#!/bin/bash
# build-deb.sh — Gera tarsila-email_<versao>_all.deb
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PKG_NAME="tarsila-email"
# A versao vem do DEBIAN/control, que e a fonte unica. Escrita a mao aqui
# tambem, ela vira duas verdades que envelhecem separado: no
# tarsila-app-management as duas ja tinham divergido, e o pacote saia com um
# numero no nome e outro por dentro.
VERSION="${1:-$(sed -n 's/^Version: *//p' "$SCRIPT_DIR/DEBIAN/control" | head -1)}"
[ -n "$VERSION" ] || { echo "ERRO: sem Version: em DEBIAN/control" >&2; exit 1; }
DEB="${PKG_NAME}_${VERSION}_all.deb"
BUILD_DIR="$(mktemp -d)"

cleanup() { rm -rf "$BUILD_DIR"; }
trap cleanup EXIT

echo "==> Construindo $DEB..."

cp -a "$SCRIPT_DIR/DEBIAN" "$BUILD_DIR/"
mkdir -p "$BUILD_DIR/opt/tarsila-email/bin" \
         "$BUILD_DIR/opt/tarsila-email/lib" \
         "$BUILD_DIR/usr/local/bin" \
         "$BUILD_DIR/usr/share/applications"

install -m 755 "$SCRIPT_DIR/src/opt/tarsila-email/bin/"*.py  "$BUILD_DIR/opt/tarsila-email/bin/"
install -m 644 "$SCRIPT_DIR/src/opt/tarsila-email/lib/"*.py  "$BUILD_DIR/opt/tarsila-email/lib/"
install -m 755 "$SCRIPT_DIR/src/usr/local/bin/tarsila-email" "$BUILD_DIR/usr/local/bin/"
install -m 644 "$SCRIPT_DIR/src/usr/share/applications/tarsila-email.desktop" \
    "$BUILD_DIR/usr/share/applications/tarsila-email.desktop"

# O aviso de licenca vai DENTRO do pacote, em /usr/share/doc/<pkg>/copyright,
# que e onde a convencao Debian manda procurar. Este build monta o pacote
# listando arquivo por arquivo, entao nada entra sozinho.
install -D -m 644 "$SCRIPT_DIR/src/usr/share/doc/tarsila-email/copyright" \
    "$BUILD_DIR/usr/share/doc/tarsila-email/copyright"

chmod 755 "$BUILD_DIR/DEBIAN/postinst"

dpkg-deb --build --root-owner-group "$BUILD_DIR" "$DEB"
echo "==> $DEB gerado."