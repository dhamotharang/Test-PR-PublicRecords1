/*--SOAP--
<message name="ProfCredentialSearchService">
		
	<part name="UniqueId" 					 type="xsd:unsignedint"/>
	<part name="FullName" 					 type="xsd:string"/>
	<part name="FirstName" 					 type="xsd:string"/>
	<part name="MiddleName" 				 type="xsd:string"/>
	<part name="PaternalName" 	 		 type="xsd:string"/>
	<part name="MaternalName" 	 		 type="xsd:string"/>
	<part name="MarriedName" 				 type="xsd:string"/>

  <separator />
	<part name="Category"		 	 			 type="xsd:string"/>
	<part name="Gender" 						 type="xsd:string" description="[M|F]"/>

  <separator />
	<part name="PenaltThreshold"     type="xsd:unsignedInt" default="0"/>
	<part name="PhoneticMatch"     	 type="xsd:boolean"/>
	<part name="StrictMatch"     	 	 type="xsd:boolean"/>
	<part name="ReturnCount" 			 	 type="xsd:unsignedInt" default="10"/>
  <part name="StartingRecord" 		 type="xsd:unsignedInt" default="0"/>
	
  <separator />
	<part name="InternationalProfCertificationSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- <p>Search service for Mexican professional certification.</p>*/
/*--HELP */
/*--USES-- ut.input_xslt */
import AutoStandardI, iesp;

// Used by Accurint->International->Professional Certification Search.
//	- formerly known as International Professional License Search (ProfLicenseSearchService)
export ProfessionSearchService := MACRO

	ds_in := DATASET ([], iesp.internationalprofcert.t_InternationalProfCertificationSearchRequest) : STORED('InternationalProfCertificationSearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	MX_Services.IParam.SetInputProfessionSearchBy(first_row.searchBy);	
	MX_Services.IParam.SetInputProfessionSearchOptions(first_row.options);
	in_mod 			:= MX_Services.Functions.getProfessionSearchModule(first_row);	
	recs 				:= MX_Services.SearchRecords.Profession.records(in_mod);	
	recs_final 	:= choosen(MX_Services.Functions.toFinalProfessionOut(recs), MX_Services.Constants.Limits.MAX_RESULTS);	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs_final,Results,iesp.internationalprofcert.t_InternationalProfCertificationSearchResponse);	
	output(Results, named('results'));

ENDMACRO;
// MX_Services.ProfessionSearchService();
