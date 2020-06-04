IMPORT Ecrash_Common;

Layouts_NAccidentsInquiry.VEHICLE_INSURANCE tVehicleInsurance(Files_NAccidentsInquiry.DS_SPRAY_VEHICLE_INSCR L) := TRANSFORM
		SELF.Carrier_ID   := TRIM(L.Carrier_ID,LEFT,RIGHT);
		SELF.Carrier_Name := TRIM(L.Carrier_Name,LEFT,RIGHT);
		SELF.Last_Changed := TRIM(L.Last_Changed,LEFT,RIGHT);
		SELF.UserID       := TRIM(L.UserID,LEFT,RIGHT);
	END;

	sUncleanVehicleInscr := PROJECT(Files_NAccidentsInquiry.DS_SPRAY_VEHICLE_INSCR, tVehicleInsurance(LEFT));
	rmvHeaderVehicleInscr := sUncleanVehicleInscr(Carrier_ID NOT IN Constants_NtlAccidentsInquiry.HdrVehicleInscr);

	Ecrash_Common.mac_CleanFields(rmvHeaderVehicleInscr,sVehicleInscrClean);
	Ecrash_Common.mac_ConvertToUpperCase(sVehicleInscrClean, sVehicleInscrUpper);

	dVehicleInscr := DISTRIBUTE(sVehicleInscrUpper, HASH32(Carrier_ID));

EXPORT iVehicleInscr := dVehicleInscr : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_VEHICLE_INSURANCE');