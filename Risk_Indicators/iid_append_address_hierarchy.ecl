import _Control, header, riskwise, address, ut, mdr;
onThor := _Control.Environment.OnThor;

EXPORT iid_append_address_hierarchy(GROUPED DATASET(risk_indicators.iid_constants.layout_outx) allheader , boolean isFCRA, integer bsversion) := FUNCTION

hierarchy_key := header.key_addr_hist(isFCRA); 

just_dids_roxie := table(allheader(did<>0), {did}, did);

just_dids_thor := table(distribute(allheader(did<>0), hash64(did)), {did}, did, LOCAL);

#IF(onThor)
	just_dids := just_dids_thor;
#ELSE
	just_dids := just_dids_roxie;
#END

addr_history_data_roxie := join(just_dids, hierarchy_key, 
	keyed(left.did=right.s_did), 
	transform(recordof(hierarchy_key), self := right), atmost(riskwise.max_atmost));
	
addr_history_data_thor := join(distribute(just_dids, hash64(did)), 
	distribute(pull(hierarchy_key), hash64(s_did)), 
	(left.did=right.s_did), 
	transform(recordof(hierarchy_key), self := right), atmost(riskwise.max_atmost), LOCAL);

#IF(onThor)
	addr_history_data := addr_history_data_thor;
#ELSE
	addr_history_data := addr_history_data_roxie;
#END

layout_temp := record
	unsigned record_seq;  // for deduping after join to key_addr_hist, fix issue with ut.nneq join
	risk_indicators.iid_constants.layout_outx;
end;	

allheader_temp := project(allheader, transform(layout_temp, self.record_seq := counter, self := left, self := []));

layout_temp append_hierarchy(allheader_temp le, addr_history_data rt) := transform
	//temporary solution to flag addresses that are found on only 1 record across the board.
	// testing this out to see if it helps.  
	// if we like this, we'll consider adding a new field to the address hiearchy layout next year instead of using position 5 of addressstatus
	single_instance_address := rt.addressstatus[5]='S';

	addr1 := address.Addr1FromComponents(rt.prim_range,rt.predir,rt.prim_name,rt.suffix,rt.postdir,rt.unit_desig,rt.sec_range);
	// override the sequence number in the hierarchy table for records which are PO Boxes, blank zip4, 
	// single sourced bureau inquiry records, or addresses which don't have insurance/utility/vehicle/voter/dl/property footprint
	address_history_seq := map(
																	rt.address_history_seq  in [0,91,92,93,94,95,96,97,98,99] or rt.addresstype='BUS' => 255,
																	risk_indicators.iid_constants.override_addr_type(addr1, '','')='P' => 255,
																	le.chronozip4='' => 255,
																	rt.source_count=1 and single_instance_address => 255,													
																	rt.source_count=1 and le.src in 
																	[mdr.sourcetools.src_Equifax,	mdr.sourcetools.src_Experian_Credit_Header,	mdr.sourcetools.src_TransUnion,
																	mdr.sourcetools.src_TUCS_Ptrack, mdr.sourcetools.src_TU_CreditHeader,	mdr.sourcetools.src_Lexis_Trans_Union] => 255,
																	rt.address_history_seq);	  // leave it as is by default																

	self.address_history_seq := address_history_seq;
	
	garbage_addr := address_history_seq=255;
	
	self.addr_from_did := if(garbage_addr, '', le.addr_from_did);
	self.addrs_per_adl := if(garbage_addr, 0, le.addrs_per_adl);
	self.addrs_per_adl_created_6months := if(garbage_addr, 0, le.addrs_per_adl_created_6months);
	self.addrs_last_5years := if(garbage_addr, 0, le.addrs_last_5years);							
	self.addrs_last_10years := if(garbage_addr, 0, le.addrs_last_10years);
	self.addrs_last_15years := if(garbage_addr, 0, le.addrs_last_15years);					
	self.addrs_last30 := if(garbage_addr, 0, le.addrs_last30);
	self.addrs_last90 := if(garbage_addr, 0, le.addrs_last90);
	self.addrs_last12 := if(garbage_addr, 0, le.addrs_last12);
	self.addrs_last24 := if(garbage_addr, 0, le.addrs_last24);
	self.addrs_last36 := if(garbage_addr, 0, le.addrs_last36);
	
	self := le;
end;

// append the hierarchy sequencing
header_with_addr_heirarchy_nneq_roxie := join(allheader_temp, addr_history_data, 
	left.did<>0 and left.chronozip<>'' and left.chronoprim_name<>'' and
	left.did=right.s_did and 
	left.chronozip=right.zip and
	left.chronoprim_range=right.prim_range and
	left.chronoprim_name=right.prim_name and
	ut.NNEQ(left.chronosec_range,right.sec_range) and  // allow for NNEQ on sec range
	right.date_first_seen < left.historydate,
	append_hierarchy(left,right),
	left outer, 
	keep(2));  // keep 2 just in case there are records on addr_hist for same street, 1 with the sec_range populated and 1 without

header_with_addr_heirarchy_nneq_thor := join(distribute(allheader_temp, hash64(did, chronozip, chronoprim_range, chronoprim_name)), 
	distribute(addr_history_data, hash64(s_did, zip, prim_range, prim_name)), 
	left.did<>0 and left.chronozip<>'' and left.chronoprim_name<>'' and
	left.did=right.s_did and 
	left.chronozip=right.zip and
	left.chronoprim_range=right.prim_range and
	left.chronoprim_name=right.prim_name and
	ut.NNEQ(left.chronosec_range,right.sec_range) and  // allow for NNEQ on sec range
	right.date_first_seen < left.historydate,
	append_hierarchy(left,right),
	left outer, 
	keep(2),
	LOCAL);  // keep 2 just in case there are records on addr_hist for same street, 1 with the sec_range populated and 1 without
	
#IF(onThor)
	header_with_addr_heirarchy_nneq := header_with_addr_heirarchy_nneq_thor;
#ELSE
	header_with_addr_heirarchy_nneq := header_with_addr_heirarchy_nneq_roxie;
#END

// get back to just 1 record per record_seq
header_with_addr_heirarchy_roxie := dedup(sort(header_with_addr_heirarchy_nneq, seq, did, record_seq, if(address_history_seq=0, 255, address_history_seq) ),
	seq, did, record_seq);
header_with_addr_heirarchy_thor := dedup(sort(distribute(header_with_addr_heirarchy_nneq, hash64(seq, did)), seq, did, record_seq, if(address_history_seq=0, 255, address_history_seq), LOCAL),
	seq, did, record_seq, LOCAL);

#IF(onThor)
	header_with_addr_heirarchy := header_with_addr_heirarchy_thor;
#ELSE
	header_with_addr_heirarchy := header_with_addr_heirarchy_roxie;
#END

// now that we've appended the address history_seq, use that thing for the sort instead of just dt_last_seen, dt_first_seen dates
new_sortedBest_roxie := sort(header_with_addr_heirarchy, seq, did, if(address_history_seq=0, 255, address_history_seq), 
		-dt_last_seen, -chronodate_first, chronolast, chronofirst, 
		// added more fields to sort by to make code deterministic when picking between EQ record and EQ(QH) record with same dates, but different address and ssn_valid results
		-socsvalid, -chronozip, -chronoprim_name, -chronoprim_range, -chronopredir, -chronosuffix, -chronopostdir, 
		-chronosec_range, -chronounit_desig, -chronogeo_blk, -chronozip4, -chronocity, -chronostate);

new_sortedBest_thor := sort(header_with_addr_heirarchy, seq, did, if(address_history_seq=0, 255, address_history_seq), 
		-dt_last_seen, -chronodate_first, chronolast, chronofirst, 
		// added more fields to sort by to make code deterministic when picking between EQ record and EQ(QH) record with same dates, but different address and ssn_valid results
		-socsvalid, -chronozip, -chronoprim_name, -chronoprim_range, -chronopredir, -chronosuffix, -chronopostdir, 
		-chronosec_range, -chronounit_desig, -chronogeo_blk, -chronozip4, -chronocity, -chronostate, LOCAL);
	
#IF(onThor)
	new_sortedBest := new_sortedBest_thor;
#ELSE
	new_sortedBest := new_sortedBest_roxie;
#END

best_address_roxie := dedup(new_sortedBest, seq, did);  // get the best address per sequence

best_address_thor := dedup(new_sortedBest, seq, did, LOCAL);

#IF(onThor)
	best_address := best_address_thor;
#ELSE
	best_address := best_address_roxie;
#END

// join back to new_sortedBest to append that best to layout_output

Risk_indicators.iid_constants.layout_outx getBestAddress(new_sortedBest le, best_address ri) := TRANSFORM
	self.addr_hierarchy_best_prim_range := ri.chronoprim_range;
	self.addr_hierarchy_best_predir := ri.chronopredir;
	self.addr_hierarchy_best_prim_name := ri.chronoprim_name;;
	self.addr_hierarchy_best_suffix := ri.chronosuffix;
	self.addr_hierarchy_best_postdir := ri.chronopostdir;
	self.addr_hierarchy_best_unit_desig := ri.chronounit_desig;
	self.addr_hierarchy_best_sec_range := ri.chronosec_range;
	self.addr_hierarchy_best_city  := ri.chronocity;
	self.addr_hierarchy_best_state  := ri.chronostate;
	self.addr_hierarchy_best_zip  := ri.chronozip;
	self := le;
END;

with_best_address_roxie := join(new_sortedBest, best_address, left.seq=right.seq and left.did=right.did
	and right.address_history_seq not in [0, 255], // don't call anything the best if the most recent is 0 or 255 - invalid
	getBestAddress(LEFT, RIGHT), 
	left outer, keep(1));
	
with_best_address_thor := join(new_sortedBest, best_address, left.seq=right.seq and left.did=right.did
	and right.address_history_seq not in [0, 255], // don't call anything the best if the most recent is 0 or 255 - invalid
	getBestAddress(LEFT,RIGHT),
	left outer, keep(1), LOCAL);
		
#IF(onThor)
	with_best_address := with_best_address_thor;
#ELSE
	with_best_address := with_best_address_roxie;
#END

with_best_address_grouped_roxie := group(sort(with_best_address, seq,did), seq, did);
with_best_address_grouped_thor := group(sort(with_best_address, seq,did, LOCAL), seq, did, LOCAL);

#IF(onThor)
	with_best_address_grouped := with_best_address_grouped_thor;
#ELSE
	with_best_address_grouped := with_best_address_grouped_roxie;
#END

// ################### comment out this section when done troubleshooting  ##################
			// get every unique DID in the input dataset to use for searching the hierarchy table
			// unique_dids := table(allheader, {did}, did);

			// hierarchy := join(unique_dids, header.key_addr_hist(isFCRA),
				// keyed(left.did=right.s_did), 
				// atmost(riskwise.max_atmost) );
			// output(sort(hierarchy,address_history_seq) , named('hierarchy'));
// ################### 

// output(allheader, named('allheader'));
// output(header_with_addr_heirarchy_nneq, named('header_with_addr_heirarchy_nneq'));
// output(new_sortedbest, named('new_sortedbest'));
// output(best_address, named('best_address'));

return with_best_address_grouped;

end;
