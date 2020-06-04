export ExtractCompanyOrgStructure(in_header) := functionmacro

	orgStructureCodeTypes := enum(
                                                 corp
                                                ,bCorp
									   ,cCorp
									   ,cooperative
									   ,nonProfitCorp
									   ,sCorp
									   ,government
									   ,localGovern
									   ,stateGovern
									   ,LLC
									   ,nonProfitLLC
									   ,professional
									   ,partnership
									   ,general
									   ,limited
									   ,LLP
									   ,proprietorship
									   ,trust
									   ,UNKNOWN=99
	                              );
							
     SlimRec := record
	     in_header.seleid;
	     in_header.dt_last_seen;
		string20  org_structure;
		string20  org_sub_structure;
		unsigned2 orgStructureCode;
		integer   orgStructureCount;
	end;
							
     createStructures   := project(in_header,
                                   transform(SlimRec,
	     					          self.org_structure     := map(
								                                  left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.corpRawSet            => 'CORPORATION'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.governRawSet          => 'GOVERNMENT'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.llcRawSet             => 'LLC'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.partnerRawSet         => 'PARTNERSHIP'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.propRawSet            => 'PROPRIETORSHIP'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.trustRawSet           => 'TRUST'
								                                 ,left.company_org_structure_derived in BIPV2_Segmentation.OrgStructureMaps.corporationDerivedSet => 'CORPORATION'
								                                 ,left.company_org_structure_derived in BIPV2_Segmentation.OrgStructureMaps.llcDerivedSet         => 'LLC'
								                                 ,left.company_org_structure_derived in BIPV2_Segmentation.OrgStructureMaps.propDerivedSet        => 'PROPRIETORSHIP'
								                                 ,left.company_org_structure_derived in BIPV2_Segmentation.OrgStructureMaps.partnerDerivedSet     => 'PARTNERSHIP'
								                                 ,''
													         ),
						               self.org_sub_structure := map(
								                                  left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.bCorpRawSet          => 'B-CORP'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.cCorpRawSet          => 'C-CORP'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.coopRawSet           => 'COOPERATATIVE'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.genPartRawSet        => 'GENERAL'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.llPRawSet            => 'LLP'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.limPartRawSet        => 'LIMITED'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.localGovRawSet       => 'LOCAL'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.nonProfitRawSet      => 'NONPROFIT'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.pLLCRawSet           => 'PROFESSIONAL'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.sCorpRawSet          => 'S-CORP'
								                                 ,left.company_org_structure_raw     in BIPV2_Segmentation.OrgStructureMaps.stateGovRawSet       => 'STATE'
								                                 ,left.company_org_structure_derived in BIPV2_Segmentation.OrgStructureMaps.nonProfitDerivedSet  => 'NONPROFIT'
								                                 ,left.company_org_structure_derived in BIPV2_Segmentation.OrgStructureMaps.limPartnerDerivedSet => 'LIMITED'
								                                 ,''
													         ),
                                             self.orgStructureCode   := map(
									                              self.org_structure = 'CORPORATION'    and self.org_sub_structure = ''              => orgStructureCodeTypes.corp
									                             ,self.org_structure = 'CORPORATION'    and self.org_sub_structure = 'B-CORP'        => orgStructureCodeTypes.bCorp
									                             ,self.org_structure = 'CORPORATION'    and self.org_sub_structure = 'C-CORP'        => orgStructureCodeTypes.cCorp
									                             ,self.org_structure = 'CORPORATION'    and self.org_sub_structure = 'COOPERATATIVE' => orgStructureCodeTypes.cooperative
									                             ,self.org_structure = 'CORPORATION'    and self.org_sub_structure = 'NONPROFIT'     => orgStructureCodeTypes.nonProfitCorp
									                             ,self.org_structure = 'CORPORATION'    and self.org_sub_structure = 'S-CORP'        => orgStructureCodeTypes.sCorp
									                             ,self.org_structure = 'GOVERNMENT'     and self.org_sub_structure = ''              => orgStructureCodeTypes.government
									                             ,self.org_structure = 'GOVERNMENT'     and self.org_sub_structure = 'LOCAL'         => orgStructureCodeTypes.localGovern
									                             ,self.org_structure = 'GOVERNMENT'     and self.org_sub_structure = 'STATE'         => orgStructureCodeTypes.stateGovern
									                             ,self.org_structure = 'LLC'            and self.org_sub_structure = ''              => orgStructureCodeTypes.LLC
									                             ,self.org_structure = 'LLC'            and self.org_sub_structure = 'NONPROFIT'     => orgStructureCodeTypes.nonProfitLLC
									                             ,self.org_structure = 'LLC'            and self.org_sub_structure = 'PROFESSIONAL'  => orgStructureCodeTypes.professional
									                             ,self.org_structure = 'PARTNERSHIP'    and self.org_sub_structure = ''              => orgStructureCodeTypes.partnership
									                             ,self.org_structure = 'PARTNERSHIP'    and self.org_sub_structure = 'GENERAL'       => orgStructureCodeTypes.general
									                             ,self.org_structure = 'PARTNERSHIP'    and self.org_sub_structure = 'LIMITED'       => orgStructureCodeTypes.limited
									                             ,self.org_structure = 'PARTNERSHIP'    and self.org_sub_structure = 'LLP'           => orgStructureCodeTypes.LLP
									                             ,self.org_structure = 'PROPRIETORSHIP' and self.org_sub_structure = ''              => orgStructureCodeTypes.proprietorship
									                             ,self.org_structure = 'TRUST'          and self.org_sub_structure = ''              => orgStructureCodeTypes.trust
									                             ,orgStructureCodeTypes.UNKNOWN 
									                              );
									self.orgStructureCount  := 1,						
								     self := left));	
     
 
     sortByStruct := group(sort(distribute(createStructures, hash32(seleid)), seleid, orgStructureCode, -dt_last_seen,local),seleid, orgStructureCode,local);
	
	countStructs := rollup(sortByStruct,
	                       true,
					   transform(SlimRec,
					             self.orgStructureCount := left.orgStructureCount + 1,
							   self := left));
							   
	sortByCriteria := sort(ungroup(countStructs), seleid, -dt_last_seen, -orgStructureCount, local);
	
	dedupBySeleid  := dedup(sortByCriteria, seleid, all, hash);
	
     return dedupBySeleid(orgStructureCode!=orgStructureCodeTypes.UNKNOWN);
endmacro;