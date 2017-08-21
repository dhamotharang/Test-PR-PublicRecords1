a := pgarg_vehreg_analysis.File_OHMV;
a_d := distribute(a,hash(VIN,REG_EXP_DT));
a_s := sort(a_d,VIN,REG_EXP_DT,local);

b := VehLic.File_OH_Update;
b_d := distribute(b,hash(VR_VIN,VR_EXP_DATE));
b_s := sort(b_d,VR_VIN,VR_EXP_DATE,local);

Layout_join := record
//string1                     FILE_TYP;(meaning only in experian data)
string22                    VIN;
string20 					VR_VIN;
//string5                     VEHICLE_TYP;(unable to find matching record)


string4                     MODEL_YR;
string4 					VR_YY;

//string1                     MODEL_YR_IND;(not present in state)

string25                    MAKE;
string4                     VR_MAKE;

//string1                     MAKE_IND;(not present in state)
string25                    SERIES;
//string1                     SERIES_IND;
string4                     PRIME_COLOR;
string4                     SECOND_COLOR;


string15                    BODY_STYLE;
string2                     VR_TYPE;


//string1                     BODY_STYLE_IND;
string30                    MODEL;
//string1                     MODEL_IND;



string10                    WEIGHT;
string5                     LENGTH;
string3                     AXLE_CNT;
string11                    PLATE_NBR;
string2                     PLATE_STATE;
string11                    PREV_PLATE_NBR;
string2                     PREV_PLATE_STATE;
string3                     PLATE_TYP_CD;
string2                     MSTR_SRC_STATE;
string10                    REG_DECAL_NBR;

string8                     ORG_REG_DT;
string8                     REG_RENEW_DT;
string8                     REG_EXP_DT;

  string8 VR_PUR_DATE;
  string8 VR_ISS_DATE;
  string8 VR_EXP_DATE;
  string8 VR_REG_DATE;


string17                    TITLE_NBR;
string8                     ORG_TITLE_DT;
string8                     TITLE_TRANS_DT;
string1                     NAME_TYP_CD;
string1                     OWNER_TYP_CD;
string20                    FIRST_NM;
string20                    MIDDLE_NM;
string35                    LAST_NM;
string3                     NAME_SUFFIX;
string3                     PROF_SUFFIX;



string9                     IND_SSN;
string9                     VR_SSN;

string8                     IND_DOB;
string8                     MAIL_RANGE;
string2                     M_PRE_DIR;
string20                    M_STREET;
string4                     M_SUFFIX;
string2                     M_POST_DIR;
string9                     M_POB;
string3                     M_RR_NBR;
string7                     M_RR_BOX;
string6                     M_SCNDRY_RNG;
string6                     M_SCNDRY_DES;
string20                    M_CITY;
string2                     M_STATE;
string5                     M_ZIP5;
string4                     M_ZIP4;
string2                     M_CNTRY_CD;
string6                     M_CC_FILLER;
string3                     M_CC;
string20                    M_COUNTY;
string8                     PHYS_RANGE;
string2                     P_PRE_DIR;
string20                    P_STREET;
string4                     P_SUFFIX;
string2                     P_POST_DIR;
string9                     P_POB;
string3                     P_RR_NBR;
string7                     P_RR_BOX;
string6                     P_SCNDRY_RNG;
string6                     P_SCNDRY_DES;
string20                    P_CITY;
string2                     P_STATE;
string5                     P_ZIP5;
string4                     P_ZIP4;
string2                     P_CNTRY_CD;
string6                     P_CC_FILLER;
string3                     P_CC;
string20                    P_COUNTY;

  string30 VR_ADDR;
  string15 VR_CITY1;
  string2 VR_STATE1;
  string9 VR_ZIP9;
  string30 VR_MAILING_ADDRESS;
  string15 VR_CITY2;
  string2 VR_STATE2;
  string5 VR_ZIP;

string1                     OPT_OUT_CD;


string12                    ASG_WGT;
string6                     ASG_WGT_UOM;

  string6 VR_UNL_WEIGHT;
  string6 VR_GVW_WEIGHT;
  string6 VR_TAX_WEIGHT;

//string34                    FILLER;
//string1                     LF;
  //string8 process_date;
  string8 VR_LIC;
  string2 VR_CAT;
  string1 VR_RSV_FLAGS;
  string1 VR_TYPE_ISS;
  string1 VR_CODE;
  string1 VR_OWNER;
  string1 VR_REV_CODE;
  string3 VR_COLL_CODE;
  string4 VR_AGENCY;
  string8 VR_APP_NBR;
  string10 VR_VAL;

  string2 VR_OLDCAT;
  string8 VR_OLDLIC;



  
  string10 VR_TITLE;

  string1 VR_SPEC_TRAN;
  string1 VR_NU_CODE;
  string1 VR_LIMO;

  string35 VR_NAME;

  string2 VR_CO;
  string2 VR_RG;
  string35 VR_NAME2;
  string8 VR_SYS_DATE;
  string1 VR_OPT_FLAG;
  //string9 Filler;

//vehlic.Layout_OH_Update;
end;

Layout_join tjoin(a_s l,b_s r) := Transform
self := l;
self := r;
end;

join_file := join(a_s,b_s,left.VIN=right.VR_VIN and left.REG_EXP_DT=right.VR_EXP_DATE,tjoin(left,right));

output(join_file);

