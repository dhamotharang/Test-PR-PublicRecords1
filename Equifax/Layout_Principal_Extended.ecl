export Layout_Principal_Extended := record
string1 record_type; // '1' - Equifax, '2' - Seisint
Layout_Principal_Clean;
qstring35 company_title := '';   // Title of Contact at Company if available
qstring35 company_department := '';
qstring120 company_name := '';
qstring10 company_prim_range := '';
string2   company_predir := '';
qstring28 company_prim_name := '';
qstring4  company_addr_suffix := '';
string2   company_postdir := '';
qstring5  company_unit_desig := '';
qstring8  company_sec_range := '';
qstring25 company_city := '';
string2   company_state := '';
unsigned3 company_zip := '';
unsigned2 company_zip4 := '';
unsigned6 company_phone := '';
unsigned4 company_fein := 0;
unsigned6 contact_phone := 0;
string60  contact_email_address := '';
unsigned4 contact_ssn := 0;
end;