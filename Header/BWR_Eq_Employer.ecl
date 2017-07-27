#workunit('name','Eq Employer');
//split out position and employer info

h := header.File_Eq_DID;

header.Layout_Eq_DID fixDOB(h L) := transform
 self.did := 0;
 self := l;
end;

fix_dob := project(h,fixDOB(left));

matchset := ['A','D','S','P','4','G','Z'];

did_add.Mac_Match_Flex(fix_dob,matchset,ssn,dob,fname,mname,lname,name_suffix,
					prim_range,prim_name,sec_range,zip,st,phone,did,header.Layout_Eq_DID,
					true,did_score,75,outfile)

a := outfile(did>0);

header.Layout_Eq_Employer split1(a L, integer c) := transform
 self.dt_first_seen := (unsigned3)l.file_date;
 self.dt_last_seen := (unsigned3)l.file_date;
 self.occupation_employer := choose(c,l.current_occupation_employer[stringlib.stringfind(l.current_occupation_employer,',',1)+1..],
									  l.former_occupation_employer[stringlib.stringfind(l.former_occupation_employer,',',1)+1..],
									  l.former2_occupation_employer[stringlib.stringfind(l.former2_occupation_employer,',',1)+1..],
									  l.other_occupation_employer[stringlib.stringfind(l.other_occupation_employer,',',1)+1..],
									  l.other_former_occupation_employer[stringlib.stringfind(l.other_former_occupation_employer,',',1)+1..]);
 self.occupation_position := choose(c,stringlib.stringfilterout(l.current_occupation_employer[1..stringlib.stringfind(l.current_occupation_employer,',',1)-1],','),
									  stringlib.stringfilterout(l.former_occupation_employer[1..stringlib.stringfind(l.former_occupation_employer,',',1)-1],','),
									  stringlib.stringfilterout(l.former2_occupation_employer[1..stringlib.stringfind(l.former2_occupation_employer,',',1)-1],','),
									  stringlib.stringfilterout(l.other_occupation_employer[1..stringlib.stringfind(l.other_occupation_employer,',',1)-1],','),
									  stringlib.stringfilterout(l.other_former_occupation_employer[1..stringlib.stringfind(l.other_former_occupation_employer,',',1)-1],','));
 //C - current, F - former, G - former2, O - other, P - other2
 self.employer_type := choose(c,'C','F','G','O','P');
 self := l;
end;

employ := normalize(a,5,split1(LEFT,counter))(occupation_employer!='');

//Remove dups
dis := distribute(employ,hash(did));
srt := sort(dis,record,local);
dup := dedup(srt,local);

//Rollup dates
header.Layout_Eq_Employer rollDates(employ L, employ R) := transform
  self.dt_last_seen := if(l.dt_last_seen>r.dt_last_seen,l.dt_last_seen,r.dt_last_seen);
  self.dt_first_seen := if(l.dt_first_seen>r.dt_first_seen,r.dt_first_seen,l.dt_first_seen);
  self := r;
end;

srt_roll := sort(dup,except dt_last_seen,except dt_first_seen,local);

dates := rollup(srt_roll,rolldates(left,right),except dt_last_seen,except dt_first_seen,local);

output(dates,,'base::Eq_Employer_200103' + thorlib.wuid(),overwrite);