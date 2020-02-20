IMPORT Ecrash_Common;

Layouts_NAccidentsInquiry.RESULT tResult(Files_NAccidentsInquiry.DS_SPRAY_RESULT L) := TRANSFORM
		SELF.Result_ID       := TRIM(L.Result_ID,LEFT,RIGHT);
		SELF.Order_ID        := TRIM(L.Order_ID,LEFT,RIGHT);
		SELF.Sequence_Nbr    := TRIM(L.Sequence_Nbr,LEFT,RIGHT);
		SELF.Creation_Date   := TRIM(L.Creation_Date,LEFT,RIGHT);
		SELF.Last_Changed    := TRIM(L.Last_Changed,LEFT,RIGHT);
		SELF.UserID          := TRIM(L.UserID,LEFT,RIGHT);
		SELF := L;
		SELF := [];
	END;

	sUncleanResult := PROJECT(Files_NAccidentsInquiry.DS_SPRAY_RESULT, tResult(LEFT));
	rmvHeaderResult := sUncleanResult(Result_ID NOT IN Constants_NtlAccidentsInquiry.HdrResult);

	Ecrash_Common.mac_CleanFields(rmvHeaderResult,sResultClean);
	Ecrash_Common.mac_ConvertToUpperCase(sResultClean, sResultUpper);

	dResult := DISTRIBUTE(sResultUpper, HASH32(Order_ID));

EXPORT iResult := dResult : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_RESULT');