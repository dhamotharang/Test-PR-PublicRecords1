import ln_propertyv2,header;

layout_attribute := RECORD
   
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
prop_in:=ln_propertyv2.ln_propertyv2_as_source().p_rollup;
prop_at:=project( prop_in , {layout_attribute});

d_prop_all := distribute(prop_at,hash(ln_fares_id));
 
prop_attrib := dedup(  sort(   d_prop_all, did,dt_last_seen,src,local), did,dt_last_seen,src);

EXPORT Proc_File_Linking_Attribute := prop_attrib;
