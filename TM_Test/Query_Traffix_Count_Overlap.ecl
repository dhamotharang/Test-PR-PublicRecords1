// Count overlap with existing PAW data for contacts with a bdid
f := TM_Test.traffix_prep;
count(f(did <> 0));
count(f(did = 0));

layout_contact_slim := record
f.bdid;
f.did;
f.fname;
f.mname;
f.lname;
f.name_suffix;
f.EMPLOYER;
end;

contacts_slim_bdid := table(f(bdid <> 0), layout_contact_slim);

bc := Business_Header.File_Business_Contacts_Base;

layout_bc_slim := record
bc.bdid;
bc.did;
bc.fname;
bc.mname;
bc.lname;
bc.name_suffix;
bc.company_name;
end;

bc_slim_bdid := table(bc(bdid <> 0, from_hdr='N'), layout_bc_slim);

bc_overlap_bdid := join(bc_slim_bdid,
                        contacts_slim_bdid,
			         left.bdid = right.bdid and
			         ((left.did = right.did and right.did <> 0) or
				      ut.NameMatch(left.fname, left.mname, left.lname,
				                   right.fname, right.mname, right.lname) <= 3),
			         transform(layout_contact_slim, self := right),
			         hash);

count(dedup(bc_overlap_bdid, all));
count(dedup(bc_overlap_bdid(did <> 0), did, all));

bc_non_overlap_bdid := join(bc_slim_bdid,
                            contacts_slim_bdid,
			             left.bdid = right.bdid and
			             ((left.did = right.did and right.did <> 0) or
				          ut.NameMatch(left.fname, left.mname, left.lname,
				                       right.fname, right.mname, right.lname) <= 3),
			             transform(layout_contact_slim, self := right),
				        right only,
			             hash);

count(bc_non_overlap_bdid);
count(bc_non_overlap_bdid(did <> 0));

// Count overlap with existing PAW data for contacts with a did
contacts_slim_did := table(f(did <> 0), layout_contact_slim);

bc_slim_did := table(bc(did <> 0), layout_bc_slim);

bc_overlap_did := join(bc_slim_did,
                       contacts_slim_did,
			        left.did = right.did and
			         ((left.bdid = right.bdid and right.bdid <> 0) or
				      ut.CompanySimilar100(left.company_name, stringlib.StringToUpperCase(right.EMPLOYER)) <= 65),
			         transform(layout_contact_slim, self := right),
			         hash);

count(dedup(bc_overlap_did, all));
count(dedup(bc_overlap_did(did <> 0), did, all));

bc_non_overlap_did := join(bc_slim_did,
                           contacts_slim_did,
			            left.did = right.did and
			             ((left.bdid = right.bdid and right.bdid <> 0) or
				          ut.CompanySimilar100(left.company_name, stringlib.StringToUpperCase(right.EMPLOYER)) <= 65),
			             transform(layout_contact_slim, self := right),
				        right only,
			             hash);

count(bc_non_overlap_did);
count(bc_non_overlap_did(did <> 0));