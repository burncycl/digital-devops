from flask import Blueprint, request, render_template
import random


web = Blueprint('routes', __name__)


# List of s3 images to be shared by flask running in docker via EKS. 
images = [
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/01.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/02.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/03.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/04.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/05.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/06.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/07.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/08.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/09.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/10.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/11.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/12.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/13.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/14.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/15.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/16.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/17.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/18.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/19.jpg",
    "https://digital-devops-images.s3-us-west-2.amazonaws.com/20.jpg"
]


@web.route('/')
def index():
    url = random.choice(images)
    return render_template('index.html', url=url)


@web.route('/health')
def health():
    return 'OK', 200

