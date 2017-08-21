import TransunionCred, data_services;

src_rec := record
	header.layout_Source_ID;
	TransunionCred.Layouts.base
end;

export Key_Src_TN(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

d:=if(pCombo,pDataset,header.Files_SeqdSrc(pFastHeader).TN);

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
						data_services.Data_location.prefix('Source')+'thor_data400::key::tn_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id)
						
return id;
end;