'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Books', [

      {

       bookName: 'Ankit',

       authorName: 'Arrora',

       createdAt: new Date(),

       updatedAt: new Date()       

     },

     {

      bookName: 'Amit',

      authorName: 'Jha',

      createdAt: new Date(),

      updatedAt: new Date()       

    },

    {

      bookName: 'Ankita',

      authorName: 'Shinde',

      createdAt: new Date(),

      updatedAt: new Date()       

    }

    ], {});
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
