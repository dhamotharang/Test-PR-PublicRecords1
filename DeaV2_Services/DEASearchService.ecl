/*--SOAP--
<message name="DEASearchService" wuTimeout="300000">
  <part name="DID"	type="xsd:string"/>
  <part name="BDID"	type="xsd:string"/>
  <part name="LastName" type = "xsd:string" />
	<part name="FirstName" type="xsd:string" />
	<part name="MiddleName" type="xsd:string" />
  <part name="UnParsedFullName" 	type="xsd:string"/>
	<part name="AllowNicknames" type='xsd:boolean' />
	<part name="PhoneticMatch" type='xsd:boolean' />
	<part name="SSN" type="xsd:string"/>	
	<part name="SSNMask" type="xsd:string"/>
	<part name="CompanyName" type="xsd:string" />
	<part name="Addr" type="xsd:string" />
	<part name="City" type="xsd:string" />
	<part name="State" type="xsd:string" />
	<part name="Zip" type="xsd:unsignedInt"/>
  <part name="County" type="xsd:string"/>
	<part name="RegistrationNumber" type="xsd:string" />
	<part name="NoDeepDive" type="xsd:boolean"/>
  <part name="GLBPurpose" type = "xsd:byte"/>
  <part name="DPPAPurpose" type = "xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="PenaltThreshold"   type="xsd:unsignedInt"/>
  <part name="MaxResults"  type = "xsd:unsignedInt" />
  <part name="MaxResultsThisTime" type = "xsd:unsignedInt" />
  <part name="SkipRecords" type = "xsd:unsignedInt" />
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service searches all DEA datafiles.*/



EXPORT DEASearchService := MACRO

#CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#constant('SearchGoodSSNOnly',true);
#constant('SearchIgnoresAddressOnly',true);
#constant('getBdidsbyExecutive',FALSE);

  EXPORT DEA_params := MODULE(DEAV2_Services.Interfaces.search_params)
			String9 Reg_Number                         := '' : STORED('RegistrationNumber');	
			EXPORT String9 reg_num                     := stringlib.stringtouppercase(Reg_Number);
			EXPORT Unsigned PenaltThreshold            := 10  : STORED('PenaltThreshold');
	END;
	 dea_Input	:= DATASET([{DEA_params.reg_num}],DEAV2_Services.assorted_layouts.layout_DeaKey);
   dea_recs := DEAV2_services.DEASearchService_ids(dea_Input);
	 dea_pt  := dea_recs( penalt <= DEA_params.PenaltThreshold);
	 dea_sorted  := SORT(dea_pt,IsDeepDive,Penalt,dea_registration_number);
	 Text_Search.MAC_Append_ExternalKey(dea_sorted, dea_sorted2, l.dea_registration_number);
	 doxie.MAC_Header_Field_Declare()	 
	 doxie.MAC_Marshall_Results(dea_sorted2,results);
	 OUTPUT(results,NAMED('RESULTS'));


ENDMACRO;

