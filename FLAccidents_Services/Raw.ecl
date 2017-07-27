import AutoStandardI,doxie,FLAccidents, ut, suppress;

export Raw := MODULE
	export byDIDs(dataset(FLAccidents_Services.layouts.search_did) in_dids) := function 
			deduped := dedup(sort(in_dids,did),did);
			joinup := join(deduped,FLAccidents.Key_FLCrash_Did,
			               keyed(left.did=right.l_did),
										 transform(FLAccidents_Services.layouts.search,
				                       self := left,
															 self := right),LIMIT(FLAccidents_Services.Constants.MAX_RECS_ON_JOIN,skip)); 
			return joinup;
	end;
		
	export byBDIDs(dataset(FLAccidents_Services.layouts.search_bdid) in_bdids) := function
			deduped := dedup(sort(in_bdids,bdid),bdid);
			joinup := join(deduped,FLAccidents.Key_FLCrash_Bdid,
			               keyed(left.bdid=right.l_bdid),
										 transform(FLAccidents_Services.layouts.search,
				                       self := left,
															 self := right),LIMIT(FLAccidents_Services.Constants.MAX_RECS_ON_JOIN,skip)); 
			return joinup;
	end;	
	
	export byDLNbr(dataset(FLAccidents_Services.layouts.search_dlnbr) in_dlnbr) := function 
			deduped := dedup(sort(in_dlnbr,dlnbr),dlnbr);
			joinup := join(deduped,FLAccidents.Key_FLCrash_DLNbr,
			               keyed(left.dlnbr=right.l_dlnbr),
										 transform(FLAccidents_Services.layouts.search,
				                       self := left,
															 self := right),LIMIT(FLAccidents_Services.Constants.MAX_RECS_ON_JOIN,skip));
			return joinup;
	end;
	
	export byTagNbr(dataset(FLAccidents_Services.layouts.search_tagnbr) in_tagnbr) := function 
			deduped := dedup(sort(in_tagnbr,tagnbr),tagnbr);
			joinup := join(deduped,FLAccidents.Key_FLCrash_TagNbr,
			               keyed(left.tagnbr=right.l_tagnbr),
										 transform(FLAccidents_Services.layouts.search,
				                       self := left,
															 self := right),LIMIT(FLAccidents_Services.Constants.MAX_RECS_ON_JOIN,skip));
			return joinup;
	end;
	
	export byVIN(dataset(FLAccidents_Services.layouts.search_vin) in_vin) := function 
			deduped := dedup(sort(in_vin,vin),vin);
			joinup := join(deduped,FLAccidents.Key_FLCrash_VIN,
			               keyed(left.vin=right.l_vin),
										 transform(FLAccidents_Services.layouts.search,
				                       self := left,
															 self := right),LIMIT(FLAccidents_Services.Constants.MAX_RECS_ON_JOIN,skip));
			return joinup;
	end;

	
	// ==========================================================================
  // Returns records of FL Accident data in search view
  // ==========================================================================
	export SEARCH_VIEW := module
		export params := interface(
		  AutoStandardI.LIBIN.PenaltyI_Indv.base,
			AutoStandardI.LIBIN.PenaltyI_Biz.base,
		  AutoStandardI.InterfaceTranslator.glb_purpose.params,
		  AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		  AutoStandardI.InterfaceTranslator.application_type_val.params)
		  export unsigned2 penalty_Threshold;
	  end;
		
		//Returns records for input accident_nbrs
		export byAccNbr (dataset (FLAccidents_Services.layouts.search) in_accnbrs, params in_mod) := function
		
			deduped := dedup(sort(in_accnbrs,accident_nbr),accident_nbr);
			
			// Join deduped input ids (accident numbers) to main acc_nbr key file on accident_nbr
			recs_joined := join(deduped,FLAccidents.Key_FLCrash_AccNbr,
			               keyed((integer)left.accident_nbr=right.l_accnbr),
		 				         transform(FLAccidents_Services.Layouts.raw_rec,
						           self:=left,
											 self:=right,
											 self := []), limit(FLAccidents_Services.Constants.MAX_RECS_ON_JOIN, skip));

		  // Calculate the penalty on the records
		  recs_plus_pen := project(recs_joined,transform(FLAccidents_Services.Layouts.raw_rec,
			  tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				  export allow_wildcard := false;
				  export fname_field    := left.fname;
				  export mname_field    := left.mname;
				  export lname_field    := left.lname;
				  export prange_field   := left.prim_range;
				  export predir_field   := left.predir;
				  export pname_field    := left.prim_name;
				  export suffix_field   := left.addr_suffix;
				  export postdir_field  := left.postdir;
					export sec_range_field  := left.sec_range ;
				  export city_field     := left.v_city_name;			
				  export city2_field    := '';
				  export state_field    := left.st;
				  export zip_field      := left.zip;
			    // set fields not input to null
				  export ssn_field      := '';
				  export did_field      := left.did;
				  export dob_field      := '';
				  export phone_field    := '';
				  export county_field   := '';
			  end;

			  tempbizmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
				  export allow_wildcard := false;
				  export cname_field    := left.cname;
				  export prange_field   := left.prim_range;
				  export predir_field   := left.predir;
				  export pname_field    := left.prim_name;
				  export suffix_field   := left.addr_suffix;
				  export postdir_field  := left.postdir;
					export sec_range_field  := left.sec_range ;
				  export city_field     := left.v_city_name;			
				  export city2_field    := '';
				  export state_field    := left.st;
				  export zip_field      := left.zip;
				  // set fields not input to null
 				  export fein_field     := '';
				  export bdid_field     := left.b_did;
				  export county_field   := '';
			    export phone_field    := '';
			  end;

		    tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
				//Only use vals unique to biz so addr penalty doesn't get counted twice.
        tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod) + 
				                 AutoStandardI.LIBCALL_PenaltyI_Biz.val_bdid(tempbizmod);
						
        // if its deepdive, don't apply the penalty
		    self.penalt := if (left.isDeepDive, 0, tempPenaltIndv + tempPenaltBiz),
		    self := left));
			
		  // Don't return records for certain DIDs
			Suppress.MAC_Suppress(recs_plus_pen,recs_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did);
			
			return recs_pulled;

		end;
		
	end;
	
end;
