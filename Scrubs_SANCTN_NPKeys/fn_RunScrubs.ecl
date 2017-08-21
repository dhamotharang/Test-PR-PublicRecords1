import scrubs,scrubs_sanctn_npkeys,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

return sequential(
scrubs.ScrubsPlus('SANCTN_NPKeys','Scrubs_SANCTN_NPKeys','Scrubs_SANCTN_NPKeys_incident_bip','incident_bip',pVersion,emailList,false),
scrubs.ScrubsPlus('SANCTN_NPKeys','Scrubs_SANCTN_NPKeys','Scrubs_SANCTN_NPKeys_party_aka_dba','party_aka_dba',pVersion,emailList,false),
scrubs.ScrubsPlus('SANCTN_NPKeys','Scrubs_SANCTN_NPKeys','Scrubs_SANCTN_NPKeys_party_text','party_text',pVersion,emailList,false),
scrubs.ScrubsPlus('SANCTN_NPKeys','Scrubs_SANCTN_NPKeys','Scrubs_SANCTN_NPKeys_incident_text','incident_text',pVersion,emailList,false),
scrubs.ScrubsPlus('SANCTN_NPKeys','Scrubs_SANCTN_NPKeys','Scrubs_SANCTN_NPKeys_incident_codes','incident_codes',pVersion,emailList,false),
scrubs.ScrubsPlus('SANCTN_NPKeys','Scrubs_SANCTN_NPKeys','Scrubs_SANCTN_NPKeys_party_bip','party_bip',pVersion,emailList,false)
);

end;