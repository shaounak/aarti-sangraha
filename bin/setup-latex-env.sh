#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if command -v apt-get >/dev/null 2>&1; then
  SUDO=""
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  fi

  echo "Installing LaTeX build dependencies..."
  $SUDO apt-get update
  $SUDO DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    latexmk \
    texlive-xetex \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    fonts-noto-core \
    fonts-lohit-deva

  echo "Note: For Marathi/Devanagari text, prefer Noto Serif Devanagari or another full-coverage Devanagari font to avoid square boxes from missing glyphs."
else
  echo "This setup script currently supports Debian/Ubuntu-based systems only."
  exit 1
fi

echo "Building PDF..."
latexmk -pdf -interaction=nonstopmode -xelatex example.tex

echo "Done. PDF is available at: $ROOT_DIR/example.pdf"
