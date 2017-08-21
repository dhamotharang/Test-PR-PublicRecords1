my_ds:= crimsrch.File_Moxie_Offender_Dev(trim(StringLib.StringReverse(lname),all)[1..2] in [
'RJ',
'RS',
'II',
'VI']);

count(my_ds);

srec := record
string 	vendor:= my_ds.vendor;
string source_file := my_ds.source_file;
integer ttl := count(group);
end;
s := table(my_ds,srec,vendor,vendor,source_file,few);
output(s,all);


output(my_ds(vendor='AH'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='01'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='11'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='81'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='12'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='53'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='29'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='03'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='31'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='69'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='21'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='08'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='84'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='2S'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='16'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix});
output(my_ds(vendor='C2'),{vendor,source_file,off_name,orig_lname,fname,mname,lname,name_suffix},all);
