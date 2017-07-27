/*--SOAP--
<message name="SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="NPINumber" type="xsd:string"/>
	<separator />
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="Addr" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<separator />
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte" />
	<separator />
	<part name="NPIReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

/*--INFO-- This service pulls from the NPPES files.*/

/*--HELP-- 
<pre>
   &lt;NPIReportRequest&gt;
    &lt;Row&gt;
     &lt;User&gt;
      &lt;ReferenceCode/&gt;
      &lt;BillingCode/&gt;
      &lt;QueryId/&gt;
      &lt;CompanyId/&gt;
      &lt;GLBPurpose/&gt;
      &lt;DLPurpose/&gt;
      &lt;LoginHistoryId/&gt;
      &lt;DebitUnits/&gt;
      &lt;IP/&gt;
      &lt;IndustryClass/&gt;
      &lt;ResultFormat/&gt;
      &lt;LogAsFunction/&gt;
      &lt;SSNMask/&gt;
      &lt;DOBMask/&gt;
      &lt;DLMask&gt;0&lt;/DLMask&gt;
      &lt;DataRestrictionMask/&gt;
      &lt;DataPermissionMask/&gt;
      &lt;ApplicationType/&gt;
      &lt;SSNMaskingOn&gt;0&lt;/SSNMaskingOn&gt;
      &lt;DLMaskingOn&gt;0&lt;/DLMaskingOn&gt;
      &lt;EndUser&gt;
       &lt;CompanyName/&gt;
       &lt;StreetAddress1/&gt;
       &lt;City/&gt;
       &lt;State/&gt;
       &lt;Zip5/&gt;
      &lt;/EndUser&gt;
      &lt;MaxWaitSeconds/&gt;
      &lt;RelatedTransactionId/&gt;
      &lt;AccountNumber/&gt;
      &lt;TestDataEnabled&gt;0&lt;/TestDataEnabled&gt;
      &lt;TestDataTableName/&gt;
     &lt;/User&gt;
     &lt;RemoteLocations/&gt;
     &lt;ServiceLocations/&gt;
     &lt;Options&gt;
      &lt;Blind&gt;0&lt;/Blind&gt;
      &lt;Encrypt&gt;0&lt;/Encrypt&gt;
      &lt;ReturnTokens&gt;0&lt;/ReturnTokens&gt;
      &lt;StrictMatch/&gt;
      &lt;MaxResults/&gt;
      &lt;UseNicknames/&gt;
      &lt;UsePhonetics/&gt;
      &lt;PenaltyThreshold/&gt;
			&lt;IncludeAlsoFound&gt;0&lt;/IncludeAlsoFound&gt;
      &lt;ReturnCount/&gt;
      &lt;StartingRecord/&gt;
     &lt;/Options&gt;
     &lt;ReportBy&gt;
      &lt;UniqueId/&gt;
      &lt;Name&gt;
       &lt;Full/&gt;
       &lt;First/&gt;
       &lt;Middle/&gt;
       &lt;Last/&gt;
       &lt;Suffix/&gt;
       &lt;Prefix/&gt;
      &lt;/Name&gt;
      &lt;CompanyName/&gt;
      &lt;Address&gt;
       &lt;StreetNumber/&gt;
       &lt;StreetPreDirection/&gt;
       &lt;StreetName/&gt;
       &lt;StreetSuffix/&gt;
       &lt;StreetPostDirection/&gt;
       &lt;UnitDesignation/&gt;
       &lt;UnitNumber/&gt;
       &lt;StreetAddress1/&gt;
       &lt;StreetAddress2/&gt;
       &lt;City/&gt;
       &lt;State/&gt;
       &lt;Zip5/&gt;
       &lt;Zip4/&gt;
       &lt;County/&gt;
       &lt;PostalCode/&gt;
       &lt;StateCityZip/&gt;
      &lt;/Address&gt;
      &lt;DOB&gt;
       &lt;Year/&gt;
       &lt;Month/&gt;
       &lt;Day/&gt;
      &lt;/DOB&gt;
      &lt;CompanyName/&gt;
			&lt;NPINumber&gt; &lt;/NPINumber&gt;
     &lt;/ReportBy&gt;
    &lt;/Row&gt;
   &lt;/NPIReportRequest&gt;
</pre>
*/
/*--USES-- ut.input_xslt */

import iesp, AutoStandardI;

EXPORT NPI_ReportService := MACRO
	ds_in := DATASET ([], iesp.npireport.t_NPIReportRequest) : STORED('NPIReportRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputSearchOptions(first_row.options);	  
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.reportBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
	// string11 Fein       := trim(first_row.ReportBy.Taxid);
	// #stored('Fein', Fein);
  STRING CompanyName := trim(first_row.ReportBy.CompanyName);
	#STORED('CompanyName', CompanyName);
	unsigned1 PenaltThreshold := if(first_row.Options.penaltythreshold>0,first_row.Options.penaltythreshold,10);
	#stored ('PenaltThreshold', PenaltThreshold);	
  STRING npi_number := '' : STORED('NPINumber');
	input_params := AutoStandardI.GlobalModule();
	tmpMod:= MODULE(PROJECT(input_params, Healthcare_Provider_Services.IParams.searchParams,opt))		
		EXPORT unsigned2 	penalty_threshold := PenaltThreshold;
		EXPORT STRING 		NPI := IF(npi_number <> '', npi_number, first_row.reportBy.NPINumber);
		// EXPORT string11 	Fein := AutoStandardI.InterfaceTranslator.fein_val.val(project(input_params, AutoStandardI.InterfaceTranslator.fein_val.params));  
		EXPORT STRING30 	LastName := AutoStandardI.InterfaceTranslator.lname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.lname_value.params));      			
		EXPORT STRING30 	FirstName := AutoStandardI.InterfaceTranslator.fname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.fname_value.params));      			
		EXPORT STRING30 	MiddleName := AutoStandardI.InterfaceTranslator.mname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.mname_value.params));      			
		EXPORT string120 	CompanyName := AutoStandardI.InterfaceTranslator.company_name.val(project(input_params, AutoStandardI.InterfaceTranslator.company_name_value.params));
		EXPORT boolean 		isReport := first_row.options.isReport;
	END;
	
	results := Healthcare_Provider_Services.NPI_ReportService_Records(tmpMod);	
		
	final_results := project(results, transform(iesp.npireport.t_NPIReportResponse, 
																						self.InputEchoReportBy :=  first_row.ReportBy, 
																						self:=left));
	output(final_results, named('Results'));

ENDMACRO;
