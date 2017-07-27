import iesp, doxie, Images_V2;
EXPORT ReportRecords(DATASET(doxie.layout_references) in_did,
										 BOOLEAN sexualOffenderOnly = FALSE) := FUNCTION;

	crimImagesByDid := Raw.getCrimImagesByDid(in_did);
	SOImagesByDid := Raw.getSOImagesByDid(in_did);
	combinedRecs := IF(sexualOffenderOnly, SOImagesByDid, crimImagesByDid + SOImagesByDid);

	iesp.criminalimagereport.t_CriminalImageRecord assignrecs(Images_V2.Layout_Common L, INTEGER C) := transform
		self.UniqueID := INTFORMAT(L.did,12,1);
		self.Identifier := L.id;
		self._Type := L.rtype;
		self.Date := iesp.ECL2ESP.toDatestring8(L.date);
		self.state := L.state;
		self.Image := L.photo;
		self.SequenceNumber := C;
		self := L;
	end;

	finalRecs := project(sort(combinedRecs,did,-date,id,rtype,state), assignrecs(left, COUNTER));
		
	return finalRecs;
END;