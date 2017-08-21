import business_header, doxie, ut, Prte2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
f := Prte2_Business_Header.File_Business_Header_Base_for_keybuild( (prim_name!='' or prim_range!='') and zip!=0 and bdid!=0);
#ELSE
f := Business_Header.File_Business_Header_Base_for_keybuild( (prim_name!='' or prim_range!='') and zip!=0 and bdid!=0);
#END;

export Key_Business_Header_Address := index(f,{zip,prim_range,prim_name,sec_range},
													{bdid,
													source,
													source_group,
													dt_first_seen,
													dt_last_seen,
													dt_vendor_first_reported,
													dt_vendor_last_reported,
													company_name,
													prim_range,
													predir,
													prim_name,
													addr_suffix,
													postdir,
													unit_desig,
													sec_range,
													city,
													state,
													zip,
													zip4,
													county,
													msa,
													geo_lat,
													geo_long,
													phone,
													phone_score,
													fein,
													current,
													dppa},			
										'~thor_data400::key::br_bus_header_address_'+doxie.Version_SuperKey);
										// ut.foreign_dataland + 'thor_data400::key::br_bus_header_address_'+doxie.Version_SuperKey);
