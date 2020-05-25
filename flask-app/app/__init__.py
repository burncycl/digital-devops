import sys
import logging

from flask import Flask, request, url_for

# from .api.v1 import api_blueprint as api_v1
from .routes import web


logger = logging.getLogger()
handler = logging.StreamHandler(stream=sys.stdout)
handler.formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(name)s - %(funcName)s: %(message)s')
logger.addHandler(handler)
logger.setLevel(logging.DEBUG)
logger.propagate = True


def create_app():
    flask_app = Flask(__name__)
    logger.info('Tester')
    # flask_app.register_blueprint(api_v1)
    flask_app.register_blueprint(web)

    @flask_app.before_request
    def _():
        logger.info('Before Request')

    @flask_app.after_request
    def _(response):
        logger.info('Processed Request')
        return response
    return flask_app
