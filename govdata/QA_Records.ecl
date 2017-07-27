import ut;
export QA_Records :=
function

	dCA_Sales_Tax_BDID			 := govdata.File_CA_Sales_Tax_BDID			(bdid != 0, start_date			 != '', (unsigned6)start_date			 	<= (unsigned6)ut.GetDate );
	dCA_Sales_Tax_LinkIDS 	 := govdata.File_CA_Sales_Tax_BDID			((dotid<>0 OR	empid<>0 OR	powid<>0 OR	proxid<>0 OR seleid<>0 OR	orgid<>0 OR	ultid<>0), start_date	!= '', (unsigned6)start_date <= (unsigned6)ut.GetDate );		
	dIA_SalesTax_Base				 := govdata.File_IA_SalesTax_Base				(bdid != 0, issue_date			 != '', (unsigned6)issue_date			 	<= (unsigned6)ut.GetDate);
	dFDIC_BDID							 := govdata.File_FDIC_BDID							(bdid != 0, process_date		 != '', (unsigned6)process_date		 	<= (unsigned6)ut.GetDate);
	dfl_fbn_base						 := govdata.file_fl_fbn_base						(bdid != 0, fic_fil_date		 != '', (unsigned6)fic_fil_date		 	<= (unsigned6)ut.GetDate);
	dFL_NonProfit_Corp			 := govdata.File_FL_NonProfit_Corp			(bdid != 0, process_date		 != '', (unsigned6)process_date		 	<= (unsigned6)ut.GetDate);
	dGov_Phones_Base				 := govdata.File_Gov_Phones_Base				(bdid != 0, record_date			 != '', (unsigned6)record_date			<= (unsigned6)ut.GetDate);
	dIRS_NonProfit_Base			 := govdata.File_IRS_NonProfit_Base			(bdid != 0, Process_Date		 != '', (unsigned6)Process_Date		 	<= (unsigned6)ut.GetDate);
	dMS_Workers_Comp_BDID		 := govdata.File_MS_Workers_Comp_BDID		(bdid != 0, date_last_seen	 != '', (unsigned6)date_last_seen	 	<= (unsigned6)ut.GetDate);
	dOR_Workers_Comp_BDID		 := govdata.File_OR_Workers_Comp_BDID		(bdid != 0, date_last_seen	 != '', (unsigned6)date_last_seen	 	<= (unsigned6)ut.GetDate);
	dSEC_Broker_Dealer_BDID	 := govdata.File_SEC_Broker_Dealer_BDID	(bdid != 0, dt_last_reported != '', (unsigned6)dt_last_reported <= (unsigned6)ut.GetDate);
                                                                                                             
	dCA_Sales_Tax_BDID_sample 				:= topn(dCA_Sales_Tax_BDID			, 200, -start_date			);
	dCA_Sales_Tax_BDID_LinkIDS_sample	:= topn(dCA_Sales_Tax_LinkIDS		, 200, -start_date			);	
	dIA_SalesTax_Base_sample 					:= topn(dIA_SalesTax_Base				, 200, -issue_date			);
	dFDIC_BDID_sample 								:= topn(dFDIC_BDID							, 200, -process_date		);
	dfl_fbn_base_sample								:= topn(dfl_fbn_base						, 200, -fic_fil_date		);
	dFL_NonProfit_Corp_sample					:= topn(dFL_NonProfit_Corp			, 200, -process_date		);
	dGov_Phones_Base_sample						:= topn(dGov_Phones_Base				, 200, -record_date			);
	dIRS_NonProfit_Base_sample				:= topn(dIRS_NonProfit_Base			, 200, -Process_Date		);
	dMS_Workers_Comp_BDID_sample			:= topn(dMS_Workers_Comp_BDID		, 200, -date_last_seen	);
	dOR_Workers_Comp_BDID_sample			:= topn(dOR_Workers_Comp_BDID		, 200, -date_last_seen	);
	dSEC_Broker_Dealer_BDID_sample		:= topn(dSEC_Broker_Dealer_BDID	, 200, -dt_last_reported);
                                
	return 
	parallel(
		 output(dCA_Sales_Tax_BDID_sample 						, named('CASalesTaxSampleNewRecordsForQA'						))
		,output(dCA_Sales_Tax_BDID_LinkIDS_sample 		, named('CASalesTaxSampleNewLinkIDRecordsForQA'			))		 
		,output(dIA_SalesTax_Base_sample 							, named('IASalesTaxSampleNewRecordsForQA'						))
		,output(dFDIC_BDID_sample 										, named('FDICSampleNewRecordsForQA'									))
		,output(dfl_fbn_base_sample										, named('FLFBNSampleNewRecordsForQA'								))
		,output(dFL_NonProfit_Corp_sample							, named('FlNonProfitSampleNewRecordsForQA'					))
		,output(dGov_Phones_Base_sample								, named('GovPhonesSampleNewRecordsForQA'						))
		,output(dIRS_NonProfit_Base_sample						, named('IRSNonProfitSampleNewRecordsForQA'					))
		,output(dMS_Workers_Comp_BDID_sample					, named('MsWorkersCompSampleNewRecordsForQA'				))
		,output(dOR_Workers_Comp_BDID_sample					, named('ORWorkersCompSampleNewRecordsForQA'				))
		,output(dSEC_Broker_Dealer_BDID_sample				, named('SECBrokerDealerSampleNewRecordsForQA'			))
	);        

end;