 d := distribute(dataset('~thor_200::base::fcra_criminal_offender_20080801',CrimSrch.Layout_Moxie_Offender,flat,unsorted),hash(offender_key));
////////// dedupe d by offender key

dids := dedup(sort(distribute(d((unsigned6) did<>0),hash(offender_key)),offender_key,local),offender_key,local);
crimsrch.Layout_Moxie_Offender to_get_all_no_dids(d l,dids r) := transform
self := l;
end;

no_dids := join(d,dids,left.offender_key=right.offender_key,to_get_all_no_dids(left,right), left only,local);



tempLayout := record
unsigned6 new_did  := 0;
unsigned6 best_did := 0;
unsigned did_score := 0;
d;
end;

tempLayout trecs(d L) := transform
self.new_did   := 0;
self.best_did  := 0;
self.did_score := 0;
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
	 true, did_score,
	 75,//dids with a score below here will be dropped
	 outfile
	);
	
newfile:= outfile:persist('~thor_200::persist::fcraCrimDIDtest');

layout_primaryDIDtbl := record
newfile.offender_key;
newfile.new_did;
end;


primaryDIDtbl := sort(table(newfile(off_name_type = '0' and new_did != 0),layout_primaryDIDtbl,offender_key,new_did,few),offender_key,new_did);

newfile jrecs(newfile L, primaryDIDtbl R) := transform
self.best_did := map(L.offender_key = R.offender_key and
					 L.off_name_type != '0' => R.new_did,L.new_did);
					 
self := L;
end;

newfile2 := join(newfile,primaryDIDtbl,
				 left.offender_key = right.offender_key,
				 jrecs(left,right),left outer,hash);
				 


layout_bestAKAtbl := record
newfile2.offender_key;
newfile2.new_did;
newfile2.did_score;
maxScore:= max(group,newfile2.did_score);
end;


bestAKAtbl := sort(table(newfile2(off_name_type != '0' and new_did != 0),layout_bestAKAtbl,offender_key,new_did,did_score,few),offender_key,new_did,did_score);
bestakatbld := dedup(bestakatbl,offender_key,local);
layout_bestakatbl to_get_all_no_dids_aka_dided(d l,bestakatbld r) := transform
self := r;
end;
	
new_with_dids := join(no_dids,bestakatbld,left.offender_key=right.offender_key,to_get_all_no_dids_aka_dided(left,right), lookup);
output(enth(dedup(sort(distribute(new_with_dids,hash(offender_key)),offender_key,-did_score,local),offender_key,local),500));

newfile2 jrecs2(newfile2 L, bestAKAtbl R) := transform
self.best_did := map(L.offender_key = R.offender_key and
					 L.best_did = 0 => R.new_did,L.best_did);
					 
self := L;
end;

bestfile := join(newfile2,bestAKAtbl,
				 left.offender_key = right.offender_key,
				 jrecs2(left,right),left outer,hash) : persist('~thor_200::persist::fcraCrimBestDIDtest');
				 
//output(choosen(bestfile,20));
///////dedup by offender key to get correct rate

layout_statBest := record
bestfile.data_type;
bestfile.source_file;
has_best_did := AVE(group,IF(bestfile.best_did<>0,100,0)); ///// is the highest scoring aka did that has been propagated to every other record
has_did      := AVE(group,IF(stringlib.stringfilterout(bestfile.did,'0')<>'',100,0)); ////really your new file where everything has been did'ed regardless of the party type
end;
statBest:= sort(table(dedup(bestfile, offender_key, all),layout_statBest,data_type,source_file,few),data_type,source_file);

output(statBest,all);
