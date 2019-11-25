IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, UPI_DataBuild,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT Metrics_Report (string pVersion, boolean pUseProd, string gcid, dataset (UPI_DataBuild.Layouts_V2.input_processing) pBaseFile):= MODULE
  
	EXPORT MetricsRecord(metric1,metric2,metric3,metric4,metric5,metric6,metric7,metric8,metric9,metric10) := FUNCTIONMACRO
	
   d := dataset([{min_lexid_score, max_lexid_score, ave_lexid_score, cnt_lexid_change, pct_lexid_change, cnt_crk_change, pct_crk_change, guardian_min_lexid_score, guardian_max_lexid_score, guardian_ave_lexid_score}],
                  UPI_Databuild.Layouts_V2.metrics_fields);          

    return d;
	endmacro;
	
	export prep_file := function
		UPI_DataBuild.layouts_V2.input_processing tMapping(UPI_DataBuild.layouts_V2.input_processing L) := TRANSFORM
			self.batch_seq_number							:= L.batch_seq_number;
			self.input_lexid									:= L.input_lexid;
			self.input_crk										:= L.input_crk;
			self.member_id										:= L.member_id;
			self.customer_id									:= L.customer_id;
			self.account_id										:= L.account_id;
			self.subscriber_id								:= L.subscriber_id;
			self.group_id											:= L.group_id;
			self.relationship_code						:= L.relationship_code;
			self.input_first_name							:= L.input_first_name;
			self.input_middle_initial					:= L.input_middle_initial;
			self.input_last_name							:= L.input_last_name;
			self.input_suffix									:= L.input_suffix;
			self.input_full_name							:= L.input_full_name;
			self.address_line1								:= L.address_line1;
			self.address_line2								:= L.address_line2;
			self.input_city										:= L.input_city;
			self.input_state									:= L.input_state;
			self.input_zip										:= L.input_zip;
			self.input_dob										:= L.input_dob;
			self.input_gender									:= L.input_gender;
			self.input_ssn										:= L.input_ssn;
			self.input_home_phone							:= L.input_home_phone;
			self.input_alt_phone							:= L.input_alt_phone;
			self.input_primary_email_address	:= L.input_primary_email_address;
			self.input_guardian_first_name		:= L.input_guardian_first_name;
			self.input_guardian_last_name			:= L.input_guardian_last_name;
			self.input_guardian_dob						:= L.input_guardian_dob;
			self.input_guardian_ssn						:= L.input_guardian_ssn;
			self.udf1													:= L.udf1;
			self.udf2													:= L.udf2;
			self.udf3													:= L.udf3;
			self.lexid												:= map(L.append_option = '1' => L.lexid,
																							 L.append_option = '2' => L.lexid,
																							 L.append_option = '3' => L.lexid,
																							 L.append_option = '4' => 0,
																							 L.lexid); 
			self.lexid_score									:= map(L.append_option = '1' => L.lexid_score,
																							 L.append_option = '2' => L.lexid_score,
																							 L.append_option = '3' => L.lexid_score,
																							 L.append_option = '4' => 0,
																							 L.lexid_score); 
			self.lexid_changed								:= map(L.append_option = '1' => L.lexid_changed,
																							 L.append_option = '2' => L.lexid_changed,
																							 L.append_option = '3' => L.lexid_changed,
																							 L.append_option = '4' => 'N',
																							 L.lexid_changed); 
			self.prev_lexid										:= L.prev_lexid; 
			self.crk													:= map(L.append_option = '1' => L.crk,
																							 L.append_option = '2' AND self.lexid = 0 => L.crk,
																							 L.append_option = '2' AND self.lexid > 0 => '',
																							 L.append_option = '3' => '',
																							 L.append_option = '4' => L.crk,
																							 L.crk);
			self.crk_changed									:= map(L.append_option = '1' => L.crk_changed,
																							 L.append_option = '2' AND self.lexid = 0 => L.crk_changed,
																							 L.append_option = '2' AND self.lexid > 0 => 'N',
																							 L.append_option = '3' => 'N',
																							 L.append_option = '4' => L.crk_changed,
																							 L.crk_changed);
			self.prev_crk											:= L.prev_crk;
			SELF  :=  L;	
			SELF  :=  [];
		END;
		//AppendOption:
		// 1 - Append LexID to records with LexID match AND Customer Record Key for all records
		// 2 - Append LexID to records with LexID match AND Customer Record Key ONLY for records with NO LEXID
		// 3 - Append LexID ONLY to records with LexID match and DO NOT append Customer Record Key for any records
		// 4 - Append ONLY Customer Record Key for all records - NO LEXID appends for any records

		reformatFile	:= project(pBaseFile, tMapping(left));
		
		sort_return	:= sort(reformatFile, (integer)batch_seq_number);
		
		RETURN sort_return;
	END;

	export min_lexid_score := function
		has_score := prep_file(lexid_score > 0);
	return min(has_score, lexid_score);
	end;

	export max_lexid_score := function
		has_score := prep_file(lexid_score > 0);
	return max(has_score, lexid_score);
	end;

	export ave_lexid_score	:= function
		has_score := prep_file(lexid_score > 0);
	return truncate(ave(has_score, lexid_score));
	end;

	export cnt_lexid_change	:= function
		lexid_change := prep_file(lexid_changed = 'Y');
	return count(lexid_change);
	end;
	
	export pct_lexid_change := function
		total_rec_cnt	:= count(prep_file);
		pct_lexid			:= cnt_lexid_change / total_rec_cnt * 100;
	return round(pct_lexid);
	end;

	export cnt_crk_change := function
		crk_change := prep_file(crk_changed = 'Y');
	return count(crk_change);
	end;

	export pct_crk_change := function
		total_rec_cnt	:= count(prep_file);
		pct_crk				:= cnt_crk_change / total_rec_cnt * 100;
	return round(pct_crk);
	end;
	
	export guardian_min_lexid_score := function
		has_score := prep_file(guardian_lexid_score > 0);
	return min(has_score, guardian_lexid_score);
	end;

	export guardian_max_lexid_score := function
		// has_score := pBaseFile(guardian_lexid_score > 0);
		has_score := prep_file(guardian_lexid_score > 0);
	return max(has_score, guardian_lexid_score);
	end;

	export guardian_ave_lexid_score	:= function
		// has_score := pBaseFile(guardian_lexid_score > 0);
		has_score := prep_file(guardian_lexid_score > 0);
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
