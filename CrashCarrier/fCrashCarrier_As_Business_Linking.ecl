IMPORT Address,Business_Header,email_data,lib_stringlib,NID,UT;

export fCrashCarrier_As_Business_Linking(
		boolean pUseOtherEnviron = _Constants().IsDataland
	 ,dataset(CrashCarrier.layouts.Base) pBase = files(,pUseOtherEnviron).base.qa	
	) := function							

		ingest_file := pBase(cleaned_carrier_name<>'');

		pDataset_sort	:=	sort(ingest_file,
													 except 
														dt_first_seen
														,dt_last_seen
														,dt_vendor_first_reported
														,dt_vendor_last_reported
														,raw.carrier_id
														,raw.crash_id
														,source_rec_id
													);

		Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := transform
				self.dt_first_seen								:=	ut.EarliestDate(ut.EarliestDate(l.dt_first_seen, r.dt_first_seen),
																															ut.EarliestDate(l.dt_last_seen, r.dt_last_seen)
																															);
				self.dt_last_seen									:=	Max(l.dt_last_seen,r.dt_last_seen);
				self.dt_vendor_first_reported			:=	ut.EarliestDate(ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported),
																															ut.EarliestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported)
																															);
				self.dt_vendor_last_reported		  :=	Max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
				//maintain the lowest carrier_id
				self.raw.carrier_id								:=  if ((unsigned4)l.raw.carrier_id < (unsigned4)r.raw.carrier_id,l.raw.carrier_id,r.raw.carrier_id);
				//based upon the carrier_id map the associated crash_id
				self.raw.crash_id									:=  if ((unsigned4)l.raw.carrier_id < (unsigned4)r.raw.carrier_id,l.raw.crash_id,r.raw.crash_id);
				//take the source_rec_id from the same record with the that we are capturing the carrier_id from 
				self.source_rec_id								:=  if ((unsigned4)l.raw.carrier_id < (unsigned4)r.raw.carrier_id,l.source_rec_id,r.source_rec_id);
				self                						  :=  l;

		end;

		//Note:  The CrashCarrier base file has unique carrier_ids even though the remaining
		//       raw data is the same.  So basically there are duplicate records where all the
		//			 raw data is the same except for the crash_id and carrier_ids.  Since these "keys"
		//			 are of no importance for the business header, these records will be rolled up.
		//			 
		//			 This rollup maintains the lowest carrier_id and keeps that
		//			 records associated crash_id and source_rec_id.
		pDataset_rollup := rollup(pDataset_sort,
															RollupUpdate(left, right),
															record,
															except 
															 dt_first_seen
															,dt_last_seen
															,dt_vendor_first_reported
															,dt_vendor_last_reported
															,raw.carrier_id
															,raw.crash_id
															,source_rec_id
                            );

		//LINKING_INTERFACE MAPPING
		business_header.layout_business_linking.linking_interface	trfMapBLInterface(CrashCarrier.layouts.Base l) := transform																				
				self.source                      := l.source;
				self.dt_first_seen               := (unsigned4)l.dt_first_seen;
				self.dt_last_seen                := (unsigned4)l.dt_last_seen;
				self.dt_vendor_last_reported     := (unsigned4)l.dt_vendor_last_reported;
				self.dt_vendor_first_reported    := (unsigned4)l.dt_vendor_last_reported;
				self.company_bdid			   	       := l.bdid;				
				self.company_name                := l.cleaned_carrier_name;
				self.company_name_type_raw	  	 := '';//not available			
				self.company_rawaid			         := l.raw_aid ;
				self.company_address.prim_range  := l.prim_range;
				self.company_address.predir      := l.predir;
				self.company_address.prim_name   := l.prim_name;
				self.company_address.addr_suffix := l.addr_suffix;
				self.company_address.postdir     := l.postdir;
				self.company_address.unit_desig  := l.unit_desig;
				self.company_address.sec_range   := l.sec_range;
				self.company_address.p_city_name := l.p_city_name;
				self.company_address.v_city_name := l.v_city_name;
				self.company_address.st          := l.st;
				self.company_address.zip	       := l.zip;
				self.company_address.zip4        := l.zip4;
				self.company_address.cart        := l.cart;
				self.company_address.cr_sort_sz  := l.cr_sort_sz;
				self.company_address.lot         := l.lot;
				self.company_address.lot_order   := l.lot_order;
				self.company_address.dbpc        := l.dbpc;
				self.company_address.chk_digit   := l.chk_digit;
				self.company_address.rec_type    := l.rec_type;
				self.company_address.fips_state  := l.fips_state;
				self.company_address.fips_county := l.fips_county;
				self.company_address.geo_lat     := l.geo_lat;
				self.company_address.geo_long    := l.geo_long;
				self.company_address.msa         := l.msa;
				self.company_address.geo_blk     := l.geo_blk;
				self.company_address.geo_match   := l.geo_match;
				self.company_address.err_stat    := l.err_stat;
				self.company_address_type_raw		 := '';//not available
				self.company_fein                := '';//not available
				self.company_phone             	 := '';//not available
				self.phone_type									 := '';//not available
				self.vl_id                       := trim(l.raw.carrier_id) + '|' + trim(l.raw.crash_id);				
				self.current					           := true;
				self.source_record_id            := l.source_rec_id;
				self.dppa						             := false;
				self 							   						 := l;
				self 							   						 := [];
		end;

		CrashCarrier_proj  := project(pDataset_rollup,trfMapBLInterface(left));
		
		CrashCarrier_dedup := dedup(sort(distribute(CrashCarrier_proj,hash(vl_id,company_name)),record, local),record, local);

		return CrashCarrier_dedup;
end;