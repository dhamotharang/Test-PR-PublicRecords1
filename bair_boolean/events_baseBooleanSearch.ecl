IMPORT text_search,ut,SALT30,MDR;
 
EXPORT events_baseBooleanSearch(DATASET(layout_events_base) ih)  := MODULE
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
    h.ir_number;
    h.class_code;
    h.wc_crime;
    h.crime;
    h.wc_location_type;
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
    h.wc_property_taken_1;
    h.property_taken_1;
    h.wc_property_taken_2;
    h.property_taken_2;
    h.wc_property_taken_3;
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
    h.wc_address_of_crime;
    h.address_of_crime;
    h.wc_address_name;
    h.address_name;
    h.wc_beat;
    h.beat;
    h.wc_rd;
    h.rd;
    h.companions;
    h.agency;
    h.accuracy;
    h.geocoded;
    h.synopsis_of_crime;
    h.Sequence;
    h.Interval;
    h.Commonalities;
    h.clean_edit_date;
    h.ORI;
    h.Raids;
    h.data_provider_ori;
    h.name_type;
    h.last_name;
    h.first_name;
    h.middle_name;
    h.moniker;
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
    h.persons_address;
    h.weight_1;
    h.weight_2;
    h.height_1;
    h.height_2;
    h.age_1;
    h.age_2;
    h.recordid_raids;
    h.wc_plate;
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
    h.moudf1;
    h.moudf2;
    h.moudf3;
    h.moudf4;
    h.moudf5;
    h.moudf6;
    h.moudf7;
    h.moudf8;
    h.personudf1;
    h.personudf2;
    h.personudf3;
    h.personudf4;
    h.primaryrec;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.gh4,(SALT30.StrType)le.gh5,(SALT30.StrType)le.gh6,(SALT30.StrType)le.etype,(SALT30.StrType)le.ir_number,(SALT30.StrType)le.class_code,(SALT30.StrType)le.wc_crime,(SALT30.StrType)le.crime,(SALT30.StrType)le.wc_location_type,(SALT30.StrType)le.location_type,(SALT30.StrType)le.object_of_attack_1,(SALT30.StrType)le.object_of_attack_2,(SALT30.StrType)le.point_of_entry_1,(SALT30.StrType)le.point_of_entry_2,(SALT30.StrType)le.method_of_entry_1,(SALT30.StrType)le.method_of_entry_2,(SALT30.StrType)le.suspects_actions_against_person_1,(SALT30.StrType)le.suspects_actions_against_person_2,(SALT30.StrType)le.suspects_actions_against_person_3,(SALT30.StrType)le.suspects_actions_against_person_4,(SALT30.StrType)le.suspects_actions_against_person_5,(SALT30.StrType)le.suspects_actions_against_property_1,(SALT30.StrType)le.suspects_actions_against_property_2,(SALT30.StrType)le.suspects_actions_against_property_3,(SALT30.StrType)le.wc_property_taken_1,(SALT30.StrType)le.property_taken_1,(SALT30.StrType)le.wc_property_taken_2,(SALT30.StrType)le.property_taken_2,(SALT30.StrType)le.wc_property_taken_3,(SALT30.StrType)le.property_taken_3,(SALT30.StrType)le.property_value,(SALT30.StrType)le.weapon_type_1,(SALT30.StrType)le.weapon_type_2,(SALT30.StrType)le.method_of_departure,(SALT30.StrType)le.clean_first_date_time,(SALT30.StrType)le.clean_last_date_time,(SALT30.StrType)le.first_time,(SALT30.StrType)le.last_time,(SALT30.StrType)le.clean_report_date,(SALT30.StrType)le.first_day,(SALT30.StrType)le.last_day,(SALT30.StrType)le.wc_address_of_crime,(SALT30.StrType)le.address_of_crime,(SALT30.StrType)le.wc_address_name,(SALT30.StrType)le.address_name,(SALT30.StrType)le.wc_beat,(SALT30.StrType)le.beat,(SALT30.StrType)le.wc_rd,(SALT30.StrType)le.rd,(SALT30.StrType)le.companions,(SALT30.StrType)le.agency,(SALT30.StrType)le.accuracy,(SALT30.StrType)le.geocoded,(SALT30.StrType)le.synopsis_of_crime,(SALT30.StrType)le.Sequence,(SALT30.StrType)le.Interval,(SALT30.StrType)le.Commonalities,(SALT30.StrType)le.clean_edit_date,(SALT30.StrType)le.ORI,(SALT30.StrType)le.Raids,(SALT30.StrType)le.data_provider_ori,(SALT30.StrType)le.name_type,(SALT30.StrType)le.last_name,(SALT30.StrType)le.first_name,(SALT30.StrType)le.middle_name,(SALT30.StrType)le.moniker,(SALT30.StrType)le.clean_dob,(SALT30.StrType)le.race,(SALT30.StrType)le.sex,(SALT30.StrType)le.hair,(SALT30.StrType)le.hair_length,(SALT30.StrType)le.eyes,(SALT30.StrType)le.hand_use,(SALT30.StrType)le.speech,(SALT30.StrType)le.teeth,(SALT30.StrType)le.physical_condition,(SALT30.StrType)le.build,(SALT30.StrType)le.complexion,(SALT30.StrType)le.facial_hair,(SALT30.StrType)le.hat,(SALT30.StrType)le.mask,(SALT30.StrType)le.glasses,(SALT30.StrType)le.appearance,(SALT30.StrType)le.shirt,(SALT30.StrType)le.pants,(SALT30.StrType)le.shoes,(SALT30.StrType)le.jacket,(SALT30.StrType)le.soundex,(SALT30.StrType)le.persons_notes,(SALT30.StrType)le.persons_address,(SALT30.StrType)le.weight_1,(SALT30.StrType)le.weight_2,(SALT30.StrType)le.height_1,(SALT30.StrType)le.height_2,(SALT30.StrType)le.age_1,(SALT30.StrType)le.age_2,(SALT30.StrType)le.recordid_raids,(SALT30.StrType)le.wc_plate,(SALT30.StrType)le.plate,(SALT30.StrType)le.plate_state,(SALT30.StrType)le.make,(SALT30.StrType)le.model,(SALT30.StrType)le.style,(SALT30.StrType)le.color,(SALT30.StrType)le.year,(SALT30.StrType)le.type,(SALT30.StrType)le.vehicle_status,(SALT30.StrType)le.vehicle_address,(SALT30.StrType)le.description,SKIP,SKIP,SKIP,SKIP,(SALT30.StrType)le.moudf1,(SALT30.StrType)le.moudf2,(SALT30.StrType)le.moudf3,(SALT30.StrType)le.moudf4,(SALT30.StrType)le.moudf5,(SALT30.StrType)le.moudf6,(SALT30.StrType)le.moudf7,(SALT30.StrType)le.moudf8,(SALT30.StrType)le.personudf1,(SALT30.StrType)le.personudf2,(SALT30.StrType)le.personudf3,(SALT30.StrType)le.personudf4,(SALT30.StrType)le.primaryrec,SKIP);
  SELF.len := LENGTH(TRIM(SELF.word));
  SELF.wip := IF(SELF.Word=Def(c-1),SKIP,1); // Adjusted later - also filters blank words
  SELF.nominal := 0; //Filled in later
  self.suffix := 0; // Filled in later
  self.part := thorlib.node();
  SELF.kwp := 0; // Adjusted later
  SELF.docref.doc := 0; // Filled in later
  SELF.docref.src := 0; // Filled in later
  SELF.src := TRANSFER(le.etype,UNSIGNED2); // Namespace for ID provided
  SELF.seg := c; // Field number is seg; values filled in in segment definition
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','gh4','gh5','gh6','etype','ir_number','class_code','wc_crime','crime','wc_location_type','location_type','object_of_attack_1','object_of_attack_2','point_of_entry_1','point_of_entry_2','method_of_entry_1','method_of_entry_2','suspects_actions_against_person_1','suspects_actions_against_person_2','suspects_actions_against_person_3','suspects_actions_against_person_4','suspects_actions_against_person_5','suspects_actions_against_property_1','suspects_actions_against_property_2','suspects_actions_against_property_3','wc_property_taken_1','property_taken_1','wc_property_taken_2','property_taken_2','wc_property_taken_3','property_taken_3','property_value','weapon_type_1','weapon_type_2','method_of_departure','clean_first_date_time','clean_last_date_time','first_time','last_time','clean_report_date','first_day','last_day','wc_address_of_crime','address_of_crime','wc_address_name','address_name','wc_beat','beat','wc_rd','rd','companions','agency','accuracy','geocoded','synopsis_of_crime','Sequence','Interval','Commonalities','clean_edit_date','ORI','Raids','data_provider_ori','name_type','last_name','first_name','middle_name','moniker','clean_dob','race','sex','hair','hair_length','eyes','hand_use','speech','teeth','physical_condition','build','complexion','facial_hair','hat','mask','glasses','appearance','shirt','pants','shoes','jacket','soundex','persons_notes','persons_address','weight_1','weight_2','height_1','height_2','age_1','age_2','recordid_raids','wc_plate','plate','plate_state','make','model','style','color','year','type','vehicle_status','vehicle_address','description','NOTES','DATE','NOTES','NOTES','moudf1','moudf2','moudf3','moudf4','moudf5','moudf6','moudf7','moudf8','personudf1','personudf2','personudf3','personudf4','primaryrec'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,129,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('gh4'),'gh4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh4')]}
  ,{text_search.MakeShortSeg('gh5'),'gh5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh5')]}
  ,{text_search.MakeShortSeg('gh6'),'gh6',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh6')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('ir_number'),'ir_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('ir_number')]}
  ,{text_search.MakeShortSeg('class_code'),'class_code',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('class_code')]}
  ,{text_search.MakeShortSeg('wc_crime'),'wc_crime',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_crime')]}
  ,{text_search.MakeShortSeg('crime'),'crime',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('crime')]}
  ,{text_search.MakeShortSeg('wc_location_type'),'wc_location_type',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_location_type')]}
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
  ,{text_search.MakeShortSeg('wc_property_taken_1'),'wc_property_taken_1',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_property_taken_1')]}
  ,{text_search.MakeShortSeg('property_taken_1'),'property_taken_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_taken_1')]}
  ,{text_search.MakeShortSeg('wc_property_taken_2'),'wc_property_taken_2',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_property_taken_2')]}
  ,{text_search.MakeShortSeg('property_taken_2'),'property_taken_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_taken_2')]}
  ,{text_search.MakeShortSeg('wc_property_taken_3'),'wc_property_taken_3',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_property_taken_3')]}
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
  ,{text_search.MakeShortSeg('wc_address_of_crime'),'wc_address_of_crime',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_address_of_crime')]}
  ,{text_search.MakeShortSeg('address_of_crime'),'address_of_crime',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('address_of_crime')]}
  ,{text_search.MakeShortSeg('wc_address_name'),'wc_address_name',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_address_name')]}
  ,{text_search.MakeShortSeg('address_name'),'address_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('address_name')]}
  ,{text_search.MakeShortSeg('wc_beat'),'wc_beat',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_beat')]}
  ,{text_search.MakeShortSeg('beat'),'beat',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('beat')]}
  ,{text_search.MakeShortSeg('wc_rd'),'wc_rd',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_rd')]}
  ,{text_search.MakeShortSeg('rd'),'rd',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('rd')]}
  ,{text_search.MakeShortSeg('companions'),'companions',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('companions')]}
  ,{text_search.MakeShortSeg('agency'),'agency',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency')]}
  ,{text_search.MakeShortSeg('accuracy'),'accuracy',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('accuracy')]}
  ,{text_search.MakeShortSeg('geocoded'),'geocoded',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('geocoded')]}
  ,{text_search.MakeShortSeg('synopsis_of_crime'),'synopsis_of_crime',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('synopsis_of_crime')]}
  ,{text_search.MakeShortSeg('Sequence'),'Sequence',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('Sequence')]}
  ,{text_search.MakeShortSeg('Interval'),'Interval',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('Interval')]}
  ,{text_search.MakeShortSeg('Commonalities'),'Commonalities',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('Commonalities')]}
  ,{text_search.MakeShortSeg('clean_edit_date'),'clean_edit_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_edit_date')]}
  ,{text_search.MakeShortSeg('ORI'),'ORI',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('ORI')]}
  ,{text_search.MakeShortSeg('Raids'),'Raids',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('Raids')]}
  ,{text_search.MakeShortSeg('data_provider_ori'),'data_provider_ori',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('data_provider_ori')]}
  ,{text_search.MakeShortSeg('name_type'),'name_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name_type')]}
  ,{text_search.MakeShortSeg('last_name'),'last_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('last_name')]}
  ,{text_search.MakeShortSeg('first_name'),'first_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('first_name')]}
  ,{text_search.MakeShortSeg('middle_name'),'middle_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('middle_name')]}
  ,{text_search.MakeShortSeg('moniker'),'moniker',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('moniker')]}
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
  ,{text_search.MakeShortSeg('persons_address'),'persons_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('persons_address')]}
  ,{text_search.MakeShortSeg('weight_1'),'weight_1',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('weight_1')]}
  ,{text_search.MakeShortSeg('weight_2'),'weight_2',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('weight_2')]}
  ,{text_search.MakeShortSeg('height_1'),'height_1',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('height_1')]}
  ,{text_search.MakeShortSeg('height_2'),'height_2',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('height_2')]}
  ,{text_search.MakeShortSeg('age_1'),'age_1',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('age_1')]}
  ,{text_search.MakeShortSeg('age_2'),'age_2',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('age_2')]}
  ,{text_search.MakeShortSeg('recordid_raids'),'recordid_raids',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('recordid_raids')]}
  ,{text_search.MakeShortSeg('wc_plate'),'wc_plate',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_plate')]}
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
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('synopsis_of_crime')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('clean_first_date_time')]}
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('persons_notes')]}
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('description')]}
  ,{text_search.MakeShortSeg('moudf1'),'moudf1',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('moudf1')]}
  ,{text_search.MakeShortSeg('moudf2'),'moudf2',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('moudf2')]}
  ,{text_search.MakeShortSeg('moudf3'),'moudf3',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('moudf3')]}
  ,{text_search.MakeShortSeg('moudf4'),'moudf4',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('moudf4')]}
  ,{text_search.MakeShortSeg('moudf5'),'moudf5',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('moudf5')]}
  ,{text_search.MakeShortSeg('moudf6'),'moudf6',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('moudf6')]}
  ,{text_search.MakeShortSeg('moudf7'),'moudf7',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('moudf7')]}
  ,{text_search.MakeShortSeg('moudf8'),'moudf8',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('moudf8')]}
  ,{text_search.MakeShortSeg('personudf1'),'personudf1',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('personudf1')]}
  ,{text_search.MakeShortSeg('personudf2'),'personudf2',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('personudf2')]}
  ,{text_search.MakeShortSeg('personudf3'),'personudf3',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('personudf3')]}
  ,{text_search.MakeShortSeg('personudf4'),'personudf4',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('personudf4')]}
  ,{text_search.MakeShortSeg('primaryrec'),'primaryrec',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('primaryrec')]}
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

