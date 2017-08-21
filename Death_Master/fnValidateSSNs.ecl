import ut,watchdog,Header;

export fnValidateSSNs(dataset(recordof(Header.Layout_Did_Death_MasterV3)) in_ds) := function
												// State Direct
set_src_to_validate := ['CAL','CON','FLA','FLH','GAA','GAH','KEN','MAS','MIC','MIN','MNT','NCA','NEV','OHI','VGA',
												// Credit Bureau
												'EXP','TUN','TCS',
												// Enclarity
												'ENC'];

r2 := record
 boolean   is_src_to_validate;
 boolean   is_ssa;
 boolean   is_other;//historical direct sources
 string9   best_ssn :='';
 string1   valid_ssn:='';
 boolean   filter_record:=false;
 unsigned6 temp_record_id;
 in_ds;
end;

r2 x1(in_ds le) := transform
 self.is_src_to_validate := le.death_rec_src in set_src_to_validate;
 self.is_ssa             := le.death_rec_src='SSA';
 self.is_other           := self.is_src_to_validate=false and self.is_ssa=false;
 self.temp_record_id     := 0;
 self                    := le;
end;

p1       := project(in_ds,x1(left));
ut.MAC_Sequence_Records(p1,temp_record_id,p2);

has_did_and_ssn  := distribute(p2((UNSIGNED)did>0 and ut.full_ssn(ssn)),HASH((UNSIGNED)did));

wdog := DISTRIBUTE(watchdog.file_best,HASH((UNSIGNED)did));

r2 x2(r2 le, wdog ri) := transform
 self.best_ssn  := ri.ssn;
 self.valid_ssn := ri.valid_ssn;
 self           := le;
end;

j_add_best := join(has_did_and_ssn,wdog,(UNSIGNED)left.did=(UNSIGNED)right.did,x2(left,right),local);

srtd_did_and_ssn := sort(distribute(j_add_best,hash((UNSIGNED)did,ssn)),(UNSIGNED)did,ssn,local);

r2 x3(srtd_did_and_ssn le, srtd_did_and_ssn ri) := transform
 self.is_src_to_validate := if(le.is_src_to_validate=true,le.is_src_to_validate,ri.is_src_to_validate);
 self.is_ssa             := if(le.is_ssa=true,le.is_ssa,ri.is_ssa);
 self.is_other           := if(le.is_other=true,le.is_other,ri.is_other);
 self                    := le;
end;

rold_did_and_ssn := rollup(srtd_did_and_ssn,(UNSIGNED)left.did=(UNSIGNED)right.did and left.ssn=right.ssn,x3(left,right),local);

//filter captures both:
// 1) DIDs that aren't in the SSA
// 2) DIDs that are in the SSA but the Direct source has a different SSN
did_ssn_candidates := rold_did_and_ssn(is_src_to_validate=true and is_ssa=false);

//get the original records... pre-rollup
//j1 := join(j_add_best,did_ssn_candidates,left.did=right.did and left.ssn=right.ssn,self:=left);
j1 := join(srtd_did_and_ssn,did_ssn_candidates,(UNSIGNED)left.did=(UNSIGNED)right.did and left.ssn=right.ssn,transform({r2},self:=left),local);

//if the SSN from the Direct source doesn't belong to the owner then flag the record for filtering later
r2 x4(r2 le) := transform
 self.filter_record := if(le.ssn=le.best_ssn and le.valid_ssn='G',false,true);
 self               := le;
end;

flag_bad_records := project(j1,x4(left));

//get the records that were filtered for various reasons
j2 := join(distribute(p2,hash(temp_record_id)),distribute(flag_bad_records,hash(temp_record_id)),left.temp_record_id=right.temp_record_id,transform({r2},self:=left),left only,local);

concat := j2+flag_bad_records(filter_record=false);

project_back_to_incoming_layout := project(concat,recordof(in_ds));

dFilteredRecords	:=	JOIN(
												SORT(DISTRIBUTE(in_ds,HASH(state_death_id)),state_death_id,LOCAL),
												SORT(DISTRIBUTE(project_back_to_incoming_layout,HASH(state_death_id)),state_death_id,LOCAL),
													LEFT.state_death_id	=	RIGHT.state_death_id,
												TRANSFORM(LEFT),
												LEFT ONLY,
												LOCAL
											);
dFilteredRecordsTable	:=	TABLE(dFilteredRecords,{death_rec_src,COUNT(GROUP)},death_rec_src);

	// Output WatchDog Filter information for debugging
OUTPUT('Number of records removed by WatchDog is '+(STRING)(COUNT(dFilteredRecords)));
OUTPUT(SORT(dFilteredRecordsTable,death_rec_src),NAMED('WatchDog_Filter_Table'));
OUTPUT(dFilteredRecords,,'~thor_data400::base::WatchdogFilter_death_masterV3_all', __compressed__,OVERWRITE);

return project_back_to_incoming_layout;

end;
