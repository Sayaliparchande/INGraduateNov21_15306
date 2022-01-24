'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
     await queryInterface.bulkInsert(
       "accounts",
       [
         {
           accno: "123456789",

           accaName: "Account 1",

           balance: "100",

           createdAt: new Date(),

           updatedAt: new Date(),
         },

         {
           accno: "987654321",

           accaName: "Account 2",

           balance: "200",

           createdAt: new Date(),

           updatedAt: new Date(),
         },

         {
           accno: "123456789",

           accaName: "Account 3",

           balance: "300",

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