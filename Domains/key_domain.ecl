import  doxie;

KeyName_InternetServices  := Cluster.Cluster_out + 'key::internetservices::';
sf := searchFileDomains;

// Filter to remove empty domain_name data fields
dbase := sf(domain_name != '');

export Key_domain := INDEX(dbase,{string45 domain_name := dbase.domain_name}, {internetservices_id},
																	KeyName_InternetServices  + doxie.Version_SuperKey + '::domain');