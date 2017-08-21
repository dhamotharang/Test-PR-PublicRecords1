import text_search,ut,SALT,MDR;
export FBN_BusBooleanSearch(dataset(layout_FBN_Bus) ih)  := MODULE
shared h := ih; // More - use propogated data
// Now recreate the file in 'segname' form for eventual data load
  rf := record
  unsigned6 rid := h.rid;
  unsigned6 sid := h.sid;
  unsigned6 lid := (unsigned6)h.did;
    h.BUS_NAME;
    h.BUS_PHONE_NUM;
    h.BUS_ADDRESS1;
    h.BUS_ADDRESS2;
    h.BUS_CITY;
    h.BUS_STATE;
    h.BUS_ZIP;
    h.BUS_ZIP4;
    h.BUS_COUNTRY;
    h.MAIL_STREET;
    h.MAIL_CITY;
    h.MAIL_STATE;
    h.MAIL_ZIP;
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
    h.mail_prim_range;
    h.mail_predir;
    h.mail_prim_name;
    h.mail_addr_suffix;
    h.mail_postdir;
    h.mail_unit_desig;
    h.mail_sec_range;
    h.mail_v_city_name;
    h.mail_st;
    h.mail_zip5;
    h.mail_zip4;
  end;
export TranslatedFile := table(h,rf);
Text_Search.Layout_Posting Into(h le,unsigned2 c) := transform
  self.word := choose(c,(string)le.BUS_NAME,(string)le.BUS_PHONE_NUM,(string)le.BUS_ADDRESS1,(string)le.BUS_ADDRESS2,(string)le.BUS_CITY,(string)le.BUS_STATE,(string)le.BUS_ZIP,(string)le.BUS_ZIP4,(string)le.BUS_COUNTRY,(string)le.MAIL_STREET,(string)le.MAIL_CITY,(string)le.MAIL_STATE,(string)le.MAIL_ZIP,(string)le.prim_range,(string)le.predir,(string)le.prim_name,(string)le.addr_suffix,(string)le.postdir,(string)le.unit_desig,(string)le.sec_range,(string)le.v_city_name,(string)le.st,(string)le.zip5,(string)le.zip4,(string)le.mail_prim_range,(string)le.mail_predir,(string)le.mail_prim_name,(string)le.mail_addr_suffix,(string)le.mail_postdir,(string)le.mail_unit_desig,(string)le.mail_sec_range,(string)le.mail_v_city_name,(string)le.mail_st,(string)le.mail_zip5,(string)le.mail_zip4,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
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
  self.segName := Text_Search.MakeShortSeg(choose(c,'BUS_NAME','BUS_PHONE_NUM','BUS_ADDRESS1','BUS_ADDRESS2','BUS_CITY','BUS_STATE','BUS_ZIP','BUS_ZIP4','BUS_COUNTRY','MAIL_STREET','MAIL_CITY','MAIL_STATE','MAIL_ZIP','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','v_city_name','st','zip5','zip4','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_v_city_name','mail_st','mail_zip5','mail_zip4','BUS_CASS_ADDR','BUS_CASS_CSZ','BUS_CSZ','BUS_ADDR','MAIL_ADDR','MAIL_CASS_ADDR','MAIL_CASS_CSZ','MAIL_CSZ','NAME','PHONE','ADDRESS','COMPANY'));
  self.typ := text_search.types.WordType.TextStr; // May get changed later
  self.sect := 0; // Not needed
  self.pos := 0; // Not needed
  self.rid := le.rid;
  self.sid := le.sid;
  self.lid := (unsigned6)le.did;
end;
shared FieldsAsPostings := normalize(h,47,into(left,counter))(word<>' ');
export SegmentDefinitions := dataset([  {text_search.MakeShortSeg('BUS_NAME'),'BUS_NAME',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BUS_NAME')]}
  ,{text_search.MakeShortSeg('BUS_PHONE_NUM'),'BUS_PHONE_NUM',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('BUS_PHONE_NUM')]}
  ,{text_search.MakeShortSeg('BUS_ADDRESS1'),'BUS_ADDRESS1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BUS_ADDRESS1')]}
  ,{text_search.MakeShortSeg('BUS_ADDRESS2'),'BUS_ADDRESS2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BUS_ADDRESS2')]}
  ,{text_search.MakeShortSeg('BUS_CITY'),'BUS_CITY',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BUS_CITY')]}
  ,{text_search.MakeShortSeg('BUS_STATE'),'BUS_STATE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BUS_STATE')]}
  ,{text_search.MakeShortSeg('BUS_ZIP'),'BUS_ZIP',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BUS_ZIP')]}
  ,{text_search.MakeShortSeg('BUS_ZIP4'),'BUS_ZIP4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BUS_ZIP4')]}
  ,{text_search.MakeShortSeg('BUS_COUNTRY'),'BUS_COUNTRY',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BUS_COUNTRY')]}
  ,{text_search.MakeShortSeg('MAIL_STREET'),'MAIL_STREET',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('MAIL_STREET')]}
  ,{text_search.MakeShortSeg('MAIL_CITY'),'MAIL_CITY',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('MAIL_CITY')]}
  ,{text_search.MakeShortSeg('MAIL_STATE'),'MAIL_STATE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('MAIL_STATE')]}
  ,{text_search.MakeShortSeg('MAIL_ZIP'),'MAIL_ZIP',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('MAIL_ZIP')]}
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
  ,{text_search.MakeShortSeg('mail_prim_range'),'mail_prim_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_prim_range')]}
  ,{text_search.MakeShortSeg('mail_predir'),'mail_predir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_predir')]}
  ,{text_search.MakeShortSeg('mail_prim_name'),'mail_prim_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_prim_name')]}
  ,{text_search.MakeShortSeg('mail_addr_suffix'),'mail_addr_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_addr_suffix')]}
  ,{text_search.MakeShortSeg('mail_postdir'),'mail_postdir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_postdir')]}
  ,{text_search.MakeShortSeg('mail_unit_desig'),'mail_unit_desig',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_unit_desig')]}
  ,{text_search.MakeShortSeg('mail_sec_range'),'mail_sec_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_sec_range')]}
  ,{text_search.MakeShortSeg('mail_v_city_name'),'mail_v_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_v_city_name')]}
  ,{text_search.MakeShortSeg('mail_st'),'mail_st',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_st')]}
  ,{text_search.MakeShortSeg('mail_zip5'),'mail_zip5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_zip5')]}
  ,{text_search.MakeShortSeg('mail_zip4'),'mail_zip4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mail_zip4')]}
  ,{text_search.MakeShortSeg('BUS_CASS_ADDR'),'BUS_CASS_ADDR',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('addr_suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('BUS_CASS_CSZ'),'BUS_CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip5'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('BUS_CSZ'),'BUS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('BUS_CITY'),text_search.MakeShortSeg('BUS_STATE'),text_search.MakeShortSeg('BUS_ZIP'),text_search.MakeShortSeg('BUS_ZIP4')]}
  ,{text_search.MakeShortSeg('BUS_ADDR'),'BUS_ADDR',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('BUS_ADDRESS1'),text_search.MakeShortSeg('BUS_ADDRESS2'),text_search.MakeShortSeg('BUS_CITY'),text_search.MakeShortSeg('BUS_STATE'),text_search.MakeShortSeg('BUS_ZIP'),text_search.MakeShortSeg('BUS_ZIP4')]}
  ,{text_search.MakeShortSeg('MAIL_ADDR'),'MAIL_ADDR',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('MAIL_STREET'),text_search.MakeShortSeg('MAIL_CITY'),text_search.MakeShortSeg('MAIL_STATE'),text_search.MakeShortSeg('MAIL_ZIP')]}
  ,{text_search.MakeShortSeg('MAIL_CASS_ADDR'),'MAIL_CASS_ADDR',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('mail_prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('mail_prim_name'),text_search.MakeShortSeg('mail_addr_suffix'),text_search.MakeShortSeg('mail_postdir'),text_search.MakeShortSeg('mail_unit_desig'),text_search.MakeShortSeg('mail_sec_range')]}
  ,{text_search.MakeShortSeg('MAIL_CASS_CSZ'),'MAIL_CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('mail_v_city_name'),text_search.MakeShortSeg('mail_st'),text_search.MakeShortSeg('mail_zip5'),text_search.MakeShortSeg('mail_zip4')]}
  ,{text_search.MakeShortSeg('MAIL_CSZ'),'MAIL_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('MAIL_CITY'),text_search.MakeShortSeg('MAIL_STATE'),text_search.MakeShortSeg('MAIL_ZIP')]}
  ,{text_search.MakeShortSeg('NAME'),'NAME',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('BUS_NAME')]}
  ,{text_search.MakeShortSeg('PHONE'),'PHONE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('BUS_PHONE_NUM')]}
  ,{text_search.MakeShortSeg('ADDRESS'),'ADDRESS',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('BUS_ADDRESS1'),text_search.MakeShortSeg('BUS_ADDRESS2'),text_search.MakeShortSeg('BUS_CITY'),text_search.MakeShortSeg('BUS_STATE'),text_search.MakeShortSeg('BUS_ZIP'),text_search.MakeShortSeg('BUS_ZIP4'),text_search.MakeShortSeg('BUS_COUNTRY'),text_search.MakeShortSeg('MAIL_STREET'),text_search.MakeShortSeg('MAIL_CITY'),text_search.MakeShortSeg('MAIL_STATE'),text_search.MakeShortSeg('MAIL_ZIP'),text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('addr_suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range'),text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip5'),text_search.MakeShortSeg('zip4'),text_search.MakeShortSeg('mail_prim_range'),text_search.MakeShortSeg('mail_predir'),text_search.MakeShortSeg('mail_prim_name'),text_search.MakeShortSeg('mail_addr_suffix'),text_search.MakeShortSeg('mail_postdir'),text_search.MakeShortSeg('mail_unit_desig'),text_search.MakeShortSeg('mail_sec_range'),text_search.MakeShortSeg('mail_v_city_name'),text_search.MakeShortSeg('mail_st'),text_search.MakeShortSeg('mail_zip5'),text_search.MakeShortSeg('mail_zip4')]}
  ,{text_search.MakeShortSeg('COMPANY'),'COMPANY',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('BUS_NAME')]}
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

