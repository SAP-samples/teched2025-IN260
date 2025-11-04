# Exercise 2: Creating a Trading Partner Agreement (TPA) from a Template

This exercise teaches you how to create a Trading Partner Agreement (TPA) using a predefined template within Trading Partner Management. You will verify and update activity parameters, add company- and trading partner–specific parameters, and finalize the agreement setup. By the end of this exercise, you will be able to configure and activate a TPA tailored to your trading partner’s requirements.

## Step 1 - Open the TPA Template
First, verify that all required activity parameters are correctly set in the uploaded Trading Partner Agreement Template and make any necessary changes:
- (a) In Trading Partner Management, go to the **Agreement Templates** tab.
- (b) Open the template **[B2B Integration Factory] - Order to Cash B2B Scenario for SAP IDoc with UN/EDIFACT D.96A – Template**.

![IN260 Figure 02.01](assets/IN260_02.01.png)

## Step 2 - Check and review the TPA Template
Review the required activity parameters for each business transaction. If any are missing, add them as described in Step 3. Check the following activity parameters:
- (a) Go to the **B2B Scenarios** tab.
- (b) Expand Business Transaction: **01.) Sales Order Request/Response**.
- (c) Open the **Activity Parameters** tab.
- (d) Ensure the following Activity Parameters are available:

| Activity | Role | Data Source | Private Key | Private Value |
| --- | --- | --- | --- | --- |
| Inbound | RECEIVER | [Company Name] | SAP_EDI_REC_Receiver_System_ID | SAPDS2 |
| Inbound | RECEIVER | [Company Name] | SAP_EDI_REC_Receiver_Partner_Type | LS |
| Inbound | RECEIVER | [Company Name] | SAP_EDI_REC_Receiver_Partner_Function | MA |
| Inbound | SENDER |  | SAP_EDI_REC_Sender_System_ID | *Derived from TPP* |
| Inbound | SENDER |  | SAP_EDI_REC_Sender_Partner_Function | *Derived from TPP* |
| Inbound | SENDER |  | SAP_EDI_REC_Sender_Partner_Type | *Derived from TPP* |
| Outbound | RECEIVER |  | SAP_EDI_REC_Receiver_Routing_Address | *Derived from TPP* |
| Outbound | SENDER | [Company Name] | SAP_EDI_REC_Sender_Routing_Address | FromCI |

- (e) Expand Business Transaction: **02.) Delivery Notification – Outbound** and check:

| Activity | Role | Data Source | Private Key | Private Value |
| --- | --- | --- | --- | --- |
| Outbound | RECEIVER |  | SAP_EDI_REC_Receiver_Routing_Address | *Derived from TPP* |
| Outbound | SENDER | [Company Name] | SAP_EDI_REC_Sender_Routing_Address | FromCI |

- (f) Expand Business Transaction: **03.) Invoice - Outbound** and review:

| Activity | Role | Data Source | Private Key | Private Value |
| --- | --- | --- | --- | --- |
| Outbound | RECEIVER |  | SAP_EDI_REC_Receiver_Routing_Address | *Derived from TPP* |
| Outbound | SENDER | [Company Name] | SAP_EDI_REC_Sender_Routing_Address | FromCI |

![IN260 Figure 02.02](assets/IN260_02.02.png)


## Step 3 - Create a TPA by Copying a TPA Template
Create a new TPA by copying from the template:
- (a) Open the **Agreements** tab.
- (b) Click **Create**; a pop-up will open.
- (c) Select the TPA template `[B2B Integration Factory] - Order to Cash B2B Scenario for SAP IDoc with UN/EDIFACT D.96A - Template`.
- (d) Click **Next**.
- (e) Enable **Copy from Template**.
- (f) Select all business transactions.
- (g) From the drop-down, select your Trading Partner **IN260-UserXX** (replace XX with your User ID).
- (h) Click **Open Draft**.

General note: Selecting all transactions is not always necessary. Choose only the transactions that are relevant for your trading partner.

![IN260 Figure 02.06](assets/IN260_02.06.png)

## Step 4 - Finalize the TPA Overview
A new TPA for your trading partner will be created. In the default **Overview** tab, finalize the details:
- (a) Update the agreement name and description, replacing `[IN260]` with `IN260-XX` (replace XX with your User ID).
- (b) In **Trading Partner Details**, set **Type System** to `UN/EDIFACT`.
- (c) Set **Type System Version** to `D.96A S3`.
- (d) Click the value help for **Identifier in Company Type System** to open a pop-up.
- (e) In the pop-up, open the **Identifier Groups** tab.
- (f) Select the identifier group with **Group Name**: `GE-UserXX` (replace XX with your User ID).
- (g) In **My Company Details**, set **Identifier in Trading Partner Type System** to `COMP_E_D`.
- (h) Click **Save**.

![IN260 Figure 02.07](assets/IN260_02.07.png)

## Step 5 - Review, update, and activate the TPA
To finalize and activate the TPA:
- (a) Go to the **B2B Scenarios** tab.
- (b) Verify that all activity parameters defined in Step 2 are present and filled. Trading partner–related activity parameters should show values derived from the corresponding parameters in the Trading Partner Profile. Repeat this review for:
  - 02.) Delivery Notification - Outbound
  - 03.) Invoice - Outbound
- (c) Check that any empty values in the template are now filled with your trading partner parameters.
- (d) If everything looks correct, click **Activate**.
- (e) After a short while, **Activation Status** should display **Active**, and the **Activate** button will be replaced with **Deactivate**.

![IN260 Figure 02.08](assets/IN260_02.08.png)

## Step 6 - Feasibility Check
Use the Bruno API Testing Tool to verify the activated TPA:
- (a) Open the Bruno API Testing Tool, navigate to the folder **IN260 - Order to Cash - SAP IDoc with UN/EDIFACT**, and open the GET request **01.a) Sales Order Request - Inbound**.
- (b) select the correct environment by pressing the button on the right top (_No environments_) and select _Tenant 2 - Teched 2025_
- (c) Click the **→** button to run the GET request.
- (d) After a short while, you should see an XML-based IDoc message as the result.
- (e) Repeat the procedure with the GET request **01.b) Sales Order Response - Outbound**,
- (f) so that you see a UN/EDIFACT interchange payload with an ORDRSP message as the response.
- (g) Repeat the procedure with the GET request **02.) Delivery Notification - Outbound**,
- (h) so that you see a UN/EDIFACT interchange payload with a DESADV message as the response.
- (i) Repeat the procedure with the GET request **03.) Invoice - Outbound - Buyer**,
- (j) so that you see a UN/EDIFACT interchange payload with an INVOIC message as the response.

Remark: Don’t worry about the content you receive. It is not yet finalized. The content will be corrected in Exercises 03 to 07.

![IN260 Figure 02.09](assets/IN260_02.09.png)

Remark: If you receive a result for all four GET requests, this task is complete and you can proceed with the next exercise.

----

Continue with: [Exercise 3](Exercise_03.md)

Please give us feedback on session **IN260** by scanning the QR code:

![QR Code](../pictures/survey_QR.png)