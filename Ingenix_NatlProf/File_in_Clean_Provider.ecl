import Ingenix_NatlProf, lib_stringlib, address;

File_in := Ingenix_NatlProf.File_in_provider_joined;


Ingenix_NatlProf.Layout_in_Clean_Provider  tcleaning(file_in L):= transform


self.Prov_Clean_title						:= L.clean_name[1..5]			    ;
self.Prov_Clean_fname						:= L.clean_name[6..25]			;
self.Prov_Clean_mname						:= L.clean_name[26..45]			;
self.Prov_Clean_lname						:= L.clean_name[46..65]			;
self.Prov_clean_name_suffix	   				:= L.clean_name[66..70]			;
self.Prov_Clean_cleaning_score				:= L.clean_name[71..73]			;
self.prov_Clean_prim_range 		            := 		L.clean_address[1..10]				;
self.prov_Clean_predir     		:=		L.clean_address[11..12]				;
self.prov_Clean_prim_name			:= 		L.clean_address[13..40]				;
self.prov_Clean_addr_suffix		:= 		L.clean_address[41..44]				;
self.prov_Clean_postdir				:=		L.clean_address[45..46]				;
self.prov_Clean_unit_desig			:= 		L.clean_address[47..56]				;
self.prov_Clean_sec_range				:= 		L.clean_address[57..64]				;
self.prov_Clean_p_city_name			:= 		L.clean_address[65..89]				;
self.prov_Clean_v_city_name			:= 		L.clean_address[90..114]				;
self.prov_Clean_st					:= 		L.clean_address[115..116]			;
self.prov_Clean_zip					:=		L.clean_address[117..121]			;
self.prov_Clean_zip4					:=		L.clean_address[122..125]			;
self.prov_Clean_cart					:=		L.clean_address[126..129]			;
self.prov_Clean_cr_sort_sz			:=		L.clean_address[130]					;
self.prov_Clean_lot					:=		L.clean_address[131..134]			;
self.prov_Clean_lot_order				:=		L.clean_address[135]					;
self.prov_Clean_dpbc					:=		L.clean_address[136..137]			;
self.prov_Clean_chk_digit				:=		L.clean_address[138]					;
self.prov_Clean_record_type			:=		L.clean_address[139..140]			;
self.prov_Clean_ace_fips_st			:=		L.clean_address[141..142]			;
self.prov_Clean_fipscounty			:=		L.clean_address[143..145]			;
self.prov_Clean_geo_lat				:=		L.clean_address[146..155]			;
self.prov_Clean_geo_long				:=		L.clean_address[156..166]			;
self.prov_Clean_msa					:=		L.clean_address[167..170]			;
self.prov_Clean_geo_match				:=		L.clean_address[178]					;
self.prov_Clean_err_stat				:=		L.clean_address[179..182]		;
self                                        := L                            ;
end;


export File_in_Clean_Provider := project(file_in, tcleaning(left));







