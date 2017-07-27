export DL_Source := MODULE

// data dump from Scank file

/*
Code	 Code Description
A		 NCOA 
C		 CLUE 
D		 DMV DRIVER - keep
E		 ECMD
M		 MVR HISTORY 
N		 NCF
S		 SNDX EQUIFAX
T		 TRANS UNION  - keep
X		 EXPERIAN  - keep
*/


export rCompDLIn
 :=
  record
	string1							Junk_0;
	string3		HISTORY_FLAG;
	string1							Junk_1;
	string3		CLOAK1;
	string1							Junk_2;
	string3		CLOAK2;
	string1							Junk_3;
	string3		CLOAK3;
	string1							Junk_4;
	string3		CLOAK4;
	string1							Junk_5;
	string8		IMPORT_DATE;
	string1							Junk_6;
	string34	NAME_FULL;
	string1							Junk_7;
	string46	ADR_ADDR;
	string1							Junk_8;
	string15	ADR_CITY;
	string1							Junk_9;
	string2		ADR_STATE;
	string1							Junk_10;
	string5		ADR_ZIP;
	string1							Junk_11;
	string4		ADR_ZIP4;
	string1							Junk_12;
	string3		HEIGHT;
	string1							Junk_13;
	string3		WEIGHT;
	string1							Junk_14;
	string1		HAIR_COLOR;
	string1							Junk_15;
	string1		EYE;
	string1							Junk_16;
	string19	DL_NUMB;
	string1							Junk_17;
	string20	LIC_CLASS;
	string1							Junk_18;
	string52	RESTRICTIONS;
	string1							Junk_19;
	string8		DATE_ISSUE;
	string1							Junk_20;
	string8		DATE_EXPIRE;
	string1							Junk_21;
	string8		DATE_DOB;
	string1							Junk_22;
	string1		GENDER;
	string1							Junk_23;
	string12	DATE_CL_ISS;
	string1							Junk_24;
	string12	DATE_CL_EXP;
	string1							Junk_25;
	string12	DATE_CL_DOB;
	string1							Junk_26;
	string2		DLSTATE;
	string1							Junk_27;
	string9		SSN;
	string1							Junk_28;
	string12	DATE_CL_ORIG;
	string1							Junk_29;
	string12	DATE_CL_CONV;
	string1							Junk_30;
	string1		RACE;
	string1							Junk_31;
	string2		PREV_STATE;
	string1							Junk_32;
	string25	PREV_DL_NUMB;
	string1							Junk_33;
	string1		OPT_OUT_CODE;
	string1							Junk_34;
	string1		NCOA_CODE;
	string1							Junk_35;
	string1		NCOA_MATCHES;
	string1							Junk_36;
	string15	LICENSE_TYPE;
	string1							Junk_37;
	string35	ADR_ORG_ADDR;
	string1							Junk_38;
	string15	ADR_ORG_CITY;
	string1							Junk_39;
	string2		ADR_ORG_STAT;
	string1							Junk_40;
	string5		ADR_ORG_ZIP;
	string1							Junk_41;
	string4		ADR_ORG_ZIP4;
	string1							Junk_42;
	string10	KF_HOUSE_NBR;
	string1							Junk_43;
	string2		KF_PRE_DIR;
	string1							Junk_44;
	string22	KF_STREET_NM;
	string1							Junk_45;
	string4		KF_STREET_SU;
	string1							Junk_46;
	string2		KF_POST_DIR;
	string1							Junk_47;
	string6		KF_APT_NBR;
	string1							Junk_48;
	string6		DATE_ADDRESS;
	string1							Junk_49;
	string1		COMMERCIAL;
	string1							Junk_50;
	string10	RECORD_SEQ;
	string1							Junk_51;
	string8		MATRIX_NAME;
	string1							Junk_52;
	string8		MATRIX_LIC;
	string1							Junk_53;
	string8		MATRIX_SSN;
	string1							Junk_54;
	string8		MATRIX_DOB;
	string1							Junk_55;
	string8		MATRIX_ADDR;
	string1							Junk_56;
	string8		MATRIX_SEX;
	string1							Junk_57;
	string1		SOURCE_ID;
	string1							Junk_58;
	string20	FULL_DL;
	string1							Junk_59;
	string5		KF_APT_NO_OV;
	string1							Junk_60;
	string8		FILLER;
	string2		EOR;
  end
 ;
export dHistoryData :=	
		dataset('~thor200_144::in::compdl::scank',rCompDLIn,thor);

export rScankDLMatrix		// dump from 2010-01-11
 :=
  record
	string1		HISTORY_FLAG;
	string1		CLOAK1;
	string1		CLOAK2;
	string1		CLOAK3;
	string1		CLOAK4;
	string8		IMPORT_DATE;
	string34	NAME_FULL;
	string46	ADR_ADDR;
	string15	ADR_CITY;
	string2		ADR_STATE;
	string5		ADR_ZIP;
	string4		ADR_ZIP4;
	string3		HEIGHT;
	string3		WEIGHT;
	string1		HAIR_COLOR;
	string1		EYE;
	string19	DL_NUMB;
	string20	LIC_CLASS;
	string52	RESTRICTIONS;
	string8		DATE_ISSUE;
	string8		DATE_EXPIRE;
	string8		DATE_DOB;
	string1		GENDER;
	string12	DATE_CL_ISS;
	string12	DATE_CL_EXP;
	string12	DATE_CL_DOB;
	string2		DLSTATE;
	string9		SSN;
	string12	DATE_CL_ORIG;
	string12	DATE_CL_CONV;
	string1		RACE;
	string2		PREV_STATE;
	string25	PREV_DL_NUMB;
	string1		OPT_OUT_CODE;
	string1		NCOA_CODE;
	string1		NCOA_MATCHES;
	string15	LICENSE_TYPE;
	string35	ADR_ORG_ADDR;
	string15	ADR_ORG_CITY;
	string2		ADR_ORG_STAT;
	string5		ADR_ORG_ZIP;
	string4		ADR_ORG_ZIP4;
	string10	KF_HOUSE_NBR;
	string2		KF_PRE_DIR;
	string22	KF_STREET_NM;
	string4		KF_STREET_SU;
	string2		KF_POST_DIR;
	string6		KF_APT_NBR;
	string6		DATE_ADDRESS;
	string1		COMMERCIAL;
	string10	RECORD_SEQ;
	string8		MATRIX_NAME;
	string8		MATRIX_LIC;
	string8		MATRIX_SSN;
	string8		MATRIX_DOB;
	string8		MATRIX_ADDR;
	string8		MATRIX_SEX;
	string1		SOURCE_ID;
	string20	FULL_DL;
	string5		KF_APT_NO_OV;
	string9		FILLER;
	string2		EOR;
  end;
 
 export dHistoryDataMatrix :=	
		dataset('~thor400_92::in::scankdl::matrix',rScankDLMatrix,thor);
 
export rScankDL_FL_TX		// dump from 2010-01-11
 :=
  record
	string1		HISTORY_FLAG;
	string1		CLOAK1;
	string1		CLOAK2;
	string1		CLOAK3;
	string1		CLOAK4;
	string8		IMPORT_DATE;
	string34	NAME_FULL;
	string46	ADR_ADDR;
	string15	ADR_CITY;
	string2		ADR_STATE;
	string5		ADR_ZIP;
	string4		ADR_ZIP4;
	string3		HEIGHT;
	string3		WEIGHT;
	string1		HAIR_COLOR;
	string1		EYE;
	string19	DL_NUMB;
	string20	LIC_CLASS;
	string52	RESTRICTIONS;
	string8		DATE_ISSUE;
	string8		DATE_EXPIRE;
	string8		DATE_DOB;
	string1		GENDER;
	string12	DATE_CL_ISS;
	string12	DATE_CL_EXP;
	string12	DATE_CL_DOB;
	string2		DLSTATE;
	string9		SSN;
	string12	DATE_CL_ORIG;
	string12	DATE_CL_CONV;
	string1		RACE;
	string2		PREV_STATE;
	string25	PREV_DL_NUMB;
	string1		OPT_OUT_CODE;
	string1		NCOA_CODE;
	string1		NCOA_MATCHES;
	string15	LICENSE_TYPE;
	string35	ADR_ORG_ADDR;
	string15	ADR_ORG_CITY;
	string2		ADR_ORG_STAT;
	string5		ADR_ORG_ZIP;
	string4		ADR_ORG_ZIP4;
	string10	KF_HOUSE_NBR;
	string2		KF_PRE_DIR;
	string22	KF_STREET_NM;
	string4		KF_STREET_SU;
	string2		KF_POST_DIR;
	string6		KF_APT_NBR;
	string100	FILLER;
	string2		EOR;
  end;
  
export dHistoryDataFlTx :=	
		dataset('~thor400_92::in::scankdl::fltx',rScankDL_FL_TX,thor);
   

END;