export GetJurisdictions (DATASET(Layout_BuildFax.streetlookup_key_rec) addrs) := FUNCTION   
	streetLookupRslts := KeyedJoins.GetStreetLookupRecs(addrs);
	streetLookupRecs  := PROJECT(streetLookupRslts,Layout_BuildFax.jurisdiction_key_rec);
	jurisdictionRecs  := KeyedJoins.GetJurisdictionRecs(streetLookupRecs);
	cleanJurisdictions := PROJECT(jurisdictionRecs,
	                              TRANSFORM(recordof(left),
                                          self.JurisdictionName := REGEXREPLACE('\r\n',left.JurisdictionName,' ');
																          self.OfficialName := REGEXREPLACE('\r\n',left.OfficialName,' ');
																					self.streetaddress := REGEXREPLACE('\r\n',left.streetaddress,' ');
																					self := left));
	return cleanJurisdictions;
end;