// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
export CorpsSearchService := macro

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#constant('getBdidsbyExecutive',FALSE);
	#Constant('SetRepAddr',TRUE);
	#stored('SetRepAddrBit',4);


	// output(corp2_services.CorpSearch, named('Results'));

	recs := corp2_services.CorpSearch(isCorpSearchService := TRUE);


orec := record
   RECORDOF(recs);
   Text_Search.Layout_ExternalKey;
END;
orec addExt ( recs l) := transform
  self := l;
	self.ExternalKey := l.corp_key;
end;
recs2 := project(recs, addext(left));



	doxie.MAC_Header_Field_Declare()
	doxie.MAC_Marshall_Results(recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));

endmacro;
