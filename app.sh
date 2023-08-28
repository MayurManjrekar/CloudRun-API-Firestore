git clone https://github.com/GoogleCloudPlatform/nodejs-getting-started.git
cd nodejs-getting-started/bookshelf
docker build -t gcr.io/${{env.PROJECT_ID}}/app .
docker push gcr.io/${{env.PROJECT_ID}}/app  
