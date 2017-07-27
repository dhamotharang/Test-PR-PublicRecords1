/*--SOAP--
<message name="Phone Append Process">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
 </message>
*/
/*--INFO-- Migrating pha0, pha1, pha2, and ph50 to boca */

import address, ut, suppress, risk_indicators, didville, AutoStandardI;

export RiskWiseMainHCLO := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'first',
	'last',
	'addr',
	'city',
	'state',
	'zip',
	'DPPAPurpose',
	'GLBPurpose', 
	'DataRestrictionMask',
	'ApplicationType',
	'HistoryDateYYYYMM'));

string4  tribCode_value := ''  : stored('tribcode');	// not used in prii
string30 account_value := ''   : stored('account');
string20 first_value := ''     : stored('first');
string20 last_value := ''      : stored('last');
string50 addr_value := ''      : stored('addr');
string25 city_value := ''      : stored('city');
string2  state_value := ''     : stored('state');
string5  zip_value := ''       : stored('zip');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');

unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean isUtility := false;
boolean ln_branded := false;
boolean ofac_only := true;
boolean suppressNearDups := true;
boolean require2Ele := true;
full_history_date := (STRING8)((STRING6)history_date+'01');
myGetDate := IF(history_date=999999,ut.GetDate,full_history_date);
myDaysApart(string8 d1, string8 d2) := ut.DaysApart(d1,d2) <= 365 OR (unsigned)d2 >= (unsigned)full_history_date;
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

fz := '4GZ';
dedup_these := true;
allscores := false;
min_addrscore := 80;

tribCode := StringLib.StringToLowerCase(tribCode_value);

clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);

dwelltype(STRING1 at) := MAP(at='F' => '',	// changed to blank from B on 6/16/05, F seems to mean an invalid address
					    at='G' => 'S',
					    at='H' => 'A',
					    at='P' => 'E',
					    at='R' => 'R',
					    at='S' => ' ',  // this may be incorrect, it could be a G
					    '');

working_layout := record
	STRING30  account := '';
	UNSIGNED6 did := 0;
	UNSIGNED2 didscore := 0;
	UNSIGNED4 seq := 0;
     STRING15  in_first :='';
     STRING20  in_last :='';
     STRING50  in_addr :='';
     STRING30  in_city :='';
     STRING2   in_state :='';
     STRING9   in_zip :='';
     STRING210 ca_prim_range :='';
     STRING2   ca_predir :='';
     STRING28  ca_prim_name :='';
     STRING4   ca_addr_suffix :='';
     STRING2   ca_postdir :='';
     STRING10  ca_unit_desig :='';
     STRING8   ca_sec_range :='';
	STRING50  ca_addr := '';
	STRING25	ca_city := '';
	STRING2	ca_state := '';
	STRING5	ca_zip := '';
	STRING4	ca_zip4 := '';
	STRING2	ca_addr_type := '';
	STRING4	ca_addr_status := '';
	STRING1   gong_hitcode := '0';
     STRING15  gong_first :='';
     STRING20  gong_last :='';
	STRING5   gong_suffix := '';
	STRING50  gong_cmpy := '';
	STRING50  gong_addr := '';
     STRING30  gong_city :='';
     STRING2   gong_state :='';
     STRING5   gong_zip :='';
     STRING4   gong_zip4 :='';
     STRING210 gong_prim_range :='';
     STRING2   gong_predir :='';
     STRING28  gong_prim_name :='';
     STRING4   gong_addr_suffix :='';
     STRING2   gong_postdir :='';
     STRING10  gong_unit_desig :='';
     STRING8   gong_sec_range :='';
	STRING8   gong_date_last_seen := '';
	BOOLEAN   gong_bus_flag := false;
	BOOLEAN   gong_current_flag := false;
	UNSIGNED1 gong_firstscore := 0;
	UNSIGNED1 gong_lastscore := 0;
	UNSIGNED1 gong_addrscore := 0;
	STRING10  gong_phone10 := '';
	STRING1   gong_publish_code := '';
	STRING1   gong_addrtype :='';
	BOOLEAN   hdr_hitcode := false;
     STRING15  hdr_first :='';
     STRING20  hdr_last :='';
	STRING5   hdr_suffix := '';
	STRING50  hdr_cmpy := '';
	STRING50  hdr_addr := '';
     STRING30  hdr_city :='';
     STRING2   hdr_state :='';
     STRING5   hdr_zip :='';
     STRING4   hdr_zip4 :='';
     STRING210 hdr_prim_range :='';
     STRING2   hdr_predir :='';
     STRING28  hdr_prim_name :='';
     STRING4   hdr_addr_suffix :='';
     STRING2   hdr_postdir :='';
     STRING10  hdr_unit_desig :='';
     STRING8   hdr_sec_range :='';
	STRING8   hdr_date_last_seen := '';
	STRING1   hdr_tnt := '';
	UNSIGNED1 hdr_firstscore := 0;
	UNSIGNED1 hdr_lastscore := 0;
	UNSIGNED1 hdr_addrscore := 0;
	BOOLEAN   gong2_hitcode := false;
     STRING15  gong2_first :='';
     STRING20  gong2_last :='';
	STRING5   gong2_suffix := '';
	STRING50  gong2_cmpy := '';
	STRING50  gong2_addr := '';
     STRING30  gong2_city :='';
     STRING2   gong2_state :='';
     STRING5   gong2_zip :='';
     STRING4   gong2_zip4 :='';
     STRING210 gong2_prim_range :='';
     STRING2   gong2_predir :='';
     STRING28  gong2_prim_name :='';
     STRING4   gong2_addr_suffix :='';
     STRING2   gong2_postdir :='';
     STRING10  gong2_unit_desig :='';
     STRING8   gong2_sec_range :='';
	STRING8   gong2_date_last_seen := '';
	BOOLEAN   gong2_bus_flag := false;
	BOOLEAN   gong2_current_flag := false;
	UNSIGNED1 gong2_firstscore := 0;
	UNSIGNED1 gong2_lastscore := 0;
	UNSIGNED1 gong2_addrscore := 0;
	STRING10  gong2_phone10 := '';
	STRING1   gong2_publish_code := '';
     STRING210 ca2_prim_range :='';
     STRING2   ca2_predir :='';
     STRING28  ca2_prim_name :='';
     STRING4   ca2_addr_suffix :='';
     STRING2   ca2_postdir :='';
     STRING10  ca2_unit_desig :='';
     STRING8   ca2_sec_range :='';
	STRING25	ca2_city := '';
	STRING2	ca2_state := '';
	STRING5	ca2_zip := '';
	STRING4	ca2_zip4 := '';
	STRING2	ca2_addr_type := '';
	STRING4	ca2_addr_status := '';
	BOOLEAN   coaalertflag := false;
	STRING1   phonestatusflag :='';
     STRING1   addrstatusflag :='';
	STRING10  phone :='';
	STRING1   areacodesplitflag := '';
	STRING8   areacodesplitdate := '';
	STRING3   altareacode := '';
     STRING2   internalcode :='';
     STRING1   addrcharflag2 :='';
     STRING1   phonestatusflag2 :='';
     STRING1   addrstatusflag2 :='';
     STRING10  phone2 :='';
	STRING1   areacodesplitflag2 := '';
	STRING8   areacodesplitdate2 := '';
	STRING3   altareacode2 := '';
     STRING2   internalcode2 :='';
     STRING1   coaflag :='';
end;

t := dataset([{''}], working_layout);
 
working_layout fill(t l, integer c) := transform 
	self.seq := c;
	self.account := account_value;
	self.in_first := stringlib.stringtouppercase(first_value);
	self.in_last := stringlib.stringtouppercase(last_value);
	self.in_addr := addr_value;
	self.in_city := city_value;
	self.in_state := state_value;
	self.in_zip := zip_value;
	self.ca_prim_range := clean_a2[1..10];
	self.ca_predir := clean_a2[11..12];
	self.ca_prim_name := clean_a2[13..40];
	self.ca_addr_suffix := clean_a2[41..44];
	self.ca_postdir := clean_a2[45..46];
	self.ca_unit_desig := clean_a2[47..56];
	self.ca_sec_range := clean_a2[57..64];
	self.ca_addr := Risk_Indicators.MOD_AddressClean.street_address('',self.ca_prim_range,self.ca_predir,self.ca_prim_name,self.ca_addr_suffix,self.ca_postdir,'',self.ca_sec_range);
	self.ca_city := clean_a2[90..114];
	self.ca_state := clean_a2[115..116];
	self.ca_zip := IF(clean_a2[117..121]<>'',clean_a2[117..121],zip_value[1..5]);	// use the input zip if cass zip is empty
	self.ca_zip4 := clean_a2[122..125];
	self.ca_addr_type := clean_a2[139];
	self.ca_addr_status := clean_a2[179..182];
	self := [];	
end;

inputrec := project(t, fill(left, counter));

Risk_Indicators.Layouts.Layout_Input_Plus_Overrides gong_prep(t le) := transform
	self.fname := le.in_first;
	self.lname := le.in_last;
	self.prim_range := le.ca_prim_range;
	self.predir := le.ca_predir;
	self.prim_name := le.ca_prim_name;
	self.addr_suffix := le.ca_addr_suffix;
	self.postdir := le.ca_postdir;
	self.unit_desig := le.ca_unit_desig;
	self.sec_range := le.ca_sec_range;
	self.p_city_name := le.ca_city;
	self.st := le.ca_state;
	self.z5 := le.ca_zip;
	self.zip4 := le.ca_zip4;
	self := [];
end;
ad := project(inputrec, gong_prep(left));

dirsaddr := riskwise.getDirsByAddr(ad);

//Search gong by address and score first name, last name and address

working_layout add_gong(inputrec le, dirsaddr ri) := transform
	firstscore := Risk_Indicators.FnameScore(le.in_first, ri.name_first);
	lastscore := Risk_Indicators.LnameScore(le.in_last, ri.name_last);
	lastmatch := Risk_Indicators.g(lastscore);
	self.did := ri.did;
     self.gong_hitcode := MAP(tribCode = 'pha0' => IF((le.ca_addr_type = 'F' OR le.ca_addr_type = 'S') AND ri.prim_name <> '','1','0'), 
						tribCode = 'pha2' => IF(lastmatch, '1','0'),
						IF(ri.prim_name <> '','1','0'));

	self.gong_first := ri.name_first; 
     self.gong_last := ri.name_last; 
     self.gong_suffix := ri.name_suffix; 
     self.gong_cmpy := ri.listed_name; 
     self.gong_prim_range := ri.prim_range;
     self.gong_predir := ri.predir;
     self.gong_prim_name := ri.prim_name;
     self.gong_addr_suffix := ri.suffix;
     self.gong_postdir := ri.postdir;
     self.gong_sec_range := ri.sec_range;
     self.gong_addr := Risk_Indicators.MOD_AddressClean.street_address('',ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,'',ri.sec_range);
     self.gong_city := ri.p_city_name;
     self.gong_state := ri.st;
     self.gong_zip := ri.z5;
     self.gong_zip4 := ri.z4;
     self.gong_phone10 := ri.phone10;
     self.gong_publish_code := ri.publish_code;
     self.gong_date_last_seen := ri.dt_last_seen;
     self.gong_bus_flag := ri.business_flag;
     self.gong_current_flag := ri.current_flag;
     self.gong_firstscore := if(firstscore=255, 0, firstscore);
     self.gong_lastscore := if(lastscore=255, 0,lastscore);
     self.gong_addrscore := Risk_Indicators.AddrScore.AddressScore(le.ca_prim_range, le.ca_prim_name, le.ca_sec_range,
									 ri.prim_range, ri.prim_name, ri.sec_range);
	self := le;
end;

dirs_added := join(inputrec, dirsaddr,
						left.ca_prim_name=right.prim_name and left.ca_state=right.st and left.ca_zip=right.z5 and left.ca_prim_range=right.prim_range and
				          ((unsigned)RIGHT.dt_first_seen < (unsigned)full_history_date and
						(RIGHT.current_flag OR myDaysApart(myGetDate,((STRING6)RIGHT.deletion_date[1..6]+'01')))),				          
						add_gong(left,right),
						left outer, many lookup, ATMOST(left.ca_prim_name=right.prim_name and left.ca_state=right.st and left.ca_zip=right.z5 and left.ca_prim_range=right.prim_range,RiskWise.max_atmost), keep(500));
	
gong_added := sort(dirs_added, seq, -gong_lastscore, -gong_firstscore, -gong_current_flag, -gong_date_last_seen);

//Pick the best gong record
working_layout filter1(gong_added le, gong_added ri) := transform
	chooser1 := MAP(ri.gong_hitcode >= le.gong_hitcode AND ~ri.gong_bus_flag AND le.gong_bus_flag => true,  //11/22 - added this to keep a residential record over a business record
				 le.gong_current_flag=true and ri.gong_current_flag=false => false,
				 ri.gong_hitcode >= le.gong_hitcode and ri.gong_date_last_seen >= le.gong_date_last_seen and ri.gong_lastscore >= le.gong_lastscore AND ri.gong_firstscore >= le.gong_firstscore => true,
				 false);
	self := if(chooser1, ri, le);										
end;

one_gong := rollup(gong_added, true, filter1(left, right)); 				

//Get alternate area code information

working_layout get_ac_split(one_gong le, risk_indicators.Key_AreaCode_Change_plus ri) :=
TRANSFORM
	SELF.areacodesplitflag := IF(ri.old_NPA<>'' and ~ri.reverse_flag,'Y','N');
	SELF.areacodesplitdate := if(~ri.reverse_flag, ri.permissive_start, '');
	SELF.altareacode := if(~ri.reverse_flag, ri.new_NPA, '');
	SELF := le;
END;

ac_split := JOIN(one_gong, risk_indicators.Key_AreaCode_Change_plus, LENGTH(TRIM(LEFT.gong_phone10))=10 AND
												   keyed(LEFT.gong_phone10[1..3]=RIGHT.old_NPA) AND
												   keyed(LEFT.gong_phone10[4..6]=RIGHT.old_NXX) and
												   (unsigned)right.permissive_start[1..6] < history_date,
												   get_ac_split(LEFT,RIGHT),left outer);
												   

//Format the didville record using gong data (if we got a hit) or cassed address data

didville.Layout_did_outbatch popDidInput(ac_split le) := transform
	self.seq := le.seq;
	self.prim_range := IF(le.gong_hitcode = '1',le.gong_prim_range,le.ca_prim_range);
	self.predir := IF(le.gong_hitcode = '1',le.gong_predir,le.ca_predir);
	self.prim_name:= IF(le.gong_hitcode = '1',le.gong_prim_name,le.ca_prim_name);
	self.addr_suffix  := IF(le.gong_hitcode = '1',le.gong_addr_suffix,le.ca_addr_suffix);
	self.postdir:= IF(le.gong_hitcode = '1',le.gong_postdir,le.ca_postdir);
	self.unit_desig:= IF(le.gong_hitcode = '1',le.gong_unit_desig,le.ca_unit_desig);
	self.sec_range:= IF(le.gong_hitcode = '1',le.gong_sec_range,le.ca_sec_range);
	self.p_city_name:= IF(le.gong_hitcode = '1',le.gong_city,le.ca_city);
	self.st:= IF(le.gong_hitcode = '1',le.gong_state,le.ca_state);
	self.z5:= IF(le.gong_hitcode = '1',le.gong_zip,le.ca_zip);
	self.zip4:= IF(le.gong_hitcode = '1',le.gong_zip4,le.ca_zip4);
	self.fname := IF(le.gong_hitcode = '1',le.gong_first,le.in_first);
	self.lname := IF(le.gong_hitcode = '1',le.gong_last,le.in_last);	
	self := [];
end;

didprep := PROJECT(ac_split, popDidInput(left));

didville.MAC_DidAppend(didprep,resu,dedup_these,fz,allscores)
  
//Add the did to our working_layout record

working_layout joinDID(ac_split le, resu ri) := transform
	self.did := ri.did;
	self.didscore := ri.score;
	self := le;
end;

didadded := JOIN(ac_split,resu, LEFT.seq=RIGHT.seq, joinDID(LEFT, RIGHT), LEFT OUTER);

//Search header by did...score first, last and address and also set COA flag if input address is different from header address
e := record
	unsigned6 did := 0;
end;

eqfs := riskwise.getHeaderByDid(project(didadded, transform(e, self:=left)), DPPA_Purpose, GLB_Purpose, false, DataRestriction);

working_layout addheader(didadded le, eqfs ri) := transform
	fname := IF(le.gong_hitcode = '1', le.gong_first, le.in_first);
	lname := IF(le.gong_hitcode = '1', le.gong_last, le.in_last);
	prim_range := IF(le.gong_hitcode = '1', le.gong_prim_range, le.ca_prim_range);
	prim_name := IF(le.gong_hitcode = '1', le.gong_prim_name, le.ca_prim_name);
	sec_range := IF(le.gong_hitcode = '1', le.gong_sec_range, le.ca_sec_range);
	zip := IF(le.gong_hitcode = '1', le.gong_zip, le.ca_zip);
     self.hdr_hitcode := IF(ri.prim_name <> '',true,false);
	self.hdr_first := ri.fname;
	self.hdr_last := ri.lname;
	self.hdr_suffix := ri.name_suffix;
	self.hdr_prim_range := ri.prim_range;	
	self.hdr_predir := ri.predir;	
	self.hdr_prim_name := ri.prim_name;	
	self.hdr_addr_suffix := ri.suffix;	
	self.hdr_postdir := ri.postdir;	
	self.hdr_sec_range := ri.sec_range;	
	self.hdr_addr := Risk_Indicators.MOD_AddressClean.street_address('',ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,'',ri.sec_range);
	self.hdr_city:= ri.city_name;
	self.hdr_state := ri.st;
	self.hdr_zip := ri.zip;
	self.hdr_zip4 := ri.zip4;
	self.hdr_date_last_seen := (string)ri.dt_last_seen;
	self.hdr_tnt := ri.tnt;
	self.hdr_firstscore := Risk_Indicators.FnameScore(fname, ri.fname);
	self.hdr_lastscore := Risk_Indicators.LnameScore(lname, ri.lname);
	self.hdr_addrscore := Risk_Indicators.AddrScore.AddressScore(prim_range, prim_name, sec_range,
										   ri.prim_range, ri.prim_name, ri.sec_range);
	self.coaalertflag := IF(le.didscore > 90 AND self.hdr_addrscore < min_addrscore,1,0);	//didscore > 90 means the input address matched the did file so this is the right person.
	self := le;																//But the address is different than input so set COA flag.
end;

dirs_and_header := join(didadded, eqfs,
						right.s_did = left.did and left.did <> 0 and
						(RIGHT.dt_first_seen < history_date),
						addheader(left, right),
						left outer, many lookup);

combined_gong_header := sort(dirs_and_header, seq, hdr_date_last_seen);

working_layout filter2(combined_gong_header le, combined_gong_header ri) := transform
	chooser2 := ri.hdr_tnt = 'B' AND ri.hdr_date_last_seen[1..6] >= le.hdr_date_last_seen[1..6];	  	//narrow down to 1 header record with the most recent dt_last_seen		 
	self := if(chooser2, ri, le);											//move all fields from the most recent record
end;


one_header := rollup(combined_gong_header, true, filter2(left, right));				//do the actual rollup to narrow down to one record

//match the COA back to the Gong file
Risk_Indicators.Layouts.Layout_Input_Plus_Overrides gong_prep2(one_header le) := transform
	self.prim_range := le.hdr_prim_range;
	self.predir := le.hdr_predir;
	self.prim_name := le.hdr_prim_name;
	self.addr_suffix := le.hdr_addr_suffix;
	self.postdir := le.hdr_postdir;
	self.unit_desig := le.hdr_unit_desig;
	self.sec_range := le.hdr_sec_range;
	self.p_city_name := le.hdr_city;
	self.st := le.hdr_state;
	self.z5 := le.hdr_zip;
	self.zip4 := le.hdr_zip4;
	self := [];
end;

ad2 := project(one_header, gong_prep2(left));

dirsaddr2 := riskwise.getDirsByAddr(ad2);

working_layout add_gong2(inputrec le, dirsaddr2 ri) := transform
     self.gong2_hitcode := IF(ri.prim_name <> '',true,false);
     self.gong2_first := ri.name_first;
	self.gong2_last := ri.name_last;
	self.gong2_suffix := ri.name_suffix;	
	self.gong2_cmpy := IF(ri.business_flag,ri.listed_name,'');
	self.gong2_prim_range := ri.prim_range;	
	self.gong2_predir := ri.predir;	
	self.gong2_prim_name := ri.prim_name;	
	self.gong2_addr_suffix := ri.suffix;	
	self.gong2_postdir := ri.postdir;	
	self.gong2_sec_range := ri.sec_range;	
	self.gong2_addr := Risk_Indicators.MOD_AddressClean.street_address('',ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,'',ri.sec_range);
	self.gong2_city := ri.p_city_name;
	self.gong2_state := ri.st;
	self.gong2_zip := ri.z5;
	self.gong2_zip4 := ri.z4;
	self.gong2_phone10 := ri.phone10;
	self.gong2_publish_code := ri.publish_code;
	self.gong2_date_last_seen := (string)ri.dt_last_seen;
	self.gong2_bus_flag := ri.business_flag;
	self.gong2_current_flag := ri.current_flag;
	self.gong2_firstscore := Risk_Indicators.FnameScore(le.hdr_first, ri.name_first);
	self.gong2_lastscore := Risk_Indicators.LnameScore(le.hdr_last, ri.name_last);
	self.gong2_addrscore := Risk_Indicators.AddrScore.AddressScore(le.ca_prim_range, le.ca_prim_name, le.ca_sec_range,
									 ri.prim_range, ri.prim_name, ri.sec_range);
	self := le;
end;

dirs2_added := join(one_header, dirsaddr2,
					left.hdr_prim_name=right.prim_name and left.hdr_state=right.st and 
					left.hdr_zip=right.z5 and left.hdr_prim_range=right.prim_range and
					((unsigned)RIGHT.dt_first_seen < (unsigned)full_history_date and
					(RIGHT.current_flag OR myDaysApart(myGetDate,((STRING6)RIGHT.deletion_date[1..6]+'01')))),				          
					add_gong2(left,right),
					left outer, many lookup, ATMOST(left.hdr_prim_name=right.prim_name and left.hdr_state=right.st and 
					left.hdr_zip=right.z5 and left.hdr_prim_range=right.prim_range,RiskWise.max_atmost), keep(100));


gong2_added := sort(dirs2_added, seq, -gong2_date_last_seen);

working_layout filter3(gong2_added le, gong2_added ri) := transform
	chooser1 := ri.gong2_date_last_seen[1..6] >= le.gong2_date_last_seen[1..6] AND ri.gong2_firstscore > le.gong2_firstscore;
	self := if(chooser1, ri, le);										
end;

one_gong2 := rollup(gong2_added, true, filter3(left, right)); 				

//Get alternate area code information

working_layout get_ac_split2(one_gong2 le, risk_indicators.Key_AreaCode_Change_plus ri) :=
TRANSFORM
	SELF.areacodesplitflag2 := IF(ri.old_NPA<>'' and ~ri.reverse_flag,'Y','N');
	SELF.areacodesplitdate2 := if(~ri.reverse_flag, ri.permissive_start, '');
	SELF.altareacode2 := if(~ri.reverse_flag, ri.new_NPA, '');
	SELF := le;
END;

ac_split2 := JOIN(one_gong2, risk_indicators.Key_AreaCode_Change_plus, LENGTH(TRIM(LEFT.gong2_phone10))=10 AND
												   keyed(LEFT.gong2_phone10[1..3]=RIGHT.old_NPA) AND
												   keyed(LEFT.gong2_phone10[4..6]=RIGHT.old_NXX) and
												   (unsigned)right.permissive_start[1..6] < history_date,
												   get_ac_split2(LEFT,RIGHT),left outer);


working_layout cassit2(ac_split2 le) := transform 
	clean_a22 := Risk_Indicators.MOD_AddressClean.clean_addr(le.gong_addr, le.gong_city, le.gong_state, le.gong_zip);
	clean_a23 := Risk_Indicators.MOD_AddressClean.clean_addr(le.gong2_addr, le.gong2_city, le.gong2_state, le.gong2_zip);

	
	self.ca2_prim_range := clean_a23[1..10];
	self.ca2_predir := clean_a23[11..12];
	self.ca2_prim_name := clean_a23[13..40];
	self.ca2_addr_suffix := clean_a23[41..44];
	self.ca2_postdir := clean_a23[45..46];
	self.ca2_unit_desig := clean_a23[47..56];
	self.ca2_sec_range := clean_a23[57..64];
	self.ca2_city := clean_a23[90..114];
	self.ca2_state := clean_a23[115..116];
	self.ca2_zip := clean_a23[117..121];
	self.ca2_zip4 := clean_a23[122..125];
	self.ca2_addr_type := clean_a23[139];
	self.ca2_addr_status := clean_a23[179..182];
	self.gong_addrtype := clean_a22[139];
	self := le;	
end;

cassadded2 := project(ac_split2, cassit2(left));

cassadded_rolled := rollup(cassadded2, true, filter3(left,right));


RiskWise.Layout_HCLO format_out(cassadded_rolled le) := TRANSFORM

	firstmatch := Risk_Indicators.g(le.gong_firstscore);
	lastmatch := Risk_Indicators.g(le.gong_lastscore);
	addrmatch := Risk_Indicators.ga(le.gong_addrscore);
	firstmatch2 := Risk_Indicators.g(le.gong2_firstscore);
	lastmatch2 := Risk_Indicators.g(le.gong2_lastscore);
	addrmatch2 := Risk_Indicators.ga(le.gong2_addrscore);

	SELF.account := le.account;
	SELF.riskwiseid := (STRING)le.did;									// outputting the did here, doug should not use this
	SELF.inputaddrcharflag := MAP(tribcode = 'pha0' => IF(le.in_addr = '', '0', dwelltype(le.ca_addr_type)),
							tribCode = 'pha2' => dwelltype(le.ca_addr_type),
							tribCode = 'pha1' => '1',
							'');
	SELF.phonestatusflag := IF(tribcode = 'pha0', MAP (le.gong_hitcode = '1' AND le.gong_publish_code <> 'P'=> '2',
										 le.gong_hitcode = '1' AND addrmatch => '5',
										 ''),
										 MAP (tribCode = 'pha2' AND le.gong_hitcode = '0' => '', 
										 le.gong_hitcode = '1' AND le.gong_publish_code <> 'P'=> '2',
										 addrmatch AND lastmatch AND firstmatch=> '3',
										 addrmatch AND lastmatch=> '4',
										 addrmatch => '5',
										 '')); 
	SELF.phone := MAP(le.gong_hitcode = '1' AND le.gong_publish_code = 'P' => le.gong_phone10,
				   '');
	SELF.altareacode := le.altareacode;
	SELF.splitdate := le.areacodesplitdate;
	SELF.internalcode := '00'; 
	SELF.phonestatusflag2 := IF(tribCode = 'pha2' AND le.coaalertflag, 
									   MAP (le.gong2_publish_code <> 'P'=> '2',
									   addrmatch2 AND lastmatch2 AND firstmatch2=> '3',
									   addrmatch2 AND lastmatch2=> '4',
									   addrmatch2 => '5',
									   ''),
									   '');
	SELF.phone2 := IF(tribCode = 'pha2' AND le.coaalertflag, le.gong2_phone10, '');
	SELF.altareacode2 := IF((tribCode = 'pha2' OR tribCode = 'ph50') AND le.coaalertflag, le.altareacode2, '');
	SELF.splitdate2 := IF((tribCode = 'pha2' OR tribCode = 'ph50') AND le.coaalertflag, le.areacodesplitdate2, '');
	SELF.internalcode2 := '00';
	SELF.addrstatusflag := IF(tribCode = 'pha0', '0', 
									   MAP (~le.gong_hitcode = '1' => '0',
									   addrmatch AND lastmatch AND firstmatch AND le.ca_prim_range = le.gong_prim_range => '1',
									   addrmatch AND lastmatch AND firstmatch AND le.ca_prim_range <> le.gong_prim_range => '3',
									   addrmatch AND lastmatch AND le.ca_prim_range = le.gong_prim_range => '2',
									   addrmatch AND lastmatch AND le.ca_prim_range <> le.gong_prim_range => '4',
									   addrmatch AND le.ca_prim_range = le.gong_prim_range => '6',
									   '5'));
	SELF.addrcharflag := MAP (tribCode = 'pha0' => IF(le.in_addr = '', '0', dwelltype(le.ca_addr_type)),
						 tribCode = 'pha1' => '1',
						 tribCode = 'pha2' => dwelltype(le.gong_addrtype),
						 '');
	SELF.first := IF(le.gong_hitcode = '1',le.gong_first,'');
	SELF.last := IF(le.gong_hitcode = '1',le.gong_last,'');
	SELF.addr := IF(le.gong_hitcode = '1',le.gong_addr,IF(tribCode = 'pha2',le.ca_addr,''));
	SELF.city := IF(le.gong_hitcode = '1',le.gong_city,IF(tribCode = 'pha2',le.ca_city,''));
	SELF.state := IF(le.gong_hitcode = '1',le.gong_state,IF(tribCode = 'pha2',le.ca_state,''));
	SELF.zip := IF(le.gong_hitcode = '1',le.gong_zip + le.gong_zip4,IF(tribCode = 'pha2',le.ca_zip + le.ca_zip4,''));
	SELF.addrstatusflag2 := IF(tribCode = 'pha2' AND le.coaalertflag,
									   MAP (~le.gong2_hitcode => '0',
									   lastmatch2 AND firstmatch2 AND le.ca_prim_range = le.gong2_prim_range => '1',  //this seems odd to be comparing the cass'ed input house number
									   lastmatch2 AND firstmatch2 AND le.ca_prim_range <> le.gong2_prim_range => '3', //     to the coa house number but that's what St. Cloud does.
									   lastmatch2 AND le.ca_prim_range = le.gong2_prim_range => '2',
									   lastmatch2 AND le.ca_prim_range <> le.gong2_prim_range => '4',
									   le.ca_prim_range = le.gong2_prim_range => '6',
									   '5'),
									   '');
	SELF.addrcharflag2 := IF(tribCode = 'pha2' AND le.coaalertflag, dwelltype(le.ca2_addr_type), '');
	SELF.first2 := IF(tribCode = 'pha2' AND le.coaalertflag, le.gong2_first, '');
	SELF.last2 := IF(tribCode = 'pha2' AND le.coaalertflag, le.gong2_last, '');
	SELF.addr2 := IF(tribCode = 'pha2' AND le.coaalertflag, le.gong2_addr, '');
	SELF.city2 := IF(tribCode = 'pha2' AND le.coaalertflag, le.gong2_city, '');
	SELF.state2 := IF(tribCode = 'pha2' AND le.coaalertflag, le.gong2_state, '');
	SELF.zip2 := IF(tribCode = 'pha2' AND le.coaalertflag, le.gong2_zip + le.gong2_zip4, '');
	SELF.coaflag := '';
	self := [];	
						
	
END;
final := PROJECT(cassadded_rolled, format_out(LEFT));

// remove output if on the following files
Suppress.MAC_Suppress(cassadded_rolled,out2,apptype,Suppress.Constants.LinkTypes.DID,did);

emptyset := dataset([{account_value}], riskwise.Layout_HCLO);
ret := if(StringLib.StringToLowerCase(tribCode_value) in ['pha0', 'pha1', 'pha2', 'ph50'] and count(out2)!=0, final, emptyset);

output(ret, named('Results'));

ENDMACRO;
// RiskWise.RiskWiseMainHCLO()