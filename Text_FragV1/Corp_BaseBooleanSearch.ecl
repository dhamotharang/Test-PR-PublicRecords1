import text_search,ut,SALT,MDR;
export Corp_BaseBooleanSearch(dataset(layout_Corp_Base) ih)  := MODULE
shared h := ih; // More - use propogated data
// Now recreate the file in 'segname' form for eventual data load
  rf := record
  unsigned6 rid := h.rid;
  unsigned6 sid := h.sid;
  unsigned6 lid := (unsigned6)h.did;
    h.corp_legal_name;
    h.corp_address1_line1;
    h.corp_address1_line2;
    h.corp_address1_line3;
    h.corp_address1_line4;
    h.corp_address1_line5;
    h.corp_address1_line6;
    h.corp_address2_line1;
    h.corp_address2_line2;
    h.corp_address2_line3;
    h.corp_address2_line4;
    h.corp_address2_line5;
    h.corp_address2_line6;
    h.corp_phone_number;
    h.corp_fax_nbr;
    h.corp_addr1_prim_range;
    h.corp_addr1_predir;
    h.corp_addr1_prim_name;
    h.corp_addr1_addr_suffix;
    h.corp_addr1_postdir;
    h.corp_addr1_unit_desig;
    h.corp_addr1_sec_range;
    h.corp_addr1_p_city_name;
    h.corp_addr1_v_city_name;
    h.corp_addr1_state;
    h.corp_addr1_zip5;
    h.corp_addr1_zip4;
    h.corp_addr2_prim_range;
    h.corp_addr2_predir;
    h.corp_addr2_prim_name;
    h.corp_addr2_addr_suffix;
    h.corp_addr2_postdir;
    h.corp_addr2_unit_desig;
    h.corp_addr2_sec_range;
    h.corp_addr2_p_city_name;
    h.corp_addr2_v_city_name;
    h.corp_addr2_state;
    h.corp_addr2_zip5;
    h.corp_addr2_zip4;
    h.corp_phone10;
    h.corp_ra_name;
    h.corp_ra_ssn;
    h.corp_ra_dob;
    h.corp_ra_address_line1;
    h.corp_ra_address_line2;
    h.corp_ra_address_line3;
    h.corp_ra_address_line4;
    h.corp_ra_address_line5;
    h.corp_ra_address_line6;
    h.corp_ra_phone_number;
    h.corp_ra_fax_nbr;
  end;
export TranslatedFile := table(h,rf);
Text_Search.Layout_Posting Into(h le,unsigned2 c) := transform
  self.word := choose(c,(string)le.corp_legal_name,(string)le.corp_address1_line1,(string)le.corp_address1_line2,(string)le.corp_address1_line3,(string)le.corp_address1_line4,(string)le.corp_address1_line5,(string)le.corp_address1_line6,(string)le.corp_address2_line1,(string)le.corp_address2_line2,(string)le.corp_address2_line3,(string)le.corp_address2_line4,(string)le.corp_address2_line5,(string)le.corp_address2_line6,(string)le.corp_phone_number,(string)le.corp_fax_nbr,(string)le.corp_addr1_prim_range,(string)le.corp_addr1_predir,(string)le.corp_addr1_prim_name,(string)le.corp_addr1_addr_suffix,(string)le.corp_addr1_postdir,(string)le.corp_addr1_unit_desig,(string)le.corp_addr1_sec_range,(string)le.corp_addr1_p_city_name,(string)le.corp_addr1_v_city_name,(string)le.corp_addr1_state,(string)le.corp_addr1_zip5,(string)le.corp_addr1_zip4,(string)le.corp_addr2_prim_range,(string)le.corp_addr2_predir,(string)le.corp_addr2_prim_name,(string)le.corp_addr2_addr_suffix,(string)le.corp_addr2_postdir,(string)le.corp_addr2_unit_desig,(string)le.corp_addr2_sec_range,(string)le.corp_addr2_p_city_name,(string)le.corp_addr2_v_city_name,(string)le.corp_addr2_state,(string)le.corp_addr2_zip5,(string)le.corp_addr2_zip4,(string)le.corp_phone10,(string)le.corp_ra_name,(string)le.corp_ra_ssn,(string)le.corp_ra_dob,(string)le.corp_ra_address_line1,(string)le.corp_ra_address_line2,(string)le.corp_ra_address_line3,(string)le.corp_ra_address_line4,(string)le.corp_ra_address_line5,(string)le.corp_ra_address_line6,(string)le.corp_ra_phone_number,(string)le.corp_ra_fax_nbr,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  self.len := length(trim(self.word));
  self.wip := 1; // Adjusted later
  self.nominal := 0; //Filled in later
  self.suffix := 0; // Filled in later
  self.part := thorlib.node();
  self.kwp := 0; // Adjusted later
  self.docref.doc := le.rid; // Filled in later
  self.docref.src := TRANSFER(le.source,UNSIGNED2); // Filled in later
  self.src := TRANSFER(le.source,UNSIGNED2); // Namespace for ID provided
  self.seg := c; // Field number is seg; values filled in in segment definition
  self.segName := Text_Search.MakeShortSeg(choose(c,'corp_legal_name','corp_address1_line1','corp_address1_line2','corp_address1_line3','corp_address1_line4','corp_address1_line5','corp_address1_line6','corp_address2_line1','corp_address2_line2','corp_address2_line3','corp_address2_line4','corp_address2_line5','corp_address2_line6','corp_phone_number','corp_fax_nbr','corp_addr1_prim_range','corp_addr1_predir','corp_addr1_prim_name','corp_addr1_addr_suffix','corp_addr1_postdir','corp_addr1_unit_desig','corp_addr1_sec_range','corp_addr1_p_city_name','corp_addr1_v_city_name','corp_addr1_state','corp_addr1_zip5','corp_addr1_zip4','corp_addr2_prim_range','corp_addr2_predir','corp_addr2_prim_name','corp_addr2_addr_suffix','corp_addr2_postdir','corp_addr2_unit_desig','corp_addr2_sec_range','corp_addr2_p_city_name','corp_addr2_v_city_name','corp_addr2_state','corp_addr2_zip5','corp_addr2_zip4','corp_phone10','corp_ra_name','corp_ra_ssn','corp_ra_dob','corp_ra_address_line1','corp_ra_address_line2','corp_ra_address_line3','corp_ra_address_line4','corp_ra_address_line5','corp_ra_address_line6','corp_ra_phone_number','corp_ra_fax_nbr','CASS1_ADDR1','CASS1_CSZ','CASS2_ADDR1','CASS2_CSZ','NAME','SSN','DOB','ADDRESS','PHONE','COMPANY'));
  self.typ := text_search.types.WordType.TextStr; // May get changed later
  self.sect := 0; // Not needed
  self.pos := 0; // Not needed
  self.rid := le.rid;
  self.sid := le.sid;
  self.lid := (unsigned6)le.did;
end;
shared FieldsAsPostings := normalize(h,61,into(left,counter))(word <> ' ');
export SegmentDefinitions := dataset([  {text_search.MakeShortSeg('corp_legal_name'),'corp_legal_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_legal_name')]}
  ,{text_search.MakeShortSeg('corp_address1_line1'),'corp_address1_line1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line1')]}
  ,{text_search.MakeShortSeg('corp_address1_line2'),'corp_address1_line2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line2')]}
  ,{text_search.MakeShortSeg('corp_address1_line3'),'corp_address1_line3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line3')]}
  ,{text_search.MakeShortSeg('corp_address1_line4'),'corp_address1_line4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line4')]}
  ,{text_search.MakeShortSeg('corp_address1_line5'),'corp_address1_line5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line5')]}
  ,{text_search.MakeShortSeg('corp_address1_line6'),'corp_address1_line6',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line6')]}
  ,{text_search.MakeShortSeg('corp_address2_line1'),'corp_address2_line1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address2_line1')]}
  ,{text_search.MakeShortSeg('corp_address2_line2'),'corp_address2_line2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address2_line2')]}
  ,{text_search.MakeShortSeg('corp_address2_line3'),'corp_address2_line3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address2_line3')]}
  ,{text_search.MakeShortSeg('corp_address2_line4'),'corp_address2_line4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address2_line4')]}
  ,{text_search.MakeShortSeg('corp_address2_line5'),'corp_address2_line5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address2_line5')]}
  ,{text_search.MakeShortSeg('corp_address2_line6'),'corp_address2_line6',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address2_line6')]}
  ,{text_search.MakeShortSeg('corp_phone_number'),'corp_phone_number',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('corp_phone_number')]}
  ,{text_search.MakeShortSeg('corp_fax_nbr'),'corp_fax_nbr',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('corp_fax_nbr')]}
  ,{text_search.MakeShortSeg('corp_addr1_prim_range'),'corp_addr1_prim_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_prim_range')]}
  ,{text_search.MakeShortSeg('corp_addr1_predir'),'corp_addr1_predir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_predir')]}
  ,{text_search.MakeShortSeg('corp_addr1_prim_name'),'corp_addr1_prim_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_prim_name')]}
  ,{text_search.MakeShortSeg('corp_addr1_addr_suffix'),'corp_addr1_addr_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_addr_suffix')]}
  ,{text_search.MakeShortSeg('corp_addr1_postdir'),'corp_addr1_postdir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_postdir')]}
  ,{text_search.MakeShortSeg('corp_addr1_unit_desig'),'corp_addr1_unit_desig',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_unit_desig')]}
  ,{text_search.MakeShortSeg('corp_addr1_sec_range'),'corp_addr1_sec_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_sec_range')]}
  ,{text_search.MakeShortSeg('corp_addr1_p_city_name'),'corp_addr1_p_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_p_city_name')]}
  ,{text_search.MakeShortSeg('corp_addr1_v_city_name'),'corp_addr1_v_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_v_city_name')]}
  ,{text_search.MakeShortSeg('corp_addr1_state'),'corp_addr1_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_state')]}
  ,{text_search.MakeShortSeg('corp_addr1_zip5'),'corp_addr1_zip5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_zip5')]}
  ,{text_search.MakeShortSeg('corp_addr1_zip4'),'corp_addr1_zip4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr1_zip4')]}
  ,{text_search.MakeShortSeg('corp_addr2_prim_range'),'corp_addr2_prim_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_prim_range')]}
  ,{text_search.MakeShortSeg('corp_addr2_predir'),'corp_addr2_predir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_predir')]}
  ,{text_search.MakeShortSeg('corp_addr2_prim_name'),'corp_addr2_prim_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_prim_name')]}
  ,{text_search.MakeShortSeg('corp_addr2_addr_suffix'),'corp_addr2_addr_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_addr_suffix')]}
  ,{text_search.MakeShortSeg('corp_addr2_postdir'),'corp_addr2_postdir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_postdir')]}
  ,{text_search.MakeShortSeg('corp_addr2_unit_desig'),'corp_addr2_unit_desig',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_unit_desig')]}
  ,{text_search.MakeShortSeg('corp_addr2_sec_range'),'corp_addr2_sec_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_sec_range')]}
  ,{text_search.MakeShortSeg('corp_addr2_p_city_name'),'corp_addr2_p_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_p_city_name')]}
  ,{text_search.MakeShortSeg('corp_addr2_v_city_name'),'corp_addr2_v_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_v_city_name')]}
  ,{text_search.MakeShortSeg('corp_addr2_state'),'corp_addr2_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_state')]}
  ,{text_search.MakeShortSeg('corp_addr2_zip5'),'corp_addr2_zip5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_zip5')]}
  ,{text_search.MakeShortSeg('corp_addr2_zip4'),'corp_addr2_zip4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_addr2_zip4')]}
  ,{text_search.MakeShortSeg('corp_phone10'),'corp_phone10',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_phone10')]}
  ,{text_search.MakeShortSeg('corp_ra_name'),'corp_ra_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_ra_name')]}
  ,{text_search.MakeShortSeg('corp_ra_ssn'),'corp_ra_ssn',text_search.types.SegmentType.SSN,[text_search.MakeShortSeg('corp_ra_ssn')]}
  ,{text_search.MakeShortSeg('corp_ra_dob'),'corp_ra_dob',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('corp_ra_dob')]}
  ,{text_search.MakeShortSeg('corp_ra_address_line1'),'corp_ra_address_line1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_ra_address_line1')]}
  ,{text_search.MakeShortSeg('corp_ra_address_line2'),'corp_ra_address_line2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_ra_address_line2')]}
  ,{text_search.MakeShortSeg('corp_ra_address_line3'),'corp_ra_address_line3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_ra_address_line3')]}
  ,{text_search.MakeShortSeg('corp_ra_address_line4'),'corp_ra_address_line4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_ra_address_line4')]}
  ,{text_search.MakeShortSeg('corp_ra_address_line5'),'corp_ra_address_line5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_ra_address_line5')]}
  ,{text_search.MakeShortSeg('corp_ra_address_line6'),'corp_ra_address_line6',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_ra_address_line6')]}
  ,{text_search.MakeShortSeg('corp_ra_phone_number'),'corp_ra_phone_number',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('corp_ra_phone_number')]}
  ,{text_search.MakeShortSeg('corp_ra_fax_nbr'),'corp_ra_fax_nbr',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('corp_ra_fax_nbr')]}
  ,{text_search.MakeShortSeg('CASS1_ADDR1'),'CASS1_ADDR1',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('corp_addr1_prim_range'),text_search.MakeShortSeg('corp_addr1_predir'),text_search.MakeShortSeg('corp_addr1_prim_name'),text_search.MakeShortSeg('corp_addr1_addr_suffix'),text_search.MakeShortSeg('corp_addr1_postdir'),text_search.MakeShortSeg('corp_addr1_unit_desig'),text_search.MakeShortSeg('corp_addr1_sec_range')]}
  ,{text_search.MakeShortSeg('CASS1_CSZ'),'CASS1_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('corp_addr1_v_city_name'),text_search.MakeShortSeg('corp_addr1_state'),text_search.MakeShortSeg('corp_addr1_zip5'),text_search.MakeShortSeg('corp_addr1_zip4')]}
  ,{text_search.MakeShortSeg('CASS2_ADDR1'),'CASS2_ADDR1',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('corp_addr2_prim_range'),text_search.MakeShortSeg('corp_addr2_predir'),text_search.MakeShortSeg('corp_addr2_prim_name'),text_search.MakeShortSeg('corp_addr2_addr_suffix'),text_search.MakeShortSeg('corp_addr2_postdir'),text_search.MakeShortSeg('corp_addr2_unit_desig'),text_search.MakeShortSeg('corp_addr2_sec_range')]}
  ,{text_search.MakeShortSeg('CASS2_CSZ'),'CASS2_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('corp_addr2_v_city_name'),text_search.MakeShortSeg('corp_addr2_state'),text_search.MakeShortSeg('corp_addr2_zip5'),text_search.MakeShortSeg('corp_addr2_zip4')]}
  ,{text_search.MakeShortSeg('NAME'),'NAME',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('corp_legal_name')]}
  ,{text_search.MakeShortSeg('SSN'),'SSN',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('corp_ra_ssn')]}
  ,{text_search.MakeShortSeg('DOB'),'DOB',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('corp_ra_dob')]}
  ,{text_search.MakeShortSeg('ADDRESS'),'ADDRESS',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('corp_ra_address_line5'),text_search.MakeShortSeg('corp_ra_address_line6')]}
  ,{text_search.MakeShortSeg('PHONE'),'PHONE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('corp_phone10'),text_search.MakeShortSeg('corp_fax_nbr'),text_search.MakeShortSeg('corp_phone_number')]}
  ,{text_search.MakeShortSeg('COMPANY'),'COMPANY',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('corp_legal_name')]}
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

