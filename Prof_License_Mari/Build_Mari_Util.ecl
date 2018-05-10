IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date, STD, address;


EXPORT Build_Mari_Util := MODULE

	EXPORT fPrintData(String8 code, String pVersion) := FUNCTION

		  src_cd						:= code[3..7];
		  super_mari_base		:= '~thor_data400::in::proflic_mari::'+ src_cd;
		  mari_base					:= '~thor_data400::in::proflic_mari::'+ pVersion+'::'+src_cd;

			super := IF(ut.CleanSpacesAndUpper(code)='ALL',
			            Prof_License_Mari.file_Maribase_in,
			            DATASET(super_mari_base,Prof_License_Mari.layouts.base,THOR));

			after_map := map(ut.CleanSpacesAndUpper(code)='ALL' and ut.CleanSpacesAndUpper(pVersion)='ALL' 
			                   => Prof_License_Mari.file_Maribase_in,
											 ut.CleanSpacesAndUpper(code)<>'ALL' and ut.CleanSpacesAndUpper(pVersion)='ALL'
											   => DATASET('~thor_data400::in::proflic_mari::'+src_cd,Prof_License_Mari.layouts.base,THOR),
											 DATASET('~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,Prof_License_Mari.layouts.base,THOR));
			cmc := TABLE(after_map,{cmc_slpk,cnt:=count(group)},cmc_slpk);
			data_table := TABLE(after_map, {std_source_upd,std_prof_cd,license_state,
																			CREATE_DTE,LAST_UPD_DTE,STAMP_DTE,
																			DATE_FIRST_SEEN,DATE_LAST_SEEN,
																			DATE_VENDOR_FIRST_REPORTED,DATE_VENDOR_LAST_REPORTED,
																			PROCESS_DATE,ORIG_ISSUE_DTE,CURR_ISSUE_DTE,EXPIRE_DTE,
																			license_nbr,off_license_nbr,raw_license_type,std_license_type,raw_license_status,std_license_status,
																			type_cd,name_first,name_last, name_mid, name_prefx,name_sufx,
																			name_org,name_org_sufx,dba_flag,name_dba,office_parse,name_office,
																			name_mari_org,name_mari_dba,name_org_orig,name_dba_orig,
																			addr_bus_ind,Addr_addr1_1,Addr_addr2_1,addr_addr3_1,addr_addr4_1,Addr_city_1,addr_state_1,Addr_zip5_1,Addr_zip4_1,
																			phn_phone_1,phn_fax_1,
																			AFFIL_TYPE_CD,mltreckey,cmc_slpk,pcmc_slpk});
			Q4 := TABLE(after_map, {std_source_upd,type_cd,name_first, name_last, name_mid, name_prefx,name_sufx,Addr_addr1_1,
															Name_org,name_org_prefx,name_org_sufx,name_org_orig,name_mari_org,
															 Name_DBA,name_dba_prefx,name_dba_sufx,DBA_flag,Name_dba_orig,Name_mari_dba, 
															 name_office, office_parse, name_nick});
			update_cnt := TABLE(SORT(DISTRIBUTE(after_map,hash(std_source_upd,date_vendor_first_reported)),std_source_upd,date_vendor_first_reported), {std_source_upd,date_vendor_first_reported,cnt:=count(group)},std_source_upd,date_vendor_first_reported);
			cmc_dup := cmc(cnt>1);
			
			cmc_dup_all := join(after_map, cmc_dup,
													LEFT.cmc_slpk=RIGHT.cmc_slpk,
													TRANSFORM(LEFT));
			PATTERN_NAME := '( LLC$| LLC | INC$| INC | CORP$| CORP | COMPANY$| COMPANY |ATTN |C/O| DBA |D/B/A|^DBA | T/A | AKA |^AKA)';
			PATTERN_DBA := '( DBA |^DBA |D/B/A |D\\.B\\.A|C/O|T/A | AKA |^AKA |A/K/A |A\\.K\\.A)';
      sufxpattern1:= '(^JR |^SR |^I |^II |^III |^V |^IV |^VI | JR | SR | II | III | IV | VI | JR$| SR$| I$| II$| III$| IV$| V$| VI$)';
      sufxpattern2:= '(^JR |^SR |^II |^III |^IV |^VI | JR | SR | II | III | IV | VI | JR$| SR$| II$| III$| IV$| VI$)';
      addresspattern:= '( STREET| ST | DR | DRIVE | ROAD | RD | PLAZA )';			
					
			RETURN PARALLEL(
							OUTPUT(SORT(super,license_nbr),,NAMED(code+'_SUPER'));
							OUTPUT(after_map(Name_org=' '),,NAMED(code+'_No_Name_Org'));
							OUTPUT(after_map(license_nbr=' '),,NAMED(code+'_No_license_nbr'));
							OUTPUT(after_map(license_state=' '),,NAMED(code+'_No_license_state'));
							OUTPUT(after_map(type_cd=' '),,NAMED(code+'_No_type_cd'));
							OUTPUT(after_map(std_prof_cd=' '),,NAMED(code+'_No_std_prof_cd'));
							OUTPUT(after_map(std_license_status=''),,NAMED(code+'_No_std_lic_status'));
							OUTPUT(after_map(std_license_type=' '),,NAMED(code+'_No_std_license_type'));
							OUTPUT(after_map(REGEXFIND('(^[A-Z]+ [A-Z]+$|[0-9]+/[0-9]+$)',license_nbr)),,NAMED(code+'_invalid_license_nbr'));
							OUTPUT(after_map(TYPE_CD='GR' and Prof_License_Mari.func_is_company(NAME_ORG) and NAME_MARI_ORG=''),,NAMED(code+'_invalid_mari_org'));
							OUTPUT(after_map((curr_issue_dte<>'' AND curr_issue_dte[1..2] NOT IN ['17','18','19','20']) OR
							                 (orig_issue_dte<>'' AND orig_issue_dte[1..2] NOT IN ['17','18','19','20']) OR
															 (expire_dte<>'' AND expire_dte[1..2] NOT IN ['17','18','19','20']) OR
															 (birth_dte<>'' AND birth_dte[1..2] NOT IN ['17','18','19','20']) OR
															 (renewal_dte<>'' AND renewal_dte[1..2] NOT IN ['17','18','19','20']) OR
															 (REGEXFIND('[A-Za-z ]',TRIM(curr_issue_dte+orig_issue_dte+expire_dte+birth_dte+renewal_dte,ALL)))
															 ),,NAMED(code+'_invalid_date'));		
							OUTPUT(after_MAP(NAME_DBA!='' AND TRIM(name_mari_dba+name_dba_orig,ALL)=''),NAMED(code+'_InvalidDBA'));								 
							OUTPUT(after_MAP((NAME_OFFICE!='' AND TRIM(NAME_OFFICE,ALL)= TRIM(NAME_FIRST,ALL) + TRIM(NAME_LAST,ALL)) OR (TRIM(NAME_OFFICE,ALL) = TRIM(name_org,ALL))
		                 OR (NAME_OFFICE!='' AND TRIM(NAME_OFFICE,ALL)= TRIM(NAME_FIRST,ALL) + TRIM(name_mid,ALL) + TRIM(NAME_LAST,ALL))),NAMED(code+'_InvalidNameOffice'));				 
							OUTPUT(after_MAP((LENGTH(ADDR_ZIP5_1)!=5) OR (addr_zip4_1 <>'' AND LENGTH(ADDR_ZIP4_1)!=4)),NAMED(code+'_invalidZip'));								 
							OUTPUT(after_map(REGEXFIND(PATTERN_DBA,NAME_OFFICE+' '+NAME_ORG+' '+NAME_DBA)),,NAMED(code+'_Office_Name_w_DBA'));
							OUTPUT(after_map(OOC_IND_1<>0),,NAMED(code+'_OOC_IND_1'));
							
							OUTPUT(after_map(REGEXFIND(PATTERN_NAME,Addr_addr1_1+Addr_addr2_1+Addr_addr3_1, NOCASE) OR
															 REGEXFIND('(ATTN |ATTENTION|C/O|T/A|:)',Addr_addr1_1+Addr_addr2_1+Addr_addr3_1, NOCASE) OR
															 REGEXFIND('(D/B/A|A/K/A| AKA |DBA |D\\.B\\.A|A\\.K\\.A)',addr_addr1_1+' '+addr_addr2_1+' '+addr_addr3_1) OR
															 (TRIM(ADDR_ZIP5_1,LEFT,RIGHT)<>'' AND LENGTH(TRIM(ADDR_ZIP5_1,LEFT,RIGHT))<>5) OR
															 (addr_addr1_1='' AND addr_addr2_1<>''))
															 ,,NAMED(code+'_ab_addr1'));
							OUTPUT(after_map(REGEXFIND(PATTERN_NAME,Addr_addr1_2+Addr_addr2_2+Addr_addr3_2+Addr_addr4_2, NOCASE) OR
															 REGEXFIND('(ATTN |ATTENTION|C/O|T/A|:)',Addr_addr1_2+' '+Addr_addr2_2+' '+Addr_addr3_2+' '+Addr_addr4_2, NOCASE) OR
															 REGEXFIND('(D/B/A|A/K/A| AKA |DBA |D\\.B\\.A|A\\.K\\.A)',Addr_addr1_2+' '+Addr_addr2_2+' '+Addr_addr3_2+' '+Addr_addr4_2) OR
															 (TRIM(ADDR_ZIP5_2,LEFT,RIGHT)<>'' AND LENGTH(TRIM(ADDR_ZIP5_2,LEFT,RIGHT))<>5) OR
															 (addr_addr1_2='' AND addr_addr2_2<>''))
															 ,,NAMED(code+'_ab_addr2'));
							OUTPUT(after_map(REGEXFIND('(D/B/A|A/K/A| AKA |DBA |D\\.B\\.A|A\\.K\\.A|ATTN |C/O|ATTENTION)',NAME_ORG)),,NAMED(code+'_ab_org_name'));
							OUTPUT(after_map(REGEXFIND('[0-9]+',name_org) OR REGEXFIND('[0-9]+',name_office)),,NAMED(code+'_ab_office'));			
							OUTPUT(after_map(name_dba<>''),,NAMED(code+'_dba_exists'));
							OUTPUT(after_map(name_dba<>'' and name_dba_orig=''),,NAMED(code+'_bad_dba'));
							OUTPUT(SORT(after_map(name_office<>' '),name_office),,NAMED(code+'_office_exists'));
							
							OUTPUT(after_map(LENGTH(TRIM(name_last,LEFT,RIGHT))=1),,NAMED(code+'_LANME_1'));
							OUTPUT(after_map(name_nick<>' '),,NAMED(code+'_NickName'));
);

	END;


END;