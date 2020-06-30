import Business_Header,Watchdog,ut;
 
EXPORT DATASET(layouts.history) fn_cgm_address(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.address.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.address.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
		
		// Filter and distribute Portfolio appropriately. 
		
		// For those Portfolio entities having a valid did, we'll join those records using a
		// did pivot only, since the corresponding batch service joins only on a did as well. 
		portfolio_dist_did  := distribute(in_portfolio(did != 0),hash64(did)) : INDEPENDENT;
			

		// ******* Key Files *******
		
		// TODO: Dedup all header files before joining to Portfolio file. (Criteria?)
		
		// doxie.key_header
		key_header := 
			DISTRIBUTED(
				AccountMonitoring.product_files.header_files.r_doxie_key_header_slim,
				HASH64(DID)
			); // by DID only
			
		// header_quick.key_DID
		quick_header :=
			DISTRIBUTED(
				AccountMonitoring.product_files.header_files.r_quick_header_key_DID_slim,
				HASH64(DID)
			); 

		// utilfile.key_util_daily_did
		daily_utility := 
			DISTRIBUTED(
				AccountMonitoring.product_files.header_files.r_daily_utility_key_DID_slim,
				HASH64((UNSIGNED6)DID)
			);
		
		
		// ******* Layouts *******

		temp_layout := record
			in_portfolio.pid;
			in_portfolio.rid;
			in_documents.hid;
			unsigned6 did;
			unsigned6 bdid;
      string10  prim_range;
      string28  prim_name;
      string8   sec_range;
      string25  city_name;
      string2   st;
      string5   zip;
			unsigned3 dt_last_seen;
		end;
		
		
		// Pivot on DID for each of the header keys. The Best Address Batch Service finds
		// matching records strictly by DID, so that is the only pivot we'll use in this CGM.

		temp_join_1 := join(key_header,portfolio_dist_did, 
			left.did = right.did ,
			transform(temp_layout,
				self.pid  := right.pid,
				self.rid  := right.rid,
				self.hid  := 0,
				self.bdid := 0,
				self      := left),
			local);

		temp_join_2 := join(quick_header,portfolio_dist_did,
			left.did = right.did ,
			transform(temp_layout,
				self.pid  := right.pid,
				self.rid  := right.rid,
				self.hid  := 0,
				self.bdid := 0,
				self      := left),
			local);

		temp_join_3 := join(portfolio_dist_did, daily_utility,
			left.did = (UNSIGNED6)right.did,
			transform(temp_layout,
				self.pid  := left.pid,
				self.rid  := left.rid,
				self.hid  := 0,
				self.did  := (UNSIGNED6)right.did,
				self.bdid := 0,
				self.city_name := right.address_city,
				self.dt_last_seen := (unsigned3)right.record_date,
				self      := right),
			local);
			
 		// Combine the possibilities from the various pivots.
		temp_all_joins :=
				  temp_join_1
				+ temp_join_2
				+ temp_join_3
				;

		temp_all_joins_deduped := 
			dedup(
				sort(
					distribute(temp_all_joins,hash64(pid,rid)),
					pid,rid,did,-dt_last_seen,record,local
				),
				pid,rid,did,local
			);
			
		// Now create a hash value from only the fields we're interested in (these are the
		// non *id fields in the temp_layout).
		//
		// INFO: Per the monitoring matrix, 'Zip code alone will not be an address change.' 
		temp_unrolled_hashes := 
			project(
				temp_all_joins_deduped,
				transform(AccountMonitoring.layouts.history,
					self.hid          := 0,
					self.product_mask := AccountMonitoring.Constants.pm_address,
					self.timestamp    := '',
					self.hash_value   := 
						hash64(
							left.prim_name, 
							left.st, 
							left.zip, 
							left.prim_range, 
							left.sec_range
						),
					self              := left
				)
			); 
				
		//Then roll up the hashes for all records for a particular pid/rid.
		temp_rolled_hashes := 
			rollup(
				distribute(
					temp_unrolled_hashes,
					HASH64(pid, rid)
				),
				transform(AccountMonitoring.layouts.history,
					self.hash_value := left.hash_value + right.hash_value,
					self := left
				),
				pid,rid,local
			);
			
		return temp_rolled_hashes;
		
	end;