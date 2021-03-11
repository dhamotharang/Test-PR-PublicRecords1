//Barb O'Neill replaced Mac_Spray_Voters with this code for DOPS-461.
IMPORT std,VotersV2,_Control;

export spray_allowed_states(string st,string pversion, string sprayIP, string sourcePath,string superfileName,integer recSize,string groupName):= function
				
    sprayed_name := VotersV2.cluster + 'in::Voters::sprayed::'+pversion+'::'+st;		
		
		spray_state := FileServices.SprayFixed(sprayIP                              
                              ,sourcePath
															+ st
															+ '*.txt'
															,recsize
															,groupName
															,sprayed_name
															,-1,,,true,true,false,false);	
		
		addSuper:=FileServices.AddSuperFile(superfileName, 
				                         sprayed_name);
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Check to see if state sprayed file is already in superfile.
///// If state sprayed file is present remove sprayed file from subsuperfile and respray and add to superfile again. 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		doSeq:= sequential(
										 spray_state,addSuper
									   );									 
		return doSeq;
end;

export fSprayAndPromoteVoters(string pversion, string sourceIP = 'bctlpedata11', string sourcePath = '/data/load01/voters/sprays/') := 
function

#workunit('name','Voters Build '+pversion);
#option('multiplePersistInstances',FALSE);

wuid := thorlib.wuid();
recSize := 1888;
groupName := STD.System.Thorlib.Group( );									

sprayed_used_superfile := VotersV2.cluster + 'in::Voters::used';

clear_sprayed_used := sequential(FileServices.StartSuperFileTransaction(),
															FileServices.ClearSuperFile(sprayed_used_superfile),
															FileServices.FinishSuperFileTransaction());	

sprayed_superfile := VotersV2.cluster + 'in::Voters::Sprayed';

email_message := wuid+' - \n\n';

mailTargetSuccess := if(VotersV2._Flags.IsTesting
	                      ,_Control.MyInfo.EmailAddressNotify
												,_Control.MyInfo.EmailAddressNotify	
												+ ';Melanie.Jackson@lexisnexisrisk.com');

mailTarget := if(VotersV2._Flags.IsTesting
	                 ,_Control.MyInfo.EmailAddressNotify
									 ,_Control.MyInfo.EmailAddressNotify 
									 + ';Melanie.Jackson@lexisnexisrisk.com');

send_mail (string pSubject, string pBody) := FileServices.sendemail(mailTarget, pSubject, pBody);

sprayIP := map(sourceIP = 'bctlpedata11' => _control.IPAddress.bctlpedata11,
									sourceIP = 'bctlpedata12' => _control.IPAddress.bctlpedata12,
									sourceIP);	 									
					
spray_state := sequential(
	             spray_allowed_states('AK',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)	
							 ,spray_allowed_states('AL',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('AR',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('CO',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('CT',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('DC',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('FL',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('LA',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('MA',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('MI',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('NC',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('NJ',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('NV',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('NY',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('OH',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('OK',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('RI',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('TX',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
	             ,spray_allowed_states('WI',pversion,sprayIP,sourcePath,sprayed_superfile,recSize,groupName)
							 );
						
doSprayedToUsing := sequential(            
						Promote(pversion).Inputfiles.Sprayed2Using
						);	

cleaned_file :=  output(VotersV2.Cleaned_Voters(pversion),,VotersV2.cluster + 'in::Voters::'+pversion+'::cleaned',overwrite);

super_main :=  sequential(FileServices.StartSuperFileTransaction(),
																	FileServices.AddSuperFile(VotersV2.Cluster + 'in::Voters::main::Superfile',
																														VotersV2.Cluster + 'in::Voters::'+pversion+'::cleaned'),
																	FileServices.FinishSuperFileTransaction());

clean_state := if(FileServices.GetLogicalFileAttribute(sprayed_superfile,'recordCount') != '0',
					sequential(cleaned_file,super_main));
													 
doUsing2Used := Promote(pversion).Inputfiles.Using2Used;
					
do_all := sequential(
           clear_sprayed_used,
           sprayIP,
					 spray_state,
					 doSprayedToUsing,
           clean_state,
					 doUsing2Used
					 );            	
						 
return do_all;
						 
END;

