	
  Layouts_NAccidentsInquiry.ALL_CRU_ORDERS tAllCruOrders(OrderCombinedVehicleIncident L) := TRANSFORM
    SELF := L;
	SELF := [];
  END;
  pAllCruOrders := PROJECT(OrderCombinedVehicleIncident, tAllCruOrders(LEFT));
	
  dAllCruOrders := DISTRIBUTE(pAllCruOrders, HASH32(Order_ID));

EXPORT iAllCruOrders := dAllCruOrders  : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_ALL_CRU_ORDERS');