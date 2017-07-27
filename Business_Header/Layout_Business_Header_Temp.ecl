export Layout_Business_Header_Temp := record
Layout_Business_Header_New;
qstring81 match_company_name;  // clean company name minus branch number
qstring20 match_branch_number;
unsigned1 match_branch_position;
qstring20 match_branch_unit_desig;
qstring20 match_branch_unit;
qstring25 match_geo_city := '';
end;