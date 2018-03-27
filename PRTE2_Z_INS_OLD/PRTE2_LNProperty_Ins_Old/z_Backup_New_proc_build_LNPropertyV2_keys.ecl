//*EXPORT Backup_New_proc_build_LNPropertyV2_keys := 'todo';
//* NEW_Proc_Build_LNPropertyV2_keys *// 
IMPORT PRTE2_LNProperty,PRTE2, PRTE_CSV;
EXPORT	NEW_Proc_Build_LNPropertyV2_Keys(string	pIndexVersion)	:= FUNCTION
STRING Filedate := pIndexVersion;

Expanded_LNPROPERTYv2_Payload := PRTE2_LNProperty.Get_payload.LNPROPERTYV2;
OUTPUT(Expanded_LNPROPERTYv2_Payload,,'~prte::ct::ln_propertyv2::join::expanded',OVERWRITE);
//*OUTPUT(choosen(Expanded_LNPROPERTYv2_Payload,100),NAMED('OLDLNPROP'));
New_Expanded_LNPropertyV2_Payload := PRTE2_LNProperty.Get_payload.NEW_LNPROPERTYV2(filedate);
OUTPUT(New_Expanded_LNPROPERTYv2_Payload,,'~prte::ct::ln_propertyv2::join::newexpanded',OVERWRITE);
//*OUTPUT(choosen(New_Expanded_LNPROPERTYv2_Payload,100),NAMED('NEWLNPROP'));
OUTPUT(COUNT(New_Expanded_LNPROPERTYv2_Payload),NAMED('cntnewlnp'));

F1 := dedup(project(Expanded_LNPROPERTYv2_Payload,PRTE2.layouts.layout_ln_propertyv2_expanded_payload),record,all);
OUTPUT(COUNT(F1),NAMED('cntf1dedup'));
SHARED F2 := dedup(project(New_Expanded_LNPROPERTYv2_Payload,PRTE2.layouts.layout_ln_propertyv2_expanded_payload),record,all);
OUTPUT(COUNT(F2),NAMED('cntf2dedup'));
All_Expanded := F1 + F2;
OUTPUT (All_Expanded,,'~prte::ct::ln_propertyv2::join::ALLexpanded',OVERWRITE);
OUTPUT(All_expanded(ln_fares_id = 'OA0041634156'),NAMED('allexprec'));
//*OUTPUT (COUNT(ALL_Expanded),NAMED('cntallexp'));

DS_All_LNPropertyv2_payload := F1	+ F2;
//*OUTPUT (DS_All_LNPropertyv2_payload,,'~prte::ct::ln_propertyv2::join::ALLexpanded',OVERWRITE);
//*OUTPUT(COUNT(F2),NAMED('cntf2dedup'));	
//*OUTPUT (choosen(F1,100),NAMED('DEDUPOLD'));
//*OUTPUT (choosen(F2,200),NAMED('DEDUPNEW'));
																

rKeyLNPropertyV2__addlfaresdeed_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__addlfaresdeed_fid;
	end;
	
	rKeyLNPropertyV2__addlfarestax_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__addlfarestax_fid;
	end;
	
	rKeyLNPropertyV2__addllegal_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__addllegal_fid;
	end;
	
	rKeyLNPropertyV2__addr_search_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__addr_search_fid;
	end;
	
	rKeyLNPropertyV2__assessor_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__assessor_fid;
	end;
	
	rKeyLNPropertyV2__assessor_parcelnum	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__assessor_parcelnum;
	end;
	
	rKeyLNPropertyV2__autokey__address	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__address;
	end;
	
	rKeyLNPropertyV2__autokey__addressb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__addressb2;
	end;
	
	rKeyLNPropertyV2__autokey__citystname	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__citystname;
	end;
	
	rKeyLNPropertyV2__autokey__citystnameb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__citystnameb2;
	end;
	
	rKeyLNPropertyV2__autokey__fein2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__fein2;
	end;
	
	rKeyLNPropertyV2__autokey__name	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__name;
	end;
	
	rKeyLNPropertyV2__autokey__nameb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__nameb2;
	end;
	
	rKeyLNPropertyV2__autokey__namewords2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__namewords2;
	end;
	
	rKeyLNPropertyV2__autokey__payload	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__payload;
	end;
	
	rKeyLNPropertyV2__autokey__phone2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__phone2;
	end;
	
	rKeyLNPropertyV2__autokey__phoneb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__phoneb2;
	end;
	
	rKeyLNPropertyV2__autokey__ssn2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__ssn2;
	end;
	
	rKeyLNPropertyV2__autokey__stname	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__stname;
	end;
	
	rKeyLNPropertyV2__autokey__stnameb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__stnameb2;
	end;
	
	rKeyLNPropertyV2__autokey__zip	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__zip;
	end;
		
	rKeyLNPropertyV2__autokey__zipb2	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__autokey__zipb2;
	end;
	
	rKeyLNPropertyV2__deed_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__deed_fid;
	end;
	
	rKeyLNPropertyV2__deed_parcelnum	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__deed_parcelnum;
	end;
	
	rKeyLNPropertyV2__search_bdid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__search_bdid;
	end;
	
	rKeyLNPropertyV2__search_did	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__search_did;
	end;
	
	rKeyLNPropertyV2__search_fid	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__search_fid;
	end;
	
	rKeyLNPropertyV2__search_fid_county	:=
	record
		PRTE_CSV.LN_PropertyV2.rthor_data400__key__ln_propertyv2__search_fid_county;
	end;
	

Newaddlfaresdeedfid		:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__addlfaresdeed_fid,
			SELF := left,
			SELF := [] )); 	
dKeyLNPropertyV2__addlfaresdeed_fid := DEDUP(Newaddlfaresdeedfid(fares_owner_etal_indicator !='' and fares_document_year !=''),RECORD,ALL);
			
			
Newaddlfarestaxfid			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__addlfarestax_fid,
			SELF := left,
			SELF := [] )); 
//*OUTPUT(Newaddlfarestaxfid(ln_fares_id = 'RA1939707938'),NAMED('RA1939707938'));			
dKeyLNPropertyV2__addlfarestax_fid := DEDUP(Newaddlfarestaxfid(ln_fares_id != ''),RECORD,ALL);			
//*OUTPUT (dKeyLNPropertyV2__addlfarestax_fid(ln_fares_id = 'RA1939707938'),NAMED('dedAddlFares'));			
			
Newaddllegalfid			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__addllegal_fid,
			SELF := left,
			SELF := [] )); 
dKeyLNPropertyV2__addllegal_fid := DEDUP(Newaddllegalfid(ln_fares_id != '' and addl_legal != ''),RECORD,ALL);			
			
Newsearchfid			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__addr_search_fid,
			SELF := left,
			SELF := [] )); 	
dKeyLNPropertyV2__addr_search_fid		:= DEDUP(Newsearchfid(prim_name !=''),RECORD,ALL);

		
Newassessorfid			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__assessor_fid,
			SELF := left,
			SELF := [] )); 
dKeyLNPropertyV2__assessor_fid := DEDUP(Newassessorfid,RECORD,ALL);			
			
			
Newparcelnum			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__assessor_parcelnum,
			SELF := left,
			SELF := [] )); 	
dKeyLNPropertyV2__assessor_parcelnum := DEDUP(Newparcelnum,RECORD,ALL);	


rKeyLNPropertyV2__autokey__address  Reformat_Address (DS_ALL_LNPropertyv2_Payload L) := TRANSFORM
    SELF.DID := L.fakeid; 
		SELF := L;
		SELF := [];
END;
NewAddress := DEDUP(PROJECT(DS_ALL_LNPropertyv2_Payload, Reformat_Address (Left)),RECORD,ALL);

/*
NewAddress			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__address,
			SELF.DID := left.fakeid,	
			SELF := left,
			SELF := [] )),RECORD,ALL); 
*/
			
			
//*dKeyLNPropertyV2__autokey__address  :=  DEDUP(NewAddress,RECORD,ALL);
//*dKeyLNPropertyV2__autokey__address := NewAddress(prim_name !='' or st !='');
dKeyLNPropertyV2__autokey__address := NewAddress(city_code > 0 and did != 0);;

NewAddressb2			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__addressb2,
			SELF := left,
			SELF := [] )),RECORD,ALL);
//*dKeyLNPropertyV2__autokey__addressb2 := DEDUP(NewAddressb2,RECORD,ALL);
dKeyLNPropertyV2__autokey__addressb2 := NewAddressb2(bdid != 0);

Newcitystname			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__citystname,
			SELF.DID := Left.fakeid,	
			SELF := left,
			SELF := [] )),RECORD,ALL);
dKeyLNPropertyV2__autokey__citystname := DEDUP(Newcitystname(did != 0),RECORD,ALL);
	
Newcitystnameb2			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__citystnameb2,
			SELF := left,
			SELF := [] )),RECORD,ALL); 
dKeyLNPropertyV2__autokey__citystnameb2 := DEDUP(Newcitystnameb2(bdid != 0),RECORD,ALL);

Newfein2    			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__fein2,
			SELF := left,
			SELF := [] )),RECORD,ALL); 	
dKeyLNPropertyV2__autokey__fein2 := DEDUP(Newfein2(F1 != '' and F2 != ''),RECORD,ALL);

Newname       		:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__name,
      self.DID := left.fakeid,	
			self.lname := left.person_name.lname,
			SELF := left,
			SELF := [] )),RECORD,ALL); 
dKeyLNPropertyV2__autokey__name := DEDUP(Newname(did != 0 and lname != ''),RECORD,ALL);

Newnameb2   			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__nameb2,
			SELF := left,
			SELF := [] )),RECORD,ALL);
dKeyLNPropertyV2__autokey__nameb2 := DEDUP(Newnameb2(bdid != 0),RECORD,ALL);

Newnamewords2			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__namewords2,
			SELF := left,
			SELF := [] )); 
dKeyLNPropertyV2__autokey__namewords2 := DEDUP(Newnamewords2(bdid != 0),RECORD,ALL);

Newpayload		  	:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__payload,
			SELF := left,
			SELF := [] )),RECORD,ALL); 
dKeyLNPropertyV2__autokey__payload := DEDUP(Newpayload);
	

Newphone2   			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__phone2,
			self.DID := left.fakeid,
			self.p3 := left.phone[1..3],
			self.p7 := left.phone[4..10],
			SELF := left,
			SELF := [] )),RECORD,ALL); 
dKeyLNPropertyV2__autokey__phone2  := DEDUP(Newphone2(p7 !=''),RECORD,ALL);
	

Newphoneb2  			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__phoneb2,
      self.p3 := left.bphone[1..3],
			self.p7 := left.bphone[4..10],
			SELF := left,
			SELF := [] )),RECORD,ALL); 	
dKeyLNPropertyV2__autokey__phoneb2 := DEDUP(Newphoneb2(p7 !=''),RECORD,ALL);
	

Newssn2     			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__ssn2,
      self.DID := left.fakeid,			
			SELF.s4 := (string) Left.app_ssn[4..4],	
			SELF := left,
			SELF := [] )),RECORD,ALL); 
dKeyLNPropertyV2__autokey__ssn2 := DEDUP(Newssn2(s1 != '' and s2 != '' and s3 != '') ,RECORD,ALL);

Newstname		    	:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__stname,
      self.DID := left.fakeid,		  
			SELF.zip := (integer) Left.zip,		
			SELF := left,
			SELF := [] )),RECORD,ALL);
dKeyLNPropertyV2__autokey__stname := DEDUP(Newstname(did != 0),RECORD,ALL);
	

Newstnameb2 			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__stnameb2,
			SELF := left,
			SELF := [] )),RECORD,ALL);
dKeyLNPropertyV2__autokey__stnameb2 := DEDUP(Newstnameb2(bdid != 0),RECORD,ALL);
	

Newzip      			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__zip,
      self.DID := left.fakeid,      
			SELF.zip := (integer) left.zip,			
			SELF := left,
			SELF := [] )),RECORD,ALL); 
dKeyLNPropertyV2__autokey__zip := DEDUP(Newzip(zip > 0 and did != 0),RECORD,ALL);
	

Newzipb2    			:= 	DEDUP(project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__autokey__zipb2,
      self.zip := (integer) left.zip,			
			SELF := left,
			SELF := [] )),RECORD,ALL);
dKeyLNPropertyV2__autokey__zipb2 := DEDUP(Newzipb2(zip > 0 and bdid != 0),RECORD,ALL);			

Newdeedfid          			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__deed_fid,
			SELF := left,
			SELF := [] ));
dKeyLNPropertyV2__deed_fid := DEDUP(Newdeedfid(ln_fares_id != '' and apnt_or_pin_number != ''),RECORD,ALL);
OUTPUT (dKeyLNPropertyV2__deed_fid(ln_fares_id = 'DD0000000354'),NAMED('lnfares'));

Newdeedparcelnum    			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__deed_parcelnum,
			SELF := left,
			SELF := [] )); 
dKeyLNPropertyV2__deed_parcelnum := DEDUP(Newdeedparcelnum(fares_unformatted_apn != ''),RECORD,ALL);
OUTPUT(choosen(DS_ALL_LNPropertyv2_Payload(ln_fares_id='OA0041634156'),10),NAMED('DSALLbdid'));
Newbdid       			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__search_bdid,
//*      self.s_bid := left.s_bid,
			self.s_bid  := IF(left.bdid > 0,left.s_bid, 0),
			self.bdid   := IF(left.bdid > 0, left.s_bid,0),
//*			self.did   := IF(left.did > 0, left.s_bid,0),
			SELF := left));
//*			SELF := [] ));
OUTPUT(choosen(newbdid(ln_fares_id='OA0041634156'),10),NAMED('newbdid'));
dKeyLNPropertyV2__search_bdid := DEDUP(Newbdid(s_bid != 0),s_bid,ln_fares_id,vendor_source_flag,source_code,ALL);
OUTPUT(choosen(dkeylnpropertyv2__search_bdid(ln_fares_id='OA0041634156'),100),NAMED('dkeynewbdid'));	

Newdid        			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__search_did,
      self.s_did := left.did, 			
			SELF := left,
			SELF := [] ));
OUTPUT(newdid(ln_fares_id = 'DA0000010053'),NAMED('newdidex'));
dKeyLNPropertyV2__search_did := DEDUP(Newdid(s_did != 0 and source_code_2 != ''),RECORD,ALL);
	

Newsearch_fid        			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__search_fid,
      SELF.ln_fares_id := left.ln_fares_id, 			
			SELF := left,
			SELF := [] ));
dKeyLNPropertyV2__search_fid := DEDUP(Newsearch_fid(ln_fares_id != ''),RECORD,ALL);
OUTPUT (dkeyLNPropertyV2__search_fid(DID = 888809000107),NAMED('searchfid'));	

Newsearchfidcounty 			:= 	project(DS_ALL_LNPropertyv2_Payload,TRANSFORM (rKeyLNPropertyV2__search_fid_county,
			SELF := left,
			SELF := [] )); 
dKeyLNPropertyV2__search_fid_county := DEDUP(Newsearchfidcounty(ln_fares_id != ''),RECORD,ALL);



  kKeyLNPropertyV2__autokey__address			:=	index(dKeyLNPropertyV2__autokey__address,{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{dKeyLNPropertyV2__autokey__address},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::address');
	kKeyLNPropertyV2__autokey__addressb2		:=	index(dKeyLNPropertyV2__autokey__addressb2,{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__addressb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::addressb2');
	kKeyLNPropertyV2__autokey__citystname		:=	index(dKeyLNPropertyV2__autokey__citystname,{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyLNPropertyV2__autokey__citystname},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::citystname');
	kKeyLNPropertyV2__autokey__citystnameb2	:=	index(dKeyLNPropertyV2__autokey__citystnameb2,{city_code,st,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__citystnameb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::citystnameb2');
	kKeyLNPropertyV2__autokey__fein2				:=	index(dKeyLNPropertyV2__autokey__fein2,{f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__fein2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::fein2');
	kKeyLNPropertyV2__autokey__name					:=	index(dKeyLNPropertyV2__autokey__name,{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyLNPropertyV2__autokey__name},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::name');
	kKeyLNPropertyV2__autokey__nameb2				:=	index(dKeyLNPropertyV2__autokey__nameb2,{cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__nameb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::nameb2');
	kKeyLNPropertyV2__autokey__namewords2		:=	index(dKeyLNPropertyV2__autokey__namewords2,{word,state,seq,bdid},{dKeyLNPropertyV2__autokey__namewords2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::namewords2');
	kKeyLNPropertyV2__autokey__payload			:=	index(dKeyLNPropertyV2__autokey__payload,{fakeid},{dKeyLNPropertyV2__autokey__payload},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::payload');
	kKeyLNPropertyV2__autokey__phone2				:=	index(dKeyLNPropertyV2__autokey__phone2,{p7,p3,dph_lname,pfname,st,did},{dKeyLNPropertyV2__autokey__phone2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::phone2');
	kKeyLNPropertyV2__autokey__phoneb2			:=	index(dKeyLNPropertyV2__autokey__phoneb2,{p7,p3,cname_indic,cname_sec,st,bdid},{dKeyLNPropertyV2__autokey__phoneb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::phoneb2');
	kKeyLNPropertyV2__autokey__ssn2					:=	index(dKeyLNPropertyV2__autokey__ssn2,{s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did},{dKeyLNPropertyV2__autokey__ssn2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::ssn2');
	kKeyLNPropertyV2__autokey__stname				:=	index(dKeyLNPropertyV2__autokey__stname,{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyLNPropertyV2__autokey__stname},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::stname');
	kKeyLNPropertyV2__autokey__stnameb2			:=	index(dKeyLNPropertyV2__autokey__stnameb2,{st,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__stnameb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::stnameb2');
	kKeyLNPropertyV2__autokey__zip					:=	index(dKeyLNPropertyV2__autokey__zip,{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dKeyLNPropertyV2__autokey__zip},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::zip');
	kKeyLNPropertyV2__autokey__zipb2				:=	index(dKeyLNPropertyV2__autokey__zipb2,{zip,cname_indic,cname_sec,bdid},{dKeyLNPropertyV2__autokey__zipb2},'~prte::key::ln_propertyv2::' + pIndexVersion + '::autokey::zipb2');
	kKeyLNPropertyV2__addlfaresdeed_fid			:=	index(dKeyLNPropertyV2__addlfaresdeed_fid,{ln_fares_id},{dKeyLNPropertyV2__addlfaresdeed_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::addlfaresdeed.fid');
	kKeyLNPropertyV2__addlfarestax_fid			:=	index(dKeyLNPropertyV2__addlfarestax_fid,{ln_fares_id},{dKeyLNPropertyV2__addlfarestax_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::addlfarestax.fid');
	kKeyLNPropertyV2__addllegal_fid					:=	index(dKeyLNPropertyV2__addllegal_fid,{ln_fares_id},{dKeyLNPropertyV2__addllegal_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::addllegal.fid');
	kKeyLNPropertyV2__addr_search_fid				:=	index(dKeyLNPropertyV2__addr_search_fid,{prim_name,prim_range,zip,predir,postdir,suffix,sec_range,source_code_2,LN_owner,owner,nofares_owner,source_code_1},{ln_fares_id,lname,fname,name_suffix},'~prte::key::ln_propertyv2::' + pIndexVersion + '::addr_search.fid');
	kKeyLNPropertyV2__assessor_fid					:=	index(dKeyLNPropertyV2__assessor_fid,{ln_fares_id,proc_date},{dKeyLNPropertyV2__assessor_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::assessor.fid');
	kKeyLNPropertyV2__assessor_parcelnum		:=	index(dKeyLNPropertyV2__assessor_parcelnum,{fares_unformatted_apn},{ln_fares_id},'~prte::key::ln_propertyv2::' + pIndexVersion + '::assessor.parcelNum');
	kKeyLNPropertyV2__deed_fid							:=	index(dKeyLNPropertyV2__deed_fid,{ln_fares_id,proc_date},{dKeyLNPropertyV2__deed_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::deed.fid');
	kKeyLNPropertyV2__deed_parcelnum				:=	index(dKeyLNPropertyV2__deed_parcelnum,{fares_unformatted_apn},{ln_fares_id},'~prte::key::ln_propertyv2::' + pIndexVersion + '::deed.parcelNum');
	kKeyLNPropertyV2__search_bdid						:=	index(dKeyLNPropertyV2__search_bdid,{s_bid},{dKeyLNPropertyV2__search_bdid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::search.bdid');
	kKeyLNPropertyV2__search_did						:=	index(dKeyLNPropertyV2__search_did,{s_did,source_code_2},{ln_fares_id,source_code,lname,fname,prim_range,predir,prim_name,suffix,postdir,sec_range,st,p_city_name,zip,county,geo_blk},'~prte::key::ln_propertyv2::' + pIndexVersion + '::search.did');
	kKeyLNPropertyV2__search_fid						:=	index(dKeyLNPropertyV2__search_fid,{ln_fares_id,which_orig,source_code_2,source_code_1},{dKeyLNPropertyV2__search_fid},'~prte::key::ln_propertyv2::' + pIndexVersion + '::search.fid');
	kKeyLNPropertyV2__search_fid_county			:=	index(dKeyLNPropertyV2__search_fid_county,{ln_fares_id},{p_county_name,o_county_name},'~prte::key::ln_propertyv2::' + pIndexVersion + '::search.fid_county');




return	sequential(
											parallel(
																build(kKeyLNPropertyV2__autokey__address			,update),
																build(kKeyLNPropertyV2__autokey__addressb2		,update),
																build(kKeyLNPropertyV2__autokey__citystname		,update),
																build(kKeyLNPropertyV2__autokey__citystnameb2	,update),
																build(kKeyLNPropertyV2__autokey__fein2				,update),
																build(kKeyLNPropertyV2__autokey__name					,update),
																build(kKeyLNPropertyV2__autokey__nameb2				,update),
																build(kKeyLNPropertyV2__autokey__namewords2		,update),
																build(kKeyLNPropertyV2__autokey__payload			,update),
																build(kKeyLNPropertyV2__autokey__phone2				,update),
																build(kKeyLNPropertyV2__autokey__phoneb2			,update),
																build(kKeyLNPropertyV2__autokey__ssn2					,update),
																build(kKeyLNPropertyV2__autokey__stname				,update),
																build(kKeyLNPropertyV2__autokey__stnameb2			,update),
																build(kKeyLNPropertyV2__autokey__zip					,update),
																build(kKeyLNPropertyV2__autokey__zipb2				,update),
																build(kKeyLNPropertyV2__addlfaresdeed_fid			,update),
																build(kKeyLNPropertyV2__addlfarestax_fid			,update),
																build(kKeyLNPropertyV2__addllegal_fid					,update),
																build(kKeyLNPropertyV2__addr_search_fid				,update),
																build(kKeyLNPropertyV2__assessor_fid					,update),
																build(kKeyLNPropertyV2__assessor_parcelnum		,update),
																build(kKeyLNPropertyV2__deed_fid						  ,update),
																build(kKeyLNPropertyV2__deed_parcelnum				,update),
																build(kKeyLNPropertyV2__search_bdid						,update),
																build(kKeyLNPropertyV2__search_did						,update),
																build(kKeyLNPropertyV2__search_fid						,update),
																build(kKeyLNPropertyV2__search_fid_county			,update)
														
																)
									);
END;
