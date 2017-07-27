import ut, Doxie_Raw;
export rid_cnt := module

	// This is the same as doxie.Layout_Rollup.RidRec but referring to
	// it that way creates circular references elsewhere in the code.
	export l_triple := record
		string30	rid;
		string2		src;
		unsigned6	docCnt := 1;
	end;
	
	export l_ds := record
		dataset(l_triple) rids {maxcount(ut.limits.HEADER_PER_DID)};
		unsigned2 rid_cnt;
		unsigned2 src_cnt;
		unsigned2 src_doc_cnt;
	end;
	
	// assimilate repeated rid/src combinations
	export dataset(l_triple) clean(dataset(l_triple) ds) := function
		ds tr(ds L, ds R) := transform
			self.docCnt := L.docCnt + R.docCnt;
			self := L;
		end;
		result := rollup(sort(ds,rid,src), tr(left,right), rid, src);
		return result;
	end;
	
	// compute three different counts of the rids table:
	//   rid_cnt     = number of distinct rids
	//   src_cnt     = number of distinct source types
	//   src_doc_cnt = sum of all doc_cnt values
	//
	// rid_cnt <= src_cnt <= src_doc_cnt
	//
	export unsigned rid_cnt(dataset(l_triple) ds) := function
		rid_uniq := table(ds(rid<>''),{rid},rid,few);
		return count(rid_uniq);
	end;
	export unsigned src_cnt(dataset(l_triple) ds) := function
		// We want this to align as closely as possible with the Occurrence counts
		l_tmp := record(l_triple)
			string50 src_desc;
		end;
		withDesc := project(ds(rid<>''), transform(l_tmp, self.src_desc:=Doxie_Raw.Occurrence.ridSrc_to_desc(left.src),self:=left));
		src_uniq := table(withDesc(src_desc<>''),{src_desc},src_desc,few);
		return count(src_uniq);
	end;
	
	export unsigned src_doc_cnt(dataset(l_triple) ds) := function
		return sum(ds, ds.docCnt);
	end;

	export dataset(l_triple) rid_filter(dataset(l_triple) ds, unsigned sdoc_filter) := function

		ds tr(ds L) := transform
			ext_src  	:= Doxie_Raw.Occurrence.ridSrc_to_desc(L.src);
			self.src 	:= if(doxie.SourceDocFilter.KeepSource(sdoc_filter, ext_src), L.src, skip);
			self 			:= L;
		end;
		filt_res := project(ds, tr(left));		
		return if(sdoc_filter > 0, filt_res, ds); 
		
	end;
	
end;