import 'package:intl/intl.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';

import '../models/invoice.dart';

String htmlContent = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      .row {
        display: flex;
        justify-content: space-between;
      }

      .row-center {
        display: flex;
        justify-content: center;
      }

      .text-center {
        text-align: center;
      }

      .heading {
        font-size: x-large;
        color: red;
        margin: 0.2rem 0rem;
        font-weight: bold;
      }

      .text-end {
        text-align: end;
      }

      .bold {
        font-weight: 600;
      }

      .underline {
        text-decoration: underline;
      }

      .mobile-number-position {
        position: absolute;
        right: 0px;
      }

      .address-section {
        text-align: center;
        width: 100%;
      }

      .date-invoice-no {
        font-size: medium;
      }

      .company-name {
        width: 70%;
        word-wrap: break-word;
      }

      .pan-no {
        border: 2px solid red;
        color: red;
        display: flex;
        align-items: center;
        padding: 0.4rem 1rem;
        border-radius: 4px;
      }
      @media print {
        body {
          -webkit-print-color-adjust: exact;
        }
      }

      .div-underline {
        border-bottom: 1px solid black;
        width: 100%;
      }

      table {
        border-top: 1px solid black;
        border-bottom: 1px solid black;
        border-left: 1px solid black;
        border-right: 1px solid black;

        margin: 0;
        padding-top: 0;
        padding-bottom: 0;
        border-collapse: collapse;
      }
      table-content {
        padding: 0px;
      }
      table td {
        padding: 0.4rem 1rem;
        border-collapse: collapse;
      }

      td {
        border: 1px solid black;
        border-top: none;
        border-bottom: none;
      }
      tr:nth-child(1) {
        padding-top: 0;
        border-bottom: 1px solid black;
      }
      tr:nth-child(13) {
        padding-top: 0;
        border-bottom: 1px solid black;
      }

      /* total */
      #total {
        border: 0 !important;
        text-align: right;
        padding-right: 10px;
      }

      .total-amount {
        font-weight: 600;
        font-size: large;
      }

      .footer {
        position: absolute;
        bottom: 0;
        width: 100%;
      }
    </style>
  </head>

  <body>
    <div>
      <div class="row">
        <div></div>
        <div>
          <div class="text-center">|| OM SAI ||</div>
          <div class="text-center underline">Subject to Thane Jurisdiction</div>
          <div class="text-center heading">VISHAL ROADLINES</div>
          <div class="text-center">Fleet Owners & Transport Contractor</div>
          <div class="text-center">Stainless Steel Tanker For Petroleum</div>
          <div class="text-center">All Kinds of Oil & Chemical Solvents</div>
        </div>
        <div class="text-end"></div>
        <div class="mobile-number-position text-end">
          <div>Tel.:022-25802718</div>
          <div>Mobile No. :022-25802718</div>
          <div>Mobile No. :022-25802718</div>
        </div>
      </div>
      <hr color="black" />
      <div class="address-section">
        Address : Ajaykumar Yadav, Kajuwadi, Opp. Shivsena Shakha, Wagle
        Estate,Thane (W) - 400604.
      </div>
      <div class="address-section">Email : vishalroadlines1976@gmail.com</div>
      <hr color="black" />

      <div class="row .date-invoice-no">
        <div>No. 123</div>
        <div>Date: <span class="underline"> 10 Mar 2021</span></div>
      </div>
      <br />

      <br />

      <div class="row">
        <div class="company-name">
          <div
            style="
              width: 100%;
              background-color: black;
              height: 1px;
              margin-bottom: 1rem;
            "
          ></div>
          <div
            style="
              width: 100%;
              background-color: black;
              height: 1px;
              margin-bottom: 1rem;
            "
          ></div>
          <div
            style="
              width: 100%;
              background-color: black;
              height: 1px;
              margin-bottom: 1rem;
            "
          ></div>
          <span class="bold" style="position: absolute; width: 65%; top: 239px">
            is simply dummy text of the printing and typesetting industry. Lorem
            Ipsum has been the industry's standard dummy text ever since the
          </span>
        </div>
        <div class="pan-no">PAN No. ACGPY 8550P</div>
      </div>
    </div>
    <div class="text-center">
      Baring cost of Transporting your products in our Tanker as under
    </div>

    <div style="display: grid; grid-template-columns: 0.5fr 2fr 0.5fr 2fr">
      <div>From :</div>
      <div class="div-underline text-center bold">Thane</div>
      <div>To :</div>
      <div class="div-underline text-center bold">Bhiwandi</div>
    </div>

    <br />
    <table rules="all" style="width: 100%">
      <tr>
        <td>Tanker No.</td>
        <td>LR No.</td>
        <td>Date</td>
        <td>Quantity</td>
        <td>Rate</td>
        <td>PARTICULARS</td>
        <td>Amount(Rs.)</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <td>MH04KU9093</td>
        <td>12210</td>
        <td>19/04/22</td>
        <td>28540kg.</td>
        <td>1.70</td>
        <td>Methenol</td>
        <td>48518.00</td>
      </tr>
      <tr>
        <th id="total" colspan="6">Sub Total</th>
        <td class="total-amount">200</td>
      </tr>
      <tr>
        <th id="total" colspan="6">Advance</th>
        <td class="total-amount">200</td>
      </tr>
      <tr>
        <th id="total" colspan="6">Total</th>
        <td class="total-amount">200</td>
      </tr>
    </table>

    <div class="footer">
      <hr color="black" width="100%" size="1px" />

      <div class="row" style="justify-content: end">
        <div>Payment Details</div>
      </div>
    </div>
  </body>
</html>


 """;

getBill(Invoice invoice) {
  return """"
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>

    <title>Document</title>
    <style>
    body {
    font-family: 'Roboto';font-size: 18px;
}
      .row {
        display: flex;
        justify-content: space-between;
      }

      .row-center {
        display: flex;
        justify-content: center;
      }

      .text-center {
        text-align: center;
      }

      .heading {
        font-size: x-large;
        color: red;
        margin: 0.2rem 0rem;
        font-weight: bold;
      }

      .text-end {
        text-align: end;
      }

      .bold {
        font-weight: 600;
      }

      .underline {
        text-decoration: underline;
      }

      .mobile-number-position {
        position: absolute;
        right: 0px;
      }

      .address-section {
        text-align: center;
        width: 100%;
      }

      .date-invoice-no {
        font-size: medium;
      }

      .company-name {
        width: 70%;
        word-wrap: break-word;
      }

      .pan-no {
        border: 2px solid red;
        color: red;
        display: flex;
        align-items: center;
        padding: 0.4rem 1rem;
        border-radius: 4px;
      }
      @media print {
        body {
          -webkit-print-color-adjust: exact;
        }
      }

      .div-underline {
        border-bottom: 1px solid black;
        width: 100%;
      }

      table {
        border-top: 1px solid black;
        border-bottom: 1px solid black;
        border-left: 1px solid black;
        border-right: 1px solid black;

        margin: 0;
        padding-top: 0;
        padding-bottom: 0;
        border-collapse: collapse;
      }
      table-content {
        padding: 0px;
      }
      table td {
        padding: 0.2rem .5rem;
        border-collapse: collapse;
      }

      td {
        border: 1px solid black;
        border-top: none;
        border-bottom: none;
      }
      tr:nth-child(1) {
        padding-top: 0;
        border-bottom: 1px solid black;
      }
      tr:nth-child(14) {
        padding-top: 0;
        border-bottom: 1px solid black;
      }

      /* total */
      #total {
        border: 0 !important;
        text-align: right;
        padding-right: 10px;
      }

      .total-amount {
        font-weight: 600;
        font-size: large;
      }

      .footer {
        position: absolute;
        bottom: 0;
        width: 100%;
      }

      body { margin: 0; padding: 0; }
    </style>
  </head>

  <body>
    <div>
      <div class="row">
        <div></div>
        <div>
          <div class="text-center">|| OM SAI ||</div>
          <div class="text-center underline">Subject to Thane Jurisdiction</div>
          <div class="text-center heading">VISHAL ROADLINES</div>
          <div class="text-center">Fleet Owners & Transport Contractor</div>
          <div class="text-center">Stainless Steel Tanker For Petroleum</div>
          <div class="text-center">All Kinds of Oil & Chemical Solvents</div>
        </div>
        <div class="text-end"></div>
        <div class="mobile-number-position text-end">
          <div>Tel.:022-25802718</div>
          <div>Mobile No. :022-25802718</div>
          <div>Mobile No. :022-25802718</div>
        </div>
      </div>
      <hr color="black" />
      <div class="address-section">
        Address : Ajaykumar Yadav, Kajuwadi, Opp. Shivsena Shakha, Wagle
        Estate,Thane (W) - 400604.
      </div>
      <div class="address-section">Email : vishalroadlines1976@gmail.com</div>
      <hr color="black" />

      <div class="row .date-invoice-no">
        <div>No. ${invoice.invoiceNo}</div>
        <div>Date: <span class="underline"> ${DateFormat('dd MMM yyyy').format(invoice.date)}</span></div>
      </div>
      <br />

      <br />

      <div class="row">
        <div class="company-name">
          <div
            style="
              width: 100%;
              background-color: black;
              height: 1px;
              margin-bottom: 1rem;
            "
          ></div>
          <div
            style="
              width: 100%;
              background-color: black;
              height: 1px;
              margin-bottom: 1rem;
            "
          ></div>
          <div
            style="
              width: 100%;
              background-color: black;
              height: 1px;
              margin-bottom: 1rem;
            "
          ></div>
          <span class="bold" style="position: absolute; width: 65%; top: 270px">
          ${invoice.customer.companyName}
          </span>
        </div>
        <div class="pan-no">PAN No. ACGPY 8550P</div>
      </div>
    </div>
    <div class="text-center">
      Baring cost of Transporting your products in our Tanker as under
    </div>

    <div style="display: grid; grid-template-columns: 0.5fr 2fr 0.5fr 2fr">
      <div>From :</div>
      <div class="div-underline text-center bold">Thane</div>
      <div>To :</div>
      <div class="div-underline text-center bold">Bhiwandi</div>
    </div>

    <br />
    <table rules="all" style="width: 100%">
      <tr>
        <td>Tanker No.</td>
        <td>LR No.</td>
        <td>Date</td>
        <td>Quantity</td>
        <td>Rate</td>
        <td>PARTICULARS</td>
        <td>Amount(Rs.)</td>
      </tr>
 
  
   ${getTableContent(invoice)}
      
 

      
      
      <tr>
        <th id="total" colspan="6">Sub Total</th>
        <td class="total-amount">${getInvoiceTotal(invoice.rides)}</td>
      </tr>
      <tr>
        <th id="total" colspan="6">Advance</th>
        <td class="total-amount">${invoice.advance}</td>
      </tr>
      <tr>
        <th id="total" colspan="6">Total</th>
        <td class="total-amount">${getInvoiceTotal(invoice.rides) - invoice.advance}</td>
      </tr>
    </table>

    <div class="footer">
      <hr color="black" width="100%" size="1px" />

      <div class="row" style="justify-content: end">
        <div>Payment Details</div>
      </div>
    </div>
  </body>
</html>

 """;
}

getTableContent(Invoice invoice) {
  String tableContent = """ """;
  for (int i = 0; i <= 12; i++) {
    if (i < invoice.rides.length) {
      tableContent = """$tableContent         
        <tr>
        <td>${invoice.rides[i].truckNumber}</td>
        <td>${invoice.rides[i].lrNo}</td>
        <td>${DateFormat('dd MMM yyyy').format(invoice.rides[i].date)}</td>
        <td>${invoice.rides[i].quantity} kg</td>
        <td>${invoice.rides[i].rate}</td>
        <td>${invoice.rides[i].particular}</td>
        <td>${invoice.rides[i].quantity * invoice.rides[i].rate}</td>
      </tr>
         """;
    } else {
      tableContent = """ $tableContent
        <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        </tr>
""";
    }
  }
  return tableContent;
}

getInvoiceTotal(List<Ride> rides) {
  double total = 0.0;
  for (var ride in rides) {
    total += (ride.quantity * ride.rate) + ride.detention!;
  }
  return total;
}
