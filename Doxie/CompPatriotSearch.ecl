// for the different names for the subject perform a name search in the GlobalWatchlist data
import patriot, doxie, iesp;

export CompPatriotSearch := function
	ds := doxie.Comp_Subject_Addresses_wrap.raw;
	r_ds := dedup(sort(ds,fname,lname,mname),fname,lname,mname); // unique list of names for the subject
	patriot.Layout_batch_in b_trans(r_ds L) := transform
		self.name_middle := l.mname;
		self.name_first := l.fname;
		self.name_last := l.lname;
		self.acctno := '';
		self.name_unparsed := '';
		self.search_type := 'BOTH'; 
		self.country :='';
		self.dob := '';
		self := L;
	end;    
	b_ds := project(r_ds,b_trans(LEFT));

	gb_ds := group(sort(b_ds,acctno),acctno);
  a := ungroup(SORT(patriot.Search_Function(gb_ds,false),-score,pty_key));
	

iesp.globalwatchlist.t_GlobalWatchListSearchRecord gw_trans(a l) := transform 
		self.PartyKey := l.pty_key;
		self.datasource := l.source;
		self.partyName := (string)l.orig_pty_name;
		self.maxmatchscore := (real8)l.score;
		self.blockedcountry := (string)l.blocked_country;
		self.recordtype := l.record_type;
    iesp.globalwatchlist.t_GlobalWatchListSearchAddress 
				addr_trans1(Patriot.layout_search_out.address le):= transform
				   loclines := dataset([{le.addr_1},{le.addr_2},{le.addr_3},{le.addr_4},{le.addr_5},{le.addr_6},{le.addr_7},{le.addr_8},{le.addr_9},{le.addr_10}],iesp.share.t_stringarrayitem);
				   self.addresslines := loclines(value<>' '); 
		   self := le;
		end;

		self.addresses := choosen(project(l.addresses,addr_trans1(left)),iesp.constants.Patriot.MaxAddresses);
		self.akas := choosen(project(l.akas,transform(iesp.globalwatchlist.t_GlobalWatchListSearchAKA,self.partyname := (string)left.orig_pty_name,self.MatchScore := (real8)left.score)),iesp.constants.Patriot.MaxAkas);
		self.Remarks := choosen(project(l.remarks,transform(iesp.share.t_stringarrayitem,self.value := left.remark_v)),iesp.constants.Patriot.MaxRemarks); // dataset of remarks
		self := l;
	end;
	iesp_results := project(a, gw_trans(left));
	return iesp_results;
end; 
