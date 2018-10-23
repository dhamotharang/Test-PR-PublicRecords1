/*--SOAP--
<message name="FCRAData_service"  wuTimeout="300000">
	<part name="AlphaNumericInput" type="xsd:boolean" default="false" description=" Defines whether the input is from VRU (numeric only) or non-numeric"/>
	<part name="IncludeAllHeaderResults" type="xsd:boolean" description="If checked, header results will not be deduped (for QA testing)"/>
	<part name="DID" type="xsd:integer" disabled="true" description=" (temporarily disabled)"/>

  <section name="Numeric input" />
	<part name="socs" type="xsd:string" description=" SSN"/>
	<part name="yob" type="xsd:string" description=" 2-digit year of birth"/>
	<part name="housenum" type="xsd:string"/>
	<part name="hphone" type="xsd:string" description=" 10-digit home number"/>
	<part name="zip5" type="xsd:string" description=" (5-digit)"/>
  <separator />
	
  <section name="Non-numeric input" />
	<part name="first" type="xsd:string" /> 
	<part name="middle" type="xsd:string" />
	<part name="last" type="xsd:string" /> 
	<part name="suffix" type="xsd:string" />
	<part name="addr" type="xsd:string" /> 
	<part name="city" type="xsd:string" /> 
	<part name="state" type="xsd:string" /> 
	<part name="zip" type="xsd:string" description=" (9-digit)"/>
	<part name="dob" type="xsd:string" description=" full date of birth"/>
  <separator />
	
	<part name="instant_ip" type="xsd:string" default="http://roxiestaging.br.seisint.com:9876" description=" gateway to VRU Identity service and neutral did service"/>
	<part name="SkipRiskviewFilters" type="xsd:boolean" default="false" description="turns off certain riskview business logic filtering of the data so that DOST can get full picture if they want">
	<part name='NonSubjectSuppression' type = 'xsd:unsignedInt' default="2"/> <!-- [1,2,3] -->
</message>
*/
/*--INFO-- Returns FCRA compliant data for a given person. <br/>*/
IMPORT Risk_Indicators, RiskWise, doxie, doxie_files, FCRA, drivers, mdr, ut, targus,
       avm_v2, american_student_list, gong, codes, impulse_email, infutorCID, email_data,
       Advo, inquiry_AccLogs, header_quick, address, did_add, AlloyMedia_student_list;

export FCRAData_service := MACRO

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'AlphaNumericInput',
	'IncludeAllHeaderResults',
	'DID',

	/* <section name="Numeric input" /> */
	'socs',
	'yob',
	'housenum',
	'hphone',
	'zip5',
	/* <separator /> */

	/* <section name="Non-numeric input" /> */
	'first',
	'middle',
	'last',
	'suffix',
	'addr',
	'city',
	'state',
	'zip',
	'dob',
	'instant_ip',
	'NonSubjectSuppression',
	'SkipRiskviewFilters'));


boolean alpha_numeric := false : stored ('AlphaNumericInput');
boolean IncludeAllHeaderResults := false : stored ('IncludeAllHeaderResults');
boolean isVRU := NOT alpha_numeric;
unsigned6 did_value := 0 : stored('DID'); //if we have did, no did-search is required, not currently in use

// Numeric input
string12  ssn_val    := '' : stored ('socs');
string2  yob_val     := '' : stored ('yob');
string5  hnumber_val := '' : stored ('housenum');
string10 phone_val   := '' : stored ('hphone');
string5  zip_val     := '' : stored ('zip5');

// Non-numeric input
string15 first_val   := '' : stored ('first');
string20 middle_val  := '' : stored ('middle');
string20 last_val    := '' : stored ('last');
string5  suffix_val  := '' : stored ('suffix');
string50 address_val := '' : stored ('addr');
string30 city_val    := '' : stored ('city');
string2  state_val   := '' : stored ('state');
string9  zip9_val    := '' : stored ('zip');
string8  dob_val     := '' : stored ('dob');

string neutral_ip := '' : stored ('instant_ip');
boolean SkipRiskviewFilters := false : stored ('SkipRiskviewFilters');
IF ((neutral_ip = '') and (did_value = 0), FAIL (301, TRIM (doxie.ErrorCodes (301)) + ': instant_ip is required'));

//non-subject suppression
nss := ut.getNonSubjectSuppression ();

//common settings
unsigned3 history_date := 999999;	// removed the input history date, this query is not meant to be run in historical mode
boolean isFCRA := true;
boolean glb_ok := true;
boolean dppa_ok := true;


unsigned2 MAX_OVERRIDE_LIMIT := 100;
unsigned4 MAX_OVERRIDE_LIMIT_FLAGS := 1000;
unsigned2 MAX_HEADER_DID := 500;
unsigned2 MAX_PII_READ   := 1000; // number of correction person can make

todaysdate := ut.GetDate; // for checking derog's fcra-date compliance

layout_VRU      := RiskWise.layouts_vru.layout_VRU;
layout_input    := RiskWise.layouts_vru.layout_input;
layout_person   := RiskWise.layouts_vru.layout_person;
layout_output		:= RiskWise.layouts_vru.layout_data_service_output;

// removed the PII override key from vru identity and will do it in here so that it is on the fcra roxie
ssn_pii_lookup := CHOOSEN (FCRA.Key_FCRA_Override_pii_SSN (keyed (ssn = ssn_val) and ssn_val!=''), MAX_PII_READ);
correction_dids_ssn_filtered := ssn_pii_lookup ( ssn = ssn_val or ssn='' or ssn_val='' );
corrected_person := project(correction_dids_ssn_filtered, transform(layout_person, 
																		self.did := (unsigned)left.did,
																		self.dob := (unsigned)left.dob,
																		self.dt_first_seen := (unsigned)left.dt_first_seen[1..6],
																		self.dt_last_seen := (unsigned)left.dt_last_seen[1..6],
																		self := left));
																		
ds_ssn_correction := Risk_Indicators.iid_constants.GetVRUDataset(3, 'ssn: correction record utilized', Risk_Indicators.iid_constants.GetVerified (ssn_val, yob_val, hnumber_val, phone_val, zip_val), corrected_person);

// formal projection to encapsulate input parameters
layout_temp := RECORD
  unsigned1 x := 0; 
END;

layout_input GetInput (layout_temp L) := TRANSFORM
  SELF.socs     := ssn_val;
  SELF.yob      := yob_val;
  SELF.housenum := hnumber_val;
  SELF.hphone   := phone_val;
  SELF.zip5     := zip_val;

  SELF.first := first_val;
	SELF.middle:= middle_val;
  SELF.last  := last_val;
	SELF.suffix:= suffix_val;
  SELF.addr  := address_val;
  SELF.city  := city_val;
  SELF.state := state_val;
  SELF.zip   := zip9_val;
	SELF.dob   := dob_val;

  SELF.AlphaNumericInput := alpha_numeric;
	SELF.neutralIP := neutral_ip;
END;

ds_input := PROJECT (DATASET ([{1}], {layout_temp}), GetInput (Left));


// Get DID
bshell := SOAPCALL (ds_input, neutral_ip, 
                    'RiskWise.VRU_IdentityService', {ds_input},
                    DATASET (RiskWise.layouts_vru.layout_output),
                    PARALLEL (1));
										
// if we get a corrected person hit above, then use that, otherwise, call the vru identity service
bshell2 := if(exists(corrected_person), ds_ssn_correction, bshell);													

// Get all relevant corrections
layout_corr := fcra.layout_override_pii;

did_pii := CHOOSEN (FCRA.Key_FCRA_Override_pii_DID (keyed (s_did = bshell2[1].id[1].did)), MAX_PII_READ);

all_corrections := PROJECT (did_pii, layout_corr) + PROJECT (correction_dids_ssn_filtered, layout_corr);
                           

// take latest record
//? do we need dedup, if we take the latest anyway
corr_latest := DATASET (SORT (DEDUP (all_corrections, ALL), -date_created) [1]);

layout_person GetCorrections (layout_corr L) := TRANSFORM
  SELF.did := (unsigned) L.did;
  SELF.dob := (integer4) L.dob;
  SELF.dt_first_seen := (unsigned3) L.dt_first_seen;
  SELF.dt_last_seen := (unsigned3) L.dt_last_seen;
  SELF := L;
END;
corr_recs := PROJECT (corr_latest, GetCorrections (Left));

// validating input
ph_trim := TRIM (phone_val);
ph_trim_len := LENGTH (ph_trim);
ph_filtered_len := LENGTH (StringLib.StringFilterOUT (ph_trim, '0123456789'));
ph_zeros_len := LENGTH (StringLib.StringFilterOUT (ph_trim, '0'));
boolean phone_present := IF ((ph_zeros_len = 0) OR (ph_filtered_len <> 0) OR (ph_trim_len < 10), FALSE, TRUE);

boolean hnumber_present := hnumber_val != '';
boolean zip_present := zip_val != '';


// adjust dids according to correction records
layout_person Adjust (bshell2 L, layout_person R) := TRANSFORM
  boolean validCorrAddress := (R.prim_name != '' AND R.prim_range != '' AND
                               R.city_name != '' AND R.st != '' AND R.zip != '');
  
  // to correct VRU address, VRU address-input shoud match correction addres:
  boolean matchVRUAddress := (~hnumber_present OR (hnumber_val = R.prim_range)) AND
                             (~zip_present OR (zip_val = R.zip));
  boolean takeAddress := validCorrAddress AND (~IsVRU OR matchVRUAddress);

  // VRU-input phone , if present, should match correction
  boolean takePhone := (R.phone != '') AND (~IsVRU OR (~phone_present OR (phone_val = R.phone)));
  // VRU-input yob, if present, should match correction
  boolean takeDOB   := (R.dob != 0) AND (~IsVRU OR (yob_val = ''));
  
  // In case of Numeric input SSN can't be adjusted 
  SELF.ssn   := IF (IsVRU or (~isVRU and R.ssn=''), L.id[1].ssn, R.ssn);
  SELF.dob   := IF (takeDOB, R.dob, L.id[1].dob);
  SELF.phone := IF (takePhone, R.phone, L.id[1].phone);
  SELF.fname := IF (R.fname != '', R.fname, L.id[1].fname);
  SELF.mname := IF (R.mname != '', R.mname, L.id[1].mname);
  SELF.lname := IF (R.lname != '', R.lname, L.id[1].lname);

  SELF.predir     := IF (takeAddress, R.predir, L.id[1].predir);
  SELF.prim_name  := IF (takeAddress, R.prim_name, L.id[1].prim_name);
  SELF.prim_range := IF (takeAddress, R.prim_range, L.id[1].prim_range);
  SELF.suffix     := IF (takeAddress, R.suffix, L.id[1].suffix);
  SELF.postdir    := IF (takeAddress, R.postdir, L.id[1].postdir);
  SELF.unit_desig := IF (takeAddress, R.unit_desig, L.id[1].unit_desig);
  SELF.sec_range  := IF (takeAddress, R.sec_range, L.id[1].sec_range);
  SELF.city_name  := IF (takeAddress, R.city_name, L.id[1].city_name);
  SELF.st         := IF (takeAddress, R.st, L.id[1].st);
  SELF.zip        := IF (takeAddress, R.zip, L.id[1].zip);
  SELF.zip4       := IF (takeAddress, R.zip4, L.id[1].zip4);
	
	SELF.dt_first_seen := l.id[1].dt_first_seen;
	SELF.dt_last_seen := l.id[1].dt_last_seen;
	
	SELF.did := L.id[1].did;
	SELF.hhid := L.id[1].hhid;
END;

//? use ssn=ssn
// this is formal join: both sets have atmost one record
dids_adjusted := IF (EXISTS (corr_latest),
                     JOIN (bshell2, corr_recs,
                           (Left.id[1].did = Right.did),
                           Adjust (Left, Right), LEFT OUTER),
                     bshell2.id);
										 
										 

RiskWise.layouts_vru.layout_output SetOutput (RiskWise.layouts_vru.layout_output L) := TRANSFORM
	self.seq := 0;
// add DIDs if vru-code is OK; special Numeric case: code=1, identified: address absent
  addID := ~exists(corrected_person) //and // if corrected person is found using SSN override, don't used dids
			/*( (L.VRU_code != 1) OR (IsVRU AND ssn_present AND phone_present AND ~address_present AND (CNT_JoinDids = 1)) )*/;
  
  SELF.VRU_code := if(exists(corrected_person), ds_ssn_correction[1].vru_code, L.VRU_code);
  SELF.VRU_message := if(exists(corrected_person), ds_ssn_correction[1].vru_message, L.VRU_message);	// only add the deceased message if it was from correction, otherwise, it was already there
	SELF.id := IF (addID, dids_adjusted, L.id);
  SELF.CID := IF (EXISTS (corr_recs), corr_latest[1].UID, ''); 
  SELF.input := ds_input;
  SELF := L;
END;
ds_result :=  PROJECT (bshell2, SetOutput (Left));


										
										
// We now need to get the data from the FCRA roxie for returning - so override what was returned from the vru identity service, that data is now only used fo find the DID
csz := Address.Addr2FromComponents(city_val, state_val, zip9_val);	
clean_a := if(address_val='' or csz='', '', Address.CleanAddress182(address_val,csz));
cleaned := Address.CleanAddress182(address_val,csz);
clean_pr := clean_a[1..10]; // cleaned prim range
clean_pn := clean_a[13..40]; // cleaned prim name
clean_sr := clean_a[57..64]; // cleaned sec range
clean_z5 := if(clean_a[117..121]<>'', clean_a[117..121], zip9_val[1..5]);	// use the input zip if cass zip is empty
			
tscore(UNSIGNED1 i) := IF(i=255,0,i);

// Choosing "best" name and address;
layout_person ChooseAddress (layout_person L, layout_person R ) := TRANSFORM

  boolean latest := (L.dt_last_seen < R.dt_last_seen) OR (L.dt_last_seen < R.dt_first_seen);
  boolean sameAddress := (L.prim_range = R.prim_range AND L.prim_name = R.prim_name AND L.zip = R.zip);
  boolean takeAddress1 := latest AND (R.prim_range != '' AND R.prim_name != '' AND R.zip != '');

  leScore := risk_indicators.AddrScore.addressScore( clean_pr, clean_pn, clean_sr, l.prim_range, l.prim_name, l.sec_range );
  riScore := risk_indicators.AddrScore.addressScore( clean_pr, clean_pn, clean_sr, r.prim_range, r.prim_name, r.sec_range );

  takeAddress := (isVru and takeAddress1) // when doing a vru search, just use the 'latest' version of takeAddress
	or tscore(riScore) > tscore(leScore);   // or, when using by-address, take the right if it's a higher score but not 255


  SELF.hhid := IF (latest AND R.hhid!=0, R.hhid, L.hhid);
  SELF.dob := IF (R.dob != 0 AND ((string) R.dob)[5..6] != '00', R.dob, L.dob);
  SELF.phone := IF (latest AND R.phone != '', R.phone, L.phone);

  SELF.dt_first_seen := IF (takeAddress, R.dt_first_seen, L.dt_first_seen);
  SELF.dt_last_seen  := IF (takeAddress, R.dt_last_seen, L.dt_last_seen);
  
  // best name
  // see how both records do against the input
  lfScore := risk_indicators.FnameScore(first_val,l.fname); // left's fname score
  rfScore := risk_indicators.FnameScore(first_val,r.fname); // right's fname score
  llScore := risk_indicators.LnameScore(last_val,l.lname);  // left's lname score
  rlScore := risk_indicators.LnameScore(last_val,r.lname);  // right's lname score
  
  // on blank input, simply follow what takeAddress indicates; on valid input, use which ever one scores higher (but not 255)
  fnameRight := first_val='' and takeAddress or tscore(rfscore) > tscore(lfscore);
  lnameRight := last_val ='' and takeAddress or tscore(rlscore) > tscore(llscore);
  
  self.fname := if( fnameRight, r.fname, l.fname );
  self.lname := if( lnameRight, r.lname, l.lname );
  self.mname := map(
	 fnameright and  lnameright => r.mname, // if using both fname and lname from one side, use that mname
	~fnameright and ~lnameright => l.mname,

	// else, pick the longer one. another possibility is to stick strictly with the last name's record, or possibly
	// do some comparison against fname/lname and ensure we don't duplicate one of them.
	length(l.mname) > length(r.mname) => l.mname,
	r.mname
  );
	

  SELF.predir     := IF (takeAddress, R.predir,     L.predir);
  SELF.prim_name  := IF (takeAddress, R.prim_name,  L.prim_name);
  SELF.prim_range := IF (takeAddress, R.prim_range, L.prim_range);
  SELF.suffix     := IF (takeAddress, R.suffix,     L.suffix);
  SELF.postdir    := IF (takeAddress, R.postdir,    L.postdir);
  SELF.unit_desig := IF (takeAddress, R.unit_desig, L.unit_desig);
  SELF.sec_range  := IF (takeAddress, R.sec_range,  L.sec_range);
  SELF.city_name  := IF (takeAddress, R.city_name,  L.city_name);
  SELF.st         := IF (takeAddress, R.st,         L.st);
  SELF.zip        := IF (takeAddress, R.zip,        L.zip);
  SELF.zip4       := IF (takeAddress, R.zip4,       L.zip4);
  
  // score the SSNs and pick the best match
  LSSNScore := did_add.ssn_match_score( ssn_val, L.ssn );
  RSSNScore := did_add.ssn_match_score( ssn_val, R.ssn );
  self.ssn := if(tscore(LSSNScore) > tscore(RSSNScore), L.ssn, R.ssn );
  
  self.did := if( L.did=0, R.did, L.did );
END;

layout_person GetPersonData (doxie.key_fcra_header R) := TRANSFORM
  SELF := R;
END;
layout_person GetPersonDataQuick (header_quick.key_DID_fcra R) := TRANSFORM
  SELF := R;
END;
// Get all header records for given did(s); did != 0 here, but ds_dids might be empty
dids_ssn1 := JOIN (bshell2, doxie.key_fcra_header,
                  keyed (Left.id[1].did = Right.s_did) AND Risk_Indicators.iid_constants.IsEligibleHeaderRec (Right, dppa_ok) AND left.id[1].did!=0,
                  GetPersonData (Right),
                  LIMIT (MAX_HEADER_DID, SKIP));

// Get all quick header records for given did(s); did != 0 here, but ds_dids might be empty
dids_ssn2 := JOIN (bshell2, header_quick.key_did_fcra,
                  keyed (Left.id[1].did = Right.did) AND left.id[1].did!=0,
                  GetPersonDataQuick( right ),
                  LIMIT (MAX_HEADER_DID, SKIP));

dids_ssn := sort(ungroup(dids_ssn1+dids_ssn2),did);



		
//    B. Find dids by ssn, filter by zip/hnumber/yob, don't eliminate if dob is blank
boolean match_dob     := (yob_val     = '') OR (dids_ssn.dob = 0) OR (yob_val = ((string) dids_ssn.dob)[3..4]);
boolean match_hnumber := (hnumber_val = '') OR (hnumber_val = dids_ssn.prim_range);
boolean match_zip     := (zip_val     = '') OR (zip_val = dids_ssn.zip);

// filter by yob, housenum, zip, whichever is provided; match whole record (paranoic mode)
// ssn might be different here -- add it to filter; don't eliminate dob, if absent
dids_ssn_filtered := dids_ssn ((ssn = ssn_val) AND match_dob AND  match_hnumber AND match_zip);

dids_addressed := ROLLUP (dids_ssn_filtered, TRUE, ChooseAddress (Left, Right));


RiskWise.layouts_vru.layout_output addID(ds_result le, dids_addressed ri) := transform
	self.id := if(exists(corr_latest), le.id[1], ri);		// overwrite the nonfcra id data with fcra side id data, use correction result if correction was found
	self := le;
end;
bshellID := join(ds_result, dids_addressed, left.id[1].did=right.did, addID(left,right), LEFT OUTER);

// Include Generic (consumer) Flags
layout_output getFlags (RiskWise.layouts_vru.layout_output le, fcra.Key_Override_PCR_UID ri) :=
TRANSFORM
	SELF.cflags.corrected_flag := false;
  SELF.cflags.consumer_statement_flag := (ri.consumer_statement_flag='1');
  SELF.cflags.dispute_flag := (ri.dispute_flag='1');
  SELF.cflags.security_freeze := (ri.security_freeze='1');
  SELF.cflags.security_alert := (ri.security_alert='1');
  SELF.cflags.negative_alert := (ri.negative_alert='1');
  SELF.cflags.id_theft_flag := (ri.id_theft_flag='1');
  SELF := le;
	self := [];
END;
bshell_w_flags := JOIN (bshellID, fcra.Key_Override_PCR_UID, 
                        keyed(LEFT.CID=RIGHT.UID),
                        getFlags(LEFT,RIGHT),
                        LEFT OUTER, KEEP (1)); // no more than 1 matching record on the right
												
//formal normalize; there's atmost one did-record returned
layout_person GetPerson (layout_output le, layout_person ri) := TRANSFORM
	SELF := ri;
END;
bshell_id := NORMALIZE (bshell_w_flags, LEFT.id, GetPerson (LEFT,RIGHT));

// Corrections: we have only one did-person here, so it's easier to use global overrides
//? avoid normalize here, just filter by bshell_id[1].did/ssn
layout_overrides := RECORD
  DATASET (fcra.Layout_override_flag) flagrecs {MAXCOUNT(MAX_OVERRIDE_LIMIT_FLAGS)};
END;

layout_overrides GetFlagRecords (bshell_id Le) := TRANSFORM
  ssn_flags := CHOOSEN (fcra.key_override_flag_ssn (keyed (l_ssn = Le.ssn), datalib.NameMatch (Le.fname, Le.mname, Le.lname, fname, mname, lname)<3), MAX_OVERRIDE_LIMIT_FLAGS);
  did_flags := CHOOSEN (fcra.key_override_flag_did (keyed (l_did=(string)Le.did)), MAX_OVERRIDE_LIMIT_FLAGS);
  flags := PROJECT (did_flags, fcra.Layout_override_flag) + PROJECT (ssn_flags, fcra.Layout_override_flag);
  SELF.flagrecs := CHOOSEN (dedup(flags, ALL), MAX_OVERRIDE_LIMIT_FLAGS);
END;

ds_flagfile := NORMALIZE (PROJECT (bshell_id, GetFlagRecords (Left)), LEFT.flagrecs, TRANSFORM (fcra.Layout_override_flag, SELF := Right));

// code > 1 or special case when person was dided, but address can't be verified.

layout_didslim := RiskWiseFCRA.layouts.didslim;

//formal normalize; there's atmost one did-record returned
// INSTEAD OF using ID section from VRU on the alphanumeric search, 
// use the inputs from DOST FOR SEARCHING ADVO, Property by ADDRESS, AVM, SSN_TABLE
layout_didslim GetDidSlim (layout_output le, layout_person ri) := TRANSFORM
  SELF.cflags := le.cflags;
	
	self.did := ri.did;   // comes from what is found in ID on neutral side
	self.ssn := ssn_val;  // always using the input SSN

	self.fname := IF(alpha_numeric, stringlib.stringtouppercase(first_val), ri.fname);
	self.mname := IF(alpha_numeric, stringlib.stringtouppercase(middle_val), ri.mname);
	self.lname := IF(alpha_numeric, stringlib.stringtouppercase(last_val), ri.lname);
	self.name_suffix := IF(alpha_numeric, stringlib.stringtouppercase(suffix_val), '');  // bshell_w_flags doesn't have suffix field

	clean_input_addr := Risk_Indicators.MOD_AddressClean.clean_addr(address_val, city_val, state_val, zip9_val);
	
	ri_street_addr := Risk_Indicators.MOD_AddressClean.street_address('',ri.prim_range, ri.predir, ri.prim_name, ri.suffix, ri.postdir, ri.unit_desig, ri.sec_range);
	clean_id_addr := Risk_Indicators.MOD_AddressClean.clean_addr(ri_street_addr, ri.city_name, ri.st, ri.zip );
	
	// when alpha_numeric, always use the input address for searching the DBs
	clean_addr := if(alpha_numeric, clean_input_addr, clean_id_addr);
	
	self.prim_range := clean_addr[1..10];
	self.predir := clean_addr[11..12];
	self.prim_name := clean_addr[13..40];
	self.suffix := clean_addr[41..44];
	self.postdir := clean_addr[45..46];
	self.unit_desig := clean_addr[47..56];
	self.sec_range := clean_addr[57..64];
	self.city_name := clean_addr[90..114];
	self.st := clean_addr[115..116];
	self.zip := clean_addr[117..121];
	self.zip4 := clean_addr[122..125]; 
	self.lat := clean_addr[146..155];
	self.long := clean_addr[156..166];
	self.county := clean_addr[143..145];
	self.geo_blk := clean_addr[171..177];
	self.phone10 := phone_val;	
END;
bshell_dids := NORMALIZE (bshell_w_flags, LEFT.id, GetDidSlim (LEFT,RIGHT));

// this is mostly for usage convenience: a short cut if DID is in the input
dids_input := dataset ([did_value], doxie.layout_references);
dids := if (count (bshell_dids (did > 0)) > 0, 
            project (bshell_dids (did > 0), doxie.layout_references),
            dids_input);

// ===========================================================================
// ==================     MAIN KEYS LAYOUT DEFINITION     ====================
// ===========================================================================

set_fcra_scoring_inquiries := ['FCRA BUSINESS PROTECTION SERVICE',
'FCRA CREDIT REPORT',
'FCRA EQUIFAX RECOVERY REPORT',
'FCRA RISKVIEW APPLICATION',
'FCRA RISKWISE AUTOINDEX SCORE (SC64)',
'FCRA RISKWISE CUSTOM AIRWAVES SCORE (PW14)',
'FCRA RISKWISE CUSTOM AIRWAVES SCORE (PW22)',
'FCRA RISKWISE CUSTOM AUTOINDEX (PW51)',
'FCRA RISKWISE CUSTOM FINANCE RISK SCORE (EX63)',
'FCRA RISKWISE CUSTOM FINANCE RISK SCORE (EX80)',
'FCRA RISKWISE CUSTOM FINANCE RISK SCORE (EX89)',
'FCRA RISKWISE CUSTOM INSTANT ID W/ FINANCE RISK & RC (FDS1)',
'FCRA RISKWISE CUSTOM MARKETMAX AIRWAVES(EX44)',
'FCRA RISKWISE CUSTOM ONESCORE (PW10)',
'FCRA RISKWISE CUSTOM ONESCORE (PW15)',
'FCRA RISKWISE CUSTOM SUBPRIME AUTO THINDEX (NP12)',
'FCRA RISKWISE GENERIC AUTOINDEX (PW52)',
'FCRA RISKWISE INSTANT ID (CUSTOM NP32)',
'FCRA RISKWISE INSTANT ID SCORE ONLY (NPT4)',
'FCRA RISKWISE INSTANT ID W/ OFAC (NPT3)',
'FCRA RISKWISE MARKETMAX (TARGET CUSTOM EX29)',
'FCRA RISKWISE MARKETMAX AIRWAVES (EX14)',
'FCRA RISKWISE MARKETMAX FINANCE SCORE  (SC63)',
'FCRA RISKWISE MARKETMAX FINANCE SCORE (SC63)',
'FCRA RISKWISE MARKETMAX FINANCE W/ FRAUDADVISOR (EX17)',
'FCRA RISKWISE PHONE HISTORY REPORT',
'FCRA RISKWISE RISKVIEW RETAIL 2.0 (EX49)',
'FCRA RISKWISE RISKVIEW RETAIL 2.0 + CVI (NP33)',
'FCRA RISKWISE RISKVIEW TELECOM 2.0 (PW34)',
'FCRA RISKWISE SUBPRIME AUTO THINDEX (NP52)',
'MODELS.RISKVIEWBATCHSERVICE',
'MODELS.RISKVIEWCAPONEBATCHSERVICE',
'RISKVIEW APPLICATION',
'RISKVIEW PORTFOLIO',
'RWBATCH'];

ssn_inquiries_pre_pull := join(bshell2, Inquiry_AccLogs.Key_FCRA_SSN,
					alpha_numeric and  // only search the inquiries DB on alpha_numeric input where we can check to see if the name matches
					keyed(right.ssn=left.input[1].socs) 
					and datalib.NameMatch (Left.input[1].first, left.input[1].middle, left.input[1].last, right.person_q.fname, right.person_q.mname, right.person_q.lname) < 3 
					and ut.DaysApart(ut.GetDate,right.search_info.datetime[1..8]) < ut.DaysInNYears(1)
					and trim(StringLib.StringToUpperCase(right.search_info.function_description)) in set_fcra_scoring_inquiries,	
					transform(recordof(Inquiry_AccLogs.Key_FCRA_SSN), self := right) );

// add pullID lookup to ensure this person with SSN inquiries is also not on the pullID list
appType := Suppress.Constants.ApplicationTypes.DEFAULT;
Suppress.MAC_Suppress(ssn_inquiries_pre_pull,ssn_inquiries,appType,Suppress.Constants.LinkTypes.SSN,ssn);

ssn_inquiry_match := exists(ssn_inquiries);

// ==========================================================
// ======================    HEADER    ======================	
// ==========================================================
header_recs := RiskWiseFCRA._header_data (dids, ds_flagfile);

// dedup the records and show the earliest first seen and latest last seen
RiskWiseFCRA.layouts.working dedupEm(RiskWiseFCRA.layouts.working le, RiskWiseFCRA.layouts.working ri) := transform
	self.dt_first_seen := ut.Min2(le.dt_first_seen, ri.dt_first_seen);	// take the lowest non-zero?
	self.dt_last_seen := ut.max2(le.dt_last_seen, ri.dt_last_seen);	// take the max of the 2
	self := le;
end;

headerRecsDeduped := rollup(header_recs, 	left.src=right.src and left.fname=right.fname and left.mname=right.mname and left.lname=right.lname and 
																					left.name_suffix=right.name_suffix and left.prim_range=right.prim_range and left.predir=right.predir and 
																					left.prim_name=right.prim_name and left.suffix=right.suffix and left.postdir=right.postdir and 
																					left.unit_desig=right.unit_desig and left.sec_range=right.sec_range and left.ssn=right.ssn and left.dob=right.dob, dedupEm(left,right));

// finalHeaderRecs1 := project(if(IncludeAllHeaderResults, header_recs, headerRecsDeduped), transform(Riskwise.layouts_vru.Layout_Header_Data, self := left));
header_recs_temp := if(IncludeAllHeaderResults, header_recs, headerRecsDeduped);


with_highriskaddr_source := join(header_recs_temp, risk_indicators.key_HRI_Address_To_SIC_filtered_fcra,  
										left.addr_flags.highRisk='1' and
										keyed(left.zip=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.suffix=right.suffix) and 
										keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
										keyed(left.sec_range=right.sec_range) and right.sic_code<>'', 
										transform(Riskwise.layouts_vru.Layout_Header_Data,
											self.high_risk_address_source := right.source,
											self.high_risk_address_description := risk_indicators.iid_constants.hri_sic_code_description(right.sic_code);
											self := left),
										left outer,
										ATMOST(RiskWise.max_atmost), keep(1));	

finalHeaderRecs :=  SORT (with_highriskaddr_source, -dt_last_seen, -dt_first_seen);

inquiry_recs := RiskWiseFCRA._inquiries_data(dids, ds_flagfile);

unique_inquiry_ssns := dedup(project(inquiry_recs, transform({string ssn}, self.ssn := left.person_q.ssn)));
								
// ==========================================================
// ======================    SSN TABLE    ===================
// ==========================================================
Layout_SSN := record
 recordof(Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA);		
 	string30 death_sources;
end;

ssn_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.ssn), flag_file_id );
ssn_ids  := SET(ds_flagfile(file_id = FCRA.FILE_ID.ssn), trim(record_id) );
ssn_corr  := CHOOSEN(FCRA.Key_Override_SSN_Table_FFID( keyed( flag_file_id in ssn_ffids ) ), MAX_OVERRIDE_LIMIT );

ssn_main1 := join(bshell_dids, Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA,	
						ssn_val<>'' and keyed(ssn_val=right.ssn) and trim((string12)right.ssn) not in ssn_ids,
						transform( layout_ssn, self.death_sources := '', self := right ),
						KEEP(10), atmost(100));		
// add the ssns from the inquiry records as well for display on the CDR					
ssn_main2 := join(unique_inquiry_ssns, Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA,	
						left.ssn<>'' and keyed(left.ssn=right.ssn),
						transform( layout_ssn, self.death_sources := '', self := right ),
						KEEP(10), atmost(100));						
ssn_deduped := dedup(sort(ungroup(ssn_main1 + ssn_main2), record),all);

ssn_recs1 := ssn_deduped + PROJECT( ssn_corr,
		transform( Layout_ssn,
									self.death_sources := '',
									self := LEFT
							) );
							
// add the death_sources to the ssn_table result	

					
with_death_sources := join(ssn_recs1, Death_Master.key_ssn_ssa(isFCRA := true), 
	left.ssn<>'' and left.isDeceased and
	keyed(left.ssn=right.ssn),
transform(layout_ssn, 
	self.death_sources := if(trim(right.death_rec_src)='', '', right.death_rec_src + ',');
	self := left), 
	atmost(riskwise.max_atmost), left outer);

// first, get rid of all duplicates per source
death_sources_deduped := dedup(sort(with_death_sources, ssn, death_sources), ssn, death_sources);

// then rollup to 1 record per SSN of comma delimited death_sources	
death_sources_rolled := rollup(death_sources_deduped, left.ssn=right.ssn,
	transform(layout_ssn, 
	self.death_sources := trim(left.death_sources) + right.death_sources +',';
	self := left) );
								
ssn_recs := sort(death_sources_rolled, -official_last_seen, -official_first_seen);

////////////////////////////////////////////////////////////
/////////// Get Current and Previous Address ///////////////
/////////// for use with assessor and deed   ///////////////
////////////////////////////////////////////////////////////
Risk_Indicators.iid_constants.layout_outx getHeader(risk_indicators.iid_constants.layout_outx le) := TRANSFORM                                                                                                                                                                        
	dt_last1 := MAP(le.h.dt_last_seen<>0 => le.h.dt_last_seen, 
									le.h.dt_vendor_last_reported<>0 and le.h.src != mdr.sourcetools.src_TU_CreditHeader and le.h.src != mdr.sourcetools.src_Equifax_Quick and 
																											le.h.src != mdr.sourcetools.src_Equifax_Weekly => le.h.dt_vendor_last_reported,  // don't trust vendor dates from Transunion credit header or quick header or weekly header
									le.h.dt_first_seen<>0 => le.h.dt_first_seen,
									le.h.src != mdr.sourcetools.src_TU_CreditHeader and le.h.src != mdr.sourcetools.src_Equifax_Quick and 
																																			le.h.src != mdr.sourcetools.src_Equifax_Weekly => le.h.dt_vendor_first_reported, // don't trust vendor dates from Transunion credit header or quick header or weekly header
									0);
																																																																									
	dt_last := if(dt_last1 >= le.historydate, le.historydate, dt_last1);  // in a history mode, set all dates greater than history date equal to history date
																	
	dt_first := MAP(le.h.src = mdr.sourcetools.src_Equifax_Quick or le.h.src = mdr.sourcetools.src_Equifax_Weekly => le.h.dt_first_seen,          // if quick or weekly header then use that first seen
									le.h.dt_first_seen<>0 => le.h.dt_first_seen,
									dt_last <= le.h.dt_vendor_first_reported => dt_last, // make sure the dt_first is <= dt_last
									le.h.src != mdr.sourcetools.src_TU_CreditHeader => le.h.dt_vendor_first_reported, // don't trust vendor dates from Transunion credit header
									0);  
																																																																	
	// keep the addresses to figure current and previous
	self.chronoprim_range := le.h.prim_range;
	self.chronopredir := le.h.predir;
	self.chronoprim_name := le.h.prim_name;
	self.chronosuffix := le.h.suffix;
	self.chronopostdir := le.h.postdir;
	self.chronounit_desig := le.h.unit_desig;
	self.chronosec_range := le.h.sec_range;
	self.chronocity := le.h.city_name;
	self.chronostate := le.h.st;
	self.chronozip := le.h.zip;
	self.chronodate_first := dt_first;
	self.chronodate_last := dt_last;
	self.dt_last_seen := dt_last;
	self.chronocounty := le.h.county;
	self.chronogeo_blk := le.h.geo_blk;
	self := le;
end;

gHeader := group(sort(project(header_recs, transform(risk_indicators.iid_constants.layout_outx, self.h := left, self.dob:=(string)left.dob,self := left, self := [])),seq),seq);
tranHeader := project(gHeader, getHeader(LEFT));
gTranHeader := group(sort(project(tranHeader, transform(risk_indicators.layout_output, self := left)),seq),seq);

bsversion := 255;
experian_batch_feed := false;
bsOptions := 0;

rh := Risk_Indicators.iid_roll_header(gtranHeader, false, bsversion, experian_batch_feed, isFCRA, bsoptions);	// rollup the header records

with_best_addr := Risk_Indicators.iid_check_best(gHeader, rh/*, ExactMatchLevel*/, bsversion := 41);

// Current and previous addresses are needed to produce non-subject owners for property.
layout_didslim getCurrAddr(with_best_addr le) := transform
	// current address pick for matching isbestmatch, assuming 1 of the 3 addresses are best	
	CAaddrChooser := map(le.chronoaddr_isbest => 1, // input is current
											 le.chronoaddr_isbest2 => 2, // hist 1 is current
											 le.chronoaddr_isbest3 => 3, // hist 2 is current
											 4);	// don't know what the current address is
											 
	// populate the current address with the correct address
	self.predir := map(	CAaddrChooser=1 => le.chronopredir,
											CAaddrChooser=2 => le.chronopredir2,
											CAaddrChooser=3 => le.chronopredir3,
											'');
	self.prim_name := map(CAaddrChooser=1 => le.chronoprim_name,
												CAaddrChooser=2 => le.chronoprim_name2,
												CAaddrChooser=3 => le.chronoprim_name3,
												'');
	self.prim_range := map(	CAaddrChooser=1 => le.chronoprim_range,
													CAaddrChooser=2 => le.chronoprim_range2,
													CAaddrChooser=3 => le.chronoprim_range3,
													'');
	self.suffix := map(	CAaddrChooser=1 => le.chronosuffix,
											CAaddrChooser=2 => le.chronosuffix2,
											CAaddrChooser=3 => le.chronosuffix3,
											'');
	self.postdir := map(CAaddrChooser=1 => le.chronopostdir,
											CAaddrChooser=2 => le.chronopostdir2,
											CAaddrChooser=3 => le.chronopostdir3,
											'');
	self.unit_desig := map(	CAaddrChooser=1 => le.chronounit_desig,
													CAaddrChooser=2 => le.chronounit_desig2,
													CAaddrChooser=3 => le.chronounit_desig3,
													'');
	self.sec_range := map(CAaddrChooser=1 => le.chronosec_range,
												CAaddrChooser=2 => le.chronosec_range2,
												CAaddrChooser=3 => le.chronosec_range3,
												'');
	self.city_name := map(CAaddrChooser=1 => le.chronocity,
												CAaddrChooser=2 => le.chronocity2,
												CAaddrChooser=3 => le.chronocity3,
												'');
	self.st := map(	CAaddrChooser=1 => le.chronostate,
									CAaddrChooser=2 => le.chronostate2,
									CAaddrChooser=3 => le.chronostate3,
									'');
	self.zip := map(CAaddrChooser=1 => le.chronozip,
									CAaddrChooser=2 => le.chronozip2,
									CAaddrChooser=3 => le.chronozip3,
									'');									 

	self.county := map(CAaddrChooser=1 => le.chronocounty,
									CAaddrChooser=2 => le.chronocounty2,
									CAaddrChooser=3 => le.chronocounty3,
									'');		
									
	self.geo_blk := map(CAaddrChooser=1 => le.chronogeo_blk,
									CAaddrChooser=2 => le.chronogeo_blk2,
									CAaddrChooser=3 => le.chronogeo_blk3,
									'');	
									
	self := [];
END;
currAddr := project(with_best_addr, getCurrAddr(left));


// now get the previous address
layout_didslim getPrevAddr(with_best_addr le) := transform
	CAaddrChooser := map(le.chronoaddr_isbest => 1, // input is current
											 le.chronoaddr_isbest2 => 2, // hist 1 is current
											 le.chronoaddr_isbest3 => 3, // hist 2 is current
											 4);	// don't know what the current address is
											 
	// Previous address picker assumes that either the input or Address history 1 is current
	PAaddrChooser_temp := map(CAaddrChooser=1 => 2, // if input is current, then pick history 1 as previous
														CAaddrChooser=2 and le.chronodate_last > le.chronodate_last3 => 1,	// if hist 1 is current and input date last seen > hist 2 date last seen then input is previous
														CAaddrChooser=2 and le.chronodate_last = le.chronodate_last3 and
															le.chronodate_first >= le.chronodate_first3 => 1,	// if hist 1 is current and input date last seen = hist 2 date last seen and input date first seen >= hist 2 date first seen then input is previous
														CAaddrChooser=3 and le.chronodate_last > le.chronodate_last2 => 1, // if hist 2 is current and input date last seen > hist 1 date last seen then input is previous
														CAaddrChooser=3 and le.chronodate_last = le.chronodate_last2 and
															le.chronodate_first >= le.chronodate_first2 => 1,	// if hist 2 is current and input date last seen = hist 1 date last seen and input date first seen >= hist 1 date first seen then input is previous
														CAaddrChooser=2 => 3,	// if none of the above and hist 1 is current, then hist 2 is previous
														CAaddrChooser=4 => 4,	// no Current address chosen
														2);	// if none of the above and hist 2 is current, then hist 1 is previous
	
	// override the previous address chooser to 4 if the address selected as previous doesn't actually exist
	PAaddrChooser := if( (PAaddrChooser_temp=1 and le.chronoprim_name='') or
											 (PAaddrChooser_temp=2 and le.chronoprim_name2='') or
											 (PAaddrChooser_temp=3 and le.chronoprim_name3=''), 
											 4,
											 PAaddrChooser_temp);
								
	// now populate the previous address with the correct address							
	self.predir := map(	PAaddrChooser=1 => le.chronopredir,
											PAaddrChooser=2 => le.chronopredir2,
											PAaddrChooser=3 => le.chronopredir3,
											'');
	self.prim_name := map(PAaddrChooser=1 => le.chronoprim_name,
												PAaddrChooser=2 => le.chronoprim_name2,
												PAaddrChooser=3 => le.chronoprim_name3,
												'');
	self.prim_range := map(	PAaddrChooser=1 => le.chronoprim_range,
													PAaddrChooser=2 => le.chronoprim_range2,
													PAaddrChooser=3 => le.chronoprim_range3,
													'');
	self.suffix := map(	PAaddrChooser=1 => le.chronosuffix,
											PAaddrChooser=2 => le.chronosuffix2,
											PAaddrChooser=3 => le.chronosuffix3,
											'');
	self.postdir := map(PAaddrChooser=1 => le.chronopostdir,
											PAaddrChooser=2 => le.chronopostdir2,
											PAaddrChooser=3 => le.chronopostdir3,
											'');
	self.unit_desig := map(	PAaddrChooser=1 => le.chronounit_desig,
													PAaddrChooser=2 => le.chronounit_desig2,
													PAaddrChooser=3 => le.chronounit_desig3,
													'');
	self.sec_range := map(PAaddrChooser=1 => le.chronosec_range,
												PAaddrChooser=2 => le.chronosec_range2,
												PAaddrChooser=3 => le.chronosec_range3,
												'');
	self.city_name := map(PAaddrChooser=1 => le.chronocity,
												PAaddrChooser=2 => le.chronocity2,
												PAaddrChooser=3 => le.chronocity3,
												'');
	self.st := map(	PAaddrChooser=1 => le.chronostate,
									PAaddrChooser=2 => le.chronostate2,
									PAaddrChooser=3 => le.chronostate3,
									'');
	self.zip := map(PAaddrChooser=1 => le.chronozip,
									PAaddrChooser=2 => le.chronozip2,
									PAaddrChooser=3 => le.chronozip3,
									'');								 
	
	self.county := map(PAaddrChooser=1 => le.chronocounty,
									PAaddrChooser=2 => le.chronocounty2,
									PAaddrChooser=3 => le.chronocounty3,
									'');		
									
	self.geo_blk := map(PAaddrChooser=1 => le.chronogeo_blk,
									PAaddrChooser=2 => le.chronogeo_blk2,
									PAaddrChooser=3 => le.chronogeo_blk3,
									'');	
									
	self := [];	
end;
prevAddr := project(with_best_addr, getPrevAddr(left));

// =============================================
// ================     AVM     ================
// =============================================

layout_avm := avm_v2.layouts.Layout_AVM_Base_original; // keep the layout the same for now until we can coordinate with terrence on changing the ESP layouts

avm_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.AVM), flag_file_id );
avm_recid := SET(ds_flagfile(file_id = FCRA.FILE_ID.AVM), record_id );
avm_corr  := CHOOSEN(FCRA.key_override_avm_ffid( keyed( flag_file_id in avm_ffids ) ), MAX_OVERRIDE_LIMIT );

avm_main := join(bshell_dids,AVM_V2.Key_AVM_Address_FCRA,
	(left.did<>0 OR ssn_inquiry_match)
		and keyed(left.prim_name  = right.prim_name)
		and keyed(left.st         = right.st)
		and keyed(left.zip        = right.zip)
		and keyed(left.prim_range = right.prim_range)
		and keyed(left.sec_range  = right.sec_range)
		and right.automated_valuation<>0
		and trim(right.prim_range)+trim(right.prim_name)+trim(right.sec_range) not in avm_recid,
	transform( layout_avm, self := right, self := [] ),
	KEEP(100), LIMIT(1000)
);
avm_deduped := dedup(sort(avm_main,record),all);

avm_recs1  := avm_deduped + PROJECT( avm_corr, transform( layout_avm, self := LEFT ) );
avm_recs := sort(avm_recs1, -recording_date);

// avm Medians for current and previous address
address_plus := ungroup (currAddr) & ungroup (prevAddr);

// normalize the 2 addresses in currAddr/prevAddr into 
layout_avm_median_disclosure := record
	string10 prim_range;
	string2  predir;
	string28 prim_name;
	string4  suffix;
	string2  postdir;
	string10 unit_desig;
	string8  sec_range;
	string25 city_name;
	string2  st;
	string5  zip;
	string12 geolink;
	unsigned median_county_value;
	unsigned median_tract_value;
	unsigned median_block_value;
end;

layout_avm_median_disclosure_temp := record
  layout_avm_median_disclosure;
	integer whichaddr;
  string3 county;
	string7 geo_blk;
end;


layout_avm_median_disclosure_temp create_geolinks(address_plus le, integer c) := TRANSFORM
	SELF.whichaddr := c;
	countyfips := le.county;									
	statefips := ut.st2FipsCode(le.st);
	geoblk := 
	CHOOSE(c,'',  							// fips level only, first addr
					le.geo_blk[1..6],  	// block level, first addr
					le.geo_blk[1..7]  	// tract level, first addr
					);
	
	self.geolink := trim(statefips) + trim(countyfips) + trim(geoblk);
	SELF.st := le.st;
	SELF.county := countyfips;
	SELF.geo_blk := geoblk;
	self := le;
	self := [];
END;
with_geolinks := NORMALIZE(address_plus, 3, create_geolinks(LEFT,COUNTER));

layout_avm_median_disclosure getMedians(with_geolinks le, avm_v2.Key_AVM_Medians_fcra rt) := transform
	full_history_date := risk_indicators.iid_constants.full_history_date(999999);
	AVM_V2.MOD_get_AVM_from_History.MAC_get_Medians(rt, full_history_date, median_record);

	self.median_county_value := if(le.geolink[1..5]=median_record.fips_geo_12 and le.whichaddr=1, median_record.median_valuation, 0);
	self.median_tract_value := if(le.geolink[1..11]=median_record.fips_geo_12 and le.whichaddr=2, median_record.median_valuation, 0);
	self.median_block_value := if(le.geolink[1..12]=median_record.fips_geo_12 and le.whichaddr=3, median_record.median_valuation, 0);
	self := le;
end;
with_avm_medians := join(with_geolinks, avm_v2.Key_AVM_Medians_fcra, left.geolink=right.fips_geo_12, getMedians(left,right), left outer);
							
layout_avm_median_disclosure rollMedians(with_avm_medians le, with_avm_medians rt) := transform
	self.median_county_value := ut.max2(le.median_county_value, rt.median_county_value);
	self.median_tract_value := ut.max2(le.median_tract_value, rt.median_tract_value);
	self.median_block_value := ut.max2(le.median_block_value, rt.median_block_value);
  self.geolink := rt.geolink;
	self := le;
end;
rolled_AVM_Medians_raw := rollup(with_avm_medians, 
	left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.sec_range=right.sec_range, 
	rollMedians(left,right));
	
corrected_AVM_Medians := join(ds_flagfile(file_id=fcra.file_id.AVM_MEDIANS), 
															FCRA.Key_Override_AVM.avm_medians,
															keyed(left.flag_file_id=right.flag_file_id),
	transform(layout_avm_median_disclosure, self.geolink := left.record_id, self := right), left outer, atmost(riskwise.max_atmost));

rolled_AVM_medians1 := join(rolled_AVM_Medians_raw, corrected_avm_medians, 
	left.geolink=right.geolink,
		transform(layout_avm_median_disclosure,
			// if the right geolink is populated, take the right median values to handle corrections and suppressions
			// otherwise simply take the median values of the raw records
			self.median_county_value := if(right.geolink='', left.median_county_value, right.median_county_value);
			self.median_tract_value := if(right.geolink='', left.median_tract_value, right.median_tract_value);
			self.median_block_value := if(right.geolink='', left.median_block_value, right.median_block_value);
			self := left), left outer, keep(1));
			
rolled_AVM_medians := rolled_AVM_medians1(median_county_value<>0 or median_tract_value<>0 or median_block_value<>0);		


// ==========================================================
// ================     American Student     ================
// ==========================================================

Layout_Student := record
	american_student_list.key_DID_FCRA;
end;

student_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.STUDENT), flag_file_id );
student_keys  := SET(ds_flagfile(file_id = FCRA.FILE_ID.STUDENT), record_id );
student_corr  := CHOOSEN(FCRA.key_override_student_new_ffid( keyed( flag_file_id in student_ffids ) ), MAX_OVERRIDE_LIMIT );

student_main := join(dids,american_student_list.key_DID_FCRA,
	left.did<>0 and keyed(left.did=right.l_did) and (string)right.key not in student_keys,
	transform( layout_student, self := right ),
	KEEP(100), LIMIT(1000)
);
student_deduped := dedup(sort(student_main,record),record);

all_student_recs  := student_deduped + PROJECT( student_corr,
		transform( Layout_student,
			self.l_did := left.did,
			self := LEFT,
      self := []
		) );

// this transform taken from risk_indicators.boca_shell_student_fcra. rollup all ASL records to the same record we would use in production
all_student_recs asl_roll( all_student_recs le, all_student_recs ri ) := TRANSFORM
		self := map(
		
			// Use any other record over File Type 'M'
			le.file_type='M' and ri.file_type<>'M' => ri,
			ri.file_type='M' and le.file_type<>'M'=> le,	
	
			// current ASL over historical -- SRC BECOMES HISTORICAL_FLAG
			le.historical_flag='C' and ri.historical_flag='H' => le,
			le.historical_flag='H' and ri.historical_flag='C' => ri,

			// take the newer record when the DLS are unequal
			le.date_last_seen > ri.date_last_seen => le,
			le.date_last_seen < ri.date_last_seen => ri,

			// take american student over alloy -- NOT APPLICABLE HERE SINCE IT'S ALL ASL
			// le.src in ['C','H','S'] and ri.src = 'A' => le,
			// ri.src in ['C','H','S'] and le.src = 'A' => ri,

			// take the newer record when the DFS are unequal
			le.date_first_seen > ri.date_first_seen => le,
			le.date_first_seen < ri.date_first_seen => ri,

			le
		);
	END;
student_recs1 := rollup( all_student_recs, true, asl_roll(left,right) );

student_recs := sort(student_recs1, -date_last_Seen, -date_first_Seen);



		
// ==========================================================
// ================           Alloy          ================
// ==========================================================

Layout_Alloy := record
	AlloyMedia_student_list.Key_DID_FCRA;
end;

alloy_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.STUDENT_ALLOY), flag_file_id );
alloy_keys  := SET(ds_flagfile(file_id = FCRA.FILE_ID.STUDENT_ALLOY), record_id );
alloy_corr  := CHOOSEN(FCRA.key_override_alloy_ffid( keyed( flag_file_id in alloy_ffids ) ), MAX_OVERRIDE_LIMIT );


// from david lenz:
// The records are normalized since a raw record can contain multiple addresses.  So, a unique identifier would
// be sequence_number + key_code + rawaid. You will notice that if you look at all of the fields in that record
// that they are actually the same except for the standardized/clean fields.

// string7   sequence_number;
// string15  key_code;
// unsigned8 rawaid; // string20?

alloy_main := join(dids, AlloyMedia_student_list.Key_DID_FCRA,
	left.did<>0
		and keyed(left.did=right.did)
		and ( TRIM(right.sequence_number) + TRIM(right.key_code) + (string)right.rawaid ) not in alloy_keys
		,
	transform( Layout_Alloy, self := right ),
	KEEP(100), LIMIT(1000)
);
alloy_deduped := dedup(sort(alloy_main,record),all);

alloy_recs1  := alloy_deduped + PROJECT( alloy_corr, transform(Layout_alloy, self := left, self := []) );
alloy_recs := sort(alloy_recs1, -date_last_seen, -date_first_seen);

// ==========================================================
// ======================     Gong     ======================
// ==========================================================

gong_recs1 := RiskWiseFCRA._Gong_data (dids, ds_flagfile(file_id = FCRA.FILE_ID.GONG));
gong_recs := sort(gong_recs1, -dt_last_seen, -dt_first_seen);
		
// ==========================================================
// ======================    Impulse   ======================
// ==========================================================

Layout_Impulse := recordof(Impulse_Email.Key_Impulse_DID_FCRA);

impulse_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.IMPULSE), flag_file_id );
impulse_keys  := SET(ds_flagfile(file_id = FCRA.FILE_ID.IMPULSE), trim(record_id) );
impulse_corr  := CHOOSEN(FCRA.key_override_impulse_ffid( keyed( flag_file_id in impulse_ffids ) ), MAX_OVERRIDE_LIMIT );

impulse_main := join(dids,Impulse_Email.Key_Impulse_DID_FCRA,
												left.did<>0 and keyed(left.did=right.did) and trim((string)right.did)+trim(right.created) not in impulse_keys,	// created and last modified should be 8 byte (20100215)
												transform( layout_impulse, self := right ),
												KEEP(100), LIMIT(1000)
											);
impulse_deduped := dedup(sort(impulse_main,record),all);

impulse_recs1 := impulse_deduped + PROJECT( impulse_corr,
												transform( Layout_Impulse,
													self := LEFT,
													self := []
												) );
												
impulse_recs := sort(impulse_recs1, -DateVendorLastReported, -DateVendorFirstReported);									
												
// ==========================================================
// ======================    Infutor   ======================
// ==========================================================
		
Layout_Infutor := recordof(InfutorCID.Key_Infutor_DID_FCRA);

infutor_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.INFUTOR), flag_file_id );
infutor_keys  := SET(ds_flagfile(file_id = FCRA.FILE_ID.INFUTOR), trim(record_id) );
infutor_corr  := CHOOSEN(FCRA.key_override_infutor_ffid( keyed( flag_file_id in infutor_ffids ) ), MAX_OVERRIDE_LIMIT );

infutor_main  := join(dids, InfutorCID.Key_Infutor_DID_FCRA,
												left.did<>0 and keyed(left.did=right.did) 
												and trim((string)right.did)+trim(right.phone)+trim((string)right.dt_first_seen) not in infutor_keys  // old way - exclude corrected records from prior to 11/13/2012
												and trim(right.persistent_record_id) not in infutor_keys, // new way, use the persistent_record_id
												transform( layout_infutor, self := right),
												KEEP(100), LIMIT(1000)
											);
infutor_deduped := dedup(sort(infutor_main,record),all);

infutor_recs1 := infutor_deduped + PROJECT( infutor_corr,
												transform( Layout_Infutor,
													self := LEFT
												  ) );

infutor_recs := sort(infutor_recs1 , -dt_last_seen, -dt_first_seen);									
													

// ==========================================================
// ======================    Email   	 ======================
// ==========================================================
Layout_Email := recordof(email_data.Key_Did_FCRA);

email_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.email_data), flag_file_id );
email_correction_keys  := SET(ds_flagfile(file_id = FCRA.FILE_ID.email_data), trim(record_id) );
email_corr  := CHOOSEN(FCRA.key_override_email_data_ffid( keyed(flag_file_id in email_ffids ) ), MAX_OVERRIDE_LIMIT );

email_main  := join(dids, email_data.Key_Did_FCRA,
												left.did<>0 and keyed(left.did=right.did)
												and (string)right.email_rec_key not in email_correction_keys,
												transform(Layout_Email, self := right),
												KEEP(100), LIMIT(1000)
											);
email_deduped := dedup(sort(email_main,record),all);  // dedup all just in case the data has any dups

email_recs1 := email_deduped + PROJECT( email_corr, transform( Layout_Email, self := LEFT) );
email_recs	:= sort(email_recs1, -date_last_seen, -date_first_seen);

// ==========================================================
// ======================    ADVO      ======================
// ==========================================================
Layout_ADVO := recordof(Advo.Key_Addr1_FCRA);

advo_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.advo), flag_file_id );
advo_correction_keys  := SET(ds_flagfile(file_id = FCRA.FILE_ID.advo), trim(record_id) );
advo_corr  := CHOOSEN(FCRA.key_override_advo_ffid( keyed( flag_file_id in advo_ffids ) ), MAX_OVERRIDE_LIMIT );

advo_main  := join(bshell_dids, Advo.Key_Addr1_FCRA,
		(left.did<>0 OR ssn_inquiry_match) and left.zip != '' and left.prim_range != '' and
					keyed(left.zip = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(left.sec_range = right.sec_range)
		and trim(right.zip) + trim(right.prim_range) + trim(right.prim_name) + trim(right.sec_range) not in advo_correction_keys,
	transform( Layout_ADVO, self := right, self := [] ),
	KEEP(1), LIMIT(1000));
										
advo_recs1 := advo_main + PROJECT( advo_corr, transform( Layout_ADVO, self := LEFT, self := []) );
advo_recs  := sort(advo_recs1, -date_last_seen, -date_first_seen);						


// ==========================================================
// ======================    FCRA OPT Outs  =================
// ==========================================================
fcra_opt_outs  := join(dids, fcra_opt_out.key_did,
					left.did!=0 and 
					keyed(left.did = right.l_DID),
				  transform(recordof(fcra_opt_out.key_did),  
										self := right),
					atmost(riskwise.max_atmost), keep(1));

// output(header_correction_keys, named('header_correction_keys'));	
// output(header_corr, named('header_corr'));
// output(qheader_main, named('qheader_main'));
// output(header_main, named('header_main'));
// output(combo_header, named('combo_header'));	
// output(corrPlusHeader, named('corrplusheader'));
// output(finalcorr, named('finalcorr'));	
// output(s, named('s'));
// output(finalcorr2, named('finalcorr2'));
// OUTPUT (finalHeaderRecs, NAMED ('header'));
		
layout_output doDeceased( bshell_w_flags le ) := TRANSFORM
  isDeceased := exists(ssn_recs(isDeceased));

  im_not_dead := exists(ssn_corr(not isDeceased));
  
  SELF.VRU_code := map(
    im_not_dead => 3,
    IsDeceased  => 0,
    le.VRU_code
  );
  
  msg := StringLib.StringFindReplace( le.VRU_Message, ' [deceased]', '' ); // remove the deceased indicator which can come from the VRU
  SELF.VRU_message := map(
    im_not_dead => 'ssn: correction record utilized',
    isDeceased  => msg + ' [deceased]',
    msg
  );

  self := le;
END;
bshell_w_flags__decs := project( bshell_w_flags, doDeceased(left) );
OUTPUT (bshell_w_flags__decs, NAMED ('VRU_identity_output'));


boolean VRU_ok := MAX(bshellID,VRU_code) > 1 OR MAX (bshell_id, did) != 0 or (did_value != 0)
	or ssn_inquiry_match;

IF (VRU_ok, OUTPUT (finalHeaderRecs, NAMED ('header')));
IF (VRU_ok, OUTPUT (ssn_recs(ssn=ssn_val), named('ssn')));

property_recs := RiskWiseFCRA._property_data (bshell_dids, ungroup (currAddr), ungroup (prevAddr), ssn_inquiry_match, ds_flagfile, nss);
IF (VRU_ok, OUTPUT (property_recs.search, NAMED ('property_search')));
IF (VRU_ok, OUTPUT (property_recs.assessments, NAMED ('assessment')));
IF (VRU_ok, OUTPUT (property_recs.deeds, NAMED ('deed')));

RiskWiseFCRA._Bankruptcy_data(dids, ds_flagfile, bankruptcy_search_f, bankruptcy_f, bankruptcy_courts_f, history_date, bankruptcy_withdraw_f);
IF (VRU_ok, OUTPUT (bankruptcy_search_f, NAMED ('bankruptcy_search')));
IF (VRU_ok, OUTPUT (bankruptcy_f,        NAMED ('bankruptcy')));
IF (VRU_ok, OUTPUT (bankruptcy_courts_f, NAMED ('bankruptcy_courts')));
IF (VRU_ok, OUTPUT (bankruptcy_withdraw_f, NAMED ('bankruptcy_withdraw')));

RiskWiseFCRA._Lien_data(dids, ds_flagfile, liens_main_f, liens_party_f, nss, history_date, getDebtorOnly:=false);
IF (VRU_ok, OUTPUT (liens_main_f,   NAMED ('liens_main')));
IF (VRU_ok, OUTPUT (liens_party_f,  NAMED ('liens_party')));

crim_recs := RiskWiseFCRA._crim_data (dids, ds_flagfile, SkipRiskviewFilters);
IF (VRU_ok, OUTPUT (crim_recs.offenders,      NAMED ('offenders')));
IF (VRU_ok, OUTPUT (crim_recs.offenses,       NAMED ('offenses')));
IF (VRU_ok, OUTPUT (crim_recs.punishments,    NAMED ('punishment')));
IF (VRU_ok, OUTPUT (crim_recs.offenders_plus, NAMED ('offenders_plus')));
IF (VRU_ok, OUTPUT (crim_recs.court_offenses, NAMED ('court_offenses')));
IF (VRU_ok, OUTPUT (crim_recs.activity,       NAMED ('activity')));

proflic_recs := RiskWiseFCRA._Prof_License_data(dids, ds_flagfile);
IF (VRU_ok, OUTPUT (proflic_recs, NAMED ('professional_license')));

IF (VRU_ok, OUTPUT (student_recs, NAMED ('student_new')));
IF (VRU_ok, OUTPUT (alloy_recs, NAMED ('alloy')));
IF (VRU_ok, OUTPUT (avm_recs, NAMED ('avm')));
IF (VRU_ok, output (rolled_AVM_Medians, named('avm_medians')));
IF (VRU_ok, OUTPUT (gong_recs, NAMED ('gong')));
IF (VRU_ok, OUTPUT (impulse_recs, NAMED ('impulse')));
IF (VRU_ok, OUTPUT (infutor_recs, NAMED ('infutor')));

IF (VRU_ok, OUTPUT (email_recs, NAMED ('email')));

paw_recs := RiskWiseFCRA._PAW_data(dids, ds_flagfile);
IF (VRU_ok, OUTPUT (paw_recs, NAMED ('people_at_work')));

IF (VRU_ok, OUTPUT (advo_recs, NAMED ('advo')));

IF (VRU_ok, OUTPUT (inquiry_recs, NAMED ('inquiries')));

watercrafts := RiskWiseFCRA._watercraft_data (dids, ds_flagfile, nss);
IF (VRU_ok, OUTPUT (watercrafts.owners, NAMED ('watercraft')));
IF (VRU_ok, OUTPUT (watercrafts.coastguard, NAMED ('watercraft_coastguard')));
IF (VRU_ok, OUTPUT (watercrafts.details, NAMED ('watercraft_details')));

faa_recs := RiskWiseFCRA._FAA_data (dids, ds_flagfile);
IF (VRU_ok, OUTPUT (faa_recs.aircrafts, NAMED ('aircraft')));
IF (VRU_ok, OUTPUT (faa_recs.aircraft_details, NAMED ('aircraft_details')));
IF (VRU_ok, OUTPUT (faa_recs.aircraft_engine, NAMED ('aircraft_engine')));
IF (VRU_ok, OUTPUT (faa_recs.pilot_registrations, NAMED ('pilot_registration')));
IF (VRU_ok, OUTPUT (faa_recs.pilot_certificates, NAMED ('pilot_certificate')));

ccw_recs := RiskWiseFCRA._CCW_data (dids, ds_flagfile).ccw;
IF (VRU_ok, OUTPUT (ccw_recs, NAMED ('concealed_weapons')));

huntfish_recs := RiskWiseFCRA._HuntingFishing_data (dids, ds_flagfile).hunting_fishing;
IF (VRU_ok, OUTPUT (huntfish_recs, NAMED ('hunting_fishing_license')));

atf_recs := RiskWiseFCRA._ATF_data (dids, ds_flagfile (file_id = FCRA.FILE_ID.ATF), nss);
IF (VRU_ok, OUTPUT (atf_recs.atf, named ('ATF')));

md_recs := RiskWiseFCRA._MarriageDivorce_data (dids, ds_flagfile, nss);
IF (VRU_ok, OUTPUT (md_recs.main, named ('marriage_main')));
IF (VRU_ok, OUTPUT (md_recs.party, named ('marriage_search')));

thrive_recs := RiskWiseFCRA._thrive_data(dids, ds_flagfile);
IF (VRU_ok, OUTPUT (thrive_recs, named ('thrive')));

Prof_License_Mari_recs := RiskWiseFCRA._Prof_License_Mari_data(dids, ds_flagfile);
IF (VRU_ok, OUTPUT (Prof_License_Mari_recs, named ('prof_license_mari')));

IF (VRU_ok, OUTPUT (fcra_opt_outs, named ('fcra_opt_outs')));

so_recs := RiskWiseFCRA._SO_data (dids, ds_flagfile);
IF (VRU_ok, OUTPUT (so_recs.so_main, named ('so_main')));
IF (VRU_ok, OUTPUT (so_recs.so_offenses, named ('so_offenses')));

IF (VRU_ok, OUTPUT (ssn_recs(ssn in set(unique_inquiry_ssns, ssn)), named('ssns_from_inquiries')));

DID_death := RiskWiseFCRA._Death_data(dids, ds_flagfile);
IF (VRU_ok, OUTPUT (DID_death, named ('DID_Death')));

input_address_prep := project(bshell_dids, transform(riskwiseFCRA.layouts.layout_addresses_data_input, self := left));

address_data := RiskWiseFCRA._address_Data(input_address_prep, ds_flagfile);
IF (VRU_ok, OUTPUT (address_data, named ('input_address_data')));

// todo:  check with Brad to see if we need to run this on all addresses in inquiries as well
// inquiry_addr_data := address_data( address = inquiry address );
// IF (VRU_ok, OUTPUT (inquiry_addr_data, named ('inquiry_addr_data')));


// for debugging only
// output(bshell_dids, named('bshell_dids'));
// output(bshell_w_flags, named('bshell_w_flags'));
// OUTPUT (bshell_dids, NAMED ('bshell_dids'));
// OUTPUT (address_plus, NAMED ('address_plus'));
// output(ds_flagfile, named('ds_flagfile'));
// output(with_geolinks, named('with_geolinks'));
// output(with_avm_medians, named('with_avm_medians'));
// OUTPUT(corrected_avm_medians, named('corrected_avm_medians'));								
// OUTPUT (ssn_inquiries, named('ssn_fcra_inquiries')) );
	
ENDMACRO;