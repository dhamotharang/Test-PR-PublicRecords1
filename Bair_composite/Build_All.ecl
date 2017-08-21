
import versioncontrol, _control, ut, tools;
export Build_all(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := function

built := sequential(
					 if(pUseDelta,Input_Clear.composite_data_building(pUseProd))
					,if(pUseDelta,Input_Set.composite_data_building(pUseProd))
					,Build_keys.Build_Keys_mo_phone(pversion,pUseProd,pUseDelta).mo_phone_key
					,Build_keys.Build_Keys_mo_eid(pversion,pUseProd,pUseDelta).mo_eid_key	 
					,Build_keys.Build_Keys_mo_v2_phone(pversion,pUseProd,pUseDelta).mo_phone_v2_key
					,Build_keys.Build_Keys_mo_v2_eid(pversion,pUseProd,pUseDelta).mo_eid_v2_key	
					,Build_keys.Build_keys_ext(pversion,pUseDelta).Bair_Ext_keys
					,Build_keys.Build_keys_wdbody(pversion,pUseProd,pUseDelta).wd_body_key	
					,Build_keys.Build_keys_wdmake(pversion,pUseProd,pUseDelta).wd_make_key	
					,Build_keys.Build_keys_wdmodel(pversion,pUseProd,pUseDelta).wd_model_key
					,Build_keys.Build_keys_wdveh(pversion,pUseProd,pUseDelta).wd_veh_key					
					,Build_keys.Build_keys_ext_v2(pversion,pUseDelta).Bair_Ext_keys_v2
					);

return built;
end;

