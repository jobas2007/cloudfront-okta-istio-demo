export const auth0Config = {
  domain: "dev-k7aqsoufpe7gmz08.us.auth0.com",
  clientId: "GfHMOhBdZEVcofv6D24o5PjD1nHCEvJX",
  authorizationParams: {
    redirect_uri: window.location.origin + "/callback",
    audience: "https://api.springboot-demo.com",
    scope: "openid profile email"
  }
};
