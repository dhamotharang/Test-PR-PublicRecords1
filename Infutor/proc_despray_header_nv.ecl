import doxie, RoxieKeyBuild, ut, header, lib_fileservices, _control,lib_Datalib;

filedate := trim(infutor.version_dev, all);

d0:=Infutor.infutor_header(fname<>'',lname<>'',dob>0,st='NV');
d1:=table(d0,{did,title,fname,mname,lname,name_suffix,dob},did,title,fname,mname,lname,name_suffix,dob,few,merge);
output(d1,,'~thor400_data::out::name_'+filedate+'.csv',csv(heading(single)),overwrite,compressed);
fileservices.Despray('~thor400_data::out::name_'+filedate+'.csv'
												  , _control.IPAddress.bctlpedata11
												  , '/data/data_lib_2_hus2/infutor/out/infutor_nv_'+filedate+'.csv',,,,true);
