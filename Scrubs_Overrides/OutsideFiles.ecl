import FCRA,Scrubs_Headers_Monthly,Scrubs_LN_PropertyV2_Assessor,ln_propertyv2,Scrubs_LN_PropertyV2_Deed,Scrubs_LN_PropertyV2_Search,
Scrubs_LiensV2,Scrubs_bk_main,Scrubs_bk_search,Email_Data,Scrubs_Prof_License_Mari,Prof_License_Mari,American_student_list,Scrubs_Prof_License,
SexOffender,scrubs_sexoffender_offense,scrubs_sexoffender_main,Scrubs_Watercraft_Search,Advo,Scrubs_Crim,corrections,data_services,ut;
EXPORT OutsideFiles := module
		shared daily_prefix_Property := '~thor_data400::base::override::fcra::daily::qa::';
		
		shared kf := FCRA.File_Header_Correct ((unsigned)head.did<>0);

		shared HeaderScrubs:=project(kf,transform(Scrubs_Headers_Monthly.layout_File,self:=Left.head;self:=[]));
		
		EXPORT file_HeaderScrubsInput := HeaderScrubs;
	
		shared assessment_override_layout := record
				string20 flag_file_id;
				ln_propertyv2.layout_property_common_model_base;
			end;

		shared dailyds_assessment := dataset (daily_prefix_Property + 'assessment', assessment_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

		shared PropertyAssessmentScrubs:=project(dailyds_assessment,transform(Scrubs_LN_PropertyV2_Assessor.layout_Property_Assessor,self:=Left;self:=[]));
		
		EXPORT file_PropertyAssessmentScrubs:=PropertyAssessmentScrubs;
		
		shared deed_override_layout := record
			string20 flag_file_id;
			ln_propertyv2.layout_deed_mortgage_common_model_base;
		end;

		shared dailyds_deed := dataset (daily_prefix_Property + 'deed', deed_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
		
		shared PropertyDeedScrubs:=project(dailyds_deed,transform(Scrubs_LN_PropertyV2_Deed.layout_Property_Deed,self:=Left;self:=[]));

		EXPORT file_PropertyDeedScrubs	:= PropertyDeedScrubs;
		
		shared search_override_layout := record
			string20 flag_file_id;
			ln_propertyv2.layout_search_building;
		end;
		
		shared dailyds_search := dataset (daily_prefix_Property + 'property_search', search_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
		
		shared PropertySearchScrubs:=project(dailyds_search,transform(Scrubs_LN_PropertyV2_Search.layout_LN_PropertyV2_Search,self:=Left;self:=[]));
		
		EXPORT file_PropertySearchScrubs	:= PropertySearchScrubs;
		
		shared dsLiensMain :=  dataset('~thor_data400::base::override::fcra::qa::liensv2_main',FCRA.Layout_Override_Liens_Main_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
		
		EXPORT file_LiensMain := project(dsLiensMain,transform(Scrubs_LiensV2.Main_layout_LiensV2,self:=left;self:=[];));
		
		shared dsLiensParty :=  dedup(sort(dataset('~thor_data400::base::override::fcra::qa::liensv2_party',FCRA.Layout_Override_Liens_Party_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),tmsid,rmsid,-flag_file_id),except flag_file_id,keep(1));
		
		EXPORT file_LiensParty := project(dsLiensParty,transform(Scrubs_LiensV2.Party_layout_LiensV2,self:=left;self:=[];));
		
		shared dsbankrupt_filing :=  dedup(sort(dataset('~thor_data400::base::override::fcra::qa::bankrupt_main',FCRA.layout_main_ffid_v3,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));
		
		EXPORT file_bankrupt_filing := project(dsbankrupt_filing,transform(Scrubs_bk_main.Layout_bk_main,self:=left;self:=[];));
		
		shared dsbankrupt_Search := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::bankrupt_search', FCRA.layout_search_ffid_v3,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));
		
		EXPORT file_bankrupt_Search := project(dsbankrupt_Search,transform(Scrubs_bk_search.Layout_bk_search,self:=left;self:=[];));
		
		shared file_Emailbase := dataset('~thor_data400::base::override::fcra::qa::email_data',FCRA.Layout_Override_Email_Data,csv(separator('\t'),quote('\"'),terminator('\r\n')));
		
		Email_Data.Layout_Email.Scrubs_Layout xform(file_Emailbase l) := transform
	 self.title := l.clean_name.title;
   self.fname := l.clean_name.fname;
   self.mname	:= l.clean_name.mname;
   self.lname	:= l.clean_name.lname;
   self.name_suffix := l.clean_name.name_suffix;	
   self.name_score := l.clean_name.name_score;	
   self.prim_range := l.clean_address.prim_range;
   self.predir := l.clean_address.predir;
   self.prim_name := l.clean_address.prim_name;
   self.addr_suffix := l.clean_address.addr_suffix;
   self.postdir := l.clean_address.postdir;
   self.unit_desig := l.clean_address.unit_desig;
   self.sec_range := l.clean_address.sec_range;
   self.p_city_name := l.clean_address.p_city_name;
   self.v_city_name := l.clean_address.v_city_name;
   self.st := l.clean_address.st;
   self.zip := l.clean_address.zip;
   self.zip4 := l.clean_address.zip4;
   self.cart := l.clean_address.cart;
   self.cr_sort_sz := l.clean_address.cr_sort_sz;
   self.lot := l.clean_address.lot;
   self.lot_order := l.clean_address.lot_order;
   self.dbpc := l.clean_address.dbpc;
   self.chk_digit := l.clean_address.chk_digit;
   self.rec_type := l.clean_address.rec_type;
   self.county := l.clean_address.county;
   self.geo_lat := l.clean_address.geo_lat;
   self.geo_long := l.clean_address.geo_long;
   self.msa := l.clean_address.msa;
   self.geo_blk := l.clean_address.geo_blk;
   self.geo_match := l.clean_address.geo_match;
   self.err_stat := l.clean_address.err_stat;
	 self := l;
end;

EXPORT file_Email_Data := project(file_Emailbase, xform(left));


 shared proflic_mari_rec := RECORD
    recordof(Prof_License_Mari.key_did(true));
    string20 flag_file_id;
  end;
shared dailyds_proflic_mari := dataset ('~thor_data400::base::override::fcra::daily::qa::proflic_mari', proflic_mari_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
shared dailyds_ForScrubs:=project(dailyds_proflic_mari,transform(Scrubs_Prof_License_Mari.Layout_Prof_License_Mari,self:=left;self:=[];));
ut.CleanFields(dailyds_ForScrubs,cln_LatestUpdate);

Export file_ProfLicMari := cln_LatestUpdate;

shared dailyds_Student_New := dataset ('~thor_data400::base::override::fcra::daily::qa::american_student_new', fcra.Layout_Override_Student_New, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT);

shared ds_Student := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::american_student',FCRA.Layout_Override_Student_In,CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT),-flag_file_id),except flag_file_id,keep(1));

EXPORT file_Student_New:=project(dailyds_Student_New,transform(American_student_list.layout_american_student_base_v2,self:=left;self:=[];));
EXPORT file_Student:=project(ds_Student,transform(American_student_list.layout_american_student_base_v2,self.key := (integer)left.key;self.did := (unsigned)left.did;self:=left;self:=[];));

shared ProfLicInput := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::proflic',fcra.layout_override_proflic,csv(separator('\t'),quote('\"'),terminator('\r\n'))),-flag_file_id),except flag_file_id,keep(1));

Export file_ProfLic:=project(ProfLicInput,transform(Scrubs_Prof_License.Base_Layout_Prof_License,self:=left;self:=[];));

 shared SOff_rec := RECORD
		string20 flag_file_id;
		recordof(SexOffender.key_SexOffender_SPK());
  end;

shared dailyds_SOff := dataset ('~thor_data400::base::override::fcra::daily::qa::so_main', SOff_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

Export file_SOff:=project(dailyds_SOff,transform(scrubs_sexoffender_main.layout_sexoffender_main,self:=left;self:=[];));

shared offense_rec := record
		string20 flag_file_id;
		recordof(SexOffender.Key_SexOffender_offenses());
	end;

shared dailyds_offenses := dataset ('~thor_data400::base::override::fcra::daily::qa::so_offenses', offense_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

Export file_SOffOffense:=project(dailyds_offenses,transform(scrubs_sexoffender_offense.layout_sexoffender_offense,self.offense_category:=(STRING)left.offense_category;self:=left;self:=[];));

shared Watercraftin := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::watercraft',fcra.layout_override_watercraft,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

Export file_Watercraft := project(Watercraftin,transform(Scrubs_Watercraft_Search.Layout_Watercraft_Search,self:=left;self:=[];));

shared AdvoIn := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::ADVO',FCRA.Layout_Override_ADVO,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

Export file_ADVO:=project(AdvoIn,transform(Advo.Layout_Scrubs,self:=left;self:=[];));

shared offenders_rec := record
	  string20 flag_file_id;
		corrections.layout_Offender;
		end;

shared dailyds_offenders := dataset (data_services.data_location.prefix('fcra_overrides')+'thor_data400::base::override::fcra::daily::qa::offenders', offenders_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

export file_CrimOffenders:=project(dailyds_offenders,transform(Scrubs_Crim.Moxie_Crim_Offender2_Dev_Layout_Crim,self:=left;self:=[];));

//court_offenses
  shared court_offenses_rec := record
	  string20 flag_file_id;
    corrections.layout_CourtOffenses - offense_category;
  end;

  shared dailyds_court_offenses := dataset (data_services.data_location.prefix('fcra_overrides')+'thor_data400::base::override::fcra::daily::qa::court_offenses', court_offenses_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	
	export file_CourtOffenses:=project(dailyds_court_offenses,transform(Scrubs_Crim.Moxie_Court_Offenses_Dev_Layout_Crim,self:=left;self:=[];));
	
	//Extracting Flag File ID
	shared IndFlag_file_PropertyAssessmentScrubs :=project(dailyds_assessment,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_PropertyAssessmentScrubs';self:=left;));
	shared IndFlag_file_PropertyDeedScrubs :=project(dailyds_deed,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_PropertyDeedScrubs';self:=left;));
	shared IndFlag_file_PropertySearchScrubs :=project(dailyds_search,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_PropertySearchScrubs';self:=left;));
	shared IndFlag_file_LiensParty :=project(dsLiensParty,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_LiensParty';self:=left;));
	shared IndFlag_file_LiensMain :=project(dsLiensMain,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_LiensMain';self:=left;));
	shared IndFlag_file_bankrupt_filing :=project(dsbankrupt_filing,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_bankrupt_filing';self:=left;));
	shared IndFlag_file_bankrupt_Search :=project(dsbankrupt_Search,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_bankrupt_Search';self:=left;));
	shared IndFlag_file_email_data :=project(file_Emailbase,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_email_data';self:=left;));
	shared IndFlag_file_ProfLicMari :=project(dailyds_proflic_mari,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_ProfLicMari';self:=left;));
	shared IndFlag_file_Student :=project(ds_Student,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_Student';self:=left;));
	shared IndFlag_file_ProfLic :=project(ProfLicInput,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_ProfLic';self:=left;));
	shared IndFlag_file_SOff :=project(dailyds_SOff,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_SOff';self:=left;));
	shared IndFlag_file_SOffOffense :=project(dailyds_offenses,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_SOffOffense';self:=left;));
	shared IndFlag_file_Student_New :=project(dailyds_Student_New,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_Student_New';self:=left;));
	shared IndFlag_file_Watercraft :=project(Watercraftin,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_Watercraft';self:=left;));
	shared IndFlag_file_Advo :=project(AdvoIn,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_Advo';self:=left;));
	shared IndFlag_file_CrimOffenders :=project(dailyds_offenders,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_CrimOffenders';self:=left;));
	shared IndFlag_file_CourtOffenses :=project(dailyds_court_offenses,transform(Scrubs_Overrides.IndFlag_layout_overrides,self.Key_Ind:='file_CourtOffenses';self:=left;));
	
	export file_IndFlag := 
	IndFlag_file_PropertyAssessmentScrubs +
	IndFlag_file_PropertyDeedScrubs +
	IndFlag_file_PropertySearchScrubs +
	IndFlag_file_LiensParty +
	IndFlag_file_LiensMain +
	IndFlag_file_bankrupt_filing +
	IndFlag_file_bankrupt_Search +
	IndFlag_file_email_data +
	IndFlag_file_ProfLicMari +
	IndFlag_file_Student +
	IndFlag_file_ProfLic +
	IndFlag_file_SOff +
	IndFlag_file_SOffOffense +
	IndFlag_file_Student_New +
	IndFlag_file_Watercraft +
	IndFlag_file_Advo +
	IndFlag_file_CrimOffenders +
	IndFlag_file_CourtOffenses;
	
	
end;