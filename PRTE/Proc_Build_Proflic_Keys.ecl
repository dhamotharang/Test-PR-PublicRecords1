import	_control, PRTE_CSV;
export  Proc_Build_Proflic_Keys(string pIndexVersion)	:= function

 rKeyProlic__key__proflic__did	:=record
PRTE_CSV.Proflic.rthor_data400__key__proflic__did;
end;

dKeyProlic__key__proflic__did  := project(PRTE_CSV.Proflic.dthor_data400__key__proflic__did,rKeyProlic__key__proflic__did);
kKeyProlic__key__proflic__did := index(dKeyProlic__key__proflic__did, {s_did}, {dKeyProlic__key__proflic__did}, '~prte::key::proflic::'+pIndexVersion+'::did');
return	sequential(	build(kKeyProlic__key__proflic__did,  update),
   											PRTE.UpdateVersion('ProfLicKeys ',										//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																)
								);
								 

end;

