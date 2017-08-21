import  doxie,Bipv2;

KeyName_InternetServices  := Cluster.Cluster_out + 'key::internetservices::';
sf := PROJECT(searchFileDomains, TRANSFORM(RECORDOF(searchFileDomains) - BIPV2.IDlayouts.l_xlink_ids -source_rec_id, SELF := LEFT));

// Filter to remove empty dids
dbase := sf(did != 0);

export Key_did := INDEX(dbase,{unsigned6 did := (unsigned6)dbase.did},{internetservices_id},
																	KeyName_internetServices+ doxie.Version_SuperKey+'::did');