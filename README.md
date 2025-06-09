HOW TO USE IN LINUX:

1: MAKE SURE THESE PACKAGES ARE INSTALLED:

sudo apt update

sudo apt install curl dos2unix p7zip-full genisoimage wget cpio qemu qemu-system-x86

2: RUN THIS AND THIS IN THE FOLDER WITH YOUR PYTHON SCRIPT, WICH HAS TO BE CALLED PYTHON.PY:

curl -O https://raw.githubusercontent.com/OllieOlzu/PYTHON2ISO/main/make_tinycore_iso.sh

curl -O https://raw.githubusercontent.com/OllieOlzu/PYTHON2ISO/main/bash.sh

3: MAKE FILES EXECUTABLE:

sudo chown $USER:$USER bash.sh make_tinycore_iso.sh python.py

sudo dos2unix bash.sh make_tinycore_iso.sh

sudo chmod +x bash.sh make_tinycore_iso.sh python.py

4: RUN THIS TO BUILD:

sudo ./make_tinycore_iso.sh

5: AFTER LOADED, YOU SHOULD SEE "✅ Done! Output ISO: custom_core.iso". THIS IS YOUR ISO FILE.

_____________________________________

HOW TO CLEAN THE FOLDER, SO ONLY python.py AND bash.sh AND make_tinycore_iso.sh ARE THERE

MAKE SURE THIS IS ABSULOTELY IN THE CORRECT FOLDER AS IT COULD DELETE THE ENTIRE LINUX SYSTEM

sudo bash -c '
shopt -s extglob
rm -rf !("make_tinycore_iso.sh"|"bash.sh"|"code.sh"|"python.py")
'
___________________________________

RUN IN QEMU WITH:

qemu-system-x86_64 -cdrom custom_core.iso -m 512

