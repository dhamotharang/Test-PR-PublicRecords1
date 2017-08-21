import doxie, tools,bair;

export Keys(string pversion='',boolean pUseProd =false, boolean pUseDelta = false

) :=
module

	shared mo_phone_parse_v2 := Standardize_input(pversion,pUseProd,pUseDelta).MO_PHONE;
	
	mo_phone_parse_temp			:= RECORD
	bair_composite.layouts.Phone_Parse  -[Iscurrent];
	END;
	
	shared mo_phone_parse		:= Project(mo_phone_parse_v2,transform(mo_phone_parse_temp,self:=left));

	shared wd_make_base		:= Standardize_input(pversion,pUseProd,pUseDelta).VEH_WD_MAKE;
	
	shared wd_body_base 	:= Standardize_input(pversion,pUseProd,pUseDelta).VEH_WD_BODY;
	
	shared wd_model_base	:= Standardize_input(pversion,pUseProd,pUseDelta).VEH_WD_MODEL;
	
	shared wd_veh_base		:= Standardize_input(pversion,pUseProd,pUseDelta).VEH_WD_HOLE;
	
	
	tools.mac_FilesIndex('mo_phone_parse	,	{eid}	 ,	{mo_phone_parse}'	,keynames(pversion,pUseProd,pUseDelta).mo_eid_key	,mo_eid);
	tools.mac_FilesIndex('mo_phone_parse	,	{phone}	 ,	{mo_phone_parse}'	,keynames(pversion,pUseProd,pUseDelta).mo_phone_key	,mo_phone);
	
	tools.mac_FilesIndex('mo_phone_parse_v2	,	{eid}	 ,	{mo_phone_parse_v2}'	,keynames(pversion,pUseProd,pUseDelta).mo_eid_v2_key	,mo_v2_eid);
	tools.mac_FilesIndex('mo_phone_parse_v2	,	{phone}	 ,	{mo_phone_parse_v2}'	,keynames(pversion,pUseProd,pUseDelta).mo_phone_v2_key	,mo_v2_phone);
	
	tools.mac_FilesIndex('wd_make_base	,	{wd_make}	 				,	{wd_make_base}'		,keynames(pversion,pUseProd,pUseDelta).wd_make_key	,wd_make);
	
	tools.mac_FilesIndex('wd_body_base	,	{wd_bodystyle,i}	,	{wd_body_base}'		,keynames(pversion,pUseProd,pUseDelta).wd_body_key	,wd_body);
	
	tools.mac_FilesIndex('wd_model_base	,	{wd_model}				,	{wd_model_base}'	,keynames(pversion,pUseProd,pUseDelta).wd_model_key	,wd_model);
		
	tools.mac_FilesIndex('wd_veh_base		,	{wd_MAKE_CODE, wd_MODEL_description, wd_COLOR_CODE, wd_state_code, wd_zip, wd_body_code}	,	{wd_veh_base}'		,keynames(pversion,pUseProd,pUseDelta).wd_veh_key		,wd_veh);
	
end;
