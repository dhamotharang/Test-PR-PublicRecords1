IMPORT TopBusiness_BIPV2, MDR;

Base := Edgar.File_Edgar_Company_Base_BIP;

UNSIGNED4 CvtFiscalYear(STRING4 mmdd) :=
				  (UNSIGNED4)((INTEGER)((StringLib.GetDateYYYYMMDD())[1..4]) * 10000 + (INTEGER)(mmdd));

TopBusiness_BIPV2.Layouts.rec_industry_combined_layout MapIndustry(Base L) := TRANSFORM
	SELF.bdid 										:=	L.bdid;
	SELF.bdid_score								:=	0;
	SELF.source       						:=	MDR.sourceTools.src_Edgar;
	SELF.source_docid  						:=	'';
	SELF.source_rec_id 						:=	'';
	SELF.siccode       						:=	L.sicCode;
	SELF.naics        						:=	'';
	SELF.industry_description 		:=	'';
	SELF.business_description 		:=	'';
	SELF.dt_first_seen						:=	(UNSIGNED4)Edgar.Version_Edgar_Company;
	SELF.dt_last_seen							:=	(UNSIGNED4)Edgar.Version_Edgar_Company;
	SELF.dt_vendor_first_reported	:=	IF(L.fiscalyear <> '',
											                 IF((INTEGER)((StringLib.GetDateYYYYMMDD())[5..6]) <= (INTEGER)(L.fiscalyear[1..2]),
												                  CvtFiscalYear(L.fiscalyear[1..4]) -10000,
												                  CvtFiscalYear(L.fiscalyear[1..4])),
											                 (UNSIGNED4)Version_Edgar_Company);
	SELF.dt_vendor_last_reported	:=	SELF.dt_vendor_first_reported;
	SELF.record_type							:=	'';
	SELF.record_date							:=	SELF.dt_vendor_first_reported;
	SELF 													:=	L; 
	SELF 													:=	[];
END;
		
EXPORT Edgar_As_Industry := PROJECT(Base,MapIndustry(LEFT));
