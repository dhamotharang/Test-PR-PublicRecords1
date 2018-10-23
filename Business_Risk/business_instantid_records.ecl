import address, doxie, risk_indicators, models, business_risk, Business_Header,Gateway;

Business_Header.doxie_MAC_Field_Declare()

string4	tribcode_value := '' : stored('tribcode');
string100 alt_Co_Name := '' : stored('AlternateCompanyName');
string30 seqnum := '' : stored('AccountNumber');
string200 addr := addr_value;
string30 city := city_val;
string2 state := state_val;
string5 zip := zip_val;
string10 busphone := '' : stored('BusinessPhone');
string9 FEIN := '' : stored('TaxIdNumber');
string45 Bus_IP := '' : stored('BusinessIPAddress');

Risk_Indicators.Mac_UnparsedFullName(title_val,rep_Fname,rep_Mname,rep_Lname,rep_name_suffix,'RepresentativeFirstName','RepresentativeMiddleName','RepresentativeLastName','RepresentativeNameSuffix');

string200 rep_addr := '' : stored('RepresentativeAddr');
string30 rep_city := '' : stored('RepresentativeCity');
string2 rep_state := '' : stored('RepresentativeState');
string5 rep_zip := '' : stored('RepresentativeZip');
string9 rep_ssn := '' : stored('RepresentativeSSN');
string8 rep_dob := '' : stored('RepresentativeDOB');
integer rep_age := 0  : stored('RepresentativeAge');
string10 rep_phone := '' : stored('RepresentativeHomePhone');
string25 rep_dl_num := '' : stored('RepresentativeDLNumber');
string2 rep_dl_state := '' : stored('RepresentativeDLState');
string100 rep_email := '' : stored('RepresentativeEmaiLAddress');
string20 rep_alt_lname := '' : stored('RepresentativeFormerLastName');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean IsPOBoxCompliant := false : STORED('PoBoxCompliance');
boolean ofac_only := true : stored('OfacOnly');
boolean ExcludeWatchLists := false : stored('ExcludeWatchLists');
unsigned1 OFAC_version :=1 :STORED('OFACversion');
boolean Include_Additional_watchlists := FALSE: stored('IncludeAdditionalWatchlists');
boolean Include_Ofac := FALSE: stored('IncludeOfac');
real Global_WatchList_Threshold :=.84 :stored('GlobalWatchlistThreshold');
boolean Test_Data_Enabled := FALSE : stored('TestDataEnabled');
string20 Test_Data_Table_Name := '' : stored('TestDataTableName');
boolean use_dob_filter := FALSE : stored('UseDobFilter');
integer2 dob_radius := 2 : stored('DobRadius');
string6 ssnmask := 'NONE' : stored('SSNMask');
boolean IncludeTargus3220 := false : stored('IncludeTargusE3220');
string10 ExactMatchLevel := risk_indicators.iid_constants.default_ExactMatchLevel;  // default this for now, until the project is kicked off to add exact matching logic to BIID
string DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask;

dob_radius_use := if(use_dob_filter,dob_radius,-1);

gateways_in := Gateway.Configuration.Get();
model_url := dataset([],Models.Layout_Score_Chooser) : STORED('scores',few);

in_city_name := stringlib.stringtouppercase(city);
in_st := stringlib.stringtouppercase(state);
in_z5 := zip;

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

foorec := record
	unsigned4	seq := 0;
end;

df := dataset([{1}],foorec);

business_risk.Layout_Input into_input(df L) := transform
	clean_bus_addr := Risk_Indicators.MOD_AddressClean.clean_addr(addr,city,state,zip);
	clean_rep_addr := Risk_Indicators.MOD_AddressClean.clean_addr(rep_addr,rep_city,rep_state,rep_zip);

	self.seq := 1;
	self.Account := seqnum;
	self.bdid := (integer)bdid_value;
	self.score := 0;
	self.company_name := stringlib.stringtouppercase(company_name_value);
	self.alt_company_name := stringlib.stringtouppercase(alt_co_name);
	self.prim_range := Address.CleanFields(clean_bus_addr).prim_range;
	self.predir := Address.CleanFields(clean_bus_addr).predir;
	self.prim_name := Address.CleanFields(clean_bus_addr).prim_name;
	self.addr_suffix := Address.CleanFields(clean_bus_addr).addr_suffix;
	self.postdir := Address.CleanFields(clean_bus_addr).postdir;
	self.unit_desig := Address.CleanFields(clean_bus_addr).unit_desig;
	self.sec_range := Address.CleanFields(clean_bus_addr).sec_range;

	// Cleaned Address pieces
	self.p_city_name := if (Address.CleanFields(clean_bus_addr).p_city_name = '', in_city_name, Address.CleanFields(clean_bus_addr).p_city_name);
	self.v_city_name := Address.CleanFields(clean_bus_addr).v_city_name;
	self.st := if (Address.CleanFields(clean_bus_addr).st = '', in_st, Address.CleanFields(clean_bus_addr).st);
	self.z5 := if (Address.CleanFields(clean_bus_addr).zip = '', in_z5, Address.CleanFields(clean_bus_addr).zip);
	
	self.zip4 := Address.CleanFields(clean_bus_addr).zip4;
	self.orig_z5 := in_z5;
	self.lat := Address.CleanFields(clean_bus_addr).geo_lat;
	self.long := Address.CleanFields(clean_bus_addr).geo_long;
	self.addr_type := clean_bus_addr[139];
	self.addr_status := Address.CleanFields(clean_bus_addr).err_stat;
	self.county := Address.CleanFields(clean_bus_addr).county;
	self.geo_blk := Address.CleanFields(clean_bus_addr).geo_blk;	
	self.fein := fein;
	self.phone10 := busphone;
	self.ip_addr := bus_ip;
	self.rep_fname := stringlib.stringtouppercase(rep_fname);
	self.rep_mname := stringlib.stringtouppercase(rep_mname);
	self.rep_lname := stringlib.stringtouppercase(rep_lname);
	self.rep_name_suffix := stringlib.stringtouppercase(rep_name_suffix);
	self.rep_alt_Lname := stringlib.stringtouppercase(rep_alt_lname);
	self.rep_prim_range := Address.CleanFields(clean_rep_addr).prim_range;
	self.rep_predir := Address.CleanFields(clean_rep_addr).predir;
	self.rep_prim_name := Address.CleanFields(clean_rep_addr).prim_name;
	self.rep_addr_suffix := Address.CleanFields(clean_rep_addr).addr_suffix;
	self.rep_postdir := Address.CleanFields(clean_rep_addr).postdir;
	self.rep_unit_desig := Address.CleanFields(clean_rep_addr).unit_desig;
	self.rep_sec_range := Address.CleanFields(clean_rep_addr).sec_range;
	self.rep_p_city_name := Address.CleanFields(clean_rep_addr).p_city_name;
	self.rep_st := Address.CleanFields(clean_rep_addr).st;
	self.rep_z5 := Address.CleanFields(clean_rep_addr).zip;
	self.rep_orig_city := stringlib.stringtouppercase(rep_city);
	self.rep_orig_st := stringlib.stringtouppercase(rep_state);
	self.rep_orig_z5 := rep_zip;
	self.rep_zip4 := Address.CleanFields(clean_rep_addr).zip4;
	self.rep_lat := Address.CleanFields(clean_rep_addr).geo_lat;
	self.rep_long := Address.CleanFields(clean_rep_addr).geo_long;
	self.rep_addr_type := clean_rep_addr[139];
	self.rep_addr_status := Address.CleanFields(clean_rep_addr).err_stat;
	self.rep_county := Address.CleanFields(clean_rep_addr).county;
	self.rep_geo_blk := Address.CleanFields(clean_rep_addr).geo_blk;	
	self.rep_ssn := rep_ssn;
	self.rep_dob := rep_dob;
	self.rep_phone := rep_phone;
	self.rep_age := (string)rep_age;
	dl_num := stringlib.stringFilterOut(rep_dl_num,'-');
	dl_num2 := stringlib.stringFilterOut(dl_num,' ');
	self.rep_dl_num := stringlib.stringtouppercase(dl_num2);
	self.rep_dl_state := stringlib.stringtouppercase(rep_dl_state);
	self.rep_email := stringlib.stringtouppercase(rep_email);
	self.historydate := history_date;
end;

df2 := project(df,into_input(LEFT));

bsVersion := 2; // need bs version 2
outf := business_risk.InstantID_Function(df2, gateways, if (bdid_value = 0, false, true),DPPA_Purpose,GLB_Purpose,false,false, '', 
	ExcludeWatchLists,ofac_only,ofac_version,include_ofac,include_additional_watchlists,Global_WatchList_Threshold,
	dob_radius_use,IsPOBoxCompliant,bsVersion, ExactMatchLevel, DataRestriction);

export business_instantid_records := outf;
