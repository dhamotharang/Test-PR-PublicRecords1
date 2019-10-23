=-=-= BIPV2_POWID_DOWN_Platform.Proc_Iterate =-=-=
- added keysuffix to changes filename.  so it will be unique per build and prevent superfile error too.
import bipv2;
EXPORT OutputChanges := OUTPUT(MM.IdChanges,,'~temp::POWID::BIPV2_POWID_DOWN_Platform::changes_it'+iter+'_'+ bipv2.KeySuffix,OVERWRITE,COMPRESSED);// Changes made



No hacks needed right now.  The hack below was needed when my orgid specificity declaration was messed up, but not anymore.

---------------

BIPV2_POWID_DOWN_Platform.match_candidates:

// j8 := JOIN(h1,PULL(Specificities(ih).orgid_values_persisted),LEFT.orgid=RIGHT.orgid,add_orgid(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
j8 := JOIN(h1,Specificities(ih).orgid_values_persisted,keyed(LEFT.orgid=RIGHT.orgid),add_orgid(LEFT,RIGHT,TRUE),LEFT OUTER);


