layout_bdid_list := record
unsigned6 bdid;
unsigned6 group_id := 0;
end;

// List of Business Header BDIDs not in InfoUSA
bh_list_nondnb := dataset('~thor_data400::TMTEST::Demographic_BDID_List_NonIUSA', layout_bdid_list, flat);				   

// List of InfoUSA BDIDS
iusa_list := dataset('~thor_data400::TMTEST::Demographic_BDID_List_IUSA', layout_bdid_list, flat);	

iusa_bdid_only := join(bh_list_nondnb,
                     iusa_list,
				 left.bdid = right.bdid,
				 transform(layout_bdid_list, self := right),
				 right only,
				 hash);
				 
iusa_bdid_only_sample := enth(iusa_bdid_only, 1000);

bhb := Business_Header.File_Business_Header_Best;

layout_bhb_group := record
unsigned6 group_id;
bhb;
end;

// Get sample records from best file
iusa_sample := join(bhb,
                  iusa_bdid_only_sample,
			   left.bdid = right.bdid,
			   transform(layout_bhb_group, self.group_id := right.group_id, self := left),
			   lookup);
			   
output(iusa_sample, all);
