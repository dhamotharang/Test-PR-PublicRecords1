import ut,ebr;

doxie_cbrs.mac_Selection_Declare()

ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_4030_key := ebr.Key_4030_Judgement_BDID;

ebr_4030_key keep_r(ebr_4030_key r) := transform
  self := r;
end;

export Liens_Judgments_EBR_4030_records :=
       join(bdids_use,ebr_4030_key,
            left.bdid = right.bdid,
						keep_r(right))(record_type='C');
