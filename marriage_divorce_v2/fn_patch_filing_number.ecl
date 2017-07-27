//this function fixes format discrepancies between Direct and XML records
//seems limited to CT Marriages

export fn_patch_filing_number(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function

    ct_candidate_recs := int0(  state_origin ='CT' and stringlib.stringfind(source_file,'XML',1)!=0);
not_ct_candidate_recs := int0(~(state_origin ='CT' and stringlib.stringfind(source_file,'XML',1)!=0));

recordof(int0) t_fix_filing_number(recordof(int0) le) := transform
 
 //looking for a value between 1-5 characters
 // string rmv_null_filling_number := if(regexfind('[\\x00]',trim(le.marriage_filing_number)),'',le.marriage_filing_number);
 boolean null_number_candidate := stringlib.stringfind(le.marriage_filing_number, '\000',1) > 0;
 string v_rmv_null_nbr	 := If(null_number_candidate,Stringlib.stringfilterOut(le.marriage_filing_number,'\000'),
															'');
 string v_retain_nbr  := if(v_rmv_null_nbr != '' and length(trim(v_rmv_null_nbr)) <= 5,'', v_rmv_null_nbr);
 
 boolean filing_number_is_candidate := le.marriage_filing_number<>'' and length(trim(le.marriage_filing_number))<=5;
 
 string  v_padded_filing_number := (string)intformat((integer)le.marriage_filing_number,5,1);
 
 string  v_marriage_year := if(le.marriage_dt<>'',le.marriage_dt[1..4],'');
 
 self.marriage_filing_number := if(filing_number_is_candidate,v_padded_filing_number+v_marriage_year,
																		if(null_number_candidate,v_retain_nbr,le.marriage_filing_number));
 self                        := le;

end;
 
fixed_filing_number := project(ct_candidate_recs,t_fix_filing_number(left));


recordof(int0) t_fix_filing_number_rest(recordof(int0) le) := transform
// self.marriage_filing_number := if(regexfind('[\\x00]',trim(le.marriage_filing_number)),'',le.marriage_filing_number);
boolean null_number_candidate := stringlib.stringfind(le.marriage_filing_number, '\000',1) > 0;
string v_rmv_null_nbr	 := If(null_number_candidate,Stringlib.stringfilterOut(le.marriage_filing_number,'\000'),
															'');
string v_retain_nbr  := if(v_rmv_null_nbr != '' and length(trim(v_rmv_null_nbr)) <= 5,'', v_rmv_null_nbr);
 
self.marriage_filing_number := if(null_number_candidate,v_retain_nbr,le.marriage_filing_number);
																	 
self                        := le;

end;

fixed_filing_number_rest := project(not_ct_candidate_recs,t_fix_filing_number_rest(left));

// concat := fixed_filing_number+not_ct_candidate_recs;
concat := fixed_filing_number + fixed_filing_number_rest;

return concat;

end;