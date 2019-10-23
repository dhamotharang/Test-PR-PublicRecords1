IMPORT Watchdog;
EXPORT fn_append_vehnum(DATASET(watchdog_best.Layouts.Layout_Best) best) := FUNCTION
	veh := DISTRIBUTE(Watchdog.BestVehicle, did);
  b := DISTRIBUTE(best, did);
	
	result := JOIN(b, veh, left.did=right.did, TRANSFORM(Watchdog_best.Layouts.Layout_Best,		
										self.Vehicle_vehnum := RIGHT.vehnum;
										self := LEFT;),
									LEFT OUTER, KEEP(1), LOCAL);
									
	return result;
END;