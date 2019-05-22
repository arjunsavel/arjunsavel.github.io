from flask import render_template, url_for, redirect, request
from app import app, pages

@app.route('/')
def home():
    posts = [page for page in pages if 'date' in page.meta]
    # Sort pages by date
    sorted_posts = sorted(posts, reverse=True,
        key=lambda page: page.meta['date'])
    return render_template('index.html', pages=sorted_posts)

@app.route('/bacon', methods=['GET', 'POST'])
def page(path='bacon'):
    # `path` is the filename of a page, without the file extension
    # e.g. "first-post"
    if request.method == 'POST':
        # do stuff when the form is submitted

        # redirect to end the POST handling
        # the redirect can be to the same route or somewhere else
        return redirect(url_for('index'))
    page = pages.get_or_404(path)
    return render_template('page.html', page=page)