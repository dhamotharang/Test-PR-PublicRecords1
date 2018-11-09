// TBD as of 10/07/16:
  // 1. Add a key fetch EXPORT for linkids keys used in any ***Source_Records attribute and 
	//    then revise the ***Source_Records attribute to use the new export for these sources:
	//    NOTE: some of the sources below already have a key fetch export, but the corresponding
	//          ***Source_records needs revised to use it.
	//    a. SourceSection main (non Gov Ag or other dirs) sources:
	//       Aircraft, Bankruptcy, Corporation, CrashCarrier, DNBDmi, EBR, ForeclosureNOD, 
	//       Motorvehicle, Property, Sanction/Ingenix, UCC
	//    b. SourceSection Government Agency sources:
  //       ATF, Calbus, CASalesTax, DEA, FCC, FDIC, GSA, IASalesTax, InsuranceCert, IRS5500(ret), 
	//       IRS990(nonprofit), MSWork, NDR/Natural Disaster Readiness, OIG, ORWork, ProfLicense, 
	//       SEC_BD, Txbus & WorkersCompensation
	//    c. SourceSection Other Directories sources:
	//       Amidir, BBBNonMem, BBB, CNLDFacility, DiversityCert, InfoUSA_ABIUS, InfoUSA_DEADCO, 
	//       LaborActionsWHD, Ncpdp, Sheila Greco, Spoke
	//    d. Revise the OtherSource_Records attribute to use key_fetches from here.  
	//       Will have to uncomment the Bus Hdr (discuss with Don) & "Directories" EXPORTs below???

  // 2. Add other common BIP linkids keys, i.e. BusHdr, Directories, Best, others???

IMPORT AMS, ATF, BankruptcyV3, BIPV2, BIPV2_Build, BusReg, Corp2, Cortera, DCAV2, DEA, DNB_FEINV2, EBR, 
       Experian_CRDB, Experian_FEIN, faa, FBNV2, FCC, Frandx, Gong, LiensV2, LN_PropertyV2, 
			 OSHAIR, Prof_LicenseV2, Property, Sheila_Greco, TopBusiness_BIPV2, UCCV2, VehicleV2, 
			 Watercraft, YellowPages;

EXPORT Key_Fetches(dataset(BIPV2.IDlayouts.l_xlink_ids) ds_in_linkids
                  ,string1 in_FetchLevel 
									,unsigned4 in_FetchLimit=25000 // default same as in BIPV2.IDMacros
									) 
       := MODULE
	
	shared STRING1   FETCH_LEVEL := in_FetchLevel;
	shared UNSIGNED4 FETCH_LIMIT := in_FetchLimit;

  //****** BIPV2 linkids keys containing data from multiple sources
	//
 	// *** Key fetch to get BIP "Business Header" linkids key records
  //EXPORT ds_bushdr_linkidskey_recs  := BIPV2.Key_BH_Linking_Ids.kfetch(ds_in_linkids,FETCH_LEVEL);

 	// *** Key fetch to get BIP "Contact" linkids key records
	// NOTE: This one will need to use a passed in fetch limit
  EXPORT ds_contact_linkidskey_recs := BIPV2_Build.key_contact_linkids.kFetch(
	                                       ds_in_linkids,FETCH_LEVEL,,,FETCH_LIMIT);

 	// *** Key fetch to get BIP (other) "Directories" linkids key records   //MAY NOT BE NEEDED???
  //EXPORT ds_directories_linkidskey_recs := BIPV2_Build.key_directories_linkids.kFetch(
	//                                            ds_in_linkids,FETCH_LEVEL);

 	// *** Key fetch to get BIP "Industry" info linkids key records
  EXPORT ds_industry_linkidskey_recs := TopBusiness_BIPV2.Key_Industry_Linkids.KeyFetch(
	                                        ds_in_linkids,FETCH_LEVEL,,,FETCH_LIMIT);

 	// *** Key fetch to get BIP "License" info(only has 2 sources) linkids key records
  EXPORT ds_license_linkidskey_recs := TopBusiness_BIPV2.Key_License_Linkids.KeyFetch(
	                                       ds_in_linkids,FETCH_LEVEL,,,FETCH_LIMIT);

	
	//****** Individual source linkids key fetches
	//
	// *** Key fetch to get FAA Aircraft linkids key records
  EXPORT ds_airc_linkidskey_recs := faa.key_aircraft_linkids.keyfetch(ds_in_linkids,FETCH_LEVEL);

  // *** Key fetch to get AMS linkids key records
	EXPORT ds_ams_linkidskey_recs := AMS.key_linkids.KFetch(ds_in_linkids,FETCH_LEVEL,,FETCH_LIMIT);

  // *** Key fetch to get ATF linkids key records
  EXPORT ds_atf_linkidskey_recs := ATF.Key_Linkids.kFetch(ds_in_linkids,FETCH_LEVEL,,FETCH_LIMIT);

  // *** Key fetch to get Bankruptcy linkids key records
  EXPORT ds_bankr_linkidskey_recs := BankruptcyV3.key_bankruptcyV3_linkids.kfetch(ds_in_linkids,
	                                                                                FETCH_LEVEL);

  // *** Key fetch to get Business Registrations linkids key records
  EXPORT ds_busreg_linkidskey_recs := BusReg.key_busreg_company_linkids.kFetch(ds_in_linkids,
	                                                                             FETCH_LEVEL,,FETCH_LIMIT);
   
	// *** Key fetch to get cortera Linkids key records
	EXPORT ds_cortera_linkidskey_recs := Cortera.Key_LinkIds.kFetch2(project(ds_in_linkids, 
	                                                                    transform(BIPV2.IDlayouts.l_xlink_ids2,
																																			  SELF := LEFT, SELF := [])),
																																		FETCH_LEVEL,,FETCH_LIMIT);
  // *** Key fetch to get Corp/Incorporation linkids key records
  EXPORT ds_corp_linkidskey_recs := Corp2.Key_Linkids.Corp.kFetch(ds_in_linkids,FETCH_LEVEL);

  // *** Key fetch to get LNCA/DCA linkids key records
	// NOTE: This one will need to use a passed in fetch limit
	EXPORT ds_dca_linkidskey_recs := DCAV2.Key_Linkids.kFetch(ds_in_linkids,FETCH_LEVEL,,FETCH_LIMIT); 

  //*** Key fetch to get DEA linkids key records
	EXPORT ds_dea_linkidskey_recs := DEA.Key_dea_linkids.kFetch(ds_in_linkids,FETCH_LEVEL,,FETCH_LIMIT); 

  //*** Key fetch to get D&B Fein linkids key records
 	EXPORT ds_dnbfein_linkidskey_recs := DNB_FEINV2.Key_LinkIds.KeyFetch(ds_in_linkids,FETCH_LEVEL,,FETCH_LIMIT);
	
  // *** Key fetch to get EBR 0010 (header data) linkids key records
	// NOTE: This one will need to use a passed in fetch limit
	EXPORT ds_ebr0010_linkidskey_recs := EBR.Key_0010_Header_linkIds.kFetch(ds_in_linkids,
	                                                                        FETCH_LEVEL,,,FETCH_LIMIT);

  // *** Key fetch to get EBR 5600 (Demographic data) linkids key records
  EXPORT ds_ebr5600_linkidskey_recs := EBR.Key_5600_Demographic_Data_LinkIds.kFetch(ds_in_linkids,
	                                                                                  FETCH_LEVEL,,,FETCH_LIMIT);

  // *** Key fetch to get Experian CRDB linkids key records
  EXPORT ds_expcrdb_linkidskey_recs := Experian_CRDB.Key_LinkIDs.kFetch(ds_in_linkids,FETCH_LEVEL);

  // *** Key fetch to get Experian Fein linkids key records
  EXPORT ds_expfein_linkidskey_recs := Experian_FEIN.Key_LinkIDs.kFetch(ds_in_linkids,FETCH_LEVEL);

  // *** Key fetch to get FBN linkids key records
  EXPORT ds_fbn_linkidskey_recs := FBNV2.Key_LinkIds.KeyFetch(ds_in_linkids,FETCH_LEVEL,,FETCH_LIMIT);
																																			 
  // *** Key fetch to get FCC linkids key records
  EXPORT ds_fcc_linkidskey_recs := FCC.Key_FCC_Linkids.kFetch(ds_in_linkids,FETCH_LEVEL,,FETCH_LIMIT);

  // *** Key fetch to get Foreclosure linkids key records
  // NOTE: This one will need to use a passed in fetch limit
	EXPORT ds_fc_linkidskey_recs := Property.Key_Foreclosure_Linkids.kfetch(ds_in_linkids,
													                                                FETCH_LEVEL,,FETCH_LIMIT); 

  // *** Key fetch to get Frandx linkids key records
  EXPORT ds_frandx_linkidskey_recs := Frandx.Key_Linkids.kFetch(ds_in_linkids,FETCH_LEVEL);

  // *** Key fetch to get Gong history linkids key records
	EXPORT ds_gong_linkidskey_recs := Gong.Key_History_LinkIDs.KFetch(ds_in_linkids, FETCH_LEVEL,,FETCH_LIMIT);

	// *** Key fetch to get Liens & Judgments linkids key records
	// NOTE: This one will need to use a passed in fetch limit
  EXPORT ds_liens_linkidskey_recs := LiensV2.Key_Linkids.KeyFetch(ds_in_linkids,
	                                                                FETCH_LEVEL,,FETCH_LIMIT);

  // *** Key fetch to get OHSAIR linkids key records
  EXPORT ds_osha_linkidskey_recs := OSHAIR.Key_OSHAIR_LinkIds.kFetch(ds_in_linkids,FETCH_LEVEL,,FETCH_LIMIT);

  // *** Key fetch to get Professional License linkids key records
  EXPORT ds_pl_linkidskey_recs := Prof_LicenseV2.Key_Proflic_Linkids.KeyFetch(ds_in_linkids,
	                                                                            FETCH_LEVEL,,FETCH_LIMIT);

  // *** Key fetch to get (real) Property linkids key records
	// NOTE: This one will need to use a passed in fetch limit other than default one in 
	//       BIPV2.IDmacros.mac_IndexFetch.
  EXPORT ds_prop_linkidskey_recs := LN_propertyv2.key_Linkids.kfetch(ds_in_linkids, 
								                                                     FETCH_LEVEL,,,
																																		 FETCH_LIMIT);
	
	// *** Key fetch to get Notice of Default/NOD linkids key records
	// NOTE: This one will need to use a passed in fetch limit
  EXPORT ds_nod_linkidskey_recs := Property.Key_NOD_Linkids.kfetch(ds_in_linkids,
	                                                                 FETCH_LEVEL,,FETCH_LIMIT);

	// *** Key fetch to get Sheila Greco linkids key records
  EXPORT ds_sg_linkidskey_recs := Sheila_Greco.Key_LinkIds.kFetch(ds_in_linkids,FETCH_LEVEL,,FETCH_LIMIT);

	// *** Key fetch to get UCC linkids key records
	// NOTE: This one will need to use a passed in fetch limit
	EXPORT ds_ucc_linkidskey_recs := UCCv2.Key_LinkIds.KeyFetch(ds_in_linkids,
	                                                            FETCH_LEVEL,,FETCH_LIMIT);	

  // *** Key fetch to get Vehicles (MVRs) linkids key records
	EXPORT ds_veh_linkidskey_recs := VehicleV2.Key_Vehicle_Linkids.kFetch(ds_in_linkids,FETCH_LEVEL,,,FETCH_LIMIT);

	// *** Key fetch to get Watercraft linkids key records
	EXPORT ds_wc_linkidskey_recs := Watercraft.Key_Linkids.KeyFetch(ds_in_linkids,FETCH_LEVEL); 

  // *** Key fetch to get Yellow Pages linkids key records
	EXPORT ds_yp_linkidskey_recs := YellowPages.Key_yellowpages_linkids.KFetch(ds_in_linkids, FETCH_LEVEL);

END;
