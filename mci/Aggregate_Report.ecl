IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, MCI,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT Aggregate_Report(boolean pUseProd, string gcid, string pHistMode, dataset (MCI.Layouts_V2.jobID_list) pBatch_jobID_list, string pVersion_start, string pVersion_end):= MODULE

	EXPORT AggregateRecord(metric1,metric2,metric3,metric4,metric5,metric6,metric7,metric8,metric9,metric10,metric11,metric12,metric13) := FUNCTIONMACRO
	
   d := dataset([{min_lexid_score, max_lexid_score, ave_lexid_score, cnt_lexid_change, pct_lexid_change, 
									distinct_lexid_cnt, dup_lexid_cnt, cnt_crk_change, pct_crk_change, distinct_crk_cnt, 
									dup_crk_cnt, cnt_new_crk, match_crk_cnt}],
                  MCI.Layouts_V2.aggregate_fields);       									

    return d;
	endmacro;
	
	export startFile				:= sort(dataset('~usgv::mci::slim_history::' + gcid + '::qa', MCI.Layouts_V2.slim_history, thor), source_rid, batch_jobID);

  export pBatch_jobID_set	:= set(pBatch_jobID_list,batch_jobID);
	
	export pBaseFile	:= if(pBatch_jobID_set <> [], startFile(batch_jobID in pBatch_jobID_set),  
											startFile(dt_vendor_last_reported >= (unsigned4)pVersion_start and dt_vendor_last_reported <= (unsigned4)pVersion_end));
	
	export min_lexid_score := function
		has_score := pBaseFile(lexid_score > 0);
	return min(has_score, lexid_score);
	end;

	export max_lexid_score := function
		has_score := pBaseFile(lexid_score > 0);
	return max(has_score, lexid_score);
	end;

	export ave_lexid_score	:= function
		has_score := pBaseFile(lexid_score > 0);
	return truncate(ave(has_score, lexid_score));
	end;

	export cnt_lexid_change	:= function 
		lexid_change := pBaseFile(lexid_changed = 'Y');
	return count(lexid_change);
	end;
	
	export pct_lexid_change := function
		total_rec_cnt	:= count(pBaseFile);
		pct_lexid			:= cnt_lexid_change / total_rec_cnt * 100;
	return round(pct_lexid);
	end;

	export distinct_lexid_cnt := function
		has_lexid := pBaseFile(lexid > 0);
		lex_only	:= record
			has_lexid.lexid;
		end;
		
		distinct_cnt	:= dedup(project(has_lexid, lex_only), all);
	return count(distinct_cnt);
	end;

	export dup_lexid_cnt		:= function
		has_lexid := pBaseFile(lexid > 0);
		lex_only	:= record
			has_lexid.lexid;
			cnt:=count(group);
		end;
		
		dup_table	:= table(has_lexid,lex_only,lexid);
		dup_cnt		:= dup_table(cnt > 1);
		
	return count(dup_cnt);
	end;	

	export cnt_crk_change := function
		crk_change := pBaseFile(crk_changed = 'Y');
	return count(crk_change);
	end;

	export pct_crk_change := function
		total_rec_cnt	:= count(pBaseFile);
		pct_crk				:= cnt_crk_change / total_rec_cnt * 100;
	return round(pct_crk);
	end;
									
	export distinct_crk_cnt := function
		has_crk 	:= pBaseFile(crk <> '');
		crk_only	:= record
			has_crk.crk;
		end;
		
		distinct_cnt	:= dedup(project(has_crk, crk_only), all);
	return count(distinct_cnt);
	end;

	export dup_crk_cnt		:= function
		has_crk := pBaseFile(crk <> '');
		crk_only	:= record
			has_crk.crk;
			cnt:=count(group);
		end;
		
		dup_table	:= table(has_crk,crk_only,crk);
		dup_cnt		:= dup_table(cnt > 1);
		
	return count(dup_cnt);
	end;	
	
	export cnt_new_crk	:= function
		crk_only					:= record
			MCI.Layouts_V2.base.crk;
		end;
		
		get_distinct_crk 	:= sort(distribute(dedup(project(pBaseFile, crk_only), all)), crk);
		prev_base					:= MCI.Files_V2('',pUseProd,gcid,pHistMode).member_base.qa;
		prev_distinct_crk	:= sort(distribute(dedup(project(prev_base, crk_only), all)), crk);

		new_only 					:= join(prev_distinct_crk, get_distinct_crk,
													left.crk = right.crk,
													right only);

		return if(pHistMode = 'N', count(get_distinct_crk), if(count(new_only) < 0, 0, count(new_only)));
	end;	
	
	export match_crk_cnt := function
		crk_compare	:= record
			pBaseFile.input_crk;
			pBaseFile.crk;
			pBaseFile.crk_changed;
		end;
		
		slim_file		 := dedup(distribute(project(pBaseFile, crk_compare)),record);
		has_same_crk := slim_file(crk <> '' and input_crk <> '' and crk_changed = 'N');
	return count(has_same_crk);
	end;
	   
	EXPORT get_all	:= FUNCTION
	
		aggregate_file := AggregateRecord(
							min_lexid_score,
							max_lexid_score,
							ave_lexid_score,
							cnt_lexid_change,
							pct_lexid_change, 
							distinct_lexid_cnt,
							dup_lexid_cnt,
							cnt_crk_change,
							pct_crk_change,
							distinct_crk_cnt, 
							dup_crk_cnt,
							cnt_new_crk,
							match_crk_cnt);
							
		return aggregate_file;
	end;
							
end;

