import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility, Std, UPI_DataBuild__old, HealthcareNoMatchHeader_Ingest;

EXPORT Update_Base_V2 (
				string pVersion
			, boolean pUseProd
			, string gcid
			, unsigned1 pLexidThreshold
			, string1 pHistMode
			, string100 gcid_name
			, string10 pBatch_jobID
			, string1			pAppendOption) := module
//AppendOption:
// 1 - Append LexID to records with LexID match AND Customer Record Key for all records
// 2 - Append LexID to records with LexID match AND Customer Record Key ONLY for records with NO LEXID
// 3 - Append LexID ONLY to records with LexID match and DO NOT append Customer Record Key for any records
// 4 - Append ONLY Customer Record Key for all records - NO LEXID appends for any records
										
	EXPORT pNewFile 	:= UPI_DataBuild__old.Files_V2(pVersion, pUseProd, gcid, pHistMode).from_batch;
	EXPORT pHistFile	:= UPI_DataBuild__old.Files_V2(pVersion, pUseProd, gcid, pHistMode).member_base.built;

	EXPORT Clean_addr (pStdFile)	:= FUNCTIONMACRO
	
		expand_base_layout	:= RECORD
			{pStdFile};
			STRING50		addresslast;
		END;

		expand_base_layout expand_rec(pStdFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;

		temp_base_recs := PROJECT(pStdFile,expand_rec(LEFT));	
				
		expand_base_layout prepAddress(temp_base_recs L) := TRANSFORM   
			Prep_addresslast 		:= trim(L.input_city, left,right) + ', ' + trim(L.input_state, left, right) + ' ' + trim(L.input_zip[1..5], left, right);
			SELF.addresslast		:= IF(Prep_addresslast = ',','',Prep_addresslast);
			SELF.preferred_name	:= Nid.PreferredFirstNew(L.input_first_name); // Get Preferred First Name, too
			SELF													:= L;
			SELF 													:= [];
		END;
  
		dAddressPrep	:= PROJECT(temp_base_recs,prepAddress(LEFT));

		UNSIGNED4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
		AID.MacAppendFromRaw_2Line(dAddressPrep,Address_line1,addresslast,RawAID,cleanAddr, lFlags);

		{pStdFile} addr(cleanAddr L)	:= TRANSFORM
			SELF.RawAID     := L.aidwork_rawaid;
			SELF.ACEAID			:= L.aidwork_acecache.aid;
			SELF.prim_range := stringlib.stringfilterout(L.aidwork_acecache.prim_range,'.');
			SELF.prim_name  := stringlib.stringfilterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
			SELF.sec_range  := stringlib.stringfilterout(L.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
			SELF.city_name	:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.v_city_name,'');
			SELF.zip        := L.aidwork_acecache.zip5;
			SELF.county			:= L.aidwork_acecache.county[3..5];
			SELF.msa        := IF(L.aidwork_acecache.msa='','',L.aidwork_acecache.msa+'0');
			SELF            := L.aidwork_acecache;
			SELF            := L;
		END;
		RETURN PROJECT(CleanAddr, addr(LEFT));
	ENDMACRO;
		
	EXPORT Get_Preferred_Name (pStdFile)	:= FUNCTIONMACRO 
					
		{pStdFile} PrefName(pStdFile L) := TRANSFORM   
			SELF.preferred_name						:= Nid.PreferredFirstNew(L.input_first_name); // Get Preferred First Name
			SELF													:= L;
			SELF 													:= [];
		END;
  
		RETURN PROJECT(pStdFile, PrefName(LEFT));
	ENDMACRO;
	
	EXPORT date_year_first (pDateToCheck)	:= FUNCTIONMACRO
		
		year_in_front	:= if((string)pDateToCheck[1..2] = '19' or (string)pDateToCheck[1..2] = '20', true, false);
		
		RETURN year_in_front;
	ENDMACRO;
	
	EXPORT dates_match (pDate1ToCheck, pDate2ToCheck)	:= FUNCTIONMACRO
		
		left_side_setup	:= if(date_year_first(pDate1ToCheck),
										(STRING)TRIM(stringlib.stringfilterout(pDate1ToCheck,'-.>$!%*@=?&\''),LEFT,RIGHT),
										Std.Date.ConvertDateFormat((string)pDate1ToCheck));
		
		right_side_setup	:= if(date_year_first(pDate2ToCheck),
										(STRING)TRIM(stringlib.stringfilterout(pDate2ToCheck,'-.>$!%*@=?&\''),LEFT,RIGHT),
										Std.Date.ConvertDateFormat((string)pDate2ToCheck));
										
		match_flag	:= if(left_side_setup = right_side_setup, true, false);
		
		RETURN match_flag;
	ENDMACRO;
	
	EXPORT name_fields_match (pUpdateFile, pBaseToCheck) := FUNCTIONMACRO
	
		match_flag := IF(
				trim(stringlib.stringtouppercase(left.input_first_name),left,right) 								=
				trim(stringlib.stringtouppercase(right.input_first_name),left,right) 							AND
				trim(stringlib.stringtouppercase(left.input_middle_initial),left,right) 							=
				trim(stringlib.stringtouppercase(right.input_middle_initial),left,right) 							AND
				trim(stringlib.stringtouppercase(left.input_last_name),left,right) 							=
				trim(stringlib.stringtouppercase(right.input_last_name),left,right) 							AND
				trim(stringlib.stringtouppercase(left.input_suffix),left,right) 							=
				trim(stringlib.stringtouppercase(right.input_suffix),left,right) 							AND
				trim(stringlib.stringtouppercase(left.input_full_name),left,right) 							=
				trim(stringlib.stringtouppercase(right.input_full_name),left,right) 						AND
				trim(stringlib.stringtouppercase(left.input_guardian_first_name),left,right) 						=
				trim(stringlib.stringtouppercase(right.input_guardian_first_name),left,right) 						AND
				trim(stringlib.stringtouppercase(left.input_guardian_last_name),left,right) 							=
				trim(stringlib.stringtouppercase(right.input_guardian_last_name),left,right),
			true, false);

		RETURN match_flag;
	ENDMACRO;
		
	EXPORT addresses_match (pUpdateFile, pBaseToCheck) := FUNCTIONMACRO
	
		match_flag := IF(
				trim(stringlib.stringtouppercase(left.address_line1),left,right)						=
				trim(stringlib.stringtouppercase(right.address_line1),left,right)						AND
				trim(stringlib.stringtouppercase(left.address_line2),left,right)				=
				trim(stringlib.stringtouppercase(right.address_line2),left,right)				AND
				trim(stringlib.stringtouppercase(left.input_city),Left, Right)		=
				trim(stringlib.stringtouppercase(right.input_city),Left, Right) 	AND
				trim(stringlib.stringtouppercase(left.input_state),Left, Right) 	=
				trim(stringlib.stringtouppercase(right.input_state),Left, Right) 	AND
				trim(stringlib.stringtouppercase(left.input_zip),Left, Right) 					=
				trim(stringlib.stringtouppercase(right.input_zip),Left, Right) 					AND
				trim(stringlib.stringtouppercase(left.input_home_phone),Left, Right) 					=
				trim(stringlib.stringtouppercase(right.input_home_phone),Left, Right) 					AND
				trim(stringlib.stringtouppercase(left.input_alt_phone),Left, Right) 						=
				trim(stringlib.stringtouppercase(right.input_alt_phone),Left, Right) 					AND
				trim(stringlib.stringtouppercase(left.input_primary_email_address),Left, Right) 					=
				trim(stringlib.stringtouppercase(right.input_primary_email_address),Left, Right),
			TRUE, FALSE);
						
		RETURN match_flag;	
	ENDMACRO;
		
	EXPORT all_others_match (pUpdateFile, pBaseToCheck) := FUNCTIONMACRO
	
		match_flag := IF(
				trim(left.input_dob, all) = trim(right.input_dob, all)										AND	
				trim(left.input_guardian_dob, all) = trim(right.input_guardian_dob, all)										AND	
				trim(stringlib.stringtouppercase(left.input_gender),left,right)						=
				trim(stringlib.stringtouppercase(right.input_gender),left,right)						AND
				trim(stringlib.stringtouppercase(left.input_ssn),left,right)						=
				trim(stringlib.stringtouppercase(right.input_ssn),left,right)						AND
				trim(stringlib.stringtouppercase(left.input_guardian_ssn),left,right)				=
				trim(stringlib.stringtouppercase(right.input_guardian_ssn),left,right)				AND
				// left.input_lexid				=	right.input_lexid			AND
				// left.input_crk					=	right.input_crk				AND
				left.member_id					=	right.member_id				AND
				left.customer_id				=	right.customer_id			AND
				left.account_id					=	right.account_id			AND
				left.subscriber_id			=	right.subscriber_id		AND
				trim(stringlib.stringtouppercase(left.group_id),left,right)				=
				trim(stringlib.stringtouppercase(right.group_id),left,right)			AND
				trim(stringlib.stringtouppercase(left.relationship_code),left,right)				=
				trim(stringlib.stringtouppercase(right.relationship_code),left,right)				AND
				trim(stringlib.stringtouppercase(left.udf1),left,right)		=
				trim(stringlib.stringtouppercase(right.udf1),left,right)		AND
				trim(stringlib.stringtouppercase(left.udf2),left,right)		=
				trim(stringlib.stringtouppercase(right.udf2),left,right)		AND
				trim(stringlib.stringtouppercase(left.udf3),left,right)		=
				trim(stringlib.stringtouppercase(right.udf3),left,right),
			true, false);

		RETURN match_flag;
	ENDMACRO;

	EXPORT dist_and_sort_them (pFileToSort) := FUNCTIONMACRO
	
		temp_file_dist		:= distribute(pFileToSort, hash(
										// name fields
										trim(stringlib.stringtouppercase(input_last_name),left,right),
										trim(stringlib.stringtouppercase(input_first_name),left,right),
										trim(stringlib.stringtouppercase(input_middle_initial),left,right),
										trim(stringlib.stringtouppercase(input_suffix),left,right),
										trim(stringlib.stringtouppercase(input_full_name),left,right),
										trim(stringlib.stringtouppercase(input_guardian_last_name),left,right),
										trim(stringlib.stringtouppercase(input_guardian_first_name),left,right),
										// address fields
										trim(stringlib.stringtouppercase(address_line1),left,right),
										trim(stringlib.stringtouppercase(address_line2),left,right),
										trim(stringlib.stringtouppercase(input_city),left,right),
										trim(stringlib.stringtouppercase(input_state),left,right),
										trim(stringlib.stringtouppercase(input_zip),left,right),
										trim(stringlib.stringtouppercase(input_home_phone),left,right),
										trim(stringlib.stringtouppercase(input_alt_phone),left,right),
										trim(stringlib.stringtouppercase(input_primary_email_address),left,right),
										// other id fields
										trim(stringlib.stringfilterout(input_dob,'-.>$!%*@=?&\''),left,right),
										trim(stringlib.stringfilterout(input_guardian_dob,'-.>$!%*@=?&\''),left,right),
										trim(stringlib.stringtouppercase(input_gender),left,right),
										trim(stringlib.stringtouppercase(input_ssn),left,right),
										trim(stringlib.stringtouppercase(input_guardian_ssn),left,right),
										// input_lexid,input_crk,
										member_id,customer_id,account_id,subscriber_id,
										trim(stringlib.stringtouppercase(group_id),left,right),
										trim(stringlib.stringtouppercase(relationship_code),left,right),
										trim(stringlib.stringtouppercase(udf1),left,right),
										trim(stringlib.stringtouppercase(udf2),left,right),
										trim(stringlib.stringtouppercase(udf3),left,right)));
										// trim(stringlib.stringtouppercase(batch_jobid),left,right)));
										
		temp_file_sort := sort(temp_file_dist, 
										// name fields
										trim(stringlib.stringtouppercase(input_last_name),left,right),
										trim(stringlib.stringtouppercase(input_first_name),left,right),
										trim(stringlib.stringtouppercase(input_middle_initial),left,right),
										trim(stringlib.stringtouppercase(input_suffix),left,right),
										trim(stringlib.stringtouppercase(input_full_name),left,right),
										trim(stringlib.stringtouppercase(input_guardian_last_name),left,right),
										trim(stringlib.stringtouppercase(input_guardian_first_name),left,right),
										// address fields
										trim(stringlib.stringtouppercase(address_line1),left,right),
										trim(stringlib.stringtouppercase(address_line2),left,right),
										trim(stringlib.stringtouppercase(input_city),left,right),
										trim(stringlib.stringtouppercase(input_state),left,right),
										trim(stringlib.stringtouppercase(input_zip),left,right),
										trim(stringlib.stringtouppercase(input_home_phone),left,right),
										trim(stringlib.stringtouppercase(input_alt_phone),left,right),
										trim(stringlib.stringtouppercase(input_primary_email_address),left,right),
										// other id fields
										trim(stringlib.stringfilterout(input_dob,'-.>$!%*@=?&\''),left,right),
										trim(stringlib.stringfilterout(input_guardian_dob,'-.>$!%*@=?&\''),left,right),
										trim(stringlib.stringtouppercase(input_gender),left,right),
										trim(stringlib.stringtouppercase(input_ssn),left,right),
										trim(stringlib.stringtouppercase(input_guardian_ssn),left,right),
										// input_lexid,input_crk,
										member_id,customer_id,account_id,subscriber_id,
										trim(stringlib.stringtouppercase(group_id),left,right),
										trim(stringlib.stringtouppercase(relationship_code),left,right),
										trim(stringlib.stringtouppercase(udf1),left,right),
										trim(stringlib.stringtouppercase(udf2),left,right),
										trim(stringlib.stringtouppercase(udf3),left,right),
										// trim(stringlib.stringtouppercase(batch_jobid),left,right),
										-dt_vendor_last_reported, local);
										// local);
										
		RETURN temp_file_sort;
	ENDMACRO;	

	EXPORT roll_them_up (pFileToRoll)	:= FUNCTIONMACRO
	
		temp_sort_file	:= dist_and_sort_them(pFileToRoll);
		
		{pFileToRoll} roll_them(temp_sort_file L, temp_sort_file R) := TRANSFORM
			SELF.dt_first_seen            := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
			SELF.dt_last_seen             := max(L.dt_last_seen, R.dt_last_seen);
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF.startdate								:= ut.EarliestDate(L.startdate, r.startdate);
			SELF.source_rid               := min(L.source_rid, R.source_rid);
			SELF.batch_jobid							:= IF(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.batch_jobid, R.batch_jobid);
			SELF.batch_seq_number					:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.batch_seq_number, R.batch_seq_number);
			SELF.gcid_name								:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.gcid_name, R.gcid_name);
			SELF.rid											:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.rid, R.rid);
			SELF.nomatch_id								:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.nomatch_id, R.nomatch_id);
			SELF.lexid										:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.lexid, R.lexid);
			SELF.lexid_score							:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.lexid_score, R.lexid_score);
			SELF.guardian_lexid						:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.guardian_lexid, R.guardian_lexid);
			SELF.guardian_lexid_score			:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.guardian_lexid_score, R.guardian_lexid_score);
			SELF.append_option						:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.append_option, R.append_option);
			SELF.runtime_threshold				:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.runtime_threshold, R.runtime_threshold);
			SELF.history_mode							:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.history_mode, R.history_mode);
			SELF.input_crk								:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.input_crk, R.input_crk);
			SELF.input_lexid							:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.input_lexid, R.input_lexid);
			SELF.prev_crk									:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.prev_crk, R.prev_crk);
			SELF.prev_lexid								:= if(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.prev_lexid, R.prev_lexid);
			SELF						 		 				  := IF(L.history_or_current = 'C', L, R);	
		END;

		rolled_base := rollup(
							temp_sort_file,
								 trim(stringlib.stringtouppercase(left.input_last_name),left,right)								=
								 trim(stringlib.stringtouppercase(right.input_last_name),left,right)							AND
								 trim(stringlib.stringtouppercase(left.input_first_name),left,right)									=
								 trim(stringlib.stringtouppercase(right.input_first_name),left,right)								AND
								 trim(stringlib.stringtouppercase(left.input_middle_initial),left,right)								=
								 trim(stringlib.stringtouppercase(right.input_middle_initial),left,right)								AND
								 trim(stringlib.stringtouppercase(left.input_suffix),left,right)								=
								 trim(stringlib.stringtouppercase(right.input_suffix),left,right)								AND
								 trim(stringlib.stringtouppercase(left.input_full_name),left,right)							=
								 trim(stringlib.stringtouppercase(right.input_full_name),left,right)							AND
								 trim(stringlib.stringtouppercase(left.input_guardian_last_name),left,right)								=
								 trim(stringlib.stringtouppercase(right.input_guardian_last_name),left,right)							AND
								 trim(stringlib.stringtouppercase(left.input_guardian_first_name),left,right)							=
								 trim(stringlib.stringtouppercase(right.input_guardian_first_name),left,right)						AND
								 // address fields
								 trim(stringlib.stringtouppercase(left.address_line1),left,right)								=
								 trim(stringlib.stringtouppercase(right.address_line1),left,right)							AND
								 trim(stringlib.stringtouppercase(left.address_line2),left,right)				=
								 trim(stringlib.stringtouppercase(right.address_line2),left,right)				AND
								 trim(stringlib.stringtouppercase(left.input_city),left,right)		=
								 trim(stringlib.stringtouppercase(right.input_city),left,right)	AND
								 trim(stringlib.stringtouppercase(left.input_state),left,right)	=
								 trim(stringlib.stringtouppercase(right.input_state),left,right)AND
								 trim(stringlib.stringtouppercase(left.input_zip),left,right)							=
								 trim(stringlib.stringtouppercase(right.input_zip),left,right)							AND
								 trim(stringlib.stringtouppercase(left.input_home_phone),left,right)							=
								 trim(stringlib.stringtouppercase(right.input_home_phone),left,right)						AND
								 trim(stringlib.stringtouppercase(left.input_alt_phone),left,right)								=
								 trim(stringlib.stringtouppercase(right.input_alt_phone),left,right)							AND
								 trim(stringlib.stringtouppercase(left.input_primary_email_address),left,right)							=
								 trim(stringlib.stringtouppercase(right.input_primary_email_address),left,right)							AND
								 trim(left.input_dob, all) = trim(right.input_dob, all)										AND	
								 trim(left.input_guardian_dob, all) = trim(right.input_guardian_dob, all)												AND	
								 trim(stringlib.stringtouppercase(left.input_gender),left,right)										=
								 trim(stringlib.stringtouppercase(right.input_gender),left,right)										AND
								 trim(stringlib.stringtouppercase(left.input_ssn),left,right)										=
								 trim(stringlib.stringtouppercase(right.input_ssn),left,right)										AND
								 trim(stringlib.stringtouppercase(left.input_guardian_ssn),left,right)								=
								 trim(stringlib.stringtouppercase(right.input_guardian_ssn),left,right)								AND
								 // left.input_lexid			= right.input_lexid						AND
								 // left.input_crk				=	right.input_crk		AND
								 left.member_id				= right.member_id		AND
								 left.customer_id			=	right.customer_id		AND
								 left.account_id			=	right.account_id			AND
								 left.subscriber_id		=	right.subscriber_id						AND
								 trim(stringlib.stringtouppercase(left.group_id),left,right)									=
								 trim(stringlib.stringtouppercase(right.group_id),left,right)								AND
								 trim(stringlib.stringtouppercase(left.relationship_code),left,right)									=
								 trim(stringlib.stringtouppercase(right.relationship_code),left,right)								AND
								 trim(stringlib.stringtouppercase(left.udf1),left,right)								=
								 trim(stringlib.stringtouppercase(right.udf1),left,right)								AND
								 trim(stringlib.stringtouppercase(left.udf2),left,right)		=
								 trim(stringlib.stringtouppercase(right.udf2),left,right)		AND
								 trim(stringlib.stringtouppercase(left.udf3),left,right)		=
								 trim(stringlib.stringtouppercase(right.udf3),left,right),
					roll_them(LEFT, RIGHT),LOCAL);
					
		RETURN rolled_base;
	ENDMACRO;

	EXPORT check_and_fix (pRaw_date, pClean_date)	:= FUNCTIONMACRO

		check_fields	:= if(pRaw_date <> '' and (pClean_date = '00000000' or pClean_date = ''),
														(string)trim(stringlib.stringfilterout(pRaw_date,'-.>$!%*@=?&\''), left, right), 
														if(pClean_date <> '00000000', pClean_date, '00000000'));
		RETURN check_fields;
	ENDMACRO;	
	
	EXPORT mark_old (pBaseFile) := FUNCTIONMACRO
	
		old_base	:= project(pBaseFile, TRANSFORM(UPI_DataBuild__old.Layouts_V2.Input_processing, 
				SELF.current_input		:= 'N',
				SELF.batch_seq_number := '',
				SELF.batch_jobid			:= '',
				SELF.prev_crk					:= '',
				SELF.prev_lexid				:= 0,
				SELF.crk_changed			:= '',
				SELF.lexid_changed		:= '',
				SELF								:= left));
		deduped_old_base := dedup(sort(old_base, record, local), record, local);
		RETURN deduped_old_base;
	ENDMACRO;
	
	EXPORT Pre_Process_Input := FUNCTION
					
				stdInput0		:= UPI_DataBuild__old.Standardize_V2(pVersion, pUseProd, gcid, pLexidThreshold, pHistMode, gcid_name, pBatch_jobID, pAppendOption).common_stamping;
				
				stdInput		:= Get_Preferred_Name(stdInput0); 
				
												
   		RETURN stdInput;
   	END;	
							
 	EXPORT Processed_Input:= FUNCTION
	
				use_threshold					:= if(pAppendOption = '4', 90, pLexidThreshold);
												
				pre_processed_input		:=  Append_LexID(pVersion, pUseProd, gcid, use_threshold, pHistMode, pBatch_jobID, pre_process_input).LexID_Append;

								
				previous_base		:= IF((NOTHOR(FileServices.GetSuperFileSubCount(UPI_DataBuild__old.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_lBaseTemplate_built)) = 0)
														OR pHistMode = 'N'
														,dataset([],UPI_DataBuild__old.Layouts_V2.input_processing)
														,mark_old(project(UPI_DataBuild__old.Files_V2(pVersion,pUseProd,gcid,pHistMode).member_base.qa, 
																				transform(UPI_DataBuild__old.Layouts_V2.Input_processing, self := left, self := []))));
												 						
				stdInput			:= dist_and_sort_them(pre_processed_input);
				
				ds_current		:= dist_and_sort_them(roll_them_up(previous_base));
				
				// Right now we don't care about historical only records, that will be handled after CRK results
				// First we want to compare the new input to the old base to re-use source_rid for any previously
				// processed individuals (where we can clearly identify as the same individual)
				UPI_DataBuild__old.Layouts_V2.input_processing reuse_existing_source_rids(UPI_DataBuild__old.Layouts_V2.input_processing new_update, UPI_DataBuild__old.Layouts_v2.input_processing last_built_base) := TRANSFORM
					SELF.source_rid								:= last_built_base.source_rid;
					SELF.prev_crk									:= new_update.input_crk;
					SELF.prev_lexid								:= new_update.input_lexid;
					SELF 													:= new_update;
					SELF													:= [];
				END;
				
				assign_existing_source_rids := DEDUP(SORT(JOIN(stdInput, ds_current, 
									name_fields_match(stdInput, ds_current)		AND
									addresses_match(stdInput, ds_current)			AND
									all_others_match(stdInput, ds_current),
								reuse_existing_source_rids(LEFT, RIGHT),LEFT OUTER, LOCAL), RECORD, LOCAL), RECORD, LOCAL);	
								
				no_existing_source_rids 	:= assign_existing_source_rids(source_rid = 0);
				with_existing_source_rids	:= assign_existing_source_rids(source_rid > 0);				
				// Second join - this one is to identify the truly new records and assign new source_rids
		
				UPI_DataBuild__old.Layouts_V2.input_processing find_new_recs(UPI_DataBuild__old.Layouts_V2.input_processing new_update, UPI_DataBuild__old.Layouts_V2.input_processing last_built_base) := TRANSFORM
					SELF.current_input						:= 'Y';
					SELF.batch_jobid							:= new_update.batch_jobid;
					SELF.batch_seq_number					:= new_update.batch_seq_number;
					SELF.prev_crk									:= if(pHistMode = 'A', last_built_base.crk, new_update.input_crk);
					SELF.prev_lexid								:= if(pHistMode = 'A', last_built_base.lexid, new_update.input_lexid);
					SELF 													:= new_update;
					SELF													:= [];
				END;

				truly_new_recs := JOIN(no_existing_source_rids, ds_current,
									name_fields_match(no_existing_source_rids, ds_current)		AND
									addresses_match(no_existing_source_rids, ds_current)			AND
									all_others_match(no_existing_source_rids, ds_current),
								find_new_recs(LEFT, RIGHT), LEFT ONLY, LOCAL);

				// add the two together to assign new source_rids
				recombined_input	:= with_existing_source_rids + truly_new_recs;  
								
				need_rid					:= recombined_input(source_rid = 0);
				has_rid						:= recombined_input(source_rid > 0);
	
				max_rid 					:= MAX(previous_base, source_rid); 
	
				ut.MAC_Sequence_Records_3(need_rid,source_rid,(max_rid + 1),new_rid); 
				
				all_rids	:= has_rid + new_rid;
				
   		RETURN sort(all_rids, batch_seq_number);
	END;
		
 	EXPORT Add_CRK_results := FUNCTION
				
				crk_results				:= HealthcareNoMatchHeader_Ingest.Files(gcid).CRK;
								
				linked_input_file	:= UPI_DataBuild__old.Files_V2(pVersion,pUseProd,gcid,pHistMode).processed_input.new;
				
				previous_base		:= IF(NOTHOR(FileServices.GetSuperFileSubCount(UPI_DataBuild__old.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_lBaseTemplate_built)) = 0
														OR pHistMode = 'N'
														,dataset([],UPI_DataBuild__old.Layouts_V2.input_processing)
														,mark_old(project(UPI_DataBuild__old.Files_V2(pVersion,pUseProd,gcid,pHistMode).member_base.qa, 
																				transform(UPI_DataBuild__old.Layouts_V2.Input_processing, self := left, self := []))));
				
				update_current_batch	:= dedup(sort(join(sort(distribute(crk_results,hash(source_rid)),source_rid,local)
														,sort(distribute(linked_input_file,hash(source_rid)),source_rid,local)
														,LEFT.source_rid = RIGHT.source_rid AND
														 RIGHT.current_input = 'Y'
														,TRANSFORM(UPI_DataBuild__old.Layouts_V2.input_processing
																,SELF.input_crk			:= RIGHT.input_crk
																,SELF.input_lexid		:= RIGHT.input_lexid
																,SELF.prev_crk			:= RIGHT.prev_crk
																,SELF.prev_lexid		:= RIGHT.prev_lexid
																,SELF.crk						:= LEFT.crk
																,SELF.nomatch_id		:= LEFT.nomatch_id
																,SELF.rid						:= LEFT.rid
																,SELF.crk_changed		:= map(RIGHT.input_crk <> '' AND RIGHT.input_crk =  LEFT.crk => 'N'
																													,RIGHT.input_crk <> '' AND RIGHT.input_crk <> LEFT.crk => 'Y'
																													,RIGHT.input_crk = '' => ''
																													,'')
																,SELF.lexid_changed	:= map(RIGHT.input_lexid > 0 AND RIGHT.input_lexid =  LEFT.lexid => 'N'
																													,RIGHT.input_lexid > 0 AND RIGHT.input_lexid <> LEFT.lexid => 'Y'
																													,RIGHT.input_lexid = 0 => ''
																													,'')
																,SELF           		:= RIGHT
																,SELF								:= LEFT)
														,RIGHT OUTER
														,LOCAL), RECORD, LOCAL), RECORD, LOCAL);
				
				update_older_records	:= dedup(sort(join(sort(distribute(crk_results,hash(source_rid)),source_rid,local)
														,sort(distribute(previous_base,hash(source_rid)),source_rid,local)
														,LEFT.source_rid = RIGHT.source_rid AND
														 RIGHT.current_input = 'N'
														,TRANSFORM({previous_base}
																,SELF.input_crk			:= RIGHT.input_crk
																,SELF.input_lexid		:= RIGHT.input_lexid
																,SELF.prev_crk			:= RIGHT.prev_crk
																,SELF.prev_lexid		:= RIGHT.prev_lexid
																,SELF.crk						:= LEFT.crk
																,SELF.nomatch_id		:= LEFT.nomatch_id
																,SELF.rid						:= LEFT.rid
																,SELF.crk_changed		:= map(RIGHT.input_crk <> '' AND RIGHT.input_crk =  LEFT.crk => 'N'
																													,RIGHT.input_crk <> '' AND RIGHT.input_crk <> LEFT.crk => 'Y'
																													,RIGHT.input_crk = '' => ''
																													,'')
																,SELF.lexid_changed	:= map(RIGHT.input_lexid > 0 AND RIGHT.input_lexid =  LEFT.lexid => 'N'
																													,RIGHT.input_lexid > 0 AND RIGHT.input_lexid <> LEFT.lexid => 'Y'
																													,RIGHT.input_lexid = 0 => ''
																													,'')
																,SELF           		:= RIGHT)
														,RIGHT OUTER
														,LOCAL), RECORD, LOCAL), RECORD, LOCAL);
														
				ds_current		:= dedup(sort(update_older_records, record, local), record, local);	

				stdInput := dedup(sort(update_current_batch, record, local), record, local);
				
				// First of a series of 3 joins - the first is to determine the truly historical records, which in this build logic are those
				// that have previously been processed, and then do not appear again in the new update
				UPI_DataBuild__old.Layouts_V2.input_processing find_truly_historical(UPI_DataBuild__old.Layouts_V2.input_processing new_update, UPI_DataBuild__old.Layouts_V2.input_processing last_built_base) := TRANSFORM
					SELF.enddate									:= 99991231;
					SELF.history_or_current 			:= 'H'; 
					SELF.dt_first_seen						:= ut.EarliestDate(new_update.dt_first_seen, last_built_base.dt_first_seen);
					SELF.dt_vendor_first_reported	:= ut.EarliestDate(new_update.dt_vendor_first_reported, last_built_base.dt_vendor_first_reported);
					SELF.dt_vendor_last_reported	:= max(new_update.dt_vendor_last_reported, last_built_base.dt_vendor_last_reported);
					SELF.dt_last_seen							:= max(new_update.dt_last_seen, last_built_base.dt_last_seen);
					SELF.batch_jobid							:= new_update.batch_jobid;
					SELF.batch_seq_number					:= new_update.batch_jobid;
					SELF.gcid_name								:= new_update.gcid_name;
					SELF.prev_crk									:= new_update.input_crk;
					SELF.prev_lexid								:= new_update.input_lexid;
					SELF.input_crk								:= new_update.input_crk;
					SELF.input_lexid							:= new_update.input_lexid;
					SELF 													:= last_built_base;
					SELF													:= [];
				END;

				historical_only := dedup(sort(JOIN(stdInput, ds_current, 
									name_fields_match(stdInput, ds_current)		AND
									addresses_match(stdInput, ds_current)			AND
									all_others_match(stdInput, ds_current),
								find_truly_historical(LEFT, RIGHT), RIGHT ONLY, LOCAL), RECORD, LOCAL), RECORD, LOCAL);
								
				// Second join, this one is to update the records that have been seen previously and update the dt_last_seen and 
				// dt_vendor_last_reported, and make sure the history_or_current flag is C
		
				UPI_DataBuild__old.Layouts_V2.input_processing update_already_seen_recs(UPI_DataBuild__old.Layouts_V2.input_processing new_update, UPI_DataBuild__old.Layouts_V2.input_processing last_built_base) := TRANSFORM
					SELF.dt_first_seen            := ut.EarliestDate(new_update.dt_first_seen, last_built_base.dt_first_seen);
					SELF.dt_last_seen             := max(new_update.dt_last_seen, last_built_base.dt_last_seen);
					SELF.dt_vendor_first_reported := ut.EarliestDate(new_update.dt_vendor_first_reported, last_built_base.dt_vendor_first_reported);
					SELF.dt_vendor_last_reported  := max(new_update.dt_vendor_last_reported, last_built_base.dt_vendor_last_reported);
					SELF.startdate								:= ut.EarliestDate((unsigned4)pVersion[1..8], last_built_base.startdate);
					SELF.enddate									:= 99991231;
					SELF.history_or_current 			:= 'C';
					SELF.batch_jobid							:= new_update.batch_jobid;
					SELF.batch_seq_number					:= new_update.batch_seq_number;
					SELF.gcid_name								:= new_update.gcid_name;
					SELF.prev_crk									:= new_update.input_crk;
					SELF.prev_lexid								:= new_update.input_lexid;
					SELF.input_crk								:= new_update.input_crk;
					SELF.input_lexid							:= new_update.input_lexid;
					SELF.current_input						:= 'Y';
					SELF 													:= new_update;
					SELF													:= [];
				END;
				
				update_existing_recs := JOIN(sort(stdInput, source_rid), sort(ds_current, source_rid),
									LEFT.source_rid = RIGHT.source_rid				AND
									name_fields_match(stdInput, ds_current)		AND
									addresses_match(stdInput, ds_current)			AND
									all_others_match(stdInput, ds_current),
								update_already_seen_recs(LEFT, RIGHT), LEFT OUTER, LOCAL);	
								
				still_need_update	:= dedup(sort(update_existing_recs(crk = ''), record, local), record, local);
				has_update				:= dedup(sort(update_existing_recs(crk <> ''), record, local), record, local);
								
				// Last of three joins - this one is to identify the truly new records and process them as usual
		
				UPI_DataBuild__old.Layouts_V2.input_processing find_new_recs(UPI_DataBuild__old.Layouts_V2.input_processing new_update, UPI_DataBuild__old.Layouts_V2.input_processing last_built_base) := TRANSFORM
					SELF.history_or_current := 'C';
					SELF.prev_crk			:= new_update.input_crk;
					SELF.prev_lexid		:= new_update.input_lexid;
					SELF.input_crk		:= new_update.input_crk;
					SELF.input_lexid	:= new_update.input_lexid;
					SELF 							:= new_update;
					SELF							:= [];
				END;

				truly_new_recs := JOIN(still_need_update, ds_current,
									name_fields_match(still_need_update, ds_current)		AND
									addresses_match(still_need_update, ds_current)			AND
									all_others_match(still_need_update, ds_current)			AND
									LEFT.batch_seq_number <> '',
								find_new_recs(LEFT, RIGHT), LEFT ONLY, LOCAL);

				// add all three pieces together
				recombined 		:= historical_only + has_update + truly_new_recs; 
				
				dedup_recombined	:= dedup(sort(recombined, record, local), record, local);

				new_base	:= PROJECT(dedup_recombined
														,TRANSFORM({UPI_DataBuild__old.Layouts_V2.input_processing}
																,SELF.crk_changed		:= map(LEFT.input_crk <> '' AND LEFT.input_crk =  LEFT.crk => 'N'
																													,LEFT.input_crk <> '' AND LEFT.input_crk <> LEFT.crk => 'Y'
																													,LEFT.input_crk = '' => ''
																													,'')
																,SELF.lexid_changed	:= map(LEFT.input_lexid > 0 AND LEFT.input_lexid =  LEFT.lexid => 'N'
																													,LEFT.input_lexid > 0 AND LEFT.input_lexid <> LEFT.lexid => 'Y'
																													,LEFT.input_lexid = 0 => ''
																													,'')
																,SELF           		:= LEFT));
																
				// dedup_base	:= dedup(sort(new_base, record, local), record, local);	
					
   		RETURN distribute(new_base);
   	END; 
		
		EXPORT PrepReturn			:= FUNCTION
		   	
   				this_batch_only	:= dedup(Add_CRK_Results(batch_jobid = pBatch_jobID), record);
   					
   				prepReturn_file		:= UPI_DataBuild__old.ReturnToBatch(pVersion, pUseProd, gcid, this_batch_only, pAppendOption).batch_processing;
						
					RETURN sort(prepReturn_file, batch_seq_number);
		END;

 		EXPORT Return_ToBatch := FUNCTION
   					
					slimReturn	:= project(prepReturn, UPI_DataBuild__old.layouts_V2.to_batch);
					
					sortReturn	:= sort(slimReturn, (integer)batch_seq_number);
						
      		RETURN sortReturn;
   		END;	
		
 	EXPORT Return_Metrics	:= FUNCTION
   	
   				this_batch_only	:= prepReturn;
   				
   				prepMetrics		:= UPI_DataBuild__old.Metrics_Report(pVersion, pUseProd, gcid, this_batch_only, pHistMode).get_all;
   				
   			RETURN prepMetrics;
   	END;
		
 	EXPORT Slim_Report	:= FUNCTION
   	
   				this_batch_only	:= prepReturn;
   				
   				slim_down				:= project(this_batch_only, UPI_DataBuild__old.Layouts_V2.slim_history);
   				
   			RETURN slim_down;
   	END;
	
  	EXPORT All_Data_Base := FUNCTION
   	
   			new_base			:= project(Add_CRK_results, UPI_DataBuild__old.Layouts_V2.base); 
 				rolled_base		:= dist_and_sort_them(roll_them_up(new_base));
  			
   			RETURN rolled_base;
   	END;
												
END;