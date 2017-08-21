f := Business_Header.File_Business_Contacts;

set_contact_titles :=['CONTACT',
'APPLICANT',
'PROCESS ADDRESS CONTACT',
'PRINCIPAL EXECUTIVE OFFICE CONTACT',
'UNINCORPORATED ACCOUNT OWNER',
'TRADE NAME OWNER',
'OFFICER D',
'SOC SIGNATORY',
'REAL PROPERTY',
'CHIEF',
'MM',
'S',
'INCORPORATOR/ORGANIZER',
'LTD LIAB COMPANY INDIVIDUAL MANAGER',
'INC',
'TRADE NAME OWNER FILED PRIOR TO 7/1',
'D',
'OFFICER P/D',
'OFFICER V',
'T'];

layout_title_stat := record
f.source;
f.company_title;
cnt := count(group);
end;

fstat := table(f(from_hdr='N', company_title in set_contact_titles), layout_title_stat, source, company_title, few);

output(fstat, all);
