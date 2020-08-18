/*--SOAP--
<message name="BusinessAdvisorService">
 	<part name="AccountNumber" 				type="xsd:string"/>
	<part name="BDID" 						type="xsd:string"/>
	<part name="CompanyName" 				type="xsd:string"/>
	<part name="AlternateCompanyName" 			type="xsd:string"/>
	<part name="Addr"						type="xsd:string"/>
	<part name="City"						type="xsd:string"/>
	<part name="State" 						type="xsd:string"/>
	<part name="Zip"						type="xsd:string"/>
	<part name="BusinessPhone"				type="xsd:string"/>
	<part name="TaxIDNumber" 				type="xsd:string"/>
	<part name="BusinessIPAddress" 			type="xsd:string"/>
				
	<part name="RepresentativeFirstName" 		type="xsd:string"/>
	<part name="RepresentativeMiddleName" 		type="xsd:string"/>
	<part name="RepresentativeLastName" 		type="xsd:string"/>
	<part name="RepresentativeNameSuffix"		type="xsd:string"/>
	<part name="RepresentativeAddr"			type="xsd:string"/>
	<part name="RepresentativeCity"			type="xsd:string"/>
	<part name="RepresentativeState" 			type="xsd:string"/>
	<part name="RepresentativeZip"			type="xsd:string"/>
	<part name="RepresentativeSSN"			type="xsd:string"/>
	<part name="RepresentativeDOB" 			type="xsd:string"/>
	<part name="RepresentativeAge"			type="xsd:string"/>
	<part name="RepresentativeDLNumber"		type="xsd:string"/>
	<part name="RepresentativeDLState"			type="xsd:string"/>
	<part name="RepresentativeHomePhone" 		type="xsd:string"/>
	<part name="RepresentativeEmailAddress" 	type="xsd:string"/>
	<part name="RepresentativeFormerLastName" 	type="xsd:string"/>
	
	<part name="DPPAPurpose"					type="xsd:byte"/>
	<part name="GLBPurpose" 					type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" 				type="xsd:string"/>
	<part name="LnBranded"					type="xsd:boolean"/>
	<part name="HistoryDateYYYYMM" 			type="xsd:integer"/>
	<part name="OfacOnly"					type="xsd:boolean"/>

	<part name="PoBoxCompliance" type="xsd:boolean"/>	
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>  
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>	
	
	<part name="gateways"					type="tns:XmlDataSet" cols="70" rows="25"/>
 </message>
*/
/*--INFO--  */

import ut, doxie, seed_files, risk_indicators, riskwise, business_risk,Gateway, AutoStandardI, STD, Models;
 
export BusinessAdvisor_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);


#WEBSERVICE(FIELDS(
	'AccountNumber',
	'BDID',
	'CompanyName',
	'AlternateCompanyName',
	'Addr',
	'City',
	'State',
	'Zip',
	'BusinessPhone',
	'TaxIDNumber',
	'BusinessIPAddress',

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
	'IndustryClass',
	'LnBranded',
	'HistoryDateYYYYMM',
	'OfacOnly',

	'PoBoxCompliance',
	'ExcludeWatchLists',
	'OFACversion',
	'IncludeOfac',
	'GlobalWatchlistThreshold',
	'IncludeAdditionalWatchLists',
	'UseDOBFilter',
	'DOBRadius',	
	'TestDataEnabled',
	'TestDataTableName',	

	'gateways',
    'LexIdSourceOptout',
    '_TransactionId',
    '_BatchUID',
    '_GCID'));


string30 AccountNumber_value := '' 			: stored('AccountNumber');
string14 BDID_value		    := ''				: stored('BDID');
string100 Company_Name  	    := ''      		: stored('CompanyName');
string100 Alt_Co_Name   	    := '' 	    		: stored('AlternateCompanyName');
string200 Addr := ' '		 				: stored('Addr');
string30 City  := ''      	 	   			: stored('City');
string2  State  := ''      	    			     : stored('State');
string5  Zip  := ''      				     : stored('Zip');
string10 Busphone_value := ''		 			: stored('BusinessPhone');
string9  FEIN:= '' 			 				: stored('TaxIDNumber');
string45 Bus_IP         := ''					: stored('BusinessIPAddress');
   
string20 Rep_Fname := ''     	: stored('RepresentativeFirstName');
string20 Rep_Mname := ''    	: stored('RepresentativeMiddleName');
string20 Rep_Lname := ''     	: stored('RepresentativeLastName');
string5  Rep_name_Suffix := ''    	: stored('RepresentativeNameSuffix');
string200 Rep_Addr  				:= ''     	: stored('RepresentativeAddr');
string30 Rep_City  				:= ''      	: stored('RepresentativeCity');
string2  Rep_State  := ''      	: stored('RepresentativeState');
string5  Rep_Zip  := ''      		: stored('RepresentativeZip');
string9  Rep_SSN  := ''     		: stored('RepresentativeSSN');
string8  Rep_DOB  := ''      		: stored('RepresentativeDOB');
Integer  Rep_Age := 0     	 	: stored('RepresentativeAge');
STRING25 Rep_dl_num		 := ''     	: stored('RepresentativeDLNumber');
STRING2  Rep_dl_state     := ''    	: stored('RepresentativeDLState');
string10 Rep_Phone				:=''		: stored('RepresentativeHomePhone');
string100 Rep_Email 			:= '' 	: stored('RepresentativeEmailAddress');
string20 Rep_alt_lname			 :=''  : stored('RepresentativeFormerLastName'); 

unsigned1 DPPA_Purpose := 0 		: stored('DPPAPurpose');
unsigned1 GLB_Purpose := AutoStandardI.Constants.GLBPurpose_default : stored('GLBPurpose');
 
STRING5 industry_class_val := '' 	: STORED('IndustryClass');
industry_class_value 			:= STD.Str.toUpperCase(industry_class_val);
boolean ln_branded_value := false 	: STORED('LnBranded');
unsigned3 history_date := 999999 	: stored('HistoryDateYYYYMM');
boolean IsPOBoxCompliant := false : STORED('PoBoxCompliance');
boolean ofac_only := true 		: stored('OfacOnly');

//
boolean   excludewatchlists := false    : stored('ExcludeWatchLists');
unsigned1 OFACVersion       := 1        : stored('OFACVersion');
boolean   IncludeOfac       := false    : stored('IncludeOfac');
real      gwThreshold       := 0.84     : stored('GlobalWatchlistThreshold');
boolean   addtl_watchlists  := false    : stored('IncludeAdditionalWatchLists');
boolean   usedobFilter       := false    : stored('UseDOBFilter');
integer2  dobradius0         := 2       : stored('DOBRadius');
// match default settings it was using before adding the dataRestriction
integer bsVersion := 1;
boolean runSSNCodes:=true;
boolean runBestAddrCheck:=true; 
boolean runChronoPhoneLookup:=true;	
boolean runAreaCodeSplitSearch:=true;
boolean allowCellphones:=false;
string10 ExactMatchLevel := risk_indicators.iid_constants.default_ExactMatchLevel;
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

string10 CustomDataFilter:='';
//

boolean   Test_Data_Enabled := false   	: stored('TestDataEnabled');
string20  Test_Data_Table_Name := ''   	: stored('TestDataTableName');

dobradius:= if(usedobFilter,dobradius0,-1);
gateways := Gateway.Configuration.Get();

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');


if( OFACVersion = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

// constants
	suppressNearDups := true;
	require2Ele      := false;
	from_biid        := true;
	isFCRA           := false;
	from_IT1O        := false;
//

r := record
	unsigned4 seq;
end;
d := dataset([{1}],r);

//
//project representative data into bocashell
//

risk_indicators.Layout_Input into(d l) := transform
	self.historydate := history_date;
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(Rep_Addr, Rep_City, Rep_State, Rep_Zip);
	
	//ssn_val := riskwise.cleanssn(Rep_SSN);
	hphone_val := riskwise.cleanphone(Rep_Phone); 
	wphone_val := riskwise.cleanphone(Busphone_value); 
	dob_val := riskwise.cleandob(Rep_DOB); 
	dl_num_clean := riskwise.cleanDL_num(rep_dl_num);

	self.seq := l.seq;
	
	self.ssn := Rep_SSN;
	self.dob := dob_val;
	self.age := if (Rep_Age = 0 and (integer)dob_val != 0, (STRING3)ut.Age((integer)dob_val), (string3)Rep_Age);
	self.phone10 := hphone_val;
	self.wphone10 := wphone_val;
	
	self.fname := STD.Str.toUpperCase(Rep_fName);
	self.mname := STD.Str.toUpperCase(Rep_MName);
	self.lname := STD.Str.toUpperCase(Rep_LName);
	self.suffix := STD.Str.toUpperCase(Rep_Name_Suffix);
	
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
	
	SELF.dl_number := STD.Str.toUpperCase(dl_num_clean);
	SELF.dl_state := STD.Str.toUpperCase(Rep_DL_State);
	
	SELF.email_address := Rep_Email;
	SELF.ip_address := Bus_IP;
	
	SELF.employer_name := STD.Str.toUpperCase(Company_Name);
	SELF.lname_prev := STD.Str.toUpperCase(alt_Co_Name);
end;
prep := PROJECT(d,into(LEFT));


iid := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, Doxie.Compliance.isUtilityRestricted(industry_class_value), ln_branded_value, ofac_only,
	suppressNearDups, require2Ele, from_biid, isFCRA, excludewatchlists, from_IT1O, OFACVersion, IncludeOfac, addtl_watchlists, gwThreshold, dobradius,
	bsversion, runSSNCodes, runBestAddrCheck, runChronoPhoneLookup, runAreaCodeSplitSearch, allowcellphones,
	exactMatchLevel,DataRestriction,CustomDataFilter,in_DataPermission:=DataPermission, LexIdSourceOptout := LexIdSourceOptout, 
    TransactionID := TransactionID, BatchUID := BatchUID, GlobalCompanyID := GlobalCompanyID
);//check parameters here


clam := risk_indicators.Boca_Shell_Function(iid, gateways, DPPA_Purpose, GLB_Purpose, Doxie.Compliance.isUtilityRestricted(industry_class_value), ln_branded_value, false, false, false, true, DataRestriction:=DataRestriction, DataPermission:=DataPermission,
                                                                              LexIdSourceOptout := LexIdSourceOptout, 
                                                                              TransactionID := TransactionID, 
                                                                              BatchUID := BatchUID, 
                                                                              GlobalCompanyID := GlobalCompanyID);


business_risk.Layout_Input into_input(d L) := transform
	self.historydate := history_date;
  clean_bus_addr := Risk_Indicators.MOD_AddressClean.clean_addr(addr, city,state,zip);
	clean_rep_addr	:= Risk_Indicators.MOD_AddressClean.clean_addr(rep_addr, rep_city,rep_state,rep_zip);
	
	self.seq := l.seq;
	self.Account := AccountNumber_value;
	self.bdid	:= (integer)BDID_value;
	self.score := 0;
	self.company_name := STD.Str.toUpperCase(company_name);
	self.alt_company_name := STD.Str.toUpperCase(alt_co_name);
	self.prim_range := clean_bus_addr[1..10];
	self.predir	 := clean_bus_addr[11..12];
	self.prim_name	 := clean_bus_addr[13..40];
	self.addr_suffix := clean_bus_addr[41..44];
	self.postdir	 := clean_bus_addr[45..46];
	self.unit_desig := clean_bus_addr[47..56];
	self.sec_range  := clean_bus_addr[57..64];
	self.p_city_name := clean_bus_addr[65..89];
	self.v_city_name := clean_bus_addr[90..114];
	self.st		 := clean_bus_addr[115..116];
	self.z5		 := clean_bus_addr[117..121];	
	self.zip4		 := clean_bus_addr[122..125];
	self.orig_z5 	 := zip;
	self.lat		 := clean_bus_addr[146..155];
	self.long		 := clean_bus_addr[156..166];
	self.addr_type  := clean_bus_addr[139];
	self.addr_status := clean_bus_addr[179..182];
	self.county := clean_bus_addr[143..145];
	self.geo_blk := clean_bus_addr[171..177];
	self.fein		 := fein;
	self.phone10    := Busphone_value;
	self.ip_addr	 := bus_ip;
	self.rep_fname	 := STD.Str.toUpperCase(rep_fname);
	self.rep_mname  := STD.Str.toUpperCase(rep_mname);
	self.rep_lname  := STD.Str.toUpperCase(rep_lname);
	self.rep_name_suffix := STD.Str.toUpperCase(rep_name_suffix);
	self.rep_alt_Lname := STD.Str.toUpperCase(rep_alt_lname);
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
	self.rep_orig_city 	:= STD.Str.toUpperCase(rep_city);
	self.rep_orig_st	:=  STD.Str.toUpperCase(rep_state);
	self.rep_orig_z5	:=  rep_zip;
	self.rep_zip4		:= clean_rep_addr[122..125];
	self.rep_lat		:= clean_rep_addr[146..155];
	self.rep_long		:= clean_rep_addr[156..166];
	self.rep_addr_type  := clean_rep_addr[139];
	self.rep_addr_status := clean_rep_addr[179..182];
	self.rep_ssn		:= rep_ssn;
	self.rep_dob		:= rep_dob;
	self.rep_phone		:= rep_phone;
	self.rep_age 		:= (string)rep_age;
	self.rep_dl_num	:= rep_dl_num;
	self.rep_dl_state	:= STD.Str.toUpperCase(rep_dl_state);
	self.rep_email		:= STD.Str.toUpperCase(rep_email);
end;

df2 := project(d,into_input(LEFT));

business_risk.Layout_Input into_test_input(d L) := transform
	self.company_name := STD.Str.toUpperCase(company_name);
	self.z5		 := Zip;	
	self.fein		 := fein;
	self.phone10    := Busphone_value;
	self.rep_fname	 := STD.Str.toUpperCase(rep_fname);
	self.rep_lname  := STD.Str.toUpperCase(rep_lname);

end;

test_input := project(d,into_test_input(LEFT));

isUtility  := false;
ln_branded := false;
tribcode   := '';
biid := business_risk.InstantID_Function(df2, gateways, if (bdid_value = '', false, true),dppa_purpose,glb_purpose,isUtility,ln_branded, tribcode, ExcludeWatchLists,
	ofac_only, OFACVersion, IncludeOfac, addtl_watchlists, gwThreshold, dobradius, IsPOBoxCompliant, DataRestriction := DataRestriction, DataPermission:= DataPermission, LexIdSourceOptout := LexIdSourceOptout, 
                                                                                        TransactionID := TransactionID, 
                                                                                        BatchUID := BatchUID, 
                                                                                        GlobalCompanyID := GlobalCompanyID
);

/*
	DATASET(Layout_Input) inf
	dataset(risk_indicators.Layout_Gateways_In) gateways
	boolean hasbdids = false
	unsigned1 dppa
	unsigned1 glb
	boolean isUtility=false
	boolean ln_branded=false
	string4 tribcode=''
	unsigned3 history_date=999999
	boolean ExcludeWatchLists = false
	boolean ofac_only=false
	unsigned1 ofac_version=1
	boolean include_ofac=FALSE
	boolean include_additional_watchlists=FALSE
	real Global_WatchList_Threshold =.84
	dob_range = -1
*/

riskwise.Layout_BusReasons_Input into_orig_input(biid le) := transform
	self.seq := le.seq;
	self.orig_addr := STD.Str.toUpperCase(addr);
	self.orig_city := STD.Str.toUpperCase(city);
	self.orig_state := STD.Str.toUpperCase(state);
	self.orig_zip := zip;
	self.orig_fax := '';
	self.orig_cmpy := STD.Str.toUpperCase(company_name);
	self.orig_wphone := busphone_value;
	self.telcoPhoneType := le.TelcordiaPhoneType;
	
	bans_current := if(((integer)((STRING8)Std.Date.Today()[1..6]) - (integer)(le.RecentBkDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	lien_current := if(((integer)((STRING8)Std.Date.Today()[1..6]) - (integer)(le.RecentLienDate[1..6])) < 1000, true, false);  // make sure the bans is within the last 10 years
	self.cmpy_bans :=  map(fein='' or (company_name='' and addr='') => '3',
											  le.bkbdidflag and le.lienbdidflag and bans_current and lien_current => '5',
										       le.bkbdidflag and bans_current => '2', 
											  le.lienbdidflag and lien_current => '4',
						   					   '0');								   
end;

orig_input := project(biid, into_orig_input(left));


nugen := true;
ret  := Models.BD3605_0_0    (clam, biid, orig_input, ofac_only, nugen, addtl_watchlists);
ret2 := Models.BD5605_0_0    (clam, biid, orig_input, ofac_only, nugen, addtl_watchlists);
ret3 := Models.BD9605_generic(clam, biid, orig_input, ofac_only, nugen, addtl_watchlists);



models.Layout_Reason_Codes form_rc(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[1].hri <> '00', le.ri[1].hri, '');
	SELF.reason_description := le.ri[1].desc;
end;
models.Layout_Reason_Codes form_rc2(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[2].hri <> '00', le.ri[2].hri, '');
	SELF.reason_description := le.ri[2].desc;
end;
models.Layout_Reason_Codes form_rc3(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[3].hri <>'00', le.ri[3].hri, '');
	SELF.reason_description := le.ri[3].desc;
end;
models.Layout_Reason_Codes form_rc4(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[4].hri <> '00', le.ri[4].hri, '');
	SELF.reason_description := le.ri[4].desc;
end;


models.Layout_Score form_cscore(ret le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '0 to 999';
	reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
END;
models.Layout_Score form_cscore2(ret2 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '10 to 50';
	reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
END;
models.Layout_Score form_cscore3(ret3 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '10 to 90';
	reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
END;

testrec := record
	unsigned seq;
	models.layout_model;
end;

testrec form_model(ret le, ret2 ri) := TRANSFORM
	self.seq := le.seq;
	self.accountnumber := accountnumber_value;
	self.description := 'BusinessDefender';
	self.scores := PROJECT(le,form_cscore(LEFT)) + PROJECT(ri,form_cscore2(LEFT));
END;

final := join(ret,ret2,left.seq=right.seq, form_model(LEFT,RIGHT));

models.Layout_Model form_model2(final le, ret3 ri) := TRANSFORM
	self.accountnumber := le.accountnumber;
	self.description := le.description;
	self.scores := le.scores + PROJECT(ri,form_cscore3(LEFT));
END;
final2 := join(final,ret3,left.seq=right.seq, form_model2(LEFT,RIGHT));

/* TURN OFF TEST SEEDS - DEBUG ONLY :: comment out the next 3 lines of code, and comment in the 'final2' output. */
bd_seed_scores := seed_files.GetBusinessDefender(test_input, AccountNumber_value, Test_Data_Table_Name);
final_out := if(Test_Data_Enabled, bd_seed_scores, final2);

OUTPUT(final_out,NAMED('Results'));
// OUTPUT(final2,NAMED('Results'));  //When this line is active, test seeds are not included in the compiled code.

ENDMACRO;
// Models.BusinessAdvisor_Service()
