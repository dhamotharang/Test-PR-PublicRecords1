import doxie, doxie_crs, doxie_raw, FCRA, FFD;

export hunting_records(dataset(doxie.layout_references) dids, 
										boolean IsFCRA = false,
										dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
										dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
										integer8 inFFDOptionsMask = 0
										) := function
										
	doxie.MAC_Header_Field_Declare(IsFCRA);
	doxie.MAC_Selection_Declare();
	
  FAP_hunting := false : STORED('IncludeHunting');
	is_FAP := Select_Indiv AND FAP_hunting;
	
	fetched := if(Include_HuntingFishingLicenses_val or is_FAP, 
		Doxie_Raw.Hunt_Raw(dids, dateVal, dppa_purpose, glb_purpose, ssn_mask_value, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask));
	
  // macro cretes an output file "outf1"	
	doxie.MAC_Header_Result_Rank(fname,mname,lname,
                             best_ssn,dob,did,
                             predir,prim_range,prim_name,suffix,postdir,sec_range,
                             p_city_name,county_name,st,zip,
                             phone,false);

	outrec := doxie_crs.layout_hunting_records;
	
  // no penalizing on FCRA side.
  outfile := if (IsFCRA,
                 project (fetched, transform (outrec, self.penalt := 0, self := left)),
                 project (outf1, outrec));
	
	return outfile;
end; 


