IMPORT text_search,ut,SALT30,MDR;
 
EXPORT shotspotter_baseBooleanSearch(DATASET(layout_shotspotter_base) ih)  := MODULE
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
    h.gh12;
    h.etype;
    h.raids_record_id;
    h.shot_id;
    h.shots;
    h.address;
    h.beat;
    h.district;
    h.shot_source;
    h.shot_incident_type;
    h.shot_incident_status;
    h.x_coordinate;
    h.y_coordinate;
    h.shot_incident_notes;
    h.clean_shot_datetime;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','0','','','','','','','0','0','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.etype,(SALT30.StrType)le.raids_record_id,(SALT30.StrType)le.shot_id,(SALT30.StrType)le.shots,(SALT30.StrType)le.address,(SALT30.StrType)le.beat,(SALT30.StrType)le.district,(SALT30.StrType)le.shot_source,(SALT30.StrType)le.shot_incident_type,(SALT30.StrType)le.shot_incident_status,(SALT30.StrType)le.x_coordinate,(SALT30.StrType)le.y_coordinate,(SALT30.StrType)le.shot_incident_notes,(SALT30.StrType)le.clean_shot_datetime,SKIP,SKIP,SKIP);
  SELF.len := LENGTH(TRIM(SELF.word));
  SELF.wip := IF(SELF.Word=Def(c-1),SKIP,1); // Adjusted later - also filters blank words
  SELF.nominal := 0; //Filled in later
  self.suffix := 0; // Filled in later
  self.part := thorlib.node();
  SELF.kwp := 0; // Adjusted later
  SELF.docref.doc := 0; // Filled in later
  SELF.docref.src := 0; // Filled in later
  SELF.src := TRANSFER(MDR.sourceTools.src_Bair_Analytics,UNSIGNED2); // Namespace for ID provided
  SELF.seg := c; // Field number is seg; values filled in in segment definition
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','etype','raids_record_id','shot_id','shots','address','beat','district','shot_source','shot_incident_type','shot_incident_status','x_coordinate','y_coordinate','shot_incident_notes','clean_shot_datetime','NOTES','DATE'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,19,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('raids_record_id'),'raids_record_id',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('raids_record_id')]}
  ,{text_search.MakeShortSeg('shot_id'),'shot_id',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('shot_id')]}
  ,{text_search.MakeShortSeg('shots'),'shots',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('shots')]}
  ,{text_search.MakeShortSeg('address'),'address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('address')]}
  ,{text_search.MakeShortSeg('beat'),'beat',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('beat')]}
  ,{text_search.MakeShortSeg('district'),'district',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('district')]}
  ,{text_search.MakeShortSeg('shot_source'),'shot_source',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('shot_source')]}
  ,{text_search.MakeShortSeg('shot_incident_type'),'shot_incident_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('shot_incident_type')]}
  ,{text_search.MakeShortSeg('shot_incident_status'),'shot_incident_status',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('shot_incident_status')]}
  ,{text_search.MakeShortSeg('x_coordinate'),'x_coordinate',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('x_coordinate')]}
  ,{text_search.MakeShortSeg('y_coordinate'),'y_coordinate',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('y_coordinate')]}
  ,{text_search.MakeShortSeg('shot_incident_notes'),'shot_incident_notes',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('shot_incident_notes')]}
  ,{text_search.MakeShortSeg('clean_shot_datetime'),'clean_shot_datetime',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_shot_datetime')]}
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('shot_incident_notes')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('clean_shot_datetime')]}
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

