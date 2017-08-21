dbh := business_header.files().base.business_headers.qa;
dbc := business_header.files().base.business_contacts.qa(from_hdr != 'Y');

dbh_slim := table(dbh	,{string source := source});
dbc_slim := table(dbc	,{string source := source});

dbh_all_slim := dbh_slim + dbc_slim;

dbh_all_dedup := table(dbh_all_slim	,{source},source, few);

dbh_all_sources := table(dbh_all_dedup	,{source, string description := mdr.sourcetools.translatesource(source)});

output(dbh_all_sources,named('All_Business_Header_Sources'),all);