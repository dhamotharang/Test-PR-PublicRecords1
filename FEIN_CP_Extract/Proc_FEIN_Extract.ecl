import lib_fileservices,_control;

leMailTarget      := _control.MyInfo.EmailAddressNotify + '; datareceiving@lexisnexis.com; patrick.bell@lexisnexis.com;';

fSendMail(string pSubject, string pBody)
      := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);
	  
export  Proc_FEIN_Extract(string filedate ) := function
	
  despray_FEIN_Extract 	:= FileServices.despray('~thor_data400::out::'+filedate+'::FEIN_Extract',_control.IPAddress.edata10,
         																						'/data_build_4/Extracts/FEIN/FEIN_ScankExtract_'+filedate[1..8],
         																						,,,true);
										
	 		return sequential(	 FEIN_CP_Extract.fsprayFEIN_RawFiles(filedate[1..8])
								,FEIN_CP_Extract.FEIN_Map_ExtractLayout(filedate,,)
								,output('FEIN Extract PopulationStats Follow'	)
							    ,FEIN_CP_Extract.stats_Pop_FeinExtract
								,fSendMail('FEIN EXTRACT DE-SPRAY STARTING NOW FOR: '+filedate[1..8], 'Check edata10:/data_build_4/Extracts/FEIN/ for file shortly....')
								,despray_FEIN_Extract
								,fSendMail('FEIN EXTRACT File Ready For Pick Up: '+filedate[1..8],'The FEIN_Extract file at edata10:/data_build_4/Extracts/FEIN/FEIN_ScankExtract_'+filedate[1..8]+' is ready for pick up')
								,output('You may want to pick up desprayed FEIN_Extract file at edata10:/data_build_4/Extracts/FEIN/FEIN_ScankExtract_'+filedate[1..8])
								,notify('FEIN CP Extract Complete','*')
							 );
							 
	end;