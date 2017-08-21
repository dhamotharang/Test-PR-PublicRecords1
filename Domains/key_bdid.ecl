import  doxie,Bipv2;

KeyName_InternetServices  := Cluster.Cluster_out + 'key::internetservices::';
sf := PROJECT(searchFileDomains, TRANSFORM(RECORDOF(searchFileDomains) - BIPV2.IDlayouts.l_xlink_ids -source_rec_id, SELF := LEFT));

// Filter to remove empty bdids
dbase := sf(bdid != 0);

export Key_bdid := INDEX(dbase,{unsigned6 bdid := (unsigned6)dbase.bdid},{internetservices_id},
																	KeyName_internetServices+doxie.Version_SuperKey + '::bdid');