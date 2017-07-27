import  RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::Taxpro::';
dBase 	      := file_base;               


export Key_tmsid := INDEX(dBase  ,{tmsid},{dBase},KeyName+doxie.Version_SuperKey+'::Tmsid');