import doxie,ut;
KeyName       := cluster.cluster_out+'Key::infoUSA::DEADCO::';
dBase 		  := TABLE(File_deadco_Base(Bdid>0), {Bdid,ABi_number});



export Key_DEADCO_BDID  := INDEX(dBase  ,{bdid},{ABI_number},
                                        KeyName + Doxie.Version_SuperKey+'::Bdid' );
										
		