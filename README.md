# IN260 - Master Integrations: Integration Advisor and Trading Partner Management

## Description

Welcome to the hands-on session **IN260** at SAP TechEd 2025. In this session, you will learn how to master B2B integrations using **SAP Integration Advisor** and **Trading Partner Management (TPM)**. You will build a complete **Trading Partner Agreement (TPA)** for a real-world **Order-to-Cash B2B scenario** involving the ordering of healthy food products from a German manufacturer.

## Scenario

The business scenario simulates a B2B integration between a buyer and a supplier of health food products. The integration covers the full **Order-to-Cash** process, including:

1. **Sales Order**
   - 01.a) Sales Order Request – Inbound
   - 01.b) Sales Order Response – Outbound
2. **Delivery Notification – Outbound**
3. **Invoice – Outbound**

The product catalog includes items such as cereal bars, organic porridge, smoothies, and electrolyte water, each with specific packaging and pricing details.

## Learning Objectives

Throughout the exercises, you will:

- Configure a Trading Partner Profile with identifiers, systems, and parameters.
- Create and customize a Trading Partner Agreement (TPA) using templates.
- Design and refine Message Implementation Guidelines (MIGs) and Mapping Guidelines (MAGs).
- Simulate and validate B2B message flows using the SAP Integration Suite.
- Apply advanced mapping techniques including qualifiers, code lists, and post-processing.

## System URL and login information 

To complete the exercises, the access to the following systems have been provided. \
**In case you are not able to access any of these systems please contact the workshop instructors**.

- [SAP Integration Suite Tenant](https://workshop-eu-03b.integrationsuite-cpi035.cfapps.eu20-001.hana.ondemand.com/shell/design)

> [!IMPORTANT]
> - _For a smooth experience, tenants have been preconfigured, and you already have all the roles and permissions needed to complete this exercise._
> - _User ID and password information will be provided to you by the instructors._
> - _When you run through the exercise steps, you need to ensure that the technical IDs of the integration artifacts that you will create are unique. Hence, add a participant number to your integration artifacts. The instructors will assign the participant number to you._
> - _Please adhere strictly to the instructions regarding the naming conventions for the artifacts you create. This will ensure successful completion of the tasks without conflicting with other participants._
> - _Do not delete, change or undeploy any artifact in the tenant other than yours._

## Exercises Overview

Each exercise builds on the previous one, guiding you through the complete lifecycle of a B2B integration setup.

### Mandatory Exercises

- **[Getting Started](GettingStarted.md)**  
  Initial setup and environment preparation.

- **[Exercise 1: Create the necessary Trading Partner Profile](exercises/Exercise_01.md)**  
  Learn how to configure a Trading Partner Profile, including identifiers, systems, communication channels, and parameters.

- **[Exercise 2: Creating a Trading Partner Agreement (TPA) from a Template](exercises/Exercise_02.md)**  
  Use a predefined template to create a TPA, configure activity parameters, and validate the agreement using test payloads.

- **[Exercise 3: Create Trading Partner MIG for Sales Order Request](exercises/Exercise_03.md)**  
  Build a source MIG from a sample payload, apply qualifiers, and refine the structure for mapping.

- **[Exercise 4: Finalize the Business Transaction Activity Sales Order Request](exercises/Exercise_04.md)**  
  Create an Overlay MAG, resolve mapping issues, simulate the flow, and validate the output against expected results.

### 🔸 Optional Deep-Dive Exercises

- **[Exercise 5: Finalize the Business Transaction Activity Order Response](exercises/Exercise_05.md)**  
  Work with code lists and code value mappings to complete the outbound Sales Order Response.

- **[Exercise 6: Finalize the Business Transaction Activity Delivery Notification](exercises/Exercise_06.md)**  
  Enhance the Delivery Notification with pre- and post-processing logic, including sorting and packaging structure.

- **[Exercise 7: Finalize the Business Transaction Activity Invoice](exercises/Exercise_07.md)**  
  Add trading partner-specific parameters and implement complex mapping logic for invoice processing.

## Product Catalog

| # | Product Name | Article No | EAN | Net Weight | Price | Package | Quantity | Total |
|---|--------------|------------|-----|------------|-------|---------|----------|-------|
| 1 | BestRun VitalCrisp Cereal Bar | BR-VCB-001 | 4000001000012 | 40g | €0.89 | 12 bars | 12 cartons | 144 |
| 2 | BestRun KornKraft Whole-Grain Bread | BR-KKWB-002 | 4000001000029 | 500g | €2.49 | 1 roll | 100 rolls | 100 |
| 3 | BestRun MorgenGold Organic Porridge | BR-MGOP-003 | 4000001000036 | 400g | €3.29 | 1 bag | 150 bags | 150 |
| ... | *(see full list in session)* | | | | | | | |

## Requirements

To complete the exercises, you will need:

- Access to SAP Integration Suite (including TPM and Integration Advisor)
- The **Bruno API Testing Tool** with the provided environment
- Uploaded content from this repository into **Bruno**
- Use **Visual Studio Code** for analysing and comparing of the test results.

## Key Takeaways
By the end of this session, participants will be able to:
- Understand the end-to-end process of setting up a Trading Partner Agreement (TPA) for a real-world B2B scenario.
- Use SAP Integration Advisor to create and refine Message Implementation Guidelines (MIGs) and Mapping Guidelines (MAGs).
- Configure Trading Partner Profiles and manage communication parameters effectively.
- Simulate and validate B2B message flows for Sales Orders, Delivery Notifications, and Invoices.
- Apply advanced mapping techniques such as qualifiers, code lists, and post-processing logic.
- Gain hands-on experience with SAP Integration Suite capabilities for TPM and B2B integration.

This session is designed to empower integration developers and architects to confidently manage B2B integrations using SAP’s latest tools and methodologies.

## Feedback

Please provide your feedback for session **IN260** by scanning the QR code below:

 ![QR Code](pictures/survey_QR.png)

