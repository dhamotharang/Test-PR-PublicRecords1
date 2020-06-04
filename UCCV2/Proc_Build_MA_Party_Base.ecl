IMPORT Address, NID, UCCV2, ut; 

Layout_party	:=	Record
	string8   process_date;
	string10	uccid;
	string1		filingstatus;
	string12	filingnum;
	string3		ucctype;
	string30	ucc_type_desc;
	string10	ucc1;
	string25	approvaldate;
	string1		ficheexists;
	string60  ficheexists_desc;
	string1		newsysswitch;
	string30	transtype;
	string10	nameid;
	string2	  nametype;
	string15  nametype_desc;
	string25	Orig_fname;
	string25	Orig_mname;
	string35	Orig_lname;
	string10	Orig_suffix;
	string25	srchfname;
	string25	srchmname;
	string35	srchlname;
	string10	srchsuffix;
	string160	addr1;
	string55	addr2;
	string30	city;
	string30	srchcity;
	string2		state;
	string15	postalcode;
	string10	country;
	string175	orgname;
	string175	srchorgname;
	string45	stateofinc;
	string30	corpnum;
	string30	corptype;
	string1		status_cd;
	string8		status_desc;
	string12	originalfilenum; 
	string100	prep_addr_line1;
	string50	prep_addr_last_line; 
	unsigned8	RawAid	:= 0;
	unsigned8	ACEAID	:= 0;	
	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	string3		name_score;
	string60	company_name;			
end; 
   
trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;   
			
layout_party	trfPartyClean(uccv2.File_MA_in pInput) := 	transform
	self.fname								:=	pInput.Orig_fname;
	self.mname								:=	pInput.Orig_mname;
	self.lname								:=	pInput.Orig_lname;
	self.name_suffix					:=	pInput.Orig_suffix;
	self			        				:= 	pInput;
	self											:=	[];
END;

dParty	:=	project(uccv2.File_MA_in, trfPartyClean(left));

dBusiness	:=	dParty(orgname!='');
dPerson		:=	dParty(orgname='');

// Since the layout contains nametype, need to declare the NID attriubte to be something else.
NID.Mac_CleanFullNames(dBusiness, cleanedNameRecs, orgname, , nid_nametype, useV2:=true);

person_flags   := ['P', 'D'];
// V2 replaced the Unclassified('U') category with the Trust ('T') category, what used to be a U should become a T or I with V2.
business_flags := ['B', 'I', 'T'];

layout_party trfCleanName(cleanedNameRecs L) := TRANSFORM
	SELF.title        := IF(L.nid_nametype IN person_flags, L.cln_title, '');
	SELF.fname        := IF(L.nid_nametype IN person_flags, L.cln_fname, '');
	SELF.mname        := IF(L.nid_nametype IN person_flags, L.cln_mname, '');
	SELF.lname        := IF(L.nid_nametype IN person_flags, L.cln_lname, '');
	SELF.name_suffix  := IF(L.nid_nametype IN person_flags, L.cln_suffix, '');
	SELF.company_name := IF(L.nid_nametype IN business_flags, StringLib.StringToUpperCase(L.orgname), '');
	SELF.name_score		:= '';

	SELF := L;
END;

// Since the layout contains nametype, need to declare the NID attriubte to be something else.
NID.Mac_CleanParsedNames(dPerson, VerifyPersons, fname, mname, lname, name_suffix, , , nid_nametype, useV2:=true);

// Because the vendor will sometimes send a company name as a person's last name only, we need to make
// sure what they sent is a person.
layout_party add_clean_name_person(VerifyPersons L) := TRANSFORM
	SELF.title        := IF(L.nid_nametype IN person_flags, L.cln_title, '');
	SELF.fname        := IF(L.nid_nametype IN person_flags, L.cln_fname, '');
	SELF.mname        := IF(L.nid_nametype IN person_flags, L.cln_mname, '');
	SELF.lname        := IF(L.nid_nametype IN person_flags, L.cln_lname, '');
	SELF.name_suffix  := IF(L.nid_nametype IN person_flags, L.cln_suffix, '');
	SELF.company_name := IF(L.nid_nametype IN business_flags, StringLib.StringToUpperCase(L.orig_lname), '');

	SELF := L;
END;

dAll := PROJECT(cleanedNameRecs, trfCleanName(LEFT)) + PROJECT(VerifyPersons, add_clean_name_person(LEFT));

UCCV2.Layout_UCC_Common.Layout_Party_with_AID tProjParty(dParty  pInput) 
   := 
   TRANSFORM
    
	Boolean    Orig_tag						:= REGEXFIND('1|Ut|li',pInput.ucc_type_desc );
	self.tmsid										:= 'MA'+if(pInput.originalfilenum='',pInput.filingnum,pInput.originalfilenum) ;
	self.rmsid										:= 'MA'+pInput.filingnum+pInput.ucctype;
	self.Orig_name 								:= pInput.orgname ;
	self.Orig_address1						:= pInput.addr1;
	self.Orig_city								:= pInput.city;
	self.Orig_state								:= pInput.state;
	self.Orig_zip5								:= if(REGEXFIND('[A-Z]',pInput.postalcode),'', pInput.postalcode[1..5]);
	self.Orig_country							:= pInput.country;
	self.corp_number							:= pInput.corpnum ;
	self.corp_type								:= pInput.corptype ;
	self.Incorp_state							:= pInput.stateofinc;
	self.Orig_postal_code					:= if(pInput.country<>'USA',pInput.postalcode,'');
	self.foreign_indc							:= if(REGEXFIND('[A-Z]',pInput.postalcode) ,'Y','N');
	self.Party_type								:= if(trimUpper(pInput.nameType)='C',  //If MA has sent a nameType of 'C'
																				'S',                            //(creditor), then override it with
																				pInput.nameType
																			);               //'S' (secured) - per Rosemary Murphy.
	self.dt_first_seen						:=   (unsigned6)(pInput.process_date[1..6]);
	self.dt_last_seen							:=   (unsigned6)(pInput.process_date[1..6]);
	self.dt_vendor_first_reported	:=   (unsigned6) pInput.process_date;
	self.dt_vendor_last_reported	:=   (unsigned6) pInput.process_date;
	self													:=	pInput;
	self													:=	[];
END;

UCCV2.Layout_UCC_Common.Layout_Party_with_AID RollupUpdate(UCCV2.Layout_UCC_Common.Layout_Party_with_AID pLEft, UCCV2.Layout_UCC_Common.Layout_Party_with_AID pRight) 
   := TRANSFORM
	SELF.dt_first_seen 						:= ut.EarliestDate(	ut.EarliestDate(pLeft.dt_first_seen,pRight.dt_first_seen),
																										ut.EarliestDate(pLeft.dt_last_seen,pRight.dt_last_seen));
	SELF.dt_last_seen 						:= max(pLeft.dt_last_seen,pRight.dt_last_seen);
	SELF.dt_vendor_last_reported 	:= max(pLeft.dt_vendor_last_reported, pRight.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(pLeft.dt_vendor_first_reported, pRight.dt_vendor_first_reported);
	SELF.process_date 						:= if(pleft.process_date > pRight.process_date, pLeft.process_date, pRight.process_date);
	SELF 													:= pLeft;
end;

		 
dNameProj   						:= sort(distribute(project(dAll, tProjParty(Left)),hash(tmsid)),record,local);
dNameDedup							:= rollup(dNameProj, RollupUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                                       dt_vendor_first_reported, dt_vendor_last_reported, process_date,  local);
									   
									   

OutParty                :=  output(dNameDedup  ,,UCCV2.cluster.cluster_out+'base::UCC::Party::ma',overwrite,__compressed__);
AddSuperfile            :=  FileServices.AddSuperFile(UCCV2.cluster.cluster_out+'base::UCC::Party_Name',UCCV2.cluster.cluster_out+'base::UCC::Party::ma');

export proc_build_ma_party_base    :=sequential(OutParty,AddSuperfile); 