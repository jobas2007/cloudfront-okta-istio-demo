#!/bin/bash

echo "🚀 Starting API access..."
echo ""
echo "This will forward Istio Gateway to: http://localhost:8080"
echo "Your API will be available at:"
echo "  - http://localhost:8080/api/health"
echo "  - http://localhost:8080/api/hello"
echo "  - http://localhost:8080/api/products"
echo ""
echo "Press Ctrl+C to stop"
echo ""

# Forward Istio Ingress Gateway to localhost:8080
kubectl port-forward -n istio-system svc/istio-ingressgateway 8080:80
