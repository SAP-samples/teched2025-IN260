# Exercise 4: Finalize the Business Transaction Activity: 01. a) Sales Order Request - Inbound

In this exercise, you will complete and test the Business Transaction Activity **01. a) Sales Order Request - Inbound** using the SAP Integration Suite. The goal is to simulate a sales order request, analyze any errors, and refine the configuration to ensure successful processing. You will create and configure a Source MIG (Message Implementation Guideline), generate an Overlay MAG (Mapping Guideline), and update the Trading Partner Agreement (TPA) accordingly.

**What you will do:**
- Trigger the inbound test and analyze the initial syntax error in the B2B Monitor.
- Save the partner’s payload and create a source MIG from it.
- Qualify key segments and refine data types/formatting in the MIG.
- Create an Overlay MAG from the base MAG and align mappings to your MIG.
- Use the proposal service to add non-conflicting mappings and simulate the result.
- Update the TPA to use your Overlay MAG and re-run the end-to-end test.

**Prerequisites:**
- Your TPA is created and activated (from previous exercises).
- You know your sender ID(s) from Exercise 2, Step 8.
- Access to SAP Integration Suite (Cloud Integration), including Design and Monitor.
- Notepad++ (or a text editor) installed.

Follow each step carefully to complete the configuration and ensure the business transaction is correctly processed.

## Step 1 - Test 01. a) Sales Order Request - Inbound
After activation of the TPA, go to the test tool and proceed with the test of the first Business Transaction Activity
- (a) Select the Get Request: **01. a) Sales Order Request - Inbound**
- (b) Open the tab **Body** (if this is not open yet)
- (c) Change the sender ID to one of these, which you entered in Exercise 2 - Step 8
- (d) Substitute the `XX` in **UserXX** with your user ID.
- (e) Click on the **Save** button.
- (f) Run this test.
- (g) After a short while, you'll get an error message.

![IN260 Figure 04.01](assets/IN260_04.01.png)

## Step 2 - Analyze the error
You have to check now why there is an error. For this purpose, you should open the B2B Monitor in the SAP Cloud Integration to get further details for this error. Do the following steps for it:
- (a) Open in the navigation panel the **Monitor --> B2B Scenarios**
- (b) Select this entry in the overview list of **Interchanges**, which belongs to your test. 
  ***Remark:*** You can use the filter at the top to refine the list and find your entry much more easily.
- (c) Check the error in the tab **Error Information**
- (d) This error tells you there is somehow an interchange syntax error.
  ***Remark:*** You got just a kind of error because of the syntax validation in your **TPA --> Business Transaction Activity 01. a) Sales Order Request** is enabled. If you go to your TPA and click on the sender **Interchange** step in this business transaction activity, you can check this. A pop-up window will give you the details of the configuration.
- (e) To get the details of the error, click on the tab **Interchange Payload**
- (f) You'll see the details of the syntax error in this section. This error tells you that some segments are missing or others are too long. 
  ***Remark***: This means that the Source MIG given by the prepackaged B2B Integration Content does not match this payload. It is now recommended that this MIG be updated accordingly and used as an Overlay MIG.

![IN260 Figure 04.02](assets/IN260_04.02.png)

## Step 3 - Save the sender interchange payload
You need to take further steps, such as creating the source MIG and the UN/EDIFACT sender interchange payload for the business transaction activity 01. a) Create the Sales Order Request as a separate file. Therefore, follow the following steps. 
- (a) Go to the API test, especially in the HTTP GET request: **01. a) Sales Order Request** and copy the payload shown in the tab **Body** into the clipboard.
- (b) Open the Notepad++ tool and paste the payload into a new file.
- (c) Open the menu **File**.
- (d) Select **Save** to save the payload as `IN260-XX-EDIFACT-ORDERS.edi` in your downloads folder.

![IN260 Figure 04.03](assets/IN260_04.03.png)

## Step 4 - Create the trading partner's source MIG
The next significant step is to create a source MIG to fit the given payload available in the API testing tool.
- (a) open the **Design --> MIGs**in the navigation panel in SAP Integration Suite.
- (b) In the Message Implementation Guidelines overview list, click the **Create** button.
- (c) You will see a new pop-up window with a wizard for creating a new MIG. You should search the `UN/EDIFACT` type system in the first step.
- (d) Select this type system **UN/EDIFACT**.
- (e) The wizard automatically displays the second step, where you should search for the ´Purchase Order Message`.
- (f) Select the listed **ORDERS** mesage type and select in the forth step the version **D.96A**.
- (g) Select the entry **EnvelopeForMessageS3**in the fourth step.
- (h) Select for uploading in the fifth step the given payload `IN260-XX-EDIFACT-ORDERS.edi`. 
- (i) Ensure that the payload's content will be used as example values.
- (j) Click on the button **Next**.

![IN260 Figure 04.04](assets/IN260_04.04.png)

## Step 5 - Select the nodes for qualification
The qualifier concept is an integral part of the MIGs. It helps you provide the correct business meaning of the used nodes and especially simplifies the mapping later on. The sixth step of the wizard allows you to select these segments that should get different qualified representations. 
- (a) To see which should be qualified, you should open Notepad++ with the opened payload for which you must create a MIG now.
- (b) In this payload, you might recognize that the **DTM** segment occurs several times with different qualifiers. Therefore, it makes sense to select the **DTM** segment.
- (c) The **FTX** occurs just once, but it is also useful to select this segment for semantic precision.
- (d) The **Segment Group 2 (SG2)**, which expresses the different kinds of parties, should also be selected.
- (e) Please check the table below to select the remaining segments.
- (f) If you finished the selection, click the **Next** button.

![IN260 Figure 04.05](assets/IN260_04.05.png)

| Node | Name |
| --- | --- |
| `DTM [2005 = “137”]` | Document/message date/time |
| `FTX [4451 = “AAI”]` | General information |
| `SG2 [3035 = “BY”]` | Buyer |
| **In SG25** | In Line Item Segment Group | 
| `     PIA [4347 = “1”]` | Additional product id - Additional identification |
| `    IMD [7077 = “F”]` | Free-form |
| `    QTY [6063 = “21”]` | Quantity - Ordered quantity |
| `    SG28 [5125 = “AAA”]` | Calculation net price |
| `CNT [6069 = “1”]` | Algebraic total of the quantity values in line items in a |


## Step 6 - Finalize the Overview Information of the new MIG
In the wizard step (6), you can enter all the information that belongs to the overview of the new MIG. Follow the following steps:
- (a) Enter in **Name** the name of the MIG such as: `01a IN260-UserXX - UN/EDIFACT D.96A ORDERS – Source`
- (b) Select the **Direction**: `In` for Inbound. 
- (c) Select in the **Own Business Conext** the valus in the **Own Business Conext** category **Business Procss**: `Create Order`
- (d)	**Product Classification**: `Food Beverage and Tobacco Products`
- (e) **Industry Classification**: `Wholesale Distribution`
- (f)	**Country/Region**: `Germany`
- (e)	**Business Process Role**: `Buyer`
- (h) Click on the **Create** button.

***Remarks:***
-	The “Partner Business Context” is not relevant.
-	The context currently has just an informative purpose. But it will be part of the future proposal service, categorization, and searching.

![IN260 Figure 04.06](assets/IN260_04.06.png)

## Step 7 - Automatic creation of the MIG
The MIG will be initially created. After a while, you'll see a pop-up window that the MIG was successfully processed.
- (a) Click the **Close** button to close the window.
- (b) First, you should hide all the unselected nodes by going to the column header **Node** in the Structure table and clicking on the **right mouse button**.
- (c) You'll see a menu. In here, you should select the menu item **Show Selected Nodes**
- (d) Now, you'll just see the selected nodes, which are the ones in which the checkbox is marked.
- (e) You can now refine/finalize the nodes. For example, you can change the names to be more concise or the properties of the data element  **2380**. For this purpose, you have to click on each node so that the details panel of this node will be displayed. 
- (f) In the details panel, at tab **Details**, scroll down to the section **Simple Type Properties** and select the value' Date' in **Primitive Type**.
- (g) May enter the value `8` for eight digits in **max. Length**. You can do the same in **min. Length**, because the date has a static length of 8 characters.
- (h) The most crucial part is selecting the **Date Time Format**, because this will be recognized in the MAG (Mapping Guideline) later on. Select the value `CCYYMMDD` here, because this format is expressed by the qualifier value **102** in the subsequent node **2379** (Date/time/period format qualifier).  If you set the date/format at all the date/time nodes in the source/target MIGs, you don't have to create conversion functions in a MAG's mapping element if the source/target MIGs have different formats. This will be in a MAG automatically computed if the date/formats are known.

***Remark**: The table in Step 8 shows the nodes where you have to make the changes.

![IN260 Figure 04.07](assets/IN260_04.07.png)

## Step 8 - Set further qualifier markers
Unfortunately, the automatic qualifier setting procedure while creating a MIG via payload, as described in step 5, does not yet recognize all the necessary qualifier markers and qualifications. Therefore, some of the qualifier markers have to be manually set via the following steps:  
- (a) Go to the data element (leaf) node that will be used to qualify a segment or segment group. In this case, the data element **6347** (Currency details qualifier) should qualify segment group 7, which might be used to express different kinds of currencies, including the usage of the other segments in this segment group. 
- (b) In the details panel at **Details** tab go to the section **Properties** and click at **Qualifiers** the **[+]** (Add) button.
- (c) You should now select the **SG7** in the pop-up window so that this segment group can also be qualified by this data element.
- (d) Click on the **Create** button. 
- (e) You'll see a further (grey) qualifier marker arrow from the data element **6347** to the segment group **SG7**.
-   
![IN260 Figure 04.08](assets/IN260_04.08.png)

## Step 9 - Set a qualification to a segment group
Once you set the additional qualifier markers as explained in step 8, you can now set a qualification of this segment group by the following steps:
- (a) Click on the segment group **SG7**, which should be qualified and click on the **Right Mouse Button** so that you can seea menu.
(b) In this menu, select the item **Qualify Node...**, and a pop-up window will appear.
- (c) Select the value **2** (Reference currency) in this pop-up window because this is the value set in the given payload. See: 
  `CUX+2:EUR:9'`
- (d) Click the **Create** button to see the additional qualifications for the MIG. We suggest changing the name of this segment group so that you will only see the necessary meaning of the whole segment group, such as **Reference currency**.

***Remark***: Refine the further nodes according to the same principle as described in steps 7 to 9. The table below shows which nodes should be updated or have further information. Once you have finished this update, you should click the **Save** button of this MIG.

![IN260 Figure 04.09](assets/IN260_04.09.png)

**Table of relevant changes**

| Node | Name | Qualifier | Prim. Type | Length | Format | 
| --- | --- | --- | --- | --- | --- |
| `DTM [2005 = “137”]` | Document/message date/time | `./C507/2005` |  |  |  | 
| `            2380` | Date/time/period |  | `Date` | `8 .. 8` | `CCYYMMDD` | 
| `DTM [2005 = “2”]` | Delivery date/time, requested | `./C507/2005` |  |  |  | 
| `            2380` | Date/time/period |  | `DateTime` | `12 .. 12` | `CCYYMMDDhhmm` | 
| `DTM [2005 = “10”]` | Shipment date/time, requested | `./C507/2005` |  |  |  | 
| `            2380` | Date/time/period |  | `DateTime` | `12 .. 12` | `CCYYMMDDhhmm` | 
| `FTX [4451 = “AAI”]` | General information | `./4451` |  |  |  | 
| `SG2 [3035 = “BY”]` | Buyer | `./NAD/3035` |  |  |  | 
| `    SG5 [3139 = “OC”]​` | Order contact | `./CTA/3139` |  |  |  | 
| `            COM [3155 = “TE”]​` | Telephone | `./C076/3155` |  |  |  | 
| `SG2 [3035 = “SU”]` | Supplier | `./NAD/3035` |  |  |  | 
| `SG2 [3035 = “DP”]` | Delivery party | `./NAD/3035` |  |  |  | 
| `SG7 [6347 = “2”]` | Reference currency | `./CUX/C504/6347` |  |  |  | 
| `SG25    ` | Line Items |  |  |  |  | 
| `    PIA [4347 = “1”]​` | Additional product id | `./4347` |  |  |  | 
| `    IMD [7077 = “F”]​` | Free-form item description | `./7077` |  |  |  | 
| `    QTY [6063 = “21”]​` | Ordered quantity | `./C186/6063` |  |  |  | 
| `    SG28 [5125 = “AAA”]​` | Calculation net price | `./PRI/C509/5125` |  |  |  | 
| `            CUX [6347 = “2”]​` | Reference currency | `./C504/6347` |  |  |  | 
| `CNT [6069 = “1”]` | Algebraic total of the quantity values in line items in a | `./C270/6069` |  |  |  | 
| `CNT [6069 = “2”]` | Number of line items in message | `./C270/6069` |  |  |  | 



## Step 10 - Create a new Overlay MAG
Once you are ready with the trading partner-specific source MIG, you can go ahead with the creation of the "Overlay MIG" based on the given MAG already provided by the pre-packaged B2B integration content. To create this **Overlay MAG**, you have to follow the following steps: 
- (a) Go to the MAG overview list by selecting **Design --> MAGs** in the navigation panel.
- (b) Click on the **Create** button and select the item **Overlay MAG** to display a pop-up window with a wizard for creating a Mapping Guideline.
- (c) Search for the base MAG, which is `01.a) [Trading Partner Name] - UN/EDIFACT D.96A ORDERS -to- SAP IDOC ORDERS.ORDERS05`
- (d) Select this MAG from the filtered list, and the wizard will jump directly to the next step.
- (e) In this second step, **Source MIG** select the tab **Compatible MIG**because you have to choose this MIG, which you already created in the previous steps.
- (f) Search for this MIG, which `01a IN260-UserXX - UN/EDIFACT D.96A ORDERS – Source
- (g) Select this MIG that is now displayed in the list.
- (h) Keep the Base Target MIG in the third step because it is the IDoc structure used across all trading partners.
- (i) This means that you should take the same target MIG as the Base Target MIG, which is `
01.a) [Company Name] - SAP IDOC ORDERS.ORDERS05 for Customer EDI - Target.
- (j) Enter the name of the Overlay MAG in the 4th wizard step, which is: `01a IN260-UserXX - UN/EDIFACT D.96A ORDERS –to- SAP IDOC ORDERS.ORDERS05`.
- (k) Click on the button **Create**.

![IN260 Figure 04.10](assets/IN260_04.10.png)

## Step 11 - New Overlay MAG, first clean up
You will see the new Overlay MAG in the Mapping view. However, because of the inconsistencies between the base source MIG and the trading partner-specific MIG, you may see some errors. These should be deleted according to the following steps. 
- (a) You may see several errors.
- (b) Go to the **Mapping List** tab.
- (c) Select **Only errors** to see the errors in the Mapping List.
- (d) Delete all the erroneous mapping elements.

![IN260 Figure 04.11](assets/IN260_04.11.png)

## Step 12 - Check if the Overlay MAG is correct.
You should now test if the **Overlay MAG** is not correct. You can do this best by simulating the mapping with the source payload. For this purpose, you have to do the following steps:
- (a) Select the menu item **Simulate --> Simulate with MIG Example Data**.
- (b) Upload the given payload `IN260-XX-EDIFACT-ORDERS.edi` in the new pop-up window.
- (c) Click on the button **OK**.
- (d) You should then see the values of the uploaded payload in the table, which shows the structure of the source MIG at the appropriate nodes.
- (e) You should see the transformed values at the mapped nodes at the target MIG. 

![IN260 Figure 04.12](assets/IN260_04.12.png)

## Step 13 - Add further mapping elements via proposal service
The assumption is now that the mapping is incomplete because it covers just the valid base mapping elements yet. Therefore, you should add further mapping elements in the Overlay MAG via the proposal service once the Overlay MAG is running sufficiently. The following steps are required for it: 
- (a) Open the menu item **Proposal**, and the proposal service will be started. After about 2 minutes, it will give you a result in the **Mapping List**.
- (b) You should now display just the **Nonconflicting proposals**, which means that you will see these mapping elements only, which will not overrule the base mapping elements.
- (c) Select the best-fitting proposed mapping elements by clicking the button **Select Best Proposal**. 
- (d) Then select in the pop-up window the correct mapping elements via clicking on the button **Use only valid Mappings**- 

![IN260 Figure 04.13](assets/IN260_04.13.png)

## Step 14 - Check and save the updated Overlay MAG
You should run a further simulation to check if the Overlay MAG with the additional overlay mapping elements is still correct.
- (a) You'll see the additional overlay mapping elements in **Green**.
- (b) Click on the button to repeat the simulations.
- (c) You should see a different result than step (14).
- (d) If all is correct, click the button **Save**.

![IN260 Figure 04.14](assets/IN260_04.14.png)

## Step 15 - Change to the Overlay MAG in the TPA
You should put the Overlay MAG into your TPA by following these steps: 
- (a) Open your TPA and display the **B2B Scenarios** tab. 
- (b) In the first business transaction activity in the **01.) Sales Order Request/Response** business transaction. Click here on the activity step **Mapping**.
- (c) Click in the panel **Mapping** on the value help button at the **Mapping Guidelines (MAG).**.
- (d) In the pop-up window, click the **Reset** button to select the MAGs.
- (e) Select **Contains**.
- (f) Insert the name of your Overlay MAG, such as `01a IN260-UserXX - UN/EDIFACT D.96A ORDERS –to- SAP IDOC ORDERS.ORDERS05`.
- (g) Click on the button **Go**.
- (h) Select your MAG in the filtered list of MAGs. 

![IN260 Figure 04.15](assets/IN260_04.15.png)

## Step 16 - Update the TPA
You have to update the content of the TPA in the PD (Partner Directory) by following the steps. The PD (Partner Directory) stores all the configuration and content of the configured TPAs so that this will be dynamically invoked during runtime via the generic TPM-related integration flows. You can do an update via the following steps:
- (a) First, you should save all the changes you made by clicking on the button **Save**.
- (b) Click on the button **Update**.
- (c) In the pop-up window, you should select the first business transaction because you usually don't make any changes in the other business transactions.
- (d) Click on the button *Update**.

![IN260 Figure 04.16](assets/IN260_04.16.png)

## Step 17 - 
- (a)

![IN260 Figure 04.17](assets/IN260_04.17.png)

## Step 18 - 
- (a)

![IN260 Figure 04.18](assets/IN260_04.18.png)

## Step 19 - 
- (a)

![IN260 Figure 04.19](assets/IN260_04.19.png)

## Step 20 - 
- (a)

![IN260 Figure 04.20](assets/IN260_04.20.png)
