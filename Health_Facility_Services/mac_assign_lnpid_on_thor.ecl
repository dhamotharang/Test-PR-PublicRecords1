export mac_assign_lnpid_on_thor (infile,Input_CNAME = '',
															Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',Input_ST = '',Input_ZIP = '',
															Input_TAX_ID = '',Input_FEIN = '',Input_PHONE = '',Input_FAX = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',
															Input_NPI_NUMBER = '',Input_CLIA_NUMBER = '',
															Input_MEDICARE_FACILITY_NUMBER = '',Input_MEDICAID_NUMBER = '',Input_NCPDP_NUMBER = '',Input_TAXONOMY = '', Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',
															OutFile, forcePull = false, weight_score = 38, distance = 6) := MACRO

import ecl, BIPV2_Company_Names;

#uniquename(asindex)
%asIndex% := if(forcePull = true, false, if(thorlib.nodes() < 400 or count(infile) < 13000000, true, false));

#UNIQUENAME(hasUniqueId)
ut.hasField(infile, UniqueId, %hasUniqueId%);

#uniquename(layout_seq)
%layout_seq% := record
	#IF (~%hasUniqueID%) unsigned8 uniqueID; #END	
	unsigned8 lnfid;
	recordof(infile);
	string250 cnp_name;
	string10 cnp_number;	
	string10 cnp_store_number;
	string10 cnp_btype;		
	string20 cnp_lowv;
	string2 iTaxonomy_code;	
  unsigned2 pid_weight 			:= 0;
  unsigned2 pid_score 				:= 0;
  unsigned4 pid_keys_used := 0;
  unsigned2 pid_distance			:= 0;
  string20 	pid_matches 			:= '';
  string	pid_keys_desc 			:= '';
  string	pid_matches_desc 	:= '';
end;

#uniquename(AssignSeq)
%layout_seq% %AssignSeq%(infile l, unsigned4 cnt) := transform
	self.uniqueID := #IF (%hasUniqueID%) l.uniqueID; #ELSE cnt; #END
	self.lnfid := 0;
  #IF ( #TEXT(Input_CNAME) <> '' )
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))l.Input_CNAME;
  #ELSE
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))'';
  #END
	SELF.iTaxonomy_code := (TYPEOF(SELF.Input_Taxonomy))l.Input_Taxonomy[1..2];
	self := l;
	self := [];
end;

#uniquename(infile_seq_1)
%infile_seq_1% := project(infile, %AssignSeq%(left, counter));
#uniquename(infile_seq)
%infile_seq% := if(%asIndex%, distribute(%infile_seq_1%, uniqueId), %infile_seq_1%);

#uniquename(add_cnp_nameid)
%add_cnp_nameid% := project (%infile_seq%,transform(BIPV2_Company_Names.layouts.layout_names,self.cnp_nameid := left.uniqueId; self.cnp_name := left.cnp_name; self := []));

#uniquename(clean_cname)
%clean_cname% := BIPV2_Company_Names.functions.go(%add_cnp_nameid%,TRUE,FALSE);
	
#uniquename(apply_clean_cname)
%apply_clean_cname% := join (%infile_seq%,%clean_cname%,left.uniqueId = right.cnp_nameid,
													transform (%layout_seq%,
																		 // SELF.cnp_nameid				:= RIGHT.cnp_nameid;
																		 SELF.cnp_name					:= RIGHT.cnp_name;
																		 SELF.cnp_number				:= RIGHT.cnp_number;
																		 SELF.cnp_store_number	:= RIGHT.cnp_store_number;
																		 SELF.cnp_btype					:= RIGHT.cnp_btype;
																		 SELF.cnp_lowv					:= RIGHT.cnp_lowv;
																		 SELF := LEFT;),LEFT OUTER,LOCAL);

//output (%apply_clean_cname%);
/*-------------------------------- Thor Search -------------------------------------------*/
#uniquename(result_thor)
Health_Facility_Services.MAC_MEOW_xLNPID_Batch(%apply_clean_cname%,uniqueID,Input_CNAME,CNP_NAME,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,
											Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_V_CITY_NAME,Input_ST,Input_ZIP,
											Input_TAX_ID,Input_FEIN,Input_PHONE,Input_FAX,Input_LIC_STATE,Input_C_LIC_NBR,Input_DEA_NUMBER,
											Input_VENDOR_ID,Input_NPI_NUMBER,Input_CLIA_NUMBER,Input_MEDICARE_FACILITY_NUMBER,Input_MEDICAID_NUMBER,Input_NCPDP_NUMBER,
											Input_TAXONOMY,iTaxonomy_code,Input_BDID,Input_SRC,Input_SOURCE_RID,,,,,%result_thor%, %asIndex%);											

// output (%result_thor%);											
#uniquename(result_thor_trim)
Health_Facility_Services.mac_trim_xLNPID_layout(%result_thor%, %result_thor_trim%);
// output (%result_thor_trim%);																
/*------- Final Result ----*/
#uniquename(result)
// %result% := %result_thor_trim%;
%result% := %result_thor%;
/*----------------- Join input dataset and results using reference id ---------------------*/
#uniquename(infiledist)

#uniquename(exlinkdist)
%infiledist% := distribute(%infile_seq%, uniqueId);
%exlinkdist% := distribute(%result%, reference);

#uniquename(layout_ref)
%layout_ref% := record
	unsigned8 uniqueID;
	unsigned8 prefix_lnfid;
	recordof(infile);
	unsigned3	weight;
	unsigned4 keys_tried;
  unsigned2 pid_weight;
  unsigned2 pid_score := 0;
  unsigned4 pid_keys_used;
  unsigned2 pid_distance;
  string20 		pid_matches;
  string				pid_keys_desc;
  string				pid_matches_desc;
end;

#uniquename(AssignDID)
%layout_ref% %assignDID%(%infiledist% l, %exlinkdist% r) := transform
	// de_result := dedup(sort (r.results,-weight,-fnameweight,-lnameweight),weight);
	// idlWeightDiff := if(count(de_result) > 1, de_result[1].weight - de_result[2].weight, 0);
	// totalResults 	:= count(de_result);
	// self.lnpid 		:= if((idlWeightDiff >= distance or totalResults = 1)  and de_result[1].weight >= weight_score, de_result[1].lnpid, 0);
	idlWeightDiff := if(count(r.results) > 1, r.results[1].weight - r.results[2].weight, 0);
	totalResults 	:= count(r.results);
	self.prefix_lnfid 		:= if((idlWeightDiff >= distance or totalResults = 1)  and r.results[1].weight >= weight_score, r.results[1].lnpid, 0);
	// self.lnpid 		:= if((idlWeightDiff >= distance or totalResults = 1)  and r.results[1].weight >= weight_score, r.results[1].lnpid, 0);
  self.pid_weight 			:= r.results[1].weight;
  self.pid_keys_used := r.results[1].keys_used;
  self.pid_distance		:= idlWeightDiff;
	self.pid_matches 		:= 	IF (r.results[1].CNAME_match_code 			= 99, '-',  (STRING)r.results[1].CNAME_match_code)  + '/' +
																		IF (r.results[1].CNP_NAME_match_code 			= 99, '-',  (STRING)r.results[1].CNP_NAME_match_code)  + '/' +
																		IF (r.results[1].CNP_NUMBER_match_code 			= 99, '-',  (STRING)r.results[1].CNP_NUMBER_match_code)  + '/' +
																		IF (r.results[1].CNP_STORE_NUMBER_match_code 		= 99, '-',  (STRING)r.results[1].CNP_STORE_NUMBER_match_code)  + '/' +
																		IF (r.results[1].CNP_BTYPE_match_code 			= 99, '-',  (STRING)r.results[1].CNP_BTYPE_match_code)  + '/' +
																		IF (r.results[1].CNP_LOWV_match_code 			= 99, '-',  (STRING)r.results[1].CNP_LOWV_match_code)  + '/' +
																		IF (r.results[1].PRIM_RANGE_match_code 			= 99, '-',  (STRING)r.results[1].PRIM_RANGE_match_code)  + '/' +
																		IF (r.results[1].PRIM_NAME_match_code 			= 99, '-',  (STRING)r.results[1].PRIM_NAME_match_code)  + '/' +
																		IF (r.results[1].SEC_RANGE_match_code 			= 99, '-',  (STRING)r.results[1].SEC_RANGE_match_code)  + '/' +
																		IF (r.results[1].V_CITY_NAME_match_code 		= 99, '-',  (STRING)r.results[1].V_CITY_NAME_match_code)  + '/' +
																		IF (r.results[1].ST_match_code 				= 99, '-',  (STRING)r.results[1].ST_match_code)  + '/' +
																		IF (r.results[1].ZIP_match_code 			= 99, '-',  (STRING)r.results[1].ZIP_match_code)  + '/' +
																		IF (r.results[1].TAX_ID_match_code 			= 99, '-',  (STRING)r.results[1].TAX_ID_match_code)  + '/' +
																		IF (r.results[1].FEIN_match_code 			= 99, '-',  (STRING)r.results[1].FEIN_match_code)  + '/' + 
																		IF (r.results[1].PHONE_match_code 			= 99, '-',  (STRING)r.results[1].PHONE_match_code)  + '/' +
																		IF (r.results[1].FAX_match_code 			= 99, '-',  (STRING)r.results[1].FAX_match_code)  + '/' +
																		IF (r.results[1].LIC_STATE_match_code 			= 99, '-',  (STRING)r.results[1].LIC_STATE_match_code)  + '/' +
																		IF (r.results[1].C_LIC_NBR_match_code 			= 99, '-',  (STRING)r.results[1].C_LIC_NBR_match_code)  + '/' +
																		IF (r.results[1].DEA_NUMBER_match_code 			= 99, '-',  (STRING)r.results[1].DEA_NUMBER_match_code)  + '/' +
																		IF (r.results[1].VENDOR_ID_match_code 			= 99, '-',  (STRING)r.results[1].VENDOR_ID_match_code)  + '/' +
																		IF (r.results[1].NPI_NUMBER_match_code 			= 99, '-',  (STRING)r.results[1].NPI_NUMBER_match_code)  + '/' +
																		IF (r.results[1].CLIA_NUMBER_match_code 		= 99, '-',  (STRING)r.results[1].CLIA_NUMBER_match_code)  + '/' +
																		IF (r.results[1].MEDICARE_FACILITY_NUMBER_match_code 	= 99, '-',  (STRING)r.results[1].MEDICARE_FACILITY_NUMBER_match_code)  + '/' +
																		IF (r.results[1].MEDICAID_NUMBER_match_code 		= 99, '-',  (STRING)r.results[1].MEDICAID_NUMBER_match_code)  + '/' +
																		IF (r.results[1].NCPDP_NUMBER_match_code 		= 99, '-',  (STRING)r.results[1].NCPDP_NUMBER_match_code)  + '/' +
																		IF (r.results[1].TAXONOMY_match_code 			= 99, '-',  (STRING)r.results[1].TAXONOMY_match_code)  + '/' + 
																		IF (r.results[1].TAXONOMY_CODE_match_code 		= 99, '-',  (STRING)r.results[1].TAXONOMY_CODE_match_code)  + '/' +
																		IF (r.results[1].BDID_match_code 			= 99, '-',  (STRING)r.results[1].BDID_match_code)  + '/' +
																		IF (r.results[1].SRC_match_code 			= 99, '-',  (STRING)r.results[1].SRC_match_code)  + '/' +
																		IF (r.results[1].SOURCE_RID_match_code 			= 99, '-',  (STRING)r.results[1].SOURCE_RID_match_code)  + '/' +
																		IF (r.results[1].FAC_NAME_match_code 			= 99, '-',  (STRING)r.results[1].FAC_NAME_match_code)  + '/' +
																		IF (r.results[1].ADDR1_match_code 			= 99, '-',  (STRING)r.results[1].ADDR1_match_code)  + '/' +
																		IF (r.results[1].LOCALE_match_code 			= 99, '-',  (STRING)r.results[1].LOCALE_match_code)  + '/' +
																		IF (r.results[1].ADDRES_match_code 			= 99, '-',  (STRING)r.results[1].ADDRES_match_code); 
  self.pid_keys_desc := Health_Facility_Services.Process_xLNPID_Layouts.KeysUsedToText(r.results[1].keys_used);
	noMatch := [(String)SALT29.MatchCode.OneComponentNull, (String)SALT29.MatchCode.OneSideNull, '0', '-'];
	m := self.pid_matches;
	matchSet := StringLib.SplitWords(m, '/', false);
	res := IF(TRIM(M)='',m, 
				IF(matchSet[1] not in noMatch, 'CNAME,', '')  + 
				IF(matchSet[2] not in noMatch, 'CNP_NAME,', '') + 
				IF(matchSet[3] not in noMatch, 'CNP_NUMBER,', '')  + 
				IF(matchSet[4] not in noMatch, 'CNP_STORE_NUMBER,', '') + 
				IF(matchSet[5] not in noMatch, 'CNP_BTYPE,', '') + 
				IF(matchSet[6] not in noMatch, 'CNP_LOWV,', '') + 
				IF(matchSet[7] not in noMatch, 'PRIM_RANGE,', '')  + 
				IF(matchSet[8] not in noMatch, 'PRIM_NAME,', '') + 
				IF(matchSet[9] not in noMatch, 'SEC_RANGE,', '')   + 
				IF(matchSet[10] not in noMatch, 'V_CITY_NAME,', '') + 
				IF(matchSet[11] not in noMatch,'ST,', '') 	    + 
				IF(matchSet[12] not in noMatch,'ZIP,', '') + 
				IF(matchSet[13] not in noMatch,'TAX_ID,', '')         + 
				IF(matchSet[14] not in noMatch,'FEIN,', '')         + 
				IF(matchSet[15] not in noMatch,'FAX,', '')      +
				IF(matchSet[16] not in noMatch,'LIC_STATE,', '')      +
				IF(matchSet[17] not in noMatch,'C_LIC_NBR,', '')      +							
				IF(matchSet[18] not in noMatch,'DEA_NUMBER,', '')      +
				IF(matchSet[19] not in noMatch,'VENDOR_ID,', '')      +
				IF(matchSet[20] not in noMatch,'NPI_NUMBER,', '')      +							
				IF(matchSet[21] not in noMatch,'CLIA_NUMBER,', '')       + 
				IF(matchSet[22] not in noMatch,'MEDICARE_FACILITY_NUMBER,', '') + 
				IF(matchSet[23] not in noMatch,'MEDICAID_NUMBER,', '')      + 
				IF(matchSet[24] not in noMatch,'NCPDP_NUMBER,', '')      + 
				IF(matchSet[25] not in noMatch,'TAXONOMY,', '')      + 
				IF(matchSet[26] not in noMatch,'TAXONOMY_CODE,', '')      + 
				IF(matchSet[27] not in noMatch,'BDID,', '')      + 
				IF(matchSet[28] not in noMatch,'SRC,', '')      + 
				IF(matchSet[29] not in noMatch,'SOURCE_RID,', '')      + 
				IF(matchSet[30] not in noMatch,'ADDR1,', '')      + 
				IF(matchSet[31] not in noMatch,'LOCALE,', '')      + 
				IF(matchSet[32] not in noMatch,'ADDRES,', ''));							
  self.pid_matches_desc 	:= res;
  self.pid_score := r.results[1].score; 
	self := l;
	self := [];
end;

outfile := join(%infiledist%, %exlinkdist%, left.uniqueid = right.reference, %assignDID%(left, right), left outer, local);
  
endmacro;

 
