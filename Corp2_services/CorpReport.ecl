import business_header,doxie_cbrs;

export CorpReport(BOOLEAN return_multiple_pgs = FALSE) := FUNCTION

	string32 	chn := '' 		: stored('CharterNumber');
	string30 	ck := ''  		: stored('CorpKey');
	string2 st :=''         : stored('state');
	
	bdid_val := business_header.stored_bdid_value;
	bdids := dataset([{bdid_val}], doxie_cbrs.layout_references);

	noleading(string charter) := regexfind('([^0].*)$',charter,0);
	
	uchn :=stringlib.stringtouppercase(chn);
	uchn_noleading := noleading(uchn);

	charter_and_state :=dedup(dataset([{uchn,st},{uchn_noleading,st}],corp2_services.layout_charter_state),all);

	by_bdid := corp2_services.corp2_raw.get_corpkeys_from_bdids(bdids);

	by_Charter_and_state :=corp2_services.corp2_raw.get_corpkeys_from_charter_and_state(charter_and_state);

	uck :=stringlib.stringtouppercase(ck);
	corp_keys := 
		dedup(sort(if(ck <> '', dataset([{uck}],corp2_services.layout_corpkey)) +
							 if(bdid_val > 0, by_bdid) +
							 if(chn <>'',by_charter_and_state),corp_key),corp_key);



	prepr := corp2_services.corp2_raw.report_view.by_corpkey(in_corpkeys := corp_keys, return_multiple_pages := return_multiple_pgs);


	r :=prepr(corp_key= uck or uck='',
						intformat(bdid_val,12,1) in set(corp_hist,bdid) or bdid_val=0,
						noleading(corp_sos_charter_nbr)=uchn_noleading or uchn='',
						corp_state_origin= stringlib.stringtouppercase(st) or st='');

	RETURN r;

END;