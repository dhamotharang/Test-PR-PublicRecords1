import STD;
// output(Ares.Files.ds_area, named('area'));;
output(Ares.Files.ds_office, named('office'));
// output(Ares.Files.ds_city_raw, named('city_raw'));
// output(Ares.Files.ds_country, named('country'));
// output(Ares.Files.ds_currency, named('currency'));
// output(Ares.Files.ds_department, named('department'));
// output(Ares.Files.ds_department_raw, named('department_raw'));

// output(Ares.Files.ds_financialstatement_raw, named('financialstatement_raw'));
// output(Ares.Files.ds_legalentity_raw(RegExFind('<service>', legalentity)), named('legalentity_raw'));
// output(Ares.Files.ds_lookup_raw, named('ds_lookup_raw'));
output(Ares.Files.ds_office_raw(STD.STR.FindCount(office,'<address ') > 1), named('ds_office_raw_telecom'));
output(Ares.Files.ds_office_raw(RegExFind('<historyEvent fid', office)), named('ds_office_raw'));
// output(Ares.Files.ds_person_raw, named('ds_person_raw'));
// output(Ares.Files.ds_product_raw, named('ds_product_raw'));
// output(Ares.Files.ds_relationship_raw, named('ds_relationship_raw'));
// output(Ares.Files.ds_routingcode_raw, named('ds_routingcode_raw'));
// output(Ares.Files.ds_ssi_raw, named('ds_ssi_raw'));
// output(Ares.Files.ds_ssiset_raw, named('ds_ssiset_raw'));


// Ares.Files.ds_legal_entity(count(services) >0);