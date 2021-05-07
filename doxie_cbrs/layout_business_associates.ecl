IMPORT $;
EXPORT layout_business_associates := MODULE
  EXPORT out_rec := RECORD
    UNSIGNED6 group_id;
    $.layout_relatives;
  END;
  EXPORT slim_rec := RECORD
    UNSIGNED6 bdid := 0;
    QSTRING120 company_name;
    QSTRING10 prim_range;
    STRING2 predir;
    QSTRING28 prim_name;
    QSTRING4 addr_suffix;
    STRING2 postdir;
    QSTRING5 unit_desig;
    QSTRING8 sec_range;
    QSTRING25 city;
    STRING2 state;
    STRING5 zip := '';
    STRING4 zip4 := '';
  END;
END;
