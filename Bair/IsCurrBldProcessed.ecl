EXPORT IsCurrBldProcessed(string version, boolean pDelta = false) := function

	BuiltVers := if(pDelta
												,dataset(bair.Superfile_List().DeltaBuiltvers, bair.layouts.rBuiltVers, flat, opt)
												,dataset(bair.Superfile_List().FullBuiltvers, bair.layouts.rBuiltVers, flat, opt)
											);
	
	return if(count(BuiltVers(ver = version)) > 0, true, false);
	
END;