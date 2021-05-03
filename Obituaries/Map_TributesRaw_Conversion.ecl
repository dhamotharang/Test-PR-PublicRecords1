Import obituaries,ut, VersionControl,	PromoteSupers;

EXPORT Map_TributesRaw_Conversion	:= function

file_date_obit  := VersionControl.fGetFilenameVersion('~thor_data400::in::tributes_dmaster_raw');

ds_obit_in      := Obituaries.file_obit_xml_in;

Obituaries.layouts.layout_reor_tribute TransObit(obituaries.layouts.obit_xml_in l) := TRANSFORM
	 self.filedate		:=	(string8)file_date_obit;
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
	 SELF := [];
END;

file_new_obit  := project(ds_obit_in(trim(person_id,left,right) != 'person_id'),TransObit(left));

PromoteSupers.MAC_SF_BuildProcess(file_new_obit,'~thor_data400::in::tributes_raw',build_tributes_out,3, /*csvout*/false, /*compress*/true);


RETURN build_tributes_out;

END;