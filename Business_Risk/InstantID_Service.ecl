/*--SOAP--
<message name="BocaBusinessInstantID">
	<part name="_LoginID" type="xsd:string"/>
	<part name="tribcode" 		type="xsd:string"/>
	<part name="AccountNumber" 		type="xsd:string"/>
	<part name="BDID"				type="xsd:string"/>
	<part name="CompanyName" 		type="xsd:string"/>
	<part name="AlternateCompanyName" 	type="xsd:string"/>
	<part name="Addr" 				type="xsd:string"/>
	<part name="City" 				type="xsd:string"/>
	<part name="State" 				type="xsd:string"/>
	<part name="Zip" 				type="xsd:string"/>
	<part name="BusinessPhone"		type="xsd:string"/>
	<part name="TaxIdNumber" 		type="xsd:string"/>
	<part name="BusinessIPAddress" 	type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="RepresentativeFirstName"  type="xsd:string"/>
	<part name="RepresentativeMiddleName" type="xsd:string"/>
	<part name="RepresentativeLastName"   type="xsd:string"/>
	<part name="RepresentativeNameSuffix" type="xsd:string"/>
	<part name="RepresentativeAddr" 	type="xsd:string"/>
	<part name="RepresentativeCity" 	type="xsd:string"/>
	<part name="RepresentativeState"	type="xsd:string"/>
	<part name="RepresentativeZip" 	type="xsd:string"/>
	<part name="RepresentativeSSN" 	type="xsd:string"/>
	<part name="RepresentativeDOB" 	type="xsd:string"/>
	<part name="RepresentativeAge" 	type="xsd:unsignedInt"/>
	<part name="RepresentativeDLNumber" 	  type="xsd:string"/>
	<part name="RepresentativeDLState" 	  type="xsd:string"/>
	<part name="RepresentativeHomePhone" 	  type="xsd:string"/>
	<part name="RepresentativeEmailAddress"   type="xsd:string"/>
	<part name="RepresentativeFormerLastName" type="xsd:string"/>
	<part name="DPPAPurpose" 		type="xsd:byte"/>
	<part name="GLBPurpose" 			type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>		
  <part name="_espclientinterfaceversion'" type="xsd:string"/>		
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>	
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="DLMask" type="xsd:string"/>
	<part name="DOBMask" type="xsd:string"/>
	<part name="IncludeTargusE3220" type="xsd:boolean"/>
	<part name="scores" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="IncludeMSoverride" type="xsd:boolean"/>
	<part name="IncludeDLVerification" type="xsd:boolean"/>
  <part name="AttributesVersionRequest" type="xsd:string"/>
	<part name="WatchList" type="tns:XmlDataSet" cols="90" rows="10"/>
	<part name="IncludeAllRiskIndicators" type="xsd:boolean"/>
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This Service is an interface into the Business InstantID. */

import address, doxie, risk_indicators, models, riskwise, Risk_Reporting, suppress, ut, iesp, AutoStandardI, OFAC_XG5,
       Inquiry_AccLogs, Risk_Reporting;

export InstantID_Service() := macro

#stored('_espclientinterfaceversion', '');

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',0);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);


#WEBSERVICE(FIELDS(
	'_LoginID',
	'tribcode',
	'AccountNumber',
	'BDID',
	'CompanyName',
	'AlternateCompanyName',
	'Addr',
	'City',
	'State',
	'Zip',
	'BusinessPhone',
	'TaxIdNumber',
	'BusinessIPAddress',
	'UnParsedFullName',
	'RepresentativeFirstName',
	'RepresentativeMiddleName',
	'RepresentativeLastName',
	'RepresentativeNameSuffix',
	'RepresentativeAddr',
	'RepresentativeCity',
	'RepresentativeState',
	'RepresentativeZip',
	'RepresentativeSSN',
	'RepresentativeDOB',
	'RepresentativeAge',
	'RepresentativeDLNumber',
	'RepresentativeDLState',
	'RepresentativeHomePhone',
	'RepresentativeEmailAddress',
	'RepresentativeFormerLastName',
	'DPPAPurpose',
	'GLBPurpose',
	'DataRestrictionMask',
	'DataPermissionMask',
	'HistoryDateYYYYMM',
	'PoBoxCompliance',	
	'_espclientinterfaceversion',
	'OfacOnly',
	'ExcludeWatchLists',
	'OFACversion',
	'IncludeOfac',
	'IncludeAdditionalWatchLists',
	'GlobalWatchlistThreshold',
	'UseDOBFilter',
	'DOBRadius',	
	'TestDataEnabled',
	'TestDataTableName',
	'SSNMask',
	'DLMask',
	'DOBMask',
	'IncludeTargusE3220',
	'scores',
	'gateways',
	'IncludeMSoverride',
	'IncludeDLVerification',
	'AttributesVersionRequest',
	'WatchList',
	'IncludeAllRiskIndicators',
	'OutcomeTrackingOptOut'));

/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
	string32 _LoginID           := ''	: STORED('_LoginID');
	string20 CompanyID          := '' : STORED('_CompanyID');
	string20 FunctionName       := '' : STORED('_LogFunctionName');
	string50 ESPMethod          := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion   := '' : STORED('_ESPClientInterfaceVersion');
	string6 ssnmask             := 'NONE' : STORED('SSNMask');
	string6 dobmask	            := 'NONE'	: STORED('DOBMask');
	unsigned1 dlmask            := 0	: STORED('DLMask');
	string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
	string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Business_Risk__InstantID_Service);
/* ************* End Scout Fields **************/

string4	tribcode_value		:= '' : stored('tribcode');
string14	bdid 		:= '' : stored('BDID');
string100	company_name 	:= '' : stored('CompanyName');
string100	alt_Co_Name	:= '' : stored('AlternateCompanyName');
string30	seqnum		:= '' : stored('AccountNumber');
string200	addr			:= '' : stored('Addr');
string30	city			:= '' : stored('City');
string2	state		:= '' : stored('State');
string5	zip			:= '' : stored('Zip');
string10	busphone		:= '' : stored('BusinessPhone');
string9	FEIN			:= '' : stored('TaxIdNumber');
string45	Bus_IP		:= '' : stored('BusinessIPAddress');

Risk_Indicators.Mac_UnparsedFullName(title_val,rep_Fname,rep_Mname,rep_Lname,rep_name_suffix,'RepresentativeFirstName','RepresentativeMiddleName','RepresentativeLastName','RepresentativeNameSuffix');

string120 unparsed_fullname_val := '' : stored('UnParsedFullName');
string200	rep_addr		:= '' : stored('RepresentativeAddr');
string30	rep_city		:= '' : stored('RepresentativeCity');
string2	rep_state		:= '' : stored('RepresentativeState');
string5	rep_zip		:= '' : stored('RepresentativeZip');
string9	rep_ssn		:= '' : stored('RepresentativeSSN');
string8	rep_dob		:= '' : stored('RepresentativeDOB');
integer	rep_age		:= 0  : stored('RepresentativeAge');
string10	rep_phone		:= '' : stored('RepresentativeHomePhone');
string25	rep_dl_num	:= '' : stored('RepresentativeDLNumber');
string2	rep_dl_state	:= '' : stored('RepresentativeDLState');
string100	rep_email		:= '' : stored('RepresentativeEmaiLAddress');
string20	rep_alt_lname	:= '' : stored('RepresentativeFormerLastName');
unsigned1 glb := 0 : stored('GLBPurpose');
unsigned1	dppa			:= 0  : stored('DppaPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean IsPOBoxCompliant := false : STORED('PoBoxCompliance');
boolean ofac_only := true : stored('OfacOnly');
boolean	ExcludeWatchLists  := false   : stored('ExcludeWatchLists');
String OFAC_version_Null := '' 			: stored('OFACversion');
unsigned1 OFAC_version_temp := if(OFAC_version_Null = '', 1, (unsigned1) OFAC_version_Null);
	OFAC_version := if(trim(stringlib.stringtolowercase(_LoginID)) in ['keyxml','keydevxml'], 4, OFAC_version_temp);	// temporary code for Key Bank
boolean Include_Additional_watchlists := FALSE: stored('IncludeAdditionalWatchlists');
boolean Include_Ofac := FALSE: stored('IncludeOfac');
real global_watchlist_threshold_temp := 0 			: stored('GlobalWatchlistThreshold');
	global_watchlist_threshold := Map( trim(stringlib.stringtolowercase(_LoginID)) in ['keyxml','keydevxml'] and global_watchlist_threshold_temp=0  => OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL ,
																		OFAC_version >= 4	and global_watchlist_threshold_temp = 0																											=> OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL,
																		OFAC_version < 4  and global_watchlist_threshold_temp = 0 																										=> OFAC_XG5.Constants.DEF_THRESHOLD_REAL,
																		global_watchlist_threshold_temp);
boolean Test_Data_Enabled := FALSE   : stored('TestDataEnabled');
string20 Test_Data_Table_Name := ''   : stored('TestDataTableName');
boolean use_dob_filter := FALSE :stored('UseDobFilter');
integer2 dob_radius := 2 :stored('DobRadius');
boolean IncludeTargus3220 := false : stored('IncludeTargusE3220');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
string10 exactMatchlevel := risk_indicators.iid_constants.default_ExactMatchLevel;
STRING AttributesVersionRequest := '' : STORED('AttributesVersionRequest');
IncludeRepAttributes := StringLib.StringToUpperCase(AttributesVersionRequest) IN ['BIIDATTRIBUTESV1'];
dob_radius_use := if(use_dob_filter,dob_radius,-1);

gateways_in := Gateway.Configuration.Get();
model_url := dataset([],Models.Layout_Score_Chooser) : STORED('scores',few);

boolean IncludeAllRC := false : stored('IncludeAllRiskIndicators');

#stored('DisableBocaShellLogging', DisableOutcomeTracking);

temp := record
		dataset(iesp.share.t_StringArrayItem) WatchList {xpath('WatchList/Name'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
end;

watchlist_options := dataset([],temp) :stored('WatchList', few);
watchlists_request := watchlist_options[1].WatchList;
boolean IncludeMSoverride := false : stored('IncludeMSoverride');
boolean IncludeDLverification := false : stored('IncludeDLverification');
unsigned1 AppendBest := 1;	// search best file

in_city_name := stringlib.stringtouppercase(city);
in_st		 := stringlib.stringtouppercase(state);
in_z5		 := zip;



Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := map(IncludeTargus3220 and le.servicename = 'targus' => 'targuse3220',	// if E3220 requested, change servicename for later use
													le.servicename = 'bridgerwlc' and OFAC_version <> 4 => '',
													le.servicename);
	self.url := map(IncludeTargus3220 and le.servicename = 'targus' => le.url + '?ver_=1.39',	// need version 1.39 for E3220,
									le.servicename = 'bridgerwlc' and OFAC_version <> 4 => '',
									le.url); 
	self := le;								
end;
gateways := project(gateways_in, gw_switch(left));

String10 ESP_version_temp := '1.000000' : STORED('_espclientinterfaceversion');
Real ESP_version := (REAL)ESP_version_temp;


OFAC_version_from_ESP :=
  MAP(
    ESP_version < 1.039 => 1, 
    ESP_version >= 1.039 and ESP_version < 1.49 => 2, 
    ESP_version >= 1.49 and OFAC_version_Null = '' => 2,
    ESP_version >= 1.49 and OFAC_version < 2 => 2,
    OFAC_version
  );
  
Include_Ofac_from_ESP :=
  MAP(
    ESP_version >= 1.49 => False, // Customers only pick watchlists from the warchlist dataset in these versions of the ESP 
    Include_Ofac
  );
  
Include_Additional_watchlists_from_ESP :=
  MAP(
    ESP_version < 1.039 => FALSE, 
    ESP_version >= 1.49 => False, // Customers only pick watchlists from the warchlist dataset in these versions of the ESP
    Include_Additional_watchlists
  );

ofac_only_from_ESP := 
  MAP(
    ESP_version < 1.039 => TRUE,
    ESP_version >= 1.039 and ESP_version < 1.49 and Include_ofac_from_ESP = True and Include_Additional_watchlists_from_ESP = True => FALSE,
    ESP_version >= 1.039 and ESP_version < 1.49 and Include_ofac_from_ESP = True and Include_Additional_watchlists_from_ESP = False => TRUE,
    ESP_version >= 1.49 => False,
    ofac_only
  );
  
  ExcludeWatchLists_from_ESP :=
  MAP(
  ESP_version >= 1.039 and ESP_version < 1.49 and Include_ofac_from_ESP = False and Include_Additional_watchlists_from_ESP = False => TRUE,
  ExcludeWatchLists
  );
  
/*
  This logic needs to be added when all queries are moved to OFAC version 4. According to notes this logic is to be added only when ESP Version is less than 1.039.
  ESP_Version < 1.039 and ofac_only_from_ESP = TRUE, Include_Ofac_from_ESP = True and Include_Additional_watchlists_from_ESP = False);
  ESP_Version < 1.039 and ofac_only_from_ESP = FALSE, Include_Ofac_from_ESP = True and Include_Additional_watchlists_from_ESP = True);
*/

if( OFAC_version_from_ESP = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

IF( OFAC_version_from_ESP != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(watchlists_request, value),
		FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

foorec := record
	unsigned4	seq := 0;
end;

df := dataset([{1}],foorec);

business_risk.Layout_Input into_input(df L) := transform
	clean_bus_addr := Risk_Indicators.MOD_AddressClean.clean_addr(addr,city,state,zip);
	clean_rep_addr := Risk_Indicators.MOD_AddressClean.clean_addr(rep_addr,rep_city,rep_state,rep_zip);

	
	self.seq := 1;
	self.historydate := history_date;
	self.Account := seqnum;
	self.bdid	:= (integer)bdid;
	self.score := 0;
	self.company_name := stringlib.stringtouppercase(company_name);
	self.alt_company_name := stringlib.stringtouppercase(alt_co_name);
	self.prim_range := clean_bus_addr[1..10];
	self.predir	 := clean_bus_addr[11..12];
	self.prim_name	 := clean_bus_addr[13..40];
	self.addr_suffix := clean_bus_addr[41..44];
	self.postdir	 := clean_bus_addr[45..46];
	self.unit_desig := clean_bus_addr[47..56];
	self.sec_range  := clean_bus_addr[57..64];

	// Cleaned Address pieces
	self.p_city_name := if (clean_bus_addr[65..89] = '', in_city_name, clean_bus_addr[65..89]);
	self.v_city_name := clean_bus_addr[90..114];
	self.st		 := if (clean_bus_addr[115..116] = '', in_st, clean_bus_addr[115..116]);
	self.z5		 := if (clean_bus_addr[117..121] = '', in_z5, clean_bus_addr[117..121]);
	
	
	self.zip4		 := clean_bus_addr[122..125];
	self.orig_z5 	 := in_z5;
	self.lat		 := clean_bus_addr[146..155];
	self.long		 := clean_bus_addr[156..166];
	self.addr_type  :=  risk_indicators.iid_constants.override_addr_type(addr, clean_bus_addr[139],clean_bus_addr[126..129]);
	self.addr_status := clean_bus_addr[179..182];
	self.county := clean_bus_addr[143..145];
	self.geo_blk := clean_bus_addr[171..177];	
	self.fein		 := fein;
	self.phone10    := busphone;
	self.ip_addr	 := bus_ip;
	self.rep_fname	 := stringlib.stringtouppercase(rep_fname);
	self.rep_mname  := stringlib.stringtouppercase(rep_mname);
	self.rep_lname  := stringlib.stringtouppercase(rep_lname);
	self.rep_name_suffix := stringlib.stringtouppercase(rep_name_suffix);
	self.rep_alt_Lname := stringlib.stringtouppercase(rep_alt_lname);
	self.rep_prim_range := clean_rep_addr[1..10];
	self.rep_predir	:= clean_rep_addr[11..12];
	self.rep_prim_name	:= clean_rep_addr[13..40];
	self.rep_addr_suffix := clean_rep_addr[41..44];
	self.rep_postdir	:= clean_rep_addr[45..46];
	self.rep_unit_desig := clean_rep_addr[47..56];
	self.rep_sec_range  := clean_rep_addr[57..64];
	self.rep_p_city_name := clean_rep_addr[65..89];
	self.rep_st		:= clean_rep_addr[115..116];
	self.rep_z5		:= clean_rep_addr[117..121];
	self.rep_orig_city 	:= stringlib.stringtouppercase(rep_city);
	self.rep_orig_st	:=  stringlib.stringtouppercase(rep_state);
	self.rep_orig_z5	:=  rep_zip;
	self.rep_zip4		:= clean_rep_addr[122..125];
	self.rep_lat		:= clean_rep_addr[146..155];
	self.rep_long		:= clean_rep_addr[156..166];
	self.rep_addr_type  := risk_indicators.iid_constants.override_addr_type(rep_addr, clean_rep_addr[139],clean_rep_addr[126..129]); 
	self.rep_addr_status := clean_rep_addr[179..182];
	self.rep_county := clean_rep_addr[143..145];
	self.rep_geo_blk := clean_rep_addr[171..177];	
	self.rep_ssn		:= rep_ssn;
	self.rep_dob		:= rep_dob;
	self.rep_phone		:= rep_phone;
	self.rep_age 		:= (string)rep_age;
	dl_num := stringlib.stringFilterOut(rep_dl_num,'-');
	dl_num2 := stringlib.stringFilterOut(dl_num,' ');
	self.rep_dl_num	:= stringlib.stringtouppercase(dl_num2);
	self.rep_dl_state	:= stringlib.stringtouppercase(rep_dl_state);
	self.rep_email		:= stringlib.stringtouppercase(rep_email);
end;

df2 := project(df,into_input(LEFT));

bsVersion := MAP(
									IncludeRepAttributes => 3, 
																					2
								);

outf := business_risk.InstantID_Function(df2, gateways, if (bdid = '', false, true),dppa,glb,false,false, '',
							ExcludeWatchLists_from_ESP,ofac_only_from_ESP,OFAC_version_from_ESP,Include_Ofac_from_ESP,Include_Additional_watchlists_from_ESP,Global_WatchList_Threshold,
							dob_radius_use,IsPOBoxCompliant,bsVersion,exactMatchLevel, DataRestriction, 
							IncludeMSoverride, IncludeDLverification, watchlists_request, AppendBest, IncludeRepAttributes, IncludeAllRC,
							DataPermission);
				
ret_btest_seed_pre := business_risk.InstantID_Test_Function(Test_Data_Table_Name,rep_fname,rep_lname,FEIN,zip,busphone,company_name, seqnum);

r := RECORD
  unsigned6 Rep_DID := 0;
	business_risk.Layout_Final_Denorm;
	DATASET(Models.Layout_Model) models;
  unsigned2 royalty_type_code_targus;
  string20  royalty_type_targus; 			
  unsigned2 royalty_count_targus; 			 
  unsigned2 non_royalty_count_targus;  
  string20  count_entity_targus;
end;

ret_btest_seed := PROJECT( ret_btest_seed_pre, TRANSFORM( r, SELF := LEFT, SELF := [] ) );

r into_final(outf L) := transform
  self.Rep_DID := L.RepDID;

	self.PRI_seq_1 := if(L.pri1 = '', '', '1');
	self.PRI_seq_2 := if(L.pri2 = '', '', '2');
	self.PRI_seq_3 := if(L.pri3 = '', '', '3');
	self.PRI_seq_4 := if(L.pri4 = '', '', '4');
	self.PRI_seq_5 := if(L.pri5 = '', '', '5');
	self.PRI_seq_6 := if(L.pri6 = '', '', '6');
	self.PRI_seq_7 := if(L.pri7 = '', '', '7');
	self.PRI_seq_8 := if(L.pri8 = '', '', '8');
	self.Rep_PRI_seq_1 := if (L.rep_pri1 = '', '' , '1');
	self.Rep_PRI_seq_2 := if (L.rep_pri2 = '', '' , '2');
	self.Rep_PRI_seq_3 := if (L.rep_pri3 = '', '' , '3');
	self.Rep_PRI_seq_4 := if (L.rep_pri4 = '', '' , '4');
	self.Rep_PRI_seq_5 := if (L.rep_pri5 = '', '' , '5');
	self.Rep_PRI_seq_6 := if (L.rep_pri6 = '', '' , '6');
	self.Watchlist_seq_1 := if(l.watchlist_table='', '', '1');
	self.Watchlist_seq_2 := if(l.watchlist_table_2='', '', '2');
	self.Watchlist_seq_3 := if(l.watchlist_table_3='', '', '3');
	self.Watchlist_seq_4 := if(l.watchlist_table_4='', '', '4');
	self.Watchlist_seq_5 := if(l.watchlist_table_5='', '', '5');
	self.Watchlist_seq_6 := if(l.watchlist_table_6='', '', '6');
	self.Watchlist_seq_7 := if(l.watchlist_table_7='', '', '7');
	self.RepWatchlist_seq_1 := if(l.repwatchlist_table='', '', '1');
	self.RepWatchlist_seq_2 := if(l.repwatchlist_table_2='', '', '2');
	self.RepWatchlist_seq_3 := if(l.repwatchlist_table_3='', '', '3');
	self.RepWatchlist_seq_4 := if(l.repwatchlist_table_4='', '', '4');
	self.RepWatchlist_seq_5 := if(l.repwatchlist_table_5='', '', '5');
	self.RepWatchlist_seq_6 := if(l.repwatchlist_table_6='', '', '6');
	self.RepWatchlist_seq_7 := if(l.repwatchlist_table_7='', '', '7');
	
	self.BusRiskIndicators := l.busriskindicators;
	self.repriskindicators := l.repriskindicators;
	
	self.pri_1 := L.pri1;
	self.pri_desc_1 := if( L.pri1 = '', '', business_risk.Tra_Bus_PRI(L.pri1) );
	self.pri_2 := L.pri2;
	self.pri_desc_2 := if( L.pri2 = '', '', business_risk.Tra_Bus_PRI(L.pri2));
	self.pri_3 := L.pri3;
	self.pri_desc_3 := if( L.pri3 = '', '', business_risk.Tra_Bus_PRI(L.pri3));
	self.pri_4 := L.pri4;
	self.pri_desc_4 := if( L.pri4 = '', '', business_risk.Tra_Bus_PRI(L.pri4));
	self.pri_5 := L.pri5;
	self.pri_desc_5 := if( L.pri5 = '', '', business_risk.Tra_Bus_PRI(L.pri5));
	self.pri_6 := L.pri6;
	self.pri_desc_6 := if( L.pri6 = '', '', business_risk.Tra_Bus_PRI(L.pri6));
	self.pri_7 := L.pri7;
	self.pri_desc_7 := if( L.pri7 = '', '', business_risk.Tra_Bus_PRI(L.pri7));
	self.pri_8 := L.pri8;
	self.pri_desc_8 := if( L.pri8 = '', '', business_risk.Tra_Bus_PRI(L.pri8));
	self.rep_pri_1 := L.rep_pri1;
	self.rep_pri_desc_1 := if (L.rep_pri1 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri1)));
	self.rep_pri_2 := L.rep_pri2;
	self.rep_pri_desc_2 := if (L.rep_pri2 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri2)));
	self.rep_pri_3 := L.rep_pri3;
	self.rep_pri_desc_3 := if (L.rep_pri3 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri3)));
	self.rep_pri_4 := L.rep_pri4;
	self.rep_pri_desc_4 := if (L.rep_pri4 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri4)));
	self.rep_pri_5 := L.rep_pri5;
	self.rep_pri_desc_5 := if (L.rep_pri5 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri5)));
	self.rep_pri_6 := L.rep_pri6;
	self.rep_pri_desc_6 := if (L.rep_pri6 = '', '' , business_risk.Tra_Rep_PRI((L.rep_pri6)));
	self.rep_followup_1 := L.rep_followup1;
	self.rep_followup_desc_1 := business_risk.Tra_Rep_Followups(L.rep_followup1);
	self.rep_followup_2 := L.rep_followup2;
	self.rep_followup_desc_2 := business_risk.Tra_Rep_Followups(L.rep_followup2);
	self.rep_followup_3 := L.rep_followup3;
	self.rep_followup_desc_3 := business_risk.Tra_Rep_Followups(L.rep_followup3);
	self.rep_followup_4 := L.rep_followup4;
	self.rep_followup_desc_4 := business_risk.Tra_Rep_Followups(L.rep_followup4);
	self.bdid := intformat(L.bdid, 12, 1);
	self.score := intformat(L.score, 3, 0);
	self.Account := L.account;
	self.verNotRecentFlag := if (L.verNotRecentFlag, 'Y', 'N');
	self.bestCompanyNameScore := intformat(L.bestCompanyNameScore, 3, 0);
	self.bestAddrScore := intformat(L.bestAddrScore, 3, 0);
	self.bestFEINScore := intformat(L.bestFEINScore, 3, 0);
	self.bestPhoneScore := intformat(L.bestPhoneScore, 3, 0);
	self.dt_first_Seen_min := (String)L.dt_first_seen_min;
	self.dt_last_seen_max := (string)L.dt_last_seen_max;
	//self.watchlist_num_with_name := (string)L.watchlist_num_with_name;
	self.dist_homeAddr_BusAddr := (string)L.dist_homeAddr_BusAddr;
	self.dist_homePhone_BusAddr := (string)L.dist_homePhone_busAddr;
	self.dist_homeAddr_busPhone := (string)L.dist_HomeAddr_BusPhone;
	self.dist_homePhone_BusPhone := (string)L.dist_HomePhone_BusPHone;
	self.dist_homePhone_HomeAddr := (string)L.dist_HomePhone_HomeAddr;
	self.dist_BusPhone_BusAddr	:= (string)L.dist_BusPhone_BusAddr;
	self.Hist_date_last_Seen_1 := (string)L.Hist_date_last_seen_1;
	self.Hist_date_last_Seen_2 := (string)L.Hist_date_last_seen_2;
	self.Hist_date_last_Seen_3 := (string)L.Hist_date_last_seen_3;
	self.repWatchlist_num_with_name := (string)L.repWatchlist_Num_With_Name;
	self.UnreleasedLienCount := intformat(L.unreleasedLienCount,4,0);
	self.ReleasedLienCount  := intformat(L.releasedLienCount,4, 0);
	self.TotalBKCount	:= (string)L.bankruptcy_Count;
	self.addr1 := addr;//address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name, L.addr_suffix, L.postdir, L.unit_desig, L.sec_range);
	// flip around address pieces
	self.p_city_name := stringlib.stringtouppercase(city);
	self.st		 := stringlib.stringtouppercase(state);
	self.z5		 := zip;	
	
	//self.p_city_name := city;
	//self.st := state;
	//self.z5 := zip;
	
	self.zip4 := '';
	self.rep_addr1 := rep_addr; //address.Addr1FromComponents(L.rep_prim_range, L.rep_predir, L.rep_prim_name, L.rep_addr_suffix, L.rep_postdir, L.rep_unit_desig, L.rep_sec_range);
	self.rep_p_city_name := rep_city;
	self.rep_st := rep_state;
	self.rep_z5 := rep_zip;
	self.rep_zip4 := '';
	self.addrmatchphone := L.CmpyPhoneFromAddr;
	//fix zips
		self.verzip := if (L.verzip != '', intformat((integer)L.verzip,5,1),'');
	self.bestZip := if (L.bestZip != '', intformat((integer)L.bestZip,5,1),'');
	self.bestZip4 := if (L.bestZip4 != '', intformat((integer)L.bestZip4,4,1),'');
	self.phoneMatchZip := if (L.phoneMatchZip != '', intformat((integer)L.phoneMatchZip,5,1),'');
	self.phoneMatchZip4 := if (L.phoneMatchZip4 != '', intformat((integer)L.phoneMatchZip4,4,1),'');
	self.FEINMatchZip1 := if (L.FEINMatchZip1 != '', intformat((integer)L.FEINMatchZip1,5,1),'');
	self.FEINMatchZip4_1 := if (L.FEINMatchZip4_1 != '', intformat((integer)L.FEINMatchZip4_1,4,1),'');
	self.FEINMatchZip2 := if (L.FEINMatchZip2 != '', intformat((integer)L.FEINMatchZip2,5,1),'');
	self.FEINMatchZip4_2 := if (L.FEINMatchZip4_2 != '', intformat((integer)L.FEINMatchZip4_2,4,1),'');
	self.FEINMatchZip3 := if (L.FEINMatchZip3 != '', intformat((integer)L.FEINMatchZip3,5,1),'');
	self.FEINMatchZip4_3 := if (L.FEINMatchZip4_3 != '', intformat((integer)L.FEINMatchZip4_3,4,1),'');
	self.RecentBkZip := if (L.RecentBkZip != '', intformat((integer)L.RecentBkZip,5,1),'');
	self.RecentBkZip4 := if (L.RecentBkZip4 != '', intformat((integer)L.RecentBkZip4,4,1),'');
	self.RecentLienZip := if (L.RecentLienZip != '', intformat((integer)L.RecentLienZip,5,1),'');
	self.RecentLienZip4 := if (L.RecentLienZip4 != '', intformat((integer)L.RecentLienZip4,4,1),'');
	self.watchlist_zip := if (L.watchlist_zip != '', intformat((integer)L.watchlist_zip,5,1),'');
	self.RepZipVerify := if (L.RepZipVerify != '', intformat((integer)L.RepZipVerify,5,1),'');
	self.RepZip4Verify := if (L.RepZip4Verify != '', intformat((integer)L.RepZip4Verify,4,1),'');
	self.RepBestZip := if (L.RepBestZip != '', intformat((integer)L.RepBestZip,5,1),'');
	self.RepBestZip4 := if (L.RepBestZip4 != '', intformat((integer)L.RepBestZip4,4,1),'');
	self.RepPhoneZip := if (L.RepPhoneZip != '', intformat((integer)L.RepPhoneZip,5,1),'');
	self.RepPhoneZip4 := if (L.RepPhoneZip4 != '', intformat((integer)L.RepPhoneZip4,4,1),'');
	self.RepWatchlist_zip := if (L.RepWatchlist_zip != '', intformat((integer)L.RepWatchlist_zip,5,1),'');
	self.Hist_Zip_1 := if (L.Hist_Zip_1 != '', intformat((integer)L.Hist_Zip_1,5,1),'');
	self.Hist_Zip4_1 := if (L.Hist_Zip4_1 != '', intformat((integer)L.Hist_Zip4_1,4,1),'');
	self.Hist_Zip_2 := if (L.Hist_Zip_2 != '', intformat((integer)L.Hist_Zip_2,5,1),'');
	self.Hist_Zip4_2 := if (L.Hist_Zip4_2 != '', intformat((integer)L.Hist_Zip4_2,4,1),'');
	self.Hist_Zip_3 := if (L.Hist_Zip_3 != '', intformat((integer)L.Hist_Zip_3,5,1),'');
	self.Hist_Zip4_3 := if (L.Hist_Zip4_3 != '', intformat((integer)L.Hist_Zip4_3,4,1),'');	
	self.areacodesplitdate := if(l.areacodesplitflag='Y', l.areacodesplitdate, '');
	self.altareacode := if(l.areacodesplitflag='Y', l.altareacode, '');
	
	self.Alt_Fname_1				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Fname_1, '');
	self.Alt_Lname_1				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Lname_1, '');
	self.Alt_Date_Last_Seen_1		:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Date_Last_Seen_1, '');
	self.Alt_Fname_2				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Fname_2, '');
	self.Alt_Lname_2				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Lname_2, '');
	self.Alt_Date_Last_Seen_2		:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Date_Last_Seen_2, '');
	self.Alt_Fname_3				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Fname_3, '');
	self.Alt_Lname_3				:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Lname_3, '');
	self.Alt_Date_Last_Seen_3		:= if((integer)l.RepNas_Score IN [4,7,9,10,11,12], l.Alt_Date_Last_Seen_3, '');		
	                   
	SELF.RepSSNValid := L.valid_ssn;									 
	
	self.models := [];
	self := l;
end;

out_unchecked := project(outf, into_final(LEFT));

biid := if(Test_Data_Enabled, ret_btest_seed, out_unchecked);


// Create input dataset to be passed to Score_Controller
business_risk.Layout_Business_Advisor_In scoredata(df le) := TRANSFORM
	SELF.AccountNumber := seqnum;
	SELF.BDID := bdid;
	SELF.CompanyName := company_name;
	SELF.AlternateCompanyName := alt_Co_name;
	SELF.Addr := addr;
	SELF.City := city;
	SELF.State := state;
	SELF.Zip := zip;
	SELF.BusinessPhone := busphone;
	SELF.TaxIDNumber := FEIN;
	SELF.BusinessIPAddress := Bus_IP;
				
	SELF.RepresentativeFirstName := rep_Fname;
	SELF.RepresentativeMiddleName := rep_Mname;
	SELF.RepresentativeLastName := rep_Lname;
	SELF.RepresentativeNameSuffix := rep_name_suffix;
	SELF.RepresentativeAddr := rep_addr;
	SELF.RepresentativeCity := rep_city;
	SELF.RepresentativeState := rep_state;
	SELF.RepresentativeZip := rep_zip;
	SELF.RepresentativeSSN := rep_ssn;
	SELF.RepresentativeDOB := rep_dob;
	SELF.RepresentativeAge := (string)rep_age;
	SELF.RepresentativeDLNumber := rep_dl_num;
	SELF.RepresentativeDLState := rep_dl_state;
	SELF.RepresentativeHomePhone := rep_phone;
	SELF.RepresentativeEmailAddress := rep_email;
	SELF.RepresentativeFormerLastName := rep_alt_lname;

	SELF.DPPAPurpose         := dppa;
	SELF.GLBPurpose          := glb;
	SELF.HistoryDateYYYYMM   := history_date;
	SELF.OfacOnly            := ofac_only_from_ESP;
	SELF.ExcludeWatchLists   := ExcludeWatchLists_from_ESP;
	SELF.OfacVersion         := OFAC_version_from_ESP;
	SELF.IncludeAdditionalWatchlists := Include_Additional_watchlists_from_ESP;
	SELF.IncludeOFAC         := Include_Ofac_from_ESP;
	SELF.GlobalWatchListThreshold := Global_WatchList_Threshold;
	SELF.UseDOBFilter         := use_dob_filter;
	SELF.DOBRadius            := dob_radius;
	
	self.testdataenabled := Test_Data_Enabled;
	self.TestDataTableName := Test_Data_Table_Name;

	self.DataRestrictionMask := DataRestriction;
	self.ExactMatchLevel := ExactMatchLevel;
  self.gateways := PROJECT(gateways_in, Risk_Indicators.Layout_Gateways_In);
	SELF := [];
END;

// Pass the input dataset to the Score Controller (if necessary)
soapcall_request_date := PROJECT(df,scoredata(LEFT));

scores := IF(EXISTS(model_url),Business_Risk.Score_Controller(model_url,soapcall_request_date));

r combo(r le, scores ri) := TRANSFORM
	SELF.models := ri.models;
	self.recordcount := count(biid);	// add recordcount for logging by ESP
	SELF := le;
	SELF := [];
END;

nugen := JOIN(biid, scores, LEFT.Account=RIGHT.AccountNumber, combo(LEFT,RIGHT), LEFT OUTER, PARALLEL);


// normal business instantid ends here...  (used by ws_Identity ESP for accurint.com)

// everything below this line is to modify the service for BD1O-BD1I-0001 (2x42 - delivered via ws_Riskwise ESP/protocolX)
risk_indicators.layout_input into_rep(df l) := transform
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(Rep_Addr, Rep_City, Rep_State, Rep_Zip);
	
	
	ssn_val := Rep_SSN;
	hphone_val := riskwise.cleanphone(Rep_Phone); 
	wphone_val := riskwise.cleanphone(busphone); 
	dob_val := riskwise.cleandob(Rep_DOB); 
	dl_num_clean := riskwise.cleanDL_num(rep_dl_num);

	self.seq := l.seq;
	
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.age := if (Rep_Age = 0 and (integer)dob_val != 0, (STRING3)ut.Age((integer)dob_val), (string3)Rep_Age);
	self.phone10 := hphone_val;
	self.wphone10 := wphone_val;
	
	self.fname := stringlib.stringtouppercase(Rep_fName);
	self.mname := stringlib.stringtouppercase(Rep_MName);
	self.lname := stringlib.stringtouppercase(Rep_LName);
	self.suffix := stringlib.stringtouppercase(Rep_Name_Suffix);
	
	SELF.in_streetAddress := Rep_Addr;
	SELF.in_city := Rep_City;
	SELF.in_state := Rep_State;
	SELF.in_zipCode := Rep_Zip;

	SELF.in_country := '';
	
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..64];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := IF(clean_a2[117..121]<>'',clean_a2[117..121],Rep_Zip);		// use the input zip if cass zip is empty
	self.zip4 := IF(clean_a2[122..125]<>'', clean_a2[122..125], '');	
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];	
	
	self.country := '';
	
	SELF.dl_number := stringlib.stringtouppercase(dl_num_clean);
	SELF.dl_state := stringlib.stringtouppercase(Rep_DL_State);
	
	SELF.email_address := Rep_Email;
	SELF.ip_address := Bus_IP;
	
	SELF.employer_name := stringlib.stringtouppercase(Company_Name);
	SELF.lname_prev := stringlib.stringtouppercase(alt_Co_Name);
end;
rep_input := PROJECT(df,into_rep(LEFT));

tribCode := StringLib.StringToLowerCase(tribCode_value);

// To avoid running risk_indicators.InstantID_Function( ) unnecessarily in business_risk.BIDO_Function
// --which has caused performance issues--blank out the search criteria unless tribcode = '2x42'.
addr_bido      := IF( tribcode = '2x42', addr, '' );
city_bido      := IF( tribcode = '2x42', city, '' );
state_bido     := IF( tribcode = '2x42', state, '' );
zip_bido       := IF( tribcode = '2x42', zip, '' );
outf_bido      := IF( tribcode = '2x42', outf, DATASET( [], business_risk.Layout_Output) );
rep_input_bido := IF( tribcode = '2x42', rep_input, DATASET( [], risk_indicators.Layout_Input) );
gateways_bido  := IF( tribcode = '2x42', gateways, DATASET( [], Gateway.Layouts.Config ) );

bido := business_risk.BIDO_Function(tribcode, test_data_enabled, addr_bido, city_bido, state_bido, zip_bido,
									outf_bido, rep_input_bido, gateways_bido, dppa, glb, ofac_only_from_ESP,
									ExcludeWatchLists_from_ESP, OFAC_version_from_ESP, Include_Ofac_from_ESP, Include_Additional_watchlists_from_ESP,
									global_watchlist_threshold, dob_radius_use,bsVersion,
									exactMatchLevel:=exactMatchLevel, 
									DataRestriction:=DataRestriction,
									DataPermission:=DataPermission);

final := if(tribcode='2x42', bido, nugen);

dl_mask_value := dlmask=1;
Suppress.MAC_Mask(final, post_ssn_mask1, repssnverify, '', true, false, false, false, '', ssnmask);
Suppress.MAC_Mask(post_ssn_mask1, post_ssn_mask2, repbestssn, rep_verDL, true, true, false, false, '', ssnmask);

layout_out := { r AND NOT [royalty_type_code_targus, royalty_type_targus, royalty_count_targus, non_royalty_count_targus, count_entity_targus] };

unsigned1 dob_mask_value := Suppress.date_mask_math.MaskIndicator (dobmask);
layout_out mask_dobs(r le) := transform
	self.RepDOBVerify := risk_indicators.iid_constants.mask_dob(le.RepDOBVerify, dob_mask_value);
	self.RepBestDOB := risk_indicators.iid_constants.mask_dob(le.RepBestDOB, dob_mask_value);
	self.rep_deceasedDate := risk_indicators.iid_constants.mask_dob(le.rep_deceasedDate, dob_mask_value);
	self.rep_deceasedDOB := risk_indicators.iid_constants.mask_dob(le.rep_deceasedDOB, dob_mask_value);
	self := le;
end;

post_dob_masking := project(post_ssn_mask2,mask_dobs(left));

intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');

//Log to Deltabase
Deltabase_Logging_prep := project(final, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
                                                  self.company_id := (Integer)CompanyID,
                                                  self.login_id := _LoginID,
                                                  self.product_id := Risk_Reporting.ProductID.Business_Risk__InstantID_Service,
                                                  self.function_name := FunctionName,
                                                  self.esp_method := ESPMethod,
                                                  self.interface_version := InterfaceVersion,
                                                  self.delivery_method := DeliveryMethod,
                                                  self.date_added := (STRING8)Std.Date.Today(),
                                                  self.death_master_purpose := DeathMasterPurpose,
                                                  self.ssn_mask := ssnmask,
                                                  self.dob_mask := dobmask,
                                                  self.dl_mask := (String)dlmask,
                                                  self.exclude_dmv_pii := ExcludeDMVPII,
                                                  self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
                                                  self.archive_opt_in := ArchiveOptIn,
                                                  self.glb := glb,
                                                  self.dppa := dppa,
                                                  self.data_restriction_mask := DataRestriction,
                                                  self.data_permission_mask := DataPermission,
                                                  self.industry := Industry_Search[1].Industry,
                                                  self.i_attributes_name := AttributesVersionRequest,
                                                  self.i_ssn := rep_ssn,
                                                  self.i_dob := rep_dob;
                                                  self.i_name_full := unparsed_fullname_val,
                                                  self.i_name_first := rep_Fname,
                                                  self.i_name_last := rep_Lname,
                                                  self.i_address := rep_addr,
                                                  self.i_city := rep_city,
                                                  self.i_state := rep_state,
                                                  self.i_zip := rep_zip,
                                                  self.i_dl := rep_dl_num,
                                                  self.i_dl_state := rep_dl_state,
                                                  self.i_home_phone := rep_phone,
                                                  self.i_tin := FEIN,
                                                  self.i_bus_name := company_name,
                                                  self.i_alt_bus_name := alt_Co_Name,
                                                  self.i_bus_address := addr,
                                                  self.i_bus_city := city,
                                                  self.i_bus_state := state,
                                                  self.i_bus_zip := zip,
                                                  self.i_bus_phone := busphone,
                                                  self.i_model_name_1 := 'BVI',
                                                  self.i_model_name_2 := 'CVI',
                                                  self.o_score_1    := (Integer)left.BVI, //bvi
                                                  self.o_reason_1_1 := left.PRI_1,
                                                  self.o_reason_1_2 := left.PRI_2,
                                                  self.o_reason_1_3 := left.PRI_3,
                                                  self.o_reason_1_4 := left.PRI_4,
                                                  self.o_reason_1_5 := left.PRI_5,
                                                  self.o_reason_1_6 := left.PRI_6,
                                                  self.o_score_2    := (Integer)left.RepCVI, //rep cvi
                                                  self.o_reason_2_1 := left.Rep_PRI_1,
                                                  self.o_reason_2_2 := left.Rep_PRI_2,
                                                  self.o_reason_2_3 := left.Rep_PRI_3,
                                                  self.o_reason_2_4 := left.Rep_PRI_4,
                                                  self.o_reason_2_5 := left.Rep_PRI_5,
                                                  self.o_reason_2_6 := left.Rep_PRI_6,
                                                  self.o_lexid      := left.Rep_DID,
                                                  self.o_bdid       := left.bdid,
                                                  self := left,
                                                  self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);


// Can't name this otherwise the ESP fails...
 OUTPUT(post_dob_masking);

// Note: All intermediate logs must have the following name schema:
// Starts with 'LOG_' (Upper case is important!!)
// Middle part is the database name, in this case: 'log__mbs'
// Must end with '_intermediate__log'
IF(~DisableOutcomeTracking and ~test_data_enabled, OUTPUT(intermediateLog, NAMED('LOG_log__mbs_intermediate__log')) );

//Improved Scout Logging
IF(~DisableOutcomeTracking and ~test_data_enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

// Output Royalties
dRoyalties_bido := 
  PROJECT(
    bido,
    TRANSFORM( Royalty.Layouts.Royalty,
      SELF.royalty_type_code := LEFT.royalty_type_code_targus;
      SELF.royalty_type      := LEFT.royalty_type_targus;
      SELF.royalty_count     := LEFT.royalty_count_targus;
      SELF.non_royalty_count := LEFT.non_royalty_count_targus;
      SELF.count_entity      := LEFT.count_entity_targus;
    )
  );

dRoyalties_empty := 
  DATASET(
    1,
    TRANSFORM( Royalty.Layouts.Royalty,
      SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.TARGUS;
      SELF.royalty_type      := Royalty.Constants.RoyaltyType.TARGUS;
      SELF.royalty_count     := 0;
      SELF.non_royalty_count := 0;
      SELF.count_entity      := '';
    )
  );

dRoyalties := IF( tribcode = '2x42', dRoyalties_bido, dRoyalties_empty );

output(dRoyalties, named('RoyaltySet'));

endmacro;

// Business_Risk.InstantID_Service();