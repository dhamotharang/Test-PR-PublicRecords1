IMPORT Address, NID, UCCV2, ut; 

layout_party	:=	record
	string8		process_date;
	string17	Unique_Key;
	string1		record_type;
	string1		Party_type;
	string70	Name;
	string60	Addr1;
	string60	Addr2;
	string2		Country;
	string30	City;
	string2		State;
	string9		Zip;
	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	string3		name_score;
	string60	company_name;
	string100	prep_addr_line1;
	string50	prep_addr_last_line; 
	unsigned8	RawAid	:= 0;
	unsigned8	ACEAID	:= 0;		
end;

NID.Mac_CleanFullNames(UCCV2.File_NYC_Party_in, VerifyRecs, name, useV2:=true);

person_flags   := ['P', 'D'];
// V2 replaced the Unclassified('U') category with the Trust ('T') category, what used to be a U should become a T or I with V2.
business_flags := ['B', 'I', 'T'];

layout_party trfCleanName(VerifyRecs L) := TRANSFORM
	SELF.title        := IF(L.nametype IN person_flags, L.cln_title, '');
	SELF.fname        := IF(L.nametype IN person_flags, L.cln_fname, '');
	SELF.mname        := IF(L.nametype IN person_flags, L.cln_mname, '');
	SELF.lname        := IF(L.nametype IN person_flags, L.cln_lname, '');
	SELF.name_suffix  := IF(L.nametype IN person_flags, L.cln_suffix, '');
	SELF.company_name := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.name), '');

	SELF := L;
	SELF := [];
END;

cleanedNameRecs := PROJECT(VerifyRecs, trfCleanName(LEFT));

UCCV2.Layout_UCC_Common.Layout_Party_with_AID tProjParty(layout_party  pInput) := TRANSFORM
	self.orig_name								:=  pInput.Name;
	self.orig_address1						:=  pInput.Addr1;
	self.orig_address2						:=  pInput.Addr2;
	self.orig_city								:=  pInput.City;
	self.orig_state								:=  pInput.State;
	self.orig_zip5								:=  pInput.Zip;
	self.orig_country							:=  pInput.Country;
	self.orig_postal_code					:=  pInput.Zip; 
	self.party_type								:=  case(pInput.party_type,
																				'1'=>'D',
																				'2'=>'S',
																				'3'=>'A',
																				''
																				);
	self.tmsid										:= 	'';
	self.rmsid										:=  pInput.Unique_Key;	 
	self.dt_first_seen						:=  (unsigned6)(pInput.process_date[1..6]);
	self.dt_last_seen							:=  (unsigned6)(pInput.process_date[1..6]);
	self.dt_vendor_first_reported	:=  (unsigned6) pInput.process_date;
	self.dt_vendor_last_reported	:=  (unsigned6) pInput.process_date;
	self													:=	pInput;
	self													:=	[];
END;

layout_rmsid_tmsid :=	record
	Layout_UCC_Common.layout_ucc.rmsid;
	Layout_UCC_Common.layout_ucc.tmsid;
end;

UCCV2.Layout_UCC_Common.Layout_Party_with_AID tIdSwitch(UCCV2.Layout_UCC_Common.Layout_Party_with_AID  pLeft, layout_rmsid_tmsid pRight)
   :=
   TRANSFORM
   self.tmsid		:=pRight.tmsid;
   self					:=pleft;
   end;
   
UCCV2.Layout_UCC_Common.Layout_Party_with_AID RollupP(UCCV2.Layout_UCC_Common.Layout_Party_with_AID  pLeft,UCCV2.Layout_UCC_Common.Layout_Party_with_AID pRight) 
   := 
   TRANSFORM
	self.dt_first_seen 			    	:= ut.EarliestDate(	ut.EarliestDate(pLeft.dt_first_seen,pRight.dt_first_seen),
																										ut.EarliestDate(pLeft.dt_last_seen,pRight.dt_last_seen));
	self.dt_last_seen 			    	:= max(pLeft.dt_last_seen,pRight.dt_last_seen);
	self.dt_vendor_last_reported	:= max(pLeft.dt_vendor_last_reported,	pRight.dt_vendor_last_reported);
	self.dt_vendor_first_reported	:= ut.EarliestDate(pLeft.dt_vendor_first_reported,pRight.dt_vendor_first_reported);
	SELF.process_date							:= if(pleft.process_date > pright.process_date, pleft.process_date, pRight.process_date);
	self													:= pLeft;
END;
   
dMain											:=  DATASET(cluster.cluster_out+'base::ucc::main::nyc',Layout_UCC_Common.Layout_ucc_new , thor);
dSortmain									:=  sort(distribute(DEDUP(PROJECT(dmain,layout_rmsid_tmsid),all),hash(rmsid)),rmsid, local);

dNameProj   							:=  project(cleanedNameRecs(company_name=''), tProjParty(Left));
dNameDist		        			:=  distribute(dNameProj,  hash(rmsid,fname, mname,lname,trim(orig_address1)));
dNameSort 			    			:=  sort(	dNamedist, rmsid,fname, mname,lname,trim(orig_address1),
																		dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local
																	 );
dNameDedup								:= rollup(dNameSort ,
																		left.rmsid    			= right.rmsid 	and
																		left.fname    			= right.fname 	and
																		left.mname   			 	= right.mname   and
																		left.lname  				= right.lname   and
																		left.orig_address1	= right.orig_address1,
																		Rollupp(left, right),  local
																		);

dCnameProj   							:= project(cleanedNameRecs(company_name!=''), tProjParty(Left));
dCnameDist								:= distribute(dCnameProj ,hash(rmsid,orig_zip5, trim(orig_address1),trim(company_name)));
dCnameSort 								:= sort(dCnamedist, rmsid,orig_zip5, orig_address1, company_name,fein,
																	dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local
																	);
dCnameDedup    						:= rollup(dCnameSort  ,
																		left.rmsid          = right.rmsid 				and
																		left.orig_zip5     	= right.orig_zip5 		and
																		left.orig_address1  = right.orig_address1	and
																		left.company_name   = right.company_name 	and
																		(right.fein         = '' or left.fein 		= right.fein),
																		Rollupp(left, right),
																		local
																		);

dpartyOut							:= dCnameDedup+dnameDedup;
					
dPartyJoin         			:= Join(sort(distribute(dpartyOut,hash(rmsid)),rmsid,local)
											,dSortmain ,left.rmsid=right.rmsid,tIdSwitch(left,right),local);
											
								  

OutParty                :=  output(dPartyJoin  ,,UCCV2.cluster.cluster_out+'base::UCC::Party::NYC',overwrite,__compressed__);
AddSuperfile            :=  FileServices.AddSuperFile(UCCV2.cluster.cluster_out+'base::UCC::Party_Name',UCCV2.cluster.cluster_out+'base::UCC::Party::NYC');

export proc_build_NYC_party_base    :=sequential(OutParty,AddSuperfile); 