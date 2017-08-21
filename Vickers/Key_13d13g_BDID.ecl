Import Data_Services, doxie, BIPV2;

df := project(file_13d13g_base(bdid != 0),transform(layout_13d13g_base -BIPV2.IDlayouts.l_xlink_ids ,self:=left;));

export Key_13d13g_BDID := index(df,{bdid},{df},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::vickers_13d13g_bdid_' + doxie.Version_SuperKey);
