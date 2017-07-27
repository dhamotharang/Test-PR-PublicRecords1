import ut,ebr;

export industry_information_EBR_5600_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

doxie_cbrs.mac_Selection_Declare()

// ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use);

ebr_5600_key := ebr.Key_5600_Demographic_Data_BDID;

ebr_5600_key keep_r(ebr_5600_key r) := transform
  self := r;
end;


return join(bdids,ebr_5600_key,
            left.bdid = right.bdid,
						keep_r(right))(record_type='C');

END;