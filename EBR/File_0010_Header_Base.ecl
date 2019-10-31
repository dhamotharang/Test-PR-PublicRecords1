import _control, Mdr, Std;

layout_0010_header_base	trfBaseToOrig(layout_0010_header_base_AID	l)	:=	transform
	self.prim_range		:=	l.clean_Address.prim_range	;
	self.predir				:=	l.clean_Address.predir	;
	self.prim_name		:=	l.clean_Address.prim_name	;
	self.addr_suffix	:=	l.clean_Address.addr_suffix	;
	self.postdir			:=	l.clean_Address.postdir	;
	self.unit_desig		:=	l.clean_Address.unit_desig	;
	self.sec_range		:=	l.clean_Address.sec_range	;
	self.p_city_name	:=	l.clean_Address.p_city_name	;
	self.v_city_name	:=	l.clean_Address.v_city_name	;
	self.st						:=	l.clean_Address.st	;
	self.zip					:=	l.clean_Address.zip	;
	self.zip4					:=	l.clean_Address.zip4	;
	self.cart					:=	l.clean_Address.cart	;
	self.cr_sort_sz		:=	l.clean_Address.cr_sort_sz	;
	self.lot					:=	l.clean_Address.lot	;
	self.lot_order		:=	l.clean_Address.lot_order	;
	self.dbpc					:=	l.clean_Address.dbpc	;
	self.chk_digit		:=	l.clean_Address.chk_digit	;
	self.rec_type			:=	l.clean_Address.rec_type	;
	self.county				:=	l.clean_Address.county	;
	self.geo_lat			:=	l.clean_Address.geo_lat	;
	self.geo_long			:=	l.clean_Address.geo_long	;
	self.msa					:=	l.clean_Address.msa	;
	self.geo_blk			:=	l.clean_Address.geo_blk	;
	self.geo_match		:=	l.clean_Address.geo_match	;
	self.err_stat			:=	l.clean_Address.err_stat	;
	self							:=	l;
	self							:=	[];
end;

projectBase  := project(EBR.File_0010_Header_Base_AID, trfBaseToOrig(left));

addGlobalSID := mdr.macGetGlobalSID(projectBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export File_0010_Header_Base := addGlobalSID;