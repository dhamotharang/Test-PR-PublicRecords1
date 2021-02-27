import Header, MDR, STD, Email_Data, Advo, Relationship, Phonesplus_v2, ut, Watchdog, header_quick, dx_BestRecords, dx_gong;
// Segment		Count
// CORE	 		261.1M 
// C_MERGE	 	 70.3M 
// DEAD	 		126.1M 
// -------------------------------	
// Total	 	457.5M 
// -------------------------------
EXPORT Files := MODULE

#OPTION ('multiplePersistInstances',FALSE);

SHARED wdog := distribute(Watchdog.File_Best, hash(did));
SHARED seg  := distribute(pull(Header.key_ADL_segmentation), hash(did));

hdr := Header.File_Headers;
hdr_filtered_by_src := hdr(src not in $.Filters.SRC_EXCLUSIONS and ~MDR.Source_is_DPPA(src))
					 + Header.File_TUCS_did
					 + Voters_Inclusions;

hdr_filtered_by_src_w_nonglb := project(hdr_filtered_by_src
	,transform({hdr, boolean Allowed_for_nonGLB}
		,self.Allowed_for_nonGLB := if(~mdr.Source_is_Utility(left.src) and left.src <> 'EQ', true, false)
		,self := left
		));

hdr_w_seg := join(distribute(hdr_filtered_by_src_w_nonglb(did > 0), hash(did)), seg, left.did = right.did, local);

EXPORT hdr_segemented := distribute(hdr_w_seg(ind1 not in ['AMBIG', 'NOISE', 'H_MERGE', 'NO_SSN']), hash(did)) : persist('~thor400_data::persist::emailage::hdr_segemented');//, refresh(false));

SHARED threshold_months    := 24; //2 years data for names and address
SHARED threshold_names_cnt := 24;
SHARED threshold_addr_cnt  := 24;
SHARED last_2_yrs_recs := hdr_segemented(STD.Date.MonthsBetween((integer)(((string)dt_last_seen)[1..6] + '00'), Std.Date.Today()) <= threshold_months);

hdrnames_sorted := sort(distribute(hdr_segemented(fname <> '' or lname <> ''), hash(did))
 			,did
			,fname
			,lname
			,mname
			,name_suffix
			,local
			);

//Keep the full names with middle being the longest
rolluprecs := ROLLUP(hdrnames_sorted,
                  LEFT.did=RIGHT.did and LEFT.fname=RIGHT.fname
			  and LEFT.lname=RIGHT.lname
			  and ut.NNEQ(left.name_suffix, right.name_suffix)
                  ,transform({hdrnames_sorted}
				  	,self.name_suffix := if(left.name_suffix = '', right.name_suffix, left.name_suffix)
					,self.mname := if(length(trim(left.mname)) > length(trim(right.mname)), left.mname, right.mname)
					,self.dt_last_seen := max(left.dt_last_seen, right.dt_last_seen);
					,self.Allowed_for_nonGLB := if(left.Allowed_for_nonGLB = true, true, right.Allowed_for_nonGLB)
					,self := left;)
				  ,local
				  );

keep_last_2_yrs_recs := rolluprecs(STD.Date.MonthsBetween((integer)(((string)dt_last_seen)[1..6] + '00'), Std.Date.Today()) <= threshold_months);
with_wdog := join(distribute(keep_last_2_yrs_recs, hash(did))
				,wdog
				,left.did = right.did
				,transform({recordof(keep_last_2_yrs_recs), unsigned1 curr_rec := 0}, 
					self.curr_rec := if(left.fname = right.fname and left.mname = right.mname and left.lname = right.lname and left.name_suffix = right.name_suffix, 1, 0);
					self := left;
					)
				,left outer
				,local);
with_wdog_srt := sort(with_wdog, did, -curr_rec, -dt_last_seen, local);

dNamesGrouped := GROUP(with_wdog_srt,did,LOCAL);
dNames := PROJECT(dNamesGrouped
					,TRANSFORM({$.layouts.rNames, integer counter_ := 0}
						,SELF.LexId := LEFT.did
						,SELF.name_ind := if(COUNTER=1, 'C', 'F')
						,SELF.counter_ := COUNTER + 1
						,SELF:=LEFT;)
						);
dNamesUngrouped := project(UNGROUP(dNames)(counter_ <= threshold_names_cnt + 1),  $.layouts.rNames);//+1 bcz counter_ starts with 2

SHARED names_all := distribute(dNamesUngrouped, hash(lexid));

with_dates := project(hdr_segemented, transform({recordof(hdr_segemented), unsigned4 Address_Date_First_Seen_for_GLB := 0, unsigned4 Address_Date_Last_Seen_for_GLB := 0, unsigned4 Address_Date_First_Seen_for_nonGLB := 0, unsigned4 Address_Date_Last_Seen_for_nonGLB := 0}, self := left;));

hdraddr_sorted := sort(distribute(with_dates, hash(did))
 			,did
			,prim_range
			,prim_name
			,zip
			,sec_range			
			,unit_desig
			,city_name
			,st			
			,suffix
			,predir
			,postdir
			,zip4
			,local
			);

rolluprecs := ROLLUP(hdraddr_sorted,
			LEFT.did=RIGHT.did and LEFT.prim_range=RIGHT.prim_range
		and LEFT.prim_name=RIGHT.prim_name and LEFT.zip=RIGHT.zip
		and ut.NNEQ(left.sec_range, right.sec_range)
			,transform({hdraddr_sorted}
				,self.sec_range  := if(left.sec_range <> '', left.sec_range, right.sec_range)
				,self.predir     := if(left.predir <> '', left.predir, right.predir)
				,self.postdir 	 := if(left.postdir <> '', left.postdir, right.postdir)
				,self.unit_desig := if(left.unit_desig <> '', left.unit_desig, right.unit_desig)
				,self.city_name  := if(left.city_name <> '', left.city_name, right.city_name)
				,self.st   		 := if(left.st <> '', left.st, right.st)
				,self.suffix     := if(left.suffix <> '', left.suffix, right.suffix)
				,self.Allowed_for_nonGLB := if(left.Allowed_for_nonGLB = true, true, right.Allowed_for_nonGLB)
				,self.dt_first_seen := ut.min2(left.dt_first_seen,right.dt_first_seen);
				,self.dt_last_seen := max(left.dt_last_seen, right.dt_last_seen);
				,self.Address_Date_First_Seen_for_GLB := self.dt_first_seen;
				,self.Address_Date_Last_Seen_for_GLB := self.dt_last_seen;
				,self.Address_Date_First_Seen_for_nonGLB := if(left.Allowed_for_nonGLB = true, if(left.Address_Date_First_Seen_for_nonGLB = 0, ut.min2(left.dt_first_seen,right.dt_first_seen), ut.min2(left.Address_Date_First_Seen_for_nonGLB,right.dt_first_seen)), left.Address_Date_First_Seen_for_nonGLB);
				,self.Address_Date_Last_Seen_for_nonGLB := if(self.Allowed_for_nonGLB = true, if(left.Address_Date_Last_Seen_for_nonGLB = 0, max(left.dt_last_seen, right.dt_last_seen), max(left.Address_Date_Last_Seen_for_nonGLB, right.dt_last_seen)), left.Address_Date_Last_Seen_for_nonGLB);
				,self := left;)
			,local
			);

keep_last_2_yrs_recs := rolluprecs(STD.Date.MonthsBetween((integer)(((string)dt_last_seen)[1..6] + '00'), Std.Date.Today()) <= threshold_months);

with_wdog := join(distribute(keep_last_2_yrs_recs, hash(did))
				,wdog
				,left.did = right.did
				,transform({recordof(keep_last_2_yrs_recs), unsigned1 curr_rec := 0},
					self.curr_rec := if(left.prim_name = right.prim_name and left.prim_range = right.prim_range and left.city_name = right.city_name and left.zip = right.zip and ut.NNEQ(left.sec_range, right.sec_range), 1, 0);
					self := left;
					)
				,left outer
				,local);
with_wdog_srt := sort(with_wdog, did, -curr_rec, -dt_last_seen, local);

dhdrGrouped := GROUP(with_wdog_srt,did,LOCAL);
dhdrAddress := PROJECT(dhdrGrouped
					,TRANSFORM({$.layouts.rAddress, integer counter_ := 0}
						,SELF.LexId := LEFT.did
						,SELF.addr_ind := if(COUNTER=1, 'C', 'F')
						,SELF.counter_ := COUNTER + 1						
						,SELF:=LEFT;)
						);
dhdrUngrouped := UNGROUP(dhdrAddress);
SHARED address_all := distribute(project(dhdrUngrouped(counter_ <= threshold_addr_cnt + 1), $.layouts.rAddress), hash(lexid));

uniq_address_lexids := dedup(address_all, lexid, all);
uniq_names_lexids 	:= dedup(names_all, lexid, all);
SHARED lexids_w_name_addr := distribute(join(uniq_address_lexids, uniq_names_lexids, left.lexid = right.lexid, transform({unsigned6 lexid}, self := left;), local), hash(lexid));

EXPORT Address := join(address_all, lexids_w_name_addr, left.lexid = right.lexid, transform(left), local) : persist('~thor400_data::persist::emailage::hdr_address');
EXPORT Names := join(names_all, lexids_w_name_addr, left.lexid = right.lexid, transform(left), local) : persist('~thor400_data::persist::emailage::hdr_names');

keep_latest_rec := dedup(sort(hdr_segemented, did, -dt_last_seen, local), did, local);
lexids_w_dob := join(keep_latest_rec, lexids_w_name_addr, left.did = right.lexid
					,transform({keep_latest_rec.did, keep_latest_rec.dob, boolean best_dob := false}, self := left)
					,local);

best_dobs := join(lexids_w_dob, wdog, left.did=right.did and left.dob=right.dob
			,transform({lexids_w_dob}
				,self.best_dob := if(left.did=right.did and left.dob=right.dob, true, false)
				,self := left;
				)
			,left outer
			,local);
good_quality_dobs := dedup(distribute(table(hdr_segemented(jflag1 = 'C' and dob <> 0), {did, dob}), hash(did)), did, dob, all, local);
j1 := join(distribute(best_dobs(best_dob = false), hash(did)), good_quality_dobs, left.did=right.did
		,transform({best_dobs}, self.best_dob := if(left.did=right.did, true, false),self.dob := right.dob, self := left;)
		,left outer
		,local);

low_quality_dobs := dedup(distribute(table(hdr_segemented(jflag1 = 'L' and dob <> 0), {did, dob}), hash(did)), did, all, local);
j2 := join(distribute(j1(best_dob = false), hash(did)), low_quality_dobs, left.did=right.did
		,transform({j1}, self.best_dob := if(left.did=right.did, true, false) ,self.dob := right.dob, self := left;)
		,left outer
		,local);

all_dobs := best_dobs(best_dob = true) + j1(best_dob = true) + j2;
$.layouts.rMetaData toMeta(all_dobs L, seg R) := TRANSFORM
	SELF.LexID     := L.did;
	SELF.lexid_ind := case(R.ind1, 'CORE' =>  'C', 'C_MERGE' => 'E', 'DEAD' => 'D', 'INACTIVE' => 'I', 'SUSPECT' => 'S', 'CORENOVSSN' => 'A', '');
	SELF.Best_DOB_GLB := L.dob;
	SELF.Best_DOB_nonGLB := L.dob;
END;

all_metadata := join(distribute(all_dobs, hash(did))
	,seg
	,left.did = right.did
	,toMeta(LEFT, RIGHT)
	,local);

EXPORT MetaData := all_metadata : persist('~thor400_data::persist::emailage::hdr_metadata');

fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;

boolean IsFlatRate(unsigned src_set) := 
/*Flat rate*/		fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_IBehavior)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_Thrive_LT)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_Thrive_PD)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_AlloyMedia_Consumer))	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_InfutorNare)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_impulse)) 		
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_email));

uniq_email := DEDUP(SORT(DISTRIBUTE(Email_Data.File_Email_Base(
							did<>0
							,current_rec=true
							,Clean_Email<>''
							,IsFlatRate(email_src_all))
						,hash(did)),
					did, -date_last_seen, clean_email, local),
				did, clean_email, local);

demailGrouped := GROUP(uniq_email,did,LOCAL);
demails := PROJECT(demailGrouped
					,TRANSFORM({$.layouts.rEmail, integer counter_ := 0}
						,SELF.LexId := LEFT.did
						,SELF.Email := LEFT.Clean_Email
						,SELF.counter_ := COUNTER + 1
						,SELF:=LEFT;)
						);
demailUngroup := UNGROUP(demails);

hdr_w_email := JOIN(dedup(lexids_w_name_addr, lexid, all), distribute(demailUngroup(counter_ <= 4), hash(LexId)), left.lexid = right.LexId, transform($.layouts.rEmail, self := RIGHT), LOCAL);

EXPORT Emails := hdr_w_email : persist('~thor400_data::persist::emailage::hdr_emails');

kRelatives := pull(Relationship.key_relatives_v3(not(confidence IN ['NOISE','LOW']) and did1 > 0));

dRelatives1 := join(distribute(kRelatives, hash(did1)), MetaData, left.did1 = right.Lexid
				,TRANSFORM($.layouts.rRelative
					,SELF.LexID1  := LEFT.did1
					,SELF.LexID2  := LEFT.did2
					,SELF.relation_ind := if(LEFT.isanylnamematch, 'R', 'A')
				), LOCAL);

dRelatives := join(distribute(dRelatives1, hash(LexID2)), MetaData, left.LexID2 = right.Lexid, transform(LEFT), LOCAL);

EXPORT Relatives := dRelatives : persist('~thor400_data::persist::emailage::hdr_relatives');

gong := dx_gong.key_history_did();
last_2_years_gong_phones := gong(STD.Date.MonthsBetween((integer)((string)dt_last_seen[1..6] + '00'), Std.Date.Today()) <= threshold_months);
gong_phones := project(last_2_years_gong_phones
				,TRANSFORM($.layouts.rPhone
					,SELF.LexId := LEFT.did
					,SELF.phone := LEFT.phone10
					,SELF.phone_type := 'LANDLINE'
					,SELF.phone_source := 'D'
					,SELF.phone_ind := if(LEFT.current_flag = true and LEFT.deletion_date = '', 'C', 'F')
					,SELF.Allowed_for_GLB := true;
					,SELF.Allowed_for_nonGLB := true;
					));

gong_phones trGong(gong_phones l, gong_phones r) := transform
  SELF.phone_ind := if(l.phone_ind = 'C', l.phone_ind, r.phone_ind);
  SELF := l;    
end;

roll_gong_ph := rollup(sort(distribute(gong_phones, hash(lexid)), lexid, phone, local), left.lexid=right.lexid and left.phone=right.phone, trGong(left, right), local);
sort_gong_ph := distribute(roll_gong_ph, hash(lexid));

dgongGrouped := GROUP(sort_gong_ph,lexid,LOCAL);
dgong := PROJECT(dgongGrouped
					,TRANSFORM({dgongGrouped, integer counter_ := 0}
						,SELF.counter_ := COUNTER + 1						
						,SELF:=LEFT;)
						);
dgongUngrouped := UNGROUP(dgong);
gong_only_20 := distribute(project(dgongUngrouped(counter_ <= 21), $.layouts.rPhone), hash(lexid));

ph_plus_v2 := Phonesplus_v2.File_Phonesplus_Base;
last_2_years_ph_plus := ph_plus_v2(STD.Date.MonthsBetween((integer)(((string)datelastseen)[1..6] + '00'), Std.Date.Today()) <= threshold_months);
phones_plus := project(last_2_years_ph_plus
				,TRANSFORM({$.layouts.rPhone, integer confidencescore}
					,SELF.LexId := LEFT.did
					,SELF.phone := LEFT.cellphone
					,SELF.phone_type := LEFT.append_phone_type
					,SELF.phone_source := 'P'
					,SELF.phone_ind := if(LEFT.confidencescore>=11, 'C', 'F')
					,SELF.Allowed_for_GLB := true;
					,SELF.Allowed_for_nonGLB := ~mdr.sourceTools.SourceIsGLB(LEFT.src);
					,SELF.confidencescore := LEFT.confidencescore
					));

phones_plus trPhoneplus(phones_plus l, phones_plus r) := transform
  SELF.phone_ind := if(l.phone_ind = 'C', l.phone_ind, r.phone_ind);
  SELF := l;    
end;

roll_phones_plus := rollup(sort(distribute(phones_plus, hash(lexid)), lexid, phone, local), left.lexid=right.lexid and left.phone=right.phone, trPhoneplus(left, right), local);
sort_phone_plus := sort(distribute(roll_phones_plus, hash(lexid)), lexid, -confidencescore, local);

dPhonePlusGrouped := GROUP(sort_phone_plus,lexid,LOCAL);
dPhonesPlus := PROJECT(dPhonePlusGrouped
					,TRANSFORM({dPhonePlusGrouped, integer counter_ := 0}
						,SELF.counter_ := COUNTER + 1						
						,SELF:=LEFT;)
						);
dPhonePlusUngrouped := UNGROUP(dPhonesPlus);
phonplus_only_20 := distribute(project(dPhonePlusUngrouped(counter_ <= 21), $.layouts.rPhone), hash(lexid));

all_phones := gong_only_20 + phonplus_only_20;
all_phones_sorted := sort(distribute(all_phones, hash(LexId)), LexId, phone, local);

all_phones_sorted rollupdups(all_phones_sorted l, all_phones_sorted R) := TRANSFORM
	 SELF.phone_type := if(L.phone_source = 'D', L.phone_type, R.phone_type)
	,SELF.phone_source := if(L.phone_source = 'D', L.phone_source, R.phone_source);
	,SELF.phone_ind := if(L.phone_ind = 'C', L.phone_ind, R.phone_ind)
	,SELF.Allowed_for_nonGLB := if(L.Allowed_for_nonGLB = true, L.Allowed_for_nonGLB, R.Allowed_for_nonGLB)
	,SELF := L;
END;

uniq_phones := rollup(all_phones_sorted, left.lexid=right.lexid and left.phone=right.phone, rollupdups(left, right), local);

EXPORT Phones := join(lexids_w_name_addr, distribute(uniq_phones, hash(LexId)), left.lexid = right.LexId, TRANSFORM(RIGHT), local)
					: persist('~thor400_data::persist::emailage::hdr_phones');

kFraudFlag := pull(header_quick.key_fraud_flag_eq);

$.layouts.rFraudFlags toFraud(kFraudFlag L) := TRANSFORM
	self.LexID := L.did;
	self.Factact_cd := L.factact_code;
	self.Fraud_Victim_Date_Reported := L.date_reported;
	self.First_Fraud_Victim_Date_Reported := L.dt_vendor_first_reported;
	self.Last_Fraud_Victim_Date_Reported  := L.dt_vendor_last_reported;
	self.Fraud_Flag_Ind := if(L.current, 'C', 'F');
END;

EXPORT FraudFlag := join(lexids_w_name_addr, distribute(kFraudFlag, hash(did)), left.lexid = right.did, toFraud(RIGHT), local)
					: persist('~thor400_data::persist::emailage::hdr_fraudflags');

END;
