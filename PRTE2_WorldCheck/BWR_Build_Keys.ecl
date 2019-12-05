import STD,PRTE2, _control, PRTE, Data_Services, dops;

skipDOPS:=FALSE;
string emailTo:='';
dataset_name := 'WorldCheckKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + '';


//Build Keys
Key_ext_src  	:= index(prte2_worldcheck.files.ext_sources,{UID},{prte2_worldcheck.files.ext_sources},prte2.constants.prefix+'key::worldcheck::'+ pIndexVersion+'::external_sources');
Key_in       	:= index(prte2_worldcheck.files.in_file,{uid},{prte2_worldcheck.files.in_file},prte2.constants.prefix+'key::worldcheck::'+ pIndexVersion+'::in');
Key_key  			:= index(prte2_worldcheck.files.main,{key},{prte2_worldcheck.files.main},prte2.constants.prefix+'key::worldcheck::'+ pIndexVersion+'::key');
Key_main  		:= index(prte2_worldcheck.files.main,{UID},{prte2_worldcheck.files.main},prte2.constants.prefix+'key::worldcheck::'+ pIndexVersion+'::main');
Key_version  	:= index(prte2_worldcheck.files.version,{version},{},prte2.constants.prefix+'key::worldcheck::'+ pIndexVersion+'::version');

out := output(prte2_worldcheck.files.tokens,,prte2.constants.prefix + 'base::WorldCheck::' + pIndexVersion + '::tokens',overwrite,__compressed__);

//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dataset_name, pIndexVersion, notifyEmail,'B','N','N');
PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
//-----------------------------------------------------------------

key_validation :=  output(dops.ValidatePRCTFileLayout(pIndexVersion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dataset_name, 'N'), named(dataset_name+'Validation'));


build_keys := sequential(parallel(build(Key_ext_src, update), 
                                  build(Key_in, update),
																	build(Key_key, update),
																	build(Key_main, update),
																	build(Key_version, update),
																	out
																	), 
																	key_validation,
																	PerformUpdateOrNot
												);

build_keys;                       
output ('successful');