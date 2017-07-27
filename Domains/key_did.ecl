import  doxie;

KeyName_InternetServices  := Cluster.Cluster_out + 'key::internetservices::';
sf := searchFileDomains;

// Filter to remove empty dids
dbase := sf(did != 0);

export Key_did := INDEX(dbase,{unsigned6 did := (unsigned6)dbase.did},{internetservices_id},
																	KeyName_internetServices+ doxie.Version_SuperKey+'::did');