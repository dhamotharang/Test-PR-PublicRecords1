/*--SOAP--
<message name="ReportService"> 
	<part name="KeepContactReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/
/*--INFO--  
*/

import iesp, AutoStandardI,Royalty;

EXPORT ReportService := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #onwarning(4207, warning);
	//b. Receive input 
	rec_in := iesp.keepcontactreport.t_KeepContactReportRequest;

	// "FEW" keyword set to make data read more efficient
	ds_in  := DATASET ([], rec_in) : STORED ('KeepContactReportRequest', FEW);

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
	
	
	memberpoint.layouts.reportservice_data_In getReportbyInfo() := transform
			self.SSN_in := report_by.SSN;
			self.fullName := report_by.Name.Full;
			self.name_First := report_by.Name.First;
			self.name_Middle := report_by.Name.Middle;
			self.name_Last := report_by.Name.Last;
			self.name_Suffix := report_by.Name.Suffix;
			self.DOB_in := iesp.ECL2ESP.DateToString(report_by.DOB);
      street_address3:= if(report_by.Address.StreetNumber <>'' AND report_by.Address.StreetName<>'' AND report_by.Address.StreetSuffix<>'',report_by.Address.StreetNumber+report_by.Address.StreetName+report_by.Address.StreetSuffix,'');
			self.street_addr := if (report_by.Address.StreetAddress1<>'' or   street_address3<>'',report_by.Address.StreetAddress1,'');
			self.p_City_name := report_by.Address.City;
			self.State_in := report_by.Address.State;
			self.Zip_in := report_by.Address.Zip5;
			end;
	dsMemberInfo := dataset([getReportbyInfo()]);


	// **************************************************************************************
	//    Call main attribute to fetch records. 
	// **************************************************************************************
	fullBatchOutput		:= MemberPoint.BatchRecords(cBatchInput, BatchParams);
	BatchResults := fullBatchOutput.Records;

	input_ssn_mask_value := stringlib.stringtouppercase(first_row.User.SSNMask);
	input_dob_mask_value := suppress.date_mask_math.MaskIndicator (first_row.User.DOBMask);
	input_include_dob_value:=options.includedob;
	_blank:='';
  Trimmed_Input := PROJECT(dsMemberInfo, MemberPoint.Transforms.Trim_Input(LEFT));
	Cleaned_Input := PROJECT(Trimmed_Input, MemberPoint.Transforms.Clean(LEFT,COUNTER));
	Condition_1_2_Minor_Reject_DS := MemberPoint.functions.BuildMinInputErrorsDS(Cleaned_Input);
	hasExceptions := IF(COUNT(Condition_1_2_Minor_Reject_DS(code<>0)) > 0, TRUE, FALSE);
	
	iesp.keepcontactreport.t_KeepContactReportResponse format() := transform
				self._Header.Status := if(hasExceptions, memberpoint.constants.InvalidInput_Code, 0);
				self._Header.Message := if(hasExceptions, memberpoint.constants.InvalidInput_Message, _blank);
				self._Header.Exceptions := if(hasExceptions,															
																    Condition_1_2_Minor_Reject_DS(code<>0),
																    dataset([],iesp.share.t_WsException));
																
				self._Header.QueryId := first_row.user.QueryId;
				self:=[];
	end;
	
	formatdata := dataset([format()]);
	esdloutput:= MemberPoint.makeESDLOutput(BatchResults,report_by,input_ssn_mask_value,input_include_dob_value,input_dob_mask_value);
	Results:=if(hasExceptions,formatdata,esdloutput);
	output(Results,named('Results'));
	output(PROJECT(fullBatchOutput.Royalties, Royalty.Layouts.Royalty), named('RoyaltySet'));			 
ENDMACRO;

