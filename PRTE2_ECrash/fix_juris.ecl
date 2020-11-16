EXPORT fix_juris(infile, parse_field, rid_field) := FUNCTIONMACRO
IMPORT std;

PATTERN alphanum := PATTERN('[A-Za-z0-9]');
PATTERN ws := [' ','\t']+;

PATTERN police := ['ACCIDENT PD ', 'CITY PD ', 'METRO POLICE ', 'METRO POLICE DEPT ', 
									 'METROPOLITAN POLIC ', 'METROPOLITAN POLICE ', 'METROPOLITAN POLICE D ', 
									 'METROPOLITAN POLICE DEPART ', 'PD PD ', 'POLICE ', 'POLICE DE ', 'POLICE DEPARTM ', 
									 'POLICE DEPARTME ', 'POLICE DEPARTMEN ', 'POLICE DEPARTMENT ', 'POLICE DEPT ', 'DEPARTME '];

PATTERN sheriff := ['COUNTY SHER ', 'COUNTY SHERIF ', 'COUNTY SHERIFF ', 'COUNTY SHERIFF OFFIC ', 
										'COUNTY SHERIFF OFFICE ', 'SHERIFFS OFFICE ', 'COUNTY SHERIFFS OFFICE ', 'COUNTY SHERIFF S ', 
										'COUNTY SHERIFF SO ', 'COUNTY SO ', 'SHERIFF ', 'SHERIFF SO ', 'SO ', 'SO SO', 'PARISH PD '];

PATTERN county_pd := ['COUNTY CO PD ', 'COUNTY PD ', 'COUNTY PD CO PD ',  'COUNTY PD PD ', 'COUNTY POLICE DEPT  ', 
											'COUNTY POLICE DEP ', 'COUNTY POLICE DEP ', 'COUNTY POLICE DEPART ', 'COUNTY POLICE DEPARTM ', 
											'COUNTY POLICE DEPARTME ', 'COUNTY POLICE DEPARTMEN ', 'COUNTY POLICE DEPARTMENT ',  'PD CO PD '];
											
PATTERN fire := ['FIRE DEPT ', 'TOWNSHIP FD ', 'TOWNSHIP FIRE ', 'TOWNSHIP FIRE DEPT ', 'TWSP FD '];

PATTERN twp := ['TOWNSHIP PD ', 'TOWNSHIP POLICE ', 'TOWNSHIP POLICE DEPT ', 'TWSP PD ', 'TOWNSHIP POLICE DEPARTMENT '];

PATTERN hwy := ['CHP ', 'DEPARTMENT OF PUBLIC S ', 'DEPARTMENT OF PUBLIC SAFETY ', 'DEPT OF PUBLIC SAFETY ', 
								'PUBLIC SAFETY ', 'FHP ', 'FHPD ', 'FLHP ',
								'HIGHWAY PATROL ', 'HIGHWAY PATROL H', 'HP HP ', 'HWY PATROL ', 'HWY PATROL HP ', 'OHP ', 'PATR ',
								'STATE HIGHWAY PATROL ', 'STATE HP ', 'STATE PATROL ', 'STATE PATROL HP ', 'STATE POLICE ', 
								'STATE POLICE DEP ', 'STATE POLICE DEPT ', 'STATE POLICE DEPA ', 'STATE POLICE DEPART ',
								'STATE POLICE DEPARTM ','STATE POLICE DEPARTME ', 'STATE POLICE DEPARTMEN ', 'STATE POLICE DEPARTMENT ',
								'STATE POLICE HP ', 'STATE TCPS ', 'STATE TROOPER ', 'STATE TROOPERS ', 'STATE TROOPERS HP ', 
								'TROOPER HP ', 'TROOPERS '];

PATTERN replace_term := police OR
												sheriff OR
												county_pd OR
												fire OR
												twp OR
												hwy;
												
PATTERN reg_term := alphanum+  PENALTY(5);

PATTERN p1 := replace_term;
PATTERN p2 := reg_term;

RULE R1 := p1 OR p2;

inlayout := recordof(infile);

// strip punctuation first -- may need more of these, may need to reconsider if this causes 
// mismatches when comparing to cru_jurisdiction
inlayout prep(inlayout le) := TRANSFORM
	self.parse_field := STD.STR.FilterOut(le.parse_field, '.\'');
	self := le;
END;

prepped := project(infile, prep(LEFT));

inlayout trans(inlayout le) := TRANSFORM
	SELF.parse_field := MAP(
													 MATCHED(p1/police) => 'PD',
													 MATCHED(p1/sheriff) => 'CO SO',
													 MATCHED(p1/county_pd) => 'CO PD',
													 MATCHED(p1/fire) => 'FD',
													 MATCHED(p1/twp) => 'TWP PD',
													 MATCHED(p1/hwy) => 'HP',
													 MATCHED(p2) => MATCHTEXT(p2), 
													 '');
	SELF := le;
END;

outfile := PARSE(prepped, parse_field, R1, trans(LEFT), MAX, MANY, NOT MATCHED);
grpd := group(outfile, rid_field, local);

inlayout concat(grpd le, grpd ri) := transform
	self.parse_field := TRIM(le.parse_field) + ' ' + TRIM(ri.parse_field);
	self := le;
end;

rolled := ungroup(rollup(grpd, true, concat(LEFT, RIGHT)));
return rolled;

endmacro;