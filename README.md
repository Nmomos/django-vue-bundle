# Usage

1. `cd ~/path/to/project`

2. `docker build . -t bundle`

3. `docker run --name bundle_container -it -p 8080:8080 -p 8000:8000 bundle`

4. `cd frontend && npm run serve`

5. `python manage.py runserver 0.0.0.0:8000`

6. `access to http://127.0.0.1/8000`
