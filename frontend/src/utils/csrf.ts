type FetchOptions = RequestInit & {
  headers?: Record<string, string>;
};

async function csrfFetch(
  url: string,
  options: FetchOptions = {},
): Promise<Response> {
  options.method = options.method || "GET";
  options.headers = options.headers || {};

  if (options.method.toUpperCase() !== "GET") {
    options.headers["Content-Type"] =
      options.headers["Content-Type"] || "application/json";
    const csrfToken = sessionStorage.getItem("X-CSRF-Token");
    if (csrfToken) {
      options.headers["X-CSRF-Token"] = csrfToken;
    }
  }

  const res = await fetch(url, options);
  if (!res.ok) throw res;

  return res;
}

export function storeCSRFToken(response: Response): void {
  const csrfToken = response.headers.get("X-CSRF-Token");
  if (csrfToken) sessionStorage.setItem("X-CSRF-Token", csrfToken);
}

export function storeCurrentUser(user: any): void {
  if (user) {
    sessionStorage.setItem("currentUser", JSON.stringify(user));
  } else {
    sessionStorage.removeItem("currentUser");
  }
}

export async function restoreCSRF(): Promise<Response> {
  const response = await csrfFetch("/api/session");
  storeCSRFToken(response);
  return response;
}

export default csrfFetch;
