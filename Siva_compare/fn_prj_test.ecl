EXPORT fn_prj_test (d1,d2, first_key,  second_key,  third_key, compare_file_name, pview_file_name  ) := functionmacro

siva_compare.MAC_prj_compare_file_layouts_1(d1, d2, outfile1);
siva_compare.MAC_prj_compare_file_layouts_2(d1, d2, outfile2 );


// outfile1;
// outfile2;
// firstfile  := distribute(outfile1, hash64(pid));
// Secondfile := distribute(outfile2, hash64(pid));

return siva_compare.MAC_Compare_files_macro_new(outfile1, outfile2, no_of_keys ,primary_list,  first_key,  second_key,  third_key, compare_file_name, pview_file_name );

endmacro;