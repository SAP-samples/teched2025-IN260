# Excercise 3: -Creating a TPA based on the TPA template
## Step 1 - Open the TPA Template
First, check if all required (activity) parameters are correctly set in the uploaded Trading Partner Agreement Template (TPA-Template) and make any necessary changes, if required. For this reason:
- (a) Go in the Trading Partner Management system to the tab **Agreement Templates**
- (b) And open the template **[B2B Integration Factory] - Order to Cash B2B Scenario for SAP IDoc with UN/EDIFACT D.96A – Template**

![IN260 Figure 03.01](assets/IN260_03.01.png)

## Step 2 - Check and may update the TPA-Template
Now, you should review the required (activity) parameters in each Business Transaction. If these are not available, add the required (activity) parameters as described in step 3. You should check if the following (activity) parameters are set:
- (a) in tab **B2B Scenarios**
- (b) In Business Transaction: **01.) Sales Order Request/Response**
  
| Activity | Role | Data Source | Private Key | Private Value |
| --- | --- | --- | --- | --- |
| Inbound | RECEIVER | [Company Name] | SAP_EDI_REC_Receiver_System_ID | SAPDS2 |
| Inbound | RECEIVER | [Company Name] | SAP_EDI_REC_Receiver_Partner_Type | LS |
| Inbound | RECEIVER | [Company Name] | SAP_EDI_REC_Receiver_Partner_Function | MA |
| Inbound | SENDER | | SAP_EDI_REC_Sender_System_ID | *Derived from TPP* |
| Inbound | SENDER | | SAP_EDI_REC_Sender_Partner_Function | *Derived from TPP* |
| Inbound | SENDER | | SAP_EDI_REC_Sender_Partner_Type | *Derived from TPP* |
| Outbound | RECEIVER | SAP_EDI_REC_Receiver_Routing_Address | *Derived from TPP* |
| Outbound | SENDER | [Company Name] | SAP_EDI_REC_Sender_Routing_Address | FromCI |

- (c) In Business Transaction: **02.) Delivery Notification – Outbound**
  
| Activity | Role | Data Source | Private Key | Private Value |
| --- | --- | --- | --- | --- |
| Outbound | RECEIVER | | SAP_EDI_REC_Receiver_Routing_Address | *Derived from TPP* |
| Outbound | SENDER | [Company Name] | SAP_EDI_REC_Sender_Routing_Address | FromCI |

- (d) In Business Transaction: **03.) Invoice - Outbound**
  
| Activity | Role | Data Source | Private Key | Private Value |
| --- | --- | --- | --- | --- |
| Outbound | RECEIVER | | SAP_EDI_REC_Receiver_Routing_Address | *Derived from TPP* |
| Outbound | SENDER | [Company Name] | SAP_EDI_REC_Sender_Routing_Address | FromCI |

- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.02](assets/IN260_03.02.png)

## Step 3 - Add (Activity) Parameters in TPA Template
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.03](assets/IN260_03.03.png)

## Step 4 - Create a TPA via Copy of a TPA Template
In order to create in the Trading Partner Management a new TPA (Trading Partner Agreement) via the copy from a TPA template function, do the following steps:
- (a) Open the tab “Agreements”
- (a) Click on the button “Create”, a new popup will open
- (c) Select the TPA template
- (d) Choose “Next”
- (e)Select “Copy from Template”
- (f) Make sure to select the transactions all transactions
- (g) Select your Trading Partner from the drop-down list
- (h) Click on “Open Draft”

***General Note:*** It is not always necessary to select all transactions. This depends on the trading partner. Choose only the transactions that are relevant for your trading partner.

![IN260 Figure 03.04](assets/IN260_03.04.png)

## Step 5 - Check and update the Overview of the TPA
You are in the overview screen of your agreement
- (a) Change the name and the description of your agreement. Make sure to replace XX with your UserID and Trading Partner Name. Scroll down to the section “Trading Partner Details”
- (b) Copy the response and enter it in the “Description” field.
- (c) Check if the same aliases are defined in your Trading Partner Profile. 
- (d) Click on the “Save” button

![IN260 Figure 03.05](assets/IN260_05.05.png)

## Step 6 - Check, if all set in TPA
Stay in your newly created agreement and switch to the “B2B scenarios” tab.
- (a) Check if the same aliases are used in your Trading Partner system.
- (b) Check if the values that have been empty in the agreement template are filled with your Trading Partner parameters.
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.06](assets/IN260_03.06.png)

## Step 7 - Activate the TPA
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.07](assets/IN260_03.07.png)

## Step 8 - Prepare the source files
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)
  
![IN260 Figure 03.08](assets/IN260_03.08.png)

## Step 9 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.09](assets/IN260_03.09.png)

## Step 10 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.10](assets/IN260_03.10.png)

## Step 11 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.11](assets/IN260_03.11.png)

## Step 12 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.12](assets/IN260_03.12.png)

## Step 13 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.13](assets/IN260_03.13.png)

## Step 14 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.14](assets/IN260_03.14.png)

## Step 15 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.15](assets/IN260_03.15.png)

## Step 16 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.16](assets/IN260_03.16.png)

## Step 17 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.17](assets/IN260_03.17.png)

## Step 18 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.18](assets/IN260_03.18.png)

## Step 19 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.19](assets/IN260_03.19.png)

## Step 20 - 
- (a)
- (b)
- (c)
- (d)
- (e)
- (f)
- (g)
- (h)
- (i)
- (j)

![IN260 Figure 03.20](assets/IN260_03.20.png)