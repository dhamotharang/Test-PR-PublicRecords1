import lib_fileservices,RoxieKeyBuild,ut;
export Proc_build_Iyetek(string filedate,string morning = 'no',string issunday = 'N') := function

string8 fdate := filedate[1..8];

updatdops := map(morning = 'yes' and issunday = 'N' => RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com',,'N',,'Y'),
                   morning = 'yes' and issunday = 'Y' => RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com','Y','N',,'Y'),
									 sequential(RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com'),RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com',,,,,'A'),Proc_OrbitI_CreateBuild(filedate)));

build_ecrashkey := FLAccidents_Ecrash.proc_build_EcrashV2_keys(filedate) : success(FileServices.sendemail( 'sudhir.kasavajjala@lexisnexis.com','ECrash Build Status' + filedate,'ECrash Build Success')),
                                                                           failure(FileServices.sendemail( 'sudhir.kasavajjala@lexisnexis.com','ECrash Build Status' + filedate,'ECrash  Build failure'));
 
string_rec := record
  string8 fdate;
end;

d := dataset([{filedate}],string_rec);

wchk := if(fileservices.fileexists('~thor_data400::in::iyetek_check_'+filedate),
	output('iyetek check file exists'),
	output(d,,'~thor_data400::in::iyetek_check_'+filedate));                                                                                                                                                   
																																																																									 
build_index := map ( ut.DaysApart(  (string8) ut.fGetFilenameVersion('~thor_data400::base::ecrash'),fdate ) = 0 and ut.DaysApart((string8) ut.fGetFilenameVersion('~thor_data400::base::iyetek_metadata') , fdate ) = 0 => 
                     Sequential(wchk,build_ecrashkey,updatdops,FLAccidents_Ecrash.Sample_data
		                            ,FLAccidents_Ecrash.strata(filedate),FLAccidents_Ecrash.proc_build_dupe_extract(filedate,ut.gettime()),
																FLAccidents_Ecrash.Proc_build_Accident_watch(filedate,ut.gettime()),FLAccidents_Ecrash.InFilesList) ,
                      ut.DaysApart(  (string8) ut.fGetFilenameVersion('~thor_data400::base::ecrash'),fdate ) <> 0  =>     FileServices.sendemail( 'sudhir.kasavajjala@lexisnexis.com','ECrash Base file not up to date','ECrash Base file has not been built yet.Please hold off the Index built for now'),
											ut.DaysApart( (string8) ut.fGetFilenameVersion('~thor_data400::base::iyetek_metadata'),fdate ) <> 0  =>     FileServices.sendemail( 'sudhir.kasavajjala@lexisnexis.com','Iyetek Base file not up to date','Iyetek Base file has not been built yet.Please hold off the Index built for now'),output('Both_Base_files_not_completed'));

chk_buildindx  := if ( fileservices.fileexists('~thor_data400::in::ecrash_check_'+filedate),output('Build_Index_already_started_from_ECrash'),build_index);

 
build_iyetek := Sequential(FLAccidents_Ecrash.Spray_In_Iyetek(false),FLAccidents_Ecrash.Map_base_Iyetek(filedate),chk_buildindx);

return build_iyetek;
end;