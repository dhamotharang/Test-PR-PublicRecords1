IMPORT ut,ebr;

EXPORT industry_information_EBR_0010_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION
doxie_cbrs.mac_Selection_Declare()

// ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_0010_key := ebr.Key_0010_Header_BDID;

ebr_0010_key keep_r(ebr_0010_key r) := TRANSFORM
  SELF := r;
END;

RETURN JOIN(bdids,ebr_0010_key,
            LEFT.bdid = RIGHT.bdid,
            keep_r(RIGHT))(record_type='C');

END;
