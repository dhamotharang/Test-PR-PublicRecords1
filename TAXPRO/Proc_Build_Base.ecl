IMPORT  did_add, ut, business_header, business_header_ss;

Layout.Taxpro_standard_base Trans(Layout.Taxpro_base Pinput)
   :=Transform
     Self.name:=pinput;
	 Self.name:=[];
	 Self.Addr.addr_suffix:=pInput.suffix;
	 Self.Addr.fips_state:=pInput.ace_fips_st;
	 self.Addr.fips_county:=pInput.ace_fips_county;
	 Self.addr.cbsa:=pInput.msa;
	 self.addr.addr_rec_type:=pInput.rec_type;
	 self.addr:=pInput;
	 self.addr:=[];
	 self:=pinput;
	 end;

dIn:=Mapping_IRS_Enrolled_Agent+Mapping_Practitioner;


matchset := ['A','Z'];

did_add.MAC_Match_Flex(dIn
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
					   ,''
					   ,did
					   ,recordof(dIn )
					   ,true
					   ,did_score
					   ,75
					   ,dPostDID)

did_add.MAC_Add_SSN_By_DID(dPostDID, did, ssn, dAppendSSN, false)
dInC                   := dAppendSSN(company<>'');
sBDIDMatchSet		   := ['A'];

Business_Header_SS.MAC_Add_BDID_FLEX(dInC ,
									 sBDIDMatchSet,
									 company,
									 prim_range,
									 prim_name,
									 zip5,
									 sec_range,
									 st,
									 foo,
									 foo,
									 BDID,
									 recordof(dInC ),
									 false,
									 BDID_Score,
								     dPostBusHdrSourceMatch);

dWithBusHdrSourceMatch          := dPostBusHdrSourceMatch(BDID != 0);
dWithNoBusHdrSourceMatch        := dPostBusHdrSourceMatch(BDID = 0);

business_header.MAC_Source_Match(dWithNoBusHdrSourceMatch
                                 ,dPostBDID
                                 ,false
                                 ,BDID
                                 ,false
                                 ,'Ta'
                                 ,FALSE, corp_key
                                 ,company
                                 ,prim_range
                                 ,prim_name
                                 ,sec_range
                                 ,zip5,
                                 false,foo,
								 false,foo
                                 ,FALSE, corp_key
                                );

dPostDIDandBDIDPersist	:=	dWithBusHdrSourceMatch
						+   dPostBDID
						+	dAppendSSN(company='');
dStandard               :=project(dPostDIDandBDIDPersist,trans(left)):persist(cluster.cluster_out+'persist::base::taxpro');


export Proc_Build_Base :=dStandard   ;
