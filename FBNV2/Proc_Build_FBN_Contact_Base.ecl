IMPORT Address, AID, DID_Add, NID, PromoteSupers, lib_stringLib;

dContactInputs  	:=ungroup(Mapping_FBN_FL_Contact)+
				                         ungroup(Mapping_FBN_CA_San_Diego_Contact)+
																 ungroup(Mapping_FBN_CA_Santa_Clara_Contact)+
														     ungroup(Mapping_FBN_TX_Harris_Contact)+
																 ungroup(Mapping_FBN_CA_Orange_Contact)+
																 ungroup(Mapping_FBN_CA_Ventura_Contact)+
																 ungroup(Mapping_FBN_Experian_Contact);	
				
dContactBase := 
        ungroup(Mapping_FBN_BUSREG_Contact)+
				FBNV2.File_FBN_Contact_Base_AID;
				                  
				
dContact := dContactInputs + dContactBase;
	
NID.Mac_CleanFullNames(dContact, cleaned_input, contact_name);

FBNv2.layout_common.contact_AID add_clean_name(cleaned_input L) := TRANSFORM
	SELF.title       					:= L.cln_title;
	SELF.fname       					:= L.cln_fname;
	SELF.mname       					:= L.cln_mname;
	SELF.lname       					:= L.cln_lname;
	SELF.name_suffix 					:= L.cln_suffix;
	SELF.contact_name_format 	:= MAP(L.nametype IN ['P', 'D'] => 'P', // Person
	                                L.nametype = 'B' => 'C',         // Company
                                  '');
	prep_line1					 			:=	trim(lib_stringLib.StringLib.StringFindReplace(l.prep_addr_line1,	'STRE ET','STREET'),left,right);
  
	self.prep_addr_line1			:=	prep_line1;																				
	
	SELF := L;
END;

dContact_cleannames := PROJECT(cleaned_input, add_clean_name(LEFT));

HasAddress	:=	trim(dContact_cleannames.prep_addr_line1, left,right) != '' and 
								trim(dContact_cleannames.prep_addr_line_last, left,right) != '';
									
dWith_address			:= dContact_cleannames(HasAddress);
dWithout_address	:= dContact_cleannames(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, RawAID, dwithAID, lFlags);
	
dContact_cln_addr := project(dwithAID,transform(
																			FBNV2.Layout_Common.contact_AID
																			,
																			self.ACEAID					:= left.aidwork_acecache.aid;
																			self.RawAID					:= left.aidwork_rawaid;
																			self.zip5						:= left.aidwork_acecache.zip5;
																			self.addr_rec_type 	:= left.aidwork_acecache.rec_type;
																			self.fips_state	   	:= left.aidwork_acecache.county[1..2];
																			self.fips_county	 	:= left.aidwork_acecache.county[3..];
																			self.cbsa				   	:= left.aidwork_acecache.msa;
																			self								:= left.aidwork_acecache;
																			self								:= left;
																		)
								) + dWithout_address; 

dContactc   :=dContact_cln_addr (fname='');
dContactp   :=dContact_cln_addr (fname<>'');
							 
matchset := ['A','Z'];

did_add.MAC_Match_Flex(dContactP 
                       ,matchset
					   ,foo
					   ,foo
					   ,fname
					   ,mname
					   ,lname
					   ,name_suffix
					   ,prim_range
					   ,prim_name
					   ,sec_range
					   ,zip5
					   ,st
					   ,contact_Phone
					   ,did
					   ,recordof(dContact )
					   ,true
					   ,did_score
					   ,75
					   ,dPostDID)

did_add.MAC_Add_SSN_By_DID(dPostDID, did, ssn, dAppendSSN, false)
 
sBDIDMatchSet		   :=	['A','F','P'];

Business_Header_SS.MAC_Add_BDID_FLEX(dContactc,
									 sBDIDMatchSet,
									 Contact_name,
									 prim_range, 
									 prim_name, 
									 zip5,
									 sec_range, 
									 st,
									 contact_Phone,
									 CONTACT_FEI_NUM,
									 BDID,
									 recordof(dContactc),
									 false,
									 BDID_Score,
								     dPostBusHdrSourceMatch);
									 
dWithBusHdrSourceMatch          := dPostBusHdrSourceMatch(BDID != 0);
dWithNoBusHdrSourceMatch        := dPostBusHdrSourceMatch(BDID = 0);

// -- Add source code so can do a source match to business headers
// -- Bug: 36599 - Business Header/Header Source code sync up 
dWithNoBusHdrSourceMatch_source := table(dWithNoBusHdrSourceMatch
	, {dWithNoBusHdrSourceMatch;string2 source := MDR.sourceTools.fFBNV2(tmsid)});

business_header.MAC_Source_Match(dWithNoBusHdrSourceMatch_source  
                                 ,dPostBDID
                                 ,false
                                 ,BDID
                                 ,true
                                 ,source     
                                 ,FALSE, corp_key
                                 ,contact_name
                                 ,prim_range
                                 ,prim_name
                                 ,sec_range
                                 ,zip5,
                                 false,foo,
								 false,foo
                                 ,FALSE, corp_key
                                );

dPostBDID_reformat := project(dPostBDID, transform(recordof(dWithNoBusHdrSourceMatch), self := left));								 

dPostDIDandBDIDPersist	:=	dWithBusHdrSourceMatch
						+   dPostBDID_reformat
						+	dAppendSSN:persist(fbnv2.cluster.cluster_out+'persist::FBNv2::Contact');
					
PromoteSupers.MAC_SF_BuildProcess(dPostDIDandBDIDPersist,fbnv2.cluster.cluster_out+'base::FBNv2::Contact',Out, 3,pCompress:=true);

export Proc_Build_FBN_Contact_Base := out;