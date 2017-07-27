export Keys (indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,
						Address_Key,CityStName_Key,Name_Key,NameWords_Key,Phone_Key,FEIN_Key,StName_Key,Zip_Key,
						by_lookup=TRUE,favor_lookup=0,build_skip_set,
						visitorb = 'standard.MStandardBuildb') :=

MACRO


#uniquename(x)
%x% := 1;

// If by_lookup is true the lookup field will not be included in the dedup before the index is defined.  
// The favored lookup bit specifies which lookup to prefer for a given set of otherwise identical records.

visitorb.MAC_Address(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,Address_Key,by_lookup,favor_lookup)
					
visitorb.MAC_CityStName(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,CityStName_Key,by_lookup,favor_lookup,build_skip_set)
					
visitorb.MAC_Name(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,Name_Key,by_lookup,favor_lookup)
						
visitorb.MAC_NameWords(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,NameWords_Key,by_lookup,favor_lookup)
					
visitorb.MAC_Phone(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,Phone_Key,by_lookup,favor_lookup)
				
visitorb.MAC_FEIN(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,FEIN_Key,by_lookup,favor_lookup)
						
visitorb.MAC_StName(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,StName_Key,by_lookup,favor_lookup)
						
visitorb.MAC_Zip(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inlookups,
						inbdid,
						inkeyname,Zip_Key,by_lookup,favor_lookup,build_skip_set) 

ENDMACRO;