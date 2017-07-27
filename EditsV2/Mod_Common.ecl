EXPORT Mod_Common := MODULE
	
	SHARED Layout_Order := Layouts_Order.Order;
	SHARED Layout_CompId_Order := Layouts_Services.CompId_Order;
	
	/* Convert the Generic Order (Edits) to CompId-Specific Order */
	EXPORT DATASET(Layout_CompId_Order) getCompIdOrdersFromGeneric(DATASET(Layout_Order) Orders) := FUNCTION
	
		Layout_CompId_Order ConvertToCompIdOrder (Layout_Order L) := TRANSFORM
			SELF := L.RI01_Recs[1];
			SELF := L.PI01_Recs[1];
			SELF := L.AL01_Recs[1];
			
			SELF := L.DL01_Recs[1];
			SELF.DLStateCode := L.DL01_Recs[1].StateCode;
		END;
		
		CompId_Orders := PROJECT (Orders, ConvertToCompIdOrder (LEFT));
		
		RETURN CompId_Orders;
	END;
	
END;
