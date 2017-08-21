import text_search,ut,SALT,MDR;
export FBN_ContactBooleanSearch(dataset(layout_FBN_Contact) ih)  := MODULE
shared h := ih; // More - use propogated data
// Now recreate the file in 'segname' form for eventual data load
  rf := record
  unsigned6 rid := h.rid;
  unsigned6 sid := h.sid;
  unsigned6 lid := (unsigned6)h.did;
    h.CONTACT_NAME;
    h.CONTACT_PHONE;
    h.CONTACT_ADDR;
    h.CONTACT_CITY;
    h.CONTACT_STATE;
    h.CONTACT_ZIP;
    h.CONTACT_COUNTRY;
    h.title;
    h.fname;
    h.mname;
    h.lname;
    h.name_suffix;
    h.prim_range;
    h.predir;
    h.prim_name;
    h.addr_suffix;
    h.postdir;
    h.unit_desig;
    h.sec_range;
    h.v_city_name;
    h.st;
    h.zip5;
    h.zip4;
  end;
export TranslatedFile := table(h,rf);
Text_Search.Layout_Posting Into(h le,unsigned2 c) := transform
  self.word := choose(c,(string)le.CONTACT_NAME,(string)le.CONTACT_PHONE,(string)le.CONTACT_ADDR,(string)le.CONTACT_CITY,(string)le.CONTACT_STATE,(string)le.CONTACT_ZIP,(string)le.CONTACT_COUNTRY,(string)le.title,(string)le.fname,(string)le.mname,(string)le.lname,(string)le.name_suffix,(string)le.prim_range,(string)le.predir,(string)le.prim_name,(string)le.addr_suffix,(string)le.postdir,(string)le.unit_desig,(string)le.sec_range,(string)le.v_city_name,(string)le.st,(string)le.zip5,(string)le.zip4,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
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
  self.segName := Text_Search.MakeShortSeg(choose(c,'CONTACT_NAME','CONTACT_PHONE','CONTACT_ADDR','CONTACT_CITY','CONTACT_STATE','CONTACT_ZIP','CONTACT_COUNTRY','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','v_city_name','st','zip5','zip4','PARSE_NAME','CASS_ADDR','CASS_CSZ','CONTACT_CSZ','CONTACT_ADDRESS','ADDRESS','NAME','PHONE'));
  self.typ := text_search.types.WordType.TextStr; // May get changed later
  self.sect := 0; // Not needed
  self.pos := 0; // Not needed
  self.rid := le.rid;
  self.sid := le.sid;
  self.lid := (unsigned6)le.did;
end;
shared FieldsAsPostings := normalize(h,31,into(left,counter))(word<>'');
export SegmentDefinitions := dataset([  {text_search.MakeShortSeg('CONTACT_NAME'),'CONTACT_NAME',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CONTACT_NAME')]}
  ,{text_search.MakeShortSeg('CONTACT_PHONE'),'CONTACT_PHONE',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('CONTACT_PHONE')]}
  ,{text_search.MakeShortSeg('CONTACT_ADDR'),'CONTACT_ADDR',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CONTACT_ADDR')]}
  ,{text_search.MakeShortSeg('CONTACT_CITY'),'CONTACT_CITY',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CONTACT_CITY')]}
  ,{text_search.MakeShortSeg('CONTACT_STATE'),'CONTACT_STATE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CONTACT_STATE')]}
  ,{text_search.MakeShortSeg('CONTACT_ZIP'),'CONTACT_ZIP',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CONTACT_ZIP')]}
  ,{text_search.MakeShortSeg('CONTACT_COUNTRY'),'CONTACT_COUNTRY',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CONTACT_COUNTRY')]}
  ,{text_search.MakeShortSeg('title'),'title',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('title')]}
  ,{text_search.MakeShortSeg('fname'),'fname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fname')]}
  ,{text_search.MakeShortSeg('mname'),'mname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mname')]}
  ,{text_search.MakeShortSeg('lname'),'lname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lname')]}
  ,{text_search.MakeShortSeg('name_suffix'),'name_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('prim_range'),'prim_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_range')]}
  ,{text_search.MakeShortSeg('predir'),'predir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('predir')]}
  ,{text_search.MakeShortSeg('prim_name'),'prim_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_name')]}
  ,{text_search.MakeShortSeg('addr_suffix'),'addr_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('addr_suffix')]}
  ,{text_search.MakeShortSeg('postdir'),'postdir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('postdir')]}
  ,{text_search.MakeShortSeg('unit_desig'),'unit_desig',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('unit_desig')]}
  ,{text_search.MakeShortSeg('sec_range'),'sec_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('v_city_name'),'v_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('v_city_name')]}
  ,{text_search.MakeShortSeg('st'),'st',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('st')]}
  ,{text_search.MakeShortSeg('zip5'),'zip5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('zip5')]}
  ,{text_search.MakeShortSeg('zip4'),'zip4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('PARSE_NAME'),'PARSE_NAME',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('CASS_ADDR'),'CASS_ADDR',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('addr_suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('CASS_CSZ'),'CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip5'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('CONTACT_CSZ'),'CONTACT_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('CONTACT_CITY'),text_search.MakeShortSeg('CONTACT_STATE'),text_search.MakeShortSeg('CONTACT_ZIP')]}
  ,{text_search.MakeShortSeg('CONTACT_ADDRESS'),'CONTACT_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('CONTACT_ADDR'),text_search.MakeShortSeg('CONTACT_CITY'),text_search.MakeShortSeg('CONTACT_STATE'),text_search.MakeShortSeg('CONTACT_ZIP')]}
  ,{text_search.MakeShortSeg('ADDRESS'),'ADDRESS',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('CONTACT_ADDR'),text_search.MakeShortSeg('CONTACT_CITY'),text_search.MakeShortSeg('CONTACT_STATE'),text_search.MakeShortSeg('CONTACT_ZIP'),text_search.MakeShortSeg('CONTACT_COUNTRY'),text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('addr_suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range'),text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip5'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('NAME'),'NAME',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('CONTACT_NAME'),text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('PHONE'),'PHONE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('CONTACT_PHONE')]}
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

