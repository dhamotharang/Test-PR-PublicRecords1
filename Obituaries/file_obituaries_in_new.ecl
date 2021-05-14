Import obituaries,ut, VersionControl,	PromoteSupers;

EXPORT file_obituaries_in_new	:= function

file_date := VersionControl.fGetFilenameVersion('~thor_data400::in::tributes_dmaster_raw_history_new');

ds_raw_in		:=	Obituaries.file_obit_xml_in_new;
ds_raw_base	:=	Obituaries.files_raw_base.Tributes;

Obituaries.layouts_new.layout_reor_tribute reorderFields(obituaries.layouts_new.obit_xml_historical l) := TRANSFORM
// Obituaries.layouts.layout_reor_tribute reorderFields(obituaries.layouts.obit_xml_in l) := TRANSFORM

	 self.filedate		:=	(string8)file_date;
   self.person_id 	:=	ut.fn_RemoveSpecialChars(l.person_id);
	 self.rec_type		:=	'';
	 trimlname				:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.lname));
   clnlname					:=	MAP ( 
													stringlib.stringfind(trimlname,' JR',1) <>0 => trimlname[1..stringlib.stringfind(trimlname,' JR',1)],
													stringlib.stringfind(trimlname,' SR',1) <>0 => trimlname[1..stringlib.stringfind(trimlname,' SR',1)],
													stringlib.stringfind(trimlname,' I',1) <>0 => trimlname[1..stringlib.stringfind(trimlname,' I',1)],
													stringlib.stringfind(trimlname,' II',1) <>0 => trimlname[1..stringlib.stringfind(trimlname,' II',1)],
													trimlname );
	// trimsuffix				:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.suffix));
  // clnsuffix					:=	MAP ( 
													// trimsuffix<>'' => trimsuffix,
													// stringlib.stringfind(trimlname,' JR',1) <>0 => 'JR',
													// stringlib.stringfind(trimlname,' SR',1) <>0 => 'SR',
													// stringlib.stringfind(trimlname,' I',1) <>0 => 'I',
													// stringlib.stringfind(trimlname,' II',1) <>0 => 'II',
													// trimsuffix );
	 // self.prefix					:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.prefix),'.',''));
	 self.prefix						:= '';
	 self.name_suffix						:='';
	 self.RowCreated_Date			:=  ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.row_create),'.',''));
	 self.RowUpdated_Date			:=  ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.row_update),'.',''));
	 self.RowDeleted_Date			:=  ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.row_deleted),'.',''));
   self.fname						:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.fname),'.',''));
   self.mname						:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.mname),'.',''));
   self.lname						:=	ut.CleanSpacesAndUpper(clnlname);
   // self.name_suffix			:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(clnsuffix,'.',''));
   self.gender					:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.gender));
   self.age							:=	ut.fn_RemoveSpecialChars(l.age);
   self.birth_month			:=	ut.Date_Standard.date_dashed(l.date_birth) [5..6];
   self.birth_day				:=	ut.Date_Standard.date_dashed(l.date_birth) [7..8];
	 self.birth_year			:=	ut.Date_Standard.date_dashed(l.date_birth) [..4];
   self.death_month 		:=	ut.Date_Standard.date_dashed(l.date_death) [5..6];
   self.death_day				:=	ut.Date_Standard.date_dashed(l.date_death) [7..8];
   self.death_year			:=	ut.Date_Standard.date_dashed(l.date_death) [..4];
	 
	 // self.dob							:=  ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.dob));
	 // self.dod 						:=  ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.dod));
	 Trim_City						:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.location_city));
	 Trim_State						:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.location_state));
   self.location_city		:=	IF(Trim_City = 'N/A','',Trim_City);
   self.location_state	:=	MAP(Trim_State = 'ALABAMA'  =>	'AL',
																Trim_State = 'ALASKA'   =>	'AK',
																Trim_State = 'ARIZONA'  =>	'AZ',
																Trim_State = 'ARKANSAS' =>	'AR',
																Trim_State = 'CALIFORNIA' =>	'CA',
																Trim_State = 'COLORADO'   =>	'CO',
																Trim_State = 'CONNECTICUT' =>	'CT',		
																Trim_State = 'DELAWARE' =>	'DE',
																Trim_State = 'FLORIDA' =>	'FL',
																Trim_State = 'GEORGIA' =>	'GA',
																Trim_State = 'HAWAII'  =>	'HI',
																Trim_State = 'IDAHO'   =>	'ID',
																Trim_State = 'ILLINOIS' =>	'IL',
																Trim_State = 'INDIANA'  =>	'IN',
																Trim_State = 'IOWA'   =>	'IA',
																Trim_State = 'KANSAS' =>	'KS',
																Trim_State = 'KENTUCKY' =>	'KY',
																Trim_State = 'LOUISIANA' =>	'LA',
																Trim_State = 'MAINE' =>	'ME',
																Trim_State = 'MARYLAND' =>	'MD',
																Trim_State = 'MASSACHUSETTS' =>	'MA',
																Trim_State = 'MICHIGAN' =>	'MI',
																Trim_State = 'MINNESOTA' =>	'MN',
																Trim_State = 'MISSISSIPPI' =>	'MS',
																Trim_State = 'MISSOURI' =>	'MO',
																Trim_State = 'MONTANA' =>	'MT',
																Trim_State = 'NEBRASKA' =>	'NE',
																Trim_State = 'NEVADA' =>	'NV',
																Trim_State = 'NEW HAMPSHIRE' =>	'NH',
																Trim_State = 'NEW JERSEY' =>	'NJ',
																Trim_State = 'NEW MEXICO' =>	'NM',
																Trim_State = 'NEW YORK' =>	'NY',
																Trim_State = 'NORTH CAROLINA' =>	'NC',
																Trim_State = 'NORTH DAKOTA' =>	'ND',
																Trim_State = 'OHIO' =>	'OH',
																Trim_State = 'OKLAHOMA' =>	'OK',
																Trim_State = 'OREGON' =>	'OR',
																Trim_State = 'PENNSYLVANIA' =>	'PA',
																Trim_State = 'RHODE ISLAND' =>	'RI',
																Trim_State = 'SOUTH CAROLINA' =>	'SC',
																Trim_State = 'SOUTH DAKOTA' =>	'SD',
																Trim_State = 'TENNESSEE' =>	'TN',
																Trim_State = 'TEXAS' =>	'TX',
																Trim_State = 'UTAH' =>	'UT',
																Trim_State = 'VERMONT' =>	'VT',
																Trim_State = 'VIRGINIA' =>	'VA',
																Trim_State = 'WASHINGTON' =>	'WA',
																Trim_State = 'WEST VIRGINIA' =>	'WV',
																Trim_State = 'WISCONSIN' =>	'WI',
																Trim_State = 'WYOMING' =>	'WY',
																Trim_State = 'N/A' => '',
																Trim_State);
	 
   self.spouses_name		:=	'';
   self.spouses_living_status :='';
   self.companions_name	:=	'';
	 self.Obit_Date       :=  ut.CleanSpacesAndUpper(l.obit_start_date);
	 self.Funeral_Service_in_City  :=  ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.funeral_city));
   self.Funeral_Service_in_State :=  ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.funeral_st));
   self.full_obit_text	:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.full_obit_text));
   self.donation_text		:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.donation_text));
   self.education_text	:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.education_text));
   self.military_text		:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.military_text));
   self.service_text		:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.service_text));
	 self.salutation			:=  ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.salutation));
	 self.Associated_Funeral_Home			:=  ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.associate_funeral_home));
	 SELF	:= [];
END;

file_new_order := project(ds_raw_in(trim(person_id,left,right) != 'person_id'),reorderFields(left));

//Remove nicknames from name fields
string RemoveNickname(string s) := function
                rmv_nickname := StringLib.StringCleanSpaces(REGEXREPLACE('([("\'][A-Z ]+[)"\'])',s,''));
return rmv_nickname;
end;								

Obituaries.layouts.layout_reor_tribute cleanName(file_new_order l) := TRANSFORM
  self.fname	:=	RemoveNickname(l.fname);
	self.mname	:=	RemoveNickname(l.mname);
	self.lname	:=	RemoveNickname(l.lname);
	self				:=	l;
END;

file_clean_name	:=	project(file_new_order,cleanName(left));
combine_recs		:=	file_clean_name(trim(fname,all)!= '' and trim(lname,all)!= '') + ds_raw_base(trim(fname,all)!= '' and trim(lname,all)!= '');
distr_combined	:=	distribute(combine_recs,hash(person_id));
srt_combined		:=	sort(distr_combined,person_id,-filedate,local);

//rollup new file to base file to capture changed records
obituaries.layouts.layout_reor_tribute xformCombined(srt_combined l, srt_combined r)	:= TRANSFORM
	self.person_id							:=	l.person_id;
	self.filedate								:=	IF(l.filedate<r.filedate,r.filedate,l.filedate);
	self.rec_type								:=	IF(l.rec_type='',r.rec_type,l.rec_type);
	self.prefix									:=	IF(l.prefix='',r.prefix,l.prefix);
	self.fname									:=	IF(l.fname='',r.fname,l.fname);
	self.mname									:=	IF(l.mname='',r.mname,l.mname);
	self.lname									:=	IF(l.lname='',r.lname,l.lname);
	self.name_suffix						:=	IF(l.name_suffix='',r.name_suffix,l.name_suffix);
	self.gender									:=	IF(l.gender='',r.gender,l.gender);
	self.age										:=	IF((UNSIGNED)l.age=0,r.age,l.age);
	self.birth_month						:=	IF((UNSIGNED)l.birth_month=0,r.birth_month,l.birth_month);
	self.birth_day							:=	IF((UNSIGNED)l.birth_day=0,r.birth_day,l.birth_day);
	self.birth_year							:=	IF((UNSIGNED)l.birth_year=0,r.birth_year,l.birth_year);
	self.death_month						:=	IF((UNSIGNED)l.death_month=0,r.death_month,l.death_month);
	self.death_day							:=	IF((UNSIGNED)l.death_day=0,r.death_day,l.death_day);
	self.death_year							:=	IF((UNSIGNED)l.death_year=0,r.death_year,l.death_year);	
	self.location_city					:=	IF(l.location_city='',r.location_city,l.location_city);
	self.location_state					:=	IF(l.location_state='',r.location_state,l.location_state);
	self.spouses_name						:=	IF(l.spouses_name='',r.spouses_name,l.spouses_name);
	self.spouses_living_status	:=	IF(l.prefix='',r.prefix,l.prefix);
	self.companions_name				:=	IF(l.spouses_living_status='',r.spouses_living_status,l.spouses_living_status);
	self.full_obit_text					:=	IF(l.full_obit_text='',r.full_obit_text,l.full_obit_text);
	self.donation_text					:=	IF(l.donation_text='',r.donation_text,l.donation_text);
	self.education_text					:=	IF(l.education_text='',r.education_text,l.education_text);
	self.military_text					:=	IF(l.military_text='',r.military_text,l.military_text);
	self.service_text						:=	IF(l.service_text='',r.service_text,l.service_text);	
	// New fields from Newspaper and History Tribute
  self.Maiden_Name            :=	IF(l.Maiden_Name='',r.Maiden_Name,l.Maiden_Name);	
  self.Nick_Name              :=	IF(l.Nick_Name='',r.Nick_Name,l.Nick_Name);	
	self.Obit_Date              :=	IF(l.Obit_Date='',r.Obit_Date,l.Obit_Date);	
  self.Updated_Date           :=	IF(l.Updated_Date='',r.Updated_Date,l.Updated_Date);	
	self.RowCreated_Date        :=	IF(l.RowCreated_Date='',r.RowCreated_Date,l.RowCreated_Date);
	self.RowUpdated_Date        :=	IF(l.RowUpdated_Date='',r.RowUpdated_Date,l.RowUpdated_Date);
	self.RowDeleted_Date        :=	IF(l.RowDeleted_Date='',r.RowDeleted_Date,l.RowDeleted_Date);
	self.Salutation             :=	IF(l.Salutation='',r.Salutation,l.Salutation);
	self.Associated_Funeral_Home  :=	IF(l.Associated_Funeral_Home='',r.Associated_Funeral_Home,l.Associated_Funeral_Home);
  self.Funeral_Service_in_City  :=	IF(l.Funeral_Service_in_City='',r.Funeral_Service_in_City,l.Funeral_Service_in_City);	
  self.Funeral_Service_in_State :=	IF(l.Funeral_Service_in_State='',r.Funeral_Service_in_State,l.Funeral_Service_in_State);	
  self.Service_Location_Zip_Code:=	IF(l.Service_Location_Zip_Code='',r.Service_Location_Zip_Code,l.Service_Location_Zip_Code);	
  self.Obituary_Link          :=	IF(l.Obituary_Link='',r.Obituary_Link,l.Obituary_Link);	
  self.Newspaper_Source       :=	IF(l.Newspaper_Source='',r.Newspaper_Source,l.Newspaper_Source);	
  self.Newspaper_City         :=	IF(l.Newspaper_City='',r.Newspaper_City,l.Newspaper_City);	
  self.Newspaper_Zip_Code     :=	IF(l.Newspaper_Zip_Code='',r.Newspaper_Zip_Code,l.Newspaper_Zip_Code);

END;

RollupTributes	:= Rollup(srt_combined,xformCombined(LEFT,RIGHT),person_id,LOCAL);

PromoteSupers.MAC_SF_BuildProcess(RollupTributes,'~thor_data400::base::obituary_death_master',build_obituary_out,3, /*csvout*/false, /*compress*/true);

return build_obituary_out;
	
end;
