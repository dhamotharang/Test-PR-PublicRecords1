IMPORT Header, Address, ut;
EXPORT fn_fillSupplementalFields(	DATASET(RECORDOF(Header.layout_death_master_supplemental)) supp, 
																	STRING8 	VersionDate, 
																	UNSIGNED 	vMaxRecordID) := 
FUNCTION 

	RECORDOF(supp) fill(RECORDOF(supp) pInput, UNSIGNED cnt) := 
	TRANSFORM
		SELF.process_date								:=	IF(pInput.process_date<>'',pInput.process_date,VersionDate);
		SELF.StateFN										:=	Death_Master.fn_cleanNULL(pInput.StateFN);
		SELF.ssn												:=	Death_Master.fn_clean_death_ssn(pInput.ssn);
		SELF.year												:=	pInput.dod[5..8];
		SELF.disposition_date						:=	IF(ut.isNumeric(pInput.disposition_date),pInput.disposition_date[5..6]+pInput.disposition_date[7..8]+pInput.disposition_date[1..4],'');
		SELF.injury_date								:=	IF(ut.isNumeric(pInput.injury_date),pInput.injury_date[5..6]+pInput.injury_date[7..8]+pInput.injury_date[1..4],'NOINJURY');
		SELF.surgery_date								:=	IF(ut.isNumeric(pInput.surgery_date),pInput.surgery_date[5..6]+pInput.surgery_date[7..8]+pInput.surgery_date[1..4],'');
		SELF.date_last_trans						:=	IF(ut.isNumeric(pInput.date_last_trans),pInput.date_last_trans[5..6]+pInput.date_last_trans[7..8]+pInput.date_last_trans[1..4],'');
		// SELF.disposition_date						:=	IF(ut.isNumeric(pInput.disposition_date),pInput.disposition_date,'');	// Test Only
		// SELF.injury_date								:=	IF(ut.isNumeric(pInput.injury_date),pInput.injury_date,'NOINJURY');	// Test Only
		// SELF.surgery_date								:=	IF(ut.isNumeric(pInput.surgery_date),pInput.surgery_date,'');	// Test Only
		// SELF.date_last_trans						:=	IF(ut.isNumeric(pInput.date_last_trans),pInput.date_last_trans,'');	// Test Only
		SELF.state_death_id							:=	IF(pInput.state_death_id<>'',pInput.state_death_id,pInput.source_state + INTFORMAT(vMaxRecordID + cnt,14,1));
		SELF.state_death_flag 					:=	'Y';
		SELF.CERTIFICATE_VOL_NO					:=	Death_Master.fn_cleanNULL(pInput.CERTIFICATE_VOL_NO);
		SELF.CERTIFICATE_VOL_YEAR				:=	Death_Master.fn_cleanNULL(pInput.CERTIFICATE_VOL_YEAR);
		SELF.PUBLICATION								:=	Death_Master.fn_cleanNULL(pInput.PUBLICATION);
		SELF.DECEDENT_RACE							:=	Death_Master.fn_cleanNULL(pInput.DECEDENT_RACE);
		SELF.DECEDENT_ORIGIN						:=	Death_Master.fn_cleanNULL(pInput.DECEDENT_ORIGIN);
		SELF.DECEDENT_SEX								:=	Death_Master.fn_cleanNULL(pInput.DECEDENT_SEX);
		SELF.DECEDENT_AGE								:=	Death_Master.fn_cleanNULL(pInput.DECEDENT_AGE);
		SELF.EDUCATION									:=	Death_Master.fn_cleanNULL(pInput.EDUCATION);
		SELF.OCCUPATION									:=	Death_Master.fn_cleanNULL(pInput.OCCUPATION);
		SELF.WHERE_WORKED								:=	Death_Master.fn_cleanNULL(pInput.WHERE_WORKED);
		SELF.CAUSE											:=	Death_Master.fn_cleanNULL(pInput.CAUSE);
		SELF.DOB												:=	Death_Master.fn_cleanNULL(pInput.DOB);
		SELF.DOD												:=	Death_Master.fn_cleanNULL(pInput.DOD);
		SELF.BIRTHPLACE									:=	Death_Master.fn_cleanNULL(pInput.BIRTHPLACE);
		SELF.MARITAL_STATUS							:=	Death_Master.fn_cleanNULL(pInput.MARITAL_STATUS);
		SELF.FATHER											:=	Death_Master.fn_cleanNULL(pInput.FATHER);
		SELF.MOTHER											:=	Death_Master.fn_cleanNULL(pInput.MOTHER);
		SELF.FILED_DATE									:=	Death_Master.fn_cleanNULL(pInput.FILED_DATE);
		SELF.COUNTY_RESIDENCE						:=	Death_Master.fn_cleanNULL(pInput.COUNTY_RESIDENCE);
		SELF.COUNTY_DEATH								:=	Death_Master.fn_cleanNULL(pInput.COUNTY_DEATH);
		SELF.ADDRESS										:=	Death_Master.fn_cleanNULL(pInput.ADDRESS);
		SELF.AUTOPSY										:=	Death_Master.fn_cleanNULL(pInput.AUTOPSY);
		SELF.AUTOPSY_FINDINGS						:=	Death_Master.fn_cleanNULL(pInput.AUTOPSY_FINDINGS);
		SELF.PRIMARY_CAUSE_OF_DEATH			:=	Death_Master.fn_cleanNULL(pInput.PRIMARY_CAUSE_OF_DEATH);
		SELF.UNDERLYING_CAUSE_OF_DEATH	:=	Death_Master.fn_cleanNULL(pInput.UNDERLYING_CAUSE_OF_DEATH);
		SELF.MED_EXAM										:=	Death_Master.fn_cleanNULL(pInput.MED_EXAM);
		SELF.EST_LIC_NO									:=	Death_Master.fn_cleanNULL(pInput.EST_LIC_NO);
		SELF.DISPOSITION								:=	Death_Master.fn_cleanNULL(pInput.DISPOSITION);
		SELF.WORK_INJURY								:=	Death_Master.fn_cleanNULL(pInput.WORK_INJURY);
		SELF.INJURY_TYPE								:=	Death_Master.fn_cleanNULL(pInput.INJURY_TYPE);
		SELF.INJURY_LOCATION						:=	Death_Master.fn_cleanNULL(pInput.INJURY_LOCATION);
		SELF.SURG_PERFORMED							:=	Death_Master.fn_cleanNULL(pInput.SURG_PERFORMED);
		SELF.HOSPITAL_STATUS						:=	Death_Master.fn_cleanNULL(pInput.HOSPITAL_STATUS);
		SELF.PREGNANCY									:=	Death_Master.fn_cleanNULL(pInput.PREGNANCY);
		SELF.FACILITY_DEATH							:=	Death_Master.fn_cleanNULL(pInput.FACILITY_DEATH);
		SELF.EMBALMER_LIC_NO						:=	Death_Master.fn_cleanNULL(pInput.EMBALMER_LIC_NO);
		SELF.DEATH_TYPE									:=	Death_Master.fn_cleanNULL(pInput.DEATH_TYPE);
		SELF.TIME_DEATH									:=	Death_Master.fn_cleanNULL(pInput.TIME_DEATH);
		SELF.BIRTH_CERT									:=	Death_Master.fn_cleanNULL(pInput.BIRTH_CERT);
		SELF.CERTIFIER									:=	Death_Master.fn_cleanNULL(pInput.CERTIFIER);
		SELF.CERT_NUMBER								:=	Death_Master.fn_cleanNULL(pInput.CERT_NUMBER);
		SELF.BIRTH_VOL_YEAR							:=	Death_Master.fn_cleanNULL(pInput.BIRTH_VOL_YEAR);
		SELF.LOCAL_FILE_NO							:=	Death_Master.fn_cleanNULL(pInput.LOCAL_FILE_NO);
		SELF.VDI												:=	Death_Master.fn_cleanNULL(pInput.VDI);
		SELF.CITE_ID										:=	Death_Master.fn_cleanNULL(pInput.CITE_ID);
		SELF.FILE_ID										:=	Death_Master.fn_cleanNULL(pInput.FILE_ID);
		SELF.AMENDMENT_CODE							:=	Death_Master.fn_cleanNULL(pInput.AMENDMENT_CODE);
		SELF.AMENDMENT_YEAR							:=	Death_Master.fn_cleanNULL(pInput.AMENDMENT_YEAR);
		SELF._ON_LEXIS									:=	Death_Master.fn_cleanNULL(pInput._ON_LEXIS);
		SELF._FS_PROFILE								:=	Death_Master.fn_cleanNULL(pInput._FS_PROFILE);
		SELF.US_ARMED_FORCES						:=	Death_Master.fn_cleanNULL(pInput.US_ARMED_FORCES);
		SELF.PLACE_OF_DEATH							:=	Death_Master.fn_cleanNULL(pInput.PLACE_OF_DEATH);
		SELF														:=	pInput;
	END;

	fill_supp := PROJECT(supp,fill(LEFT, COUNTER));
	RETURN fill_supp;
END;
