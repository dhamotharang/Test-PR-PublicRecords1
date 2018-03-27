IMPORT PRTE2_Header_Ins, ut, PRTE2_Common, prte_csv;
#workunit('name', 'Boca CT Header Alter SSN');


// CSV_NAME := 'PersonHeader_Alpha_Base_PROD_'+xdate+'.csv';
// Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_PROD;

// After update the BHDR up to date, it could be referenced from the QA generation.
// Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
// Alpha_Base_DS := DATASET('~prct::base::ct::alpharetta::peopleheader_base_fixed_DOB_DLN::20150910', prte_csv.ge_header_base.layout_payload,THOR);;
Alpha_Base_DS := DATASET('~prct::base::ct::alpharetta::peopleheader_base_fixed_dob_dt_dln::20150911', prte_csv.ge_header_base.layout_payload,THOR);;
COUNT(Alpha_Base_DS(dl_number <>'')); //3630

/*--------------------------------
  Fix SSNs in BHDR before Despray 
 ---------------------------------*/
Alpha := project(Alpha_Base_DS, {unsigned s_did, unsigned did, string fname, string mname, string lname, string ssn, STRING ST, STRING ZIP});

OUT_LAYOUT := RECORD
	recordof(Alpha);
	string9  A_SSN;
  string9  NEW_SSN;
  string9  E_SSN;
	string  E_fname;
	string  E_mname;
	string  E_lname;
	string  E_ST;
	string  E_ZIP;
END;

SSN_needFix := DATASET('~prct::BASE::ct::alpharetta::PeopleHeader_Base_NeedFix::20150903', OUT_LAYOUT, THOR);
 
SSNs_Fix_Layout := RECORD
  RECORDOF(Alpha_Base_DS);
  string9  NEW_SSN;	
END;

SSNs_Fix_Layout xFixSSN(Alpha_Base_DS L, SSN_needFix R) := TRANSFORM
  SELF := L;
	SELF := R;
END;

SSN_Fix_RESULT := JOIN(Alpha_Base_DS, SSN_needFix,
                       LEFT.DID = RIGHT.DID
											 ,xFixSSN(LEFT, RIGHT)
											 , LEFT OUTER);

prte_csv.ge_header_base.layout_payload xFixSSNFinal(SSN_Fix_RESULT L):= TRANSFORM
  FixSSN     := IF(L.New_SSN = '', L.SSN, L.New_SSN);
	SELF.SSN   := FixSSN;
	SELF.S1    := FixSSN[1];
	SELF.S2    := FixSSN[2];
	SELF.S3    := FixSSN[3];
	SELF.S4    := FixSSN[4];
	SELF.S5    := FixSSN[5];
	SELF.S6    := FixSSN[6];
	SELF.S7    := FixSSN[7];
	SELF.S8    := FixSSN[8];
	SELF.S9    := FixSSN[9];
	SELF.SSN4  := FixSSN[6..9];
	SELF.SSN5  := FixSSN[1..5];
	SELF.S_SSN := FixSSN;
	SELF       := L;
END;

ALpha_Base_DS_Fixed := PROJECT(SSN_Fix_RESULT, xFixSSNFinal(LEFT));
// OUTPUT(ALpha_Base_DS_Fixed,,'~prct::BASE::ct::alpharetta::PeopleHeader_Base_fixed::20150903', OVERWRITE);
OUTPUT(ALpha_Base_DS_Fixed,,'~prct::BASE::ct::alpharetta::PeopleHeader_Base_fixed::20150911', OVERWRITE);

/*-----------------------
  Despray Fixed BHDR
 ------------------------*/
xdate	:= ut.GetDate+'';

CSV_NAME              := 'BHDR_EXP_SSN_FIXED_'+xdate+'.csv';
lzFilePathGatewayFile	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME;
TempCSV								:= PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT;
EXPORT_DS							:= DEDUP(SORT(ALpha_Base_DS_Fixed,DID),DID); 

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, PRTE2_Header_Ins.Constants.LandingZoneIP, lzFilePathGatewayFile);
