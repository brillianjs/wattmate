# Test Credentials for WattMate API

## Login Testing

For testing the login functionality, you can use these sample credentials:

### Sample User 1

- **Email**: `test@wattmate.com`
- **Password**: `password123`

### Sample User 2

- **Email**: `admin@wattmate.com`
- **Password**: `admin123`

### Sample User 3

- **Email**: `user@example.com`
- **Password**: `user123`

## API Endpoint

The app is configured to connect to: `http://localhost:3000/api/auth/login`

## Expected API Response Format

The app expects the backend API to return responses in this format:

### Successful Login Response

```json
{
  "success": true,
  "message": "Login berhasil",
  "data": {
    "user": {
      "id": 1,
      "name": "Test User",
      "email": "test@wattmate.com",
      "phone": "+6281234567890",
      "address": "Jakarta, Indonesia",
      "is_verified": 1,
      "verification_token": null,
      "reset_password_token": null,
      "reset_password_expires": null,
      "created_at": "2024-01-01T00:00:00.000Z",
      "updated_at": "2024-01-01T00:00:00.000Z"
    },
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### Error Response

```json
{
  "success": false,
  "message": "Email atau password salah"
}
```

## Setup Instructions

1. Make sure your backend server is running on `localhost:3000`
2. The login endpoint should be available at `/api/auth/login`
3. Set up the above test users in your database
4. Test the login functionality using the provided credentials

## Notes

- The app will show connection errors if the backend server is not running
- Authentication tokens are stored securely using SharedPreferences
- Users are automatically redirected to dashboard after successful login
- Logout functionality clears all stored credentials
