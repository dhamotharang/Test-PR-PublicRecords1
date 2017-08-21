IMPORT Death_Master, address, ut, HEADER, Codes;

EXPORT fn_supplemental_to_plus_layout(DATASET(Header.layout_death_master_supplemental) supp_in) := 
FUNCTION
	
	// Transform the state layout to the common death master layout
	Header.layout_death_master_plus tDeathMaster_Data_Plus(Header.layout_death_master_supplemental pInput) := 
	TRANSFORM
															
		SELF.filedate						:=	pInput.process_date;
		SELF.ssn								:=	pInput.ssn;
		SELF.lname							:=	pInput.lname;
		SELF.name_suffix				:=	pInput.name_suffix;
		SELF.fname							:=	pInput.fname;
		SELF.mname							:=	pInput.mname;
		SELF.dod8								:=	pInput.dod;
		SELF.dob8								:=	pInput.dob;
		SELF.state							:=	IF(pInput.state<>'',pInput.state,pInput.source_state);
		SELF.st_country_code		:=	IF(pInput.fips_state<>'',pInput.fips_state,Codes.st2FipsCode(SELF.state));
		SELF.zip_lastres				:=	pInput.zip5;
		SELF.fipscounty					:=	IF(pInput.fips_county<>'',pInput.fips_county,
																	IF(COUNT(	Address.County_Names(	state_alpha	=	TRIM(pInput.source_state)	AND
																																	county_name	=	TRIM(REGEXREPLACE(' COUNTY',pInput.county_residence,'',NOCASE))))>0,
																						Address.County_Names(	state_alpha	=	TRIM(pInput.source_state)	AND	
																																	county_name	=	TRIM(REGEXREPLACE(' COUNTY',pInput.county_residence,'',NOCASE)))[1].county_code,
																		''
																	)
																);
		SELF.clean_title				:=	pInput.title;
		SELF.clean_fname				:=	pInput.fname;
		SELF.clean_mname				:=	pInput.mname;
		SELF.clean_lname  			:=	pInput.lname;
		SELF.clean_name_suffix  :=	pInput.name_suffix;
		SELF.clean_name_score		:=	pInput.name_score;
		SELF.state_death_id			:=	pInput.state_death_id;
		SELF.state_death_flag		:=	pInput.state_death_flag;
		SELF										:=	[];
	END;

	pDeathMaster_State_Data_Plus := PROJECT(supp_in, tDeathMaster_Data_Plus(LEFT));

	RETURN pDeathMaster_State_Data_Plus;
	
END;
