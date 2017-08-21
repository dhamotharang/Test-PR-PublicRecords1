import	_control, PRTE_CSV;
export Proc_Build_Ingenix_Providers_Keys(string pIndexVersion)	:= function
 
rKeyIngenix_Providers__ingenix_providerid_upin__providerid	:=
record
PRTE_CSV.Ingenix_Providers.rthor_data400__key__ingenix_providerid_upin__providerid;
end;

rKeyIngenix_Providers__ingenix_providers__autokey__address	:=
record
PRTE_CSV.Ingenix_Providers.rthor_data400__key__ingenix_providers__autokey__address;
end;

rKeyIngenix_Providers__ingenix_providers__autokey__citystname	:=
record
PRTE_CSV.Ingenix_Providers.rthor_data400__key__ingenix_providers__autokey__citystname;
end;

rKeyIngenix_Providers__ingenix_providers__autokey__name	:=
record
PRTE_CSV.Ingenix_Providers.rthor_data400__key__ingenix_providers__autokey__name;
end;

rKeyIngenix_Providers__ingenix_providers__autokey__payload	:=
record
PRTE_CSV.Ingenix_Providers.rthor_data400__key__ingenix_providers__autokey__payload;
end;

rKeyIngenix_Providers__ingenix_providers__autokey__phone2	:=
record
PRTE_CSV.Ingenix_Providers.rthor_data400__key__ingenix_providers__autokey__phone2;
end;

rKeyIngenix_Providers__ingenix_providers__autokey__stname	:=
record
PRTE_CSV.Ingenix_Providers.rthor_data400__key__ingenix_providers__autokey__stname;
end;

rKeyIngenix_Providers__ingenix_providers__autokey__zip	:=
record
	PRTE_CSV.Ingenix_Providers.rthor_data400__key__ingenix_providers__autokey__zip;
end;

rKeyIngenix_Providers__ingenix_residency__providerid	:=
record
	PRTE_CSV.Ingenix_Providers.rthor_data400__key__ingenix_residency__providerid;
end;

 dKeyIngenix_Providers__ingenix_providerid_upin__providerid 	:=project(PRTE_CSV.Ingenix_Providers.dthor_data400__key__ingenix_providerid_upin__providerid ,rKeyIngenix_Providers__ingenix_providerid_upin__providerid);
 dKeyIngenix_Providers__ingenix_providers__autokey__address  	:=project(PRTE_CSV.Ingenix_Providers.dthor_data400__key__ingenix_providers__autokey__address,rKeyIngenix_Providers__ingenix_providers__autokey__address	); 	
 dKeyIngenix_Providers__ingenix_providers__autokey__citystname 	:=project(PRTE_CSV.Ingenix_Providers.dthor_data400__key__ingenix_providers__autokey__citystname,rKeyIngenix_Providers__ingenix_providers__autokey__citystname); 	
 dKeyIngenix_Providers__ingenix_providers__autokey__name 		:=project(PRTE_CSV.Ingenix_Providers.dthor_data400__key__ingenix_providers__autokey__name,rKeyIngenix_Providers__ingenix_providers__autokey__name); 		
 dKeyIngenix_Providers__ingenix_providers__autokey__payload 	:=project(PRTE_CSV.Ingenix_Providers.dthor_data400__key__ingenix_providers__autokey__payload,rKeyIngenix_Providers__ingenix_providers__autokey__payload); 		
 dKeyIngenix_Providers__ingenix_providers__autokey__phone2  	:=project(PRTE_CSV.Ingenix_Providers.dthor_data400__key__ingenix_providers__autokey__phone2,rKeyIngenix_Providers__ingenix_providers__autokey__phone2); 		
 dKeyIngenix_Providers__ingenix_providers__autokey__stname 		:=project(PRTE_CSV.Ingenix_Providers.dthor_data400__key__ingenix_providers__autokey__stname,rKeyIngenix_Providers__ingenix_providers__autokey__stname); 		
 dKeyIngenix_Providers__ingenix_providers__autokey__zip 		:=project(PRTE_CSV.Ingenix_Providers.dthor_data400__key__ingenix_providers__autokey__zip,rKeyIngenix_Providers__ingenix_providers__autokey__zip); 					
 dKeyIngenix_Providers__ingenix_residency__providerid			:=project(PRTE_CSV.Ingenix_Providers.dthor_data400__key__ingenix_residency__providerid,rKeyIngenix_Providers__ingenix_residency__providerid); 
 
kKeyIngenix_Providers__ingenix_providerid_upin__providerid 		:= index(dKeyIngenix_Providers__ingenix_providerid_upin__providerid, {l_upin,l_providerid}, {dKeyIngenix_Providers__ingenix_providerid_upin__providerid}, '~prte::key::ingenix_providerid_upin::' + pIndexVersion + '::providerid');
kKeyIngenix_Providers__ingenix_providers__autokey__address 		:= index(dKeyIngenix_Providers__ingenix_providers__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyIngenix_Providers__ingenix_providers__autokey__address}, '~prte::key::ingenix_providers::' + pIndexVersion + '::autokey::address');
kKeyIngenix_Providers__ingenix_providers__autokey__citystname 	:= index(dKeyIngenix_Providers__ingenix_providers__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Providers__ingenix_providers__autokey__citystname}, '~prte::key::ingenix_providers::' + pIndexVersion + '::autokey::citystname');
kKeyIngenix_Providers__ingenix_providers__autokey__name 		:= index(dKeyIngenix_Providers__ingenix_providers__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Providers__ingenix_providers__autokey__name }, '~prte::key::ingenix_providers::' + pIndexVersion + '::autokey::name');
kKeyIngenix_Providers__ingenix_providers__autokey__payload 		:= index(dKeyIngenix_Providers__ingenix_providers__autokey__payload, {fakeid}, {dKeyIngenix_Providers__ingenix_providers__autokey__payload}, '~prte::key::ingenix_providers::' + pIndexVersion + '::autokey::payload');
kKeyIngenix_Providers__ingenix_providers__autokey__phone2 		:= index(dKeyIngenix_Providers__ingenix_providers__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyIngenix_Providers__ingenix_providers__autokey__phone2}, '~prte::key::ingenix_providers::' + pIndexVersion + '::autokey::phone2');
kKeyIngenix_Providers__ingenix_providers__autokey__stname 		:= index(dKeyIngenix_Providers__ingenix_providers__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Providers__ingenix_providers__autokey__stname}, '~prte::key::ingenix_providers::' + pIndexVersion + '::autokey::stname');
kKeyIngenix_Providers__ingenix_providers__autokey__zip 			:= index(dKeyIngenix_Providers__ingenix_providers__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyIngenix_Providers__ingenix_providers__autokey__zip}, '~prte::key::ingenix_providers::' + pIndexVersion + '::autokey::zip');
kKeyIngenix_Providers__ingenix_residency__providerid 			:= index(dKeyIngenix_Providers__ingenix_residency__providerid, {l_providerid}, {dKeyIngenix_Providers__ingenix_residency__providerid}, '~prte::key::ingenix_residency::' + pIndexVersion + '::providerid');

						return	sequential(
														parallel(
																build(kKeyIngenix_Providers__ingenix_providerid_upin__providerid 	, update),
																build(kKeyIngenix_Providers__ingenix_providers__autokey__address	, update),
																build(kKeyIngenix_Providers__ingenix_providers__autokey__citystname, update),
																build(kKeyIngenix_Providers__ingenix_providers__autokey__name , update),
																build(kKeyIngenix_Providers__ingenix_providers__autokey__payload, update),
																build(kKeyIngenix_Providers__ingenix_providers__autokey__phone2, update),
																build(kKeyIngenix_Providers__ingenix_providers__autokey__stname, update),
																build(kKeyIngenix_Providers__ingenix_providers__autokey__zip, update),
																build(kKeyIngenix_Providers__ingenix_residency__providerid, update)
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