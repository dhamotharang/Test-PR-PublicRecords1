import  RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::Taxpro::';
dBase 	      := File_Base(Bdid>0);
                
dSlim		  := TABLE(dBase, {Bdid,tmsid});
dDedup        := dedup(dSlim ,all);

export Key_BDID := INDEX(dDedup  ,{Bdid},{tmsid},KeyName+doxie.Version_SuperKey+'::Bdid');