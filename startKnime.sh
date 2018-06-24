docker run --rm --name knime -p 5901:5901 -e USER=root -v $(pwd)/data:/root/knime-workspace -i knime /bin/bash -c "vncserver :1 -geometry 1366x768 -depth 24 && tail -F /root/.vnc/*.log";
sudo docker kill knime;
