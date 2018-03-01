//Bug # 64084 -- Added promonitor extract 
import RoxieKeybuild,ut,FLAccidents_Ecrash;
export Proc_Build_Ntl_all(string filedate):= function

build_inq := if ( regexfind( filedate ,'b') = false,Sequential(FLAccidents.Map_NtlAccidents_Alpharetta(filedate),FLAccidents.Proc_build_Promonitor_Accident_extract),Output('Skip building Ntl base and promonitor in Evening Build'));

Spray_NtlCrash := FLAccidents.FLNTLCrash_Spray(false) : success(FileServices.sendemail('DataReceiving@lexisnexis.com; sudhir.kasavajjala@lexisnexis.com','NtlCrash File Status' + filedate, 'Please archive National Crash files on LZ /super_credit/flcrash/alpharetta/build/'+ filedate)), failure(FileServices.sendemail('sudhir.kasavajjala@lexisnexis.com', '	National Crash Spray failure', failmessage));


build_all := sequential(
                 ConcatNationalInputfiles
                 ,Spray_NtlCrash
			          ,FLAccidents_Ecrash.map_basefile_inquiry(filedate)
			          ,notify('NTLCRU INQ BASE COMPLETE','*')
                 ,build_inq
		            );
			
return if(ut.weekday((integer)filedate)  in  [  'SATURDAY','SUNDAY' ] and regexfind( filedate ,'b') = false, Spray_NtlCrash, build_all);

end;	