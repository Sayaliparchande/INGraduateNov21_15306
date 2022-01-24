'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert(
      "Authors",
      [
        {
          bookName: "The Lord of the Rings",
          authorName: "J.R.R. Tolkien",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          bookName: "The Hobbit",
          authorName: "J.R.R. Tolkien",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          bookName: "The Catcher in the Rye",
          authorName: "J.D. Salinger",
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ],
      {}
    );
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};