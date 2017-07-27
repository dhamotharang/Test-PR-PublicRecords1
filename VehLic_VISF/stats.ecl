File_in_use_Orig := VehLic_VISF.File_Main_Orig;

//File_in_use_Name := VehLic_VISF.File_Main_Name;

//File_in_use_Address := VehLic_VISF.File_Main_Address;

 

d_orig := distribute(File_in_use_orig,hash(file_no));

orig_stat_rec :=  record

d_orig.file_no;

d_orig.STATE_POST_CODE;

total := count(group);

end;

orig_stats := table(d_orig,orig_stat_rec,file_no,STATE_POST_CODE,few);

output(choosen(orig_stats,1000));

 /*

d_name := distribute(File_in_use_name,hash(file_no));

name_stat_rec :=  record

d_name.file_no;

d_name.NAME_TYPE;

total := count(group);

end;

name_stats := table(d_name,name_stat_rec,file_no,NAME_TYPE,few);

output(choosen(name_stats,1000));

 

d_address := distribute(File_in_use_address,hash(file_no));

address_stat_rec :=  record

d_address.file_no;

d_address.ADDR_TYPE;

total := count(group);

end;

address_stats := table(d_address,address_stat_rec,file_no,ADDR_TYPE,few);

output(choosen(address_stats,1000));*/