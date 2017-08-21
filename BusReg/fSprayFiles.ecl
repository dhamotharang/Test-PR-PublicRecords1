import Versioncontrol, _control, scrubs, Scrubs_BusReg, tools, std, ut;

export fSprayFiles(string		pServerIP		= _control.IPAddress.edata10
																	 ,string		pDirectory	 = '/prod_data_build_10/production_data/business_headers/accutrend/in/'
																	 ,string		pFilename		 = '*txt'
																	 ,string		pversion
																	 ,string		pGroupName	 = _dataset().groupname																		
																	 ,boolean	pIsTesting 	= false
																	 ,boolean	pOverwrite	 = false
																	 ,string		pNameOutput = _Dataset().Name + ' Spray Info'	
																	 ,string  PEmailList  = Email_Notification_Lists.ScrubsPlus
																 	) := function

	FilesToSpray := DATASET([
														{pServerIP
														,pDirectory
														,pFilename
														,sizeof(layouts.input.sprayed)
														,Filenames(pversion).input.new(pversion)
														,[ {Filenames(pversion).input.sprayed	}	]
														,pGroupName
														,pversion
														}

													], VersionControl.Layout_Sprays.Info
												 );
	spray_file				:= VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput);
	scrub_file				:= Scrubs.ScrubsPlus('BusReg','Scrubs_BusReg','Scrubs_BusReg','' ,pversion,PEmailList,false);
 
	return sequential(spray_file, scrub_file);

end;
