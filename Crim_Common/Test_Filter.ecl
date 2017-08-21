export Test_Filter(file_date) := macro

#workunit('name','Test_Filter - '+ file_date)

df := dataset('~thor_data400::base::crim_offender2_did_20110916_new', 	Crim_Common.Layout_Moxie_Crim_Offender2.new, flat);

output(count(df));

endmacro;
