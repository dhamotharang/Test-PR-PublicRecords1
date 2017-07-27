IMPORT text_search,ut,SALT30,MDR;
 
EXPORT vehicle_baseBooleanSearch(DATASET(layout_vehicle_base) ih)  := MODULE
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
    h.recordid_raids;
    h.ir_number;
    h.plate;
    h.plate_state;
    h.make;
    h.model;
    h.style;
    h.color;
    h.year;
    h.type;
    h.vehicle_status;
    h.vehicle_address;
    h.description;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.etype,(SALT30.StrType)le.recordid_raids,(SALT30.StrType)le.ir_number,(SALT30.StrType)le.plate,(SALT30.StrType)le.plate_state,(SALT30.StrType)le.make,(SALT30.StrType)le.model,(SALT30.StrType)le.style,(SALT30.StrType)le.color,(SALT30.StrType)le.year,(SALT30.StrType)le.type,(SALT30.StrType)le.vehicle_status,(SALT30.StrType)le.vehicle_address,(SALT30.StrType)le.description,SKIP,SKIP);
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
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','etype','recordid_raids','ir_number','plate','plate_state','make','model','style','color','year','type','vehicle_status','vehicle_address','description','NOTES'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,18,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('recordid_raids'),'recordid_raids',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('recordid_raids')]}
  ,{text_search.MakeShortSeg('ir_number'),'ir_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('ir_number')]}
  ,{text_search.MakeShortSeg('plate'),'plate',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('plate')]}
  ,{text_search.MakeShortSeg('plate_state'),'plate_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('plate_state')]}
  ,{text_search.MakeShortSeg('make'),'make',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('make')]}
  ,{text_search.MakeShortSeg('model'),'model',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('model')]}
  ,{text_search.MakeShortSeg('style'),'style',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('style')]}
  ,{text_search.MakeShortSeg('color'),'color',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('color')]}
  ,{text_search.MakeShortSeg('year'),'year',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('year')]}
  ,{text_search.MakeShortSeg('type'),'type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('type')]}
  ,{text_search.MakeShortSeg('vehicle_status'),'vehicle_status',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_status')]}
  ,{text_search.MakeShortSeg('vehicle_address'),'vehicle_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_address')]}
  ,{text_search.MakeShortSeg('description'),'description',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('description')]}
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('description')]}
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

