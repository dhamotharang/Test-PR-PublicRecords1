﻿/*--SOAP--
<message name="Business Shell">
	<part name="seq" type="xsd:integer"/>
	<part name="AccountNumber" type="xsd:string"/>
	<part name="CompanyName" type="xsd:string"/>
	<part name="AlternateCompanyName" type="xsd:string"/>
	<part name="Addr" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="BusinessPhone" type="xsd:string"/>
	<part name="TaxIdNumber" type="xsd:string"/>
	<part name="BusinessIPAddress" type="xsd:string"/>
	<part name="RepresentativeFirstName" type="xsd:string"/>
	<part name="RepresentativeMiddleName" type="xsd:string"/>
	<part name="RepresentativeLastName" type="xsd:string"/>
	<part name="RepresentativeNameSuffix" type="xsd:string"/>
	<part name="RepresentativeAddr" type="xsd:string"/>
	<part name="RepresentativeCity" type="xsd:string"/>
	<part name="RepresentativeState" type="xsd:string"/>
	<part name="RepresentativeZip" type="xsd:string"/>
	<part name="RepresentativeSSN" type="xsd:string"/>
	<part name="RepresentativeDOB" type="xsd:string"/>
	<part name="RepresentativeAge" type="xsd:unsignedInt"/>
	<part name="RepresentativeDLNumber" type="xsd:string"/>
	<part name="RepresentativeDLState" type="xsd:string"/>
	<part name="RepresentativeHomePhone" type="xsd:string"/>
	<part name="RepresentativeEmailAddress" type="xsd:string"/>
	<part name="RepresentativeFormerLastName" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>	
  <part name="OfacOnly" type="xsd:boolean"/>
  <part name="GlobalWatchlistThreshold" type="xsd:real"/>
  <part name="OFACversion" type="xsd:unsignedInt"/>
  <part name="IncludeOfac" type="xsd:boolean"/>
  <part name="IncludeAdditionalWatchLists" type="xsd:boolean"/> 
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- This Service is an interface for modelers to see all data available from BIID and Profile Risk Score. */

IMPORT RiskWise, business_risk, Risk_Indicators, STD, Gateway;

export Business_Shell := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

#WEBSERVICE(FIELDS(
	'seq',
	'AccountNumber',
	'CompanyName',
	'AlternateCompanyName',
	'Addr',
	'City',
	'State',
	'Zip',
	'BusinessPhone',
	'TaxIdNumber',
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
	'HistoryDateYYYYMM',
	'PoBoxCompliance',
	'OfacOnly',
	'OFACversion',
	'IncludeOfac',
	'IncludeAdditionalWatchLists',
	'GlobalWatchlistThreshold',	
	'ExcludeWatchLists',
	'DataRestrictionMask',
	'DataPermissionMask',
	'gateways',
    'LexIdSourceOptout',
    '_TransactionId',
    '_BatchUID',
    '_GCID'));

unsigned	seq_value		:= 0  : stored('seq');
string30	account		:= '' : stored('AccountNumber');
string100	company_name 	:= '' : stored('CompanyName');
string100	alt_Co_Name	:= '' : stored('AlternateCompanyName');
string200	addr			:= '' : stored('Addr');
string30	city			:= '' : stored('City');
string2	state		:= '' : stored('State');
string5	zip			:= '' : stored('Zip');
string10	busphone		:= '' : stored('BusinessPhone');
string9	FEIN			:= '' : stored('TaxIdNumber');
string45	Bus_IP		:= '' : stored('BusinessIPAddress');
string20	rep_Fname		:= '' : stored('RepresentativeFirstName');
string20	rep_Mname		:= '' : stored('RepresentativeMiddleName');
string20	rep_Lname		:= '' : stored('RepresentativeLastName');
string5	rep_name_suffix	:= '' : stored('RepresentativeNameSuffix');
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
unsigned1 glb := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned1	dppa			:= riskwise.permittedUse.fraudDPPA  : stored('DppaPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean IsPOBoxCompliant := false : STORED('PoBoxCompliance');
boolean ofac_only := false : STORED('OfacOnly');
unsigned1 ofac_version       := 1        : stored('OFACVersion');
boolean   include_ofac       := false    : stored('IncludeOfac');
boolean   include_additional_watchlists  := false    : stored('IncludeAdditionalWatchLists');
boolean	ExcludeWatchLists  := false   : stored('ExcludeWatchLists');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
real Global_WatchList_Threshold := 0.84 			: stored('GlobalWatchlistThreshold');
gateways := Gateway.Configuration.Get();
//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');
unsigned1 AppendBest := 1;	// search best file

rec := record
	unsigned4	seq := 0;
end;

df := dataset([{seq_value}],rec);

business_risk.Layout_Input into_input(df L) := transform
	clean_bus_addr := Risk_Indicators.MOD_AddressClean.clean_addr(addr, city,state,zip);	
	clean_rep_addr := Risk_Indicators.MOD_AddressClean.clean_addr(rep_addr,rep_city,rep_state,rep_zip);	
	
	self.seq := l.seq;
	self.Account := account;
	self.bdid	:= 0;
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
	self.phone10    := busphone;
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
	self.rep_county := clean_rep_addr[143..145];
	self.rep_geo_blk := clean_rep_addr[171..177];	
	self.rep_ssn		:= rep_ssn;
	self.rep_dob		:= rep_dob;
	self.rep_phone		:= rep_phone;
	self.rep_age 		:= (string)rep_age;
	dl_num := STD.Str.FilterOut(rep_dl_num,'-');
	dl_num2 := STD.Str.FilterOut(dl_num,' ');
	self.rep_dl_num	:= STD.Str.toUpperCase(dl_num2);
	self.rep_dl_state	:= STD.Str.toUpperCase(rep_dl_state);
	self.rep_email		:= STD.Str.toUpperCase(rep_email);
	self.historydate := history_date;
end;

indata := project(df,into_input(LEFT));

biid := business_risk.InstantID_Function(indata, gateways, false, dppa, glb, false, false, '', 
											ExcludeWatchLists, ofac_only,ofac_version, include_ofac, include_additional_watchlists, Global_WatchList_Threshold, IsPOBoxCompliant:=IsPOBoxCompliant, DataRestriction := DataRestriction,
											in_append_best:=AppendBest, DataPermission := DataPermission,
                                            LexIdSourceOptout := LexIdSourceOptout, 
                                            TransactionID := TransactionID, 
                                            BatchUID := BatchUID, 
                                            GlobalCompanyID := GlobalCompanyID);

bus_shell := business_risk.Business_Shell_Function(biid, glb, LexIdSourceOptout, TransactionID, BatchUID, GlobalCompanyID, DataPermission);

output(bus_shell, named('Results'));

endmacro;