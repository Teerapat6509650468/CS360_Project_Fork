module.exports = {
    testEnvironment: 'jsdom',  // Setting the environment to jsdom for React tests
    transform: {
      '^.+\\.(js|jsx)$': 'babel-jest',  // Use babel-jest to transform JavaScript and JSX files
    },
    moduleNameMapper: {
      '\\.(css|less|scss|sass)$': 'identity-obj-proxy',  // Mock CSS and style imports
    },
    testPathIgnorePatterns: [
      "<rootDir>/backend/", // Ignore backend tests
    ],
  };
  