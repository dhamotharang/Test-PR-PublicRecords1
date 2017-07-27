IMPORT text_search,ut,SALT30,MDR;
 
EXPORT offenders_baseBooleanSearch(DATASET(layout_offenders_base) ih)  := MODULE
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
    h.agency_offender_id;
    h.address;
    h.first_name;
    h.middle_name;
    h.last_name;
    h.moniker;
    h.name_type;
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
    h.weight_1;
    h.weight_2;
    h.height_1;
    h.height_2;
    h.age_1;
    h.age_2;
    h.offenders_sid;
    h.dl_number;
    h.dl_state;
    h.fbi_number;
    h.offender_notes;
    h.clean_edit_date;
    h.quarantined;
    h.admin_state;
    h.agency_name;
    h.user_text_1;
    h.user_text_2;
    h.user_integer;
    h.user_float;
    h.clean_user_datetime;
    h.agency_category;
    h.agency_level;
    h.agency_score;
    h.bair_score;
    h.case_reference_number;
    h.charge_offense;
    h.probation_type;
    h.probation_officer;
    h.warrant_type;
    h.warrant_number;
    h.gang_name;
    h.clean_classification_date;
    h.clean_expiration_date;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','0','0','0','0','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.etype,(SALT30.StrType)le.agency_offender_id,(SALT30.StrType)le.address,(SALT30.StrType)le.first_name,(SALT30.StrType)le.middle_name,(SALT30.StrType)le.last_name,(SALT30.StrType)le.moniker,(SALT30.StrType)le.name_type,(SALT30.StrType)le.clean_dob,(SALT30.StrType)le.race,(SALT30.StrType)le.sex,(SALT30.StrType)le.hair,(SALT30.StrType)le.hair_length,(SALT30.StrType)le.eyes,(SALT30.StrType)le.hand_use,(SALT30.StrType)le.speech,(SALT30.StrType)le.teeth,(SALT30.StrType)le.physical_condition,(SALT30.StrType)le.build,(SALT30.StrType)le.complexion,(SALT30.StrType)le.facial_hair,(SALT30.StrType)le.hat,(SALT30.StrType)le.mask,(SALT30.StrType)le.glasses,(SALT30.StrType)le.appearance,(SALT30.StrType)le.shirt,(SALT30.StrType)le.pants,(SALT30.StrType)le.shoes,(SALT30.StrType)le.jacket,(SALT30.StrType)le.weight_1,(SALT30.StrType)le.weight_2,(SALT30.StrType)le.height_1,(SALT30.StrType)le.height_2,(SALT30.StrType)le.age_1,(SALT30.StrType)le.age_2,(SALT30.StrType)le.offenders_sid,(SALT30.StrType)le.dl_number,(SALT30.StrType)le.dl_state,(SALT30.StrType)le.fbi_number,(SALT30.StrType)le.offender_notes,(SALT30.StrType)le.clean_edit_date,(SALT30.StrType)le.quarantined,(SALT30.StrType)le.admin_state,(SALT30.StrType)le.agency_name,(SALT30.StrType)le.user_text_1,(SALT30.StrType)le.user_text_2,(SALT30.StrType)le.user_integer,(SALT30.StrType)le.user_float,(SALT30.StrType)le.clean_user_datetime,(SALT30.StrType)le.agency_category,(SALT30.StrType)le.agency_level,(SALT30.StrType)le.agency_score,(SALT30.StrType)le.bair_score,(SALT30.StrType)le.case_reference_number,(SALT30.StrType)le.charge_offense,(SALT30.StrType)le.probation_type,(SALT30.StrType)le.probation_officer,(SALT30.StrType)le.warrant_type,(SALT30.StrType)le.warrant_number,(SALT30.StrType)le.gang_name,(SALT30.StrType)le.clean_classification_date,(SALT30.StrType)le.clean_expiration_date,SKIP,SKIP);
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
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','etype','agency_offender_id','address','first_name','middle_name','last_name','moniker','name_type','clean_dob','race','sex','hair','hair_length','eyes','hand_use','speech','teeth','physical_condition','build','complexion','facial_hair','hat','mask','glasses','appearance','shirt','pants','shoes','jacket','weight_1','weight_2','height_1','height_2','age_1','age_2','offenders_sid','dl_number','dl_state','fbi_number','offender_notes','clean_edit_date','quarantined','admin_state','agency_name','user_text_1','user_text_2','user_integer','user_float','clean_user_datetime','agency_category','agency_level','agency_score','bair_score','case_reference_number','charge_offense','probation_type','probation_officer','warrant_type','warrant_number','gang_name','clean_classification_date','clean_expiration_date','DATE'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,66,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('agency_offender_id'),'agency_offender_id',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency_offender_id')]}
  ,{text_search.MakeShortSeg('address'),'address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('address')]}
  ,{text_search.MakeShortSeg('first_name'),'first_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('first_name')]}
  ,{text_search.MakeShortSeg('middle_name'),'middle_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('middle_name')]}
  ,{text_search.MakeShortSeg('last_name'),'last_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('last_name')]}
  ,{text_search.MakeShortSeg('moniker'),'moniker',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('moniker')]}
  ,{text_search.MakeShortSeg('name_type'),'name_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name_type')]}
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
  ,{text_search.MakeShortSeg('weight_1'),'weight_1',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('weight_1')]}
  ,{text_search.MakeShortSeg('weight_2'),'weight_2',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('weight_2')]}
  ,{text_search.MakeShortSeg('height_1'),'height_1',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('height_1')]}
  ,{text_search.MakeShortSeg('height_2'),'height_2',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('height_2')]}
  ,{text_search.MakeShortSeg('age_1'),'age_1',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('age_1')]}
  ,{text_search.MakeShortSeg('age_2'),'age_2',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('age_2')]}
  ,{text_search.MakeShortSeg('offenders_sid'),'offenders_sid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('offenders_sid')]}
  ,{text_search.MakeShortSeg('dl_number'),'dl_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('dl_number')]}
  ,{text_search.MakeShortSeg('dl_state'),'dl_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('dl_state')]}
  ,{text_search.MakeShortSeg('fbi_number'),'fbi_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fbi_number')]}
  ,{text_search.MakeShortSeg('offender_notes'),'offender_notes',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('offender_notes')]}
  ,{text_search.MakeShortSeg('clean_edit_date'),'clean_edit_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_edit_date')]}
  ,{text_search.MakeShortSeg('quarantined'),'quarantined',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('quarantined')]}
  ,{text_search.MakeShortSeg('admin_state'),'admin_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('admin_state')]}
  ,{text_search.MakeShortSeg('agency_name'),'agency_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency_name')]}
  ,{text_search.MakeShortSeg('user_text_1'),'user_text_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('user_text_1')]}
  ,{text_search.MakeShortSeg('user_text_2'),'user_text_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('user_text_2')]}
  ,{text_search.MakeShortSeg('user_integer'),'user_integer',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('user_integer')]}
  ,{text_search.MakeShortSeg('user_float'),'user_float',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('user_float')]}
  ,{text_search.MakeShortSeg('clean_user_datetime'),'clean_user_datetime',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_user_datetime')]}
  ,{text_search.MakeShortSeg('agency_category'),'agency_category',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency_category')]}
  ,{text_search.MakeShortSeg('agency_level'),'agency_level',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency_level')]}
  ,{text_search.MakeShortSeg('agency_score'),'agency_score',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency_score')]}
  ,{text_search.MakeShortSeg('bair_score'),'bair_score',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('bair_score')]}
  ,{text_search.MakeShortSeg('case_reference_number'),'case_reference_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('case_reference_number')]}
  ,{text_search.MakeShortSeg('charge_offense'),'charge_offense',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('charge_offense')]}
  ,{text_search.MakeShortSeg('probation_type'),'probation_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('probation_type')]}
  ,{text_search.MakeShortSeg('probation_officer'),'probation_officer',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('probation_officer')]}
  ,{text_search.MakeShortSeg('warrant_type'),'warrant_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('warrant_type')]}
  ,{text_search.MakeShortSeg('warrant_number'),'warrant_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('warrant_number')]}
  ,{text_search.MakeShortSeg('gang_name'),'gang_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gang_name')]}
  ,{text_search.MakeShortSeg('clean_classification_date'),'clean_classification_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_classification_date')]}
  ,{text_search.MakeShortSeg('clean_expiration_date'),'clean_expiration_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_expiration_date')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('clean_classification_date')]}
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

