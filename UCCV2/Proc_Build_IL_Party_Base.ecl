IMPORT Address, NID, UCCV2, ut; 

dCanada  := ['AB','BC','MB','NS','ON','PQ','SN','AE'];

layout_party :=record
		  string9     file_no;
			string8		process_date;
			string300 	Orig_name:='';
			string300   Company_name :='';
			string60 	Orig_address1:='';
			string60 	Orig_address2:='';
			string30 	Orig_city:='';
			string2  	Orig_state:='';
			string5  	Orig_zip5:='';
			string4  	Orig_zip4:='';
			string30	Orig_country:='';
			string30 	Orig_province:='';
			string10    ssn     :='';
			string11    fein    :='';
			string9  	Orig_postal_code:='';
			string1  	foreign_indc:='';
			string1  	Party_type:='';
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
end;

layout_rmsid_tmsid 
         :=record
		   Layout_UCC_Common.layout_ucc.rmsid;
		   Layout_UCC_Common.layout_ucc.tmsid;
		   Layout_UCC_Common.layout_ucc.filing_date;
		  end;	
			
layout_party tBDName_Address(File_IL_Debtor_in pInput) 
   := 
   transform
            
			boolean   foreign_indc  	:= pInput.debtor_state in Dcanada;
			self.Orig_name 	   				:= pInput.debtor_name;// d_pname_debtor;
			self.company_name  				:= if(pInput.debtor_name_cd='B',pInput.debtor_name,'');
			self.ssn      		    		:= if(pInput.debtor_ssfn!='000000000' ,pInput.debtor_ssfn,'');
			self.fein     		    		:= if(pInput.debtor_ssfn!='000000000',pInput.debtor_ssfn,''); 
			self.Orig_address1 				:= pInput.debtor_street;
			self.Orig_city     				:= pInput.debtor_city;
			self.Orig_state    				:= pInput.debtor_state;
			self.Orig_zip5     				:= pInput.debtor_zip;
			self.Orig_country  				:= if(foreign_indc, 'CANADA','');
			self.Orig_province  			:= if(foreign_indc, pInput.debtor_state,'');
			self.Orig_postal_code			:= if(foreign_indc, pInput.debtor_zip,'');
			self.foreign_indc	    		:= if (foreign_indc,'Y','N');
			self.party_type         	:= 'D';
			self			        				:= 	pInput;
			self											:=	[];
     END;

layout_party tBSName_Address(File_IL_SecuredParty_in pInput) 
   := 
   transform
      boolean   foreign_indc  	:= pInput.secured_state in Dcanada;
			self.Orig_name 	   				:= pInput.Secured_name;// d_pname_debtor;
			self.Orig_address1 				:= pInput.secured_street;
			self.Orig_city     				:= pInput.secured_city;
			self.Orig_state    				:= pInput.secured_state;
			self.Orig_zip5     				:= pInput.secured_zip;
			self.Orig_country  				:= if(foreign_indc, 'CANADA','');
			self.Orig_province  			:= if(foreign_indc, pInput.secured_state,'');
			self.Orig_postal_code			:= if(foreign_indc, pInput.secured_zip,'');
			self.foreign_indc	    		:= if (foreign_indc,'Y','N');
			self.party_type        		:= 'S';
			self			        				:= 	pInput;
			self											:=	[];			
     END;
		 
layout_party tpDName_Address(File_IL_Master_in pInput) 
   := 
   transform
        
      boolean   foreign_indc  	:= pInput.secured_state in Dcanada;
			self.Orig_name 	   				:= pInput.Secured_name;// d_pname_debtor;
			self.Orig_address1 				:= pInput.secured_street;
			self.Orig_city     				:= pInput.secured_city;
			self.Orig_state    				:= pInput.secured_state;
			self.Orig_zip5     				:= pInput.secured_zip;
			self.Orig_country  				:= if(foreign_indc, 'CANADA','');
			self.Orig_province  			:= if(foreign_indc, pInput.secured_state,'');
			self.Orig_postal_code			:= if(foreign_indc, pInput.secured_zip,'');
			self.foreign_indc	    		:= if (foreign_indc,'Y','N');
			self.party_type        		:= 'S';
			self			        				:=  pInput;
			self											:=	[];			
     END;
		 
UCCV2.Layout_UCC_Common.Layout_Party_with_AID tProjParty(layout_party    pInput) 
   := 
   TRANSFORM
    
	 self.tmsid 					    			:=	'IL'+pInput.file_no;	 
	 self.dt_first_seen							:=  (unsigned6)(pInput.process_date[1..6]);
   self.dt_last_seen							:=  (unsigned6)(pInput.process_date[1..6]);
   self.dt_vendor_first_reported	:=  (unsigned6) pInput.process_date;
   self.dt_vendor_last_reported		:=  (unsigned6) pInput.process_date;
	 self														:=	pInput;
	 self														:=	[];
END;

UCCV2.Layout_UCC_Common.Layout_Party_with_AID RollupP(UCCV2.Layout_UCC_Common.Layout_Party_with_AID  pLeft,UCCV2.Layout_UCC_Common.Layout_Party_with_AID pRight) 
   := 
   TRANSFORM
  self.dt_first_seen 				    := ut.EarliestDate(	ut.EarliestDate(pLeft.dt_first_seen,pRight.dt_first_seen),
																										ut.EarliestDate(pLeft.dt_last_seen,pRight.dt_last_seen)
																									 );
	self.dt_last_seen 			    	:= max(pLeft.dt_last_seen,pRight.dt_last_seen);
	self.dt_vendor_last_reported	:= max(pLeft.dt_vendor_last_reported,	pRight.dt_vendor_last_reported);
	self.dt_vendor_first_reported	:= ut.EarliestDate(pLeft.dt_vendor_first_reported,pRight.dt_vendor_first_reported);
	SELF.process_date 			    	:= if(pleft.process_date > pright.process_date, pleft.process_date, pRight.process_date);
	self                       	  := pLeft;
END;

UCCV2.Layout_UCC_Common.Layout_Party_with_AID tIdSwitch(UCCV2.Layout_UCC_Common.Layout_Party_with_AID  pLeft, layout_rmsid_tmsid pRight)
   :=
   TRANSFORM
   self.rmsid		:=pRight.rmsid;
   self					:=pleft;
   end;

dMain						:= File_IL_Main_Base;
dSortmain				:= sort(distribute(dedup(sort(project(dmain,layout_rmsid_tmsid),filing_date),except filing_date,rmsid,all),hash(tmsid)),tmsid,local);

dDebtor					:= project(File_IL_Debtor_in,tBDName_Address(left));
dSecuredParty		:= project(File_IL_SecuredParty_in,tBSName_Address(left));
dMaster					:= project(File_IL_Master_in,tPDName_Address(left));
dParty					:= dSecuredParty+dMaster;

NID.Mac_CleanFullNames(dParty, CleanNameRecs, orig_name, useV2:=true);

person_flags   := ['P', 'D'];
// V2 replaced the Unclassified('U') category with the Trust ('T') category, what used to be a U should become a T or I with V2.
business_flags := ['B', 'I', 'T'];

layout_party trfCleanName(CleanNameRecs L) := TRANSFORM
	SELF.title        := IF(L.nametype IN person_flags, L.cln_title, '');
	SELF.fname        := IF(L.nametype IN person_flags, L.cln_fname, '');
	SELF.mname        := IF(L.nametype IN person_flags, L.cln_mname, '');
	SELF.lname        := IF(L.nametype IN person_flags, L.cln_lname, '');
	SELF.name_suffix  := IF(L.nametype IN person_flags, L.cln_suffix, '');
	SELF.company_name := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.orig_name), '');
	SELF.name_score		:= '';

	SELF := L;
END;

NID.Mac_CleanFullNames(dDebtor, VerifyDebtors, orig_name, useV2:=true);

layout_party add_clean_name_debtor(VerifyDebtors L) := TRANSFORM
	SELF.title        := IF(L.nametype IN person_flags, L.cln_title, '');
	SELF.fname        := IF(L.nametype IN person_flags, L.cln_fname, '');
	SELF.mname        := IF(L.nametype IN person_flags, L.cln_mname, '');
	SELF.lname        := IF(L.nametype IN person_flags, L.cln_lname, '');
	SELF.name_suffix  := IF(L.nametype IN person_flags, L.cln_suffix, '');
	SELF.company_name := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.orig_name), '');
	SELF.ssn      		:= IF(L.ssn != '' AND L.nametype NOT IN business_flags, L.ssn, '');
	SELF.fein     		:= IF(L.fein != '' AND L.nametype IN business_flags, L.fein, ''); 

	SELF := L;
END;

dAll := PROJECT(CleanNameRecs, trfCleanName(LEFT)) + PROJECT(VerifyDebtors, add_clean_name_debtor(LEFT));

dNameProj				:= project(dAll(company_name=''), tProjParty(Left));
dNameDist				:= distribute(dNameProj,  hash(tmsid,fname, mname,lname,trim(Orig_address1)));
dNameSort				:= sort(dNamedist, tmsid,fname, mname,lname,trim(Orig_address1),
							          dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local
												);
											 
dNameDedup			:= rollup(dNameSort ,
													left.tmsid    = right.tmsid 	and
													left.fname    = right.fname 	and
													left.mname    = right.mname   and
													left.lname  	= right.lname   and
													left.Orig_address1  	= right.Orig_address1,
													Rollupp(left, right),  local
													);

dCnameProj			:= project(dAll(company_name!=''), tProjParty(Left));
dCnameDist			:= distribute(dCnameProj ,hash(tmsid,zip5, trim(Orig_address1), trim(company_name)));
dCnameSort			:= sort(dCnamedist, tmsid,Orig_zip5, Orig_address1, company_name,fein,
												dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local
												);
											 
dCnameDedup			:=  rollup(dCnameSort  ,
													left.tmsid          = right.tmsid					and
													left.Orig_zip5      = right.Orig_zip5			and
													left.Orig_address1  = right.Orig_address1	and
													left.company_name   = right.company_name 	and
													(right.fein         = '' or left.fein 		= right.fein),
													Rollupp(left, right),
													local
													);
dpartyOut				:=dCnameDedup+dnameDedup;

dReassignRmsid	:=  Join(	sort(distribute(dpartyOut,hash(tmsid)),tmsid,local),
													dSortmain ,
													left.tmsid=right.tmsid,
													tIdSwitch(left,right),local
												);

OutParty				:=  output(dReassignRmsid   ,,UCCV2.cluster.cluster_out+'base::UCC::Party::IL',overwrite,__compressed__);
AddSuperfile		:=  FileServices.AddSuperFile(UCCV2.cluster.cluster_out+'base::UCC::Party_Name',UCCV2.cluster.cluster_out+'base::UCC::Party::IL');

export proc_build_IL_party_base    :=sequential(OutParty,AddSuperfile); 