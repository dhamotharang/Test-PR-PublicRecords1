IMPORT PRTE2_Death_Master,VersionControl, _control, LIB_DATE,codes,
_Validate,header, NID,census_data, mdr,standard, ut, address;
EXPORT files := module

	EXPORT Death_Master_IN 	:= DATASET(prte2_death_master.Constants.DEATH_MASTER_IN,layouts.layout_death_master_base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	

	EXPORT Death_Master 	:= DATASET(prte2_death_master.Constants.DEATH_MASTER_BASE,layouts.layout_death_master_base,FLAT);
	
	EXPORT Death_Master_DID(Boolean SSA=false) :=  if (~SSA,
														project(Death_Master(SRC<>'D$'), layouts.Layout_Did_Death_Master),
														project(Death_Master, layouts.Layout_Did_Death_Master));
	
	EXPORT Death_Master_SUPPLEMENTAL_SSA := PROJECT (Death_Master, LAYOUTS.layout_Death_Master_slim_supplemental);
	
	EXPORT File_DeathMaster_Building		:=	PROJECT(Death_Master,  Header.Layout_Did_Death_MasterV3);
	EXPORT File_DeathMaster_Building_2		:=	PROJECT(Death_Master,  Header.Layout_Did_Death_MasterV3-[global_sid,record_sid]);

	EXPORT Death_Master_Header := project(File_DeathMaster_Building,layouts.Layout_Did_Death_MasterV2);
	
	EXPORT DID_Dead_With_County(Boolean SSA) := PROJECT(Death_Master_DID(SSA), Layouts.Death_Record_DID);
	
	EXPORT SLIM_DOD_SSA := dedup(project(Death_Master(_Validate.Date.fIsValid(dod8)), layouts.rec_dod), all);

	EXPORT File_DeathMaster_DOD := dedup(project(Death_Master(_Validate.Date.fIsValid(dod8) AND SRC<>'D$'), layouts.rec_dod), all);

	EXPORT File_DeathMaster_DOB_SSA := dedup(project(Death_Master(_Validate.Date.fIsValid(dob8)), Layouts.Rec_Dob), all);
	
	EXPORT Building_Dead_With_County(Boolean SSA = FALSE) :=  
					IF (~SSA,
					 PROJECT(Death_Master(SRC<>'D$'), Layouts.Layout_Death_Record_Building),
					 PROJECT(Death_Master, Layouts.Layout_Death_Record_Building));
					 
	EXPORT Building_Dead_With_County_2(Boolean SSA = FALSE) :=  
					IF (~SSA,
					 PROJECT(Death_Master(SRC<>'D$'), Layouts.Layout_Death_Record_Building-[Global_SID,Record_SID]),
					 PROJECT(Death_Master, Layouts.Layout_Death_Record_Building-[Global_SID,Record_SID]));
	

	EXPORT Bldg_Dead_With_County_FCRA(Boolean SSA = false) := 
			Building_Dead_With_County_2(SSA)(
			(unsigned6)did != 0  and 
			(src in mdr.sourceTools.set_scoring_FCRA) and 
			(src not in mdr.sourceTools.set_scoring_FCRA_retro_test));	
			
	EXPORT Bldg_Dead_With_County_FCRA_SSA(Boolean SSA = true) := 
			Building_Dead_With_County(SSA)(
			(unsigned6)did != 0  and 
			(src in mdr.sourceTools.set_scoring_FCRA) and 
			(src not in mdr.sourceTools.set_scoring_FCRA_retro_test));	
	
		// EXPORT Bldg_Dead_With_County_FCRA(Boolean SSA = false) := 
			// Building_Dead_With_County(SSA)(
			// (unsigned6)did != 0  and 
			// (src in mdr.sourceTools.set_scoring_FCRA) and 
			// (src not in mdr.sourceTools.set_scoring_FCRA_retro_test));		
	
			
	
	fdeath_ssa := File_DeathMaster_Building;
	fsupp_ssa  := Death_Master_SUPPLEMENTAL_SSA;

	//project base file into layout


	Layouts.rec_autokey_ssa tformat_ssa(fdeath_ssa l) := transform
		self.addr.st					:=	IF(l.state <> '', l.state, ut.stFips2stAbbrev(l.st_country_code));
		self.addr.zip5				:=	IF(TRIM(l.zip_lastres) != '', l.zip_lastres, l.zip_lastpayment);
		self.addr.fips_state	:=	l.st_country_code;
		self.addr.fips_county	:=	l.fipscounty;
		self.addr							:=	[];
		self.dob							:=	l.dob8;
		self.did							:=	(unsigned6)L.did;
		self.src							:=	l.src;
		self.glb_flag					:=	l.glb_flag;
		self.global_sid       :=  l.global_sid;
	  self.record_sid       :=  l.record_sid;    
		self									:=	l;
	end;

	base_ssa := project(fdeath_ssa, tformat_ssa(left));

	//create some additional addresses using supp file
	Layouts.rec_autokey_ssa taddl_ssa(fdeath_ssa l, fsupp_ssa r) := transform
		self.addr.cbsa				:=	r.msa;
		self.addr.st					:=	MAP(codes.valid_st(r.state) => r.state,
																	codes.valid_st(r.SOURCE_STATE) => r.SOURCE_STATE,
																	'');
		self.addr.fips_state	:=	IF(TRIM(r.fips_state)<>'',
																r.fips_state,
																IF(TRIM(l.st_country_code)<>'',
																	l.st_country_code,
																	codes.st2FipsCode(self.addr.st)
																)
															);
		self.addr.fips_county	:=	IF(r.fips_county<>'',r.fips_county,l.fipscounty);
		self.addr							:=	r;
		self.dob							:=	l.dob8;
		self.did							:=	(unsigned6)L.did;
		self									:=	l;
	end;

	addl_ssa := join(fdeath_ssa(state_death_id <> ''), fsupp_ssa,
						   left.state_death_id = right.state_death_id,
							 taddl_ssa(left, right),
							 keep(1),
							 local);

	EXPORT file_SearchAutokey_ssa := 
	//throw out the record with the less complete duplicate address
		dedup(sort(base_ssa + addl_ssa, state_death_id, addr.zip5, addr.st, -addr.prim_range, -addr.prim_name, -addr.v_city_name, local),
				  state_death_id, addr.zip5, addr.st, local);


	
END;

