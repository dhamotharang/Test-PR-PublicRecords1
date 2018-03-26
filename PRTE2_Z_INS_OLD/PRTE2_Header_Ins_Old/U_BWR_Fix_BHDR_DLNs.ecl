IMPORT PRTE2_X_DataCleanse, PRTE2_Header_Ins, prte_csv;
#workunit('name', 'Boca CT Header Alter DLNs');

/* **********************************************************
****************Research of DLN in MHDR and BHDR**************
************************************************************* */

Merged_Headers_SF_DS := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_SF_DS; //49153

COUNT(Merged_Headers_SF_DS(fb_dln= dl_number and dl_number <>'')); //3623
COUNT(Merged_Headers_SF_DS(fb_dln= dl_number)); //4113

// After update the BHDR up to date, it could be referenced from the QA generation.
// Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
// Alpha_Base_DS := DATASET('~prct::base::ct::alpharetta::peopleheader_base_fixed_DOB::20150910', prte_csv.ge_header_base.layout_payload,THOR);;
Alpha_Base_DS := DATASET('~prct::base::ct::alpharetta::peopleheader_base_fixed_DOB_DT::20150911', prte_csv.ge_header_base.layout_payload,THOR);;

COUNT(Alpha_Base_DS(dl_number <>'')); //3630


MHDR := SET(Merged_Headers_SF_DS(fb_dln= dl_number and dl_number <>''), DID);
BHDR := SET(Alpha_Base_DS(dl_number <>''), DID);

//Check the different DLN between fb_dln and dl_numbers
Merged_Headers_SF_DS(did in BHDR AND fb_dln<>dl_number); //7
Merged_Headers_SF_DS(dl_number <> fb_dln AND dl_number<>'' AND fb_dln <> ''); //7
Merged_Headers_SF_DS(fb_dln[16..] <>''); //8

Dismatch_DLD_LIST := SET(Merged_Headers_SF_DS(dl_number <> fb_dln AND dl_number<>'' AND fb_dln <> ''), DID);

/* **********************************************************
****************Fix DLN in MHDR and BHDR**********************
************************************************************* */
BHDR_FIX_OUTREC := RECORD
  STRING30 REPLACED_DLN_FROM_MHDR;
	PRTE2_X_Ins_DataCleanse.Layouts.Layout_Merged_IHDR_BHDR;
END;

BHDR_FIX_OUTREC xFixDLNinMHDR(Merged_Headers_SF_DS L):=TRANSFORM
  SELF := L;
  SELF.REPLACED_DLN_FROM_MHDR := L.fb_dln;
END;

MHDR_BHDR_DLN_FIX_RS := PROJECT(Merged_Headers_SF_DS, xFixDLNinMHDR(LEFT));
MHDR_BHDR_DLN_FIX_RS;

BHDR_FIX_OUTREC1 := RECORD
  STRING30 REPLACED_DLN_FROM_MHDR;
	prte_csv.ge_header_base.layout_payload;
END;

BHDR_FIX_OUTREC1 xFixDLNinBHDR(Alpha_Base_DS L,MHDR_BHDR_DLN_FIX_RS R):= TRANSFORM
  SELF.DL_NUMBER :=IF(L.DL_NUMBER<> '', L.DL_NUMBER, IF(L.DL_NUMBER = R.FB_DLN, L.DL_NUMBER, R.FB_DLN));
	SELF.REPLACED_DLN_FROM_MHDR := R.REPLACED_DLN_FROM_MHDR;
	SELF := L;
END;

BHDR_DLN_FIX_RS := JOIN(Alpha_Base_DS, MHDR_BHDR_DLN_FIX_RS(addr_ind <> '2'),
                        LEFT.DID = RIGHT.DID
												,xFixDLNinBHDR(LEFT,RIGHT)
												,LEFT OUTER
												);
												

COUNT(BHDR_DLN_FIX_RS(REPLACED_DLN_FROM_MHDR=DL_NUMBER)); //52552
COUNT(BHDR_DLN_FIX_RS(REPLACED_DLN_FROM_MHDR<>DL_NUMBER)); //8
BHDR_DLN_FIX_RS(REPLACED_DLN_FROM_MHDR<>DL_NUMBER);  // The reason is fb_dln in MHDR is string30, however, dln in BHDR is qstring15

COUNT(BHDR_DLN_FIX_RS(REPLACED_DLN_FROM_MHDR[1..15]<>DL_NUMBER)); //0

BHDR_DLN_FIXED := PROJECT(BHDR_DLN_FIX_RS, prte_csv.ge_header_base.layout_payload);
// COUNT(BHDR_DLN_FIXED);
// OUTPUT(BHDR_DLN_FIXED,, '~prct::base::ct::alpharetta::peopleheader_base_fixed_DOB_DLN::20150910');
OUTPUT(BHDR_DLN_FIXED,, '~prct::base::ct::alpharetta::peopleheader_base_fixed_DOB_DT_DLN::20150911');

/*
//More reasearch of checking DLNs
BHDR_DLN_FIXED(did = 888809024314);
BHDR_DLN_FIX_RS(did = 888809024314);
MHDR_BHDR_DLN_FIX_RS(did = 888809024314);

BHDR_DLN_FIX_RS(DID in Dismatch_DLD_LIST);
BHDR_DLN_FIXED(DID in Dismatch_DLD_LIST);
MHDR_BHDR_DLN_FIX_RS(DID in Dismatch_DLD_LIST);
*/