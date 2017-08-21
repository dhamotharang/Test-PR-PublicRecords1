IMPORT text_search,ut,SALT30,MDR;
 
EXPORT cfs_baseBooleanSearch(DATASET(layout_cfs_base) ih)  := MODULE
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
    h.cfs_id;
    h.ori;
    h.event_number;
    h.caller_address;
    h.address;
    h.place_name;
    h.wc_location_type;
    h.location_type;
    h.wc_district;
    h.district;
    h.wc_beat;
    h.beat;
    h.wc_rd;
    h.rd;
    h.wc_how_received;
    h.how_received;
    h.wc_initial_type;
    h.initial_type;
    h.wc_final_type;
    h.final_type;
    h.incident_code;
    h.wc_incident_progress;
    h.incident_progress;
    h.city;
    h.call_taker;
    h.contacting_officer;
    h.complainant;
    h.status;
    h.apartment_number;
    h.total_minutes_on_call;
    h.accuracy;
    h.minutes_on_call;
    h.minutes_response;
    h.wc_unit;
    h.unit;
    h.officer_name;
    h.primary_officer;
    h.dispatcher_comments;
    h.synopsis;
    h.agency;
    h.data_provider_ori;
    h.clean_current_phone;
    h.complainant_address;
    h.clean_date_time_received;
    h.clean_date_time_archived;
    h.clean_date_time_dispatched;
    h.clean_date_time_enroute;
    h.clean_date_time_arrived;
    h.clean_date_time_cleared;
    h.primaryrec;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.gh4,(SALT30.StrType)le.gh5,(SALT30.StrType)le.gh6,(SALT30.StrType)le.etype,(SALT30.StrType)le.cfs_id,(SALT30.StrType)le.ori,(SALT30.StrType)le.event_number,(SALT30.StrType)le.caller_address,(SALT30.StrType)le.address,(SALT30.StrType)le.place_name,(SALT30.StrType)le.wc_location_type,(SALT30.StrType)le.location_type,(SALT30.StrType)le.wc_district,(SALT30.StrType)le.district,(SALT30.StrType)le.wc_beat,(SALT30.StrType)le.beat,(SALT30.StrType)le.wc_rd,(SALT30.StrType)le.rd,(SALT30.StrType)le.wc_how_received,(SALT30.StrType)le.how_received,(SALT30.StrType)le.wc_initial_type,(SALT30.StrType)le.initial_type,(SALT30.StrType)le.wc_final_type,(SALT30.StrType)le.final_type,(SALT30.StrType)le.incident_code,(SALT30.StrType)le.wc_incident_progress,(SALT30.StrType)le.incident_progress,(SALT30.StrType)le.city,(SALT30.StrType)le.call_taker,(SALT30.StrType)le.contacting_officer,(SALT30.StrType)le.complainant,(SALT30.StrType)le.status,(SALT30.StrType)le.apartment_number,(SALT30.StrType)le.total_minutes_on_call,(SALT30.StrType)le.accuracy,(SALT30.StrType)le.minutes_on_call,(SALT30.StrType)le.minutes_response,(SALT30.StrType)le.wc_unit,(SALT30.StrType)le.unit,(SALT30.StrType)le.officer_name,(SALT30.StrType)le.primary_officer,(SALT30.StrType)le.dispatcher_comments,(SALT30.StrType)le.synopsis,(SALT30.StrType)le.agency,(SALT30.StrType)le.data_provider_ori,(SALT30.StrType)le.clean_current_phone,(SALT30.StrType)le.complainant_address,(SALT30.StrType)le.clean_date_time_received,(SALT30.StrType)le.clean_date_time_archived,(SALT30.StrType)le.clean_date_time_dispatched,(SALT30.StrType)le.clean_date_time_enroute,(SALT30.StrType)le.clean_date_time_arrived,(SALT30.StrType)le.clean_date_time_cleared,SKIP,SKIP,(SALT30.StrType)le.primaryrec,SKIP);
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
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','gh4','gh5','gh6','etype','cfs_id','ori','event_number','caller_address','address','place_name','wc_location_type','location_type','wc_district','district','wc_beat','beat','wc_rd','rd','wc_how_received','how_received','wc_initial_type','initial_type','wc_final_type','final_type','incident_code','wc_incident_progress','incident_progress','city','call_taker','contacting_officer','complainant','status','apartment_number','total_minutes_on_call','accuracy','minutes_on_call','minutes_response','wc_unit','unit','officer_name','primary_officer','dispatcher_comments','synopsis','agency','data_provider_ori','clean_current_phone','complainant_address','clean_date_time_received','clean_date_time_archived','clean_date_time_dispatched','clean_date_time_enroute','clean_date_time_arrived','clean_date_time_cleared','NOTES','DATE','primaryrec'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,59,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('gh4'),'gh4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh4')]}
  ,{text_search.MakeShortSeg('gh5'),'gh5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh5')]}
  ,{text_search.MakeShortSeg('gh6'),'gh6',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh6')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('cfs_id'),'cfs_id',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cfs_id')]}
  ,{text_search.MakeShortSeg('ori'),'ori',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('ori')]}
  ,{text_search.MakeShortSeg('event_number'),'event_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('event_number')]}
  ,{text_search.MakeShortSeg('caller_address'),'caller_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('caller_address')]}
  ,{text_search.MakeShortSeg('address'),'address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('address')]}
  ,{text_search.MakeShortSeg('place_name'),'place_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('place_name')]}
  ,{text_search.MakeShortSeg('wc_location_type'),'wc_location_type',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_location_type')]}
  ,{text_search.MakeShortSeg('location_type'),'location_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('location_type')]}
  ,{text_search.MakeShortSeg('wc_district'),'wc_district',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_district')]}
  ,{text_search.MakeShortSeg('district'),'district',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('district')]}
  ,{text_search.MakeShortSeg('wc_beat'),'wc_beat',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_beat')]}
  ,{text_search.MakeShortSeg('beat'),'beat',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('beat')]}
  ,{text_search.MakeShortSeg('wc_rd'),'wc_rd',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_rd')]}
  ,{text_search.MakeShortSeg('rd'),'rd',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('rd')]}
  ,{text_search.MakeShortSeg('wc_how_received'),'wc_how_received',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_how_received')]}
  ,{text_search.MakeShortSeg('how_received'),'how_received',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('how_received')]}
  ,{text_search.MakeShortSeg('wc_initial_type'),'wc_initial_type',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_initial_type')]}
  ,{text_search.MakeShortSeg('initial_type'),'initial_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('initial_type')]}
  ,{text_search.MakeShortSeg('wc_final_type'),'wc_final_type',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_final_type')]}
  ,{text_search.MakeShortSeg('final_type'),'final_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('final_type')]}
  ,{text_search.MakeShortSeg('incident_code'),'incident_code',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('incident_code')]}
  ,{text_search.MakeShortSeg('wc_incident_progress'),'wc_incident_progress',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_incident_progress')]}
  ,{text_search.MakeShortSeg('incident_progress'),'incident_progress',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('incident_progress')]}
  ,{text_search.MakeShortSeg('city'),'city',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('city')]}
  ,{text_search.MakeShortSeg('call_taker'),'call_taker',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('call_taker')]}
  ,{text_search.MakeShortSeg('contacting_officer'),'contacting_officer',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('contacting_officer')]}
  ,{text_search.MakeShortSeg('complainant'),'complainant',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('complainant')]}
  ,{text_search.MakeShortSeg('status'),'status',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('status')]}
  ,{text_search.MakeShortSeg('apartment_number'),'apartment_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('apartment_number')]}
  ,{text_search.MakeShortSeg('total_minutes_on_call'),'total_minutes_on_call',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('total_minutes_on_call')]}
  ,{text_search.MakeShortSeg('accuracy'),'accuracy',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('accuracy')]}
  ,{text_search.MakeShortSeg('minutes_on_call'),'minutes_on_call',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('minutes_on_call')]}
  ,{text_search.MakeShortSeg('minutes_response'),'minutes_response',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('minutes_response')]}
  ,{text_search.MakeShortSeg('wc_unit'),'wc_unit',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_unit')]}
  ,{text_search.MakeShortSeg('unit'),'unit',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('unit')]}
  ,{text_search.MakeShortSeg('officer_name'),'officer_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('officer_name')]}
  ,{text_search.MakeShortSeg('primary_officer'),'primary_officer',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('primary_officer')]}
  ,{text_search.MakeShortSeg('dispatcher_comments'),'dispatcher_comments',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('dispatcher_comments')]}
  ,{text_search.MakeShortSeg('synopsis'),'synopsis',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('synopsis')]}
  ,{text_search.MakeShortSeg('agency'),'agency',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency')]}
  ,{text_search.MakeShortSeg('data_provider_ori'),'data_provider_ori',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('data_provider_ori')]}
  ,{text_search.MakeShortSeg('clean_current_phone'),'clean_current_phone',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('clean_current_phone')]}
  ,{text_search.MakeShortSeg('complainant_address'),'complainant_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('complainant_address')]}
  ,{text_search.MakeShortSeg('clean_date_time_received'),'clean_date_time_received',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_date_time_received')]}
  ,{text_search.MakeShortSeg('clean_date_time_archived'),'clean_date_time_archived',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_date_time_archived')]}
  ,{text_search.MakeShortSeg('clean_date_time_dispatched'),'clean_date_time_dispatched',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_date_time_dispatched')]}
  ,{text_search.MakeShortSeg('clean_date_time_enroute'),'clean_date_time_enroute',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_date_time_enroute')]}
  ,{text_search.MakeShortSeg('clean_date_time_arrived'),'clean_date_time_arrived',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_date_time_arrived')]}
  ,{text_search.MakeShortSeg('clean_date_time_cleared'),'clean_date_time_cleared',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_date_time_cleared')]}
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('dispatcher_comments'),text_search.MakeShortSeg('synopsis')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('clean_date_time_received')]}
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

