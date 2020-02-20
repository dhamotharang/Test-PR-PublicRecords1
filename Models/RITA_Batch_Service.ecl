/*--SOAP--
<message name = 'Ranking Inviation To Apply (Thindex Lite) BATCH Service'>
	<part name='batch_in'    				type='tns:XmlDataSet' cols='70' rows='25'/>
	<part name='DPPAPurpose'  				type='xsd:byte'/>
	<part name='GLBPurpose' 					type='xsd:byte'/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name='HistoryDateYYYYMM' 			type='xsd:integer'/>
	<part name='gateways' 					type='tns:XmlDataSet' cols='70' rows='25'/>
</message>
*/
/*--INFO-- RITA Batch Service */
 
export RITA_Batch_Service := MACRO

import address, risk_indicators, riskwise, ut, gateway, AutoStandardI;

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

batchin := dataset([],risk_indicators.Layout_Batch_In) : stored('batch_in',few);

unsigned1 dppa := 0 			: stored('DPPAPurpose');
unsigned1 glba := AutoStandardI.Constants.GLBPurpose_default: stored('GLBPurpose');
unsigned3 history_date := 999999 	: stored('HistoryDateYYYYMM');

gateways := Gateway.Configuration.Get();

boolean   suppressNearDups := false;
boolean   require2ele := false;
boolean   fromBIID := false;
boolean   fromIT1O := false;
boolean   isFCRA := false;
boolean   isUtility := false;
boolean   ln_branded := false;
boolean   ExcludeWatchLists := false;
unsigned1 OFAC_version := 1;
boolean   Include_Additional_watchlists := false;
boolean   Include_Ofac := false;
real      Global_WatchList_Threshold := .84;
boolean   ofac_only := true;
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string10 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');

// add sequence to matchup later to add acctno to output
Risk_Indicators.Layout_Batch_In into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));



risk_indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
	// clean up input
	ssn_val := le.ssn;
	hphone_val := riskwise.cleanPhone(le.home_phone);
	wphone_val := riskwise.cleanphone(le.work_phone);
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.dl_number);

	self.seq := le.seq;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.age := if ((integer)le.age = 0 and (integer)le.dob != 0, (string3)ut.Age((integer)le.dob), (le.age));
	
	self.phone10 := hphone_val;
	self.wphone10 := wphone_val;
	
	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
	
	self.fname := STD.Str.touppercase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	self.lname := STD.Str.touppercase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	self.mname := STD.Str.touppercase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	self.suffix := STD.Str.touppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
	self.title := STD.Str.touppercase(if(valid_cleaned, cleaned_name[1..5],''));
	
	street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;	


	SELF.in_streetAddress := street_address;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Z5;
		
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..65];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
	
	self.dl_number := STD.Str.touppercase(dl_num_clean);
	self.dl_state := STD.Str.touppercase(le.dl_state);
	self.historydate := if(le.HistoryDateYYYYMM=0, history_date, le.historydateYYYYMM); 
	self := [];
END;
cleanIn := project(batchinseq, into_in(left));


iid := risk_indicators.InstantID_Function(cleanIn, gateways, dppa, glba, isUtility, ln_branded, ofac_only, suppressNearDups, require2Ele, fromBIID, isFCRA, ExcludeWatchLists,
								  fromIT1O, ofac_version, include_ofac, Include_Additional_watchlists, Global_WatchList_Threshold,in_DataRestriction := DataRestriction,in_DataPermission := DataPermission,
                                  LexIdSourceOptout := LexIdSourceOptout, 
                                  TransactionID := TransactionID, 
                                  BatchUID := BatchUID, 
                                  GlobalCompanyID := GlobalCompanyID);
clam := risk_indicators.Boca_Shell_Function(iid, gateways, dppa, glba, isUtility, ln_branded, true, false, false, true,DataRestriction := DataRestriction, DataPermission := DataPermission,
                                                                              LexIdSourceOptout := LexIdSourceOptout, 
                                                                              TransactionID := TransactionID, 
                                                                              BatchUID := BatchUID, 
                                                                              GlobalCompanyID := GlobalCompanyID);


	
ret := Models.MSN610_0_0(clam, history_date);


out_layout := RECORD
	string20 acctno;
	string3 score;
END;

out_layout into_out(ret le, batchinseq ri) := TRANSFORM
	self.acctno := ri.acctno;
	self.score := le.score;
END;
final := join(ret, batchinseq, left.seq=right.seq, into_out(left,right), left outer);

output(final, named('Results'));

ENDMACRO;
// Models.RITA_Batch_Service()