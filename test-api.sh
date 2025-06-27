#!/bin/bash

# API Testing Script
echo "🧪 Testing GitHub Actions Learning API"
echo "===================================="
echo ""

# Check if server is running
check_server() {
    curl -s http://localhost:3000/health > /dev/null 2>&1
    return $?
}

# Start server if not running
if ! check_server; then
    echo "📦 Starting server..."
    npm start &
    SERVER_PID=$!
    echo "Server PID: $SERVER_PID"
    
    # Wait for server to start
    echo -n "Waiting for server to start"
    for i in {1..30}; do
        if check_server; then
            echo " ✅"
            break
        fi
        echo -n "."
        sleep 1
    done
    
    if ! check_server; then
        echo " ❌"
        echo "Failed to start server!"
        exit 1
    fi
else
    echo "✅ Server is already running"
fi

echo ""
echo "🔍 Running API Tests:"
echo ""

# Test 1: Health Check
echo "1. Health Check:"
curl -s http://localhost:3000/health | json_pp
echo ""

# Test 2: Welcome Message
echo "2. Welcome Message:"
curl -s http://localhost:3000/ | json_pp
echo ""

# Test 3: Create Item
echo "3. Creating an item:"
ITEM_RESPONSE=$(curl -s -X POST http://localhost:3000/items \
  -H "Content-Type: application/json" \
  -d '{"name":"Test Item","description":"Created by test script"}')
echo "$ITEM_RESPONSE" | json_pp
ITEM_ID=$(echo "$ITEM_RESPONSE" | grep -o '"id":[0-9]*' | cut -d: -f2)
echo ""

# Test 4: Get All Items
echo "4. Getting all items:"
curl -s http://localhost:3000/items | json_pp
echo ""

# Test 5: Get Specific Item
if [ ! -z "$ITEM_ID" ]; then
    echo "5. Getting item with ID $ITEM_ID:"
    curl -s http://localhost:3000/items/$ITEM_ID | json_pp
    echo ""
    
    # Test 6: Delete Item
    echo "6. Deleting item with ID $ITEM_ID:"
    curl -s -X DELETE http://localhost:3000/items/$ITEM_ID
    echo "✅ Item deleted"
    echo ""
fi

# Test 7: Error Handling
echo "7. Testing error handling (404):"
curl -s http://localhost:3000/nonexistent | json_pp
echo ""

echo "✅ All API tests completed!"
echo ""

# Cleanup
if [ ! -z "$SERVER_PID" ]; then
    echo "🛑 Stopping server (PID: $SERVER_PID)..."
    kill $SERVER_PID 2>/dev/null
    echo "✅ Server stopped"
fi

echo ""
echo "💡 To run the server manually:"
echo "   npm start        # Production mode"
echo "   npm run dev      # Development mode with auto-reload"