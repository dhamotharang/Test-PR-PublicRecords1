// ================================================================================
// = FOR BIP2, RETURNS AMS License RECORDS FOR A GIVEN ENTITY IN ESP-COMPLIANT WAY =
// ================================================================================
// uses V1 layouts (both in ECL and ESP)

IMPORT BIPV2, iesp, Healthcare_Header_Services, STD, TopBusiness_Services;

EXPORT AMSSource_Records ( 
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
	SourceService_Layouts.OptionsLayout inoptions,
  boolean IsFCRA = false,
	unsigned max_penalty = 10) 
	:= MODULE
	
	SHARED ams_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		Healthcare_Header_Services.Layouts.CombinedHeaderResults -acctno;
	END;
	
	SHARED ams_key_layout := RECORD
			STRING8	ams_id;
			Layouts.rec_input_ids_wSrc;
	END;
	
	// For in_docids records that don't have SourceDocIds (ams_id's) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get all ams ids for the input linkids
  ds_amskeys := PROJECT(TopBusiness_Services.Key_Fetches(in_docs_linkonly,inoptions.fetch_level
	                                                      ).ds_ams_linkidskey_recs,
												TRANSFORM(Layouts.rec_input_ids_wSrc,
												   SELF.IdValue := TRIM(LEFT.ams_id) + '||', // Add trailing delimiter
													 SELF := LEFT,
													 SELF := []));

	ams_keys_comb := in_docids+ds_amskeys;
	
	ams_keys := PROJECT(ams_keys_comb(IdValue != ''),
								TRANSFORM(Healthcare_Header_Services.Layouts.searchKeyResults_plus_input,
										SELF.acctno := '1',
										SELF.src := Healthcare_Header_Services.Constants.SRC_AMS,
										// idValue is assumed in ams_id|state|license# format.
										delim := StringLib.StringFind(LEFT.IdValue,'|',1);
										SELF.prov_id := (integer) LEFT.IdValue[1..delim-1],
										SELF := []));
	
	ams_keys_dedup := DEDUP(ams_keys,ALL);
	
  // fetch main records via Healhcare Provider service
	cfg := dataset([],Healthcare_Header_Services.Layouts.common_runtime_config);
	ams_sourceview := Healthcare_Header_Services.Datasource_AMS.get_ams_entity(ams_keys_dedup, cfg); 
	
			
	SHARED ams_sourceview_wLinkIds := JOIN(ams_sourceview,ams_keys_comb,
																			// delim := StringLib.StringFind(RIGHT.IdValue,'|',1);
																			LEFT.srcid = (integer) RIGHT.IdValue[1..StringLib.StringFind(RIGHT.IdValue,'|',1)-1],
																			TRANSFORM(ams_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																			KEEP(1));   // For cases in which a idvalue has multiple linkids;
	
	SHARED iesp.healthcare.t_MedicalSchool xform_MedSchool(Healthcare_Header_Services.Layouts.layout_medschool L) := TRANSFORM
			self.Name 					:= L.medschoolname;
			self.GraduationYear := (Integer)L.graduationyear;
			self := [];
	END;
	
	SHARED iesp.healthcare.t_Specialty xform_Specialty(Healthcare_Header_Services.Layouts.layout_specialty L) := TRANSFORM
			self.SpecialtyId 		:= (String)L.specialtyid; 
			self.SpecialtyName 	:= L.specialtyname;
			self.GroupId 				:= (String)L.specialtygroupid;
			self.GroupName 			:= L.specialtygroupname;
			self := [];
	END;
	
	SHARED iesp.healthcare.t_ProviderLicenseInfo xform_License(Healthcare_Header_Services.Layouts.layout_licenseinfo L) := TRANSFORM
			self.LicenseState 	:= L.licensestate;
			self.LicenseNumber 	:= L.licensenumber;
			self.EffectiveDate 	:= iesp.ECL2ESP.toDatestring8(L.effective_date);
			self.ExpirationDate	:= iesp.ECL2ESP.toDatestring8(L.termination_date);
			self := [];
	END;
	
	iesp.americanmedicalservices.t_AmericanMedicalServicesProvider toOut (ams_layout_wLinkIds L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids()	
		provIDs := project(L.dids(did > 0), transform (iesp.share.t_StringArrayItem, Self.value := (string)(unsigned6)Left.did));
		provFein := project(L.taxids(taxid<>''), transform (iesp.share.t_StringArrayItem, Self.value := Left.taxid));
		provBusAddr := project(L.addresses, Healthcare_Header_Services.Transforms.processAddressSearchService(left));
		FullName := L.names[1].CompanyName;
		provNames := project(L.names, transform(iesp.share.t_Name, self := iesp.ECL2ESP.SetName(left.firstName, left.middleName, left.lastName, left.suffix,left.title,fullName)));
		self.ProviderId := (string)L.srcid;
		self.ProviderSrc := L.src;
		genderData := L.names(gender<>'');
		self.sex := map(genderData[1].gender = 'M' => 'MALE', genderData[1].gender = 'F' => 'FEMALE','');
		self.UniqueIds := choosen(dedup(sort(provIDs,record),record),iesp.Constants.HPR.MAX_UNIQUEIDS);
		self.Names := choosen(dedup(sort(provNames,record),record),iesp.Constants.HPR.MAX_NAMES);
		self.Languages := project(choosen(dedup(L.languages,all,hash),iesp.Constants.HPR.MAX_LANGUAGES), transform (iesp.share.t_StringArrayItem, Self.value := Left.language));
		self.DOBs := project(choosen(L.dobs,iesp.Constants.HPR.MAX_DOBS), transform (iesp.share.t_Date, Self := iesp.ECL2ESP.ApplyDateMask(iesp.ECL2ESP.toDatestring8(Left.dob),1)));
		self.TaxIds := project(choosen(L.taxids,iesp.Constants.HPR.MAX_TAXIDS), transform (iesp.share.t_StringArrayItem, Self.value := Left.taxid));
		self.UPINs := project(choosen(dedup(sort(L.upins,upin),upin),iesp.Constants.HPR.MAX_UPINS), transform (iesp.share.t_StringArrayItem, Self.value := Left.upin));
		self.Degrees := project(choosen(dedup(sort(L.degrees,degree),degree),iesp.Constants.HPR.MAX_DEGREES), transform (iesp.share.t_StringArrayItem, Self.value := Left.degree));
		npi_dup_rec := choosen(dedup(sort(L.npis,npi),npi),iesp.Constants.HPR.MAX_NPIS);
		self.NationalProviderIds := project(choosen(npi_dup_rec,iesp.Constants.HPR.MAX_NPIS), transform (iesp.share.t_StringArrayItem, Self.value := Left.npi));
		self.GroupAffiliations := project(choosen(dedup(sort(L.affiliates,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)),iesp.Constants.HPR.MAX_GROUPAFFILIATIONS), transform (iesp.healthcare.t_ProviderRelatedEntity,self:=left,self:=[]));
		self.HospitalAffiliations := project(choosen(dedup(sort(L.hospitals,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)),iesp.Constants.HPR.MAX_HOSPITALAFFILIATIONS),  transform (iesp.healthcare.t_ProviderRelatedEntity,self:=left,self:=[]));
		self.Residencies := project(choosen(dedup(sort(L.Residencies,residency),residency),iesp.Constants.HPR.MAX_RESIDENCIES), transform(iesp.healthcare.t_ProviderRelatedEntity, self.Name:=left.residency, self := []));
		self.MedicalSchools := project(choosen(dedup(sort(L.medschools,medschoolname,-graduationyear),medschoolname,graduationyear),iesp.Constants.HPR.MAX_MEDICALSCHOOLS), xform_MedSchool(LEFT));
		self.Specialties := project(choosen(dedup(sort(L.Specialties,specialtyname,specialtygroupname),stringlib.StringToLowerCase(specialtyname),stringlib.StringToLowerCase(specialtygroupname)),iesp.Constants.HPR.MAX_SPECIALTIES),xform_Specialty(LEFT));
		self.Licenses := project(choosen(L.StateLicenses,iesp.Constants.HPR.MAX_LICENSES), xform_License(LEFT));
		self.FEINs := choosen(dedup(sort(provFein,record),record),iesp.Constants.HPR.MAX_TAXIDS);
		self.BusinessAddresses := choosen(provBusAddr,iesp.Constants.HPR.MAX_BUSINESSADDRESSES);	
		self := [];
	end;

	EXPORT SourceView_Recs := project(ams_sourceview_wLinkIds, toOut(left));
	EXPORT SourceView_RecCount := COUNT(ams_sourceview_wLinkIds);
	
END;
