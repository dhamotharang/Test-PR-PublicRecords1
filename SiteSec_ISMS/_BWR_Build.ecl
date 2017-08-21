pversion    := '20110216';
// pversion    := '20110329';
// pversion    := '20110527';
// pversion    := '20110624';
// pversion    := '20110810';
// pversion    := '20110927';
// pversion    := '20111007';
// pversion    := '20111121';
     
directory := '/hds_180/SIM/SiteSecISMS/' + pversion;

#workunit('name', 'SiteSec_ISMS Build ' + pversion);
SiteSec_ISMS.Build_All(pversion).all;