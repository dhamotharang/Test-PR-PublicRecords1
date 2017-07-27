import ut,ebr;

export industry_information_EBR_0010_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION
doxie_cbrs.mac_Selection_Declare()

// ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_0010_key := ebr.Key_0010_Header_BDID;

ebr_0010_key keep_r(ebr_0010_key r) := transform
  self := r;
end;

return join(bdids,ebr_0010_key,
            left.bdid = right.bdid,
						keep_r(right))(record_type='C');

END;