import IESP,Healthcare_Header_Services,Healthcare_Shared;
EXPORT Transforms_Summary := Module
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
	Export iesp.healthcare_orgsearchandreport.t_OrganizationSearchOrganization xformSummary (Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout l) := transform
		dsNames :=  l.Names(CompanyName <> '');
		SELF.LNFID := (string)l.lnpid;
		self.Status := l.status;
		self.Score := (string)(100-l.record_penalty);
		self.OrganizationName := dsNames[1].CompanyName;
		self.FacilityType := l.FacilityType;
		self.OrganizationType := l.OrganizationType;
		self.Taxonomy := l.Taxonomy[1].TaxonomyCode;
		self.CLIA := l.clianumbers[1].clianumber;
		self.HasSanctions := l.hasStateRestrict or l.hasOIG or l.hasOPM;
		self.HasLEIESanctions := l.hasOPM;
		self.HasEPLSSanctions := l.hasOIG;
		self.HasDisciplinarySanctions := l.hasStateRestrict;
		self.Aliases := choosen(project(dsNames[2..],transform(iesp.share.t_StringArrayItem, Self.value := Left.CompanyName)),iesp.constants.HPR.MAX_NAMES);
		self.Addresses := choosen(project(l.Addresses, xformAddress(left)),iesp.constants.HPR.MAX_BUSINESSADDRESSES);
		self.NPIRecords := choosen(project(l.NPIs(npi<>''),transform(iesp.healthcare_share.t_HCNPIDetails,
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
		self.LegacyBusinessIds := choosen(project(l.bdids, transform(iesp.share.t_StringArrayItem,self.value:=(string)left.bdid;)),iesp.constants.HPR.MAX_UNIQUEIDS);
		self.BusinessIdsList := choosen(project(l.bipkeys, transform(iesp.share.t_BusinessIdentity,self:=left;)),iesp.constants.HPR.MAX_UNIQUEIDS);
		self := [];
	end;
End;