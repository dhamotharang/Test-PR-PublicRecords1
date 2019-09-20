NOTE: In proc_powid we widen the layout to include a couple extra fields


=-=-=-= BIPV2_POWID_Platform.BasicMatch =-=-=-=
comment-out everything after Rec, up until basic_match_count, then...

// HACK - disable BasicMatch altogether
EXPORT patch_file := dataset([],Rec);
EXPORT input_file := h00;
EXPORT basic_match_count := 0;


=-=-=-= BIPV2_POWID_Platform.Config =-=-=-=
- DoSliceouts := FALSE


=-=-= BIPV2_POWID_Platform.Fields =-=-=
- Add a "GLOBAL" to the "f" attr in the "UIDConsistency" FUNCTIONMACRO (improves performance)

- Add a non-zero filter to each _Unbased JOIN, like...
  EXPORT LGID3_Unbased := JOIN(f(LGID3<>0),bases,LEFT.LGID3=RIGHT.LGID3,TRANSFORM(LEFT),LEFT ONLY,HASH);

- Before each _Twoparents create a thinned version of f, like...
		f_thin := table(f(rcid<>0,LGID3<>0),{rcid,LGID3},rcid,LGID3,merge); // HACK

- and then in each _Twoparents change the two "f" references to "f_thin"


=-=-= BIPV2_POWID_Platform.match_candidates =-=-=
- Eliminate all ,HINT(parallel_match) references


=-=-=-= BIPV2_POWID_Platform.matches =-=-=-=
- Add near the top...
	SHARED ih_thin := TABLE(ih,{ultid,orgid,seleid,powid,proxid,dotid,rcid}); // HACK
  
- Change the following lines in the match_join transform to this:
  INTEGER2 company_name_score := IF ( company_name_score_temp > Config.company_name_Force * 100, company_name_score_temp, 0 ); // HACK: FORCE only if both company names fail the force test
  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp >= Config.cnp_name_Force * 100, cnp_name_score_temp, IF(company_name_score=0,SKIP,0) ); // HACK: FORCE only if both company names fail the force test
  
  iComp := (prim_range_score + prim_name_score + MAX(company_name_score,cnp_name_score) + zip_score + cnp_number_score) / 100 + outside; // HACK: Change addition to MAX for the two company name scores

- Change SALT28.mac_avoid_transitives to BIPV2_Tools.mac_avoid_transitives

- Change SALT28.MAC_ParentId_Patch references to BIPV2_Tools.MAC_MultiParent_Collapse

- Work in a thinner layout where possible
	// ut.MAC_Patch_Id(ih,POWID,BasicMatch(ih).patch_file,POWID1,POWID2,ihbp); // Perform basic matches
	ut.MAC_Patch_Id(ih_thin,POWID,BasicMatch(ih).patch_file,POWID1,POWID2,ihbp); // Perform basic matches
	...
	// EXPORT Patched_Infile := PatchUltID;
	SHARED Patched_Infile_thin := PatchUltID : INDEPENDENT; // HACK
	EXPORT Patched_Infile := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH); // HACK
	...
  // id_shift_r note_change(ih le,patched_infile ri) := TRANSFORM
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
	...
	// EXPORT IdChanges := JOIN(ih,patched_infile,LEFT.rcid = RIGHT.rcid AND (LEFT.POWID<>RIGHT.POWID OR LEFT.SeleID<>RIGHT.SeleID OR LEFT.OrgID<>RIGHT.OrgID OR LEFT.UltID<>RIGHT.UltID),note_change(LEFT,RIGHT));
	EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.POWID<>RIGHT.POWID OR LEFT.SeleID<>RIGHT.SeleID OR LEFT.OrgID<>RIGHT.OrgID OR LEFT.UltID<>RIGHT.UltID),note_change(LEFT,RIGHT));
	...
	// EXPORT PreIDs := BIPV2_POWID_Platform.Fields.UIDConsistency(ih); // Export whole consistency module
	// EXPORT PostIDs := BIPV2_POWID_Platform.Fields.UIDConsistency(Patched_Infile); // Export whole consistency module
	EXPORT PreIDs := BIPV2_POWID_Platform.Fields.UIDConsistency(ih_thin); // Export whole consistency module
	EXPORT PostIDs := BIPV2_POWID_Platform.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
	...
	// EXPORT DuplicateRids0 := COUNT(Patched_Infile) - PostIDs.IdCounts[1].rcid_Count; // Should be zero
	EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Count; // Should be zero


=-=-=-= BIPV2_POWID_Platform.MOD_Attr_charter =-=-=-=
Replace with Vern's code.  See history.

=-=-= BIPV2_POWID_Platform.Proc_Iterate =-=-=
- added keysuffix to changes filename.  so it will be unique per build and prevent superfile error too.
  import bipv2;
  EXPORT OutputChanges := OUTPUT(MM.IdChanges,,'~temp::POWID::BIPV2_POWID_Platform::changes_it'+iter+'_'+ bipv2.KeySuffix,OVERWRITE,COMPRESSED);// Changes made
