/* import lib_stringlib;
   
   DriversV2.Layout_DL_NV_In.Cleaned tConvertOldToNew(DriversV2.Layout_DL_In_CompID_Load pInput)	:=	transform
   		self.dt_last_seen							:=	(unsigned8)lib_stringlib.stringlib.stringfilter((string)pInput.dt_last_seen,'0123456789') div 100;
   		self.dt_first_seen						:= 	(unsigned8)lib_stringlib.stringlib.stringfilter((string)pInput.dt_first_seen,'0123456789') div 100;
   		self.dt_vendor_first_reported	:=	(unsigned8)lib_stringlib.stringlib.stringfilter((string)pInput.dt_vendor_first_reported,'0123456789') div 100;
   		self.dt_vendor_last_reported	:=	(unsigned8)lib_stringlib.stringlib.stringfilter((string)pInput.dt_vendor_last_reported,'0123456789') div 100;
   		self.dln											:=	pInput.dl_nbr;
   		self.lst_name									:=	pInput.last_name;
   		self.fst_name									:=	pInput.first_name;
   		self.mid_name									:=	pInput.middle_name;
   		self.perm_cd_1								:=	pInput.license_type[1..2];
   		self.perm_cd_2								:=	pInput.license_type[3..4];
   		self.perm_cd_3								:=	pInput.license_type[5..6];
   		self.perm_cd_4								:=	pInput.license_type[7..8];
   		self.m_addr										:=	pInput.address_1;
   		self.m_city										:=	pInput.o_city;
   		self.m_state									:=	pInput.o_State;
   		self.m_zip										:=	pInput.o_zip;
   		self.clean_name_prefix				:=	pInput.title;
   		self.clean_name_first					:=	pInput.fname;
   		self.clean_name_middle				:=	pInput.mname;
   		self.clean_name_last					:=	pInput.lname;
   		self.clean_name_suffix				:=	pInput.sname;	
   		self.clean_m_prim_range				:=	pInput.prim_range;
   		self.clean_m_predir						:=	pInput.predir;
   		self.clean_m_prim_name				:=	pInput.prim_name;
   		self.clean_m_addr_suffix			:=	pInput.addr_suffix;
   		self.clean_m_postdir					:=	pInput.postdir;
   		self.clean_m_unit_desig				:=	pInput.unit_desig;
   		self.clean_m_sec_range				:=	pInput.sec_range;
   		self.clean_m_p_city_name			:=	pInput.city;
   		self.clean_m_v_city_name			:=	pInput.city;
   		self.clean_m_st								:=	pInput.st;
   		self.clean_m_zip							:=	pInput.zip;
   		self.clean_m_zip4							:=	pInput.zip4;		
   		self													:=	pInput;
   		self													:=	[];
   end;
   
   dOldAsNew := project(DriversV2.File_DL_In_CompID_Load.NV, tConvertOldToNew(left)); 
*/
//old inputs -deprecating !!due to build enhancements & only processing Current updates
//export File_DL_NV_IN_All	:=	dOldAsNew	+ DriversV2.File_DL_NV_In_Update; 
export File_DL_NV_IN_All	:= DriversV2.File_DL_NV_In_Update;//Current update 

