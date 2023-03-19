// const domain = "http://192.168.0.105:6001";
// const domain = "https://transport-app-api.onrender.com";

const domain = "http://3.108.221.195:6001";

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
  'searchCustomer': '/api/customer/searchCustomer',

  //Invocie
  'createInvoice': '/api/invoice/createInvoice',
  'fetchInvoices': '/api/invoice/fetchInvoices',
};
