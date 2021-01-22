//ECrash Morning deployments
// The following flags to be set to Y
// isprodready is set to Y and Autopkg is set to Y only on Sunday.
import RoxieKeybuild,ut;
export Proc_Build_base(string filedate):= function 

string_rec	:=
	record
		string10	processdate;
	end;

desp_flag	:=	sequential(	output(dataset([{filedate}],string_rec),,'~thor_data400::out::ecrash_spversion',overwrite),
														fileservices.Despray(	'~thor_data400::out::ecrash_spversion','10.173.14.14',
																									'/super_credit/ecrash/bin/ecrashflag.txt',,,,TRUE
																								)
													);

Spray_ECrash := Sequential(FLAccidents_Ecrash.Spray_In(false), FLAccidents_Ecrash.Spray_In_Iyetek(false)): success( Sequential(desp_flag,FileServices.sendemail('DataReceiving@lexisnexis.com; sudhir.kasavajjala@lexisnexis.com','ECrash File Status' + filedate, 'Please archive ECrash files on LZ /super_credit/ecrash/build/'+ filedate))), failure(FileServices.sendemail('skasavajjala@seisint.com', '	ECrash Spray failure', failmessage));



build_all := sequential(
			 Spray_ECrash
      ,FLAccidents_Ecrash.map_basefile(filedate)
	  //,FLAccidents_Ecrash.Map_base_Iyetek(filedate)
		//	,FLAccidents.map_basefile_inquiry(filedate)
			) : success(Send_Email(filedate,'V2').buildsuccess), failure(Send_Email(filedate,'V1').buildfailure);

return build_all;

end;	