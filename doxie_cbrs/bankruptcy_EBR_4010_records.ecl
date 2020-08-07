IMPORT ut,ebr;

doxie_cbrs.mac_Selection_Declare()

ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_4010_key := ebr.Key_4010_Bankruptcy_BDID;

ebr_4010_key keep_r(ebr_4010_key r) := TRANSFORM
  SELF := r;
END;

EXPORT Bankruptcy_EBR_4010_records :=
       JOIN(bdids_use,ebr_4010_key,
            LEFT.bdid = RIGHT.bdid,
            keep_r(RIGHT));
