export layouts := module

export l_vendor := record
 string orig_Ixid;
 string orig_Firstname;
 string orig_Middleinitial;
 string orig_Lastname;
 string orig_Address;
 string orig_City;
 string orig_State;
 string orig_Zip;
 string orig_zip4;
 string orig_dob;
end;

export l_raw := record
 string    Ixid;
 string    Firstname;
 string    Middleinitial;
 string    Lastname;
 string    Address;
 string    City;
 string    State;
 string    Zip;
 string    zip4;
 string    dob;
 unsigned8 aid;
 unsigned6 pid;
end;

export l_address := record
 unsigned8 aid;
 string65  street;
 string25  v_city_name;
 string2   st;
 string5   zip;
 string4   zip4;
 string5   county;
 integer   avm_valuation    :=0;
 integer   avm_score        :=0;
 boolean   appended_address :=false;
end;

export l_assessor := record
 unsigned8 aid;
 string13  tax_amt;
 integer   tax_yr;
 integer   assd_land_value;
 integer   assd_improvement_value;
 integer   assd_total_value;
 integer   assd_value_year;
 integer   mkt_land_value;
 integer   mkt_improvement_value;
 integer   mkt_total_value;
 integer   mkt_value_year;
end;

export l_deed := record
 unsigned8 aid;
 integer   sales_price;
 integer   first_loan_amt;
 integer   second_loan_amt;
 string30  loan_type;
 string1   date_type;
 integer   date_;
 boolean   is_2nd_mortgage;
end;

export l_people := record
 unsigned8 aid;
 unsigned6 pid;
 string20  fname;
 string20  mname;
 string20  lname;
 string20  name_suffix;
 boolean   on_ixi_rec;
end;

end;