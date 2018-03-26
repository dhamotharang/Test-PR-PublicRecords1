IMPORT PRTE2_X_DataCleanse, PRTE2_Header_Ins, prte_csv;
#workunit('name', 'Boca CT Header Alter DOBs');

/* **********************************************************
****************Research of DOB in MHDR and BHDR**************
************************************************************* */
Merged_Headers_SF_DS := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_SF_DS; //49153
// COUNT(Merged_Headers_SF_DS((INTEGER)FB_DOB=DOB));  //4110
// COUNT(Merged_Headers_SF_DS((INTEGER)FB_DOB=DOB AND DOB<>0)); //3984

Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS; //52560
// COUNT(Alpha_Base_DS(DOB<>0)); //3984

MHDR := SET(Merged_Headers_SF_DS((INTEGER)FB_DOB=DOB AND DOB<>0), DID);
BHDR := SET(Alpha_Base_DS(DOB<>0), DID);

OUTREC := RECORD
  UNSIGNED MHDR_DID;
	INTEGER  MHDR_FB_DOB;
	INTEGER  MHDR_DOB;
	UNSIGNED BHDR_DID;
	INTEGER  BHDR_DOB;
END;

OUTREC xGetResult(Merged_Headers_SF_DS L, Alpha_Base_DS R) := TRANSFORM
  SELF.MHDR_DID := L.DID ;
  SELF.MHDR_FB_DOB := (INTEGER)L.FB_DOB ;
  SELF.MHDR_DOB := (INTEGER)L.DOB ;
  SELF.BHDR_DID := R.DID ;
  SELF.BHDR_DOB := R.DOB ;
	
END;
CommonCheck := JOIN(Merged_Headers_SF_DS(DID IN MHDR), Alpha_Base_DS(DID IN BHDR),
                    LEFT.DID = RIGHT.DID
										, xGetResult(LEFT, RIGHT)
										, FULL OUTER);
CommonCheck_DS := CHOOSEN(CommonCheck, ALL);
// CommonCheck_DS;
// COUNT(Merged_Headers_SF_DS(DID IN BHDR)); //3984
// COUNT(Alpha_Base_DS(DID IN MHDR)); //3984


MHDR_DOB_Check := Merged_Headers_SF_DS((INTEGER)FB_DOB=DOB);
DS := CHOOSEN(MHDR_DOB_Check(DOB =0), ALL);
DS;

// COUNT(Merged_Headers_SF_DS(FB_DOB <>'00000000' and FB_DOB <>' ' ));

// COUNT(Merged_Headers_SF_DS(DID not in MHDR AND FB_DOB <>'00000000' and FB_DOB <>' '));


/* ***********************************************************
****************Fix DOB in MHDR and BHDR**********************
************************************************************* */
BHDR_FIX_OUTREC := RECORD
  INTEGER REPLACED_DOB_FROM_MHDR;
  INTEGER REPLACED_YOB_FROM_MHDR;
	PRTE2_X_Ins_DataCleanse.Layouts.Layout_Merged_IHDR_BHDR;
END;

BHDR_FIX_OUTREC xFixDOBINMHDR(Merged_Headers_SF_DS L):=TRANSFORM
  SELF.REPLACED_DOB_FROM_MHDR := (INTEGER)L.FB_DOB;
  SELF.REPLACED_YOB_FROM_MHDR := (INTEGER)L.FB_DOB[1..4];
  SELF := L;
END;

MHDR_BHDR_DOB_FIX_RS := PROJECT(Merged_Headers_SF_DS, xFixDOBINMHDR(LEFT));

BHDR_FIX_OUTREC1 := RECORD
  INTEGER REPLACED_DOB_FROM_MHDR;
  INTEGER REPLACED_YOB_FROM_MHDR;
	prte_csv.ge_header_base.layout_payload;
END;

BHDR_FIX_OUTREC1 xFixDobINBHDR(Alpha_Base_DS L,MHDR_BHDR_DOB_FIX_RS R):= TRANSFORM
  DOB := IF(L.DOB=(INTEGER)R.FB_DOB, L.DOB, (INTEGER)R.FB_DOB);
  SELF.DOB := DOB;
  SELF.YOB := (INTEGER)DOB[1..4];
	SELF.REPLACED_DOB_FROM_MHDR := R.REPLACED_DOB_FROM_MHDR;
	SELF.REPLACED_YOB_FROM_MHDR := R.REPLACED_YOB_FROM_MHDR;
	SELF := L;
END;

BHDR_DOB_FIX_RS := JOIN(Alpha_Base_DS, MHDR_BHDR_DOB_FIX_RS(addr_ind <> '2'),
                        LEFT.DID = RIGHT.DID
												// AND LEFT.ST = RIGHT.ST
												,xFixDobINBHDR(LEFT,RIGHT)
												,LEFT OUTER
												);
												

COUNT(BHDR_DOB_FIX_RS(REPLACED_DOB_FROM_MHDR=DOB)); //52560
COUNT(BHDR_DOB_FIX_RS(REPLACED_YOB_FROM_MHDR=YOB)); //52560
COUNT(BHDR_DOB_FIX_RS(REPLACED_DOB_FROM_MHDR<>DOB)); //0
COUNT(BHDR_DOB_FIX_RS(REPLACED_YOB_FROM_MHDR<>YOB)); //0

BHDR_DOB_FIXED := PROJECT(BHDR_DOB_FIX_RS, prte_csv.ge_header_base.layout_payload);
COUNT(BHDR_DOB_FIXED(DOB[1..4] = (string)yob)); //52560

OUTPUT(BHDR_DOB_FIXED,, '~prct::base::ct::alpharetta::peopleheader_base_fixed_DOB::20150910');