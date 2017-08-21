
d := dataset('~thor_200::base::fcra_criminal_offender_20080425',CrimSrch.Layout_Moxie_Offender,flat,unsorted);

tempLayout := record
unsigned6 orig_did  := 0;
unsigned6 new_did := 0;
unsigned new_did_score := 0;
unsigned6 best_did:=0;
d;
end;

/*
 tempLayout trecs(d L) := transform
 self.orig_did 	:= (integer6) l.did;
 self.new_did   := 0;
 self.new_did_score := 0;
 self.best_did  := 0;
 self := L;
 end;

precs := project(d,trecs(left));


lMatchSet := ['S','A','D'];

 did_Add.MAC_Match_Flex
	 (precs, lMatchSet,						
	  orig_ssn, dob, fname, mname, lname, name_suffix, 
	  prim_range, prim_name, sec_range, zip5, state, fake_phone_field, 
	  new_did,
	  tempLayout,
	  false, new_did_score,
	  75,//dids with a score below here will be dropped
	  outfile
	 );
	
output(outfile,,'~thor_200::temp::fcraCrimDIDtest_20080425');
*/ 

//start2/*
ds := dataset('~thor_200::temp::fcraCrimDIDtest_20080425',tempLayout,flat);


stat_rec := record
string1		data_type:=ds.data_type;
string2		state_of_origin:=ds.state_of_origin;
string2		vendor:=ds.vendor;
string20	source_file:=ds.source_file;
integer		ttl_recs:=count(group);
//
integer		ttl_recs_orig_did:=sum(group,if(ds.orig_did<>0,1,0));
integer		ttl_recs_new_did :=sum(group,if(ds.new_did<>0,1,0));
//
integer		ttl_recs_off_name_type0:=sum(group,if(ds.off_name_type='0',1,0));
integer		ttl_recs_off_name_type1:=sum(group,if(ds.off_name_type='1',1,0));
integer		ttl_recs_off_name_type2:=sum(group,if(ds.off_name_type='2',1,0));
integer		ttl_recs_off_name_type3:=sum(group,if(ds.off_name_type='3',1,0));
integer		ttl_recs_off_name_type4:=sum(group,if(ds.off_name_type='4',1,0));
//
integer		ttl_recs_off_name_type0_orig_did:=sum(group,if(ds.off_name_type='0' and ds.orig_did<>0,1,0));
integer		ttl_recs_off_name_type1_orig_did:=sum(group,if(ds.off_name_type='1' and ds.orig_did<>0,1,0));
integer		ttl_recs_off_name_type2_orig_did:=sum(group,if(ds.off_name_type='2' and ds.orig_did<>0,1,0));
integer		ttl_recs_off_name_type3_orig_did:=sum(group,if(ds.off_name_type='3' and ds.orig_did<>0,1,0));
integer		ttl_recs_off_name_type4_orig_did:=sum(group,if(ds.off_name_type='4' and ds.orig_did<>0,1,0));
//
integer		ttl_recs_off_name_type0_new_did:=sum(group,if(ds.off_name_type='0' and ds.new_did<>0,1,0));
integer		ttl_recs_off_name_type1_new_did:=sum(group,if(ds.off_name_type='1' and ds.new_did<>0,1,0));
integer		ttl_recs_off_name_type2_new_did:=sum(group,if(ds.off_name_type='2' and ds.new_did<>0,1,0));
integer		ttl_recs_off_name_type3_new_did:=sum(group,if(ds.off_name_type='3' and ds.new_did<>0,1,0));
integer		ttl_recs_off_name_type4_new_did:=sum(group,if(ds.off_name_type='4' and ds.new_did<>0,1,0));
end;

stats1 := table(ds,stat_rec, data_type,state_of_origin,vendor,source_file,few);

//output1(stats1,all);


stat_ofk := record
string1		data_type:=ds.data_type;
string2		state_of_origin:=ds.state_of_origin;
string2		vendor:=ds.vendor;
string20	source_file:=ds.source_file;
integer		ttl_ofk;
integer		ttl_ofk_orig_did0;
integer		ttl_ofk_orig_did1;
integer		ttl_ofk_orig_didn;
integer		ttl_ofk_new_did0;
integer		ttl_ofk_new_did1;
integer		ttl_ofk_new_didn;
end;
//
all_ofk := dedup(sort(distribute(ds,hash(offender_key)),data_type,state_of_origin,vendor,source_file,offender_key,local),data_type,state_of_origin,vendor,source_file,offender_key,local);
stat_ttl_ofk_rec := record
string1		data_type:=all_ofk.data_type;
string2		state_of_origin:=all_ofk.state_of_origin;
string2		vendor:=all_ofk.vendor;
string20	source_file:=all_ofk.source_file;
integer		ttl_ofk := count(group);
end;
stats_ttl_ofk := table(all_ofk,stat_ttl_ofk_rec, data_type,state_of_origin,vendor,source_file,few);
//output(stats_ttl_ofk,all);

//
all_ofk_dids := dedup(sort(distribute(ds(orig_did<>0 or new_did<>0),hash(offender_key)),data_type,state_of_origin,vendor,source_file,offender_key,orig_did,new_did,local),data_type,state_of_origin,vendor,source_file,offender_key,orig_did,new_did,local);
stat_ofk_record1 := record
string1		data_type:=ds.data_type;
string2		state_of_origin:=ds.state_of_origin;
string2		vendor:=ds.vendor;
string20	source_file:=ds.source_file;
string90	offender_key:=ds.offender_key;
integer		ttl_ofk_orig_did := count(group,if(ds.orig_did<>0,1,0));
integer		ttl_ofk_new_did := count(group,if(ds.new_did<>0,1,0));
end;
stats_ofk_did_cnt := table(all_ofk_dids,stat_ofk_record1,data_type,state_of_origin,vendor,source_file,offender_key,local);
//output(choosen(stats_ofk_did_cnt,500));
stat_ofk_record2 := record
string1		data_type:=stats_ofk_did_cnt.data_type;
string2		state_of_origin:=stats_ofk_did_cnt.state_of_origin;
string2		vendor:=stats_ofk_did_cnt.vendor;
string20	source_file:=stats_ofk_did_cnt.source_file;
integer		ttl_ofk_orig_did0 := count(group,if(stats_ofk_did_cnt.ttl_ofk_orig_did=0,1,0));
integer		ttl_ofk_orig_did1 := count(group,if(stats_ofk_did_cnt.ttl_ofk_orig_did=1,1,0));
integer		ttl_ofk_orig_didn := count(group,if(stats_ofk_did_cnt.ttl_ofk_orig_did>1,1,0));
integer		ttl_ofk_new_did0  := count(group,if(stats_ofk_did_cnt.ttl_ofk_new_did=0,1,0));
integer		ttl_ofk_new_did1  := count(group,if(stats_ofk_did_cnt.ttl_ofk_new_did=1,1,0));
integer		ttl_ofk_new_didn  := count(group,if(stats_ofk_did_cnt.ttl_ofk_new_did>1,1,0));
end;
stats_ofk_did_bo := table(stats_ofk_did_cnt,stat_ofk_record2,data_type,state_of_origin,vendor,source_file,few);
//output(stats_ofk_did_bo,all);
//
stat_ofk to_join_ofk(stats_ttl_ofk l, stats_ofk_did_bo r) := transform
self := l;
self := r;
end;
stats2 := join(stats_ttl_ofk, stats_ofk_did_bo, 
							left.data_type=right.data_type and
							left.state_of_origin=right.state_of_origin and
							left.vendor=right.vendor and
							left.source_file=right.source_file, 
							to_join_ofk(left,right),
							left outer);
//output2(stats2,all);	


stats_all := record
stat_rec;
integer		ttl_ofk;
integer		ttl_ofk_orig_did0;
integer		ttl_ofk_orig_did1;
integer		ttl_ofk_orig_didn;
integer		ttl_ofk_new_did0;
integer		ttl_ofk_new_did1;
integer		ttl_ofk_new_didn;
end;

stats_all to_join_all(stats1 l, stats2 r) := transform
self := l;
self := r;
end;

statsx := join(stats1,stats2,	
						left.data_type=right.data_type and
						left.state_of_origin=right.state_of_origin and
						left.vendor=right.vendor and
						left.source_file=right.source_file, 
						to_join_all(left,right),
						left outer);

output(statsx,all);

										
//end2*/