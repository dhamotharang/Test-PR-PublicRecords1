import bankruptcyv2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address, watchdog;

file_in := BankruptcyV2.Mapping_BK_search_history ; 


PreDID_Rec
 :=
  record
    
	qstring34  source_group := '';
	qstring34  vendor_id := '';
	BankruptcyV2.layout_bankruptcy_search;
	integer8	temp_DID		    := 0;
	integer8	temp_BDID    	    := 0;
	string9 appended_SSN := '';
    string9 appended_tax_id := '';
	
	
  end
 ;

PreDID_Rec taddDID(file_in L)
 :=
  transform
    self.source_group :=  l.court_code + l.case_number; 
	self.vendor_id    :=  l.court_code + l.case_number + l.debtor_type + l.name_type;
	self			:=	L;
	
  end
 ;

Prefile	:= project(file_in,taddDID(left));

//append DID
matchset :=['A', 'z', 'S', 'P','4'];

did_Add.MAC_Match_Flex(Prefile, matchset,
	 ssn, '', fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,phone,
	 temp_did,   			
	 PreDID_Rec, 
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped 	
	 postDID)

//append BDID 

preBDID_no_company  := postDID(cname  = '');
preBDID := postDID(cname <> '');

business_header.MAC_Source_Match(preBDID,dPostSourceMatch,
								 false,temp_BDID,
								 false,'BK',	
								 TRUE, source_group,
								 cname,
								 prim_range,prim_name,sec_range,zip,
								 true,phone,
								 true,tax_id,
								 TRUE, vendor_id);
								 
dPostSourceMatchPersist	:=	dPostSourceMatch : persist('~thor_data400::persist::BK_PostSourceMatch');

dWithSourceMatch		:=	dPostSourceMatchPersist(temp_BDID != 0);
dWithNoSourceMatch		:=	dPostSourceMatchPersist(temp_BDID = 0);

myset := ['A', 'N', 'F', 'P'];

Business_Header_SS.MAC_Add_BDID_FLEX(dWithNoSourceMatch,myset,
						cname,
                        prim_range,prim_name,zip,sec_range,
						st,
						phone,tax_id,
						temp_bdid,
						PreDID_Rec,
						false, BDID_Score_field,   //these should default to zero in definition
						postbdid);

					
post_DID_BDID := preBDID_no_company + postbdid  + dWithSourceMatch;  //format DID and BDID

//Append SSN 

did_add.MAC_Add_SSN_By_DID(post_DID_BDID, temp_did, appended_SSN, file_search_ssn, false);

// Append Fein


Business_Header_SS.MAC_Add_FEIN_By_BDID(file_search_ssn, temp_bdid, appended_tax_id, file_search_fein);



BankruptcyV2.layout_bankruptcy_search reformattemp(file_search_fein L)
 :=
  transform
    self.DID		    :=	intformat(L.temp_DID,12,1);
    self.BDID		    :=	intformat(L.temp_BDID,12,1);
	self.app_SSN        := l.appended_SSN ;
    self.app_tax_id     := l.appended_tax_id ;
	self := L;
	end;

file_out := project(file_search_fein, reformattemp(left));

export BK_DID_history := file_out : persist('~thor_data400::persist::bankruptcy::BK_DID_history');

