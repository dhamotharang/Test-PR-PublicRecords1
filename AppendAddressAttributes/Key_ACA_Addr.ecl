IndexLayout := RECORD
    STRING28    prim_name;
    STRING10    prim_range;
    STRING9     zip;
    STRING8     sec_range;
    STRING2     inst_type;
    STRING200   institution;
    STRING240   mail_addr;
    STRING30    mail_city;
    STRING10    mail_state;
    STRING9     mail_zip;
    STRING240   addr1;
    STRING30    city;
    STRING10    state;
    STRING100   notes;
    STRING50    name;
    STRING70    title;
    STRING20    fname;
    STRING20    mname;
    STRING20    lname;
    STRING5     name_suffix;
    STRING120   addr2;
    STRING2     predir;
    STRING4     addr_suffix;
    STRING2     postdir;
    STRING10    unit_desig;
    STRING25    p_city_name;
    STRING25    v_city_name;
    STRING2     st;
    STRING5     z5;
    STRING4     zip4;
    STRING10    phone;
    STRING10    inst_type_exp;
    STRING1     addr_type;
END;

EXPORT Key_ACA_Addr := INDEX
    (
        {
            IndexLayout.prim_name,
            IndexLayout.prim_range,
            IndexLayout.zip,
            IndexLayout.sec_range
        },
        {
            IndexLayout
        },
        '~thor_data400::key::aca_institutions_addr_qa'
    );
