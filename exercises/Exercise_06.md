# Exercise 6: Finalize the Business Transaction Activity **02.) Delivery Notification - Outbound**
In this exercise, you will configure and enhance the Business Transaction Activity 02.) Delivery Notification - Outbound
using the SAP Integration Suite. The objective is to define partner-specific parameters, duplicate and adjust the Trading Partner Agreement (TPA), and customize the Mapping Guideline (MAG) and Message Implementation Guideline (MIG) to support extended invoice processing.
What you will do:

Add custom parameters to the Trading Partner Profile.
Copy and rename the existing Trading Partner Agreement.
Extend the invoice transaction with the defined parameters.
Duplicate and rename the MAG and MIG used in the transaction.
Update the MAG to reference the new MIG.
Link the updated MAG to the TPA to complete the configuration.

## Step 03 - Copy Trading Partner MIG
Due to time constraints, you can now create a copy of an already prepared Trading Partner MIG, which you need for the creation of the delivery notification mapping. For this purpose, do the following steps:
- (a) Go in the navigation pane to **Design --> MIGs** and search for the prepared **Trading Partner MIG**: `02.) #IN260-OVERLAY# - UN/EDIFACT D.96A DESADV - Target`
    ***Caution:*** !!! Please never delete or modify this prepared Trading Partner MIG.
- (b) Click on the **Actions → Copy** menu item.
- (c) In the new window of the copied Trading Partner MIG, enable edit mode and click on tab **Overview**.
- (d) Enter your name of the MIG, which is `01.b) IN260-UserXX - UN/EDIFACT D.96A DESADV - Target` and (e) click on the **Save** button.

![IN260 Figure 06.01](assets/IN260_06.01.png)
 
## Step 01 - Create the Overlay Mapping Guidline (MAG)
For the creation of the  is now necessary to create an Overlay MAG so that the specific delivery notification related parts such as pre-transformation and indexing for sorting can be incorporated. the code value mappings accordingly. Therefore, you should make the Overlay MAG for the second BTA (Business Transaction Activity) **02.) Delivery Notification - Outbound** according to the following steps:
- (a) Open **Design → MAGs** to view the MAG list and click **Create → Overlay MAG** to open the wizard.
- (b) For the base MAG, search for: `02.) #IN260-BASE# - SAP IDOC DESADV.DELVRY07 -to- UN/EDIFACT D.96A DESADV` and select this base MAG to move to the next step.
- (c) Keep the **Base Source MIG** unchanged (idoc structure for all partners).
- (d) In **Target MIG**, switch to **Compatible MIG** and search as well as (e) select the MIG you adjusted previously: `02.) #IN260-OVERLAY# - UN/EDIFACT D.96A DESADV - Target`.
- (f) In step 4, name the Overlay MAG:
  `01.b) IN260-UserXX - SAP IDOC ORDRSP.ORDERS05 -to- UN/EDIFACT D.96A ORDRSP`
- (g) Click **Create**.
- 
Create a copy of the Mapping Guideline (MAG) used in the invoice transaction:
- (a) Open the **MAGs** overview by navigating to **Design → MAGs** in the left-hand panel.
- (b) Identify the Overlay MAG titled **02.) #Bootcamp-STANDARD# - SAP IDOC DESADV.DELVRY07 -to- UN/EDIFACT D.96A DESADV**. Initiate the copy process and choose the option to copy only the MAG structure.
- (c) Access the **Overview** tab of the copied MAG and enable editing mode.
- (d) Rename the MAG to: `03.) Bootcamp-UserXX – SAP IDOC INVOIC.INVOIC02 – to – UN/EDIFACT D.96A INVOIC`.
- (e) Save the MAG to preserve the updated configuration.

![IN260 Figure 06.01](assets/IN260_06.01.png)


## Step 2 - Copy the Message Implementation Guideline (MIG)

Next, duplicate the target Message Implementation Guideline (MIG) referenced in the MAG:
- (a)	Within the copied MAG, locate the **Target MIG** and open its details.
- (b)   Use the copy function to create a new instance of the MIG.
- (c)	Navigate to the **Overview** tab of the copied MIG and activate editing mode.
- (d)	Rename the MIG to: `03.) Bootcamp-UserXX – UN/EDIFACT D.96A INVOIC – Target`.
- (e)   Save the MIG to complete the duplication process.

![IN260 Figure 06.02](assets/IN260_06.02.png)

## Step 3 - Update the Target MIG Reference in the MAG

Replace the reference to the original target MIG with the newly created one:
- (a)	Open the copied MAG and go to the **Overview** tab. In the **Target MIG** section, initiate the edit function.
- (b)   Select the MIG created in Step 5 from the available list.
- (c)   Confirm the change to update the reference.
- (d)	Save the MAG to apply the new configuration.

![IN260 Figure 06.03](assets/IN260_06.03.png)


## Step 4 - Update the MAG in the Trading Partner Agreement

Finally, link the updated MAG to the invoice transaction in your Trading Partner Agreement:
- (a)	Return to the Trading Partner Agreement and open the `02.) Delivery Notification - Outbound`.
- (b)	Enable editing mode to modify the transaction settings.
- (c)   In the **Mapping** section, open the Mapping Guideline configuration.
- (d)   Search for the updated MAG created in Step 1 and select it.
- (e)   Save the transaction and perform a final Update of the TPA to ensure all changes are applied.

![IN260 Figure 06.04](assets/IN260_06.04.png)

## Step 5 - Create Pretransformation

To create the Pretransformation go to: 
- (a) Open your MAG and click Edit.
- (b) Navigate to Pretransformation 
- (c) Click **Create → Copy referenced node**.
- (d) Drag and drop to fill out the fields: 
    - Receiving node: **E1EDL37**
    - Node with reference ID: **EXIDV**
    - Referenced Node: **E1EDL24**
    - Referenced ID Node: **MATNR**

![IN260 Figure 06.05](assets/IN260_06.05.png)


## Step 6 - Create Pallets and Units

Next, extend the main transformation:
- (a) Go back to **Main Transformation**.
- (b) Search for the field **SG10** and click **Duplicate**. 
- (c) Create two duplicates by clicking **Create** twice. 
- (d) Name them **Pallets** and **Units**. 
- (e) Click **Apply**. 

![IN260 Figure 06.06](assets/IN260_06.06.png)


## Step 7 - Mapp the Pallets

Mapp the following fields by draging the source field on the target field:
- (a) Add constant 2 to fields 7164 and 7075; map EXIDV to 7166.
- (b) Add the function `<xsl:sequence select="concat('01;', $nodes_in/EXIDV)"/>`. 
- (c) Add constant 1 to field 7224; map VHILM to 7065.
- (d) Click **Add → All** remaining source values and add **PX -- Pallet**.

![IN260 Figure 06.07](assets/IN260_06.07.png)


## Step 8 - Map the Units

Mapp the following fields by draging the source field on the target field:
- (a) Map **E1EDL44** to **SG10[2]**.
- (b) Add constant **3** to fields **7164** and **7075**; map **EXIDV** and **POSNR** to **7166** and add the function: 
    - `*<xsl:sequence select="concat('01;', $nodes_in/EXIDV[1], ';', $nodes_in/POSNR[1])"/>*`
- (c) Map **VEMNG** to **7224** and **VEMEH** to **7065**.
- (e) Click **Add → All remaining source values** and fill out: 
    - `CT -- Cartoon``
    - `RO -- Roll``
    - `BG -- Bag``
    - `BX -- Box``
    - `PK -- Package``

![IN260 Figure 06.08](assets/IN260_06.08.png)


## Step 9 - Map the Line Items

- (a) Map **E1EDL24** to **SG15**.
- (b) Map **POSNR** to **1082**. 
- (c) Map **MATNR** to **7140** and add the constant **EF** to **7143**.
- (d) Add constant **F** to **7077** and map **ARKTX** to **7008**.
- (e) Add constant **131** to **6063**, constant **PCE** to **6411**, then map the **VELIN** and **LFIMG** to **6060** using: 
    - `<xsl:sequence select="xs:integer($nodes_in/LFIMG div count($nodes_in/VELIN))"/>`

![IN260 Figure 06.09](assets/IN260_06.09.png)

## Step 10 - Add the Customized Post-Processing
To add the Customized Post-Processing follow these steps: 
- (a) Go to your MAG into the **02.) Delivery Notification – Outbound transaction**.
- (b) In the interchange section on the target side, select **Customized Post-Processing**. 
- (c) Add the Process Direct adress: 
    - `/tpm/post-processing/userXX/02-delivery-notification-outbound/un-edifact`

![IN260 Figure 06.10](assets/IN260_06.10.png)


## Step 11 - Copy the Post-Processing iFlow

To copy the iflow: 
- (a) Go into **Design → Integration and APIs**. 
- (b) Open the package **BOOTCAMP - Pre and Post-Processing Flows - Custom**.
- (c) In the **Artifacts** tab, copy the iFlow**Post-Processing - UserXX - 02 ...**.
- (d) Change **UserXX** in the name to your ID. 
- (e) Click **Copy**.
![IN260 Figure 06.11](assets/IN260_06.11.png)


## Step 12 - Configure the iFlow

- (a) Click **Configure** on your new iFlow. 
- (b) Add the same Process Direct Adress as in the TPA. 
    - `tpm/post-processing/userXX/02-delivery-notification-outbound/un-edifact` 
- (c) Click **Deploy**. 

![IN260 Figure 06.12](assets/IN260_06.12.png)

----

Continue with:[Excercise 7](Exercise_07.md)
Please give us also feedback to this session **IN260** by scanning the QR-Code:
 ![QR Code](pictures/survey_QR.png)