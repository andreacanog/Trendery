import React from "react";
import { useAppSelector } from "../hooks";
import { Navigate } from "react-router-dom";

interface ProtectedRouteProps {
  children: JSX.Element;
}

const ProtectedRoute: React.FC<ProtectedRouteProps> = ({ children }) => {
  const session = useAppSelector((state) => state.session);

  if (!session.user) {
    return <Navigate to="/auth" />;
  }

  return children;
};

export default ProtectedRoute;
