mkdir -p /docker-storage/python 
pip3 install -r requirements.txt -t /docker-storage/python
cd /docker-storage; zip -r python.zip python/
