export fn_process_one(string input_file, string dest_file_qualifier, string vdate) := function

import ut,header_services,_control;

super_file 	:= '~thor_data400::in::md5::qa::ssn'+dest_file_qualifier;
logical_file := '~thor_data400::in::md5::'+vdate+'::ssn'+dest_file_qualifier;

my_layout := header_services.Supplemental_Data.layout_in;
header_services.Supplemental_Data.mac_verify(	input_file,my_layout,supp_ds_func1);
in_new := supp_ds_func1();

stepa := output(in_new,,logical_file,overwrite);
stepb := fileservices.startsuperfiletransaction();
stepc := fileservices.clearsuperfile(super_file);
stepd := fileservices.addsuperfile(super_file,logical_file);
stepe := fileservices.finishsuperfiletransaction();
stepf := fileservices.despray(logical_file,
																	_control.IPAddress.edata12,
																	'/thor_back5/local_data/md5_ssn/despray_ssn'+dest_file_qualifier,
																	,,,true);

do_it := sequential(stepa,stepb,stepc,stepd,stepe,stepf) : success(output('1')),failure(output('7'));

return do_it;

end;