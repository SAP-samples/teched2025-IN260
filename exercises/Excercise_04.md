# Exercise 4: Finalize the Business Transaction Activity: 01. a) Sales Order Request - Inbound


## Step 1 - Create a new Overlay MAG
Once you are ready with the trading partner-specific source MIG, you can go ahead with the creation of the **Overlay MAG** based on the given MAG already provided by the pre-packaged B2B integration content. To create this **Overlay MAG**, you have to follow the following steps: 
- (a) Go to the MAG overview list by selecting **Design --> MAGs** in the navigation panel.
- (b) Click on the **Create** button and select the item **Overlay MAG** to display a pop-up window with a wizard for creating a Mapping Guideline.
- (c) Search for the base MAG, which is `01.a) #IN260-BASE# - UN/EDIFACT D.96A ORDERS -to- SAP IDOC ORDERS.ORDERS05`
- (d) Select this MAG from the filtered list, and the wizard will jump directly to the next step.
- (e) In this second step, **Source MIG** select the tab **Compatible MIG**because you have to choose this MIG, which you already created in the previous steps.
- (f) Search for this MIG, which `01.a) IN260-UserXX - UN/EDIFACT D.96A ORDERS – Source`
- (g) Select this MIG that is now displayed in the list.
- (h) Keep the Base Target MIG in the third step because it is the IDoc structure used across all trading partners.
- (i) This means that you should take the same target MIG as the Base Target MIG, which is `
01.a) [Company Name] - SAP IDOC ORDERS.ORDERS05 for Customer EDI - Target.
- (j) Enter the name of the Overlay MAG in the 4th wizard step, which is: `01.a) IN260-UserXX - UN/EDIFACT D.96A ORDERS –to- SAP IDOC ORDERS.ORDERS05`.
- (k) Click on the button **Create**.

![IN260 Figure 04.01](assets/IN260_04.01.png)

## Step 2 - New Overlay MAG, first clean up
You will see the new Overlay MAG in the Mapping view. However, because of the inconsistencies between the base source MIG and the trading partner-specific MIG, you may see some errors. The reason is that the Base MIG and its corresponding Base MAG may consider more commonly used nodes than the MIG that is used for the specific trading partner. These should be deleted according to the following steps. 
- (a) You may see several errors.
- (b) Go to the **Mapping List** tab.
- (c) Select **Only errors** to see the errors in the Mapping List.
- (d) Delete all the erroneous mapping elements.

![IN260 Figure 04.02](assets/IN260_04.02.png)

## Step 3 - Check if the Overlay MAG is correct.
You should now test if the **Overlay MAG** is not correct. You can do this best by simulating the mapping with the source payload. For this purpose, you have to do the following steps:
- (a) Select the menu item **Simulate --> Simulate with MIG Example Data**.
- (b) Upload the given payload `IN260-XX-EDIFACT-ORDERS.edi` in the new pop-up window.
- (c) Click on the button **OK**.
- (d) You should then see the values of the uploaded payload in the table, which shows the structure of the source MIG at the appropriate nodes.
- (e) You should see the transformed values at the mapped nodes at the target MIG. 

![IN260 Figure 04.03](assets/IN260_04.03.png)

## Step 4 - Add further mapping elements via proposal service
The assumption is now that the mapping is incomplete because it covers just the valid base mapping elements yet. Therefore, you should add further mapping elements in the Overlay MAG via the proposal service once the Overlay MAG is running sufficiently. The following steps are required for it: 
- (a) Open the menu item **Proposal**, and the proposal service will be started. After about 2 minutes, it will give you a result in the **Mapping List**.
- (b) You should now display just the **Nonconflicting proposals**, which means that you will see these mapping elements only, which will not overrule the base mapping elements.
- (c) Select the best-fitting proposed mapping elements by clicking the button **Select Best Proposal**. 
- (d) Then select in the pop-up window the correct mapping elements via clicking on the button **Use only valid Mappings**- 

![IN260 Figure 04.04](assets/IN260_04.04.png)

## Step 5 - See added mapping elements and clear proposal
You will see the added mapping elements in the Overlay MAG, but before proceeding, you should clear the proposal and save the Overlay MAG.
- (a) You'll see the additional overlay mapping elements in **Green**.
- (b) In the tab **Proposal List**
- (c) Click on button **Clear Proposal** so that all the proposed mapping elements will be deleted.
- (d) If all is correct, click the button **Save**. 
  
***Remark:*** This **Save** is important so that the whole Overlay MAG will be updated accordingly.

![IN260 Figure 04.05](assets/IN260_04.05.png)

## Step 6 - Check, if the Overlay MAG is valid
You should now proof the processing correctness of the Overlay MAG without reviewing the semantic details. This so review of semantic correctness will be done at a step. 
- (a) Click on **Simulate** button and select **Simulate with simulate data**.
- (b) Select your test file `Source - IN260-XX-EDIFACT-ORDERS.edi` and click on **OK** button.
- (c) It could be the case that you'll get a processor error like shown in the pop-window "Error". It tells that the value `20250929`in the input data does not match with the given date/time `CCYYMMDDhhmm`format. 
- (d) Please check in given source payload via note editor, where this value occurs. In this example case, this value `20250929` belongs to the **DTM** segment with the qualifier **137**, see: `DTM+137:20250929:102'`. 
- (e) Go in source structure of your Overlay MAG, especially to the source node **DTM[2005 = 137] --> C507 --> 2380**, that you will see that this source node has two mapping elements.
- (f) This mapping element covers for e.g. the transformation of the time based on the given date format `CCYMMDDhhmm`. This mapping element was inserted by the mapping proposal --> select best proposal. The reason is that the contributed majority covers also this mapping element.
- (g) You can simply delete this in your context unnecessary mapping element by clicking on the specific mapping element line --> click on right mouse button --> an especially click on the menu item **Delete**.
  
![IN260 Figure 04.06](assets/IN260_04.06.png)

## Step 7 - Change to the Overlay MAG in the TPA
You should put the Overlay MAG into your TPA by following these steps: 
- (a) Open your TPA and display the **B2B Scenarios** tab. 
- (b) Go into the edit mode by clicking on **Edit** button.
- (c) In the first business transaction activity in the **01.) Sales Order Request/Response** business transaction. Click here on the activity step **Mapping**.
- (d) Click in the panel **Mapping** on the value help button at the **Mapping Guidelines (MAG).**.
- (e) In the pop-up window, click the **Reset** button to select the MAGs.
- (f) Select **Contains**.
- (g) Insert the name of your Overlay MAG, such as `01.a) IN260-UserXX`.
- (h) Click on the button **Go**.
- (i) Select your MAG in the filtered list of MAGs. 
- (j) Click on the button **Choose**.
- (k) Save the updated TPA by clicking on **Save** button.

![IN260 Figure 04.07](assets/IN260_04.07.png)

## Step 8 - Select Business Transaction Activirty for updating in PD
You have to update the content of the TPA in the PD (Partner Directory) by following the steps. The PD (Partner Directory) stores all the configuration and content of the configured TPAs so that this will be dynamically invoked during runtime via the generic TPM-related integration flows. You can do an update via the following steps:
- (a) Click on the button **Update**.
- (b) Click on the **OK** button in the pop-up window ***Update Agreement*** with updating into.
- (c) You'll see another pop-up-window ***Select Transactions and ...*** in where you should select the first business transaction `01.) Sales Order Request/Response` because you usually don't make any changes in the other business transactions.
- (d) Click on the button *Update**.

![IN260 Figure 04.08](assets/IN260_04.08.png)

## Step 9 - Updating in the PD 
Once you selected you Business Transaction Activity, you should now see the updating pocess
- (b) By displaying the progress status.
- (a) And after a short while that the updated TPA has the status **Active**.

![IN260 Figure 04.09](assets/IN260_04.09.png)

## Step 10 - Test the updated Business Transaction Activity
You can finally thest the updated Business Transaction Activity via Bruno
- (a) Select in Bruno the first test entry `01.a) Sales Order Request - Inbound`
- (b) Click on the **Send** button
- (c) And you'll see as in the "Response" a target interchange payload which covers the mapping result of the updated MAG.

***Remark***: The next excersice describes now how you can review, finalize and refine the mapping and and gives you an idea how you can use payload validation for increasing the precission of the transformed content.

![IN260 Figure 04.10](assets/IN260_04.10.png)

TBD ## Step 11 - Review and Adjust MAG and Test
In accordance with the test run result, the MAG or may the source payload can now be corrected accordingly. The following changes can be made:
- (a) Deletion of mapping elements or constants. There is an element in the test run result that does not exist in the reference payload.
- (b) Changing of the position of mapping element lines or changing of a mapping function. The expected values are distributed to different target elements in the test run result, but this does not correspond to the specifications of the reference payload.
- (c) Add additional mapping elements including mapping functions or constants. There is an element in the reference payload that does not exist in the test run result.

To find out which sore and target nodes are to be connected and how the mapping functions look, you have the following options:
- Use the embedded MAG simulation to check, which target values in a reference payload might exist at the source site.
- Check the meaning (semantics) of the possible nodes This can be also done together with the embedded.
- If this is not helpful, you must then ask the experts from the customers. Perhaps there is a specification that can help.
- Ask SAP AI with a sufficient prompt.
Before you start, it is recommended to have a big screen so that you can see both at the same view, the MAG and the test case run results in parallel view. This makes your work more effective.
Please note that the following tasks, instructions, and examples are based on a specific status of the proposal. Due to a different proposal, these can then no longer match 100%. Therefore, you should consider these tasks, instructions, and examples as a recommendation. 

![IN260 Figure 04.11](assets/IN260_04.11.png)

## Step 12 - Find matching results for to be added Mapping Elements
In order to recognize which of the mapping elements are required, you should run the simulate with payload in the MAG so that you can see the payload values at the source and target payload side. In here, you should do for example the following steps:
- (a) Repeat the simulation that you initially started in step (3).
- (b) Search for the value that you see at the "Reference Message" side in the INT4 Test Run result in the simulation result at the source side. It is possible that the string you are looking for is a part of a concatenated string. It can also be the other way around. A of the string to be searched for is displayed only part of the original page.
- (c) By means of the comparison, it may be possible to exchange qualification values. However, since is a qualification value for the representation of a complete qualified group, not only should the individual qualification value be exchanged, but in this case new mapping elements must be created, of which there is a qualified group in the target structure that contains this qualification value.
- (d) Now, in this case, it is very important to compare the meanings of the respective qualifying groups. In particular, the names and may the descriptions of the qualifying groups should be compared. 
- (e) As a result of the comparison, the probability is very high that the corresponding mapping elements should be created to another qualifying segment group. As a result, the probability is very high that the corresponding mapping elements should be created to another qualifying segment group. In this case, the mapping elements must be dragged to the qualifying group with the value 22 and to the qualifying group with the value 10.
  
![IN260 Figure 04.12](assets/IN260_04.12.png)

## Step 13 - Add Date/Time Mapping Elements
Once you have performed the semantic comparison and the value comparison, and you are sure which corresponding source/target nodes are to be mapped, you can add the corresponding mapping elements. An example of a Date/Time Mapping Element is shown here.
- (a) In the case of a UN/EDIFACT representation, the date formats are represented using peer qualifiers. Here, an adjacent node (2379) specifies the format using the code value. In this case, it is CCYYMMDDhhmm. This specifies that the value contains the data and the time. 
- (b) Since the target side has split the date and time between two nodes (DATE, UZEIT), two mapping elements must be created for these corresponding nodes.
- (c) Since this qualifying group has a maximum cardinality of 1, it is not necessary to create a mapping element at group level. This is because this qualifying group is automatically created once during processing due to the child nodes mapped in step (13.b).
- (d) As a result of the situation described in step (13.c), a mapping element is then only required for aesthetic reasons.

![IN260 Figure 04.13](assets/IN260_04.13.png)

## Step 14 - Date/Time Format Conversion
If the date and time formats are now preset in MIG, nothing more needs to be done. This is because the conversion rule is then generated automatically. You can basically understand this by performing the following steps:
- (a) If you have created the mapping element between the corresponding mapping elements.
- (b) You should see the **Date Time Conversion** tab in the Details Panel. You should then click on this one.
- (c) In this details panel you can see the preset date and time formats at the the source and the target side.
- (d) In this case, you can see the time format in the selected Mapping Element from 2380 to UZEIT. You can also create this format display subsequently within the MAG. However, we recommend that you always define the formats in the MIGs.
- (e) You can check the result by clicking on the simulation button.

![IN260 Figure 04.14](assets/IN260_04.14.png)

## Step 15 - Adding further standard Mapping Elements
The other mapping elements can be added according to the same principle.
- (a) In most cases, only the mapping element line must be drawn between the corresponding source and target elements. 
- (b) As described above, if the ancestors occur only once at most, mapping between the respective leaf nodes that contain the values is sufficient.
- (c) In most cases, this is a standard mapping element. This means that the standard function `<xsl:sequence select="$nodes_in/*"/>` does not have to be changed.
- (d) By carrying out the simulation, you can see the corresponding results. 
- (e) Here you can also see that the constant values of the ancestors are also generated autmatically.

![IN260 Figure 04.15](assets/IN260_04.15.png)