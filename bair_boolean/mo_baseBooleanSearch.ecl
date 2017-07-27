IMPORT text_search,ut,SALT30,MDR;
 
EXPORT mo_baseBooleanSearch(DATASET(layout_mo_base) ih)  := MODULE
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
    h.crime;
    h.location_type;
    h.object_of_attack_1;
    h.object_of_attack_2;
    h.point_of_entry_1;
    h.point_of_entry_2;
    h.method_of_entry_1;
    h.method_of_entry_2;
    h.suspects_actions_against_person_1;
    h.suspects_actions_against_person_2;
    h.suspects_actions_against_person_3;
    h.suspects_actions_against_person_4;
    h.suspects_actions_against_person_5;
    h.suspects_actions_against_property_1;
    h.suspects_actions_against_property_2;
    h.suspects_actions_against_property_3;
    h.property_taken_1;
    h.property_taken_2;
    h.property_taken_3;
    h.property_value;
    h.weapon_type_1;
    h.weapon_type_2;
    h.method_of_departure;
    h.clean_first_date_time;
    h.clean_last_date_time;
    h.first_time;
    h.last_time;
    h.clean_report_date;
    h.first_day;
    h.last_day;
    h.address_of_crime;
    h.address_name;
    h.beat;
    h.rd;
    h.companions;
    h.apt;
    h.agency;
    h.accuracy;
    h.x_coordinate;
    h.y_coordinate;
    h.geocoded;
    h.synopsis_of_crime;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','','','','','','','0','','','','','','0','0','','','','','','','','0','','','','0','0','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.etype,(SALT30.StrType)le.ir_number,(SALT30.StrType)le.crime,(SALT30.StrType)le.location_type,(SALT30.StrType)le.object_of_attack_1,(SALT30.StrType)le.object_of_attack_2,(SALT30.StrType)le.point_of_entry_1,(SALT30.StrType)le.point_of_entry_2,(SALT30.StrType)le.method_of_entry_1,(SALT30.StrType)le.method_of_entry_2,(SALT30.StrType)le.suspects_actions_against_person_1,(SALT30.StrType)le.suspects_actions_against_person_2,(SALT30.StrType)le.suspects_actions_against_person_3,(SALT30.StrType)le.suspects_actions_against_person_4,(SALT30.StrType)le.suspects_actions_against_person_5,(SALT30.StrType)le.suspects_actions_against_property_1,(SALT30.StrType)le.suspects_actions_against_property_2,(SALT30.StrType)le.suspects_actions_against_property_3,(SALT30.StrType)le.property_taken_1,(SALT30.StrType)le.property_taken_2,(SALT30.StrType)le.property_taken_3,(SALT30.StrType)le.property_value,(SALT30.StrType)le.weapon_type_1,(SALT30.StrType)le.weapon_type_2,(SALT30.StrType)le.method_of_departure,(SALT30.StrType)le.clean_first_date_time,(SALT30.StrType)le.clean_last_date_time,(SALT30.StrType)le.first_time,(SALT30.StrType)le.last_time,(SALT30.StrType)le.clean_report_date,(SALT30.StrType)le.first_day,(SALT30.StrType)le.last_day,(SALT30.StrType)le.address_of_crime,(SALT30.StrType)le.address_name,(SALT30.StrType)le.beat,(SALT30.StrType)le.rd,(SALT30.StrType)le.companions,(SALT30.StrType)le.apt,(SALT30.StrType)le.agency,(SALT30.StrType)le.accuracy,(SALT30.StrType)le.x_coordinate,(SALT30.StrType)le.y_coordinate,(SALT30.StrType)le.geocoded,(SALT30.StrType)le.synopsis_of_crime,SKIP,SKIP,SKIP);
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
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','etype','ir_number','crime','location_type','object_of_attack_1','object_of_attack_2','point_of_entry_1','point_of_entry_2','method_of_entry_1','method_of_entry_2','suspects_actions_against_person_1','suspects_actions_against_person_2','suspects_actions_against_person_3','suspects_actions_against_person_4','suspects_actions_against_person_5','suspects_actions_against_property_1','suspects_actions_against_property_2','suspects_actions_against_property_3','property_taken_1','property_taken_2','property_taken_3','property_value','weapon_type_1','weapon_type_2','method_of_departure','clean_first_date_time','clean_last_date_time','first_time','last_time','clean_report_date','first_day','last_day','address_of_crime','address_name','beat','rd','companions','apt','agency','accuracy','x_coordinate','y_coordinate','geocoded','synopsis_of_crime','NOTES','DATE'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,49,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('ir_number'),'ir_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('ir_number')]}
  ,{text_search.MakeShortSeg('crime'),'crime',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('crime')]}
  ,{text_search.MakeShortSeg('location_type'),'location_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('location_type')]}
  ,{text_search.MakeShortSeg('object_of_attack_1'),'object_of_attack_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('object_of_attack_1')]}
  ,{text_search.MakeShortSeg('object_of_attack_2'),'object_of_attack_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('object_of_attack_2')]}
  ,{text_search.MakeShortSeg('point_of_entry_1'),'point_of_entry_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('point_of_entry_1')]}
  ,{text_search.MakeShortSeg('point_of_entry_2'),'point_of_entry_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('point_of_entry_2')]}
  ,{text_search.MakeShortSeg('method_of_entry_1'),'method_of_entry_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('method_of_entry_1')]}
  ,{text_search.MakeShortSeg('method_of_entry_2'),'method_of_entry_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('method_of_entry_2')]}
  ,{text_search.MakeShortSeg('suspects_actions_against_person_1'),'suspects_actions_against_person_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suspects_actions_against_person_1')]}
  ,{text_search.MakeShortSeg('suspects_actions_against_person_2'),'suspects_actions_against_person_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suspects_actions_against_person_2')]}
  ,{text_search.MakeShortSeg('suspects_actions_against_person_3'),'suspects_actions_against_person_3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suspects_actions_against_person_3')]}
  ,{text_search.MakeShortSeg('suspects_actions_against_person_4'),'suspects_actions_against_person_4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suspects_actions_against_person_4')]}
  ,{text_search.MakeShortSeg('suspects_actions_against_person_5'),'suspects_actions_against_person_5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suspects_actions_against_person_5')]}
  ,{text_search.MakeShortSeg('suspects_actions_against_property_1'),'suspects_actions_against_property_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suspects_actions_against_property_1')]}
  ,{text_search.MakeShortSeg('suspects_actions_against_property_2'),'suspects_actions_against_property_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suspects_actions_against_property_2')]}
  ,{text_search.MakeShortSeg('suspects_actions_against_property_3'),'suspects_actions_against_property_3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suspects_actions_against_property_3')]}
  ,{text_search.MakeShortSeg('property_taken_1'),'property_taken_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_taken_1')]}
  ,{text_search.MakeShortSeg('property_taken_2'),'property_taken_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_taken_2')]}
  ,{text_search.MakeShortSeg('property_taken_3'),'property_taken_3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_taken_3')]}
  ,{text_search.MakeShortSeg('property_value'),'property_value',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('property_value')]}
  ,{text_search.MakeShortSeg('weapon_type_1'),'weapon_type_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('weapon_type_1')]}
  ,{text_search.MakeShortSeg('weapon_type_2'),'weapon_type_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('weapon_type_2')]}
  ,{text_search.MakeShortSeg('method_of_departure'),'method_of_departure',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('method_of_departure')]}
  ,{text_search.MakeShortSeg('clean_first_date_time'),'clean_first_date_time',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_first_date_time')]}
  ,{text_search.MakeShortSeg('clean_last_date_time'),'clean_last_date_time',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_last_date_time')]}
  ,{text_search.MakeShortSeg('first_time'),'first_time',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('first_time')]}
  ,{text_search.MakeShortSeg('last_time'),'last_time',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('last_time')]}
  ,{text_search.MakeShortSeg('clean_report_date'),'clean_report_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_report_date')]}
  ,{text_search.MakeShortSeg('first_day'),'first_day',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('first_day')]}
  ,{text_search.MakeShortSeg('last_day'),'last_day',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('last_day')]}
  ,{text_search.MakeShortSeg('address_of_crime'),'address_of_crime',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('address_of_crime')]}
  ,{text_search.MakeShortSeg('address_name'),'address_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('address_name')]}
  ,{text_search.MakeShortSeg('beat'),'beat',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('beat')]}
  ,{text_search.MakeShortSeg('rd'),'rd',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('rd')]}
  ,{text_search.MakeShortSeg('companions'),'companions',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('companions')]}
  ,{text_search.MakeShortSeg('apt'),'apt',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('apt')]}
  ,{text_search.MakeShortSeg('agency'),'agency',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency')]}
  ,{text_search.MakeShortSeg('accuracy'),'accuracy',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('accuracy')]}
  ,{text_search.MakeShortSeg('x_coordinate'),'x_coordinate',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('x_coordinate')]}
  ,{text_search.MakeShortSeg('y_coordinate'),'y_coordinate',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('y_coordinate')]}
  ,{text_search.MakeShortSeg('geocoded'),'geocoded',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('geocoded')]}
  ,{text_search.MakeShortSeg('synopsis_of_crime'),'synopsis_of_crime',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('synopsis_of_crime')]}
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('synopsis_of_crime')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('clean_first_date_time')]}
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

