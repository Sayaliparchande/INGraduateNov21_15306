'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Books', [

      {

       carName: 'BMW1',

       brandName: 'BMW',

       createdAt: new Date(),

       updatedAt: new Date()       

     },

     {

      carName: 'suzuki1',

      brandName: 'suzuki',

      createdAt: new Date(),

      updatedAt: new Date()       

    },

    {

      carName: 'farari1',

      brandName: 'farari',

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
