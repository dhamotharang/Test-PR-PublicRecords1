/*2010-04-14T13:51:10Z (Sudhir Kasavajjala)

*/
import lib_stringlib, watercraft;

Watercraft.Layout_KY_infolink_clean_in reformat(Watercraft.file_KY_infolink_clean_in L) := transform

self.HULL_ID := if(trim(L.HULL_ID,left,right)in['NO S/N','NOS/N','N/S/N', 'UNK', 'UNKNOWN','UNKN'],'',if(StringLib.StringFind(L.HULL_ID,'S/N',1) = 1,trim(L.HULL_ID,left,right)[4..],L.HULL_ID)) ;
self := L;
end;

hull_clean_in := project(Watercraft.file_KY_infolink_clean_in, reformat(left));

Watercraft.Layout_Watercraft_Search_Group search_mapping_format(hull_clean_in L)
 :=
  transform
	self.date_first_seen			:=	L.REG_DATE;
	self.date_last_seen				:=	L.REG_DATE;
	self.date_vendor_first_reported	:=	L.process_date;
	self.date_vendor_last_reported	:=	L.process_date;
    self.watercraft_key				        :=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.YEAR, left, right) >= '1972', trim(L.HULL_ID, left, right),
										        (trim(L.HULL_ID,left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right) + trim(L.LNAME,left, right) + trim(L.FNAME,left, right))[1..30]);                          
	self.sequence_key			    :=	L.REG_DATE;
	self.state_origin				:=	'KY';
	self.source_code				:=	'AW';
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	trim(L.FNAME,left,right);
	self.orig_name_middle			:=	trim(L.MNAME,left,right);
	self.orig_name_last				:=	trim(L.LNAME,left,right);
	self.orig_address_1				:=	trim(L.ADDRESS,left,right);
	self.orig_city					:=	trim(L.CITY,left,right);
	self.orig_state					:=	L.STATE;
	self.orig_zip					:=	L.ZIP;
	self.gender						:=	L.SEX;
	self.clean_pname                :=  trim(L.pname,left,right);
	self.company_name				:=	L.cname;
	self.clean_address              :=  L.clean_address;  
	self                            := [];
  end
 ; 
 
Mapping_KY_infolink_as_Search_norm			:= project(hull_clean_in,search_mapping_format(left));

export Mapping_KY_infolink_as_Search         := Mapping_KY_infolink_as_Search_norm(clean_pname <> '' or company_name <> '');

