import autokeyb2;

export MAutokeyb := 
MODULE

	export MAC_Address(indataset,inbname,
							infein,
							phone,
							inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
							inlookups,
							inbdid,
							inkeyname,Address_Key,by_lookup,favor_lookup) :=
	macro
		CanadianPhones.MAC_Address_Canb(indataset,inbname,
								infein,
								phone,
								inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
								inlookups,
								inbdid,
								inkeyname,Address_Key,by_lookup,favor_lookup);
	endmacro;					
	export MAC_CityStName(indataset,inbname,
							infein,
							phone,
							inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
							inlookups,
							inbdid,
							inkeyname,CityStName_Key,by_lookup,favor_lookup,build_skip_set) :=
	macro					
		autokeyb2.MAC_CityStName(indataset,inbname,
								infein,
								phone,
								inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
								inlookups,
								inbdid,
								inkeyname,CityStName_Key,by_lookup,favor_lookup,build_skip_set);
	endmacro;					
	export MAC_Name(indataset,inbname,
							infein,
							phone,
							inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
							inlookups,
							inbdid,
							inkeyname,Name_Key,by_lookup,favor_lookup) :=
	macro
		autokeyb2.MAC_Name(indataset,inbname,
								infein,
								phone,
								inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
								inlookups,
								inbdid,
								inkeyname,Name_Key,by_lookup,favor_lookup);
	endmacro;					
	export MAC_NameWords(indataset,inbname,
							infein,
							phone,
							inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
							inlookups,
							inbdid,
							inkeyname,NameWords_Key,by_lookup,favor_lookup) :=
	macro					
		autokeyb2.MAC_NameWords(indataset,inbname,
								infein,
								phone,
								inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
								inlookups,
								inbdid,
								inkeyname,NameWords_Key,by_lookup,favor_lookup);		
	endmacro;
	export MAC_Phone(indataset,inbname,
							infein,
							phone,
							inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
							inlookups,
							inbdid,
							inkeyname,Phone_Key,by_lookup,favor_lookup) :=
	macro				
		autokeyb2.MAC_Phone(indataset,inbname,
								infein,
								phone,
								inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
								inlookups,
								inbdid,
								inkeyname,Phone_Key,by_lookup,favor_lookup);
	endmacro;				
	export MAC_FEIN(indataset,inbname,
							infein,
							phone,
							inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
							inlookups,
							inbdid,
							inkeyname,FEIN_Key,by_lookup,favor_lookup) :=
	macro						
		autokeyb2.MAC_FEIN(indataset,inbname,
								infein,
								phone,
								inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
								inlookups,
								inbdid,
								inkeyname,FEIN_Key,by_lookup,favor_lookup);
	endmacro;						
	export MAC_StName(indataset,inbname,
							infein,
							phone,
							inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
							inlookups,
							inbdid,
							inkeyname,StName_Key,by_lookup,favor_lookup) :=
	macro						
		autokeyb2.MAC_StName(indataset,inbname,
								infein,
								phone,
								inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
								inlookups,
								inbdid,
								inkeyname,StName_Key,by_lookup,favor_lookup);
	endmacro;						
	export MAC_Zip(indataset,inbname,
							infein,
							phone,
							inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
							inlookups,
							inbdid,
							inkeyname,Zip_Key,by_lookup,favor_lookup,build_skip_set) :=
	macro						
		CanadianPhones.MAC_Zip_Canb(indataset,inbname,
								infein,
								phone,
								inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
								inlookups,
								inbdid,
								inkeyname,Zip_Key,by_lookup,favor_lookup,build_skip_set); 
	endmacro;
END;