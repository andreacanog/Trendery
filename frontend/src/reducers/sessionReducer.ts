import {
  LOGIN_FAILURE,
  LOGIN_REQUEST,
  LOGIN_SUCCESS,
  REMOVE_CURRENT_USER,
} from "../actions/sessionActions";

interface User {
  email: string;
  id: number;
  name: string;
}
interface SessionState {
  error: string | null;
  loading: boolean;
  user: User | null;
}

const initialState: SessionState = {
  error: null,
  loading: false,
  user: null,
};

const sessionReducer = (state = initialState, action: any): SessionState => {
  switch (action.type) {
    case LOGIN_FAILURE:
      return { ...state, loading: false, error: action.payload, user: null };
    case LOGIN_REQUEST:
      return { ...state, loading: true, error: null };
    case LOGIN_SUCCESS:
      return { ...state, loading: false, user: action.payload, error: null };
    case REMOVE_CURRENT_USER:
      return { ...state, user: null };
    default:
      return state;
  }
};

export default sessionReducer;
