IMPORT Address, NID, UCCV2, ut;

person_flags := ['P', 'D'];
// An executive decision was made to consider Unclassifed and Invalid names as company names for UCC.
business_flags := ['B', 'U', 'I'];

NID.Mac_CleanFullNames(UCCV2.File_DnB_debtor_in, dCleanName, filg_nme);

UCCV2.Layout_File_DnB_Debtor_in CleanName(dCleanName L) := TRANSFORM
	SELF.Personal_name1	:= MAP(L.nametype IN person_flags => L.cln_title + 
																													 L.cln_fname + 
																													 L.cln_mname + 
																													 L.cln_lname +
																													 L.cln_suffix,
														 '');
	SELF.Personal_name2	:= MAP(L.nametype = 'D' => L.cln_title2 + 
																								 L.cln_fname2 + 
																								 L.cln_mname2 + 
																								 L.cln_lname2 +
																								 L.cln_suffix2,
														 '');
	SELF.Company_name1 := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.filg_nme), '');	

	SELF := L;
END;		

cleanDebtor := PROJECT(dCleanName, CleanName(LEFT));

NID.Mac_CleanFullNames(UCCV2.File_DnB_SecuredParty_in, dCleanName_sec, filg_nme);

UCCV2.Layout_File_DnB_SecuredParty_in CleanName_sec(dCleanName_sec L) := TRANSFORM
	SELF.Personal_name1	:= MAP(L.nametype IN person_flags => L.cln_title + 
																													 L.cln_fname + 
																													 L.cln_mname + 
																													 L.cln_lname +
																													 L.cln_suffix,
														 L.nametype = 'U' => L.Personal_name1,
														 '');
	SELF.Personal_name2	:= MAP(L.nametype = 'D' => L.cln_title2 + 
																								 L.cln_fname2 + 
																								 L.cln_mname2 + 
																								 L.cln_lname2 +
																								 L.cln_suffix2,
														 L.nametype = 'U' => L.Personal_name2,
														 '');
	SELF.Company_name1 := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.filg_nme), '');	

	SELF := L;
END;		

CleanSecured := PROJECT(dCleanName_sec, CleanName_sec(LEFT));

layout_rmsid :=	Record
		string31 tmsid;
		string23 rmsid;
end;

rNormalizedName
 :=
  record ,MAXLENGTH(32767)
		  string17  Rmsid;
			string8   PROCESS_DATE;		 
		 	string120 Orig_name:='';
			string25 	Orig_lname:='';
			string25	Orig_fname:='';
			string35	Orig_mname:='';
			string10	Orig_suffix:='';
			string9  	duns_number:='';
			string9  	hq_duns_number:='';
			string9 	ssn:='';
			string10 	fein:='';
			string45 	Incorp_state:='';
			string30 	corp_number:='';
			string30 	corp_type:='';
			string60 	Orig_address1:='';
			string60 	Orig_address2:='';
			string30 	Orig_city:='';
			string2  	Orig_state:='';
			string5  	Orig_zip5:='';
			string4  	Orig_zip4:='';
			string30	Orig_country:='';
			string30 	Orig_province:='';
			string9  	Orig_postal_code:='';
			string1  	foreign_indc:='';
			string1  	Party_type:='';
			string5  	title;
			string20 	fname;
			string20 	mname;
			string20 	lname;
			string5  	name_suffix;
			// qstring73	Personal_Name;
			qstring60 Company_Name;
			string100	prep_addr_line1;
			string50	prep_addr_last_line; 
			unsigned8	RawAid	:= 0;
			unsigned8	ACEAID	:= 0;	
  end
 ;

rNormalizedName tNormalizeName(File_DnB_debtor_in pInput, unsigned1 pCounter)
 :=
  transform
	self.title							:=	choose(pCounter,pInput.Personal_name1[1..5],pInput.Personal_name2[1..5],pInput.Personal_name3[1..5],pInput.Personal_name4[1..5],pInput.Personal_name5[1..5]);
	self.fname							:=	choose(pCounter,pInput.Personal_name1[6..25],pInput.Personal_name2[6..25],pInput.Personal_name3[6..25],pInput.Personal_name4[6..25],pInput.Personal_name5[6..25]);
	self.mname							:=	choose(pCounter,pInput.Personal_name1[26..45],pInput.Personal_name2[26..45],pInput.Personal_name3[26..45],pInput.Personal_name4[26..45],pInput.Personal_name5[26..45]);
	self.lname							:=	choose(pCounter,pInput.Personal_name1[46..65],pInput.Personal_name2[46..65],pInput.Personal_name3[46..65],pInput.Personal_name4[46..65],pInput.Personal_name5[46..65]);
	self.name_suffix				:=	choose(pCounter,pInput.Personal_name1[66..70],pInput.Personal_name2[66..70],pInput.Personal_name3[66..70],pInput.Personal_name4[66..70],pInput.Personal_name5[66..70]);
	self.Company_Name				:=	choose(pCounter,pInput.Company_name1,pInput.Company_name2,pInput.Company_name3,pInput.Company_name4,pInput.Company_name5);
	self.party_type					:=  'D';
	self.orig_name          := 	pInput.FILG_NME;
	self.duns_number        := 	pInput.BUS_DUNS_ID;
	self.hq_duns_number     := 	pInput.BUS_HQ_DUNS_NBR;
	self.orig_address1      := 	pInput.FILG_STR_ADR;
	self.orig_city          := 	pInput.FILG_CITY_NME;
	self.orig_state         := 	pInput.FILG_ST_NAME;
	self.orig_zip5          := 	pInput.FILG_POST_CD;
	self.orig_country       := 	pInput.FILG_CTRY_NME;
	self.orig_province      := 	pInput.FILG_FOR_REG;
	self.orig_postal_code   := 	if (pInput.FILG_CTRY_NME+pInput.FILG_FOR_REG>'0',pInput.FILG_POST_CD,'');
	self.foreign_indc       := 	if (pInput.FILG_CTRY_NME<>'','Y','N');
  self.rmsid	            := 	pInput.F_FING_ENTY_ID;
	self 										:= 	pInput;
	self										:= 	[];
	
end;

rNormalizedName tNormalizeNameS(File_DnB_SecuredParty_in pInput, unsigned1 pCounter)
 :=
  transform
	self.title						:=	choose(pCounter,pInput.Personal_name1[1..5],pInput.Personal_name2[1..5],pInput.Personal_name3[1..5],pInput.Personal_name4[1..5],pInput.Personal_name5[1..5]);
	self.fname						:=	choose(pCounter,pInput.Personal_name1[6..25],pInput.Personal_name2[6..25],pInput.Personal_name3[6..25],pInput.Personal_name4[6..25],pInput.Personal_name5[6..25]);
	self.mname						:=	choose(pCounter,pInput.Personal_name1[26..45],pInput.Personal_name2[26..45],pInput.Personal_name3[26..45],pInput.Personal_name4[26..45],pInput.Personal_name5[26..45]);
	self.lname						:=	choose(pCounter,pInput.Personal_name1[46..65],pInput.Personal_name2[46..65],pInput.Personal_name3[46..65],pInput.Personal_name4[46..65],pInput.Personal_name5[46..65]);
	self.name_suffix			:=	choose(pCounter,pInput.Personal_name1[66..70],pInput.Personal_name2[66..70],pInput.Personal_name3[66..70],pInput.Personal_name4[66..70],pInput.Personal_name5[66..70]);	
	self.Company_Name	    :=  choose(pCounter,pInput.Company_name1,pInput.Company_name2,pInput.Company_name3,pInput.Company_name4,pInput.Company_name5);
	self.party_type		    := 	if (pInput.ASGE_INDC='Y','A','S');
	self.orig_name				:= 	pInput.FILG_NME;
	self.duns_number      := 	pInput.BUS_DUNS_NBR;
	self.hq_duns_number		:= 	pInput.BUS_HQ_DUNS_NBR;
	self.orig_address1		:= 	pInput.FILG_STR_ADR;
	self.orig_city				:= 	pInput.FILG_CITY_NME;
	self.orig_state				:= 	pInput.FILG_ST_NAME;
	self.orig_zip5				:= 	pInput.FILG_POST_CD;
	self.orig_country			:= 	pInput.FILG_CTRY_NME;
	self.orig_province		:= 	pInput.FILG_FOR_REG;
	self.orig_postal_code	:= 	if (pInput.FILG_CTRY_NME+pInput.FILG_FOR_REG>'0',pInput.FILG_POST_CD,'');
	self.foreign_indc			:= 	if (pInput.FILG_CTRY_NME<>'','Y','N');
  self.rmsid						:= 	pInput.F_FING_ENTY_ID;
	self									:= 	pInput;
	self									:=	[];
end;


dNormalizeDebtor					:=	normalize(cleanDebtor,5,tNormalizeNAme(left,counter));
dNormalizeSecuredParty		:=	normalize(cleanSecured,5,tNormalizeNameS(left,counter));
dName_address       			:=	dNormalizeDebtor(Company_name>'' or StringLib.StringCleanSpaces(trim(title)+trim(fname)+trim(mname)+trim(lname))>'' ) +   
															dNormalizeSecuredParty(Company_name>'' or StringLib.StringCleanSpaces(trim(title)+trim(fname)+trim(mname)+trim(lname))>'' );

// Preparing to append DID,BDID

UCCV2.Layout_UCC_Common.Layout_Party_with_AID project_Name_address(dName_Address pInput) 
   := 
   TRANSFORM
   
	self.dt_first_seen						:=   (unsigned6)(pInput.process_date[1..6]);
	self.dt_last_seen							:=   (unsigned6)(pInput.process_date[1..6]);
	self.dt_vendor_first_reported	:=   (unsigned6)(pInput.process_date[1..6]);
	self.dt_vendor_last_reported	:=   (unsigned6)(pInput.process_date[1..6]);
	self.tmsid										:=  	'';
	self													:=		pInput;
	self													:=		[];
END;

UCCV2.Layout_UCC_Common.Layout_Party_with_AID RollupP(UCCV2.Layout_UCC_Common.Layout_Party_with_AID  pLeft,UCCV2.Layout_UCC_Common.Layout_Party_with_AID pRight) 
   := 
   TRANSFORM
    self.dt_first_seen 			    := ut.EarliestDate(ut.EarliestDate(pLeft.dt_first_seen,pRight.dt_first_seen),
	                                   ut.EarliestDate(pLeft.dt_last_seen,pRight.dt_last_seen));
	self.dt_last_seen 			    	:= max(pLeft.dt_last_seen,pRight.dt_last_seen);
	self.dt_vendor_last_reported	:= max(pLeft.dt_vendor_last_reported,	pRight.dt_vendor_last_reported);
	self.dt_vendor_first_reported	:= ut.EarliestDate(pLeft.dt_vendor_first_reported,pRight.dt_vendor_first_reported);
	SELF.process_date 			    	:= if(pleft.process_date > pright.process_date, pleft.process_date, pRight.process_date);
	self                          := pLeft;
   END;
   
//Note: The Party TMSID is assigned from the RMSID-associated Main TMSID   
UCCV2.Layout_UCC_Common.Layout_Party_with_AID    tIdappend(UCCV2.Layout_UCC_Common.Layout_Party_with_AID pleft,layout_rmsid pright)
   :=
   TRANSFORM
     self.tmsid                     :=pright.tmsid;
	 self                           :=pLeft;
   end;
dDedupRmsid							:= sort(distribute(project(File_DnB_Main_Base(~REGEXFIND('D',rmsid )),layout_rmsid)
                                            ,hash(rmsid)),rmsid,local);
dNameProj   						:= project(dName_address(Company_Name=''), project_Name_address(Left));
dNameDist		        			:= distribute(dNameProj,  hash(rmsid,fname, mname,lname,trim(prim_range)));
dNameSort 			    			:= sort(dNamedist, rmsid,fname, mname,lname,trim(orig_address1),party_type,
							                 dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
dNameDedup              			:= rollup(dNameSort ,
											  left.rmsid    = right.rmsid   and
											  left.fname    = right.fname 	and
											  left.mname    = right.mname   and
											  left.lname  	= right.lname   and
											  left.party_type   = right.party_type	    and
											  left.orig_address1  	= right.orig_address1,
											  Rollupp(left, right),  local);

dCnameProj   						:= project(dName_address(Company_Name<>''), project_Name_address(Left));
dCnameDist							:= distribute(dCnameProj ,hash(rmsid,orig_zip5,trim(orig_address1),trim(company_name)));
dCnameSort 							:= sort(dCnamedist, rmsid,orig_zip5,orig_address1,company_name,fein,party_type,
							                 dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
dCnameDedup    						:= rollup(dCnameSort  ,
												left.rmsid          = right.rmsid 				and
												left.orig_zip5      = right.orig_zip5			and
												left.orig_address1  = right.orig_address1	and
												left.company_name   = right.company_name 	and
												left.party_type     = right.party_type		and
												(right.fein         = '' or left.fein 		= right.fein),
												Rollupp(left, right),
												local);

					
dPartyOut                            := dCnameDedup + dNameDedup;
                                       
					
dAppendRmsid            :=  Join(sort(distribute(dPartyOut,hash(rmsid)),rmsid,local),dDedupRmsid  ,
                                      left.rmsid=right.rmsid,
									  tIdappend(left,right),local);	
						
dPartyBase              :=  dedup(dAppendRmsid  ,except dt_first_seen, 
                                                           dt_last_seen,
														   dt_vendor_last_reported,
														   dt_vendor_first_reported, All);
														   
														   
dPartyBaseFilt					:=	dPartyBase(tmsid <> 'DNB11538536120180807'	or (tmsid='DNB11538536120180807' and ut.CleanSpacesAndUpper(orig_name)<>'HOWARD STATE BANK'));
														   
														   
OutParty                :=  output(dPartyBaseFilt  ,,UCCV2.cluster.cluster_out+'base::UCC::Party::dnb',overwrite,__compressed__);
AddSuperfile            :=  FileServices.AddSuperFile(UCCV2.cluster.cluster_out+'base::UCC::Party_Name',UCCV2.cluster.cluster_out+'base::UCC::Party::dnb');

export proc_build_dnb_party_base    :=sequential(OutParty,AddSuperfile); 
