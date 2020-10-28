IMPORT text_search,ut,SALT30,MDR;

EXPORT person_baseBooleanSearch(DATASET(Training_sharma.layout_person_base) ih)  := MODULE
  TmpRec := RECORD
    ih;
    //RID will be an auto-generated sequence number
    SALT30.UIDType newrid := 0;
    //SID number will be derived from docfield using a hash value
    SALT30.UIDType Hashed_Sid := (UNSIGNED5)HASH64(ih.eid); // High byte to be patched in
  END;
  h1 := table(ih,TmpRec);
  ut.MAC_Sequence_Records(h1,newrid,h0);
SHARED h := h0;
  CollisionRec_eid := RECORD
    typeof(h.eid) leftvalue;
    typeof(h.eid) rightvalue;
    SALT30.UIDType hashvalue
  end;
  CollisionRec_eid note_collide(h le,h ri) := transform
    self.leftvalue := le.eid;
    self.rightvalue := ri.eid;
    self.hashvalue := le.Hashed_sid;
  end;
export Collisions_eid := dedup(join(h,h,left.Hashed_sid=right.Hashed_sid and left.eid<>right.eid,note_collide(left,right)),whole record,all);
export NumCollisions_eid0 := count(Collisions_eid);
// Now recreate the file in 'segname' form for eventual data load
  rf := RECORD
  SALT30.UIDType rid := h.newrid;
  SALT30.UIDType sid := h.hashed_sid;
  SALT30.UIDType lid := (SALT30.UIDType)h.newrid;
    h.eid;
		h.fname;
		h.mname;
		h.lname;
		h.dob;
		h.ssn;
		h.phone;
		h.prim_range;
		h.predir;
		h.prim_name;
//		h.suffix;
		h.city_name;
		h.st;
		h.zip;
END;

EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.fname,(SALT30.StrType)le.mname,(SALT30.StrType)le.lname,(SALT30.StrType)le.dob,(SALT30.StrType)le.ssn,(SALT30.StrType)le.phone,(SALT30.StrType)le.prim_range,(SALT30.StrType)le.predir,(SALT30.StrType)le.prim_name,(SALT30.StrType)le.city_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip,SKIP);
  SELF.len := LENGTH(TRIM(SELF.word));
  SELF.wip := IF(SELF.Word=Def(c-1),SKIP,1); // Adjusted later - also filters blank words
  SELF.nominal := 0; //Filled in later
  self.suffix := 0; // Filled in later
  self.part := thorlib.node();
  SELF.kwp := 0; // Adjusted later
  SELF.docref.doc := 0; // Filled in later
  SELF.docref.src := 0; // Filled in later
  SELF.src := 1;//TRANSFER(le.class_code,UNSIGNED2); // Namespace for ID provided
  SELF.seg := c; // Field number is seg; values filled in in segment definition
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','fname','mname','lname','dob','ssn','phone','prim_range','predir','prim_name','city_name','st','zip'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,14,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('fname'),'fname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fname')]}
  ,{text_search.MakeShortSeg('mname'),'mname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mname')]}
  ,{text_search.MakeShortSeg('lname'),'lname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lname')]}
  ,{text_search.MakeShortSeg('dob'),'dob',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('dob')]}
  ,{text_search.MakeShortSeg('ssn'),'ssn',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('ssn')]}
  ,{text_search.MakeShortSeg('phone'),'phone',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('phone')]}
  ,{text_search.MakeShortSeg('prim_range'),'prim_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_range')]}
  ,{text_search.MakeShortSeg('predir'),'predir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('predir')]}
  ,{text_search.MakeShortSeg('prim_name'),'prim_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_name')]}
  //,{text_search.MakeShortSeg('suffix'),'suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suffix')]}
  ,{text_search.MakeShortSeg('city_name'),'city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('city_name')]}
  ,{text_search.MakeShortSeg('st'),'st',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('st')]}
  ,{text_search.MakeShortSeg('zip'),'zip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('zip')]}
],Text_Search.Layout_Segment_ComposeDef );
 
SHARED Text_Search.Layout_Posting setRef(Text_Search.Layout_Posting le, INTEGER2 sw) := TRANSFORM
    SELF.docRef.src := CHOOSE(sw, IF(le.lid=0, le.src, 0),  le.src);
    SELF.docRef.doc := CHOOSE(sw, IF(le.lid=0, le.rid, le.lid), le.rid, le.sid);
    SELF := le;
END;
 
EXPORT Postings_LID := Text_Search.ApplyKWP2Postings(PROJECT(FieldsAsPostings, setRef(LEFT,1)), SegmentDefinitions);
EXPORT Postings_RID := Text_Search.ApplyKWP2Postings(PROJECT(FieldsAsPostings, setRef(LEFT,2)), SegmentDefinitions);
EXPORT Postings_Doc := Text_Search.ApplyKWP2Postings(PROJECT(FieldsAsPostings, setRef(LEFT,3)), SegmentDefinitions);
END;

