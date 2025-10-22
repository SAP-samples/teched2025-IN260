# Excercise 5: Finalize the Business Transaction Activity: 01. a) Sales Order Response - Outbound

- Code Value Mapping
- Compound Code Value

Steps: Explain how to get Overlay MIG and initial Overlay MAG similar like in Excercise 04 - Step 4 to Step 12. Either can do this, if they have time, if not than they to copy the prepared Overlay MIG and MAG. No use of proposal
Explain the insertion of additional code lists
Explain how to create a simple code value mapping and complex code value mapping in the Overlay MAG

## Step 1 - Create the trading partner's target MIG
The next significant step is to create a source MIG to fit the given payload available in the API testing tool.
- (a) open the **Design --> MIGs** in the navigation panel in SAP Integration Suite.
- (b) In the Message Implementation Guidelines overview list, click the **Create** button.
- (c) You will see a new pop-up window with a wizard for creating a new MIG. You should search the `UN/EDIFACT` type system in the first step.
- (d) Select this type system **UN/EDIFACT**.
- (e) The wizard automatically displays the second step, where you should search for the `Purchase Order Response Message`.
- (f) Select the listed **ORDRSP** mesage type and select in the forth step the version **D.96A**.
- (g) Select the entry **EnvelopeForMessageS3** in the fourth step.
- (h) Select for uploading in the fifth step the given payload `Bootcamp-XX-EDIFACT-ORDRSP.edi`. 
- (i) Ensure that the payload's content will be used as example values.
- (j) Click on the button **Next**.

![IN260 Figure 04.01](assets/IN260_05.01.png)

## Step 5 - Select the nodes for qualification
The qualifier concept is an integral part of the MIGs. It helps you provide the correct business meaning of the used nodes and especially simplifies the mapping later on. The sixth step of the wizard allows you to select these segments that should get different qualified representations. 
- (a) To see which should be qualified, you should open Notepad++ with the opened payload for which you must create a MIG now.
- (b) In this payload, you might recognize that the **DTM** segment occurs several times with different qualifiers. Therefore, it makes sense to select the **DTM** segment.
- (c) The **FTX** occurs just once, but it is also useful to select this segment for semantic precision.
- (d) The **Segment Group 2 (SG2)**, which expresses the different kinds of parties, should also be selected.
- (e) Please check the table below to select the remaining segments.
- (f) If you finished the selection, click the **Next** button.

![IN260 Figure 04.02](assets/IN260_05.02.png)

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


## Step 3 - Finalize the Overview Information of the new MIG
In the wizard step (6), you can enter all the information that belongs to the overview of the new MIG. Follow the following steps:
- (a) Enter in **Name** the name of the MIG such as: `01.b) Bootcamp-UserXX - UN/EDIFACT D.96A ORDRSP – Target`
- (b) Select the **Direction**: `Out` for Inbound. 
- (c) Select in the **Own Business Conext** the values in the **Own Business Conext** category **Business Procss**: `Confirm/Verify Payment Orders`
- (e) **Industry Classification**: `Consumer Products`
- (e)	**Business Process Role**: `Seller`
- (h) Click on the **Create** button.

***Remarks:***
-	The “Partner Business Context” is not relevant.
-	The context currently has just an informative purpose. But it will be part of the future proposal service, categorization, and searching.

![IN260 Figure 04.03](assets/IN260_05.03.png)

## Step 4 - Automatic creation of the MIG
The MIG will be initially created. After a while, you'll see a pop-up window that the MIG was successfully processed.
- (a) First, you should hide all the unselected nodes by going to the column header **Node** in the Structure table and clicking on the **right mouse button**.
- (b) You'll see a menu. In here, you should select the menu item **Show Selected Nodes**
- (c) Now, you'll just see the selected nodes, which are the ones in which the checkbox is marked.

![IN260 Figure 04.04](assets/IN260_05.04.png)

You can now refine/finalize the nodes. For example, you can change codelists of the data element  **6411**. 

- (a) For this purpose, search and select the element 6411.
- (b) In the details panel, switch to tab **Codelist**.
- (c) Click on the plus button, a new popup will open.
- (d) Select `From Type System`
- (e) Select type system `GS1 EANCOM`
- (d) Select version `F1997_S3_Edition_2001`
- (g) Search and select the codelist **6411**. Repeat the steps for all remaining **6411** elements.

![IN260 Figure 04.0401](assets/IN260_05.0401.png)

Similar to the 6411 element, we will now add a new codelist to the element **7065**.
- (a) For this purpose, search and select the element 7065.
- (b) In the details panel, switch to tab **Codelist**.
- (c) Click on the plus button, a new popup will open.
- (d) Select `From Custom Type System`
- (e) Search and select the codelist `UserXX_7065_PackageType`.
- (f) Save your MIG.

![IN260 Figure 04.0402](assets/IN260_05.0402.png)

## Step 10 - Create a new Overlay MAG
Once you are ready with the trading partner-specific source MIG, you can go ahead with the creation of the "Overlay MIG" based on the given MAG already provided by the pre-packaged B2B integration content. To create this **Overlay MAG**, you have to follow the following steps: 
- (a) Go to the MAG overview list by selecting **Design --> MAGs** in the navigation panel.
- (b) Click on the **Create** button and select the item **Overlay MAG** to display a pop-up window with a wizard for creating a Mapping Guideline.
- (c) Search for the base MAG, which is `01.b) #BOOTCAMP-BASE# - SAP IDOC ORDRSP.ORDERS05 -to- UN/EDIFACT D.96A ORDRSP`
- (d) Select this MAG from the filtered list, and the wizard will jump directly to the next step.
- (e) Keep the Base Source MIG in the second step because it is the IDoc structure used across all trading partners.
- (f) In the third step, **Target MIG**, select the tab **Compatible MIG** because you have to choose this MIG, which you already created in the previous steps. Search for this MIG, which `01.b) Bootcamp-UserXX - UN/EDIFACT D.96A ORDRSP – Target`
- (g) Select this MIG that is now displayed in the list.
- (h) `01.b) #XX-OVERLAY# - SAP IDOC ORDRSP.ORDERS05 -to- UN/EDIFACT D.96A ORDRSP`
- (k) Click on the button **Create**.

![IN260 Figure 04.10](assets/IN260_05.05.png)

## Step 11 - New Overlay MAG, first clean up
You will see the new Overlay MAG in the Mapping view. However, because of the inconsistencies between the base source MIG and the trading partner-specific MIG, you may see some errors. These should be deleted according to the following steps. 
- (a) You may see several errors.
- (b) Go to the **Mapping List** tab.
- (c) Select **Only errors** to see the errors in the Mapping List.
- (d) Delete all the erroneous mapping elements.

![IN260 Figure 04.11](assets/IN260_05.06.png)

## Step 12 - Check if the Overlay MAG is correct.
You should now test if the **Overlay MAG** is not correct. You can do this best by simulating the mapping with the source payload. For this purpose, you have to do the following steps:
- (a) Select the menu item **Simulate --> Simulate with MIG Example Data**.
- (b) Upload the given payload `Bootcamp-XX-EDIFACT-ORDRSP.edi` in the new pop-up window.
- (c) Click on the button **OK**.
- (d) You should then see the values of the uploaded payload in the table, which shows the structure of the source MIG at the appropriate nodes.
- (e) You should see the transformed values at the mapped nodes at the target MIG. 

![IN260 Figure 04.12](assets/IN260_05.07.png)

## Step 13 - Add further mapping elements 
The assumption is now that the mapping is incomplete because it covers just the valid base mapping elements yet. Therefore, you should add further mapping elements in the Overlay MAG. In this step, we will have a look at the single code value mapping and compound code value mappings.

A **Simple code value mapping** covers a mapping from one source code value from one source node to a target code value for a target node. You can either map the values directly in the mapping element, or, if you are going to use the value mapping in several mapping elements, create a Global Mapping that can be reused. 

- (a) Create a mapping element between source and target leaf node. Both nodes must have an assigned codelist. If this is the case, you should see the tabe “Code Value Mapping”. Open this tab.
- (b)	As we will use this mapping for several mapping elements, we will create a Global Mapping. Click on **Create Global Mapping**.
- (c)	A new popup will open. Enter the name `UserXX_UoM to 6411` and click on **Create**. A new tab will open.
- (d) Click on **Edit**.
- (e) Add new code values by clicking on **Add** and choosing **All remaining source values**.
- (f) Open the value help for the first line. Search `PCE` and choose it. 
- (g) Repeat the steps and map the target values according to the screenshot. **Save your changes.**

![IN260 Figure 04.13](assets/IN260_05.08.png)

The Global Mapping can now be assigned to the respective mapping elements.

- (a) Open your overlay mapping again. You might need to refresh the browser. Make sure to save your changes before refreshing.
- (b) Search for the target element 6411 and select it.
- (c) Switch to the tab **Code Value Mapping**
- (d) Click on **Assign Global Mapping**.
- (e) Select the Global Code Value Mapping you created in the previous steps.
- (f) The mapping is now visible inside the code value mapping tab.


Repeat the steps (b) to (e) for the remaining 6411 elements.

![IN260 Figure 04.13](assets/IN260_05.0801.png)

The next step is to create a **compound code value mapping**. A compound code value mapping maps several code values from different source nodes to one code values of a target value. This allows you to create more complex code value mappings in where a combination of code values at source side are required for getting a specific target code. All the involved nodes must have assigned code lists, which was done in step 4. 

In the given example we will map the combination of a sales document item category and material type to the corresponding tpye of package. If you want to create a compound code value mapping, you have to follow the following steps:
- (a)	Insert the first mapping line from for e.g. PSTYV – Sales document item category Tax Exempt Code to 7065 – Type of packages
- (b)	Insert the second mapping line from for e.g. MATKL – IDOC Material class to the same element, means 7065 – Type of packages
- (c)	If all the nodes have assigned codelists, you will than see the code value mapping icon and the “Code Value Mapping” tab is enabled.
- (d)	Insert a default target code value such as: CT -- Carton
- (e)	Click on the add button and create the combination of code values per entry. You’ll the list for the exercise below.
- (f)	Repeat this step until you created all the compound code value mappings.


![IN260 Figure 04.13](assets/IN260_05.0802.png)

## Step 14 - Check and save the updated Overlay MAG
You should run a further simulation to check if the Overlay MAG with the additional overlay mapping elements is still correct.
- (a) You'll see the additional overlay mapping elements in **Green**.
- (b) Click on the button to repeat the simulations.
- (c) If all is correct, click the button **Save**.

![IN260 Figure 04.14](assets/IN260_05.09.png)

## Step 15 - Change to the Overlay MAG in the TPA
You should put the Overlay MAG into your TPA by following these steps: 
- (a) Open your TPA and display the **B2B Scenarios** tab. 
- (b) In the first business transaction activity **01.) Sales Order Request/Response**, click on the activity step **Mapping** of the bottom flow.
- (c) Click in the panel **Mapping** on the value help button at the **Mapping Guidelines (MAG).**.
- (d) In the pop-up window, click the **Reset** button to select the MAGs.
- (e) Select **Contains**.
- (f) Insert the name of your Overlay MAG, such as `01.b) #XX-OVERLAY# - SAP IDOC ORDRSP.ORDERS05 -to- UN/EDIFACT D.96A ORDRSP`.
- (g) Click on the button **Go**.
- (h) Select your MAG in the filtered list of MAGs. 

![IN260 Figure 04.15](assets/IN260_05.10.png)

## Step 16 - Activate the TPA
You have to update the content of the TPA in the PD (Partner Directory) by following the steps. The PD (Partner Directory) stores all the configuration and content of the configured TPAs so that this will be dynamically invoked during runtime via the generic TPM-related integration flows. You can do an update via the following steps:
- (a) First, you should save all the changes you made by clicking on the button **Save**.
- (b) Click on the button **Activate**.

![IN260 Figure 04.16](assets/IN260_05.11.png)