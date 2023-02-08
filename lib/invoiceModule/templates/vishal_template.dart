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
      .serial-number {
        color: red;
        font-size: large;
        padding: 0rem 1rem;
      }
      .name-title {
        padding: 2rem 0rem;
      }
      .pan-number {
        color: red;
        border: 1px solid red;
      }
      .name {
        display: inline-block;
      }
      .name-pannel {
        margin: 1rem;
        padding: 1rem 0rem;
        text-align: center;
      }
      .name-pannel-2 {
        font-size: larger;
        text-decoration: underline;
        padding-left: 1rem;
      }
      .From {
        padding-top: 1rem;
        padding-left: 1rem;
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
      tr:nth-child(11) {
        padding-top: 0;
        border-bottom: 1px solid black;
      }

      /* total */
      #total {
        border: 0 !important;
        text-align: right;

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

     

      <!-- <table rules="all" style="width: 100%;" >
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
          <th id="total" colspan="6">Sub total :</th>
          <td>200</td>
        </tr>
        <tr>
            <th id="total" colspan="6">Advance :</th>
            <td>200</td>
          </tr>
          <tr>
            <th id="total" colspan="6">Total :</th>
            <td>200</td>
          </tr>
      </table> -->
    </div>
  </body>
</html>

 """;
