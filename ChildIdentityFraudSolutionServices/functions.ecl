import BatchServices, BatchShare, ut, VehicleV2_Services, Autokey_batch, 
       doxie, AddrBest, LiensV2_Services, paw_services, DidVille, prof_LicenseV2_Services, FaaV2_Services,
			 SexOffender_Services, WatercraftV2_Services, Foreclosure_Services, LN_PropertyV2_Services, Suppress,
			 BIPV2, Royalty, STD;

export Functions := module

//These are the common batch parameters that may be used to call other batch services. 
shared BatchParams		:= IParam.getBatchParams();				 										 
// temporarily: until we move all batches to BatchShare.IParam.BatchParamsV2
shared mod_batchV2 := BatchShare.IParam.GetFromLegacy (BatchParams);
//---------------------------------------------------------------------------------------------------------//	
	export getBest(dataset(Layouts.BatchIn) BatchIn)  := function
	
		batchBest := project(BatchIn,transform(didville.Layout_Did_OutBatch ,
		  self.seq		:=	(integer)left.acctno,
			self.ssn		:=	left.ssn,
			self				:=  []  )); 

		dsBestPre := DidVille.did_service_common_function(batchBest,'BEST_ALL','BEST_ALL','',false,, ,
                                                 , , , , , mod_batchV2.glb,mod_batchV2.show_minors , , ,'',
																								 IndustryClass_val := mod_batchV2.industry_class); 
																								 	
		dsBest	:= dsBestPre(score >= CONSTANTS.ScoreThreshold );	

    return dsBest;
	 end;   
	
//---------------------------------------------------------------------------------------------------------//

	export getBestAddress(BatchIn, ds_best) :=  functionmacro
    IMPORT AddrBest;

		dsForBestAdd := project(ungroup(ds_best),
			transform(AddrBest.Layout_BestAddr.Batch_in,
				self.acctno 			:= (string) left.seq,
				self.did 					:= left.did, 
				self.ssn 					:= if(left.best_ssn <> '',left.best_ssn,left.ssn), 
				self.name_first 	:= left.best_fname,
				self.name_middle 	:= left.best_mname,
				self.name_last 		:= left.best_lname,
				self.name_suffix 	:= left.best_name_suffix,
				self := [] ));									

		BatchParams	:= ChildIdentityFraudSolutionServices.IParam.getBatchParams();

		AddrParams  := module(project(BatchParams,AddrBest.IParams.SearchParams,opt))
			export ReturnLatLong				:= TRUE;
		end;
		
		dsBestAddressPre0 	:= AddrBest.Records(dsForBestAdd,AddrParams).best_records;
		
		dsBestAddressPre		:= project(dsBestAddressPre0, 
			transform(recordof(dsBestAddressPre0),
				self.fips_county 	:= INTFORMAT(ut.St2Code(left.st),2, 1)+left.fips_county,
				self							:= left));
			
		dsBestAddress := dsBestAddressPre((unsigned)name_score between AddrParams.minNameScore and AddrParams.maxNameScore);		
		
		return dsBestAddress;
	endmacro;	
//---------------------------------------------------------------------------------------------------------//		
	export getBankruptcy(dataset(Layouts.BatchIn) BatchIn) := function
	 BatchInCommonSSN := project(BatchIn, transform(BatchServices.layout_BankruptcyV3_Batch_in,
																										self.acctno := left.acctno,
																										self.ssn := left.ssn,
																										self := []));
																										
   dsBankruptcy := BatchServices.Bankruptcy_BatchService_Records.Search(BatchInCommonSSN);
	 return dsBankruptcy;
	end;
//---------------------------------------------------------------------------------------------------------//		
	export getLJ(dataset(Layouts.BatchIn) BatchIn) := function
		LJBatchParams := module(project(mod_batchV2, LiensV2_Services.IParam.batch_params,opt))
			export BOOLEAN no_did_append		:= FALSE ;
			export party_types 							:= ['A','C','D',''];
			export BOOLEAN MatchSSN					:= true;
		end;	
		
	  LJBatchIn := project(BatchIn,transform(LiensV2_Services.Batch_Layouts.batch_in,
													self.acctno := left.acctno,
													self.ssn := left.ssn ,
													self := [] ));
													
		dsLJ := LiensV2_Services.Batch_records(LJBatchIn, LJBatchParams); 
		ds_JL_recs_flat := PROJECT(dsLJ, LiensV2_Services.batch_make_flat(LEFT));				
		
		return ds_JL_recs_flat;
	end;
//---------------------------------------------------------------------------------------------------------//		
   export getProperty(dataset(Layouts.BatchIn) BatchIn) := function
	 rec_batch_in_plus_date_filter := RECORD(LN_PropertyV2_Services.layouts.batch_in)
		STRING4 min_year := '0';
		STRING4 max_year := '9999';
	END;

	  BatchInProperty := project(BatchIn, transform(rec_batch_in_plus_date_filter,
																										self.acctno := left.acctno,
																										self.ssn := left.ssn,
																										self := []));
		
		nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.doNothing);
		dsProperty_pre  := BatchServices.Property_BatchCommon(false, nss, false,BatchInProperty).Records;
		//make sure to exclude no hit records to avoid count of 1 for records with no hit
		dsProperty	:= dsProperty_pre(ln_fares_id <> '');
		return dsProperty;
	 end;
//---------------------------------------------------------------------------------------------------------//		
	export getSOF(dataset(Layouts.BatchIn) BatchIn)	:= function																		
		SOF_BatchIn := project(BatchIn,transform(SexOffender_Services.Layouts.batch_in,
																							self.acctno := left.acctno,
																							self.ssn := left.ssn,
																							self := [] ));
		 SOF_BatchParams := module(project(mod_batchV2,SexOffender_Services.IParam.batch_params, opt))
		 end;
		
		 dsSOF := SexOffender_Services.batch_records(SOF_BatchParams,SOF_BatchIn);
		 
		return dsSOF;
	end;
//---------------------------------------------------------------------------------------------------------//		
	export getPAW(dataset(Layouts.BatchIn) BatchIn) := function
	
	  BatchInCommonSSN := project(BatchIn, transform(Autokey_batch.Layouts.rec_inBatchMaster,
																										self.acctno := left.acctno,
																										self.ssn := left.ssn,
																										self := []));
		dsPAW := paw_services.Batch_Service_Records(BatchInCommonSSN);
		return dsPAW;
	end;

//---------------------------------------------------------------------------------------------------------//		
  export getForeclosure(dataset(Layouts.BatchIn) BatchIn ,
												dataset(AddrBest.Layout_BestAddr.batch_out_final) BestAddress) := function

    Foreclosure_Services.Layouts.layout_batch_in  xformToForeclosureBatch( Layouts.BatchIn L )  := transform
				self.acctno         := 	L.acctno ;
				self.last_name      := 	L.name_last;
				self.middle_initial := 	L.name_middle;
				self.first_name     := 	L.name_first ;
				curRecBestA					:=  BestAddress(acctno = L.acctno);
				self.prim_range     := 	if(exists(curRecBestA),curRecBestA[1].prim_range  ,'') ; 
				self.prim_name      := 	if(exists(curRecBestA),curRecBestA[1].prim_name  ,'') ;
				self.addr_suffix    := 	if(exists(curRecBestA),curRecBestA[1].suffix  ,'') ;
				self.predir         := 	if(exists(curRecBestA),curRecBestA[1].predir  ,'') ;
				self.postdir        := 	if(exists(curRecBestA),curRecBestA[1].postdir  ,'') ;
				self.sec_range      := 	if(exists(curRecBestA),curRecBestA[1].sec_range  ,'') ;
				self.p_city_name    := 	if(exists(curRecBestA),curRecBestA[1].p_city_name  ,'') ;
				self.st             := 	if(exists(curRecBestA),curRecBestA[1].st  ,'') ;
				self.z5             := 	if(exists(curRecBestA),curRecBestA[1].z5  ,'') ;
				self.zip4           := 	if(exists(curRecBestA),curRecBestA[1].zip4  ,'') ;
				self 								:= 	[] ;
		end;
		
		ForeclosureBatchIn := project(BatchIn,xformToForeclosureBatch(left));
	
		dsForeclosure := Foreclosure_Services.BatchService_Records(ForeclosureBatchIn);
		return dsForeclosure;
 end;	
 
//---------------------------------------------------------------------------------------------------------//		

	export getRTMV(dataset(Layouts.BatchIn) BatchIn, 
								 dataset(AddrBest.Layout_BestAddr.batch_out_final) BestAddress) := function
								 
    VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2  xformToRTMVBatchIn(BatchIn L )  :=   transform					
			self.acctno 		:= l.acctno;
			self.name_first := l.name_first;
			self.name_last  := l.name_last;
			curBestAddress 	:= BestAddress(acctno = l.acctno);
			self.addr1 := curBestAddress[1].prim_range  + ' '+ curBestAddress[1].predir + ' '+ 
										curBestAddress[1].prim_name + ' '+ curBestAddress[1].suffix + ' '+ 
										curBestAddress[1].postdir ;
			self.addr2 := curBestAddress[1].unit_desig  + ' '+ curBestAddress[1].sec_range;
			self.p_city_name  := curBestAddress[1].p_city_name;
			self.st 	:= curBestAddress[1].st;
			self.z5 	:= curBestAddress[1].z5;
			self:=[]; 
		end;					 
	  RTMVBatchIn   := project(BatchIn , xformToRTMVBatchIn(left));
		
		RTMVBatchParams := module(project(BatchParams, VehicleV2_Services.IParam.RTBatch_V2_params,opt))
			// 127542 - GatewayNameMatch option works only for gateways - It filters by person's name who owns the vehicle at input address.
			export boolean GatewayNameMatch   := True;
			export BOOLEAN AlwaysHitGateway   := ~doxie.DataPermission.use_Polk;
			export BOOLEAN ReturnCurrent			:= true;
		end;
		dsRTMV_pre 	:= VehicleV2_Services.RealTime_Batch_Service_V2_records(RTMVBatchIn, RTMVBatchParams, true); 
		
		//make sure to exclude no hit records to avoid count of 1 for records with no hit
		dsRTMV_filt	:= dsRTMV_pre(vin <> '');
		
		returnDetailedRoyalties	:= BatchParams.ReturnDetailedRoyalties;
		Royalty.RoyaltyVehicles.MAC_Append(dsRTMV_filt, dsRTMV_Results, vin, hit_flag, true);
		Royalty.RoyaltyVehicles.MAC_BatchSet(dsRTMV_Results, royalties,,returnDetailedRoyalties);
		
		RTMV_OutRec  := record
			dataset(recordof(dsRTMV_Results)) Results;
			dataset(recordof(royalties))   Royalties;
		end;
		
	  dsRTMV := dataset([{dsRTMV_Results,royalties}],RTMV_OutRec);
		
		return dsRTMV; 
	end;
//---------------------------------------------------------------------------------------------------------//
export getPL(dataset(Layouts.BatchIn) BatchIn) := function

	PLBatchIn := project(BatchIn,transform(prof_LicenseV2_Services.Layout_MLPL_Combined_Input,
					self.acctno := left.acctno,
					self.ssn 		:= left.ssn,
					self := [] ));
					
	dsPL := prof_LicenseV2_Services.PL_Batch_Service_Records(20,false,false,PLBatchIn);
	
	return dsPL;
end;
//---------------------------------------------------------------------------------------------------------//
export getWC(dataset(Layouts.BatchIn) BatchIn) := function
		WCBatchIn 		:= project(BatchIn,transform(WatercraftV2_Services.Layouts.batch_in,
																							  self.acctno := left.acctno,
																								self.ssn := left.ssn,
																								self:=[]));
		WCBatchParams := module(project(mod_batchV2, WatercraftV2_Services.Interfaces.batch_params,opt))
		export boolean 		ReturnCurrentOnly := false; 
		end;
		dsWCNotFlat :=	WatercraftV2_Services.BatchRecords(WCBatchParams,WCBatchIn);
		dsWC := project(dsWCNotFlat, WatercraftV2_Services.Transforms.xform_toFinalBatch(LEFT));	
		
	return dsWC;
end;
//---------------------------------------------------------------------------------------------------------//
export getFaaV2(dataset(Layouts.BatchIn) BatchIn) := function
  FaaV2BatchIn := project(BatchIn,transform(FaaV2_Services.Layouts.batch_in,
													self.acctno := left.acctno,
													self.ssn := left.ssn ,
													self := []));
													
	FaaV2Params := FaaV2_Services.IParam.getBatchParams();
								 
	dsFaaV2 := FaaV2_Services.batch_records(FaaV2Params , FaaV2BatchIn).records; //FFD Change
	return dsFaaV2;
end;
//---------------------------------------------------------------------------------------------------------//
 export getBusiness(dataset(Layouts.BatchIn) BatchIn) := function

	// BIP method 
		BIPV2.IDfunctions.rec_SearchInput   xform(Layouts.BatchIn L) := transform
			self.acctno := (string) L.acctno;
			self.contact_ssn := (string) L.ssn;
			self := [];
		end;
		
		InputSearch := project(BatchIn,xform(left));
		dsBussiness := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(InputSearch).SELEBest;
    return(dsBussiness);
   end;

end;
