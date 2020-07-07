// input:  iesp.RelationshipIdentifierReport.t_RelationshipIdentifierReportRequest

// output:  iesp.RelationshipIdentifierReport.t_RelationshipIdentifierReportResponseEx
// sample XML inputs are listed below The options IncludeNeighbor and AsOfDate are 
// passed from the search query to the report query automatically in Portal GUI code
// but are shown in XML input below.
//
import iesp, autostandardi, suppress, STD;
export Report_Service() := macro
			
	rec_in := iesp.RelationshipIdentifierReport.t_RelationshipIdentifierReportRequest;
	ds_in := dataset([],rec_in) : stored('RelationshipIdentifierReportRequest',few);
	first_row := ds_in[1] : independent;
	
 ds_reportOptions := PROJECT(first_row.Options, TRANSFORM(
	                    iesp.RelationshipIdentifierReport.t_RelationshipIdentifierReportOption,
	SELF := LEFT;
	self := [];
	));
   					 
	boolean inc_neighbors := ds_reportOptions.IncludeNeighbors;	 
	 
	integer CurDate := STD.Date.today();
	unsigned4 endDateTmp := (unsigned4) iesp.ecl2esp.DateToInteger(ds_reportOptions.AsOfDate);
	unsigned4 enddate := if (endDateTmp = 0, (unsigned4) curDate, endDateTmp);
	
	#stored('Include_Neighbors', inc_neighbors);
	#stored('Include_HistoricalNeighbors',TRUE); // only get current neighbors.
	#stored('Max_Neighborhoods',8); // default for this in comp report is 4
	 
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
	
 is_consumer := mod_access.isConsumer();
 glb_ok  := mod_access.isValidGlb() or is_consumer;
			
	// coded per requirement 3.30 #3 Relationship identifier Project.
	PermissionsFlagGLB := mod_access.glb = 0 and ~is_consumer;
	
	// END OF requirement 3.30 #3
	
	ds_reportBy := PROJECT(first_row.ReportBy, TRANSFORM( 
	               iesp.RelationshipIdentifierReport.t_relationshipIdentifierReportBy,																							  
	SELF := LEFT;));
  
 num_rows := COUNT(ds_reportBy);
	
	reportResults := RelationshipIdentifier_Services.Report_Records.getReport(ds_reportBy,inc_neighbors,
	                                                                          endDate,mod_access);
	
	iesp.RelationshipIdentifierReport.t_RelationshipIdentifierReportResponse
		 Format_out() := TRANSFORM
			self._Header := iesp.ECL2ESP.getHeaderRow();		   
			SELF.Records := reportResults;
		 END;
			 
			Results := dataset( [format_out()]);	

	 Map(
	    num_rows <= 1 OR num_rows >= iesp.constants.RelationshipIdentifier.MAX_COUNT_SEARCH_MATCH_RECORDS +1
																	         => FAIL(203,doxie.ErrorCodes(301)),
						PermissionsFlagGlb  => FAIL(100, 'GLB permissible purpose is required.'),
						(~(glb_ok))         => FAIL(2, 'Invalid GLB permissible purpose'),
						output(Results, named('Results'))
	 );
	ENDMACRO;
	
/*
// this is the XML block that can be used on wsecl page as input into roxie service
// as this service RelationshipIdentifier_Services.Report_Service is designed to be used
// in conjunction with : RelationshipIdentifier_Services.Search_Service
// using output of RelationshipIdentifier_Services.Search_Service and passing it as input
// of RelationshipIdentifier_Services.Report_Service once all search entities (Individual (person) or business)
// have been resolved in the RelationshipIdentifier_Services.Search_Service meaning the
// needsResolution field name in RelationshipIdentifier_Services.Search_Service for each
// row should be false BEFORE RelationshipIdentifier_Services.Report_Service is able to be called
// Testing examples can fill in a UniqueID (did) value OR ult/org/seleid values for each
// reportBy xml structure.
// the role field is just a place holder and user can put any string value up to 50 chars in that field.
//
<relationshipidentifier_services.report_serviceRequest>
<relationshipidentifierreportrequest>
  <Row>
 <User>
    <ReferenceCode/>
    <BillingCode/>
    <QueryId/>
    <CompanyId/>
    <GLBPurpose>1</GLBPurpose> // values can be 1-7 or 0
    <DLPurpose>1</DLPurpose> // values can be 1-7 or 0.
    <LoginHistoryId/>
    <DebitUnits/>
    <IP/>
    <IndustryClass/>
    <ResultFormat/>
    <LogAsFunction/>
    <SSNMask/>
    <DOBMask/>
    <ExcludeDMVPII>0</ExcludeDMVPII>
    <DLMask>0</DLMask>
    <DataRestrictionMask/>
    <DataPermissionMask/>
    <SourceCode/>
    <ApplicationType/>
    <SSNMaskingOn>0</SSNMaskingOn>
    <DLMaskingOn>0</DLMaskingOn>
    <LnBranded>0</LnBranded>
    <EndUser>
     <CompanyName/>
     <StreetAddress1/>
     <City/>
     <State/>
     <Zip5/>
     <Phone/>
    </EndUser>
    <MaxWaitSeconds/>
    <RelatedTransactionId/>
    <AccountNumber/>
    <TestDataEnabled>0</TestDataEnabled>
    <TestDataTableName/>
    <OutcomeTrackingOptOut>0</OutcomeTrackingOptOut>
    <NonSubjectSuppression/>
   </User>
  <Options>
    <IncludeNeighbors>0</IncludeNeighbors>    
			<AsOfDate>
           <Year>2016</Year>
           <Month>02</Month>
           <Day>20</Day>
       </AsOfDate>
   </Options>
    <ReportBy>
     <Item>   
      <UniqueId></UniqueId>
      <BusinessIds>
       <DotID/>
       <EmpID/>
       <POWID/>
       <ProxID/>
       <SeleID/>
       <OrgID/>
       <UltID/>
      </BusinessIds>
      <Role></Role>
     </Item>
     <Item>
      <UniqueId></UniqueId>
      <BusinessIds>
       <DotID/>
       <EmpID/>
       <POWID/>
       <ProxID/>
       <SeleID/>
       <OrgID/>
       <UltID/>
      </BusinessIds>
      <Role></Role>
     </Item>
   <Item>
      <UniqueId></UniqueId>
      <BusinessIds>
       <DotID/>
       <EmpID/>
       <POWID/>
       <ProxID/>
       <SeleID></SeleID>
       <OrgID></OrgID>
       <UltID></UltID>
      </BusinessIds>
      <Role></Role>
     </Item>
    </ReportBy>
  </Row>
</relationshipidentifierreportrequest>
</relationshipidentifier_services.report_serviceRequest>


*/