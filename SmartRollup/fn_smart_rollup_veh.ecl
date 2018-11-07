import iesp,STD,VehicleV2,ut;
export fn_smart_rollup_veh(dataset(iesp.motorvehicle.t_MotorVehicleReport2Record) inRecs,unsigned6 subjectDID) := function
  todays_date := STD.Date.Today();
  outLayout := record
		string1 current_prior;
 	  unsigned4 regist_date_9999;
		string LengthOfOwnership;
		recordof(inRecs);
	end;
	outLayout f_it(inRecs L) := transform
	  cur_prior := If (L.isCurrent,iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR);
    self.current_prior := cur_prior;
	  self.regist_date_9999 := 99999999 - (unsigned4)iesp.ECL2ESP.DateToInteger(l.registrants[1].RegistrationInfo.LatestEffectiveDate);
		fRegDate := INTFORMAT(l.Registrants[1].RegistrationInfo.FirstDate.Year,4,1) + 
								INTFORMAT(l.Registrants[1].RegistrationInfo.FirstDate.Month,2,1) + 
								INTFORMAT(l.Registrants[1].RegistrationInfo.FirstDate.Day,2,1);
		self.LengthOfOwnership := IF(cur_prior = iesp.Constants.SMART.CURRENT,(string) ut.Age((INTEGER)fRegDate),'');	
		self := l;
	end;
  fRecs := project(inRecs, f_it(left));
	sRecs := SORT(fRecs,  VehicleInfo.vin, VehicleInfo.make, VehicleInfo.model, current_prior , regist_date_9999, record); 
	
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
  // This code will not catch when a car registration has expired but the owner has renewed at the
  // registrars office and the new updated expiration date vender record is not been sent yet.  
  // The car will show in the prior vehicle section until the new vender record is in the data. 
	// currOwners(append_did = subjectDID... allows for co-owners to show the veh as current
  dRecs fixCurrent(dRecs L) := transform
	  owners := LIMIT(VehicleV2.Key_Vehicle_Party_Key(keyed(vehicle_key = L.vehicleInfo.vehicleRecordId)),1000,KEYED,SKIP);
    sowners := sort(owners, -reg_latest_effective_date,-reg_latest_expiration_date,-date_vendor_last_reported);
    currOwners := sowners(reg_latest_effective_date = sowners[1].reg_latest_effective_date AND
                          reg_latest_expiration_date = sowners[1].reg_latest_expiration_date AND
                          date_vendor_last_reported  = sowners[1].date_vendor_last_reported);
    isCurrent := EXISTS(currOwners(append_did = subjectDID AND (UNSIGNED4)reg_latest_expiration_date >= todays_date));  
		self.IsCurrent := isCurrent;
    self.current_prior := IF (isCurrent,iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR);
		self := L;
	end;
  dRecs2Current := project(dRecs, fixCurrent(LEFT));	
	
	finalSort := sort(dRecs2Current, current_prior, regist_date_9999, VehicleInfo.vin, VehicleInfo.make, VehicleInfo.model, record);
	outrecs := project(finalSort, transform(iesp.smartlinxreport.t_SLRVehicle, self.currentPrior := LEFT.current_prior,self := LEFT ));

	RETURN outrecs; 
end;