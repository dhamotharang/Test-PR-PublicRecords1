import text_search,ut,SALT,MDR;
export Property_DMBooleanSearch(dataset(layout_Property_DM_Extract) ih)  := MODULE
shared h := ih; // More - use propogated data
// Now recreate the file in 'segname' form for eventual data load
  rf := record
  unsigned6 rid := h.rid;
  unsigned6 sid := h.sid;
  unsigned6 lid := (unsigned6)h.did;
    h.name1;
    h.name2;
    h.phone_number;
    h.mailing_care_of;
    h.mailing_street;
    h.mailing_unit_number;
    h.mailing_csz;
    h.seller1;
    h.seller2;
    h.seller_mailing_full_street_address;
    h.seller_mailing_address_unit_number;
    h.seller_mailing_address_citystatezip;
    h.property_full_street_address;
    h.property_address_unit_number;
    h.property_address_citystatezip;
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
  end;
export TranslatedFile := table(h,rf);
Text_Search.Layout_Posting Into(h le,unsigned2 c) := transform
  self.word := choose(c,(string)le.name1,(string)le.name2,(string)le.phone_number,(string)le.mailing_care_of,(string)le.mailing_street,(string)le.mailing_unit_number,(string)le.mailing_csz,(string)le.seller1,(string)le.seller2,(string)le.seller_mailing_full_street_address,(string)le.seller_mailing_address_unit_number,(string)le.seller_mailing_address_citystatezip,(string)le.property_full_street_address,(string)le.property_address_unit_number,(string)le.property_address_citystatezip,(string)le.title,(string)le.fname,(string)le.mname,(string)le.lname,(string)le.name_suffix,(string)le.cname,(string)le.nameasis,(string)le.prim_range,(string)le.predir,(string)le.prim_name,(string)le.suffix,(string)le.postdir,(string)le.unit_desig,(string)le.sec_range,(string)le.v_city_name,(string)le.st,(string)le.zip,(string)le.zip4,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
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
  self.segName := Text_Search.MakeShortSeg(choose(c,'name1','name2','phone_number','mailing_care_of','mailing_street','mailing_unit_number','mailing_csz','seller1','seller2','seller_mailing_full_street_address','seller_mailing_address_unit_number','seller_mailing_address_citystatezip','property_full_street_address','property_address_unit_number','property_address_citystatezip','title','fname','mname','lname','name_suffix','cname','nameasis','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','v_city_name','st','zip','zip4','CASS_ADDRESS','CASS_CSZ','CLEAN_NAME','ADDRESS','NAME','PHONE','COMPANY'));
  self.typ := text_search.types.WordType.TextStr; // May get changed later
  self.sect := 0; // Not needed
  self.pos := 0; // Not needed
  self.rid := le.rid;
  self.sid := le.sid;
  self.lid := (unsigned6)le.did;
end;
shared FieldsAsPostings := normalize(h,40,into(left,counter))(word<>'');
export SegmentDefinitions := dataset([  {text_search.MakeShortSeg('name1'),'name1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name1')]}
  ,{text_search.MakeShortSeg('name2'),'name2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name2')]}
  ,{text_search.MakeShortSeg('phone_number'),'phone_number',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('phone_number')]}
  ,{text_search.MakeShortSeg('mailing_care_of'),'mailing_care_of',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_care_of')]}
  ,{text_search.MakeShortSeg('mailing_street'),'mailing_street',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_street')]}
  ,{text_search.MakeShortSeg('mailing_unit_number'),'mailing_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_unit_number')]}
  ,{text_search.MakeShortSeg('mailing_csz'),'mailing_csz',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_csz')]}
  ,{text_search.MakeShortSeg('seller1'),'seller1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller1')]}
  ,{text_search.MakeShortSeg('seller2'),'seller2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller2')]}
  ,{text_search.MakeShortSeg('seller_mailing_full_street_address'),'seller_mailing_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller_mailing_full_street_address')]}
  ,{text_search.MakeShortSeg('seller_mailing_address_unit_number'),'seller_mailing_address_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller_mailing_address_unit_number')]}
  ,{text_search.MakeShortSeg('seller_mailing_address_citystatezip'),'seller_mailing_address_citystatezip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller_mailing_address_citystatezip')]}
  ,{text_search.MakeShortSeg('property_full_street_address'),'property_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_full_street_address')]}
  ,{text_search.MakeShortSeg('property_address_unit_number'),'property_address_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_address_unit_number')]}
  ,{text_search.MakeShortSeg('property_address_citystatezip'),'property_address_citystatezip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_address_citystatezip')]}
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
  ,{text_search.MakeShortSeg('CASS_ADDRESS'),'CASS_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('CASS_CSZ'),'CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('CLEAN_NAME'),'CLEAN_NAME',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('ADDRESS'),'ADDRESS',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range'),text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip'),text_search.MakeShortSeg('zip4'),text_search.MakeShortSeg('mailing_street'),text_search.MakeShortSeg('mailing_unit_number'),text_search.MakeShortSeg('mailing_csz'),text_search.MakeShortSeg('seller_mailing_full_street_address'),text_search.MakeShortSeg('seller_mailing_address_unit_number'),text_search.MakeShortSeg('seller_mailing_address_citystatezip'),text_search.MakeShortSeg('property_full_street_address'),text_search.MakeShortSeg('property_address_unit_number'),text_search.MakeShortSeg('property_address_citystatezip')]}
  ,{text_search.MakeShortSeg('NAME'),'NAME',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix'),text_search.MakeShortSeg('cname'),text_search.MakeShortSeg('nameasis'),text_search.MakeShortSeg('name1'),text_search.MakeShortSeg('name2'),text_search.MakeShortSeg('mailing_care_of'),text_search.MakeShortSeg('seller1'),text_search.MakeShortSeg('seller2')]}
  ,{text_search.MakeShortSeg('PHONE'),'PHONE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('phone_number')]}
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

