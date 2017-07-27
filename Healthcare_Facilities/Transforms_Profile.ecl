import IESP,Healthcare_Header_Services,Healthcare_Shared,Healthcare_Lookups;
EXPORT Transforms_Profile := Module
	Export iesp.healthcare.t_HealthCarePhones xformPhone (Healthcare_Header_Services.Layouts.layout_addressphone l, String PhoneType) := transform
		self.Phone10 := if(PhoneType='P',l.PhoneNumber,l.FaxNumber);
		self.PhoneType := map(PhoneType='P' => 'Phone',
													PhoneType='F' => 'Fax','');
	end;
	Export iesp.healthcare.t_HealthCareBusinessAddress xformAddress (Healthcare_Header_Services.Layouts.layout_addressinfo l) := transform
		self.Address.StreetNumber := l.prim_range;
		self.Address.StreetPreDirection := l.predir;
		self.Address.StreetName := l.prim_name;
		self.Address.StreetSuffix := l.addr_suffix;
		self.Address.StreetPostDirection := l.postdir;
		self.Address.UnitDesignation := l.unit_desig;
		self.Address.UnitNumber := l.sec_range;
		self.Address.StreetAddress1 := l.address1;
		self.Address.StreetAddress2 := l.address2;
		self.Address.City := l.p_city_name;
		self.Address.State := l.st;
		self.Address.Zip5 := l.z5;
		self.Address.Zip4 := l.zip4;
		self.Address.County := '';
		self.Address.PostalCode := l.z5;
		self.Address.StateCityZip := '';
		self.Location.Latitude := l.geo_lat;
		self.Location.Longitude := l.geo_long;
		self.AddressType := map(l.addrTypeCode in ['1','2','3','4'] => l.addrType,
														l.addrTypeCode);
		self.Phones := choosen(sort(dedup(sort(Project(l.Phones(PhoneNumber<>''),xformPhone(left,'P'))+Project(l.Phones(FaxNumber<>''),xformPhone(left,'F')),record),record),-PhoneType),iesp.constants.HPR.MAX_ADDRESSES_PHONES);
		self.DateFirstSeen := iesp.ECL2ESP.toDatestring8(if(l.first_seen<>'',l.first_seen,l.v_first_seen));
		self.DateLastSeen := iesp.ECL2ESP.toDatestring8(if(l.last_seen<>'',l.last_seen,l.v_last_seen));
	end;
	Export iesp.healthcare_orgsearchandreport.t_OrganizationReportOrganization xformProfile (Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout l) := transform
		dsNames :=  l.Names(CompanyName <> '');
		strSource := if(l.src='H','',l.src[1]);
		SELF.LNFID := trim(strSource,left,right)+(string)l.lnpid;
		self.Status := l.status;
		self.Score := (string)(100-l.record_penalty);
		self.OrganizationName := dsNames[1].CompanyName;
		self.FacilityType := l.FacilityType;
		self.OrganizationType := l.OrganizationType;
		self.HasSanctions := l.hasStateRestrict or l.hasOIG or l.hasOPM;
		self.HasLEIESanctions := l.hasOPM;
		self.HasEPLSSanctions := l.hasOIG;
		self.HasDisciplinarySanctions := l.hasStateRestrict;
		self.Aliases := choosen(project(dsNames[2..],transform(iesp.share.t_StringArrayItem, Self.value := Left.CompanyName)),iesp.constants.HPR.MAX_NAMES);
		self.Addresses := choosen(project(l.Addresses, xformAddress(left)),iesp.constants.HPR.MAX_BUSINESSADDRESSES);
		self.NPIRecords := choosen(project(l.NPIs(npi <>''),transform(iesp.healthcare_share.t_HCNPIDetails,
																													self.NPINumber:=left.npi;
																													self.Status:=map(left.npi_deact_date > left.npi_enum_date and 
																																					 left.npi_deact_date > left.npi_react_date => 'D',
																																					 left.npi_react_date > left.npi_enum_date => 'R',
																																					 'A');
																													self._Type:=(string)left.npi_type;
																													self.DeactivationDate:=iesp.ECL2ESP.toDatestring8(left.npi_deact_date);)),iesp.constants.HPR.MAX_NPIS);
		self.DEARecords := choosen(project(l.DEAs(dea_num<>''),transform(iesp.healthcare_share.t_HCDEADetails,
																													self.RegistrationNumber:=left.dea_num;
																													self.BusinessType := left.dea_num_bus_type;
																													self.DrugSchedules := left.dea_num_sch;
																													self.Expiration := iesp.ECL2ESP.toDatestring8(left.dea_num_exp);
																													self.Status := left.dea_num_status;
																													self.Address.StreetNumber := left.dea_prim_range;
																													self.Address.StreetPreDirection := left.dea_predir;
																													self.Address.StreetName := left.dea_prim_name;
																													self.Address.StreetSuffix := left.dea_addr_suffix;
																													self.Address.StreetPostDirection := left.dea_postdir;
																													self.Address.UnitDesignation := left.dea_unit_desig;
																													self.Address.UnitNumber := left.dea_sec_range;
																													self.Address.StreetAddress1 := left.dea_AddressLine1;
																													self.Address.StreetAddress2 := left.dea_AddressLine2;
																													self.Address.City := left.dea_p_city_name;
																													self.Address.State := left.dea_st;
																													self.Address.Zip5 := left.dea_z5;
																													self.Address.Zip4 := left.dea_zip4;
																													self.Address.PostalCode := left.dea_z5;
																													self.BusinessActivityCode := left.dea_num_bus_act_ind;
																													self.BusinessActivityCodeDesc := Healthcare_Shared.Functions_DEA.decodeActivityCode(left.dea_num_bus_act_ind);
																													self.BusinessActivitySubCode:= left.dea_num_bus_act_sub_ind;
																													self.BusinessActivitySubCodeDesc:= Healthcare_Shared.Functions_DEA.decodeActivitySubCode(left.dea_num_bus_act_ind,left.dea_num_bus_act_sub_ind);
																													self:=[];)),iesp.constants.HPR.MAX_NPIS);
		self.FEINs := choosen(project(l.FEINs(fein<>''),transform(iesp.share.t_StringArrayItem,self.value:=left.fein;self:=[];)),iesp.constants.HPR.MAX_TAXIDS);
		self.CLIARecords := choosen(project(l.clianumbers(clianumber<>''),transform(iesp.healthcare_share.t_HCCLIADetails,
																													self.CLIANumber :=left.clianumber;
																													self.Expiration :=iesp.ECL2ESP.toDatestring8(left.clia_end_date);
																													self.CertificateType :=left.clia_cert_type_code;
																													self.LaboratoryType :=left.clia_lab_type_description;
																													self.TerminationCode :=left.clia_lab_term_code;
																													self.TerminationCodeDesc :=left.clia_TermCodeDesc;
																													self:=[];)),iesp.constants.HPR.MAX_CLIA);
		self.Licenses := choosen(project(l.StateLicenses(LicenseNumber<>''),transform(iesp.healthcare.t_ProviderLicenseInfo,
																													self.LicenseState :=left.LicenseState;
																													self.LicenseNumber :=left.LicenseNumber;
																													self.LicenseType :=left.LicenseType;
																													self.LicenseNumberOrig :=left.LicenseNumberFmt;
																													self.ExpirationDate :=iesp.ECL2ESP.toDatestring8(left.Termination_Date);
																													self.EffectiveDate :=iesp.ECL2ESP.toDatestring8(left.Effective_Date);
																													self.LicenseStatus :=left.LicenseStatus;
																													self.LicenseSeqID :=left.licenseSeq;
																													self:=[];)),iesp.constants.HPR.MAX_LICENSES);
		self.MedicareNumbers := project(l,transform(iesp.share.t_StringArrayItem,self.value:=left.medicare_fac_num;self:=[];));
		//Not available in Legacy
		// self.MedicaidNumbers := choosen(project(l,transform(iesp.healthcare_share.t_HCMedicaidDetails,self:=[];)),iesp.constants.HPR.MAX_MEDICAID);
		self.Taxonomies := choosen(project(l.Taxonomy(TaxonomyCode<>''),transform(iesp.healthcare_share.t_HCTaxonomyDetails,
																													xref:=Healthcare_Lookups.Functions_Taxonomy.getTaxonomybyCode(left.TaxonomyCode);
																													self.Code := left.TaxonomyCode;
																													self._Type := if(left.TaxonomyType<>'',left.TaxonomyType,xref[1].Grouping);
																													self.Classification := if(left.Classification<>'',left.Classification,xref[1].Classification);
																													self.Specialization := if(left.Specialization<>'',left.Specialization,xref[1].Specialization);
																													self.PrimaryIndicator := left.PrimaryIndicator;
																													self:=[];)),iesp.constants.PROFLIC.MAX_TAXONOMY);
		self.Affiliations := choosen(project(l.newaffiliations,transform(iesp.healthcare_orgsearchandreport.t_OrganizationReportAffiliation,
																													self.EntityID := left.EntityID;
																													self.EntityIDType := left.EntityIDType;
																													self.RelationshipType := left.RelationshipType;
																													self.Effective := iesp.ECL2ESP.toDatestring8(left.Effective);
																													self.Expiration := iesp.ECL2ESP.toDatestring8(left.Expiration);
																													self.OrganizationName := left.OrganizationName;
																													self.PractitionerName.Full := left.ProviderFull;
																													self.PractitionerName.First := left.ProviderFirst;
																													self.PractitionerName.Middle := left.ProviderMiddle;
																													self.PractitionerName.Last := left.ProviderLast;
																													self.PractitionerName.Suffix := left.ProviderSuffix;
																													self.PractitionerName.Prefix := left.ProviderPrefix;
																													self.Address.StreetNumber := left.FacilityStreetNumber;
																													self.Address.StreetPreDirection := left.FacilityStreetPreDirection;
																													self.Address.StreetName := left.FacilityStreetName;
																													self.Address.StreetSuffix := left.FacilityStreetSuffix;
																													self.Address.StreetPostDirection := left.FacilityStreetPostDirection;
																													self.Address.UnitDesignation := left.FacilityUnitDesignation;
																													self.Address.UnitNumber := left.FacilityUnitNumber;
																													self.Address.StreetAddress1 := left.FacilityStreetAddress1;
																													self.Address.StreetAddress2 := left.FacilityStreetAddress2;
																													self.Address.City := left.FacilityCity;
																													self.Address.State := left.FacilityState;
																													self.Address.Zip5 := left.FacilityZip5;
																													self.Address.Zip4 := left.FacilityZip4;
																													self.Phone := left.FacilityPhone;
																													self.Fax := left.FacilityFax;
																													self.NPI := left.NPI;
																													self.Specialty := left.Specialty1;
																													self.PractitionerType := left.PractitionerType;
																													self.FacilityType := left.FacilityType;
																													self.OrganizationType := left.OrganizationType;
																													self := [];)),iesp.constants.HPR.MAX_AFFILIATIONS);
		self.Sanctions := choosen(project(l.LegacySanctions,transform(iesp.healthcare.t_HealthCareSanctionConsolidatedReport,
																													self.SanctionId := (string)left.SANC_ID;
																													self.UniqueId := left.did;
																													self.Name.Full := left.SANC_BUSNME;
																													self.Name.First := left.Prov_Clean_fname;
																													self.Name.Middle := left.Prov_Clean_mname;
																													self.Name.Last := left.Prov_Clean_lname;
																													self.Name.Suffix := left.Prov_Clean_name_suffix;
																													self.Name.Prefix := left.Prov_Clean_title;
																													self.GeoAddress.Address.StreetNumber := left.ProvCo_Address_Clean_prim_range;
																													self.GeoAddress.Address.StreetPreDirection := left.ProvCo_Address_Clean_predir;
																													self.GeoAddress.Address.StreetName := left.ProvCo_Address_Clean_prim_name;
																													self.GeoAddress.Address.StreetSuffix := left.ProvCo_Address_Clean_addr_suffix;
																													self.GeoAddress.Address.StreetPostDirection := left.ProvCo_Address_Clean_postdir;
																													self.GeoAddress.Address.UnitDesignation := left.ProvCo_Address_Clean_unit_desig;
																													self.GeoAddress.Address.UnitNumber := left.ProvCo_Address_Clean_sec_range;
																													self.GeoAddress.Address.City := left.ProvCo_Address_Clean_p_city_name;
																													self.GeoAddress.Address.State := left.ProvCo_Address_Clean_st;
																													self.GeoAddress.Address.Zip5 := left.ProvCo_Address_Clean_zip;
																													self.GeoAddress.Location.Latitude := left.ProvCo_Address_Clean_geo_lat;
																													self.GeoAddress.Location.Longitude := left.ProvCo_Address_Clean_geo_long;
																													self.DOB := iesp.ECL2ESP.toDatestring8(left.SANC_DOB);
																													self.TaxId := left.SANC_TIN;
																													self.UPIN := left.SANC_UPIN;
																													self.Source := left.SANC_SRC_DESC;
																													self.SanctionTerm := left.SANC_TERMS;
																													self.SanctionType := left.SANC_TYPE;
																													self.BoardType := left.SANC_BRDTYPE;
																													self.ProviderType := left.SANC_PROVTYPE;
																													self.Fines := left.SANC_FINES;
																													self.SanctionReason := left.SANC_REAS;
																													self.Conditions := left.SANC_COND;
																													self.LicenseNumber := left.SANC_LICNBR;
																													self.SanctionState := left.SANC_SANCST;
																													self.SanctionDate := iesp.ECL2ESP.toDatestring8(left.sanc_sancdte_form);
																													self.DateLastReported := iesp.ECL2ESP.toDatestring8(left.date_last_reported);
																													self.DateFirstSeen := iesp.ECL2ESP.toDatestring8(left.date_first_seen);
																													self.DateLastSeen := iesp.ECL2ESP.toDatestring8(left.date_last_seen);
																													self.LicenseReinstatedDate := iesp.ECL2ESP.toDatestring8(left.SANC_REINDTE_form);
																													self.DerivedReinstateDate := iesp.ECL2ESP.toDatestring8(left.SANC_REINDTE_form);
																													self.FraudAbuseFlag := (Boolean)left.SANC_FAB;
																													self.LostOfLicenseIndicator := (Boolean)left.SANC_UNAMB_IND;
																													self.DerivedReinstateDateIndicator := left.LNDerivedReinstateDate;
																													self.SanctionGroupType := left.sanc_grouptype;
																													self.SanctionSubGroupType := left.sanc_subgrouptype;
																													self.SanctionTypePriority := (string)left.sanc_priority;
																													self.DateFirstReported := iesp.ECL2ESP.toDatestring8(left.date_first_reported);
																													self.ProcessDate := iesp.ECL2ESP.toDatestring8(left.process_date);
																													self := [];)),iesp.constants.HPR.MAX_SANCTIONS);
		self.PharmacyRecords := choosen(project(l.NCPDPRaw,transform(iesp.ncpdp.t_PharmacyReportConsolidatedSearch, 
																								self.EntityInformation:=project(left.EntityInformation,
																																						transform(iesp.ncpdp.t_PharmacyInformationConsolidatedSearch,self:=left));
																								self:=left;)),iesp.constants.HPR.Max_NCPDP_Report);
		self.LegacyBusinessIds := choosen(project(l.bdids, transform(iesp.share.t_StringArrayItem,self.value:=(string)left.bdid;)),iesp.constants.HPR.MAX_UNIQUEIDS);
		self.BusinessIdsList := choosen(project(l.bipkeys, transform(iesp.share.t_BusinessIdentity,self:=left;)),iesp.constants.HPR.MAX_UNIQUEIDS);
		//Does not Exist in legacy
		// self.Corrections := project(l.Corrections, transform(iesp.healthcare_orgsearchandreport.t_OrganizationReportCorrections,self:=left;));
		//Does not Exist in legacy
		// self.UStats := project(l.UStat, transform(iesp.healthcare_orgsearchandreport.t_OrganizationReportUStats,self:=left;));
		//Does not Exist in legacy
		// self.CIC := project(l.CIC, transform(iesp.healthcare_orgsearchandreport.t_OrganizationReportCIC,self:=left;));
		//Does not Exist in legacy
		// self.QuestionCodes := l.QuestionCodes;
		self.Verifications := project(l.VerificationInfo, transform(iesp.healthcare.t_HealthCareSearchVerifications,self.PharmacyProviderIdVerified := left.NCPDPNumberVerified ;self:=left;))[1];
		self := [];
	end;
End;