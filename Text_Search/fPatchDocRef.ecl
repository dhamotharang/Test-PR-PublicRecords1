IMPORT Text_Search;
IMPORT Lib_THORLIB;
//Patch the doc reference number collisions

EXPORT DATASET(Layout_Posting) fPatchDocRef(Filename_Info info, 
                                            DATASET(Layout_Posting) ps, 
                                            BOOLEAN incremental=FALSE) := FUNCTION
  Work_Posting := RECORD(Layout_Posting)
    UNSIGNED4 rel_doc := 0;
  END;
  Work_Posting enum_docs(Work_Posting prev, Work_Posting curr) := TRANSFORM
    isNewDoc := prev.docRef.doc<>curr.docRef.doc;
    isFirstDoc := prev.docRef.doc = 0;
    SELF.rel_doc := MAP(isFirstDoc      => ThorLib.node()+1,
                        isNewDoc        => prev.rel_doc + ThorLib.nodes(),
                        prev.rel_doc);
    SELF := curr;
  END;
  enum_ps := ITERATE(PROJECT(ps, Work_Posting), enum_docs(LEFT,RIGHT), LOCAL);
  // find collisions
  collision_rec := RECORD
    Types.DocRef docRef;
    Types.PartitionID part;
    UNSIGNED1 collision_pos;
    BOOLEAN newKey; 
    Types.ExternalKey extKey;
    SET OF UNSIGNED4 rel_doc_set;
  END;
  collision_rec getExk(RECORDOF(Indx_ExtKeyOut2(info)) k) := TRANSFORM
    SELF.docRef.src := k.src;
    SELF.docRef.doc := (UNSIGNED5) k.doc;   // drop out the high 8 bits
    SELF.extKey := k.ExternalKey;
    SELF.collision_pos := k.doc >> 40;  // shift out lower 40 bits
    SELF.newKey := FALSE;
    SELF.part := k.part;
    SELF.rel_doc_set := [];
  END;
  old_assignments := IF(incremental, 
                        PROJECT(Indx_ExtKeyOut2(info), getExk(LEFT)),
                        DATASET([], collision_rec));
  collision_rec getPost(Work_Posting post) := TRANSFORM
    SELF.docRef.src := post.docRef.src;
    SELF.docRef.doc := (UNSIGNED5)post.docRef.doc;
    SELF.extKey := TRIM(post.word);
    SELF.collision_pos := 0;
    SELF.newKey := TRUE;
    SELF.part := post.part;
    SELF.rel_doc_set := [post.rel_doc];
  END;
  ext_keys := enum_ps(typ=Types.WordType.ExtKey);  // pick up the external keys records
  new_assignments := PROJECT(ext_keys, getPost(LEFT));
  grp_assignments := GROUP(new_assignments+old_assignments, docRef.src, docRef.doc, ALL);
  grp_assgn_seq := SORT(grp_assignments, newKey, extKey, collision_pos); 
  collision_rec rollCollisions(collision_rec cumm, collision_rec incr) := TRANSFORM
    SELF.rel_doc_set := cumm.rel_doc_set + incr.rel_doc_set;
    SELF := incr;     // keep the highest collision pos per external key
  END;
  grp_key_list := ROLLUP(grp_assgn_seq, rollCollisions(LEFT,RIGHT), newKey, extKey);
  collisions := HAVING(grp_key_list, COUNT(ROWS(LEFT))>1 AND EXISTS(ROWS(LEFT)(newKey)));
  
  // create delete records for replaced documents
  Layout_Posting makeDelete(collision_rec cr) := TRANSFORM
    SELF.part := cr.part;
    SELF.nominal := Constants.DeleteKeyNominal;
    SELF.docRef.src := cr.docRef.src;
    SELF.docRef.doc := cr.docRef.doc + (cr.collision_pos << 40);
    SELF.typ := Text_Search.Types.WordType.MetaData;
    SELF.segName := MakeShortSeg(Constants.DelKeyField);
    SELF := [];;
  END;
  replaced := HAVING(GROUP(SORT(collisions, extKey, newKey), extKey), COUNT(ROWS(LEFT))>1);
  deletes := PROJECT(UNGROUP(replaced(NOT newKey)), makeDelete(LEFT));
  // assign collision positions as needed
  collision_rec setPos(collision_rec prev, collision_rec curr) := TRANSFORM
    SELF.collision_pos := IF(curr.collision_pos=0 AND curr.newKey, 
                             prev.collision_pos+1, 
                             curr.collision_pos);
    SELF := curr;
  END;
  collisions_old_new := SORT(collisions, newKey, collision_pos, extKey); // new all all 0 pos
  colliders_marked := ASSERT(UNGROUP(ITERATE(collisions_old_new, setPos(LEFT,RIGHT))),
                             collision_pos<250, 'Too many collisions found', FAIL);
  // make patch records
  patch_rec := RECORD
    UNSIGNED4 rel_doc;
    Types.DocRef docRef;
    UNSIGNED1 collision_pos;
  END;
  patch_rec normPatch(collision_rec base, UNSIGNED c) := TRANSFORM
    SELF.rel_doc := base.rel_doc_set[c];
    SELF := base;
  END;
  patches := NORMALIZE(colliders_marked, COUNT(LEFT.rel_doc_set), normPatch(LEFT, COUNTER));
  // now patch the input as required
  Layout_Posting patchPost(Work_Posting post, patch_rec patch) := TRANSFORM
    UNSIGNED6 new_doc := patch.docRef.doc + ((UNSIGNED6)patch.collision_pos << 40);
    SELF.docRef.doc := IF(patch.rel_doc<>0, new_doc, post.docRef.doc);
    SELF := post;
  END;
  patched := JOIN(enum_ps, patches, LEFT.rel_doc=RIGHT.rel_doc,
                  patchPost(LEFT, RIGHT), LEFT OUTER, LOOKUP);
  RETURN patched & DISTRIBUTE(deletes, part);
END;