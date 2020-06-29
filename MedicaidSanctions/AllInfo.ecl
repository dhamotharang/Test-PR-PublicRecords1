IMPORT Std;
EXPORT AllInfo(DATASET($.Layout_Sanctions) infile) := FUNCTION

/***
	1		DOB 				
	2		Occupation (Cred)
	3		Action
NOTE: Action is being moved to comments
The code is included here in case it moves back to additional info
****/		


	{unsigned8 id, $.Layout_XG.layout_addlinfo} 
					xForm($.Layout_Sanctions infile, integer n) := TRANSFORM
		self.type := CHOOSE(n, 
												IF(infile.type_id = 'I' AND infile.DateOfBirth<>'0',
													'DOB',
													SKIP),
												IF(infile.cred<>'', 'Occupation', SKIP),
												/*IF(infile.action<>'' OR 
													infile.action_date not in ['','0'] or infile.action_start not in ['','0'] or 
																				infile.action_end not in ['','0'] or infile.fine <>'',
																	'Incident', SKIP),*/
												SKIP);
		self.information := TRIM(CHOOSE(n,
								infile.DateOfBirth,
								infile.cred,
								infile.action,
								SKIP));
		self.parsed := Choose(n,
										IF(infile.type_id = 'I' AND infile.DateOfBirth<>'0',Std.Date.ConvertDateFormat(infile.DateOfBirth,'%Y%m%d',	'%Y/%m/%d'),''),
										'',
										'',
										''),
		self.comments := CHOOSE(n,
									'',
									'',
									Std.Str.CleanSpaces(
										IF(infile.action_date IN ['','0'], '', 'Action Date: ' + infile.action_date) + ' ' +
										IF(infile.action_start IN ['','0'], '', 'Action Start: ' + infile.action_start) + ' ' +
										IF(infile.action_end IN ['','0'], '', 'Action End: ' + infile.action_end) + ' ' +
										IF(infile.fine='', '', 'Fine: ' + infile.fine)
									),
									'');
		self.id := infile.key;
END;

	addlInfo := Normalize(infile(
													DateOfBirth<>'0' OR 
													//action<>'' OR
													//action_date not in ['','0'] or action_start not in ['','0'] or 
													//							action_end not in ['','0'] or fine <>''
												 cred<>''),
												2, xform(LEFT, COUNTER))(type<>'');
	
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