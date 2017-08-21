import Business_Header;

// Append Group IDs to test records
amex_iclic_test_base := TM_Test.amex_iclic_test_bdid_by_contact;

bh_group := Business_Header.File_Super_Group;

amex_iclic_test_group_append := join(amex_iclic_test_base(bdid <> 0),
                                     bh_group,
							  left.bdid = right.bdid,
							  transform(Layout_Amex_iCLIC_Test_Base, self.group_id := right.group_id, self := left),
							  hash);

amex_iclic_test_group_combined := amex_iclic_test_group_append + amex_iclic_test_base(bdid = 0);

amex_iclic_test_group_combined_sort := sort(amex_iclic_test_group_combined, AXP_Vendor_Key, if(bdid <> 0, 1, 1), -bdid_score);



export amex_iclic_test_group := amex_iclic_test_group_combined_sort : persist('TMTEST::amex_iclic_test_group');