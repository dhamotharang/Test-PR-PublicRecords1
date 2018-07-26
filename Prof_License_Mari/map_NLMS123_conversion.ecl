/* Converting Nationwide Mortgage Licensing System and Registry File to MARI common layout
// Following allowable Real Estate License Type: APR, RLE, MTG, LND
*/

IMPORT ut, Address, Standard, Prof_License_Mari, lib_stringlib ,Lib_FileServices;
#OPTION('multiplePersistInstances',FALSE);

EXPORT map_NLMS123_conversion(STRING process_dte) := FUNCTION		

#workunit('name','Prof License NLMS MARI Build ' + process_dte);		

src_cd	:= 'S0900'; //Vendor code
src_st	:= 'US';	//License state


//License Status
active_status_set := ['ACTIVE','APPROVED','APPROVED-INACTIVE','APPROVED-SURRENDER/CANCELLATION REQUESTED','TEMPORARY CEASE AND DESIST',
											'REVOKED-ON APPEAL','SUSPENDED','SUSPENDED-ON APPEAL'];
							 


inactive_status_set := ['INACTIVE','DENIED','REVOKED','EXPIRED','SURRENDERED','ORDERED TO SURRENDER','VOLUNTARY SURRENDER'];
                                          

country_set := ['Canada - British Columbia','Canada - Ontario','Canada - Quebec','Costa Rica','Honduras','India','Micronesia, Federated States of',
								'United Kingdom','Uruguay','Guatemala','Hungary','Jamaica','Mexico','Panama','Philippines'];                                           


//Import raw data files and dedup according to NMLS business rules. All files have been prepared to facilitate
//future updates to business rules.

SprayFiles := Prof_License_Mari.spray_NMLS(process_dte).NMLS_SprayFiles;

// Branch ***********************************************************
temp_branch := Prof_License_Mari.files_NMLS0900.branch(branch_nmls_id != 0);
ut.CleanFields(temp_branch,cln_branch);
branch := cln_branch;

// Branch DBA *******************************************************
temp_dba_branch := Prof_License_Mari.files_NMLS0900.branch_dba;
ut.CleanFields(temp_dba_branch,cln_dba_branch);
dba_branch := cln_dba_branch;

// Branch License ***************************************************
temp_branch_lic := Prof_License_Mari.files_NMLS0900.branch_lic;


//dedup : compare to all records to eliminate duplicates with inactive statuses according to business rules
temp_branlic_dedup_1 := DEDUP(temp_branch_lic,LEFT.BRANCH_NMLS_ID = RIGHT.BRANCH_NMLS_ID AND
                                                 LEFT.REGULATOR = RIGHT.REGULATOR AND
																					       LEFT.LICENSE_NBR = RIGHT.LICENSE_NBR AND
																						     LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE AND
																						     StringLib.StringToUppercase(LEFT.STATUS) IN active_status_set AND
																						     StringLib.StringToUppercase(RIGHT.STATUS) IN inactive_status_set,
													   LEFT);

//sort : sort records by business rule fields and status date (effective_date)														 
temp_branlic_sorted_1 := SORT(temp_branlic_dedup_1,BRANCH_NMLS_ID,REGULATOR,LICENSE_NBR,LICENSE_TYPE,EFFECTIVE_DATE);

//dedup : dedup records to eliminate duplicates with earlier status dates (effective dates)														 
temp_branlic_dedup_2 := DEDUP(temp_branlic_sorted_1,LEFT.BRANCH_NMLS_ID = RIGHT.BRANCH_NMLS_ID AND
                                            LEFT.REGULATOR = RIGHT.REGULATOR AND
																						LEFT.LICENSE_NBR = RIGHT.LICENSE_NBR AND
																						LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE,
													   RIGHT);
ut.CleanFields(temp_branlic_dedup_2,cln_branlic_dedup_2);														 
branch_lic := cln_branlic_dedup_2;

// Business *********************************************************
temp_business := Prof_License_Mari.files_NMLS0900.business(COMPANY_NMLS_ID != 0);
ut.CleanFields(temp_business, clean_business);
business := clean_business;

// Business DBA *****************************************************
temp_dba_business := Prof_License_Mari.files_NMLS0900.business_dba;
ut.CleanFields(temp_dba_business, clean_business_dba);
dba_business := clean_business_dba;

// Business License *************************************************
temp_business_lic := Prof_License_Mari.files_NMLS0900.business_lic;

//dedup : compare to all records to eliminate duplicates with inactive statuses according to business rules
temp_buslic_dedup_1 := DEDUP(temp_business_lic,LEFT.COMPANY_NMLS_ID = RIGHT.COMPANY_NMLS_ID AND
                                                 LEFT.REGULATOR = RIGHT.REGULATOR AND
																					       LEFT.LICENSE_NBR = RIGHT.LICENSE_NBR AND
																						     LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE AND
																						     StringLib.StringToUppercase(LEFT.STATUS) IN active_status_set AND
																						     StringLib.StringToUppercase(RIGHT.STATUS) IN inactive_status_set,
													   LEFT);
														 
//sort : sort records by business rule fields and status date (effective_date)														 
temp_buslic_sorted_1 := SORT(temp_buslic_dedup_1,COMPANY_NMLS_ID,REGULATOR,LICENSE_NBR,LICENSE_TYPE,EFFECTIVE_DATE);

//dedup : dedup records to eliminate duplicates with earlier status dates (effective dates)														 
temp_buslic_dedup_2 := DEDUP(temp_buslic_sorted_1,LEFT.COMPANY_NMLS_ID = RIGHT.COMPANY_NMLS_ID AND
                                            LEFT.REGULATOR = RIGHT.REGULATOR AND
																						LEFT.LICENSE_NBR = RIGHT.LICENSE_NBR AND
																						LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE,
													   RIGHT);

ut.CleanFields(temp_buslic_dedup_2,cln_buslic_dedup_2);														 
business_lic := cln_buslic_dedup_2;


// Individual *******************************************************
temp_individual := Prof_License_Mari.files_NMLS0900.individual(INDIVIDUAL_NMLS_ID != 0);
individual := temp_individual;

// Individual License ***********************************************
temp_individual_lic := Prof_License_Mari.files_NMLS0900.individual_lic;

//dedup : compare to all records to eliminate duplicates with inactive statuses according to business rules
temp_indlic_dedup_1 := DEDUP(temp_individual_lic,LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID AND
                                                 LEFT.REGULATOR = RIGHT.REGULATOR AND
																					       LEFT.LICENSE_NBR = RIGHT.LICENSE_NBR AND
																						     LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE AND
																								 LEFT.LICENSE_ID	= RIGHT.LICENSE_ID AND 
																						     StringLib.StringToUppercase(LEFT.STATUS) IN active_status_set AND
																						     StringLib.StringToUppercase(RIGHT.STATUS) IN inactive_status_set,
													   LEFT);

//sort : sort records by business rule fields and status date (effective_date)														 
temp_indlic_sorted_1 := SORT(temp_indlic_dedup_1,INDIVIDUAL_NMLS_ID,REGULATOR,LICENSE_NBR,LICENSE_TYPE,EFFECTIVE_DATE);

//dedup : dedup records to eliminate duplicates with earlier status dates (effective dates)														 
temp_indlic_dedup_2 := DEDUP(temp_indlic_sorted_1,LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID AND
                                            LEFT.REGULATOR = RIGHT.REGULATOR AND
																						LEFT.LICENSE_NBR = RIGHT.LICENSE_NBR AND
																						LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE,
													   RIGHT);
														 
individual_lic := temp_indlic_dedup_2;

// Individual Location **********************************************
temp_location := Prof_License_Mari.files_NMLS0900.location;
temp_loc_sorted_1 := SORT(temp_location,INDIVIDUAL_NMLS_ID,COMPANY,LOCATION_NMLS_ID,LOCATION_TYPE,START_DATE);
temp_loc_dedup_1 := DEDUP(temp_loc_sorted_1,LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID,
                                            LEFT.COMPANY = RIGHT.COMPANY,
																						LEFT.LOCATION_NMLS_ID = RIGHT.LOCATION_NMLS_ID,
																						LEFT.LOCATION_TYPE = RIGHT.LOCATION_TYPE,
													RIGHT);

location := temp_loc_dedup_1;

//Individual Other Names **********************************************
temp_AKA		:= Prof_License_Mari.files_NMLS0900.individual_aka;
temp_aka_sorted_1 := SORT(temp_AKA,INDIVIDUAL_NMLS_ID);
temp_aka_dedup_1  := DEDUP(temp_aka_sorted_1,LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID,
																						LEFT.FIRST_NAME	= RIGHT.FIRST_NAME,
																						LEFT.MIDDLE_NAME = RIGHT.MIDDLE_NAME,
																						LEFT.LAST_NAME = RIGHT.LAST_NAME,
													RIGHT);

IndivAKA := temp_aka_dedup_1;

//Individual Registration **********************************************
temp_reg		:= Prof_License_Mari.files_NMLS0900.individual_reg;
temp_reg_sorted_1 := SORT(temp_reg,INDIVIDUAL_NMLS_ID, REGNAME, STATUS);
temp_reg_dedup_1  := DEDUP(temp_reg_sorted_1,LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID,
																							LEFT.REGNAME = RIGHT.REGNAME,
																							LEFT.STATUS = RIGHT.STATUS,
													RIGHT);

IndivReg := temp_reg_dedup_1;

//Individual Registration Detail ****************************************
temp_regdetail		:= Prof_License_Mari.files_NMLS0900.individual_regdetail;
temp_regdetail_sorted_1 := SORT(temp_regdetail,INDIVIDUAL_NMLS_ID,INSTIT_NMLS_ID,FEDREGULATOR,START_DATE);
temp_regdetail_dedup_1  := DEDUP(temp_regdetail_sorted_1,LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID,
																													LEFT.INSTIT_NMLS_ID = RIGHT.INSTIT_NMLS_ID,
																													LEFT.FEDREGULATOR = RIGHT.FEDREGULATOR,
													RIGHT);

IndivRegDetail := temp_regdetail_dedup_1;

// Individual Sponsorship **********************************************
temp_sponsorship  := Prof_License_Mari.files_NMLS0900.sponsorship;			
temp_sponsorship_sorted_1 := SORT(temp_sponsorship,INDIVIDUAL_NMLS_ID,COMPANY_NMLS_ID,LICENSE_TYPE,START_DATE,END_DATE);
temp_sponsorship_dedup_1  := DEDUP(temp_sponsorship_sorted_1,LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID
                                                         AND LEFT.COMPANY_NMLS_ID = RIGHT.COMPANY_NMLS_ID
																												 AND LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE
																												 AND LEFT.START_DATE = RIGHT.START_DATE,
								 					 	      LEFT);

temp_sponsorship_dedup_2 := DEDUP(temp_sponsorship_dedup_1,LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID
                                                         AND LEFT.COMPANY_NMLS_ID = RIGHT.COMPANY_NMLS_ID
																												 AND LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE,
																	RIGHT);
sponsorship := temp_sponsorship_dedup_2;
																		

// Regulatory  Actions *****************************
regulatory := Prof_License_Mari.files_NMLS0900.regulatory;

// Disciplinary Actions ****
disciplinary := Prof_License_Mari.files_NMLS0900.disciplinary;
 

//Process Files
regulatory_file := Prof_License_Mari.file_NMLS_RegulatoryActions(regulatory,process_dte);
disciplinary_file := Prof_License_Mari.file_NMLS_DisciplinaryActions(disciplinary,process_dte);
individual_detail_file := Prof_License_Mari.file_NMLS_Indv_Detail(IndivReg,
																																	IndivRegDetail,
																																	sponsorship,
																																	process_dte);


// Populating BranchLicense File
rRawBranch_layout	:=
RECORD
	Prof_License_Mari.layouts_NMLS0900.BRANCH;
	Prof_License_Mari.layouts_NMLS0900.BRANCH_LIC AND NOT BRANCH_NMLS_ID;
	Prof_License_Mari.layouts_NMLS0900.BRANCH_DBA AND NOT [BRANCH_NMLS_ID,REGULATOR];
	STRING2 affil_type_cd;
END;

inFileBranch := PROJECT(branch,TRANSFORM(rRawBranch_layout,
                                         SELF.affil_type_cd := 'BR';
																				 SELF := LEFT;
																			   SELF := []));

//Join Branch Files
rRawBranch_layout 	trans_branch(inFileBranch L, branch_lic R) := TRANSFORM
  SELF.REGULATOR 							:= R.REGULATOR;
	SELF.LICENSE_ID 						:= R.LICENSE_ID;
	SELF.LICENSE_NBR 						:= R.LICENSE_NBR;
	SELF.LICENSE_TYPE 					:= R.LICENSE_TYPE;
	SELF.ORIG_ISSUE_DATE 				:= R.ORIG_ISSUE_DATE;
	SELF.STATUS 								:= R.STATUS;
	SELF.EFFECTIVE_DATE 				:= R.EFFECTIVE_DATE;
	SELF.IS_AUTHORIZED_LICENSE 	:= R.IS_AUTHORIZED_LICENSE;
	SELF.RENEW_THRU							:= R.RENEW_THRU;
	SELF := L;
END;

ds_branch_lic := JOIN(inFileBranch, branch_lic,
						       LEFT.BRANCH_NMLS_ID = RIGHT.BRANCH_NMLS_ID,
						       trans_branch(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);


rRawBranch_layout 	trans_branch_dba(ds_branch_lic L, dba_branch R) := TRANSFORM
  SELF.DBA 				:= R.DBA;
	SELF.NAME_TYPE 	:= R.NAME_TYPE;
	SELF := L;
END;

ds_branch_dba := JOIN(ds_branch_lic, dba_branch,
						       LEFT.BRANCH_NMLS_ID= RIGHT.BRANCH_NMLS_ID,
						       trans_branch_dba(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);

// Populating CompanyLicense File
rRawCompany_layout	:=
RECORD
	Prof_License_Mari.layouts_NMLS0900.BUSINESS;
	Prof_License_Mari.layouts_NMLS0900.BUSINESS_LIC AND NOT [COMPANY_NMLS_ID];
	Prof_License_Mari.layouts_NMLS0900.BUSINESS_DBA AND NOT [COMPANY_NMLS_ID,REGULATOR];
	STRING affil_type_cd;
END;

inFileCompany := PROJECT(business,TRANSFORM(rRawCompany_layout,
																				 SELF.affil_type_cd := 'CO';
																				 SELF := LEFT;
																			   SELF := []));

//Join Company Files
rRawCompany_layout 	trans_company(inFileCompany L, business_lic R) := TRANSFORM
	SELF.REGULATOR 							:= R.REGULATOR;
	SELF.LICENSE_ID 						:= R.LICENSE_ID;
	SELF.LICENSE_NBR 						:= R.LICENSE_NBR;
	SELF.LICENSE_TYPE 					:= R.LICENSE_TYPE;
	SELF.ORIG_ISSUE_DATE 				:= R.ORIG_ISSUE_DATE;
	SELF.STATUS 								:= R.STATUS;
	SELF.EFFECTIVE_DATE 				:= R.EFFECTIVE_DATE;
	SELF.IS_AUTHORIZED_LICENSE 	:= R.IS_AUTHORIZED_LICENSE;	
	SELF := L;
END;


ds_company_lic := JOIN(inFileCompany, business_lic,
						       LEFT.COMPANY_NMLS_ID= RIGHT.COMPANY_NMLS_ID,
						       trans_company(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);


rRawCompany_layout 	trans_company_dba(ds_company_lic L, dba_business R) := TRANSFORM
  SELF.DBA 					:= R.DBA;	
	SELF.NAME_TYPE 		:= R.NAME_TYPE;
	SELF := L;
END;

ds_company_dba := JOIN(ds_company_lic, dba_business,
						       LEFT.COMPANY_NMLS_ID= RIGHT.COMPANY_NMLS_ID,
						       trans_company_dba(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);

//Combine company layouts for full input file
rRaw_Common_layout := RECORD
  rRawBranch_layout;
	STRING500	FEDREGULATOR;
	STRING20	FEDSTATUS;
	STRING50	BUSINESS_STRUCTURE;
	STRING60	SITE_LOCATION;
	STRING10 FISCALYEAREND,     //NEW FIELD
	STRING50 FORMEDIN,         //NEW FIELD 
	STRING10 DATEFORMED,         //NEW FIELD
	STRING4 STOCKSYMBOL,       //DF-12096
END;

//TRANSFORM Company file to common layout
rRaw_Common_layout 	trans_Comp_Common(ds_company_dba L) := TRANSFORM
	SELF.name_type 					:= StringLib.StringFilterOut(L.name_type, '"');
	SELF.fedregulator				:= L.fedregulator;
	SELF.fedstatus					:= L.fedstatus;
	SELF.business_structure := StringLib.StringFilterOut(L. business_structure, '"');
	SELF.site_location			:= '';
	SELF := L;
	SELF := [];	
END;

ds_Comp_Common := PROJECT(ds_company_dba, trans_comp_Common(LEFT)) : PERSIST('~thor_data400::persist::nmls::co_intermediate');

//TRANSFORM Branch file to common layout
rRaw_Common_layout 	trans_Branch_Common(ds_branch_dba L) := TRANSFORM
	branchpattern	:= '^(.*),(.*),(.*) BRANCH$';
	tempbranch		:= ut.CleanSpacesAndUpper(L.NAME);
	clnbranch			:= IF(REGEXFIND(branchpattern,tempbranch),REGEXFIND(branchpattern,tempbranch,1),tempbranch);
	SELF.name	:= IF(REGEXFIND('BRANCH$',clnbranch),REGEXREPLACE('BRANCH$',clnbranch,''),clnbranch);
	SELF.FEDREGULATOR		:= '';
	SELF.FEDSTATUS			:= '';
	site_city	 := IF(REGEXFIND(branchpattern,tempbranch),REGEXFIND(branchpattern,tempbranch,2),'');
	site_state := IF(REGEXFIND(branchpattern,tempbranch),REGEXFIND(branchpattern,tempbranch,3),'');
	SELF.SITE_LOCATION	:= StringLib.StringCleanSpaces(site_city + site_state+' '+ 'BRANCH');
	SELF.name_type 			:= StringLib.StringFilterOut(L.name_type, '"');
	SELF.is_authorized	:= StringLib.StringFilterOut(L.is_authorized, '"');
	SELF := L;	
	SELF := [];
END;

ds_Branch_Common := PROJECT(ds_branch_dba, trans_branch_common(LEFT)) : PERSIST('~thor_data400::persist::nmls::br_intermediate');

//Combine all raw files in common format into a single file
ds_Raw_Common_Company := ds_Branch_Common + ds_Comp_Common;


//Layout to add clean name fields for identifying business vs individual name
Layout_clean_name := RECORD
		rRaw_Common_layout;
		Standard.Name;
		STRING1    name_flag;
		STRING150  cname;
END;

Layout_clean_name mapClnFields(ds_Raw_Common_Company l)	:= TRANSFORM
tempname	:= StringLib.StringCleanSpaces(stringlib.stringfindreplace(l.name,',',' '));
tempname2	:= IF(REGEXFIND('^O (.*)',tempname), REGEXREPLACE('^O ',tempname,'O'),tempname);
SELF.name	:= tempname2;
SELF	:= l;
SELF	:= [];
END;
 
ClnCoName	:= PROJECT(ds_Raw_Common_Company,mapClnFields(LEFT));

//call Macro to differentiate company vs person in ORG_NAME field
Address.Mac_Is_Business(ClnCoName,NAME,ClnName,name_flag,FALSE,TRUE);


structure_exclusion := '(Corporation|Limited Liability Company|Not For Profit Corporation|Other|Partnership)';
type_exclusion 			:= '(Real Estate Corporation License Endorsement|Deferred Presentment License)';

//Map identified name fields fields
Layout_clean_name mapCoName(ClnName l) := TRANSFORM
		clean_name_U			:= IF(l.name_flag = 'U',Address.CleanPerson73(l.NAME),'');
		SELF.name_flag		:= l.name_flag;
		SELF.business_structure	:=  REGEXREPLACE('\\v', l.business_structure, '');
		SELF.title 				:=  MAP(TRIM(SELF.business_structure) = 'Sole Proprietorship' => l.cln_title,
															l.name_flag = 'P' 
															AND l.fedregulator = ''
															AND REGEXFIND(structure_exclusion,TRIM(l.business_structure,LEFT,RIGHT))
															AND NOT REGEXFIND(type_exclusion,TRIM(l.license_type))
																	=> l.cln_title,
															l.name_flag = 'P' AND TRIM(l.business_structure,LEFT,RIGHT) = '' AND 	l.fedregulator = '' => l.cln_title,
															'');										
		SELF.fname 				:= MAP(TRIM(SELF.business_structure) = 'Sole Proprietorship' => l.cln_fname,
														 	l.name_flag = 'P' 
															AND l.fedregulator = ''
															AND REGEXFIND(structure_exclusion,TRIM(l.business_structure,LEFT,RIGHT))
															AND NOT REGEXFIND(type_exclusion,TRIM(l.license_type))
																	=> l.cln_fname,
															l.name_flag = 'P' AND TRIM(l.business_structure,LEFT,RIGHT) = '' AND 	l.fedregulator = '' => l.cln_fname,		
														 '');										
		SELF.mname 				:= MAP(TRIM(SELF.business_structure) = 'Sole Proprietorship' => l.cln_mname,
														 	l.name_flag = 'P' 
															AND l.fedregulator = ''
															AND REGEXFIND(structure_exclusion,TRIM(l.business_structure,LEFT,RIGHT))
															AND NOT REGEXFIND(type_exclusion,TRIM(l.license_type))
																	=> l.cln_mname,
															l.name_flag = 'P' AND TRIM(l.business_structure,LEFT,RIGHT) = '' AND 	l.fedregulator = '' => l.cln_mname,		
														 '');					
		SELF.lname 				:=  MAP(TRIM(SELF.business_structure) = 'Sole Proprietorship' => l.cln_lname,
																l.name_flag = 'P' 
															AND l.fedregulator = ''
															AND REGEXFIND(structure_exclusion,TRIM(l.business_structure,LEFT,RIGHT))
															AND NOT REGEXFIND(type_exclusion,TRIM(l.license_type))
																	=> l.cln_lname,
															l.name_flag = 'P' AND TRIM(l.business_structure,LEFT,RIGHT) = '' AND 	l.fedregulator = '' => l.cln_lname,		
															'');
		SELF.name_suffix 	:=  MAP(TRIM(SELF.business_structure) = 'Sole Proprietorship' => l.cln_suffix,
															l.name_flag = 'P' 
															AND l.fedregulator = ''
															AND REGEXFIND(structure_exclusion,TRIM(l.business_structure,LEFT,RIGHT))
															AND NOT REGEXFIND(type_exclusion,TRIM(l.license_type))
																	=> l.cln_suffix,
															l.name_flag = 'P' AND TRIM(SELF.business_structure) = '' AND 	l.fedregulator = '' => l.cln_suffix,		
															'');
		SELF.cname	 			:= IF(l.name_flag IN ['B','U','D','I'],l.NAME,
															IF(l.fedregulator != '',l.NAME,
																IF(l.name_flag = 'P' 
																		AND REGEXFIND(structure_exclusion,TRIM(l.business_structure,LEFT,RIGHT))
																		AND l.fedregulator = ''
																		AND REGEXFIND(type_exclusion,TRIM(l.license_type)),
																				l.NAME,
																						'')
																						));

		SELF := l;
		SELF := [];
END;

ds_clnName	:= PROJECT(ClnName,mapCoName(LEFT)) : PERSIST('~thor_data400::persist::nmls::company_br_clean');


// Dedup for duplicate active company licenses under the same regulator
temp_active_dedup := DEDUP(ds_clnName,LEFT.COMPANY_NMLS_ID = RIGHT.COMPANY_NMLS_ID AND
																								 LEFT.BRANCH_NMLS_ID= RIGHT.BRANCH_NMLS_ID AND
																								 LEFT.REGULATOR = RIGHT.REGULATOR AND
																					       LEFT.LICENSE_NBR = RIGHT.LICENSE_NBR AND
																						     LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE AND
																						     StringLib.StringToUppercase(LEFT.STATUS) IN active_status_set AND
																								 StringLib.StringToUppercase(RIGHT.STATUS) IN active_status_set,LEFT);
																								 						
																						 																		 						
//Dataset reference files for lookup joins
Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0900');

//Regular expressions
Comments := 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';
addr_list := '(#|P O |APT |APT[.] |BLDG |C/O |PO |POB |STE |SUITE|SU |APARTMENT |BOX |UNIT |PMB |ROOM |RT |HWY | FLOOR|PENTHOUSE |POST OFFICE|GENERAL |ESTATES)';
C_O_Ind := '(C/O |ATTN:|ATTN|ATTENTION:|ATT:|%)';
DBA_Ind := '(;[ ]*DBA |,[ ]*DBA |/DBA/|DBA |C/O |D B A |D/B/A |AKA |;)';
invalid_addr := '(N/A|NONE |NO VALID|SAME |UNKNOWN|TBD|NOT CURRENTLY)';
quote_pattern	:= '^(.*)\\"(.*)\\"(.*)$';
paren_pattern := '^(.*)\\((.*)\\)(.*)$';
dbl_quote_pattern := '^(.*)\\"\\"(.*)\\"\\"(.*)$';
CO_pattern := '^(.*)(C/O |%| C/0| ATTN: |ATTN  )(.*)$';

//Pattern for DBA
DBApattern	:= '^(.*)(;[ ]*DBA |,[ ]*DBA |/DBA/| DBA |C/O |D B A |D/B/A |AKA |T/A |;)(.*)';

//Pattern for Internet companies
IPpattern	:= '^(.*)(.COM[,]* |.NET |.ORG |.GOV |.EDU |.MIL |.INT )(.*)';

//Date Pattern
Datepattern := '^(.*)/(.*)/(.*)$';                      


maribase_plus_dbas := RECORD,MAXLENGTH(8000)
  Prof_License_Mari.layouts.base;
  STRING60 dba1;
  STRING60 dba2;
  STRING60 dba3;
  STRING60 dba4;
  STRING60 dba5;
END;

//raw to MARIBASE layout - Company
maribase_plus_dbas	transformToCommon_CO(Layout_clean_name pInput) := TRANSFORM
	SELF.PRIMARY_KEY	:= 0;
	SELF.CREATE_DTE		:= thorlib.wuid()[2..9]; //yyyymmdd
	SELF.LAST_UPD_DTE	:= process_dte;
	SELF.STAMP_DTE		:= process_dte; //yyyymmdd
	SELF.DATE_FIRST_SEEN	:= process_dte;
	SELF.DATE_LAST_SEEN		:= process_dte;
	SELF.DATE_VENDOR_FIRST_REPORTED		:= process_dte;
	SELF.DATE_VENDOR_LAST_REPORTED		:= process_dte;
	SELF.PROCESS_DATE									:= thorlib.wuid()[2..9];
	SELF.STD_SOURCE_UPD	:= src_cd;
	SELF.STD_SOURCE_DESC	:= 'NATIONWIDE MORTGAGE LICENSING SYSTEM & REGISTRY';
	
	tempLicNum           := ut.CleanSpacesAndUpper(pInput.LICENSE_NBR);
	SELF.LICENSE_NBR	   := IF(tempLicNum != ' ',tempLicNum,'NR');
	
	tempLicenseSt				:= ut.CleanSpacesAndUpper(pInput.REGULATOR);
	clnState						:= IF(REGEXFIND('-',tempLicenseSt),tempLicenseSt[1..stringlib.stringfind(tempLicenseSt,'-',1) -1],tempLicenseSt);
	SELF.REGULATOR		  := tempLicenseSt;
	SELF.LICENSE_STATE	:= IF(clnState = ' ','US',
														IF(LENGTH(clnState) >2,ut.st2abbrev(clnState),clnState));
			
// assigning type
	tempTypeCd		  	:= IF(pInput.cname = ' ','MD','GR');
	SELF.TYPE_CD      := tempTypeCd;
	
// Prepping ORG_NAME to handle various conditions 
// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
// 2.) Handle AKA Names to First, Middle Last Format
// 3.) Standardized corporation suffixes
	UpperOrgName				:= ut.CleanSpacesAndUpper(pInput.NAME);
	fixname							:= IF(REGEXFIND('RE/MAX ',UpperOrgName), REGEXREPLACE('/',UpperOrgName,' '),UpperOrgName);
	tempTrimName     := fixname;
	tempTrimNameFix1 := stringlib.stringfindreplace(tempTrimName,'; DBA ',' DBA ');
	tempTrimNameFix2 := stringlib.stringfindreplace(tempTrimNameFix1,', DBA ',' DBA ');
	tempTrimNameFix3 := IF(tempTrimNameFix2[1..4]= 'DBA ', TRIM(tempTrimNameFix2[5..],LEFT,RIGHT),tempTrimNameFix2);
	tempTrimNameFix4 := stringlib.stringfindreplace(tempTrimNameFix3,'/DBA ',' DBA ');
	tempTrimNameFix5 := stringlib.stringfindreplace(tempTrimNameFix4,' D B A ',' DBA ');
	tempTrimNameFix6 := stringlib.stringfindreplace(tempTrimNameFix5,' T/A ',' DBA ');
	tempTrimNameFix7 := stringlib.stringfindreplace(tempTrimNameFix6,' (DBA)/ ',' DBA ');
	tempTrimNameFix8 := stringlib.stringfindreplace(tempTrimNameFix7,';',' DBA ');
	tempTrimNameFix9 := stringlib.stringfindreplace(tempTrimNameFix8,'"','');
	tempTrimNameFix10 := stringlib.stringcleanspaces(tempTrimNameFix9);

	getCorpOnly					:= IF(REGEXFIND(DBApattern,tempTrimNameFix10), REGEXFIND(DBApattern,tempTrimNameFix10,1)
													,StringLib.StringCleanSpaces(tempTrimNameFix10));		 //get names without DBA names
	FullIndvName				:= stringlib.stringcleanspaces(pInput.lname+' '+pInput.fname);
													
	tmpNameOrg					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(getCorpOnly); //business name with standard corp abbr.
	tmpNameOrgSufx			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(tmpNameOrg);
	clnOrgName					:= IF(tempTypeCd = 'MD' AND TRIM(FullIndvName) != ' ',FullIndvName,
													 IF(tempTypeCd = 'MD' AND TRIM(FullIndvName) = ' ',UpperOrgName,
														IF(REGEXFIND(IPpattern,getCorpOnly),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')),
															Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',tmpNameOrg,' CO')))));  //Without punct. and Sufx removed
	SELF.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(tmpNameOrg);
	SELF.NAME_ORG				:= REGEXREPLACE('/',clnOrgName,' ');
	SELF.NAME_ORG_SUFX 	:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',tmpNameOrgSufx, ''));
	
	SELF.NAME_PREFX   	:= IF(tempTypeCd ='MD',TRIM(pInput.title,LEFT,RIGHT),'');
	SELF.NAME_FIRST			:= IF(tempTypeCd ='MD',TRIM(pInput.fname,LEFT,RIGHT),'');
	SELF.NAME_MID				:= IF(tempTypeCd ='MD',TRIM(pInput.mname,LEFT,RIGHT),'');
	SELF.NAME_LAST			:= IF(tempTypeCd ='MD',TRIM(pInput.lname,LEFT,RIGHT),'');
	SELF.NAME_SUFX			:= IF(tempTypeCd ='MD',TRIM(pInput.name_suffix,LEFT,RIGHT),'');
		

// initialize raw_license_type from raw data
	tempRawType  := ut.CleanSpacesAndUpper(pInput.LICENSE_TYPE);												 
  SELF.RAW_LICENSE_TYPE := tempRawType;
																	 													         
// map raw license type to standard license type before profcode translations
	tempStdLicType        := '';															 
  SELF.STD_LICENSE_DESC := tempRawType;
	
//Prof_cd based on raw license type
	SELF.STD_PROF_CD		:= MAP(REGEXFIND('MORTGAGE',tempRawType) => 'MTG',
														REGEXFIND('REAL ESTATE',tempRawType) => 'RLE',
														REGEXFIND('APPRAISER',tempRawType) => 'APR','LND');
	SELF.STD_PROF_DESC	:= ' ';
   	
// assigning dates per business rules
	SELF.EXPIRE_DTE		   := '17530101';
	SELF.ORIG_ISSUE_DTE  := Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ORIG_ISSUE_DATE);
	SELF.CURR_ISSUE_DTE  := Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EFFECTIVE_DATE);
	SELF.RENEWAL_DTE		 := ut.CleanSpacesAndUpper(pInput.RENEW_THRU);
	SELF.INST_BEG_DTE  := IF(TRIM(pInput.DATEFORMED) <> '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.DATEFORMED),'17530101');
//initialize raw_license_status from raw data
	tempRawStatus 					:= ut.CleanSpacesAndUpper(pInput.STATUS);
	SELF.RAW_LICENSE_STATUS := tempRawStatus;
	
	tempStdStatus						:= IF(TRIM(tempRawStatus,LEFT,RIGHT) IN active_status_set, 'A',
																IF(TRIM(tempRawStatus,LEFT,RIGHT) IN inactive_status_set,'I',' '));
  SELF.STD_STATUS_DESC    := tempRawStatus;
	 	 
// 1st set of address fields
	tempAdd1_1_1            := ut.CleanSpacesAndUpper(pInput.STREET1);
	tempAdd2_1_1            := ut.CleanSpacesAndUpper(pInput.STREET2);
	
	tempCNTRY						    := ut.CleanSpacesAndUpper(pInput.COUNTRY);
	SELF.ADDR_CNTRY_1		    := IF(tempCNTRY = 'UNITED STATES','US',tempCNTRY);
	
	tempAdd1_1_2            := IF(Prof_License_Mari.func_is_address(tempAdd1_1_1) = FALSE,tempAdd2_1_1,tempAdd1_1_1);
	tempAdd1_1_3            := MAP(tempAdd1_1_2 = '' AND tempAdd2_1_1 != '' => tempAdd2_1_1,
																		 tempAdd1_1_2);
			
	tempAdd2_1_2            := IF(tempAdd1_1_3 = tempAdd2_1_1,'',tempAdd2_1_1);
			
			
	
  prepAddr_Line_11			:= tempAdd1_1_1 + ' ' + tempAdd2_1_1;
	prepAddr_Line_21			:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.City) + ' ' +
	                         Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATE) + ' ' +
													 Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZipCode);
	clnAddrAddr1					:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_11,prepAddr_Line_21);
	tmpADDR_ADDR1_1				:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
	tmpADDR_ADDR2_1				:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
	AddrWithContact1			:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address

	tempCity            := ut.CleanSpacesAndUpper(pInput.CITY);
	tempCity2           := IF(tempCity='N/A','',TRIM(tempCity,LEFT,RIGHT));
	tempCity3           := IF(REGEXFIND(',$',tempCity2),REGEXREPLACE(',',tempCity2,''),tempCity2);
	
  Cln_City_1  			    := IF(SELF.ADDR_CNTRY_1 IN ['US',''],REGEXREPLACE(',',TRIM(clnAddrAddr1[65..89]),''),tempCity3);
  Cln_City_2	          := StringLib.StringFilterOut(Cln_City_1,'0123456789');
  Cln_City_3            := StringLib.StringCleanSpaces(Cln_City_2);		
	
	tempState           := IF(ut.CleanSpacesAndUpper(pInput.STATE) IN ['NULL','N/A','NA'],'',ut.CleanSpacesAndUpper(pInput.STATE));

	tempZip3            := ut.CleanSpacesAndUpper(stringlib.stringfindreplace(pInput.ZIPCODE,'-',''));
	tempZip4            := IF(tempZip3 IN ['NULL','N/A','NA'],'',stringlib.stringfindreplace(tempZip3,' ',''));
	tempZip44           := IF(LENGTH(tempZip4)=4, '0'+tempZip4, tempZip4);

	tempZip4_1        		:= tempZip44[6..9];

	
	GoodADDR_ADDR1_1			:= MAP(SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR1_1!='' AND StringLib.StringFind(tmpADDR_ADDR1_1,prepAddr_Line_21,1)>0
													         => StringLib.StringCleanSpaces(StringLib.StringFindReplace(tmpADDR_ADDR1_1,prepAddr_Line_21,'')),
	                         SELF.ADDR_CNTRY_1 IN ['US',''] AND AddrWithContact1 != '' AND tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR1_1 !='' AND TRIM(tmpADDR_ADDR1_1,LEFT,RIGHT) = TRIM(Cln_City_3,LEFT,RIGHT)
													         => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1), 
													 SELF.ADDR_CNTRY_1 NOT IN ['US','']
													         => StringLib.StringCleanSpaces(tempAdd1_1_3),
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
																 
	GoodADDR_ADDR2_1			:= MAP(SELF.ADDR_CNTRY_1 IN ['US',''] AND AddrWithContact1!='' => '',
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR2_1='' => '',
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND TRIM(tmpADDR_ADDR1_1) = TRIM(tmpADDR_ADDR2_1) => '',
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR1_1 !='' AND TRIM(tmpADDR_ADDR1_1,LEFT,RIGHT) = TRIM(Cln_City_3,LEFT,RIGHT) => '',
													 SELF.ADDR_CNTRY_1 NOT IN ['US','']  => StringLib.StringCleanSpaces(tempAdd2_1_2),
													 StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 

	SELF.ADDR_ADDR1_1     := IF(GoodADDR_ADDR1_1 = Cln_City_3,GoodADDR_ADDR2_1,
	                            IF(GoodADDR_ADDR1_1[(LENGTH(GoodADDR_ADDR1_1)-4)..] = tempZip44[1..5],        
																   StringLib.StringCleanSpaces(StringLib.StringFindReplace(GoodADDR_ADDR1_1,tempZip44[1..5],'')),
																   GoodADDR_ADDR1_1));
	
	SELF.ADDR_ADDR2_1     := IF(GoodADDR_ADDR2_1 = Cln_City_3 or GoodADDR_ADDR1_1 = Cln_City_3, '',
	                            GoodADDR_ADDR2_1);
															
	SELF.ADDR_CITY_1      := Cln_City_3;
	
	SELF.ADDR_STATE_1		  := IF(SELF.ADDR_CNTRY_1 IN ['US',''],TRIM(clnAddrAddr1[115..116]),tempState);
  SELF.ADDR_ZIP5_1			:= IF(SELF.ADDR_CNTRY_1 IN ['US',''],TRIM(clnAddrAddr1[117..121]),tempZip44[1..5]);
  SELF.ADDR_ZIP4_1			:= IF(SELF.ADDR_CNTRY_1 IN ['US',''],clnAddrAddr1[122..125],
	                            IF(tempZip4_1 = '0000',' ',tempZip4_1));

// assign business address indicator to true (B) if business address fields are not empty
	SELF.ADDR_BUS_IND	  := IF(TRIM(pInput.STREET1 + pInput.CITY + pInput.STATE + pInput.ZIPCODE,LEFT,RIGHT) != '','B','');	
     
// assign two holders for raw data per mari business rules
	SELF.NAME_FORMAT			:= IF(tempTypeCd = 'MD','L','F');
	SELF.NAME_ORG_ORIG		:= UpperOrgName;
	
// assign mari_org with semi-clean name data per business rules
	SELF.NAME_MARI_ORG		:= IF(tempTypeCd ='MD','',
															IF(SELF.NAME_ORG != ' ' AND REGEXFIND(IPpattern,tmpNameOrg),tmpNameOrg,
																	IF(SELF.NAME_ORG != ' ' AND NOT REGEXFIND(IPpattern,tmpNameOrg),
																				prof_license_mari.mod_clean_name_addr.strippunctMisc(tmpNameOrg),' ')));
				

// Business rules to standardize DBA(s) for splitting into multiple records

// Populate if DBA exist in ORG_NAME field
	DBAOnly       	:= IF(tempTrimNameFix10 != '',prof_license_mari.mod_clean_name_addr.getDBAname(tempTrimNameFix10),'');
	trimDBA       	:= ut.CleanSpacesAndUpper(DBAOnly);
	trimDBA2      	:= IF(trimDBA = tempTrimNameFix10,'',trimDBA);
	UpperDBAName	:= ut.CleanSpacesAndUpper(stringlib.stringfindreplace(pInput.DBA,'"',''));
	RmvPreDBA			:= IF(REGEXFIND('^DBA ',UpperDBAName),REGEXREPLACE('^DBA ',UpperDBAName,''),UpperDBAName);
	ClnNameDBA		:= IF(REGEXFIND('RE/MAX ',RmvPreDBA),REGEXREPLACE('/',RmvPreDBA,' '),RmvPreDBA);
	prepDBA				:= IF(REGEXFIND(DBApattern,ClnNameDBA),
											REGEXREPLACE('(;[ ]*DBA |,[ ]*DBA |/DBA/|DBA |C/O |D B A |D/B/A |AKA |;|AND/OR |T/A|/)',ClnNameDBA, ' / '),ClnNameDBA);
	ClnSpaceDBA		:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepDBA));
  tmpDBA				:= IF(trimDBA2 != ' ' AND TRIM(trimDBA2,LEFT,RIGHT) != TRIM(ClnNameDBA,LEFT,RIGHT), trimDBA2,' ');	
	SELF.NAME_DBA_ORIG		:= UpperDBAName;
	TmpName_Type      := stringlib.stringfindreplace(ut.CleanSpacesAndUpper(pInput.NAME_TYPE),'"','');
	SELF.NAME_TYPE    := IF(TmpName_Type = 'PRIORINSTITUTIONLEGAL','PRINSTLEGL',TmpName_Type);
	SELF.DBA1			:=  MAP(tmpDBA != ' ' => tmpDBA,
											StringLib.stringfind(ClnSpaceDBA,'/',1) = 0	=> ClnSpaceDBA,
											StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,',',1) > 0 => REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',ClnSpaceDBA,2),
											StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,1),
											StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,1),
											StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',ClnSpaceDBA,1),
											StringLib.stringfind(ClnSpaceDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',ClnSpaceDBA,1),ClnSpaceDBA);
		  
	SELF.dba2			:= MAP(tmpDBA != ' ' AND StringLib.stringfind(ClnSpaceDBA,'/',1) = 0	=> ClnSpaceDBA,
											StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,2),
											StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,2),
							        StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',ClnSpaceDBA,2),
											StringLib.stringfind(ClnSpaceDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',ClnSpaceDBA,2),' ');
			 			
	SELF.dba3 			:= MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
											StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
											StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 =>
											REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',ClnSpaceDBA,3),'');
			
	SELF.dba4 		:= MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
											StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,3),
											StringLib.stringfind(ClnSpaceDBA,'/',3) > 0  
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)',ClnSpaceDBA)
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)',ClnSpaceDBA,4),										
											StringLib.stringfind(ClnSpaceDBA,'/',3) > 0 
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ])$',ClnSpaceDBA)									   
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ])$',ClnSpaceDBA,4),
											'');
			
	SELF.dba5 		:= MAP(StringLib.stringfind(ClnSpaceDBA,'/',1) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,4),
											StringLib.stringfind(ClnSpaceDBA,'/',2) > 0 AND StringLib.stringfind(ClnSpaceDBA,';',1) > 0 =>	  
											REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',ClnSpaceDBA,4),
											StringLib.stringfind(ClnSpaceDBA,'/',4) > 0 
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',ClnSpaceDBA)
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',ClnSpaceDBA,5), 										
											StringLib.stringfind(ClnSpaceDBA,'/',4) > 0 
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',ClnSpaceDBA)
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',ClnSpaceDBA,5),
											'');
	
			
//affiliation type code
	SELF.affil_type_cd 					:= pInput.affil_type_cd;	
	SELF.NMLS_ID								:= IF(pInput.affil_type_cd = 'CO',pInput.COMPANY_NMLS_ID,
																		IF(pInput.affil_type_cd = 'BR',pInput.BRANCH_NMLS_ID,
																				0));
  SELF.FOREIGN_NMLS_ID				:= IF(pInput.affil_type_cd = 'BR',pInput.COMPANY_NMLS_ID,0);
	SELF.LICENSE_ID							:= pInput.LICENSE_ID;
	SELF.is_AUTHORIZED_CONDUCT	:= ut.CleanSpacesAndUpper(pInput.IS_AUTHORIZED);
	SELF.is_AUTHORIZED_LICENSE 	:= ut.CleanSpacesAndUpper(pInput.IS_AUTHORIZED_LICENSE);
	SELF.BUSINESS_TYPE					:= ut.CleanSpacesAndUpper(pInput.BUSINESS_STRUCTURE);
														 
	
	//Federal Regulating Agency			
	SELF.AGENCY_STATUS	:= ut.CleanSpacesAndUpper(pInput.fedstatus);
	SELF.FEDERAL_REGULATOR := ut.CleanSpacesAndUpper(pInput.FEDREGULATOR); 
	TrimStockSymbol := StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.StockSymbol),'"');
 ValidStockSymbol := MAP(TrimStockSymbol = 'NONE' => '',
                         TrimStockSymbol = 'N/A' => '',
												             TrimStockSymbol = 'NA' => '',
                         TrimStockSymbol);	
	
	SELF.PROVNOTE_2 := IF(TRIM(pInput.FiscalYearEnd) <> '','FISCAL YEAR END: ' + ut.CleanSpacesAndUpper(pInput.FiscalYearEnd) + ';','')  + 
	                   IF(TRIM(pInput.FormedIn) <> '','FORMED IN: ' + ut.CleanSpacesAndUpper(pInput.FormedIn) + ';','') + 
										          IF(ValidStockSymbol <> '','STOCK SYMBOL: ' + TrimStockSymbol,'');
		
/* fields used to create mltreckey key ato handke multiple dba's:
	license number
	license type
	source update
	name
	address_1
	dba
	officename
*/
			 
// Using NMLS unique ID for the mltreckey 
	
	SELF.MLTRECKEY := IF(pInput.affil_type_cd = 'BR' AND TRIM(SELF.dba2) != ' ' AND TRIM(SELF.dba1) <> TRIM(SELF.dba2)
													,HASH64(pInput.BRANCH_NMLS_ID + ',' 
																+ pInput.COMPANY_NMLS_ID + ',' 
																+ ut.CleanSpacesAndUpper(pInput.REGULATOR) + ','
																+ UpperDBAName),
																
												IF(pInput.affil_type_cd = 'CO' AND TRIM(SELF.dba2) != ' ' AND TRIM(SELF.dba1) <> TRIM(SELF.dba2)
													,HASH64(pInput.COMPANY_NMLS_ID + ',' 
																+ ut.CleanSpacesAndUpper(pInput.REGULATOR) + ','
																+ ut.CleanSpacesAndUpper(pInput.FEDREGULATOR) + ','
																+ UpperDBAName),
																				0));
													
/* fields used to create unique key are:
	license number
  license type
	source update
	name
	address
*/		 
	
	SELF.cmc_slpk   := IF(pInput.affil_type_cd = 'CO',
														HASH64(SELF.NMLS_ID + ','
																		+ ut.CleanSpacesAndUpper(pInput.REGULATOR) + ','
																		+ ut.CleanSpacesAndUpper(pInput.FEDREGULATOR) + ','
																		+ pInput.LICENSE_ID + ','
																		+ tempRawType),
												IF(pInput.affil_type_cd = 'BR',
														HASH64(SELF.NMLS_ID + ','
																		+ SELF.FOREIGN_NMLS_ID + ','
																		+ ut.CleanSpacesAndUpper(pInput.REGULATOR) + ','
																		+ pInput.LICENSE_ID + ','
																		+ tempRawType),
																				0));
	SELF.pcmc_slpk	:= 0;
	SELF := [];		   		   
END;

ds_map_co := PROJECT(temp_active_dedup, transformToCommon_CO(LEFT)) : PERSIST('~thor_data400::persist::nmls::co_br_intermediate');;



//Clean Up Individual File
cleanedUp_IndvNames := Prof_License_Mari.file_NMLS_indv(individual);
cleanedUp_IndvAka		:= prof_License_mari.file_NMLS_Indv_AKA(IndivAKA);

// Individual Files Addl Joining
// Layout to join multiple AKA records to single parent record
layout_indv_with_aka	:= RECORD
	UNSIGNED1 numRows;
	Prof_License_Mari.layouts_NMLS0900.INDIVIDUAL;
	STRING50	orig_first_name;
	STRING50	orig_middle_name;
	STRING50	orig_last_name;
	STRING10  orig_suffix;
	STRING10	std_name_prefix;
	STRING10  std_name_suffix;
	STRING10	std_name_title;
	STRING30	nickname;
	STRING10	gender;
	STRING50  maiden_name;
	STRING15  marital_status;
	STRING10  std_name_type;
	STRING10  misc_info;			// possible ssn, birth_date
	STRING50  url;
	STRING60	AKA1	:= ' ';
	STRING50	AKA2	:= ' ';
	STRING50	AKA3	:= ' ';
	STRING50	AKA4	:= ' ';
	STRING50	AKA5	:= ' ';
	STRING50	AKA6	:= ' ';
	STRING10	NAME_TYPE_1 := ' ';
	STRING10	NAME_TYPE_2 := ' ';
	STRING10	NAME_TYPE_3 := ' ';
	STRING10	NAME_TYPE_4 := ' ';
	STRING10	NAME_TYPE_5 := ' ';
	STRING10	NAME_TYPE_6 := ' ';
	STRING10  misc_info_1;
	STRING10  misc_info_2;
	STRING10  misc_info_3;
	STRING10  misc_info_4;
	STRING10  misc_info_5;
	STRING10  misc_info_6;
	STRING15  marital_status_1;
	STRING15  marital_status_2;
	STRING15  marital_status_3;
	STRING15  marital_status_4;
	STRING15  marital_status_5;
	STRING15  marital_status_6;
	STRING10	gender_1;
	STRING10	gender_2;
	STRING10	gender_3;
	STRING10	gender_4;
	STRING10	gender_5;
	STRING10	gender_6;
END;



layout_indv_with_aka map_indv_aka(cleanedUp_IndvNames L):= TRANSFORM
	SELF.numRows	:= 0;
	SELF.std_name_suffix := L.suffix;
	SELF.std_name_type := IF(L.std_name_type = '' AND L.maiden_name != '','OTHER','');
	SELF := L;
	SELF := [];
END;

ds_indv				:= PROJECT(cleanedUp_IndvNames,map_indv_aka(LEFT));
srt_indv			:= SORT(ds_indv, INDIVIDUAL_NMLS_ID);


// /*

//Denormalize the individual file to include multiple AKA's linked by INDIVIDUAL_NMLS_ID
layout_indv_with_aka DenormAKA(layout_indv_with_aka L, cleanedUp_IndvAka R, INTEGER C) := TRANSFORM
		SELF.numRows := C;
	  remove_punct :=	StringLib.StringFilterOut(R.NICKNAME,'&()');
		remove_AKA	:= IF(remove_punct[1..4] = 'AKA ',remove_punct[5..],remove_punct); 
		tmpNickName := REGEXREPLACE('(I DO NOT HAVE A MIDDLE NAME|INITIAL ONLY, NO MIDDLE NAME|MIS-SPELLING|MISPELLED|MAIDEN|NICKNAMES)',
										remove_AKA,'');
		SELF.AKA1	:= IF(C=1, stringlib.stringcleanspaces(R.First_Name+' '+R.Middle_Name+' '+R.Last_Name+ IF(R.suffix != '',','+R.Suffix,'') +IF(R.maiden_name != '',';MAIDEN NAME: '+ R.maiden_name,'')+ IF(tmpNickName != '',';NICKNAME: '+tmpNickName,'')), stringlib.stringcleanspaces(L.AKA1));
		SELF.AKA2	:= IF(C=2, stringlib.stringcleanspaces(R.First_Name+' '+R.Middle_Name+' '+R.Last_Name+ IF(R.suffix != '',','+R.Suffix,'') +IF(R.maiden_name != '',';MAIDEN NAME: '+ R.maiden_name,'')+ IF(tmpNickName != '',';NICKNAME: '+tmpNickName,'')), stringlib.stringcleanspaces(L.AKA2));
		SELF.AKA3	:= IF(C=3, stringlib.stringcleanspaces(R.First_Name+' '+R.Middle_Name+' '+R.Last_Name+ IF(R.suffix != '',','+R.Suffix,'') +IF(R.maiden_name != '',';MAIDEN NAME: '+ R.maiden_name,'')+ IF(tmpNickName != '',';NICKNAME: '+tmpNickName,'')), stringlib.stringcleanspaces(L.AKA3));
		SELF.AKA4	:= IF(C=4, stringlib.stringcleanspaces(R.First_Name+' '+R.Middle_Name+' '+R.Last_Name+ IF(R.suffix != '',','+R.Suffix,'') +IF(R.maiden_name != '',';MAIDEN NAME: '+ R.maiden_name,'')+ IF(tmpNickName != '',';NICKNAME: '+tmpNickName,'')), stringlib.stringcleanspaces(L.AKA4));
		SELF.AKA5	:= IF(C=5, stringlib.stringcleanspaces(R.First_Name+' '+R.Middle_Name+' '+R.Last_Name+ IF(R.suffix != '',','+R.Suffix,'') +IF(R.maiden_name != '',';MAIDEN NAME: '+ R.maiden_name,'')+ IF(tmpNickName != '',';NICKNAME: '+tmpNickName,'')), stringlib.stringcleanspaces(L.AKA5));
		SELF.AKA6	:= IF(C=6, stringlib.stringcleanspaces(R.First_Name+' '+R.Middle_Name+' '+R.Last_Name+ IF(R.suffix != '',','+R.Suffix,'') +IF(R.maiden_name != '',';MAIDEN NAME: '+ R.maiden_name,'')+ IF(tmpNickName != '',';NICKNAME: '+tmpNickName,'')), stringlib.stringcleanspaces(L.AKA6));
		convertNameType := IF(R.std_NAME_TYPE = 'LEGAL NAME','PRIORLEGAL',
													IF(R.std_NAME_TYPE = 'MAIDEN NAME','OTHER',
															R.std_NAME_TYPE));
		convertGender := IF(R.gender IN ['FEMALE','FEMAIL','FEMAL'],'F',
												IF(R.gender IN ['MALE','MAEL'], 'M',
														''));
		convertMaritalStatus := IF(R.marital_status IN ['DIVORCE','DIVORCED'],'DIVORCED',
															 IF(R.marital_status IN ['MARIED','MARRIED'],'MARRIED',
																''));
		SELF.NAME_TYPE_1	:= IF(C=1, convertNameType,''); 
		SELF.NAME_TYPE_2	:= IF(C=2, convertNameType,''); 
		SELF.NAME_TYPE_3	:= IF(C=3, convertNameType,''); 
		SELF.NAME_TYPE_4	:= IF(C=4, convertNameType,''); 
		SELF.NAME_TYPE_5	:= IF(C=5, convertNameType,''); 
		SELF.NAME_TYPE_6	:= IF(C=6, convertNameType,''); 
		SELF.MARITAL_STATUS_1	:= IF(C=1, stringlib.stringcleanspaces(convertMaritalStatus),''); 
		SELF.MARITAL_STATUS_2	:= IF(C=2, stringlib.stringcleanspaces(convertMaritalStatus),''); 
		SELF.MARITAL_STATUS_3	:= IF(C=3, stringlib.stringcleanspaces(convertMaritalStatus),''); 
		SELF.MARITAL_STATUS_4	:= IF(C=4, stringlib.stringcleanspaces(convertMaritalStatus),''); 
		SELF.MARITAL_STATUS_5	:= IF(C=5, stringlib.stringcleanspaces(convertMaritalStatus),''); 
		SELF.MARITAL_STATUS_6	:= IF(C=6, stringlib.stringcleanspaces(convertMaritalStatus),''); 
		SELF.GENDER_1	:= IF(C=1, stringlib.stringcleanspaces(convertGender),''); 
		SELF.GENDER_2	:= IF(C=2, stringlib.stringcleanspaces(convertGender),''); 
		SELF.GENDER_3	:= IF(C=3, stringlib.stringcleanspaces(convertGender),''); 
		SELF.GENDER_4	:= IF(C=4, stringlib.stringcleanspaces(convertGender),''); 
		SELF.GENDER_5	:= IF(C=5, stringlib.stringcleanspaces(convertGender),''); 
		SELF.GENDER_6	:= IF(C=6, stringlib.stringcleanspaces(convertGender),''); 
		SELF.MISC_INFO_1	:= IF(C=1, R.MISC_INFO,''); 
		SELF.MISC_INFO_2	:= IF(C=2, R.MISC_INFO,''); 
		SELF.MISC_INFO_3	:= IF(C=3, R.MISC_INFO,''); 
		SELF.MISC_INFO_4	:= IF(C=4, R.MISC_INFO,''); 
		SELF.MISC_INFO_5	:= IF(C=5, R.MISC_INFO,''); 
		SELF.MISC_INFO_6	:= IF(C=6, R.MISC_INFO,''); 
		SELF	:= L;
END;

DeNormedRecs := DENORMALIZE(srt_indv, cleanedUp_IndvAka,
														LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID,
														DenormAKA(LEFT,RIGHT,COUNTER));

// Populating IndividualLicense File
rRawIndividual_layout	:=
RECORD
	layout_indv_with_aka AND NOT NUMROWS;
	Prof_License_Mari.layouts_NMLS0900.INDIVIDUAL_LIC AND NOT [INDIVIDUAL_NMLS_ID];
	Prof_License_Mari.layouts_NMLS0900.INDIVIDUAL_LOCATION AND NOT [INDIVIDUAL_NMLS_ID];
	STRING affil_type_cd;
END;

inFileIndividual := PROJECT(DeNormedRecs,TRANSFORM(rRawIndividual_layout,
																				 SELF.affil_type_cd := 'IN';
																				 SELF := LEFT;
																			   SELF := []));

//Join Individual Files
rRawIndividual_layout 	trans_Individual(inFileIndividual L, Individual_lic R) := TRANSFORM
  SELF.REGULATOR 					:= R.REGULATOR;
	SELF.LICENSE_ID 				:= R.LICENSE_ID;
	SELF.LICENSE_NBR 				:= R.LICENSE_NBR;
	SELF.LICENSE_TYPE 			:= R.LICENSE_TYPE;
	SELF.ORIG_ISSUE_DATE 		:= R.ORIG_ISSUE_DATE;
	SELF.STATUS 						:= R.STATUS;
	SELF.EFFECTIVE_DATE 		:= R.EFFECTIVE_DATE;
	SELF.IS_AUTHORIZED_LICENSE 			:= R.IS_AUTHORIZED_LICENSE;	
	SELF.RENEW_THRU					:= R.RENEW_THRU;
	SELF := L;
END;

ds_Individual_lic := JOIN(inFileIndividual, Individual_lic,
													LEFT.INDIVIDUAL_NMLS_ID= RIGHT.INDIVIDUAL_NMLS_ID,
													trans_Individual(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);


rRawIndividual_layout 	trans_Individual_loc(ds_Individual_lic L, location R) := TRANSFORM
  SELF.COMPANY 					:= R.COMPANY;
	SELF.LOCATION_NMLS_ID := R.LOCATION_NMLS_ID;
	SELF.LOCATION_TYPE 		:= R.LOCATION_TYPE;
	SELF.STREET1 					:= R.STREET1;
	SELF.CITY 						:= R.CITY;
	SELF.STATE 						:= R.STATE;
	SELF.ZIPCODE 					:= R.ZIPCODE;
	SELF.COUNTRY 					:= R.COUNTRY;
	SELF.START_DATE				:= R.START_DATE;
	SELF := L;
END;

ds_Individual_loc := JOIN(ds_Individual_lic, location,
													LEFT.INDIVIDUAL_NMLS_ID= RIGHT.INDIVIDUAL_NMLS_ID,
													trans_Individual_loc(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);


// Dedup for duplicate active individual licenses under the same regulator
temp_active_indv_dedup := DEDUP(ds_Individual_loc,LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID AND
																								 LEFT.REGULATOR = RIGHT.REGULATOR AND
																					       LEFT.LICENSE_NBR = RIGHT.LICENSE_NBR AND
																						     LEFT.LICENSE_TYPE = RIGHT.LICENSE_TYPE AND
																						     StringLib.StringToUppercase(LEFT.STATUS) IN active_status_set AND
																								 StringLib.StringToUppercase(RIGHT.STATUS) IN active_status_set,LEFT);
																								 																						 
//raw to MARIBASE layout - Individual
maribase_plus_dbas		transformToCommon_Indv(rRawIndividual_layout pInput) := TRANSFORM

	SELF.PRIMARY_KEY									:= 0;
	SELF.CREATE_DTE										:= thorlib.wuid()[2..9]; //yyyymmdd
	SELF.LAST_UPD_DTE									:= process_dte;
	SELF.STAMP_DTE										:= process_dte; //yyyymmdd
	SELF.DATE_FIRST_SEEN							:= process_dte;
	SELF.DATE_LAST_SEEN								:= process_dte;
	SELF.DATE_VENDOR_FIRST_REPORTED		:= process_dte;
	SELF.DATE_VENDOR_LAST_REPORTED		:= process_dte;
	SELF.PROCESS_DATE									:= thorlib.wuid()[2..9];
	SELF.STD_SOURCE_UPD	:= src_cd;
	SELF.STD_SOURCE_DESC	:= 'NATIONWIDE MORTGAGE LICENSING SYSTEM & REGISTRY';
	tempLicNum           := ut.CleanSpacesAndUpper(Prof_License_Mari.mod_clean_name_addr.strippunctName(pInput.LICENSE_NBR));
	SELF.LICENSE_NBR	   := IF(tempLicNum != ' ',tempLicNum,'NR');

	tempLicenseSt				:= ut.CleanSpacesAndUpper(pInput.REGULATOR);
	clnState						:= IF(REGEXFIND('-',tempLicenseSt),tempLicenseSt[1..stringlib.stringfind(tempLicenseSt,'-',1) -1],tempLicenseSt);
	SELF.LICENSE_STATE	:= IF(clnState = ' ','US',
													IF(LENGTH(clnState) >2,ut.st2abbrev(clnState),clnState));
	SELF.REGULATOR			:= tempLicenseSt;
	
// assigning type
	tempTypeCd		  	:= 'MD';
	SELF.TYPE_CD      := tempTypeCd;
	
// Prepping ORG_NAME to handle various conditions 
// 1.) Handle AKA Names to First, Middle Last Format
// 2.) Full name format as LSF - omit middle name in org_name
	trimFname        := ut.CleanSpacesAndUpper(pInput.FIRST_NAME);
	trimLname        := ut.CleanSpacesAndUpper(pInput.LAST_NAME);
	trimMname        := ut.CleanSpacesAndUpper(pInput.MIDDLE_NAME);
	trimJRSR         := stringlib.stringcleanspaces(ut.CleanSpacesAndUpper(pInput.SUFFIX));

	FullIndvName		 := stringlib.stringcleanspaces(trimLname+' '+trimFname);

	SELF.NAME_ORG				:= stringlib.stringfindreplace(FullIndvName,'.','');
	SELF.NAME_PREFX   	:= '';
	SELF.NAME_FIRST			:= trimFname;
	SELF.NAME_MID				:= trimMname;
	SELF.NAME_LAST			:= trimLname;
	SELF.NAME_SUFX			:= stringlib.stringfindreplace(trimJRSR,'.','');
	SELF.NAME_NICK			:= stringlib.stringcleanspaces(pInput.NICKNAME);
	
// initialize raw_license_type from raw data
	tempRawType  := ut.CleanSpacesAndUpper(pInput.LICENSE_TYPE);												 
  SELF.RAW_LICENSE_TYPE := tempRawType;
																	 													         
// map raw license type to standard license type before profcode translations
	tempStdLicType        := '';															 
  SELF.STD_LICENSE_TYPE := '';
	SELF.STD_LICENSE_DESC	:= tempRawType;
	
//Prof_cd based on raw license type
	SELF.STD_PROF_CD		:= MAP(REGEXFIND('MORTGAGE',tempRawType) => 'MTG',
														REGEXFIND('REAL ESTATE',tempRawType) => 'RLE',
														REGEXFIND('APPRAISER',tempRawType) => 'APR','LND');
	SELF.STD_PROF_DESC	:= ' ';
   	
// assigning dates per business rules
	SELF.EXPIRE_DTE		   := '17530101';
	SELF.ORIG_ISSUE_DTE  	:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ORIG_ISSUE_DATE);
	SELF.CURR_ISSUE_DTE  	:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.EFFECTIVE_DATE);
	SELF.RENEWAL_DTE			:= ut.CleanSpacesAndUpper(pInput.RENEW_THRU);
	
//initialize raw_license_status from raw data
	tempRawStatus 		:= ut.CleanSpacesAndUpper(pInput.STATUS);
	SELF.RAW_LICENSE_STATUS := tempRawStatus;
	SELF.STD_LICENSE_STATUS	:= '';
	SELF.STD_STATUS_DESC 		:= tempRawStatus;
  
																		
// 1st set of address fields
	tempAdd1_1_1        := ut.CleanSpacesAndUpper(pInput.STREET1);

	tempCNTRY					  := ut.CleanSpacesAndUpper(pInput.COUNTRY);
	SELF.ADDR_CNTRY_1	  := IF(tempCNTRY = 'UNITED STATES','US',tempCNTRY);
		
	
  prepAddr_Line_11	  := tempAdd1_1_1 ;
	prepAddr_Line_21		:= Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.City) + ' ' +
	                        Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.STATE) + ' ' +
												 Prof_License_Mari.mod_clean_name_addr.TrimUpper(pInput.ZipCode);
													 
	clnAddrAddr1				:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(prepAddr_Line_11,prepAddr_Line_21);
	tmpADDR_ADDR1_1			:= TRIM(clnAddrAddr1[1..10],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[11..12],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[13..40],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[41..44],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[45..46],LEFT,RIGHT);																	
	tmpADDR_ADDR2_1			:= TRIM(clnAddrAddr1[47..56],LEFT,RIGHT)+' '+TRIM(clnAddrAddr1[57..64],LEFT,RIGHT);
	AddrWithContact1		:= Prof_License_Mari.mod_clean_name_addr.GetDBAName(tmpADDR_ADDR1_1); //Looks for any stray ATTN and C/O in address
	
	
	tempCity            := ut.CleanSpacesAndUpper(pInput.CITY);
	tempCity2           := IF(tempCity='N/A','',TRIM(tempCity,LEFT,RIGHT));
	tempCity3           := IF(REGEXFIND(',$',tempCity2),REGEXREPLACE(',',tempCity2,''),tempCity2);
	
	
  Cln_City_1  			  := IF(SELF.ADDR_CNTRY_1 IN ['US',''],REGEXREPLACE(',',TRIM(clnAddrAddr1[65..89]),''),tempCity3);
  Cln_City_2	        := StringLib.StringFilterOut(Cln_City_1,'0123456789');
  Cln_City_3          := StringLib.StringCleanSpaces(Cln_City_2);		
	
	tempState           := IF(ut.CleanSpacesAndUpper(pInput.STATE) IN ['NULL','N/A','NA'],'',ut.CleanSpacesAndUpper(pInput.STATE));

	tempZip3            := ut.CleanSpacesAndUpper(stringlib.stringfindreplace(pInput.ZIPCODE,'-',''));
	tempZip4            := IF(tempZip3 IN ['NULL','N/A','NA'],'',stringlib.stringfindreplace(tempZip3,' ',''));
	tempZip44           := IF(LENGTH(tempZip4)=4, '0'+tempZip4, tempZip4);

	tempZip4_1        		:= tempZip44[6..9];
	
	GoodADDR_ADDR1_1			:= MAP(SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR1_1!='' AND StringLib.StringFind(tmpADDR_ADDR1_1,prepAddr_Line_21,1)>0
													         => StringLib.StringCleanSpaces(StringLib.StringFindReplace(tmpADDR_ADDR1_1,prepAddr_Line_21,'')),
	                         SELF.ADDR_CNTRY_1 IN ['US',''] AND AddrWithContact1 != '' AND tmpADDR_ADDR2_1 != ''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR1_1=''
																   => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR1_1!='' AND TRIM(tmpADDR_ADDR1_1,LEFT,RIGHT) = TRIM(Cln_City_3,LEFT,RIGHT)
													         => StringLib.StringCleanSpaces(tmpADDR_ADDR2_1),			
																 StringLib.StringCleanSpaces(tmpADDR_ADDR1_1));
																 
	GoodADDR_ADDR2_1			:= MAP(SELF.ADDR_CNTRY_1 IN ['US',''] AND AddrWithContact1!='' => '',
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR2_1='' => '',
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND TRIM(tmpADDR_ADDR1_1) = TRIM(tmpADDR_ADDR2_1) => '',
													 SELF.ADDR_CNTRY_1 IN ['US',''] AND tmpADDR_ADDR1_1 !='' AND TRIM(tmpADDR_ADDR1_1,LEFT,RIGHT) = TRIM(Cln_City_3,LEFT,RIGHT) => '',
													 SELF.ADDR_CNTRY_1 NOT IN ['US','']  => '',
													 StringLib.StringCleanSpaces(tmpADDR_ADDR2_1)); 
		
	SELF.ADDR_ADDR1_1     := IF(GoodADDR_ADDR1_1 = Cln_City_3,GoodADDR_ADDR2_1,
	                            IF(GoodADDR_ADDR1_1[(LENGTH(GoodADDR_ADDR1_1)-4)..] = tempZip44[1..5],        
																   StringLib.StringCleanSpaces(StringLib.StringFindReplace(GoodADDR_ADDR1_1,tempZip44[1..5],'')),
																   GoodADDR_ADDR1_1));
	SELF.ADDR_ADDR2_1     := IF(GoodADDR_ADDR2_1 = Cln_City_3,'',GoodADDR_ADDR2_1);
		
	SELF.ADDR_CITY_1			:= IF(SELF.ADDR_CNTRY_1 IN ['US',''],REGEXREPLACE(',',TRIM(clnAddrAddr1[65..89]),''),tempCity3);
	SELF.ADDR_STATE_1		  := IF(SELF.ADDR_CNTRY_1 IN ['US',''],TRIM(clnAddrAddr1[115..116]),tempState);
  SELF.ADDR_ZIP5_1			:= IF(SELF.ADDR_CNTRY_1 IN ['US',''],TRIM(clnAddrAddr1[117..121]),tempZip44[1..5]);
  SELF.ADDR_ZIP4_1			:= IF(SELF.ADDR_CNTRY_1 IN ['US',''],clnAddrAddr1[122..125],
	                            IF(tempZip4_1 = '0000',' ',tempZip4_1));

// assign business address indicator to true (B) if business address fields are not empty
	SELF.LOCATION_TYPE	:= ut.CleanSpacesAndUpper(pInput.LOCATION_TYPE);
	tmpLocationInd := CASE(TRIM(SELF.LOCATION_TYPE),
															'BRANCH' => 'R',
															'MAIN'	 =>	'N',
															'WORK'	 => 'W',
																'');
	SELF.ADDR_BUS_IND	  := tmpLocationInd;
	
//assign officename
	temp_OfficeName     := IF(TRIM(pInput.company) != ' ',ut.CleanSpacesAndUpper(pInput.company),'');
	stdOfficeName				:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(temp_OfficeName);
	clnOfficeName				:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(stdOfficeName));
															 																 
	SELF.NAME_OFFICE    := IF(TRIM(clnOfficeName) = TRIM(FullIndvName),'',
														IF(REGEXFIND('.COM',stdOfficeName),stdOfficeName,
															TRIM(REGEXREPLACE(' COMPANY',clnOfficeName,' CO'),LEFT,RIGHT)));			
// office parse
	SELF.OFFICE_PARSE := IF(SELF.NAME_OFFICE != ' ','GR','');
     
// assign two holders for raw data per mari business rules
	tmpMidName_sufx	:= stringlib.stringcleanspaces(trimMname+' '+trimJRSR);
	SELF.NAME_FORMAT		:= 'L';												
	SELF.NAME_ORG_ORIG	:= ut.fn_FormatFullName(trimLName, trimFName, tmpMidName_sufx);
	SELF.NAME_MARI_ORG	:= SELF.NAME_OFFICE;
		
//affiliation type code
	SELF.affil_type_cd := pInput.affil_type_cd;
	
	SELF.START_DTE				:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.start_date);
	SELF.is_AUTHORIZED_LICENSE	:= pInput.is_Authorized_license;
	SELF.NMLS_ID					:= pInput.INDIVIDUAL_NMLS_ID;
	SELF.FOREIGN_NMLS_ID	:= pInput.LOCATION_NMLS_ID;
	SELF.LICENSE_ID				:= pInput.LICENSE_ID;

	SELF.NAME_TYPE			:= '';
	convertGenderFemale := IF((pInput.GENDER = 'F' OR pInput.GENDER_1 = 'F' OR pInput.GENDER_2 = 'F'
															OR pInput.GENDER_3 = 'F' OR pInput.GENDER_4 = 'F' OR pInput.GENDER_5 = 'F'
															OR pInput.GENDER_6 = 'F'),'F','');
	
	convertGenderMale := IF((pInput.GENDER = 'M' OR pInput.GENDER_1 = 'M' OR pInput.GENDER_2 = 'M'
															OR pInput.GENDER_3 = 'M' OR pInput.GENDER_4 = 'M' OR pInput.GENDER_5 = 'M'
															OR pInput.GENDER_6 = 'M'),'M','');
	
	SELF.GENDER := IF(convertGenderFemale != '', convertGenderFemale, convertGenderMale);
	SELF.url :=  pInput.URL;
	convertMiscInfo := MAP(pInput.MISC_INFO != '' => pInput.MISC_INFO,
												 pInput.MISC_INFO_1 != '' => pInput.MISC_INFO_1,
												 pInput.MISC_INFO_2 != '' => pInput.MISC_INFO_2,
												 pInput.MISC_INFO_3 != '' => pInput.MISC_INFO_3,
												 pInput.MISC_INFO_4 != '' => pInput.MISC_INFO_4,
												 pInput.MISC_INFO_5 != '' => pInput.MISC_INFO_5,
												 pInput.MISC_INFO_6 != '' => pInput.MISC_INFO_6,
												 '');
	SELF.MISC_OTHER_ID		:= convertMiscInfo;
	SELF.MISC_OTHER_TYPE	:= IF(convertMiscInfo != '','POS. DOB/SSN','');
	
//Multiple AKA names seperated by a pipe delimiter
	remove_punct :=	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(pInput.MAIDEN_NAME),'&()');
	prepMaidenName := REGEXREPLACE('(MAIDEN)', remove_punct,'');	
	SELF.PROVNOTE_2		:= stringlib.stringcleanspaces(
												 TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_1 IN ['OTHER','PRIOROTHER'] AND pInput.AKA1 <> '','OTHER NAMES: '+pInput.AKA1,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_2 IN ['OTHER','PRIOROTHER'] AND pInput.AKA2 <> '','|'+pInput.AKA2,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_3 IN ['OTHER','PRIOROTHER'] AND pInput.AKA3 <> '','|'+pInput.AKA3,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_4 IN ['OTHER','PRIOROTHER'] AND pInput.AKA4 <> '','|'+pInput.AKA4,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_5 IN ['OTHER','PRIOROTHER'] AND pInput.AKA5 <> '','|'+pInput.AKA5,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_6 IN ['OTHER','PRIOROTHER'] AND pInput.AKA6 <> '','|'+pInput.AKA6,''),LEFT)
												+	TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.STD_NAME_TYPE IN ['OTHER','PRIOROTHER'] AND prepMaidenName <> '','|'+prepMaidenName,''),LEFT)
												);

	SELF.PROVNOTE_3		:= stringlib.stringcleanspaces(
												TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_1 = 'PRIORLEGAL' AND pInput.AKA1 <> '','PRIOR LEGAL NAMES: '+pInput.AKA1,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_1 = 'PRIORLEGAL' AND pInput.AKA2 <> '','|'+pInput.AKA2,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_1 = 'PRIORLEGAL' AND pInput.AKA3 <> '','|'+pInput.AKA3,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_1 = 'PRIORLEGAL' AND pInput.AKA4 <> '','|'+pInput.AKA4,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_1 = 'PRIORLEGAL' AND pInput.AKA5 <> '','|'+pInput.AKA5,''),LEFT)
												+ TRIM(TRIM('',LEFT,RIGHT) + IF(pInput.NAME_TYPE_1 = 'PRIORLEGAL' AND pInput.AKA6 <> '','|'+pInput.AKA6,''),LEFT));
	
		 		
/* fields used to create unique key are:
	license number
  license type
	source update
	name
	address
*/
	
	SELF.cmc_slpk       := 	HASH64(SELF.NMLS_ID + ','
																+ SELF.FOREIGN_NMLS_ID + ','
																+ ut.CleanSpacesAndUpper(pInput.REGULATOR) + ','
																+ pInput.LICENSE_ID + ','
																+ tempRawType);
	
	SELF.pcmc_slpk    	:= 0;
	SELF := [];		   		   
END;

ds_map_indv := PROJECT(temp_active_indv_dedup, transformToCommon_Indv(LEFT)): PERSIST('~thor_data400::persist::nmls::indv_intermediate');


//Combine common layout for both individual and company files
ds_map_all	:= ds_map_co + ds_map_indv;
																	


// Normalized DBA records
maribase_dbas := RECORD,MAXLENGTH(8000)
  maribase_plus_dbas;
  STRING60 tmp_dba;
END;

maribase_dbas	NormIT(ds_map_all L, INTEGER C) := TRANSFORM
   SELF := L;
	SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
END;

NormDBAs 	:= DEDUP(NORMALIZE(ds_map_ALL,5,NormIT(LEFT,COUNTER)),ALL,RECORD);

NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' 
				AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
DBARecs 	:= NormDBAs(TMP_DBA != '');

FilteredRecs  := DBARecs + NoDBARecs;

Prof_License_Mari.layouts.base xTransToBase(FilteredRecs L) := TRANSFORM
	RmvDBA							:= IF(TRIM(L.TMP_DBA,LEFT,RIGHT) = 'DBA','',L.TMP_DBA);
  StdNAME_DBA					:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(RmvDBA);
  DBA_SUFX						:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA);		   
	ClnDBA				 			:= IF(REGEXFIND(IPpattern,L.TMP_DBA),Prof_License_Mari.mod_clean_name_addr.cleanInternetName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')),
													Prof_License_Mari.mod_clean_name_addr.cleanFName(REGEXREPLACE(' COMPANY',StdNAME_DBA,' CO')));
	SELF.NAME_DBA_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
	SELF.NAME_DBA				:= IF(TRIM(ClnDBA,LEFT,RIGHT) != TRIM(L.NAME_ORG,LEFT,RIGHT), stringlib.stringfindreplace(ClnDBA,'"',''),'');
	SELF.DBA_FLAG       := IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',1,0); // 1: true  0: FALSE
	SELF.NAME_DBA_SUFX	:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',Prof_License_Mari.mod_clean_name_addr.TrimUpper(REGEXREPLACE('[^a-zA-Z0-9_]',DBA_SUFX,'')),''); 
	SELF.NAME_DBA_ORIG	:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',L.NAME_DBA_ORIG,'');
	SELF.NAME_MARI_DBA	:= IF(TRIM(SELF.name_dba,LEFT,RIGHT) != '',TRIM(StdNAME_DBA,LEFT,RIGHT),'');
	SELF.MLTRECKEY 		  := IF(TRIM(SELF.NAME_DBA,LEFT,RIGHT) = '',0,L.MLTRECKEY);
	SELF := L;
END;

ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));


//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
company_only_lookup := ds_map_base(affil_type_cd='CO');

//assign pcmc_slpk for linked records and remove temporary place holder for COMPANY_NMLS_ID used for linking
Prof_License_Mari.layouts.base assign_pcmcslpk(ds_map_base L, company_only_lookup R) := TRANSFORM
	SELF.pcmc_slpk := R.cmc_slpk;
	SELF := L;
END;

ds_map_affil := JOIN(ds_map_base, company_only_lookup,
									LEFT.FOREIGN_NMLS_ID = RIGHT.NMLS_ID
								  AND LEFT.AFFIL_TYPE_CD IN ['IN', 'BR'],
						      assign_pcmcslpk(LEFT,RIGHT),LEFT OUTER,LOOKUP);																		


Prof_License_Mari.layouts.base xTransPROVNOTE(ds_map_affil L) := TRANSFORM
	SELF.provnote_1 := MAP(L.provnote_1 != '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
							TRIM(L.provnote_1,LEFT,RIGHT)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
						   L.provnote_1 = '' AND L.pcmc_slpk = 0 AND L.affil_type_cd = 'BR' => 
							'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);
	SELF := L;
END;

OutRecs := PROJECT(ds_map_affil, xTransPROVNOTE(LEFT));
d_final := OUTPUT(DEDUP(OutRecs,RECORD,ALL,LOCAL), ,'~thor_data400::in::proflic_mari::'+process_dte+'::'+src_cd,__COMPRESSED__,OVERWRITE);

add_super := SEQUENTIAL(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile('~thor_data400::in::proflic_mari::individual_detail','~thor_data400::out::proflic_mari::nmls::'+process_dte+'::individual_detail'),
													fileservices.addsuperfile('~thor_data400::in::proflic_mari::regulatory_actions','~thor_data400::out::proflic_mari::nmls::'+process_dte+'::regulatory_actions'),
													fileservices.addsuperfile('~thor_data400::in::proflic_mari::disciplinary_actions','~thor_data400::out::proflic_mari::nmls::'+process_dte+'::disciplinary_actions'),
													fileservices.addsuperfile('~thor_data400::in::proflic_mari::'+src_cd,'~thor_data400::in::proflic_mari::'+process_dte+'::'+src_cd),
													fileservices.finishsuperfiletransaction()
													);


RETURN SEQUENTIAL(
                  PARALLEL(regulatory_file,disciplinary_file,individual_detail_file)
									,d_final
									,add_super
									);

END;