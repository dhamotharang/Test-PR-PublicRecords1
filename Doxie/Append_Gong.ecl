import dx_Gong, dx_header, Did_add, suppress, ut, risk_indicators, moxie_phonesplus_server, iesp, doxie, STD, address;
import lib_datalib, NID; // to be able to call a macro in a JOIN condition

todays_date := (string) STD.Date.Today();

export Append_Gong(DATASET(doxie.layout_presentation) in_f,
  DATASET(doxie.layout_relative_dids) rels,
  Doxie.IDataAccess mod_access,
  integer dcp_value = 5,
  boolean include_phonesPlus = FALSE,
  unsigned1 score_threshold_value = 0,
  string phoneToMatch = '') :=
FUNCTION
// TODO: only add did in Phones if <> orig did?
cell_text := 'Possible Cell Phone';
nonDA_text := 'Possible non DA';

layout_new := doxie.layout_presentation_phones;

layout_didmatch :=
RECORD
  unsigned6 did;
  unsigned6 did2match;
  boolean is_relat;
END;

rels2match := PROJECT(rels(isRelative), TRANSFORM(layout_didmatch,
                                              SELF.did := LEFT.person1,
                                              SELF.did2match := LEFT.person2,
                                              SELF.is_relat := true));
in_did := PROJECT(in_f(did<>0),TRANSFORM(layout_didmatch,
                                              SELF.did := LEFT.did,
                                              SELF.did2match := LEFT.did,
                                              SELF.is_relat := false));
dids := DEDUP(SORT(in_did+IF(dcp_value>=4,rels2match),did, did2match, is_relat), did, did2match);

layout_hhidmatch :=
RECORD
  unsigned6 did2return2;
  unsigned6 hhid;
  boolean is_relat;
END;

index_did_hdid := dx_header.key_did_hhid();
layout_hhidmatch take_hhid(index_did_hdid le) := transform
  self.hhid := le.hhid_relat;
  SELF.did2return2 := le.did;
  SELF.is_relat := true;
end;
rels2match_hhid := join(rels2match,index_did_hdid,
                        keyed (left.did=right.did) and
                        keyed (right.ver = 1),
                        take_hhid(right), atmost (ut.limits.HHID_PER_PERSON), left outer);

incoming_hhid := PROJECT(in_f,TRANSFORM(layout_hhidmatch,
                                  SELF.hhid := LEFT.hhid,
                                  SELF.did2return2 := LEFT.did,
                                  SELF.is_relat := false));

in_hhid := dedup(sort(rels2match_hhid+incoming_hhid(hhid<>0), did2return2, hhid, is_relat), did2return2, hhid);

did_key := dx_Gong.key_did();
hhid_key := dx_Gong.key_hhid();
curr_addr_key := dx_Gong.key_address_current();
history_phone_key := dx_Gong.key_history_phone();
supp_key := suppress.key_pullPhone;

layout_gong_out :=
RECORD
  dx_Gong.layout_prepped_for_keys;
  unsigned6 did;
  unsigned6 did2return2 := 0;
  unsigned6 did2match := 0;
  unsigned6 hhid := 0;
  unsigned6 bdid := 0;
  boolean is_relat;
  UNSIGNED4 global_sid := 0;
  UNSIGNED8 record_sid := 0;
END;

//use the most current gong did records
layout_gong_out get_did_base(dids le, did_key ri) := transform
  SELF.is_relat := le.is_relat;
  self.did := le.did;
  self.did2match := ri.l_did;
  self.global_sid := ri.global_sid;
  self.record_sid := ri.record_sid;
  self := ri;
  self := [];
end;

_did_base_recs := join(dids,did_key,
  left.did2match = right.l_did,get_did_base(left,right), ATMOST(50));

did_base_recs := Suppress.MAC_SuppressSource(_did_base_recs, mod_access, did2match);
final_did := dedup(sort(did_base_recs(ut.NNEQ(phoneToMatch,phone10)),
                   bdid,did,listed_name,phone10),bdid,did,listed_name,phone10);

//use the most current gong hhid records
layout_gong_out get_hhid_base(in_hhid le, hhid_key ri) := transform
  SELF.did2return2 := le.did2return2;
  SELF.did := 0;
  SELF.is_relat := le.is_relat;
  self := ri;
  self := [];
end;

hhid_base_recs := join(in_hhid,hhid_key,
                         left.hhid = right.s_hhid,get_hhid_base(LEFT, RIGHT), ATMOST(50));

final_hhid := dedup(sort(hhid_base_recs(ut.NNEQ(phoneToMatch,phone10)),
                    bdid,did,listed_name,phone10),bdid,did,listed_name,phone10);;

layout_gong_out hhid2did(final_hhid le) :=
TRANSFORM
  SELF.did := le.did2return2;
  SELF := le;
END;
relats_hhids := PROJECT(final_hhid(is_relat), hhid2did(LEFT));

non_relat_dids := project(dids(~is_relat),doxie.layout_references);
doxie.mac_best_records(non_relat_dids,did,b,true,true,false,mod_access.DataRestrictionMask);
/*NOTE: Notice that glb_per has been set as TRUE even when GLB_Purpose is a parameter received by this attribute.
        The reason for doing that is because the address of the best record (returned by mac_best_records) is used solely to categorize
        the address that the procedure actually returns.  GLB information is not exposed at this point.
        Furthermore, the hardcoded value of TRUE is necessary for a consistent result of the value of "tnt", which is the only one affected (see next TRANSFORM)
        This comment was added for ticket 191943 */

doxie.layout_presentation init_tnt(doxie.layout_presentation le, b ri) := transform
  self.tnt := if(DID_Add.Address_Match_Score(LE.prim_range, LE.prim_name, LE.sec_range, LE.zip,
              RI.prim_range, RI.prim_name, RI.sec_range, RI.zip) BETWEEN 76 AND 254
                  AND le.prim_range=ri.prim_range,
        'C', 'H');
  self := le;
end;

in_init_ready := join(in_f, b,
                  left.did = right.did,
                  init_tnt(left,right),left outer,PARALLEL);

f_slim_ap_roll := doxie.fn_roll_gong_dates(in_init_ready(phone<>''), mod_access);

layout_new append_phone_dates(in_init_ready l, f_slim_ap_roll r) := transform
  self.phone_last_seen := if(r.phone_last_seen>r.phone_first_seen, r.phone_last_seen, r.phone_first_seen);
  self.phone_first_seen := r.phone_first_seen;
  self := l;
end;

in_init := join(in_init_ready, f_slim_ap_roll,
  left.prim_name=right.prim_name and
  left.prim_range=right.prim_range and
  left.st=right.st and
  left.zip=right.zip and
  left.phone=right.phone,
  append_phone_dates(left, right), left outer, keep(1));

//update listed_name, listed_phone, tnt fields with gong did records
ext_in_rec := record
  layout_new;
  integer gong_score;
end;

doxie.Layout_Phones add_did_phones(final_did le, integer gong_score) :=
TRANSFORM
  SELF.match_type := IF(le.is_relat,4,1);
  SELF.listed := true;
  SELF.bdid := 0;
  SELF.did := le.did2match;
  SELF.gong_score := gong_score;
  SELF.listing_type_cell := '';
  SELF.new_type := '';
  SELF.carrier := '';
  SELF.carrier_city := '';
  SELF.carrier_state := '';
  SELF.PhoneType := '';
  SELF.phone_first_seen := (integer)le.filedate[1..6];
  SELF.phone_last_seen := (integer)(todays_date[1..6]);
  SELF.timezone := '';
  SELF := le;
END;

ext_in_rec checkgDID(in_init le, final_did ri) := transform
  self.listed_name := ri.listed_name;
  self.listed_name_prefix:= ri.name_prefix;
  self.listed_name_first:= ri.name_first;
  self.listed_name_middle:= ri.name_middle;
  self.listed_name_last:= ri.name_last;
  self.listed_name_suffix:= ri.name_suffix;
  self.listed_phone := ri.phone10;
  SELF.phone_first_seen := if(ri.phone10='',le.phone_first_seen,(integer)ri.filedate[1..6]);
  SELF.phone_last_seen := if(ri.phone10='',le.phone_last_seen,(integer)(todays_date[1..6]));
  self.gong_score := if(ri.listed_name = '', 500,
    datalib.nameMatch(le.fname, le.mname, le.lname, ri.name_first, ri.name_middle, ri.name_last));
  self.tnt := map(ri.is_relat => le.tnt,
    ri.did != 0 AND le.tnt = 'C' => 'B',
    le.tnt = 'C' => 'C',
    ri.did != 0 AND ut.DaysApart(le.dt_last_seen+'00', todays_date) < 31*6 => 'P',
    le.tnt);
  SELF.phones := IF(ri.did<>0,DATASET(PROJECT(ri,add_did_phones(LEFT,self.gong_score))));
  SELF.publish_code := ri.publish_code;
  SELF := le;
END;

in_by_did := JOIN(in_init, final_did+relats_hhids,
  LEFT.did = RIGHT.did AND
  ((DID_Add.Address_Match_Score(LEFT.prim_range, LEFT.prim_name, LEFT.sec_range, LEFT.zip,
    RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range, RIGHT.z5) BETWEEN 76 AND 254 AND
  LEFT.prim_range=RIGHT.prim_range) OR
  (RIGHT.prim_name='' AND RIGHT.prim_range='' AND LEFT.zip=RIGHT.z5 AND
  (LEFT.tnt='C' OR
  (ut.DaysApart(LEFT.dt_last_seen+'00', todays_date) < ut.DaysInNYears(1))))),
          checkgDID(LEFT, RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL);

//gjw//add PhonesPlus records
doxie.layout_references didTrans(in_init L) := TRANSFORM
  self.did := (integer)L.did;
END;

//get all phonesPlus records for Dids
justdids := dedup(sort(project(in_init, didTrans(left)),did),did);
phplRecs := moxie_phonesplus_server.phonesplus_did_records (
  justdids,
  iesp.Constants.BR.MaxPhonesPlus,
  score_threshold_value,
  mod_access.glb,
  mod_access.dppa,, TRUE).w_timezoneSeenDt;

doxie.Layout_Phones add_phonesPlus(phplRecs le, integer gong_score) :=
TRANSFORM
  SELF.phone10 := le.phoneno;
  SELF.match_type := 3; //3 specifically for phonesPlus records.
  SELF.new_type := if (le.listing_type_cell <> '', cell_text,nonDA_text);
  SELF.phone_first_seen := le.first_seen;
  SELF.phone_last_seen := le.last_seen;
  SELF.listed := true;
  SELF.bdid := 0;
  SELF.did := (unsigned6)le.did;
  SELF.gong_score := gong_score;
  SELF.listing_type_gov := '';
  SELF.caption_text := '';
  SELF := le;
END;

ext_in_rec checkphplDID(in_by_did le, phplRecs ri) := transform
  SELF.listed_name := ri.listed_name;
  SELF.listed_name_prefix:= '';
  SELF.listed_name_first:= ri.name_first;
  SELF.listed_name_middle:= ri.name_middle;
  SELF.listed_name_last:= ri.name_last;
  SELF.listed_name_suffix:= ri.name_suffix;
  SELF.listed_phone := ri.phoneno;
  SELF.gong_score := if(ri.listed_name = '', 500, datalib.nameMatch(le.fname, le.mname, le.lname, ri.name_first, ri.name_middle, ri.name_last));
  SELF.phones := IF((integer)ri.did<>0,DATASET(PROJECT(ri,add_phonesPlus(LEFT,self.gong_score))));
  SELF.publish_code := le.publish_code;
  SELF := le;
END;
in_by_phpl := JOIN(in_by_did, phplRecs, (string)LEFT.did = RIGHT.did AND
  ((DID_Add.Address_Match_Score(LEFT.prim_range, LEFT.prim_name, LEFT.sec_range, LEFT.zip,
    RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range, RIGHT.z5) BETWEEN 76 AND 254 AND
  LEFT.prim_range=RIGHT.prim_range) OR (RIGHT.prim_name='' AND RIGHT.prim_range='' AND
  LEFT.zip=RIGHT.z5 AND (LEFT.tnt='C' OR
  (ut.DaysApart(LEFT.dt_last_seen+'00', todays_date) < ut.DaysInNYears(1))))),
    checkphplDID(LEFT, RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL);
in_next := if (include_phonesPlus,in_by_phpl,in_by_did);

//gjw//endOF add PhonesPlus records
//update listed_name, listed_phone, tnt fields with gong hhid records
doxie.Layout_Phones add_hhid_phones(final_hhid le, integer gong_score) :=
TRANSFORM
  SELF.match_type := IF(le.is_relat,4,2);
  SELF.listed := true;
  SELF.did := 0;
  SELF.bdid := 0;
  SELF.gong_score := gong_score;
  SELF.timezone :='';
  SELF.listing_type_cell := '';
  SELF.new_type := '';
  SELF.carrier := '';
  SELF.carrier_city := '';
  SELF.carrier_state := '';
  SELF.PhoneType := '';
  SELF.phone_first_seen := (integer)le.filedate[1..6];
  SELF.phone_last_seen := (integer)(todays_date[1..6]);
  SELF := le;
END;

ext_in_rec checkgHHID(in_next le, final_hhid ri) := transform
  new_gong_score := datalib.nameMatch(le.fname, le.mname, le.lname, ri.name_first, ri.name_middle, ri.name_last);
  choose_new_gong := (new_gong_score < le.gong_score) and ri.hhid != 0;
  self.listed_name := IF(choose_new_gong, ri.listed_name, le.listed_name);
  self.listed_name_prefix:= IF(choose_new_gong, ri.name_prefix, le.listed_name_prefix);
  self.listed_name_first:= IF(choose_new_gong, ri.name_first, le.listed_name_first);
  self.listed_name_middle:= IF(choose_new_gong, ri.name_middle, le.listed_name_middle);
  self.listed_name_last:= IF(choose_new_gong, ri.name_last, le.listed_name_last);
  self.listed_name_suffix:= IF(choose_new_gong, ri.name_suffix, le.listed_name_suffix);
  self.listed_phone := IF(choose_new_gong, ri.phone10, le.listed_phone);
  self.phone_first_seen := if(choose_new_gong and ri.phone10<>'',(integer)ri.filedate[1..6],le.phone_first_seen);
  self.phone_last_seen := if(choose_new_gong and ri.phone10<>'',(integer)(todays_date[1..6]),le.phone_last_seen);
  self.gong_score := IF(choose_new_gong, new_gong_score, le.gong_score);
  self.tnt := MAP(ri.is_relat => le.tnt,
    le.tnt = 'B' => 'B',
    ri.hhid != 0 AND le.tnt = 'C' => 'V',
    le.tnt = 'C' => 'C',
    ri.hhid != 0 AND ut.DaysApart(le.dt_last_seen+'00', todays_date) < 31*6 => 'P',
    le.tnt = 'P' => 'P',
    ri.hhid != 0 => 'R',
    le.tnt);
  SELF.phones := le.phones+IF(ri.hhid<>0,DATASET(PROJECT(ri,add_hhid_phones(LEFT, self.gong_score))));
  SELF.publish_code := IF(choose_new_gong, ri.publish_code, le.publish_code);
  self := le;
END;

in_by_hhid := JOIN(in_next(hhid != 0), final_hhid(~is_relat),
  dcp_value >=2 AND
  left.hhid = right.hhid and
  DID_Add.Address_Match_Score(LEFT.prim_range, LEFT.prim_name, LEFT.sec_range, LEFT.zip,
    RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range, RIGHT.z5) BETWEEN 76 AND 254
  AND LEFT.prim_range=RIGHT.prim_range,
  checkgHHID(LEFT, RIGHT), left outer, MANY LOOKUP, PARALLEL) + in_next(hhid = 0);

doxie.gong_append_utils.MAC_lookupAptCount(in_by_hhid,withApt);

withApt keepBestTNT(withApt le, withApt ri) := transform
  self.listed_name := IF(le.listed_phone != '', le.listed_name, ri.listed_name);
  self.listed_name_prefix:= IF(le.listed_phone != '', le.listed_name_prefix, ri.listed_name_prefix);
  self.listed_name_first:= IF(le.listed_phone != '', le.listed_name_first, ri.listed_name_first);
  self.listed_name_middle:= IF(le.listed_phone != '', le.listed_name_middle, ri.listed_name_middle);
  self.listed_name_last:= IF(le.listed_phone != '', le.listed_name_last, ri.listed_name_last);
  self.listed_name_suffix:= IF(le.listed_phone != '', le.listed_name_suffix, ri.listed_name_suffix);
  self.listed_phone := IF(le.listed_phone != '', le.listed_phone, ri.listed_phone);
  self.publish_code := IF(le.listed_phone != '', le.publish_code, ri.publish_code);
  self.tnt := MAP(le.tnt = 'B' or ri.tnt = 'B' => 'B',
    le.tnt = 'V' or ri.tnt = 'V' => 'V',
    le.tnt = 'C' or ri.tnt = 'C' => 'C',
    le.tnt = 'P' or ri.tnt = 'P' => 'P',
    le.tnt = 'R' or ri.tnt = 'R' => 'R', 'H');
  SELF.phones := choosen(dedup(sort(le.phones&ri.phones,phone10,listed_name,gong_score),phone10,listed_name),rollup_limits.phones);
  SELF := le;
END;

out_roll := ROLLUP(SORT(withApt, rid, gong_score, -listed_phone, -listed_name), rid, keepBestTNT(LEFT, RIGHT));

gong_addr_rec_slim := record
  curr_addr_key.DID;
  curr_addr_key.listed_name;
  curr_addr_key.fname;
  curr_addr_key.mname;
  curr_addr_key.lname;
  curr_addr_key.name_suffix;
  curr_addr_key.prim_name;
  curr_addr_key.sec_range;
  curr_addr_key.phone10;
  curr_addr_key.date_first_seen;
  curr_addr_key.listing_type;
  curr_addr_key.global_sid;
  curr_addr_key.record_sid;
  boolean is_suppressed := false;
end;

rec_out_roll_ext := record
  out_roll;
  gong_addr_rec_slim gong_addr_rec;
  dataset(doxie.Layout_Phones) gong_addr_phones;
end;

// extra work to add some phone number when no listing got appended
doxie.Layout_Phones add_addr_phones(curr_addr_key le, integer gong_score) :=
TRANSFORM
  SELF.match_type := 5;
  SELF.listed := true;
  SELF.did := 0;
  SELF.bdid := 0;
  SELF.gong_score := gong_score;
  Self.listing_type_res := if (le.listing_type & dx_Gong.Constants.PTYPE.RESIDENTIAL = dx_Gong.Constants.PTYPE.RESIDENTIAL, 'R', '');
  Self.listing_type_bus := if (le.listing_type & dx_Gong.Constants.PTYPE.BUSINESS    = dx_Gong.Constants.PTYPE.BUSINESS, 'B', '');
  Self.listing_type_gov := if (le.listing_type & dx_Gong.Constants.PTYPE.GOVERNMENT  = dx_Gong.Constants.PTYPE.GOVERNMENT, 'G', '');
  SELF.phone_first_seen := (integer)le.date_first_seen[1..6];
  SELF.phone_last_seen := (integer)(todays_date[1..6]);
//  Self.listing_type_cell; in the future can be read from listing_type as well
  SELF := le;
  SELF := []; // timezone, listing_type_cell, new_type, carrier, carrier_city
END;


rec_out_roll_ext checkAddr(out_roll le, curr_addr_key ri) := TRANSFORM
  self.gong_addr_rec := ri;
  self.gong_addr_phones := DATASET(PROJECT(ri,add_addr_phones(LEFT, le.gong_score)));
  self := le;
  self := [];
end;

// Join current Gong records:
//To avoid inappropriate matches among persons living in apartment buildings, among other things. . .
//The street number of both addresses must match, *AND* . . .
// . . .( the LEFT dwelling is a house (apt_cnt <= 1). OR . . .
// . . .  both dwellings have similar enough sec_ranges. OR . . .
// . . .  both dwellings have differing sec_ranges but whose occupants have similar enough names ).

j_addr_pre := JOIN(out_roll, curr_addr_key,
  (ut.DaysApart((STRING6)LEFT.dt_last_seen+'31',todays_date) < 365 or dcp_value >= 5) AND
  keyed(LEFT.prim_name = RIGHT.prim_name) AND
  keyed(LEFT.st = RIGHT.st) AND
  keyed(LEFT.zip = RIGHT.z5) AND
  keyed(LEFT.prim_range = RIGHT.prim_range) AND
  ut.NNEQ (Left.suffix, Right.suffix) AND
  doxie.gong_append_utils.MAC_sec_range(true), checkAddr(LEFT,RIGHT), LEFT OUTER, ATMOST(100));

j_addr_sup_flag := Suppress.MAC_FlagSuppressedSource (j_addr_pre, mod_access, gong_addr_rec.did, gong_addr_rec.global_sid);  

j_addr := project(j_addr_sup_flag, transform(recordof(out_roll),
  _gong_addr_rec := if(~left.is_suppressed, left.gong_addr_rec, row([], gong_addr_rec_slim));
  SELF.listed_name := IF(left.listed_phone != '', left.listed_name, _gong_addr_rec.listed_name);
  SELF.listed_name_prefix:= IF(left.listed_phone != '', left.listed_name_prefix, '');
  SELF.listed_name_first:= IF(left.listed_phone != '', left.listed_name_first, _gong_addr_rec.fname);
  SELF.listed_name_middle:= IF(left.listed_phone != '', left.listed_name_middle, _gong_addr_rec.mname);
  SELF.listed_name_last:= IF(left.listed_phone != '', left.listed_name_last, _gong_addr_rec.lname);
  SELF.listed_name_suffix:= IF(left.listed_phone != '', left.listed_name_suffix, _gong_addr_rec.name_suffix);
  SELF.listed_phone := IF(left.listed_phone != '', left.listed_phone, _gong_addr_rec.phone10);
  self.phone_first_seen := if(left.listed_phone = '' and _gong_addr_rec.phone10<>'',(integer)_gong_addr_rec.date_first_seen[1..6],left.phone_first_seen);
  self.phone_last_seen := if(left.listed_phone = '' and _gong_addr_rec.phone10<>'',(integer)(todays_date[1..6]),left.phone_last_seen);
  self.publish_code := IF(left.listed_phone != '', left.publish_code, '');
  _gong_score :=
  if(_gong_addr_rec.listed_name = '' or (_gong_addr_rec.lname ='' and _gong_addr_rec.fname =''), 500,
    datalib.nameMatch(left.fname, left.mname, left.lname, _gong_addr_rec.fname, _gong_addr_rec.mname, _gong_addr_rec.lname))
    + address.Sec_Range_EQ(left.sec_range,_gong_addr_rec.sec_range);
  self.gong_score := _gong_score;
  // if name/addr match, upgrade tnt to a 'V' since it is a 'virtual' hhid match (test lname match and optional
  // input phone match)
  self.tnt := IF(left.tnt = 'C' and left.lname = _gong_addr_rec.lname and (ut.NNEQ(phoneToMatch,_gong_addr_rec.phone10)),'V',left.tnt);
  _addr_phone_patch := PROJECT(left.gong_addr_phones, TRANSFORM(doxie.Layout_Phones, self.gong_score := _gong_score; self := left));
  self.phones := choosen(left.phones & IF(_gong_addr_rec.prim_name<>'', _addr_phone_patch), rollup_limits.phones);
  self := left;
  ));


out_roll2_ready := ROLLUP(SORT(j_addr, rid, gong_score, -listed_phone, -listed_name), rid, keepBestTNT(LEFT, RIGHT));

f_slim_ap_roll2 := doxie.fn_roll_gong_dates(project(out_roll2_ready(listed_phone<>''),
  transform(doxie.layout_presentation,
    self.prim_name := left.prim_name,
    self.prim_range := left.prim_range,
    self.st := left.st,
    self.zip := left.zip,
    self.phone := left.listed_phone,
    self := [])),
  mod_access);

out_roll patch_phone_first_seen(out_roll2_ready l, f_slim_ap_roll2 r) := transform
  picked_phone_first_seen := if(r.phone_first_seen < l.phone_first_seen and r.phone_first_seen>0,r.phone_first_seen,l.phone_first_seen);
  SELF.phone_first_seen := picked_phone_first_seen;
  SELF.phones := project(l.phones, transform(doxie.Layout_Phones,
    SELF.phone_first_seen := if(left.phone10 = l.listed_phone and left.match_type<>3, picked_phone_first_seen, left.phone_first_seen),
    SELF := LEFT));
  self := l;
end;

out_roll2 := join(out_roll2_ready, f_slim_ap_roll2,
  left.prim_name=right.prim_name and
  left.prim_range=right.prim_range and
  left.st=right.st and
  left.zip=right.zip and
  left.listed_phone=right.phone,
  patch_phone_first_seen(left, right), left outer, keep(1));

doxie.Layout_Phones AddUnlisted(out_roll2 le, string listed_name) :=
TRANSFORM
  SELF.match_type := 0;
  SELF.listed := false;
  SELF.did := le.did;
  SELF.phone10 := le.phone;
  SELF.bdid := 0;
  SELF.listed_name := listed_name;
  SELF.phone_first_seen := if(le.listed_phone<>'' and le.listed_phone<>le.phone, le.dt_first_seen, le.phone_first_seen);
  SELF.phone_last_seen := if(le.listed_phone<>'' and le.listed_phone<>le.phone, le.dt_last_seen, le.phone_last_seen);
  SELF := [];
END;

doxie.layout_phones bump_match(doxie.layout_phones le, doxie.layout_phones ri) :=
TRANSFORM
  SELF.match_type := IF(le.match_type IN [5,6],
    IF(dcp_value<6,SKIP,6),ri.match_type);
  SELF := ri;
END;

layout_new backOne(out_roll2 le, history_phone_key ri) := transform
  p1 := le.Phones((match_type<=dcp_value OR match_type=5 and dcp_value=4),match_type<5 OR phone10<>'');
  p2 := SORT(p1,match_type,gong_score,-phone10,-listed_name);
  p3 := ITERATE(p2, bump_match(LEFT,RIGHT));

  // NB: le.phone may already exist among child phones, so we may introduce duplicates here,
  // especially questionable when there was no match: we would add same phone with match_type := 0, and blank name
  SELF.Phones := CHOOSEN(IF(le.phone<>'',DATASET(PROJECT(le,AddUnlisted(LEFT,ri.listed_name))))&p3, rollup_limits.phones);

  self := le;
end;

out_roll3 := IF(dcp_value>=4,out_roll2,out_roll);

// For all the other phone numbers we have in the dataset, find all current holders of phone numbers we've
//collected, or those that have not been matched by DID, HHID, Name, or Address. NOTE! Doing this will append
//a lot of records of people working at a perticular business who share the same phone number.

// Filter the key since the backOne transform is somewhat complex in how it uses key data.
phone_hist_key_filtered := JOIN(out_roll3, history_phone_key,
  LENGTH(TRIM(LEFT.phone)) = 10 and
  LEFT.phone[4..10] = RIGHT.p7 and
  LEFT.phone[1..3] = RIGHT.p3 and
  RIGHT.current_flag,
  TRANSFORM(RIGHT),
  ATMOST(LENGTH(TRIM(LEFT.phone)) = 10 and LEFT.phone[4..10] = RIGHT.p7
    and LEFT.phone[1..3] = RIGHT.p3, 1000));

phone_hist_key_optout := Suppress.MAC_SuppressSource(phone_hist_key_filtered, mod_access);

outReady := JOIN(out_roll3, phone_hist_key_optout, LENGTH(TRIM(LEFT.phone)) = 10 and LEFT.phone[4..10] = RIGHT.p7
  and LEFT.phone[1..3] = RIGHT.p3 and RIGHT.current_flag,
  backOne(LEFT,RIGHT), left outer,
  ATMOST(LENGTH(TRIM(LEFT.phone)) = 10 and LEFT.phone[4..10] = RIGHT.p7
  and LEFT.phone[1..3] = RIGHT.p3, 1000));

//isolate last 7 digits
normedPhone(string10 p) := p[MAX(1, LENGTH(TRIM(p))-6)..];
//determine if all zeros (exempt empty phones from consideration -- these are unpublished)
nonZeroPhone(string10 ph) := ph != '' and STD.Str.FilterOut(normedPhone(ph), '0') != '';

layout_new checkListed(outReady le, supp_key ri) := transform
  SELF.listed_phone := if(le.listed_phone=ri.phone10,'',le.listed_phone);
  SELF.listed_name :=  IF(le.listed_phone=ri.phone10,'',le.listed_name);
  SELF.listed_name_prefix:= IF(le.listed_phone=ri.phone10,'',le.listed_name_prefix);
  SELF.listed_name_first:= IF(le.listed_phone=ri.phone10,'',le.listed_name_first);
  SELF.listed_name_middle:= IF(le.listed_phone=ri.phone10,'',le.listed_name_middle);
  SELF.listed_name_last:= IF(le.listed_phone=ri.phone10,'',le.listed_name_last);
  SELF.listed_name_suffix:= IF(le.listed_phone=ri.phone10,'',le.listed_name_suffix);
  SELF.phone := IF(le.phone=ri.phone10,'',le.phone);
  //filter any phones whose last 7 digit are all-zero
  SELF.phones := le.phones(nonZeroPhone(phone10));
  SELF.publish_code := IF(le.listed_phone=ri.phone10,'',le.publish_code);
  SELF := le;
END;

outFilt_1 := JOIN(outReady, supp_key,
  (LEFT.listed_phone<>'' OR LEFT.phone<>'') AND
  keyed(LEFT.did=RIGHT.did) AND RIGHT.phone10 IN [LEFT.listed_phone, LEFT.phone],
  checkListed(LEFT,RIGHT), LEFT OUTER, KEEP (1), LIMIT (ut.limits .PHONE_PER_PERSON, SKIP));

layout_new filt2(layout_new L) := transform
  self.phones := join(
    L.phones, supp_key,
    left.did<>0 and left.phone10<>'' and keyed(left.did=right.did) and left.phone10=right.phone10,
    transform(doxie.Layout_Phones,self:=left),
    left only // no keep() necessary with left only
  );
  self := L;
end;
outFilt_2 := project(outFilt_1, filt2(left));

doxie.layout_phones get_timezone_child(doxie.Layout_Phones le):=transform
  telcordia := Risk_Indicators.Key_Telcordia_tds(length(trim(le.phone10,all))=10 and
    keyed(le.phone10[1..3]=npa) and
    keyed(le.phone10[4..6]=nxx))[1];
  SELF.timezone := ut.TimeZone_Convert((unsigned1) telcordia.timezone,telcordia.state);
  SELF := le;
END;

layout_new get_timezone(outFilt_2 le):=transform
  SELF.phones := project(le.phones, get_timezone_child(left));
  SELF := le;
END;

outFilt_w_timezone0 := project(outFilt_2,get_timezone(left));


ut.getTimeZone(outFilt_w_timezone0,phone,timezone,outFilt_w_timezone1)
ut.getTimeZone(outFilt_w_timezone1,listed_phone,listed_timezone,outFilt_w_timezone2)

// For debugging:
// output(out_roll1, NAMED('out_roll1'));
// output(j_addr, NAMED('j_addr'));
// output(j_addr_add, NAMED('j_addr_add'));
// output(out_roll2, NAMED('out_roll2'));
// output(outReady, NAMED('outReady'));

return outFilt_w_timezone2;

END;
