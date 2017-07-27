IMPORT text_search,ut,SALT30,MDR;
 
EXPORT crash_baseBooleanSearch(DATASET(layout_crash_base) ih)  := MODULE
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
    h.id;
    h.data_provider_id;
    h.case_number;
    h.reportnumber;
    h.clean_report_date;
    h.address;
    h.county;
    h.crash_city;
    h.crash_state;
    h.hitandrun;
    h.intersectionrelated;
    h.officername;
    h.crashtype;
    h.locationtype;
    h.x;
    h.y;
    h.accidentclass;
    h.specialcircumstance1;
    h.specialcircumstance2;
    h.specialcircumstance3;
    h.lightcondition;
    h.weathercondition;
    h.surfacetype;
    h.roadspecialfeature1;
    h.roadspecialfeature2;
    h.roadspecialfeature3;
    h.surfacecondition;
    h.trafficcontrolpresent;
    h.narrative;
    h.vehicleid;
    h.vin;
    h.plate;
    h.platestate;
    h.year;
    h.make;
    h.model;
    h.towed;
    h.vehicle_type;
    h.damage;
    h.action;
    h.sequence;
    h.driverimpairment;
    h.first_name;
    h.last_name;
    h.per_crashid;
    h.driveractions;
    h.licensenumber;
    h.licensestate;
    h.airbag;
    h.race;
    h.sex;
    h.age;
    h.seatbelt;
    h.per_city;
    h.per_state;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','0','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.etype,(SALT30.StrType)le.id,(SALT30.StrType)le.data_provider_id,(SALT30.StrType)le.case_number,(SALT30.StrType)le.reportnumber,(SALT30.StrType)le.clean_report_date,(SALT30.StrType)le.address,(SALT30.StrType)le.county,(SALT30.StrType)le.crash_city,(SALT30.StrType)le.crash_state,(SALT30.StrType)le.hitandrun,(SALT30.StrType)le.intersectionrelated,(SALT30.StrType)le.officername,(SALT30.StrType)le.crashtype,(SALT30.StrType)le.locationtype,(SALT30.StrType)le.x,(SALT30.StrType)le.y,(SALT30.StrType)le.accidentclass,(SALT30.StrType)le.specialcircumstance1,(SALT30.StrType)le.specialcircumstance2,(SALT30.StrType)le.specialcircumstance3,(SALT30.StrType)le.lightcondition,(SALT30.StrType)le.weathercondition,(SALT30.StrType)le.surfacetype,(SALT30.StrType)le.roadspecialfeature1,(SALT30.StrType)le.roadspecialfeature2,(SALT30.StrType)le.roadspecialfeature3,(SALT30.StrType)le.surfacecondition,(SALT30.StrType)le.trafficcontrolpresent,(SALT30.StrType)le.narrative,(SALT30.StrType)le.vehicleid,(SALT30.StrType)le.vin,(SALT30.StrType)le.plate,(SALT30.StrType)le.platestate,(SALT30.StrType)le.year,(SALT30.StrType)le.make,(SALT30.StrType)le.model,(SALT30.StrType)le.towed,(SALT30.StrType)le.vehicle_type,(SALT30.StrType)le.damage,(SALT30.StrType)le.action,(SALT30.StrType)le.sequence,(SALT30.StrType)le.driverimpairment,(SALT30.StrType)le.first_name,(SALT30.StrType)le.last_name,(SALT30.StrType)le.per_crashid,(SALT30.StrType)le.driveractions,(SALT30.StrType)le.licensenumber,(SALT30.StrType)le.licensestate,(SALT30.StrType)le.airbag,(SALT30.StrType)le.race,(SALT30.StrType)le.sex,(SALT30.StrType)le.age,(SALT30.StrType)le.seatbelt,(SALT30.StrType)le.per_city,(SALT30.StrType)le.per_state,SKIP,SKIP,SKIP);
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
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','etype','id','data_provider_id','case_number','reportnumber','clean_report_date','address','county','crash_city','crash_state','hitandrun','intersectionrelated','officername','crashtype','locationtype','x','y','accidentclass','specialcircumstance1','specialcircumstance2','specialcircumstance3','lightcondition','weathercondition','surfacetype','roadspecialfeature1','roadspecialfeature2','roadspecialfeature3','surfacecondition','trafficcontrolpresent','narrative','vehicleid','vin','plate','platestate','year','make','model','towed','vehicle_type','damage','action','sequence','driverimpairment','first_name','last_name','per_crashid','driveractions','licensenumber','licensestate','airbag','race','sex','age','seatbelt','per_city','per_state','NOTES','DATE'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,61,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('id'),'id',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('id')]}
  ,{text_search.MakeShortSeg('data_provider_id'),'data_provider_id',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('data_provider_id')]}
  ,{text_search.MakeShortSeg('case_number'),'case_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('case_number')]}
  ,{text_search.MakeShortSeg('reportnumber'),'reportnumber',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('reportnumber')]}
  ,{text_search.MakeShortSeg('clean_report_date'),'clean_report_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_report_date')]}
  ,{text_search.MakeShortSeg('address'),'address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('address')]}
  ,{text_search.MakeShortSeg('county'),'county',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('county')]}
  ,{text_search.MakeShortSeg('crash_city'),'crash_city',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('crash_city')]}
  ,{text_search.MakeShortSeg('crash_state'),'crash_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('crash_state')]}
  ,{text_search.MakeShortSeg('hitandrun'),'hitandrun',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('hitandrun')]}
  ,{text_search.MakeShortSeg('intersectionrelated'),'intersectionrelated',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('intersectionrelated')]}
  ,{text_search.MakeShortSeg('officername'),'officername',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('officername')]}
  ,{text_search.MakeShortSeg('crashtype'),'crashtype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('crashtype')]}
  ,{text_search.MakeShortSeg('locationtype'),'locationtype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('locationtype')]}
  ,{text_search.MakeShortSeg('x'),'x',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('x')]}
  ,{text_search.MakeShortSeg('y'),'y',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('y')]}
  ,{text_search.MakeShortSeg('accidentclass'),'accidentclass',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('accidentclass')]}
  ,{text_search.MakeShortSeg('specialcircumstance1'),'specialcircumstance1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('specialcircumstance1')]}
  ,{text_search.MakeShortSeg('specialcircumstance2'),'specialcircumstance2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('specialcircumstance2')]}
  ,{text_search.MakeShortSeg('specialcircumstance3'),'specialcircumstance3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('specialcircumstance3')]}
  ,{text_search.MakeShortSeg('lightcondition'),'lightcondition',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lightcondition')]}
  ,{text_search.MakeShortSeg('weathercondition'),'weathercondition',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('weathercondition')]}
  ,{text_search.MakeShortSeg('surfacetype'),'surfacetype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('surfacetype')]}
  ,{text_search.MakeShortSeg('roadspecialfeature1'),'roadspecialfeature1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('roadspecialfeature1')]}
  ,{text_search.MakeShortSeg('roadspecialfeature2'),'roadspecialfeature2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('roadspecialfeature2')]}
  ,{text_search.MakeShortSeg('roadspecialfeature3'),'roadspecialfeature3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('roadspecialfeature3')]}
  ,{text_search.MakeShortSeg('surfacecondition'),'surfacecondition',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('surfacecondition')]}
  ,{text_search.MakeShortSeg('trafficcontrolpresent'),'trafficcontrolpresent',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('trafficcontrolpresent')]}
  ,{text_search.MakeShortSeg('narrative'),'narrative',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('narrative')]}
  ,{text_search.MakeShortSeg('vehicleid'),'vehicleid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicleid')]}
  ,{text_search.MakeShortSeg('vin'),'vin',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vin')]}
  ,{text_search.MakeShortSeg('plate'),'plate',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('plate')]}
  ,{text_search.MakeShortSeg('platestate'),'platestate',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('platestate')]}
  ,{text_search.MakeShortSeg('year'),'year',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('year')]}
  ,{text_search.MakeShortSeg('make'),'make',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('make')]}
  ,{text_search.MakeShortSeg('model'),'model',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('model')]}
  ,{text_search.MakeShortSeg('towed'),'towed',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('towed')]}
  ,{text_search.MakeShortSeg('vehicle_type'),'vehicle_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_type')]}
  ,{text_search.MakeShortSeg('damage'),'damage',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('damage')]}
  ,{text_search.MakeShortSeg('action'),'action',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('action')]}
  ,{text_search.MakeShortSeg('sequence'),'sequence',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sequence')]}
  ,{text_search.MakeShortSeg('driverimpairment'),'driverimpairment',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('driverimpairment')]}
  ,{text_search.MakeShortSeg('first_name'),'first_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('first_name')]}
  ,{text_search.MakeShortSeg('last_name'),'last_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('last_name')]}
  ,{text_search.MakeShortSeg('per_crashid'),'per_crashid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('per_crashid')]}
  ,{text_search.MakeShortSeg('driveractions'),'driveractions',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('driveractions')]}
  ,{text_search.MakeShortSeg('licensenumber'),'licensenumber',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('licensenumber')]}
  ,{text_search.MakeShortSeg('licensestate'),'licensestate',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('licensestate')]}
  ,{text_search.MakeShortSeg('airbag'),'airbag',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('airbag')]}
  ,{text_search.MakeShortSeg('race'),'race',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('race')]}
  ,{text_search.MakeShortSeg('sex'),'sex',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sex')]}
  ,{text_search.MakeShortSeg('age'),'age',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('age')]}
  ,{text_search.MakeShortSeg('seatbelt'),'seatbelt',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seatbelt')]}
  ,{text_search.MakeShortSeg('per_city'),'per_city',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('per_city')]}
  ,{text_search.MakeShortSeg('per_state'),'per_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('per_state')]}
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('narrative')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('clean_report_date')]}
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

