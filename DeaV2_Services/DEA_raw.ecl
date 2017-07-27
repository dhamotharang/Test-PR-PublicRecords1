import doxie, doxie_cbrs, DEA, suppress, ut;


export DEA_raw := module

	//******* Get Registration_Number for BDIDs
	export get_deaKeys_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
																 unsigned in_limit = 0) := function
	  key := DEA.Key_DEA_Bdid;

		res := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.bd),
								transform(assorted_Layouts.layout_search_IDs,self := right),
								keep(ut.limits.DEA_PER_BDID));

		ded := dedup(sort(res,dea_registration_number),ALL);
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;

	//******* Get Registration_Number for DIDs
	export get_deaKeys_from_dids(dataset(doxie.layout_references) in_dids,
															   unsigned in_limit =0) :=function
		key :=DEA.key_DEA_did;
		res := join(dedup(sort(in_dids,did),did),key,
		            keyed(left.did = right.my_did),
								transform(assorted_Layouts.layout_search_IDs,self := right),
								keep(ut.limits.DEA_PER_DID));
		ded := dedup(sort(res,dea_registration_number),ALL);
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;
	
	// Gets RMSIDs from DIDs
	export get_dids (dataset(doxie.layout_references) in_dids
									 ,unsigned in_limit = 0) := function

			key := DEA.Key_dea_DID;
			res:= join(dedup(sort(in_dids,did),did),key,
										keyed(left.did = right.my_did)
										,limit(1000,skip) );
		  ded1 := dedup(sort(res,did),did);
			
			assorted_layouts.layout_Search_Ids  xfm_dids(recordof(ded1) l) := TRANSFORM
					//SELF.did := (String9)l.did;
					SELF.IsDeepDive := true;
					SELF := l;
  		END;
			
			ded := PROJECT(ded1,xfm_dids(LEFT));
	
	  return if(in_limit = 0,choosen(ded,1000),choosen(ded,in_limit));
		
		//return 0;
	end;

	// Gets RMSIDs from BDIDs
	export get_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
	                              unsigned in_limit = 0) := function
	  key := DEA.Key_dea_BDID;
		res:= join(dedup(sort(in_bdids,bdid),bdid),key,
										keyed(left.bdid = right.bd)
										,limit(1000,skip) );						
		ded1 := dedup(sort(res,bdid),bdid);
		assorted_layouts.layout_Search_Ids xfm_bdids(recordof(ded1) l) := TRANSFORM
					//SELF.dea_registration_number := (String9)l.bdid;
					SELF.IsDeepDive := true;
					SELF := l;
		END;
		ded := PROJECT(ded1,xfm_bdids(LEFT));
		return if(in_limit = 0,choosen(ded,1000),choosen(ded,in_limit));
	end;
	
	// GET the List of Ids for TextSearch Service and Comp Report
	export search_view := module
			export by_deakey(dataset(assorted_layouts.layout_search_IDs) in_DEAkeys,
											string in_ssn_mask_type = 'ALL', string32 appType):= function
					return DEAV2_services.DEAV2_Search_recs(in_DEAKeys, in_ssn_mask_type, appType);
			end;
	end;
	
	//Required by Comp Report
	export report_view := module(search_view)
	
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids
									 ,unsigned in_limit = 0
									 ,string in_ssn_mask_type = ''
									 , string32 appType
									) := function
		  return by_deakey(get_deaKeys_from_bdids(in_bdids,in_limit),in_ssn_mask_type, appType);
		end;

		export by_did(dataset(doxie.layout_references) in_dids
									,unsigned in_limit = 0
									,string in_ssn_mask_type = ''
									, string32 appType
								 ) := function
		  return by_deakey(get_deaKeys_from_dids(in_dids,in_limit),in_ssn_mask_type, appType);
		end;
		
	end;
	
	
END;