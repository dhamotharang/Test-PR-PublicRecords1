IMPORT Healthcare_Shared, iesp,Healthcare_Header_Services;
//Builds the stubbed reports. 1 = first record, 2 = second record
EXPORT Stubs := Module
	
	EXPORT BuildAddress1() := FUNCTION
		iesp.healthcare_share.t_HCExtendedAddressPhoneFax addr1 := TRANSFORM
				self.StreetNumber:= '405';
				self.StreetName:= '86TH';
				self.StreetSuffix:= 'ST';
				self.StreetAddress1:='405 86TH ST';
				self.City:= 'BROOKLYN';
				self.State:= 'NY';
				self.Zip5 := '11209';
				self.Zip4 := '4707';
				self.StateCityZip := 'NY BROOKLYN 11209';
				// self.PrimaryRange := '405';
				// self.PrimaryName := '86TH';
				// self.Suffix := 'ST';
				self.DateFirstSeen := iesp.ECL2ESP.toDatestring8('20160913');
				self.DateLastSeen  := iesp.ECL2ESP.toDatestring8('20160913');
				self.Phone := '7187452233';
				self.Fax := '7187451424';
				self:=[];
			END;
		return addr1;
	END;
	
		EXPORT BuildAddress2() := FUNCTION
		iesp.healthcare_share.t_HCExtendedAddressPhoneFax addr2 := TRANSFORM
				self.StreetNumber:= '300';
				self.StreetName:= 'PERRY';
				self.StreetSuffix:= 'ST';
				self.StreetAddress1:='300 PERRY ST';
				self.City:= 'HELENA';
				self.State:= 'AR';
				self.Zip5 := '72342';
				self.Zip4 := '3325';
				self.StateCityZip := 'AR HELENA 72342';
				// self.PrimaryRange := '300';
				// self.PrimaryName := 'PERRY';
				// self.Suffix := 'ST';
				self.DateFirstSeen := iesp.ECL2ESP.toDatestring8('20160913');
				self.DateLastSeen  := iesp.ECL2ESP.toDatestring8('20160913');
				self.Phone := '8703386464';
				self.Fax := '8703388407';
				self:=[];
			END;
		return addr2;
	END;
	
	EXPORT BuildMedicaidRecord1() := FUNCTION
		iesp.healthcare_share.t_HCMedicaidDetails MedicaidRecord1 := TRANSFORM
				self.State := 'NY';
				self.Number := '835805';
				self.Status := 'A';
		END;
		return MedicaidRecord1;
	END;
	
		EXPORT BuildMedicaidRecord2() := FUNCTION
		iesp.healthcare_share.t_HCMedicaidDetails MedicaidRecord2 := TRANSFORM
				self.State := 'AR';
				self.Number := '';
				self.Status := '';
		END;
		return MedicaidRecord2;
	END;
	
	EXPORT BuildNPIRecord1() := FUNCTION
		iesp.npireport.t_NPIReport NPI1 := TRANSFORM
				self.EntityInformation.CompanyName:= 'GLOBE DRUG & SURGICAL';
				self.EntityInformation.AuthorizedName.Full:= 'Brett L Cohen';
				self.EntityInformation.AuthorizedName.First:= 'Brett';
				self.EntityInformation.AuthorizedName.Middle:= 'L';
				self.EntityInformation.AuthorizedName.Last:= 'Cohen';
				self.EntityInformation.AuthorizedTitle:= 'PRESIDENT';
				self.NPIInformation.NPINumber:= '1063413185';
				self.NPIInformation.EntityType:= '2';
				self.NPIInformation.EnumDate:=iesp.ECL2ESP.toDatestring8('20050810');
				self.NPIInformation.LastUpdateDate:=iesp.ECL2ESP.toDatestring8('20070708');
				self.ProviderMailingAddress.StreetNumber:= '405';
				self.ProviderMailingAddress.StreetName:= '86th';
				self.ProviderMailingAddress.StreetSuffix:= 'ST';
				self.ProviderMailingAddress.StreetAddress1:= '405th 86th ST'; 
				self.ProviderMailingAddress.City:= 'Brooklyn';
				self.ProviderMailingAddress.State:= 'NY';
				self.ProviderMailingAddress.Zip5:= '11209';
				self.ProviderMailingAddress.Zip4:= '4707';
				self.ProviderMailingAddress.County:= '047';
				self.ProviderMailingAddress.PostalCode:= '112094707';
				self.ProviderMailingAddress.StateCityZip:= 'NY Brooklyn 11209';
				self.ProviderMailingAddress.Phone10:= '9178489172';
				self.ProviderMailingAddress.FaxNumber:= '7187451424';
				self.ProviderPracticeAddress.StreetAddress1:= '405 86TH ST';
				self.ProviderPracticeAddress.StateCityZip:= 'NY Brooklyn 11209';
				self.ProviderPracticeAddress.Phone10:= '9178489172';
				self.ProviderPracticeAddress.FaxNumber:= '7187451424';
				self := [];
			END;
		return NPI1;
	END;
	
		EXPORT BuildNPIRecord2() := FUNCTION
		iesp.npireport.t_NPIReport NPI2 := TRANSFORM
				self.EntityInformation.CompanyName:= 'ECONOMY DRUGS OF HELENA';
				self.EntityInformation.AuthorizedName.Full:= 'CAROL WEILAND';
				self.EntityInformation.AuthorizedName.First:= 'Carol';
				//self.EntityInformation.AuthorizedName.Middle:= 'L';
				self.EntityInformation.AuthorizedName.Last:= 'WEILAND';
				self.EntityInformation.AuthorizedTitle:= 'PRESIDENT';
				self.NPIInformation.NPINumber:= '1093701336';
				self.NPIInformation.EntityType:= '2';
				self.NPIInformation.EnumDate:=iesp.ECL2ESP.toDatestring8('20050922');
				self.NPIInformation.LastUpdateDate:=iesp.ECL2ESP.toDatestring8('20150310');
				self.ProviderMailingAddress.StreetNumber:= '300';
				self.ProviderMailingAddress.StreetName:= 'PERRY';
				self.ProviderMailingAddress.StreetSuffix:= 'ST';
				self.ProviderMailingAddress.StreetAddress1:= '300 PERRY ST'; 
				self.ProviderMailingAddress.City:= 'Helena';
				self.ProviderMailingAddress.State:= 'AR';
				self.ProviderMailingAddress.Zip5:= '72342';
				self.ProviderMailingAddress.Zip4:= '3325';
				//self.ProviderMailingAddress.County:= '047';
				self.ProviderMailingAddress.PostalCode:= '723423325';
				self.ProviderMailingAddress.StateCityZip:= 'AR HELENA 72342';
				self.ProviderMailingAddress.Phone10:= '8703386464';
				self.ProviderMailingAddress.FaxNumber:= '8703388407';
				self.ProviderPracticeAddress.StreetAddress1:= '300 PERRY ST';
				self.ProviderPracticeAddress.StateCityZip:= 'AR HELENA 72342';
				self.ProviderPracticeAddress.Phone10:= '8703386464';
				self.ProviderPracticeAddress.FaxNumber:= '8703388407';
				self := [];
			END;
		return NPI2;
	END;
	
	EXPORT BuildDDEAREcord1() := FUNCTION
		iesp.healthcare_share.t_HCDEAProfile DEA1 := TRANSFORM
				self.RegistrationNumber:= 'A90777889';
				self.DrugSchedules := '22N 33N 4 5';
				self.Effective := iesp.ECL2ESP.toDatestring8('20160307'); 
				self.Expiration := iesp.ECL2ESP.toDatestring8('99991231');
				self.isorganization := true;
				self.organizationname := '405 86TH ST PHARMACY';  
				self.Address.StreetNumber := '405';
				self.Address.StreetName := '86th';
				self.Address.StreetSuffix := 'ST';
				self.Address.StreetAddress1 := '405 86TH ST PHARMACY INC';
				self.Address.StreetAddress2 := 'GLOBE PHARMACY';
				self.Address.City := 'BROOKLYN';
				self.Address.State := 'NY';
				self.Address.Zip5 := '11209';
				self.Address.Zip4 := '4707';
				self.Address.county := '36047';
				self.Address.PostalCode := '11209';
				self.BusinessActivityCode := 'A';
				self.BusinessActivityCodeDesc := Healthcare_Shared.Functions_DEA.decodeActivityCode('A');
				self.BusinessActivitySubCode:= '0';
				self.BusinessActivitySubCodeDesc:= Healthcare_Shared.Functions_DEA.decodeActivitySubCode('A', '0');
				self.activestatus := true;
				self:=[];
		END;
		return DEA1;
	END;
	
	EXPORT BuildDDEAREcord2() := FUNCTION
		iesp.healthcare_share.t_HCDEAProfile DEA2 := TRANSFORM
				self.RegistrationNumber:= 'A90777889';
				self.DrugSchedules := '22N 33N 4 5';
				self.Effective := iesp.ECL2ESP.toDatestring8('20160307'); 
				self.Expiration := iesp.ECL2ESP.toDatestring8('99991231');
				self.isorganization := true;
				self.organizationname := '405 86TH ST PHARMACY';  
				self.address.StreetNumber:= '300';
				self.address.StreetName:= 'PERRY';
				self.address.StreetSuffix:= 'ST';
				self.address.StreetAddress1:='300 PERRY ST';
				self.address.City:= 'HELENA';
				self.address.State:= 'AR';
				self.address.Zip5 := '72342';
				self.address.Zip4 := '3325';
				self.address.StateCityZip := 'AR HELENA 72342';
				self.BusinessActivityCode := 'A';
				self.BusinessActivityCodeDesc := Healthcare_Shared.Functions_DEA.decodeActivityCode('A');
				self.BusinessActivitySubCode:= '0';
				self.BusinessActivitySubCodeDesc:= Healthcare_Shared.Functions_DEA.decodeActivitySubCode('A', '0');
				self.activestatus := false;
				self:=[];
		END;
		return DEA2;
	END;
	
		EXPORT BuildDTaxonomyRecord1() := FUNCTION
			iesp.healthcare_share.t_HCTaxonomyDetails Tax1 := TRANSFORM
				self.Code := '333600000X';
				self._Type := 'Suppliers';
				self.Classification := 'Pharmacy';
				self:=[];
			END;
		return Tax1;
	END;
	
		EXPORT BuildDTaxonomyRecord2() := FUNCTION
			iesp.healthcare_share.t_HCTaxonomyDetails Tax2 := TRANSFORM
				self.Code := '3336C0003X';
				self._Type := 'PHARMACY COMMUNITY/RETAIL PHARMACY';
				self.Classification := 'Pharmacy';
				self:=[];
			END;
			iesp.healthcare_share.t_HCTaxonomyDetails Tax3 := TRANSFORM
				self.Code := '332B00000X';
				self._Type := 'DURABLE MEDICAL EQUIPMENT & MEDICAL SUPPLIES';
				self.Classification := 'Pharmacy';
				self:=[];
			END;
			return dataset([Tax2]) + dataset([Tax3]);
	END;
	
		EXPORT BuildNCPDPRecord1() := FUNCTION
			iesp.ncpdp.t_PharmacyReportConsolidatedSearch NCPDP1 := TRANSFORM
				self.EntityInformation.PharmacyProviderId := '3323122';
				self.EntityInformation.BusinessId := '';
				self.EntityInformation.CompanyName := 'GLOBE DRUG STORE';
				self.EntityInformation.DBAName := '405 86TH STREET PHARMACY INC';
				self.PharmacyLocationAddress.Phone10 := '7187452233';
				self.PharmacyLocationAddress.FaxNumber := '405';
				self.PharmacyLocationAddress.StreetNumber := '86TH';
				self.PharmacyLocationAddress.StreetPreDirection := '';
				self.PharmacyLocationAddress.StreetName  := '86TH';
				self.PharmacyLocationAddress.StreetSuffix := 'ST';
				self.PharmacyLocationAddress.StreetPostDirection := '';
				self.PharmacyLocationAddress.UnitDesignation := '';
				self.PharmacyLocationAddress.UnitNumber := '';
				self.PharmacyLocationAddress.StreetAddress1 := '405 86TH ST';
				self.PharmacyLocationAddress.StreetAddress2 := '';
				self.PharmacyLocationAddress.City := 'BROOKLYN';
				self.PharmacyLocationAddress.State := 'NY';
				self.PharmacyLocationAddress.Zip5 := '11209';
				self.PharmacyLocationAddress.Zip4 := '4707';
				self.PharmacyLocationAddress.County := '047';
				self.PharmacyLocationAddress.PostalCode := '4707';
				self.PharmacyMailingAddress.StreetNumber  := '405';
				self.PharmacyMailingAddress.StreetPreDirection := '';
				self.PharmacyMailingAddress.StreetName := '86TH';
				self.PharmacyMailingAddress.StreetSuffix := 'ST';
				self.PharmacyMailingAddress.StreetPostDirection := '';
				self.PharmacyMailingAddress.UnitDesignation := '';
				self.PharmacyMailingAddress.UnitNumber := '';
				self.PharmacyMailingAddress.StreetAddress1 := '405 86TH ST';
				self.PharmacyMailingAddress.City := 'BROOKLYN';
				self.PharmacyMailingAddress.State := 'NY';
				self.PharmacyMailingAddress.Zip5 := '11209';
				self.PharmacyMailingAddress.Zip4 := '4707';
				self.PharmacyMailingAddress.County := '4707';
				self.PharmacyMailingAddress.PostalCode := '11209';
				self := [];
			END;
		return NCPDP1;
	END;
	
	EXPORT BuildNCPDPRecord2() := FUNCTION
			iesp.ncpdp.t_PharmacyReportConsolidatedSearch NCPDP2 := TRANSFORM
				self.EntityInformation.PharmacyProviderId := '3323122';
				self.EntityInformation.BusinessId := '';
				self.EntityInformation.CompanyName := 'ECONOMY DRUGS OF HELENA';
				self.EntityInformation.DBAName := 'SPECIALTY SERVICES INC';
				self.PharmacyLocationAddress.Phone10 := '8703386464';
				self.PharmacyLocationAddress.FaxNumber := '300';
				self.PharmacyLocationAddress.StreetNumber := 'PERRY';
				self.PharmacyLocationAddress.StreetName  := 'PERRY';
				self.PharmacyLocationAddress.StreetSuffix := 'ST';
				self.PharmacyLocationAddress.StreetAddress1 := '300 PERRY ST';
				self.PharmacyLocationAddress.City := 'HELENA';
				self.PharmacyLocationAddress.State := 'AR';
				self.PharmacyLocationAddress.Zip5 := '72342';
				self.PharmacyLocationAddress.Zip4 := '3325';
				self.PharmacyLocationAddress.County := '107';
				self.PharmacyLocationAddress.PostalCode := '72342';
				self.PharmacyMailingAddress.StreetNumber  := '300';
				self.PharmacyMailingAddress.StreetName := 'PERRY';
				self.PharmacyMailingAddress.StreetSuffix := 'ST';
				self.PharmacyMailingAddress.StreetAddress1 := '300 PERRY ST';
				self.PharmacyMailingAddress.City := 'HELENA';
				self.PharmacyMailingAddress.State := 'AR';
				self.PharmacyMailingAddress.Zip5 := '72342';
				self.PharmacyMailingAddress.Zip4 := '3325';
				self.PharmacyMailingAddress.County := '107';
				self.PharmacyMailingAddress.PostalCode := '72342';
				self := [];
			END;
		return NCPDP2;
	END;
	
	EXPORT BuildStLic1() := FUNCTION
			iesp.healthcare_share.t_HCStateLicenseProfile StLic1 := TRANSFORM
				self.LicenseNumber := '8536';
				self.Email := 'GLOBEDRUG@AOL.COM';
				self.OrganizationName := 'GLOBE DRUG STORE';
				self.Phone := '9178489172';
				self.NPINumber := '1063413185';
				self.DEANumber := 'A90777889';
				self.Address.StreetNumber := '405';
				self.Address.StreetName := '86th';
				self.Address.StreetSuffix := 'ST';
				self.Address.StreetAddress1 := '405 86TH ST PHARMACY INC';
				self.Address.StreetAddress2 := 'GLOBE PHARMACY';
				self.Address.City := 'BROOKLYN';
				self.Address.State := 'NY';
				self.Address.Zip5 := '11209';
				self.Address.Zip4 := '4707';
				self.Address.county := '36047';
				self.Address.PostalCode := '11209';
				self := [];
			END;
		return StLic1;
	END;
	
		EXPORT BuildStLic2() := FUNCTION
			iesp.healthcare_share.t_HCStateLicenseProfile StLic2 := TRANSFORM
				self.LicenseNumber := '1';
				self.OrganizationName := 'ECONOMY DRUGS HELENA';
				self.Email := 'EconomyDrugs@AOL.COM';
				self.Phone := '9178489172';
				self.DEANumber := 'FS2511194';
				self.NPINumber := '1093701336';
				self.Taxonomy := '3336C0003X';
				self.CSRNumber := '100000000';
				self.address.StreetNumber:= '300';
				self.address.StreetName:= 'PERRY';
				self.address.StreetSuffix:= 'ST';
				self.address.StreetAddress1:='300 PERRY ST';
				self.address.City:= 'HELENA';
				self.address.State:= 'AR';
				self.address.Zip5 := '72342';
				self.address.Zip4 := '3325';
				self.address.StateCityZip := 'AR HELENA 72342';
				self := [];
			END;
		return StLic2;
	END;
	
	EXPORT BuildAHA1() := FUNCTION
			iesp.healthcare_share.t_HCAHAProfile AHA1 := TRANSFORM
					self.AHAId := '1';
					self.MetropolitanStatisticalArea := '0000';
					self.LNFID := '1';
					self.Address.StreetNumber := '405';
					self.Address.StreetName := '86th';
					self.Address.StreetSuffix := 'ST';
					self.Address.StreetAddress1 := '405 86TH ST PHARMACY INC';
					self.Address.StreetAddress2 := 'GLOBE PHARMACY';
					self.Address.City := 'BROOKLYN';
					self.Address.State := 'NY';
					self.Address.Zip5 := '11209';
					self.Address.Zip4 := '4707';
					self.Address.county := '36047';
					self.Address.PostalCode := '11209';
					self := [];
			END;
		return AHA1;
	END;
	
		EXPORT BuildAHA2() := FUNCTION
			iesp.healthcare_share.t_HCAHAProfile AHA2 := TRANSFORM
					self.AHAId := '1';
					self.MetropolitanStatisticalArea := '0000';
					self.LNFID := '2';
					self.address.StreetNumber:= '300';
					self.address.StreetName:= 'PERRY';
					self.address.StreetSuffix:= 'ST';
					self.address.StreetAddress1:='300 PERRY ST';
					self.address.City:= 'HELENA';
					self.address.State:= 'AR';
					self.address.Zip5 := '72342';
					self.address.Zip4 := '3325';
					self.address.StateCityZip := 'AR HELENA 72342';
					// self.address.PrimaryRange := '300';
					// self.address.PrimaryName := 'PERRY';
					// self.address.Suffix := 'ST';
					self.address.DateFirstSeen := iesp.ECL2ESP.toDatestring8('20160913');
					self.address.DateLastSeen  := iesp.ECL2ESP.toDatestring8('20160913');
					//self.address.Phone := '8703386464';
					//self.address.Fax := '8703388407';
					self := [];
			END;
		return AHA2;
	END;
	
	EXPORT BuildCSR1() := FUNCTION
			iesp.healthcare_share.t_HCStateControlledSubstancesProfile CSR1 := TRANSFORM
				self.OrganizationName := 'GLOBE DRUG STORE';
				self.Email := 'GLOBEDRUG@AOL.COM';
				self.DEANumber := 'A90777889';
				self.NPINumber := '1063413185';
				self.Taxonomy := '333600000X';
				self.LNFID := '1';
				self.Address.StreetNumber := '405';
				self.Address.StreetName := '86th';
				self.Address.StreetSuffix := 'ST';
				self.Address.StreetAddress1 := '405 86TH ST PHARMACY INC';
				self.Address.StreetAddress2 := 'GLOBE PHARMACY';
				self.Address.City := 'BROOKLYN';
				self.Address.State := 'NY';
				self.Address.Zip5 := '11209';
				self.Address.Zip4 := '4707';
				self.Address.county := '36047';
				self.Address.PostalCode := '11209';
				self := [];
			END;
		return CSR1;
	END;
	
		EXPORT BuildCSR2() := FUNCTION
			iesp.healthcare_share.t_HCStateControlledSubstancesProfile CSR2 := TRANSFORM
				self.OrganizationName := 'ECONOMY DRUGS HELENA';
				self.Email := 'EconomyDrugs@AOL.COM';
				self.DEANumber := 'FS2511194';
				self.NPINumber := '1093701336';
				self.Taxonomy := '3336C0003X';
				self.LNFID := '2';
				self.address.StreetNumber:= '300';
				self.address.StreetName:= 'PERRY';
				self.address.StreetSuffix:= 'ST';
				self.address.StreetAddress1:='300 PERRY ST';
				self.address.City:= 'HELENA';
				self.address.State:= 'AR';
				self.address.Zip5 := '72342';
				self.address.Zip4 := '3325';
				self.address.StateCityZip := 'AR HELENA 72342';
				// self.address.PrimaryRange := '300';
				// self.address.PrimaryName := 'PERRY';
				// self.address.Suffix := 'ST';
				self.address.DateFirstSeen := iesp.ECL2ESP.toDatestring8('20160913');
				self.address.DateLastSeen  := iesp.ECL2ESP.toDatestring8('20160913');
				//self.address.Phone := '8703386464';
				//self.address.Fax := '8703388407';
				self := [];
			END;
		return CSR2;
	END;
	
		EXPORT BuildOfficeAttr1() := FUNCTION
			iesp.healthcare_share.t_HCOfficeAttributesProfile OffAttr1 := TRANSFORM
					self.ExamRooms := '5';
					self.Practice.StreetAddress1 :='405 86TH ST';
					self.Practice.City := 'Brooklyn';
					self.Practice.State := 'NY';
					self.Practice.Zip5 := '11209';
					self.Practice.Zip4 := '4707';
					self.OfficeHours.Sunday.StartTime := '0600';
					self.OfficeHours.Sunday.EndTime := '1800';
					self.OfficeHours.Sunday.LunchTime := '1200';
					self.OfficeHours.Sunday.LunchDurationMinutes := '0045';
					self.OfficeHours.Monday.StartTime := '0600';
					self.OfficeHours.Monday.EndTime := '1800';
					self.OfficeHours.Monday.LunchTime := '1200';
					self.OfficeHours.Monday.LunchDurationMinutes := '0045';
					self.OfficeHours.Tuesday.StartTime := '0600';
					self.OfficeHours.Tuesday.EndTime := '1800';
					self.OfficeHours.Tuesday.LunchTime := '1200';
					self.OfficeHours.Tuesday.LunchDurationMinutes := '0045';
					self.OfficeHours.Wednesday.StartTime := '0600';
					self.OfficeHours.Wednesday.EndTime := '1800';
					self.OfficeHours.Wednesday.LunchTime := '1200';
					self.OfficeHours.Wednesday.LunchDurationMinutes := '0045';
					self.OfficeHours.Thursday.StartTime := '0600';
					self.OfficeHours.Thursday.EndTime := '1800';
					self.OfficeHours.Thursday.LunchTime := '1200';
					self.OfficeHours.Thursday.LunchDurationMinutes := '0045';
					self.OfficeHours.Friday.StartTime := '0600';
					self.OfficeHours.Friday.EndTime := '1800';
					self.OfficeHours.Friday.LunchTime := '1200';
					self.OfficeHours.Friday.LunchDurationMinutes := '0045';
					self.OfficeHours.Saturday.StartTime := '0600';
					self.OfficeHours.Saturday.EndTime := '1800';
					self.OfficeHours.Saturday.LunchTime := '1200';
					self.OfficeHours.Saturday.LunchDurationMinutes := '0045';
				self := [];
			END;
		return OffAttr1;
	END;
	
	EXPORT BuildOfficeAttr2() := FUNCTION
			iesp.healthcare_share.t_HCOfficeAttributesProfile OffAttr2 := TRANSFORM
					self.ExamRooms := '10';
					self.Practice.StreetAddress1 :='300 PERRY ST';
					self.Practice.City := 'HELENA';
					self.Practice.State := 'AR';
					self.Practice.Zip5 := '72342';
					self.Practice.Zip4 := '3325';
					self.OfficeHours.Sunday.StartTime := '0600';
					self.OfficeHours.Sunday.EndTime := '1800';
					self.OfficeHours.Sunday.LunchTime := '1200';
					self.OfficeHours.Sunday.LunchDurationMinutes := '0045';
					self.OfficeHours.Monday.StartTime := '0600';
					self.OfficeHours.Monday.EndTime := '1800';
					self.OfficeHours.Monday.LunchTime := '1200';
					self.OfficeHours.Monday.LunchDurationMinutes := '0045';
					self.OfficeHours.Tuesday.StartTime := '0600';
					self.OfficeHours.Tuesday.EndTime := '1800';
					self.OfficeHours.Tuesday.LunchTime := '1200';
					self.OfficeHours.Tuesday.LunchDurationMinutes := '0045';
					self.OfficeHours.Wednesday.StartTime := '0600';
					self.OfficeHours.Wednesday.EndTime := '1800';
					self.OfficeHours.Wednesday.LunchTime := '1200';
					self.OfficeHours.Wednesday.LunchDurationMinutes := '0045';
					self.OfficeHours.Thursday.StartTime := '0600';
					self.OfficeHours.Thursday.EndTime := '1800';
					self.OfficeHours.Thursday.LunchTime := '1200';
					self.OfficeHours.Thursday.LunchDurationMinutes := '0045';
					self.OfficeHours.Friday.StartTime := '0600';
					self.OfficeHours.Friday.EndTime := '1800';
					self.OfficeHours.Friday.LunchTime := '1200';
					self.OfficeHours.Friday.LunchDurationMinutes := '0045';
					self.OfficeHours.Saturday.StartTime := '0600';
					self.OfficeHours.Saturday.EndTime := '1800';
					self.OfficeHours.Saturday.LunchTime := '1200';
					self.OfficeHours.Saturday.LunchDurationMinutes := '0045';
				self := [];
			END;
		return OffAttr2;
	END;
	
	EXPORT BuildCLIA1() := FUNCTION
			iesp.cliasearch.t_CLIARecord CLIA1 := TRANSFORM
				self.BusinessId := '1';
				self.ExpirationDate :=iesp.ECL2ESP.toDatestring8('20180430');
				self.CompanyName :='GLOBE DRUG STORE';
				self.CLIAProviderAddress.StreetNumber := '405';
				self.CLIAProviderAddress.StreetName := '86TH';
				self.CLIAProviderAddress.StreetSuffix := 'ST';
				self.CLIAProviderAddress.StreetAddress1 := '405 86TH ST PHARMACY INC';
				self.CLIAProviderAddress.City := 'BROOKLYN';
				self.CLIAProviderAddress.State := 'NY';
				self.CLIAProviderAddress.Zip5 := '11209';
				self.CLIAProviderAddress.Zip4 := '4707';
				self.CLIAProviderAddress.County := '36047';
				self.CLIAProviderAddress.PostalCode := '11209';
				self.Phone10 := '9178489172';
				self.datefirstseen  := iesp.ECL2ESP.toDatestring8('20110329');
				self.datelastseen  := iesp.ECL2ESP.toDatestring8('20160114');
				self := [];
			END;
		return CLIA1;
	END;
	
		EXPORT BuildCLIA2() := FUNCTION
			iesp.cliasearch.t_CLIARecord CLIA2 := TRANSFORM
				self.BusinessId := '2';
				self.ExpirationDate :=iesp.ECL2ESP.toDatestring8('20180430');
				self.CompanyName :='ECONOMY DRUGS HELENA';
				self.CLIAProviderAddress.StreetNumber:= '300';
				self.CLIAProviderAddress.StreetName:= 'PERRY';
				self.CLIAProviderAddress.StreetSuffix:= 'ST';
				self.CLIAProviderAddress.StreetAddress1:='300 PERRY ST';
				self.CLIAProviderAddress.City:= 'HELENA';
				self.CLIAProviderAddress.State:= 'AR';
				self.CLIAProviderAddress.Zip5 := '72342';
				self.CLIAProviderAddress.Zip4 := '3325';
				self.CLIAProviderAddress.StateCityZip := 'AR HELENA 72342';
				self.Phone10 := '8703386464';
				self.datefirstseen  := iesp.ECL2ESP.toDatestring8('20160101');
				self.datelastseen  := iesp.ECL2ESP.toDatestring8('20160114');
				self := [];
			END;
		return CLIA2;
	END;
	
	EXPORT BuildAffiliations1() := FUNCTION
			iesp.healthcare_orgsearchandreport.t_OrganizationReportAffiliation Aff1 := TRANSFORM
				self.EntityID := '1';
				self.EntityIDType := 'LNFID';
				self.OrganizationName := 'GLOBE DRUG STORE';
				self.Phone := '9178489172';
				self.Effective := iesp.ECL2ESP.toDatestring8('20151103');
				self.Expiration := iesp.ECL2ESP.toDatestring8('20180430');
				self.Address.StreetNumber := '405';
				self.Address.StreetName := '86th';
				self.Address.StreetSuffix := 'ST';
				self.Address.StreetAddress1 := '405 86TH ST PHARMACY INC';
				self.Address.StreetAddress2 := 'GLOBE PHARMACY';
				self.Address.City := 'BROOKLYN';
				self.Address.State := 'NY';
				self.Address.Zip5 := '11209';
				self.Address.Zip4 := '4707';
				self.Address.county := '36047';
				self.Address.PostalCode := '11209';
				self := [];
			END;
		return Aff1;
	END;
	
		EXPORT BuildAffiliations2() := FUNCTION
			iesp.healthcare_orgsearchandreport.t_OrganizationReportAffiliation Aff2 := TRANSFORM
				self.EntityID := '2';
				self.EntityIDType := 'LNFID';
				self.OrganizationName := 'ECONOMY DRUGS HELENA';
				self.Phone := '8703386464';
				self.Effective := iesp.ECL2ESP.toDatestring8('20151103');
				self.Expiration := iesp.ECL2ESP.toDatestring8('20180430');
				self.address.StreetNumber:= '300';
				self.address.StreetName:= 'PERRY';
				self.address.StreetSuffix:= 'ST';
				self.address.StreetAddress1:='300 PERRY ST';
				self.address.City:= 'HELENA';
				self.address.State:= 'AR';
				self.address.Zip5 := '72342';
				self.address.Zip4 := '3325';
				self.address.StateCityZip := 'AR HELENA 72342';
				self := [];
			END;
		return Aff2;
	END;
	EXPORT BuildCustomerData1CustomFields() := FUNCTION
			iesp.healthcare_share.t_HCADMCustomFieldNameValue Cust1Fields := TRANSFORM
					self.Name := 'DIVISION';
					self.Value :='BHC Sales Operations';
			end;
		return Cust1Fields;
	END;
	EXPORT BuildCustomerData1_2CustomFields() := FUNCTION
			iesp.healthcare_share.t_HCADMCustomFieldNameValue Cust1_2Fields := TRANSFORM
					self.Name := 'DIVISION_CODE';
					self.Value :='SALES_OPS';
			end;
		return Cust1_2Fields;
	END;
	EXPORT BuildCustomerData1IDs() := FUNCTION
			iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationIds Cust1IDS := TRANSFORM
					self.ParentRecordId := 291035;
					self.IdType :=14;
					self.RawIdType :='TAXONOMY';
					self.RawState :='';
					self.RawIdValue :='33';
					self.RawEndDate :='';
					self.RawUnknownIdType :='';
					self.CleanState :='';
					self.CleanIdValue :='';
					self:=[];
			end;
		return Cust1IDS;
	END;
	EXPORT BuildCustomerData1_2_IDs() := FUNCTION
			iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationIds Cust1_2IDS := TRANSFORM
					self.ParentRecordId := 291035;
					self.IdType :=15;
					self.RawIdType :='CLIENTID';
					self.RawState :='';
					self.RawIdValue :='BHO3023989';
					self.RawEndDate :='';
					self.RawUnknownIdType :='';
					self.CleanState :='';
					self.CleanIdValue :='BHO3023989';
					self:=[];
			end;
		return Cust1_2IDS;
	END;
	EXPORT BuildCustomerData1Address() := FUNCTION
			iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationAddress Cust1Addr := TRANSFORM
					self.ParentRecordId := 291035;
					self.AddressId :='0009146954';
					self.AddressType:=0;
					self.RawAddress.StreetAddress1:='405 86TH ST';
					self.RawAddress.StreetAddress2:='';
					self.RawAddress.City:='BROOKLYN';
					self.RawAddress.State:='NY';
					self.RawAddress.Zipcode:='11209';
					self.RawAddress.CBSACode:='';
					self.RawAddress.Country:='';
					// self.RawAddress.UnknownAddressType:='';   drop from layout
					self.RawAddress.IsActive:=true;
					self.Communications:=dataset([{'291035','MAIN','MAIN','','15615551212','','','','15615551212',''}],iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationCommunications);
					self:=[];
			end;
		return Cust1Addr;
	END;
	EXPORT BuildCustomerData1() := FUNCTION
			iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationRecord Cust1 := TRANSFORM
				self.RecordId := '210002';
				self.LNFID :='1';
				self.OrganizationName:='GLOBE DRUG';
				self.OrganizationNumber:='';
				self.OrganizationStoreNumber:='';
				self.ClientSourceId:='BHO3035477';
				self.ClientSourceCode:='SAP';
				self.RawOrganizationName:='GLOBE DRUG LLC';
				self.RawOrganizationType:='PHARMACY';
				self.RawOrganizationSubType:='RETAIL CHAIN';
				self.CleanOrganizationSubType:='RETAIL CHAIN';
				self.Addresses := dataset([BuildCustomerData1Address()]);
				self.Ids := dataset([BuildCustomerData1IDs()])&dataset([BuildCustomerData1_2_IDs()]);
				self.CustomFields := dataset([BuildCustomerData1CustomFields()])&dataset([BuildCustomerData1_2CustomFields()]);
				self := [];
			END;
		return Cust1;
	END;
	EXPORT BuildCustomerData2CustomFields() := FUNCTION
			iesp.healthcare_share.t_HCADMCustomFieldNameValue Cust2Fields := TRANSFORM
					self.Name := 'DIVISION';
					self.Value :='BHC Sales Operations';
			end;
		return Cust2Fields;
	END;
	EXPORT BuildCustomerData2_2CustomFields() := FUNCTION
			iesp.healthcare_share.t_HCADMCustomFieldNameValue Cust2_2Fields := TRANSFORM
					self.Name := 'DIVISION_CODE';
					self.Value :='SALES_OPS';
			end;
		return Cust2_2Fields;
	END;
	EXPORT BuildCustomerData2IDs() := FUNCTION
			iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationIds Cust2IDS := TRANSFORM
					self.ParentRecordId := 9135;
					self.IdType :=12;
					self.RawIdType :='DEA';
					self.RawState :='';
					self.RawIdValue :='ED2334533';
					self.RawEndDate :='';
					self.RawUnknownIdType :='';
					self.CleanState :='';
					self.CleanIdValue :='';
					self:=[];
			end;
		return Cust2IDS;
	END;
	EXPORT BuildCustomerData2_2_IDs() := FUNCTION
			iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationIds Cust2_2IDS := TRANSFORM
					self.ParentRecordId := 9135;
					self.IdType :=15;
					self.RawIdType :='CLIENTID';
					self.RawState :='';
					self.RawIdValue :='BHO3023783';
					self.RawEndDate :='';
					self.RawUnknownIdType :='';
					self.CleanState :='';
					self.CleanIdValue :='BHO3023783';
					self:=[];
			end;
		return Cust2_2IDS;
	END;
	EXPORT BuildCustomerData2Address() := FUNCTION
			iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationAddress Cust2Addr := TRANSFORM
					self.ParentRecordId := 9135;
					self.AddressId :='0091406554';
					self.AddressType:=0;
					self.RawAddress.StreetAddress1:='300 PERRY ST';
					self.RawAddress.StreetAddress2:='';
					self.RawAddress.City:='HELENA';
					self.RawAddress.State:='AR';
					self.RawAddress.ZipCode:='72342';
					self.RawAddress.CBSACode:='';
					self.RawAddress.Country:='';
					// self.RawAddress.UnknownAddressType:='';  // dropped from layout
					self.RawAddress.IsActive:=true;
					self.Communications:=dataset([{'9135','VSF','VSF','','15615554545','','','','15615554545',''}],iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationCommunications);
					self:=[];
			end;
		return Cust2Addr;
	END;
	EXPORT BuildCustomerData2() := FUNCTION
			iesp.healthcare_admorgsearchandreport.t_ADMCustomerOrganizationRecord Cust2 := TRANSFORM
				self.RecordId := '274502';
				self.LNFID :='2';
				self.OrganizationName:='ECONOMY DRUGS HELENA';
				self.OrganizationNumber:='';
				self.OrganizationStoreNumber:='';
				self.ClientSourceId:='HLO3054677';
				self.ClientSourceCode:='SAP';
				self.RawOrganizationName:='ECONOMY DRUGS HELENA';
				self.RawOrganizationType:='PHARMACY';
				self.RawOrganizationSubType:='RETAIL CHAIN';
				self.CleanOrganizationSubType:='RETAIL CHAIN';
				self.Addresses := dataset([BuildCustomerData2Address()]);
				self.Ids := dataset([BuildCustomerData2IDs()])&dataset([BuildCustomerData2_2_IDs()]);
				self.CustomFields := dataset([BuildCustomerData2CustomFields()])&dataset([BuildCustomerData2_2CustomFields()]);
				self := [];
			END;
		return Cust2;
	END;

	EXPORT StubbedSearch1() := FUNCTION
		iesp.healthcare_admorgsearchandreport.t_ADMOrganizationReportOrganization StubbedSearch1 := transform
				SELF.LNFID := '1';
				self.ConfidenceScore := '100';
				self.status := 'ACTIVE';
				self.clientid := 'BHO3035477';
				self.OrganizationNames := dataset([{'GLOBE DRUG', ''}],iesp.healthcare_share.t_HCBusinessName);          
				self.facilitytype := 'PHARMACY';          
				self.organizationtype := 'Pharmacy, Retail/Chain';          
				self.Addresses := dataset([BuildAddress1()]);
				self.HasSanctions := false;
				self.HasLEIESanctions := false;
				self.HasEPLSSanctions := false;
				self.HasDisciplinarySanctions := false;
				self.globallocationnumber := '659743';
				self.globallocationnumberstatus := 'Active';
				self.healthindustrynumberingsystemid := '432087380';
				self.pointofserviceid := '10544';
				self.ahaid1 := '6040002';
				self.ahaid2 := '';
				self.dshadjustedpercentage := '10';
				self.Websites := dataset([{'GLOBEDRUG.COM'}], iesp.share.t_StringArrayItem);
				self.LegacyBusinessIds := dataset([{'7142603'}, {'476630985'}], iesp.share.t_StringArrayItem);
				self.Emails := dataset([{'GLOBEDRUG@AOL.COM'}], iesp.share.t_StringArrayItem);
				self.MedicaidRecords := dataset([BuildMedicaidRecord1()]);
				self.NpiRecords := dataset([BuildNPIRecord1()]);
				self.DeaRecords := dataset([BuildDDEAREcord1()]);
				self.Taxonomies := dataset([BuildDTaxonomyRecord1()]);
				self.PharmacyRecords  :=  dataset([BuildNCPDPRecord1()]);
				self.Licenses := dataset([BuildStLic1()]);
				self.AHARecords := dataset([BuildAHA1()]);      
				self.StateControlledSubstanceRecords  := dataset([BuildCSR1()]);   
				self.OfficeAttributes := dataset([BuildOfficeAttr1()]);				
				//self.Corrections := project(l,Healthcare_Shared.Transforms_Corrections.xformHCOCorrections(left));
				//self.UserStats := project(l,Healthcare_Shared.Transforms_UserStats.xformHCOUserStats(left));
				//self.CustomerIntegrationCodes := project(l,Healthcare_Shared.Transforms_CIC.xformHCOCIC(left));
				//self.QuestionCodes := l.CIC.questioncodes;
				//self.Verifications := project(l,Healthcare_Shared.Transforms_Verifications.xformHCOVerifications(left));
				self.CLIARecords := dataset([BuildCLIA1()]);   
				self.Affiliations := dataset([BuildAffiliations1()]);
				self.CustomerRecords := dataset([BuildCustomerData1()]);
				self := [];
			END;
		return dataset([StubbedSearch1]);
	END;
	
	EXPORT StubbedSearch2() := FUNCTION
		iesp.healthcare_admorgsearchandreport.t_ADMOrganizationReportOrganization StubbedSearch2 := transform
				SELF.LNFID := '2';
				self.ConfidenceScore := '58';
				self.status := 'ACTIVE';
				self.clientid := 'BHO3023783';
				self.OrganizationNames := dataset([{'ECONOMY DRUGS HELENA', 'LBN'}],iesp.healthcare_share.t_HCBusinessName);          
				self.facilitytype := 'PHARMACY';          
				self.organizationtype := 'Pharmacy, Retail/Chain';          
				self.Addresses := dataset([BuildAddress2()]);
				self.HasSanctions := false;
				self.HasLEIESanctions := false;
				self.HasEPLSSanctions := false;
				self.HasDisciplinarySanctions := false;
				self.globallocationnumber := '379233';
				self.globallocationnumberstatus := 'Active';
				self.healthindustrynumberingsystemid := '467888930';
				self.pointofserviceid := '104560';
				self.ahaid1 := '6040122';
				self.ahaid2 := '';
				self.dshadjustedpercentage := '10';
				self.Websites := dataset([{'EconomyDrugs.COM'}], iesp.share.t_StringArrayItem);
				self.LegacyBusinessIds := dataset([{'00000000'}, {'111111111'}, {'22222222'}], iesp.share.t_StringArrayItem);
				self.Emails := dataset([{'EconomyDrugs@Aol.com'}], iesp.share.t_StringArrayItem);
				self.MedicaidRecords := dataset([BuildMedicaidRecord2()]);
				self.NpiRecords := dataset([BuildNPIRecord2()]);
				self.DeaRecords := dataset([BuildDDEAREcord2()]);
				self.Taxonomies := BuildDTaxonomyRecord2();
				self.PharmacyRecords  :=  dataset([BuildNCPDPRecord2()]);
				//self.Licenses := dataset([BuildStLic2()]);
				self.AHARecords := dataset([BuildAHA2()]);      
				self.StateControlledSubstanceRecords  := dataset([BuildCSR2()]);   
				self.OfficeAttributes := dataset([BuildOfficeAttr2()]);
				//self.Corrections := project(l,Healthcare_Shared.Transforms_Corrections.xformHCOCorrections(left));
				//self.UserStats := project(l,Healthcare_Shared.Transforms_UserStats.xformHCOUserStats(left));
				//self.CustomerIntegrationCodes := project(l,Healthcare_Shared.Transforms_CIC.xformHCOCIC(left));
				//self.QuestionCodes := l.CIC.questioncodes;
				//self.Verifications := project(l,Healthcare_Shared.Transforms_Verifications.xformHCOVerifications(left));
				self.CLIARecords := dataset([BuildCLIA2()]);   
				self.Affiliations := dataset([BuildAffiliations2()]);
				self.CustomerRecords := dataset([BuildCustomerData2()]);
				self := [];
			END;
		return dataset([StubbedSearch2]);
	END;
END;