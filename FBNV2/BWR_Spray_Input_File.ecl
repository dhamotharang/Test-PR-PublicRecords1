import FBNV2,_control, std, lib_fileservices, _control;

export BWR_Spray_Input_File(string filename,string filedate,string source) 
		:= function
		
			leMailTarget      := _control.MyInfo.EmailAddressNotify;
			
		  fSendMail(string pSubject, string pBody)
				:= lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);
			
			validateSource(string pSource) :=
				map(trim(source,left,right) = 'Orange' => fSendMail('FBN Spray Started','Valid Source Parameter Entered'),		
								trim(source,left,right) = 'San_Diego'   => fSendMail('FBN Spray Started','Valid Source Parameter Entered'),
								trim(source,left,right) = 'Santa_Clara'   => fSendMail('FBN Spray Started','Valid Source Parameter Entered'),		
								trim(source,left,right) = 'Ventura'   => fSendMail('FBN Spray Started','Valid Source Parameter Entered'),
								trim(source,left,right) = 'Event'   => fSendMail('FBN Spray Started','Valid Source Parameter Entered'),		
								trim(source,left,right) = 'Filing'   => fSendMail('FBN Spray Started','Valid Source Parameter Entered'),		
								trim(source,left,right) = 'Harris'   => fSendMail('FBN Spray Started','Valid Source Parameter Entered'),
								trim(source,left,right) = 'Dallas'   => fSendMail('FBN Spray and Build Not Set Up For This Source','This Source Has Not Been Sent By Vendor In A Long Time'),
								trim(source,left,right) = 'InfoUSA'   => fSendMail('FBN Spray and Build Not Set Up For This Source','This Source HasNot Been Sent By Vendor In A Long Time'),		
								trim(source,left,right) = 'San_Bernardino'   => fSendMail('FBN Spray and Build Not Set Up For This Source','This Source Has Not Been Sent By Vendor In A Long Time'),		
								trim(source,left,right) = 'NY'   => fSendMail('FBN Spray and Build Not Set Up For This Source','This Source Has Not Been Sent By Vendor In A Long Time'),		
								trim(source,left,right) = 'Experian'   => fSendMail('FBN Spray Started','Valid Source Parameter Entered'),
								FAIL('Source Parameter passed did not match the Sources, please check the source value passed.'));	

				sourceip 					:= _control.IPAddress.bctlpedata11;
				
				superfilename 		:= FBNV2.Get_Input_Superfilename(source); 						
				logicalfilename 	:= FBNV2.Get_Input_Superfilename(source)[1..length(trim(superfilename))-length('Sprayed')]+filedate;
				reclength 				:= Get_Infile_Record_Length(source);
        groupName := STD.System.Thorlib.Group( );
				
        // Due to the file names changing with multiple loads, shortened them up to give the greatest
				// chance to actually get them all.
				doInstr	:= FileServices.SprayVariable(sourceip,
											'/data/data_build_4/fbn/sources/tx/harris/'+filedate+'/'+'ASNI*.txt',
											,'|',,'"', groupname,'~thor_data400::in::fbnv2::tx::harris::' + filedate+ '::instruments',-1,,,true,false);
																																	
				doOwner	:= FileServices.SprayVariable(sourceip,
											'/data/data_build_4/fbn/sources/tx/harris/'+filedate+'/'+'ASNO*.txt',
											,'|',,'"', groupname,'~thor_data400::in::fbnv2::tx::harris::' + filedate+ '::owners',-1,,,true,false);
												
				doDBA		:= FileServices.SprayVariable(sourceip,
											'/data/data_build_4/fbn/sources/tx/harris/'+filedate+'/'+'ASND*.txt',
											,'|',,'"', groupname,'~thor_data400::in::fbnv2::tx::harris::' + filedate+ '::dbas',-1,,,true,false);											
	
				spray_Harris := sequential( parallel(doInstr, doOwner, doDBA), 
											              Merge_FBN_TX_Harris('~thor_data400::in::fbnv2::tx::harris::' + filedate, 
																			'~thor_data400::in::fbnv2::tx::harris::' + filedate+ '::instruments', 
																			'~thor_data400::in::fbnv2::tx::harris::' + filedate+ '::owners', 
																			'~thor_data400::in::fbnv2::tx::harris::' + filedate+ '::dbas') );

				spray_Fixed				:= FileServices.SprayFixed(sourceip,filename, reclength,groupname,logicalfilename,-1,,,true,true,true);
				spray_file				:= map(trim(source,left,right) in ['Filing','Event'] => spray_Fixed,
				                         trim(source,left,right) = 'San_Diego'   => FileServices.SprayVariable(sourceip,filename, ,',','\\n,\\r\\n','"',groupname,logicalfilename,-1,,,true,true,true),
																 trim(source,left,right) = 'Santa_Clara' => FileServices.SprayVariable(sourceip,filename, ,,,'"',groupname,logicalfilename,-1,,,true,true,true),
														     trim(source,left,right) = 'Harris' => spray_Harris,
																 trim(source,left,right) = 'Orange' => FileServices.SprayVariable(sourceip,filename, ,,,'"',groupname,logicalfilename,-1,,,true,true,true),
																 trim(source,left,right) = 'Ventura' => FileServices.SprayVariable(sourceip,filename, ,'\\~','\\n,\\r\\n','"',groupname,logicalfilename,-1,,,true,true,true),		
																 trim(source,left,right) = 'Experian' => fsprayFBNfiles(filename,filedate,sourceip),															 
																 output('Source Parameter passed did not match the Sources, please check the source value passed.'));
																 
				create_super			:= FileServices.CreateSuperFile(superfilename,false);
				add_super 				:= sequential(FileServices.RemoveOwnedSubFiles(superfilename),
				                                FileServices.StartSuperFileTransaction(),
																				
																				FileServices.ClearSuperFile(superfilename), 
																				FileServices.RemoveOwnedSubFiles(superfilename),
																				
																				fileservices.addsuperfile(superfilename,logicalfilename),
																				FileServices.FinishSuperFileTransaction()
																			 );
																			 
				preprocess_file		:= map(trim(source,left,right) = 'Orange' => FBNV2.Standardize_FBN_CA_Orange(filedate, ,FBNV2.File_CA_Orange_in.raw),
																 trim(source,left,right) = 'San_Diego' => FBNV2.Standardize_FBN_CA_San_Diego(filedate, ,FBNV2.File_CA_San_Diego_in.raw),
																 trim(source,left,right) = 'Santa_Clara' => FBNV2.Standardize_FBN_CA_Santa_Clara(filedate, ,FBNV2.File_CA_Santa_Clara_in.raw),
																 trim(source,left,right) = 'Ventura' => FBNV2.Standardize_FBN_CA_Ventura(filedate, ,FBNV2.File_CA_Ventura_in.raw),
																 trim(source,left,right) = 'Harris' => FBNV2.Standardize_FBN_TX_Harris(filedate, ,FBNV2.File_TX_Harris_in.raw),
																 trim(source,left,right) = 'Filing' => FBNV2.Standardize_FBN_FL.fPreProcessFiling(filedate, ,FBNV2.File_FL_Filing_in.raw),
																 trim(source,left,right) = 'Event' => FBNV2.Standardize_FBN_FL.fPreProcessEvent(filedate, ,FBNV2.File_FL_Event_in.raw)
																 // ,output('Source Parameter passed did not match the Sources, please check the source value passed.')
																);
				
				
				addExtractSuper		:= sequential(
				                                FileServices.RemoveOwnedSubFiles(cluster.cluster_out + 'in::fbn_extract::sprayed::FL_Filing'),
																				FileServices.StartSuperFileTransaction(),
																				FileServices.AddSuperFile(cluster.cluster_out + 'in::fbn_extract::sprayed::FL_Filing', '~thor_data400::in::fbnv2::FL::Filing::'+filedate+'::Cleaned'),
																				FileServices.FinishSuperFileTransaction()
																			  );
																				
				retval 						:= sequential(validateSource(source),
				                                spray_file,
																				if (source!='Experian',
																				     sequential( 																								
																							if(~FileServices.FileExists(superfilename), create_super),
																							add_super,
																							preprocess_file
																					   )
																				   ),
																				if (source='Filing',
																							addExtractSuper
																						)	
																				//uncomment when scrubs is added		
																				,RunScrubsOnInput(source,filedate,leMailTarget)																				
																				);
		 return retval;
		
end;