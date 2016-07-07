# Run Knime in Docker
TO BUILD: sudo docker build -t knime .
TO RUN: docker run --rm --name knime -p 5901:5901 -e USER=root -i knime /bin/bash -c "vncserver :1 -geometry 1366x768 -depth 24 && tail -F /root/.vnc/*.log"

