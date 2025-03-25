import {
  LOGIN_REQUEST,
  LOGIN_SUCCESS,
  LOGIN_FAILURE,
  REMOVE_CURRENT_USER,
} from "../actions/sessionActions";

interface User {
  id: number;
  email: string;
  name?: string;
}
interface SessionState {
  loading: boolean;
  user: User | null;
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
      return { ...state, loading: false, user: action.payload, error: null };
    case LOGIN_FAILURE:
      return { ...state, loading: false, error: action.payload, user: null };
    case REMOVE_CURRENT_USER:
      return { ...state, user: null };
    default:
      return state;
  }
};

export default sessionReducer;
