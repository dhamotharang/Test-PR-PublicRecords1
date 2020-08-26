IMPORT ut,ebr;

doxie_cbrs.mac_Selection_Declare()

ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_4510_key := ebr.Key_4510_UCC_Filings_BDID;

ebr_4510_key keep_r(ebr_4510_key r) := TRANSFORM
  SELF := r;
END;

EXPORT UCC_EBR_4510_records :=
       JOIN(bdids_use,ebr_4510_key,
            LEFT.bdid = RIGHT.bdid,
            keep_r(RIGHT))(record_type='C');
