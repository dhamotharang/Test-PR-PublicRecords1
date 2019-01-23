export layout_deathfile_records := record
string12 did,
unsigned1 did_score,
string1                        rec_type;
string9                        ssn;
string20                       lname;
string4                       name_suffix;
string15                       fname;
string15                       mname;
string1                        VorP_code;
string8                        dod8;
string8                        dob8;
string2                        st_country_code;
string5                        zip_lastres;
string5                        zip_lastpayment;
string2						   state;
string3						   fipscounty;
string2                        crlf;
string18 county_name,
unsigned1 age_at_death,
string9	ssn_unmasked := '';
unsigned2 fdn_did_ind   := 0; // Added for the FDN project.
unsigned2 fdn_ssn_ind   := 0; // Added for the FDN project.
end;