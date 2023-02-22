const domain = "http://192.168.0.105:6000";
// const domain = "https://transport-app-api.onrender.com";

const endPoints = {
  //Rides
  'createRide': '/api/ride/createRide',
  'updateRide': '/api/ride/updateRide',
  'deleteRide': '/api/ride/deleteRide',
  'toggleActiveStatus': '/api/ride/toggleActiveStatus',
  'fetchRides': '/api/ride/fetchRides',

  // Customer
  'createCustomer': '/api/customer/createCustomer',
  'fetchCustomers': '/api/customer/fetchCustomers',

  //Invocie
  'createInvoice': '/api/customer/createInvoice'
};
