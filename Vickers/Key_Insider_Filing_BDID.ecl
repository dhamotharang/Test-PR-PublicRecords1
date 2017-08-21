Import Data_Services, doxie,BIPV2;

df := project(vickers.File_Insider_Filing_Base(bdid != 0),transform(layout_insider_filing_base -BIPV2.IDlayouts.l_xlink_ids ,self:=left;));

export Key_Insider_Filing_BDID := index(df,{bdid},{df},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::vickers_insider_filing_bdid_' + doxie.Version_SuperKey);
