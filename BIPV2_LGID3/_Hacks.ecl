NOTE: In proc_lgid3 we do some funky stuff with vl_id and company_name during init/postProcess


=-=-=-= BIPV2_LGID3.BasicMatch =-=-=-=
comment-out everything after Rec, up until basic_match_count, then...

// HACK - disable BasicMatch altogether
EXPORT patch_file := dataset([],Rec);
EXPORT input_file := h00_match;
EXPORT basic_match_count := 0;


=-=-= BIPV2_LGID3.Fields =-=-=
- Add a "GLOBAL" to the "f" attr in the "UIDConsistency" FUNCTIONMACRO (improves performance)

- Add a non-zero filter to each _Unbased JOIN, like...
  EXPORT LGID3_Unbased := JOIN(f(LGID3<>0),bases,LEFT.LGID3=RIGHT.LGID3,TRANSFORM(LEFT),LEFT ONLY,HASH);

- Before each _Twoparents create a thinned version of f, like...
		f_thin := table(f(rcid<>0,LGID3<>0),{rcid,LGID3},rcid,LGID3,merge); // HACK

- and then in each _Twoparents change the two "f" references to "f_thin"


=-=-=-= BIPV2_LGID3.LGID3CompareService =-=-=-=
// After "LGID3twostr" substitute this for the rest of the macro...
BIPV2_LGID3._fn_CompareService((unsigned6)LGID3onestr,(unsigned6)LGID3twostr);


=-=-= BIPV2_DotID.match_candidates =-=-=
- Eliminate all ,HINT(parallel_match) references


=-=-=-= BIPV2_LGID3.matches =-=-=-=
- Add near the top...
	SHARED ih_thin := TABLE(ih,{ultid,orgid,seleid,lgid3,proxid,dotid,rcid}); // HACK

- Add within RuleText:
  ,n = 100 => ':duns_number'
  ,n = 101 => ':company_fein'

- replace SALT28.mac_avoid_transitives line with
import BIPV2_Tools; /*HACK*/
BIPV2_Tools.mac_avoid_transitives(All_Matches,LGID31,LGID32,Conf,DateOverlap,Rule,o);/*HACK*/

- disable sliceout
// too_big := Specificities(ih).ClusterSizes(InCluster>1); // LGID3 that are too big for sliceout
// h_ok := JOIN(h,too_big,LEFT.LGID3=RIGHT.LGID3,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
h_ok := dataset([],recordof(h)); /* HACK - disable sliceout */
...
// SALT28.MAC_SliceOut_ByRID(ihbp,rcid,LGID3,ToSlice,rcid,sliced); // Execute Sliceouts /* HACK - disable sliceout */
ut.MAC_Patch_Id(ihbp,LGID3,Matches,LGID31,LGID32,o); // Join Clusters

- Change SALT28.MAC_ParentId_Patch references to BIPV2_Tools.MAC_ParentId_Patch
- Change SALT28.MAC_ChildId_Patch references to BIPV2_Tools.MAC_ChildId_Patch

- Work in a thinner layout where possible
	// ut.MAC_Patch_Id(ih,POWID,BasicMatch(ih).patch_file,POWID1,POWID2,ihbp); // Perform basic matches
	ut.MAC_Patch_Id(ih_thin,POWID,BasicMatch(ih).patch_file,POWID1,POWID2,ihbp); // Perform basic matches
	...
	// EXPORT Patched_Infile := PatchDotID;
	SHARED Patched_Infile_thin := PatchDotID : INDEPENDENT; // HACK
	EXPORT Patched_Infile := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH); // HACK
	...
  // id_shift_r note_change(ih le,patched_infile ri) := TRANSFORM
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
	...
	// EXPORT IdChanges := JOIN(ih,patched_infile,LEFT.rcid = RIGHT.rcid AND (LEFT.POWID<>RIGHT.POWID OR LEFT.SeleID<>RIGHT.SeleID OR LEFT.OrgID<>RIGHT.OrgID OR LEFT.UltID<>RIGHT.UltID),note_change(LEFT,RIGHT));
	EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.POWID<>RIGHT.POWID OR LEFT.SeleID<>RIGHT.SeleID OR LEFT.OrgID<>RIGHT.OrgID OR LEFT.UltID<>RIGHT.UltID),note_change(LEFT,RIGHT));
	...
	// EXPORT PreIDs := BIPV2_POWID.Fields.UIDConsistency(ih); // Export whole consistency module
	// EXPORT PostIDs := BIPV2_POWID.Fields.UIDConsistency(Patched_Infile); // Export whole consistency module
	EXPORT PreIDs := BIPV2_POWID.Fields.UIDConsistency(ih_thin); // Export whole consistency module
	EXPORT PostIDs := BIPV2_POWID.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
	...
	// EXPORT DuplicateRids0 := COUNT(Patched_Infile) - PostIDs.IdCounts[1].rcid_Count; // Should be zero
	EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Count; // Should be zero
