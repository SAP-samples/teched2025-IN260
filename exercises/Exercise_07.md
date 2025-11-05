# Exercise 7: Finalize the Business Transaction Activity Invoice **03.) Invoice – Outbound**
In this exercise, you will configure and enhance the Business Transaction Activity 03.) Invoice – Outbound using the SAP Integration Suite. The objective is to define trading partner-specific parameters, use them in mapping functions within a Mapping Guideline (MAG), and create further complex mapping functions that can also be used.

This exercise also demonstrates the possibilities of XPath 2.0 functions in conjunction with XSLT functions such as `xsl: variable` and `xsl: sequence`. You will learn how to utilize these functions to manipulate and transform XML data effectively.

### What You Will Do
- Explore XPath 2.0 functions and their integration with just the XSLT functions xsl: variable and xsl: sequence.
- Practice creating variables and sequences using `xsl: variable` and `xsl: sequence`.
- Understand how these functions can be used for specific mapping element transformations.

### Prerequisites
- Familiarity with XSLT syntax 
- Knowledge of XPath fundamentals.


## Step 01 - Copy Trading Partner MIG
Similar to Exercise 06, you should now create a copy of an already prepared Trading Partner MIG, which you need for creating the invoice mapping. For this purpose, do the following steps:
- (a) Go in the navigation pane to **Design --> Message Implementation Guidelines** and 
- (b) Search for the prepared **Trading Partner MIG**: `03.) #IN260-OVERLAY# - UN/EDIFACT D.96A INVOIC - Target`
    ***Caution:*** !!! Please never delete or modify this prepared Trading Partner MIG.
- (c) Click on the **Actions → Copy** menu item.
- (d) In the new window of the copied Trading Partner MIG, enable edit mode and click on tab **Overview**, enter your name of the MIG, which is `03.) IN260-UserXX - UN/EDIFACT D.96A INVOIC - Target` and (e) click on the **Save** button.

![IN260 Figure 07.01](assets/IN260_07.01.png)
 
## Step 02 - Create the Overlay Mapping Guideline (MAG)
The next step is to create an Overlay MAG so that SAP IDoc INVOIC will be mapped to the trading partner-related UN/EDIFACT INVOIC. In this MAG, you will now incorporate several different kinds of mapping functions according to various methods and at varying levels of complexity. Therefore, you should make the Overlay MAG for the third BTA (Business Transaction Activity) **03.) Invoice - Outbound** according to the following steps:
- (a) Open **Design → Mapping Guidelines** to view the MAG list and click **Create → Overlay MAG** to open the wizard.
- (b) For the base MAG, search for: `03.) #IN260-BASE# - SAP IDOC INVOIC.INVOIC02 -to- UN/EDIFACT D.96A INVOIC` and select this base MAG to move to the next step.
- (c) Keep the **Base Source MIG** (`03.) IN260 BestRun - SAP IDOC INVOIC.INVOIC02 for Customer EDI - Source`) unchanged (idoc structure for all partners).
- (d) In **Target MIG**, switch to **Use Compatible MIG** and search as well as (e) select the MIG you created previously: `03.) IN260-UserXX - UN/EDIFACT D.96A INVOIC - Target`.
- (f) In step 4, enter the name of the Overlay MAG:
  `03.) IN260-UserXX - SAP IDoc INVOIC.INVOIC02 -to- UN/EDIFACT D.96A INVOIC`
- (g) Click on the button **Create**.

![IN260 Figure 07.02](assets/IN260_07.02.png)

## Step 03 - Create Global Parameters in MAG  
You need to provide additional parameters to retrieve invoice-specific data that is configured in the Trading Partner Profile. Therefore, do the following steps:
- (a) Go to the Invoice MAG, edit mode, to the tab **Global Parameters**.
- (b) Click on the **Create** button.
- (c) Enter in the pop-up window **Create New Global Parameter** the name: `UserXX_AllowanceChargeInformation`.
- (d) Give a meaningful summary such as: `Allowance Charge Information`
- (e) And set a default value: `Discount:10` ***Remark:*** The colon is necessary.
- (f) Click on the **Create** button, so
- (g) That you can see the new entry in the parameter list.
- (h) Repeat these activities with the following:
  - Name: `UserXX_ValueAddedTaxPercent`
  - Summary: `Value Added Tax Percent`
  - Default: `19`

![IN260 Figure 07.03](assets/IN260_07.03.png)

## Step 04 - Insert a mapping function where the source node is a trigger
Depending on the cardinality of the to-be-mapped target nodes and their ancestors, it is required to enforce the creation of the target value, especially if these are values defined as constants or will be created by functions at the target structure side. For this case, it is necessary to develop an XSLT/XPath snippet that transforms a colon-separated string from the global parameter `$UserXX_AllowanceChargeInformation` into a human-readable sentence that describes a percentage-based allowance or charge, which should be written into the target leaf node `4440`. The following steps are required:
- (a) Drag and drop a mapping element:
  - From: `/INVOIC02/E1EDK01/BELNR` (IDOC document number)
  - To: `/Interchange/INVOIC/FTX [4451 = ALC]/C108/4440` (Free text)
- (b) In the opened tab **Function**, enter the following XSLT/XPath code:

  ``` XML
  <xsl:variable name="vArray" select="tokenize($UserXX_AllowanceChargeInformation, ':')"/>
  <xsl:variable name="vLabel" select="lower-case($vArray[1])"/>
  <xsl:variable name="vPercent" select="format-number(xs:decimal($vArray[2]), '0.00')"/>
  <xsl:sequence select="concat('The ', $vLabel, ' is ', $vPercent, '%')"/>
  ```
  The expected input format: [Label]:[Percent] → Output: "The [label] (lowercase) is [percent] (two decimals)%".
  
- (c) Click on the button **Validate** to validate the correctness of the syntax.
- (d) Now simulate with the test source file  that is provided in the folder `03.) Invoice - Outbound.
- (e) You should see a result with the readable output, such as `The discount is 10%`.

![IN260 Figure 07.04](assets/IN260_07.04.png)

Source - IN260-IDOC-INVOIC.INVOIC02.xml

## Step 05 - Add Condition at Leaf Node Mapping
You can also define a specific condition for the generation of a target leaf node. The following steps can make this:
- (a) Drag and drop a mapping element:
  - From: `/INVOIC02/E1EDKA1 [PARVW = AG]/LAND1` (Country key)
  - To: `/Interchange/INVOIC/SG6 [5283 = 7]/TAX/C243/5278` (Duty/tax/fee rate)
- (b) Go to tab **Mapping Linst** and,
- (c) Enable the **Condition**-
- (d) You will see a new tab **Condition**, which you should open, and
- (e) Enter the condition code `boolean($nodes_in/LAND1 = 'DE')`
- (f) Open the tab **Function** and 
- (g) Enter the specific processing function:
  ``` XML
  <xsl:sequence select="$UserXX_ValueAddedTaxPercent"/>`
  ``` 

![IN260 Figure 07.05](assets/IN260_07.05.png)

## Step 06 - Add Condition at Group Node Mapping
You can also create conditions at the group node level, which will then create whole groups based on these conditions. For this purpose, follow the following steps:
- (a) Drag and drop a mapping element:
  - From: `INVOIC02/E1EDK01` (Header general data)
  - To: `/Interchange/INVOIC/SG15 [5463 = A | C]` (Allowances and Charges)
- (b) Enter a second mapping line from `/INVOIC02/E1EDK01/BELNR` (IDOC document number) to the same target group node.
- (c) Open the tab **Condition**
- (d) And enter the following condition code:
  ``` XML
  boolean($nodes_in/*) and $UserXX_AllowanceChargeInformation != ''
  ``` 
![IN260 Figure 07.06](assets/IN260_07.06.png)

## Step 07 - Add a Complex Function at the Target Side
You can also add functions to target the leaf node. These will be processed if other mapping elements create ancestors. You can add a function on the target side by following these steps:
- (a) Go to the target node `/Interchange/INVOIC/SG15 [5463 = A | C]/ALC/5463` 
(Allowance or charge), Open the action menu and select **Set Function**.
- (b) Inset the following mapping function into the foreseen field:
  ``` XML
  <xsl:variable name="vTag" select="local-name($nodes_in/*[position() = last()])"/>
  <xsl:variable name="vArray" select="tokenize($nodes_in/*[2], ':')"/>
  <xsl:variable name="vLabel" select="lower-case($vArray[1])"/>
  <xsl:variable name="vValue" select="format-number(number($vArray[2]),'##.00')"/>
  <xsl:variable name="vQual" select="if($vLabel = 'discount') then 'A:1' else 'C:2'"/>
  <xsl:value-of select="
    if($vTag = 'AlcQual') then tokenize($vQual, ':')[1] else 
    if($vTag = 'Descr') then $vLabel else 
    if($vTag = 'PctQual') then tokenize($vQual, ':')[2] else 
    if($vTag = 'Percent') then $vValue else ()"/>
  ```
***Remark:** This function extracts and formats data from a parameter and outputs a value based on the tag name that is given by the function parameter (`$nodes_in/[AlcQual|Descr|PctQual|Percent]`).

 ![IN260 Figure 07.07](assets/IN260_07.07.png)

## Step 08 - Add Function Parameters
This mapping function in step 07 requires further instructions so that it returns the specific discount or charge values according to the setting (`AlcQual`, `Descr`, `PctQual`, and `Percent`). The if... then... else statements will return the appropriate data accordingly. For this purpose, a **Function Parameter** must be set according to the following steps:
- (a) Click in the **Function Definition** panel on the button **Add new function parameter**.
- (b) Enter in the pop-up window **Create New Function Parameter** the value: `AlcQual`.
- (c) Click on the **Create** button.
- (d) You'll now see the new function parameter in the panel, but this function parameter must be assigned to a global parameter by clicking on **Choose a Global Parameter**.
- (e) You will get a list of the global parameters where you should select `UserXX_AllowanceChargeInformation`.
- (f) You will then see the assigned parameter name in the panel.

![IN260 Figure 07.08](assets/IN260_07.08.png)


## Step 09 - Create Shared Mapping Function Code
You can make this mapping function shareable by following these steps:
- (a) Click in the **Mapping Definition** panel on the button **Share**
- (b) In the new pop-up window, enter the function name, such as `fx_AllowanceChargeOutput`.
- (c) Click on the **Create** button so that you can see 
- (d) This function is available as shared code, and it is assigned to this mapping element.
  
![IN260 Figure 07.09](assets/IN260_07.09.png)

## Step 10 - Reuse Shared Mapping Function Code
You can assign this shared function to different mapping elements, like:
- (a) At: /Interchange/INVOIC/SG15 [5463 = A | C]/ALC/5463 (Allowance or charge)
***Remark:*** Already made.
- (b) Create a mapping element, 
  - From: `/INVOIC02/E1EDK01/BELNR` (IDOC document number)
  - To: `/Interchange/INVOIC/SG15 [5463 = A | C]/ALC/C552/5189` (Charge/allowance description, coded)
  - Add the function parameter: `$nodes_in/Descr` with the association to the global parameter `UserXX_AllowanceChargeInformation`
  - Assign mapping function: `fx_AllowanceChargeOutput`
- (c) Create a mapping element, 
  - At: `/Interchange/INVOIC/SG15 [5463 = A | C]/SG18 [5245 = 1 | 2]/PCD/C501/5245` (Percentage qualifier)
   - Add the function parameter: `$nodes_in/PctQual` with the association to the global parameter `UserXX_AllowanceChargeInformation`
  - Assign mapping function: `fx_AllowanceChargeOutput`
- (b) Create a mapping element, 
  - From: `/INVOIC02/E1EDK01/BELNR` (IDOC document number)
  - To: `/Interchange/INVOIC/SG15 [5463 = A | C]/SG18 [5245 = 1 | 2]/PCD/C501/5482` (Percentage)
  - Add the function parameter: `$nodes_in/Percent` with the association to the global parameter `UserXX_AllowanceChargeInformation`
  - Assign mapping function: `fx_AllowanceChargeOutput`
- (e) Do a simulation, and you will see the computed results at the target side.

![IN260 Figure 07.10](assets/IN260_07.10.png)

## Step 11 - Shared Mapping Function considering Properties
The properties of the target nodes are provided as parameters, which can be incorporated into a mapping function, such as:
- (a) Create a mapping element, 
  - From: `/INVOIC02/E1EDP01/E1EDP19 [QUALF = 001]/KTEXT` (IDOC short text)
  - To: `/Interchange/INVOIC/SG25/IMD [7077 = B]/C273/7009` (Item description identification)
  ***Remark:*** This mapping element does not cover the properties, but it is necessary for completion.
- (b) Create a mapping element, 
  - From: `/INVOIC02/E1EDP01/E1EDPT1 [TDID = 004]/E1EDPT2/TDLINE` (Text line)
  - To: `/Interchange/INVOIC/SG25/IMD [7077 = B]/C273/7008` (Item description)
- (c) Insert the following mapping function code:
  ``` XML
  <xsl:variable name="vIn" select="$nodes_in/*[1]"/>
  <xsl:variable name="vPosition" select="xs:integer(substring-after(local-name($nodes_in/*[1]), '_'))"/>
  <xsl:variable name="vStart" select="($target_tag_min_length * ($target_tag_max_length * ($vPosition - 1))) + 1"/>
  <xsl:variable name="vLength" select="$target_tag_max_length"/>
  <xsl:sequence select="normalize-space(substring($vIn, $vStart, $vLength))"/>
  ```
  ***Remark:*** The `$target_tag_min_length` is the given parameter for the property max length, as it is defined in the target MIG.

- (d) Click on the button **Share* for setting it to shared function code and enter the name `fx_ItemDescription`.
- (e) Change the source node parameter from: `$nodes_in/TDLINE` to `$nodes_in/
TDLINE_1`
- (f) Create a mapping element, 
  - From: `/INVOIC02/E1EDP01/E1EDPT1 [TDID = 004]/E1EDPT2/TDLINE` (Text line)
  - To: `/Interchange/INVOIC/SG25/IMD [7077 = B]/C273/7008 [2]` (Item description)
  - Change the source node parameter from: `$nodes_in/TDLINE` to `$nodes_in/
TDLINE_2`
- (g) Select for the second mapping element the shared mapping function: `fx_ItemDescription`.
- (g) Do a simulation
- (h) You see the behaviour of this function. 

![IN260 Figure 07.11](assets/IN260_07.11.png)

## Step 12 - Shared Mapping Function with Calculations
You can also build more complex generic functions with different kinds of calculations, which the different target leaf nodes can take differently. This is possible by the following steps:
- (a) Create a mapping element, 
  - From: `/INVOIC02/E1EDP01/E1EDP01/MENGE` (Quantity)
    And: `/INVOIC02/E1EDP01/E1EDP01/VPREI` (Price (net))
  - To: `/Interchange/INVOIC/SG25/SG28 [5125 = AAA]/PRI/C509/5118` (Price)
  - Add the function parameter: `$nodes_in/Net` with the association to the global parameter `UserXX_AllowanceChargeInformation`
- (b) Insert the following mapping function code:
  ``` XML
  <xsl:variable name="vTag" select="local-name($nodes_in/*[position() = last()])"/>
  <xsl:variable name="vRateArray" select="tokenize($nodes_in/*[position() = last()], ':')"/>
  <xsl:variable name="vTaxRate" select="1 + xs:integer($UserXX_ValueAddedTaxPercent) div 100"/>
  <xsl:variable name="vRate" select="if($vRateArray[1] = 'Discount') then xs:integer($vRateArray[2]) * -1 else xs:integer($vRateArray[2])"/>
  <xsl:variable name="vNet" select="$nodes_in/MENGE * $nodes_in/VPREI * (1 + ($vRate div 100))"/>
  <xsl:variable name="vGross" select="$vNet * $vTaxRate"/>
  <xsl:variable name="vResult" select="
    if($vTag = 'Net') then $vNet else
    if($vTag = 'Gross') then $vGross else
    if($vTag = 'Tax') then $vGross - $vNet else ()"/>
  <xsl:sequence select="format-number($vResult, '0.00')"/>
  ```
- (c) Click on the button **Share* for setting it to shared function code and enter the name `fx_LineItemPrices`.
- (d) Create a mapping element, 
  - From: `/INVOIC02/E1EDP01/E1EDP01/MENGE` (Quantity)
    And: `/INVOIC02/E1EDP01/E1EDP01/VPREI` (Price (net))
  - To: `/Interchange/INVOIC/SG25/SG28 [5125 = AAB]/PRI/C509/5118` (Price)
  - Add the function parameter: `$nodes_in/Gross` with the association to the global parameter `UserXX_AllowanceChargeInformation`
- (e) Select for the second mapping element the shared mapping function: `fx_LineItemPrices`.
- (f) Create a mapping element, 
  - From: `/INVOIC02/E1EDP01/E1EDP01/VPREI` (Price (net))
    To: `/Interchange/INVOIC/SG25/SG33 [5283 = 7]/TAX/C243/5278` (Duty/tax/fee rate)
    Function: `<xsl:sequence select="$UserXX_ValueAddedTaxPercent"/>`
    ***Remark:** This mapping element is just for completion
- (g) Create a mapping element, 
  - From: `/INVOIC02/E1EDP01/E1EDP01/MENGE` (Quantity)
    And: `/INVOIC02/E1EDP01/E1EDP01/VPREI` (Price (net))
  - To: `/Interchange/INVOIC/SG25/SG33 [5283 = 7]/MOA [5025 = 124]/C516/5004` (Monetary Amount)
  - Add the function parameter: `$nodes_in/Tax` with the association to the global parameter `UserXX_AllowanceChargeInformation`
  - Select for the second mapping element the shared mapping function: `fx_LineItemPrices`.
- (h) Do a simulation
- (i) You see the behaviour of this function. 

![IN260 Figure 07.12](assets/IN260_07.12.png)

## Step 13 - Shared Mapping Function with Loops
You can also do a summary of repeated line items via the following steps:
- (a) Create a mapping element, 
  - From: `/INVOIC02/E1EDP01/E1EDP01/MENGE` (Quantity)
    And: `/INVOIC02/E1EDP01/E1EDP01/VPREI` (Price (net))
  - To: `	
/Interchange/INVOIC/SG48 [5025 = 124]/MOA/C516/5004` (Monetary Amount)
  - Add the function parameter: `$nodes_in/Tax` with the association to the global parameter `UserXX_AllowanceChargeInformation`
- (b) Insert the following mapping function code:
  ``` XML
  <xsl:variable name="vTag" select="local-name($nodes_in/*[position() = last()])"/>
  <xsl:variable name="vRateArray" select="tokenize($nodes_in/*[position() = last()], ':')"/>
  <xsl:variable name="vTaxRate" select="1 + xs:integer($UserXX_ValueAddedTaxPercent) div 100"/>
  <xsl:variable name="vRate" select="if($vRateArray[1] = 'Discount') then xs:integer($vRateArray[2]) * -1 else xs:integer($vRateArray[2])"/>
  <xsl:variable name="vNet" select="sum(for $n in 1 to 10 return $nodes_in/MENGE[$n] * $nodes_in/VPREI[$n]) * (1 + ($vRate div 100))"/>
  <xsl:variable name="vGross" select="$vNet * $vTaxRate"/>
  <xsl:variable name="vTax" select="$vGross - $vNet"/>
  <xsl:variable name="vResult" select="
    if($vTag = 'Net') then $vNet else
    if($vTag = 'Gross') then $vGross else
    if($vTag = 'Tax') then $vGross - $vNet else ()"/>
  <xsl:sequence select="format-number($vResult, '0.00')"/>
- (c) Click on the button **Share* for setting it to shared function code and enter the name `fx_TotalPrices`.
- (f) Create a mapping element, 
  - From: `/INVOIC02/E1EDK01/CURCY` (Currency)
    To: `/Interchange/INVOIC/SG48 [5025 = 124]/MOA/C516/6345` (Currency, coded)
    ***Remark:** This mapping element is just for completion
- (a) Create a mapping element, 
  - From: `/INVOIC02/E1EDP01/E1EDP01/MENGE` (Quantity)
    And: `/INVOIC02/E1EDP01/E1EDP01/VPREI` (Price (net))
  - To: `	
/Interchange/INVOIC/SG48 [5025 = 77]/MOA/C516/5004` (Monetary Amount)
  - Add the function parameter: `$nodes_in/Tax` with the association to the global parameter `UserXX_AllowanceChargeInformation
- (e) Select for the second mapping element the shared mapping function: `fx_TotalPrices`.
- (f) Create a mapping element, 
  - From: `/INVOIC02/E1EDK01/CURCY` (Currency)
    To: `/Interchange/INVOIC/SG48 [5025 = 77]/MOA/C516/6345` (Currency, coded)
    ***Remark:** This mapping element is just for completion
- (h) Do a simulation
- (i) You see the behaviour of this function. 

![IN260 Figure 07.13](assets/IN260_07.13.png)

## Step 14 - Add Parameters in Trading Partner Profile
You now need to set the trading partner-related parameters to specify the charges or allowances, as well as the percentage of tax required in the mapping. Create the parameters as follows:

- (a) In your Trading Partner Profile, 
- (b) Go to the **Parameters** tab.
- (c) Click **Create**; a pop-up window will open.
- (d) In **Parameter Key**, enter: `UserXX_AllowanceChargeInformation`.
- (e) In **Value**, enter: `Discount:10`.
- (f) Click **Save**.
- (g) Repeat these steps for the:
  - **Parameter Key:** `UserXX_ValueAddedTaxPercent`
  - **Value:** `19`

![IN260 Figure 07.14](assets/IN260_07.14.png)

## Step 15 - Update the Business Transaction Activity: 03.) Invoice - Outbound
You have to add the Customized Post-Processing to the BTA **03.) Invoice – Outbound** by the following steps: 
- (a) Go to your TPA and change it into edit mode.
- (b) Select like in the Exercises before in the business transaction activity **03.) Invoice - Outbound** the step **Mapping**
  - Change the given MAG with your MAG: `01.b) IN260-UserXX - SAP IDOC INVOIC.INVOIC02 -to- UN/EDIFACT D.96A INVOIC` and (d) click on **Save**.
- (c) Click on **Add Parameters** and select **TP Parameters** for assigning the allowances/charges parameters to the Business Transaction Activity-
- (d) In the pop-up window, select the **Trading Partner Parameters**:
  - `UserXX_AllowanceChargeInformation`
  - `UserXX_ValueAddedTaxPercent`
- (e) Click on the **Save** button so 
- (f) That you see the parameters within the Business Transaction Activity.
- (g) Click **Save** for saving the whole TPA.
- (h) Click on the **Update** button;
- (i) Select `03.) Invoice - Outbound` in the dialog and (j) click **Update**.

![IN260 Figure 07.15](assets/IN260_07.15.png)

## Step 16 - Do final test
Do the same test run as described in the Exercises before, but with the given file `Source - IN260-IDOC-INVOIC.INVOIC02.xml ' in the folder `03.) Invoice - Outbound` and compare the results with the expected payloads. If you don't see any mismatches, then all the mapping functions you made in your Overlay MAG seem to be correct.

**Remark:** If you did all the Exercises, then congratulations..

![IN260 Figure 07.16](assets/IN260_07.16.png)

## Summary
In this exercise, you explored XPath 2.0 functions alongside XSLT constructs, such as `xsl: variable` and `xsl: sequence`. These tools allow you to create dynamic transformations by combining XPath expressions with XSLT mapping elements. Mastering these techniques will enable you to build robust and flexible XML processing solutions.

Please give us feedback on this session **IN260** by scanning the QR-Code:

 ![QR Code](../pictures/survey_QR.png)

