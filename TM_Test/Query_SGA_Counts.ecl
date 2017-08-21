// count unique companies
sga_company := TM_Test.sga_prep;

count(sga_company);
count(sga_company(bdid <> 0));
count(sga_company(bdid = 0));
count(dedup(sga_company, bdid, all));

// count unique contacts
sga_contacts := TM_Test.sga_contacts_prep;

count(sga_contacts);
count(sga_contacts(did <> 0));
count(sga_contacts(did = 0));
count(dedup(sga_contacts, did, all));

count(sga_contacts(bdid <> 0));
count(sga_contacts(bdid = 0));
count(dedup(sga_contacts(bdid <> 0), bdid, all));



