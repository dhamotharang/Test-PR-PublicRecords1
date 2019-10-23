//Barb O'Neill replaced Mac_Spray_Voters with this code for DOPS-461.
IMPORT std,VotersV2,_Control;

export fSprayAndPromoteVoters(string filedate) := 
function

#workunit('name','Voters Build '+filedate);
#option('multiplePersistInstances',FALSE);

wuid := thorlib.wuid();
sourceIP := 'bctlpedata12';
sourcePath := '/data/load01/voters/sprays/';
recSize := 1888;
groupName := STD.System.Thorlib.Group( );									

sprayed_superfile := VotersV2.cluster + 'in::Voters::Sprayed';
sprayed_name := VotersV2.cluster + 'in::Voters::sprayed::'+filedate;

spray_fileMessage := sprayed_name+' already exists.\n\n  Remove file with this '+filedate+' from SuperFiles AND Delete it or use different version date other than '+filedate+'.\n\n';

email_message := wuid+' - \n\n';

mailTargetSuccess := if(VotersV2._Flags.IsTesting
	                      ,_Control.MyInfo.EmailAddressNotify
												,_Control.MyInfo.EmailAddressNotify	
												+ ';Melanie.Jackson@lexisnexisrisk.com');

mailTarget := if(VotersV2._Flags.IsTesting
	                 ,_Control.MyInfo.EmailAddressNotify
									 ,_Control.MyInfo.EmailAddressNotify 
									 + ';Melanie.Jackson@lexisnexisrisk.com');

send_mail (string pSubject, string pBody) := FileServices.sendemail(mailTarget                                                                 , pSubject
																																		, pBody);

sprayIP := map(sourceIP = 'bctlpedata11' => _control.IPAddress.bctlpedata11,
									sourceIP = 'bctlpedata12' => _control.IPAddress.bctlpedata12,
									sourceIP);	 									
	

check_sprayed := if(FileServices.FileExists(sprayed_name)                   
                    ,sequential(
										send_mail('Emerges Voters Build',email_Message +spray_fileMessage)
										,fail('Emerges Voters Build - '+email_Message+spray_fileMessage)
										)
										);							
															
spray_state := FileServices.SprayFixed(sprayIP                              
                              ,sourcePath + '*.txt'
															,recSize
															,groupName
															,sprayed_name
															,-1,,,true,true,false,false);															
						
doSprayedToUsing := sequential(            
						Promote(filedate).Inputfiles.Sprayed2Using
						);	

doAdd := if(FileServices.GetLogicalFileAttribute(sprayed_name,'recordCount') != '0',
            sequential(FileServices.StartSuperFileTransaction(),
                           FileServices.AddSuperFile(sprayed_superfile,
																										 sprayed_name),
													 FileServices.FinishSuperFileTransaction())
			      );	

cleaned_file :=  output(VotersV2.Cleaned_Voters(filedate),,VotersV2.cluster + 'in::Voters::'+filedate+'::cleaned',overwrite);

super_main :=  sequential(FileServices.StartSuperFileTransaction(),
																	FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile',
																														VotersV2.Cluster + 'in::Voters::'+filedate+'::cleaned'),
																	FileServices.FinishSuperFileTransaction());

clean_state := if(FileServices.GetLogicalFileAttribute(sprayed_name,'recordCount') != '0',
					sequential(cleaned_file,super_main));
													 
doUsing2Used := Promote(filedate).Inputfiles.Using2Used;
					
do_all := sequential(
           check_sprayed,
           sprayIP,
					 spray_state,
					 doAdd,
					 doSprayedToUsing,
           clean_state,
					 doUsing2Used
					 );            	
						 
return do_all;
						 
END;