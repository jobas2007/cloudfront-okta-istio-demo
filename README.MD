# Terraform
    
    # create environment
    terraform apply

    # test Spring Boot + Istio + Okta

    # cleanup
    terraform destroy

---

#Front End:

Step 1: IdeaProjects/cloudfront-okta-istio-demo/demo-ui$ npm run dev
Step 2: Local:   http://localhost:5173/

----
#Backend:

```
/IdeaProjects/cloudfront-okta-istio-demo/springboot-api$ docker build -t springboot-api:1.0 .
```


#minikube

minikube start --driver=docker


#kiali
istioctl dashboard kiali

#okta

Domain: dev-k7aqsoufpe7gmz08.us.auth0.com
Client Id: GfHMOhBdZEVcofv6D24o5PjD1nHCEvJX
Client Secret: EDaGa_QcSdo_SIhxjzW1buY2RlltCEeerL2J9TufypmVv_U7v6uV6wUl7j0Avjlq
Identifier: https://api.springboot-demo.com

----------------
Testing Instructions:

1. Start the Port Forward (Terminal 1)

./scripts/start-api-access.sh

2. Start React App (Terminal 2)

cd demo-ui
npm run dev

3. Open Browser

http://localhost:5173

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Test Scenarios:

Test 1: Unauthenticated Access (Should Fail)

# Try calling API without token
curl http://localhost:8080/api/hello

Expected: RBAC: access denied (403 or 401)

Test 2: Health Check (Should Work)

# Health endpoint is public
curl http://localhost:8080/api/health

Expected: {"status":"UP"}

Test 3: Login and Call API (Should Work)

1. Click "🔐 Login with Auth0" button
2. Enter your Auth0 credentials
3. You'll be redirected back
4. Should see: "✅ Authenticated" with your email
5. Click "📡 Call Backend (with JWT)"
6. Should see backend response!


---
user: asjobseek2014@gmail.com/Fifa12