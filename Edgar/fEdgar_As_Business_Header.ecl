IMPORT Business_Header, ut,mdr;

export fEdgar_As_Business_Header(dataset(Layout_Edgar_Company_BIP) pEdgarBase) :=
function

	EdgarCompanies := pEdgarBase;
	//EdgarCompanies := CHOOSEN(File_Edgar_Company_Base, 1000);

	Layout_temp := RECORD
		UNSIGNED8 rcid := 0;
		Layout_Edgar_Company_BIP;
	END;

	// Append id field to edgar company records.
	Layout_temp AddField(Layout_Edgar_Company_BIP l) := TRANSFORM
		SELF := l;
	END;

	Edgar_exp := PROJECT(EdgarCompanies, AddField(LEFT));

	// Sequence the records.
	Edgar_distrib := DISTRIBUTE(Edgar_exp, HASH(cikcode));
	ut.MAC_Sequence_Records(Edgar_distrib, rcid, Edgar_seq)

	// Split each record into two: One for business,
	// one for mailing address.
	MAC_Edgar_Normalize(Edgar_seq, NormedEdgar)

	// Remove records with a blank address.
	EdgarWithAddress := DISTRIBUTE(NormedEdgar(zip5 <> ''), HASH(rcid));

	// $REVIEW: Should also probably filter out records with sic code = 6189,
	// 90+% of which are not companies but certificates.

	// Merge business & mail records where the address is the same
	// and the phone is either the same or one is missing.
	Layout_Edgar_Company_Single_Address RollupAddress(
			Layout_Edgar_Company_Single_Address l, 
			Layout_Edgar_Company_Single_Address r) := TRANSFORM
		SELF.phone10 := IF(l.phone10 = '', r.phone10, l.phone10);
		SELF := l;
	END;

	EdgarRolled := ROLLUP(EdgarWithAddress,
		LEFT.rcid = RIGHT.rcid AND
		LEFT.prim_name = RIGHT.prim_name AND
		LEFT.prim_range = RIGHT.prim_range AND
		LEFT.zip5 = RIGHT.zip5 AND
		ut.NNEQ(LEFT.phone10, RIGHT.phone10),
		RollupAddress(LEFT, RIGHT), LOCAL);

	// Use the rcid as the source group for business headers, but first
	// 0-out rcids whose pair we just removed due to blank or identical
	// addresses.
	Layout_Edgar_Company_Single_Address FindPair(
			Layout_Edgar_Company_Single_Address l, 
			Layout_Edgar_Company_Single_Address r) := TRANSFORM
		SELF.rcid := r.rcid;
		SELF := l;
	END;

	EdgarWithGroupID := JOIN(	EdgarRolled,
								EdgarRolled,
								LEFT.rcid = RIGHT.rcid 
									AND LEFT.addr_type != RIGHT.addr_type,
								FindPair(LEFT, RIGHT),
								LEFT OUTER, LOCAL);

	unsigned4 CvtFiscalYear(string4 mmdd) :=
				  (unsigned4)((integer)((StringLib.GetDateYYYYMMDD())[1..4]) * 10000 + (integer)(mmdd));

	// Project to business header layout
	Business_Header.Layout_Business_Header_New EdgarToBH(
			Layout_Edgar_Company_Single_Address l) := TRANSFORM
		SELF.source := MDR.sourceTools.src_Edgar;
		SELF.source_group := L.cikcode;
		SELF.rcid := 0;
		SELF.group1_id := l.rcid;
		SELF.vl_id := l.accNumber;
		SELF.vendor_id := l.accNumber;
		SELF.dt_first_seen := (unsigned4)Version_Edgar_Company;
		SELF.dt_last_seen := (unsigned4)Version_Edgar_Company;
		SELF.dt_vendor_first_reported := if(l.fiscalyear <> '',
											if((integer)((StringLib.GetDateYYYYMMDD())[5..6]) <= (integer)(l.fiscalyear[1..2]),
												CvtFiscalYear(l.fiscalyear[1..4]) -10000,
												 CvtFiscalYear(l.fiscalyear[1..4])),
											(unsigned4)Version_Edgar_Company);
		SELF.dt_vendor_last_reported := if(l.fiscalyear <> '',
											if((integer)((StringLib.GetDateYYYYMMDD())[5..6]) <= (integer)(l.fiscalyear[1..2]),
												CvtFiscalYear(l.fiscalyear[1..4]) -10000,
												 CvtFiscalYear(l.fiscalyear[1..4])),
											(unsigned4)Version_Edgar_Company);
		SELF.company_name := l.companyName;
		SELF.phone := (UNSIGNED6) ((UNSIGNED8) l.phone10);
		SELF.phone_score := IF((UNSIGNED8) l.phone10 = 0, 0, 1);
		SELF.city := l.v_city_name;
		SELF.state := l.st;
		SELF.fein := (UNSIGNED4) l.taxid;
		SELF.current := true; // $NYI
		SELF.zip := (UNSIGNED3) l.zip5;
		SELF.zip4 := (UNSIGNED2) l.zip4;
		SELF.county := l.county[3..5];
		SELF := l;
	END;

	Edgar_As_BH := PROJECT(EdgarWithGroupID, EdgarToBH(LEFT));
	return Edgar_As_BH;

end;