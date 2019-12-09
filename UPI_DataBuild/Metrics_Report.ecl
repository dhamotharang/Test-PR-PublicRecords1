﻿IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, UPI_DataBuild,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT Metrics_Report (string pVersion, boolean pUseProd, string gcid, dataset (UPI_DataBuild.Layouts_V2.input_processing) pBaseFile):= MODULE
  
	EXPORT MetricsRecord(metric1,metric2,metric3,metric4,metric5,metric6,metric7,metric8,metric9,metric10) := FUNCTIONMACRO
	
   d := dataset([{min_lexid_score, max_lexid_score, ave_lexid_score, cnt_lexid_change, pct_lexid_change, cnt_crk_change, pct_crk_change, guardian_min_lexid_score, guardian_max_lexid_score, guardian_ave_lexid_score}],
                  UPI_Databuild.Layouts_V2.metrics_fields);          

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
		// has_score := pBaseFile(guardian_lexid_score > 0);
		has_score := pBaseFile(guardian_lexid_score > 0);
	return max(has_score, guardian_lexid_score);
	end;

	export guardian_ave_lexid_score	:= function
		// has_score := pBaseFile(guardian_lexid_score > 0);
		has_score := pBaseFile(guardian_lexid_score > 0);
	return round(ave(has_score, guardian_lexid_score));
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
							guardian_ave_lexid_score);
							
		return metrics_file;
	end;
							
end;
