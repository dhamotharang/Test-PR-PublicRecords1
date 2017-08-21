// EXPORT BWR_NMLS := 'todo';

import ut, Address, Standard, Prof_License_Mari, lib_stringlib ,Lib_FileServices;

// export BWR_NMLS := function		

#workunit('name','BWR_NMLS');		

src_cd	:= 'S0900'; //Vendor code
src_st	:= 'US';	//License state


//License Status
active_status_set := ['ACTIVE','APPROVED','APPROVED-INACTIVE','APPROVED-SURRENDER/CANCELLATION REQUESTED','TEMPORARY CEASE AND DESIST',
											'REVOKED-ON APPEAL','SUSPENDED','SUSPENDED-ON APPEAL'];
							 


inactive_status_set := ['INACTIVE','DENIED','REVOKED','EXPIRED','SURRENDERED','ORDERED TO SURRENDER','VOLUNTARY SURRENDER'];
                                          


//Import raw data files and dedup according to NMLS business rules. All files have been prepared to facilitate
//future updates to business rules.

// Branch ***********************************************************
temp_branch := Prof_License_Mari.files_NMLS0900.branch(branch_nmls_id != 0);
branch := temp_branch;

// Branch DBA *******************************************************
temp_dba_branch := Prof_License_Mari.files_NMLS0900.branch_dba;
dba_branch := temp_dba_branch;

// Branch License ***************************************************
temp_branch_lic := Prof_License_Mari.files_NMLS0900.branch_lic;


//dedup : compare to all records to eliminate duplicates with inactive statuses according to business rules
temp_branlic_dedup_1 := dedup(temp_branch_lic,left.BRANCH_NMLS_ID = right.BRANCH_NMLS_ID and
                                                 left.REGULATOR = right.REGULATOR and
																					       left.LICENSE_NBR = right.LICENSE_NBR and
																						     left.LICENSE_TYPE = right.LICENSE_TYPE and
																						     StringLib.StringToUppercase(left.STATUS) IN active_status_set and
																						     StringLib.StringToUppercase(right.STATUS) IN inactive_status_set,
														 //record,ALL,
													   left);

//sort : sort records by business rule fields and status date (effective_date)														 
temp_branlic_sorted_1 := sort(temp_branlic_dedup_1,BRANCH_NMLS_ID,REGULATOR,LICENSE_NBR,LICENSE_TYPE,EFFECTIVE_DATE);

//dedup : dedup records to eliminate duplicates with earlier status dates (effective dates)														 
temp_branlic_dedup_2 := dedup(temp_branlic_sorted_1,left.BRANCH_NMLS_ID = right.BRANCH_NMLS_ID and
                                            left.REGULATOR = right.REGULATOR and
																						left.LICENSE_NBR = right.LICENSE_NBR and
																						left.LICENSE_TYPE = right.LICENSE_TYPE,
													   right);
														 
branch_lic := temp_branlic_dedup_2;

output(branch_lic);