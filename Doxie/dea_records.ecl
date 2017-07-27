import doxie, doxie_crs, business_header, doxie_raw;


export dea_records (DATASET (doxie.layout_references) dids) := function

  // I'm not making [bdid] as an input parameter, since I hope to get rid of business search here all together.
  business_header.doxie_MAC_Field_Declare();

  bdids := if (comp_name_value != '',
               business_header.doxie_get_bdids(true),
               dataset([],{unsigned6 bdid})) + dataset([{(integer)bdid_value}],{unsigned6 bdid})(bdid != 0);

  raw := Doxie_Raw.Dea_Raw(dids, project(bdids, Doxie.Layout_ref_bdid), dateVal, dppa_purpose, glb_purpose, ssn_mask_value);

  F3 := dedup(sort(raw,whole record), whole record);

  plusdid := record
	  F3;
  	unsigned6	idid := (integer)F3.did;
  	string10	null := '';
  end;

  Fetched := table(F3,plusdid);

  doxie.MAC_Header_Result_Rank(fname,mname,lname,
                               best_ssn,null,idid,
                               predir,prim_range,prim_name,addr_suffix,postdir,sec_range,
                               p_city_name,county_name,st,zip,
                               null,false)
					    
  out_f := project(outf1, doxie_crs.layout_dea_records);
											
  return out_f;
END;