import	_control;

Export Proc_build_FDN_keys (string pIndexVersion)	:=

Function

			Prte_akey_address			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::address','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::address');
			Prte_akey_addressb2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::addressb2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::addressb2');
			Prte_akey_citystname			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::citystname','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::citystname');
			Prte_akey_citystnameb2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::citystnameb2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::citystnameb2');
			Prte_akey_fein2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::fein2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::fein2');
			Prte_akey_name			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::name','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::name');
			Prte_akey_nameb2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::nameb2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::nameb2');
			Prte_akey_namewords2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::namewords2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::namewords2');
			Prte_akey_payload			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::payload','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::payload');
			Prte_akey_phone2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::phone2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::phone2');
			Prte_akey_phoneb2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::phoneb2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::phoneb2');
			Prte_akey_ssn2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::ssn2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::ssn2');
			Prte_akey_stname			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::stname','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::stname');
			Prte_akey_stnameb2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::stnameb2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::stnameb2');
			Prte_akey_zip			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::zip','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::zip');
			Prte_akey_zipb2			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::autokey::zipb2','thor400_44','~prte::key::fdn::' + pIndexVersion + '::autokey::zipb2');			
			Prte_key_bdid			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::bdid','thor400_44','~prte::key::fdn::' + pIndexVersion + '::bdid');
			Prte_key_deviceid			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::deviceid','thor400_44','~prte::key::fdn::' + pIndexVersion + '::deviceid');
			Prte_key_did			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::did','thor400_44','~prte::key::fdn::' + pIndexVersion + '::did');
			Prte_key_email			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::email','thor400_44','~prte::key::fdn::' + pIndexVersion + '::email');
			Prte_key_id			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::id','thor400_44','~prte::key::fdn::' + pIndexVersion + '::id');
			Prte_key_ip			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::ip','thor400_44','~prte::key::fdn::' + pIndexVersion + '::ip');
			Prte_key_linkids			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::linkids','thor400_44','~prte::key::fdn::' + pIndexVersion + '::linkids');
			Prte_key_mbs			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::mbs','thor400_44','~prte::key::fdn::' + pIndexVersion + '::mbs');
			Prte_key_mbsindtypeexclusion			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::mbsindtypeexclusion','thor400_44','~prte::key::fdn::' + pIndexVersion + '::mbsindtypeexclusion');
			Prte_key_mbsproductinclude			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::mbsproductinclude','thor400_44','~prte::key::fdn::' + pIndexVersion + '::mbsproductinclude');
			Prte_key_mbsfdnmasterID			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::gcid_2_mbsfdnmasterid','thor400_44','~prte::key::fdn::' + pIndexVersion + '::gcid_2_mbsfdnmasterid');
			Prte_key_mbsfdnmasterIDExcl			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::mbsfdnmasteridexclusion','thor400_44','~prte::key::fdn::' + pIndexVersion + '::mbsfdnmasteridexclusion');
			Prte_key_lnpid            			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::lnpid','thor400_44','~prte::key::fdn::' + pIndexVersion + '::lnpid');
			Prte_key_appproviderid   			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::appproviderid','thor400_44','~prte::key::fdn::' + pIndexVersion + '::appproviderid');
			Prte_key_npi        			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::npi','thor400_44','~prte::key::fdn::' + pIndexVersion + '::npi');
			Prte_key_professionalid			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::professionalid','thor400_44','~prte::key::fdn::' + pIndexVersion + '::professionalid');
			Prte_key_tin      			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::tin','thor400_44','~prte::key::fdn::' + pIndexVersion + '::tin');
			Prte_key_BankAccount			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::bankaccount','thor400_44','~prte::key::fdn::' + pIndexVersion + '::bankaccount');
			Prte_key_driverslicense 			:= 	fileservices.copy('~foreign::10.241.12.201::thor_data400::key::fdn::qa::driverslicense','thor400_44','~prte::key::fdn::' + pIndexVersion + '::driverslicense');


	return	sequential(
											parallel( Prte_akey_address,
																Prte_akey_addressb2,
																Prte_akey_citystname,
																Prte_akey_citystnameb2,
																Prte_akey_fein2,
																Prte_akey_name,
																Prte_akey_nameb2,
																Prte_akey_namewords2,
																Prte_akey_payload,
																Prte_akey_phone2,
																Prte_akey_phoneb2,
																Prte_akey_ssn2,
																Prte_akey_stname,
																Prte_akey_stnameb2,
																Prte_akey_zip,
																Prte_akey_zipb2,
																Prte_key_bdid,
																Prte_key_deviceid,
																Prte_key_did,
																Prte_key_email,
																Prte_key_id,
																Prte_key_ip,
																Prte_key_linkids,
																Prte_key_mbs,
																Prte_key_mbsindtypeexclusion,
																Prte_key_mbsproductinclude,
																Prte_key_mbsfdnmasterID,
																Prte_key_mbsfdnmasterIDExcl,
																Prte_key_lnpid,
																Prte_key_appproviderid,
																Prte_key_npi,
																Prte_key_professionalid,
																Prte_key_tin,																
																Prte_key_BankAccount,
																Prte_key_driverslicense),
                              PRTE.UpdateVersion('FDNKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not include boolean, Y = Include boolean, too
																				)
										 );

end;
