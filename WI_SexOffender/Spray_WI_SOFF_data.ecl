
//----------------------------------------------------------------------
//Function to spray fixed file specified
//----------------------------------------------------------------------
IMPORT lib_stringlib, lib_fileservices, _control,lib_thorlib;

EXPORT Spray_WI_SOFF_data (String srcIP,
                           String targetGrp,
												   String RemoteLoc,
												   String Update_filedate
                          )  := FUNCTION

// srcIP       := 'edata12.br.seisint.com';
 //targetGrp   := 'thor_data50';
// RemoteLoc   := '/export/home/vchikte/';
// Update_filedate := '20100701';

//#stored ('SOFF_Target_grp', targetGrp);

#workunit('name','WI SexOffender Promonitor Extract');


IPFileName_offender:= 'CP_OFND.txt';
IPFileName_Addr    := 'CP_OFND_RES.txt';

Sprayed_offender   := '~thor_data400::in::crim_court::wisoff::cp_ofnd'; 
Sprayed_Addr       := '~thor_data400::in::crim_court::wisoff::cp_ofnd_res';

recsize_CP_OFND     := 303;
recsize_CP_OFND_RES := 214;

//check if file exists in UNIX
checkremotefileexists(STRING FileName) := IF(count(FileServices.remotedirectory(srcIP,RemoteLoc,FileName,false)(size <> 0 )) = 1,
	                                           true,
	                                           false);		

   // Spray the file
Fun_SprayFile(String IPFileName, String OPFileName,rec_size) := FileServices.sprayfixed(
                                                                srcIP,
                                                                RemoteLoc + IPFileName,
                                                                rec_size,
                                                                targetGrp,
                                                                OPFileName,
                                                                -1,,,
																													      true,
																													      true                                                         
																                                );
																														 
   SprayFiles    := Parallel  (Fun_Sprayfile(IPFileName_offender ,Sprayed_offender ,recsize_CP_OFND),
                               Fun_Sprayfile(IPFileName_Addr     ,Sprayed_Addr ,recsize_CP_OFND_RES)
                              );
																		 
																
   spray_files   := sequential(Sprayfiles,
															 output('WI Sex Offender Spray complete') ,
															 WI_SexOffender.Proc_generate_WISOFF_Extract
															) : Failure(FileServices.SendEmail('Vani.chikte@lexisnexis.com','WI Sex Offender Extract', thorlib.wuid())),
															    Success(FileServices.SendEmail('Vani.chikte@lexisnexis.com','WI Sex Offender Extract','Completed Successfully')) ;																											 												 

return spray_files; 

end;


