/*--SOAP--
<message name="WatercraftSearch" wuTimeout="300000">
	<part name="BDID" type="xsd:string"/>
	<part name="DID" type="xsd:string"/>
	<part name="WatercraftKey" type="xsd:string" />
	<part name="SequenceKey" type="xsd:string" />
  <part name="HullNumber" type="xsd:string" />
  <part name="VesselName" type="xsd:string" />
  <part name="MinVesselLength" type="xsd:unsignedInt" />
  <part name="MaxVesselLength" type="xsd:unsignedInt" />
  <part name="UnParsedFullName" type="xsd:string"/>	
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type = "xsd:string"/>
	<part name="AllowNicknames" type="xsd:boolean"/>
	<part name="PhoneticMatch" type="xsd:boolean"/>
	<part name="CompanyName" type="xsd:string"/>
	<part name="FEIN" type="xsd:string"/>

	<part name="PrimName" type="xsd:string"/>
	<part name="PrimRange" type="xsd:string"/>

	<part name="Addr" type="xsd:string"/>
	<part name="City" type="xsd:string" />
	<part name="State" type="xsd:string"/>
	<part name="Zip" 	type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="Phone" 	type="xsd:string"/>
  <part name="NoDeepDive" type="xsd:boolean"/>
  <part name="RecordByDate" type="xsd:string"/>
	<part name="GLBPurpose"	type="xsd:byte"/>
	<part name="DPPAPurpose"	type="xsd:byte"/>
	<part name="DataRestrictionMask"	type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
	<part name="MaxResults"  type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
	<part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>	<!-- [NONE, ALL, LAST4, FIRST5] -->
	<part name="IncludeNonRegulatedWatercraftSources" type="xsd:boolean" />
</message>
*/
/*--INFO-- This service searches all Watercraft datafiles.*/
IMPORT Text_Search, doxie, AutostandardI;

EXPORT WatercraftSearchService := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#WEBSERVICE(FIELDS(	'DID',
											'BDID',
											'WatercraftKey',
											'SequenceKey',
											'HullNumber',											
											'UnParsedFullName',
											'FirstName',
											'MiddleName',
											'LastName',
											'AllowNicknames',
											'PrimName',
											'PrimRange',
											'Addr',
											'City',
											'County',
											'State',
											'Zip',
											'ZipRadius',
											'Phone',
											'CompanyName',
											'FEIN',
											'VesselName',
											'MinVesselLength',
											'MaxVesselLength',
											'MaxResults',
											'MaxResultsThisTime',
											'NoDeepDive',
											'PenaltThreshold',
											'PhoneticMatch',
											'RecordByDate',
											'SkipRecords',
											'DPPAPurpose',
											'GLBPurpose',
											'ApplicationType',
											'DataRestrictionMask',
											'SSNMask',
											'IncludeNonRegulatedWatercraftSources'
											));

	#constant('SearchGoodSSNOnly',true)
	#constant('SearchIgnoresAddressOnly',true)
	#constant('getBdidsbyExecutive',FALSE)

	doxie.MAC_Header_Field_Declare ();
	gm := AutoStandardI.GlobalModule();
	
	params := module(project(gm, WatercraftV2_Services.Interfaces.search_params, opt))
		string2 					st_pass 			:= ''   : stored('state');
		export string2 		st 						:= stringlib.stringtouppercase(st_pass);
		export unsigned2 	pt 						:= 10 	: stored('PenaltThreshold');
		export string30 	wk 						:= ''  	: stored('WatercraftKey');
		string30 					h_num 				:= '' 	: stored('HullNumber');
		export string30 	hull_num 			:= stringlib.stringtouppercase (h_num);
		export string32 	seqk 					:= '' 	: stored('sequenceKey');
		string50 					v_name	 			:= '' 	: stored('VesselName');
		export string50 	vesl_nam  		:= stringlib.stringtouppercase(v_name);
		export unsigned2	min_vesl_len	:= 0		: stored('MinVesselLength');
		export unsigned2	max_vesl_len	:= 0		: stored('MaxVesselLength');
		export string6 		ssn_mask 			:= ssn_mask_val;
		export string14 	DID 					:= '' 	:stored('DID');
		export string 		BDID					:= '' 	:stored('BDID');
		export boolean include_non_regulated_sources := false : stored('IncludeNonRegulatedWatercraftSources');
	END;
	rsrt_stmts := WatercraftV2_services.WatercraftSearch(params);
	rsrt1 := rsrt_stmts.Records;
	Text_Search.MAC_Append_ExternalKey(rsrt1, rsrt2, l.watercraft_key + l.sequence_key + l.state_origin);
	doxie.MAC_Marshall_Results(rsrt2,rmar);
	OUTPUT(rmar, NAMED('Results'));
	
ENDMACRO;
