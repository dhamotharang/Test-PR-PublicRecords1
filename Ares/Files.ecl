Import Ares;
EXPORT Files := Module

Export ds_area := dataset(Constants.filename_Area, layout_area, XML('area',NOROOT));
Export ds_city := dataset(Constants.filename_City, Layout_City, XML('city',NOROOT));
Export ds_legal_entity := dataset(Constants.filename_LegalEntity, Layout_LegalEntity, XML('legalEntity',NOROOT));
Export ds_lookup := dataset(Constants.filename_Lookup, Layout_Lookup, XML('lookup',NOROOT));

Export ds_person := dataset(Constants.filename_Person, Layout_Person, XML('person',NOROOT));

Export ds_country := dataset(Constants.filename_Country, layout_country, XML('country',NOROOT));

Export ds_currency := dataset(Constants.filename_Currency, layout_currency, XML('currency',NOROOT));

Export ds_department := dataset(Constants.filename_Department, layout_department, XML('department',NOROOT));

Export ds_office := dataset(Constants.filename_Office, layout_office, XML('office', NOROOT));

shared area := DATASET(Constants.filename_Area, {STRING area {XPATH('<>')}},XML('area', NOROOT));
shared city := DATASET(Constants.filename_City,{STRING city {XPATH('<>')}},XML('city', NOROOT));
shared country := DATASET(Constants.filename_Country,{STRING country {XPATH('<>')}},XML('country', NOROOT));
shared currency := DATASET(Constants.filename_Currency,{STRING currency {XPATH('<>')}},XML('currency', NOROOT));
shared department := DATASET(Constants.filename_Department,{STRING department {XPATH('<>')}},XML('department', NOROOT));
shared financialstatement := DATASET(Constants.filename_FinancialStatement,{STRING financialstatement {XPATH('<>')}},XML('financialStatement', NOROOT));
shared legalentity := DATASET(Constants.filename_LegalEntity,{STRING legalentity {XPATH('<>')}},XML('legalEntity', NOROOT));
shared lookup := DATASET(Constants.filename_Lookup,{STRING lookup {XPATH('<>')}},XML('lookup', NOROOT));
shared office := DATASET(Constants.filename_Office,{STRING office {XPATH('<>')}},XML('office', NOROOT));
shared person := DATASET(Constants.filename_Person,{STRING person {XPATH('<>')}},XML('person', NOROOT));
shared product := DATASET(Constants.filename_Product,{STRING product {XPATH('<>')}},XML('product', NOROOT));
shared relationship := DATASET(Constants.filename_Relationship,{STRING relationship {XPATH('<>')}},XML('relationship', NOROOT));
shared routingcode := DATASET(Constants.filename_RoutingCode,{STRING routingcode {XPATH('<>')}},XML('routingCode', NOROOT));
shared ssi := DATASET(Constants.filename_SSI,{STRING ssi {XPATH('<>')}},XML('SSI', NOROOT));
shared ssiset := DATASET(Constants.filename_SSISet,{STRING ssiset {XPATH('<>')}},XML('ssiSet', NOROOT));

Export ds_area_raw := project(area, {string area});
Export ds_city_raw := project(city, {string city});
Export ds_country_raw := project(country, {string country});
Export ds_currency_raw := project(currency, {string currency});
Export ds_department_raw := project(department, {string department});
Export ds_financialstatement_raw := project(financialstatement, {string financialstatement});
Export ds_legalentity := project(legalentity, {string legalentity});
Export ds_lookup_raw := project(lookup, {string lookup});
// Export ds_office := project(office, {string office});
Export ds_person_raw := project(person, {string person});
Export ds_product := project(product, {string product});
Export ds_relationship := project(relationship, {string relationship});
Export ds_routingcode := project(routingcode, {string routingcode});
Export ds_ssi := project(ssi, {string ssi});
Export ds_ssiset := project(ssiset, {string ssiset});

end;