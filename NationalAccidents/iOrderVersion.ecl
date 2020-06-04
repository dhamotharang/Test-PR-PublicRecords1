IMPORT Ecrash_Common;

Layouts_NAccidentsInquiry.ORDER_VERSION tOrderVersion(Files_NAccidentsInquiry.DS_SPRAY_ORDER_VERSION L) := TRANSFORM
		SELF.Order_ID           := TRIM(L.Order_ID,LEFT,RIGHT);
		SELF.Creation_Date      := TRIM(L.Creation_Date,LEFT,RIGHT); 
		SELF.Acct_Nbr           := TRIM(L.Acct_Nbr,LEFT,RIGHT);  
		SELF.Client_ID          := TRIM(L.Client_ID,LEFT,RIGHT);  
		SELF.Edit_Agency_Name   := TRIM(L.Edit_Agency_Name,LEFT,RIGHT);   
		SELF.House_Nbr          := TRIM(L.House_Nbr,LEFT,RIGHT);    
		SELF.Street             := TRIM(L.Street,LEFT,RIGHT);    
		SELF.VIN                := TRIM(L.VIN,LEFT,RIGHT);    
		SELF.Make               := TRIM(L.Make,LEFT,RIGHT);     
		SELF.Model              := TRIM(L.Model,LEFT,RIGHT);     
		SELF.First_Name_1       := TRIM(L.First_Name_1,LEFT,RIGHT);     
		SELF.Middle_Name_1      := TRIM(L.Middle_Name_1,LEFT,RIGHT);     
		SELF.Last_Name_1        := TRIM(L.Last_Name_1,LEFT,RIGHT);     
		SELF.SSN_1              := TRIM(L.SSN_1,LEFT,RIGHT);     
		SELF.DOB_1              := TRIM(L.DOB_1,LEFT,RIGHT);     
		SELF.First_Name_2       := TRIM(L.First_Name_2,LEFT,RIGHT);     
		SELF.Middle_Name_2      := TRIM(L.Middle_Name_2,LEFT,RIGHT);     
		SELF.Last_Name_2        := TRIM(L.Last_Name_2,LEFT,RIGHT);     
		SELF.First_Name_3       := TRIM(L.First_Name_3,LEFT,RIGHT);     
		SELF.Middle_Name_3      := TRIM(L.Middle_Name_3,LEFT,RIGHT);     
		SELF.Last_Name_3        := TRIM(L.Last_Name_3,LEFT,RIGHT);     
		SELF.DL_Nbr             := TRIM(L.DL_Nbr,LEFT,RIGHT);     
		SELF.DL_ST              := TRIM(L.DL_ST,LEFT,RIGHT);     
		SELF.Processed_Date     := TRIM(L.Processed_Date,LEFT,RIGHT);     
		SELF.Checkin_Date       := TRIM(L.Checkin_Date,LEFT,RIGHT);     
		SELF.Last_Changed       := TRIM(L.Last_Changed,LEFT,RIGHT);          
		SELF.UserID             := TRIM(L.UserID,LEFT,RIGHT);     
		SELF := L;
		SELF := [];
	END;

	sUncleanOrderVersion := PROJECT(Files_NAccidentsInquiry.DS_SPRAY_ORDER_VERSION, tOrderVersion(LEFT));
 rmvHeaderOrderVersion := sUncleanOrderVersion(Order_ID NOT IN Constants_NtlAccidentsInquiry.HdrOrderVersion);

	Ecrash_Common.mac_CleanFields(rmvHeaderOrderVersion,sOrderVersionClean);
	Ecrash_Common.mac_ConvertToUpperCase(sOrderVersionClean, sOrderVersionUpper);

	OrderVersion := sOrderVersionUpper;

EXPORT iOrderVersion := OrderVersion  : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_ORDER_VERSION');