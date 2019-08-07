# Jenkins

Personal Jenkins (jenkins.arnold.netw0rk.sh) running on bare metal tin with Docker installed.

# How to run

```
docker run -p 8080:8080 -p 50000:50000 -e GITHUB_AUTH_CLIENT_ID="" -e GITHUB_AUTH_SECRET="" -e GITHUB_TOKEN="" -e SLACK_TOKEN="" gregsharpe/jenkins:latest
``` 
