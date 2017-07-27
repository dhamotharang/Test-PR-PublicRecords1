import address, did_add, didville,ut,header_slimsort,FBNV2,business_header,Business_Header_SS,watchdog;

dContact  	:=  ungroup(Mapping_FBN_CA_Orange_Contact)+
				ungroup(Mapping_FBN_CA_San_Bernardino_Contact)+
				ungroup(Mapping_FBN_CA_San_Diego_Contact)+
				ungroup(Mapping_FBN_CA_Santa_Clara_Contact)+
				ungroup(Mapping_FBN_CA_Ventura_Contact)+
				ungroup(Mapping_FBN_FL_Contact)+
				ungroup(Mapping_FBN_InfoUSA_Contact)+
				ungroup(Mapping_FBN_NY_Contact)+
				ungroup(Mapping_FBN_TX_Harris_Contact)+
				ungroup(Mapping_FBN_TXD_Contact);

dContactc   :=dContact (fname='');
dContactp   :=dContact (fname<>'');
							 
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
 
business_header.MAC_Source_Match(dContactc 
                                 ,dPostBusHdrSourceMatch
                                 ,false
                                 ,BDID
                                 ,false
                                 ,'F2'     
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
                                
                               
dWithBusHdrSourceMatch          := dPostBusHdrSourceMatch(BDID != 0);
dWithNoBusHdrSourceMatch        := dPostBusHdrSourceMatch(BDID = 0);




sBDIDMatchSet		   :=	['A','F','P'];

Business_Header_SS.MAC_Add_BDID_FLEX(dWithNoBusHdrSourceMatch ,
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
									 recordof(dWithNoBusHdrSourceMatch),
									 false,
									 BDID_Score,
								     dPostBDID);
								 

dPostDIDandBDIDPersist	:=	dWithBusHdrSourceMatch
						+   dPostBDID
						+	dAppendSSN:persist(cluster.cluster_out+'persist::FBNv2::Contact');
						
 
					
ut.MAC_SF_BuildProcess(dPostDIDandBDIDPersist,cluster.cluster_out+'base::FBNv2::Contact',Out, 2);
//ut.MAC_SF_Build_standard(dPostDIDandBDIDPersist,cluster.cluster_out+'base::FBNv2::Contact',out,ut.GetDate);


export Proc_Build_FBN_Contact_Base := out;