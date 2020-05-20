IMPORT _Control, Data_Services;

EXPORT Constants := MODULE

  SHARED Prefix := IF(_Control.ThisEnvironment.Name='Dataland', '~', Data_Services.foreign_prod);
  EXPORT Base_Prefix := '~prte::base::';
  EXPORT key_prefix  := '~prte::key::thrive::';
  EXPORT fcra_key_prefix  := '~prte::key::fcra::thrive::';
  
  // DF-21492 - Blank out fields in FCRA file thor_data400::key::thrive::fcra::qa::did
  Export fields_to_clear  := 'phone_work,phone_home,phone_cell,monthsemployed,own_home,is_military,drvlic_state,monthsatbank,ip,yrsthere,' +
                             'besttime,credit,loanamt,loantype,ratetype,mortrate,ltv,propertytype,datecollected,title,fips_st,fips_county,' +
                             'clean_phone_work,clean_phone_home,clean_phone_cell';
  
  
END;