EXPORT mac_assign_lnpid_with_description  (Infile,Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_SNAME = '',Input_GENDER = '',
																									Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',
																									Input_ST = '',Input_ZIP = '',Input_SSN = '',Input_DOB = '',Input_PHONE = '',Input_LIC_STATE = '',Input_LIC_NBR = '',
																									Input_TAX_ID = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',
																									Input_UPIN = '',Input_DID = '',Input_BDID = '',Input_SRC = '',
																									Input_SOURCE_RID = '', forcePull = false, weight_score = 30, distance = 0,appendPrefix = '\'\'') := FUNCTIONMACRO
		IMPORT Health_Provider_Services;																
		OutPut_Rec := RECORD
			RECORDOF (Infile);
			UNSIGNED8   #EXPAND(appendPrefix + 'LNPID');
			UNSIGNED2   #EXPAND(appendPrefix + 'PIDWeight');
			UNSIGNED2   #EXPAND(appendPrefix + 'PIDDistance');
		END;

		asIndex := if(forcePull = true, false, if(thorlib.nodes() < 400 or count(infile) < 13000000, true, false));

		ut.hasField(infile, UniqueId, hasUniqueId);

		layout_seq := record
			#IF (~hasUniqueID) unsigned8 uniqueID; #END	
			RECORDOF	(Infile);
			UNSIGNED8 #EXPAND(appendPrefix + 'LNPID')					:= 0;
			UNSIGNED2 #EXPAND(appendPrefix + 'PIDWeight') 				:= 0;
			UNSIGNED2 #EXPAND(appendPrefix + 'PIDDistance')			:= 0;
			UNSIGNED2 #EXPAND(appendPrefix + 'Score') 				:= 0;
			UNSIGNED4 #EXPAND(appendPrefix + 'Keys_Used') 		:= 0;
			STRING20 	#EXPAND(appendPrefix + 'Matches') 			:= '';
			STRING		#EXPAND(appendPrefix + 'Keys_Desc') 		:= '';
			STRING		#EXPAND(appendPrefix + 'Matches_Desc') 	:= '';
		end;

	layout_seq AssignSeq (Infile L, UNSIGNED4 Cnt) := transform
		SELF.uniqueID := #IF (hasUniqueID) L.UniqueID; #ELSE Cnt; #END
		SELF := l;
	END;

	infile_seq_1 := PROJECT (Infile, AssignSeq (LEFT, COUNTER));
	
	infile_seq := if(asIndex, distribute(infile_seq_1, uniqueId), infile_seq_1);
	
/*-------------------------------- Thor Search -------------------------------------------*/
	Health_Provider_Services.MAC_MEOW_xLNPID_Batch(infile_seq,uniqueID,Input_FNAME,Input_MNAME,Input_LNAME,Input_SNAME,Input_GENDER,
																																				Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_V_CITY_NAME,Input_ST,Input_ZIP,
																																				Input_SSN,Input_SSN,Input_DOB,Input_DOB,Input_Phone,Input_LIC_STATE,Input_LIC_NBR,
																																				// Input_TAX_ID,Input_TAX_ID,Input_DEA_NUMBER,Input_VENDOR_ID,Input_NPI_NUMBER,Input_NPI_NUMBER,
																																				,,Input_DEA_NUMBER,Input_VENDOR_ID,Input_NPI_NUMBER,Input_NPI_NUMBER,
																																				Input_UPIN,Input_DID,Input_BDID,
																																				Input_SRC,Input_SOURCE_RID,,,,,,,result_thor, asIndex);		

	Health_Provider_Services.mac_trim_xLNPID_layout(result_thor, result_thor_trim);
/*------- Final Result ----*/

// %result% := %result_thor_trim%;
result := result_thor;
/*----------------- Join input dataset and results using reference id ---------------------*/

infiledist := DISTRIBUTE(infile_seq, uniqueId);
exlinkdist := DISTRIBUTE(result, reference);

layout_ref := record
	unsigned8 uniqueID;
	unsigned8 prefix_lnpid;
	recordof(infile);
	unsigned3	weight;
	unsigned4 keys_tried;
  unsigned2 pid_weight;
  unsigned2 pid_score := 0;
  unsigned4 pid_keys_used;
  unsigned2 pid_distance;
  string20 	pid_matches;
  string		pid_keys_desc;
  string		pid_matches_desc;
end;

layout_ref assignDID (infiledist l, exlinkdist r) := TRANSFORM
	isNameMatch 				:= r.results[1].FNAMEWeight > 0 or r.results[1].LNAMEWeight > 0 or r.results[1].mainnameWeight > 0 or r.results[1].fullnameWeight > 0; 
	idlWeightDiff := if(count(r.results) > 1, r.results[1].weight - r.results[2].weight, 0);
	totalResults 	:= count(r.results);
	self.prefix_lnpid 		:= if((idlWeightDiff >= distance or totalResults = 1)  and r.results[1].weight >= weight_score and isNameMatch, r.results[1].lnpid, 0);
  self.pid_weight 			:= r.results[1].weight;
  self.pid_keys_used := r.results[1].keys_used;
  self.pid_distance		:= idlWeightDiff;
  self.pid_matches 		:= 	IF (r.results[1].FNAME_match_code	 	 = 99, '-',  (STRING)r.results[1].FNAME_match_code) + '/' + 
																		IF (r.results[1].MNAME_match_code 	 	 = 99, '-',  (STRING)r.results[1].MNAME_match_code) + '/' + 
																		IF (r.results[1].LNAME_match_code 		 = 99, '-',  (STRING)r.results[1].LNAME_match_code) + '/' + 
																		IF (r.results[1].SNAME_match_code 		 = 99, '-',  (STRING)r.results[1].SNAME_match_code) + '/' + 
																		IF (r.results[1].GENDER_match_code	 	 = 99, '-',  (STRING)r.results[1].GENDER_match_code) + '/' + 
																		IF (r.results[1].PRIM_RANGE_match_code  	 = 99, '-',  (STRING)r.results[1].PRIM_RANGE_match_code) + '/' + 
																		IF (r.results[1].PRIM_NAME_match_code	 	 = 99, '-',  (STRING)r.results[1].PRIM_NAME_match_code) + '/' + 
																		IF (r.results[1].SEC_RANGE_match_code 	 	 = 99, '-',  (STRING)r.results[1].SEC_RANGE_match_code) + '/' + 
																		IF (r.results[1].V_CITY_NAME_match_code 	 = 99, '-',  (STRING)r.results[1].V_CITY_NAME_match_code) + '/' + 
																		IF (r.results[1].ST_match_code 		 	 = 99, '-',  (STRING)r.results[1].ST_match_code) + '/' + 
																		IF (r.results[1].ZIP_match_code 	 	 = 99, '-',  (STRING)r.results[1].ZIP_match_code) + '/' + 
																		IF (r.results[1].SSN_match_code 	 	 = 99, '-',  (STRING)r.results[1].SSN_match_code) + '/' + 
																		IF (r.results[1].CNSMR_SSN_match_code 	 	 = 99, '-',  (STRING)r.results[1].CNSMR_SSN_match_code) + '/' + 
																		IF (r.results[1].DOB_year_match_code		 = 99, '-',  (STRING)r.results[1].DOB_year_match_code) + '/' + 
																		IF (r.results[1].DOB_month_match_code		 = 99, '-',  (STRING)r.results[1].DOB_month_match_code) + '/' + 
																		IF (r.results[1].DOB_day_match_code		 = 99, '-',  (STRING)r.results[1].DOB_day_match_code) + '/' + 
																		IF (r.results[1].CNSMR_DOB_year_match_code 	 = 99, '-',  (STRING)r.results[1].CNSMR_DOB_year_match_code) + '/' + 
																		IF (r.results[1].CNSMR_DOB_month_match_code	 = 99, '-',  (STRING)r.results[1].CNSMR_DOB_month_match_code) + '/' + 
																		IF (r.results[1].CNSMR_DOB_day_match_code	 = 99, '-',  (STRING)r.results[1].CNSMR_DOB_day_match_code) + '/' + 
																		IF (r.results[1].PHONE_match_code		 = 99, '-',  (STRING)r.results[1].PHONE_match_code) + '/' + 
																		IF (r.results[1].LIC_STATE_match_code		 = 99, '-',  (STRING)r.results[1].LIC_STATE_match_code) + '/' + 
																		IF (r.results[1].C_LIC_NBR_match_code		 = 99, '-',  (STRING)r.results[1].C_LIC_NBR_match_code) + '/' + 
																		IF (r.results[1].TAX_ID_match_code		 = 99, '-',  (STRING)r.results[1].TAX_ID_match_code) + '/' + 
																		IF (r.results[1].BILLING_TAX_ID_match_code	 = 99, '-',  (STRING)r.results[1].BILLING_TAX_ID_match_code) + '/' + 
																		IF (r.results[1].DEA_NUMBER_match_code	 	 = 99, '-',  (STRING)r.results[1].DEA_NUMBER_match_code) + '/' + 
																		IF (r.results[1].VENDOR_ID_match_code		 = 99, '-',  (STRING)r.results[1].VENDOR_ID_match_code) + '/' + 
																		IF (r.results[1].NPI_NUMBER_match_code	 	 = 99, '-',  (STRING)r.results[1].NPI_NUMBER_match_code) + '/' + 
																		IF (r.results[1].BILLING_NPI_NUMBER_match_code 	 = 99, '-',  (STRING)r.results[1].BILLING_NPI_NUMBER_match_code) + '/' + 
																		IF (r.results[1].UPIN_match_code		 = 99, '-',  (STRING)r.results[1].UPIN_match_code) + '/' + 
																		IF (r.results[1].DID_match_code			 = 99, '-',  (STRING)r.results[1].DID_match_code) + '/' + 
																		IF (r.results[1].BDID_match_code	 	 = 99, '-',  (STRING)r.results[1].BDID_match_code) + '/' + 
																		IF (r.results[1].SRC_match_code			 = 99, '-',  (STRING)r.results[1].SRC_match_code) + '/' + 
																		IF (r.results[1].SOURCE_RID_match_code		 = 99, '-',  (STRING)r.results[1].SOURCE_RID_match_code) + '/' + 
																		IF (r.results[1].RID_match_code 	 	 = 99, '-',  (STRING)r.results[1].RID_match_code) + '/' + 
																		IF (r.results[1].MAINNAME_match_code		 = 99, '-',  (STRING)r.results[1].MAINNAME_match_code) + '/' + 
																		IF (r.results[1].FULLNAME_match_code		 = 99, '-',  (STRING)r.results[1].FULLNAME_match_code) + '/' + 
																		IF (r.results[1].ADDR1_match_code 		 = 99, '-',  (STRING)r.results[1].ADDR1_match_code) + '/' + 
																		IF (r.results[1].LOCALE_match_code 		 = 99, '-',  (STRING)r.results[1].LOCALE_match_code) + '/' + 
																		IF (r.results[1].ADDRESS_match_code 		 = 99, '-',  (STRING)r.results[1].ADDRESS_match_code);
  self.pid_keys_desc := Health_Provider_Services.Process_xLNPID_Layouts.KeysUsedToText(r.results[1].keys_used);
	noMatch := [(String)SALT29.MatchCode.OneComponentNull, (String)SALT29.MatchCode.OneSideNull, '0', '-'];
	m := self.pid_matches;
	matchSet := StringLib.SplitWords(m, '/', false);
	res := IF(TRIM(M)='',m, 
				IF(matchSet[1] not in noMatch, 'FNAME,', '')  + 
				IF(matchSet[2] not in noMatch, 'MNAME,', '') + 
				IF(matchSet[3] not in noMatch, 'LNAME,', '')  + 
				IF(matchSet[4] not in noMatch, 'SNAME,', '') + 
				IF(matchSet[5] not in noMatch, 'GENDER,', '') + 
				IF(matchSet[6] not in noMatch, 'PRIM_RANGE,', '')  + 
				IF(matchSet[7] not in noMatch, 'PRIM_NAME,', '') + 
				IF(matchSet[8] not in noMatch, 'SEC_RANGE,', '')   + 
				IF(matchSet[9] not in noMatch, 'V_CITY_NAME,', '') + 
				IF(matchSet[10] not in noMatch,'ST,', '') 	    + 
				IF(matchSet[11] not in noMatch,'ZIP,', '') + 
				IF(matchSet[12] not in noMatch,'SSN,', '')         + 
				IF(matchSet[13] not in noMatch,'CNSMR_SSN,', '')         + 
				IF(matchSet[14] not in noMatch,'DOB_YEAR,', '')      +
				IF(matchSet[15] not in noMatch,'DOB_MONTH,', '')      +
				IF(matchSet[16] not in noMatch,'DOB_DAY,', '')      +							
				IF(matchSet[17] not in noMatch,'CNSMR_DOB_YEAR,', '')      +
				IF(matchSet[18] not in noMatch,'CNSMR_DOB_MONTH,', '')      +
				IF(matchSet[19] not in noMatch,'CNSMR_DOB_DAY,', '')      +							
				IF(matchSet[20] not in noMatch,'PHONE,', '')       + 
				IF(matchSet[21] not in noMatch,'LIC_STATE,', '') + 
				IF(matchSet[22] not in noMatch,'C_LIC_NBR,', '')      + 
				IF(matchSet[23] not in noMatch,'TAX_ID,', '')      + 
				IF(matchSet[24] not in noMatch,'BILLING_TAX_ID,', '')      + 
				IF(matchSet[25] not in noMatch,'DEA_NUMBER,', '')      + 
				IF(matchSet[26] not in noMatch,'VENDOR_ID,', '')      + 
				IF(matchSet[27] not in noMatch,'NPI_NUMBER,', '')      + 
				IF(matchSet[28] not in noMatch,'BILLING_NPI_NUMBER,', '')      + 
				IF(matchSet[29] not in noMatch,'UPIN,', '')      + 
				IF(matchSet[30] not in noMatch,'DID,', '')      + 
				IF(matchSet[31] not in noMatch,'BDID,', '')      + 				
				IF(matchSet[32] not in noMatch,'SRC,', '') + 
				IF(matchSet[33] not in noMatch,'SOURCE_RID,', '')  + 
				IF(matchSet[34] not in noMatch,'RID,', '') + 
				IF(matchSet[35] not in noMatch,'MAINNAME,', '') + 
				IF(matchSet[36] not in noMatch,'FULLNAME,', '') + 
				IF(matchSet[37] not in noMatch,'ADDR1,', '') + 
				IF(matchSet[38] not in noMatch,'LOCALE,', '') + 				
				IF(matchSet[39] not in noMatch,'ADDRESS,', ''));							
  self.pid_matches_desc 	:= res;
  self.pid_score := r.results[1].score; 
	self := l;
	self := [];
end;

outfile := JOIN (infiledist, exlinkdist, left.uniqueid = right.reference, assignDID(left, right), left outer, local);

RETURN PROJECT (Outfile,TRANSFORM(OutPut_Rec, 
	SELF.#EXPAND(appendPrefix + 'LNPID') := LEFT.prefix_lnpid;
	SELF.#EXPAND(appendPrefix + 'PIDWeight') := LEFT.pid_weight;
	SELF.#EXPAND(appendPrefix + 'PIDDistance') := LEFT.pid_distance;
	SELF := LEFT;
	SELF := [];
		));
ENDMACRO;														
