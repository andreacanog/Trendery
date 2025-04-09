import React, { useEffect } from "react";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { restoreSession, logoutUser } from "../../actions/sessionActions";
import Login from "../Login/Login";
import Signup from "../Signup/Signup";

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
        <h2>Welcome, {session.user.name}!</h2>
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
