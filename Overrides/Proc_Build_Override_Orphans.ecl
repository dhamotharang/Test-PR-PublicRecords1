IMPORT STD,overrides,PromoteSupers,FCRA,ut;
EXPORT Proc_Build_Override_Orphans(STRING filedate) := FUNCTION

	TrueOrphans_All := overrides.GetTrueOrphans(filedate);

	OUTPUT(TrueOrphans_All, NAMED('TrueOrphans_All'));	
	
	OUTPUT(TABLE(TrueOrphans_All,{datagroup, cnt := COUNT(GROUP)}, datagroup, MERGE), NAMED('DsLexid_True_Orphans'));

	#uniquename(dOrphanFilterCandidates)
	%dOrphanFilterCandidates% := Overrides.File_Override_Orphans.datagroup_lookup_filter_file;

	//TrueOrphans :=  TrueOrphans_All(STD.Str.ToUpperCase(datagroup) IN SET(%dOrphanFilterCandidates%(skipFlag = false), datagroup));

	Orphans := PROJECT(TrueOrphans_All, TRANSFORM(overrides.File_Override_Orphans.orphan_rec,
								SELF.datagroup := STD.Str.ToUpperCase(LEFT.datagroup), SELF.did := (STRING) LEFT.did, SELF := LEFT));
	
	Orphan_Super_File := '~thor_data400::lookup::override::orphans';   
	
	Existing_Filtered_Orphans := Overrides.File_Override_Orphans.orphan_file;
	// add all from old orphans from super file
	Orphans_All := Orphans + Existing_Filtered_Orphans;

	// filter again to skip datagroup
	Filtered_Orphans_All :=  Orphans_All(datagroup IN SET(%dOrphanFilterCandidates%(skipFlag = false), datagroup));
								
	OUTPUT(TABLE(Filtered_Orphans_All, {datagroup, cnt := COUNT(GROUP)}, datagroup, MERGE), NAMED('orphans_override_base'));
	
	Orphan_Super_SubFile := '~thor_data400::lookup::override::' + FileDate + '::orphans';   
	
	build_orphans := OUTPUT(Filtered_Orphans_All,, Orphan_Super_SubFile, OVERWRITE, __COMPRESSED__);
	
	// add_orphans := FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::lookup::override::orphans','~thor_data400::lookup::override::orphans::father','~thor_data400::lookup::override::orphans::grandfather'],
	// 					'~thor_data400::lookup::override::' + FileDate + '::orphans', true);
						
	// // growth check needs to be added					
	 
	// RETURN SEQUENTIAL(build_orphans, add_orphans);
	RETURN build_orphans;
	
END;




