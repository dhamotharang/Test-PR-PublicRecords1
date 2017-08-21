EXPORT proc_compid_incremental_extract(string filedate) := FUNCTION
	
	//Attribute to extract Death Master data to separate files for Compid process
	
	IMPORT Death_Master;
	
	//#workunit('name','DeathMaster - Compid Extract');
	
	RawSSAInfile	:=	Death_Master.File_SSADeathmaster;
	
	Layout_SSADeathMaster	tJoinStateCds(RawSSAInfile pInputL, lkp_SSA_state_cntry_cd pInputR)	:=	TRANSFORM
		self.ST_COUNTRY_CODE	:=	pInputR.LN_ST_COUNTRY_CODE;
		self.DOD8							:=	pInputL.DOD8[5..8] + pInputL.DOD8[1..4];
		self									:=	pInputL;
	END;
	
	File_SSADeathmasterLkp	:=	JOIN(RawSSAInfile, lkp_SSA_state_cntry_cd,
																		LEFT.ST_COUNTRY_CODE = RIGHT.ST_COUNTRY_CODE,
																		tJoinStateCds(LEFT, RIGHT),
																		LEFT OUTER,
																		LOOKUP
																	);
	
	//Delete files
	Delete_superfile				:=	SORT(DISTRIBUTE(files_extract.file_compid_extract_deletes, HASH32(SSN)), SSN, LOCAL);
	Delete_incoming					:=	SORT(DISTRIBUTE(File_SSADeathmasterLkp(rec_type = 'D'), HASH32(SSN)), SSN, LOCAL);
	
	layouts_extract.layout_compid_extract tAddLF(File_SSADeathmasterLkp pInput) := TRANSFORM
		self.ST_COUNTRY_CODE	:=	IF(TRIM(pInput.ST_COUNTRY_CODE, LEFT, RIGHT) = '', 'UN', pInput.ST_COUNTRY_CODE);
		self.CRLF								:=	'\r\n';
		self									:=	pInput;
	END;
	
	rsDmastExtract					:=	PROJECT(Delete_superfile, layouts_extract.layout_compid_extract);
	rsDmastIncoming					:=	PROJECT(Delete_incoming, tAddLF(LEFT));
	
	//Only keep those not already on the delete list
	rsCompidDmastDelsGood		:=	IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::out::death_master::compid::deletes')) > 0,
																JOIN(rsDmastExtract, rsDmastIncoming, LEFT.SSN = RIGHT.SSN, LEFT ONLY, LOCAL),
																rsDmastIncoming);
	
	OUTPUT(rsCompidDmastDelsGood, , '~thor_data400::out::death_master::compid::deletes_' + filedate);
	
	//Filter non-deletes
	
	rsCompidDmastIns				:=	PROJECT(File_SSADeathmasterLkp(rec_type <> 'D'), tAddLF(LEFT));
	
	OUTPUT(rsCompidDmastIns, , '~thor_data400::out::death_master::compid::inserts_' + filedate);
	
	//Add to superfiles
	FileServices.AddSuperFile('~thor_data400::out::death_master::compid::deletes', '~thor_data400::out::death_master::compid::deletes_' + filedate);
	FileServices.AddSuperFile('~thor_data400::out::death_master::compid::inserts', '~thor_data400::out::death_master::compid::inserts_' + filedate);
	
	RETURN 'Compid extract files have been created.';
	
END;