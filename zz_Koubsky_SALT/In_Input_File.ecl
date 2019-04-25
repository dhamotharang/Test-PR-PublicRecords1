
infile_name := 'scoringqa::out::nonfcra_ita_capitalone_batch_v30_capone_ita_test_20140519';
infile_lay := zz_Koubsky_SALT.Layout_Input_File;

ds_ita := dataset(infile_name, infile_lay, csv(heading(1), quote('"')) );

EXPORT In_Input_File := ds_ita;