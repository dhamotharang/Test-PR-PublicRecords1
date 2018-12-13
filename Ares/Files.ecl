Import Ares;
EXPORT Files := Module

Export ds_area := dataset(Constants.filename_Area, layout_area, XML('areas/area'));
Export ds_city := dataset(Constants.filename_City, Layout_City, XML('citys/city'));
Export ds_legal_entity := dataset(Constants.filename_LegalEntity, Layout_LegalEntity, XML('legalEntitys/legalEntity'));
Export ds_lookup := dataset(Constants.filename_Lookup, Layout_Lookup, XML('lookups/lookup'));
Export ds_person := dataset(Constants.filename_Person, Layout_Person, XML('persons/person'));
Export ds_relationship := dataset(Constants.filename_Relationship, Layout_Relationship, XML('relationships/relationship'));

Export ds_country := dataset(Constants.filename_Country, layout_country, XML('countrys/country'));

Export ds_currency := dataset(Constants.filename_Currency, layout_currency, XML('currencys/currency'));

Export ds_department := dataset(Constants.filename_Department, layout_department, XML('departments/department'));

Export ds_office := dataset(Constants.filename_Office, layout_office, XML('offices/office'));

Export ds_financialstatement := dataset(Constants.filename_FinancialStatement, layout_financialstatement, XML('financialStatements/financialStatement'));

Export ds_ssi := dataset(Constants.filename_SSI, layout_ssi, XML('SSIS/SSI'));

Export ds_ssiset := dataset(Constants.filename_SSISet, layout_ssiset, XML('SSISETS/SSISET'));

Export ds_routingcode := DATASET(Constants.filename_RoutingCode, layout_RoutingCode,XML('routingcodes/routingcode'));

Export ds_product := DATASET(Constants.filename_Product, layout_Product, XML('products/product'));

shared area := DATASET(Constants.filename_Area, {STRING area {XPATH('<>')}},XML('areas/area'));
shared city := DATASET(Constants.filename_City,{STRING city {XPATH('<>')}},XML('citys/city'));
shared country := DATASET(Constants.filename_Country,{STRING country {XPATH('<>')}},XML('countrys/country'));
shared currency := DATASET(Constants.filename_Currency,{STRING currency {XPATH('<>')}},XML('currencys/currency'));
shared department := DATASET(Constants.filename_Department,{STRING department {XPATH('<>')}},XML('departments/department'));
shared financialstatement := DATASET(Constants.filename_FinancialStatement,{STRING financialstatement {XPATH('<>')}},XML('financialStatements/financialStatement'));
shared legalentity := DATASET(Constants.filename_LegalEntity,{STRING legalentity {XPATH('<>')}},XML('legalEntitys/legalEntity'));
shared lookup := DATASET(Constants.filename_Lookup,{STRING lookup {XPATH('<>')}},XML('lookups/lookup'));
shared office := DATASET(Constants.filename_Office,{STRING office {XPATH('<>')}},XML('offices/office'));
shared person := DATASET(Constants.filename_Person,{STRING person {XPATH('<>')}},XML('persons/person'));
shared product := DATASET(Constants.filename_Product,{STRING product {XPATH('<>')}},XML('products/product'));
shared relationship := DATASET(Constants.filename_Relationship,{STRING relationship {XPATH('<>')}},XML('relationships/relationship'));
shared routingcode := DATASET(Constants.filename_RoutingCode,{STRING routingcode {XPATH('<>')}},XML('routingcodes/routingcode'));
shared ssi := DATASET(Constants.filename_SSI,{STRING ssi {XPATH('<>')}},XML('SSIS/SSI'));
shared ssiset := DATASET(Constants.filename_SSISet,{STRING ssiset {XPATH('<>')}},XML('SSISETS/SSISET'));

Export ds_area_raw := project(area, {string area});
Export ds_city_raw := project(city, {string city});
Export ds_country_raw := project(country, {string country});
Export ds_currency_raw := project(currency, {string currency});
Export ds_department_raw := project(department, {string department});
Export ds_financialstatement_raw := project(financialstatement, {string financialstatement});
Export ds_legalentity := project(legalentity, {string legalentity});
Export ds_lookup_raw := project(lookup, {string lookup});
Export ds_office_raw := project(office, {string office});
Export ds_person_raw := project(person, {string person});
Export ds_product_raw := project(product, {string product});
Export ds_relationship_raw := project(relationship, {string relationship});
Export ds_routingcode_raw := project(routingcode, {string routingcode});
Export ds_ssi_raw := project(ssi, {string ssi});
Export ds_ssiset_raw := project(ssiset, {string ssiset});

Export gpatt2_mc := Dataset('~thor_data400::qc::ares::gpatt2_mc.txt', layout_gpatt2, flat);
Export gpcnt_mc := Dataset('~thor_data400::qc::ares::gpcnt_mc.txt', layout_gpcnt, flat);
Export gpcod2_mc := Dataset('~thor_data400::qc::ares::gpcod2_mc.txt', layout_gpcod2, flat);
Export gpcor2_mc := Dataset('~thor_data400::qc::ares::gpcor2_mc.txt', layout_gpssi, flat);
Export gploc_mc := Dataset('~thor_data400::qc::ares::gploc_mc.txt', layout_gploc, flat);
Export gpoff_mc := Dataset('~thor_data400::qc::ares::gpoff_mc.txt', Layout_GPOff, flat);
Export gpsub_mc := Dataset('~thor_data400::qc::ares::gpsub_mc.txt', layout_gpssi_set, flat);

end;