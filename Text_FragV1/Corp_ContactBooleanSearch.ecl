import text_search,ut,SALT,MDR;
export Corp_ContactBooleanSearch(dataset(layout_Corp_Contact) ih)  := MODULE
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
    h.corp_phone_number;
    h.corp_fax_nbr;
    h.cont_name;
    h.cont_title_desc;
    h.cont_address_line1;
    h.cont_address_line2;
    h.cont_address_line3;
    h.cont_address_line4;
    h.cont_address_line5;
    h.cont_address_line6;
    h.cont_phone_number;
    h.cont_fax_nbr;
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
    h.cont_title;
    h.cont_fname;
    h.cont_mname;
    h.cont_lname;
    h.cont_name_suffix;
    h.cont_cname;
    h.cont_prim_range;
    h.cont_predir;
    h.cont_prim_name;
    h.cont_addr_suffix;
    h.cont_postdir;
    h.cont_unit_desig;
    h.cont_sec_range;
    h.cont_p_city_name;
    h.cont_v_city_name;
    h.cont_state;
    h.cont_zip5;
    h.cont_zip4;
  end;
export TranslatedFile := table(h,rf);
Text_Search.Layout_Posting Into(h le,unsigned2 c) := transform
  self.word := choose(c,(string)le.corp_legal_name,(string)le.corp_address1_line1,(string)le.corp_address1_line2,(string)le.corp_address1_line3,(string)le.corp_address1_line4,(string)le.corp_address1_line5,(string)le.corp_address1_line6,(string)le.corp_phone_number,(string)le.corp_fax_nbr,(string)le.cont_name,(string)le.cont_title_desc,(string)le.cont_address_line1,(string)le.cont_address_line2,(string)le.cont_address_line3,(string)le.cont_address_line4,(string)le.cont_address_line5,(string)le.cont_address_line6,(string)le.cont_phone_number,(string)le.cont_fax_nbr,(string)le.corp_addr1_prim_range,(string)le.corp_addr1_predir,(string)le.corp_addr1_prim_name,(string)le.corp_addr1_addr_suffix,(string)le.corp_addr1_postdir,(string)le.corp_addr1_unit_desig,(string)le.corp_addr1_sec_range,(string)le.corp_addr1_p_city_name,(string)le.corp_addr1_v_city_name,(string)le.corp_addr1_state,(string)le.corp_addr1_zip5,(string)le.corp_addr1_zip4,(string)le.cont_title,(string)le.cont_fname,(string)le.cont_mname,(string)le.cont_lname,(string)le.cont_name_suffix,(string)le.cont_cname,(string)le.cont_prim_range,(string)le.cont_predir,(string)le.cont_prim_name,(string)le.cont_addr_suffix,(string)le.cont_postdir,(string)le.cont_unit_desig,(string)le.cont_sec_range,(string)le.cont_p_city_name,(string)le.cont_v_city_name,(string)le.cont_state,(string)le.cont_zip5,(string)le.cont_zip4,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  self.len := length(trim(self.word));
  self.wip := 1; // Adjusted later
  self.nominal := 0; //Filled in later
  self.suffix := 0; // Filled in later
  self.part := thorlib.node();
  self.kwp := 0; // Adjusted later
  self.docref.doc := le.rid; // initial value
  self.docref.src := TRANSFER(le.source,UNSIGNED2); // initial value
  self.src := TRANSFER(le.source,UNSIGNED2); // Namespace for ID provided
  self.seg := c; // Field number is seg; values filled in in segment definition
  self.segName := Text_Search.MakeShortSeg(choose(c,'corp_legal_name','corp_address1_line1','corp_address1_line2','corp_address1_line3','corp_address1_line4','corp_address1_line5','corp_address1_line6','corp_phone_number','corp_fax_nbr','cont_name','cont_title_desc','cont_address_line1','cont_address_line2','cont_address_line3','cont_address_line4','cont_address_line5','cont_address_line6','cont_phone_number','cont_fax_nbr','corp_addr1_prim_range','corp_addr1_predir','corp_addr1_prim_name','corp_addr1_addr_suffix','corp_addr1_postdir','corp_addr1_unit_desig','corp_addr1_sec_range','corp_addr1_p_city_name','corp_addr1_v_city_name','corp_addr1_state','corp_addr1_zip5','corp_addr1_zip4','cont_title','cont_fname','cont_mname','cont_lname','cont_name_suffix','cont_cname','cont_prim_range','cont_predir','cont_prim_name','cont_addr_suffix','cont_postdir','cont_unit_desig','cont_sec_range','cont_p_city_name','cont_v_city_name','cont_state','cont_zip5','cont_zip4','CLEAN_NAME','CORP_CASS_ADDRESS1','CORP_CASS_CSZ','CORP_ADDR','CONT_CASS_ADDRESS1','CONT_CASS_CSZ','CONT_ADDR','PHONE','NAME','ADDRESS','COMPANY'));
  self.typ := text_search.types.WordType.TextStr; // May get changed later
  self.sect := 0; // Not needed
  self.pos := 0; // Not needed
  self.rid := le.rid;
  self.sid := le.sid;
  self.lid := (unsigned6)le.did;
end;
shared FieldsAsPostings := normalize(h,60,into(left,counter))(word<>' ');
export SegmentDefinitions := dataset([  {text_search.MakeShortSeg('corp_legal_name'),'corp_legal_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_legal_name')]}
  ,{text_search.MakeShortSeg('corp_address1_line1'),'corp_address1_line1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line1')]}
  ,{text_search.MakeShortSeg('corp_address1_line2'),'corp_address1_line2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line2')]}
  ,{text_search.MakeShortSeg('corp_address1_line3'),'corp_address1_line3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line3')]}
  ,{text_search.MakeShortSeg('corp_address1_line4'),'corp_address1_line4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line4')]}
  ,{text_search.MakeShortSeg('corp_address1_line5'),'corp_address1_line5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line5')]}
  ,{text_search.MakeShortSeg('corp_address1_line6'),'corp_address1_line6',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('corp_address1_line6')]}
  ,{text_search.MakeShortSeg('corp_phone_number'),'corp_phone_number',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('corp_phone_number')]}
  ,{text_search.MakeShortSeg('corp_fax_nbr'),'corp_fax_nbr',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('corp_fax_nbr')]}
  ,{text_search.MakeShortSeg('cont_name'),'cont_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_name')]}
  ,{text_search.MakeShortSeg('cont_title_desc'),'cont_title_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_title_desc')]}
  ,{text_search.MakeShortSeg('cont_address_line1'),'cont_address_line1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_address_line1')]}
  ,{text_search.MakeShortSeg('cont_address_line2'),'cont_address_line2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_address_line2')]}
  ,{text_search.MakeShortSeg('cont_address_line3'),'cont_address_line3',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_address_line3')]}
  ,{text_search.MakeShortSeg('cont_address_line4'),'cont_address_line4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_address_line4')]}
  ,{text_search.MakeShortSeg('cont_address_line5'),'cont_address_line5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_address_line5')]}
  ,{text_search.MakeShortSeg('cont_address_line6'),'cont_address_line6',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_address_line6')]}
  ,{text_search.MakeShortSeg('cont_phone_number'),'cont_phone_number',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('cont_phone_number')]}
  ,{text_search.MakeShortSeg('cont_fax_nbr'),'cont_fax_nbr',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('cont_fax_nbr')]}
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
  ,{text_search.MakeShortSeg('cont_title'),'cont_title',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_title')]}
  ,{text_search.MakeShortSeg('cont_fname'),'cont_fname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_fname')]}
  ,{text_search.MakeShortSeg('cont_mname'),'cont_mname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_mname')]}
  ,{text_search.MakeShortSeg('cont_lname'),'cont_lname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_lname')]}
  ,{text_search.MakeShortSeg('cont_name_suffix'),'cont_name_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_name_suffix')]}
  ,{text_search.MakeShortSeg('cont_cname'),'cont_cname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_cname')]}
  ,{text_search.MakeShortSeg('cont_prim_range'),'cont_prim_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_prim_range')]}
  ,{text_search.MakeShortSeg('cont_predir'),'cont_predir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_predir')]}
  ,{text_search.MakeShortSeg('cont_prim_name'),'cont_prim_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_prim_name')]}
  ,{text_search.MakeShortSeg('cont_addr_suffix'),'cont_addr_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_addr_suffix')]}
  ,{text_search.MakeShortSeg('cont_postdir'),'cont_postdir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_postdir')]}
  ,{text_search.MakeShortSeg('cont_unit_desig'),'cont_unit_desig',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_unit_desig')]}
  ,{text_search.MakeShortSeg('cont_sec_range'),'cont_sec_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_sec_range')]}
  ,{text_search.MakeShortSeg('cont_p_city_name'),'cont_p_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_p_city_name')]}
  ,{text_search.MakeShortSeg('cont_v_city_name'),'cont_v_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_v_city_name')]}
  ,{text_search.MakeShortSeg('cont_state'),'cont_state',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_state')]}
  ,{text_search.MakeShortSeg('cont_zip5'),'cont_zip5',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_zip5')]}
  ,{text_search.MakeShortSeg('cont_zip4'),'cont_zip4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cont_zip4')]}
  ,{text_search.MakeShortSeg('CLEAN_NAME'),'CLEAN_NAME',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('cont_title'),text_search.MakeShortSeg('cont_fname'),text_search.MakeShortSeg('cont_mname'),text_search.MakeShortSeg('cont_lname'),text_search.MakeShortSeg('cont_name_suffix')]}
  ,{text_search.MakeShortSeg('CORP_CASS_ADDRESS1'),'CORP_CASS_ADDRESS1',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('corp_addr1_prim_range'),text_search.MakeShortSeg('corp_addr1_predir'),text_search.MakeShortSeg('corp_addr1_prim_name'),text_search.MakeShortSeg('corp_addr1_addr_suffix'),text_search.MakeShortSeg('corp_addr1_postdir'),text_search.MakeShortSeg('corp_addr1_unit_desig'),text_search.MakeShortSeg('corp_addr1_sec_range')]}
  ,{text_search.MakeShortSeg('CORP_CASS_CSZ'),'CORP_CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('corp_addr1_v_city_name'),text_search.MakeShortSeg('corp_addr1_state'),text_search.MakeShortSeg('corp_addr1_zip5'),text_search.MakeShortSeg('corp_addr1_zip4')]}
  ,{text_search.MakeShortSeg('CORP_ADDR'),'CORP_ADDR',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('corp_address1_line1'),text_search.MakeShortSeg('corp_address1_line2'),text_search.MakeShortSeg('corp_address1_line3'),text_search.MakeShortSeg('corp_address1_line4'),text_search.MakeShortSeg('corp_address1_line5'),text_search.MakeShortSeg('corp_address1_line6')]}
  ,{text_search.MakeShortSeg('CONT_CASS_ADDRESS1'),'CONT_CASS_ADDRESS1',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('cont_prim_range'),text_search.MakeShortSeg('cont_predir'),text_search.MakeShortSeg('cont_prim_name'),text_search.MakeShortSeg('cont_addr_suffix'),text_search.MakeShortSeg('cont_postdir'),text_search.MakeShortSeg('cont_unit_desig'),text_search.MakeShortSeg('cont_sec_range')]}
  ,{text_search.MakeShortSeg('CONT_CASS_CSZ'),'CONT_CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('cont_v_city_name'),text_search.MakeShortSeg('cont_state'),text_search.MakeShortSeg('cont_zip5'),text_search.MakeShortSeg('cont_zip4')]}
  ,{text_search.MakeShortSeg('CONT_ADDR'),'CONT_ADDR',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('cont_address_line1'),text_search.MakeShortSeg('cont_address_line2'),text_search.MakeShortSeg('cont_address_line3'),text_search.MakeShortSeg('cont_address_line4'),text_search.MakeShortSeg('cont_address_line5'),text_search.MakeShortSeg('cont_address_line6')]}
  ,{text_search.MakeShortSeg('PHONE'),'PHONE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('corp_phone_number'),text_search.MakeShortSeg('corp_fax_nbr'),text_search.MakeShortSeg('cont_fax_nbr')]}
  ,{text_search.MakeShortSeg('NAME'),'NAME',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('cont_title'),text_search.MakeShortSeg('cont_title_desc'),text_search.MakeShortSeg('cont_fname'),text_search.MakeShortSeg('cont_mname'),text_search.MakeShortSeg('cont_lname'),text_search.MakeShortSeg('cont_name_suffix'),text_search.MakeShortSeg('cont_name'),text_search.MakeShortSeg('corp_legal_name'),text_search.MakeShortSeg('cont_cname')]}
  ,{text_search.MakeShortSeg('ADDRESS'),'ADDRESS',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('corp_address1_line1'),text_search.MakeShortSeg('corp_address1_line2'),text_search.MakeShortSeg('corp_address1_line3'),text_search.MakeShortSeg('corp_address1_line4'),text_search.MakeShortSeg('corp_address1_line5'),text_search.MakeShortSeg('corp_address1_line6'),text_search.MakeShortSeg('cont_address_line1'),text_search.MakeShortSeg('cont_address_line2'),text_search.MakeShortSeg('cont_address_line3'),text_search.MakeShortSeg('cont_address_line4'),text_search.MakeShortSeg('cont_address_line5'),text_search.MakeShortSeg('cont_address_line6'),text_search.MakeShortSeg('corp_addr1_prim_range'),text_search.MakeShortSeg('corp_addr1_predir'),text_search.MakeShortSeg('corp_addr1_prim_name'),text_search.MakeShortSeg('corp_addr1_addr_suffix'),text_search.MakeShortSeg('corp_addr1_postdir'),text_search.MakeShortSeg('corp_addr1_unit_desig'),text_search.MakeShortSeg('corp_addr1_sec_range'),text_search.MakeShortSeg('corp_addr1_v_city_name'),text_search.MakeShortSeg('corp_addr1_p_city_name'),text_search.MakeShortSeg('corp_addr1_state'),text_search.MakeShortSeg('corp_addr1_zip5'),text_search.MakeShortSeg('corp_addr1_zip4'),text_search.MakeShortSeg('cont_prim_range'),text_search.MakeShortSeg('cont_predir'),text_search.MakeShortSeg('cont_prim_name'),text_search.MakeShortSeg('cont_addr_suffix'),text_search.MakeShortSeg('cont_postdir'),text_search.MakeShortSeg('cont_unit_desig'),text_search.MakeShortSeg('cont_sec_range'),text_search.MakeShortSeg('cont_v_city_name'),text_search.MakeShortSeg('cont_p_city_name'),text_search.MakeShortSeg('cont_state'),text_search.MakeShortSeg('cont_zip5'),text_search.MakeShortSeg('cont_zip4')]}
  ,{text_search.MakeShortSeg('COMPANY'),'COMPANY',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('corp_legal_name'),text_search.MakeShortSeg('cont_cname')]}
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

