import ut;
// #option ('singlePersistInstances', true)

export fRollup(dataset(Prof_License_Mari.layouts.final) int0) := FUNCTION
// #workunit('name','Prof License MARI Rollup Process');
   basefile_test := project(int0(std_source_upd[1] = 'T'),Prof_License_Mari.layouts.final);
	 
	 ds_dist	:= distribute(int0(std_source_upd[1] != 'T'), hash64(
														std_source_upd,
														LICENSE_STATE,
														std_license_type,
														license_nbr,
														nmls_id,
														STD_LICENSE_STATUS,			  		
														STD_STATUS_DESC,              
														STD_LICENSE_DESC,             
														name_org
														));
	 
		ds_sort   := sort(ds_dist,													
												std_source_upd,
												LICENSE_STATE,
												std_license_type,
												license_nbr,
												nmls_id,
												STD_LICENSE_STATUS,			  		
												STD_STATUS_DESC,              
												STD_LICENSE_DESC,             
												name_org,
												name_dba_orig,
												bus_prim_range,
												bus_predir,
												bus_prim_name,
												bus_addr_suffix,
												bus_postdir,
												BUS_STATE,
												BUS_ZIP5,
												name_dba,
												bus_sec_range,
												date_vendor_last_reported,
												LOCAL);	
   
  Prof_License_Mari.layouts.final rollupXform(Prof_License_Mari.layouts.final l, Prof_License_Mari.layouts.final r) := transform
			self.create_dte									:= (string)ut.EarliestDate((integer)l.create_dte,	(integer)r.create_dte);
			self.last_upd_dte								:= (string)MAX((integer)l.last_upd_dte,(integer)r.last_upd_dte);
			self.Stamp_dte    							:= (string)MAX((integer)l.stamp_dte,(integer)r.stamp_dte);
			self.date_first_seen      			:= (string)ut.EarliestDate((integer)l.date_first_seen, (integer)r.date_first_seen);
		  self.date_last_seen     				:= (string)MAX((integer)l.date_last_seen,(integer)r.date_last_seen);
			self.date_vendor_first_reported := (string)ut.EarliestDate((integer)l.date_vendor_first_reported,	(integer)r.date_vendor_first_reported);
			self.date_vendor_last_reported 	:= (string)MAX((integer)l.date_vendor_last_reported,(integer)r.date_vendor_last_reported);
			self.process_date 							:= (string)MAX((integer)l.process_date,(integer)r.process_date);
			self.prev_primary_key						:= if(l.last_upd_dte  > r.last_upd_dte, r.prev_primary_key, l.prev_primary_key);
			self.prev_mltreckey							:= if(l.last_upd_dte  > r.last_upd_dte,	r.prev_mltreckey, l.prev_mltreckey);
			self.prev_cmc_slpk							:= if(l.last_upd_dte  > r.last_upd_dte,	r.prev_cmc_slpk, l.prev_cmc_slpk);
			self.prev_pcmc_slpk							:= if(l.last_upd_dte  > r.last_upd_dte,	r.prev_pcmc_slpk, l.prev_pcmc_slpk);
			self.persistent_record_id				:= if(l.last_upd_dte  > r.last_upd_dte,	r.persistent_record_id, l.persistent_record_id);
	    self := r;
   end;
	  
	 
   dDataset_rollup := rollup( ds_sort,
							LEFT.std_source_upd = RIGHT.std_source_upd 					AND
							LEFT.LICENSE_STATE = RIGHT.LICENSE_STATE 						AND
							LEFT.std_license_type = RIGHT.std_license_type 			AND
							LEFT.license_nbr = RIGHT.license_nbr 								AND
							LEFT.nmls_id = RIGHT.nmls_id												AND
							LEFT.STD_LICENSE_STATUS = RIGHT.STD_LICENSE_STATUS 	AND
							LEFT.STD_STATUS_DESC = RIGHT.STD_STATUS_DESC 				AND
							LEFT.STD_LICENSE_DESC = RIGHT.STD_LICENSE_DESC 			AND
							LEFT.name_org = RIGHT.name_org 											AND
							LEFT.name_dba_orig = RIGHT.name_dba_orig 						AND
							ut.NNEQ(LEFT.name_dba, RIGHT.name_dba)							AND
							LEFT.bus_prim_range = RIGHT.bus_prim_range 					AND
							LEFT.bus_predir = RIGHT.bus_predir 									AND
							LEFT.bus_prim_name = RIGHT.bus_prim_name 						AND
							LEFT.bus_addr_suffix = RIGHT.bus_addr_suffix 				AND
							LEFT.bus_postdir = RIGHT.bus_postdir 								AND
							LEFT.bus_state = RIGHT.bus_state 										AND
							LEFT.bus_zip5 = RIGHT.bus_zip5			 								AND
							ut.NNEQ(LEFT.bus_sec_range, RIGHT.bus_sec_range) 
							,	rollupXFORM(LEFT, RIGHT),
			local);												
			 
			basefile_rollup := dDataset_rollup + basefile_test; /*: persist('~thor_data400::persist::proflic_mari::rolled_up_v2');*/
			
      return basefile_rollup; 
end;
