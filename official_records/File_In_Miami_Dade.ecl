 File_In := dataset('~thor_200::in::official_records_fl_miami_dade_new',official_records.Layouts_FL_Miami_dade_In.Layout_FL_Variable_In,
                                                                   csv(heading(1), separator('\t'), terminator(['\n']), quote('"'),MAXLENGTH(8192)),OPT)(payload != ' ',stringlib.stringfind(payload,'row(s) affected',1)=0);
																																	 
																																	 
 
 
 official_records.Layouts_FL_Miami_dade_In.Layout_In_Miami_Dade tr_miami_dade_in(File_In l ) := transform
 
 self.cfn_year                   :=          if (trim(l.payload[1..4]) = 'NULL' ,'', trim(l.payload[1..4]));
  self.cfn_sequence_char        :=    if (trim(l.payload[5..14]) = 'NULL','',  trim(l.payload[5..14]));
 self.group_id        :=    if (trim(l.payload[15..19]) = 'NULL','',  trim(l.payload[15..19]));
 self.recording_date        :=    if (trim(l.payload[20..27]) = 'NULL','',  trim(l.payload[20..27]));
 self.recording_time        :=    if (trim(l.payload[28..33]) = 'NULL','', trim(l.payload[28..33]));
  self.recording_book        :=    if (trim(l.payload[34..47]) = 'NULL','', trim(l.payload[34..47]));
 self.recording_page        :=    if (trim(l.payload[48..52]) = 'NULL','', trim(l.payload[48..52]));
 self.book_type_character        :=    if (trim(l.payload[53..54]) = 'NULL','', trim(l.payload[53..54]));
 self.document_pages        :=    if (trim(l.payload[55..59]) = 'NULL','',trim(l.payload[55..59]));
 self.append_pages        :=    if (trim(l.payload[60..64]) = 'NULL','', trim(l.payload[60..64]));
  self.document_type        :=    if (trim(l.payload[65..79]) = 'NULL','',    trim(l.payload[65..79]));
  self.document_type_description        :=    if (trim(l.payload[80..119]) = 'NULL','',trim(l.payload[80..119]));
 self.document_date        :=    if (trim(l.payload[120..127]) = 'NULL','',trim(l.payload[120..127]));
  self.first_party        :=    if (trim(l.payload[128..227]) = 'NULL','',trim(l.payload[128..227]));
 self.first_party_code        :=    if (trim(l.payload[228]) = 'NULL','', trim(l.payload[228]));
  self.cross_party_name        :=    if (trim(l.payload[229..328]) = 'NULL','', trim(l.payload[229..328]));
 self.original_cfn_year        :=    if (trim(l.payload[329..332]) = 'NULL','',  trim(l.payload[329..332]));
  self.original_cfn_sequence        :=    if (trim(l.payload[333..342]) = 'NULL','', trim(l.payload[333..342]));
  self.original_recording_book        :=    if (trim(l.payload[343..352]) = 'NULL','',trim(l.payload[343..352]));
 self.original_recording_page        :=    if (trim(l.payload[353..357]) = 'NULL','', trim(l.payload[353..357]));
  self.original_miscellaneous_reference        :=    if (trim(l.payload[358..407]) = 'NULL','',trim(l.payload[358..407]));
  self.subdivision_name        :=    if (trim(l.payload[408..497]) = 'NULL','', trim(l.payload[408..497]));
  self.folio_number        :=    if (trim(l.payload[498..513]) = 'NULL','', trim(l.payload[498..513]));
  self.legal_description        :=    if (trim(l.payload[514..613]) = 'NULL','', trim(l.payload[514..613]));
 self.section        :=    if (trim(l.payload[614..618]) = 'NULL','',trim(l.payload[614..618]));
 self.township        :=    if (trim(l.payload[619..623]) = 'NULL','',trim(l.payload[619..623]));
 self.range        :=    if (trim(l.payload[624..627]) = 'NULL','', trim(l.payload[624..627]));
  self.plat_book        :=    if (trim(l.payload[628..641]) = 'NULL',''  ,trim(l.payload[628..641]));
 self.plat_page        :=    if (trim(l.payload[642..647]) = 'NULL','', trim(l.payload[642..647]));
  self.block        :=    if (trim(l.payload[648..667]) = 'NULL','',trim(l.payload[648..667]));
  self.case_number        :=    if (trim(l.payload[668..697]) = 'NULL','', trim(l.payload[668..697]));
  self.consideration_1        :=    if (trim(l.payload[698..716]) = 'NULL','', trim(l.payload[698..716]));
  self.consideration_2        :=    if (trim(l.payload[717..735]) = 'NULL','',trim(l.payload[717..735] ));
  self.deed_document_tax        :=    if (trim(l.payload[736..754]) = 'NULL','',trim(l.payload[736..754]));
 self.single_family        :=    if (trim(l.payload[755]) = 'NULL','',trim(l.payload[755]));
  self.surtax        :=    if (trim(l.payload[756..774]) = 'NULL','',trim(l.payload[756..774]));
  self.intangible        :=    if (trim(l.payload[775..796]) = 'NULL','',trim(l.payload[775..796]));
  self.documentary_stamps        :=    if (trim(l.payload[797..815]) = 'NULL','',trim(l.payload[797..815]));
  self.key        :=    if (trim(l.payload[816..828]) = 'NULL','',trim(l.payload[816..828]));
 self.transaction_type        :=    if (trim(l.payload[829]) = 'NULL','',trim(l.payload[829]));
 self.lf        :=    if (trim(l.payload[830]) = 'NULL','',trim(l.payload[830]));
 
 END;
 
 prj_miami_dade := project(File_In,tr_miami_dade_in(LEFT));
 
 export File_In_Miami_Dade := prj_miami_dade;



