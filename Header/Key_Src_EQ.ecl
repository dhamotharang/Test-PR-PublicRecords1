import ut,eq_hist;

src_rec:=header.layout_header_in;

export Key_Src_EQ(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

EQ_weekly		:=project(header.file_header_in(pFastHeader).eq_uid_weekly,header.layout_header_in);
EQ_monthly	:=header.file_header_in(pFastHeader).eq_uid_monthly;

EQ_as_source := if(pCombo,pDataset
													,if(pFastHeader
														,EQ_monthly + EQ_weekly
														,EQ_monthly + eq_hist.As_Source(,true)));

mac_key_src(EQ_as_source,header.layout_eq_src, 
						eq_child, 
						ut.Data_Location.Person_header+'thor_data400::key::eq_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id)
						
return id;
end;