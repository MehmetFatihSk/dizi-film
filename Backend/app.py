from flask import Flask, request, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from flask_pymongo import PyMongo

app = Flask(__name__)
app.config["MONGO_URI"] = "mongodb://localhost:27017/mydatabase" # Example MongoDB connection URI
mongo = PyMongo(app)

# Import models here to avoid circular imports (Note: These models are for SQLAlchemy and need to be rewritten for MongoDB)
# from models import User, Movie

@app.route('/')
def home():
    return 'Backend is running!'

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    hashed_password = generate_password_hash(data['password'], method='pbkdf2:sha256')
    # MongoDB insertion would go here
    # new_user = User(username=data['username'], email=data['email'], password=hashed_password)
    # db.session.add(new_user)
    # db.session.commit()
    return jsonify({'message': 'User registration endpoint (MongoDB - not implemented yet)'})

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    # MongoDB query would go here
    # user = User.query.filter_by(username=data['username']).first()
    # if user and check_password_hash(user.password, data['password']):
    #     return jsonify({'message': 'Login successful!'})
    return jsonify({'message': 'Login endpoint (MongoDB - not implemented yet)'}), 401

@app.route('/movies', methods=['POST'])
def add_movie():
    data = request.get_json()
    # MongoDB insertion would go here
    # Placeholder for user_id - authentication would be needed here
    # new_movie = Movie(title=data['title'], duration=data['duration'], genre=data['genre'], rating=data['rating'], photo=data.get('photo', 'default.jpg'), user_id=1) # Assuming user with ID 1 for now
    # db.session.add(new_movie)
    # db.session.commit()
    return jsonify({'message': 'Add movie endpoint (MongoDB - not implemented yet)'}), 201

@app.route('/movies', methods=['GET'])
def get_movies():
    # MongoDB query would go here
    # movies = Movie.query.all()
    output = []
    # for movie in movies:
    #     movie_data = {'id': movie.id, 'title': movie.title, 'duration': movie.duration, 'genre': movie.genre, 'rating': movie.rating, 'photo': movie.photo}
    #     output.append(movie_data)
    return jsonify({'movies': output, 'message': 'Get movies endpoint (MongoDB - not implemented yet)'})

@app.route('/movies/<int:movie_id>', methods=['GET'])
def get_movie(movie_id):
    # MongoDB query would go here
    # movie = Movie.query.get_or_404(movie_id)
    # movie_data = {'id': movie.id, 'title': movie.title, 'duration': movie.duration, 'genre': movie.genre, 'rating': movie.rating, 'photo': movie.photo}
    return jsonify({'message': f'Get movie endpoint for ID {movie_id} (MongoDB - not implemented yet)'})

if __name__ == '__main__':
    with app.app_context():
        # SQLAlchemy database creation - not needed for MongoDB
        # db.create_all()
        pass # Placeholder for potential MongoDB initialization if needed
    app.run(debug=True)
