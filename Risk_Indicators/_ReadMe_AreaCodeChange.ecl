/*
Update Frequency: Quarterly Full Append;
	Step 1:  FTP data from:\\tapeload02b\k\metadata\telcordia\area_cd_split_xchange -- To:(bctlpedata11:):/data/gong/gong/telcordia/area_code_split_changes/spray/+filedate
	Step 2:	 Execute BWR_AreaCodeChange_Build_All('Enter Receiving File Date Here');

NOTE: Build process takes input file, creates flat file (First record pair is first fields of record(old_NPA info)
			and consecutive record is second set of fields(new_NPA) into a single record output.
			Input file is rolled up into current base file to create new base file.
			Expected input file RL = 30

*/

