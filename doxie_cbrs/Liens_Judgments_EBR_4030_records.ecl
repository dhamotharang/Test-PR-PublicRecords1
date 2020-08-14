IMPORT ut,ebr;

doxie_cbrs.mac_Selection_Declare()

ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_4030_key := ebr.Key_4030_Judgement_BDID;

ebr_4030_key keep_r(ebr_4030_key r) := TRANSFORM
  SELF := r;
END;

EXPORT Liens_Judgments_EBR_4030_records :=
       JOIN(bdids_use,ebr_4030_key,
            LEFT.bdid = RIGHT.bdid,
            keep_r(RIGHT))(record_type='C');
