'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Heros', [

      {

       heroName: 'Aa',

       filmName: 'aa',

       createdAt: new Date(),

       updatedAt: new Date()       

     },

     {

      heroName: 'bb',

      filmName: 'bb',

      createdAt: new Date(),

      updatedAt: new Date()       

    },

    {

      heroName: 'cc',

      filmName: 'cc',

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
