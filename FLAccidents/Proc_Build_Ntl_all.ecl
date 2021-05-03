//Bug # 64084 -- Added promonitor extract 
import ut, PromoteSupers, FLAccidents_Ecrash;
export Proc_Build_Ntl_all(string filedate):= function
								
Spray_NtlCrash := FLNTLCrash_Spray(false) : success(FileServices.sendemail('DataReceiving@lexisnexis.com; sudhir.kasavajjala@lexisnexis.com','NtlCrash File Status' + filedate, 'Please archive National Crash files on LZ /super_credit/flcrash/alpharetta/build/'+ filedate)), failure(FileServices.sendemail('sudhir.kasavajjala@lexisnexis.com', '	National Crash Spray failure', failmessage));

build_inq := if(regexfind( filedate,'b') = false,
                Sequential(Map_NtlAccidents_Alpharetta(filedate), Proc_build_Promonitor_Accident_extract),
								Output('Skip building Ntl base and promonitor in Evening Build'));

PromoteSupers.MAC_SF_BuildProcess(Map_NtlAccidents_Consolidation, '~thor_data400::base::ntlcrash_Consolidation', Build_NtlAccidents_Consolidation, 3, FALSE, TRUE);
PromoteSupers.MAC_SF_BuildProcess(Map_NtlAccidentsInquiry_Consolidation, '~thor_data400::base::ntlcrash_inquiry_Consolidation', Build_NtlAccidentsInquiry_Consolidation, 3, FALSE, TRUE);

build_all := sequential(
                        fn_CreateSuperFiles_NtlAccidents(),
                        ConcatNationalInputfiles,
                        Spray_NtlCrash,
			                  map_basefile_inquiry(filedate),
			                  notify('NTLCRU INQ BASE COMPLETE', '*'),
                        build_inq,
								        Build_NtlAccidents_Consolidation,
								        Build_NtlAccidentsInquiry_Consolidation
		                   );
			
return if(ut.weekday((integer)filedate)  in  [  'SATURDAY','SUNDAY' ] and regexfind( filedate ,'b') = false, Spray_NtlCrash, build_all);

end;	