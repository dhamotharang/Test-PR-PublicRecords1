export file_SearchBidAutokey := function

	base := PROJECT(GSA.File_GSA_Base,
	                TRANSFORM(GSA.Layouts_GSA.layout_Base_Old, SELF.bdid := LEFT.Bid, SELF := LEFT));
	
	gsa.Layouts_GSA.layout_AutoKeys_Old bldKeys(base input) := transform
		self := input;
		end;
		
	akds := project(base,bldKeys(left));
	
	return akds;
	
end;	
