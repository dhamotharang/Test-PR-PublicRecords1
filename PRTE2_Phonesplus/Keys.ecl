IMPORT	PRTE2_PhonesPlus, Phonesplus_v2, doxie, ut;

EXPORT Keys := MODULE

//--------------------------------------------------------------------------
//    Alpharetta_base_ds is managed by Alpharetta CT
//	Alpharetta_base_ds := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS;
//--------------------------------------------------------------------------	
//

	EXPORT key_phonesplus_did := index(Files.fphonesplus_did((unsigned)did<>0, (unsigned)cellphone<>0),
																		{unsigned6 l_did := did},{Files.fphonesplus_did},
																		Constants.KEY_PREFIX + 'phonesplusv2::' + doxie.Version_SuperKey + '::did');
																		
	EXPORT key_phonesplus_did_roy := index(dataset([],Phonesplus_v2.Layout_Phonesplus_Base),
																				{unsigned6 l_did := did},{dataset([],Phonesplus_v2.Layout_Phonesplus_Base)},
																				Constants.KEY_PREFIX + 'phonesplusv2_royalty::' + doxie.Version_SuperKey + '::did');

	EXPORT key_phonesplus_fdids := index(Files.dist_DSphonesplus_slim,{fdid},{Files.dist_DSphonesplus_slim},
																			Constants.KEY_PREFIX + 'phonesplusv2::' + doxie.Version_SuperKey + '::fdids');
												
	EXPORT key_phonesplus_fdids_roy := index(choosen(Files.dist_DSphonesplus_slim,ALL),{Files.dist_DSphonesplus_slim},
																						Constants.KEY_PREFIX + 'phonesplusv2_royalty::' + doxie.Version_SuperKey + '::fdids');
						
	EXPORT key_iverification_phone := index(Files.iverification(phone <> ''),{phone},{Files.iverification},
																					Constants.KEY_PREFIX + 'iverification::' + doxie.Version_SuperKey + '::phone');
												
	EXPORT key_iverification_did_phone := index(Files.iverification(did	!= 0),{did, phone},{Files.iverification},
																							Constants.KEY_PREFIX + 'iverification::' + doxie.Version_SuperKey + '::did_phone');

	EXPORT key_phonesplus_companyname := index(Files.DS_phonesplus(Company <> ''),{Company},{fdid},
																						Constants.KEY_PREFIX + 'phonesplusv2::' + doxie.Version_SuperKey + '::companyname');
																						
	EXPORT key_phonesplus_companyname_roy := index(dataset([], recordof(Files.dist_DSphonesplus_roy)),{Company},{fdid},
																								Constants.KEY_PREFIX + 'phonesplusv2_royalty::' + doxie.Version_SuperKey + '::companyname');

	EXPORT key_neustar_phone := index(Files.neustar(cellphone	!= ''),{cellphone},{cellphone},
																		Constants.KEY_PREFIX + 'neustar::' + doxie.Version_SuperKey + '::phone');

	EXPORT key_neustar_hist := index(Files.neustar_history(phone	!= ''),{phone},{Files.neustar_history} ,
																	Constants.KEY_PREFIX + 'neustar::' + doxie.Version_SuperKey + '::phone_history');

	EXPORT key_scoring_address := index(Files.scoring(trim(prim_name + prim_range, all) != '' and (unsigned)zip5 > 0),{prim_name, zip5, prim_range, sec_range,predir, addr_suffix},{Files.scoring},
																			Constants.KEY_PREFIX + 'phonesplus_scoring' + doxie.Version_SuperKey + '::address');												

	EXPORT key_scoring_phone := index(Files.scoring(cellphone	!= ''),{cellphone},{Files.scoring},
																		Constants.KEY_PREFIX + 'phonesplus_scoring' + doxie.Version_SuperKey + '::phone');
										 
END;
