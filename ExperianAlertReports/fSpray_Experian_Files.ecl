import lib_fileservices;
export fSpray_Experian_Files(string spath,string spath1,string spath2,string filedate) :=
function
source_ip := 'edata12-bld.br.seisint.com';
acc_exp_cust := FileServices.SprayVariable(source_ip, spath, 8192, '\\,', '\\n,\\r\\n', '\'', 'thor400_20', '~thor_data400::in::experian_customer_alert::' + filedate + '::data', -1, , -1, true, false,false) ; 
acc_comp := FileServices.SprayVariable(source_ip, spath1, 8192, '\\,', '\\n,\\r\\n', '\'', 'thor400_20', '~thor_data400::company::' + filedate + '::data', -1, , -1, true, false,false) ; 
acc_bus_comp := FileServices.SprayVariable(source_ip, spath2, 8192,'\\,', '\\n,\\r\\n', '\'', 'thor400_20', '~thor_data400::ab_company::' + filedate + '::data', -1, , -1, true, false,false) ; 

spray_all := parallel(acc_exp_cust,acc_comp,acc_bus_comp);
return spray_all;
end;
