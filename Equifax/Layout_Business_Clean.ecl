export Layout_Business_Clean := record
unsigned6 rid;
unsigned6 bdid;
string80 business_name;
Layout_Address_Clean;
string9  ssn_taxid := '';
string4  ssn_type := '';
end;