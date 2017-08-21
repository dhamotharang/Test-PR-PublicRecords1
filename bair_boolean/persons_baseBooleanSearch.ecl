IMPORT text_search,ut,SALT30,MDR;
 
EXPORT persons_baseBooleanSearch(DATASET(layout_persons_base) ih)  := MODULE
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
    h.ir_number;
    h.name_type;
    h.last_name;
    h.first_name;
    h.middle_name;
    h.moniker;
    h.persons_address;
    h.clean_dob;
    h.race;
    h.sex;
    h.hair;
    h.hair_length;
    h.eyes;
    h.hand_use;
    h.speech;
    h.teeth;
    h.physical_condition;
    h.build;
    h.complexion;
    h.facial_hair;
    h.hat;
    h.mask;
    h.glasses;
    h.appearance;
    h.shirt;
    h.pants;
    h.shoes;
    h.jacket;
    h.soundex;
    h.persons_notes;
    h.weight_1;
    h.weight_2;
    h.height_1;
    h.height_2;
    h.age_1;
    h.age_2;
    h.persons_sid;
    h.picture;
    h.facial_recognition;
    h.personstamp;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.etype,(SALT30.StrType)le.ir_number,(SALT30.StrType)le.name_type,(SALT30.StrType)le.last_name,(SALT30.StrType)le.first_name,(SALT30.StrType)le.middle_name,(SALT30.StrType)le.moniker,(SALT30.StrType)le.persons_address,(SALT30.StrType)le.clean_dob,(SALT30.StrType)le.race,(SALT30.StrType)le.sex,(SALT30.StrType)le.hair,(SALT30.StrType)le.hair_length,(SALT30.StrType)le.eyes,(SALT30.StrType)le.hand_use,(SALT30.StrType)le.speech,(SALT30.StrType)le.teeth,(SALT30.StrType)le.physical_condition,(SALT30.StrType)le.build,(SALT30.StrType)le.complexion,(SALT30.StrType)le.facial_hair,(SALT30.StrType)le.hat,(SALT30.StrType)le.mask,(SALT30.StrType)le.glasses,(SALT30.StrType)le.appearance,(SALT30.StrType)le.shirt,(SALT30.StrType)le.pants,(SALT30.StrType)le.shoes,(SALT30.StrType)le.jacket,(SALT30.StrType)le.soundex,(SALT30.StrType)le.persons_notes,(SALT30.StrType)le.weight_1,(SALT30.StrType)le.weight_2,(SALT30.StrType)le.height_1,(SALT30.StrType)le.height_2,(SALT30.StrType)le.age_1,(SALT30.StrType)le.age_2,(SALT30.StrType)le.persons_sid,(SALT30.StrType)le.picture,(SALT30.StrType)le.facial_recognition,(SALT30.StrType)le.personstamp,SKIP,SKIP);
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
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','etype','ir_number','name_type','last_name','first_name','middle_name','moniker','persons_address','clean_dob','race','sex','hair','hair_length','eyes','hand_use','speech','teeth','physical_condition','build','complexion','facial_hair','hat','mask','glasses','appearance','shirt','pants','shoes','jacket','soundex','persons_notes','weight_1','weight_2','height_1','height_2','age_1','age_2','persons_sid','picture','facial_recognition','personstamp','NOTES'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,45,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('ir_number'),'ir_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('ir_number')]}
  ,{text_search.MakeShortSeg('name_type'),'name_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name_type')]}
  ,{text_search.MakeShortSeg('last_name'),'last_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('last_name')]}
  ,{text_search.MakeShortSeg('first_name'),'first_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('first_name')]}
  ,{text_search.MakeShortSeg('middle_name'),'middle_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('middle_name')]}
  ,{text_search.MakeShortSeg('moniker'),'moniker',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('moniker')]}
  ,{text_search.MakeShortSeg('persons_address'),'persons_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('persons_address')]}
  ,{text_search.MakeShortSeg('clean_dob'),'clean_dob',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_dob')]}
  ,{text_search.MakeShortSeg('race'),'race',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('race')]}
  ,{text_search.MakeShortSeg('sex'),'sex',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sex')]}
  ,{text_search.MakeShortSeg('hair'),'hair',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('hair')]}
  ,{text_search.MakeShortSeg('hair_length'),'hair_length',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('hair_length')]}
  ,{text_search.MakeShortSeg('eyes'),'eyes',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eyes')]}
  ,{text_search.MakeShortSeg('hand_use'),'hand_use',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('hand_use')]}
  ,{text_search.MakeShortSeg('speech'),'speech',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('speech')]}
  ,{text_search.MakeShortSeg('teeth'),'teeth',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('teeth')]}
  ,{text_search.MakeShortSeg('physical_condition'),'physical_condition',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('physical_condition')]}
  ,{text_search.MakeShortSeg('build'),'build',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('build')]}
  ,{text_search.MakeShortSeg('complexion'),'complexion',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('complexion')]}
  ,{text_search.MakeShortSeg('facial_hair'),'facial_hair',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('facial_hair')]}
  ,{text_search.MakeShortSeg('hat'),'hat',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('hat')]}
  ,{text_search.MakeShortSeg('mask'),'mask',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mask')]}
  ,{text_search.MakeShortSeg('glasses'),'glasses',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('glasses')]}
  ,{text_search.MakeShortSeg('appearance'),'appearance',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('appearance')]}
  ,{text_search.MakeShortSeg('shirt'),'shirt',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('shirt')]}
  ,{text_search.MakeShortSeg('pants'),'pants',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('pants')]}
  ,{text_search.MakeShortSeg('shoes'),'shoes',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('shoes')]}
  ,{text_search.MakeShortSeg('jacket'),'jacket',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('jacket')]}
  ,{text_search.MakeShortSeg('soundex'),'soundex',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('soundex')]}
  ,{text_search.MakeShortSeg('persons_notes'),'persons_notes',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('persons_notes')]}
  ,{text_search.MakeShortSeg('weight_1'),'weight_1',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('weight_1')]}
  ,{text_search.MakeShortSeg('weight_2'),'weight_2',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('weight_2')]}
  ,{text_search.MakeShortSeg('height_1'),'height_1',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('height_1')]}
  ,{text_search.MakeShortSeg('height_2'),'height_2',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('height_2')]}
  ,{text_search.MakeShortSeg('age_1'),'age_1',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('age_1')]}
  ,{text_search.MakeShortSeg('age_2'),'age_2',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('age_2')]}
  ,{text_search.MakeShortSeg('persons_sid'),'persons_sid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('persons_sid')]}
  ,{text_search.MakeShortSeg('picture'),'picture',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('picture')]}
  ,{text_search.MakeShortSeg('facial_recognition'),'facial_recognition',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('facial_recognition')]}
  ,{text_search.MakeShortSeg('personstamp'),'personstamp',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('personstamp')]}
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('persons_notes')]}
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

