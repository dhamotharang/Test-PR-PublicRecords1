//Ingenix Provider Samples
import lib_fileservices,doxie_files;

export Samples_Ingenix_QA(string filedate) := function

Ingenix_Provider_File 				:= doxie_files.key_provider_id;
Ingenix_Provider_Father_File  := index(doxie_files.key_provider_id,'~thor_data400::key::ing_provider_id_father');



Ingenix_NatlProf.Layout_In_Clean_Provider join_ing_prov_trans(Ingenix_Provider_File le,Ingenix_Provider_Father_File re) := transform
	self := le;
end;

Ingenix_Provider_Join := join(Ingenix_Provider_File,Ingenix_Provider_Father_File,LEFT.l_providerid = RIGHT.l_providerid,join_ing_prov_trans(LEFT,RIGHT),LEFT ONLY);

Provider_sort 				:= sort(Ingenix_Provider_Join,providerid);
Provider_dedup 				:= dedup(Provider_sort,providerid);

Provider_Samples 			:= output(choosen(Provider_dedup,1000),named('Ingenix_Provider_Samples'));
//Sanctions Samples
Ingenix_Sanc_File 		:= doxie_files.key_sanctions_sancid;


Ingenix_Sanc_Father_File 			:= index(doxie_files.key_sanctions_sancid,'~thor_data400::key::ingenix_sanctions_sancid_father');

Ingenix_NatlProf.layout_sanctions_DID_RecID join_sanc_trans(Ingenix_Sanc_File le,Ingenix_Sanc_Father_File re) := transform
	self := le;
end;

join_Ingenix_Sanc := join(Ingenix_Sanc_File,Ingenix_Sanc_Father_File,LEFT.l_sancid = RIGHT.l_sancid,join_sanc_trans(LEFT,RIGHT),LEFT ONLY);

sanc_sort 				:= sort(join_Ingenix_Sanc,sanc_id);
dedup_sort 				:= dedup(sanc_sort,sanc_id);

sanction_samples 	:= output(choosen(dedup_sort(did <> ''),1000),named('Ingenix_Sanction_Samples'));
send_mail 			 	:= fileservices.sendemail('skasavajjala@seisint.com;qualityassurance@seisint.com',
																						 'Ingenix sample records for build version ' + filedate,
																						 'New Ingenix QA sample records: http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit);
	return sequential(Provider_Samples,sanction_samples
	,send_mail
	);
end;
