// Count Contact overlap with existing data
f := TM_Test.sga_contacts_prep;
count(f(did <> 0));
count(f(did = 0));

layout_contact_slim := record
f.bdid;
f.did;
f.fname;
f.mname;
f.lname;
f.name_suffix;
end;

fcontacts := table(f(bdid <> 0), layout_contact_slim);

bc := Business_Header.File_Business_Contacts_Base(bdid <> 0, from_hdr='N');

layout_bc_slim := record
bc.bdid;
bc.did;
bc.fname;
bc.mname;
bc.lname;
bc.name_suffix;
end;

bc_slim := table(bc, layout_bc_slim);

bc_overlap := join(bc_slim,
                   fcontacts,
			    left.bdid = right.bdid and
			      ((left.did = right.did and right.did <> 0) or
				  ut.NameMatch(left.fname, left.mname, left.lname,
				               right.fname, right.mname, right.lname) <= 3),
			    transform(layout_contact_slim, self := right),
			    hash);

count(dedup(bc_overlap, all));
count(dedup(bc_overlap(did <> 0), did, all));

bc_non_overlap := join(bc_slim,
                       fcontacts,
			        left.bdid = right.bdid and
			        ((left.did = right.did and right.did <> 0) or
				    ut.NameMatch(left.fname, left.mname, left.lname,
				               right.fname, right.mname, right.lname) <= 3),
			        transform(layout_contact_slim, self := right),
				   right only,
			        hash);

count(bc_non_overlap);
count(bc_non_overlap(did <> 0));