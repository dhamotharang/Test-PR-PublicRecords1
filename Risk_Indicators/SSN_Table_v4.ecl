import doxie_build, header, header_quick, fcra, BankruptcyV2, doxie, address, ut, mdr;

export SSN_Table_v4(boolean isFCRA) := function;

	lname_var := RECORD
		string20	fname;
		STRING20  lname;
		unsigned3 first_seen;
		unsigned3 last_seen;
	END;

	common_rec := RECORD
		// STRING9 ssn;
		unsigned3 header_first_seen;
		unsigned3 header_last_seen;
		INTEGER headerCount;
		INTEGER EqCount;
		INTEGER EnCount;
		INTEGER TnCount;
		INTEGER TuCount;
		INTEGER SrcCount;
		INTEGER DidCount;
		INTEGER DidCount_c6;//  number of dids created in the last 6 months
		INTEGER DidCount_s18; // number of dids seen in the last 18 months
		integer addr_ct;  // number of addresses associated with that SSN
		integer addr_ct_c6;  // number of addresses newly associated with that ssn within the last 6 months
		INTEGER BestCount;
		INTEGER RecentCount;
		unsigned6 BestDid;
		lname_var lname1;
		lname_var lname2;
		lname_var lname3;
		lname_var lname4;
	END;

	final_rec := RECORD
		STRING9 ssn;
		unsigned3 official_first_seen;
		unsigned3 official_last_seen;
		boolean isValidFormat;
		boolean isSequenceValid;
		boolean isBankrupt := false; // If using FCRA, hardcode to FALSE as Corrections File is not being taken into account.
		unsigned dt_first_bankrupt := 0;	// If using FCRA, hardcode to 0 as Corrections File is not being taken into account.
		boolean isDeceased;
		unsigned dt_first_deceased;
		unsigned decs_dob;
		string5 decs_zip_lastres;
		string5 decs_zip_lastpayment;
		string20 decs_last;
		string20 decs_first;
		STRING2 issue_state;
		common_rec combo;
		common_rec eq;
		common_rec en;
		common_rec tn;
		//CCPA-768
		UNSIGNED4	global_sid;
		UNSIGNED8 record_sid;
	END;

	ssntable_version4_2 := risk_indicators.ssn_table_v4_2(isFCRA);
	
  final := project(ssntable_version4_2, 
		transform(final_rec,
			self.isDeceased := left.eq.isDeceased;
			self.dt_first_deceased := left.eq.dt_first_deceased;
			self.decs_dob := left.eq.decs_dob;
			self.decs_zip_lastres := left.eq.decs_zip_lastres;
			self.decs_zip_lastpayment := left.eq.decs_zip_lastpayment;
			self.decs_last := left.eq.decs_last;
			self.decs_first := left.eq.decs_first;
			// the didcount_s18 in the layout wasn't being populated because we have that information in 'RecentCount'
			// while adding new fields for v4_2, it was a good time to remove that un-used didcount_s18 field
			self.combo.didcount_s18 := 0;
			self.eq.didcount_s18 := 0;
			self.en.didcount_s18 := 0;
			self.tn.didcount_s18 := 0;
			self := left));	
	
return final;

end;