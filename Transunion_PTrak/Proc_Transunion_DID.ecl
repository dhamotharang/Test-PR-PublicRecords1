
IMPORT  address, ut, header_slimsort, did_add, didville,watchdog,mdr,header;
EXPORT Proc_Transunion_DID (STRING Full_filedate,STRING Update_filedate) := function

//Add full history file with did set to 0 (so it can be redid) to current update file
reset_base := project(File_Transunion_DID_Out, transform(recordof(File_Transunion_DID_Out), self.did := 0, self.is_current := if(Full_filedate <> '',false, left.is_current), self := left)); 

normalized_clean := Join_Transunion_Normalized_Clean (full_filedate, update_filedate) + reset_base;   
//-----------------------------------------------------------------
//FILE ROLLUP TO HAVE UNIQUE RECORDS
//-----------------------------------------------------------------
d_normalized_clean := DISTRIBUTE(normalized_clean, HASH((INTEGER)VendorDocumentIdentifier));

s_normalized_clean := SORT(d_normalized_clean, 
								VendorDocumentIdentifier, 
								fname, 
								mname, 
								lname, 
								prim_range,
								predir,
								prim_name,
								addr_suffix,
								postdir,
								unit_desig,
								sec_range,
								v_city_name,
								st,
								zip,
								zip4,
								SSN_unformatted,
								TELEPHONE_unformatted,
								BIRTHDATE_unformatted, 
								-is_current, 
								-dt_last_seen,
								-filedate,LOCAL);
						
				
								
Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut tRollup(s_normalized_clean L, s_normalized_clean R) := TRANSFORM
  SELF.dt_first_seen				  :=	ut.min2(L.dt_first_seen, R.dt_first_seen);
  SELF.dt_last_seen				      :=	ut.max2(L.dt_last_seen, R.dt_last_seen);
	SELF.dt_vendor_first_reported :=	ut.min2(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
  SELF.dt_vendor_last_reported 	:=	ut.max2(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
  SELF.Currentname.DeathIndicator     :=	IF(R.Currentname.DeathIndicator  <> '', R.Currentname.DeathIndicator , L.Currentname.DeathIndicator );
  SELF.Currentname.Gender	          :=	IF(R.Currentname.Gender  <> '', R.Currentname.Gender , L.Currentname.Gender );
  SELF.SSNFull				          :=	IF(R.SSNFull  <> '', R.SSNFull , L.SSNFull);
  SELF.ssnfirst5digit				  :=	IF(R.ssnfirst5digit  <> '', R.ssnfirst5digit , L.ssnfirst5digit);  
  SELF.ssnlast4digit				  :=	IF(R.ssnlast4digit  <> '', R.ssnlast4digit , L.ssnlast4digit);  
  SELF.consumerupdatedate			  :=	IF(R.consumerupdatedate  <> '', R.consumerupdatedate , L.consumerupdatedate); 
  SELF.citedid					  	  :=	IF(R.citedid  <> '', R.citedid , L.citedid);  
  SELF.fileid					  	  :=	IF(R.fileid  <> '', R.fileid , L.fileid);  
  SELF.publication				  	  :=	IF(R.publication  <> '', R.publication , L.publication);  
  SELF.housenumber	  				  :=	IF(R.housenumber <> '', R.housenumber , L.housenumber);   
  SELF.streettype	  				  :=	IF(R.streettype <> '', R.streettype , L.streettype);   
  SELF.streetdirection 				  :=	IF(R.streetdirection <> '', R.streetdirection , L.streetdirection);   
  SELF.streetname	 				  :=	IF(R.streetname <> '', R.streetname , L.streetname);   
  SELF.apartmentnumber	 			  :=	IF(R.apartmentnumber <> '', R.apartmentnumber , L.apartmentnumber);   
  SELF.city				 			  :=	IF(R.city <> '', R.city , L.city);   
  SELF.state				 		  :=	IF(R.state <> '', R.state , L.state);   
  SELF.zipcode				 		  :=	IF(R.zipcode <> '', R.zipcode , L.zipcode);   
  SELF.zip4u				 		  :=	IF(R.zip4u <> '', R.zip4u , L.zip4u);
  SELF.aka1					 		  :=	IF(R.aka1 <> '', R.aka1 , L.aka1);
  SELF.aka2					 		  :=	IF(R.aka2 <> '', R.aka2 , L.aka2); 
  SELF.aka3					 		  :=	IF(R.aka3 <> '', R.aka3 , L.aka3);  
  SELF.addressstandardization		  :=	IF(R.addressstandardization <> '', R.addressstandardization , L.addressstandardization);  
  SELF.filesincedate				  :=	IF(R.filesincedate <> '', R.filesincedate , L.filesincedate);   
  SELF.compilationdate				  :=	IF(R.compilationdate <> '', R.compilationdate , L.compilationdate);   
  SELF.birthdateind				 	  :=	IF(R.birthdateind <> '', R.birthdateind , L.birthdateind);   
  SELF.orig_deceasedindicator		  :=	IF(R.orig_deceasedindicator <> '', R.orig_deceasedindicator , L.orig_deceasedindicator);     
  SELF.DECEASEDDATE								:= IF(R.DECEASEDDATE <> '', R.DECEASEDDATE , L.DECEASEDDATE);     
	SELF.transferdate_unformatted		  :=	IF(R.transferdate_unformatted <> '', R.transferdate_unformatted, L.transferdate_unformatted);     
   SELF.updatedate_unformatted		  :=	IF(R.updatedate_unformatted <> '', R.updatedate_unformatted, L.updatedate_unformatted);  
  SELF.consumerupdatedate_unformatted :=	IF(R.consumerupdatedate_unformatted  <> '', R.consumerupdatedate_unformatted , L.consumerupdatedate_unformatted ); 	
  SELF.deceasedindicator 			  :=	IF(R.deceasedindicator  <> '', R.deceasedindicator , L.deceasedindicator ); 		
  SELF.FILESINCEDATE_unformatted 	  :=	IF(R.FILESINCEDATE_unformatted  <> '', R.FILESINCEDATE_unformatted , L.FILESINCEDATE_unformatted); 		
  SELF.compilationdate_unformatted 	  :=	IF(R.compilationdate_unformatted  <> '', R.compilationdate_unformatted , L.compilationdate_unformatted); 		
  SELF.AddressSeq					  :=	ut.max2(L.AddressSeq, R.AddressSeq);
	self.is_current						:= if(l.is_current, l.is_current, r.is_current);
	SELF := L;
end;
	
	
r_normalized_clean   := ROLLUP(s_normalized_clean, tRollup(LEFT, RIGHT),
			   VendorDocumentIdentifier, 
			   fname, 
			   mname,
			   lname,
			   prim_range,
			   predir,
			   prim_name,
			   addr_suffix,
			   postdir,
			   unit_desig,
			   sec_range,
			   v_city_name,
			   st,
			   zip,
			   zip4,
			   SSN_unformatted,
			   TELEPHONE_unformatted,
			   BIRTHDATE_unformatted                                         
  ,local);
	
//-----------------------------------------------------------------
//APPEND DID
//-----------------------------------------------------------------
//add src 
src_rec := record
header_slimsort.Layout_Source;
Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut;
end;

DID_Add.Mac_Set_Source_Code(r_normalized_clean, src_rec, 'TS', r_normalized_clean_src)
								   
matchset := ['A','Z','D','S'];

did_add.MAC_Match_Flex
	(r_normalized_clean_src , matchset,					
	 SSN_unformatted, BIRTHDATE_unformatted , fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,'', 
	 DID, src_rec, true, DID_Score_field,
	 75, d_did_src,true,src)
	 
//Assigning values for fields DOB_no_conflict and SSN_no_conflict
//     assigning a sequence to be able to join back to the original file
tucs_seq := project(d_did_src, {Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut, unsigned sequence := 0});
ut.MAC_Sequence_Records(tucs_seq, sequence, tucs_seq_out);
tucs_t := project(tucs_seq_out(did > 0), transform(header.layout_header, self.dob := (unsigned)left.BIRTHDATE_unformatted, 
																													self.ssn := left.SSN_unformatted,
																													self.src := 'TS',
																													//using unused RAWID field to save the sequence field
																													self.RawAID := left.sequence,
																													self := left,
																													self := []));

//suppressing conflicting dobs and ssns
supp_d := Header.fn_TULT_SSN_DOB_Suppression (tucs_t);

// joining back results to original file to assign value to DOB_no_conflict and SSN_no_conflict fields
apply_supp := join(distribute(tucs_seq_out,  hash(sequence)),
									 distribute(supp_d, hash(RawAID)), 
									 left.sequence = right.RawAID,
									 transform( Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut,
															self.DOB_no_conflict := if(right.dob > 0, (string) right.dob, ''),
									            self.SSN_no_conflict := right.ssn,
															self := left),
															
										local);
										

all_tucs := apply_supp + project(d_did_src(did = 0), transform(Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut,
																														self.DOB_no_conflict  := left.BIRTHDATE_unformatted,
																														self.SSN_no_conflict := left.SSN_unformatted,
																														self := left));
																													
//-----------------------------------------------------------------
//BUILD
//-----------------------------------------------------------------
ut.mac_sf_buildprocess(all_tucs, '~thor400::base::transunion_PTrak', build_transunionPTrak_base, 2,,TRUE);

return build_transunionPTrak_base;
end;