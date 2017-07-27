import doxie_files,ams,Ingenix_NatlProf,AutoStandardI,didville,BatchServices,Business_Header_SS,ut,dea,doxie;
EXPORT Provider_Records_SearchKeys := module
	shared myConst := Healthcare_Provider_Services.Constants;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	shared myFn := Healthcare_Provider_Services.Provider_Records_Functions;
	shared myFnAms := Healthcare_Provider_Services.Provider_Records_Functions_Ams;
	shared myFnIng := Healthcare_Provider_Services.Provider_Records_Functions_Ing;
	shared src_ING := Healthcare_Provider_Services.Provider_Records_ING;
	shared src_AMS := Healthcare_Provider_Services.Provider_Records_AMS;
	shared src_Sanc := Healthcare_Provider_Services.Provider_Records_Sanc;
	shared src_DEA := Healthcare_Provider_Services.Provider_Records_DEA;
	shared src_NPPES := Healthcare_Provider_Services.Provider_Records_NPPES;
	shared src_ProfLic := Healthcare_Provider_Services.Provider_Records_ProfLic;
	shared src_BocaHeader := Healthcare_Provider_Services.Provider_Records_Boca_Header;
	shared src_BocaBusHeader := Healthcare_Provider_Services.Provider_Records_Boca_Bus_Header;

	Export get_ing_recs_License (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.license_number=right.LicenseNumber
																				 and if(left.license_state <> '',left.License_State=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License1 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense1Verification=right.LicenseNumber 
																				 and if(left.StateLicense1StateVerification <> '',left.StateLicense1StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License2 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense2Verification=right.LicenseNumber 
																				 and if(left.StateLicense2StateVerification <> '',left.StateLicense2StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License3 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense3Verification=right.LicenseNumber 
																				 and if(left.StateLicense3StateVerification <> '',left.StateLicense3StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License4 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense4Verification=right.LicenseNumber 
																				 and if(left.StateLicense4StateVerification <> '',left.StateLicense4StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License5 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense5Verification=right.LicenseNumber 
																				 and if(left.StateLicense5StateVerification <> '',left.StateLicense5StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License6 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense6Verification=right.LicenseNumber 
																				 and if(left.StateLicense6StateVerification <> '',left.StateLicense6StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License7 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense7Verification=right.LicenseNumber 
																				 and if(left.StateLicense7StateVerification <> '',left.StateLicense7StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License8 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense8Verification=right.LicenseNumber 
																				 and if(left.StateLicense8StateVerification <> '',left.StateLicense8StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License9 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense9Verification=right.LicenseNumber 
																				 and if(left.StateLicense9StateVerification <> '',left.StateLicense9StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_recs_License10 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, doxie_files.key_provider_license,
																				 left.StateLicense10Verification=right.LicenseNumber 
																				 and if(left.StateLicense10StateVerification <> '',left.StateLicense10StateVerification=right.LicenseState,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=right.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.license_number=right.st_lic_num) 
																				 and if(left.license_state <> '',left.license_state=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License1 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense1Verification=right.st_lic_num) 
																				 and if(left.StateLicense1StateVerification <> '',left.StateLicense1StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License2 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense2Verification=right.st_lic_num) 
																				 and if(left.StateLicense2StateVerification <> '',left.StateLicense2StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License3 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense3Verification=right.st_lic_num) 
																				 and if(left.StateLicense3StateVerification <> '',left.StateLicense3StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License4 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense4Verification=right.st_lic_num) 
																				 and if(left.StateLicense4StateVerification <> '',left.StateLicense4StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License5 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense5Verification=right.st_lic_num) 
																				 and if(left.StateLicense5StateVerification <> '',left.StateLicense5StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License6 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense6Verification=right.st_lic_num) 
																				 and if(left.StateLicense6StateVerification <> '',left.StateLicense6StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License7 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense7Verification=right.st_lic_num) 
																				 and if(left.StateLicense7StateVerification <> '',left.StateLicense7StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License8 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense8Verification=right.st_lic_num) 
																				 and if(left.StateLicense8StateVerification <> '',left.StateLicense8StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License9 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense9Verification=right.st_lic_num) 
																				 and if(left.StateLicense9StateVerification <> '',left.StateLicense9StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ams_recs_License10 (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input,ams.keys().main.LicenseNumberState.qa,
																				 keyed(left.StateLicense10Verification=right.st_lic_num) 
																				 and if(left.StateLicense10StateVerification <> '',left.StateLicense10StateVerification=right.st_lic_state,true),
																				 transform(myLayouts.searchKeyResults,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ing_by_fein (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, doxie_files.key_provider_taxid,
										 keyed(left.fein = right.l_taxid),
										 transform(myLayouts.searchKeyResults, self.prov_id := right.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
										 keep(myConst.MAX_TAXID_RECS),limit(0)),record),record);
	end;
	Export get_ing_by_taxid (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, doxie_files.key_provider_taxid,
										 keyed(left.taxid = right.l_taxid),
										 transform(myLayouts.searchKeyResults, self.prov_id := right.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
										 keep(myConst.MAX_TAXID_RECS),limit(0)),record),record);
	end;
	Export get_ams_by_fein (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, ams.keys().main.taxid.qa,
										 keyed(left.fein = right.tax_id),
										 transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.ams_id;self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
										 keep(myConst.MAX_TAXID_RECS),limit(0)),record),record);
	end;
	Export get_ams_by_taxid (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, ams.keys().main.taxid.qa,
										 keyed(left.taxid = right.tax_id),
										 transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.ams_id;self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
										 keep(myConst.MAX_TAXID_RECS),limit(0)),record),record);
	end;
	Export get_ing_by_upin (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, Ingenix_NatlProf.key_ProviderID_UPIN,
											keyed(left.upin = right.l_upin), 
											transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
											keep(myConst.MAX_UPIN_RECS),limit(0)),record),record);
	end;
	Export get_ing_by_npi (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, Ingenix_NatlProf.key_providerID_NPI,
											keyed(left.npi = right.l_npi), 
											transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
											keep(myConst.MAX_NPI_RECS),limit(0)),record),record);
	end;
	Export get_ams_by_npi (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, ams.keys().main.npi.qa,
											keyed(left.npi = right.npi), 
											transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.ams_id;self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
											keep(myConst.MAX_NPI_RECS),limit(0)),record),record);
	end;
	Export get_ing_by_dea (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, Ingenix_NatlProf.key_DEA_DEANumber,
											keyed(left.dea = right.l_deanumber),
											transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
											keep(myConst.MAX_DEA_RECS),limit(0)),record),record);
	end;
	Export get_ing_by_dea2 (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, Ingenix_NatlProf.key_DEA_DEANumber,
											keyed(left.dea2 = right.l_deanumber),
											transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
											keep(myConst.MAX_DEA_RECS),limit(0)),record),record);
	end;
	Export get_ams_by_dea (dataset(myLayouts.autokeyInput) input):= function
			return dataset([],myLayouts.searchKeyResults);
			// return dedup(sort(join(input, ams.keys().IDNumber.AMSID.qa,
											// keyed(left.dea = right.rawfields.indy_id)
											// and right.src_cd_desc = 'DEA',
											// transform(myLayouts.searchKeyResults, self.prov_id := right.ams_id;self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
											// keep(myConst.MAX_DEA_RECS),limit(0)),record),record);
	end;
	Export get_ing_by_dids (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, doxie_files.key_provider_did,
											keyed(left.did = right.l_did), 
											transform(myLayouts.searchKeyResults, self.prov_id := right.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING),
											keep(myConst.MAX_DID_RECS),limit(0)),record),record);
	end;
	Export get_ing_by_Doxie_dids (dataset(doxie.layout_references) input):= function
			return dedup(sort(join(input, doxie_files.key_provider_did,
											keyed(left.did = right.l_did), 
											transform(myLayouts.searchKeyResults, self.prov_id := right.providerid;self.acctno:='1';self.src:=myConst.SRC_ING),
											keep(myConst.MAX_DID_RECS),limit(0)),record),record);
	end;
	Export get_ams_by_dids (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, ams.keys().main.did.qa,
											keyed(left.did = right.did), 
											transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.ams_id;self.acctno:=left.acctno;self.src:=myConst.SRC_AMS),
											keep(myConst.MAX_DID_RECS),limit(0)),record),record);
	end;
	Export get_ams_by_Doxie_dids (dataset(doxie.layout_references) input):= function
			return dedup(sort(join(input, ams.keys().main.did.qa,
											keyed(left.did = right.did), 
											transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.ams_id;self.acctno:='1';self.src:=myConst.SRC_AMS),
											keep(myConst.MAX_DID_RECS),limit(0)),record),record);
	end;
	Export get_sanc_by_dids (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(join(input, doxie_files.key_Sanctions_did,
											keyed(left.did = right.l_did), 
											transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.SANC_ID;self.acctno:=left.acctno;self.src:=myConst.SRC_SANC),
											keep(myConst.MAX_DID_RECS),limit(0)),record),record);
	end;
	Export get_sanc_by_Doxie_dids (dataset(doxie.layout_references) input):= function
			return dedup(sort(join(input, doxie_files.key_Sanctions_did,
											keyed(left.did = right.l_did), 
											transform(myLayouts.searchKeyResults, self.prov_id := (unsigned6)right.SANC_ID;self.acctno:='1';self.src:=myConst.SRC_SANC),
											keep(myConst.MAX_DID_RECS),limit(0)),record),record);
	end;
	//Key not Ready yet......
	// Export get_sanc_by_BusName (dataset(myLayouts.autokeyInput) input):= function
			// return dedup(sort(join(input, Ingenix_NatlProf.key_Sanctions_busnme,
											// keyed(left.comp_name = right.SANC_BUSNME), 
											// transform(myLayouts.searchKeyResults, self.prov_id := right.SANC_ID;self.acctno:=left.acctno;self.src:=myConst.SRC_SANC),
											// keep(myConst.MAX_AUTOKEY_SEARCH_RECS),limit(0)),record),record);
	// end;
	Export myLayouts.searchKeyResults_plus_input xformAutoKeys(myLayouts.searchKeyResults l,myLayouts.autokeyInput r) := transform
		self:=l;
		self:=r;
	end;

	Export myLayouts.searchKeyResults xformLimit(myLayouts.searchKeyResults_plus_input l, integer cnt) := transform
		limitNameOnlyAutoKeySearch := (l.name_last <> '' or l.comp_name <> '') and l.prim_name='' and l.p_city_name='' and l.st ='' and l.z5 = '';
		limitAddressOnlyAutoKeySearch := (l.name_last = '' and l.comp_name = '');
		cntLimit := if(limitNameOnlyAutoKeySearch or limitAddressOnlyAutoKeySearch,myConst.MAX_NAMEONLY_AUTOKEY_SEARCH_RECS,myConst.MAX_AUTOKEY_SEARCH_RECS);
		self.acctno:=if(cnt>cntLimit, skip, l.acctno);
		self:=l;
	end;

	Export get_ing_by_ak (dataset(myLayouts.autokeyInput) input):= function
			results:=dedup(sort(project(AutoKey_for_Batch(input).ing_autokeys,transform(myLayouts.searchKeyResults, self.prov_id:=(unsigned6)left.providerid; self.acctno:=left.acctno;self.src:=myConst.SRC_ING;self.isAutokeysResult:=true)),record),record);
			results_w_input:=join(results,input,left.acctno=right.acctno,xformAutoKeys(left,right));
			return ungroup(project(group(results_w_input,acctno),xformLimit(left,counter)));
	end;
	Export get_ams_by_ak (dataset(myLayouts.autokeyInput) input):= function
			results:=dedup(sort(project(AutoKey_for_Batch(input).ams_autokeys,transform(myLayouts.searchKeyResults, self.prov_id:=(unsigned6)left.ams_id; self.acctno:=left.acctno;self.src:=myConst.SRC_AMS;self.isAutokeysResult:=true)),record),record);
			results_w_input:=join(results,input,left.acctno=right.acctno,xformAutoKeys(left,right));
			return ungroup(project(group(results_w_input,acctno),xformLimit(left,counter)));
	end;
	Export get_sanc_by_ak (dataset(myLayouts.autokeyInput) input):= function
			results:=dedup(sort(project(AutoKey_for_Batch(input).sanc_autokeys,transform(myLayouts.searchKeyResults, self.prov_id:=(unsigned6)left.sanc_id; self.acctno:=left.acctno;self.src:=myConst.SRC_SANC;self.isAutokeysResult:=true)),record),record);
			sanc_byDid := join(input, doxie_files.key_sanctions_did, keyed(left.did = right.l_did), transform(myLayouts.searchKeyResults, self.acctno:=left.acctno;self.prov_id:=(unsigned6)right.sanc_id;self.src:=myConst.SRC_SANC;self.isAutokeysResult:=true), keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			sanc_byUpin := join(input, doxie_files.key_upin_sancid, keyed(left.upin = right.l_upin),transform(myLayouts.searchKeyResults, self.acctno:=left.acctno;self.prov_id:=(unsigned6)right.sanc_id;self.src:=myConst.SRC_SANC;self.isAutokeysResult:=true),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			sanc_byStLic := join(input, doxie_files.key_license_sancid, (left.license_state = right.SANC_SANCST or left.license_state = '') and left.license_number = right.SANC_LICNBR,transform(myLayouts.searchKeyResults, self.acctno:=left.acctno;self.prov_id:=(unsigned6)right.sanc_id;self.src:=myConst.SRC_SANC;self.isAutokeysResult:=true),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			sanc_byfein := join(input, doxie_files.key_sanctions_tin, keyed((string)INTFORMAT((integer)left.fein,9,1) = right.s_SANC_tin),transform(myLayouts.searchKeyResults, self.acctno:=left.acctno;self.prov_id:=(unsigned6)right.sanc_id;self.src:=myConst.SRC_SANC;self.isAutokeysResult:=true),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			results_final:=dedup(results+sanc_byDid+sanc_byUpin+sanc_byStLic+sanc_byfein,all);
			results_w_input:=join(results_final,input,left.acctno=right.acctno,xformAutoKeys(left,right));
			return ungroup(project(group(results_w_input,acctno),xformLimit(left,counter)));
	end;
	Export getDeepDivePids (dataset(myLayouts.autokeyInput) input):= function
		//Deep Dive Logic
		fmtInputToDidville := project(input,myTransforms.convertToDidvilleBatch(left,false));
		hdrRecs := didville.did_service_common_function(fmtInputToDidville, 'BEST_ALL', 'BEST_ALL', 'ALL', true, 0, false, false, false, 
																								false, false, false, 8,false,,TRUE, '', 0);
		results := join(input,hdrRecs, (integer)left.acctno=right.seq,
										transform(myLayouts.searchKeyResults, self.prov_id:=right.did; self.acctno:=left.acctno;self.src:=myConst.SRC_BOCA_PERSON_HEADER;self.isAutokeysResult:=true),
										keep(myConst.MAX_RECS_ON_JOIN),limit(0)); 
		return results;
	end;
	Export getBusDeepDivePids (dataset(myLayouts.autokeyInput) input):= function
		//Bus Deep Dive Logic
		convertedInput := project(input,myTransforms.convertToBusinessLookup(left));
		Business_Header_SS.MAC_BDID_Append(convertedInput,busRecs,1,,,true);
		results := join(input,busRecs, left.acctno=(string)right.seq,
										transform(myLayouts.searchKeyResults, self.prov_id:=right.bdid; self.acctno:=left.acctno;self.src:=myConst.SRC_BOCA_BUS_HEADER;self.isAutokeysResult:=true),
										keep(myConst.MAX_RECS_ON_JOIN),limit(0)); 
		return results;
	end;
	//Take the search criteria and resolve to an entity set
	Export getRecordsPIDs (dataset(myLayouts.autokeyInput) input) := function
		BusinessRecords := input(comp_name <> '' and z5 <>'' and isReport=false);
		IndividualRecords := join(input,BusinessRecords,left.acctno = right.acctno,transform(myLayouts.autokeyInput,self:=left;),left only);
		ing_recs_License := get_ing_recs_License(input(license_number<>''));
		ing_recs_License1 := get_ing_recs_License(input(StateLicense1Verification<>''));
		ing_recs_License2 := get_ing_recs_License(input(StateLicense2Verification<>''));
		ing_recs_License3 := get_ing_recs_License(input(StateLicense3Verification<>''));
		ing_recs_License4 := get_ing_recs_License(input(StateLicense4Verification<>''));
		ing_recs_License5 := get_ing_recs_License(input(StateLicense5Verification<>''));
		ing_recs_License6 := get_ing_recs_License(input(StateLicense6Verification<>''));
		ing_recs_License7 := get_ing_recs_License(input(StateLicense7Verification<>''));
		ing_recs_License8 := get_ing_recs_License(input(StateLicense8Verification<>''));
		ing_recs_License9 := get_ing_recs_License(input(StateLicense9Verification<>''));
		ing_recs_License10 := get_ing_recs_License(input(StateLicense10Verification<>''));
		ams_recs_License := get_ams_recs_License(input(license_number<>''));
		ams_recs_License1 := get_ams_recs_License(input(StateLicense1Verification<>''));
		ams_recs_License2 := get_ams_recs_License(input(StateLicense2Verification<>''));
		ams_recs_License3 := get_ams_recs_License(input(StateLicense3Verification<>''));
		ams_recs_License4 := get_ams_recs_License(input(StateLicense4Verification<>''));
		ams_recs_License5 := get_ams_recs_License(input(StateLicense5Verification<>''));
		ams_recs_License6 := get_ams_recs_License(input(StateLicense6Verification<>''));
		ams_recs_License7 := get_ams_recs_License(input(StateLicense7Verification<>''));
		ams_recs_License8 := get_ams_recs_License(input(StateLicense8Verification<>''));
		ams_recs_License9 := get_ams_recs_License(input(StateLicense9Verification<>''));
		ams_recs_License10 := get_ams_recs_License(input(StateLicense10Verification<>''));
		ing_by_fein := get_ing_by_fein(input(fein<>''));
		ing_by_taxid := get_ing_by_taxid(input(taxid<>''));
		ams_by_fein := get_ams_by_fein(input(fein<>''));
		ams_by_taxid := get_ams_by_taxid(input(taxid<>''));
		ing_by_upin := get_ing_by_upin(input(Upin<>''));
		ing_by_npi := get_ing_by_npi(input(NPI<>''));
		ams_by_npi := get_ams_by_npi(input(NPI<>''));
		ing_by_dea := get_ing_by_dea(input(dea<>''));
		ing_by_dea2 := get_ing_by_dea2(input(dea2<>''));
		// ams_by_dea := get_ams_by_dea(input(dea<>''));
		ing_by_dids := get_ing_by_dids(IndividualRecords(did>0));
		ams_by_dids := get_ams_by_dids(IndividualRecords(did>0));
		sanc_by_dids := get_sanc_by_dids(IndividualRecords(did>0));
		user_ing_providerID := Project(input(providerid>0,providerSrc=myConst.SRC_ING),transform(myLayouts.searchKeyResults,self.prov_id := left.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING;self.isautokeysresult:=left.derivedinputrecord));
		user_defaultproviderID := Project(input(providerid>0,providerSrc=''),transform(myLayouts.searchKeyResults,self.prov_id := left.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING;self.isautokeysresult:=left.derivedinputrecord));
		user_ams_providerID := Project(input(providerid>0,providerSrc=myConst.SRC_AMS),transform(myLayouts.searchKeyResults,self.prov_id := left.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_AMS;self.isautokeysresult:=left.derivedinputrecord));
		user_sanc_providerID := Project(input(providerid>0,providerSrc=myConst.SRC_SANC),transform(myLayouts.searchKeyResults,self.prov_id := left.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_SANC;self.isautokeysresult:=left.derivedinputrecord));
		all_pids_pre:= dedup(sort(user_ing_providerID(isautokeysresult=false)+user_defaultproviderID(isautokeysresult=false)+ing_recs_License+ing_recs_License1+ing_recs_License2+ing_recs_License3+ing_recs_License4+ing_recs_License5+ing_recs_License6+ing_recs_License7+ing_recs_License8+ing_recs_License9+ing_recs_License10+ing_by_fein+ing_by_taxid+ing_by_upin+ing_by_npi+ing_by_dea+ing_by_dea2+ing_by_dids,record),record);
		ams_pids_pre:= dedup(sort(user_ams_providerID(isautokeysresult=false)+ams_recs_License+ams_recs_License1+ams_recs_License2+ams_recs_License3+ams_recs_License4+ams_recs_License5+ams_recs_License6+ams_recs_License7+ams_recs_License8+ams_recs_License9+ams_recs_License10+ams_by_fein+ams_by_taxid+ams_by_npi+ams_by_dids,record),record);
		sanc_pids_pre:= dedup(sort(user_sanc_providerID(isautokeysresult=false)+sanc_by_dids,record),record);
		getNoHitsForAK := join(input,all_pids_pre+ams_pids_pre+sanc_pids_pre,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);
		//Remove bad input records before sending to autokeys
		removeBadRecs := Project(getNoHitsForAK, transform(myLayouts.autokeyInput,
																		bad:=length(trim(left.name_first,all))>0 and length(trim(left.name_last,all))=0;
																		self.name_last := if(bad,skip,left.name_last);
																		self := left;));
		//Skip Name only matches for Sanctions.
		removeBadRecsSanc := Project(removeBadRecs, transform(myLayouts.autokeyInput,
																		noAddress:=left.prim_name='' and left.p_city_name='' and left.st ='' and left.z5 = '';;
																		self.name_last := if(noAddress,skip,left.name_last);
																		self := left;));

		prov_ids_byak := get_ing_by_ak(removeBadRecs);
		ams_ids_byak := get_ams_by_ak(removeBadRecs);
		sanc_ids_byak := get_sanc_by_ak(removeBadRecsSanc);
		getNoHitsForDeepDive := join(getNoHitsForAK,prov_ids_byak+ams_ids_byak+sanc_ids_byak,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);
		get_deepdive := if(exists(getNoHitsForDeepDive(doDeepDive = true)),getDeepDivePids(getNoHitsForDeepDive));
		get_BusDeepdive := if(exists(BusinessRecords(doDeepDive = true)),getBusDeepDivePids(BusinessRecords));
		skipAutokeys := (exists(all_pids_pre) or exists(ams_pids_pre) or exists(sanc_pids_pre)) and input[1].isReport;
		//Combine search results
		all_pids:= if(skipAutokeys,all_pids_pre,all_pids_pre+prov_ids_byak+user_ing_providerID(isautokeysresult=true)+user_defaultproviderID(isautokeysresult=true));//dedup(sort(user_ing_providerID+prov_ids_byak+ing_recs_License+ing_by_fein+ing_by_taxid+ing_by_upin+ing_by_npi+ing_by_dea+ing_by_dids,record),record);
		ams_pids:= if(skipAutokeys,ams_pids_pre,ams_pids_pre+ams_ids_byak+user_ams_providerID(isautokeysresult=true));//dedup(sort(user_ams_providerID+ams_ids_byak+ams_recs_License+ams_by_fein+ams_by_taxid+ams_by_npi+ams_by_dids,record),record);
		sanc_pids:= if(skipAutokeys,sanc_pids_pre,sanc_pids_pre+sanc_ids_byak+user_sanc_providerID(isautokeysresult=true));//dedup(sort(user_ams_providerID+ams_ids_byak+ams_recs_License+ams_by_fein+ams_by_taxid+ams_by_npi+ams_by_dids,record),record);
		consolidatedPids:=dedup(all_pids+ams_pids+sanc_pids,all);
		//Only call Deep dive if we found nothing else, we only have a single row of input, and the flag is turned on.
		final := if(count(consolidatedPids)=0,get_deepdive+get_BusDeepdive,consolidatedPids+get_BusDeepdive);
		// output(all_pids_pre,named('all_pids_pre'),overwrite);
		// output(ams_pids_pre,named('ams_pids_pre'),overwrite);
		// output(sanc_pids_pre,named('sanc_pids_pre'),overwrite);
		// output(getNoHitsForAK,named('getNoHitsForAK'),overwrite);
		// output(prov_ids_byak,named('prov_ids_byak'),overwrite);
		// output(ams_ids_byak,named('ams_ids_byak'),overwrite);
		// output(sanc_ids_byak,named('sanc_ids_byak'),overwrite);
		// output(getNoHitsForDeepDive,named('getNoHitsForDeepDive'),overwrite);
		// output(get_deepdive,named('get_deepdive'),overwrite);
		// output(get_BusDeepdive,named('get_BusDeepdive'),overwrite);
		return final;
	end;
	Export getRecordsPIDsByDid (dataset(doxie.layout_references) input) := function
		ing_by_dids := get_ing_by_Doxie_dids(input(did>0));
		ams_by_dids := get_ams_by_Doxie_dids(input(did>0));
		sanc_by_dids := get_sanc_by_Doxie_dids(input(did>0));
		all_pids_by_did:= dedup(sort(ing_by_dids+ams_by_dids+sanc_by_dids,record),record);
		return all_pids_by_did;
	end;
	Export mergeRecords(dataset(myLayouts.CombinedHeaderResults) ing_providers_final, 
											dataset(myLayouts.CombinedHeaderResults) ams_providers_final,
											dataset(myLayouts.CombinedHeaderResults) sanc_providers_base,
											dataset(mylayouts.searchKeyResults_plus_input) Ing_with_Input,
											dataset(mylayouts.searchKeyResults_plus_input) all_ams_pids,
											dataset(myLayouts.autokeyInput) input,
											UNSIGNED1 maxPenalty) := function
		//Rollup data within each datasource
		ing_providers_final_sorted := sort(ing_providers_final, acctno, HcId, SrcId, Src);
		ing_providers_final_grouped := group(ing_providers_final_sorted, acctno, HcId, SrcId, Src);
		ing_providers_rolled := rollup(ing_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));			

		//Rollup data within each datasource
		ams_providers_final_sorted := sort(ams_providers_final, acctno, HcId, SrcId, Src);
		ams_providers_final_grouped := group(ams_providers_final_sorted, acctno, HcId, SrcId, Src);
		ams_providers_rolled := rollup(ams_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));	

		//Rollup data within each datasource
		sanc_providers_final_sorted := sort(sanc_providers_base, acctno, HcId, SrcId, Src);
		sanc_providers_final_grouped :=	group(sanc_providers_final_sorted, acctno, HcId, SrcId, Src);
		sanc_providers_rolled := rollup(sanc_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));

		//Custom Merge logic for Ingenix and AMS
		custom_matching_logic:= Provider_Records_Matching.buildMatchTable(Ing_with_Input,all_ams_pids);
		//set the HCID for ING records with ing matches
		filterCustomMatchING := dedup(custom_matching_logic(ingkey <> '' and matchID <> ''),acctno,ingkey);
		ing_providers_w_hcid := myFnING.doCustomMatchIng(ing_providers_rolled,filterCustomMatchING);
		ing_providers_w_hcid_final := project(ing_providers_w_hcid,transform(myLayouts.CombinedHeaderResults, 
																							self.hcid := if(left.hcid=0,left.srcid,left.hcid);self:=left));

		//set the HCID for AMS records with ing matches
		filterCustomMatchAMS := dedup(sort(custom_matching_logic(amskey <> '' and ingkey <> ''),acctno,amskey,(integer)ingkey),acctno,amskey);
		ams_providers_w_hcid := myFnAMS.doCustomMatchAMS(ams_providers_rolled,filterCustomMatchAMS);
		ams_providers_w_hcid_final := project(ams_providers_w_hcid,transform(myLayouts.CombinedHeaderResults, 
																							self.hcid := if(left.hcid=0,left.srcid,left.hcid);self:=left));
		//Combine the two primary search sources and then use other data if none exists
		combined_ing_ams := ing_providers_w_hcid_final + ams_providers_w_hcid_final;

		//Roll up the sources by HCID
		combined_final_sorted := sort(combined_ing_ams, acctno, HCID, map(src='I'=>1,src='A'=>2,3));
		combined_final_grouped := group(combined_final_sorted, acctno, HCID);
		results_rollup := rollup(combined_final_grouped(HCID > 0), group, myTransforms.doFinalRollup(left,rows(left)));
		//Return AMS ID numbers as providerid's if HCID has nothing else and assigning record level penalty
		results_combined_rolled := myFn.doPenalty(results_rollup,input,maxPenalty);
		hits := if(exists(results_combined_rolled),results_combined_rolled,sanc_providers_rolled);
		return hits;
	end;
	Export getRecordsPIDsByAK (dataset(myLayouts.autokeyInput) input,UNSIGNED1 maxPenalty) := function
		//Remove bad input records before sending to autokeys
		removeBadRecs := Project(input, transform(myLayouts.autokeyInput,
																		bad:=length(trim(left.name_first,all))>0 and length(trim(left.name_last,all))=0;
																		self.name_last := if(bad or left.isReport,skip,left.name_last);
																		self := left;));
		//Skip Name only matches for Sanctions.
		removeBadRecsSanc := Project(removeBadRecs, transform(myLayouts.autokeyInput,
																		noAddress:=left.prim_name='' and left.p_city_name='' and left.st ='' and left.z5 = '';;
																		self.name_last := if(noAddress,skip,left.name_last);
																		self := left;));
		
		prov_ids_byak := get_ing_by_ak(removeBadRecs);
		Ing_with_Input := myFn.appendInputToSearchKeyData(prov_ids_byak,input);
		ing_providers_final := src_ING.get_ing_entity(Ing_with_Input,maxPenalty);
		ams_ids_byak := get_ams_by_ak(removeBadRecs);
		ams_with_Input := myFn.appendInputToSearchKeyData(ams_ids_byak,input);
		ams_providers_final := src_AMS.get_ams_entity(ams_with_Input,maxPenalty);
		sanc_ids_byak := get_sanc_by_ak(removeBadRecsSanc);
		sanc_with_Input := myFn.appendInputToSearchKeyData(sanc_ids_byak,input);
		sanc_providers_final := src_Sanc.get_sanc_providers_base(sanc_with_Input,maxPenalty);
		akHits := mergeRecords(ing_providers_final,ams_providers_final,sanc_providers_final,Ing_with_Input,ams_with_Input,input,maxPenalty);
		return akHits;
	end;
	Export getRecordsByDid (dataset(doxie.layout_references) input,UNSIGNED1 maxPenalty) := function
		getPids_with_input := project(getRecordsPIDsByDid(input),transform(mylayouts.searchKeyResults_plus_input,self.acctno:='1';self:=left;));
		ing_providers_final := src_ING.get_ing_entity(getPids_with_input(src=myConst.SRC_ING),maxPenalty);
		ams_providers_final := src_AMS.get_ams_entity(getPids_with_input(src=myConst.SRC_AMS),maxPenalty);
		sanc_providers_final := src_Sanc.get_sanc_providers_base(getPids_with_input(src=myConst.SRC_SANC),maxPenalty);
		didHits := mergeRecords(ing_providers_final,ams_providers_final,sanc_providers_final,getPids_with_input(src=myConst.SRC_ING),getPids_with_input(src=myConst.SRC_AMS),project(input,transform(myLayouts.autokeyInput,self.acctno:='1';self.did:=left.did)),maxPenalty);
		return didHits;
	end;

	Export getRecords (dataset(myLayouts.autokeyInput) input,UNSIGNED1 maxPenalty) := function
		BusinessRecords := input(comp_name <> '' and z5 <>'' and derivedInputRecord=false);
		IndividualRecords := join(input,BusinessRecords,left.acctno = right.acctno,transform(myLayouts.autokeyInput,self:=left;),left only);
		ing_recs_License := get_ing_recs_License(input(license_number<>''));
		ing_recs_License1 := get_ing_recs_License(input(StateLicense1Verification<>''));
		ing_recs_License2 := get_ing_recs_License(input(StateLicense2Verification<>''));
		ing_recs_License3 := get_ing_recs_License(input(StateLicense3Verification<>''));
		ing_recs_License4 := get_ing_recs_License(input(StateLicense4Verification<>''));
		ing_recs_License5 := get_ing_recs_License(input(StateLicense5Verification<>''));
		ing_recs_License6 := get_ing_recs_License(input(StateLicense6Verification<>''));
		ing_recs_License7 := get_ing_recs_License(input(StateLicense7Verification<>''));
		ing_recs_License8 := get_ing_recs_License(input(StateLicense8Verification<>''));
		ing_recs_License9 := get_ing_recs_License(input(StateLicense9Verification<>''));
		ing_recs_License10 := get_ing_recs_License(input(StateLicense10Verification<>''));
		ams_recs_License := get_ams_recs_License(input(license_number<>''));
		ams_recs_License1 := get_ams_recs_License(input(StateLicense1Verification<>''));
		ams_recs_License2 := get_ams_recs_License(input(StateLicense2Verification<>''));
		ams_recs_License3 := get_ams_recs_License(input(StateLicense3Verification<>''));
		ams_recs_License4 := get_ams_recs_License(input(StateLicense4Verification<>''));
		ams_recs_License5 := get_ams_recs_License(input(StateLicense5Verification<>''));
		ams_recs_License6 := get_ams_recs_License(input(StateLicense6Verification<>''));
		ams_recs_License7 := get_ams_recs_License(input(StateLicense7Verification<>''));
		ams_recs_License8 := get_ams_recs_License(input(StateLicense8Verification<>''));
		ams_recs_License9 := get_ams_recs_License(input(StateLicense9Verification<>''));
		ams_recs_License10 := get_ams_recs_License(input(StateLicense10Verification<>''));
		ing_by_fein := get_ing_by_fein(input(fein<>''));
		ing_by_taxid := get_ing_by_taxid(input(taxid<>''));
		ams_by_fein := get_ams_by_fein(input(fein<>''));
		ams_by_taxid := get_ams_by_taxid(input(taxid<>''));
		ing_by_upin := get_ing_by_upin(input(Upin<>''));
		ing_by_npi := get_ing_by_npi(input(NPI<>''));
		ams_by_npi := get_ams_by_npi(input(NPI<>''));
		ing_by_dea := get_ing_by_dea(input(dea<>''));
		ing_by_dea2 := get_ing_by_dea2(input(dea2<>''));
		// ams_by_dea := get_ams_by_dea(input(dea<>''));
		ing_by_dids := get_ing_by_dids(IndividualRecords(did>0));
		ams_by_dids := get_ams_by_dids(IndividualRecords(did>0));
		sanc_by_dids := get_sanc_by_dids(IndividualRecords(did>0));
		user_ing_providerID := Project(input(providerid>0,providerSrc=myConst.SRC_ING),transform(myLayouts.searchKeyResults,self.prov_id := left.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING;self.derivedinputrecord:=left.derivedinputrecord));
		user_defaultproviderID := Project(input(providerid>0,providerSrc=''),transform(myLayouts.searchKeyResults,self.prov_id := left.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_ING;self.derivedinputrecord:=left.derivedinputrecord));
		user_ams_providerID := Project(input(providerid>0,providerSrc=myConst.SRC_AMS),transform(myLayouts.searchKeyResults,self.prov_id := left.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_AMS;self.derivedinputrecord:=left.derivedinputrecord));
		user_sanc_providerID := Project(input(providerid>0,providerSrc=myConst.SRC_SANC),transform(myLayouts.searchKeyResults,self.prov_id := left.providerid;self.acctno:=left.acctno;self.src:=myConst.SRC_SANC;self.derivedinputrecord:=left.derivedinputrecord));
		all_pids_pre:= dedup(sort(user_ing_providerID+user_defaultproviderID(isautokeysresult=false)+ing_recs_License+ing_recs_License1+ing_recs_License2+ing_recs_License3+ing_recs_License4+ing_recs_License5+ing_recs_License6+ing_recs_License7+ing_recs_License8+ing_recs_License9+ing_recs_License10+ing_by_fein+ing_by_taxid+ing_by_upin+ing_by_npi+ing_by_dea+ing_by_dea2+ing_by_dids,record),record);
		ams_pids_pre:= dedup(sort(user_ams_providerID+ams_recs_License+ams_recs_License1+ams_recs_License2+ams_recs_License3+ams_recs_License4+ams_recs_License5+ams_recs_License6+ams_recs_License7+ams_recs_License8+ams_recs_License9+ams_recs_License10+ams_by_fein+ams_by_taxid+ams_by_npi+ams_by_dids,record),record);
		sanc_pids_pre:= dedup(sort(user_sanc_providerID+sanc_by_dids,record),record);
		//Ok now that we have all this data lets resolve it......
		Sanc_with_Input := myFn.appendInputToSearchKeyData(sanc_pids_pre,input);
		sanc_providers_base := src_Sanc.get_sanc_providers_base(Sanc_with_Input,maxPenalty)(record_penalty<maxPenalty);
		sancLookup := normalize(sanc_providers_base,left.dids,transform(doxie.layout_references, self.did := right.did; self := left; self:=[]));
		//Search the data for sanction related ids
		otherLookupPIDs := getRecordsPIDsByDid(sancLookup)(src<>'S');
		//Merge the original input with whatever we found via lookups
		Ing_with_Input := myFn.appendInputToSearchKeyData(all_pids_pre+otherLookupPIDs(src=myConst.SRC_ING),input);
		ing_providers_final := src_ING.get_ing_entity(Ing_with_Input,maxPenalty);
		//Get Additional AMS content based on Ingenix
		AMS_with_Input := myFn.appendInputToSearchKeyData(ams_pids_pre+otherLookupPIDs(src=myConst.SRC_AMS),input);
		slimDown := project(input(providerid>0 or did>0 or bdid>0 or 
															name_first<>'' or name_last<>'' or Comp_name <>'' or
															prim_range<>'' or prim_name<>'' or p_city_name<>'' or st<>'' or z5<>''), 
												transform(mylayouts.layout_slimInput, self:=left;));
		
		//Collect the resolved ing records and filter out to only those we are slimming down
		filterRecs := join (slimDown,ing_providers_final, left.acctno=right.acctno, 
												transform(mylayouts.CombinedHeaderResults, self:=right));
		childDataLicense := normalize(filterRecs,left.StateLicenses,
												transform(mylayouts.slimINGforAMSLookup, self := right;self:=left));
		childDataNPI := normalize(filterRecs,left.npis,transform(mylayouts.slimINGforAMSLookup, self := right;self:=left));
		childDataDID := normalize(filterRecs,left.dids,transform(mylayouts.slimINGforAMSLookup, self := right;self:=left));
		amsLookupRecs := dedup(sort(childDataLicense+childDataNPI+childDataDID,record),record);
		provideridBasedSearch_pids := myFnAms.checkAMS(amsLookupRecs);
		additional_ams_pids:= join(provideridBasedSearch_pids,input, left.acctno = right.acctno, 
															transform(mylayouts.searchKeyResults_plus_input, self:=left;self:=right));
		all_ams_pids := if(count(input)=1 and input[1].ProviderID > 0 and input[1].ProviderSrc <> 'S',dedup(sort(AMS_with_Input+additional_ams_pids,acctno,prov_id,src),acctno,prov_id,src),AMS_with_Input);
		ams_providers_final := src_AMS.get_ams_entity(all_ams_pids,maxPenalty);

		baseHits := mergeRecords(ing_providers_final,ams_providers_final,sanc_providers_base,Ing_with_Input,AMS_with_Input,input,maxPenalty);
		//If we don't have any hits do NPPES lookup using the NPI number
		getNoHits := join(IndividualRecords(derivedInputRecord=false),baseHits,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);
		getNoHitsForNPPES := project(getNoHits(npi<>'')+BusinessRecords(npi<>''),transform(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input,
																							self.prov_id:=(unsigned6)left.npi;self.src:='N';self:=left)); 
		nppes_providers_final := src_NPPES.get_nppes_providers_base(getNoHitsForNPPES,maxPenalty);//Search results

		//Rollup data within each datasource
		nppes_providers_final_sorted := sort(nppes_providers_final, acctno, HcId, SrcId, Src);
		nppes_providers_final_grouped :=	group(nppes_providers_final_sorted, acctno, HcId, SrcId, Src);
		nppes_providers_rolled_raw := rollup(nppes_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));
		nppes_providers_rolled := myFn.doPenalty(nppes_providers_rolled_raw,input,maxPenalty);

		//if we do not have anything left after the penalty try the autokeys.....
		//Ok if we made it this far without any hits do autokeys
		getNoHitsForAK := join(getNoHits,nppes_providers_final,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);
		akHits := getRecordsPIDsByAK(getNoHitsForAK,maxPenalty);
		NoHitForBusinessRecords := join(BusinessRecords(comp_name<>''),nppes_providers_rolled,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);
		//Check Sanctions for Business Hits
		bussanc_with_Input := join(NoHitForBusinessRecords, doxie_files.key_sanctions_busname,keyed(left.comp_name[1..7] = right.s_sanc_busnme[1..7]),
												transform(myLayouts.searchKeyResults_plus_input, 
																	inputCleanBusName:=myFn.cleanOnlyNames(left.comp_name);
																	inputFilteredBusName:=Functions.getCleanHealthCareName(myFn.cleanOnlyNames(left.comp_name));
																	fileCleanBusName:=myFn.cleanOnlyNames(right.s_sanc_busnme);
																	fileFilteredBusName:=Functions.getCleanHealthCareName(myFn.cleanOnlyNames(right.s_sanc_busnme));
																	closematch1:= if(inputCleanBusName<>'' and fileCleanBusName<>'',ut.CompanySimilar100(inputCleanBusName,fileCleanBusName),1000);
																	closematch2:= if(inputFilteredBusName<>'' and fileFilteredBusName<>'',ut.CompanySimilar100(inputFilteredBusName,fileFilteredBusName),1000);
																	bestmatch := if(closematch1<closematch2,closematch1,closematch2);
																	self.acctno:=left.acctno;
																	self.src:='S';
																	self.prov_id:=if(bestmatch<=Constants.BUS_NAME_MATCH_THRESHOLD,(integer)right.SANC_ID,skip);
																	self:=left;),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		Bus_Sanc := src_Sanc.get_sanc_providers_base(bussanc_with_Input,maxPenalty);
		//If we have don't have results, get dataset to sent thru Deep Dives
		getNoHitsForDeepDive := join(getNoHitsForAK,akHits+Bus_Sanc,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);
		//If we have don't have Business results, get dataset to send thru Deep Dives  We could have gotten hits from NPPES or Sanctions.
		getNoHitsForBusDeepDive := join(BusinessRecords,getNoHitsForNPPES+bussanc_with_Input,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);

		//Deep Dive logic 
		get_deepdive := if(exists(getNoHitsForDeepDive(doDeepDive=true)),getDeepDivePids(getNoHitsForDeepDive));
		DeepDive_with_Input := myFn.appendInputToSearchKeyData(get_deepdive,input);
		DeepDive_final := src_BocaHeader.get_boca_header_base(DeepDive_with_Input,maxPenalty);
		//Deep Dive logic Business
		DeepDiveBusinessRecords := getNoHitsForBusDeepDive(comp_name <> '' and doDeepDive = true and z5 <>'' and isReport=false);
		get_BusDeepdive := if(exists(DeepDiveBusinessRecords),getBusDeepDivePids(DeepDiveBusinessRecords));
		DeepDiveBus_with_Input := myFn.appendInputToSearchKeyData(get_BusDeepdive,input);
		DeepDiveBus_final := src_BocaBusHeader.get_boca_bus_header_base(DeepDiveBus_with_Input,DeepDiveBusinessRecords,maxPenalty);

		//Rollup data within each datasource
		BocaHeader_final_sorted := sort(DeepDive_final, acctno, HcId, SrcId, Src);
		BocaHeader_final_grouped :=	group(BocaHeader_final_sorted, acctno, HcId, SrcId, Src);
		BocaHeader_rolled := rollup(BocaHeader_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));

		//Rollup data within each datasource
		BocaBusHeader_final_sorted := sort(DeepDiveBus_final, acctno, HcId, SrcId, Src);
		BocaBusHeader_final_grouped :=	group(BocaBusHeader_final_sorted, acctno, HcId, SrcId, Src);
		BocaBusHeader_rolled := rollup(BocaBusHeader_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));

		//Collect any records we found via the extra lookups
		additional_found_hits := nppes_providers_rolled+BocaHeader_rolled+BocaBusHeader_rolled;

		//append DEA information for the additional found hits
		getNoHitsForDEA := project(getNoHits(DEA <>'' or DEA2 <>''),transform(myLayouts.autokeyInput,self:=left)); 
		getDeaInfo := dedup(sort(JOIN(getNoHitsForDEA,dea.Key_dea_reg_num,keyed(left.dea= right.dea_registration_number or 
																																						left.dea2= right.dea_registration_number),
													transform(mylayouts.pid_dea_rec, self.deanumber:=right.dea_registration_number;self.expiration_date:=right.Expiration_Date;
																													self :=left;self:=right;self:=[]),keep(myConst.MAX_RECS_ON_JOIN), limit(0)),acctno,providerid,deanumber,-Expiration_Date),acctno,providerid,deanumber,Expiration_Date);
		mylayouts.pid_dea_rec doRollDea(mylayouts.pid_dea_rec l, mylayouts.pid_dea_rec r) := TRANSFORM
			self.acctno := l.acctno;
			SELF.providerid := l.providerid;
			self.deanumber := trim(l.deanumber,all);
			self.deanumberTierTypeID := if(l.deanumberTierTypeID<r.deanumberTierTypeID,l.deanumberTierTypeID,r.deanumberTierTypeID);
			self.expiration_date := if(l.expiration_date <>'',l.expiration_date,r.expiration_date);
		END;
		f_dea_rollup := rollup(getDeaInfo,doRollDea(left,right),acctno,providerid,deanumber,Expiration_Date);
		dearesult:=project(f_dea_rollup, transform(mylayouts.layout_dea,
												self.acctno:=left.acctno;
												SELF.providerid := left.providerid;
												self.dea := trim(left.deanumber,all);
												self.expiration_date := left.expiration_date;
												self := []));
		mylayouts.layout_child_dea doRollup(mylayouts.layout_dea l, dataset(mylayouts.layout_dea) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		dearesults_child_dataset := rollup(group(sort(dearesult,acctno,ProviderID),acctno),group,doRollup(left,rows(left)));
		//append DEA information to any no hits that we found..
		extraHits := join(additional_found_hits,dearesults_child_dataset,left.acctno=right.acctno,
													transform(myLayouts.CombinedHeaderResults, self.deas:=right.childinfo;self:=left),left outer);
		//Find derived Records that we also found extra Hits for as we should remove the derived hit
		baseRemoveDerived := join (baseHits(isDerivedSource=true),extraHits, left.acctno=right.acctno and left.srcid = right.srcid,transform(recordof(basehits),self:=left),left only);
		//Only keep the records from the base hit that we want to keep
		baseFinal := join (baseHits,baseRemoveDerived, left.acctno=right.acctno and left.srcid = right.srcid,transform(recordof(basehits),self:=left),left only);
		final := sort(baseFinal+akHits+Bus_Sanc+extraHits,acctno);
		// output(input,named('input'),overwrite);
		// output(BusinessRecords,named('BusinessRecords'),overwrite);
		// output(IndividualRecords,named('IndividualRecords'),overwrite);
		// output(all_pids_pre,named('Ingenix_pids_pre'),overwrite);
		// output(ams_pids_pre,named('ams_pids_pre'),overwrite);
		// output(sanc_pids_pre,named('sanc_pids_pre'),overwrite);
		// output(Sanc_with_Input,named('Sanc_with_Input'),overwrite);
		// output(sanc_providers_base,named('sanc_providers_base'),overwrite);
		// output(otherLookupPIDs,named('otherLookupPIDs'),overwrite);
		// output(Ing_with_Input,named('Ing_with_Input'),overwrite);
		// output(ing_providers_final,named('ing_providers_final'),overwrite);
		// output(AMS_with_Input,named('AMS_with_Input'),overwrite);
		// output(filterRecs,named('filterRecs'),overwrite);
		// output(childDataLicense,named('childDataLicense'),overwrite);
		// output(childDataNPI,named('childDataNPI'),overwrite);
		// output(childDataDID,named('childDataDID'),overwrite);
		// output(amsLookupRecs,named('amsLookupRecs'),overwrite);
		// output(additional_ams_pids,named('additional_ams_pids'),overwrite);
		// output(all_ams_pids,named('all_ams_pids'),overwrite);
		// output(ams_providers_final,named('ams_providers_final'),overwrite);
		// output(baseHits,named('baseHits'),overwrite);
		// output(getNoHits,named('getNoHits'),overwrite);
		// output(getNoHitsForNPPES,named('getNoHitsForNPPES'),overwrite);
		// output(nppes_providers_rolled,named('nppes_providers_rolled'),overwrite);
		// output(getNoHitsForAK,named('getNoHitsForAK'),overwrite);
		// output(akHits,named('akHits'),overwrite);
		// output(NoHitForBusinessRecords,named('NoHitForBusinessRecords'),overwrite);
		// output(bussanc_with_Input,named('bussanc_with_Input'));
			// output(Bus_Sanc,named('Bus_Sanc'));
		// output(getNoHitsForDeepDive,named('getNoHitsForDeepDive'),overwrite);
		// output(getNoHitsForBusDeepDive,named('getNoHitsForBusDeepDive'),overwrite);
		// output(get_deepdive,named('get_deepdive'),overwrite);
		// output(DeepDive_with_Input,named('DeepDive_with_Input'),overwrite);
		// output(DeepDive_final,named('DeepDive_final'),overwrite);
		// output(DeepDiveBusinessRecords,named('DeepDiveBusinessRecords'),overwrite);
		// output(get_BusDeepdive,named('get_BusDeepdive'),overwrite);
		// output(DeepDiveBus_with_Input,named('DeepDiveBus_with_Input'),overwrite);
		// output(DeepDiveBus_final,named('DeepDiveBus_final'),overwrite);
		// output(additional_found_hits,named('additional_found_hits'),overwrite);
		// output(dearesults_child_dataset,named('dearesults_child_dataset'),overwrite);
		// output(extraHits,named('extraHits'),overwrite);
		// output(baseRemoveDerived,named('baseRemoveDerived'),overwrite);
		// output(final,named('final'),overwrite);
		return final;
	end;
end;