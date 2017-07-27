import Business_Header_SS,business_header,ut,did_add;
//All IDEXEC data
full_file := InfoUSA.fIDEXEC_as_Business_Header(InfoUSA.update_IDEXEC);

//add BDID
BDID_Matchset := ['A','P']; 

Business_Header_SS.MAC_Add_BDID_Flex(full_file,
                                  BDID_Matchset,
                                  company_name,
                                  prim_range, prim_name, zip,
                                  sec_range, state,
                                  phone, fein_field,
                                  bdid, business_header.Layout_Business_Header,
                                  false, BDID_score_field,
                                  idexec_bdid_init)
																	
idexec_bdid_match := idexec_bdid_init(bdid <> 0);

idexec_bdid_nomatch := idexec_bdid_init(bdid = 0);
Business_Header.MAC_Source_Match(idexec_bdid_nomatch, idexec_bdid_rematch,
                        false, bdid,
                        false, 'II',
                        true, source_group,
                        company_name,
                        prim_range, prim_name, sec_range, zip,
                        true, phone,
                        false, fein_field,
				        true, vendor_id);

idexec_bdid_all := idexec_bdid_match + idexec_bdid_rematch;

//Add back to original layout
file_full_layout := InfoUSA.update_IDEXEC;

bdid_layout := record
unsigned6 bdid;
InfoUSA.Layout_Cleaned_IDEXEC_file;
end;

bdid_layout getFull(idexec_bdid_all L, file_full_layout R) := transform
 self.bdid := l.bdid;
 self := r;
end;

all_data := join(idexec_bdid_all(bdid>0),file_full_layout,left.vendor_id=right.idexec_key,getFull(left,right),hash);


export IDEXEC_BDID := dedup(all_data,hash);