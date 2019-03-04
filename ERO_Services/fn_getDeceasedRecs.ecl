
import AutoStandardI, BatchServices, DeathV2_services, Doxie, NID;

export fn_getDeceasedRecs( dataset(Layouts.LookupId) ids = dataset([],Layouts.LookupId) ) :=
	function
		/*
			Requirement 4.1-19:
			Use the SSN, Name and DOB from the best subject being returned to ERO to conduct a deceased 
			search.  First search BatchServices.Death_BatchService by SSN and then by Name and DOB. 

			NOTE from Roberto Perez on how existing process works:
			The name comparison that was used for the deceased search allowed matches on nicknames for 
			the first name.  First, the BatchServices.Death_BatchService Roxie service was used to search 
			by SSN, then it was used to search by Name and DOB (relying on the name matching provided by 
			the Roxie service).  After the death data results were found by either method, the death 
			indicators were set based on the name comparisons performed using the datalib library (which 
			allows for nickname matching).

			Populate the 'Death_Indicator' field:
			This field represents a "match" found in the Death Master Data. This field will detail 
			how the match was made.    
				o   Update this field with a "Y" if the match was made using SSN and name comparison.
				o   Update this field with a "1" if the match was made using name and DOB.
				o   Update this field with a "2" if the match was made by SSN but the deceased name 
						does not match the input name. 
		*/			
		/*
			Engineering notes (last update: 2/6/2013):
			The Deceased batch service (i.e. BatchServices.Death_BatchService_Records) provides the basis  
			for the logic being used here. We don't need all of the extra code for Autokey fetches, though,  
			so what we have below is simpler than what's in the batch service: the Deceased records can be 
			obtained adequately by a single join to the Deceased key (by did). We then compare the results 
			to the input SSN and Name + DOB, and the appropriate match-code is applied. 
		*/
		// Local attributes.
		deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
		glb_ok := deathparams.isValidGlb();
		PrefFirstMatch(string20 l, string20 r) :=
				NID.mod_PFirstTools.SUBPFLeqPFR(l,r) or NID.mod_PFirstTools.SUBPFLeqR(l,r);
		// Local functions.
		
		// The following function determines the value for the Death_Indicator field.
		fn_determine_death_indicator(Layouts.LookupId le, recordof(doxie.key_death_masterV2_ssa_DID) ri) := 
			function
					
					// Convert date from Date.Day, Date.Month, Date.Year to YYYYMMDD.
					string8 date_yyyymmdd(ERO_Services.Layouts.Date dt) :=
							(string4)dt.Year + intformat(dt.Month,2,1) + intformat(dt.Day,2,1);

					boolean ssns_match := trim(le.input_ssn) = trim(ri.ssn);
					
					boolean dobs_match := date_yyyymmdd(le.input_dob) = trim(ri.dob8);
					
					// concatenate name data, capitalize, remove non-alpha chars; compare.
				  llast := StringLib.StringFilter(StringLib.StringToUpperCase(le.input_name.name_last), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
				  lfirst := StringLib.StringFilter(StringLib.StringToUpperCase(le.input_name.name_first), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
               
					rlast := StringLib.StringFilter(StringLib.StringToUpperCase(ri.lname), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
					rfirst := StringLib.StringFilter(StringLib.StringToUpperCase(ri.fname), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
               
				  lastMatch := llast = rlast;
				  firstMatch := (lfirst = rfirst) or PrefFirstMatch(lfirst, rfirst);
				  names_match := lastMatch and firstMatch;
							
					indicator := 
						map(
							ssns_match AND names_match     => 'Y',
							dobs_match AND names_match     => '1',
							ssns_match AND NOT names_match => '2',
							/* default.................... */ ''
						);
						
					return indicator;
			end;
			
		// Join ids to Deceased key. Sort, dedup; return.
		ds_death_recs_raw := 
			join(
				ids, doxie.key_death_masterV2_ssa_DID, 
				keyed(left.did = right.l_did) and
				not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
				transform( ERO_Services.Layouts.Deceased_out,
					self.acctno          := left.acctno,
					self.did             := left.did,
					self.Death_Indicator := fn_determine_death_indicator(left,right),
					self.Death_Name      := functions.fn_format_name(trim(right.lname), trim(right.fname), trim(right.mname)),
					self.Death_DOD       := functions.fn_format_date(right.dod8),
					self.Death_DOB       := functions.fn_format_date(right.dob8),
					self.Death_SSN       := right.ssn
				),
				inner,
				limit(BatchServices.Constants.DEATH_SERVICE_JOIN_LIMIT), KEEP(1) // 1000, added keep(1), more than 1 death row for a DID may exist.
			);
		
		ds_death_recs := DEDUP(SORT(ds_death_recs_raw, acctno, RECORD), acctno, RECORD);
		
		return ds_death_recs;
	end;