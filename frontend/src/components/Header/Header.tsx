// src/components/Header.tsx
import React from "react";
import { Link } from "react-router-dom";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { logoutUser } from "../../actions/sessionActions";
import "./Header.css";

const Header: React.FC = () => {
  const dispatch = useAppDispatch();
  const session = useAppSelector((state) => state.session);

  return (
    <header className="header">
      <div className="logo">
        <Link to="/">Trendery</Link>
      </div>

      <nav className="nav">
        <ul>
          <li>
            <Link to="/">Home</Link>
          </li>
          <li>
            <Link to="/products">Products</Link>
          </li>
          <li>
            <Link to="/cart">Cart</Link>
          </li>
        </ul>
      </nav>

      <div className="auth-controls">
        {session.user ? (
          <>
            <span>Welcome, {session.user.name}</span>
            <button onClick={() => dispatch(logoutUser())}>Logout</button>
          </>
        ) : (
          <Link to="/auth">Login / Signup</Link>
        )}
      </div>
    </header>
  );
};

export default Header;
