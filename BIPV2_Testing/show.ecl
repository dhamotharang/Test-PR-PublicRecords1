import mdr, tools, bizlinkfull, BIPV2;

EXPORT show := 
module

// shared k := bizlinkfull.Process_Biz_Layouts.key;
shared k := BIPV2.Key_BH_Linking_Ids.key;


// PROX
export proxids(dataset({unsigned6 proxid}) ds, string s = '', boolean justFlat = FALSE) :=
function

	wh := BIPV2.IDmacros.mac_AppendHierarchyIDs(ds, proxid);

	myk := 
	join(
		wh,
		k,
		left.UltID  = right.UltID  and  
    left.OrgID  = right.OrgID  and 
    left.SELEID = right.SELEID and 
		left.ProxID = right.ProxID
		,transform(
			{k, string50 source_decoded}, 
			self.source_decoded := mdr.sourceTools.fTranslateSource(right.source),
			self := right
		),
		keep(10000)
	);

	return myk;
	// parallel(
		// output(choosen(enth(myk, 1000), 1000), named('full_flat_enth1K_'+s)),
		// if(not justFlat, output(tools.mac_AggregateFieldsPerID( myk, proxid), all, named('full_rolled_'+s)))
	// );
end;

export proxid(unsigned pid, boolean justFlat = FALSE) :=
function

ds := dataset([{pid}],{unsigned6 proxid});
return proxids(ds, (string)pid, justFlat);

end;

export proxidf(unsigned pid) := //flat is fast
function

return proxid(pid, justFlat := TRUE);

end;

//SELE
export seleids(dataset({unsigned6 seleid}) ds, string s = '', boolean justFlat = FALSE) :=
function

	// wh := BIPV2.IDmacros.mac_AppendHierarchyIDs(ds, proxid);
	wh := bizlinkfull.Process_Biz_Layouts.id_stream_complete(project(ds, transform(bizlinkfull.Process_Biz_Layouts.id_stream_layout, self := left, self := [])));

	myk := 
	join(
		wh,
		k,
		left.UltID  = right.UltID  and  
    left.OrgID  = right.OrgID  and 
    left.SELEID = right.SELEID  
		,transform(
			{k, string50 source_decoded}, 
			self.source_decoded := mdr.sourceTools.fTranslateSource(right.source),
			self := right
		),
		keep(10000)
	);

	return 
	myk;
	// parallel(
		// output(choosen(enth(myk, 1000), 1000), named('full_flat_enth1K_'+s)),
		// if(not justFlat, output(tools.mac_AggregateFieldsPerID( myk, seleid), all, named('full_rolled_'+s)))
	// );
end;

export seleid(unsigned pid, boolean justFlat = FALSE) :=
function

ds := dataset([{pid}],{unsigned6 seleid});
return seleids(ds, (string)pid, justFlat);

end;

export seleidf(unsigned pid) := //flat is fast
function

return seleid(pid, justFlat := TRUE);


end;

export seleidd(unsigned pid) := //flat is fast
function

f := seleidf(pid);
return dedup(table(f, {proxid, seleid, company_name,company_name_type_derived, prim_range, prim_name, zip, st,hist_enterprise_number,hist_domestic_corp_key,unk_corp_key,ebr_file_number,active_duns_number,hist_duns_number,active_enterprise_number,active_domestic_corp_key,foreign_corp_key,company_inc_state,company_charter_number,company_fein,company_phone,nodes_total}), all);


end;

export seleidfd(unsigned pid) := //flat is fast
function

f := seleidf(pid);
d := seleidd(pid);

return
parallel(
	output(choosen(f, 1000), named((string)pid + '_flat'))
	// ,output(choosen(f(source = 'C7'), 1000), named((string)pid + '_flat_C7'))
	,output(choosen(d, 1000), named((string)pid + '_ddp'))
	,output(choosen(dedup(table(f, {prim_range, prim_name, zip}), all), 1000), named((string)pid + '_addrs'))
	,output(choosen(dedup(table(f, {source, source_decoded}), all), 1000), named((string)pid + '_sources'))
	,output(max(f, dt_last_seen), named((string)pid + '_dt_last_seen'))
);


end;


export proxidd(unsigned pid) := //flat is fast
function

f := proxidf(pid);
return dedup(table(f, {proxid, seleid, company_name,company_name_type_derived, prim_range, prim_name, sec_range, zip, st,hist_enterprise_number,hist_domestic_corp_key,unk_corp_key,ebr_file_number,active_duns_number,hist_duns_number,active_enterprise_number,active_domestic_corp_key,foreign_corp_key,company_inc_state,company_charter_number,company_fein,company_phone,nodes_total}), all);


end;

export proxidfd(unsigned pid) := //flat is fast
function

f := proxidf(pid);
d := proxidd(pid);

return
parallel(
	output(choosen(f, 1000), named((string)pid + '_flat_prox'))
	,output(choosen(d, 1000), named((string)pid + '_ddp_prox'))
	,output(choosen(dedup(table(f, {source, source_decoded}), all), 1000), named((string)pid + '_sources_prox'))
	,output(max(f, dt_last_seen), named('dt_last_seen'))
);


end;


end;//module