import { createStore, applyMiddleware, AnyAction } from "redux";
import thunk, { ThunkMiddleware } from "redux-thunk";
import { rootReducer, RootState } from "./reducers/rootReducer";

const store = createStore(
  rootReducer,
  applyMiddleware(thunk as ThunkMiddleware<RootState, AnyAction>),
);

export type AppDispatch = typeof store.dispatch;
export type AppState = ReturnType<typeof rootReducer>;
export default store;
