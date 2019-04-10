IMPORT PhoneFinder_Services, iesp, Gateway, MDR, Phones, PhonesInfo, ut, dx_PhonesInfo;
EXPORT GetAccuDataPhones := MODULE

	 EXPORT GetAccuData_Ocn_PortingData(
		dataset(PhoneFinder_Services.Layouts.PhoneFinder.Accudata_in) din_accu,
		Gateway.Layouts.Config gateway_cfg
		) := FUNCTION
				
		gateway_URL := gateway_cfg.url;	 
		boolean makeGatewayCall := gateway_URL != '';

	  iesp.accudata_ocn.t_AccudataOcnRequest to_req(PhoneFinder_Services.Layouts.PhoneFinder.Accudata_in l) := transform
	   self.SearchBy.Phone := l.phone;
	   self.SearchBy.RequestId  := l.acctno;
	   self.Options.TransactionType := Phones.Constants.GatewayValues.AccuDataLNP;
	   self.GatewayParams := [];
	   self.Options := [];
	   self := [];
	  end;
		
	  gw_in := project(dedup(sort(din_accu,phone),phone), to_req(left)); // to limit gateway hits for phone request.
	  gw_recs := Gateway.SoapCall_AccuData_ocn(gw_in, gateway_cfg,,,makeGatewayCall);  
		
		portedrec := record
		 string20 acctno;
		 string1 typeflag;
		 recordof(PhonesInfo.Key_Phones.Ported_Metadata);	
		end;
	 
		portedrec  xporting(iesp.accudata_ocn.t_AccudataOcnResponseEx l, recordof(dx_PhonesInfo.Key_Source_Reference.ocn_name) r) :=  transform		
		 accurpt := l.response.AccudataReport;
		 self.acctno := accurpt.RequestId;
		 self.phone := accurpt.phone;
		 self.typeflag := Phones.Constants.TypeFlag.AccuData_OCN; 
		 self.source := MDR.sourceTools.src_Phones_Accudata_OCN_LNP; 
	   PortedDate := (unsigned) ut.date_slashed_MMDDYYYY_to_YYYYMMDD(accurpt.PortedDate[1..10]);
		 self.port_start_dt := PortedDate;
		 self.port_end_dt := PortedDate;
		 self.dt_first_reported := (unsigned) r.dt_first_reported; 
		 self.dt_last_reported := (unsigned) r.dt_last_reported;  
     self.operator_fullname := r.operator_full_name;
     self := r;
		 self := [];		
		end;
		
		ocn_join  := join(gw_recs(response.AccudataReport.ErrorMessage =''), dx_PhonesInfo.Key_Source_Reference.ocn_name,
		  keyed(left.response.AccudataReport.OperatingCompanyNumber = right.ocn) and right.is_current,
			xporting(left,right),
			left outer, keep(1), limit(0));
	 
	  // joining back to count royalty per each request.
	  ocn_final := join(din_accu, ocn_join, right.phone = left.phone,
			transform(portedrec, self.acctno := left.acctno, self.phone := left.phone, self := right),
			left outer, keep(1), limit(0)); 
		
    return sort(ocn_final, acctno);
	 END; 
END; 