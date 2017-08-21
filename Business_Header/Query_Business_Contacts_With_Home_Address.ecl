// Best records with non-zero addresses
bhb := Business_Header.File_Business_Header_Best(zip <> 0, prim_name <> '');

layout_bhb_slim := record
bhb.bdid;
end;

bhb_slim := table(bhb, layout_bhb_slim);

// select BDIDs with ADLs
bc := Business_Header.File_Business_Contacts(from_hdr = 'N', bdid <> 0, did <> 0);

layout_bc_slim := record
bc.bdid;
bc.did;
end;

bc_slim := table(bc, layout_bc_slim);
bc_slim_dedup := dedup(bc_slim, all);

// Select only BDIDs with non-blank address
bdid_did_list := join(bc_slim_dedup,
                      bhb_slim,
				  left.bdid = right.bdid,
				  transform(layout_bc_slim, self := left),
				  hash);
				  
layout_bdid_stat := record
bdid_did_list.bdid;
did_cnt := count(group);
end;

bdid_stat := table(bdid_did_list, layout_bdid_stat, bdid);

output(count(bdid_stat), named('Business_Locations_with_Contacts_Home_Address'));

layout_did_stat := record
bdid_did_list.did;
bdid_cnt := count(group);
end;

did_stat := table(bdid_did_list, layout_did_stat, did);

output(count(did_stat), named('Unique_Business_Contacts_With_Home_Address'));

output(sum(did_stat, bdid_cnt), named('Total_Business_Contact_Relationships'));



