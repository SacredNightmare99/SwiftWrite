#!/bin/bash

# Script to run tests for SwiftWrite Flutter project

set -e

echo "🧪 Running SwiftWrite Tests..."
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "⚠️  .env file not found. Creating from .env.example..."
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo "✅ Created .env file. Please update it with your API keys."
    else
        echo "Judge0API=test_api_key" > .env
        echo "✅ Created default .env file for testing."
    fi
fi

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Run analyzer
echo ""
echo "🔍 Running static analysis..."
flutter analyze || echo "⚠️  Some analysis issues found (non-blocking)"

# Format check
echo ""
echo "✨ Checking code formatting..."
dart format --set-exit-if-changed . || echo "⚠️  Some formatting issues found (non-blocking)"

# Run tests
echo ""
echo "🧪 Running tests..."
flutter test --coverage

# Generate coverage report
if [ -f "coverage/lcov.info" ]; then
    echo ""
    echo "📊 Generating coverage report..."
    
    # Check if lcov is installed
    if command -v lcov &> /dev/null; then
        lcov --summary coverage/lcov.info
        
        if command -v genhtml &> /dev/null; then
            genhtml coverage/lcov.info -o coverage/html
            echo "✅ Coverage report generated at coverage/html/index.html"
        fi
    else
        echo "ℹ️  Install lcov to view detailed coverage: sudo apt-get install lcov"
    fi
fi

echo ""
echo "✅ All tests completed!"
