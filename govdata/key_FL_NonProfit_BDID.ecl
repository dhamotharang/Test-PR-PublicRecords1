import doxie, BIPV2;

df := project(govdata.File_FL_NonProfit_Corp (bdid != 0),transform(govdata.Layout_FL_Non_Profit_Corp_base -BIPV2.IDlayouts.l_xlink_IDs,self:=left;));

export key_FL_NonProfit_BDID := index(df,{bdid},{df},'~thor_data400::key::fl_nonprofit_bdid_' + doxie.Version_SuperKey);
