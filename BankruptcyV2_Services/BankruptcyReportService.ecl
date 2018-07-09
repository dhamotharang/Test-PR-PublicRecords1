/*--SOAP--
<message name="BankruptcyReportService">
  <part name="DID" 					type="xsd:string"/>
  <part name="BDID" 				type="xsd:string"/>
  <part name="TMSID" 				type="xsd:string"/>
	<part name="AllBkAllDebtors" type="xsd:boolean"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="ApplicationType"   	type="xsd:string"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns one Bankruptcy Record.*/
import doxie;

export BankruptcyReportService(
	) :=
		macro
		
		  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
		//The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_BankruptcyV2_Services_ReportService();
	
		boolean temp_all_bks_for_all_debtors := false : stored('AllBkAllDebtors');
		
    doxie.MAC_Selection_Declare()
		doxie.MAC_Header_Field_Declare()

		output(
			Bankruptcyv2_Services.bankruptcy_raw().source_view(in_ssn_mask := ssn_mask_value,
																											 in_all_bks_for_all_debtors := temp_all_bks_for_all_debtors,
                                                       in_includeCriminalIndicators := IncludeCriminalIndicators),
			named('Results'));
		endmacro;
