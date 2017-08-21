IMPORT text_search,ut,SALT30,MDR;
 
EXPORT lpr_baseBooleanSearch(DATASET(layout_lpr_base) ih)  := MODULE
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
    h.gh4;
    h.gh5;
    h.gh6;
    h.etype;
    h.eventnumber;
    h.wc_plate;
    h.plate;
    h.clean_capturedatetime;
    h.agency;
    h.data_provider_ori;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.gh4,(SALT30.StrType)le.gh5,(SALT30.StrType)le.gh6,(SALT30.StrType)le.etype,(SALT30.StrType)le.eventnumber,(SALT30.StrType)le.wc_plate,(SALT30.StrType)le.plate,(SALT30.StrType)le.clean_capturedatetime,(SALT30.StrType)le.agency,(SALT30.StrType)le.data_provider_ori,SKIP,SKIP);
  SELF.len := LENGTH(TRIM(SELF.word));
  SELF.wip := IF(SELF.Word=Def(c-1),SKIP,1); // Adjusted later - also filters blank words
  SELF.nominal := 0; //Filled in later
  self.suffix := 0; // Filled in later
  self.part := thorlib.node();
  SELF.kwp := 0; // Adjusted later
  SELF.docref.doc := 0; // Filled in later
  SELF.docref.src := 0; // Filled in later
  SELF.src := TRANSFER(le.class_code,UNSIGNED2); // Namespace for ID provided
  SELF.seg := c; // Field number is seg; values filled in in segment definition
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','gh4','gh5','gh6','etype','eventnumber','wc_plate','plate','clean_capturedatetime','agency','data_provider_ori','DATE'));
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
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('gh4'),'gh4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh4')]}
  ,{text_search.MakeShortSeg('gh5'),'gh5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh5')]}
  ,{text_search.MakeShortSeg('gh6'),'gh6',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh6')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('eventnumber'),'eventnumber',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eventnumber')]}
  ,{text_search.MakeShortSeg('wc_plate'),'wc_plate',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_plate')]}
  ,{text_search.MakeShortSeg('plate'),'plate',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('plate')]}
  ,{text_search.MakeShortSeg('clean_capturedatetime'),'clean_capturedatetime',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_capturedatetime')]}
  ,{text_search.MakeShortSeg('agency'),'agency',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency')]}
  ,{text_search.MakeShortSeg('data_provider_ori'),'data_provider_ori',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('data_provider_ori')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('clean_capturedatetime')]}
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

