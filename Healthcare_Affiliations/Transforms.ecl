Import iesp, HMS, Org_Mast;

EXPORT Transforms := Module

	EXPORT Healthcare_Affiliations.Layouts.ResultRecs PopulateProvider(Healthcare_Affiliations.Layouts.SearchRecs L, HMS.layouts.individual_base R) := TRANSFORM

			self.acctno 	:= L.acctno;
			self.SourceID := L.EntityID;
			self.SourceIDType := L.EntityIDType;
			SELF.RelationshipType := L.relationshiptype;
			SELF.ID := R.HMS_PIID;
			SELF.IDType := Healthcare_Affiliations.Constants.ProviderIndicator;
			// SELF.OrganizationName := R.Clean_Company_Name;
			SELF.OrganizationName := '';
			
			// share.t_Name PractionerName {xpath('PractionerName')};			
			SELF.PractitionerName.Full := Trim(R.First) + IF(Trim(R.Middle)='', '', ' ') + Trim(R.Middle) + ' ' + Trim(R.Last) + IF(Trim(R.Suffix)='', '', ' ') + Trim(R.Suffix);
			SELF.PractitionerName.First := R.First;
			SELF.PractitionerName.Middle := R.Middle;
			SELF.PractitionerName.Last   := R.Last;
			SELF.PractitionerName.Suffix := R.Suffix;
			SELF.PractitionerName.Prefix := '';
	
			// share.t_Address Address {xpath('Address')};   
			/* The reason the address information is not taken is because, for Providers, they are populated with its affiliated Facility's address */
			SELF.Address.StreetNumber := ''; // R.prim_range;
			SELF.Address.StreetPreDirection := ''; // R.predir;
			SELF.Address.StreetName := ''; // R.prim_name;
			SELF.Address.StreetSuffix := ''; // R.addr_suffix;
			SELF.Address.StreetPostDirection := ''; // R.postdir;
			SELF.Address.UnitDesignation := ''; // R.unit_desig;
			SELF.Address.UnitNumber := ''; // R.sec_range;
			SELF.Address.StreetAddress1 := ''; // R.prepped_addr1;
			SELF.Address.StreetAddress2 := ''; // R.prepped_addr2;
			SELF.Address.City := ''; // R.p_city_name;
			SELF.Address.State:= ''; // R.st;
			SELF.Address.Zip5 := ''; // R.zip;
			SELF.Address.Zip4 := ''; // R.zip4;
			SELF.Address.County := '';
			SELF.Address.PostalCode := '';
			SELF.Address.StateCityZip := '';
			
			SELF.Phone := R.clean_phone;
			SELF.Fax := R.fax;
			SELF.NPI := R.npi_num;
			
			// share.t_Date Effective {xpath('Effective')};
			SELF.Effective.Year := (INTEGER) R.clean_state_license_issued[1..4];
			SELF.Effective.Month := (INTEGER) R.clean_state_license_issued[5..6];
			SELF.Effective.Day := (INTEGER) R.clean_state_license_issued[7..8];
			
			// share.t_Date Expiration {xpath('Expiration')};
			SELF.Expiration.Year := (INTEGER) R.state_license_expire[1..4];
			SELF.Expiration.Month := (INTEGER) R.state_license_expire[6..7];
			SELF.Expiration.Day := (INTEGER) R.state_license_expire[9..10];
			
			// SELF.Specialty := R.specialty_description;
			SELF.Specialties := ROW({R.specialty_description}, iesp.share.t_StringArrayItem);
			SELF.PractitionerType := R.practitioner_type;
			SELF.FacilityType := '';
			SELF.OrganizationType := '';

	END;
	
	EXPORT Healthcare_Affiliations.Layouts.PreResultRecs RollUpProvider(Healthcare_Affiliations.Layouts.ResultRecs L, dataset(Healthcare_Affiliations.Layouts.ResultRecs) allrows) := TRANSFORM

			self.Acctno 	:= 				 L.Acctno;
			self.SourceID := 				 L.SourceID;
			self.SourceIDType := 		 L.SourceIDType;
			SELF.RelationshipType := L.RelationshipType;
			SELF.ID := 		 					 L.ID;
			SELF.IDType := 					 L.IDType;
			SELF.OrganizationName := IF(L.OrganizationName <> '', L.OrganizationName, allrows(OrganizationName<>'')[1].OrganizationName);
			
			// share.t_Name PractitionerName {xpath('PractitionerName')};			
			SELF.LastFirst := Trim(L.PractitionerName.Last) + Trim(L.PractitionerName.First);  // Just for sorting, will be discarted later.
			SELF.PractitionerName :=  L.PractitionerName;
	
			// share.t_Address Address {xpath('Address')};   
			SELF.Address := L.Address;
			
			SELF.Phone := allrows(Phone<>'')[1].Phone;
			SELF.Fax :=   allrows(Fax <> '')[1].Fax;
			SELF.NPI :=   allrows(NPI <> '')[1].NPI;
			
			// share.t_Date Effective {xpath('Effective')};
			SELF.Effective :=  L.Effective;
			
			// share.t_Date Expiration {xpath('Expiration')};
			SELF.Expiration :=  L.Expiration;			

			SELF.Specialties 		  := choosen(dedup(normalize(allrows, left.Specialties,transform(iesp.share.t_StringArrayItem, self:=right)),record,all),iesp.constants.HCAffiliationSearch.MaxSpecialties);
			SELF.PractitionerType := allrows(PractitionerType <> '')[1].PractitionerType;
			SELF.FacilityType     := allrows(FacilityType <> '')[1].FacilityType;
			SELF.OrganizationType := allrows(OrganizationType <> '')[1].OrganizationType;

	END;
	
	EXPORT Healthcare_Affiliations.Layouts.ResultRecs PopulateFacility(Healthcare_Affiliations.Layouts.SearchRecs L, Org_Mast.layouts.organization_base R) := TRANSFORM

			self.acctno 	:= L.acctno;
			self.SourceID := L.EntityID;
			self.SourceIDType := L.EntityIDType;
			SELF.RelationshipType := L.relationshiptype;
			SELF.ID := (STRING) R.LNFID;
			SELF.IDType := Healthcare_Affiliations.Constants.FacilityIndicator;
			SELF.OrganizationName := R.Name;
			
			// share.t_Name PractitionerName {xpath('PractitionerName')};			
			SELF.PractitionerName.Full := '';
			SELF.PractitionerName.First := '';
			SELF.PractitionerName.Middle := '';
			SELF.PractitionerName.Last   := '';
			SELF.PractitionerName.Suffix := '';
			SELF.PractitionerName.Prefix := '';
	
			// share.t_Address Address {xpath('Address')};
			SELF.Address.StreetNumber := R.prim_range;
			SELF.Address.StreetPreDirection := R.predir;
			SELF.Address.StreetName := R.prim_name;
			SELF.Address.StreetSuffix := R.addr_suffix;
			SELF.Address.StreetPostDirection := R.postdir;
			SELF.Address.UnitDesignation := R.unit_desig;
			SELF.Address.UnitNumber := R.sec_range;
			SELF.Address.StreetAddress1 := R.address1;
			SELF.Address.StreetAddress2 := R.address2;
			SELF.Address.City := R.p_city_name;
			SELF.Address.State:= R.st;
			SELF.Address.Zip5 := R.zip;
			SELF.Address.Zip4 := R.zip4;
			SELF.Address.County := '';
			SELF.Address.PostalCode := ''; // R.pos_id;
			SELF.Address.StateCityZip := '';
			
			SELF.Phone := R.clean_phone;
			SELF.Fax := R.fax;
			SELF.NPI := R.npi;
			
			// share.t_Date Effective {xpath('Effective')};
			SELF.Effective.Year := 0;
			SELF.Effective.Month := 0;
			SELF.Effective.Day := 0;
			
			// share.t_Date Expiration {xpath('Expiration')};
			SELF.Expiration.Year := 0;
			SELF.Expiration.Month := 0;
			SELF.Expiration.Day := 0;
			
			SELF.Specialties := [];
			SELF.PractitionerType := '';
			SELF.FacilityType := R.factype;
			SELF.OrganizationType := R.orgtype;

	END;
	
	EXPORT Healthcare_Affiliations.Layouts.ResultRecs PopulateAddress(Healthcare_Affiliations.Layouts.ResultRecs Provider, Healthcare_Affiliations.Layouts.ResultRecs Facility) := TRANSFORM
			self.Address := Facility.Address;
			self.Phone := Facility.phone;
			self.Fax := Facility.fax;
			self.FacilityType := Facility.FacilityType;
			self.OrganizationType := Facility.OrganizationType;
			SELF := Provider;

	END;
	EXPORT Healthcare_Affiliations.Layouts.ResultRecs PopulateFacilityAddress(Healthcare_Affiliations.Layouts.Batch_in L, Org_Mast.layouts.organization_base R) := TRANSFORM
			self.ID := L.EntityID;
			self.IDType := L.EntityIDType;
			self.SourceID := L.EntityID;
			self.SourceIDType := L.EntityIDType;
			// share.t_Address Address {xpath('Address')};
			SELF.Address.StreetNumber := R.prim_range;
			SELF.Address.StreetPreDirection := R.predir;
			SELF.Address.StreetName := R.prim_name;
			SELF.Address.StreetSuffix := R.addr_suffix;
			SELF.Address.StreetPostDirection := R.postdir;
			SELF.Address.UnitDesignation := R.unit_desig;
			SELF.Address.UnitNumber := R.sec_range;
			SELF.Address.StreetAddress1 := R.address1;
			SELF.Address.StreetAddress2 := R.address2;
			SELF.Address.City := R.p_city_name;
			SELF.Address.State:= R.st;
			SELF.Address.Zip5 := R.zip;
			SELF.Address.Zip4 := R.zip4;
			SELF.Address.County := '';
			SELF.Address.PostalCode := ''; // R.pos_id;
			SELF.Address.StateCityZip := '';
			self.Phone := r.phone1;
			self.Fax := r.fax;
			self.FacilityType := r.factype;
			self.OrganizationType := r.orgtype;
			SELF := L;
			self :=[];
	END;
	
End;