Import Obituaries, ut, VersionControl,	PromoteSupers,	Std;

EXPORT Build_obituary_base := FUNCTION

file_date			:= VersionControl.fGetFilenameVersion('~thor_data400::in::obituarydata_raw');

ds_obit_in		:= Obituaries.file_obituary_raw_in(ut.isNumeric(person_id));
ds_obit_base	:= Obituaries.files_raw_base.Obituary;

//Remove nicknames from name fields
string RemoveNickname(string s) := function
	rmv_nickname	:=	StringLib.StringCleanSpaces(REGEXREPLACE('([("\'][A-Z ]+[)"\'])',s,''));
	return rmv_nickname;
end;

Obituaries.layouts.Obituary_raw_base cleanFields(ds_obit_in l) := TRANSFORM
		// Convert dates to a common format
		fmtsin := [
			'%Y/%m/%d'
		];
		fmtout:='%Y%m%d';

		self.filedate				:= (string8)file_date;
		self.person_id			:= l.person_id;
		self.lname					:= stringlib.StringFindReplace(RemoveNickname(ut.CleanSpacesAndUpper(l.lname)),'NULL','');
		self.fname					:= stringlib.StringFindReplace(ut.CleanSpacesAndUpper(l.fname),'NULL','');
		self.mname					:= stringlib.StringFindReplace(ut.CleanSpacesAndUpper(l.mname),'NULL','');
		tempSuffix					:= ut.CleanSpacesAndUpper(stringlib.StringFindReplace(l.name_suffix,'.',''));
		self.name_prefix		:= stringlib.StringFindReplace(ut.CleanSpacesAndUpper(l.name_prefix),'NULL','');
		self.name_suffix		:= stringlib.StringFindReplace(tempSuffix,'NULL','');
		self.DateOfBirth		:=	Std.date.ConvertDateFormatMultiple(l.DateOfBirth,fmtsin,fmtout);
		self.DateOfDeath		:=	Std.date.ConvertDateFormatMultiple(l.DateOfDeath,fmtsin,fmtout);
		self.City_in				:= stringlib.StringFindReplace(ut.CleanSpacesAndUpper(l.City_in),'NULL','');
		self.State_in				:= stringlib.StringFindReplace(ut.CleanSpacesAndUpper(l.State_in),'NULL','');
		self.Age						:= stringlib.StringFindReplace(l.Age,'NULL','');
		self.create_dt			:=	Std.date.ConvertDateFormatMultiple(l.create_dt,fmtsin,fmtout);
		self.update_dt			:=	Std.date.ConvertDateFormatMultiple(l.update_dt,fmtsin,fmtout);
//		self.ObituaryText		:= ut.CleanSpacesAndUpper(l.ObituaryText);  --vendor removed this field
END;

dsClean				:=	project(ds_obit_in,cleanFields(left));
CombineFiles	:=	dsClean + ds_obit_base;
dsDist				:=	distribute(CombineFiles,hash(person_id));
dsSort				:=	sort(dsDist,person_id,-update_dt,local);

//rollup new file to base file to capture changed records
Obituaries.layouts.Obituary_raw_base xformCombined(dsSort l, dsSort r)	:= TRANSFORM
	self.person_id		:=	l.person_id;
	self.filedate			:=	IF(l.filedate<r.filedate,r.filedate,l.filedate);
	self.name_prefix	:=	IF(l.name_prefix='',r.name_prefix,l.name_prefix);
	self.fname				:=	IF(l.fname='',r.fname,l.fname);
	self.mname				:=	IF(l.mname='',r.mname,l.mname);
	self.lname				:=	IF(l.lname='',r.lname,l.lname);
	self.name_suffix	:=	IF(l.name_suffix='',r.name_suffix,l.name_suffix);
	self.DateOfDeath	:=	IF(l.DateOfDeath='',r.DateOfDeath,l.DateOfDeath);
	self.DateOfBirth	:=	IF(l.DateOfBirth='',r.DateOfBirth,l.DateOfBirth);
	self.age					:=	IF((UNSIGNED)l.age=0,r.age,l.age);
	self.City_in			:=	IF(l.City_in='',r.City_in,l.City_in);
	self.State_in			:=	IF(l.State_in='',r.State_in,l.State_in);
	self.create_dt		:=	IF(l.create_dt='',r.create_dt,l.create_dt);
	self.update_dt		:=	l.update_dt;
END;

RollupObituary	:=	ROLLUP(dsSort,xformCombined(LEFT,RIGHT),person_id,local);

PromoteSupers.MAC_SF_BuildProcess(RollupObituary,'~thor_data400::base::obituarydata_death_master',build_obituary_out,3, /*csvout*/false, /*compress*/true,(string8)file_date);

return build_obituary_out;
	
end;