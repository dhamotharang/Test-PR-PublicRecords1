import doxie,ut;

df := domains.searchFileDomains;
KeyName_InternetServices  := Cluster.Cluster_out + 'key::internetservices::';

export key_id := index(df,{internetservices_id},{df},
		KeyName_InternetServices  + doxie.Version_SuperKey + '::id');