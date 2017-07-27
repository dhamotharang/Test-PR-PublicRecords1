// Initialize match file
BH_File := Business_Header.BH_Basic_Match_FEIN;

// Any additional clean up code goes here

EXPORT BH_Basic_Match_Clean := BH_File : 
					PERSIST('TEMP::BH_Basic_Match_Clean');
					
/*
business_header.Layout_Business_Header_Temp wtf(business_header.Layout_Business_Header_Base l) := transform
	self.match_branch_number := '';
	self.match_branch_position := 0;
	self.match_branch_unit_desig := '';
	self.match_branch_unit := '';
	self := l;
end;
 
 // JUST A TEMP WAY FOR ME TO REBUILD RELS WITHOUT A HEADACHE

EXPORT BH_Basic_Match_Clean := project(Business_Header.File_Business_Header, wtf(left));
*/