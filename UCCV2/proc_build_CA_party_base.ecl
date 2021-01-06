IMPORT Address, NID, UCCV2, ut; 

//CA
layout_party	:=	record
			string14	initial_filing_number;
			string8		process_date;
			string120	Orig_name:='';
			string25 	Orig_lname:='';
			string25	Orig_fname:='';
			string35	Orig_mname:='';
			string10	Orig_suffix:='';
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
			string100	prep_addr_line1;
			string50	prep_addr_last_line; 
			string5		title;
			string20	fname;
			string20	mname;
			string20	lname;
			string5		name_suffix;
			string3		name_score;	
			string60	company_name;			
		 end;
		 
layout_rmsid_tmsid 
         :=record
		   Layout_UCC_Common.layout_ucc.rmsid;
		   Layout_UCC_Common.layout_ucc.tmsid;
		   Layout_UCC_Common.layout_ucc.filing_date;
		  end;

layout_party tBDName_Address(File_ca_BusinessDebtor_in pInput) 
   := 
   transform
	 
     self.Orig_name 					:=	pInput.bd_name;
		 self.Orig_address1				:=	pInput.bd_st_address;
		 self.Orig_address2				:=	if(pInput.bd_city != '',
																					ut.CleanSpacesAndUpper(trim(pInput.bd_city) + ', ' + trim(pInput.bd_state) + ' ' + trim(pInput.bd_zip)),
																					ut.CleanSpacesAndUpper(trim(pInput.bd_state) + ' ' + trim(pInput.bd_zip))
																			);	
		 self.Orig_city						:=	pInput.bd_city;
		 self.Orig_state					:=	pInput.bd_state;
		 self.Orig_zip5						:=	pInput.bd_zip ;
		 self.Orig_zip4						:=	pInput.bd_zip_extn;
		 self.Orig_country				:=	if(pInput.bd_country <> 'UNITED STATES',pInput.bd_country,'');
		 self.Orig_postal_code		:=	if(pInput.bd_country <> 'UNITED STATES',pInput.bd_zip,'');
		 self.foreign_indc	 		 	:=	if(pInput.bd_country <> 'UNITED STATES','Y','N');
		 self.party_type     			:=	'D';
		 self		           				:= 	pInput;
		 self											:=	[];	 
END;

layout_party tBSName_Address(File_ca_BusinessSecuredParty_in pInput) 
   := 
   transform
     self.Orig_name 					:=	pInput.bs_name;
		 self.Orig_address1				:=	pInput.bs_st_address;
		 self.Orig_address2				:=	if(pInput.bs_city != '',
																		 ut.CleanSpacesAndUpper(trim(pInput.bs_city) + ', ' + trim(pInput.bs_state) + ' ' + trim(pInput.bs_zip)),
																		 ut.CleanSpacesAndUpper(trim(pInput.bs_state) + ' ' + trim(pInput.bs_zip))
																			);	
		 self.Orig_city						:=	pInput.bs_city;
		 self.Orig_state					:=	pInput.bs_state;
		 self.Orig_zip5						:=	pInput.bs_zip ;
		 self.Orig_zip4						:=	pInput.bs_zip_extn;
		 self.Orig_country				:=	if(pInput.bs_country <> 'UNITED STATES',pInput.bs_country,'');
		 self.Orig_postal_code		:=	if(pInput.bs_country <> 'UNITED STATES',pInput.bs_zip,'');
		 self.foreign_indc	 			:=	if(pInput.bs_country <> 'UNITED STATES','Y','N');
		 self.party_type     			:=	'S';
		 self		            			:= 	pInput;
		 self											:=	[];
     END;
		 
layout_party tpDName_Address(File_ca_PersonDebtor_in pInput) 
   := 
   transform
		 self.Orig_lname					:=	pInput.pd_last_name;
		 self.Orig_fname					:=	pInput.pd_first_name;
		 self.Orig_mname					:=	pInput.pd_middle_name;
		 self.Orig_suffix					:=	pInput.pd_suffix; 
		 self.lname								:=	pInput.pd_last_name;
		 self.fname								:=	pInput.pd_first_name;
		 self.mname								:=	pInput.pd_middle_name;
		 self.name_suffix					:=	pInput.pd_suffix; 		 
		 self.Orig_address1				:=	pInput.pd_st_address;
		 self.Orig_address2				:=	if(pInput.pd_city != '',
																		 ut.CleanSpacesAndUpper(trim(pInput.pd_city) + ', ' + trim(pInput.pd_state) + ' ' + trim(pInput.pd_zip)),
																		 ut.CleanSpacesAndUpper(trim(pInput.pd_state) + ' ' + trim(pInput.pd_zip))
																			);	
		 self.Orig_city						:=	pInput.pd_city ;
		 self.Orig_state					:=	pInput.pd_state;
		 self.Orig_zip5						:=	pInput.pd_zip  ;
		 self.Orig_zip4						:=	pInput.pd_zip_extn;
		 self.Orig_country				:=	if(pInput.pd_country <> 'UNITED STATES',pInput.pd_country,'');
		 self.Orig_postal_code		:=	if(pInput.pd_country <> 'UNITED STATES',pInput.pd_zip,'');
		 self.foreign_indc	  		:=	if(pInput.pd_country <> 'UNITED STATES','Y','N');
		 self.party_type      		:=	'D';
		 self		            			:= 	pInput;
		 self											:=	[];
     END;

layout_party tpSName_Address(File_ca_PersonSecuredP_in pInput) 
   := 
   transform
         
		 self.Orig_lname					:=	pInput.ps_last_name;
		 self.Orig_fname					:=	pInput.ps_first_name;
		 self.Orig_mname					:=	pInput.ps_middle_name;
		 self.Orig_suffix					:=	pInput.ps_suffix;
		 self.lname								:=	pInput.ps_last_name;
		 self.fname								:=	pInput.ps_first_name;
		 self.mname								:=	pInput.ps_middle_name;
		 self.name_suffix					:=	pInput.ps_suffix; 		 
		 self.Orig_address1				:=	pInput.ps_st_address;
		 self.Orig_address2				:=	if(pInput.ps_city != '',
																		 ut.CleanSpacesAndUpper(trim(pInput.ps_city) + ', ' + trim(pInput.ps_state) + ' ' + trim(pInput.ps_zip)),
																		 ut.CleanSpacesAndUpper(trim(pInput.ps_state) + ' ' + trim(pInput.ps_zip))
																			);	
		 self.Orig_city						:=	pInput.ps_city;
		 self.Orig_state					:=	pInput.ps_state;
		 self.Orig_zip5						:=	pInput.ps_zip ;
		 self.Orig_zip4						:=	pInput.ps_zip_extn;
		 self.Orig_country				:=	if(pInput.ps_country <> 'UNITED STATES',pInput.ps_country,'');
		 self.Orig_postal_code		:=	if(pInput.ps_country <> 'UNITED STATES',pInput.ps_zip,'');
		 self.foreign_indc	  		:=	if(pInput.ps_country <> 'UNITED STATES','Y','N');
		 self.party_type      		:=	'S';
		 self		            			:= 	pInput;
		 self											:=	[];
     END;

UCCV2.Layout_UCC_Common.Layout_Party_with_AID tProjParty(layout_party    pInput) 
   := 
   TRANSFORM
    
	 self.rmsid											:=	'';
	 self.Tmsid											:=	'CA'+pInput.initial_filing_number;	 
	 self.dt_first_seen							:=	(unsigned6)(pInput.process_date[1..6]);
   self.dt_last_seen							:=	(unsigned6)(pInput.process_date[1..6]);
   self.dt_vendor_first_reported	:=	(unsigned6) pInput.process_date;
   self.dt_vendor_last_reported		:=	(unsigned6) pInput.process_date;
	 self														:=	pInput;
	 self														:=	[];
END;


UCCV2.Layout_UCC_Common.Layout_Party_with_AID RollupP(UCCV2.Layout_UCC_Common.Layout_Party_with_AID  pLeft,UCCV2.Layout_UCC_Common.Layout_Party_with_AID pRight)
   := TRANSFORM
	self.dt_first_seen 			   	 	:= ut.EarliestDate(	ut.EarliestDate(pLeft.dt_first_seen,pRight.dt_first_seen),
																										ut.EarliestDate(pLeft.dt_last_seen,pRight.dt_last_seen));
	self.dt_last_seen 			    	:= max(pLeft.dt_last_seen,pRight.dt_last_seen);
	self.dt_vendor_last_reported	:= max(pLeft.dt_vendor_last_reported,	pRight.dt_vendor_last_reported);
	self.dt_vendor_first_reported	:= ut.EarliestDate(pLeft.dt_vendor_first_reported,pRight.dt_vendor_first_reported);
	SELF.process_date							:= if(pleft.process_date > pright.process_date, pleft.process_date, pRight.process_date);
	self													:= pLeft;
END;
   
UCCV2.Layout_UCC_Common.Layout_Party_with_AID tIdSwitch(UCCV2.Layout_UCC_Common.Layout_Party_with_AID  pLeft, layout_rmsid_tmsid pRight)
   :=
   TRANSFORM
   self.rmsid		:=	pRight.rmsid;
   self					:=	pleft;
end;

dMain										:=  File_CA_Main_Base;
dSortmain								:=  sort(distribute(dedup(sort(project(dmain,layout_rmsid_tmsid),filing_date,rmsid),except filing_date,rmsid,all),
                                             hash(tmsid)),tmsid,local); 

dCABDebtor		         	:=	project(File_ca_BusinessDebtor_in,tBDName_Address(left));
dCABSecuredParty	     	:=	project(File_ca_BusinessSecuredparty_in,tBSName_Address(left));
dCAPDebtor						  :=  project(File_ca_PersonDebtor_in,tPDName_Address(left));
dCAPSecuredParty			  :=  project(File_ca_PersonSecuredP_in,tPSName_Address(left));

dAllBusiness						:=	dCABDebtor	+	dCABSecuredParty;
dAllPerson							:=	dCAPDebtor	+	dCAPSecuredParty;

NID.Mac_CleanFullNames(dAllBusiness, VerifyBusRecs, Orig_name, useV2:=true);

person_flags   := ['P', 'D'];
// V2 replaced the Unclassified('U') category with the Trust ('T') category, what used to be a U should become a T or I with V2.
business_flags := ['B', 'I', 'T'];

layout_party add_clean_name_business(VerifyBusRecs L) := TRANSFORM
	SELF.title        := IF(L.nametype IN person_flags, L.cln_title, '');
	SELF.fname        := IF(L.nametype IN person_flags, L.cln_fname, '');
	SELF.mname        := IF(L.nametype IN person_flags, L.cln_mname, '');
	SELF.lname        := IF(L.nametype IN person_flags, L.cln_lname, '');
	SELF.name_suffix  := IF(L.nametype IN person_flags, L.cln_suffix, '');
	SELF.company_name := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.Orig_name), '');
	SELF.name_score		:= '';

	SELF := L;
END;

NID.Mac_CleanParsedNames(dAllPerson, VerifyPersons, fname, mname, lname, name_suffix, useV2:=true);

// Because the vendor will sometimes send a company name as a person's last name only, we need to make
// sure what they sent is a person.
layout_party add_clean_name_person(VerifyPersons L) := TRANSFORM
	SELF.title        := IF(L.nametype IN person_flags, L.cln_title, '');
	SELF.fname        := IF(L.nametype IN person_flags, L.cln_fname, '');
	SELF.mname        := IF(L.nametype IN person_flags, L.cln_mname, '');
	SELF.lname        := IF(L.nametype IN person_flags, L.cln_lname, '');
	SELF.name_suffix  := IF(L.nametype IN person_flags, L.cln_suffix, '');
	SELF.company_name := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.orig_lname), '');

	SELF := L;
END;

dAll := PROJECT(VerifyBusRecs, add_clean_name_business(LEFT)) + PROJECT(VerifyPersons, add_clean_name_person(LEFT));

dNameProj   						:=  project(dAll(company_name=''), tProjParty(Left));
dNameDist		        		:=  distribute(dNameProj,  hash(tmsid,fname, mname,lname,trim(Orig_address1)));
dNameSort 			    		:=  sort(dNamedist, tmsid,fname, mname,lname,trim(Orig_address1),
																	dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
dNameDedup              :=  rollup(dNameSort ,
																	left.tmsid    			= right.tmsid 	and
																 	left.fname    			= right.fname 	and
																	left.mname    			= right.mname   and
																	left.lname  				= right.lname   and
																	left.Orig_address1	= right.Orig_address1,
																	Rollupp(left, right),  local);
												
dCnameProj   						:=  project(dAll(company_name!=''), tProjParty(Left));
dCnameDist							:=  distribute(dCnameProj ,hash(tmsid, Orig_zip5, trim(Orig_address1), trim(company_name)));
dCnameSort 							:=  sort(dCnamedist, tmsid, Orig_zip5, Orig_address1, orig_name, fein,
																	dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
dCnameDedup    					:=  rollup(	dCnameSort  ,
																		left.tmsid          = right.tmsid 				and
																		left.Orig_zip5      = right.Orig_zip5 		and
																		left.Orig_address1  = right.Orig_address1 and
																		left.company_name	  = right.company_name 	and
																		(right.fein         = '' or left.fein 		= right.fein),
																		Rollupp(left, right),
																		local);
dParty									:= 	dCnameDedup + dNameDedup;

dReassignRmsid					:=  Join(sort(distribute(dparty,hash(tmsid)),tmsid,local),
																	dSortmain ,
																	left.tmsid=right.tmsid,
																	tIdSwitch(left,right),local
																);
								
OutParty                :=  output(dReassignRmsid ,,uccv2.cluster.cluster_out+'base::UCC::Party::CA',overwrite,__compressed__);
AddSuperfile            :=  FileServices.AddSuperFile(uccv2.cluster.cluster_out+'base::UCC::Party_Name',uccv2.cluster.cluster_out+'base::UCC::Party::CA');

export proc_build_CA_party_base    :=sequential(OutParty,AddSuperfile); 
