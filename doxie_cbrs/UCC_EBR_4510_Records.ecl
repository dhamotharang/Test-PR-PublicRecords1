import ut,ebr;

doxie_cbrs.mac_Selection_Declare()

ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_4510_key := ebr.Key_4510_UCC_Filings_BDID;

ebr_4510_key keep_r(ebr_4510_key r) := transform
  self := r;
end;

export UCC_EBR_4510_records :=
       join(bdids_use,ebr_4510_key,
            left.bdid = right.bdid,
						keep_r(right))(record_type='C');
