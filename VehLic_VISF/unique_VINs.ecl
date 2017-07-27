File_in_use := VehLic_VISF.File_Main_orig;

Layout_new := record
string20 VIN;
string1 eof;
end;

Layout_new tnew(File_in_use l) := Transform
self.VIN := l.VIN;
self.eof := '\n';
end;

newfile := Project(File_in_use,tnew(left));

output(choosen(newfile,1000));
/*
d_File_in_use := distribute(newfile,hash(VIN));
sort_file := sort(newfile,-VIN);
//output(sort_file)
ded_s_File_in_use := dedup(sort_file,VIN) ;
output(choosen(ded_s_File_in_use,1000));
//output(ded_s_File_in_use, ,'~thor_data400::in::experian_non_updating_VISF_unique_VINs',overwrite)
*/