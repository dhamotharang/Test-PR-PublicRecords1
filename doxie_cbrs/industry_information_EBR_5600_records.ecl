IMPORT ut,ebr;

EXPORT industry_information_EBR_5600_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

doxie_cbrs.mac_Selection_Declare()

// ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_5600_key := ebr.Key_5600_Demographic_Data_BDID;

ebr_5600_key keep_r(ebr_5600_key r) := TRANSFORM
  SELF := r;
END;


RETURN JOIN(bdids,ebr_5600_key,
            LEFT.bdid = RIGHT.bdid,
            keep_r(RIGHT))(record_type='C');

END;
