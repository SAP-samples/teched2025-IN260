# Exercise 7: Finalize the Business Transaction Activity Invoice **03.) Invoice – Outbound**
In this exercise, you will configure and enhance the Business Transaction Activity 03.) Invoice – Outbound using the SAP Integration Suite. The objective is to define trading partner-specific parameters, use them in mapping functions in a Mapping Guideline (MAG) and create further complex mapping functions, which can be also used.

### What you will do:
- Add custom parameters to the Trading Partner Profile.
- Add further complex mapping functions which do the following:
  - Consider the custom parameters 
  - Consider the given properties at the target side
- Make the mapping functions reusable within MAG.

## Step 01 - Copy Trading Partner MIG
Similar like in excercise 06, you should now create a copy of an already prepared Trading Partner MIG, which you need for the creation of the invoice mapping. For this purpose, do the following steps:
- (a) Go in the navigation pane to **Design --> Message Implementation Guidelines** and 
- (b) Search for the prepared **Trading Partner MIG**: `03.) #IN260-OVERLAY# - UN/EDIFACT D.96A INVOIC - Target`
    ***Caution:*** !!! Please never delete or modify this prepared Trading Partner MIG.
- (c) Click on the **Actions → Copy** menu item.
- (d) In the new window of the copied Trading Partner MIG, enable edit mode and click on tab **Overview** enter your name of the MIG, which is `03.) IN260-UserXX - UN/EDIFACT D.96A INVOIC - Target` and (e) click on the **Save** button.

![IN260 Figure 07.01](assets/IN260_07.01.png)
 
## Step 02 - Create the Overlay Mapping Guideline (MAG)
The nex step is now to creat an Overlay MAG so SAP IDoc INVOIC will be mapped to the trading partner related UN/EDIFACT INVOIC. In this MAG you will now incorporate a number of different kind of mapping functions according different ways and following different kind of complexity.Therefore, you should make the Overlay MAG for the third BTA (Business Transaction Activity) **03.) Invoice - Outbound** according to the following steps:
- (a) Open **Design → Mapping Guidelines** to view the MAG list and click **Create → Overlay MAG** to open the wizard.
- (b) For the base MAG, search for: `03.) #IN260-BASE# - SAP IDOC INVOIC.INVOIC02 -to- UN/EDIFACT D.96A INVOIC` and select this base MAG to move to the next step.
- (c) Keep the **Base Source MIG** (`03.) IN260 BestRun - SAP IDOC INVOIC.INVOIC02 for Customer EDI - Source`) unchanged (idoc structure for all partners).
- (d) In **Target MIG**, switch to **Use Compatible MIG** and search as well as (e) select the MIG you created previously: `03.) IN260-UserXX - UN/EDIFACT D.96A INVOIC - Target`.
- (f) In step 4, enter the name of the Overlay MAG:
  `03.) IN260-UserXX - SAP IDoc INVOIC.INVOIC02 -to- UN/EDIFACT D.96A INVOIC`
- (g) Click on button **Create**.

![IN260 Figure 07.02](assets/IN260_07.02.png)

## Step 03 - Assign Global Parameters  
Now, associate the parameters created in Step 1 with the outbound invoice transaction:
- (a) Within the newly copied TPA, open the **B2B Scenarios** section to view the configured transactions.
- (b) Enable editing mode to modify the scenario configuration.
- (b) Locate and open the transaction labeled **03.) Invoice – Outbound**. 
- (c) Extend the transaction by selecting the option to **Add Parameters** and choosing **Extend** from TP, which allows you to inherit parameters from the trading partner profile.
- (d) Select the relevant parameters from the list and confirm the selection.
- (e) Save the updated transaction configuration within the TPA. 
- (f) Apply the changes by selecting the **Update** action twice to ensure all modifications are committed. 

UserXX_AllowanceChargeInformation - Allowance Charge Information
UserXX_ValueAddecTaxPercent

![IN260 Figure 07.03](assets/IN260_07.03.png)

## Step 04 - Insert a mapping function in where the source node is a trigger
Innsert a XSLT/XPath snippet that transforms a colon-separated string from gloabl parameter $UserXX_AllowanceChargeInformation) into a human-readable sentence that describes a percentage-based allowance or charge

```XML
<xsl:variable name="vArray" select="tokenize($UserXX_AllowanceChargeInformation, ':')"/>
<xsl:variable name="vLabel" select="lower-case($vArray[1])"/>
<xsl:variable name="vPercent" select="format-number(xs:decimal($vArray[2]), '0.00')"/>
<xsl:sequence select="concat('The ', $vLabel, ' is ', $vPercent, '%')"/>
```
Expected input format: <Label>:<Percent> → Output: "The <label (lowercase)> is <percent (two decimals)>%".
This works alongside the inserted mapping element where the presence/trigger may be associated with NVOIC02/E1EDK01/BELNR (IDOC document number), but the actual text value originates from $UserXX_AllowanceChargeInformation.

![IN260 Figure 07.04](assets/IN260_07.04.png)

Source - IN260-IDOC-INVOIC.INVOIC02.xml

## Step 05 - Add Condition at Leaf Node Mapping

`<xsl:sequence select="$UserXX_ValueAddedTaxPercent"/>`
![IN260 Figure 07.05](assets/IN260_07.05.png)

## Step 06 - Add Condition at Group Node Mapping

`boolean($nodes_in/*) and $UserXX_AllowanceChargeInformation != ''`

![IN260 Figure 07.06](assets/IN260_07.06.png)

## Step 07 - Add a Function at Target Side

```XML
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

![IN260 Figure 07.07](assets/IN260_07.07.png)

## Step 08 - Add Function Parameters


![IN260 Figure 07.08](assets/IN260_07.08.png)


## Step 09 - Create Shared Mapping Function Code

![IN260 Figure 07.09](assets/IN260_07.09.png)

## Step 10 - Reuse Shared Mapping Function Code

![IN260 Figure 07.10](assets/IN260_07.10.png)

## Step 11 - Shared Mapping Function considering Properties

![IN260 Figure 07.11](assets/IN260_07.11.png)

## Step 12 - Shared Mapping Function with Calculations

```XML
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

`<xsl:sequence select="$UserXX_ValueAddedTaxPercent"/>`

![IN260 Figure 07.12](assets/IN260_07.12.png)

## Step 13 - Shared Mapping Function with Loops

```XML
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
```

`<xsl:sequence select="$UserXX_ValueAddedTaxPercent"/>`

![IN260 Figure 07.13](assets/IN260_07.13.png)

## Step 14 - Add Parameters in Trading Partner Profile
Finally, link the updated MAG to the invoice transaction in your Trading Partner Agreement:
- (a)	Return to the Trading Partner Agreement and open the `03.) Invoice – Outbound transaction`.
- (b)	Enable editing mode to modify the transaction settings.
- (c)   In the **Mapping** section, open the Mapping Guideline configuration.
- (d)   Search for the updated MAG created in Step 4 and select it.
- (e)   Save the transaction and perform a final Update of the TPA to ensure all changes are applied.

![IN260 Figure 07.14](assets/IN260_07.14.png)

## Step 15 - Update the Business Transaction Activity: 03.) Invoice - Outbound

![IN260 Figure 07.15](assets/IN260_07.15.png)
![IN260 Figure 07.16](assets/IN260_07.16.png)

## Step 16 - Do final test

![IN260 Figure 07.06](assets/IN260_07.05.png)



Please give us feedback to this session **IN260** by scanning the QR-Code:

 ![QR Code](../pictures/survey_QR.png)
