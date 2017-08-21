export Layout_compid_best := MODULE

export layout_compid_src := record
	string4 REC_LAST_UPDT_YYMM_DATE;
	string9 REC_SOUNDEX_KEY;
	string8 REC_SOURCE_MATRIX_NAME;
	string8 REC_SOURCE_MATRIX_LIC;
	string8 REC_SOURCE_MATRIX_SSN;
	string8 REC_SOURCE_MATRIX_DOB;
	string8 REC_SOURCE_MATRIX_ADDR;
	string8 REC_SOURCE_MATRIX_GENDER;
	string28 DRVR_LAST_NAME;
	string20 DRVR_FIRST_NAME;
	string15 DRVR_MID_NAME;
	string3 DRVR_SUF_NAME;
	string1 DRVR_SEX_CODE;
	string6 DRVR_BIRTH_YMD_DATE;
	string9 DRVR_SOCIAL_SECURITY_NUM;
	string1 DRVR_CURR_ADDR_CODE;
	string5 DRVR_CURR_ZIP_NUM;
	string35 DRVR_CURR_ADDR;
	string20 DRVR_CURR_CITY_NAME;
	string2 DRVR_CURR_STATE_CODE;
	string4 DRVR_CURR_ZIP_EXT_NUM;
	string1 DRVR_DECEASED_FLAG ;
	string4 DRVR_DECEASED_YYMM_DATE;
	string11 DRVR_CURR_APT_NUM;
	string20 DRVR_LIC_NUM;
	string6 DRVR_LIC_EXPIRE_YMD_DATE;
	string6 DRVR_LIC_ISSUE_YMD_DATE;
	string10 DRVR_LIC_TYPE_CODE;
	string15 DRVR_LIC_RESTRICT_DESC;
	string1 DRVR_COMMRCL_LIC_IND;
	string2 DRVR_LIC_STATE_CODE;
	string4 DRVR_PRIOR_ADDR_YYMM_DATE1;
	string1 DRVR_PRIOR_ADDR_SOURCE_IND1;
	string1 DRVR_PRIOR_ADDR_CODE1;
	string5 DRVR_PRIOR_ZIP_NUM1;
	string35 DRVR_PRIOR_ADDR1;
	string20 DRVR_PRIOR_CITY_NAME1;
	string2 DRVR_PRIOR_STATE_CODE1;
	string4 DRVR_PRIOR_ZIP_EXT_NUM1;
	string11 DRVR_PRIOR_APT_NUM1;
	string1 DRVR_PRIOR_NCOA_FLAG1;
	string4 DRVR_PRIOR_NCOA_YYMM_DATE1;
	string4 DRVR_PRIOR_ADDR_YYMM_DATE2;
	string1 DRVR_PRIOR_ADDR_SOURCE_IND2;
	string1 DRVR_PRIOR_ADDR_CODE2;
	string5 DRVR_PRIOR_ZIP_NUM2;
	string35 DRVR_PRIOR_ADDR2;
	string20 DRVR_PRIOR_CITY_NAME2;
	string2 DRVR_PRIOR_STATE_CODE2;
	string4 DRVR_PRIOR_ZIP_EXT_NUM2;
	string11 DRVR_PRIOR_APT_NUM2;
	string1 DRVR_PRIOR_NCOA_FLAG2;
	string4 DRVR_PRIOR_NCOA_YYMM_DATE2;
	string4 DRVR_PRIOR_ADDR_YYMM_DATE3;
	string1 DRVR_PRIOR_ADDR_SOURCE_IND3;
	string1 DRVR_PRIOR_ADDR_CODE3;
	string5 DRVR_PRIOR_ZIP_NUM3;
	string35 DRVR_PRIOR_ADDR3;
	string20 DRVR_PRIOR_CITY_NAME3;
	string2 DRVR_PRIOR_STATE_CODE3;
	string4 DRVR_PRIOR_ZIP_EXT_NUM3;
	string11 DRVR_PRIOR_APT_NUM3;
	string1 DRVR_PRIOR_NCOA_FLAG3;
	string4 DRVR_PRIOR_NCOA_YYMM_DATE3;
	string6 DRVR_LOAD_DATE;
	string1 DRVR_LOAD_SOURCE;
	string1 DRVR_LIC_PERMIT_FLAG;
	string20 DRVR_SUPPL_LIC_DATA;
	string8 DRVR_SRCE_CNFRM_DTE_NAME1;
	string8 DRVR_SRCE_CNFRM_DTE_SSN1;
	string8 DRVR_SRCE_CNFRM_DTE_ADDR1;
	string8 DRVR_SRCE_CNFRM_DTE_LIC1;
	string8 DRVR_SRCE_CNFRM_DTE_DOB1;
	string8 DRVR_SRCE_CNFRM_DTE_SEX1;
	string8 DRVR_SRCE_CNFRM_DTE_NAME2;
	string8 DRVR_SRCE_CNFRM_DTE_SSN2;
	string8 DRVR_SRCE_CNFRM_DTE_ADDR2;
	string8 DRVR_SRCE_CNFRM_DTE_LIC2;
	string8 DRVR_SRCE_CNFRM_DTE_DOB2;
	string8 DRVR_SRCE_CNFRM_DTE_SEX2;
	string8 DRVR_SRCE_CNFRM_DTE_NAME3;
	string8 DRVR_SRCE_CNFRM_DTE_SSN3;
	string8 DRVR_SRCE_CNFRM_DTE_ADDR3;
	string8 DRVR_SRCE_CNFRM_DTE_LIC3;
	string8 DRVR_SRCE_CNFRM_DTE_DOB3;
	string8 DRVR_SRCE_CNFRM_DTE_SEX3;
	string8 DRVR_SRCE_CNFRM_DTE_NAME4;
	string8 DRVR_SRCE_CNFRM_DTE_SSN4;
	string8 DRVR_SRCE_CNFRM_DTE_ADDR4;
	string8 DRVR_SRCE_CNFRM_DTE_LIC4;
	string8 DRVR_SRCE_CNFRM_DTE_DOB4;
	string8 DRVR_SRCE_CNFRM_DTE_SEX4;
	string8 DRVR_SRCE_CNFRM_DTE_NAME5;
	string8 DRVR_SRCE_CNFRM_DTE_SSN5;
	string8 DRVR_SRCE_CNFRM_DTE_ADDR5;
	string8 DRVR_SRCE_CNFRM_DTE_LIC5;
	string8 DRVR_SRCE_CNFRM_DTE_DOB5;
	string8 DRVR_SRCE_CNFRM_DTE_SEX5;
	string8 DRVR_SRCE_CNFRM_DTE_NAME6;
	string8 DRVR_SRCE_CNFRM_DTE_SSN6;
	string8 DRVR_SRCE_CNFRM_DTE_ADDR6;
	string8 DRVR_SRCE_CNFRM_DTE_LIC6;
	string8 DRVR_SRCE_CNFRM_DTE_DOB6;
	string8 DRVR_SRCE_CNFRM_DTE_SEX6;
	string8 DRVR_SRCE_CNFRM_DTE_NAME7;
	string8 DRVR_SRCE_CNFRM_DTE_SSN7;
	string8 DRVR_SRCE_CNFRM_DTE_ADDR7;
	string8 DRVR_SRCE_CNFRM_DTE_LIC7;
	string8 DRVR_SRCE_CNFRM_DTE_DOB7;
	string8 DRVR_SRCE_CNFRM_DTE_SEX7;
	string8 DRVR_SRCE_CNFRM_DTE_NAME8;
	string8 DRVR_SRCE_CNFRM_DTE_SSN8;
	string8 DRVR_SRCE_CNFRM_DTE_ADDR8;
	string8 DRVR_SRCE_CNFRM_DTE_LIC8;
	string8 DRVR_SRCE_CNFRM_DTE_DOB8;
	string8 DRVR_SRCE_CNFRM_DTE_SEX8;
end;



export layout_best := RECORD
	string28 lname;  
	string20 fname;
	string15 mname;   
	string3 suffix;   
	string6 dob;   
	string9 ssn; 
	string1 gender;
	string5 zip;  
	string40 address1;
	string11 address2;
	string20 city_name;
	string2 st;
	string4 zip4; 
	string1 dod_ind;
	string4 dod;   
	string20 dl_number;
end;

export compid_best := RECORD
    unsigned6 did;
	string1 neq_best_addr;
	string1 eq_best_addr;
	string1 rec_tp;
	layout_compid_src;
	layout_best;
 /* Fields to append from Best after original comp_id file     
	01 IN500-STATE-RECORD.                                              
           05  IN500-DRIVER-DATA.                                               
               10  IN500-NAME.                                                  
                   15  IN500-LAST             PIC  X(28).                       
                   15  IN500-FIRST            PIC  X(20).                       
                   15  IN500-MID              PIC  X(15).                       
                   15  IN500-SUF              PIC  X(03).                       
               10  IN500-DOB-YMD              PIC  X(06).                       
               10  IN500-SSN                  PIC  X(09).                       
               10  IN500-GENDER               PIC  X(01).                       
           05  IN500-ADDRESS-DATA.                                              
               10  IN500-ZIP5                 PIC  X(05).                       
               10  IN500-ADDRESS              PIC  X(40).                       
               10  IN500-APT                  PIC  X(11).                       
               10  IN500-CITY                 PIC  X(20).                       
               10  IN500-ST-CODE              PIC  X(02).                       
               10  IN500-ZIP4                 PIC  X(04).                       
           05  IN500-DOD-DATA.                                              
               10 IN500-DOD-IND	          PIC  X(01).                       
               10 IN500-DOD-DATE-YYMM         PIC  X(04).                       
           05  IN500-LICENSE-DATA.                                              
               10  IN500-LICENSE              PIC  X(20).                       
               10  IN500-LIC-TYPE             PIC  X(10).                       
               10  IN500-LIC-CDL-INDICA       PIC  X(01).                       
               10  IN500-LIC-REST             PIC  X(15).                       
               10  IN500-LIC-ST-CODE          PIC  X(02).                       
               10  IN500-LIC-EXP-YMD          PIC  X(06).                       
               10  IN500-LIC-ISS-YMD          PIC  X(06).	*/
end;

export compid_best_with_dl := RECORD
	compid_best;
	string10  license_type := '';
	string4  license_class := ''; //for testing only
	string4  moxie_license_type := ''; //for testing only
	string4  CDL_Status := ''; //for testing only
	string1   cdl_indicator := '';
	string15  restrictions := '';
	string2   orig_state := '';
	string6   lic_issue_date := '';
	string6   expiration_date := '';
end;

export compid_best_final := RECORD
	layout_compid_src;
	layout_best;
	//string10  license_type := '';
	string4  license_class := ''; //for testing only
	//string4  moxie_license_type := ''; //for testing only
	string1   cdl_indicator := '';
	string15  restrictions := '';
	string2   orig_state := '';
	string6   lic_issue_date := '';
	string6   expiration_date := '';
end;

end;