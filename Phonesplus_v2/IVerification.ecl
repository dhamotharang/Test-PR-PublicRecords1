/* 1.5	R	Requirement: Insurance Phone Verification Append 
An extract from the Boca data platform shall be created, sent to the Insurance data platform for phone verification, and loaded in the Boca data platform according to the following specifications:
1.	The Boca extract file shall contain the following information:
        LexID, Phone, Source Code (This is an indicator of how the phone was determined to be associated with the given LexID)
2.	The Boca extract file shall contain phone / LexID combinations from the following sources:
        PhonesPlus and GONG / Electronic Directory Assistance
3.	The Boca extract file shall gather phone / LexID combinations according to the following logic:
       	Phone / LexID, Phone / Spouse, Phone / Household ID
4.	Each record in the Boca extract file shall be used to search the Insurance data platform by LexID to determine if the Insurance data platform verifies the given phone is associated with the given LexID.
5.	Only the contributory, non public record sourced information in the Insurance data platform shall be used to determine if the Insurance data platform verifies the phone is associated with the given LexID.
6.	This gateway shall utilize the Insurance Header restriction table to exclude the use of information from restricted customers.
7.	Each Source Code that pertains to a Phone / LexID combination shall be preserved.
8.	For each Phone / LexID combination that is verified by the Insurance Header, the date the Insurance Header first saw the LexID / Phone combination and the date the Insurance Header last saw the LexID / Phone combination shall be preserved.
9.	The Boca extract file with the appended Insurance data platform verification information shall be fabricated in the Boca data platform as a new file and shall be used to populate the Insurance Header Verification attribute in the Phone Shell.
10.	The Insurance phone verification process shall be executed on at least a monthly basis but weekly or with each PhonesPlus update is preferred.
11.	The field names, internal documentation, and external documentation related to this process shall refer to this capability as internally corroborated and shall not mention the use of the Insurance header.
12.	All products that leverage the Insurance Phone verification asset shall certify and log a valid GLB permissible purpose prior to accessing the asset.

Implementation:
1- Gather all Gong and Phonesplus data and generate addtional records for spouse and other people in the current household 
2- Pull the Insurance phone data from Alpha, which already removed restricted customer data, and generate the additional records for spouse and other people in the current household 
3- Join the data in 1 and 2 by Lexid/phone and household/phone, and flag data that matches the insurance file
4- Keep history of the data that has been verified
*/

import gong_v2, doxie, ut,didville,_Control;
shared reformat(ds, ds_source, record_type, did_field, orig_did_field, phone_field) := functionmacro
#uniquename(t_reformat)

Phonesplus_v2.File_Iverification.layout t_reformat(ds le) := transform
	self.phone := le.phone_field;
	self.did := le.did_field;
	self.orig_did := le.orig_did_field;
#if(ds_source = 1)
	self.file_source := ds_source;
#end
#if(ds_source = 2)
	self.file_source := if(le.in_flag, ds_source, 3);
#end
#if(ds_source = 0)
	self.file_source := le.file_source;
#end	
	
#if(ds_source = 1)
  self.dt_first_seen := (unsigned)le.dt_first_seen;  
	self.dt_last_seen := (unsigned)if(le.current_record_flag = 'Y', (unsigned)ut.GetDate, (unsigned)le.dt_last_seen);
#end
#if(ds_source = 2)
	self.dt_first_seen := (unsigned)((string)le.DateFirstSeen + if(le.DateFirstSeen <> 0, '01', ''));
	self.dt_last_seen := (unsigned)((string)le.DateLastSeen + if(le.DateLastSeen <> 0, '01', ''));
#end	
	self.rec_type :=  ut.bit_set(0,record_type);
	self.current_rec := true;
  self.dt_first_ver := (unsigned)ut.GetDate;
  self.dt_last_ver := (unsigned)ut.GetDate;
  self := le;
end;

	return project(ds, t_reformat(left));
endmacro;

// --------------------gather did - phone combinations from gong and phonesplus
gong := gong_v2.key_did(did >0 and phone10 <> '');
pplus:= phonesplus_V2.Key_Phonesplus_Did(did >0 and cellphone <> '' and current_rec);

gong_r := sort(distribute(reformat(gong, 1, 0, did, did, phone10), hash(phone)), phone, did, local);																											
pplus_r := sort(distribute(reformat(pplus, 2, 0, did, did, cellphone), hash(phone)), phone, did, local);

Phonesplus_v2.File_Iverification.layout t_rollup_dts1 (Phonesplus_v2.File_Iverification.layout le, Phonesplus_v2.File_Iverification.layout ri) := transform
self.dt_first_seen := ut.EarliestDate(le.dt_first_seen, ri.dt_first_seen);
self.dt_last_seen :=  ut.LatestDate(le.dt_last_seen, ri.dt_last_seen);
self := ri;
end;

gong_rollup := rollup(gong_r, t_rollup_dts1(left, right),
											left.did = right.did and 
											left.phone = right.phone,
											local);
pplus_rollup := rollup(pplus_r, t_rollup_dts1(left, right),
											left.did = right.did and 
											left.phone = right.phone,
											local);

all_phones := dedup(sort(distribute((gong_rollup + pplus_rollup), hash(did)), did, phone, file_source, local), did, phone, local);
//-----------------------get spouse
rels_by_spouse := //doxie.Key_Relatives(prim_range = -7);
                  Relationship.key_relatives_v3 (type in ['PERSONAL','TRANS CLOSURE'], confidence in ['MEDIUM','HIGH'], isanylnamematch, title in [2,3,4,8,9]);

spouse_in_person1 := join(distribute(rels_by_spouse, hash(did1)),
													distribute(all_phones, hash(did)),
													left.did1 = right.did,
													local);
													
spouse1 := reformat(spouse_in_person1, 0, 1, did2, did, phone);		

spouse_in_person2 := join(distribute(rels_by_spouse, hash(did2)),
													distribute(all_phones, hash(did)),
													left.did2 = right.did,
													local);
													

spouse2 := reformat(spouse_in_person2, 0, 1, did1, did, phone);

spouse1_rollup := rollup(spouse1, t_rollup_dts1(left, right),
											left.did = right.did and 
											left.phone = right.phone,
											local);

spouse2_rollup := rollup(spouse2, t_rollup_dts1(left, right),
											left.did = right.did and 
											left.phone = right.phone,
											local);

all_spouses := dedup(sort(distribute((spouse1_rollup + spouse2_rollup), hash(did)), did, phone, file_source, local), did, phone, local);
//-----------------------get same hhid
hhids := Doxie.Key_HHID_Did(ver = 1);

household := join(distribute(all_phones, hash(hhid)),
				          distribute(hhids, hash(hhid_relat)),
									left.hhid = right.hhid_relat,
									transform({recordof(all_phones), unsigned other_did},
														 self.other_did := right.did,
														 self := left),
									local) (other_did <> did);
									
other_in_household := reformat(household, 0, 2, other_did, did, phone);

other_in_household_rollup := rollup(other_in_household, t_rollup_dts1(left, right),
											left.did = right.did and 
											left.phone = right.phone,
											local);

all_others := dedup(sort(distribute((other_in_household_rollup), hash(did)), did, phone, file_source, local), did, phone, local);


//-----------------------Rollup file
all_records_s := sort(distribute((all_phones + all_spouses + all_others), hash(did)), did, phone, file_source, rec_type, local) ;
all_records_grp := group(all_records_s, did, phone, local);

Phonesplus_v2.File_Iverification.layout t_rollup (all_records_grp le, all_records_grp ri) := transform
self.rec_type := le.rec_type | ri.rec_type;
self.dt_first_seen := ut.EarliestDate(le.dt_first_seen, ri.dt_first_seen);
self.dt_last_seen :=  ut.LatestDate(le.dt_last_seen, ri.dt_last_seen);
self := le;
end;

all_data_r:= group(rollup(all_records_grp, 
									true,
									t_rollup (left, right)));



//----------------------Match against iphone records to verify
// verification
iver_rec := RECORD
  unsigned8 did;
  string10 phone;
  string9 src;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  boolean is_latest;
 END;

remote_ds := dataset('~foreign::' + _Control.IPAddress.aprod_thor_dali + '::thor_data400::base::insuranceheader::for_phone_verification', iver_rec , thor);

remote_ds_t := project(remote_ds, {iver_rec, unsigned hhid := 0});

didville.MAC_HHID_Append(remote_ds_t, 'HHID_NAMES', Append_HHID, true);

Phonesplus_v2.File_Iverification.layout t_did_ver (all_data_r le, remote_ds ri) := transform
self.iver_indicator:= if(ri.did > 0 and ri.phone <> '', 
															if(ri.is_latest, ut.bit_set(0,0),
															   ut.bit_set(0,1)), 0);
self.iver_dt_first_seen := ri.dt_first_seen;
self.iver_dt_last_seen := ri.dt_last_seen;
self := le;
end;

iverify_did := join(distribute(all_data_r, hash(did)),
								distribute (remote_ds, hash(did)),
								left.did = right.did and
								left.phone = right.phone,
								t_did_ver(left, right),
								left outer,
								local);

Phonesplus_v2.File_Iverification.layout t_hhid_ver (all_data_r le, Append_HHID ri) := transform
self.iver_indicator:= if(ri.hhid > 0 and ri.phone <> '', 
															if(ri.is_latest, le.iver_indicator | ut.bit_set(0,2),
															   le.iver_indicator | ut.bit_set(0,3)), le.iver_indicator);
self.iver_dt_first_seen := ut.EarliestDate(le.iver_dt_first_seen, ri.dt_first_seen); 
self.iver_dt_last_seen := ut.LatestDate(le.iver_dt_last_seen, ri.dt_last_seen);
self := le;
end;

iverify_hhid := join(distribute(iverify_did, hash(hhid)),
								dedup(sort(distribute (Append_HHID(hhid > 0), hash(hhid)), hhid, phone, -dt_last_seen, local), hhid, phone, local),
								left.hhid = right.hhid and
								left.phone = right.phone,
								t_hhid_ver(left, right),
								left outer,
								local);

//----------Rollup history;
cur_plus_hist := if(nothor(FileServices.GetSuperFileSubCount(Phonesplus_v2.File_Iverification.name)) = 0,
								 iverify_hhid,
								 iverify_hhid +  project(Phonesplus_v2.File_Iverification.base, transform(Phonesplus_v2.File_Iverification.layout, self.current_rec := false, self := left)));


all_with_hist_s := sort(distribute(cur_plus_hist, hash(did)), did, phone, orig_did, hhid, file_source, rec_type,iver_indicator, local) ;
all_with_hist_grp := group(all_with_hist_s, did, phone, orig_did, hhid, file_source, rec_type,iver_indicator, local);

						 
Phonesplus_v2.File_Iverification.layout t_rollup_history (all_with_hist_grp le, all_with_hist_grp ri) := transform
self.iver_dt_first_seen := ut.EarliestDate(le.iver_dt_first_seen , le.iver_dt_first_seen);
self.iver_dt_last_seen := ut.LatestDate(le.iver_dt_last_seen, ri.iver_dt_last_seen);
self.dt_first_ver := ut.EarliestDate(le.dt_first_ver, ri.dt_first_ver);
self.dt_last_ver := ut.LatestDate(le.dt_last_ver, ri.dt_last_ver);
self.dt_first_seen := ut.EarliestDate(le.dt_first_seen, ri.dt_first_seen);
self.dt_last_seen := ut.LatestDate(le.dt_last_seen, ri.dt_last_seen);
self.current_rec := if(le.current_rec > ri.current_rec, le.current_rec, ri.current_rec);
self := le;
end;

iverification_file:= group(rollup(all_with_hist_grp, 
									true,
									t_rollup_history  (left, right)));
									
EXPORT Iverification := iverification_file;