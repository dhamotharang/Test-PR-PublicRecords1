import  RoxieKeyBuild,ut,autokey,doxie,BIPV2;

KeyName       := cluster.cluster_out+'Key::Taxpro::';
dBase 	      :=  project(File_Base,transform(Layout.Taxpro_Standard_Base-Bipv2.IDlayouts.l_xlink_ids, self:=left;));              

export Key_tmsid := INDEX(dBase  ,{tmsid},{dBase},KeyName+doxie.Version_SuperKey+'::Tmsid');