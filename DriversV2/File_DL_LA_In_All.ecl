import lib_stringlib;

DriversV2.Layout_DL_LA_In.Cleaned tConvertOldToNew(DriversV2.Layout_DL_In_CompID_Load pInput)	:=	transform
		self.dt_last_seen							:=	(unsigned8)lib_stringlib.stringlib.stringfilter((string)pInput.dt_last_seen,'0123456789') div 100;
		self.dt_first_seen						:= 	(unsigned8)lib_stringlib.stringlib.stringfilter((string)pInput.dt_first_seen,'0123456789') div 100;
		self.dt_vendor_first_reported	:=	(unsigned8)lib_stringlib.stringlib.stringfilter((string)pInput.dt_vendor_first_reported,'0123456789') div 100;
		self.dt_vendor_last_reported	:=	(unsigned8)lib_stringlib.stringlib.stringfilter((string)pInput.dt_vendor_last_reported,'0123456789') div 100;
		self.name											:=	trim(trim(pInput.last_name,left,right) + ' ' + trim(pINput.first_Name,left,right) + ' ' + trim(pInput.middle_name,left,right));
		self.address									:=	pInput.address_1;
		self.city											:=	pInput.o_city;
		self.state										:=	pInput.o_State;
		self.zipCode									:=	pInput.o_zip;
		self.clean_name_prefix				:=	pInput.title;
		self.clean_name_first					:=	pInput.fname;
		self.clean_name_middle				:=	pInput.mname;
		self.clean_name_last					:=	pInput.lname;
		self.clean_name_suffix				:=	pInput.sname;	
		self.clean_prim_range					:=	pInput.prim_range;
		self.clean_predir							:=	pInput.predir;
		self.clean_prim_name					:=	pInput.prim_name;
		self.clean_addr_suffix				:=	pInput.addr_suffix;
		self.clean_postdir						:=	pInput.postdir;
		self.clean_unit_desig					:=	pInput.unit_desig;
		self.clean_sec_range					:=	pInput.sec_range;
		self.clean_p_city_name				:=	pInput.city;
		self.clean_v_city_name				:=	pInput.city;
		self.clean_st									:=	pInput.st;
		self.clean_zip								:=	pInput.zip;
		self.clean_zip4								:=	pInput.zip4;		
		self													:=	pInput;
		self													:=	[];
end;

dOldAsNew := project(DriversV2.File_DL_In_CompID_Load.LA, tConvertOldToNew(left)); 

export File_DL_LA_IN_All	:=	dOldAsNew	+ DriversV2.File_DL_LA_In_Update;