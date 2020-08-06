IMPORT lib_fileservices, _control, lib_STRINGlib, _Validate, did_add, didville, ut, std, UPI_DataBuild__dev, 
				HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest, wk_ut, workman;

TrimUpper(STRING s) := FUNCTION
			RETURN TRIM(Stringlib.StringToUppercase(s),LEFT,RIGHT);
			END;  
				
EXPORT Append_LexID (string pVersion, boolean pUseProd, string gcid, unsigned1 pLexidThreshold, string pHistMode, string10 pBatch_jobid,
						dataset(UPI_DataBuild__dev.Layouts_V2.input_processing)pBaseFile):= MODULE

	EXPORT LexID_append := FUNCTION
			
		temp_base_layout := record
			UPI_DataBuild__dev.Layouts_V2.input_processing;
			string50 		temp_fname := '';
			string50 		temp_mname := '';
			string50 		temp_lname := '';
			string10 		temp_suffix:= '';
			unsigned4		temp_dob	 := 0;
			string9 		temp_ssn	 := '';
			unsigned8		temp_lexid := 0;
			unsigned1		temp_lexid_score := 0;
			unsigned1		person_type:= 0;
			unsigned8 	rec_number;
		end;
		
		prep_base0 := project(pBaseFile, transform({temp_base_layout}, self.rec_number := 0, self := left));
	
		ut.MAC_Sequence_Records(prep_base0, rec_number, prep_base);
		
		prep_base tNorm(prep_base L, unsigned cnt) := TRANSFORM, SKIP(cnt = 2 AND (L.input_guardian_first_name = '' AND L.input_guardian_last_name = ''))
			SELF.rec_number				:= L.rec_number;
			SELF.person_type			:= cnt; //1 is patient, 2 is guardian
			SELF.temp_ssn					:= CHOOSE(cnt, l.ssn, l.guardian_ssn);
			SELF.temp_dob					:= CHOOSE(cnt, l.dob, l.guardian_dob);
			SELF.temp_fname				:= CHOOSE(cnt, l.fname, l.guardian_fname);
			SELF.temp_mname				:= CHOOSE(cnt, l.mname, l.guardian_mname);
			SELF.temp_lname				:= CHOOSE(cnt, l.lname, l.guardian_lname);
			SELF.temp_suffix			:= CHOOSE(cnt, l.suffix, '');
			SELF									:= L;
		END;
		
		norm_base := NORMALIZE(prep_base, 2, tNorm(LEFT,counter));
		
		under18		:= norm_base(person_type = 1 AND (UNSIGNED)calc_age < 18);
		over18		:= norm_base(person_type = 1 AND (UNSIGNED)calc_age >= 18);
		guardians	:= norm_base(person_type = 2); 
		
		append_these	:= over18 + guardians;

#STORED('did_add_force','thor'); // remove or set to 'roxi' to put recs through roxi
	
		matchset := ['A','Z','P','D','S'];

		did_add.MAC_Match_Flex_V2			
			(append_these, matchset,
			temp_ssn, temp_dob, temp_fname, temp_mname, temp_lname, temp_suffix, 
			prim_range, prim_name, sec_range, zip, st, home_phone,
			temp_lexid, {norm_base}, true, temp_lexid_score,
			pLexidThreshold,	d_did, false,, false,, false, 
			predir, addr_suffix, postdir, unit_desig, city_name, zip4);			
			
		all_ages	:= d_did + under18;
		
		sort_person1	:= sort(distribute(all_ages(person_type = 1), hash(rec_number)), rec_number, local);
		sort_person2	:= sort(distribute(all_ages(person_type = 2), hash(rec_number)), rec_number, local);
		sort_all	:= sort(distribute(all_ages, hash(rec_number)), rec_number, local);
		
		denormRecs := join(sort_person1, sort_person2,
				left.rec_number = right.rec_number,
				transform({sort_person1},
				SELF.lexid									:= left.temp_lexid,
				SELF.lexid_score						:= left.temp_lexid_score,
				SELF.guardian_lexid					:= right.temp_lexid, 
				SELF.guardian_lexid_score		:= right.temp_lexid_score,
				SELF            := left),
				left outer, local);
	   																					
		RETURN project(denormRecs, UPI_DataBuild__dev.Layouts_V2.Input_processing); // returning file in input_processing layout not base layout
	END;
END;
