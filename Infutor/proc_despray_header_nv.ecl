import doxie, RoxieKeyBuild, ut, header,infutor, lib_fileservices, _control,lib_Datalib;
export proc_despray_header_nv(string9 cversion_dev):=module
filedate := trim(cversion_dev,left,right);

d0:=Infutor.infutor_header(fname<>'',lname<>'',dob>0,st='NV');
d1:=table(d0,{did,title,fname,mname,lname,name_suffix,dob},did,title,fname,mname,lname,name_suffix,dob,few,merge);
createfile:=output(d1,,'~thor400_data::out::name_'+filedate+'.csv',csv(heading(single)),overwrite,compressed);
export despray:=sequential(createfile,
						   fileservices.Despray('~thor400_data::out::name_'+filedate+'.csv'
												  , _control.IPAddress.bctlpedata11
												  , '/data/data_lib_2_hus2/infutor/out/infutor_nv_'+filedate+'.csv',,,,true));
end;