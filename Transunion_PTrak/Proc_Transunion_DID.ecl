
IMPORT  address, ut, header_slimsort, did_add, didville,watchdog,mdr,header;

normalized_clean := Transunion_PTrak.File_Transunion_Clean_Normalized_Out;

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
								FileDate, LOCAL); //Sorted descending to preserve the record from full file which contains more data than update files
						
				
								
Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut tRollup(s_normalized_clean L, s_normalized_clean R) := TRANSFORM
  SELF.dt_first_seen				  :=	ut.min2(L.dt_first_seen, R.dt_first_seen);
  SELF.dt_last_seen				      :=	ut.max2(L.dt_last_seen, R.dt_last_seen);
  SELF.Currentname.DeathIndicator     :=	IF(R.Currentname.DeathIndicator  <> '', R.Currentname.DeathIndicator , L.Currentname.DeathIndicator );
  SELF.Currentname.Gender	          :=	IF(R.Currentname.Gender  <> '', R.Currentname.Gender , L.Currentname.Gender );
  SELF.SSNFull				          :=	IF(R.SSNFull  <> '', R.SSNFull , L.SSNFull);
  SELF.ssnfirst5digit				  :=	IF(R.ssnfirst5digit  <> '', R.ssnfirst5digit , L.ssnfirst5digit);  
  SELF.ssnlast4digit				  :=	IF(R.ssnlast4digit  <> '', R.ssnlast4digit , L.ssnlast4digit);  
  SELF.consumerupdatedate			  :=	IF(R.consumerupdatedate  <> '', R.consumerupdatedate , L.consumerupdatedate); 
  SELF.dateofdeath					  :=	IF(R.dateofdeath  <> '', R.dateofdeath , L.dateofdeath);  
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
  SELF.transferdate_unformatted		  :=	IF(R.transferdate_unformatted <> '', R.transferdate_unformatted, L.transferdate_unformatted);     
  SELF.deathdate_unformatted		  :=	IF(R.deathdate_unformatted <> '', R.deathdate_unformatted, L.deathdate_unformatted);  
  SELF.updatedate_unformatted		  :=	IF(R.updatedate_unformatted <> '', R.updatedate_unformatted, L.updatedate_unformatted);  
  SELF.consumerupdatedate_unformatted :=	IF(R.consumerupdatedate_unformatted  <> '', R.consumerupdatedate_unformatted , L.consumerupdatedate_unformatted ); 	
  SELF.deceasedindicator 			  :=	IF(R.deceasedindicator  <> '', R.deceasedindicator , L.deceasedindicator ); 		
  SELF.FILESINCEDATE_unformatted 	  :=	IF(R.FILESINCEDATE_unformatted  <> '', R.FILESINCEDATE_unformatted , L.FILESINCEDATE_unformatted); 		
  SELF.compilationdate_unformatted 	  :=	IF(R.compilationdate_unformatted  <> '', R.compilationdate_unformatted , L.compilationdate_unformatted); 		
  SELF.AddressSeq					  :=	ut.max2(L.AddressSeq, R.AddressSeq);
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
	 
//remove src 
d_did := project(d_did_src, transform(Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut, self := left));

//FOR TESTING ONLY	 
OUTPUT(choosen(d_did,100), named('RandomSampleAfterDID'));

d_out_test:= DISTRIBUTE(d_did, HASH(VendorDocumentIdentifier)); 
out_test := SORT(d_out_test,VendorDocumentIdentifier,LOCAL); 

	 
OUTPUT(choosen(out_test,100), named('SampleTopRecs'));

OUTPUT(choosen(out_test(did >0),100), named('SampleRecsWithDID'));
 
//-----------------------------------------------------------------
//BUILD
//-----------------------------------------------------------------
ut.mac_sf_buildprocess(d_did, '~thor400::base::transunion_PTrak', build_transunionPTrak_base, 2,,TRUE);

EXPORT Proc_Transunion_DID := build_transunionPTrak_base;