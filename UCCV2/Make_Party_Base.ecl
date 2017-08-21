import address, did_add, didville,ut,header_slimsort,UccV2,business_header,Business_Header_SS,header, promoteSupers, std;

outcA :=proc_build_CA_party_base;
OutDNB:=proc_build_DNB_party_base;
OutIL :=proc_build_IL_party_base;
OutMA :=proc_build_MA_party_base;
OutNYC:=proc_build_NYC_party_base;
OutTX :=proc_build_TX_party_base;
OutTH :=proc_build_Harris_TX_party_base;
OutWA :=proc_build_WA_party_base;

oCA :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccv2::CA::initialfiling')>0),outCA,output('no new data in CA'));
oDnB:=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::dnb::financingStatement')>0),outDNB,output('no new data in DnB'));
oIL :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::IL::filing')>0),outIL,output('no new data in IL'));
oMA :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::MA')>0),outMA,output('no new data in MA'));
oNYC:=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::NYC::master')>0),outNYC,output('no new data in NYC'));
oTX :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::Tx::Filing ')>0),outTX,output('no new data in TX'));
oTH :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::TH ')>0),outTH,output('no new data in TH'));
oWA :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::WA')>0),outWA,output('no new data in WA'));

pboolean_value := if (header.IsNewProdHeaderVersion('uccv2') and (ut.Weekday((integer)(STRING8)Std.Date.Today()) = 'SATURDAY' or ut.Weekday((integer)(STRING8)Std.Date.Today()) = 'SUNDAY'),
											true,false) : stored('pboolean_value');

bboolean_value := if (header.IsNewProdHeaderVersion('uccv2','bheader_file_version') and (ut.Weekday((integer)(STRING8)Std.Date.Today()) = 'SATURDAY' or ut.Weekday((integer)(STRING8)Std.Date.Today()) = 'SUNDAY'),
											true,false) : stored('bboolean_value');
											
bipboolean_value := if (header.IsNewProdHeaderVersion('uccv2','bip_build_version') and (ut.Weekday((integer)(STRING8)Std.Date.Today()) = 'SATURDAY' or ut.Weekday((integer)(STRING8)Std.Date.Today()) = 'SUNDAY'),
											true,false) : stored('bipboolean_value');
											
boolean_value := if (pboolean_value or bboolean_value or bipboolean_value, true, false);


dCombine:=   if (boolean_value,
  									Proc_Build_UCC_Party_Base(boolean_value),
										Proc_Build_UCC_Party_Base(boolean_value)+File_UCC_Party_Base_AID
  								);

Layout_UCC_Common.Layout_Party_with_AID RollupP(dCombine pleft, dCombine pright) :=  TRANSFORM
  self.dt_first_seen 			    	  := ut.EarliestDate(ut.EarliestDate(pLeft.dt_first_seen,pRight.dt_first_seen),
	                                   ut.EarliestDate(pLeft.dt_last_seen,pRight.dt_last_seen));
	self.dt_last_seen 			    		:= max(pLeft.dt_last_seen,pRight.dt_last_seen);
	self.dt_vendor_last_reported		:= max(pLeft.dt_vendor_last_reported,	pRight.dt_vendor_last_reported);
	self.dt_vendor_first_reported   := ut.EarliestDate(pLeft.dt_vendor_first_reported,pRight.dt_vendor_first_reported);
	self.process_date 			    		:= if(pleft.process_date > pright.process_date, pleft.process_date, pRight.process_date);
	self.source_rec_id							:= if(pleft.source_rec_id <> 0,pleft.source_rec_id,pRight.source_rec_id);
	self 													  := pleft;
end;

dCombineSort						:=  sort(distribute(dcombine ,hash(rmsid,tmsid,zip5, trim(prim_name), trim(prim_range), trim(company_name))),
										     rmsid,tmsid,zip5, prim_range, prim_name, company_name,sec_range,fein,party_type,
							                dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);


dFinal       						:=  rollup(dCombineSort  ,
												left.rmsid          = right.rmsid 			and
												left.tmsid          = right.tmsid 	        and
												left.zip5           = right.zip5 			and
												left.prim_name      = right.prim_name 		and
												left.prim_range 	= right.prim_range 		and
												left.company_name   = right.company_name 	and
												left.orig_name  	= right.orig_name       and
												left.party_type  	= right.party_type      and
												left.orig_fname  	= right.orig_fname      and
												left.orig_lname  	= right.orig_lname      and
												left.fname  	    = right.fname      and
												left.lname  	    = right.lname      and
											 	(right.sec_range    = '' or left.sec_range 	= right.sec_range) 	and
												(right.fein         = '' or left.fein 		= right.fein),
												Rollupp(left, right),
												local);
Done:=parallel(
								OCA
								,oDnB
								,oIL
								,oMA
								,ONYC
								,oTX
								,oTH
								,oWA
								);

ut.MAC_Append_Rcid (dFinal,source_rec_id,out_file);
AddRecordID := uccv2.fnAddPersistentRecordID_Party(out_file);
promoteSupers.MAC_SF_BuildProcess(AddRecordID,UCCV2.cluster.cluster_out+'base::UCC::Party_AID',OutParty, 2,,true);

 export Make_Party_Base := sequential(
   																		Done,
   																		IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::base::ucc::party_name')>0),
   																						OutParty,
   																						output('No change')
   																				),
   																		if (boolean_value or bboolean_value,
   																					sequential(
   																						header.PostDID_HeaderVer_Update('uccv2'),
   																						header.PostDID_HeaderVer_Update('uccv2','bheader_file_version'),
   																						header.PostDID_HeaderVer_Update('uccv2','bip_build_version'),
   																						output('Full re-did was successful')
   																						),
   																		output('Daily re-did was successful'))
   																		);

									  