IMPORT Obituaries, PromoteSupers, STD;
EXPORT Build_Tribute_base := function;

new_tribute_in   := Obituaries.files.tributes_in;
newspaper_in     := Obituaries.files.newspaper_in;
ds_raw_base	     := Obituaries.files_raw_base.Tributes;

file_new_in      := new_tribute_in + newspaper_in;

//Remove nicknames from name fields
string RemoveNickname(string s) := function
                rmv_nickname := StringLib.StringCleanSpaces(REGEXREPLACE('([("\'][A-Z ]+[)"\'])',s,''));
return rmv_nickname;
end;								

Obituaries.layouts.layout_reor_tribute cleanName(file_new_in l) := TRANSFORM
  self.fname	:=	RemoveNickname(l.fname);
	self.mname	:=	RemoveNickname(l.mname);
	self.lname	:=	RemoveNickname(l.lname);
	self				:=	l;
END;

file_clean_name	:=	project(file_new_in,cleanName(left));
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
END;