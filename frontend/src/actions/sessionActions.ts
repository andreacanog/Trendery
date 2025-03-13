import { Dispatch } from 'redux';
import csrfFetch, { storeCSRFToken, storeCurrentUser } from '../utils/csrf';

export const LOGIN_REQUEST = 'LOGIN_REQUEST';
export const LOGIN_SUCCESS = 'LOGIN_SUCCESS';
export const LOGIN_FAILURE = 'LOGIN_FAILURE';
export const REMOVE_CURRENT_USER = 'REMOVE_CURRENT_USER';

export const loginUser = (email: string, password: string) => async (dispatch: Dispatch): Promise<void> => {
    dispatch({ type: LOGIN_REQUEST });
    try {
        const response = await csrfFetch('/api/session', {
            method: 'POST',
            body: JSON.stringify({ email, password }),
        });
        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || 'Login failed');
        }
        const data = await response.json();
        storeCurrentUser(data.user);
        dispatch({ type: LOGIN_SUCCESS, payload: data.user });
    } catch (error: any) {
        dispatch({ type: LOGIN_FAILURE, payload: error.message });
    }
};

export const signupUser = (user: { username: string; email: string; password: string; name: string }) =>
    async (dispatch: Dispatch): Promise<void> => {
        dispatch({ type: LOGIN_REQUEST });
        try {
            const response = await csrfFetch('/api/users', {
                method: 'POST',
                body: JSON.stringify(user),
            });
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.error || 'Signup failed');
            }
            const data = await response.json();
            storeCurrentUser(data.user);
            dispatch({ type: LOGIN_SUCCESS, payload: data.user });
        } catch (error: any) {
            dispatch({ type: LOGIN_FAILURE, payload: error.message });
        }
};


export const logoutUser = () => async (dispatch: Dispatch): Promise<void> => {
    try {
        const response = await csrfFetch('/api/session', {
            method: 'DELETE',
        });
        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || 'Logout failed');
        }
        storeCurrentUser(null);
        dispatch({ type: REMOVE_CURRENT_USER });
    } catch (error: any) {
        console.error("Logout error:", error);
    }
};


export const restoreSession = () => async (dispatch: Dispatch): Promise<void> => {
    try {
        const response = await csrfFetch('/api/session');
        storeCSRFToken(response);
        const data = await response.json();
        storeCurrentUser(data.user);
        dispatch({ type: LOGIN_SUCCESS, payload: data.user });
    } catch (error: any) {
        dispatch({ type: LOGIN_FAILURE, payload: error.message });
    }
};
