import ut,TransunionCred, ut;

export Key_Src_TN_prep(boolean pFastHeader = false) := function

d:=TransunionCred.as_source(if(pFastHeader,TransunionCred.Files.Base),~pFastHeader,pFastHeader);

dTransUnionCred_as_Source	:=	project(d
//for contractual reasons with TU dob and phone cannot be displayed in any customer report
																					,transform({d}
																							,self.phone:=''
																							,self.clean_phone:=''
																							,self.Date_of_Birth:=''
																							,self.clean_dob:=0
																							,self:=left));

mac_key_src(dTransUnionCred_as_Source, TransunionCred.Layouts.base, 
						tn_child, 
						ut.Data_Location.Person_header+'thor_data400::key::tn_src_index'+SF_suffix(pFastHeader)+'_',id)
						
return id;
end;