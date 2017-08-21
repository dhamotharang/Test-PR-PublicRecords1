// Output AXP File A in fixed format

#option('outputLimit', 50);

amex_iclic_clean := TM_Test.amex_iclic_test_prep;

amex_iclic_clean_out := project(amex_iclic_clean, transform(TM_Test.Layout_Output_File_A, self := left));

amex_iclic_clean_out_sort := sort(amex_iclic_clean_out, AXP_Vendor_Key);

output(amex_iclic_clean_out_sort,,'tmtest::amex_iclic_test_File_A',overwrite);



