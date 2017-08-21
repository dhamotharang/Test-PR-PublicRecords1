import	_control, PRTE_CSV;

export Proc_Build_Ingenix_Keys(string pIndexVersion)	:= function
 
 rKeyIngenix__ingenix_dea__providerid	:=
record
PRTE_CSV.Ingenix.rthor_data400__key__ingenix_dea__providerid	
end;

 rKeyIngenix__ingenix_degree__providerid	:=
record
PRTE_CSV.Ingenix.rthor_data400__key__ingenix_degree__providerid
end;

rKeyIngenix__ingenix_group__providerid	:=
record
	PRTE_CSV.Ingenix.rthor_data400__key__ingenix_group__providerid
end;

 rKeyIngenix__ingenix_hospital__providerid	:=
record
PRTE_CSV.Ingenix.rthor_data400__key__ingenix_hospital__providerid	
end;

 rKeyIngenix__ingenix_language__providerid	:=
record
PRTE_CSV.Ingenix.rthor_data400__key__ingenix_language__providerid	
end;

 rKeyIngenix__ingenix_license__providerid	:=
record
PRTE_CSV.Ingenix.rthor_data400__key__ingenix_license__providerid	
end;

 rKeyIngenix__ingenix_medschool__providerid	:=
record
PRTE_CSV.Ingenix.rthor_data400__key__ingenix_medschool__providerid	
end;

 rKeyIngenix__ngenix_npi__providerid	:=
record
PRTE_CSV.Ingenix.rthor_data400__key__ingenix_npi__providerid	
end;

 dKeyIngenix__ingenix_dea__providerid 		:=project(PRTE_CSV.Ingenix.dthor_data400__key__ingenix_dea__providerid ,rKeyIngenix__ingenix_dea__providerid);
 dKeyIngenix__ingenix_degree__providerid  	:=project(PRTE_CSV.Ingenix.dthor_data400__key__ingenix_degree__providerid,rKeyIngenix__ingenix_degree__providerid); 	
 dKeyIngenix__ingenix_group__providerid 	:=project(PRTE_CSV.Ingenix.dthor_data400__key__ingenix_group__providerid,rKeyIngenix__ingenix_group__providerid); 	
 dKeyIngenix__ingenix_hospital__providerid 	:=project(PRTE_CSV.Ingenix.dthor_data400__key__ingenix_hospital__providerid,rKeyIngenix__ingenix_hospital__providerid); 		
 dKeyIngenix__ingenix_language__providerid 	:=project(PRTE_CSV.Ingenix.dthor_data400__key__ingenix_language__providerid,rKeyIngenix__ingenix_language__providerid); 		
 dKeyIngenix__ingenix_license__providerid  	:=project(PRTE_CSV.Ingenix.dthor_data400__key__ingenix_license__providerid,rKeyIngenix__ingenix_license__providerid); 		
 dKeyIngenix__ingenix_medschool__providerid :=project(PRTE_CSV.Ingenix.dthor_data400__key__ingenix_medschool__providerid,rKeyIngenix__ingenix_medschool__providerid); 		
 dKeyIngenix__ingenix_npi__providerid  		:=project(PRTE_CSV.Ingenix.dthor_data400__key__ingenix_npi__providerid,rKeyIngenix__ngenix_npi__providerid); 					

 kKeyIngenix__ingenix_dea__providerid 		:= index(dKeyIngenix__ingenix_dea__providerid, {l_providerid}, {dKeyIngenix__ingenix_dea__providerid}, '~prte::key::ingenix_dea::' + pIndexVersion + '::providerid');
 kKeyIngenix__ingenix_degree__providerid 	:= index(dKeyIngenix__ingenix_degree__providerid, {l_providerid}, {dKeyIngenix__ingenix_degree__providerid}, '~prte::key::ingenix_degree::' + pIndexVersion + '::providerid');
 kKeyIngenix__ingenix_group__providerid 	:= index(dKeyIngenix__ingenix_group__providerid, {l_providerid}, {dKeyIngenix__ingenix_group__providerid}, '~prte::key::ingenix_group::' + pIndexVersion + '::providerid');
 kKeyIngenix__ingenix_hospital__providerid 	:= index(dKeyIngenix__ingenix_hospital__providerid, {l_providerid}, {dKeyIngenix__ingenix_hospital__providerid}, '~prte::key::ingenix_hospital::' + pIndexVersion + '::providerid');
 kKeyIngenix__ingenix_language__providerid 	:= index(dKeyIngenix__ingenix_language__providerid, {l_providerid}, {dKeyIngenix__ingenix_language__providerid}, '~prte::key::ingenix_language::' + pIndexVersion + '::providerid');
 kKeyIngenix__ingenix_license__providerid 	:= index(dKeyIngenix__ingenix_license__providerid, {l_providerid}, {dKeyIngenix__ingenix_license__providerid}, '~prte::key::ingenix_license::' + pIndexVersion + '::providerid');
 kKeyIngenix__ingenix_medschool__providerid := index(dKeyIngenix__ingenix_medschool__providerid, {l_providerid}, {dKeyIngenix__ingenix_medschool__providerid}, '~prte::key::ingenix_medschool::' + pIndexVersion + '::providerid');
 kKeyIngenix__ingenix_npi__providerid 		:= index(dKeyIngenix__ingenix_npi__providerid, {l_providerid}, {dKeyIngenix__ingenix_npi__providerid}, '~prte::key::ingenix_npi::' + pIndexVersion + '::providerid');


						return	sequential(
														parallel(
																build(kKeyIngenix__ingenix_dea__providerid	, update),
																build(kKeyIngenix__ingenix_degree__providerid	, update),
																build(kKeyIngenix__ingenix_group__providerid, update),
																build(kKeyIngenix__ingenix_hospital__providerid , update),
																build(kKeyIngenix__ingenix_language__providerid, update),
																build(kKeyIngenix__ingenix_license__providerid, update),
																build(kKeyIngenix__ingenix_medschool__providerid, update),
																build(kKeyIngenix__ingenix_npi__providerid, update)
																),

   											PRTE.UpdateVersion('IngenixKeys',										//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																)
								);
								 

end;