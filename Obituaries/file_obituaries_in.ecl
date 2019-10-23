Import obituaries,ut, VersionControl,	PromoteSupers;

EXPORT file_obituaries_in	:= function

file_date := VersionControl.fGetFilenameVersion('~thor_data400::in::tributes_dmaster_raw');

ds_raw_in		:=	Obituaries.file_obit_xml_in;
ds_raw_base	:=	Obituaries.files_raw_base.Tributes;

Obituaries.layouts.layout_reor_tribute reorderFields(obituaries.layouts.obit_xml_in l) := TRANSFORM
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
	trimsuffix				:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.suffix));
  clnsuffix					:=	MAP ( 
													trimsuffix<>'' => trimsuffix,
													stringlib.stringfind(trimlname,' JR',1) <>0 => 'JR',
													stringlib.stringfind(trimlname,' SR',1) <>0 => 'SR',
													stringlib.stringfind(trimlname,' I',1) <>0 => 'I',
													stringlib.stringfind(trimlname,' II',1) <>0 => 'II',
													trimsuffix );
	 self.prefix					:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.prefix),'.',''));
   self.fname						:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.fname),'.',''));
   self.mname						:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.mname),'.',''));
   self.lname						:=	ut.CleanSpacesAndUpper(clnlname);
   self.name_suffix			:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(clnsuffix,'.',''));
   self.gender					:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.gender));
   self.age							:=	ut.fn_RemoveSpecialChars(l.age);
   self.birth_month			:=	intformat((integer)ut.fn_RemoveSpecialChars(l.birth_month),2,1);
   self.birth_day				:=	intformat((integer)ut.fn_RemoveSpecialChars(l.birth_day),2,1);
	 self.birth_year			:=	intformat((integer)ut.fn_RemoveSpecialChars(l.birth_year),4,1);
   self.death_month 		:=	intformat((integer)ut.fn_RemoveSpecialChars(l.death_month),2,1);
   self.death_day				:=	intformat((integer)ut.fn_RemoveSpecialChars(l.death_day),2,1);
   self.death_year			:=	intformat((integer)ut.fn_RemoveSpecialChars(l.death_year),4,1);
   self.location_city		:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.location_city));
   self.location_state	:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.location_state));
   self.spouses_name		:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.spouses_name));
   self.spouses_living_status := ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.spouses_living_status));
   self.companions_name	:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.companions_name));
   self.full_obit_text	:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.full_obit_text));
   self.donation_text		:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.donation_text));
   self.education_text	:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.education_text));
   self.military_text		:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.military_text));
   self.service_text		:=	ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.service_text));
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
END;

RollupTributes	:= Rollup(srt_combined,xformCombined(LEFT,RIGHT),person_id,LOCAL);

PromoteSupers.MAC_SF_BuildProcess(RollupTributes,'~thor_data400::base::obituary_death_master',build_obituary_out,3, /*csvout*/false, /*compress*/true);

return build_obituary_out;
	
end;
