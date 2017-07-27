import doxie,doxie_cbrs,doxie_raw, internetdomain_services;

export SearchService_IDs := module
	export params := interface(AutoKey_IDs.params)
		export string45 domainName := '';
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
		export unsigned2 MAX_DEEP_BDIDS := 100;
	end;
	export val(params in_mod) := function
		// autokeys
		by_auto	:= internetdomain_services.AutoKey_IDs.val(in_mod);
		
		// deep DIDs
		deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
									 transform(doxie.layout_references, 									   								
										 self.did := left.did,										
										  self := left));
		by_deep_dids := if (not in_mod.noDeepDive,raw.byDids(deep_dids));
		
		// deep BDIDs
		 deep_bdids := project(limit(doxie_Raw.Get_Bdids(true,true,false),in_mod.MAX_DEEP_BDIDS,skip),
									 transform(doxie_cbrs.layout_references,							 
									 self.bdid := left.bdid,
									 self := left)); 
			
		by_deep_bdids := if(not in_mod.noDeepDive,raw.byBDIDs(deep_bdids));
		
		
		// lookup by domainName field 
		domainNameRec := dataset([{0,0,0,in_mod.domainname}],internetdomain_services.Layouts.inetdomain_slim);
		by_DomainName := internetDomain_services.raw.byDomainNames(domainNameRec);
		
		//*******************
		
		// lookup by DID
		dids := dataset([{(unsigned)in_mod.DID}],doxie.layout_references);
		by_did := internetDomain_services.raw.byDIDs(dids);
		
		// lookup by BDID
		
		bdids := dataset([{(unsigned)in_mod.BDID}],doxie_cbrs.layout_references);
		by_bdid := internetDomain_services.raw.ByBDids(bdids);
		
		
		ids := map(
			in_mod.domainname <> '' => by_DomainName, 
			(unsigned)in_mod.DID <> 0 => by_did,
			(unsigned)in_mod.BDID <> 0 => by_bdid,
			by_auto + project (by_deep_dids + by_deep_bdids, 
			              transform (internetDomain_services.Layouts.inetdomain_slim, 
										  Self.IsDeepDive := true;
											Self := Left)));

		// ...and shifting deep-dive-only to the end
		
		ids_d	:= dedup(sort(ids, internetservices_id, isDeepDive), internetservices_id, isDeepDive);
		
		// output(domainNameRec,named('SSIDS_domainNameRec'));
		// output(by_DomainName,named('SSIDS_by_DomainName'));
		// output(in_mod.domainname,named('inmoddomainname'));
		// output(ids_d,named('ids_d'));
		return ids_d;
	end;
end;
