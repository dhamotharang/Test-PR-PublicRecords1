import ut,ebr;

doxie_cbrs.mac_Selection_Declare()

ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_4020_key := ebr.Key_4020_Tax_Liens_BDID;

ebr_4020_key keep_r(ebr_4020_key r) := transform
  self := r;
end;

export Liens_Judgments_EBR_4020_records :=
       join(bdids_use,ebr_4020_key,
            left.bdid = right.bdid,
						keep_r(right))(record_type='C');
