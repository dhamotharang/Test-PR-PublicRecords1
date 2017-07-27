import  doxie;

KeyName_InternetServices  := Cluster.Cluster_out + 'key::internetservices::';
sf := searchFileDomains;

// Filter to remove empty bdids
dbase := sf(bdid != 0);

export Key_bdid := INDEX(dbase,{unsigned6 bdid := (unsigned6)dbase.bdid},{internetservices_id},
																	KeyName_internetServices+doxie.Version_SuperKey + '::bdid');