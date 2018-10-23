/*--SOAP--
<message name="ReportService"> 
	<part name="ChildIdentityFraudReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/
/*--INFO--  
*/

import iesp, AutoStandardI;

EXPORT ReportService := MACRO
 
	#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	#onwarning(4207, ignore);
	//b. Receive input 
	rec_in := iesp.childidentityfraudreport.t_ChildIdentityFraudReportRequest;

	// "FEW" keyword set to make data read more efficient
	ds_in  := DATASET ([], rec_in) : STORED ('ChildIdentityFraudReportRequest', FEW);

	/* independent" service keyword used here to make statement atomic and a signal to 
	code generator to not combine it with other lines of code. It is evaluated at a global scope. */
	first_row := ds_in[1] : independent;
	report_by := global (first_row.ReportBy);

	// These are to keep the reportService same as batchService.		
	#constant('PenaltThreshold',10);
	#stored('ExcludeInputAddrNeighbors',true);
	#stored('ExcludeUpdateAddrNeighbors',true);
	#stored('RelativesDepth',1);

	//We blanlk the mask value so as to prevent masking in the various batch services.		
	#stored('SSNMask','');
	#stored('DOBMask','');
	
	clean_ssn := stringlib.stringfilter(report_by.SSN,'0123456789');
	#stored('SSN',clean_ssn);

	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.SetInputName (report_by.Name,true);
	iesp.ECL2ESP.SetInputDate(report_by.DOB,'DOB');
	// iesp.ECL2ESP.SetInputAddress (report_by.Address);
	glbMod := AutoStandardI.GlobalModule();

	//d.1	Project glbMod into Batch IParams: 
	BatchInput := ChildIdentityFraudSolutionServices.fnMakeBatchInput();

	//d.2	Project glbMod into the BatchIn Layout:  
	BatchParams := ChildIdentityFraudSolutionServices.fnMakeBatchParams();

	//e.	Make a (single batch input) call (TaxRefundIS_Service.functions.callTRISbatch)
	BatchShare.MAC_CapitalizeInput(BatchInput, cBatchInput);

	// **************************************************************************************
	//    Call main attribute to fetch records. 
	// **************************************************************************************
	fullBatchOutput		:= ChildIdentityFraudSolutionServices.BatchRecords(cBatchInput, BatchParams);
	BatchResults := fullBatchOutput.Records;

	input_ssn_mask_value := stringlib.stringtouppercase(first_row.User.SSNMask);
	input_dob_mask_value := suppress.date_mask_math.MaskIndicator (first_row.User.DOBMask);
	//g.	Convert batch result record to ESDL result record & do DOB/SSN Masking:
	Results := ChildIdentityFraudSolutionServices.fnMakeESDLOutput();

	//i. Give back Results
	isInsufficientInput := ChildIdentityFraudSolutionServices.fnIsInsufficientInput(report_by);

	DO_OUTPUT 		:= output(Results,named('Results'));
	DO_ROYALTIES  := output(fullBatchOutput.Royalties, named('RoyaltySet'));

	if(isInsufficientInput,
		 FAIL(301, doxie.ErrorCodes(301)),
		 DO_OUTPUT);
		 DO_ROYALTIES;
	 
ENDMACRO;
