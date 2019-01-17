//This macro is to apply Business restriction similar to BIPV2_Best.Key_LinkIds.kFetch2
//We can't call BIPV2_Best.Key_LinkIds.kFetch2 as we need to be able to handle mini-batch for large input datasets
//Suppressions and restrictions similar to BIPV2_Best.Key_LinkIds.kFetch2 are applied below
//If additional suppressions and restrictions are ever added to kFetch2 please contact
//Julie Dobrosevic or Jo Prichard
EXPORT macApplyBusinessRestrictions(dIn, modIn):= FUNCTIONMACRO
  
  // NOTE: I am not filtering the sources child dataset currently as we are not returning it in the final results
  //If we ever decide to return the sources we will need to filter them as appropriate as well!
	LOCAL dRestricted := project(dIn, TRANSFORM(RECORDOF(LEFT),
    SELF.company_name               := BIPV2.mod_sources.applyMasking(LEFT.company_name(BIPV2.mod_sources.isPermitted(modIn,true).byBmap(company_name_data_permits)), modIn, company_name_data_permits);
    SELF.company_address            := BIPV2.mod_sources.applyMasking(LEFT.company_address(BIPV2.mod_sources.isPermitted(modIn,true).byBmap(company_address_data_permits)), modIn, company_address_data_permits);
    SELF.company_phone              := LEFT.company_phone(BIPV2.mod_sources.isPermitted(modIn, true).byBmap(company_phone_data_permits));// no mask required
    SELF.company_fein               := LEFT.company_fein(BIPV2.mod_sources.isPermitted(modIn).byBmap(company_fein_data_permits));
    SELF.company_url                := LEFT.company_url(BIPV2.mod_sources.isPermitted(modIn).byBmap(company_url_data_permits));
    SELF.company_incorporation_date := LEFT.company_incorporation_date(BIPV2.mod_sources.isPermitted(modIn).byBmap(company_incorporation_date_permits));
		SELF := LEFT));
  
  RETURN dRestricted;
ENDMACRO;