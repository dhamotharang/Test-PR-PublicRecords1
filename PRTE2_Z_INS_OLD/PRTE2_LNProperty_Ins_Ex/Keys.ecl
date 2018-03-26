// PRTE2_LNProperty.Keys
// Splitting out a LOT code that was cluttering up the NEW_Proc_Build_LNPropertyV2_keys logic.
// Added filtering for records being sent into Deed related and Assessment related Keys

IMPORT PRTE2, PRTE_CSV, BIPV2;

EXPORT Keys(DATASET(layouts.layout_LNP_V2_expanded_payload) DS_All_LNPropertyv2_payload, STRING pIndexVersion) := MODULE

		// If we ever have "M" records in PRTE we may need to add another one - deeds have some keys that don't include Mtg recs
		SHARED DS_Assess_LNPropertyv2_Payload := DS_ALL_LNPropertyv2_Payload(ln_fares_id[2]='A');
		SHARED DS_Deed_LNPropertyv2_Payload := DS_ALL_LNPropertyv2_Payload(ln_fares_id[2]<>'A');

		SHARED rKeyLNPropertyV2__addlfaresdeed_fid := Key_Layouts_V2.rKeyLNPropertyV2__addlfaresdeed_fid;
		SHARED rKeyLNPropertyV2__addlfarestax_fid := Key_Layouts_V2.rKeyLNPropertyV2__addlfarestax_fid;
		SHARED rKeyLNPropertyV2__addllegal_fid := Key_Layouts_V2.rKeyLNPropertyV2__addllegal_fid;
		SHARED rKeyLNPropertyV2__addr_search_fid := Key_Layouts_V2.rKeyLNPropertyV2__addr_search_fid;
		SHARED rKeyLNPropertyV2__assessor_fid := Key_Layouts_V2.rKeyLNPropertyV2__assessor_fid;
		SHARED rKeyLNPropertyV2__assessor_parcelnum := Key_Layouts_V2.rKeyLNPropertyV2__assessor_parcelnum;
		SHARED rKeyLNPropertyV2__autokey__address := Key_Layouts_V2.rKeyLNPropertyV2__autokey__address;
		SHARED rKeyLNPropertyV2__autokey__addressb2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__addressb2;
		SHARED rKeyLNPropertyV2__autokey__citystname := Key_Layouts_V2.rKeyLNPropertyV2__autokey__citystname;
		SHARED rKeyLNPropertyV2__autokey__citystnameb2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__citystnameb2;
		SHARED rKeyLNPropertyV2__autokey__fein2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__fein2;
		SHARED rKeyLNPropertyV2__autokey__name := Key_Layouts_V2.rKeyLNPropertyV2__autokey__name;
		SHARED rKeyLNPropertyV2__autokey__nameb2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__nameb2;
		SHARED rKeyLNPropertyV2__autokey__namewords2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__namewords2;
		SHARED rKeyLNPropertyV2__autokey__payload := Key_Layouts_V2.rKeyLNPropertyV2__autokey__payload;
		SHARED rKeyLNPropertyV2__autokey__phone2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__phone2;
		SHARED rKeyLNPropertyV2__autokey__phoneb2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__phoneb2;
		SHARED rKeyLNPropertyV2__autokey__ssn2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__ssn2;
		SHARED rKeyLNPropertyV2__autokey__stname := Key_Layouts_V2.rKeyLNPropertyV2__autokey__stname;
		SHARED rKeyLNPropertyV2__autokey__stnameb2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__stnameb2;
		SHARED rKeyLNPropertyV2__autokey__zip := Key_Layouts_V2.rKeyLNPropertyV2__autokey__zip;
		SHARED rKeyLNPropertyV2__autokey__zipb2 := Key_Layouts_V2.rKeyLNPropertyV2__autokey__zipb2;
		SHARED rKeyLNPropertyV2__deed_fid := Key_Layouts_V2.rKeyLNPropertyV2__deed_fid;
		SHARED rKeyLNPropertyV2__deed_parcelnum := Key_Layouts_V2.rKeyLNPropertyV2__deed_parcelnum;
		SHARED rKeyLNPropertyV2__search_bdid := Key_Layouts_V2.rKeyLNPropertyV2__search_bdid;
		SHARED rKeyLNPropertyV2__search_did := Key_Layouts_V2.rKeyLNPropertyV2__search_did;
		SHARED rKeyLNPropertyV2__search_fid := Key_Layouts_V2.rKeyLNPropertyV2__search_fid;
		SHARED rKeyLNPropertyV2__search_fid_county := Key_Layouts_V2.rKeyLNPropertyV2__search_fid_county;
		SHARED rKeyLNPropertyV2__search_linkids := Key_Layouts_V2.rKeyLNPropertyV2__search_linkids;
		SHARED rKeyLNPropertyV2__search_fid_linkids := Key_Layouts_V2.rKeyLNPropertyV2__search_fid_linkids;

// ============================== Refactor below into Keys Module ??? =====================================
	
		SHARED dKeyLNPropertyV2__search_LinkIDs				:= 	dataset([], rKeyLNPropertyV2__search_linkids);
		SHARED dKeyLNPropertyV2__search_fid_LinkIDs		:= 	dataset([], rKeyLNPropertyV2__search_fid_linkids);

		Newaddlfaresdeedfid		:= 	project(DS_Deed_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__addlfaresdeed_fid,
					SELF := left,
					SELF := [] )); 	
		SHARED dKeyLNPropertyV2__addlfaresdeed_fid := DEDUP(Newaddlfaresdeedfid(fares_owner_etal_indicator !='' and fares_document_year !=''),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newaddlfarestaxfid			:= 	project(DS_Assess_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__addlfarestax_fid,
					SELF := left,
					SELF := [] )); 
					
		SHARED dKeyLNPropertyV2__addlfarestax_fid := DEDUP(Newaddlfarestaxfid(ln_fares_id != ''),RECORD,ALL);			
		//------------------------------------------------------------------------------------------------------------------------------------
		Newaddllegalfid			:= 	project(DS_Assess_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__addllegal_fid,
					SELF := left,
					SELF := [] )); 
		SHARED dKeyLNPropertyV2__addllegal_fid := DEDUP(Newaddllegalfid(ln_fares_id != '' and addl_legal != ''),RECORD,ALL);			
		//------------------------------------------------------------------------------------------------------------------------------------
		Newsearchfid			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__addr_search_fid,
					SELF := left,
					SELF := [] )); 	
		SHARED dKeyLNPropertyV2__addr_search_fid		:= DEDUP(Newsearchfid(prim_name !=''),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
				
		Newassessorfid			:= 	project(DS_Assess_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__assessor_fid,
					SELF := left,
					SELF := [] )); 
		SHARED dKeyLNPropertyV2__assessor_fid := DEDUP(Newassessorfid,RECORD,ALL);			
		//------------------------------------------------------------------------------------------------------------------------------------
					
		Newparcelnum			:= 	project(DS_Assess_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__assessor_parcelnum,
					SELF := left,
					SELF := [] )); 	

		SHARED dKeyLNPropertyV2__assessor_parcelnum := DEDUP(Newparcelnum,RECORD,ALL);	
		//------------------------------------------------------------------------------------------------------------------------------------

		rKeyLNPropertyV2__autokey__address  Reformat_Address (DS_ALL_LNPropertyv2_Payload L) := TRANSFORM
				SELF.DID := L.fakeid; 
				SELF := L;
				SELF := [];
		END;
		NewAddress := DEDUP(PROJECT(DS_ALL_LNPropertyv2_Payload, Reformat_Address (Left)),RECORD,ALL);
		SHARED dKeyLNPropertyV2__autokey__address := NewAddress(city_code > 0 and did != 0);;
		//------------------------------------------------------------------------------------------------------------------------------------

		NewAddressb2			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__addressb2,
					SELF := left,
					SELF := [] )),RECORD,ALL);

		SHARED dKeyLNPropertyV2__autokey__addressb2 := NewAddressb2(bdid != 0);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newcitystname			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__citystname,
					SELF.DID := Left.fakeid,	
					SELF := left,
					SELF := [] )),RECORD,ALL);
		SHARED dKeyLNPropertyV2__autokey__citystname := DEDUP(Newcitystname(did != 0),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newcitystnameb2			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__citystnameb2,
					SELF := left,
					SELF := [] )),RECORD,ALL); 
		SHARED dKeyLNPropertyV2__autokey__citystnameb2 := DEDUP(Newcitystnameb2(bdid != 0),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newfein2    			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__fein2,
					SELF := left,
					SELF := [] )),RECORD,ALL); 	
		SHARED dKeyLNPropertyV2__autokey__fein2 := DEDUP(Newfein2(F1 != '' and F2 != ''),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newname       		:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__name,
					self.DID := left.fakeid,	
					self.lname := left.person_name.lname,
					SELF := left,
					SELF := [] )),RECORD,ALL); 
		SHARED dKeyLNPropertyV2__autokey__name := DEDUP(Newname(did != 0 and lname != ''),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newnameb2   			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__nameb2,
					SELF := left,
					SELF := [] )),RECORD,ALL);
		SHARED dKeyLNPropertyV2__autokey__nameb2 := DEDUP(Newnameb2(bdid != 0),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newnamewords2			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__namewords2,
					SELF := left,
					SELF := [] )); 
		SHARED dKeyLNPropertyV2__autokey__namewords2 := DEDUP(Newnamewords2(bdid != 0),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newpayload		  	:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__payload,
					SELF := left,
					SELF := [] )),RECORD,ALL); 
		SHARED dKeyLNPropertyV2__autokey__payload := DEDUP(Newpayload);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newphone2   			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__phone2,
					self.DID := left.fakeid,
					self.p3 := left.phone[1..3],
					self.p7 := left.phone[4..10],
					SELF := left,
					SELF := [] )),RECORD,ALL); 
		SHARED dKeyLNPropertyV2__autokey__phone2  := DEDUP(Newphone2(p7 > '0000000'),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newphoneb2  			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__phoneb2,
					self.p3 := left.bphone[1..3],
					self.p7 := left.bphone[4..10],
					SELF := left,
					SELF := [] )),RECORD,ALL); 	
		SHARED dKeyLNPropertyV2__autokey__phoneb2 := DEDUP(Newphoneb2(p7 > '0000000'),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newssn2     			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__ssn2,
					self.DID := left.fakeid,			
					SELF.s4 := (string) Left.app_ssn[4..4],	
					SELF := left,
					SELF := [] )),RECORD,ALL); 
		SHARED dKeyLNPropertyV2__autokey__ssn2 := DEDUP(Newssn2(s1 != '' and s2 != '' and s3 != '') ,RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newstname		    	:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__stname,
					self.DID := left.fakeid,		  
					SELF.zip := (integer) Left.zip,		
					SELF := left,
					SELF := [] )),RECORD,ALL);
		SHARED dKeyLNPropertyV2__autokey__stname := DEDUP(Newstname(did != 0),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newstnameb2 			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__stnameb2,
					SELF := left,
					SELF := [] )),RECORD,ALL);
		SHARED dKeyLNPropertyV2__autokey__stnameb2 := DEDUP(Newstnameb2(bdid != 0),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newzip      			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__zip,
					self.DID := left.fakeid,      
					SELF.zip := (integer) left.zip,			
					SELF := left,
					SELF := [] )),RECORD,ALL); 
		SHARED dKeyLNPropertyV2__autokey__zip := DEDUP(Newzip(zip > 0 and did != 0),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newzipb2    			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__zipb2,
					self.zip := (integer) left.zip,			
					SELF := left,
					SELF := [] )),RECORD,ALL);
		SHARED dKeyLNPropertyV2__autokey__zipb2 := DEDUP(Newzipb2(zip > 0 and bdid != 0),RECORD,ALL);			
		//------------------------------------------------------------------------------------------------------------------------------------
		Newdeedfid  := 	project(DS_Deed_LNPropertyv2_Payload,
				TRANSFORM (rKeyLNPropertyV2__deed_fid,
					SELF := left,
					SELF := [] ));
		SHARED dKeyLNPropertyV2__deed_fid := DEDUP(Newdeedfid(ln_fares_id != '' and apnt_or_pin_number != ''),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newdeedparcelnum  := 	project(DS_Deed_LNPropertyv2_Payload,
				TRANSFORM (rKeyLNPropertyV2__deed_parcelnum,
					SELF := left,
					SELF := [] )); 
		//*OUTPUT(choosen(Newdeedparcelnum(ln_fares_id = 'DD0000000354'),100),NAMED('deedparcel'));
		SHARED dKeyLNPropertyV2__deed_parcelnum := DEDUP(Newdeedparcelnum(fares_unformatted_apn != ''),RECORD,ALL);
		//*OUTPUT(choosen(Newdeedparcelnum(ln_fares_id = 'DD0000000354'),100),NAMED('deedparcel'));
		//------------------------------------------------------------------------------------------------------------------------------------

		Newbdid       			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__search_bdid,
				self.s_bid  := IF(left.bdid > 0,left.s_bid, 0),
				self.bdid   := IF(left.bdid > 0, left.s_bid,0),
				self.ln_party_status					:= '';
				self.ln_percentage_ownership	:= '';
				self.ln_entity_type						:= '';
				self.ln_estate_trust_date			:= '';
				self.ln_goverment_type				:= '';
				self.xadl2_weight							:= 0;	
				self.addr_ind									:= '';
				self.best_addr_ind						:= '';
				self.addr_tx_id								:= 0;
				self.best_addr_tx_id					:= '';
				self.location_id							:= 0;
				self.best_locid								:= '';			
				SELF := left));

		SHARED dKeyLNPropertyV2__search_bdid := DEDUP(Newbdid(s_bid != 0),s_bid,ln_fares_id,vendor_source_flag,source_code,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newdid        			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__search_did,
				self.s_did := left.did, 			
				SELF := left,
				SELF := [] ));

		SHARED dKeyLNPropertyV2__search_did := DEDUP(Newdid(s_did != 0 and source_code_2 != ''),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newsearch_fid        			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM ({rKeyLNPropertyV2__search_fid, BIPV2.IDlayouts.l_xlink_ids},
				SELF.ln_fares_id := left.ln_fares_id, 			
				SELF := left,
				SELF := [] ));
		SHARED dKeyLNPropertyV2__search_fid := DEDUP(Newsearch_fid(ln_fares_id != ''),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		Newsearchfidcounty 			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__search_fid_county,
				SELF := left,
				SELF := [] )); 
		SHARED dKeyLNPropertyV2__search_fid_county := DEDUP(Newsearchfidcounty(ln_fares_id != ''),RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------

		//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
		Newaddllegal_fid_fcra				:= 	project(DS_Assess_LNPropertyv2_Payload(ln_fares_id[1] != 'R'),TRANSFORM(rKeyLNPropertyV2__addllegal_fid,
				SELF := left,
				SELF := [] )); 	
		SHARED dKeyLNPropertyV2__addllegal_fid_fcra	:= DEDUP(Newaddllegal_fid_fcra,RECORD,ALL);			
		//------------------------------------------------------------------------------------------------------------------------------------
		Newaddr_search_fid_fcra			:= 	project(DS_ALL_LNPropertyv2_Payload(ln_fares_id[1] != 'R'),TRANSFORM(rKeyLNPropertyV2__addr_search_fid,
				SELF := left,
				SELF := [] ));
		SHARED dKeyLNPropertyV2__addr_search_fid_fcra := DEDUP(Newaddr_search_fid_fcra,RECORD,ALL);			
		//------------------------------------------------------------------------------------------------------------------------------------
		Newassessor_fid_fcra					:= 	project(DS_Assess_LNPropertyv2_Payload(ln_fares_id[1] != 'R'),TRANSFORM(rKeyLNPropertyV2__assessor_fid,
				SELF := left,
				SELF := [] ));
		SHARED dKeyLNPropertyV2__assessor_fid_fcra	:= DEDUP(Newassessor_fid_fcra,RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newdeed_fid_fcra	:= 	project(DS_Deed_LNPropertyv2_Payload(ln_fares_id[1] != 'R'),
				TRANSFORM(rKeyLNPropertyV2__deed_fid,
					SELF := left,
					SELF := [] ));
		SHARED dKeyLNPropertyV2__deed_fid_fcra		:= DEDUP(Newdeed_fid_fcra,RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newsearch_bdid_fcra					:= 	project(DS_ALL_LNPropertyv2_Payload(ln_fares_id[1] != 'R'), TRANSFORM(rKeyLNPropertyV2__search_bdid,
				SELF := left,
				SELF := [] ));
		SHARED dKeyLNPropertyV2__search_bdid_fcra := DEDUP(Newsearch_bdid_fcra,RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
				
		Newsearch_did_fcra						:= 	project(DS_ALL_LNPropertyv2_Payload(ln_fares_id[1] != 'R'),TRANSFORM(rKeyLNPropertyV2__search_did,
				SELF := left,
				SELF := [] ));
		SHARED dKeyLNPropertyV2__search_did_fcra := DEDUP(Newsearch_did_fcra,RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		Newsearch_fid_fcra						:= 	project(DS_ALL_LNPropertyv2_Payload(ln_fares_id[1] != 'R'),TRANSFORM({rKeyLNPropertyV2__search_fid, BIPV2.IDlayouts.l_xlink_ids},
				SELF := left,
				SELF := [] ));
		SHARED dKeyLNPropertyV2__search_fid_fcra	:= DEDUP(Newsearch_fid_fcra,RECORD,ALL);	
		//------------------------------------------------------------------------------------------------------------------------------------
		Newsearch_fid_county_fcra		:= 	project(DS_ALL_LNPropertyv2_Payload(ln_fares_id[1] != 'R'),TRANSFORM(rKeyLNPropertyV2__search_fid_county,
				SELF := left,
				SELF := [] ));
		SHARED dKeyLNPropertyV2__search_fid_county_fcra := DEDUP(Newsearch_fid_county_fcra,RECORD,ALL);
		//------------------------------------------------------------------------------------------------------------------------------------
		SHARED iFileName(STRING postfix) := Files.iFileName(pIndexVersion + postfix);
		SHARED fiFileName(STRING postfix) := Files.fiFileName(pIndexVersion + postfix);
		
		EXPORT kKeyLNPropertyV2__autokey__address			:=	index(dKeyLNPropertyV2__autokey__address,
															{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}
															,{dKeyLNPropertyV2__autokey__address}
															,iFileName('::autokey::address') );
		EXPORT kKeyLNPropertyV2__autokey__addressb2		:=	index(dKeyLNPropertyV2__autokey__addressb2,
															{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}
															,{dKeyLNPropertyV2__autokey__addressb2}
															,iFileName('::autokey::addressb2') );
		EXPORT kKeyLNPropertyV2__autokey__citystname		:=	index(dKeyLNPropertyV2__autokey__citystname,
															{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}
															,{dKeyLNPropertyV2__autokey__citystname}
															,iFileName('::autokey::citystname') );
		EXPORT kKeyLNPropertyV2__autokey__citystnameb2	:=	index(dKeyLNPropertyV2__autokey__citystnameb2,
															{city_code,st,cname_indic,cname_sec,bdid}
															,{dKeyLNPropertyV2__autokey__citystnameb2}
															,iFileName('::autokey::citystnameb2') );
		EXPORT kKeyLNPropertyV2__autokey__fein2				:=	index(dKeyLNPropertyV2__autokey__fein2,
															{f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}
															,{dKeyLNPropertyV2__autokey__fein2}
															,iFileName('::autokey::fein2') );
		EXPORT kKeyLNPropertyV2__autokey__name					:=	index(dKeyLNPropertyV2__autokey__name,
															{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}
															,{dKeyLNPropertyV2__autokey__name}
															,iFileName('::autokey::name') );
		EXPORT kKeyLNPropertyV2__autokey__nameb2				:=	index(dKeyLNPropertyV2__autokey__nameb2,
															{cname_indic,cname_sec,bdid}
															,{dKeyLNPropertyV2__autokey__nameb2}
															,iFileName('::autokey::nameb2') );
		EXPORT kKeyLNPropertyV2__autokey__namewords2		:=	index(dKeyLNPropertyV2__autokey__namewords2,
															{word,state,seq,bdid}
															,{dKeyLNPropertyV2__autokey__namewords2}
															,iFileName('::autokey::namewords2') );
		EXPORT kKeyLNPropertyV2__autokey__payload			:=	index(dKeyLNPropertyV2__autokey__payload,
															{fakeid}
															,{dKeyLNPropertyV2__autokey__payload}
															,iFileName('::autokey::payload') );
		EXPORT kKeyLNPropertyV2__autokey__phone2				:=	index(dKeyLNPropertyV2__autokey__phone2,
															{p7,p3,dph_lname,pfname,st,did}
															,{dKeyLNPropertyV2__autokey__phone2}
															,iFileName('::autokey::phone2') );
		EXPORT kKeyLNPropertyV2__autokey__phoneb2			:=	index(dKeyLNPropertyV2__autokey__phoneb2,
															{p7,p3,cname_indic,cname_sec,st,bdid}
															,{dKeyLNPropertyV2__autokey__phoneb2}
															,iFileName('::autokey::phoneb2') );
		EXPORT kKeyLNPropertyV2__autokey__ssn2					:=	index(dKeyLNPropertyV2__autokey__ssn2,
															{s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}
															,{dKeyLNPropertyV2__autokey__ssn2}
															,iFileName('::autokey::ssn2') );
		EXPORT kKeyLNPropertyV2__autokey__stname				:=	index(dKeyLNPropertyV2__autokey__stname,
															{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}
															,{dKeyLNPropertyV2__autokey__stname}
															,iFileName('::autokey::stname') );
		EXPORT kKeyLNPropertyV2__autokey__stnameb2			:=	index(dKeyLNPropertyV2__autokey__stnameb2,
															{st,cname_indic,cname_sec,bdid}
															,{dKeyLNPropertyV2__autokey__stnameb2}
															,iFileName('::autokey::stnameb2') );
		EXPORT kKeyLNPropertyV2__autokey__zip					:=	index(dKeyLNPropertyV2__autokey__zip,
															{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}
															,{dKeyLNPropertyV2__autokey__zip}
															,iFileName('::autokey::zip') );
		EXPORT kKeyLNPropertyV2__autokey__zipb2				:=	index(dKeyLNPropertyV2__autokey__zipb2,
															{zip,cname_indic,cname_sec,bdid}
															,{dKeyLNPropertyV2__autokey__zipb2}
															,iFileName('::autokey::zipb2') );
		EXPORT kKeyLNPropertyV2__addlfaresdeed_fid			:=	index(dKeyLNPropertyV2__addlfaresdeed_fid,
															{ln_fares_id}
															,{dKeyLNPropertyV2__addlfaresdeed_fid}
															,iFileName('::addlfaresdeed.fid') );
		EXPORT kKeyLNPropertyV2__addlfarestax_fid			:=	index(dKeyLNPropertyV2__addlfarestax_fid,
															{ln_fares_id}
															,{dKeyLNPropertyV2__addlfarestax_fid}
															,iFileName('::addlfarestax.fid') );
		EXPORT kKeyLNPropertyV2__addllegal_fid					:=	index(dKeyLNPropertyV2__addllegal_fid,
															{ln_fares_id}
															,{dKeyLNPropertyV2__addllegal_fid}
															,iFileName('::addllegal.fid') );
		EXPORT kKeyLNPropertyV2__addr_search_fid				:=	index(dKeyLNPropertyV2__addr_search_fid,
															{prim_name,prim_range,zip,predir,postdir,suffix,sec_range,source_code_2,LN_owner,owner,nofares_owner,source_code_1}
															,{ln_fares_id,lname,fname,name_suffix}
															,iFileName('::addr_search.fid') );
		EXPORT kKeyLNPropertyV2__assessor_fid					:=	index(dKeyLNPropertyV2__assessor_fid,
															{ln_fares_id,proc_date}
															,{dKeyLNPropertyV2__assessor_fid}
															,iFileName('::assessor.fid') );
		EXPORT kKeyLNPropertyV2__assessor_parcelnum		:=	index(dKeyLNPropertyV2__assessor_parcelnum,
															{fares_unformatted_apn}
															,{ln_fares_id}
															,iFileName('::assessor.parcelNum') );
		EXPORT kKeyLNPropertyV2__deed_fid							:=	index(dKeyLNPropertyV2__deed_fid,
															{ln_fares_id,proc_date}
															,{dKeyLNPropertyV2__deed_fid}
															,iFileName('::deed.fid') );
		EXPORT kKeyLNPropertyV2__deed_parcelnum				:=	index(dKeyLNPropertyV2__deed_parcelnum,
															{fares_unformatted_apn}
															,{ln_fares_id}
															,iFileName('::deed.parcelNum') );
		EXPORT kKeyLNPropertyV2__search_bdid						:=	index(dKeyLNPropertyV2__search_bdid,
															{s_bid}
															,{dKeyLNPropertyV2__search_bdid}
															,iFileName('::search.bdid') );
		EXPORT kKeyLNPropertyV2__search_did						:=	index(dKeyLNPropertyV2__search_did,
															{s_did,source_code_2}
															,{ln_fares_id,source_code,lname,fname,prim_range,predir,prim_name,suffix,postdir,sec_range,st,p_city_name,zip,county,geo_blk}
															,iFileName('::search.did') );
		EXPORT kKeyLNPropertyV2__search_fid						:=	index(dKeyLNPropertyV2__search_fid,
															{ln_fares_id,which_orig,source_code_2,source_code_1}
															,{dKeyLNPropertyV2__search_fid}
															,iFileName('::search.fid') );
		EXPORT kKeyLNPropertyV2__search_fid_county			:=	index(dKeyLNPropertyV2__search_fid_county,
															{ln_fares_id}
															,{p_county_name,o_county_name}
															,iFileName('::search.fid_county') );
		//*New, just create empty keys
		EXPORT kKeyLNPropertyV2__search_LinkIDs				:=	index(dKeyLNPropertyV2__search_LinkIDs,
															{ultid,orgid,seleid,proxid,powid,empid,dotid}
															,{dKeyLNPropertyV2__search_LinkIDs}
															,iFileName('::search.linkids') );
		EXPORT kKeyLNPropertyV2__search_fid_LinkIDs		:=	index(dKeyLNPropertyV2__search_fid_LinkIDs,
															{ln_fares_id,which_orig,source_code_2,source_code_1}
															,{dKeyLNPropertyV2__search_fid_LinkIDs}
															,iFileName('::search.fid_linkids') );
		//fcra keys
		EXPORT kKeyLNPropertyV2__addllegal_fid_fcra			:=	index(dKeyLNPropertyV2__addllegal_fid_fcra,
															{ln_fares_id}
															,{dKeyLNPropertyV2__addllegal_fid_fcra}
															,fiFileName('::addllegal.fid') );
		EXPORT kKeyLNPropertyV2__addr_search_fid_fcra		:=	index(dKeyLNPropertyV2__addr_search_fid_fcra,
															{prim_name,prim_range,zip,predir,postdir,suffix,sec_range,source_code_2,LN_owner,owner,nofares_owner,source_code_1}
															,{ln_fares_id,lname,fname,name_suffix}
															,fiFileName('::addr_search.fid') );
		EXPORT kKeyLNPropertyV2__assessor_fid_fcra				:=	index(dKeyLNPropertyV2__assessor_fid_fcra,
															{ln_fares_id,proc_date}
															,{dKeyLNPropertyV2__assessor_fid_fcra}
															,fiFileName('::assessor.fid') );
		EXPORT kKeyLNPropertyV2__deed_fid_fcra						:=	index(dKeyLNPropertyV2__deed_fid_fcra,
															{ln_fares_id,proc_date}
															,{dKeyLNPropertyV2__deed_fid_fcra}
															,fiFileName('::deed.fid') );
		EXPORT kKeyLNPropertyV2__search_bdid_fcra				:=	index(dKeyLNPropertyV2__search_bdid_fcra,
															{s_bid}
															,{dKeyLNPropertyV2__search_bdid_fcra}
															,fiFileName('::bdid') );
		EXPORT kKeyLNPropertyV2__search_did_fcra					:=	index(dKeyLNPropertyV2__search_did_fcra,
															{s_did,source_code_2}
															,{ln_fares_id,source_code,lname,fname,prim_range,predir,prim_name,suffix,postdir,sec_range,st,p_city_name,zip,county,geo_blk}
															,fiFileName('::search.did') );
		EXPORT kKeyLNPropertyV2__search_fid_fcra					:=	index(dKeyLNPropertyV2__search_fid_fcra,
															{ln_fares_id,which_orig,source_code_2,source_code_1}
															,{dKeyLNPropertyV2__search_fid_fcra}
															,fiFileName('::search.fid') );
		EXPORT kKeyLNPropertyV2__search_fid_county_fcra	:=	index(dKeyLNPropertyV2__search_fid_county_fcra,
															{ln_fares_id}
															,{p_county_name,o_county_name}
															,fiFileName('::search.fid_county') );

// ============================== Refactor above into Keys Module =====================================



END;