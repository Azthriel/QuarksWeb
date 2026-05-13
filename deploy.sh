#!/bin/bash
set -e

echo "==============================="
echo "  Quarks Studio - Deploy Web"
echo "==============================="

# ── Leer versión desde pubspec.yaml ──────────────────────────────────────────
RAW_VERSION=$(grep '^version:' pubspec.yaml | awk '{print $2}' | tr -d '[:space:]')
SEMVER=$(echo "$RAW_VERSION" | cut -d'+' -f1)
BUILD=$(echo "$RAW_VERSION" | cut -d'+' -f2)

echo ""
echo "Versión: $RAW_VERSION"
echo ""

# ── Flutter build web release ─────────────────────────────────────────────────
echo "[1/3] Building Flutter Web release..."
flutter build web --release

# ── Generar version.json ──────────────────────────────────────────────────────
echo "[2/3] Escribiendo version.json..."
printf '{"version":"%s","build_number":"%s"}' "$SEMVER" "$BUILD" > build/web/version.json
echo "      version.json → version=$SEMVER, build_number=$BUILD"

# ── Firebase deploy (solo hosting) ───────────────────────────────────────────
echo "[3/3] Deploying a Firebase Hosting..."
firebase deploy --only hosting

echo ""
echo "✓ Deploy completado — v$RAW_VERSION"