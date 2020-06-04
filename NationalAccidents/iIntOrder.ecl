IMPORT Ecrash_Common;

	Layouts_NAccidentsInquiry.INT_ORDER tIntOrder(Files_NAccidentsInquiry.DS_SPRAY_INT_ORDER L) := TRANSFORM
		SELF.Order_ID       := TRIM(L.Order_ID,LEFT,RIGHT);
		SELF.Creation_Date  := TRIM(L.Creation_Date,LEFT,RIGHT);
		SELF.Acct_Nbr       := TRIM(L.Acct_Nbr,LEFT,RIGHT);
		SELF.VIN            := TRIM(L.VIN,LEFT,RIGHT);
		SELF.First_Name_1   := TRIM(L.First_Name_1,LEFT,RIGHT);
		SELF.Middle_Name_1  := TRIM(L.Middle_Name_1,LEFT,RIGHT);
		SELF.Last_Name_1    := TRIM(L.Last_Name_1,LEFT,RIGHT);
		SELF.Processed_Date := TRIM(L.Processed_Date,LEFT,RIGHT);
		SELF.Fulfilled_Date := TRIM(L.Fulfilled_Date,LEFT,RIGHT);
		SELF.Checkin_Date   := TRIM(L.Checkin_Date,LEFT,RIGHT);
		SELF.o_Suffix_1     := TRIM(L.o_Suffix_1,LEFT,RIGHT);
		SELF.Initial_Order  := TRIM(L.Initial_Order,LEFT,RIGHT);
		SELF.Last_Changed   := TRIM(L.Last_Changed,LEFT,RIGHT);
		SELF := L;
		SELF := [];
	END;

	sUncleanIntOrder := PROJECT(Files_NAccidentsInquiry.DS_SPRAY_Int_Order, tIntOrder(LEFT));
 rmvHeaderIntOrder := sUncleanIntOrder(Order_ID NOT IN Constants_NtlAccidentsInquiry.HdrIntOrder);

	Ecrash_Common.mac_CleanFields(rmvHeaderIntOrder,sCleanIntOrder);
	Ecrash_Common.mac_ConvertToUpperCase(sCleanIntOrder, sIntOrderUpper);

	IntOrder := sIntOrderUpper;

EXPORT iIntOrder := IntOrder  : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_INT_ORDER');