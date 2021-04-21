/*--SOAP--
<message name="IngenixSanctionsReportRequest">
  <part name="Gateways" type="tns:XmlDataSet" cols="80" rows="4"/>
  <part name="SanctionID" type="tns:EspStringArray" required="1"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
 </message>
*/
/*--INFO-- This service pulls from the Ingenix sanctions files.*/

import ingenix_natlprof,Prof_LicenseV2_Services;

export ING_sanctions_report := macro

input_params := AutoStandardI.GlobalModule();
	params := module(project(input_params,prof_licensev2_services.profLicSearch.params,opt))
	  export boolean Include_Prof_Lic := false : stored('IncludeProfessionalLicenses');
	  export boolean Include_Sanc := false		 : stored('IncludeSanctions');
	  export boolean Include_Prov := false		 : stored('IncludeProviders');
	
	  export unsigned6 	Sanc_id := 0 						 : stored('SanctionID');
		export set of unsigned6  sanc_id_set := [] : stored('SanctionID');
		export unsigned6  ProviderId := 0      		 : stored('ProviderID');
		export unsigned6  prolic_seq_num := 0  		 : stored('SequenceID');
		shared string20	  L_Number := '' 		 : stored('LicenseNumber');
		export string20   License_Number :=  stringlib.stringtouppercase(l_number);										 												 
	end;

sanc_rslts := doxie.ING_sanctions_report_records(params.sanc_id_set);
output(sanc_rslts, named('Results'));

endmacro;
