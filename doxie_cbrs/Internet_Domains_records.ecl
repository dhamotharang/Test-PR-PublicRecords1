IMPORT doxie_Raw, domains, doxie_cbrs_raw, census_data;
doxie_cbrs.mac_Selection_Declare()

EXPORT Internet_Domains_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

  outrec := doxie_cbrs.layouts.internet_domains_record;
  wsr := doxie_cbrs_raw.internet_domains(bdids,Include_InternetDomains_val,max_InternetDomains).records;

  outrec tra(wsr l) := TRANSFORM
    SELF.update_date_decode := domains.convertDate(l.update_date);
    SELF.expire_date_decode := domains.convertDate(l.expire_date);
    SELF.create_date_decode := domains.convertDate(l.create_date);
    SELF := l;
  END;

  wdates := PROJECT(wsr, tra(LEFT));

  //Populate county_name.
  census_data.MAC_Fips2County_Keyed(wdates,state,county[3..5],county_name,wdates2);

  //Populate county_name.
  census_data.MAC_Fips2County_Keyed(wdates2,admin_state,admin_county[3..5],admin_county_name,wdates3);

  //Populate county_name.
  census_data.MAC_Fips2County_Keyed(wdates3,tech_state,tech_county[3..5],tech_county_name,wdates4);

  RETURN SORT(wdates4, domain_name);
END;
