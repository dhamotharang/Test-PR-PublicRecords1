//

IMPORT std;
															 
 EXPORT spray_federal_bureau_files (String Update_filedate) := function																 
																	 
	srcIP := 'bctlpedata12.risk.regn.net'; 
  targetGrp := 'thor400_dev01'; 
  RemoteLoc := '/data/projects/fbop/'+Update_filedate+'/';																 
							
	def   := 'US_FEDERAL_BUREAU_OF_PRISONS_FEDERAL_INMATE_REGISTRY_DEFENDANT.txt';
	off   := 'US_FEDERAL_BUREAU_OF_PRISONS_FEDERAL_INMATE_REGISTRY_OFFENSE.txt';
	sen   := 'US_FEDERAL_BUREAU_OF_PRISONS_FEDERAL_INMATE_REGISTRY_SENTENCE.txt';

	 
	Sprayeddef := def +'_'+Update_filedate+'_'+thorlib.wuid(); 
	Sprayedoff := off +'_'+Update_filedate+'_'+thorlib.wuid(); 
	Sprayedsen := sen +'_'+Update_filedate+'_'+thorlib.wuid(); 

	 
	sourceCsvSeparater := '\\,';
	sourceCsvTeminater := '\\n,\\r\\n';
	sourceCsvQuote     := '';

	//Check if file exists in UNIX
	checkremotefileexists(STRING FileName) :=  IF(count(FileServices.remotedirectory(srcIP,RemoteLoc,FileName,false)(size <>0 )) = 1, true, false);
	 
	//Spray the file
    Fun_SprayFile(String remoteFileName, String OPFileName) := 
		       IF(count(FileServices.remotedirectory(srcIP, RemoteLoc,remoteFileName,false)(size <>0 )) = 1,
	          FileServices.SprayVariable(
						srcIP, 
						RemoteLoc + remoteFileName,,sourceCsvSeparater,
						sourceCsvTeminater, 
						sourceCsvQuote, 
						targetGrp, 
						OPFileName, 
						-1,,, 
						true, 
						true,
						true),output('Source Lookup not found'+' '+srcIP+' '+RemoteLoc+' '+remoteFileName));
																							 
	   SprayFile  :=Parallel(Fun_Sprayfile(def,Sprayeddef),
					                 Fun_Sprayfile(off,Sprayedoff),	
					                 Fun_Sprayfile(sen,Sprayedsen));      									    


		//def raw
		clear_delete_sf_def		:= nothor(fileservices.clearsuperfile('~thor200_144::in::federal_inmate::defendant_delete', true));		

		superfile_shuffle_def			:= STD.File.PromoteSuperFileList(['~thor200_144::in::federal_inmate::defendant',
																							                  '~thor200_144::in::federal_inmate::defendant_father',
																							                  '~thor200_144::in::federal_inmate::defendant_grandfather',
																							                  '~thor200_144::in::federal_inmate::defendant_great_grandfather',
																							                  '~thor200_144::in::federal_inmate::defendant_delete'], Sprayeddef, true);	
   	
		//off raw
		clear_delete_sf_off		:= nothor(fileservices.clearsuperfile('~thor200_144::in::federal_inmate::offense_delete', true));		

		superfile_shuffle_off			:= STD.File.PromoteSuperFileList(['~thor200_144::in::federal_inmate::offense',
																							                  '~thor200_144::in::federal_inmate::offense_father',
																																'~thor200_144::in::federal_inmate::offense_grandfather',
																																'~thor200_144::in::federal_inmate::offense_great_grandfather',
																																'~thor200_144::in::federal_inmate::offense_delete'], Sprayedoff, true);																				
		
		
		//sent raw							
		clear_delete_sf_sent		:= nothor(fileservices.clearsuperfile('~thor200_144::in::federal_inmate::sentence_delete', true));		

		superfile_shuffle_sent			:= STD.File.PromoteSuperFileList(['~thor200_144::in::federal_inmate::sentence',
																							                    '~thor200_144::in::federal_inmate::sentence_father',
																							                    '~thor200_144::in::federal_inmate::sentence_grandfather',
																							                    '~thor200_144::in::federal_inmate::sentence_great_grandfather',
																							                    '~thor200_144::in::federal_inmate::sentence_delete'], Sprayedsen, true);																				
		

    return sequential(SprayFile,
	                    clear_delete_sf_def,
										  superfile_shuffle_def,
										  clear_delete_sf_off,
										  superfile_shuffle_off,
										  clear_delete_sf_off,
										  superfile_shuffle_sent);	
			     
	end;			