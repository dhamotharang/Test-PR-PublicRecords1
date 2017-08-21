IMPORT ut,Business_HeaderV2;

EXPORT DUNS_To_Ultimate_DUNS(

	 dataset(Layout_DNB_Base	)	pFile_DNB_Base	= Business_HeaderV2.Source_Files.dnb_companies.BusinessHeader	()
	,string											pPersistname		= '~thor_data400::persist::DNB::DUNS_To_Ultimate_DUNS'													

) :=
function

df := pFile_DNB_Base;
du := df(active_duns_number = 'Y', duns_number != '');

du_ded := DEDUP(du, duns_number, 
					ultimate_duns_number, 
					parent_duns_number, 
					headquarters_duns_number, ALL);

// A record may not have an ultimate duns number, but it'll never have
// both a parent and headquarters duns number.
Layout_DUNS_To_Ultimate_DUNS Slim(du_ded l) := TRANSFORM
	SELF.duns_number := (UNSIGNED4) l.duns_number;
	SELF.ultimate_duns_number := (UNSIGNED4) (IF(l.ultimate_duns_number != '',
		l.ultimate_duns_number,
		IF(l.parent_duns_number != '',
			l.parent_duns_number,
			l.headquarters_duns_number)));
END;

du_ultimate_slim := PROJECT(du_ded(ultimate_duns_number != ''), Slim(LEFT));
ultimate_ded := DEDUP(du_ultimate_slim, duns_number, ultimate_duns_number, ALL);

du_child_slim := PROJECT(du_ded(ultimate_duns_number = '',
	parent_duns_number != '' OR headquarters_duns_number != ''), Slim(LEFT));
child_ded := DEDUP(du_child_slim, duns_number, ultimate_duns_number, ALL);

// Attempt to link duns numbers without an ultimate duns number
// via their parent/headquarters duns numbers.  Can't use the standard
// reduce pair techniques because we want the ultimate, not the lowest
// number as the result.
Layout_DUNS_To_Ultimate_DUNS AssignUltimate(
					Layout_DUNS_To_Ultimate_DUNS l, 
					Layout_DUNS_To_Ultimate_DUNS r) := TRANSFORM
	SELF.ultimate_duns_number := r.ultimate_duns_number;
	SELF := l;
END;

Layout_DUNS_To_Ultimate_DUNS TakeLeft(
					Layout_DUNS_To_Ultimate_DUNS l) := TRANSFORM
	SELF := l;
END;
	
parent_ult := JOIN(child_ded, ultimate_ded,
				LEFT.ultimate_duns_number = RIGHT.duns_number,
				AssignUltimate(LEFT, RIGHT), HASH);

child_ded2 := JOIN(child_ded, ultimate_ded,
				LEFT.ultimate_duns_number = RIGHT.duns_number,
				TakeLeft(LEFT),
				LEFT ONLY, HASH);

ultimate_ded2 := DEDUP(ultimate_ded + parent_ult, duns_number, ultimate_duns_number, ALL);

// Go again
grandparent_ult := JOIN(child_ded2, ultimate_ded2,
				LEFT.ultimate_duns_number = RIGHT.duns_number,
				AssignUltimate(LEFT, RIGHT), HASH);

child_ded3 := JOIN(child_ded2, ultimate_ded2,
				LEFT.ultimate_duns_number = RIGHT.duns_number,
				TakeLeft(LEFT),
				LEFT ONLY, HASH);

ultimate_ded3 := DEDUP(ultimate_ded2 + grandparent_ult, duns_number, ultimate_duns_number, ALL);

ultimate_dist := DISTRIBUTE(
	DEDUP(ultimate_ded3 + child_ded3, duns_number, ultimate_duns_number, ALL),
	HASH(duns_number));

DUNS_To_Ultimate_DUNS_persisted := ultimate_dist : PERSIST(pPersistname);

return DUNS_To_Ultimate_DUNS_persisted;

end;