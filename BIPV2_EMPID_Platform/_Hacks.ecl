/*I don't think we're still hacking BasicMatch.  check that out.

=-=-=-= BIPV2_EMPID_Platform.BasicMatch =-=-=-=
comment-out everything after Rec, up until basic_match_count, then...

// HACK - disable BasicMatch altogether
EXPORT patch_file := dataset([],Rec);
EXPORT input_file := h00;
EXPORT basic_match_count := 0;*/


=-=-=-= BIPV2_EMPID_Platform.Config =-=-=-=
DoSliceouts := FALSE


=-=-=-= BIPV2_EMPID_Platform.Fields =-=-=-= 
- (Issue #1156) EXPORT InValidFT_isOwner(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['OWNER']);

- Add a "GLOBAL" to the "f" attr in the "UIDConsistency" FUNCTIONMACRO (improves performance)

- Add a non-zero filter to each _Unbased JOIN, like...
  EXPORT LGID3_Unbased := JOIN(f(LGID3<>0),bases,LEFT.LGID3=RIGHT.LGID3,TRANSFORM(LEFT),LEFT ONLY,HASH);

- Before each _Twoparents create a thinned version of f, like...
		f_thin := table(f(rcid<>0,LGID3<>0),{rcid,LGID3},rcid,LGID3,merge); // HACK

- and then in each _Twoparents change the two "f" references to "f_thin"


=-=-= BIPV2_EMPID_Platform.match_candidates =-=-=
- Eliminate all ,HINT(parallel_match) references


=-=-=-= BIPV2_EMPID_Platform.matches =-=-=-=
- Change SALT30.mac_avoid_transitives to BIPV2_Tools.mac_avoid_transitives

- Change SALT30.MAC_ParentId_Patch references to BIPV2_Tools.MAC_MultiParent_Collapse

- added thinning logic


=-=-= BIPV2_EMPID_Platform.Proc_Iterate =-=-=
- added keysuffix to changes filename.  so it will be unique per build and prevent superfile error too.
  import bipv2;
  EXPORT OutputChanges := OUTPUT(MM.IdChanges,,'~temp::EmpID::BIPV2_EMPID_Platform::changes_it'+iter+'_'+ bipv2.KeySuffix,OVERWRITE,COMPRESSED);// Changes made
