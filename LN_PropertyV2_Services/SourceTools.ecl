import Header;

// Used by Header.HeaderShowSources to mimic being keyed by uid/src

export SourceTools := module

	export l_in := record
		header.layout_Source_ID;
		layouts.fid;
	end;
	
	shared l_roll := record
		layouts.fid;
		dataset(layouts.out_widest)	asses2_child {maxcount(1)};
		dataset(layouts.out_widest)	deeds2_child {maxcount(1)};
	end;

	export l_out := record
		header.layout_Source_ID;
		dataset(layouts.out_widest)	asses2_child {maxcount(1)};
		dataset(layouts.out_widest)	deeds2_child {maxcount(1)};
	end;

	export dataset(l_out) get(dataset(l_in) ds_in) := function
		fids := project(ds_in, transform(layouts.fid, self:=left));
		
		recs := project(
			resultFmt.widest_view.get_by_fid(fids), 
			transform(layouts.out_widest,self.isDeepDive:=false,self:=left)
		);
		
		recs_s := sort(recs, ln_fares_id, record);
		recs_g := group(recs_s, ln_fares_id);
		
		l_roll toRoll(layouts.out_widest L, dataset(layouts.out_widest) grpRows) := transform
			self.ln_fares_id := L.ln_fares_id;
			self.asses2_child := grpRows(fid_type='A');
			self.deeds2_child := grpRows(fid_type='D');
		end;
		
		recs_r := rollup(recs_g, group, toRoll(left,rows(left)));
		
		l_out toOut(l_in L, l_roll R) := transform
			self := L;
			self := R;
		end;
		
		results := join(
			ds_in, recs_r,
			left.ln_fares_id=right.ln_fares_id,
			toOut(left,right)
		);
		
		return results;
	end;
	
end;