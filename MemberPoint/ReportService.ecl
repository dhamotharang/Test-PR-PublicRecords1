/*--SOAP--
<message name="ReportService"> 
	<part name="MemberPointReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/
/*--INFO--  
*/

import iesp, AutoStandardI,Royalty;

EXPORT ReportService := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #onwarning(4207, warning);
	//b. Receive input 
	rec_in := iesp.memberpointreport.t_MemberPointReportRequest;

	// "FEW" keyword set to make data read more efficient
	ds_in  := DATASET ([], rec_in) : STORED ('MemberPointReportRequest', FEW);

	/* independent" service keyword used here to make statement atomic and a signal to 
	code generator to not combine it with other lines of code. It is evaluated at a global scope. */
	first_row := ds_in[1] : independent;
	report_by := global (first_row.ReportBy);
	options   := global (first_row.Options);

	// These are to keep the reportService same as batchService.		
	#constant('PenaltThreshold',10);
	#constant('IncludeMinors',false);
	#CONSTANT('ReturnDetailedRoyalties', FALSE); // To disable detailed royalties, since we do not need those in search

	//We blanlk the mask value so as to prevent masking in the various batch services.		
	#stored('SSNMask','');
	#stored('DOBMask','');
	
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.SetInputName (report_by.Name);
	iesp.ECL2ESP.SetInputDate(report_by.DOB,'DOB');
	glbMod := AutoStandardI.GlobalModule();

	//d.1	Project glbMod into Batch IParams: 
	BatchParams := MemberPoint.MakeBatchParams(options);

	//d.2	Project glbMod into the BatchIn Layout: 
	BatchInput := MemberPoint.makeSingleBatchInput();

	//e.	Make a (single batch input) call (TaxRefundIS_Service.functions.callTRISbatch)
	BatchShare.MAC_CapitalizeInput(BatchInput, cBatchInput);

	// **************************************************************************************
	//    Call main attribute to fetch records. 
	// **************************************************************************************
	fullBatchOutput		:= MemberPoint.BatchRecords(cBatchInput, BatchParams);
	BatchResults := fullBatchOutput.Records;

	input_ssn_mask_value := stringlib.stringtouppercase(first_row.User.SSNMask);
	input_dob_mask_value := suppress.date_mask_math.MaskIndicator (first_row.User.DOBMask);
	
	//g.	Convert batch result record to ESDL result record & do DOB/SSN Masking:
	Results := MemberPoint.makeESDLOutput(BatchResults,report_by,input_ssn_mask_value,input_dob_mask_value);
	

	//i. Give back Results
	IsSufficientInput := MemberPoint.IsSufficientInput();

	DO_OUTPUT 		:= output(Results,named('Results'));
	DO_ROYALTIES  := output(PROJECT(fullBatchOutput.Royalties, Royalty.Layouts.Royalty), named('RoyaltySet'));

	if(not IsSufficientInput,
		 FAIL(301, doxie.ErrorCodes(301)),
		 DO_OUTPUT);
		 DO_ROYALTIES;
	 
ENDMACRO;


