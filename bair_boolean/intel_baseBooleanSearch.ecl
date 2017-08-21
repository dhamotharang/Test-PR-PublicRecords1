IMPORT text_search,ut,SALT30,MDR;
 
EXPORT intel_baseBooleanSearch(DATASET(layout_intel_base) ih)  := MODULE
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
    h.id;
    h.incident_id;
    h.name_type;
    h.clean_incident_date;
    h.incident_time;
    h.case_number;
    h.call_case_number;
    h.incident_address;
    h.incident_city;
    h.incident_state;
    h.incident_zip;
    h.wc_address_name;
    h.address_name;
    h.wc_location_type;
    h.location_type;
    h.source_reliability;
    h.incident_content_validity;
    h.incident_source_score;
    h.clean_incident_entry_date;
    h.clean_incident_purge_date;
    h.reporting_officer_first_name;
    h.reporting_officer_last_name;
    h.first_name;
    h.middle_name;
    h.last_name;
    h.moniker;
    h.ssn;
    h.clean_dob;
    h.sex;
    h.race;
    h.ethnicity;
    h.country_of_origin;
    h.height;
    h.weight;
    h.eye_color;
    h.hair_color;
    h.hair_style;
    h.facial_hair;
    h.tattoo_text_1;
    h.tattoo_location_1;
    h.tattoo_text_2;
    h.tattoo_location_2;
    h.occupation;
    h.place_of_employment;
    h.entity_address;
    h.entity_city;
    h.entity_state;
    h.entity_zip;
    h.person_x;
    h.person_y;
    h.phone_number;
    h.phone_type;
    h.email_address;
    h.social_media_type_1;
    h.user_name_site_1;
    h.social_media_type_2;
    h.user_name_site_2;
    h.social_media_type_3;
    h.user_name_site_3;
    h.social_media_type_4;
    h.user_name_site_4;
    h.organization_type;
    h.organization_sub_type;
    h.organization_name;
    h.number_of_members;
    h.organization_rank_role;
    h.entity_source_type;
    h.source_relaiability;
    h.entity_content_validity;
    h.entity_source_score;
    h.clean_entity_entry_date;
    h.clean_entity_purge_date;
    h.vehicle_type;
    h.vehicle_make;
    h.vehicle_model;
    h.vehicle_color;
    h.vehicle_year;
    h.vehicle_plate;
    h.vehicle_plate_state;
    h.entity_notes;
    h.incident_notes;
    h.vehicle_notes;
    h.agency;
    h.data_provider_ori;
    h.vehicle_color_secondary;
    h.vehicle_vin;
    h.update_date;
    h.purgedate_computed;
    h.duration_since;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT30.StrType)le.eid,(SALT30.StrType)le.eid,(SALT30.StrType)le.gh12,(SALT30.StrType)le.gh4,(SALT30.StrType)le.gh5,(SALT30.StrType)le.gh6,(SALT30.StrType)le.etype,(SALT30.StrType)le.id,(SALT30.StrType)le.incident_id,(SALT30.StrType)le.name_type,(SALT30.StrType)le.clean_incident_date,(SALT30.StrType)le.incident_time,(SALT30.StrType)le.case_number,(SALT30.StrType)le.call_case_number,(SALT30.StrType)le.incident_address,(SALT30.StrType)le.incident_city,(SALT30.StrType)le.incident_state,(SALT30.StrType)le.incident_zip,(SALT30.StrType)le.wc_address_name,(SALT30.StrType)le.address_name,(SALT30.StrType)le.wc_location_type,(SALT30.StrType)le.location_type,(SALT30.StrType)le.source_reliability,(SALT30.StrType)le.incident_content_validity,(SALT30.StrType)le.incident_source_score,(SALT30.StrType)le.clean_incident_entry_date,(SALT30.StrType)le.clean_incident_purge_date,(SALT30.StrType)le.reporting_officer_first_name,(SALT30.StrType)le.reporting_officer_last_name,(SALT30.StrType)le.first_name,(SALT30.StrType)le.middle_name,(SALT30.StrType)le.last_name,(SALT30.StrType)le.moniker,(SALT30.StrType)le.ssn,(SALT30.StrType)le.clean_dob,(SALT30.StrType)le.sex,(SALT30.StrType)le.race,(SALT30.StrType)le.ethnicity,(SALT30.StrType)le.country_of_origin,(SALT30.StrType)le.height,(SALT30.StrType)le.weight,(SALT30.StrType)le.eye_color,(SALT30.StrType)le.hair_color,(SALT30.StrType)le.hair_style,(SALT30.StrType)le.facial_hair,(SALT30.StrType)le.tattoo_text_1,(SALT30.StrType)le.tattoo_location_1,(SALT30.StrType)le.tattoo_text_2,(SALT30.StrType)le.tattoo_location_2,(SALT30.StrType)le.occupation,(SALT30.StrType)le.place_of_employment,(SALT30.StrType)le.entity_address,(SALT30.StrType)le.entity_city,(SALT30.StrType)le.entity_state,(SALT30.StrType)le.entity_zip,(SALT30.StrType)le.person_x,(SALT30.StrType)le.person_y,(SALT30.StrType)le.phone_number,(SALT30.StrType)le.phone_type,(SALT30.StrType)le.email_address,(SALT30.StrType)le.social_media_type_1,(SALT30.StrType)le.user_name_site_1,(SALT30.StrType)le.social_media_type_2,(SALT30.StrType)le.user_name_site_2,(SALT30.StrType)le.social_media_type_3,(SALT30.StrType)le.user_name_site_3,(SALT30.StrType)le.social_media_type_4,(SALT30.StrType)le.user_name_site_4,(SALT30.StrType)le.organization_type,(SALT30.StrType)le.organization_sub_type,(SALT30.StrType)le.organization_name,(SALT30.StrType)le.number_of_members,(SALT30.StrType)le.organization_rank_role,(SALT30.StrType)le.entity_source_type,(SALT30.StrType)le.source_relaiability,(SALT30.StrType)le.entity_content_validity,(SALT30.StrType)le.entity_source_score,(SALT30.StrType)le.clean_entity_entry_date,(SALT30.StrType)le.clean_entity_purge_date,(SALT30.StrType)le.vehicle_type,(SALT30.StrType)le.vehicle_make,(SALT30.StrType)le.vehicle_model,(SALT30.StrType)le.vehicle_color,(SALT30.StrType)le.vehicle_year,(SALT30.StrType)le.vehicle_plate,(SALT30.StrType)le.vehicle_plate_state,(SALT30.StrType)le.entity_notes,(SALT30.StrType)le.incident_notes,(SALT30.StrType)le.vehicle_notes,(SALT30.StrType)le.agency,(SALT30.StrType)le.data_provider_ori,(SALT30.StrType)le.vehicle_color_secondary,(SALT30.StrType)le.vehicle_vin,(SALT30.StrType)le.update_date,(SALT30.StrType)le.purgedate_computed,(SALT30.StrType)le.duration_since,SKIP,SKIP,SKIP);
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
  SELF.segName := Text_Search.MakeShortSeg(choose(c,text_search.constants.DocKeyField,'eid','gh12','gh4','gh5','gh6','etype','id','incident_id','name_type','clean_incident_date','incident_time','case_number','call_case_number','incident_address','incident_city','incident_state','incident_zip','wc_address_name','address_name','wc_location_type','location_type','source_reliability','incident_content_validity','incident_source_score','clean_incident_entry_date','clean_incident_purge_date','reporting_officer_first_name','reporting_officer_last_name','first_name','middle_name','last_name','moniker','ssn','clean_dob','sex','race','ethnicity','country_of_origin','height','weight','eye_color','hair_color','hair_style','facial_hair','tattoo_text_1','tattoo_location_1','tattoo_text_2','tattoo_location_2','occupation','place_of_employment','entity_address','entity_city','entity_state','entity_zip','person_x','person_y','phone_number','phone_type','email_address','social_media_type_1','user_name_site_1','social_media_type_2','user_name_site_2','social_media_type_3','user_name_site_3','social_media_type_4','user_name_site_4','organization_type','organization_sub_type','organization_name','number_of_members','organization_rank_role','entity_source_type','source_relaiability','entity_content_validity','entity_source_score','clean_entity_entry_date','clean_entity_purge_date','vehicle_type','vehicle_make','vehicle_model','vehicle_color','vehicle_year','vehicle_plate','vehicle_plate_state','entity_notes','incident_notes','vehicle_notes','agency','data_provider_ori','vehicle_color_secondary','vehicle_vin','update_date','purgedate_computed','duration_since','NOTES','DATE'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.newrid;
  self.sid := le.hashed_sid;
  self.lid := (SALT30.UIDType)le.newrid;
END;
SHARED FieldsAsPostings := NORMALIZE(h,98,into(left,counter));
EXPORT SegmentDefinitions := DATASET([{text_search.MakeShortSeg(text_search.Constants.DocKeyField),text_search.Constants.DocKeyField,text_search.types.SegmentType.ExternalKey,[text_search.MakeShortSeg(text_search.Constants.DocKeyField)]}
  ,{text_search.MakeShortSeg('eid'),'eid',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eid')]}
  ,{text_search.MakeShortSeg('gh12'),'gh12',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh12')]}
  ,{text_search.MakeShortSeg('gh4'),'gh4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh4')]}
  ,{text_search.MakeShortSeg('gh5'),'gh5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh5')]}
  ,{text_search.MakeShortSeg('gh6'),'gh6',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('gh6')]}
  ,{text_search.MakeShortSeg('etype'),'etype',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('etype')]}
  ,{text_search.MakeShortSeg('id'),'id',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('id')]}
  ,{text_search.MakeShortSeg('incident_id'),'incident_id',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('incident_id')]}
  ,{text_search.MakeShortSeg('name_type'),'name_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name_type')]}
  ,{text_search.MakeShortSeg('clean_incident_date'),'clean_incident_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_incident_date')]}
  ,{text_search.MakeShortSeg('incident_time'),'incident_time',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('incident_time')]}
  ,{text_search.MakeShortSeg('case_number'),'case_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('case_number')]}
  ,{text_search.MakeShortSeg('call_case_number'),'call_case_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('call_case_number')]}
  ,{text_search.MakeShortSeg('incident_address'),'incident_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('incident_address')]}
  ,{text_search.MakeShortSeg('incident_city'),'incident_city',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('incident_city')]}
  ,{text_search.MakeShortSeg('incident_state'),'incident_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('incident_state')]}
  ,{text_search.MakeShortSeg('incident_zip'),'incident_zip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('incident_zip')]}
  ,{text_search.MakeShortSeg('wc_address_name'),'wc_address_name',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_address_name')]}
  ,{text_search.MakeShortSeg('address_name'),'address_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('address_name')]}
  ,{text_search.MakeShortSeg('wc_location_type'),'wc_location_type',text_search.types.SegmentType.FieldDataType,[text_search.MakeShortSeg('wc_location_type')]}
  ,{text_search.MakeShortSeg('location_type'),'location_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('location_type')]}
  ,{text_search.MakeShortSeg('source_reliability'),'source_reliability',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('source_reliability')]}
  ,{text_search.MakeShortSeg('incident_content_validity'),'incident_content_validity',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('incident_content_validity')]}
  ,{text_search.MakeShortSeg('incident_source_score'),'incident_source_score',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('incident_source_score')]}
  ,{text_search.MakeShortSeg('clean_incident_entry_date'),'clean_incident_entry_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_incident_entry_date')]}
  ,{text_search.MakeShortSeg('clean_incident_purge_date'),'clean_incident_purge_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_incident_purge_date')]}
  ,{text_search.MakeShortSeg('reporting_officer_first_name'),'reporting_officer_first_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('reporting_officer_first_name')]}
  ,{text_search.MakeShortSeg('reporting_officer_last_name'),'reporting_officer_last_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('reporting_officer_last_name')]}
  ,{text_search.MakeShortSeg('first_name'),'first_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('first_name')]}
  ,{text_search.MakeShortSeg('middle_name'),'middle_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('middle_name')]}
  ,{text_search.MakeShortSeg('last_name'),'last_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('last_name')]}
  ,{text_search.MakeShortSeg('moniker'),'moniker',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('moniker')]}
  ,{text_search.MakeShortSeg('ssn'),'ssn',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('ssn')]}
  ,{text_search.MakeShortSeg('clean_dob'),'clean_dob',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_dob')]}
  ,{text_search.MakeShortSeg('sex'),'sex',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sex')]}
  ,{text_search.MakeShortSeg('race'),'race',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('race')]}
  ,{text_search.MakeShortSeg('ethnicity'),'ethnicity',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('ethnicity')]}
  ,{text_search.MakeShortSeg('country_of_origin'),'country_of_origin',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('country_of_origin')]}
  ,{text_search.MakeShortSeg('height'),'height',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('height')]}
  ,{text_search.MakeShortSeg('weight'),'weight',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('weight')]}
  ,{text_search.MakeShortSeg('eye_color'),'eye_color',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('eye_color')]}
  ,{text_search.MakeShortSeg('hair_color'),'hair_color',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('hair_color')]}
  ,{text_search.MakeShortSeg('hair_style'),'hair_style',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('hair_style')]}
  ,{text_search.MakeShortSeg('facial_hair'),'facial_hair',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('facial_hair')]}
  ,{text_search.MakeShortSeg('tattoo_text_1'),'tattoo_text_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('tattoo_text_1')]}
  ,{text_search.MakeShortSeg('tattoo_location_1'),'tattoo_location_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('tattoo_location_1')]}
  ,{text_search.MakeShortSeg('tattoo_text_2'),'tattoo_text_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('tattoo_text_2')]}
  ,{text_search.MakeShortSeg('tattoo_location_2'),'tattoo_location_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('tattoo_location_2')]}
  ,{text_search.MakeShortSeg('occupation'),'occupation',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('occupation')]}
  ,{text_search.MakeShortSeg('place_of_employment'),'place_of_employment',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('place_of_employment')]}
  ,{text_search.MakeShortSeg('entity_address'),'entity_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('entity_address')]}
  ,{text_search.MakeShortSeg('entity_city'),'entity_city',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('entity_city')]}
  ,{text_search.MakeShortSeg('entity_state'),'entity_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('entity_state')]}
  ,{text_search.MakeShortSeg('entity_zip'),'entity_zip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('entity_zip')]}
  ,{text_search.MakeShortSeg('person_x'),'person_x',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('person_x')]}
  ,{text_search.MakeShortSeg('person_y'),'person_y',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('person_y')]}
  ,{text_search.MakeShortSeg('phone_number'),'phone_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('phone_number')]}
  ,{text_search.MakeShortSeg('phone_type'),'phone_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('phone_type')]}
  ,{text_search.MakeShortSeg('email_address'),'email_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('email_address')]}
  ,{text_search.MakeShortSeg('social_media_type_1'),'social_media_type_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('social_media_type_1')]}
  ,{text_search.MakeShortSeg('user_name_site_1'),'user_name_site_1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('user_name_site_1')]}
  ,{text_search.MakeShortSeg('social_media_type_2'),'social_media_type_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('social_media_type_2')]}
  ,{text_search.MakeShortSeg('user_name_site_2'),'user_name_site_2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('user_name_site_2')]}
  ,{text_search.MakeShortSeg('social_media_type_3'),'social_media_type_3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('social_media_type_3')]}
  ,{text_search.MakeShortSeg('user_name_site_3'),'user_name_site_3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('user_name_site_3')]}
  ,{text_search.MakeShortSeg('social_media_type_4'),'social_media_type_4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('social_media_type_4')]}
  ,{text_search.MakeShortSeg('user_name_site_4'),'user_name_site_4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('user_name_site_4')]}
  ,{text_search.MakeShortSeg('organization_type'),'organization_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('organization_type')]}
  ,{text_search.MakeShortSeg('organization_sub_type'),'organization_sub_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('organization_sub_type')]}
  ,{text_search.MakeShortSeg('organization_name'),'organization_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('organization_name')]}
  ,{text_search.MakeShortSeg('number_of_members'),'number_of_members',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('number_of_members')]}
  ,{text_search.MakeShortSeg('organization_rank_role'),'organization_rank_role',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('organization_rank_role')]}
  ,{text_search.MakeShortSeg('entity_source_type'),'entity_source_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('entity_source_type')]}
  ,{text_search.MakeShortSeg('source_relaiability'),'source_relaiability',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('source_relaiability')]}
  ,{text_search.MakeShortSeg('entity_content_validity'),'entity_content_validity',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('entity_content_validity')]}
  ,{text_search.MakeShortSeg('entity_source_score'),'entity_source_score',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('entity_source_score')]}
  ,{text_search.MakeShortSeg('clean_entity_entry_date'),'clean_entity_entry_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_entity_entry_date')]}
  ,{text_search.MakeShortSeg('clean_entity_purge_date'),'clean_entity_purge_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('clean_entity_purge_date')]}
  ,{text_search.MakeShortSeg('vehicle_type'),'vehicle_type',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_type')]}
  ,{text_search.MakeShortSeg('vehicle_make'),'vehicle_make',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_make')]}
  ,{text_search.MakeShortSeg('vehicle_model'),'vehicle_model',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_model')]}
  ,{text_search.MakeShortSeg('vehicle_color'),'vehicle_color',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_color')]}
  ,{text_search.MakeShortSeg('vehicle_year'),'vehicle_year',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_year')]}
  ,{text_search.MakeShortSeg('vehicle_plate'),'vehicle_plate',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_plate')]}
  ,{text_search.MakeShortSeg('vehicle_plate_state'),'vehicle_plate_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_plate_state')]}
  ,{text_search.MakeShortSeg('entity_notes'),'entity_notes',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('entity_notes')]}
  ,{text_search.MakeShortSeg('incident_notes'),'incident_notes',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('incident_notes')]}
  ,{text_search.MakeShortSeg('vehicle_notes'),'vehicle_notes',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_notes')]}
  ,{text_search.MakeShortSeg('agency'),'agency',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('agency')]}
  ,{text_search.MakeShortSeg('data_provider_ori'),'data_provider_ori',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('data_provider_ori')]}
  ,{text_search.MakeShortSeg('vehicle_color_secondary'),'vehicle_color_secondary',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_color_secondary')]}
  ,{text_search.MakeShortSeg('vehicle_vin'),'vehicle_vin',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('vehicle_vin')]}
  ,{text_search.MakeShortSeg('update_date'),'update_date',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('update_date')]}
  ,{text_search.MakeShortSeg('purgedate_computed'),'purgedate_computed',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('purgedate_computed')]}
  ,{text_search.MakeShortSeg('duration_since'),'duration_since',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('duration_since')]}
  ,{text_search.MakeShortSeg('NOTES'),'NOTES',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('entity_notes'),text_search.MakeShortSeg('incident_notes'),text_search.MakeShortSeg('vehicle_notes')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('clean_incident_date')]}
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

