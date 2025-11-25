# Getting Started

The number you find in front of you has three digits like **User037**. In this exercise all numbers are two digits. Please ignore the first **0** and use then e.g. **User37** .

Before you start the exercises, complete the following steps:
1. Download the test data file: [Testdata.zip](files/Testdata.zip).
2. Extract the ZIP file (for example, to your desktop).
3. Run **modify-content.bat** and enter your participant number when prompted.
4. Open the folder in which you have extracted the **Testdata.zip**
5. Double click **_teched2025-IN260-Testdata.code-workspace_**. This will open visual Studio Code with files you need in Exercise 3.
    > **Note:** Kindly ignore and skip the setup step in Visual Studio if prompted
7. Open **Bruno** app from the desktop.
8. Start Bruno on your laptop to import the necessary data.
9. In Bruno, navigate to **Open Collection -> Extracted test data folder -> "Bruno Collection" -> "in-260---order-to-cash---sap-idoc-with-un-edifact”** and click on **"Select Folder"** to open the collection.
10. Open the [SAP Integration Suite Tenant](https://workshop-eu-03b.integrationsuite-cpi035.cfapps.eu20-001.hana.ondemand.com/shell/design) (hint: hold *Ctrl* while clicking the link to open it in a new tab).
11. For login, enter Username as **“UserXX”** (replace **XX** with the assigned participant number on your desk). Example **User11**. Enter the password that have already shared by the speakers.
12. Create a new *Integration Package* named **“IN260-UserXX”** (replace **XX** with the assigned participant number on your desk) and save the package.
13. Navigate to the package **“TechEd 2025 - IN260 - Post Processing Flows”** and open the **Artifacts** tab.
14. Copy the **"Post-Processing - TEMPLATE - 02 - Delivery Notification - Outbound UN-EDIFACT"** iFlow using the **Actions (“…”)** menu.
    > **Note:** Rename it by replacing suffix **“copy”** with **“UserXX”** (replace **XX** with the assigned participant number on your desk). Set the destination **Package** to the one you created in step 1
15. Navigate to the copied iFlow and configure it by setting the **ID** to your number i.e. **XX** (replace **XX** with the assigned participant number on your desk). Then **Deploy** the **iFlow**.

You have now prepared everything and can start with [Exercise 1](exercises/Exercise_01.md).
