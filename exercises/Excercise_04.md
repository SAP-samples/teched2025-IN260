# Excercise 4: Do first tests with activated TPA and turn to Base/Overlay MIGs/MAGs
## Step 1 - Test 01. a) Sales Order Request - Inbound
After activation of the TPA, go to the test tool and proceed with the test of the first Business Transaction Activity
- (a) Select the Get Request: **01. a) Sales Order Request - Inbound**
- (b) Open the tab **Body** (if this is not open yet)
- (c) Change the sender ID with one these one, which you entered in Excercise 2 - Step 8
- (d) Subsitute the `XX` in **UserXX** with your user id.
- (e) Click on **Save** button.
- (f) Run this test.
- (g) After a short while, you'll get an error message.

![IN260 Figure 04.01](assets/IN260_04.01.png)

## Step 2 - Analyze the error
You have to check now, why there is an error. For this purpose, you should open the B2B Monitor in the SAP Cloud Integration in where you should get the further details for this error. Do the following steps for it:
- (a) Open in the navigation panel the **Monitor --> B2B Scenarios**
- (b) Select in the overview list of **Interchanges** this entry, which belongs to your test. 
  ***Remark:*** You can use the filter on top for refining the list so that you can find your entry much easier.
- (c) Check the error in the tab **Error Information**
- (d) This error tells you that ther is somehow a interchange syntax error.
  ***Remark:*** The reason that you got just a kind of error is that the syntax validation in your **TPA --> Business Transaction Activity 01.a) Sales Order Request** is enabled. You can check this, if you go to your TPA and click on the sender **Interchange** step in this business transaction activity. A pop-up window will give you the details of the configuration.
- (e) In order to get the details of the error, click on the tab **Interchange Payload**
- (f) You'll see in this section the details of the syntax error. This error tells to you that their either some segments missing or that other segments are too much. 
  ***Remark***: This means that the Source MIG given by the prepackaged B2B Integration Content does not match to this payload. It is now recommended to update this MIG accordingly and use it as Overlay MIG.

![IN260 Figure 04.02](assets/IN260_04.02.png)

## Step 3 - 
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

![IN260 Figure 04.03](assets/IN260_04.03.png)

## Step 4 - 
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

![IN260 Figure 04.04](assets/IN260_04.04.png)

## Step 5 - 
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

![IN260 Figure 04.05](assets/IN260_05.05.png)

## Step 6 - 
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

![IN260 Figure 04.06](assets/IN260_04.06.png)

## Step 7 - 
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

![IN260 Figure 04.07](assets/IN260_04.07.png)

## Step 8 - 
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
  
![IN260 Figure 04.08](assets/IN260_04.08.png)

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

![IN260 Figure 04.09](assets/IN260_04.09.png)

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

![IN260 Figure 04.10](assets/IN260_04.10.png)

## Step 11 - 
01.a) [Trading Partner Name] - UN/EDIFACT D.96A ORDERS -to- SAP IDOC ORDERS.ORDERS05
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

![IN260 Figure 04.11](assets/IN260_04.11.png)

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

![IN260 Figure 04.12](assets/IN260_04.12.png)

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

![IN260 Figure 04.13](assets/IN260_04.13.png)

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

![IN260 Figure 04.14](assets/IN260_04.14.png)

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

![IN260 Figure 04.15](assets/IN260_04.15.png)

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

![IN260 Figure 04.16](assets/IN260_04.16.png)

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

![IN260 Figure 04.17](assets/IN260_04.17.png)

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

![IN260 Figure 04.18](assets/IN260_04.18.png)

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

![IN260 Figure 04.19](assets/IN260_04.19.png)

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

![IN260 Figure 04.20](assets/IN260_04.20.png)