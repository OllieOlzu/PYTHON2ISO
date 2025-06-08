#!/bin/bash

set -e

ISO_URL="http://tinycorelinux.net/13.x/x86/release/Core-current.iso"
ISO_NAME="Core-current.iso"
ISO_DIR="tcl_iso"
EXTRACT_DIR="core_root"
ISO_OUT="custom_core.iso"
CORE_GZ_PATH="$ISO_DIR/boot/core.gz"

EXTENSIONS=(bash.tcz ncursesw.tcz readline.tcz python3.9.tcz libffi.tcz openssl-1.1.1.tcz)

echo "📥 Downloading Tiny Core ISO..."
wget -nc "$ISO_URL"

echo "📂 Extracting ISO..."
7z x "$ISO_NAME" -otmp_iso > /dev/null

echo "📁 Setting up working directory..."
rm -rf "$ISO_DIR"
cp -r tmp_iso "$ISO_DIR"
mkdir -p "$ISO_DIR/tce/optional"
mkdir -p "$ISO_DIR/boot/$EXTRACT_DIR/MAIN"

echo "📦 Downloading extensions..."
for ext in "${EXTENSIONS[@]}"; do
    EXT_URL="http://tinycorelinux.net/13.x/x86/tcz/$ext"
    wget -nc "$EXT_URL" -P "$ISO_DIR/boot/$EXTRACT_DIR/MAIN"
done

echo "${EXTENSIONS[@]}" > "$ISO_DIR/tce/onboot.lst"

echo "🧩 Unpacking core.gz to add custom folder..."
(
  cd "$ISO_DIR/boot"
  mkdir -p "$EXTRACT_DIR"
  cd "$EXTRACT_DIR"
  zcat ../core.gz | cpio -idmu
)

echo "📁 adding bash.sh..."

# Copy bash.sh into /MAIN
cp bash.sh "$ISO_DIR/boot/$EXTRACT_DIR/MAIN/bash.sh"
chmod +x "$ISO_DIR/boot/$EXTRACT_DIR/MAIN/bash.sh"
cp python.py "$ISO_DIR/boot/$EXTRACT_DIR/python.py"

# 🧵 Add boot-time bash.sh to automatically move code.sh into /MAIN
cat << 'EOF' > "$ISO_DIR/boot/$EXTRACT_DIR/opt/bootlocal.sh"
#!/bin/sh
# Run bash.sh at boot
/MAIN/bash.sh
EOF
chmod +x "$ISO_DIR/boot/$EXTRACT_DIR/opt/bootlocal.sh"

echo "📦 Repacking core.gz..."
(
  cd "$ISO_DIR/boot/$EXTRACT_DIR"
  find . | cpio -o -H newc | gzip -c > ../core.gz
)

# Clean up unpacked files
rm -rf "$ISO_DIR/boot/$EXTRACT_DIR"

echo "📀 Rebuilding ISO..."
genisoimage -l -J -R -V "TinyCore Custom" -no-emul-boot -boot-load-size 4 \
  -boot-info-table -b boot/isolinux/isolinux.bin \
  -c boot/isolinux/boot.cat -o "$ISO_OUT" "$ISO_DIR"

echo "✅ Done! Output ISO: $ISO_OUT"