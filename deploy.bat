@echo off
setlocal enabledelayedexpansion

echo ===============================
echo   Quarks Studio - Deploy Web
echo ===============================

rem ── Leer versión desde pubspec.yaml ─────────────────────────────────────────
for /f "tokens=2" %%v in ('findstr /b "version:" pubspec.yaml') do set RAW_VERSION=%%v

for /f "tokens=1,2 delims=+" %%a in ("!RAW_VERSION!") do (
    set SEMVER=%%a
    set BUILD=%%b
)

echo.
echo Version: !RAW_VERSION!
echo.

rem ── Flutter build web release ────────────────────────────────────────────────
echo [1/3] Building Flutter Web release...
call flutter build web --release
echo.

rem ── Generar version.json ─────────────────────────────────────────────────────
echo [2/3] Escribiendo version.json...
powershell -Command "$json = '{\"version\":\"%SEMVER%\",\"build_number\":\"%BUILD%\"}'; Set-Content -Path 'build\web\version.json' -Value $json -Encoding UTF8"
echo       OK: version=!SEMVER!, build_number=!BUILD!
echo.

rem ── Firebase deploy (solo hosting) ──────────────────────────────────────────
echo [3/3] Deploying a Firebase Hosting...
call firebase deploy --only hosting

echo.
echo [OK] Deploy completado ^- v!RAW_VERSION!

endlocal