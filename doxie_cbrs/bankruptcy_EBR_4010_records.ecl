import ut,ebr;

doxie_cbrs.mac_Selection_Declare()

ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_4010_key := ebr.Key_4010_Bankruptcy_BDID;

ebr_4010_key keep_r(ebr_4010_key r) := transform
  self := r;
end;

export Bankruptcy_EBR_4010_records :=
       join(bdids_use,ebr_4010_key,
            left.bdid = right.bdid,
						keep_r(right));
