export layout_parties := record

corp2_services.layout_search_parties;

//taken out for demo but not anymore
string30  cont_filing_reference_nbr;
string8   cont_filing_date;
string60  cont_filing_desc;

string10  cont_fein;
string9   cont_ssn;
string8   cont_dob;

string60  cont_status_desc; // new
string8   cont_effective_date;

string60  cont_effective_desc; // new
string350 cont_addl_info; // new
end;