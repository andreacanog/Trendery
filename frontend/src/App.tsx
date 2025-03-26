import React from "react";
import "./App.css";
import { Routes, Route, Navigate } from "react-router-dom";
import Login from "./components/Login/login";
import Signup from "./components/Signup/signup";
import Dashboard from "./components/Dashboard/dashboard";
import { useSelector } from "react-redux";
import { RootState } from "./reducers/rootReducer";

const App: React.FC = () => {
  const session = useSelector((state: RootState) => state.session);

  return (
    <Routes>
      {/* Public routes */}
      <Route path="/login" element={<Login />} />
      <Route path="/signup" element={<Signup />} />

      {/* Protected route: */}
      <Route
        path="/dashboard"
        element={session.user ? <Dashboard /> : <Navigate to="/login" />}
      />

      {/* Default redirect */}
      <Route path="/" element={<Navigate to="/dashboard" />} />
    </Routes>
  );
};

export default App;
