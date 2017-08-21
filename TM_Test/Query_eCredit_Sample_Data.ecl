// Sample data

ecb := TM_Test.File_eCredit_Customer_Base;

layout_bdid_list := record
ecb.bdid;
end;

ecb_bdid_list := table(ecb(bdid <> 0), layout_bdid_list);
ecb_bdid_list_dedup := dedup(ecb_bdid_list, all);

ecb_bdid_sample := enth(ecb_bdid_list_dedup, 100);

// Generate sample customers
ecb_sample_customers := join(ecb,
                             ecb_bdid_sample,
					    left.bdid = right.bdid,
					    transform(TM_Test.Layout_eCredit_Customer_Base, self := left),
					    lookup);
					    
output(sort(ecb_sample_customers, bdid), all);

// Generate aging records for sample customers
eab := TM_Test.File_eCredit_Aging_Base;

eab_sample_aging := join(eab,
                         ecb_bdid_sample,
					left.bdid = right.bdid,
				     transform(TM_Test.Layout_eCredit_Aging_Base, self := left),
				     lookup);
					    
output(sort(eab_sample_aging, bdid), all);


