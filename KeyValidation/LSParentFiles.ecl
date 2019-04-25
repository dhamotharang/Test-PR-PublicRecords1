//************************************************************************************************************************************//
//LS Parent files used for key validation purposes
//************************************************************************************************************************************//

EXPORT LSParentFiles := MODULE

Import Data_Services,BIPV2, liensv2, Doxie, ut,Ashirey;

SHARED liens_fcra_party_copy := LiensV2.file_liens_fcra_party;

SHARED get_recs_Bdid := project(liens_fcra_party_copy,transform(LiensV2.Layout_liens_party_ssn,self:=left));
slim_party := table(get_recs_Bdid((unsigned6)bdid != 0), {get_recs_Bdid.bdid,
                               get_recs_Bdid.tmsid,
						       get_recs_Bdid.rmsid});
									 
//Attribute that refers to BDID parent 
EXPORT parentFileKeyBDID  := slim_party;

get_recs_BDID_NF := project(LiensV2.file_liens_party,transform(LiensV2.Layout_liens_party_ssn,self:=left));

//Attribute that refers to NON FCRA BDID parent 
EXPORT parentFileKeyBDIDNF  := get_recs_BDID_NF((unsigned6)bdid != 0);

SHARED get_recs_CN_F := LiensV2.file_liens_fcra_main;

slim_rec_CN_F := record

get_recs_CN_F.tmsid;
get_recs_CN_F.rmsid;
string20 case_number;
string2 filing_state;

end;

strip_leadingzeroes(string20 number) := regexreplace('^[ |0]*',number,'');

slim_rec_CN_F tslim_CN_F(get_recs_CN_F L, integer cnt) := transform

string20 s_case_number        := if(strip_leadingzeroes(L.case_number)   <> '', L.case_number, ''); 
string20 s_filing_number      := if(strip_leadingzeroes(L.filing_number) <> '', L.filing_number, '');
string20 s_orig_filing_number := if(strip_leadingzeroes(L.orig_filing_number) <> '', L.orig_filing_number, '');

self.case_number := choose(cnt, s_case_number, s_filing_number, s_orig_filing_number);						  
self.filing_state  := if(length(trim(L.filing_jurisdiction, left, right)) = 2, L.filing_jurisdiction, L.filing_state);						                        
self := L;

end;
					   
slim_file_CN_F := normalize(get_recs_CN_F(case_number <> '' or filing_number <> '' or orig_filing_number <> ''), 3, tslim_CN_F(left, counter));


slim_rec_CN_F tformat_CN_F(slim_rec_CN_F L, integer cnt) := transform

self.case_number := choose(cnt, L.case_number, strip_leadingzeroes(L.case_number));
self := L;

end;

//Attribute that refers to FCRA case number parent 
EXPORT parentFileKeyCaseNumber :=  normalize(slim_file_CN_F(case_number<> ''), 2, tformat_CN_F(left, counter));

SHARED get_recs_CN := LiensV2.file_liens_main;

slim_rec_CN := record

get_recs_CN.tmsid;
get_recs_CN.rmsid;
string20 case_number;
string2 filing_state;

end;

strip_leadingzeroes(string20 number) := regexreplace('^[ |0]*',number,'');

slim_rec_CN tslim_CN(get_recs_CN L, integer cnt) := transform

string20 s_case_number        := if(strip_leadingzeroes(L.case_number)   <> '', L.case_number, ''); 
string20 s_filing_number      := if(strip_leadingzeroes(L.filing_number) <> '', L.filing_number, '');
string20 s_orig_filing_number := if(strip_leadingzeroes(L.orig_filing_number) <> '', L.orig_filing_number, '');

self.case_number := choose(cnt, s_case_number, s_filing_number, s_orig_filing_number);						  
self.filing_state  := if(length(trim(L.filing_jurisdiction, left, right)) = 2, L.filing_jurisdiction, L.filing_state);						                        
self := L;

end;
					   
slim_file_CN := normalize(get_recs_CN(case_number <> '' or filing_number <> '' or orig_filing_number <> ''), 3, tslim_CN(left, counter));


slim_rec_CN tformat_CN(slim_rec_CN L, integer cnt) := transform

self.case_number := choose(cnt, L.case_number, strip_leadingzeroes(L.case_number));
self := L;

end;

//Attribute that refers to NON FCRA case number parent 
EXPORT parentFileKeyCaseNumberNF := normalize(slim_file_CN(case_number<> ''), 2, tformat_CN(left, counter));

get_recs_DID := project(LiensV2.file_liens_party,transform(LiensV2.Layout_liens_party_ssn,self:=left));

//Attribute that refers to NON FCRA DID parent 
EXPORT parentFileKeyDIDNF  := get_recs_DID((unsigned6)did != 0);


//Attribute that refers to FCRA DID parent 
EXPORT parentFileKeyDID  :=  table(get_recs_Bdid((unsigned6)did != 0), {get_recs_Bdid.did,
                               get_recs_Bdid.tmsid,
						       get_recs_Bdid.rmsid});
									 
SHARED get_recs_filing := get_recs_CN_F;

slim_rec_filing := record

get_recs_filing.tmsid;
get_recs_filing.rmsid;
get_recs_filing.filing_number;
get_recs_filing.orig_filing_number;
string2 filing_state;

end;

slim_rec_filing tslim_filing(get_recs_filing L, integer cnt) := transform

self.filing_state := if(length(trim(L.filing_jurisdiction, left, right)) = 2, L.filing_jurisdiction, L.filing_state);
self.filing_number := choose(cnt, L.filing_number, L.orig_filing_number);
self := L;

end;

//Attribute that refers to FCRA Filing parent 
EXPORT parentFileKeyfiling  :=  normalize(get_recs_filing(filing_number <> '' or orig_filing_number <> ''),2, tslim_filing(left, counter));

get_recs_filing_NF := get_recs_CN;

slim_rec_filing_NF := record

get_recs_filing_NF.tmsid;
get_recs_filing_NF.rmsid;
get_recs_filing_NF.filing_number;
get_recs_filing_NF.orig_filing_number;
string2 filing_state;

end;

slim_rec_filing_NF tslim_filing_NF(get_recs_filing_NF L, integer cnt) := transform

self.filing_state := if(length(trim(L.filing_jurisdiction, left, right)) = 2, L.filing_jurisdiction, L.filing_state);
self.filing_number := choose(cnt, L.filing_number, L.orig_filing_number);
self := L;

end;
					   
//Attribute that refers to NON FCRA Filing parent 
EXPORT parentFileKeyfilingNF  :=normalize(get_recs_filing_NF(filing_number <> '' or orig_filing_number <> ''),2, tslim_filing_NF(left, counter));


slim_rec_CNr := record

get_recs_CN.tmsid;
get_recs_CN.rmsid;
string25 certificate_number;

end;

slim_rec_CNr tslim_CNR(get_recs_CN L) := transform
self.certificate_number := if(L.certificate_number != '',L.certificate_number,L.irs_serial_number);                  
self := L;

end;

// Attribute that refers to NON FCRA Ceritificate Number parent 
EXPORT parentFileKeyCTNNF  := project(get_recs_CN, tslim_CNR(left));

slim_rec_F_CTN := record

get_recs_filing.tmsid;
get_recs_filing.rmsid;
string25 certificate_number;

end;

slim_rec_F_CTN tslim_F_CTN(get_recs_filing L) := transform
self.certificate_number := if(L.certificate_number != '',L.certificate_number,L.irs_serial_number);                         
self := L;

end;

// Attribute that refers to FCRA Ceritificate Number parent 
EXPORT parentFileKeyCTN  := project(get_recs_filing, tslim_F_CTN(left));


slim_rec_SN := record

get_recs_CN.tmsid;
get_recs_CN.rmsid;
string2  agency_state ;
string25 irs_serial_number;

end;

slim_rec_SN tslim_SN(get_recs_CN L) := transform
                   
self := L;

end;

//Attribute that refers to NON FCRA Serial Number parent 
EXPORT parentFileKeySNNF  := project(get_recs_CN, tslim_SN(left));

slim_rec_SN_F := record

get_recs_filing.tmsid;
get_recs_filing.rmsid;
string2  agency_state ;
string25 irs_serial_number;

end;

slim_rec_SN_F tslim_SN_F(get_recs_filing L) := transform
                   
self := L;

end;

//Attribute that refers to FCRA Serial Number parent 
EXPORT parentFileKeySN  := project(get_recs_filing, tslim_SN_F(left));

//Attribute that refers to NON FCRA RMSID parent 
EXPORT parentFileKeyRMSNF  := get_recs_CN;

//Attribute that refers to FCRA RMSID parent 
EXPORT parentFileKeyRMS  := get_recs_filing;

SHARED get_recs_TRD := LiensV2.fnOverrideFilingStatus(get_recs_CN);

addlen_TRD := record
recordof(get_recs_TRD);
unsigned integer keylen;
end;

addlen_TRD getlen_TRD( get_recs_TRD l ) := transform
self.keylen :=  LENGTH( l.tmsid                          +    
l.rmsid                          +    
l.process_date                   +    
l.record_code                    +    
l.date_vendor_removed            +    
l.filing_jurisdiction            +    
l.filing_state                   +    
l.orig_filing_number             +    
l.orig_filing_type               +    
l.orig_filing_date               +    
l.orig_filing_time               +    
l.case_number                    +    
l.filing_number                  +    
l.filing_type_desc               +    
l.filing_date                    +    
l.filing_time                    +    
l.vendor_entry_date              +    
l.judge                          +    
l.case_title                     +    
l.filing_book                    +    
l.filing_page                    +    
l.release_date                   +    
l.amount                         +    
l.eviction                       +    
l.satisifaction_type             +    
l.judg_satisfied_date            +    
l.judg_vacated_date              +    
l.tax_code                       +    
l.irs_serial_number              +    
l.effective_date                 +    
l.lapse_date                     +    
l.accident_date                  +    
l.sherrif_indc                   +    
l.expiration_date          +    
l.agency              +    
l.agency_city         +    
l.agency_state        +    
l.agency_county       +    
l.legal_lot               +    
l.legal_block             +    
l.legal_borough           +    
l.certificate_number      +    
l.persistent_record_id + l.filing_status[1].filing_status + l.filing_status[1].filing_status_desc );

self := l;
end;

SHARED newget_TRD := project( get_recs_TRD,getlen_TRD(left));

SHARED recordof(get_recs_TRD) cutlen_TRD( newget_TRD l ) := transform
self.agency := if ( l.keylen > 150000 , l.agency[1..StringLib.StringFind(l.agency,',',1819)-1],l.agency);
self := l;
end;

//Attribute that refers to NON FCRA TMSID RMSID parent 
	
	SHARED layout_filing_status := RECORD,maxlength(10000)
	
   string filing_status;
   string filing_status_desc;
  END;
	
 SHARED TRMOutputLayout1 := RECORD,maxlength(32766)
		string50 tmsid;
		string50 rmsid;
		string process_date;
		string record_code;
		string date_vendor_removed;
		string filing_jurisdiction;
		string filing_state;
		string20 orig_filing_number;
		string orig_filing_type;
		string orig_filing_date;
		string orig_filing_time;
		string case_number;
		string20 filing_number;
		string filing_type_desc;
		string filing_date;
		string filing_time;
		string vendor_entry_date;
		string judge;
		string case_title;
		string filing_book;
		string filing_page;
		string release_date;
		string amount;
		string eviction;
		string satisifaction_type;
		string judg_satisfied_date;
		string judg_vacated_date;
		string tax_code;
		string irs_serial_number;
		string effective_date;
		string lapse_date;
		string accident_date;
		string sherrif_indc;
		string expiration_date;
		string agency;
		string agency_city;
		string agency_state;
		string agency_county;
		string legal_lot;
		string legal_block;
		string legal_borough;
		string certificate_number;
		unsigned8 persistent_record_id;
		layout_filing_status filing_status;
 END;
 
SHARED parentFileKeyTRSID_NFbase := project(newget_TRD,cutlen_TRD(left));

TRMOutputLayout1 normalizeKeyTransform4(parentFileKeyTRSID_NFbase l, unsigned c) := TRANSFORM
				self.filing_status := l.filing_status[c];
				self := l;
END;	
	
NormalizedKeyTRM_NF := NORMALIZE(parentFileKeyTRSID_NFbase,count(left.filing_status), normalizeKeyTransform4(left,counter));

Ashirey.Flatten(NormalizedKeyTRM_NF,NormalizedKeyTRF);	

EXPORT parentFileKeyTRSIDNF  := NormalizedKeyTRF;
	

addlen_F_TRSID := record
recordof(get_recs_filing);
unsigned integer keylen;
end;

addlen_F_TRSID getlen_F_TRSID( get_recs_filing l ) := transform
self.keylen :=  LENGTH( l.tmsid                          +    
l.rmsid                          +    
l.process_date                   +    
l.record_code                    +    
l.date_vendor_removed            +    
l.filing_jurisdiction            +    
l.filing_state                   +    
l.orig_filing_number             +    
l.orig_filing_type               +    
l.orig_filing_date               +    
l.orig_filing_time               +    
l.case_number                    +    
l.filing_number                  +    
l.filing_type_desc               +    
l.filing_date                    +    
l.filing_time                    +    
l.vendor_entry_date              +    
l.judge                          +    
l.case_title                     +    
l.filing_book                    +    
l.filing_page                    +    
l.release_date                   +    
l.amount                         +    
l.eviction                       +    
l.satisifaction_type             +    
l.judg_satisfied_date            +    
l.judg_vacated_date              +    
l.tax_code                       +    
l.irs_serial_number              +    
l.effective_date                 +    
l.lapse_date                     +    
l.accident_date                  +    
l.sherrif_indc                   +    
l.expiration_date          +    
l.agency              +    
l.agency_city         +    
l.agency_state        +    
l.agency_county       +    
l.legal_lot               +    
l.legal_block             +    
l.legal_borough           +    
l.certificate_number      +    
l.persistent_record_id + l.filing_status[1].filing_status + l.filing_status[1].filing_status_desc );

self := l;
end;

newget_F_TRSID := project( get_recs_filing,getlen_F_TRSID(left));

recordof(get_recs_filing) cutlen_F_TRSID( newget_F_TRSID l ) := transform
self.agency := if ( l.keylen > 150000 , l.agency[1..StringLib.StringFind(l.agency,',',1819)-1],l.agency);
self := l;
end;

//Attribute that refers to FCRA TMSID RMSID parent 
SHARED parentFileKeyTRSID_base :=   project(newget_F_TRSID,cutlen_F_TRSID(left));

TRMOutputLayout1 normalizeKeyTransform3(parentFileKeyTRSID_base l, unsigned c) := TRANSFORM
				self.filing_status := l.filing_status[c];
				self := l;
END;	

NormalizedKeyTRM_F := NORMALIZE(parentFileKeyTRSID_base,count(left.filing_status), normalizeKeyTransform3(left,counter));

Ashirey.Flatten(NormalizedKeyTRM_F,NormalizedKeyTRF_PFB);	

EXPORT parentFileKeyTRSID  := NormalizedKeyTRF_PFB;
	


//Attribute that refers to SourceRecId parent 
EXPORT parentFileKeysrid  := LiensV2.file_liens_party_BIPV2;


/* add integer did field */
d_TRL := table(parentFileKeysrid, {parentFileKeysrid, idid := (integer8)did});

/* suppress WA cellphones */
ut.mac_suppress_by_phonetype(d_TRL,phone,st,o_TRL,true,idid);

/* removed extra field */
get_recs_TRL := project(o_TRL, transform(LiensV2.Layout_liens_party_SSN_BIPV2, 
														 self.title := if(left.orig_name = 'SPENCER JAMES, ANGELA E','MS',left.title)
														,self.fname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','ANGELA',left.fname)
														,self.mname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','E',left.mname)
														,self.lname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','SPENCER JAMES',left.lname),self := left));

LiensV2.Layout_liens_party_BIPV2 tformat_TRL(liensv2.Layout_liens_party_SSN_BIPV2 L) := transform

self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
self.tax_id := if(L.tax_id <> '', if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
self := L;

end;

//Attribute that refers to TMSID RMSID LINKSID parent 
EXPORT parentFileKeyTRL := project(get_recs_TRL, tformat_TRL(left));


get_recs_TRIDP_F := LiensV2.file_liens_party_keybuild_fcra;

Layout_liens_party_linkids_TRIDP_F := record
  liensv2.layout_liens_party;
	BIPV2.IDlayouts.l_xlink_ids;
end;

Layout_liens_party_linkids_TRIDP_F tformat_TRIDP_F(get_recs_TRIDP_F L) := transform

self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
self.tax_id := if((unsigned6)L.tax_id <> 0, if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
self := L;

end;

// Attribute that refers to FCRA TMSID RMSID Party parent 
EXPORT parentFileKeyTRP :=  project(get_recs_TRIDP_F, tformat_TRIDP_F(left));


get_recs_TRP_NF := LiensV2.file_liens_party_keybuild;

Layout_liens_party_linkids_TRP_NF := record
  liensv2.layout_liens_party;
	BIPV2.IDlayouts.l_xlink_ids;
end;

Layout_liens_party_linkids_TRP_NF tformat_TRP_NF(get_recs_TRP_NF L) := transform

self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
self.tax_id := if(L.tax_id <> '', if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
self := L;

end;

//Attribute that refers to NON FCRA TMSID RMSID Party parent 
EXPORT parentFileKeyTRPNF := project(get_recs_TRP_NF, tformat_TRP_NF(left));

END;