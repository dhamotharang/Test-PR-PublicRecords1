import doxie, doxie_cbrs, internetDomain_services, domains, iesp;

export raw := MODULE;

    export internetdomain_services.Layouts.Rawrec
		       ByIDs(dataset (internetdomain_services.layouts.inetdomain_slim) ids) := function

	   recs := join(ids,domains.Key_id,
		             keyed(left.internetservices_id =  right.internetservices_id),
											transform(internetdomain_services.Layouts.Rawrec,																									
																self:=right), atmost (1));
     return recs;																
  end;
			 
	export internetdomain_services.layouts.inetdomain_slim 
	          ByDids(dataset(doxie.layout_references) dids) := function
			
                   joined_set := join(dids, domains.key_did,
	                       keyed(left.did = right.did),
												 transform(internetdomain_services.layouts.inetdomain_slim,
																	 self := right),limit(iesp.Constants.INTERNETDOMAIN_MAX_COUNT_SEARCH_RESPONSE_RECORDS, skip));
	 return joined_set;
	end;
	
	export internetdomain_services.layouts.inetdomain_slim 
	           ByBDids(dataset(doxie_cbrs.layout_references) bdids) := function
			
			          joined_set := join(bdids, domains.key_bdid,
	                       keyed(left.bdid = right.bdid),
												 transform(internetdomain_services.layouts.inetdomain_slim,
																	 self := right),limit(iesp.Constants.INTERNETDOMAIN_MAX_COUNT_SEARCH_RESPONSE_RECORDS, skip));	
	 return joined_set;
	
	end;
	
	export internetdomain_services.layouts.inetdomain_slim 
	    ByDomainNames(dataset(internetdomain_services.layouts.inetdomain_slim) domainnames) := function

			joined_set := join(domainnames, domains.key_domain,
	                       keyed(left.domainname = right.domain_name[1..length (trim (left.domainname))]),
												 transform(internetdomain_services.layouts.inetdomain_slim,
																	 self := right),
                         limit (iesp.Constants.INTERNETDOMAIN_MAX_COUNT_SEARCH_RESPONSE_RECORDS, 
                                FAIL (203, doxie.ErrorCodes(203))));
	
	 return joined_set;
	
	end;
	
end;