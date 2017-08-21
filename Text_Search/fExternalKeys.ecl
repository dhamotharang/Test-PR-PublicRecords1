IMPORT Text_Search;
IMPORT Lib_ThorLib;

EXPORT fExternalKeys(Filename_Info info, DATASET(Layout_Posting) ps, 
                     BOOLEAN incremental=FALSE) := FUNCTION
  Work_exk := RECORD(Layout_ExternalKeyMap)
    UNSIGNED4 node;
    BOOLEAN newKey;
  END;
  Work_exk get_exk(RECORDOF(Indx_ExtKeyOut2(info)) k) := TRANSFORM
    SELF.docRef.src := k.src;
    SELF.docRef.doc := k.doc;
    SELF.newKey := FALSE;
    SELF.hashKey := HASH64(TRIM(k.ExternalKey));
    SELF.node := ThorLib.node();
    SELF := k;
  END;
  old_keys := IF(incremental,
                 PROJECT(Indx_ExtKeyOut2(info), get_exk(LEFT)),
                 DATASET([], Work_exk));
  Work_exk cvt2KeyMap(Layout_Posting l) := TRANSFORM
    SELF.DocRef := l.DocRef;
    SELF.part := l.part;
    SELF.ExternalKey := TRIM(l.word);
    SELF.HashKey := HASH64(TRIM(l.word));
    SELF.newKey := TRUE;
    SELF.node := ThorLib.node();
    SELF.ver := 0;
  END;
  new_keys := PROJECT(ps(typ=Types.WordType.ExtKey), cvt2KeyMap(LEFT));
  grp_keys := SORT(GROUP(old_keys+new_keys, ExternalKey, ALL), newKey, ver);
  grp_key_pairs := DEDUP(grp_keys, newKey, RIGHT);
  Work_exk set_ver(Work_exk base, Work_exk curr) := TRANSFORM
    SELF.ver := base.ver + 1;
    SELF.newKey := base.newKey OR curr.newKey;
    SELF := curr;
  END;
  marked_exk := UNGROUP(ROLLUP(grp_key_pairs, TRUE, set_ver(LEFT,RIGHT)));
  distributed_exk := DISTRIBUTE(marked_exk, node);
  rslt := PROJECT(distributed_exk(newKey), Layout_ExternalKeyMap);
  RETURN rslt;
END;