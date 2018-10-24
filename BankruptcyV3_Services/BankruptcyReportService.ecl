/*--SOAP--
<message name="BankruptcyReportService">
  <part name="DID" 					type="xsd:string"/>
  <part name="BDID" 				type="xsd:string"/>
  <part name="TMSID" 				type="xsd:string"/>
  <part name="AllBkAllDebtors" 		type="xsd:boolean"/>
  <part name="SSNMask" 				type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="IncludeDockets"		type="xsd:boolean"/>
  <part name="LowerEnteredDateLimit"	type="xsd:string"/>
  <part name="UpperEnteredDateLimit"	type="xsd:string"/>
</message>
*/
/*--INFO-- This service returns one Bankruptcy Record.*/
import doxie, WSInput;

export BankruptcyReportService(
	) :=
		macro
		#CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
		//The following macro defines the field sequence on WsECL page of query.
		WSInput.MAC_BankruptcyV3_Services_BankruptcyReportService();  
		
		boolean temp_all_bks_for_all_debtors 	:= false : stored('AllBkAllDebtors');
		boolean include_dockets 				:= false : stored('IncludeDockets');
		string8 lower_entered_date	:= ''		: stored('LowerEnteredDateLimit');
		string8 upper_entered_date	:= ''		: stored('UpperEnteredDateLimit');
		string32 applicationType				 := '' : STORED('ApplicationType');
		
		doxie.MAC_Header_Field_Declare()

		output(
			// Bankruptcyv3_Services.bankruptcy_raw.source_view(temp_parms),
			Bankruptcyv3_Services.bankruptcy_raw().source_view(	in_ssn_mask := ssn_mask_value,
																in_all_bks_for_all_debtors := temp_all_bks_for_all_debtors,
																include_dockets := include_dockets,
																		lower_entered_date := lower_entered_date,
																		upper_entered_date := upper_entered_date),
			named('Results'));
		endmacro;
