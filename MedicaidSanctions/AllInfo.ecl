IMPORT Std;
EXPORT AllInfo(DATASET($.Layout_Sanctions) infile) := FUNCTION

/***
	1		DOB 				
	2		Action
	3		Occupation (Cred)

****/		
	{unsigned8 id, $.Layout_XG.layout_addlinfo} 
					xForm($.Layout_Sanctions infile, integer n) := TRANSFORM
		self.type := CHOOSE(n, 
												IF(infile.type_id = 'I' AND infile.DateOfBirth<>'0',
													'DOB',
													SKIP),
												IF(infile.action<>'', 'Action', SKIP),
												IF(infile.cred<>'', 'Occupation', SKIP),
												SKIP);
		self.information := TRIM(CHOOSE(n,
								infile.DateOfBirth,
								infile.action,
								infile.cred,
								SKIP));
		self.parsed := '';
		self.comments := CHOOSE(n,
									'',
									Std.Str.CleanSpaces(
										IF(infile.action_date IN ['','0'], '', 'Action Date: ' + infile.action_date) + ' ' +
										IF(infile.action_start IN ['','0'], '', 'Action Start: ' + infile.action_start) + ' ' +
										IF(infile.fine='', '', 'Fine: ' + infile.fine)
									),
									'');
		self.id := infile.key;
END;

	addlInfo := Normalize(infile(DateOfBirth<>'0' OR action<>'' OR cred<>''), 3, xform(LEFT, COUNTER))(information<>'');
	
	AddlSorted := SORT(DISTRIBUTE(addlInfo, id), id, Type, -parsed, information, comments, LOCAL);
							
	pAddl := 
			project(AddlSorted,					
					transform({unsigned8 id, $.Layout_XG.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, $.Layout_XG.layout_addlinfo); 
					)
				);

	pAddl rollRecs(pAddl L, pAddl R) := transform
		self.id  := L.id;
		self.additionalinfo := L.additionalinfo + row({	TRIM(R.additionalinfo[1].type),
										R.additionalinfo[1].information,
										R.additionalinfo[1].parsed,
										R.additionalinfo[1].comments
						}, $.Layout_XG.layout_addlinfo);
		end;
		
	result := rollup(pAddl, id, rollRecs(left, right),local);

	return result;

END;