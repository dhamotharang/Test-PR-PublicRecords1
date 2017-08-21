import lib_stringlib;

Layouts_Sarasota.raw.document map2time(Files_raw.Sarasota.File_raw_document l) := transform
   self.timeReceived := trim(l.timeReceived) [1..stringlib.stringfind(l.timeReceived,' ',1)];
   self.lf := '';
	 self    := l;
  end;
  
  dfmttime := project(Files_raw.Sarasota.File_raw_document,map2time(LEFT));
 

dist_doc := distribute( dfmttime,hash(instrument_number));
dist_grantor := distribute( Files_raw.Sarasota.File_raw_grantor,hash(instrument_number));
dist_grantee := distribute( Files_raw.Sarasota.File_raw_grantee,hash(instrument_number));
dist_legal := distribute( Files_raw.Sarasota.File_raw_legal,hash(instrument_number));
dist_crossref := distribute( Files_raw.Sarasota.File_raw_crossref,hash(instrument_number));
 
Layouts_Sarasota.Layout_Common  combine_1( dist_doc l , dist_grantor r ) := transform
self.instrument_number := l.instrument_number;
self.grantor_seqno := r.grantor_seqno;
self.grantor_last_name := r.grantor_last_name;
self.grantor_first_name := r.grantor_first_name;
self.grantor_status := r.grantor_status;
self.grantor_ind_or_cflag := r.grantor_ind_or_cflag;
self.grantor_middle_name := r.grantor_middle_name;
self.grantor_suffix := r.grantor_suffix;

self := l;
self := [];
end;

j1 := Join ( dist_doc,
                      dist_grantor,
											left.instrument_number = right.instrument_number,
											combine_1(left,right),
											left outer,local);
											
Layouts_Sarasota.Layout_Common  combine_2( j1 l , dist_grantee r ) := transform
self.instrument_number := l.instrument_number;
self.grantee_last_name := r.grantee_last_name;
self.grantee_first_name := r.grantee_first_name;
self.grantee_status := r.grantee_status;
self.grantee_ind_or_cflag := r.grantee_ind_or_cflag;
self.grantee_middle_name := r.grantee_middle_name;
self.grantee_suffix := r.grantee_suffix;

self := l;
self := [];
end;

j2 := Join ( j1,
                      dist_grantee,
											left.instrument_number = right.instrument_number,
											combine_2(left,right),
											left outer,local);
											
Layouts_Sarasota.Layout_Common  combine_3( j2 l , dist_legal r ) := transform
self.instrument_number := l.instrument_number;
self.multi_seq := r.multi_seq;
self.legal_seq := r.legal_seq;
self.combo    := r.combo;
self.section := r.section;                   
self.township := r.township;                 
self.range1 := r.range1;                       
self.qtr1 := r.qtr1;                         
self.qtr2 := r.qtr2;                         
self.lotto := r.lotto;                       
self.unit := r.unit;                         
self.building := r.building;                 
self.survey_name := r.survey_name;
self.addition  := r.addition;           
self.street_number := r.street_number;       
self.street_addr := r.street_addr;           
self.pin_id := r.pin_id;
self.freeform_legal := r.freeform_legal;                     
self.mapcase_number := r.mapcase_number;     
self.slide_number := r.slide_number;         
self.town := r.town;                         
self.pd_page := r.pd_page;                   
self.pd_volume := r.pd_volume;               
self.acrreage := r.acrreage;                 
self.condo := r.condo;                       
self.abstract := r.abstract;                 
self := l;
self := [];
end;

j3 := Join ( j2,
                      dist_legal,
											left.instrument_number = right.instrument_number,
											combine_3(left,right),
											left outer,local);
											

Layouts_Sarasota.Layout_Common  combine_4( j3 l , dist_crossref r ) := transform
self.instrument_number := l.instrument_number;
self.ref_book_type := r.ref_book_type;                 
self.ref_book := r.ref_book;                           
self.ref_page := r.ref_page;                           
self.ref_instrument_number := r.ref_instrument_number; 
self.ref_multi_seq := r.ref_multi_seq;                 
self.ref_document_type := r.ref_document_type;         
self.ref_type := r.ref_type;                           
                                                       

self := l;
end;

export File_In_FL_Sarasota := Join ( j3,
                                    dist_crossref,
											               left.instrument_number = right.instrument_number,
											               combine_4(left,right),
											               left outer,local) : persist('~thor_data400::persist::ofr_sarasota_raw');






