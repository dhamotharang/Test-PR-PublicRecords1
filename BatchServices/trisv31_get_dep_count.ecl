import ut, ChildIdentityFraudSolutionServices;

export trisv31_get_dep_count(dataset(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in_wdid) ds_In) := function

	
	ChildIdentityFraudSolutionServices.Layouts.batchIn lay_change(ds_In l) := transform
	
	self := l;
	self := [];
	
	end;
	
	batchIn  := project(ds_In,lay_change(left));


	//**The below fields are from the ADL_Best service.
	dsBest := ChildIdentityFraudSolutionServices.functions.getBest(batchIn);

	//Currently imposters are returned with blanked first name , last name and address fields. and also as filled fields. 

 	dsBestMatchingPeople 	:=   join(dsBest, batchIn,
   		((string) left.seq =  right.acctno AND 
   		(left.best_ssn = right.ssn or (left.best_ssn = '' and  left.ssn = right.ssn) ) 
   		AND left.best_fname <> '' ),
   		transform(recordof(dsBest), self := left));

	//** The below fields are from the Best Address service.			
	dsBestAddress := ChildIdentityFraudSolutionServices.functions.getBestAddress(batchIn,dsBestMatchingPeople);



	//** The below fields are from the Bankruptcy check.			
	dsBankruptcy := ChildIdentityFraudSolutionServices.functions.getBankruptcy(batchIn);
  
	//** The below fields are from the Lien/Judgment check.			
	dsLJ := ChildIdentityFraudSolutionServices.functions.getLJ(batchIn); 

	//** The below fields are from the Property check.			
	dsProperty := ChildIdentityFraudSolutionServices.functions.getProperty(batchIn);

	//** The below fields are from the Sexual Offender check.			
	dsSOF := ChildIdentityFraudSolutionServices.functions.getSOF(batchIn); 

	//** The below fields are from the People at Work check.			
	dsPAW := ChildIdentityFraudSolutionServices.functions.getPAW(batchIn);
	//** The below fields are from the Foreclosure check.			

	dsForeclosure := ChildIdentityFraudSolutionServices.functions.getForeclosure(batchIn, dsBestAddress); 
	// ** The below fields are from the Motor Vehicle check.			

	dsRTMV_Whole := ChildIdentityFraudSolutionServices.functions.getRTMV(batchIn,dsBestAddress); 
	dsRTMV := dsRTMV_Whole.Results;

	// ** The below fields are from the Professional License check.			
	dsPL :=  ChildIdentityFraudSolutionServices.functions.getPL(batchIn); 

	// ** The below fields are from the Watercraft check.			
	dsWC := ChildIdentityFraudSolutionServices.functions.getWC(batchIn); 

	// ** The below fields are from the Aircraft check.	
	dsFaaV2 := ChildIdentityFraudSolutionServices.functions.getFaaV2(batchIn);

	// ** The below fields are from the Business check.
	dsBusiness := ChildIdentityFraudSolutionServices.functions.getBusiness(batchIn); 


	//------------------------------------------------------------------------------------------------

	ChildIdentityFraudSolutionServices.Layouts.BatchOut TheXform(ChildIdentityFraudSolutionServices.Layouts.batchIn L) := transform
     self.acctno := L.acctno;
		self.BKcount := count(dsBankruptcy(acctno = L.acctno));    // Bankruptcy check.
		self.LJ_count := count(dsLJ(acctno = L.acctno));           // Lien/Judgment check.			
		self.Prop_count := count(dsProperty(acctno = L.acctno));   // Property check.	
		self.SOF_count := count(dsSOF.offenses(acctno = L.acctno));// Sexual Offender check.			
		self.PAWK_count := count(dsPAW(acctno = L.acctno));        // People at Work check.
		self.FC_count := count(dsForeclosure(acctno = L.acctno));  // Foreclosure check.
		self.MV_count := count(dsRTMV(acctno = L.acctno));         // Motor Vehicle check.
  		self.PL_count := count(dsPL(acctno = L.acctno));           // Professional License check.
		self.WC_count := count(dsWC(acctno = L.acctno));           // Watercraft check.	
		self.AC_count := count(dsFaaV2(acctno = L.acctno));       // Aircraft check.
		self.Biz_count := count(dsBusiness(acctno = L.acctno));   // BIP check
	
		self := L;
		self:= []; 
	
	END;
		
	dsOutput_cnt := project(batchIn,TheXform(left));	
	
	tris_cnt := record
  STRING30	acctno;
	unsigned3 derogatory_count;
  unsigned3 asset_count;
  unsigned3 professional_count;
	
	end;
	
	tris_cnt TheCount(dsOutput_cnt L) := transform
	 
	self.acctno := L.acctno;
	self.derogatory_count := L.BKcount + L.FC_count + L.LJ_count + L.SOF_count;
	self.asset_count      := L.Prop_count + L.MV_count + L.WC_count + L.AC_count;
	self.professional_count := L.PAWK_count +  L.PL_count + L.Biz_count;
	self := [];
	
	end;
	
  ds_cnt := project(dsOutput_cnt,TheCount(left));
 
return ds_cnt;
	
end;
	
