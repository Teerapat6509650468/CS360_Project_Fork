module.exports = {
    testEnvironment: 'node',  // Use Node environment since it's a backend API
    transform: {
      '^.+\\.(js)$': 'babel-jest',  // Transform JavaScript using Babel
    },
    testMatch: ['**/tests/**/*.test.js'],  // Specify test file location
    setupFilesAfterEnv: ['<rootDir>/tests/setupStrapi.js'], // Path to your setup file
};
  