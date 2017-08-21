import doxie,ut,Bipv2;

df := PROJECT(domains.searchFileDomains, TRANSFORM(RECORDOF(searchFileDomains) - BIPV2.IDlayouts.l_xlink_ids -source_rec_id, SELF := LEFT));
KeyName_InternetServices  := Cluster.Cluster_out + 'key::internetservices::';

export key_id := index(df,{internetservices_id},{df},
		KeyName_InternetServices  + doxie.Version_SuperKey + '::id');