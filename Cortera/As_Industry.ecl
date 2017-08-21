IMPORT TopBusiness_BIPV2, MDR, std, ut, _Validate;

trimUpper(STRING s) := 
  std.str.CleanSpaces(std.Str.ToUppercase(s));
		


EXPORT As_Industry(dataset(Cortera.Layout_Executives) base) := FUNCTION


		Industry_Layout := TopBusiness_BIPV2.Layouts.rec_industry_combined_layout;

		Industry_Layout	MapIndustry (Base L)	:=	TRANSFORM
			SELF.bdid 										:=	L.bdid;
			SELF.bdid_score								:=	L.bdid_score;
			SELF.source       						:=	MDR.sourcetools.src_Cortera;
			SELF.source_docid  						:=	(string)L.version;
			SELF.source_rec_id  					:=	L.link_id;
			SELF.siccode       						:=	L.primary_sic;
			SELF.naics        						:=	L.primary_naics;
			SELF.industry_description 		:=	trimUpper(STD.Str.FilterOut(L.sic_desc, '"'));
			SELF.business_description 		:=	trimUpper(L.naics_desc);
			SELF.dt_first_seen						:=	IF(_Validate.date.fIsValid((STRING)L.dt_first_seen), L.dt_first_seen, 0);
			SELF.dt_last_seen							:=	IF(_Validate.date.fIsValid((STRING)L.dt_last_seen), L.dt_last_seen, 0);
			SELF.dt_vendor_first_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_first_reported), L.dt_vendor_first_reported, 0);
			SELF.dt_vendor_last_reported	:=	IF(_Validate.date.fIsValid((STRING)L.dt_vendor_last_reported), L.dt_vendor_last_reported, 0);
			SELF.record_type							:=	''; //L.record_type;
			SELF.record_date							:=	0;
			SELF 													:=	L;
			SELF 													:=	[];
		END;

		Industry1 := PROJECT(Base(cnt=1),MapIndustry(LEFT));
		
		Industry := Industry1(siccode <> '' OR industry_description <> '' OR business_description <> '');

		return Industry;

END;