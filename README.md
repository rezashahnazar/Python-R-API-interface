# R-plumber-Python-flask

A simple API connection between R & Python using plumber & flask libraries.

1. Install required python packages mentioned in requirements.txt
2. run the plumber-R API in GFR.R
3. from R-studio console, copy the **url and port** which your api is listening on.
4. run flask with the following commands:
   - export FLASK_APP=API
   - run flask
