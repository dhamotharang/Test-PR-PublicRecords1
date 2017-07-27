#workunit('name','Eq Norm DID');
h := header.Eq_Normalize;

header.Layout_Eq_DID fixDOB(h L) := transform
 self.dob := l.birthdate[3..6] + l.birthdate[1..2] + '00';
 self := l;
end;

fix_dob := project(h,fixDOB(left));

matchset := ['A','D','S','P','4','G','Z'];

did_add.Mac_Match_Flex(fix_dob,matchset,ssn,dob,fname,mname,lname,name_suffix,
					prim_range,prim_name,sec_range,zip,st,phone,did,header.Layout_Eq_DID,
					true,did_score,75,outfile)

output(outfile,,'base::eq_norm_did_200103');