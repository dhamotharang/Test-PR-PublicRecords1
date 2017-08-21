import lib_stringlib, watercraft;

Watercraft.Macro_Clean_Hull_ID(watercraft.file_CO_clean_in, watercraft.Layout_CO_clean_in,hull_clean_in)

//Fix Bad dates
BadDates := hull_clean_in(StringLib.stringfind(REG_DATE,'/',1) > 0);

GoodDates := hull_clean_in(StringLib.stringfind(REG_DATE,'/',1) = 0);

//Reformat BadDates to date standard for comparison
l_tempBase := record
	Watercraft.Layout_CO_clean_in;
	string8 tempDate := '';
end;

l_tempBase XformBadDates(BadDates pInput) := TRANSFORM
		tempMonth	:= pInput.REG_DATE[1..2];
		tempDay		:= pInput.REG_DATE[4..5];
		tempYr		:= pInput.REG_DATE[7..8]; //Partial year.  Issue to fix
		self.tempDate := tempyr+'??'+tempMonth+tempDay;
		self := pInput;
end;

TempFixDates := project(BadDates,XformBadDates(left));
dist_TempBadDate	:= distribute(TempFixDates,hash(hull_id));
dist_GoodDate	:= distribute(GoodDates,hash(hull_id));
		
//Join file with bad dates and file with good dates based on hull_id, use, make, first_name, last_name, address_1, and partial tempDate
Watercraft.Layout_CO_clean_in FixBadDate(dist_TempBadDate l, dist_GoodDate r) := TRANSFORM
	self.REG_DATE := r.REG_DATE;
	self := l;
	self := r;
end;

j_GoodRecsMatch := join(dist_TempBadDate, dist_GoodDate,
												left.hull_id = right.hull_id AND
												left.use_1 = right.use_1 AND
												left.make = right.make AND
												left.first_name = right.first_name AND
												left.last_name = right.last_name AND
												left.address_1 = right.address_1 AND
												left.tempDate[1..2]+left.tempDate[5..8] = right.reg_date[1..2]+right.reg_date[5..8],
												FixBadDate(left,right),inner,local);
												
out_GoodRecs := j_GoodRecsMatch + GoodDates;
dedupGoodRecs := dedup(out_GoodRecs); //Combine with ValidDate file to get all ValidDateRecords and dedup

//Find records that do not have a good date record match and standardize date with ?? to fill missing yr
 j_BadRecsNoMatch := join(dist_TempBadDate, dist_GoodDate,
												left.hull_id = right.hull_id AND
												left.use_1 = right.use_1 AND
												left.make = right.make AND
												left.first_name = right.first_name AND
												left.last_name = right.last_name AND
												left.address_1 = right.address_1 AND
												left.tempDate[5..8] = right.reg_date[5..8],
												transform(Watercraft.Layout_CO_clean_in, self.REG_DATE := left.tempDate,
																																						self := left),left only, local);
																																						
FixedDatesFile	:= dedupGoodRecs+j_BadRecsNoMatch;

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(FixedDatesFile L)
 :=
  transform
	self.date_first_seen			:=	if(L.REG_DATE = '19910926', '', L.REG_DATE);
	self.date_last_seen				:=	if(L.REG_DATE = '19910926', '', L.REG_DATE);
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
	self.watercraft_key				:=	(trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30];                                          
	self.sequence_key				:=	trim(L.REG_DATE, left, right);
	self.state_origin				:=	'CO';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code		:=	'R';
	self.orig_name_type_description	:=	'REGISTRANT';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:=	'';
	self.orig_address_1				:=	trim(L.ADDRESS_1,left,right);
	self.orig_address_2				:=	'';
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip					:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.clean_pname                :=  L.clean_pname;
	self.company_name				:=	L.clean_cname;
	self.clean_address              :=  L.clean_address;            
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	'';
	self.did_score					:=	'';                              
	self.ssn						:=	'';
	self.history_flag				:=	'';
  end
 ; 
 
Mapping_CO_as_Search_norm			:= project(FixedDatesFile,search_mapping_format(left));

export Mapping_CO_as_Search         := Mapping_CO_as_Search_norm(clean_pname <> '' or company_name <> '');


