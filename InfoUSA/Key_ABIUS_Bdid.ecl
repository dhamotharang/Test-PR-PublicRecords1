import doxie,ut;
KeyName       := cluster.cluster_out+'Key::infoUSA::ABIUS::';
dBase 		  := TABLE(InfoUSA.File_ABIUS_Company_Base(Bdid>0), {Bdid,ABi_number});



export Key_ABIUS_Bdid  := INDEX(dBase  ,{bdid},{ABI_number},
                                        KeyName + Doxie.Version_SuperKey+'::Bdid' );