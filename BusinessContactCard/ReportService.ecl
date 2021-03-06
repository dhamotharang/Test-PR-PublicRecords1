/*--SOAP--
<message name="ReportService">

	<!-- USER SECTION -->
	<part name="ReferenceCode"         type="xsd:string"/>
	<part name="BillingCode"           type="xsd:string"/>
	<part name="QueryId"               type="xsd:string"/>

	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"            type="xsd:byte"/>
	<part name="DLPurpose"             type="xsd:byte"/>

  <part name="MaxWaitSeconds"        type="xsd:integer"/>
	
	<!-- SEARCH FIELDS -->
  <part name="BDID"		               	 type="xsd:string"/>
  <part name="DotID"		               type="xsd:integer"/>
  <part name="EmpID"		               type="xsd:integer"/>
  <part name="PowID"		               type="xsd:integer"/>
  <part name="ProxID"		               type="xsd:integer"/>
	<part name="SeleID"		               type="xsd:integer"/>
  <part name="OrgID"		               type="xsd:integer"/>
  <part name="UltID"		               type="xsd:integer"/>
  <part name="IncludePhonesPlus"     type="xsd:boolean"/>
  <part name="IncludePhonesFeedback" type="xsd:boolean"/> 
	<part name="BusinessReportFetchLevel" type="xsd:string"/>

	<!-- ESP REQUEST -->
	<part name="BCCReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
</message>
*/
/*--INFO-- Return Business Contact Card data in a report format for a particular BDID. */

IMPORT AutoStandardI, business_header_ss, iesp, topbusiness_services, BIPV2, WSInput;

EXPORT ReportService() := FUNCTION
									
	// Get XML input 
	rec_in    := iesp.businesscontactcardreport.t_BCCReportRequest;
	ds_in     := DATASET ([], rec_in) : STORED ('BCCReportRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;

	// Set global options
	iesp.ECL2ESP.SetInputBaseRequest(first_row);

	// Set main search criteria:
	report_by := GLOBAL(first_row.ReportBy);
	options   := GLOBAL(first_row.Options);

	#STORED('useLevels'            		, TRUE); 
	#STORED('useSupergroup'        		, TRUE); // setting this forces the bdid_dataset.val to possible allow multiple bdid values.	

	#STORED('BDID'                 		,report_by.BusinessId);
	#stored('DotID'								 		,report_by.BusinessIds.DotID);
	#stored('EmpID'								 		,report_by.BusinessIds.EmpID);
	#stored('PowID'								 		,report_by.BusinessIds.PowID);
	#stored('ProxID'							 		,report_by.BusinessIds.ProxID);
	#stored('SeleID'									,report_by.BusinessIds.SeleID);
	#stored('OrgID'								 		,report_by.BusinessIds.OrgID);
	#stored('UltID'								 		,report_by.BusinessIds.UltID);
	#STORED('IncludePhonesPlus'    		, options.IncludePhonesPlus);
	#STORED('IncludePhonesFeedback'		, options.IncludePhonesFeedback);
	#STORED('BusinessReportFetchLevel', options.BusinessReportFetchLevel);

	STRING  _BusinessId             := ''   : STORED('BDID');
	unsigned6 _DotID  							:= 0 		: STORED('DotID');
	unsigned6 _EmpID  							:= 0 		: STORED('EmpID'); //in BIP2.0, these will always be 0	
	unsigned6 _PowID 								:= 0 		: STORED('PowID');	 //in BIP2.0, these will always be 0
	unsigned6 _ProxID 							:= 0 		: STORED('ProxID');	
	unsigned6 _SeleID 							:= 0 		: STORED('SeleID');
	unsigned6 _OrgID  							:= 0 		: STORED('OrgID');
	unsigned6 _UltID  							:= 0 		: STORED('UltID');
	BOOLEAN	_include_phones_plus	  := FALSE: STORED('IncludePhonesPlus');
	BOOLEAN _include_phones_feedback:= FALSE: STORED('IncludePhonesFeedback');
	STRING1 _business_report_fetch	:= BIPV2.IDconstants.Fetch_Level_SELEID	: STORED('BusinessReportFetchLevel');
	
	input_rec := DATASET([ TRANSFORM(iesp.businesscontactcardreport.t_BCCReportBy, 
																	SELF.BusinessId							:= _BusinessId, 
																	SELF.BusinessIds.DotID			:= _DotID,
																	SELF.BusinessIds.EmpID			:= _EmpID,
																	SELF.BusinessIds.PowID			:= _PowID,
																	SELF.BusinessIds.ProxID			:= _ProxID,
																	SELF.BusinessIds.SeleID			:= _SeleID,
																	SELF.BusinessIds.OrgID			:= _OrgID,
																	SELF.BusinessIds.UltID			:= _UltID)]);
				
	// global_mod := AutoStandardI.GlobalModule();
	// options 
	bcc_mod := module (BusinessContactCard.IParam.options)
		export boolean IncludePhonesPlus   			:= _include_phones_plus;
		export boolean IncludePhonesFeedback 		:= _include_phones_feedback;
		export string1 BusinessReportFetchLevel := topbusiness_services.functions.fn_fetchLevel(trim(stringlib.stringToUpperCase(_business_report_fetch),left,right)[1]);
		export boolean useSupergroup 						:= true;
		export boolean useLevels     						:= true;
		export boolean isBIPReport							:= _BusinessId = '' and _UltID <> 0;
	end;
	
	// Instantiate BusinessContactCard Report View.
	BCC_reportview := BusinessContactCard.ReportView(input_rec, bcc_mod);
	
	// Slim off 'acctno'.
	BCC_recs := PROJECT(BCC_reportview, iesp.businesscontactcardreport.t_BCCReport);

	// Attach response header; project into final layout. NOTE: Since the result being returned is just 
	// one record (see iesp.businesscontactcardreport.t_BCCReportResponse) and does not contain a dataset, 
	// we must signify which row to return ( [1] ).
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(BCC_recs[1], results, 
							 iesp.businesscontactcardreport.t_BCCReportResponse, BusinessContactCard, TRUE);
							 
	//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_BusinessContactCard_ReportService();

	RETURN OUTPUT( results, NAMED('Results') );

END;

/*

<BCCReportRequest>
<row>
 <User>
  <DLPurpose>1</DLPurpose>
  <DebitUnits>0</DebitUnits>
  <SSNMaskingOn>0</SSNMaskingOn>
  <GLBPurpose>1</GLBPurpose>
  <DLMaskingOn>0</DLMaskingOn>
  <DLMask>0</DLMask>
  <MaxWaitSeconds>0</MaxWaitSeconds>
  <BillingCode>mfern</BillingCode>
 </User>
 <Options>
  <IncludePhonesFeedback>1</IncludePhonesFeedback>
  <IncludePhonesPlus>1</IncludePhonesPlus>
 </Options>
 <ReportBy>
  <BusinessId>679568622</BusinessId>
 </ReportBy>
</row>
</BCCReportRequest>

*/