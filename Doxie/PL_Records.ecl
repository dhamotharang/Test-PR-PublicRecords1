import doxie, ut, doxie_crs, Doxie_Raw, FCRA, FFD;

outrec := doxie_Crs.layout_PL_Records;

export PL_Records (
  DATASET (doxie.layout_references) dids,
  boolean IsFCRA = false,
  dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
	) := function

	boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
	boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
	
  doxie.MAC_Header_Field_Declare (IsFCRA);

  bdids := dataset([], doxie.layout_ref_bdid); // no need in comp report
  fetched := Doxie_Raw.PL_Raw(dids, bdids, '', dateVal,
                              dppa_purpose, glb_purpose, ssn_mask_value, IsFCRA, flagfile);

	outrec xformAddStatementIDs(recordof(fetched) l, FFD.Layouts.PersonContextBatchSlim r) := transform,
		skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
		self.StatementIDs := r.StatementIDs,
		self.isDisputed := r.isDisputed,
		self.penalt := 0,
		self := l
	end;

	// FFD: 
	// - prolic_key currently used for overrides but does not appear to be unique (??)
	// - appending statement ids here just to avoid changes in PL_Raw (and exposed in HeaderSourceService)
	fetched_fcra := join(fetched, slim_pc_recs(datagroup = FFD.Constants.DataGroups.PROFLIC),
		(string)left.prolic_key = right.RecID1 and
		(((unsigned)left.did  = (unsigned) right.lexid) OR (right.acctno = FFD.Constants.SingleSearchAcctno))
		, xformAddStatementIDs(left, right), 
		left outer, keep(1), limit(0));

  doxie.MAC_Header_Result_Rank(fname,mname,lname,
                               best_ssn,dob,did,
                               predir,prim_range,prim_name,suffix,postdir,sec_range,
                               p_city_name,county_name,st,zip,
                               prim_name,false);
														 
  // suppress penalty calculations on FCRA-side, since it uses non-fcra data
  // (in comp report penalty unlikely makes sense, but, since it's already here...)
	outfile := if (IsFCRA, fetched_fcra, project (outf1, outrec));

  // consolidate records for a particular license;
  // trimming here will simplify rollup below.
	outfile_srt := sort(project (outfile, transform (outrec, self.license_number := trim (left.license_number, all), self := left)),
                      license_number, expiration_date, status_effective_dt);

	outfile roll_dates(outfile L, outfile R) := transform
		self.date_first_seen := if(
			((integer)L.date_first_seen < (integer)R.date_first_seen) and 
				((integer)L.date_first_seen != 0),
			L.date_first_seen,
			R.date_first_seen
		);
		self := if(
			(integer)L.date_last_seen > (integer)R.date_last_seen,
			L,
			R
		);
	end;
	out_f := rollup(outfile_srt,
			LEFT.license_number = RIGHT.license_number AND
			LEFT.expiration_date = RIGHT.expiration_date AND
			LEFT.status_effective_dt = RIGHT.status_effective_dt,
		roll_dates(LEFT,RIGHT)
	);

	srt_out_f := sort(out_f, -expiration_date,-last_renewal_date,-date_last_seen, record);

	ut.getTimeZone(srt_out_f,phone,timezone,srt_out_f_w_tzone)	
		
	return srt_out_f_w_tzone;
end;
