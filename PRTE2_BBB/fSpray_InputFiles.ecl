IMPORT prte2;

EXPORT fSpray_InputFiles := function

	RETURN PARALLEL(
										prte2.SprayFiles.Spray_Raw_Data('BBBKeys__baseMembers__', 'member', 'bbb'),
										prte2.SprayFiles.Spray_Raw_Data('BBBKeys__base__INS__Members__', 'member_ins', 'bbb'),
										prte2.SprayFiles.Spray_Raw_Data('BBBKeys__baseNonMembers__', 'nonmember', 'bbb'),
										prte2.SprayFiles.Spray_Raw_Data('BBBKeys__base__INS__NonMembers__', 'nonmember_ins', 'bbb')
									);

END;