import iesp,VehicleV2,ut;
export fn_smart_rollup_veh(dataset(iesp.motorvehicle.t_MotorVehicleReport2Record) inRecs,unsigned6 subjectDID) := function
  outLayout := record
		string1 current_prior;
 	  unsigned4 regist_date_9999;
		string LengthOfOwnership;
		recordof(inRecs);
	end;
	outLayout f_it(inRecs L) := transform
	  self.current_prior := If (L.isCurrent,iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR);
	  self.regist_date_9999 := 99999999 - (unsigned4)iesp.ECL2ESP.DateToInteger(l.registrants[1].RegistrationInfo.LatestEffectiveDate);
		fRegDate := INTFORMAT(l.Registrants[1].RegistrationInfo.FirstDate.Year,4,1) + 
								INTFORMAT(l.Registrants[1].RegistrationInfo.FirstDate.Month,2,1) + 
								INTFORMAT(l.Registrants[1].RegistrationInfo.FirstDate.Day,2,1);
		self.LengthOfOwnership := IF(self.current_prior = iesp.Constants.SMART.CURRENT,(string) ut.GetAgeI((INTEGER)fRegDate),'');	
		self := l;
		// self := [];
	end;
  fRecs := project(inRecs, f_it(left));
	sRecs := SORT(fRecs,  VehicleInfo.vin, VehicleInfo.make, VehicleInfo.model, current_prior , regist_date_9999, record); 
	//dRecs := DEDUP(sRecs, VehicleInfo.vin, VehicleInfo.make, VehicleInfo.model);
	
	sRecs loadit(sRecs L, sRecs R) := transform
     self.registrants := IF (EXISTS(L.Registrants), L.registrants, if(EXISTS(R.registrants),R.registrants ));
     self.Owners := IF (EXISTS(L.Owners), L.Owners, if (EXISTS(R.Owners),R.Owners ));
     self.LienHolders := IF (EXISTS(L.LienHolders), L.LienHolders, if (EXISTS(R.LienHolders),R.LienHolders ));
     self.Lessees := IF (EXISTS(L.Lessees), L.Lessees, if (EXISTS(R.Lessees),R.Lessees ));
     self.Lessors := IF (EXISTS(L.Lessors), L.Lessors, if (EXISTS(R.Lessors),R.Lessors ));
	   self := L;
	end;
	dRecs := rollup(sRecs, LEFT.VehicleInfo.vin = RIGHT.VehicleInfo.vin and 
	                       LEFT.VehicleInfo.make=RIGHT.VehicleInfo.make and
												 LEFT.VehicleInfo.model=RIGHT.VehicleInfo.model, 
	                       loadit(LEFT,RIGHT));
	
	// check to see if someone else has registered this car more recently than you, if so turn off current owner flag
	dRecs fixCurrent(dRecs L) := transform
	  owners := LIMIT(VehicleV2.Key_Vehicle_Party_Key(keyed(vehicle_key = L.vehicleInfo.vehicleRecordId)),1000,KEYED,SKIP);
    sowners := sort(owners, -reg_latest_effective_date,-reg_latest_expiration_date,-date_vendor_last_reported);
    isCurrent := exists(choosen(sowners,1)(append_did = subjectDID));  
		self.current_prior := If (isCurrent,iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR);
		self := L;
	end;
  dRecs2Current := project(dRecs, fixCurrent(LEFT));	
	
	finalSort := sort(dRecs2Current, current_prior, regist_date_9999, VehicleInfo.vin, VehicleInfo.make, VehicleInfo.model, record);
	outrecs := project(finalSort, transform(iesp.smartlinxreport.t_SLRVehicle, self.currentPrior := LEFT.current_prior,self := LEFT ));
	
	RETURN outrecs; 
end;