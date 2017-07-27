export Keys (indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,
						Address_Key,CityStName_Key,Name_Key,NameWords_Key,Phone_Key,FEIN_Key,StName_Key,Zip_Key) :=

MACRO


#uniquename(x)
%x% := 1;



AutokeyB.MAC_Address(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,Address_Key)
					
AutokeyB.MAC_CityStName(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,CityStName_Key)
					
AutokeyB.MAC_Name(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,Name_Key)
						
AutokeyB.MAC_NameWords(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,NameWords_Key)
						
AutokeyB.MAC_Phone(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,Phone_Key)
						
AutokeyB.MAC_FEIN(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,FEIN_Key)
						
AutokeyB.MAC_StName(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,StName_Key)
						
AutokeyB.MAC_Zip(indataset,inbname,
						infein,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						inbdid,
						inkeyname,Zip_Key)

ENDMACRO;