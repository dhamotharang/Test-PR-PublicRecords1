import FBNV2,_control, std, lib_fileservices, ut;

export BWR_Spray_Input_File(string filename,string filedate,string source, string ip) 
		:= function
		
			leMailTarget      := _control.MyInfo.EmailAddressNotify;
			
		  fSendMail(string pSubject, string pBody)
				:= lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);
				
				ValidSources	:=	['ORANGE','SAN_DIEGO','SANTA_CLARA','VENTURA','EVENT','FILING','HARRIS','EXPERIAN'];
				StaticSources	:=	['DALLAS','INFOUSA','SAN_BERNARDINO','NY'];
				
				string psource := ut.CleanSpacesAndUpper(source);
			
				validateSource(string pSource) :=
				map(	trim(psource,left,right) in ValidSources 	=> fSendMail('FBN Spray Started','Valid Source Parameter Entered'),		
							trim(psource,left,right) in StaticSources	=> fSendMail('FBN Spray and Build Not Set Up For This Source','This Source Has Not Been Sent By Vendor In A Long Time'),
							FAIL('Source Parameter passed did not match the Sources, please check the source value passed.'));

				sourceip 					:= ip;
				
				superfilename 		:= FBNV2.Get_Input_Superfilename(psource); 						
				logicalfilename 	:= FBNV2.Get_Input_Superfilename(psource)[1..length(trim(superfilename))-length('Sprayed')]+filedate;
				reclength 				:= Get_Infile_Record_Length(psource);
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
	
				spray_HARRIS := sequential( parallel(doInstr, doOwner, doDBA), 
											              Merge_FBN_TX_HARRIS('~thor_data400::in::fbnv2::tx::harris::' + filedate, 
																			'~thor_data400::in::fbnv2::tx::harris::' + filedate+ '::instruments', 
																			'~thor_data400::in::fbnv2::tx::harris::' + filedate+ '::owners', 
																			'~thor_data400::in::fbnv2::tx::harris::' + filedate+ '::dbas') );

				spray_Fixed				:= FileServices.SprayFixed(sourceip,filename, reclength,groupname,logicalfilename,-1,,,true,true,true);
				spray_file				:= map(trim(psource,left,right) in ['FILING','EVENT'] => spray_Fixed,
				                         trim(psource,left,right) = 'SAN_DIEGO'   => FileServices.SprayVariable(sourceip,filename, ,',','\\n,\\r\\n','"',groupname,logicalfilename,-1,,,true,true,true),
																 trim(psource,left,right) = 'SANTA_CLARA' => FileServices.SprayVariable(sourceip,filename, ,,,'"',groupname,logicalfilename,-1,,,true,true,true),
														     trim(psource,left,right) = 'HARRIS' => spray_HARRIS,
																 trim(psource,left,right) = 'ORANGE' => FileServices.SprayVariable(sourceip,filename, ,,,'"',groupname,logicalfilename,-1,,,true,true,true),
																 trim(psource,left,right) = 'VENTURA' => FileServices.SprayVariable(sourceip,filename, ,'\\~','\\n,\\r\\n','"',groupname,logicalfilename,-1,,,true,true,true),		
																 trim(psource,left,right) = 'EXPERIAN' => fsprayFBNfiles(filename,filedate,sourceip),															 
																 output('Source Parameter passed did not match the Sources, please check the source value passed.'));
																 
				create_super			:= FileServices.CreateSuperFile(superfilename,false);
				add_super 				:= sequential(FileServices.RemoveOwnedSubFiles(superfilename),
				                                FileServices.StartSuperFileTransaction(),
																				
																				FileServices.ClearSuperFile(superfilename), 
																				FileServices.RemoveOwnedSubFiles(superfilename),
																				
																				fileservices.addsuperfile(superfilename,logicalfilename),
																				FileServices.FinishSuperFileTransaction()
																			 );
																			 
				preprocess_file		:= map(trim(psource,left,right) = 'ORANGE' => FBNV2.Standardize_FBN_CA_ORANGE(filedate, ,FBNV2.File_CA_ORANGE_in.raw),
																 trim(psource,left,right) = 'SAN_DIEGO' => FBNV2.Standardize_FBN_CA_SAN_DIEGO(filedate, ,FBNV2.File_CA_SAN_DIEGO_in.raw),
																 trim(psource,left,right) = 'SANTA_CLARA' => FBNV2.Standardize_FBN_CA_SANTA_CLARA(filedate, ,FBNV2.File_CA_SANTA_CLARA_in.raw),
																 trim(psource,left,right) = 'VENTURA' => FBNV2.Standardize_FBN_CA_VENTURA(filedate, ,FBNV2.File_CA_VENTURA_in.raw),
																 trim(psource,left,right) = 'HARRIS' => FBNV2.Standardize_FBN_TX_HARRIS(filedate, ,FBNV2.File_TX_HARRIS_in.raw),
																 trim(psource,left,right) = 'FILING' => FBNV2.Standardize_FBN_FL.fPreProcessFILING(filedate, ,FBNV2.File_FL_FILING_in.raw),
																 trim(psource,left,right) = 'EVENT' => FBNV2.Standardize_FBN_FL.fPreProcessEVENT(filedate, ,FBNV2.File_FL_EVENT_in.raw)
																);
				
				
				addExtractSuper		:= sequential(
				                                FileServices.RemoveOwnedSubFiles(cluster.cluster_out + 'in::fbn_extract::sprayed::fl_filing'),
																				FileServices.StartSuperFileTransaction(),
																				FileServices.AddSuperFile(cluster.cluster_out + 'in::fbn_extract::sprayed::fl_filing', '~thor_data400::in::fbnv2::fl::filing::'+filedate+'::Cleaned'),
																				FileServices.FinishSuperFileTransaction()
																			  );
																				
				retval 						:= sequential(validateSource(psource),
				                                spray_file,
																				if (psource!='EXPERIAN',
																				     sequential( 																								
																							if(~FileServices.FileExists(superfilename), create_super),
																							add_super,
																							preprocess_file
																					   )
																				   ),
																				if (psource='FILING',
																							addExtractSuper
																						)	
																				//uncomment when scrubs is added		
																				// ,RunScrubsOnInput(psource,filedate,leMailTarget)																				
																				);
		 return retval;
		
end;