# Consumer Disclosure Services
Last update on: 11.19.2019

## Contents

- The services included in this folder are used exclusively for consumer disclosure (CD Tools).  

## Services

- ConsumerDisclosure.FCRADataService
- ConsumerDisclosure.FCRAInquiryHistoryService
- ConsumerDisclosure.CollectionReportService
- ConsumerDisclosure.CollectionReportTier2Service

### ConsumerDisclosure.FCRADataService
- Added under Project Dempsey as a replacemente for legacy <i>RiskWiseFCRA.FCRAData_Service</i>.
- Used by CDT to retrieve all data available for a given LexID.
- Uses Person Context to flag disputed and/or suppressed records.
- Uses FCRA Flag File to flag corrected records and return overrides.

### ConsumerDisclosure.FCRADataService
- Created as part of Project Dempsey.
- Used by CDT to retrieve inquiries for a given LexID; inquiries are included in One Report.
- Uses a Deltabase to pull most recent inquiries and return along with inquiries found in Roxie keys.
 
### ConsumerDisclosure.CollectionReportService
- Created as part of CCPA Project.
- Used by CDT to retrieve all in-scope data for consumer disclosure.
- Raw data is returned as JSON strings to faciliate upstream integration.

### ConsumerDisclosure.CollectionReportTier2Service
- Create as part of CCPA Project.
- This is just an extension to Collection Report Service, added to handle a few additional datasets.

### CollectionReport.TestMod
- Collection Report Validation Process.
- Created to speed up QA validation for the collection report.
- Runs as a stand-alone thor job comparing results pulled from the query and Roxie keys (see CollectionReport.BWRTestReport).