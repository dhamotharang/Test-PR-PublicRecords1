	IMPORT Ecrash_Common;
	
	nOrderVersion := iOrderVersion;
	nIntOrder := iIntOrder;
															 
	//Combine int_order and order_version	
	Layouts_NAccidentsInquiry.ORDER_COMBINED OrderVersion(nOrderVersion L) := TRANSFORM
		SELF.Flag := 'V';
		SELF := L;
		SELF := []
	END;
	pOrderVersion := PROJECT(nOrderVersion,OrderVersion(LEFT));

	//---------------------------------------------
	Layouts_NAccidentsInquiry.ORDER_COMBINED IntOrder(nIntOrder L) := TRANSFORM
		SELF.Flag := 'I';
		SELF := L;
		SELF := [];
	END;
	pIntOrder:= PROJECT(nIntOrder,IntOrder(LEFT));
	
 cOrderCombined := pIntOrder + pOrderVersion;
	
 mac_NID_cleannames(cOrderCombined, NameClean); 
	 
 CleanOrderCombined := NameClean;

 dCleanOrderCombined := DISTRIBUTE(CleanOrderCombined, HASH32(ORDER_ID));

EXPORT OrderCombined := dCleanOrderCombined : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::ORDER_COMBINED');
