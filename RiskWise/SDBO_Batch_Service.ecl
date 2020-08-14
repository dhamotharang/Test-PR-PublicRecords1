/*--SOAP--
<message name="SDBOBatchService">
	<part name="tribcode" type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- tibcodes available are b2b2, b2bz, b2bc, ex24, ex41, ex98, b2b4 */
import address, Risk_Indicators, gateway;

export SDBO_Batch_Service := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

string4	tribcode_value := ''	: stored('tribcode');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');

unsigned3 history_date := 999999 	: stored('HistoryDateYYYYMM');
boolean 	isUtility := false;
boolean 	ln_branded := false;
boolean 	ofac_only := true;
boolean 	suppressNearDups := true;
boolean 	require2Ele := true;
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
batchin := dataset([],riskwise.Layout_SDBO_Batchin) : stored('batch_in', few);
gateways_in := Gateway.Configuration.Get();
tribcode := StringLib.StringToLowerCase(tribcode_value);
unsigned1 ofac_version_      := 1        : stored('OFACVersion');

ofac_version := ofac_version_;
include_ofac := if(ofac_version = 1, false, true);
include_additional_watchlists := false;
global_watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := map(tribcode='b2bz' and le.servicename in ['targus', 'attus'] => le.url,  //b2bz uses targus gateway and attus gateway
				 tribcode in ['b2b2','ex24','ex41','ex98'] and le.servicename='targus' => le.url,  // these use the targus gateway
         tribcode in ['b2b2','b2bc','ex24','ex98','b2b4'] and le.servicename = 'bridgerwlc' => le.url, // included bridger gateway to be able to hit OFAC v4
				 ''); // default to no gateway call			 
	self := le;
end;

gateways := project(gateways_in, gw_switch(left));

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

RiskWise.Layout_SD5I addseq(batchin le, integer C) := transform
	self.seq := C;
	self.tribcode := tribcode;
	self.account := le.account;
	self.acctno := le.acctno;
	self.apptype := map(tribcode='ex41' => '1',
					tribcode='ex98' => '2',
					le.apptype);  // for ex41, set1 is always consumer, for ex98, set1 is always business
					
	self.first := le.name_first;
	self.last := le.name_last;
	self.cmpy := le.name_company;
	self.addr := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr,le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range);
	self.city := le.p_city_name;
	self.state := le.st;
	self.zip := le.z5+le.zip4;
	self.socs := le.ssn;
	self.dob := le.dob;
	self.hphone := le.home_phone;
	self.wphone := le.work_phone;
	self.drlc := le.dl_number;
	self.drlcstate := le.dl_state;
	self.email := le.email;
	self.apptype2 := map(tribcode='ex41' => '2',
					 tribcode='ex98' => '1',
					 le.apptype_2);  // for ex41, set1 is always consumer, for ex98, set1 is always business
		
	self.first2 := le.name_first_2;
	self.last2 := le.name_last_2;
	self.cmpy2 := le.name_company_2;
	self.addr2 := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr2,le.prim_range_2,le.predir_2,le.prim_name_2,le.suffix_2,le.postdir_2,le.unit_desig_2,le.sec_range_2);
	self.city2 := le.p_city_name_2;
	self.state2 := le.st_2;
	self.zip2 := le.z5_2 + le.zip4_2;
	self.socs2 := le.ssn_2;
	self.dob2 := le.dob_2;
	self.hphone2 := le.home_phone_2;
	self.wphone2 := le.work_phone_2;
	self.drlc2 := le.dl_number_2;
	self.drlcstate2 := le.dl_state_2;
	self.email2 := le.email_2;

	self.income2 := le.income_2;
	self.countrycode2 := le.countrycode_2;
	
	// if the record level history date isn't populated yet, use the global parameter
	self.historydate := if(le.HistoryDateYYYYMM=0, history_date, le.historydateYYYYMM); 
	self := le;
	
end;

f := project(batchin, addseq(LEFT,COUNTER));

ret := RiskWise.SDBO_Function(f, gateways, DPPA_Purpose, GLB_Purpose, isUtility, ln_branded, tribcode, ofac_version, include_ofac, include_additional_watchlists, 
                              global_watchlist_threshold, DataRestriction, DataPermission);

output(ret, named('Results'));

endmacro;
