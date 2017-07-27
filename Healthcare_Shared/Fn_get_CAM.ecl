Import MPRD;
EXPORT Fn_get_CAM := MODULE
		Export getCAMData(dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) baseIndvRecs, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function

			//Get CAM table records and add them to the base.
			normNPI:=dedup(sort(NORMALIZE(baseIndvRecs, LEFT.RecordsRaw(filecode[1..3] = 'NPI' and npi_num<>''), TRANSFORM({string20 acctno,unsigned6 internalID,unsigned6 lnpid,unsigned6 lnfid,string40 vendor_id,string10 npi_num,boolean srcIndividualHeader}, 
				self.acctno:=left.acctno;
				self.internalID:=left.internalID;
				self.lnpid:=left.lnpid;
				self.lnfid:=left.lnfid;
				self.vendor_id := left.vendorid;
				self.srcIndividualHeader := left.srcIndividualHeader;
				SELF := RIGHT)),acctno,internalID,npi_num),acctno,internalID,npi_num);
			rawCAMdataIndividualbyNpiRendering:= join(normNpi, mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).claims_addr_master_rendering_npi_key.QA,
											keyed(left.npi_num = right.rendering_npi) and right.isTest = cfg[1].UseQATestRecs,
											transform(Healthcare_Shared.Layouts.mprd_cam_base_with_cbm,
																		keepRecord := map (left.srcIndividualHeader and cfg[1].CastCAMPerson => true,
																											 not left.srcIndividualHeader and cfg[1].CastCAMEntity => true,
																											 false);
																		self.acctno := if(keepRecord,left.acctno,skip);
																		self.internalID:=left.internalID;
																		self.lnpid:=left.lnpid;
																		self.lnfid:=left.lnfid;
																		self.vendor_id:=left.vendor_id;
																		self:=right,
																		self:=left,self:=[]),
											keep(2*Healthcare_Shared.Constants.MAX_DID_RECS), limit(0));
			rawCAMdataIndividualbyNpiBill:= join(normNpi, mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).claims_addr_master_bill_npi_key.QA,
											keyed(left.npi_num = right.bill_npi) and right.isTest = cfg[1].UseQATestRecs,
											transform(Healthcare_Shared.Layouts.mprd_cam_base_with_cbm,
																		keepRecord := map (left.srcIndividualHeader and cfg[1].CastCAMPerson => true,
																											 not left.srcIndividualHeader and cfg[1].CastCAMEntity => true,
																											 false);
																		self.internalID:=left.internalID;
																		self.lnpid:=left.lnpid;
																		self.lnfid:=left.lnfid;
																		self.vendor_id:=left.vendor_id;
																		self:=right,
																		self:=left,self:=[]),
											keep(2*Healthcare_Shared.Constants.MAX_DID_RECS), limit(0));
			rawCAMdataIndividualbyNpi := rawCAMdataIndividualbyNpiRendering+rawCAMdataIndividualbyNpiBill;

//			baseCAMRecs := project(sort(rawCAMdataIndividualbyNpi,acctno,internalid),Healthcare_Shared.Transforms_MPRD.build_mprd_CAM_base(left,cfg[1].MixedCaseOutput));//may need to pass cfg into transform			
			rawCAMdataIndividualWithCBM := join(rawCAMdataIndividualbyNpi(rendering_npi<>''), mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).claims_by_month_rendering_npi_key.QA,
											keyed(left.rendering_npi=right.rendering_npi) and left.addr_key=right.addr_key and left.bill_npi=right.bill_npi and left.bill_tin=right.bill_tin and right.isTest = cfg[1].UseQATestRecs,
											transform(Healthcare_Shared.Layouts.mprd_cam_base_with_cbm,
																		self.cbm1:=(integer)right.cbm1;
																		self.cbm3:=(integer)right.cbm3;
																		self.cbm6:=(integer)right.cbm6;
																		self.cbm12:=(integer)right.cbm12;
																		self.cbm18:=(integer)right.cbm18;
																		self:=left;
																		self:=[]), left outer,
											keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));

			rollupCAMdataIndividualWithCBM:=rollup(sort(rawCAMdataIndividualWithCBM,acctno,internalid,rendering_npi,addr_key,bill_npi,bill_tin,type_bill,place_service),transform(Healthcare_Shared.Layouts.mprd_cam_base_with_cbm,
																		self.addr_usage:=(string11)(((unsigned1)left.addr_usage)|((unsigned1)right.addr_usage));
																		self.earliest_clm_date:=if(left.earliest_clm_date<right.earliest_clm_date,left.earliest_clm_date,right.earliest_clm_date);
																		self.latest_clm_date:=if(left.latest_clm_date>right.latest_clm_date,left.latest_clm_date,right.latest_clm_date);
																		self.cbm1:=left.cbm1;// + right.cbm1;
																		self.cbm3:=left.cbm3;// + right.cbm3;
																		self.cbm6:=left.cbm6;// + right.cbm6;
																		self.cbm12:=left.cbm12;// + right.cbm12;
																		self.cbm18:=left.cbm18;// + right.cbm18;
																		self:=left),acctno,internalid,rendering_npi,addr_key,bill_npi,bill_tin,type_bill,place_service);
			baseCAMRecs := project(rollupCAMdataIndividualWithCBM,Healthcare_Shared.Transforms_MPRD.build_mprd_CAM_base(left,cfg[1].MixedCaseOutput));//may need to pass cfg into transform

			return baseCAMRecs;
		end;
end;