import _control, Mdr, Std;

EBR.Layout_6510_Government_Debarred_Contractor_Base	trfBaseToOrig(Layout_6510_Government_Debarred_Contractor_Base_AID	l)	:=	transform
	self.clean_business_address.prim_range	:=	l.clean_Business_Address.prim_range	;
	self.clean_business_address.predir			:=	l.clean_Business_Address.predir	;
	self.clean_business_address.prim_name		:=	l.clean_Business_Address.prim_name	;
	self.clean_business_address.addr_suffix	:=	l.clean_Business_Address.addr_suffix	;
	self.clean_business_address.postdir			:=	l.clean_Business_Address.postdir	;
	self.clean_business_address.unit_desig	:=	l.clean_Business_Address.unit_desig	;
	self.clean_business_address.sec_range		:=	l.clean_Business_Address.sec_range	;
	self.clean_business_address.p_city_name	:=	l.clean_Business_Address.p_city_name	;
	self.clean_business_address.v_city_name	:=	l.clean_Business_Address.v_city_name	;
	self.clean_business_address.st					:=	l.clean_Business_Address.st	;
	self.clean_business_address.zip					:=	l.clean_Business_Address.zip	;
	self.clean_business_address.zip4				:=	l.clean_Business_Address.zip4	;
	self.clean_business_address.cart				:=	l.clean_Business_Address.cart	;
	self.clean_business_address.cr_sort_sz	:=	l.clean_Business_Address.cr_sort_sz	;
	self.clean_business_address.lot					:=	l.clean_Business_Address.lot	;
	self.clean_business_address.lot_order		:=	l.clean_Business_Address.lot_order	;
	self.clean_business_address.dbpc				:=	l.clean_Business_Address.dbpc	;
	self.clean_business_address.chk_digit		:=	l.clean_Business_Address.chk_digit	;
	self.clean_business_address.rec_type		:=	l.clean_Business_Address.rec_type	;
	self.clean_business_address.county			:=	l.clean_Business_Address.county	;
	self.clean_business_address.geo_lat			:=	l.clean_Business_Address.geo_lat	;
	self.clean_business_address.geo_long		:=	l.clean_Business_Address.geo_long	;
	self.clean_business_address.msa					:=	l.clean_Business_Address.msa	;
	self.clean_business_address.geo_blk			:=	l.clean_Business_Address.geo_blk	;
	self.clean_business_address.geo_match		:=	l.clean_Business_Address.geo_match	;
	self.clean_business_address.err_stat		:=	l.clean_Business_Address.err_stat	;
	self.clean_business_name.title					:=	l.clean_business_name.title;
	self.clean_business_name.fname					:=	l.clean_business_name.fname;
	self.clean_business_name.mname					:=	l.clean_business_name.mname;
	self.clean_business_name.lname					:=	l.clean_business_name.lname;
	self.clean_business_name.name_suffix		:=	l.clean_business_name.name_suffix;
	self.clean_business_name.name_score			:=	l.clean_business_name.name_score;
	self							:=	l;
	self							:=	[];
end;

projectBase  := project(File_6510_Government_Debarred_Contractor_Base_AID, trfBaseToOrig(left));

addGlobalSID := mdr.macGetGlobalSID(projectBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export File_6510_Government_Debarred_Contractor_Base := addGlobalSID;