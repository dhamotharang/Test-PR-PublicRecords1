/* **************************** 
PLEASE DO NOT CALL THIS MACRO DIRECTLY.  
THIS SHOULD BE ACCESSED ONLY VIA DIDVILLE.MAC_DIDAPPEND
PLEASE CALL DIDVILLE.MAC_DIDAPPEND
**************************** */
export MAC_DidAppend_xLink(infile,outfile,deduped,do_fuzzy,all_scores = 'false',
                        LMaxScores = 'didville.MaxScores.MMax',
												verify_value='\'\'',inLimit = 1) := macro

import ut, Email_Data, IDLExternalLinking, InsuranceHeader_xLink;

//prepare the layout and call new ADL2 macro
#uniquename(file_in_xadl2)
%file_in_xadl2% := project(infile, transform({Insuranceheader_xLink.Layout_Person_xLink},
                                             self.uniqueid := left.seq,								 														 
																						 self.name_suffix := left.suffix,
																						 self.city := left.p_city_name,
																						 self.state := left.st,
																						 self.zip  := left.z5,
																						 self.phone := left.phone10,																						 
                                             self := left, self := []));

#uniquename(file_out_xlink)				
IDLExternalLinking.mac_xlinking_on_roxie(%file_in_xadl2%, did ,name_suffix ,fname ,mname ,lname ,
																, ,prim_name, prim_range, sec_range, city, state, 
																		zip, ssn, DOB, phone,  dl_state, dl_nbr,
																		%file_out_xlink%,  30,3, true, relative_fname, relative_lname)
 

// only return the dids by email when the email address is the only thing provided in the search.		
// when xADL2 is updated to use email as an input, this join should be removed.	
#uniquename(email_dids)
		%email_dids% :=
		dedup(
			join(
				infile, Email_Data.Key_Email_Address,
		    keyed( trim(left.email) = right.clean_email) and left.email <> '' and
				left.did=0 and left.ssn='' and left.fname='' and left.lname='' and left.st=''
				and left.z5 = '',
				transform(RECORDOF(%file_out_xlink%),				
				self.did := if (left.did=0,right.did,left.did),
				self.reference := left.seq,
				self.weight := 0,
				self.keys_used := 0, 
				self := [])
				,limit(100, skip)),
			reference,did,all
		);

#uniquename(file_out_xadl2_or_email)
 %file_out_xadl2_or_email%	:= if (exists(%email_dids%),dedup(%file_out_xlink%+%email_dids%,reference,did,all),%file_out_xlink%);	
			
//compute score_any_ fields for ADL2, fetch DID, DID score and score_any_ fields from ADL2
#uniquename(file_out_xadl2_final)				
#uniquename(need_score_any)
%need_score_any% := stringlib.stringfind(verify_value,'ANY_ALL',1) != 0 or 
                    stringlib.stringfind(verify_value,'ANY_SSN',1) != 0 or 
										stringlib.stringfind(verify_value,'ANY_ADDR',1) != 0 or 
                    stringlib.stringfind(verify_value,'ANY_DOB',1) != 0 or 
										stringlib.stringfind(verify_value,'ANY_PHONE',1) != 0;

didville.MAC_Convert_Score_Any(%file_out_xadl2_or_email%, %file_out_xadl2_final%, LMaxScores, %need_score_any%)				

#uniquename(get_xadl2_did_score)
didville.layout_did_outbatch %get_xadl2_did_score%(infile l, %file_out_xadl2_final% r)	:= transform
	self.did := if(r.did > 0, r.did, l.did),
	self.score := r.score,
	self.score_any_ssn := if(stringlib.stringfind(verify_value,'ANY_ALL',1) != 0 or stringlib.stringfind(verify_value,'ANY_SSN',1) != 0,r.score_any_ssn,255);
	self.score_any_addr := if(stringlib.stringfind(verify_value,'ANY_ALL',1) != 0 or stringlib.stringfind(verify_value,'ANY_ADDR',1) != 0,if(l.lname<>'' or l.fname<>'',r.score_any_addr,0),255); 
	self.score_any_dob := if(stringlib.stringfind(verify_value,'ANY_ALL',1) != 0 or stringlib.stringfind(verify_value,'ANY_DOB',1) != 0,if(l.lname<>'' or l.fname<>'',r.score_any_dob,0),255);
	self.score_any_phn := if(stringlib.stringfind(verify_value,'ANY_ALL',1) != 0 or stringlib.stringfind(verify_value,'ANY_PHONE',1) != 0,if(l.lname<>'' or l.fname<>'',r.score_any_phn,0),255);
	self := l;
	self := [];
end;			
				
#uniquename(file_w_did2_raw)				
%file_w_did2_raw% := join(infile, %file_out_xadl2_final%, 
                        left.seq = right.reference,
                        %get_xadl2_did_score%(left, right), 
												limit(ut.limits.DID_PER_PERSON), left outer);

//check if dedup was requested, decide which version's output to generate																			 
#uniquename(file_w_did2_srt)							
#uniquename(file_w_did2)												 
%file_w_did2_srt% := sort(%file_w_did2_raw%, seq, -score, did);																				 
%file_w_did2% := group(if(deduped, 
                        dedup(%file_w_did2_srt%, seq,keep(inLimit)), 
												%file_w_did2_srt%), seq);																										 

outfile := %file_w_did2%;
endmacro;					
