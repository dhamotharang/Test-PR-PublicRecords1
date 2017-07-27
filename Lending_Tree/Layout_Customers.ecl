export Layout_Customers := record
string7    qf_id;			//Unique identifier for individual loan request
string7    party_id;		//Unique identifier for individual borrower
string57   orig_fname;
string64   orig_lname;
string64   orig_addr_ln1;
string64   orig_city;
string2    orig_State;
string5    orig_zip;
string3    cred_score;		//FICO currently on file.
string1    Rent_Own_ID;		//1=Own, 2=Rent, 3=Other
string8    dob_yyyymmdd;
string8    cmplt_dt;		//Date loan request was completed
string10   amt_req;
string2    purp_const;		//Purpose codes provided by LT
string10   estm_value;
string10   mortgage_bal;
string1    mortgage_code;	//1=2nd/3rd is on property, 2=no 2nd/3rd mortgage
string10   addl_bal;		//Outstanding balance of any 2nd/3rd mortgages on property
string64   lend_name;		//Lender name for current 1st mortgage lender
string10   paymt;
string1    Num_Lenders;
string1    Book_Ind;		//0=not closed, 1=closed
string8    BookDate;
string13   Annual_Salary;
string21   source;			//Exact source code of QF
string9    MediaCh;			//Media, Affiliate, Online
string1    EmailResp;		//1=responder to email solicitation, 0=not a responder
string9    second_third_mort_pymt;
string5    name_title;
string20   name_first;
string20   name_middle;
string20   name_last;
string5    name_suffix;
string10   prim_range;
string2    predir;
string28   prim_name;
string4    suffix;
string2    postdir;
string10   unit_desig;
string8    sec_range;
string25   p_city_name;
string25   v_city_name;
string2    ace_state;
string5    ace_zip;
string4    ace_zip4;
string4    cart;
string1    cr_sort_sz;
string4    lot;
string1    lot_order;
string2    dbpc;
string1    chk_digit;
string2    ace_rec_type;
string5    ace_county;
string10   geo_lat;
string11   geo_long;
string4    ace_msa;
string7    geo_blk;
string1    geo_match;
string4    err_stat;
end;