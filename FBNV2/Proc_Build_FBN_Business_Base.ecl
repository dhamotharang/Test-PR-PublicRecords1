import address,fbnv2, did_add, didville,ut,header_slimsort,UCCV2,business_header,Business_Header_SS,watchdog;

dBusiness   :=  ungroup(Mapping_FBN_CA_Orange_Business)+
				ungroup(Mapping_FBN_CA_San_Bernardino_Business)+
				ungroup(Mapping_FBN_CA_San_Diego_Business)+
				ungroup(Mapping_FBN_CA_Santa_Clara_Business)+
				ungroup(Mapping_FBN_CA_Ventura_Business)+
				ungroup(Mapping_FBN_FL_Business)+
				ungroup(Mapping_FBN_InfoUSA_Business)+
				ungroup(Mapping_FBN_NY_Business)+
				ungroup(Mapping_FBN_TX_Harris_Business)+
				ungroup(Mapping_FBN_TXD_Business);

business_header.MAC_Source_Match(dBusiness
                                 ,dPostBusHdrSourceMatch
                                 ,false
                                 ,BDID
                                 ,false
                                 ,'F'     
                                 ,FALSE, corp_key
                                 ,Bus_name
                                 ,prim_range
                                 ,prim_name
                                 ,sec_range
                                 ,zip5,
                                  TRUE, 
								  BUS_PHONE_NUM,
								  TRUE, 
								  Orig_fein,
								  FALSE, corp_key
                                );
                                
                               
dWithBusHdrSourceMatch          := dPostBusHdrSourceMatch(BDID != 0);
dWithNoBusHdrSourceMatch        := dPostBusHdrSourceMatch(BDID = 0);


sBDIDMatchSet		   :=	['A','F','P'];

Business_Header_SS.MAC_Add_BDID_FLEX(dWithNoBusHdrSourceMatch ,
									 sBDIDMatchSet,
									 Bus_name,
									 prim_range, 
									 prim_name, 
									 zip5,
									 sec_range, 
									 st,
									 BUS_PHONE_NUM,
									 orig_fein,
									 BDID,
									 recordof(dWithNoBusHdrSourceMatch),
									 false,
									 BDID_Score,
								     dPostBDID);
								 

dPostDIDandBDIDPersist	:=	dWithBusHdrSourceMatch
						+   dPostBDID:persist(cluster.cluster_out+'persist::FBNv2::Business');
					
ut.MAC_SF_BuildProcess(dPostDIDandBDIDPersist,cluster.cluster_out+'base::FBNv2::Business',Out, 2);

export  Proc_Build_FBN_Business_Base     :=	Out;