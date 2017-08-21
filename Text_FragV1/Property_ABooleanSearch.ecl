import text_search,ut,SALT,MDR;
export Property_ABooleanSearch(dataset(layout_Property_A_Extract) ih)  := MODULE
shared h := ih; // More - use propogated data
// Now recreate the file in 'segname' form for eventual data load
  rf := record
  unsigned6 rid := h.rid;
  unsigned6 sid := h.sid;
  unsigned6 lid := (unsigned6)h.did;
    h.state_code;
    h.county_name;
    h.assessee_name;
    h.second_assessee_name;
    h.contract_owner;
    h.assessee_phone_number;
    h.mailing_care_of_name;
    h.mailing_full_street_address;
    h.mailing_unit_number;
    h.mailing_city_state_zip;
    h.property_full_street_address;
    h.property_unit_number;
    h.property_city_state_zip;
    h.title;
    h.fname;
    h.mname;
    h.lname;
    h.name_suffix;
    h.cname;
    h.nameasis;
    h.prim_range;
    h.predir;
    h.prim_name;
    h.suffix;
    h.postdir;
    h.unit_desig;
    h.sec_range;
    h.v_city_name;
    h.st;
    h.zip;
    h.zip4;
    h.phone_number;
  end;
export TranslatedFile := table(h,rf);
Text_Search.Layout_Posting Into(h le,unsigned2 c) := transform
  self.word := choose(c,(string)le.state_code,(string)le.county_name,(string)le.assessee_name,(string)le.second_assessee_name,(string)le.contract_owner,(string)le.assessee_phone_number,(string)le.mailing_care_of_name,(string)le.mailing_full_street_address,(string)le.mailing_unit_number,(string)le.mailing_city_state_zip,(string)le.property_full_street_address,(string)le.property_unit_number,(string)le.property_city_state_zip,(string)le.title,(string)le.fname,(string)le.mname,(string)le.lname,(string)le.name_suffix,(string)le.cname,(string)le.nameasis,(string)le.prim_range,(string)le.predir,(string)le.prim_name,(string)le.suffix,(string)le.postdir,(string)le.unit_desig,(string)le.sec_range,(string)le.v_city_name,(string)le.st,(string)le.zip,(string)le.zip4,(string)le.phone_number,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  self.len := length(trim(self.word));
  self.wip := 1; // Adjusted later
  self.nominal := 0; //Filled in later
  self.suffix := 0; // Filled in later
  self.part := thorlib.node();
  self.kwp := 0; // Adjusted later
  self.docref.doc := le.rid; // Initial
  self.docref.src := TRANSFER(le.source,UNSIGNED2); // Initial
  self.src := TRANSFER(le.source,UNSIGNED2); // Namespace for ID provided
  self.seg := c; // Field number is seg; values filled in in segment definition
  self.segName := Text_Search.MakeShortSeg(choose(c,'state_code','county_name','assessee_name','second_assessee_name','contract_owner','assessee_phone_number','mailing_care_of_name','mailing_full_street_address','mailing_unit_number','mailing_city_state_zip','property_full_street_address','property_unit_number','property_city_state_zip','title','fname','mname','lname','name_suffix','cname','nameasis','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','v_city_name','st','zip','zip4','phone_number','CASS_ADDRESS','CASS_CSZ','CLEAN_NAME','ADDRESS','NAME','PHONE','COMPANY'));
  self.typ := text_search.types.WordType.TextStr; // May get changed later
  self.sect := 0; // Not needed
  self.pos := 0; // Not needed
  self.rid := le.rid;
  self.sid := le.sid;
  self.lid := (unsigned6)le.did;
end;
shared FieldsAsPostings := normalize(h,39,into(left,counter))(word<>' ');
export SegmentDefinitions := dataset([  {text_search.MakeShortSeg('state_code'),'state_code',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('state_code')]}
  ,{text_search.MakeShortSeg('county_name'),'county_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('county_name')]}
  ,{text_search.MakeShortSeg('assessee_name'),'assessee_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('assessee_name')]}
  ,{text_search.MakeShortSeg('second_assessee_name'),'second_assessee_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('second_assessee_name')]}
  ,{text_search.MakeShortSeg('contract_owner'),'contract_owner',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('contract_owner')]}
  ,{text_search.MakeShortSeg('assessee_phone_number'),'assessee_phone_number',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('assessee_phone_number')]}
  ,{text_search.MakeShortSeg('mailing_care_of_name'),'mailing_care_of_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_care_of_name')]}
  ,{text_search.MakeShortSeg('mailing_full_street_address'),'mailing_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_full_street_address')]}
  ,{text_search.MakeShortSeg('mailing_unit_number'),'mailing_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_unit_number')]}
  ,{text_search.MakeShortSeg('mailing_city_state_zip'),'mailing_city_state_zip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_city_state_zip')]}
  ,{text_search.MakeShortSeg('property_full_street_address'),'property_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_full_street_address')]}
  ,{text_search.MakeShortSeg('property_unit_number'),'property_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_unit_number')]}
  ,{text_search.MakeShortSeg('property_city_state_zip'),'property_city_state_zip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_city_state_zip')]}
  ,{text_search.MakeShortSeg('title'),'title',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('title')]}
  ,{text_search.MakeShortSeg('fname'),'fname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fname')]}
  ,{text_search.MakeShortSeg('mname'),'mname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mname')]}
  ,{text_search.MakeShortSeg('lname'),'lname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lname')]}
  ,{text_search.MakeShortSeg('name_suffix'),'name_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('cname'),'cname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cname')]}
  ,{text_search.MakeShortSeg('nameasis'),'nameasis',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('nameasis')]}
  ,{text_search.MakeShortSeg('prim_range'),'prim_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_range')]}
  ,{text_search.MakeShortSeg('predir'),'predir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('predir')]}
  ,{text_search.MakeShortSeg('prim_name'),'prim_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_name')]}
  ,{text_search.MakeShortSeg('suffix'),'suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suffix')]}
  ,{text_search.MakeShortSeg('postdir'),'postdir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('postdir')]}
  ,{text_search.MakeShortSeg('unit_desig'),'unit_desig',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('unit_desig')]}
  ,{text_search.MakeShortSeg('sec_range'),'sec_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('v_city_name'),'v_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('v_city_name')]}
  ,{text_search.MakeShortSeg('st'),'st',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('st')]}
  ,{text_search.MakeShortSeg('zip'),'zip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('zip')]}
  ,{text_search.MakeShortSeg('zip4'),'zip4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('phone_number'),'phone_number',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('phone_number')]}
  ,{text_search.MakeShortSeg('CASS_ADDRESS'),'CASS_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('CASS_CSZ'),'CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('CLEAN_NAME'),'CLEAN_NAME',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('ADDRESS'),'ADDRESS',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range'),text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip'),text_search.MakeShortSeg('zip4'),text_search.MakeShortSeg('mailing_full_street_address'),text_search.MakeShortSeg('mailing_unit_number'),text_search.MakeShortSeg('mailing_city_state_zip'),text_search.MakeShortSeg('property_full_street_address'),text_search.MakeShortSeg('property_unit_number'),text_search.MakeShortSeg('property_city_state_zip')]}
  ,{text_search.MakeShortSeg('NAME'),'NAME',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix'),text_search.MakeShortSeg('cname'),text_search.MakeShortSeg('nameasis'),text_search.MakeShortSeg('assessee_name'),text_search.MakeShortSeg('second_assessee_name'),text_search.MakeShortSeg('mailing_care_of_name'),text_search.MakeShortSeg('contract_owner'),text_search.MakeShortSeg('cname')]}
  ,{text_search.MakeShortSeg('PHONE'),'PHONE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('assessee_phone_number'),text_search.MakeShortSeg('phone_number')]}
  ,{text_search.MakeShortSeg('COMPANY'),'COMPANY',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('cname')]}
],Text_Search.Layout_Segment_ComposeDef );
shared Text_Search.Layout_Posting setRef(Text_Search.Layout_Posting le, INTEGER2 sw) := TRANSFORM
    self.docRef.src := CHOOSE(sw, IF(le.lid=0, le.src, 0),  le.src);
    self.docRef.doc := CHOOSE(sw, IF(le.lid=0, le.rid, le.lid), le.rid, le.sid);
    self := le;
end;
shared Postings := Text_Search.ApplyKWP2Postings(FieldsAsPostings, SegmentDefinitions);
export Postings_LID := PROJECT(Postings, setRef(LEFT,1));
export Postings_RID := PROJECT(Postings, setRef(LEFT,2));
export Postings_Doc := PROJECT(Postings, setRef(LEFT,3));
end;

