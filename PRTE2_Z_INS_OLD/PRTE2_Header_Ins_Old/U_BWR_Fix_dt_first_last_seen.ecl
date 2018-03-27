IMPORT PRTE2_X_DataCleanse, PRTE2_Header_Ins, prte_csv;
#workunit('name', 'Boca CT Header Alter');

/* **************************************************************************
****************Research of dt_first/last_seen in MHDR and BHDR**************
*************************************************************************** */
Merged_Headers_SF_DS := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_SF_DS; //49153

// After update the BHDR up to date, it could be referenced from the QA generation.
// Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
Alpha_Base_DS := DATASET('~prct::base::ct::alpharetta::peopleheader_base_fixed_DOB::20150910', prte_csv.ge_header_base.layout_payload,THOR);

BHDR := SET(Alpha_Base_DS(dt_last_seen =201504), DID); //unsigned3
MHDR := SET(Merged_Headers_SF_DS(fb_last_dt = '20150427'), DID); //STRING8

// COUNT(Alpha_Base_DS(dt_last_seen =201504));  //4048
// COUNT(Merged_Headers_SF_DS(fb_last_dt = '20150427')); //4048

OUTREC := RECORD
  UNSIGNED  BHDR_DID;
  unsigned3 dt_last_seen;
	STRING8   fb_last_dt;
  UNSIGNED  MHDR_DID;
END;

OUTREC xGETCOMMON(Alpha_Base_DS L, Merged_Headers_SF_DS R):= TRANSFORM
  SELF.BHDR_DID := L.DID;
  SELF.dt_last_seen := L.dt_last_seen;
  SELF.fb_last_dt := R.fb_last_dt;
  SELF.MHDR_DID := R.DID;
END;

CommonCheck := JOIN(Alpha_Base_DS(DID in BHDR), Merged_Headers_SF_DS(DID in MHDR),
                    LEFT.DID = RIGHT.DID
							      ,xGETCOMMON(LEFT, RIGHT),
										FULL OUTER);

// CommonCheck_DS := CHOOSEN(CommonCheck, ALL);
// CommonCheck_DS; //4048

/* **************************************************************************
****************Fix dt_first/last_seen in MHDR and BHDR**********************
***************************************************************************** */
BHDR_FIX_OUTREC := RECORD
  STRING8 REPLACED_dt_first_seen;
  STRING8 REPLACED_dt_last_seen;
	PRTE2_X_Ins_DataCleanse.Layouts.Layout_Merged_IHDR_BHDR;
END;

BHDR_FIX_OUTREC xFixDOBINMHDR(Merged_Headers_SF_DS L):=TRANSFORM
  SELF.REPLACED_dt_first_seen := L.fb_first_dt;
  SELF.REPLACED_dt_last_seen  := L.fb_last_dt;
  SELF := L;
END;

MHDR_BHDR_DOB_FIX_RS := PROJECT(Merged_Headers_SF_DS, xFixDOBINMHDR(LEFT));

BHDR_FIX_OUTREC1 := RECORD
  STRING8 REPLACED_dt_first_seen;
  STRING8 REPLACED_dt_last_seen;
	prte_csv.ge_header_base.layout_payload;
END;

BHDR_FIX_OUTREC1 xFixDTinBHDR(Alpha_Base_DS L,MHDR_BHDR_DOB_FIX_RS R):= TRANSFORM
  SELF.dt_first_seen          := IF((unsigned3)R.fb_first_dt[1..6] = 0, L.dt_first_seen, IF(L.dt_first_seen = (unsigned3)R.fb_first_dt[1..6], L.dt_first_seen, (unsigned3)R.fb_first_dt[1..6]));
  SELF.dt_last_seen           := IF(L.dt_last_seen > (unsigned3)R.fb_last_dt[1..6], L.dt_last_seen, (unsigned3)R.fb_last_dt[1..6]);
	SELF.REPLACED_dt_first_seen := R.REPLACED_dt_first_seen;
	SELF.REPLACED_dt_last_seen  := R.REPLACED_dt_last_seen;
	SELF := L;
END;

BHDR_DOB_FIX_RS := JOIN(Alpha_Base_DS, MHDR_BHDR_DOB_FIX_RS(addr_ind <> '2'),
                        LEFT.DID = RIGHT.DID
												,xFixDTinBHDR(LEFT,RIGHT)
												,LEFT OUTER
												);
// COUNT(BHDR_DOB_FIX_RS);	//52560											
// BHDR_DOB_FIX_RS;

BHDR_DOB_FIXED := PROJECT(BHDR_DOB_FIX_RS, prte_csv.ge_header_base.layout_payload);
// BHDR_DOB_FIXED;
OUTPUT(BHDR_DOB_FIXED,, '~prct::base::ct::alpharetta::peopleheader_base_fixed_DOB_DT::20150911');

/* ***************************************************************************
********************** More Research to Check the Result**********************
***************************************************************************** */
/*
COUNT(BHDR_DOB_FIX_RS(REPLACED_dt_first_seen[1..6]=(string)dt_first_seen));  //49152
COUNT(BHDR_DOB_FIX_RS(REPLACED_dt_first_seen[1..6]<>(string)dt_first_seen)); //3408
MHDR_RECORD_CHECK := SET(BHDR_DOB_FIX_RS(REPLACED_dt_first_seen[1..6]=(string)dt_first_seen), DID);
MHDR_RECORD_CHECK_1 := SET(Merged_Headers_SF_DS, DID);
// ds := choosen(BHDR_DOB_FIX_RS(DID not in MHDR_RECORD_CHECK_1), all); //0
// ds1 := choosen(Alpha_Base_DS(DID not in MHDR_RECORD_CHECK_1), all); //0

BHDR_DOB_FIX_RS(dt_first_seen = 0);
COUNT(BHDR_DOB_FIX_RS(REPLACED_dt_last_seen[1..6]=(string)dt_last_seen));   //4048
COUNT(BHDR_DOB_FIX_RS(REPLACED_dt_last_seen[1..6]<>(string)dt_last_seen)); //49152

BHDR_DOB_FIXED_dt_first_seen_Table := TABLE(BHDR_DOB_FIXED, {dt_first_seen, unsigned cnt := count(group)}, dt_first_seen);
BHDR_DOB_FIXED_dt_first_seen_Table;

BHDR_DOB_FIXED_dt_last_seen_Table := TABLE(BHDR_DOB_FIXED, {dt_last_seen, unsigned cnt := count(group)}, dt_last_seen);
BHDR_DOB_FIXED_dt_last_seen_Table;

BHDR_DOB_FIXED(did = 888809012415);
*/