export Proc_Build_Court_Locator_Lookup_Keys (string pIndexVersion) := function

import	_control, PRTE_CSV;
	
	
	rKeyCourt_locator_fips	:=
	record
		PRTE_CSV.CourtLocatorLookup.rthor_data400_key_courtlocatorlookup_fips;
	end;	
	


	dKeyCourt_locator_fips									:= 	project(PRTE_CSV.CourtLocatorLookup.dthor_data400_key_courtlocatorlookup_fips, rKeyCourt_locator_fips);	
	
	kKeyCourt_locator_fips									:=	index(dKeyCourt_locator_fips, {l_fips}, {dKeyCourt_locator_fips}, '~prte::key::courtlocatorlookup::' + pIndexVersion + '::fips');
	
	
	return	sequential(
											parallel(
																build(kKeyCourt_locator_fips	, update)
															 ),
											PRTE.UpdateVersion('CourtLocatorLookupKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
