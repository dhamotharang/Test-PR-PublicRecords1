IMPORT ut;

// Initialize match file
BH_File := Business_Header.BH_Basic_Match_FEIN;

Layout_BH_Match := record
	BH_File.rcid;
	BH_File.bdid;             // Seisint Business Identifier
	BH_File.match_company_name;
	BH_File.match_branch_unit;
	BH_File.match_geo_city;
	BH_File.prim_name;
	BH_File.city;
	BH_File.state;
	BH_File.zip;
	BH_File.phone;
	BH_File.fein;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
	self := L;
end;

BH_Slim := PROJECT(BH_File(prim_name = '' OR zip = 0), InitMatchFile(LEFT));

// Exclude bdids that contain a valid address base record.
Layout_BH_Match TakeRight(Layout_BH_Match r) := TRANSFORM
	SELF := r;
END;

BH_NoAddress1 := JOIN(BH_File(prim_name != '', zip != 0), BH_Slim, 
	LEFT.bdid = RIGHT.bdid,
	TakeRight(RIGHT),
	HASH, RIGHT ONLY);

BH_NoAddress := DISTRIBUTE(BH_NoAddress1, HASH(match_company_name));

// Match Rule 6 - Match Company Name and non-conflicting info into
// one bdid.  Give preference to records with non-blank fields as
// base records - this also keeps the transitive closure stable.
Business_Header.Layout_PairMatch MatchThem(BH_NoAddress l, BH_NoAddress r) := TRANSFORM
	SELF.old_rid := r.bdid;
	SELF.new_rid := l.bdid;
	SELF.pflag := 6;
END;
	
BH_Joined := JOIN(BH_NoAddress, BH_NoAddress,
			LEFT.match_company_name = RIGHT.match_company_name AND
			LEFT.match_geo_city = RIGHT.match_geo_city AND
			LEFT.match_branch_unit = RIGHT.match_branch_unit AND
			(LEFT.prim_name = RIGHT.prim_name OR RIGHT.prim_name = '') AND
			(LEFT.city = RIGHT.city OR RIGHT.city = '') AND
			(LEFT.state = RIGHT.state OR RIGHT.state = '') AND
			(LEFT.zip = RIGHT.zip OR RIGHT.zip = 0) AND
			LEFT.bdid < RIGHT.bdid,
				MatchThem(LEFT, RIGHT), LOCAL);

// No Transitive closure -- take the lowest match.
NoAddr_Matches_Dist := DISTRIBUTE(BH_Joined, HASH(old_rid));
NoAddr_Matches_Sort := SORT(NoAddr_Matches_Dist, old_rid, new_rid, LOCAL);
NoAddr_Matches_Dedup := DEDUP(NoAddr_Matches_Sort, old_rid, LOCAL);

// Patch new BDIDs
ut.MAC_Patch_Id(BH_File, bdid, NoAddr_Matches_Dedup, old_rid, new_rid, BH_File_Patched)

EXPORT BH_Basic_Match_NoAddress := BH_File_Patched
	: PERSIST(persistnames.BHBasicMatchNoAddress);