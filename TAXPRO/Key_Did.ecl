import  RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::Taxpro::';
dBase 	      := file_base(did>0);
                
dSlim		  := TABLE(dBase, {did,tmsid});
dDedup        := dedup(dSlim ,all);

export Key_did := INDEX(dDedup  ,{did},{tmsid},KeyName+doxie.Version_SuperKey+'::did');