IMPORT UPS_Services, iesp;

export iesp.rightaddress.t_RightAddressSearchRequest fn_MakeSearchBy(STRING inFirstName = '',
                       STRING inMiddleName = '',
                       STRING inLastName = '',
                       STRING inCompanyName = '',
                       STRING inStreetAddress1 = '',
                       STRING inStreetAddress2 = '',
                       STRING inCity = '',
                       STRING inState = '',
                       STRING inZip = '',
                       STRING inPhone = '',
											 STRING inEntityType = '') := FUNCTION

	searchby :=dataset([{
			'', /* unparsed full name, NOT SUPPORTED */
			inFirstName, /* firstname */
			inMiddleName, /* middlename */
			inLastName, /* lastname*/
			'', /* NOT USED */
			'', /* NOT USED */
			inCompanyName, /* companyname */
			'', /* prim_name, NOT SUPPORTED */
			'', /* prim_range, NOT SUPPORTED */
			'', /* NOT USED */
			'', /* NOT USED */'', 
			'', /* NOT USED */
			'', /* sec_range, NOT SUPPORTED */
			inStreetAddress1, /* streetaddress1 (=> addr) */
			inStreetAddress2, /* streetaddress2 (=> addr) */
			inState, /* state */
			inCity, /* city */
			inZip, /* zip */
			'', /* NOT USED */
			'', /* NOT USED*/
			'', /* NOT USED */
			'', /* statecityzip, NOT SUPPORTED */
			inPhone, // Phone10
			if (inEntityType <> '', inEntityType, UPS_Services.Constants.TAG_ENTITY_UNK), // EntityType, UNK, BIZ, or IND
			0,     // ZipRadius
			'' }], // UniqueID
			{ iesp.share.t_NameAndCompany Name,
				iesp.share.t_Address Address,
				STRING10 Phone10,
				STRING10 EntityType,
				INTEGER  Radius,
				STRING12 UniqueID });

	iesp.rightaddress.t_RightAddressSearchRequest SearchRequestTransform(searchby L) := TRANSFORM
		SELF.RemoteLocations := [];
		SELF.ServiceLocations := [];

		SELF.User.ReferenceCode := '';
		SELF.User.BillingCode := '';
		SELF.User.QueryId := '';
		SELF.User.CompanyId := '';
		SELF.User.GLBPurpose := (STRING) 1;
		SELF.User.DLPurpose := (STRING) 1;
		SELF.User.LoginHistoryId := '';
		SELF.User.DebitUnits := 0;
		SELF.User.IP := '';
		SELF.User.IndustryClass := '';
		SELF.User.ResultFormat := '';
		SELF.User.LogAsFunction := '';
		SELF.User.SSNMask := '';
		SELF.User.DLMask := true;
		SELF.User.DataRestrictionMask := '';
		SELF.User.DataPermissionMask := '';
		SELF.User.SSNMaskingOn := true;
		SELF.User.DLMaskingOn := true;
		SELF.User.EndUser.CompanyName := '';
		SELF.User.EndUser.StreetAddress1 := '';
		SELF.User.EndUser.City := '';
		SELF.User.EndUser.State := '';
		SELF.User.EndUser.Zip5 := '';
		SELF.User.MaxWaitSeconds := 120;
		SELF.User.RelatedTransactionID := '';
		SELF.User.AccountNumber := '';
		SELF.User := []; // all other settings, like ApplicationType, SourceCode, TestDataEnabled, etc.
	
		SELF.Options.StrictMatch := false;
		SELF.Options.MaxResults := 200;
		SELF.Options.UseNickNames := true;
		SELF.Options.IncludeAlsoFound := true;
		SELF.Options.UsePhonetics  := true;
		SELF.Options.PenaltyThreshold := 50;
		SELF.Options.ReturnCount := 200;
		SELF.Options.StartingRecord := 1;
		SELF.Options := []; // all other recently added options: demomode, highlight, etc.

		SELF.SearchBy := L;
		SELF.SearchBy := []; // all other recently added parameters: powersearch, etc.
	END;

	request := project(searchby, SearchRequestTransform(LEFT));
	return request;
END;