import _Control, ProfileBooster, Doxie, UCCV2, MDR, Business_Risk_BIP, STD, TopBusiness_Services, BIPV2;
onThor := _Control.Environment.OnThor;

export V2_Key_getUCCFiling(DATASET(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim) PBslim,
							  doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

ucc_key_did := UCCV2.Key_Did_w_Type();
ucc_key_main := UCCV2.Key_Rmsid_Main();

ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_UCC append_ucc(pbslim le, ucc_key_did rt) := TRANSFORM
    SELF.UniqueID := le.seq;
	SELF.seq := le.seq;
	SELF.did := le.did;
	SELF.did2 := le.did2;
	SELF.historydate := le.historydate;
	SELF.rec_type := le.rec_type;
	SELF.party_type := rt.party_type;
	SELF.tmsid := rt.tmsid;
	SELF.rmsid := rt.rmsid;
	SELF.sourceCode := MDR.sourceTools.src_UCCv2;
	SELF := le;
	SELF := [];
END;

ucc_party_type_set := ['D','S','C','A'];

with_ucc_did_thor := JOIN(
	DISTRIBUTE(PBslim,did2), 
	DISTRIBUTE(ucc_key_did,did),
	LEFT.did2=RIGHT.did AND STD.Str.ToUpperCase(RIGHT.party_type) IN ucc_party_type_set,
	append_ucc(LEFT,RIGHT),
	KEEP(100), local);

ds_ucc_linkidskey_filtered := with_ucc_did_thor;

layout_UCC_TMSID_slim := record
    unsigned6 UniqueID;
    TopBusiness_Services.UCCSection_Layouts.rec_ids_with_linkidsdata_slimmed;
  end;
// Filter to only use recs that are not 'A'/Assignee (bug 138650) and then project onto a slimmed layout.
ds_linkids_keyrecs_slimmed := project (ds_ucc_linkidskey_filtered(party_type != 'A'),
          transform(layout_UCC_TMSID_slim,
                self.source       := MDR.sourceTools.src_UCCv2, // not needed here???
                self.role_type    := if(left.party_type = TopBusiness_Services.Constants.Debtor, //D = Debtor
                                                            TopBusiness_Services.Constants.Debtor,TopBusiness_Services.Constants.SecuredParty), //S = SecuredParty
                self              := left, // to preserve ids & other key fields being kept
			    self              := [], 
            ));
// Sort/dedup to only keep 1 record for each tmsid per set of linkids to reduce the number of key lookups when joining to the ucc main key file below.
ds_linkids_keyrecs_deduped := dedup(sort(ds_linkids_keyrecs_slimmed,
                                                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                                                                 tmsid
                                                                                     ),
                                                                      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                                                            tmsid);
set_terminated_types := ['LAPSED','L','RELEASE','EXPUNGED','DELETED',
                         'TERMINATED','TERMINATION','UCC3 TERMINATION', 'UCC-3 TERMINATION'];
layout_UCC_RMSID_slim := record
    unsigned6 UniqueID;
    TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed;
end;
// Get RMSID records
ds_uccmain_keyrecs := join(ds_linkids_keyrecs_deduped,UCCV2.Key_Rmsid_Main(),
                               keyed(left.tmsid = right.tmsid), //get all recs for the tmsids
      transform(layout_UCC_RMSID_slim,
            temp_status_type           := StringLib.StringToUpperCase(right.status_type);
            temp_filing_type           := StringLib.StringToUpperCase(right.filing_type);
            self.orig_filing_number    := if(right.orig_filing_number != '',
                                             right.orig_filing_number,right.filing_number),
            self.status_type           := temp_status_type,
            self.filing_type           := temp_filing_type,
            self.status_code           := if(temp_status_type in set_terminated_types or
                                                   temp_filing_type in set_terminated_types,
                                                                             TopBusiness_Services.Constants.TERMINATED,TopBusiness_Services.Constants.ACTIVE
                                                                             );
            self := right,  // to pull off the ucc main key fields we want
            self := left,   // to preserve ids & other(?) kept linkids key fields ???
    ),
        left outer,
        limit(10000,skip) // needed because of bad/generic tmsid=DNB, see bug 148946
     );
     
ds_ucc_RMSID_filtered := JOIN(ds_uccmain_keyrecs,PBslim,
                              LEFT.UniqueID=RIGHT.seq AND
                              (UNSIGNED)(((STRING8)LEFT.orig_filing_date)[1..8]) <= (UNSIGNED)(((STRING8)RIGHT.HistoryDate)[1..8]),
                              TRANSFORM(RECORDOF(LEFT), SELF := LEFT;));

ds_ucc_RMSID_dedup := dedup(sort(ds_ucc_RMSID_filtered, UniqueID, TMSID, -status_code), UniqueID, TMSID);
table_UCC_counts    := table(ds_ucc_RMSID_dedup, {UniqueID, bus_UCC_count := count(group), bus_UCC_active_count := count(group, status_code = 'A')}, UniqueID); //count total UCC filings and active UCC filings

integerNeg1 := -1;
integerNeg2 := -2;
	
WithUCCFilings := JOIN(PBslim, table_UCC_counts, LEFT.Seq = RIGHT.UniqueID,
                     TRANSFORM(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_UCC,
                       SELF.BusUCCFilingCntEv     := IF(RIGHT.UniqueID>0,RIGHT.bus_UCC_count,-99998);
                       SELF.BusUCCFilingActiveCnt := IF(RIGHT.UniqueID>0,RIGHT.bus_UCC_active_count,-99998);
                       SELF := LEFT;
					   SELF := []),
                    LEFT OUTER, KEEP(1), ATMOST(100), FEW);

return WithUCCFilings;

end;