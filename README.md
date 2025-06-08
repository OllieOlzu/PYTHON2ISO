HOW TO USE IN LINUX:

1: RUN THIS AND THIS IN THE FOLDER WITH YOUR PYTHON SCRIPT, WICH HAS TO BE CALLED PYTHON.PY:

curl -O https://raw.githubusercontent.com/OllieOlzu/PYTHON2ISO/make_tinycore_iso.sh

curl -O https://raw.githubusercontent.com/OllieOlzu/PYTHON2ISO/bash.sh

2: MAKE FILES EXECUTABLE:

sudo chown $USER:$USER bash.sh make_tinycore_iso.sh python.py
sudo dos2unix bash.sh make_tinycore_iso.sh
sudo chmod +x bash.sh make_tinycore_iso.sh python.py

2: RUN THIS:

sudo ./make_tinycore_iso.sh

3: AFTER LOADED, YOU SHOULD SEE "✅ Done! Output ISO: custom_core.iso". THIS IS YOUR ISO FILE.
