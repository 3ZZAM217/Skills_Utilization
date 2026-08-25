# Skills Utilization - Course Recommendation Platform

## Description
**Skills Utilization** is a web-based educational platform designed to help users track their professional skills and discover relevant courses. The application features a recommendation engine that suggests courses based on a user's self-assessed skills and areas of interest (e.g., Frontend, Backend, Cybersecurity, AI). Users can browse a comprehensive catalog of courses, enroll in them, and save their favorite selections.

## Key Features
- **User Authentication:** Secure JWT-based registration and login system with encrypted passwords.
- **Skill Tracking:** Users can add and manage their personal skills and proficiency levels.
- **Smart Course Recommendations:** An algorithm maps a user's skills to course requirements to generate a personalized list of recommended courses.
- **Course Management:** Users can search the catalog, filter by category, enroll/unenroll in specific classes, and bookmark favorites.
- **Data Seeding:** Includes a utility to automatically parse and seed skills and course data into the database from a structured JSON file.
- **Modular Architecture:** Flask application structured with Blueprints for clear separation of concerns (Auth, Courses, Frontend).

## Technologies Used
- **Backend:** Python 3, Flask REST API
- **Database:** PostgreSQL
- **ORM & Migrations:** SQLAlchemy Core, Alembic
- **Security:** PyJWT for token-based authentication, Werkzeug/Bcrypt for password hashing.
- **Frontend:** HTML, CSS, JavaScript (served via Flask templates/static folders).

## Project Structure
- `app.py`: The entry point script to run the Flask application.
- `app/__init__.py`: Application factory that initializes Flask, configurations, and registers Blueprints.
- `app/models.py`: SQLAlchemy Core table definitions (`users`, `courses`, `skills`, `user_skills`, `user_courses`, `user_favorites`, etc.).
- `app/db.py`: Engine initialization and database connection string.
- `app/routes_auth.py`: API endpoints for user registration, login, profile management, and skill selection.
- `app/routes_courses.py`: API endpoints for fetching courses, handling enrollments, managing favorites, and calculating skill-based recommendations.
- `app/routes_frontend.py`: Routes for rendering the frontend HTML templates.
- `seed_courses.py` & `courses.json`: Script and dataset for seeding initial courses and skills into the database.
- `config.py`: Environment variable configurations and secret keys.
- `alembic/`: Database migration files.

## Setup Instructions

### Prerequisites
- Python 3.8+
- PostgreSQL installed and running locally

### 1. Database Configuration
Ensure PostgreSQL is running and create the necessary database (default is `course_recommendation_db`):
```sql
CREATE DATABASE course_recommendation_db;
```
*(If your credentials differ, update the `DATABASE_URL` in `config.py` or export it as an environment variable).*

### 2. Environment Setup
Navigate to the root directory and set up a Python virtual environment:
```bash
# Clone or navigate to the project directory
cd Skills_Utilization

# Create a virtual environment
python -m venv venv

# Activate the virtual environment
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install the required Python packages
pip install -r requirements.txt
```

### 3. Run Database Migrations
Use Alembic to create the database schema based on `models.py`:
```bash
alembic upgrade head
```

### 4. Seed Initial Data
Populate the database with the initial catalog of courses and required skills:
```bash
python seed_courses.py
```

### 5. Start the Application
Run the Flask server:
```bash
python app.py
```
The application will start locally and be available at `http://127.0.0.1:5000`.

## How It Works
1. **Onboarding:** A new user registers for an account and logs in to receive a JWT authentication token.
2. **Skill Assessment:** The user adds their existing skills (e.g., Python, JavaScript, Figma) to their profile.
3. **Recommendations:** The backend evaluates the user's skill set against the `skill_requirements` of all available courses, generating a "Match Score". The user is presented with the highest matching courses.
4. **Engagement:** The user can search the full catalog, filter by domains like DevOps or Design, enroll in courses to build a schedule, and add courses to their favorites list for later viewing.