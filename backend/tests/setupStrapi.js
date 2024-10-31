const Strapi = require('@strapi/strapi');

let instance;

/**
 * Initialize Strapi before running any tests.
 */
beforeAll(async () => {
  instance = await Strapi().load();
  await instance.server.mount();
  global.strapi = instance;  // Make Strapi available globally for tests
});

/**
 * Close Strapi instance after all tests.
 */
afterAll(async () => {
  await instance.destroy();
});
