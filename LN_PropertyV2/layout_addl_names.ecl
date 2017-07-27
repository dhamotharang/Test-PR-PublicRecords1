export layout_addl_names := record
 string12 ln_fares_id;
 string45 apnt_or_pin_number;
 //Lexis Mortgages don't have additional Borrowers so 'B' shouldn't be valid
 string1  buyer_or_seller; //'O' or 'S'
 string2  name_seq; //'3' for buyer_3, etc
 string80 name;
 string2  id_code;
end;