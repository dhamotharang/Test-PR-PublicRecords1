import doxie, BIPV2;

df := project(govdata.file_fl_fbn_base (bdid != 0),transform(govdata.layout_fl_fbn_base - BIPV2.IDlayouts.l_xlink_IDs,self:=left;));

export Key_FL_FBN_BDID := index(df,{bdid},{df},'~thor_data400::key::fl_fbn_bdid_' + doxie.Version_SuperKey);
