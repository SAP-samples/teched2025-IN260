# Excercise 7: Finalize the Business Transaction Activity: 3.) Invoice - Outbound

How to create and insert 2 to 3 complex mapping functions. 
And use of shared code. The mapping functions will be prepared.
Explain that an Joule (AI) will support you on this case soon.

Explain how to get Overlay MIG and initial Overlay MAG similar like in Excercise 04 - Step 4 to Step 12. Either can do this, if they have time, if not than they to copy the prepared Overlay MIG and MAG. No use of proposal service

## Step 1 - Open your Partner Profile
To start, open your Trading Partner Profile (TPP):

- (a) Log in to your SAP Integration Suite tenant and open the Trading Partner Management application.
- (b) Navigate to Partner Profiles.
- (c) Select your Trading Partner (`IN260-UserXX`).

![Bootcamp Figure 02.01](assets/INVOIC_01.png)


## Step 2 - Add Parameters to the Trading Partner Profile

Next, create parameters that will later be used in your agreement:
- (a)	Click on “Paramters”. 
- (b) Add a new parameter with the following details:
    - Name: `UserYY_AllowanceChangeInformation`
    - Value: `Discount:10`
- (c) Save the parameter.
- (d) Create a second parameter:
    - Name: `UserYY_ValueAddedTaxPercent`
    - Value: `19`
- (e) Save your changes.

![Bootcamp Figure 02.02](assets/INVOIC_02.png)
![Bootcamp Figure 02.02](assets/INVOIC_03.png)
![Bootcamp Figure 02.02](assets/INVOIC_04.png)

## Step 3 - Copy an Existing Trading Partner Agreement

Now, create a copy of an existing TPA:
- (a) Navigate to Agreements. 
- (b) Click on Copy. 
- (c) Navigate to Overview and click on "Edit".
- (d) Rename the TPA to `IN260-UserYY- Order to Cash B2B Scenario for SAP IDoc with UN/EDIFACT D.96A`.

![Bootcamp Figure 02.02](assets/INVOIC_05.png)
![Bootcamp Figure 02.02](assets/)

## Step 4 - Assign Parameters to the Invoice Transaction
Add the parameters you created to the outbound invoice transaction:
- (a) In your TPA, navigate to "B2B Scenarios". 
- (b) Open the Transaction `03.) Invoice - Outbound` 
- (c) Click `Add Parameters` -> `Extend from TP`.
- (d) Select your Parameters and click "save".
- (e) Save the TPA (bottom right corner). 
- (f) Click "Update" → "Update" to apply the changes.  

![Bootcamp Figure 02.02](assets/INVOIC_07.png)
![Bootcamp Figure 02.02](assets/INVOIC_08.png)
![Bootcamp Figure 02.02](assets/INVOIC_09.png)
![Bootcamp Figure 02.02](assets/INVOIC_10.png)
![Bootcamp Figure 02.02](assets/INVOIC_11.png)

## Step 5 - Copy the Mapping Guidline (MAG)

To create a copy of the MAG used in your TPA:
- (a) Navigate to "Design" → "MAGs".
- (b) Select the MAG you want to copy, and click on "Cop"y" -> "Copy MAG only".
- (c) Navigate to "Overview", click on "Edit" and change the Name to `03.) IN260-UserYY - ... INVOIC`

![Bootcamp Figure 02.02](assets/INVOIC_12.png)
![Bootcamp Figure 02.02](assets/INVOIC_13.png)


## Step 6 - Copy the Message Implementation Guideline (MIG)

Next, copy the corresponding MIG:
- (a)	Click on the Taget MIG Name.
- (b)   Click on "Copy".
- (c)	Navigate to "Overview" -> "Edit".
- (c)	Rename the copied MIG to `03.) IN260-UserYY - ... Target`.
- (d)   Save the MIG.

![Bootcamp Figure 02.02](assets/INVOIC_14.png)
![Bootcamp Figure 02.02](assets/INVOIC_15.png)
![Bootcamp Figure 02.02](assets/INVOIC_16.png)

## Step 7 - Update the Target MIG Reference in the MAG

Now you will replace the old target MIG in your copied MAG:
- (a)	Open your copied MAG and go to the "Overview" tab.
- (b)	Click "Edit" next to the Target MIG field.
- (c)   Search for your new MIG by entering UserYY
- (d)   Selet it and click on "Change".
- (e)	And now save your MAG. 

![Bootcamp Figure 02.02](assets/INVOIC_17.png)
![Bootcamp Figure 02.02](assets/INVOIC_18.png)
![Bootcamp Figure 02.02](assets/INVOIC_19.png)

## Step 8 - Update the MAG in the Trading Partner Agreement

Finally, link your updated MAG in the Trading Partner Agreement:
- (a)	Return to your Trading Partner Agreement.
- (b)	Open the Invoice Transaction.
- (c)	Click “Edit".
- (d)   Under Mapping, open the Mapping Guideline.
- (e)   Search for your MAG and select it. 
- (f)   Click "Save", then Update the TPA once more to finalize the changes.

![Bootcamp Figure 02.02](assets/INVOIC_20.png)
![Bootcamp Figure 02.02](assets/INVOIC_21.png)
![Bootcamp Figure 02.02](assets/INVOIC_22.png)
![Bootcamp Figure 02.02](assets/INVOIC_23.png)
![Bootcamp Figure 02.02](assets/INVOIC_24.png)
