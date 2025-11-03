# Exercise 6: Finalize the Business Transaction Activity Delivery Notification **02.) Delivery Notification - Outbound**
In this exercise, you will configure and enhance the Business Transaction Activity 02.) Delivery Notification - Outbound
using the SAP Integration Suite. The objective is to define partner-specific parameters, duplicate and adjust the Trading Partner Agreement (TPA), and customize the Mapping Guideline (MAG) and Message Implementation Guideline (MIG) to support extended invoice processing.
What you will do:

Add custom parameters to the Trading Partner Profile.
Copy and rename the existing Trading Partner Agreement.
Extend the invoice transaction with the defined parameters.
Duplicate and rename the MAG and MIG used in the transaction.
Update the MAG to reference the new MIG.
Link the updated MAG to the TPA to complete the configuration.

## Step 01 - Copy Trading Partner MIG
Due to time constraints, you can now create a copy of an already prepared Trading Partner MIG, which you need for the creation of the delivery notification mapping. For this purpose, do the following steps:
- (a) Go in the navigation pane to **Design --> MIGs** and search for the prepared **Trading Partner MIG**: `02.) #IN260-OVERLAY# - UN/EDIFACT D.96A DESADV - Target`
    ***Caution:*** !!! Please never delete or modify this prepared Trading Partner MIG.
- (b) Click on the **Actions → Copy** menu item.
- (c) In the new window of the copied Trading Partner MIG, enable edit mode and click on tab **Overview**.
- (d) Enter your name of the MIG, which is `01.b) IN260-UserXX - UN/EDIFACT D.96A DESADV - Target` and (e) click on the **Save** button.

![IN260 Figure 06.01](assets/IN260_06.01.png)
 
## Step 02 - Create the Overlay Mapping Guideline (MAG)
For the creation of the  is now necessary to create an Overlay MAG so that the specific delivery notification related parts such as pre-transformation and indexing for sorting can be incorporated. the code value mappings accordingly. Therefore, you should make the Overlay MAG for the second BTA (Business Transaction Activity) **02.) Delivery Notification - Outbound** according to the following steps:
- (a) Open **Design → MAGs** to view the MAG list and click **Create → Overlay MAG** to open the wizard.
- (b) For the base MAG, search for: `02.) #IN260-BASE# - SAP IDOC DESADV.DELVRY07 -to- UN/EDIFACT D.96A DESADV` and select this base MAG to move to the next step.
- (c) Keep the **Base Source MIG** unchanged (idoc structure for all partners).
- (d) In **Target MIG**, switch to **Use Compatible MIG** and search as well as (e) select the MIG you created previously: `02.) IN260-UserXX - UN/EDIFACT D.96A DESADV - Target`.
- (f) In step 4, enter the name of the Overlay MAG:
  `02.) IN260-UserXX - SAP IDOC DESADV.DELVRY07 -to- UN/EDIFACT D.96A DESADV`
- (g) Click on button **Create**.

![IN260 Figure 06.02](assets/IN260_06.02.png)

## Step 03 - Create new Pretransformation Rules
In order to do a correct sorting according the finally requested sorted stucture that is required by the trading partner in its UN/EDIFACT DESADV interchange payload, you should have to copy the details of the order line items underneath the correltated packages that are used for the delivery. For this purpose, you have to create a Pretransformation within your Overlay-MAG according the following steps: 
- (a) Go in the opened Overlay MAG in edit mode to the **Overlay** tab and 
- (b) Click on the add **+** button at **Pretransformation**.
- (c) You'll see in tab **Mapping** a new view, the so called **Pretransformation** in where you should 
- (d) Enter a meaningful sorting rule name such as `Copy line item details (E1EDL24) to correlated handling units (E1EDL37)` and 
- (e) Create the new transformation rule by clicking on **Create --> Copy referenced node**

![IN260 Figure 06.03](assets/IN260_06.03.png)

## Step 04 - Copy references of Line Items to Handling Unit
Define the rule for copying the line item details of E1EDL24 to each corresponding handling units E1EDL44 with qualifier VELIN = "3" via the following steps:
- (a) Collapse the whole structure starting from root node **DELVRY07** (Delivery Interface) and expand it so that you just see the direct child group nodes **EDI_DC40** and **E1EDL20**.
- (b) Expand the group node **E1EDL20** (Delivery header) so that you can see the child group nodes of this group.
- (c) Expand the group node **E1EDL44** with qualifier VELIN = "3" (Handling unit) within **E1EDL37** (Handling units header) so that you can see all descendants, and drag and drop this group node to **Receiving node**.
- (d) Drag and drop the child leaf node **EXIDV** (External Handling Unit Identification) to **Node with reference ID**.
- (c) Expand the group node **E1EDL24** (Delivery Items) so that you can see all descendants and drag and drop this group node to **Referenced node**.
- (d) Drag and drop the child leaf node **MATNR** (Material Number (18 Characters)) to **Referenced ID Node**.

***Remark:** If you like, you can save this interim step.

![IN260 Figure 06.04](assets/IN260_06.04.png)

## Step 05 - Duplicate the Handling Units at Target Side
Initially, just the Delivery Header parts are mapped to a UN/EDIFACT segment group SG10, which covers in this case the packaging details of the shipment. You also need further packaging details for pallets that are within the shipment and further handling units that are on the pallets. For this purpose, you can do a duplicate by the following steps:
- (a) Change to tab **Main Transformation**.
- (b) You should now see the additional group **E1EDL24Copy** which was created bvy step (04). But the required data from this group are not mapped yet.
- (c) For this purpose, you need further target groups, which can be added by clickin on **SG 10 ... --> Duplicate**.
- (d) In the pop-up window **Duplicate Node "SG10** clik on button **Create** for
- (e) Adding the new duplicated group in where you should enter the name `Pallets`.
- (f) Repeat it for getting another duplicated group in where you should enter the name `Units`.
- (g) Once you clicked on the button **Apply**, you should see these duplicated groups at the target structure side.

![IN260 Figure 06.07](assets/IN260_06.07.png)

## Step 06 - Add Constants and Mapping Elements
Once you're ready with the duplicates, you can now add the following constants and mapping elements in the Overlay MAG according the following steps:
- (a) **Group Mapping Elements** and **Pass-Through Mapping Element** ``
- (b) **Constants** ``
- (c) **Leaf Mapping Elements with Functions** ``
- (d) **Leaf Mapping Elements with Code Value Mappings** ``
- (e) **:** ``
- (f) **:** ``
- (g) **:** ``
- (h) **:** ``
- (i) **:** ``
- (j) **:** ``


Constants
| Constant Value | Target Node | Target Node Name |
| --- | --- | --- |
| `1` | `/Interchange/DESADV/SG10 [1]/CPS/7164` | Hierarchical id. number |
| `2` | `/Interchange/DESADV/SG10 [1]/CPS/7075` | Packaging level, coded |
| `3` | `/Interchange/DESADV/SG10 [2]/CPS/7164` | Hierarchical id. number |
| `3` | `/Interchange/DESADV/SG10 [2]/CPS/7075` | Packaging level, coded |
| `EF` | `/Interchange/DESADV/SG10 [2]/SG15/LIN/C212/7143` | Item number type, coded |
| `F` | `/Interchange/DESADV/SG10 [2]/SG15/IMD [7077 = F]/7077` | Item description type, coded |
| `131` | `/Interchange/DESADV/SG10 [2]/SG15/QTY [6063 = 131]/C186/6063` | Quantity qualifier |

## Step 07 - Add Pass-Through Mapping Elements
Pass-Through Mapping Elements
| Source Node | Source Node Name | to | Target Node | Target Node Name |
| --- | --- | --- | --- | --- |
| `/DELVRY07/E1EDL20/E1EDL37` | Handling units header | --> |  `/Interchange/DESADV/SG10 [1]` | Pallets |
| `/DELVRY07/E1EDL20/E1EDL37/E1EDL44 [VELIN = 3]` | Handling unit | --> |  `/Interchange/DESADV/SG10 [2]` | Units |
| `/DELVRY07/E1EDL20/E1EDL37/E1EDL44 [VELIN = 3]/E1EDL44/VEMNG` | Base Quantity Packed in the Handling Unit Item | --> |  `/Interchange/DESADV/SG10 [2]/SG11/PAC/7224` | Number of packages |
| `/DELVRY07/E1EDL20/E1EDL37/E1EDL44 [VELIN = 3]/E1EDL44/VEMEH` | Base Unit of Measure of the Quantity to be Packed (VEMNG) | --> |  `/Interchange/DESADV/SG10 [2]/SG11/PAC/C202/7065` | Type of packages identification |
| `/DELVRY07/E1EDL20/E1EDL37/E1EDL44 [VELIN = 3]/E1EDL24Copy` | Copy of Delivery Items | --> |  `/Interchange/DESADV/SG10 [2]/SG15` | Line Items |
| `/DELVRY07/E1EDL20/E1EDL37/E1EDL44 [VELIN = 3]/E1EDL24Copy/E1EDL24/POSNR` | Item number of the SD document | --> |  `/Interchange/DESADV/SG10 [2]/SG15/LIN/1082` | Line item number |
| `/DELVRY07/E1EDL20/E1EDL37/E1EDL44 [VELIN = 3]/E1EDL24Copy/E1EDL24/MATNR` | Material Number (18 Characters) | --> |  `/Interchange/DESADV/SG10 [2]/SG15/LIN/C212/7140` | Item number |
| `/DELVRY07/E1EDL20/E1EDL37/E1EDL44 [VELIN = 3]/E1EDL24Copy/E1EDL24/ARKTX` | Short Text for Sales Order Item | --> |  `/Interchange/DESADV/SG10 [2]/SG15/IMD [7077 = F]/C273/7008` | Item description |

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

/tpm/post-processing/UserXX/02-delivery-notification-outbound/un-edifact

Continue with: [Exercise 7](Exercise_07.md)

02.) IN260-UserXX - SAP IDOC DESADV.DELVRY07 -to- UN/EDIFACT D.96A DESADV