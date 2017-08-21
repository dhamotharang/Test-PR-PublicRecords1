import doxie;
export Get_Dids_HHID(
	gl_rewrites.person_interfaces.i__get_dids_hhid in_parms) :=
		function
			rec := doxie.layout_references_hh;
			adv_references := gl_rewrites.header_references(in_parms);

			Fetch_fail := project(limit(adv_references,3000,FAIL(203, doxie.ErrorCodes(203))), doxie.layout_references_hh);
			Fetch_nofail :=project(limit(adv_references,3000,skip), doxie.layout_references_hh);
			hr1 := IF(in_parms.noFail, Fetch_nofail, Fetch_fail);

			inl := DATASET([{in_parms.ssn_value}],{STRING9 ssn_val});
			ssns := IF(in_parms.fuzzy_ssn, in_parms.ssn_set, SET(inl, ssn_val)); 

			rec getRec(rec l) := TRANSFORM
				 SELF := l;
			END;

			hr1_pruned := JOIN(hr1, doxie.Key_DID_SSN_Date, LEFT.did = RIGHT.did and RIGHT.ssn in ssns, 
												 getRec(LEFT), LEFT ONLY);
												 
			hr1_new := IF(in_parms.ssn_value <> '' and ~in_parms.keep_old_ssns_val, hr1_pruned, hr1);

			hr3 := doxie.Get_Household_DIDs(hr1_new);

			rec getHH(hr3 l, hr1_new r) := TRANSFORM
				SELF.includedByHHID := IF (l.did <> 0 and r.did = 0, true, false);
				SELF.did := IF(l.did <> 0, l.did, r.did);
			END;

			hr4 := join(hr3, hr1_new, left.did = right.did, getHH(left, right), full outer);
				
			// If whole house then do 'double bounce' to get dids back
			hr := if( in_parms.whole_house, 
								IF(in_parms.nofail, hr4, LIMIT(hr4, 3000, FAIL(203, doxie.ErrorCodes(203)))), hr1_new );

			sif := record
				string firstname := in_parms.fname_val;
				string lastname := in_parms.lname_val;
				string state := in_parms.state_val;
				string ssn := in_parms.ssn_value;
				string did := in_parms.did_value;
				string otherlastname1 := in_parms.olname1_val;
				string middlename := in_parms.mname_val;
				string OtherState1 := in_parms.prev_state_val1l;
				string OtherState2 := in_parms.prev_state_val2l;
				string City :=  in_parms.city_val;
				string zip := in_parms.zip_val;
				unsigned ZipZipRadius := in_parms.zipradius_value;
				string phone := in_parms.phone_value;
				string Addr := in_parms.addr_value;
				boolean PhoneticMatch :=  in_parms.phonetics;
				boolean  AllowNickNames := in_parms.nicknames;
				boolean  Household := in_parms.whole_house;
				unsigned1 AgeLow := in_parms.AgeLow_val;
				unsigned1 AgeHigh := in_parms.AgeHigh_val;
				unsigned8 Dob := in_parms.Dob_val;
				unsigned8 MaxResults := 2000;
				unsigned8 MaxResultsThisTime := 2000;
				unsigned8 SkipRecords := 0;
				unsigned1 DPPAPurpose := in_parms.DPPA_Purpose;
				unsigned1 GLBPurpose := in_parms.GLB_Purpose;
				boolean DIDOnly := true;
				string LookupType := in_parms.lookup_val;
				end;
			q := soapcall(in_parms.adl_service_ip,'DOXIE.HeaderFileSearchService',sif,dataset(rec));

			return dedup(if(in_parms.adl_service_ip='' or in_parms.forceLocal,hr,q)(did<>0),did,all);// : global;
		END;