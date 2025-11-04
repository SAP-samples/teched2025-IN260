# Exercise 1: Create the necessary Trading Partner Profile
In this exercise, you will learn how to set up a complete Trading Partner Profile for EDI processing within a B2B integration scenario. The steps guide you through:
- Creating a unique Interchange Control Number (ICN) using number ranges.
- Setting up a Trading Partner Profile, including company details and identifiers for UN/EDIFACT and IDoc payloads.
- Configuring Identifier Groups to manage multiple sender identifiers.
- Defining Trading Partner System Details, including type systems and communication channels.
- Creating Trading Partner Parameters to support dynamic data injection into mappings and headers.
- Assigning Number Ranges to ensure proper tracking of EDI transactions.

By completing this exercise, you will gain hands-on experience in configuring the foundational elements required for secure and structured electronic data interchange between business partners.

## Step 1 - Go to the Number Range objects
A unique interchange control number should be included when sending documents for EDI processing. To add an interchange number, use Number Ranges. Each IN260 participant should create their own interchange number. For this purpose:
- (a) Click **Integrations and APIs** inside the Monitor section.
- (b) Select the **Number Ranges** card.

![IN260 Figure 01.01](assets/IN260_01.01.png)

## Step 2 - Create a Number Range object
In the new window, create your number range for the Interchange Control Number (ICN) by following these steps:
- (a) Click **Add**; a pop-up will open.
- (b) Enter the name `ICN_EDIFACT_IN260_UserXX` (replace XX with your User ID).
- (c) Set the minimum value to `0`.
- (d) Set the maximum value to `99999999999999`.
- (e) Enter the field length `14`.
- (f) Select the checkbox for `Rotate`.
- (g) Click **OK**.

Note: The interchange control number is a unique identifier assigned to each interchange of EDI transactions. It is used to track and manage data exchange between trading partners. The group control number, on the other hand, is used to identify and manage the individual groups of transactions within an interchange.

![IN260 Figure 01.02](assets/IN260_01.02.png)

## Step 3 - Create a new Trading Partner Profile
Now, create your trading partner profile so that you can build your specific Trading Partner Agreement based on the imported Trading Partner Agreement template.
- (a) Navigate to B2B Scenarios to open Trading Partner Management (TPM).
- (b) Go to **Partner Profiles**.
- (c) Create a new trading partner by clicking Create → Trading Partner.
- (d) In the **Overview** tab, set Company Name to `IN260-UserXX` (replace XX with your number).
- (e) Set Company Short Name to `IN260-UserXX`.
- (f) Click **Save**.

![IN260 Figure 01.03](assets/IN260_01.03.png)

## Step 4 - Create a Single Identifier for UN/EDIFACT
First, set single identifiers for outgoing UN/EDIFACT interchanges:
- (a) Stay on the Trading Partner Profile and open the **Identifiers** tab.
- (b) Click **Create**; a pop-up will open.
- (c) Enter the identification number `E-UserXX`, where XX is your User ID. Ensure the identification number is no longer than 14 characters; if necessary, remove leading zeros.
- (d) Enter the Alias: `TP_UNEDIFACT_ID`.
- (e) Select the Type System: `UN/EDIFACT`.
- (f) Select the Scheme: `Mutually defined` with the value `ZZZ`.
- (g) Click **Save**.

![IN260 Figure 01.04](assets/IN260_01.04.png)

## Step 5 - Create a Single Identifier for SAP IDoc
Create another required identifier as in Step 4:
- (a) Click **Create** and enter:
  - Identification: `I-UserXX`, where XX is your User ID. Ensure the identification number is no longer than 10 characters; if necessary, remove leading zeros.
  - Alias: `TP_IDOC_ID`
  - Type System: `SAP S/4HANA On Premise IDoc`
  - Scheme: `N/A`
- (b) The identifier should then appear in the list after you click **Save**.

![IN260 Figure 01.05](assets/IN260_01.05.png)

## Step 6 - Create an Identifier Group for UN/EDIFACT
Create an Identifier Group for incoming UN/EDIFACT interchanges, which might have different sender identifiers in the UNB segment:
- (a) Scroll down to **Identifier Groups**.
- (b) Click **Create**; a pop-up will open.
- (c) Enter the identification number `GE-UserXX`, where G stands for group and XX is your User ID. Ensure the identification number is no longer than 14 characters; if necessary, remove leading zeros.
- (d) Enter the Alias: `TP_UN/EDIFACT_G`.
- (e) Select the Type System: `UN/EDIFACT`.
- (f) Select the Scheme: `Mutually defined` with the value `ZZZ`.
- (g) Click **Save**.

![IN260 Figure 01.06](assets/IN260_01.06.png)

## Step 7 - Add an Identifier to the Identifier Group
You should now see the new identifier group entry. Add identifiers to it as follows:
- (a) Click **Add**.
- (b) In the pop-up, enter Identification: `E1-UserXX`.
- (c) Enter Sub-Organization Name: `Suborg. E1`.
- (d) Click **Save**.

![IN260 Figure 01.07](assets/IN260_01.07.png)

## Step 8 - Add a second Identifier to the Identifier Group
Add a second identifier to the same group:
- (a) Open the details view of the identifier group.
- (b) Click **Add**.
- (c) Enter:
  - Identification: `E2-UserXX`
  - Sub-Organization Name: `Suborg. E2`
- (d) Click **Save**.
- (e) Enable Activation Status so the group's identifiers are recognized as sender identifiers for incoming UN/EDIFACT interchanges.

![IN260 Figure 01.08](assets/IN260_01.08.png)

## Step 9 - Create the trading partner’s B2B System
Add Trading Partner System Details so you can define trading partner–specific configuration, such as communication channels. Proceed as follows:
- (a) Navigate to the **Systems** tab.
- (b) Click **Create System**; a pop-up window will appear.
- (c) Enter the System Name: `B2B System`.
- (d) Enter Alias: `UN-EDIFACT_B2B-System`.
- (e) Select the Type: `B2B System`.
- (f) Select the Purpose: `Dev`.
- (g) Click **Save** to finalize the configuration.

![IN260 Figure 01.09](assets/IN260_01.09.png)

## Step 10 - Create the trading partner’s Type System
Open your newly created system and configure the trading partner’s system details:
- (a) Go to the system’s details.
- (b) On the **Type Systems** tab, click **Create Type System**; a pop-up will open.
- (c) In **Assign Type System Version(s)**, choose `UN/EDIFACT`.
- (d) Select version `D.96A S3` using the drop-down boxes.
- (e) Click **Add**. You will see the newly added type system version.

![IN260 Figure 01.10](assets/IN260_01.10.png)

## Step 11 - Create the Receiver Communication Channel
Next, set up the communication channels. Because this session focuses exclusively on interchange payload processing, creating simulation channels is sufficient. Session INT164 focuses on communication with external systems, such as via the AS2 communication protocol. Add the receiver channel as follows:
- (a) Go to the **Communications** tab.
- (b) Click **Create Communication**; a pop-up window will open.
- (c) Enter the Name: `B2B-Simulation.Receiver`.
- (d) Enter the Alias: `B2B-Simulation.Receiver`.
- (e) Set Direction: `Receiver`.
- (f) Set Adapter: `Process_Direct`.
- (g) In Connection Details, enter the address: `/tpm/b2b-simulation/receiver`.
- (h) Click **Save**.

![IN260 Figure 01.11](assets/IN260_01.11.png)

## Step 12 - Create the Sender Communication Channel
You need another communication channel on the sender side. Create it as follows:
- (a) On the **Communications** tab, click **Create**.
- (b) Enter:
  - Name: `B2B-Simulation.Sender`
  - Alias: `B2B-Simulation.Sender`
  - Direction: `Sender`
  - Adapter: `Process_Direct`
- (c) Click **Save**.

![IN260 Figure 01.12](assets/IN260_01.12.png)

## Step 13 - Create a trading partner–related parameter
Parameters can be used in many ways: to initialize additional values in the envelope header, to provide values in mappings, or in pre-/post-processing integration flows or scripts for further control and processing. If parameters are trading partner–related, it is beneficial to create them in the trading partner profile so agreements can dynamically access them. Create the parameter as follows:
- (a) In the Trading Partner Profile, go to the **Parameters** tab.
- (b) Click **Create**; a pop-up window will open.
- (c) In **Parameter Key**, enter: `SAP_EDI_REC_Receiver_Routing_Address`.
- (d) In **Value**, enter: `ToTestERP`.
- (e) Click **Save**.

Remark: This value will be inserted into the UNB interchange header via the assembly step.

![IN260 Figure 01.13](assets/IN260_01.13.png)

## Step 14 - Create additional required parameters
Add the following parameters:
- (a) Click **Create**.
- (b) Create the parameters shown in the following table.

| Parameter Key | Value | Purpose |
| --- | --- | --- |
| `DESADV_ContractPartyReferenceNumber` | `REF-IN260-UserXX` | Injection into the MAG |
| `DESADV_KindOfNumberOfTotalPackages` | `CBP` | Injection into an XSLT script in a post-processing flow |
| `SAP_EDI_REC_Sender_System_ID` | `CPIFALLBAC` | Injection into the SAP IDoc EDI_DC40 header segment in incoming transactions |
| `SAP_EDI_REC_Sender_Partner_Function` | `AG` | Injection into the SAP IDoc EDI_DC40 header segment in incoming transactions |
| `SAP_EDI_REC_Sender_Partner_Type`| `KU`| Injection into the SAP IDoc EDI_DC40 header segment in incoming transactions |

![IN260 Figure 01.14](assets/IN260_01.14.png)

## Step 15 - Assign the created Number Range object
Assign the number range from Step 2 to the trading partner. This number is used to insert a trading partner–specific interchange control number into the UNB interchange header (data element 0020: Interchange Control Reference). Proceed as follows:
- (a) Switch to the **Number Ranges** tab.
- (b) Click **Add**.
- (c) Select the Number Range `ICN_EDIFACT_IN260_UserXX`.
- (d) Enter the Alias: `ICN_EDIFACT`.
- (e) Click **Save**.

![IN260 Figure 01.15](assets/IN260_01.15.png)

----

Continue with: [Exercise 2](Exercise_02.md)

Please give us feedback on session **IN260** by scanning the QR code:

![QR Code](../pictures/survey_QR.png)
