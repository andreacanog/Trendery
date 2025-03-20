// src/components/Auth/index.tsx
import React, { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { RootState } from "../../reducers/rootReducer";
import { restoreSession, logoutUser } from "../../actions/sessionActions";
import Login from "../Login/login";
import Signup from "../Signup/signup";

const Auth: React.FC = () => {
    const dispatch = useAppDispatch();
    const session = useAppSelector((state) => state.session);

    // Attempt to restore the user session on mount
    useEffect(() => {
        dispatch(restoreSession());
    }, [dispatch]);

    if (session.loading) {
        return <div>Loading...</div>;
    }

    if (session.user) {
        return (
        <div>
            <h2>Welcome, {session.user.username}!</h2>
            <button onClick={() => dispatch(logoutUser())}>Logout</button>
        </div>
        );
    }

    return (
        <div>
            <h2>Please log in or sign up</h2>
            <Login />
            <Signup />
        </div>
    );
};

export default Auth;
