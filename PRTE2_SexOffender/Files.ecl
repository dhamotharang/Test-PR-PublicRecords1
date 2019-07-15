IMPORT SexOffender, PRTE2_SexOffender, Doxie, Header, PRTE2_Header, Watchdog, PRTE2_Watchdog, MDR, ut, autokey, data_services;

EXPORT Files := MODULE

	EXPORT Offender_in	:= DATASET('~prte::in::SexOffender::sexoffender_main', Layouts.Offender_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	
	EXPORT Offense_in		:= DATASET('~prte::in::SexOffender::sexoffense', Layouts.Offense_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	
	EXPORT Offender_di_ref := DATASET('~prte::base::SexOffender::sex_offender_main', Layouts.Offender_in, THOR); //base file plus Data Insight fields
	
	EXPORT SexOffender_base := PROJECT(Offender_di_ref, TRANSFORM(Layouts.SexOffender_base, SELF := LEFT));
	
	EXPORT Offense_di_ref	:= DATASET('~prte::base::SexOffender::sex_offender_offenses', Layouts.Offense_in, THOR); //base file plus Data Insight fields
	
	EXPORT SexOffense_base	:= PROJECT(Offense_di_ref, TRANSFORM(Layouts.SexOffense_base, SELF := LEFT));
	
	EXPORT ENHPublic_hist := DATASET('~prte::in::sexoffender::temp::enhpublic', Layouts.lENHPublic, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	
	//Autokeys
	Layouts.ak_rec norm_cities(SexOffender_base l,unsigned1 C):= TRANSFORM
	// On the second time when the v_city_name is being used, null out the
	// ssn field so that duplicate ssn autokey file records do not get created.
		self.ssn  := if(C=1,
	                if(l.ssn<>'',l.ssn,l.ssn_appended),
									'');
		self.dob := l.dob;
		self.city_name := if(C=1, l.p_city_name, l.v_city_name);
		self:= l;
	END;

	norm_file_cities := normalize(SexOffender_base, if(left.p_city_name=left.v_city_name or 
																										left.v_city_name='',1,2),
																norm_cities(left,counter));
															
	// Remove any duplicate records after the normalize
	dedup_file_cities := dedup(sort(norm_file_cities,seisint_primary_key,record),record); 


	// Normalize a second time for orig_state_code not = address state
	Layouts.ak_rec state_xform(dedup_file_cities l,unsigned1 C):= TRANSFORM
		self.prim_range  := if(C=1,l.prim_range,'');
    self.prim_name   := if(C=1,l.prim_name,'');
    self.sec_range   := if(C=1,l.sec_range,'');
    self.city_name   := if(C=1,l.city_name,'');
		self.st          := if(C=1,l.st,l.orig_state_code);
		self.zip5        := if(C=1,l.zip5,'');
		self.geo_lat 	 	 := if(C=1,l.geo_lat,'');
		self.geo_long 	 := if(C=1,l.geo_long,'');
		self.geo_match 	 := if(C=1,l.geo_match,'');

	// On the second time when orig_state_code is being used, null out the
	// ssn field so that duplicate autokey ssn file records do not get created.
		self.ssn          := if(C=1,l.ssn,'');
		self:= l;
	END;

	norm_file_states := normalize(dedup_file_cities,if(left.orig_state_code=left.st or
                                                   left.st='',1,2),
																state_xform(left,counter));

	// Remove any duplicate records after the normalize
	dedup_file_states := dedup(sort(norm_file_states,seisint_primary_key,record),record); 

	EXPORT File_Autokey_Main := dedup_file_states;
			
END;