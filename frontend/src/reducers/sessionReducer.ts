import { LOGIN_REQUEST, LOGIN_SUCCESS, LOGIN_FAILURE, REMOVE_CURRENT_USER } from '../actions/sessionActions';
interface SessionState {
    loading: boolean;
    user: any; 
    error: string | null;
}

const initialState: SessionState = {
    loading: false,
    user: null,
    error: null,
};

const sessionReducer = (state = initialState, action: any): SessionState => {
    switch (action.type) {
        case LOGIN_REQUEST:
            return { ...state, loading: true, error: null };
        case LOGIN_SUCCESS:
            return { ...state, loading: false, user: action.payload };
        case LOGIN_FAILURE:
            return { ...state, loading: false, error: action.payload };
        case REMOVE_CURRENT_USER:
            return { ...state, user: null };
        default:
            return state;
    }
};

export default sessionReducer;
