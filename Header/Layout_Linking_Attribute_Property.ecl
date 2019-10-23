IMPORT ln_propertyv2,header;
Export Layout_Linking_Attribute_Property := RECORD
   
    header.layout_header.did;
    ln_propertyv2.Layout_DID_Out.ln_fares_id;
    ln_propertyv2.Layout_DID_Out.source_code;
	ln_propertyv2.Layout_DID_Out.conjunctive_name_seq;
	ln_propertyv2.Layout_DID_Out.nameasis;
    header.layout_header.fname;
    header.layout_header.mname;
    header.layout_header.lname;
    header.layout_header.name_suffix;
    header.layout_header.dt_last_seen;
    header.layout_header.src;

END;