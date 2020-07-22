//Ingenix Provider Samples
import lib_fileservices;

export Samples_Ingenix_QA(string filedate) := function

Ingenix_Provider_File 				:= dataset('~thor_data400::base::ingenix_providers_did',Ingenix_NatlProf.Layout_Provider_Base_Rid,flat);
Ingenix_Provider_Father_File  := dataset('~thor_data400::base::ingenix_providers_did_father',Ingenix_NatlProf.Layout_Provider_Base_Rid,flat);

Ingenix_Provider_File_dist 				:= dedup(sort(distribute(Ingenix_Provider_File,HASH32(providerid,addressid)),providerid,addressid, skew(0.5,0.5)),providerid);
Ingenix_Provider_Father_File_dist := dedup(sort(distribute(Ingenix_Provider_Father_File,HASH32(providerid,addressid)),providerid,addressid, skew(0.5,0.5)),providerid);

Ingenix_NatlProf.Layout_In_Clean_Provider join_ing_prov_trans(Ingenix_Provider_File le,Ingenix_Provider_Father_File re) := transform
	self := le;
end;

Ingenix_Provider_Join := join(Ingenix_Provider_File_dist,Ingenix_Provider_Father_File_dist,
																			LEFT.providerid = RIGHT.providerid 
																	,join_ing_prov_trans(LEFT,RIGHT),LEFT ONLY,local);

Provider_sort 				:= sort(dedup(Ingenix_Provider_Join, record),providerid);
Provider_dedup 				:= dedup(Provider_sort,providerid);

Provider_Samples 			:= output(choosen(Provider_dedup,1000),named('Ingenix_Provider_Samples'));
//Sanctions Samples
Ingenix_Sanc_File 		:= dataset('~thor_data400::base::ingenix_sanctions_did', Ingenix_NatlProf.layout_sanctions_DID_RecID,flat);


Ingenix_Sanc_Father_File 			:= dataset('~thor_data400::base::ingenix_sanctions_did_father',Ingenix_NatlProf.layout_sanctions_DID_RecID,flat);
Ingenix_Sanc_File_dist 				:= dedup(sort(distribute(Ingenix_Sanc_File,HASH32(sanc_id)),sanc_id,skew(0.5,0.5)),sanc_id);
Ingenix_Sanc_Father_File_dist := dedup(sort(distribute(Ingenix_Sanc_Father_File,HASH32(sanc_id)),sanc_id,skew(0.5,0.5)),sanc_id);

Ingenix_NatlProf.layout_sanctions_DID_RecID join_sanc_trans(Ingenix_Sanc_File le,Ingenix_Sanc_Father_File re) := transform
	self := le;
end;

join_Ingenix_Sanc := join(Ingenix_Sanc_File_dist,Ingenix_Sanc_Father_File_dist,LEFT.sanc_id = RIGHT.sanc_id,join_sanc_trans(LEFT,RIGHT),LEFT ONLY,local);

sanc_sort 				:= sort(dedup(join_Ingenix_Sanc,record),sanc_id);
dedup_sort 				:= dedup(sanc_sort,sanc_id);

sanction_samples 	:= output(choosen(dedup_sort(did <> ''),1000),named('Ingenix_Sanction_Samples'));
send_mail 			 	:= fileservices.sendemail('skasavajjala@seisint.com;qualityassurance@seisint.com',
																						 'Ingenix sample records for build version ' + filedate,
																						 'New Ingenix QA sample records: http://uspr-prod-thor-esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit);
	return sequential(Provider_Samples,sanction_samples
	,send_mail
	);
end;
