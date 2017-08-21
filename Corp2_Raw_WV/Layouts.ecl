EXPORT Layouts := module

	export AddressesLayoutIn := record

		string 		record_did1;
		string 		ContactType;
		string 		ContactName;
		string 		Street1;
		string 		Street2;
		string 		City;
		string 		StateProvince;
		string 		Country;
		string 		ZipCode;

	end;

	export AddressesLayoutBase := record

		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		AddressesLayoutIn;

	end;

	export amendmentsLayoutIn := record

		string 		Record_did1;
		string 		Amendment;
		string 		AmendmentDate;

	end;

	export amendmentsLayoutBase := record

		STRING1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		amendmentsLayoutIn;

	end;

	export annualreportsLayoutIn := record

		string 		record_did;
		string 		HistoryNumber;
		string 		DateFiled;
		string 		FilingFor;

	end;

	export annualreportsLayoutBase := record

		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		annualreportsLayoutIn;

	end;

	export corporationsLayoutIn := record

		string 		record_did;
		string 		Name;
		string 		EffectiveDate;
		string 		FilingDate;
		string 		BusinessType;
		string 		CharterType;
		string 		CharterStateProvince;
		string 		CharterCounty;
		string 		BusinessClass;
		string 		TerminationDate;
		string 		TerminationReason;
		string 		TerminationEntryDate;
		string 		TotalAuthorizedShares;
		string 		ParValue;

	end;

	export corporationsLayoutBase := record

		string1		 action_flag;
		unsigned4	 dt_first_received;
		unsigned4	 dt_last_received;			
		corporationsLayoutIn;

	end;

	export  DissolutionsLayoutIn := record

		string 		record_did1;
		string 		HistoryNumber;
		string 		ActionPending;
		string 		StOfIntentDate;
		string 		ApprovalReqDate;
		string 		ESApprovalDate;
		string 		WCApprovalDate;
		string 		TaxApprovalDate;
		string 		ArtDissolutionDate;

	end;

	export  DissolutionsLayoutBase := record

		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		DissolutionsLayoutIn;

	end;

	export dbasLayoutIn := record

		string 		record_did;
		string 		DBAName;
		string 		DBAType;
		string 		EffectiveDate;
		string 		TerminationDate;

	end;

	export dbasLayoutBase := record

		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received; 
		dbasLayoutIn;

	end;

	export mergersLayoutIn := record

		string 		SurvivingCorpID;
		string 		SurvivingCorpName;
		string 		SurvivingCorpState;
		string 		MergerDate;
		string 		MergingCorpID;
		string 		MergingCorpName;
		string 		MergingCorpSt;

	end;

	export mergersLayoutBase := record

		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		mergersLayoutIn;

	end;

	export namechangesLayoutIn := record
	
		string 		record_did;
		string 		OldName;
		string 		ChangeDate;

	end;

	export namechangesLayoutBase := record

		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received; 
		namechangesLayoutIn;

	end;

	export subsidiariesLayoutIn := record

		string 		record_did;
		string 		SubsidiaryName;
		string 		Street1;
		string 		Street2;
		string 		City;
		string 		StateProvince;
		string 		ZipCode;

	end;

	export subsidiariesLayoutBase := record

		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received; 
		subsidiariesLayoutIn;

	end;

	export Temp_corp_Addr:=record	

		AddressesLayoutIn;
		corporationsLayoutIn;

	end;

	export Temp_corp_amend :=record

		corporationsLayoutIn;
		amendmentsLayoutIn;

	end;

	export Temp_corp_Dissolutions :=record

		corporationsLayoutIn;
		dissolutionsLayoutIn

	end;

	export Temp_corp_mergers :=record

		corporationsLayoutIn;
		mergersLayoutIn;

	end;	

	export slim_NormMerger_lay:=record

		string  Corp_Merger_Name	;
		string  Corp_Survivor_Corporation_ID ;
		string  corp_merged_corporation_id ;
		string  Corp_Merger_Indicator;
		string 	Corp_Merger_Date;

	end;
	
	export dbas_TempLay := record
		dbasLayoutIn;
		corporationsLayoutIn.CharterType;
		corporationsLayoutIn.FilingDate;
	end;
	
	export namechanges_TempLay := record
		namechangesLayoutIn;
		corporationsLayoutIn.CharterType;
		corporationsLayoutIn.FilingDate;
	end;
	
	export subsidiaries_TempLay := record
		subsidiariesLayoutIn;
		corporationsLayoutIn.CharterType;
		corporationsLayoutIn.FilingDate;
	end;
	
end;