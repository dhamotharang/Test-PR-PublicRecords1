/***************************************************************************
 *
 * NOTE: All code below is for testing purposes only. 
 *
 ***************************************************************************/
import iesp;

export Helper := MODULE

  // A function to create an empty shell for a SOAP request as expected by the target service.
  // ** Please DO NOT include any PII here. This should contain just typical default settings. 
  export GetSimpleRequest() := function 
    iesp.phonefinder.t_PhoneFinderSearchRequest xt() := transform
      self.User.BillingId := '';
      self.User.CompanyId := '';
      // self.User.ProductCode := '888888888';
      self.User.GLBPurpose := '5';
      self.User.DLPurpose := '3';
      self.User.DataRestrictionMask := '0000000020000101000000000000000000000000';
      self.User.DataPermissionMask := '110001000100000000001000000000';
      self.SearchBy.UniqueId := '';
      self.SearchBy.PhoneNumber := '';
      self.SearchBy.Name.First := '';
      self.SearchBy.Name.Middle := '';
      self.SearchBy.Name.Last := '';
      self.SearchBy.SSN := '';
      self.SearchBy.Address.StreetAddress1 := '';
      self.SearchBy.Address.City := '';
      self.SearchBy.Address.State := '';
      self.SearchBy.Address.Zip5 := '';
      self.Options._Type := 'BASIC';
      // self.Options._Type := 'ULTIMATE';
      // self.Options._Type := 'PHONERISKASSESMENT' ;
      self.Options.IncludePhoneMetadata := false ;
      self.Options.UseInHousePhoneMetadata := false ;    
      self.Options.VerificationOptions.VerifyPhoneName := false ;    
      self.Options.VerificationOptions.VerifyPhoneNameAddress := false ;    
      self.Options.IncludeZumigoOptions.NameAddressValidation := false ;    
      self.Options.IncludeOtherPhoneRiskIndicators := false;    
      self.Options.IncludeRiskIndicators := false;    
      self.Options.PrimarySearchCriteria := '';
      self.Options.UseDeltabase := false;
      self.Options.LineIdentityConsentLevel := 3;
      self.Options.RiskIndicators := $.GetRiskIndicators();   
      self.Options.MaxResults := 6;
      self := [];
    end;
    return dataset([xt()]);
  end;

end;
