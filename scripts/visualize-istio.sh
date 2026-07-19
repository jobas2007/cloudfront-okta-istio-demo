#!/bin/bash

echo "=========================================="
echo "   ISTIO SETUP VISUALIZATION"
echo "=========================================="
echo ""

echo "1️⃣  ISTIO CONTROL PLANE (istio-system namespace)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
kubectl get pods -n istio-system
echo ""

echo "2️⃣  YOUR APPLICATION (default namespace)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
kubectl get pods -l app=springboot-api
echo ""

echo "3️⃣  ISTIO GATEWAY (Entry Point)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
kubectl get gateway
echo ""

echo "4️⃣  ISTIO VIRTUALSERVICE (Routing Rules)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
kubectl get virtualservice
echo ""

echo "5️⃣  KUBERNETES SERVICE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
kubectl get svc springboot-api
echo ""

echo "=========================================="
echo "   TRAFFIC FLOW DIAGRAM"
echo "=========================================="
echo ""
echo "External Request"
echo "       ↓"
echo "minikube tunnel"
echo "       ↓"
echo "Istio Ingress Gateway"
echo "  (port 80)"
echo "       ↓"
echo "Gateway: springboot-gateway"
echo "       ↓"
echo "VirtualService: springboot-api"
echo "  ├─ Matches: /api/*"
echo "  ├─ CORS: enabled"
echo "  └─ Routes to ↓"
echo "       ↓"
echo "Service: springboot-api:8080"
echo "       ↓"
echo "Pod with 2 containers:"
echo "  ├─ springboot-api (your app)"
echo "  └─ istio-proxy (sidecar)"
echo ""

echo "=========================================="
echo "   VERIFY SIDECAR INJECTION"
echo "=========================================="
POD=$(kubectl get pod -l app=springboot-api -o jsonpath='{.items[0].metadata.name}' 2>/dev/null)
if [ -n "$POD" ]; then
    echo "Pod: $POD"
    kubectl get pod $POD -o jsonpath='{range .spec.containers[*]}{.name}{"\n"}{end}' | sed 's/^/  - /'
    echo ""
else
    echo "No pod found yet"
fi
echo ""

echo "=========================================="
echo "   GET ACCESS URL"
echo "=========================================="
echo "Run: minikube service istio-ingressgateway -n istio-system --url"
echo "Then test: curl <URL>/api/health"
