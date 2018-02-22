import iesp, ut;
export fn_smart_rollup_watercraft(dataset(iesp.watercraft.t_WaterCraftReport2Record)  inRecs):= function

  outLayout := record
	 string40 watercraft_id;
	 string1 current_prior;
	 unsigned4 regist_date_9999;
	 string LengthOfOwnership;
	 recordof(inRecs);
	end;
	outLayout f_it(inRecs l) := transform
	  //BIP contains watercraft_make_description as well. did=1227991044 has diff desc for same vessel.
	  self.watercraft_id := l.watercraftkey;  
	  self.current_prior := if(l.isCurrent,iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR);
		self.regist_date_9999 := 99999999 - iesp.ECL2ESP.DateToInteger(l.dateLastSeen) ;
		fPurchDate := INTFORMAT(l.Description.PurchaseDate.Year,4,1) + 
									INTFORMAT(l.Description.PurchaseDate.Month,2,1) + 
									INTFORMAT(l.Description.PurchaseDate.Day,2,1);	
		self.LengthOfOwnership := IF(self.current_prior = iesp.Constants.SMART.CURRENT,(string) ut.Age((INTEGER) fPurchDate),'');
	  self := l;
		self := [];
	end;
	fRecs := project(inRecs, f_it(LEFT));
	sRecs := SORT(fRecs,  watercraft_id, current_prior, regist_date_9999, record); 
	dRecs := DEDUP(sRecs, watercraft_id);
	finalSort := SORT(dRecs, current_prior, regist_date_9999);
	outRecs := project(finalSort, transform(iesp.smartlinxreport.t_SLRWatercraft, self.currentPrior := LEFT.current_prior,self := LEFT ));

	RETURN outRecs; 
end;