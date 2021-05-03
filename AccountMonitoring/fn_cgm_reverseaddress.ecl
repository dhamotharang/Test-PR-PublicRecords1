
import Business_Header,Watchdog,ut;
 
EXPORT DATASET(layouts.history) fn_cgm_reverseaddress(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.reverseaddress.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.reverseaddress.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
	
		// Filter and distribute Portfolio appropriately. 

		portfolio_dist_addr := 
			distribute(
				in_portfolio,
				hash64(prim_name, st, z5, prim_range, sec_range)
			) : INDEPENDENT;				


		// ******* Key Files *******
		
		// doxie.key_header	
		key_header_dist_addr := 
			DISTRIBUTE(
				AccountMonitoring.product_files.header_files.r_doxie_key_header_slim,
				HASH64(prim_name, st, zip, prim_range, sec_range)
			) : INDEPENDENT;

			
		// ******* Layouts *******

		temp_layout := record
			in_portfolio.pid;
			in_portfolio.rid;
			in_documents.hid;
			unsigned6 did            ;
			STRING20	name_first     ;
			STRING20	name_last      ;
      string10  prim_range     ;
      string28  prim_name      ;
      string8   sec_range      ;
      string25  city_name      ;
      string2   st             ;
      string5   zip            ;
		end;
				

		// Pivot on address.
		
		temp_join_1 := 
			join(
				portfolio_dist_addr,
				key_header_dist_addr,
				left.prim_name = right.prim_name and
				left.st = right.st and
				left.z5 = right.zip and
				left.prim_range = right.prim_range and
				left.sec_range = right.sec_range,
				transform(temp_layout,
					self.pid            := left.pid,
					self.rid            := left.rid,
					self.hid            := 0,
					self.name_first     := right.fname,
					self.name_last      := right.lname,
					self                := right
				),
				local
			);
		
			
 		// Combine the possibilities from the various pivots.
		temp_all_joins := temp_join_1;
															
		// Sort/Dedup joined people data. date_last_seen is not terribly important since any
		// change in address will affect the HASH value below.
		temp_all_joins_deduped := 
			dedup(
				temp_all_joins, 
				pid, rid, did, prim_name, st, zip, prim_range, sec_range, name_last, name_first,
				ALL
			);
																 
		// Now create a hash value from only the fields we're interested in (these are the
		// non *id fields in the temp_layout).
		temp_unrolled_hashes := 
			project(
				temp_all_joins_deduped,
				transform(AccountMonitoring.layouts.history,
					self.bdid         := 0,
					self.hid          := 0,
					self.product_mask := AccountMonitoring.Constants.pm_address,
					self.timestamp    := '',
					self.hash_value   := 
						hash64(
							left.name_last, 
							left.name_first, 
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