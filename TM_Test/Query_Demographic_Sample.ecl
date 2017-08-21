layout_bdid_list := record
unsigned6 bdid;
unsigned6 group_id := 0;
end;

// List of Business Header BDIDs not in D&B
bh_list_nondnb := dataset('~thor_data400::TMTEST::Demographic_BDID_List_NonDNB', layout_bdid_list, flat);				   

// List of D&B BDIDS
db_list := dataset('~thor_data400::TMTEST::Demographic_BDID_List_DNB', layout_bdid_list, flat);	

db_bdid_only := join(bh_list_nondnb,
                     db_list,
				 left.bdid = right.bdid,
				 transform(layout_bdid_list, self := right),
				 right only,
				 hash);
				 
db_bdid_only_sample := enth(db_bdid_only, 1000);

bhb := Business_Header.File_Business_Header_Best;

layout_bhb_group := record
unsigned6 group_id;
bhb;
end;

// Get sample records from best file
db_sample := join(bhb,
                  db_bdid_only_sample,
			   left.bdid = right.bdid,
			   transform(layout_bhb_group, self.group_id := right.group_id, self := left),
			   lookup);
			   
output(db_sample, all);
