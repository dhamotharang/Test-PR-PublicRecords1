IMPORT Ecrash_Common;

Layouts_NAccidentsInquiry.CLIENT tclient(Files_NAccidentsInquiry.DS_SPRAY_Client L) := TRANSFORM
		SELF.Client_ID    := TRIM(L.Client_ID,LEFT,RIGHT);
		SELF.Start_Date   := TRIM(L.Start_Date,LEFT,RIGHT);
		SELF.Version      := TRIM(L.Version,LEFT,RIGHT);
		SELF.Last_Changed := TRIM(L.Last_Changed,LEFT,RIGHT);
		SELF.Userid       := TRIM(L.Userid,LEFT,RIGHT);
		SELF := L;
		SELF := [];
	END;

	sUncleanClient := PROJECT(Files_NAccidentsInquiry.DS_SPRAY_Client, tClient(LEFT));
	rmvHeaderClient := sUncleanClient(Client_ID NOT IN Constants_NtlAccidentsInquiry.HdrClient);

	Ecrash_Common.mac_CleanFields(rmvHeaderClient,sCleanClient);
	Ecrash_Common.mac_ConvertToUpperCase(sCleanClient, sClientUpper);

	dClient := DISTRIBUTE(sClientUpper, HASH32(Client_ID));

EXPORT iClient := dClient : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_CLIENT');