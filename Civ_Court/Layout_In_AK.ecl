
EXPORT Layout_In_AK := module

export Layout_AK := record
string3   court_code;
string20  last_name;
string15  first_name;
string1   middle_initial;
string10  title;
string10  birth_date;
string20  case_num;
string35  case_type;
string10  date_filed;
string10  type_person;
string50  attorney1;
string50  attorney2;
string20  civil_dispo;
string10  civil_case_closed_date;
string15  amount;
string15  award_amount;
string100 criminal_charge_offense;
string100 criminal_charge_statute;
string20  criminal_charge_dispo;
string10  criminal_charge_closed_date;
string35  type_of_criminal_case;
string50  company_name;
string3   change_nbr;
string2   crlf;
end;

EXPORT Attorney_Codes := record
string50 attorney_code;
string50 LastName;
string50 FirstName;
string50 MiddleName;
string50 CompanyName;
string2  crlf;
end;

EXPORT CaseDispositionCodes := record
string10 case_disp_code;
string50 case_disp_desc;
string2  crlf;
end;

EXPORT PersonTypeCodes := record
string10 person_type_code;
string50 person_type_desc;
string2  crlf;
end;

end;