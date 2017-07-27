import ut;
export proc_build_all(string sourceip,string filename,string filedate,string do_spray='true') :=
function

insize := 551;

ut.mac_file_spray_and_build(sourceip,filename,insize,filedate,'dea',pre);


e_mail_success := fileservices.sendemail(
													'roxiebuilds@seisint.com;mluber@seisint.com;tkirk@seisint.com;CPettola@seisint.com;vniemela@seisint.com',
													'DEA Roxie Build Succeeded ' + filedate,
													'keys: 1) thor_data400::key::dea::qa::did(thor_data400::key::dea::'+filedate+'::did),\n' + 
													'	     2) thor_data400::key::dea::qa::bdid(thor_data400::key::dea::'+filedate+'::bdid),\n' + 
													'	     3) thor_data400::key::dea::qa::reg_num(thor_data400::key::dea::'+filedate+'::reg_num),\n' + 
													'	     4) thor_data400::key::dea::qa::linkids(thor_data400::key::dea::'+filedate+'::linkids),\n');
							
e_mail_fail := fileservices.sendemail(
													'CPettola@seisint.com;avenkatachalam@seisint.com',
													'DEA Roxie Build FAILED',
													failmessage);
													
spraystat := output('Spray done') : success(pre);

build_dea_keys :=	dea.proc_build_key(filedate);

e_mail_ret := if(do_spray='true',
						sequential(spraystat,dea.proc_build_base(filedate),
											 build_dea_keys,									
											 dea.proc_accept_sk_To_QA,
											 dea.Proc_Build_Boolean_Keys(filedate)),
						sequential(dea.proc_build_base(filedate),
											 build_dea_keys,
											 dea.proc_accept_sk_To_QA,
											 dea.Proc_Build_Boolean_Keys(filedate))
											 ) :
						success(e_mail_success),
						failure(e_mail_fail);

return e_mail_ret;


end;
