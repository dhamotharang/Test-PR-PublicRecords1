import text_search,ut,SALT,MDR;
export ExpandedHeaderBooleanSearch(dataset(layout_ExpandedHeader) ih)  := MODULE
shared h := ih; // More - use propogated data
// Now recreate the file in 'segname' form for eventual data load
  rf := record
  unsigned6 rid := h.rid;
  unsigned6 sid := h.did;
  unsigned6 lid := (unsigned6)h.did;
    h.prim_range;
    h.predir;
    h.prim_name;
    h.suffix;
    h.postdir;
    h.unit_desig;
    h.sec_range;
    h.city_name;
    h.st;
    zip_code := h.zip;
    h.zip4;
    h.title;
    h.fname;
    h.mname;
    h.lname;
    h.name_suffix;
    ssn1 := h.ssn;
    phone1 := h.phone;
    dob1 := h.dob;
  end;
export TranslatedFile := table(h,rf);
Text_Search.Layout_Posting Into(h le,unsigned2 c) := transform
  self.word := choose(c,(string)le.prim_range,(string)le.predir,(string)le.prim_name,(string)le.suffix,(string)le.postdir,(string)le.unit_desig,(string)le.sec_range,(string)le.city_name,(string)le.st,(string)le.zip,(string)le.zip4,(string)le.title,(string)le.fname,(string)le.mname,(string)le.lname,(string)le.name_suffix,(string)le.ssn,(string)le.phone,(string)le.dob,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  self.len := length(trim(self.word));
  self.wip := 1; // Adjusted later
  self.nominal := 0; //Filled in later
  self.suffix := 0; // Filled in later
  self.part := thorlib.node();
  self.kwp := 0; // Adjusted later
  self.docref.doc := le.rid; // Initial
  self.docref.src := TRANSFER(le.src,UNSIGNED2); // Initial
  self.src := TRANSFER(le.src,UNSIGNED2); // Namespace for ID provided
  self.seg := c; // Field number is seg; values filled in in segment definition
  self.segName := Text_Search.MakeShortSeg(choose(c,'prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip_code','zip4','title','fname','mname','lname','name_suffix','ssn1','phone1','dob1','CASS_ADDRESS','CASS_CSZ','CLEAN_NAME','NAME','ADDRESS','DOB','PHONE','SSN'));
  self.typ := text_search.types.WordType.TextStr; // May get changed later
  self.sect := 0; // Not needed
  self.pos := 0; // Not needed
  self.rid := le.rid;
  self.sid := le.did;
  self.lid := (unsigned6)le.did;
end;
shared FieldsAsPostings := normalize(h,27,into(left,counter))(word<>'');
export SegmentDefinitions := dataset([  {text_search.MakeShortSeg('prim_range'),'prim_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_range')]}
  ,{text_search.MakeShortSeg('predir'),'predir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('predir')]}
  ,{text_search.MakeShortSeg('prim_name'),'prim_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_name')]}
  ,{text_search.MakeShortSeg('suffix'),'suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suffix')]}
  ,{text_search.MakeShortSeg('postdir'),'postdir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('postdir')]}
  ,{text_search.MakeShortSeg('unit_desig'),'unit_desig',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('unit_desig')]}
  ,{text_search.MakeShortSeg('sec_range'),'sec_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('city_name'),'city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('city_name')]}
  ,{text_search.MakeShortSeg('st'),'st',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('st')]}
  ,{text_search.MakeShortSeg('zip_code'),'zip_code',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('zip_code')]}
  ,{text_search.MakeShortSeg('zip4'),'zip4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('title'),'title',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('title')]}
  ,{text_search.MakeShortSeg('fname'),'fname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fname')]}
  ,{text_search.MakeShortSeg('mname'),'mname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mname')]}
  ,{text_search.MakeShortSeg('lname'),'lname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lname')]}
  ,{text_search.MakeShortSeg('name_suffix'),'name_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('ssn1'),'ssn1',text_search.types.SegmentType.SSN,[text_search.MakeShortSeg('ssn1')]}
  ,{text_search.MakeShortSeg('phone1'),'phone1',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('phone1')]}
  ,{text_search.MakeShortSeg('dob1'),'dob1',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('dob1')]}
  ,{text_search.MakeShortSeg('CASS_ADDRESS'),'CASS_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('CASS_CSZ'),'CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip_code'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('CLEAN_NAME'),'CLEAN_NAME',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('NAME'),'NAME',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('ADDRESS'),'ADDRESS',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range'),text_search.MakeShortSeg('city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip_code'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('DOB'),'DOB',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('dob1')]}
  ,{text_search.MakeShortSeg('PHONE'),'PHONE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('phone1')]}
  ,{text_search.MakeShortSeg('SSN'),'SSN',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('ssn1')]}
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

