IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, UPI_DataBuild__old,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT Metrics_Report (string pVersion, boolean pUseProd, string gcid, dataset (UPI_DataBuild__old.Layouts_V2.input_processing) pBaseFile, string pHistMode):= MODULE
  
	EXPORT MetricsRecord(metric1,metric2,metric3,metric4,metric5,metric6,metric7,metric8,metric9,metric10,metric11) := FUNCTIONMACRO
	
   d := dataset([{min_lexid_score, max_lexid_score, ave_lexid_score, cnt_lexid_change, pct_lexid_change, cnt_crk_change, pct_crk_change, guardian_min_lexid_score, guardian_max_lexid_score, guardian_ave_lexid_score, cnt_new_crk}],
                  UPI_DataBuild__old.Layouts_V2.metrics_fields);          

    return d;
	endmacro;
	
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

	export cnt_crk_change := function
		crk_change := pBaseFile(crk_changed = 'Y');
	return count(crk_change);
	end;

	export pct_crk_change := function
		total_rec_cnt	:= count(pBaseFile);
		pct_crk				:= cnt_crk_change / total_rec_cnt * 100;
	return round(pct_crk);
	end;
	
	export guardian_min_lexid_score := function
		has_score := pBaseFile(guardian_lexid_score > 0);
	return min(has_score, guardian_lexid_score);
	end;

	export guardian_max_lexid_score := function
		has_score := pBaseFile(guardian_lexid_score > 0);
	return max(has_score, guardian_lexid_score);
	end;

	export guardian_ave_lexid_score	:= function
		has_score := pBaseFile(guardian_lexid_score > 0);
	return truncate(ave(has_score, guardian_lexid_score));
	end;
	
	export cnt_new_crk	:= function
		crk_only					:= record
			UPI_DataBuild__old.Layouts_V2.base.crk;
		end;
		
		prev_base		:= map(												 
									pHistMode = 'N'	=> dataset([],UPI_DataBuild__old.Layouts_V2.base),
									IF(NOTHOR(FileServices.GetSuperFileSubCount(UPI_DataBuild__old.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_base.father)) = 0
												 ,dataset([],UPI_DataBuild__old.Layouts_V2.base)
												 ,UPI_DataBuild__old.Files_V2(pVersion,pUseProd,gcid,pHistMode).member_base.father)); 
 									
		
		get_distinct_crk 	:= sort(distribute(dedup(project(pBaseFile, crk_only), all)), crk);
		prev_distinct_crk	:= sort(distribute(dedup(project(prev_base, crk_only), all)), crk);

		new_only 					:= join(prev_distinct_crk, get_distinct_crk,
													left.crk = right.crk,
													right only);

		return if(pHistMode = 'N', count(get_distinct_crk), if(count(new_only) < 0, 0, count(new_only)));
	end;
	   
	EXPORT get_all	:= FUNCTION
	
		metrics_file := MetricsRecord(
							min_lexid_score,  
							max_lexid_score, 
							ave_lexid_score, 
							cnt_lexid_change, 
							pct_lexid_change, 
							cnt_crk_change, 
							pct_crk_change,
							guardian_min_lexid_score, 
							guardian_max_lexid_score, 
							guardian_ave_lexid_score,
							cnt_new_crk);
							
		return metrics_file;
	end;
							
end;
