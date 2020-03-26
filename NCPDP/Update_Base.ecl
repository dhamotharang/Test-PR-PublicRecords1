import business_header,business_header_ss,did_add,ut,mdr,TopBusiness_External,AID, NCPDP,Health_Provider_Services, 
				Health_Facility_Services, BIPV2_Company_Names, HealthCareFacility ;

export Update_Base	:= MODULE
#OPTION('multiplePersistInstances',FALSE);
	
	SHARED fn_scale_ncpdp_id(string7 ncpdp_id) := function
		unsigned6 max_pid := 281474976710655;  //max unsigned6
		new_id
			:=
				(unsigned6)
					((unsigned8)( hash64(hashmd5(ncpdp_id)) ) % max_pid)
				;
		return new_id;
	end;

	export prov_info (
										dataset(layouts.Input.prov_information)	pUpdateFile
										,dataset(Layouts.Base.prov_information)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.prov_info  (pUpdateFile, pversion);

		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(ncpdp_provider_id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(ncpdp_provider_id));

		// Make the input unique for ncpdp_provider_id, to help determine what's historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, ncpdp_provider_id, LOCAL),
																		  ncpdp_provider_id,
																		  LOCAL);

		// If the vendor isn't sending records for a given ncpdp_provider_id anymore, we want them, but
		//   don't need to do anything to them.  They've already been marked up with C and H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																		 LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
																		 LEFT ONLY,
																		 LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that
		//   ncpdp_provider_id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																		 LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
																		 TRANSFORM(NCPDP.Layouts.Base.Prov_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
																
		dCleanNameAddr					:=	NCPDP.fCleanNameAddr.prov_info(dUpdateCombined)
																		:persist('persist::NCPDP::prov_information::CleanNameAddr');
											
		dAppendADLS							:= 	NCPDP.fAppend_ADLS.prov_info(dCleanNameAddr);
	
		dRollupBase							:= 	fRollupBase.prov_info(dAppendADLS);
   
		return dRollupBase;
	end;
	
	export prov_relat (
										dataset(layouts.Input.prov_relationship)	pUpdateFile
										,dataset(Layouts.Base.prov_relationship)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.prov_relat  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile,
		                                       HASH64(NCPDP_provider_id, relationship_id,
																					           payment_center_id, remit_and_reconciliation_id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile,
		                                       HASH64(NCPDP_provider_id, relationship_id,
																					           payment_center_id, remit_and_reconciliation_id));

		// Make the input unique for NCPDP_provider_id, relationship_id, payment_center_id, and
		//   remit_and_reconciliation_id, to help determine what's historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist,
		                                       NCPDP_provider_id, relationship_id, payment_center_id,
																					    remit_and_reconciliation_id,
																					 LOCAL),
																		  NCPDP_provider_id, relationship_id, payment_center_id,
																			   remit_and_reconciliation_id,
																		  LOCAL);

		// If the vendor isn't sending records for a given NCPDP_provider_id, relationship_id,
		//   payment_center_id, and remit_and_reconciliation_id anymore, we want them, but don't need to
		//   do anything to them.  They've already been marked up with C and H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.relationship_id = RIGHT.relationship_id AND
																		    LEFT.payment_center_id = RIGHT.payment_center_id AND
																		    LEFT.remit_and_reconciliation_id = RIGHT.remit_and_reconciliation_id,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that
		//   NCPDP_provider_id, relationship_id, payment_center_id, and remit_and_reconciliation_id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.relationship_id = RIGHT.relationship_id AND
																		    LEFT.payment_center_id = RIGHT.payment_center_id AND
																		    LEFT.remit_and_reconciliation_id = RIGHT.remit_and_reconciliation_id,
																		 TRANSFORM(NCPDP.Layouts.Base.Prov_relationship,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
	
		dRollupBase							:= 	fRollupBase.prov_relat	(dUpdateCombined);
   
		return dRollupBase;
	end;
	
	export medicaid (
										dataset(layouts.Input.medicaid_information)	pUpdateFile
										,dataset(Layouts.Base.medicaid_information)					pBaseFile
										,string	pversion
									) := function
			
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.medicaid  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(NCPDP_provider_id, medicaid_id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(NCPDP_provider_id, medicaid_id));

		// Make the input unique for NCPDP_provider_id and medicaid_id, to help determine what's
		//   historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, NCPDP_provider_id, medicaid_id, LOCAL),
																		  NCPDP_provider_id, medicaid_id,
																		  LOCAL);

		// If the vendor isn't sending records for a given NCPDP_provider_id and medicaid_id anymore, we
		//   want them, but don't need to do anything to them.  They've already been marked up with C and
		//   H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.medicaid_id = RIGHT.medicaid_id,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that
		//   NCPDP_provider_id and medicaid_id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.medicaid_id = RIGHT.medicaid_id,
																		 TRANSFORM(NCPDP.Layouts.Base.Medicaid_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
	
		dRollupBase							:= 	fRollupBase.medicaid	(dUpdateCombined);
   
		return dRollupBase;
	end;
	
	export taxonomy (
										dataset(layouts.Input.taxonomy_information)	pUpdateFile
										,dataset(Layouts.Base.taxonomy_information)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.taxonomy  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(NCPDP_provider_id, taxonomy_code));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(NCPDP_provider_id, taxonomy_code));

		// Make the input unique for NCPDP_provider_id and taxonomy_code, to help determine what's
		//   historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, NCPDP_provider_id, taxonomy_code, LOCAL),
																		  NCPDP_provider_id, taxonomy_code,
																		  LOCAL);

		// If the vendor isn't sending records for a given NCPDP_provider_id and taxonomy_code anymore, we
		//   want them, but don't need to do anything to them.  They've already been marked up with C and
		//   H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.taxonomy_code = RIGHT.taxonomy_code,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that
		//   NCPDP_provider_id and taxonomy_code.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.taxonomy_code = RIGHT.taxonomy_code,
																		 TRANSFORM(NCPDP.Layouts.Base.Taxonomy_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
	
		dRollupBase							:= 	fRollupBase.taxonomy	(dUpdateCombined);
   
		return dRollupBase;
	end;
	
	export demographic (
										dataset(layouts.Input.relationship_demographic)	pUpdateFile
										,dataset(Layouts.Base.relationship_demographic)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.demographic  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(relationship_id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(relationship_id));

		// Make the input unique for relationship_id, to help determine what's historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, relationship_id, LOCAL),
																		  relationship_id,
																		  LOCAL);

		// If the vendor isn't sending records for a given relationship_id anymore, we want them, but
		//   don't need to do anything to them.  They've already been marked up with C and H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																		 LEFT.relationship_id = RIGHT.relationship_id,
																		 LEFT ONLY,
																		 LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that
		//   relationship_id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																		 LEFT.relationship_id = RIGHT.relationship_id,
																		 TRANSFORM(NCPDP.Layouts.Base.Relationship_demographic,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
																
		dCleanNameAddr					:=	NCPDP.fCleanNameAddr.demographic(dUpdateCombined)
																	:persist('persist::NCPDP::demographic::CleanNameAddr');
											
		// dAppendADLS							:= 	NCPDP.fAppend_ADLS(dCleanNameAddr); //do we need DIDs for the secondary contact people? not sure we have enough info to get DIDs anyway
	
		dRollupBase							:= 	fRollupBase.demographic(dCleanNameAddr);
   
		return dRollupBase;
	end;
	
	export pay_center (
										dataset(layouts.Input.payment_center_information)	pUpdateFile
										,dataset(Layouts.Base.payment_center_information)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.pay_center  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(id));

		// Make the input unique for id, to help determine what's historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, id, LOCAL),
																		  id,
																		  LOCAL);

		// If the vendor isn't sending records for a given id anymore, we want them, but don't need to
		//   do anything to them.  They've already been marked up with C and H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.id = RIGHT.id,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																		 LEFT.id = RIGHT.id,
																		 TRANSFORM(NCPDP.Layouts.Base.Payment_center_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
																
		dCleanNameAddr					:=	NCPDP.fCleanNameAddr.pay_center(dUpdateCombined)
																		:persist('persist::NCPDP::pay_center::CleanNameAddr');
											
		// dAppendADLS							:= 	NCPDP.fAppend_ADLS(dCleanNameAddr); //do we need DIDs for the secondary contact people? not sure we have enough info to get DIDs anyway
	
		dRollupBase							:= 	fRollupBase.pay_center(dCleanNameAddr);
   
		return dRollupBase;
	end;
	
	export parent_org (
										dataset(layouts.Input.parent_organization_information)	pUpdateFile
										,dataset(Layouts.Base.parent_organization_information)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.parent_org  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(id));

		// Make the input unique for id, to help determine what's historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, id, LOCAL),
																		  id,
																		  LOCAL);

		// If the vendor isn't sending records for a given id anymore, we want them, but don't need to
		//   do anything to them.  They've already been marked up with C and H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.id = RIGHT.id,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																		 LEFT.id = RIGHT.id,
																		 TRANSFORM(NCPDP.Layouts.Base.Parent_organization_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
																
		dCleanNameAddr					:=	NCPDP.fCleanNameAddr.parent_org(dUpdateCombined)
																		:persist('persist::NCPDP::parent_org::CleanNameAddr');
											
		// dAppendADLS							:= 	NCPDP.fAppend_ADLS(dCleanNameAddr); //do we need DIDs for the secondary contact people? not sure we have enough info to get DIDs anyway
	
		dRollupBase							:= 	fRollupBase.parent_org(dCleanNameAddr);
   
		return dRollupBase;
	end;
	
	export ePrescribe (
										dataset(layouts.Input.eprescribe_information)	pUpdateFile
										,dataset(Layouts.Base.eprescribe_information)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.eprescribe  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(NCPDP_provider_id, network_id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(NCPDP_provider_id, network_id));

		// Make the input unique for NCPDP_provider_id and network_id, to help determine what's historical
		//   and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, NCPDP_provider_id, network_id, LOCAL),
																		  NCPDP_provider_id, network_id,
																		  LOCAL);

		// If the vendor isn't sending records for a given NCPDP_provider_id and network_id anymore, we
		//   want them, but don't need to do anything to them.  They've already been marked up with C and
		//   H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.network_id = RIGHT.network_id,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that
		//   NCPDP_provider_id and network_id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.network_id = RIGHT.network_id,
																		 TRANSFORM(NCPDP.Layouts.Base.ePrescribe_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
	
		dRollupBase							:= 	fRollupBase.eprescribe(dUpdateCombined);
   
		return dRollupBase;
	end;
	
	export remit (
										dataset(layouts.Input.remit_information)	pUpdateFile
										,dataset(Layouts.Base.remit_information)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.remit  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(id));

		// Make the input unique for id, to help determine what's historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, id, LOCAL),
																		  id,
																		  LOCAL);

		// If the vendor isn't sending records for a given id anymore, we want them, but don't need to
		//   do anything to them.  They've already been marked up with C and H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.id = RIGHT.id,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																		 LEFT.id = RIGHT.id,
																		 TRANSFORM(NCPDP.Layouts.Base.Remit_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
																
		dCleanNameAddr					:=	NCPDP.fCleanNameAddr.remit(dUpdateCombined)
																	:persist('persist::NCPDP::remit::CleanNameAddr');													
	
		dRollupBase							:= 	fRollupBase.remit(dCleanNameAddr);
   
		return dRollupBase;
	end;
	
	export state_lic (
										dataset(layouts.Input.state_license_information)	pUpdateFile
										,dataset(Layouts.Base.state_license_information)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.state_lic  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(NCPDP_provider_id, license_number));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(NCPDP_provider_id, license_number));

		// Make the input unique for NCPDP_provider_id and license_number, to help determine what's
		//   historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, NCPDP_provider_id, license_number, LOCAL),
																		  NCPDP_provider_id, license_number,
																		  LOCAL);

		// If the vendor isn't sending records for a given NCPDP_provider_id and license_number anymore, we
		//   want them, but don't need to do anything to them.  They've already been marked up with C and
		//   H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.license_number = RIGHT.license_number,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that
		//   NCPDP_provider_id and license_number.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id AND
																		    LEFT.license_number = RIGHT.license_number,
																		 TRANSFORM(NCPDP.Layouts.Base.State_license_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
	
		dRollupBase							:= 	fRollupBase.state_lic(dUpdateCombined);
   
		return dRollupBase;
	end;
	
	export services (
										dataset(layouts.Input.services_information)	pUpdateFile
										,dataset(Layouts.Base.services_information)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.services  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(ncpdp_provider_id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(ncpdp_provider_id));

		// Make the input unique for ncpdp_provider_id, to help determine what's historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, ncpdp_provider_id, LOCAL),
																		  ncpdp_provider_id,
																		  LOCAL);

		// If the vendor isn't sending records for a given ncpdp_provider_id anymore, we want them, but
		//   don't need to do anything to them.  They've already been marked up with C and H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that
		//   ncpdp_provider_id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																		 LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
																		 TRANSFORM(NCPDP.Layouts.Base.Services_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
	
		dRollupBase							:= 	fRollupBase.services(dUpdateCombined);
   
		return dRollupBase;
	end;
	
	export change_owner (
										dataset(layouts.Input.change_ownership_information)	pUpdateFile
										,dataset(Layouts.Base.change_ownership_information)					pBaseFile
										,string	pversion
									) := function
		
		dStandardizedInputFile  := 	NCPDP.StandardizeInputFile.change_owner  (pUpdateFile, pversion);
		
		dInputFileDist				  :=  DISTRIBUTE(dStandardizedInputFile, HASH64(ncpdp_provider_id));
		dBaseFileDist				 		:=  DISTRIBUTE(pBaseFile, HASH64(ncpdp_provider_id));

		// Make the input unique for ncpdp_provider_id, to help determine what's historical and what's not.
		unique_update           :=  DEDUP(SORT(dInputFileDist, ncpdp_provider_id, LOCAL),
																		  ncpdp_provider_id,
																		  LOCAL);

		// If the vendor isn't sending records for a given ncpdp_provider_id anymore, we want them, but
		//   don't need to do anything to them.  They've already been marked up with C and H appropriately.
		dCurrentBase            :=  JOIN(dBaseFileDist, unique_update,
																	   LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
																	   LEFT ONLY,
																	   LOCAL);

		// Determine the records that are historical... vendor is still sending updates for that
		//   ncpdp_provider_id.
		dHistoricalBase         :=  JOIN(dBaseFileDist, unique_update,
																		 LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
																		 TRANSFORM(NCPDP.Layouts.Base.Change_ownership_information,
																							 SELF.record_type := 'H';
																							 SELF := LEFT),
																		 LOCAL);

		dUpdateCombined					:=	if(NCPDP._Flags.Update
																			,dStandardizedInputFile + dCurrentBase + dHistoricalBase
																			,dStandardizedInputFile
																);
	
		dRollupBase							:= 	fRollupBase.change_owner(dUpdateCombined);
   
		return dRollupBase;
	end;
	

	export combined_base (string pversion):= function
	
		prov_info_ncpdp 	:= dedup(sort(distribute(Files().prov_info_base.built, hash(ncpdp_provider_id)), ncpdp_provider_id, local), record, local);

		Layouts.Base.Combined_File combine1(prov_info_ncpdp L)	:= TRANSFORM
			self.pid                      							:=	fn_scale_ncpdp_id(l.ncpdp_provider_id);
			self.src																		:= 	'J2';
			self.dt_first_seen													:=	l.dt_first_seen;
			self.dt_last_seen														:=	l.dt_last_seen;
			self.bdid																		:=	l.bdid;
			self.did																		:=	l.did;
			self.record_type														:=	l.record_type;
			self.NCPDP_provider_id											:=	l.NCPDP_provider_id;
			self.prov_info_legal_business_name					:=	l.legal_business_name;
			self.prov_info_DBA													:=	l.DBA;
			self.prov_info_doctor_name									:=	l.doctor_name;
			self.prov_info_store_number									:=	l.store_number;
			self.prov_info_phys_loc_address1						:=	l.phys_loc_address1;
			self.prov_info_phys_loc_address2						:=	l.phys_loc_address2;
			self.prov_info_phys_loc_city								:=	l.phys_loc_city;
			self.prov_info_phys_loc_state								:=	l.phys_loc_state;
			self.prov_info_phys_loc_full_zip						:=	l.phys_loc_full_zip;
			self.prov_info_phys_loc_phone								:=	l.phys_loc_phone;
			self.prov_info_phys_loc_phone_ext						:=	l.phys_loc_phone_ext;
			self.prov_info_phys_loc_fax_number					:=	l.phys_loc_fax_number;
			self.prov_info_phys_loc_email								:=	l.phys_loc_email;
			self.prov_info_phys_loc_cross_street				:=	l.phys_loc_cross_street;
			self.prov_info_phys_loc_FIPS								:=	l.phys_loc_FIPS;
			self.prov_info_phys_loc_MSA									:=	l.phys_loc_MSA;
			self.prov_info_phys_loc_PMSA								:=	l.phys_loc_PMSA;	
			self.prov_info_phys_loc_24hr_operation			:=	l.phys_loc_24hr_operation;
			self.prov_info_phys_loc_provider_hours			:=	l.phys_loc_provider_hours;
			self.prov_info_phys_loc_voting_district			:=	l.phys_loc_voting_district;
			self.prov_info_phys_loc_language_code1			:=	l.phys_loc_language_code1;
			self.prov_info_phys_loc_language_code2			:=	l.phys_loc_language_code2;
			self.prov_info_phys_loc_language_code3			:=	l.phys_loc_language_code3;
			self.prov_info_phys_loc_language_code4			:=	l.phys_loc_language_code4;
			self.prov_info_phys_loc_language_code5			:=	l.phys_loc_language_code5;
			self.prov_info_phys_loc_store_open_date			:=	l.phys_loc_store_open_date;
			self.prov_info_phys_loc_store_close_date		:=	l.phys_loc_store_close_date;
			self.prov_info_address1											:=	l.address1;
			self.prov_info_address2											:=	l.address2;
			self.prov_info_city													:=	l.city;
			self.prov_info_state												:=	l.state;
			self.prov_info_full_zip											:=	l.full_zip;
			self.prov_info_contact_last_name						:=	l.contact_last_name;
			self.prov_info_contact_first_name						:=	l.contact_first_name;
			self.prov_info_contact_middle_initial				:=	l.contact_middle_initial;
			self.prov_info_contact_title								:=	l.contact_title;
			self.prov_info_contact_phone								:=	l.contact_phone;
			self.prov_info_contact_phone_ext						:=	l.contact_phone_ext;
			self.prov_info_contact_email								:=	l.contact_email;
			self.prov_info_dispenser_class_code					:=	l.dispenser_class_code;
			self.prov_info_primary_dispenser_type_code	:=	l.primary_dispenser_type_code;
			self.prov_info_secondary_dispenser_type_code:=	l.secondary_dispenser_type_code;
			self.prov_info_tertiary_dispenser_type_code	:=	l.tertiary_dispenser_type_code;
			self.prov_info_medicare_provider_id					:=	l.medicare_provider_id;
			self.prov_info_national_provider_id					:=	l.national_provider_id;
			self.prov_info_DEA_registration_id					:=	l.DEA_registration_id;
			self.prov_info_federal_tax_id								:=	l.federal_tax_id;
			self.prov_info_state_income_tax_id					:=	l.state_income_tax_id;
			self.prov_info_deactivation_code						:=	l.deactivation_code;
			self.prov_info_reinstatement_code						:=	l.reinstatement_code;
			self.prov_info_transaction_code							:=	l.transaction_code;
			self.prov_info_SundayHours									:=	l.SundayHours;
			self.prov_info_MondayHours									:=	l.MondayHours;
			self.prov_info_TuesdayHours									:=	l.TuesdayHours;
			self.prov_info_WednesdayHours								:=	l.WednesdayHours;
			self.prov_info_ThursdayHours								:=	l.ThursdayHours;
			self.prov_info_FridayHours									:=	l.FridayHours;
			self.prov_info_SaturdayHours								:=	l.SaturdayHours;
			self.prov_info_languageCode1Desc						:=	l.languageCode1Desc;
			self.prov_info_languageCode2Desc						:=	l.languageCode2Desc;
			self.prov_info_languageCode3Desc						:=	l.languageCode3Desc;
			self.prov_info_languageCode4Desc						:=	l.languageCode4Desc;
			self.prov_info_languageCode5Desc						:=	l.languageCode5Desc;
			self.prov_info_dispensingClassDesc					:=	l.dispensingClassDesc;
			self.prov_info_PrimaryDispensingTypeDesc		:=	l.PrimaryDispensingTypeDesc;
			self.prov_info_SecondaryDispensingTypeDesc	:=	l.SecondaryDispensingTypeDesc;
			self.prov_info_TertiaryDispensingTypeDesc		:=	l.TertiaryDispensingTypeDesc;
			self.prov_info_clean_DEA_expiration_date		:=	l.clean_DEA_expiration_date;
			self.prov_info_clean_phys_loc_store_open_date	:=	l.clean_phys_loc_store_open_date;
			self.prov_info_clean_phys_loc_store_close_date:=	l.clean_phys_loc_store_close_date;
			self.prov_info_clean_reinstatement_date			:=	l.clean_reinstatement_date;
			self.prov_info_clean_transaction_date				:=	l.clean_transaction_date;
			self.prov_info_Append_PhyAddr1							:=	l.Append_PhyAddr1;
			self.prov_info_Append_PhyAddrLast						:=	l.Append_PhyAddrLast;
			self.prov_info_Append_PhyRawAID							:=	l.Append_PhyRawAID;
			self.prov_info_Append_PhyAceAID							:=	l.Append_PhyAceAID;			
			self.prov_info_Append_MailAddr1							:=	l.Append_MailAddr1;
			self.prov_info_Append_MailAddrLast					:=	l.Append_MailAddrLast;
			self.prov_info_Append_MailRawAID						:=	l.Append_MailRawAID;
			self.prov_info_Append_MailAceAID						:=	l.Append_MailAceAID;	
			self.prov_info_clean_dr_fname								:=	l.clean_dr_fname;
			self.prov_info_clean_dr_mname								:=	l.clean_dr_mname;
			self.prov_info_clean_dr_lname								:=	l.clean_dr_lname;
			self.prov_info_clean_dr_suffix							:=	l.clean_dr_suffix;	
			self.prov_info_clean_fname									:=	l.clean_fname;
			self.prov_info_clean_mname									:=	l.clean_mname;
			self.prov_info_clean_lname									:=	l.clean_lname;
			self.prov_info_clean_suffix									:=	l.clean_suffix;	
			self.prov_info_Phys_prim_range							:=	l.Phys_prim_range;
			self.prov_info_Phys_predir									:=	l.Phys_predir;
			self.prov_info_Phys_prim_name								:=	l.Phys_prim_name;
			self.prov_info_Phys_addr_suffix							:=	l.Phys_addr_suffix;
			self.prov_info_Phys_postdir									:=	l.Phys_postdir;	
			self.prov_info_Phys_unit_desig							:=	l.Phys_unit_desig;
			self.prov_info_Phys_sec_range								:=	l.Phys_sec_range;
			self.prov_info_Phys_p_city_name							:=	l.Phys_p_city_name;
			self.prov_info_Phys_v_city_name							:=	l.Phys_v_city_name;
			self.prov_info_Phys_state										:=	l.Phys_state;
			self.prov_info_Phys_zip5										:=	l.Phys_zip5;
			self.prov_info_Phys_zip4										:=	l.Phys_zip4;
			self.prov_info_Phys_cart										:=	l.Phys_cart;
			self.prov_info_Phys_cr_sort_sz							:=	l.Phys_cr_sort_sz;
			self.prov_info_Phys_lot											:=	l.Phys_lot;
			self.prov_info_Phys_lot_order								:=	l.Phys_lot_order;
			self.prov_info_Phys_dpbc										:=	l.Phys_dpbc;
			self.prov_info_Phys_chk_digit								:=	l.Phys_chk_digit;
			self.prov_info_Phys_rec_type								:=	l.Phys_rec_type;
			self.prov_info_Phys_ace_fips_st							:=	l.Phys_ace_fips_st;
			self.prov_info_Phys_county									:=	l.Phys_county;
			self.prov_info_Phys_geo_lat									:=	l.Phys_geo_lat;
			self.prov_info_Phys_geo_long								:=	l.Phys_geo_long;
			self.prov_info_Phys_msa											:=	l.Phys_msa;
			self.prov_info_Phys_geo_blk									:=	l.Phys_geo_blk;
			self.prov_info_Phys_geo_match								:=	l.Phys_geo_match;
			self.prov_info_Phys_err_stat								:=	l.Phys_err_stat;
			self.prov_info_Mail_prim_range							:=	l.Mail_prim_range;
			self.prov_info_Mail_predir									:=	l.Mail_predir;
			self.prov_info_Mail_prim_name								:=	l.Mail_prim_name;
			self.prov_info_Mail_addr_suffix							:=	l.Mail_addr_suffix;
			self.prov_info_Mail_postdir									:=	l.Mail_postdir;
			self.prov_info_Mail_unit_desig							:=	l.Mail_unit_desig;
			self.prov_info_Mail_sec_range								:=	l.Mail_sec_range;
			self.prov_info_Mail_p_city_name							:=	l.Mail_p_city_name;
			self.prov_info_Mail_v_city_name							:=	l.Mail_v_city_name;
			self.prov_info_Mail_state										:=	l.Mail_state;
			self.prov_info_Mail_zip5										:=	l.Mail_zip5;
			self.prov_info_Mail_zip4										:=	l.Mail_zip4;
			self.prov_info_Mail_cart										:=	l.Mail_cart;
			self.prov_info_Mail_cr_sort_sz							:=	l.Mail_cr_sort_sz;
			self.prov_info_Mail_lot											:=	l.Mail_lot;
			self.prov_info_Mail_lot_order								:=	l.Mail_lot_order;
			self.prov_info_Mail_dpbc										:=	l.Mail_dpbc;
			self.prov_info_Mail_chk_digit								:=	l.Mail_chk_digit;
			self.prov_info_Mail_rec_type								:=	l.Mail_rec_type;
			self.prov_info_Mail_ace_fips_st							:=	l.Mail_ace_fips_st;
			self.prov_info_Mail_county									:=	l.Mail_county;
			self.prov_info_Mail_geo_lat									:=	l.Mail_geo_lat;
			self.prov_info_Mail_geo_long								:=	l.Mail_geo_long;
			self.prov_info_Mail_msa											:=	l.Mail_msa;
			self.prov_info_Mail_geo_blk									:=	l.Mail_geo_blk;
			self.prov_info_Mail_geo_match								:=	l.Mail_geo_match;
			self.prov_info_Mail_err_stat								:=	l.Mail_err_stat;	
			self														            := 	l;
			self																				:=	[];
		end;
		base_a0	:= dedup(sort(project(prov_info_ncpdp, combine1(LEFT)), record, local), record, local);
		base_a	:= sort(distribute(base_a0, hash(ncpdp_provider_id)), ncpdp_provider_id, local);
		
		prov_relat_ncpdp	:= sort(distribute(Files().prov_relat_base.built, hash(ncpdp_provider_id)), ncpdp_provider_id, local);

		base_b0	:= JOIN(base_a, prov_relat_ncpdp,
										LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
										TRANSFORM({base_a},
											self.record_type														:=	if(right.record_type = 'H', right.record_type, left.record_type);
											self.prov_relat_relationship_id							:=	right.relationship_id;
											self.prov_relat_payment_center_id						:=	right.payment_center_id;
											self.prov_relat_remit_and_reconciliation_id	:=	right.remit_and_reconciliation_id;
											self.prov_relat_provider_type								:=	right.provider_type;
											self.prov_relat_is_primary									:=	right.is_primary;
											self.prov_relat_effective_from_date					:=	right.effective_from_date;
											self.prov_relat_effective_through_date			:=	right.effective_through_date;
											self.prov_relat_clean_effect_from_date			:=	right.clean_effect_from_date;
											self.prov_relat_clean_effect_through_date		:=	right.clean_effect_through_date;
											self																				:=	left)
										,left outer
										,local);
										
		base_b	:= dedup(sort(base_b0, record, local), record, local);
										
		medicaid_ncpdp	:= sort(distribute(Files().medicaid_base.built, hash(ncpdp_provider_id)), ncpdp_provider_id, local);
		base_c0	:= JOIN(sort(distribute(base_b, hash(ncpdp_provider_id)), ncpdp_provider_id, local), medicaid_ncpdp,
										LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
										TRANSFORM({base_b},
											self.record_type								:=	if(right.record_type = 'H', right.record_type, left.record_type);
											self.medicaid_state_code				:=	right.state_code;
											self.medicaid_id								:=	right.medicaid_id;
											self.medicaid_clean_delete_date	:=	right.clean_delete_date;
											self														:=	left)
										,left outer
										,local);
		base_c	:= dedup(sort(base_c0, record, local), record, local);
		
		taxonomy_ncpdp	:= sort(distribute(Files().taxonomy_base.built, hash(ncpdp_provider_id)), ncpdp_provider_id, local);
		base_d0	:= JOIN(sort(distribute(base_c, hash(ncpdp_provider_id)), ncpdp_provider_id, local),	taxonomy_ncpdp, 			
										LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
										TRANSFORM({base_c},
											self.record_type									:=	if(right.record_type = 'H', right.record_type, left.record_type);
											self.taxonomy_code								:=	right.taxonomy_code;
											self.taxonomy_provider_type_code	:=	right.provider_type_code;
											self.taxonomy_clean_delete_date		:=	right.clean_delete_date;
											self															:=	left)
										,left outer
										,local);
		base_d	:= dedup(sort(base_d0, record, local), record, local);

		demog_id	:= sort(distribute(Files().demographic_base.built, hash(relationship_id)), relationship_id, local);
		base_e0	:= JOIN(sort(distribute(base_d, hash(prov_relat_relationship_id)), prov_relat_relationship_id, local), demog_id,
										LEFT.prov_relat_relationship_id	= RIGHT.relationship_id,
										TRANSFORM({base_d},
											self.record_type													:=	if(right.record_type = 'H', right.record_type, left.record_type);	
											self.demographic_type											:=	right.relationship_type;
											self.demographic_name											:=	right.name;
											self.demographic_phone_number							:=	right.phone_number;
											self.demographic_extension								:=	right.extension;
											self.demographic_fax_number								:=	right.fax_number;
											self.demographic_npi											:=	right.relationship_npi;
											self.demographic_federal_tax_id						:=	right.relationship_federal_tax_id;
											self.demographic_contact_name							:=	right.demog_contact_name;
											self.demographic_contact_title						:=	right.demog_contact_title;
											self.demographic_contact_email						:=	right.demog_contact_email;
											self.demographic_contractual_contact_name	:=	right.contractual_contact_name;
											self.demographic_contractual_contact_title:=	right.contractual_contact_title;
											self.demographic_contractual_contact_email:=	right.contractual_contact_email;
											self.demographic_operational_contact_name	:=	right.operational_contact_name;
											self.demographic_operational_contact_title:=	right.operational_contact_title;
											self.demographic_operational_contact_email:=	right.operational_contact_email;
											self.demographic_technical_contact_name		:=	right.technical_contact_name;
											self.demographic_technical_contact_title	:=	right.technical_contact_title;
											self.demographic_technical_contact_email	:=	right.technical_contact_email;
											self.demographic_audit_contact_name				:=	right.audit_contact_name;
											self.demographic_audit_contact_title			:=	right.audit_contact_title;
											self.demographic_audit_contact_email			:=	right.audit_contact_email;
											self.demographic_parent_organization_id		:=	right.parent_organization_id;
											self.demographic_clean_effect_from_date		:=	right.clean_effect_from_date;
											self.demographic_clean_delete_date				:=	right.clean_delete_date;	
											self.demographic_Append_Addr1							:=	right.Append_Addr1;
											self.demographic_Append_AddrLast					:=	right.Append_AddrLast;
											self.demographic_Append_RawAID						:=	right.Append_RawAID;
											self.demographic_Append_AceAID						:=	right.Append_AceAID;
											self.demographic_clean_contact_fname			:=	right.demog_contact_fname;
											self.demographic_clean_contact_mname			:=	right.demog_contact_mname;
											self.demographic_clean_contact_lname			:=	right.demog_contact_lname;
											self.demographic_clean_contact_suffix			:=	right.demog_contact_suffix;
											self.demographic_clean_contractual_contact_fname:=	right.contractual_contact_fname;
											self.demographic_clean_contractual_contact_mname:=	right.contractual_contact_mname;
											self.demographic_clean_contractual_contact_lname:=	right.contractual_contact_lname;
											self.demographic_clean_contractual_contact_suffix:=	right.contractual_contact_suffix;		
											self.demographic_clean_operational_contact_fname:=	right.operational_contact_fname;
											self.demographic_clean_operational_contact_mname:=	right.operational_contact_mname;
											self.demographic_clean_operational_contact_lname:=	right.operational_contact_lname;
											self.demographic_clean_operational_contact_suffix:=	right.operational_contact_suffix;	
											self.demographic_clean_technical_contact_fname	:=	right.technical_contact_fname;
											self.demographic_clean_technical_contact_mname	:=	right.technical_contact_mname;
											self.demographic_clean_technical_contact_lname	:=	right.technical_contact_lname;
											self.demographic_clean_technical_contact_suffix	:=	right.technical_contact_suffix;	
											self.demographic_clean_audit_contact_fname			:=	right.audit_contact_fname;
											self.demographic_clean_audit_contact_mname			:=	right.audit_contact_mname;
											self.demographic_clean_audit_contact_lname			:=	right.audit_contact_lname;
											self.demographic_clean_audit_contact_suffix			:=	right.audit_contact_suffix;	
											self.demographic_prim_range								:=	right.prim_range;
											self.demographic_predir										:=	right.predir;
											self.demographic_prim_name								:=	right.prim_name;
											self.demographic_addr_suffix							:=	right.addr_suffix;
											self.demographic_postdir									:=	right.postdir;
											self.demographic_unit_desig								:=	right.unit_desig;
											self.demographic_sec_range								:=	right.sec_range;
											self.demographic_p_city_name							:=	right.p_city_name;
											self.demographic_v_city_name							:=	right.v_city_name;
											self.demographic_state										:=	right.state;
											self.demographic_zip5											:=	right.zip5;
											self.demographic_zip4											:=	right.zip4;
											self.demographic_cart											:=	right.cart;
											self.demographic_cr_sort_sz								:=	right.cr_sort_sz;
											self.demographic_lot											:=	right.lot;
											self.demographic_lot_order								:=	right.lot_order;
											self.demographic_dpbc											:=	right.dpbc;
											self.demographic_chk_digit								:=	right.chk_digit;
											self.demographic_rec_type									:=	right.rec_type;
											self.demographic_fips_st									:=	right.fips_st;
											self.demographic_fips_county							:=	right.fips_county;
											self.demographic_geo_lat									:=	right.geo_lat;
											self.demographic_geo_long									:=	right.geo_long;
											self.demographic_msa											:=	right.msa;
											self.demographic_geo_blk									:=	right.geo_blk;
											self.demographic_geo_match								:=	right.geo_match;
											self.demographic_err_stat									:=	right.err_stat;
											self																			:=	left)
										,left outer
										,local);
		base_e	:= dedup(sort(base_e0, record, local), record, local);
		
		pay_center_id	:= sort(distribute(Files().pay_center_base.built, hash(id)), id, local);
		base_f0	:= JOIN(sort(distribute(base_e, hash(prov_relat_payment_center_id)), prov_relat_payment_center_id, local), pay_center_id,
										LEFT.prov_relat_payment_center_id = RIGHT.id,
										TRANSFORM({base_e},
											self.record_type									:=	if(right.record_type = 'H', right.record_type, left.record_type);
											self.pay_center_name							:=	right.name;
											self.pay_center_address_1					:=	right.address_1;
											self.pay_center_address_2					:=	right.address_2;
											self.pay_center_city							:=	right.city;
											self.pay_center_state_code				:=	right.state_code;
											self.pay_center_zip_code					:=	right.zip_code;
											self.pay_center_phone							:=	right.phone;
											self.pay_center_extension					:=	right.extension;
											self.pay_center_fax								:=	right.fax;
											self.pay_center_npi								:=	right.npi;
											self.pay_center_federal_tax_id		:=	right.federal_tax_id;
											self.pay_center_contact_name			:=	right.contact_name;
											self.pay_center_contact_title			:=	right.contact_title;
											self.pay_center_contact_email			:=	right.contact_email;
											self.pay_center_clean_delete_date	:=	right.clean_delete_date;
											self.pay_center_Append_Addr1			:=	right.Append_Addr1;
											self.pay_center_Append_AddrLast		:=	right.Append_AddrLast;
											self.pay_center_Append_RawAID			:=	right.Append_RawAID;
											self.pay_center_Append_AceAID			:=	right.Append_AceAID;
											self.pay_center_contact_fname			:=	right.contact_fname;
											self.pay_center_contact_mname			:=	right.contact_mname;
											self.pay_center_contact_lname			:=	right.contact_lname;
											self.pay_center_contact_suffix		:=	right.contact_suffix;	
											self.pay_center_prim_range				:=	right.prim_range;
											self.pay_center_predir						:=	right.predir;
											self.pay_center_prim_name					:=	right.prim_name;
											self.pay_center_addr_suffix				:=	right.addr_suffix;
											self.pay_center_postdir						:=	right.postdir;
											self.pay_center_unit_desig				:=	right.unit_desig;
											self.pay_center_sec_range					:=	right.sec_range;
											self.pay_center_p_city_name				:=	right.p_city_name;
											self.pay_center_v_city_name				:=	right.v_city_name;
											self.pay_center_state							:=	right.state;
											self.pay_center_zip5							:=	right.zip5;
											self.pay_center_zip4							:=	right.zip4;
											self.pay_center_cart							:=	right.cart;
											self.pay_center_cr_sort_sz				:=	right.cr_sort_sz;
											self.pay_center_lot								:=	right.lot;
											self.pay_center_lot_order					:=	right.lot_order;
											self.pay_center_dpbc							:=	right.dpbc;
											self.pay_center_chk_digit					:=	right.chk_digit;
											self.pay_center_rec_type					:=	right.rec_type;
											self.pay_center_fips_st						:=	right.fips_st;
											self.pay_center_fips_county				:=	right.fips_county;
											self.pay_center_geo_lat						:=	right.geo_lat;
											self.pay_center_geo_long					:=	right.geo_long;
											self.pay_center_msa								:=	right.msa;
											self.pay_center_geo_blk						:=	right.geo_blk;
											self.pay_center_geo_match					:=	right.geo_match;
											self.pay_center_err_stat					:=	right.err_stat;
											self															:=	left)
										,left outer
										,local);
		base_f	:= dedup(sort(base_f0, record, local), record, local);
							
		parent_org_id	:= sort(distribute(Files().parent_org_base.built, hash(id)), id, local);
		base_g0	:= JOIN(sort(distribute(base_f, hash(demographic_parent_organization_id)), demographic_parent_organization_id, local), parent_org_id,
										LEFT.demographic_parent_organization_id = RIGHT.id,
										TRANSFORM({base_f},
											self.record_type									:=	if(right.record_type = 'H', right.record_type, left.record_type);
											self.parent_org_name							:=	right.name;
											self.parent_org_address_1					:=	right.address_1;
											self.parent_org_address_2					:=	right.address_2;
											self.parent_org_city							:=	right.city;
											self.parent_org_state_code				:=	right.state_code;
											self.parent_org_zip_code					:=	right.zip_code;
											self.parent_org_phone							:=	right.phone;
											self.parent_org_extension					:=	right.extension;
											self.parent_org_fax								:=	right.fax;
											self.parent_org_npi								:=	right.npi;
											self.parent_org_federal_tax_id		:=	right.federal_tax_id;
											self.parent_org_contact_name			:=	right.contact_name;
											self.parent_org_contact_title			:=	right.contact_title;
											self.parent_org_contact_email			:=	right.contact_email;
											self.parent_org_clean_delete_date	:=	right.clean_delete_date;
											self.parent_org_Append_Addr1			:=	right.Append_Addr1;
											self.parent_org_Append_AddrLast		:=	right.Append_AddrLast;
											self.parent_org_Append_RawAID			:=	right.Append_RawAID;
											self.parent_org_Append_AceAID			:=	right.Append_AceAID;
											self.parent_org_contact_fname			:=	right.contact_fname;
											self.parent_org_contact_mname			:=	right.contact_mname;
											self.parent_org_contact_lname			:=	right.contact_lname;
											self.parent_org_contact_suffix		:=	right.contact_suffix;	
											self.parent_org_prim_range				:=	right.prim_range;
											self.parent_org_predir						:=	right.predir;
											self.parent_org_prim_name					:=	right.prim_name;
											self.parent_org_addr_suffix				:=	right.addr_suffix;
											self.parent_org_postdir						:=	right.postdir;
											self.parent_org_unit_desig				:=	right.unit_desig;
											self.parent_org_sec_range					:=	right.sec_range;
											self.parent_org_p_city_name				:=	right.p_city_name;
											self.parent_org_v_city_name				:=	right.v_city_name;
											self.parent_org_state							:=	right.state;
											self.parent_org_zip5							:=	right.zip5;
											self.parent_org_zip4							:=	right.zip4;
											self.parent_org_cart							:=	right.cart;
											self.parent_org_cr_sort_sz				:=	right.cr_sort_sz;
											self.parent_org_lot								:=	right.lot;
											self.parent_org_lot_order					:=	right.lot_order;
											self.parent_org_dpbc							:=	right.dpbc;
											self.parent_org_chk_digit					:=	right.chk_digit;
											self.parent_org_rec_type					:=	right.rec_type;
											self.parent_org_fips_st						:=	right.fips_st;
											self.parent_org_fips_county				:=	right.fips_county;
											self.parent_org_geo_lat						:=	right.geo_lat;
											self.parent_org_geo_long					:=	right.geo_long;
											self.parent_org_msa								:=	right.msa;
											self.parent_org_geo_blk						:=	right.geo_blk;
											self.parent_org_geo_match					:=	right.geo_match;
											self.parent_org_err_stat					:=	right.err_stat;
											self															:=	left)
										,left outer
										,local);
		base_g	:= dedup(sort(base_g0, record, local), record, local);

		eprescribe_ncpdp	:= sort(distribute(Files().eprescribe_base.built, hash(ncpdp_provider_id)), ncpdp_provider_id, local);
		base_h0	:= JOIN(sort(distribute(base_g, hash(ncpdp_provider_id)), ncpdp_provider_id, local), eprescribe_ncpdp,
										LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
										TRANSFORM({base_g},
											self.record_type													:=	if(right.record_type = 'H', right.record_type, left.record_type);					
											self.eprescribe_network_id								:=	right.network_id;
											self.eprescribe_service_level_codes				:=	right.service_level_codes;
											self.eprescribe_clean_effect_from_date		:=	right.clean_effect_from_date;
											self.eprescribe_clean_effect_through_date	:=	right.clean_effect_through_date;
											self																			:=	left)
										,left outer
										,local);
		base_h	:= dedup(sort(base_h0, record, local), record, local);
		remit_id	:= sort(distribute(Files().remit_info_base.built, hash(id)), id, local);
		base_i0	:= JOIN(sort(distribute(base_h, hash(prov_relat_remit_and_reconciliation_id)), prov_relat_remit_and_reconciliation_id, local), remit_id,
										LEFT.prov_relat_remit_and_reconciliation_id = RIGHT.id,
										TRANSFORM({base_h},
											self.record_type						:=	if(right.record_type = 'H', right.record_type, left.record_type);					
											self.remit_id								:=	right.id;
											self.remit_name							:=	right.name;
											self.remit_address_1				:=	right.address_1;
											self.remit_address_2				:=	right.address_2;
											self.remit_city							:=	right.city;
											self.remit_state_code				:=	right.state_code;
											self.remit_zip_code					:=	right.zip_code;
											self.remit_phone						:=	right.phone;
											self.remit_extension				:=	right.extension;
											self.remit_fax							:=	right.fax;
											self.remit_npi							:=	right.npi;
											self.remit_federal_tax_id		:=	right.federal_tax_id;
											self.remit_contact_name			:=	right.contact_name;
											self.remit_contact_title		:=	right.contact_title;
											self.remit_contact_email		:=	right.contact_email;
											self.remit_clean_delete_date:=	right.clean_delete_date;
											self.remit_Append_Addr1			:=	right.Append_Addr1;
											self.remit_Append_AddrLast	:=	right.Append_AddrLast;
											self.remit_Append_RawAID		:=	right.Append_RawAID;
											self.remit_Append_AceAID		:=	right.Append_AceAID;
											self.remit_contact_fname		:=	right.contact_fname;
											self.remit_contact_mname		:=	right.contact_mname;
											self.remit_contact_lname		:=	right.contact_lname;
											self.remit_contact_suffix		:=	right.contact_suffix;		
											self.remit_prim_range				:=	right.prim_range;
											self.remit_predir						:=	right.predir;
											self.remit_prim_name				:=	right.prim_name;
											self.remit_addr_suffix			:=	right.addr_suffix;
											self.remit_postdir					:=	right.postdir;
											self.remit_unit_desig				:=	right.unit_desig;
											self.remit_sec_range				:=	right.sec_range;
											self.remit_p_city_name			:=	right.p_city_name;
											self.remit_v_city_name			:=	right.v_city_name;
											self.remit_state						:=	right.state;
											self.remit_zip5							:=	right.zip5;
											self.remit_zip4							:=	right.zip4;
											self.remit_cart							:=	right.cart;
											self.remit_cr_sort_sz				:=	right.cr_sort_sz;
											self.remit_lot							:=	right.lot;
											self.remit_lot_order				:=	right.lot_order;
											self.remit_dpbc							:=	right.dpbc;
											self.remit_chk_digit				:=	right.chk_digit;
											self.remit_rec_type					:=	right.rec_type;
											self.remit_fips_st					:=	right.fips_st;
											self.remit_fips_county			:=	right.fips_county;
											self.remit_geo_lat					:=	right.geo_lat;
											self.remit_geo_long					:=	right.geo_long;
											self.remit_msa							:=	right.msa;
											self.remit_geo_blk					:=	right.geo_blk;
											self.remit_geo_match				:=	right.geo_match;
											self.remit_err_stat					:=	right.err_stat;
											self												:=	left)
										,left outer
										,local);
		
		base_i	:= dedup(sort(base_i0, record, local), record, local);
		state_lic_ncpdp	:= sort(distribute(Files().state_license_base.built, hash(ncpdp_provider_id)), ncpdp_provider_id, local);
		
		base_j0	:= JOIN(sort(distribute(base_i, hash(ncpdp_provider_id)), ncpdp_provider_id, local), state_lic_ncpdp,
										LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
										TRANSFORM({base_i},
											self.record_type												:=	if(right.record_type = 'H', right.record_type, left.record_type);				
											self.state_code													:=	right.state_code;
											self.state_license_number								:=	right.license_number;
											self.state_license_clean_expiration_date:=	right.clean_expiration_date;
											self.state_license_clean_delete_date		:=	right.clean_delete_date;
											self																		:=	left)
										,left outer
										,local);
		base_j	:= dedup(sort(base_j0, ncpdp_provider_id, local), record, local);

		services_ncpdp	:= sort(distribute(Files().services_info_base.built, hash(ncpdp_provider_id)), ncpdp_provider_id, local);
		base_k0	:= JOIN(sort(distribute(base_j, hash(ncpdp_provider_id)), ncpdp_provider_id, local), services_ncpdp,
										LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
										TRANSFORM({base_j},
											self.record_type															:=	if(right.record_type = 'H', right.record_type, left.record_type);				
											self.service_accepts_eprescribe_indicator			:=	right.accepts_eprescribe_indicator;
											self.service_accepts_eprescribe_code					:=	right.accepts_eprescribe_code;
											self.service_delivery_service_indicator				:=	right.delivery_service_indicator;
											self.service_delivery_service_code						:=	right.delivery_service_code;
											self.service_compounding_service_indicator		:=	right.compounding_service_indicator;
											self.service_compounding_service_code					:=	right.compounding_service_code;
											self.service_driveup_window_indicator					:=	right.driveup_window_indicator;
											self.service_driveup_window_code							:=	right.driveup_window_code;
											self.service_dme_indicator										:=	right.dme_indicator;
											self.service_dme_code													:=	right.dme_code;
											self.service_walkin_clinic_indicator					:=	right.walkin_clinic_indicator;
											self.service_walkin_code											:=	right.walkin_code;
											self.service_emergency_24hr_service_indicator	:=	right.emergency_24hr_service_indicator;
											self.service_emergency_24hr_service_code			:=	right.emergency_24hr_service_code;
											self.service_multi_dose_compliance_indicator	:=	right.multi_dose_compliance_indicator;
											self.service_multi_dose_compliance_code				:=	right.multi_dose_compliance_code;
											self.service_immunizations_provided_indicator	:=	right.immunizations_provided_indicator;
											self.service_immunizations_provided_code			:=	right.immunizations_provided_code;
											self.service_handicapped_accessible_indicator	:=	right.handicapped_accessible_indicator;
											self.service_handicapped_accessible_code			:=	right.handicapped_accessible_code;
											self.service_status_340B_indicator						:=	right.status_340B_indicator;
											self.service_status_340B_code									:=	right.status_340B_code;
											self.service_closed_door_facility_indicator		:=	right.closed_door_facility_indicator;
											self.service_closed_door_facility_code				:=	right.closed_door_facility_code;
											self																					:=	left)
										,left outer
										,local);
		base_k	:= dedup(sort(base_k0, record, local), record, local);
		
		change_owner_ncpdp	:= sort(distribute(Files().change_owner_base.built, hash(ncpdp_provider_id)), ncpdp_provider_id, local);
		base_l0	:= JOIN(sort(distribute(base_k, hash(ncpdp_provider_id)), ncpdp_provider_id, local), change_owner_ncpdp,
										LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id,
										TRANSFORM({base_k},
											self.record_type																		:=	if(right.record_type = 'H', right.record_type, left.record_type);
											self.change_ownership_old_NCPDP_provider_id					:=	right.old_NCPDP_provider_id;
											self.change_ownership_clean_old_store_close_date		:=	right.clean_old_store_close_date;
											self.change_ownership_clean_change_owner_effect_date:=	right.clean_change_owner_effect_date;
											self																		:=	left)
										,left outer
										,local);
		base_l	:= dedup(sort(base_l0, record, local), record, local);
		base_l GetSourceRID(base_l L)	:= TRANSFORM
						self.source_rid 		:= HASH64(hashmd5(
																	trim(l.prov_info_legal_business_name)
																	,trim(l.prov_info_DBA)
																	,trim(l.prov_info_doctor_name)
																	,trim(l.prov_info_store_number)
																	,trim(l.prov_info_phys_loc_address1)
																	,trim(l.prov_info_phys_loc_address2)
																	,trim(l.prov_info_phys_loc_phone)
																	,trim(l.prov_info_phys_loc_fax_number)
																	,trim(l.prov_info_DEA_registration_id)
																	,(l.prov_info_clean_DEA_expiration_date)
																	,trim(l.prov_info_medicare_provider_id)
																	,trim(l.prov_info_national_provider_id)
																	,trim(l.prov_info_federal_tax_id)
																	,trim(l.prov_info_state_income_tax_id)
																	,trim(l.medicaid_id)
																	,trim(l.demographic_name)
																	,trim(l.demographic_phone_number)
																	,trim(l.demographic_npi)
																	,trim(l.demographic_federal_tax_id)
																	,trim(l.pay_center_name)
																	,trim(l.pay_center_npi)
																	,trim(l.pay_center_federal_tax_id)
																	,trim(l.parent_org_name)
																	,trim(l.parent_org_npi)
																	,trim(l.parent_org_federal_tax_id)
																	,trim(l.state_license_number)
																	,trim(l.remit_id)
																	,trim(l.remit_name)
																	,trim(l.remit_npi)
																	,trim(l.remit_federal_tax_id)
																	));
			SELF											:= L;
		END;
		
		dist_base_l	:= distribute(base_l);// get even distribution and order does not matter
		base_m0 := project(dist_base_l, GetSourceRID(left));//:persist('~thor_data400::persist::ncpdp_after_source_rid');
		base_m	:= dedup(sort(base_m0, record, local), record, local);
		
		base_m_dedup	:= dedup(sort(distribute(base_m, hash(ncpdp_provider_id, prov_info_clean_dr_fname, prov_info_clean_dr_mname,
											prov_info_clean_dr_lname, prov_info_clean_dr_suffix, prov_info_phys_prim_range, prov_info_phys_prim_name, 
											prov_info_phys_sec_range,	prov_info_phys_p_city_name, prov_info_phys_state, prov_info_phys_zip5, 
											prov_info_contact_phone, state_code, state_license_number, prov_info_federal_tax_id, 
											prov_info_DEA_registration_id, prov_info_national_provider_id, DID, BDID, source_rid)),
											ncpdp_provider_id, prov_info_clean_dr_fname, prov_info_clean_dr_mname,
											prov_info_clean_dr_lname, prov_info_clean_dr_suffix, prov_info_phys_prim_range, prov_info_phys_prim_name, 
											prov_info_phys_sec_range,	prov_info_phys_p_city_name, prov_info_phys_state, prov_info_phys_zip5, 
											prov_info_contact_phone, state_code, state_license_number, prov_info_federal_tax_id, 
											prov_info_DEA_registration_id, prov_info_national_provider_id, DID, BDID, source_rid, local), 
											ncpdp_provider_id, prov_info_clean_dr_fname, prov_info_clean_dr_mname,
											prov_info_clean_dr_lname, prov_info_clean_dr_suffix, prov_info_phys_prim_range, prov_info_phys_prim_name, 
											prov_info_phys_sec_range,	prov_info_phys_p_city_name, prov_info_phys_state, prov_info_phys_zip5, 
											prov_info_contact_phone, state_code, state_license_number, prov_info_federal_tax_id, 
											prov_info_DEA_registration_id, prov_info_national_provider_id, DID, BDID, source_rid, local);
		
		Health_Provider_Services.mac_get_best_lnpid_on_thor (
				base_m_dedup
				,lnpid
				,prov_info_clean_dr_fname//FNAME
				,prov_info_clean_dr_mname//MNAME
				,prov_info_clean_dr_lname//LNAME
				,prov_info_clean_dr_suffix//name_suffix
				,//GENDER
				,prov_info_Phys_prim_range
				,prov_info_Phys_prim_name
				,prov_info_Phys_sec_range
				,prov_info_Phys_p_city_name
				,prov_info_Phys_state
				,prov_info_Phys_zip5
				,//clean_SSN
				,//clean_DOB
				,prov_info_contact_phone
				,state_code//LIC_STATE
				,state_license_number//LIC_Num_in
				,prov_info_federal_tax_id//TAX_ID
				,prov_info_DEA_registration_id//DEA_NUM
				,NCPDP_provider_id//group_key
				,prov_info_national_provider_id
				,//UPIN
				,DID
				,BDID
				,//src//SRC
				,source_rid//SOURCE_RID
				,result1,false,38
			);
			
			still_blank := distribute(result1(lnpid = 0));
			has_lnpid		:= distribute(result1(lnpid > 0));
			
	Health_Facility_Services.mac_get_best_lnpid_on_thor (
					still_blank
					,LNPID
					,prov_info_legal_business_name	
					,prov_info_Phys_prim_range
					,prov_info_Phys_prim_name
					,prov_info_Phys_sec_range
					,prov_info_Phys_p_city_name
					,prov_info_Phys_state
					,prov_info_Phys_zip5
					,//
					,parent_org_federal_tax_id//TAX_ID
					,parent_org_npi
					,parent_org_fax
					,state_code
					,state_license_number
					,prov_info_DEA_registration_id
					,NCPDP_provider_id
					,prov_info_national_provider_id
					,//clia_num
					,//medicare_fac_num
					,//Input_MEDICAID_NUMBER
					,NCPDP_provider_id
					,taxonomy_code
					,BDID
					,//SRC
					,//SOURCE_RID
					,result2
					,false
					,30
					);
			
			result := has_lnpid + result2;
			
			sort_base_m	:= sort(distribute(base_m, hash(ncpdp_provider_id, prov_info_clean_dr_fname, prov_info_clean_dr_mname,
											prov_info_clean_dr_lname, prov_info_clean_dr_suffix, prov_info_phys_prim_range, prov_info_phys_prim_name, 
											prov_info_phys_sec_range,	prov_info_phys_p_city_name, prov_info_phys_state, prov_info_phys_zip5, 
											prov_info_contact_phone, state_code, state_license_number, prov_info_federal_tax_id, 
											prov_info_DEA_registration_id, prov_info_national_provider_id, DID, BDID, source_rid)), 
											ncpdp_provider_id, prov_info_clean_dr_fname, prov_info_clean_dr_mname, 
											prov_info_clean_dr_lname, prov_info_clean_dr_suffix, prov_info_phys_prim_range, prov_info_phys_prim_name, 
											prov_info_phys_sec_range,	prov_info_phys_p_city_name, prov_info_phys_state, prov_info_phys_zip5, 
											prov_info_contact_phone, state_code, state_license_number, prov_info_federal_tax_id, 
											prov_info_DEA_registration_id, prov_info_national_provider_id, DID, BDID, source_rid, local);
											
			sort_result	:= sort(distribute(result, hash(ncpdp_provider_id, prov_info_clean_dr_fname, prov_info_clean_dr_mname,
											prov_info_clean_dr_lname, prov_info_clean_dr_suffix, prov_info_phys_prim_range, prov_info_phys_prim_name, 
											prov_info_phys_sec_range,	prov_info_phys_p_city_name, prov_info_phys_state, prov_info_phys_zip5, 
											prov_info_contact_phone, state_code, state_license_number, prov_info_federal_tax_id, 
											prov_info_DEA_registration_id, prov_info_national_provider_id, DID, BDID, source_rid)), 
											ncpdp_provider_id, prov_info_clean_dr_fname, prov_info_clean_dr_mname,
											prov_info_clean_dr_lname, prov_info_clean_dr_suffix, prov_info_phys_prim_range, prov_info_phys_prim_name, 
											prov_info_phys_sec_range,	prov_info_phys_p_city_name, prov_info_phys_state, prov_info_phys_zip5, 
											prov_info_contact_phone, state_code, state_license_number, prov_info_federal_tax_id, 
											prov_info_DEA_registration_id, prov_info_national_provider_id, DID, BDID, source_rid, local);

			rejoin_lnpid	:= join(sort_base_m, sort_result,
							left.ncpdp_provider_id					= right.ncpdp_provider_id
					and	left.prov_info_clean_dr_fname		= right.prov_info_clean_dr_fname
					and left.prov_info_clean_dr_mname		= right.prov_info_clean_dr_mname
					and left.prov_info_clean_dr_lname		= right.prov_info_clean_dr_lname
					and left.prov_info_clean_dr_suffix	= right.prov_info_clean_dr_suffix
					and left.prov_info_phys_prim_range	= right.prov_info_phys_prim_range
					and left.prov_info_phys_prim_name		= right.prov_info_phys_prim_name
					and left.prov_info_phys_sec_range		= right.prov_info_phys_sec_range
					and left.prov_info_phys_p_city_name	= right.prov_info_phys_p_city_name
					and left.prov_info_phys_state				= right.prov_info_phys_state
					and left.prov_info_phys_zip5				= right.prov_info_phys_zip5
					and left.prov_info_contact_phone		= right.prov_info_contact_phone
					and left.state_code									= right.state_code
					and left.state_license_number				= right.state_license_number
					and left.prov_info_federal_tax_id		= right.prov_info_federal_tax_id
					and left.prov_info_national_provider_id		= right.prov_info_national_provider_id
					and left.did					= right.did
					and left.bdid 				= right.bdid
					and left.source_rid		= right.source_rid
			,TRANSFORM({base_m}
					,SELF.lnpid						:= right.lnpid
					,SELF									:= left)
					,LEFT OUTER
					,LOCAL);					
		
			all_lnpid	:= dedup(sort(rejoin_lnpid, record, local), record, local);
							
			//base_o	:= dedup(base_n, all);		
			// dDistributed  := distribute(all_lnpid,hash(NCPDP_provider_id));	
			dDistributed  := distribute(all_lnpid);	
			// BaseSort := SORT(dDistributed, ncpdp_provider_id,  dt_first_seen,	dt_last_seen, record_type, local);
			BaseSort := SORT(dDistributed, record);
      // BaseDedup := DEDUP(BaseSort,ncpdp_provider_id, dt_first_seen,	dt_last_seen, local); 
      BaseDedup := DEDUP(BaseSort,ncpdp_provider_id, dt_first_seen,	dt_last_seen, BEST(record_type)); 
			
			BaseDedup add_sid(BaseDedup L) := TRANSFORM
				SELF.global_sid								:= 23921;
				SELF.record_sid								:= L.source_rid;
				SELF						 							:= L;
			END;
	
			with_ccpa := project(BaseDedup, add_sid (left));
			
			dist_with_ccpa	:= sort(distribute(with_ccpa), record);
			
		return dist_with_ccpa;
	end;
	
    export keybuild (string pversion)    := function
        // The layout of final_base is layouts.base.combined_file
        giant_file     := distribute(Files().final_base.built, hash(ncpdp_provider_id));

        // The added record_type is caught up in the generalized copy
        Layouts.Keybuild combine1(giant_file L)   := TRANSFORM
            self.legal_business_name              :=    l.prov_info_legal_business_name;
            self.DBA                              :=    l.prov_info_DBA;
            self.store_number                     :=    l.prov_info_store_number;
            self.phys_loc_address1                :=    l.prov_info_phys_loc_address1;
            self.phys_loc_address2                :=    l.prov_info_phys_loc_address2;
            self.phys_loc_city                    :=    l.prov_info_phys_loc_city;
            self.phys_loc_state                   :=    l.prov_info_phys_loc_state;
            self.phys_loc_full_zip                :=    l.prov_info_phys_loc_full_zip;
            self.phys_loc_phone                   :=    l.prov_info_phys_loc_phone;
            self.phys_loc_phone_ext               :=    l.prov_info_phys_loc_phone_ext;
            self.phys_loc_fax_number              :=    l.prov_info_phys_loc_fax_number;
            self.phys_loc_email                   :=    l.prov_info_phys_loc_email;
            self.phys_loc_cross_street            :=    l.prov_info_phys_loc_cross_street;    
            self.phys_loc_FIPS                    :=    l.prov_info_phys_loc_FIPS;
            self.phys_loc_MSA                     :=    l.prov_info_phys_loc_MSA;
            self.phys_loc_PMSA                    :=    l.prov_info_phys_loc_PMSA;
            self.phys_loc_24hr_operation          :=    l.prov_info_phys_loc_24hr_operation;
            self.phys_loc_provider_hours          :=    l.prov_info_phys_loc_provider_hours;
            self.phys_loc_accepts_ePrescriptions  :=    l.service_accepts_ePrescribe_indicator;
            self.phys_loc_delivery_service        :=    l.service_delivery_service_indicator;
            self.phys_loc_compounding_service     :=    l.service_compounding_service_indicator;
            self.phys_loc_driveup_window          :=    l.service_driveup_window_indicator;
            self.phys_loc_durable_med_equip       :=    l.service_dme_indicator;
            self.phys_loc_voting_district         :=    l.prov_info_phys_loc_voting_district;
            self.phys_loc_language_code1          :=    l.prov_info_phys_loc_language_code1;
            self.phys_loc_language_code2          :=    l.prov_info_phys_loc_language_code2;
            self.phys_loc_language_code3          :=    l.prov_info_phys_loc_language_code3;
            self.phys_loc_language_code4          :=    l.prov_info_phys_loc_language_code4;
            self.phys_loc_language_code5          :=    l.prov_info_phys_loc_language_code5;
            self.phys_loc_handicap_access         :=    l.service_handicapped_accessible_indicator;
            self.phys_loc_store_open_date         :=    l.prov_info_phys_loc_store_open_date;    
            self.phys_loc_store_close_date        :=    l.prov_info_phys_loc_store_close_date;
            self.address1                         :=    l.prov_info_address1;
            self.address2                         :=    l.prov_info_address2;
            self.city                             :=    l.prov_info_city;
            self.state                            :=    l.prov_info_state;
            self.full_zip                         :=    l.prov_info_full_zip;
            self.contact_last_name                :=    l.prov_info_contact_last_name;
            self.contact_first_name               :=    l.prov_info_contact_first_name;
            self.contact_middle_initial           :=    l.prov_info_contact_middle_initial;
            self.contact_title                    :=    l.prov_info_contact_title;
            self.contact_phone                    :=    l.prov_info_contact_phone;
            self.contact_phone_ext                :=    l.prov_info_contact_phone_ext;
            self.contact_email                    :=    l.prov_info_contact_email;
            self.dispenser_class_code             :=    l.prov_info_dispenser_class_code;
            self.primary_dispenser_type_code      :=    l.prov_info_primary_dispenser_type_code;
            self.secondary_dispenser_type_code    :=    l.prov_info_secondary_dispenser_type_code;
            self.tertiary_dispenser_type_code     :=    l.prov_info_tertiary_dispenser_type_code;
            self.medicare_provider_id             :=    l.prov_info_medicare_provider_id;
            self.national_provider_id             :=    l.prov_info_national_provider_id;
            self.DEA_registration_id              :=    l.prov_info_DEA_registration_id;
            self.federal_tax_id                   :=    l.prov_info_federal_tax_id;
            self.state_license_number             :=    l.state_license_number;
            self.state_income_tax_id              :=    l.prov_info_state_income_tax_id;
            self.SundayHours                      :=    l.prov_info_SundayHours;
            self.MondayHours                      :=    l.prov_info_MondayHours;
            self.TuesdayHours                     :=    l.prov_info_TuesdayHours;
            self.WednesdayHours                   :=    l.prov_info_WednesdayHours;
            self.ThursdayHours                    :=    l.prov_info_ThursdayHours;
            self.FridayHours                      :=    l.prov_info_FridayHours;
            self.SaturdayHours                    :=    l.prov_info_SaturdayHours;
            self.languageCode1Desc                :=    l.prov_info_languageCode1Desc;
            self.languageCode2Desc                :=    l.prov_info_languageCode2Desc;
            self.languageCode3Desc                :=    l.prov_info_languageCode3Desc;
            self.languageCode4Desc                :=    l.prov_info_languageCode4Desc;
            self.languageCode5Desc                :=    l.prov_info_languageCode5Desc;
            self.dispensingClassDesc              :=    l.prov_info_dispensingClassDesc;
            self.PrimaryDispensingTypeDesc        :=    l.prov_info_PrimaryDispensingTypeDesc;
            self.SecondaryDispensingTypeDesc      :=    l.prov_info_SecondaryDispensingTypeDesc;
            self.TertiaryDispensingTypeDesc       :=    l.prov_info_TertiaryDispensingTypeDesc;
            self.Append_PhyAddr1                  :=    l.prov_info_Append_PhyAddr1;
            self.Append_PhyAddrLast               :=    l.prov_info_Append_PhyAddrLast;
            self.Append_PhyRawAID                 :=    l.prov_info_Append_PhyRawAID;
            self.Append_PhyAceAID                 :=    l.prov_info_Append_PhyAceAID;            
            self.Append_MailAddr1                 :=    l.prov_info_Append_MailAddr1;
            self.Append_MailAddrLast              :=    l.prov_info_Append_MailAddrLast;
            self.Append_MailRawAID                :=    l.prov_info_Append_MailRawAID;
            self.Append_MailAceAID                :=    l.prov_info_Append_MailAceAID;    
            self.fname                            :=    l.prov_info_clean_fname;
            self.mname                            :=    l.prov_info_clean_mname;
            self.lname                            :=    l.prov_info_clean_lname;
            self.suffix                           :=    l.prov_info_clean_suffix;    
            self.Phys_prim_range                  :=    l.prov_info_Phys_prim_range;
            self.Phys_predir                      :=    l.prov_info_Phys_predir;
            self.Phys_prim_name                   :=    l.prov_info_Phys_prim_name;
            self.Phys_addr_suffix                 :=    l.prov_info_Phys_addr_suffix;
            self.Phys_postdir                     :=    l.prov_info_Phys_postdir;    
            self.Phys_unit_desig                  :=    l.prov_info_Phys_unit_desig;
            self.Phys_sec_range                   :=    l.prov_info_Phys_sec_range;
            self.Phys_p_city_name                 :=    l.prov_info_Phys_p_city_name;
            self.Phys_v_city_name                 :=    l.prov_info_Phys_v_city_name;
            self.Phys_state                       :=    l.prov_info_Phys_state;
            self.Phys_zip5                        :=    l.prov_info_Phys_zip5;
            self.Phys_zip4                        :=    l.prov_info_Phys_zip4;
            self.Phys_cart                        :=    l.prov_info_Phys_cart;
            self.Phys_cr_sort_sz                  :=    l.prov_info_Phys_cr_sort_sz;
            self.Phys_lot                         :=    l.prov_info_Phys_lot;
            self.Phys_lot_order                   :=    l.prov_info_Phys_lot_order;
            self.Phys_dpbc                        :=    l.prov_info_Phys_dpbc;
            self.Phys_chk_digit                   :=    l.prov_info_Phys_chk_digit;
            self.Phys_rec_type                    :=    l.prov_info_Phys_rec_type;
            self.Phys_ace_fips_st                 :=    l.prov_info_Phys_ace_fips_st;
            self.Phys_county                      :=    l.prov_info_Phys_county;
            self.Phys_geo_lat                     :=    l.prov_info_Phys_geo_lat;
            self.Phys_geo_long                    :=    l.prov_info_Phys_geo_long;
            self.Phys_msa                         :=    l.prov_info_Phys_msa;
            self.Phys_geo_blk                     :=    l.prov_info_Phys_geo_blk;
            self.Phys_geo_match                   :=    l.prov_info_Phys_geo_match;
            self.Phys_err_stat                    :=    l.prov_info_Phys_err_stat;
            self.Mail_prim_range                  :=    l.prov_info_Mail_prim_range;
            self.Mail_predir                      :=    l.prov_info_Mail_predir;
            self.Mail_prim_name                   :=    l.prov_info_Mail_prim_name;
            self.Mail_addr_suffix                 :=    l.prov_info_Mail_addr_suffix;
            self.Mail_postdir                     :=    l.prov_info_Mail_postdir;
            self.Mail_unit_desig                  :=    l.prov_info_Mail_unit_desig;
            self.Mail_sec_range                   :=    l.prov_info_Mail_sec_range;
            self.Mail_p_city_name                 :=    l.prov_info_Mail_p_city_name;
            self.Mail_v_city_name                 :=    l.prov_info_Mail_v_city_name;
            self.Mail_state                       :=    l.prov_info_Mail_state;
            self.Mail_zip5                        :=    l.prov_info_Mail_zip5;
            self.Mail_zip4                        :=    l.prov_info_Mail_zip4;
            self.Mail_cart                        :=    l.prov_info_Mail_cart;
            self.Mail_cr_sort_sz                  :=    l.prov_info_Mail_cr_sort_sz;
            self.Mail_lot                         :=    l.prov_info_Mail_lot;
            self.Mail_lot_order                   :=    l.prov_info_Mail_lot_order;
            self.Mail_dpbc                        :=    l.prov_info_Mail_dpbc;
            self.Mail_chk_digit                   :=    l.prov_info_Mail_chk_digit;
            self.Mail_rec_type                    :=    l.prov_info_Mail_rec_type;
            self.Mail_ace_fips_st                 :=    l.prov_info_Mail_ace_fips_st;
            self.Mail_county                      :=    l.prov_info_Mail_county;
            self.Mail_geo_lat                     :=    l.prov_info_Mail_geo_lat;
            self.Mail_geo_long                    :=    l.prov_info_Mail_geo_long;
            self.Mail_msa                         :=    l.prov_info_Mail_msa;
            self.Mail_geo_blk                     :=    l.prov_info_Mail_geo_blk;
            self.Mail_geo_match                   :=    l.prov_info_Mail_geo_match;
            self.Mail_err_stat                    :=    l.prov_info_Mail_err_stat;
            self                                  :=    l;
        end;                                      
        
				slimmed_file	:= project(giant_file, combine1(LEFT));
				
				dDedup:=dedup(sort(slimmed_file, record, local), record, local);
				
				return dDedup;
    end;

end;