#workunit('name','Yogurt: DEA Daily Build');
#OPTION('multiplePersistInstances',FALSE);
import ut, roxiekeybuild, tools, DEA, Orbit3;
export proc_build_all(string sourceip,string filename,string filedate,string do_spray='true') :=
function

// insize := 551;
insize := 246;

ut.mac_file_spray_and_build(sourceip,filename,insize,filedate,'dea',pre,tools.fun_Groupname());


e_mail_success := fileservices.sendemail(
													'darren.knowles@lexisnexisrisk.com;roxiebuilds@seisint.com;charlene.ros@lexisnexis.com;Melanie.Jackson@lexisnexisrisk.com',
													'DEA Roxie Build Succeeded ' + filedate,
													'keys: 1) thor_data400::key::dea::qa::did(thor_data400::key::dea::'+filedate+'::did),\n' + 
													'	     2) thor_data400::key::dea::qa::bdid(thor_data400::key::dea::'+filedate+'::bdid),\n' + 
													'	     3) thor_data400::key::dea::qa::reg_num(thor_data400::key::dea::'+filedate+'::reg_num),\n' + 
													'	     4) thor_data400::key::dea::qa::linkids(thor_data400::key::dea::'+filedate+'::linkids),\n');
							
e_mail_fail := fileservices.sendemail(
													'darren.knowles@lexisnexisrisk.com;charlene.ros@lexisnexis.com;Melanie.Jackson@lexisnexisrisk.com',
													'DEA Roxie Build FAILED',
													failmessage);
													
build_dea_keys :=	dea.proc_build_key(filedate);


update_dops := RoxieKeyBuild.updateversion('DEAKeys',(filedate),'Darren.Knowles@lexisnexisrisk.com;charlene.ros@lexisnexisrisk.com;Melanie.Jackson@lexienexisrisk.com',,'N|B');

orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('DEA',(filedate),'N|B');

e_mail_ret := if(do_spray='true',
						sequential(pre,
						           DEA.Scrub_DEA(filedate).All,
						           dea.proc_build_base(filedate),
											 build_dea_keys,									
											 dea.proc_accept_sk_To_QA,
											 dea.Proc_Build_Boolean_Keys(filedate),
											 update_dops,
											 dea.SampleRecs,
											 orbit_update),
						sequential(dea.proc_build_base(filedate),
											 build_dea_keys,
											 dea.proc_accept_sk_To_QA,
											 dea.Proc_Build_Boolean_Keys(filedate),
											 update_dops,
											 dea.SampleRecs,
											 orbit_update)
											 ) :
						success(e_mail_success),
						failure(e_mail_fail);

return e_mail_ret;


end;
