from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db'
db = SQLAlchemy(app)

# Import models here to avoid circular imports
from models import User, Movie

@app.route('/')
def home():
    return 'Backend is running!'

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    hashed_password = generate_password_hash(data['password'], method='pbkdf2:sha256')
    new_user = User(username=data['username'], email=data['email'], password=hashed_password)
    db.session.add(new_user)
    db.session.commit()
    return jsonify({'message': 'User registered successfully!'})

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    user = User.query.filter_by(username=data['username']).first()
    if user and check_password_hash(user.password, data['password']):
        return jsonify({'message': 'Login successful!'})
    return jsonify({'message': 'Invalid credentials!'}), 401

@app.route('/movies', methods=['POST'])
def add_movie():
    data = request.get_json()
    # Placeholder for user_id - authentication would be needed here
    new_movie = Movie(title=data['title'], duration=data['duration'], genre=data['genre'], rating=data['rating'], photo=data.get('photo', 'default.jpg'), user_id=1) # Assuming user with ID 1 for now
    db.session.add(new_movie)
    db.session.commit()
    return jsonify({'message': 'Movie added successfully!'}), 201

@app.route('/movies', methods=['GET'])
def get_movies():
    movies = Movie.query.all()
    output = []
    for movie in movies:
        movie_data = {'id': movie.id, 'title': movie.title, 'duration': movie.duration, 'genre': movie.genre, 'rating': movie.rating, 'photo': movie.photo}
        output.append(movie_data)
    return jsonify({'movies': output})

@app.route('/movies/<int:movie_id>', methods=['GET'])
def get_movie(movie_id):
    movie = Movie.query.get_or_404(movie_id)
    movie_data = {'id': movie.id, 'title': movie.title, 'duration': movie.duration, 'genre': movie.genre, 'rating': movie.rating, 'photo': movie.photo}
    return jsonify(movie_data)

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
