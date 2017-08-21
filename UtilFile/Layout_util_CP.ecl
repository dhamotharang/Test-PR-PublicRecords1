export Layout_util_CP := module


export SVCADDR := record


     STRING32       CPS_SIG_SADDR;     //Informatica Datatype is STRING 32

     STRING32       CPS_SIG_ENT;     //Informatica Datatype is STRING 32

     STRING29       CPS_LOAD_DTTM;     //Informatica Datatype is DATETIME 29

     INTEGER2       CPS_VENDOR_CD;     //Informatica Datatype is NUMBER 4

     STRING250      SVC_DTE;     //Informatica Datatype is STRING 250

     STRING250      SVC_TYPE_CD;     //Informatica Datatype is STRING 250

     STRING250      ADDR_HOUSE_NUM;     //Informatica Datatype is STRING 250

     STRING250      ADDR_STREET_NAME;     //Informatica Datatype is STRING 250

     STRING250      ADDR_SUFFIX;     //Informatica Datatype is STRING 250

     STRING250      ADDR_PRE_DIR;     //Informatica Datatype is STRING 250

     STRING250      ADDR_APT_NUM;     //Informatica Datatype is STRING 250

     STRING250      ADDR_CITY;     //Informatica Datatype is STRING 250

     STRING250      ADDR_STATE_ABBR;     //Informatica Datatype is STRING 250

     STRING250      ADDR_POSTAL_CODE;     //Informatica Datatype is STRING 250

     STRING250      PHONE;     //Informatica Datatype is STRING 250

     STRING250      CLN_SVC_DTE;     //Informatica Datatype is STRING 250

     STRING250      CPS_STATE_ABBR;     //Informatica Datatype is STRING 250

     STRING250      CPS_ADDR_TYPE_CD;     //Informatica Datatype is STRING 250

     STRING250      CLN_AREA_CODE;     //Informatica Datatype is STRING 250

     STRING250      CLN_PHONE;     //Informatica Datatype is STRING 250

     STRING250      CPS_PHONE_TYPE_CD;     //Informatica Datatype is STRING 250

end;

export Name := RECORD

     STRING32       CPS_SIG_RAW;     //Informatica Datatype is STRING 32

     STRING5        CPS_DATA_ORIGIN;     //Informatica Datatype is STRING 5

     INTEGER6       CPS_VENDOR_CD;     //Informatica Datatype is NUMBER 15

     STRING2        CPS_TAB_CD;     //Informatica Datatype is STRING 2

     STRING2        CPS_COL_GRP_CD;     //Informatica Datatype is STRING 2

     STRING32       CPS_SIG_REL;     //Informatica Datatype is STRING 32

     STRING250      CPS_OPT;     //Informatica Datatype is STRING 250

     STRING1        CLN_NAME_REV;     //Informatica Datatype is STRING 1

     STRING250      CLN_NAME_FIRST;     //Informatica Datatype is STRING 250

     STRING250      CLN_NAME_MID;     //Informatica Datatype is STRING 250

     STRING250      CLN_NAME_LAST;     //Informatica Datatype is STRING 250

     STRING250      CLN_CERT;     //Informatica Datatype is STRING 250

     STRING250      CLN_NAME_TTL;     //Informatica Datatype is STRING 250

     STRING250      CLN_NAME_PREFIX;     //Informatica Datatype is STRING 250

     STRING250      CLN_NAME_SUFFIX;     //Informatica Datatype is STRING 250

     STRING250      CLN_GENDER;     //Informatica Datatype is STRING 250

     STRING250      CLN_NAME_STANDARD1;     //Informatica Datatype is STRING 250

     STRING250      CLN_NAME_STANDARD2;     //Informatica Datatype is STRING 250

     STRING250      CLN_FIRM_LOC;     //Informatica Datatype is STRING 250

     STRING250      CPS_NAME_TYPE_CD;     //Informatica Datatype is STRING 250
	
end;

export Entity :=

 RECORD

     STRING32       CPS_SIG_ENT;     //Informatica Datatype is STRING 32

     STRING29       CPS_LOAD_DTTM;     //Informatica Datatype is DATETIME 29

     INTEGER2       CPS_VENDOR_CD;     //Informatica Datatype is NUMBER 4

     INTEGER2       CPS_CLOAK;     //Informatica Datatype is NUMBER 4

     STRING250      VEND_REF_NUM;     //Informatica Datatype is STRING 250

     STRING250      VEND_ADD_DTE;     //Informatica Datatype is STRING 250

     STRING250      NAME_LAST;     //Informatica Datatype is STRING 250

     STRING250      NAME_FIRST;     //Informatica Datatype is STRING 250

     STRING250      NAME_MID;     //Informatica Datatype is STRING 250

     STRING250      NAME_SUFFIX;     //Informatica Datatype is STRING 250

     STRING250      SSN;     //Informatica Datatype is STRING 250

     STRING250      DL_STATE_ABBR;     //Informatica Datatype is STRING 250

     STRING250      DL_NUM;     //Informatica Datatype is STRING 250

     STRING250      CLN_VEND_ADD_DTE;     //Informatica Datatype is STRING 250

     STRING250      CLN_SSN;     //Informatica Datatype is STRING 250

     STRING250      CLN_DL_NUM;     //Informatica Datatype is STRING 250

     STRING250      CPS_DL_STATE_ABBR;     //Informatica Datatype is STRING 250

end;
end;