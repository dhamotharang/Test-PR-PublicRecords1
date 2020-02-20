IMPORT Address, Doxie, dx_gateway, iesp, Gateway;
EXPORT Functions := MODULE

  SHARED tesp_req_layout := iesp.socialmedialocatorsearch.t_SocialMediaLocatorSearchRequest;
  SHARED tesp_resp_layout := iesp.socialmedialocatorsearch.t_SocialMediaLocatorSearchResponse;
  SHARED gesp_req_layout := iesp.social_media_locator_request.t_SocialMediaLocatorRequest;
  SHARED gesp_resp_layout := iesp.social_media_locator_response.t_SocialMediaLocatorResponse;

  // Transforms T-ESP Addresses into G-ESP Addresses.
  SHARED iesp.social_media_locator_request.t_SocialMediaLocatorSubjectAddress create_gesp_addresses(iesp.share.t_Address L) := TRANSFORM
    street_address := Address.Addr1FromComponents(
        L.StreetNumber,
        L.StreetPreDirection,
        L.StreetName,
        L.StreetSuffix,
        L.StreetPostDirection,
        L.UnitDesignation,
        L.UnitNumber);

      SELF.Street :=
        IF(L.StreetAddress1 = '', street_address, L.StreetAddress1);

      SELF.City := L.City;
      SELF.State := L.State;
      SELF.Zip := L.zip5;
      SELF.County := '';
  END;

  // Creates Gateway request from T-ESP request.
  EXPORT gesp_req_layout create_gesp_req(tesp_req_layout req) := FUNCTION
    ca := req.SearchBy.Addresses.CurrentAddress;
    pas := req.SearchBy.Addresses.PriorAddresses;

    gesp_req_layout gesp_xform() := TRANSFORM

      // Easy field assignments.
      SELF.User := req.User;
      SELF.Options := req.Options;
      SELF.ServiceLocations := req.ServiceLocations;
      SELF.RemoteLocations := req.RemoteLocations;
      SELF.SearchBy.SubjectInfo.Name := req.SearchBy.Name;
      SELF.SearchBy.SubjectInfo.DateOfBirth := req.SearchBy.DateOfBirth;
      SELF.SearchBy.SubjectInfo.EmailAddresses := req.SearchBy.EmailAddresses;
      SELF.SearchBy.SubjectInfo.UserNames := req.SearchBy.UserNames;
      SELF.SearchBy.SubjectInfo.AdditionalTerms := req.SearchBy.AdditionalTerms;
      SELF.SearchBy.SubjectInfo.Aliases := req.SearchBy.Aliases;
      SELF.SearchBy.SubjectInfo.Employment.CurrentEmployer.EmployerName := req.SearchBy.Employment.CurrentEmployerName;

      // Complicated field assignments. Addresses First.
      SELF.SearchBy.SubjectInfo.Addresses.CurrentAddress := ROW(create_gesp_addresses(ca));
      SELF.SearchBy.SubjectInfo.Addresses.PriorAddresses := PROJECT(pas, create_gesp_addresses(LEFT));

      // T-ESP only allows a single phone number.
      SELF.SearchBy.SubjectInfo.PhoneNumbers.HomePhone := req.SearchBy.PhoneNumbers[1].Value;
      SELF.SearchBy.SubjectInfo.PhoneNumbers.MobilePhone := '';
      SELF.SearchBy.SubjectInfo.PhoneNumbers.OtherPhone := '';

      // T-ESP only allows a single current and prior employer.
      SELF.SearchBy.SubjectInfo.Employment.PriorEmployers := DATASET([{req.SearchBy.Employment.PriorEmployerNames[1].Value}],
        iesp.social_media_locator_request.t_SocialMediaLocatorPriorEmployer);

      // T-ESP only allows a single associate.
      SELF.SearchBy.SubjectInfo.AssociatedPersons := PROJECT(req.SearchBy.Associates[1],
        TRANSFORM(iesp.social_media_locator_request.t_SocialMediaLocatorAssociatedPerson,
          SELF := LEFT, SELF := []));

      // T-ESP only allows a single institution
      SELF.SearchBy.SubjectInfo.EducationHistory := DATASET([{req.SearchBy.EducationHistory[1].Value}],
        iesp.social_media_locator_request.t_SocialMediaLocatorInstitution);

      // T-ESP does not provide this input.
      SELF.SearchBy.SubjectInfo.RefineBy := [];

      // Filled in during SoapCall
      SELF.GatewayParams := [];

    END;

    RETURN DATASET([gesp_xform()]);
  END;

  // Creates T-ESP response from Gateway response.
  // Optional: override RequestInfo to emulate gateway response with no results.
  EXPORT tesp_resp_layout create_tesp_response(gesp_resp_layout gesp_response,
    iesp.share.t_name req_info_override = ROW([], iesp.share.t_name)) := FUNCTION

    // Can't check if row is empty, instead check if any meaningful fields are populated.
    override_req_info :=
      req_info_override.Full <> '' OR
      req_info_override.First <> '' OR
      req_info_override.Last <> '';

    tesp_resp_layout tesp_xform() := TRANSFORM

      //Service layer Headers
      service_header := iesp.ECL2ESP.GetHeaderRow();
      SELF._header.transactionID := service_header.transactionID;
      SELF._header.queryID := service_header.queryID;

      SELF._Header := gesp_response._Header;
      SELF.RecordCount := gesp_response.RecordCount;
      SELF.RequestInfo.Name := IF(override_req_info,
        req_info_override,
        gesp_response.RequestInfo.Name);

      SELF.Records := gesp_response.ReportResults;
      SELF.CategoryCounts := gesp_response.CategoryCounts;
      SELF.Error := gesp_response.Error;
    END;

    RETURN DATASET([tesp_xform()]);
  END;
END;
