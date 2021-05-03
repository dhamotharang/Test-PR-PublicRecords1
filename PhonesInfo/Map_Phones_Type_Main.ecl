IMPORT _control, MDR, DeltabaseGateway, dx_PhonesInfo, Lib_date, Std, Ut;

//DF-24397: Create Dx-Prefixed Keys
//DF-26977: Remove LIDB Carrier Info Append Process (LIDB is historical)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Map Phone Base Files to Phone Type Layout - Append Serv/Line/Carrier Names from Carrier Reference Table///////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	dsICPort					:= PhonesInfo.File_iConectiv.Main(transaction_code<>'PD');																																													//Source = PK; iConectiv/Teo Ported Phone Base File
	dsICPortVal				:= project(PhonesInfo.File_iConectiv.Main_PortData_Valid(transaction_code<>'PD'), dx_PhonesInfo.Layouts.Phones_Transaction_Main);													//Source = P!; iConectiv PortDataValidate Phone Base File	
	srcLidb						:= PhonesInfo.File_LIDB.Response_Processed_CR_Append_PType;																																													//Historical LIDB File w/ Carrier Reference Info Appended			
	srcLidbDelt				:= DeltabaseGateway.File_Deltabase_Gateway.Historic_LIDB_Results_CR_Append_PType;																																		//Historical LIDB Gateway File w/ Carrier Reference Info Appended						
	dsL6Phones				:= project(PhonesInfo.File_Lerg.Lerg6UpdPhone(account_owner<>'' and serv<>'' and line<>''), dx_PhonesInfo.Layouts.Phones_Type_Main);	
	dsCarrRef					:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE);																																													//Carrier Reference Base File

	//////////////////////////////////////////////	
	//iConectiv Ported Phone File - Join by SPID//
	//////////////////////////////////////////////	
	
	//Append Serv, Line, High Risk Indicator, Prepaid, & Operator Full Name
	icPortApp					:= PhonesInfo._fn_Append_CarrierRef_PortedPhones.Ph_Transact(dsICPort);
	icPortVApp				:= PhonesInfo._fn_Append_CarrierRef_PortedPhones.Ph_Transact(dsICPortVal);
	
	/////////////////////////////////////////////////////////	
	//LIDB File - Join by Account Owner & Carrier Name///////
	/////////////////////////////////////////////////////////
	
	//Concat LIDB Records
	concatLIDB				:= srcLidb + srcLidbDelt;
	
	dx_PhonesInfo.Layouts.Phones_Type_Main fixLIDB(concatLIDB l):= transform
		self.global_sid									:= 0;	//CCPA Requirement
		self.record_sid									:= 0;	//CCPA Requirement
		self														:= l;
	end;
	
	reformatLIDB			:= project(concatLIDB, fixLIDB(left));	
	
	//////////////////////////////////////////////////////////////////////////////////////////	
	//Concat All Records//////////////////////////////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	allFiles					:= icPortApp + icPortVApp + reformatLIDB + dsL6Phones;	
	
	//////////////////////////////////////////////////////////////////////////////////////////	
	//Append Global_SID///////////////////////////////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////	
	
	//Add Global_SID 
  addGlobalSID      := MDR.macGetGlobalSID(allFiles,'PhonesMetadata_Virtual','','global_sid'); //CCPA-799
		
	//////////////////////////////////////////////////////////////////////////////////////////	
	//Append Record_SID///////////////////////////////////////////////////////////////////////	
	//////////////////////////////////////////////////////////////////////////////////////////	
	
	//Add Record_SID to All Records
	dx_PhonesInfo.Layouts.Phones_Type_Main trID(addGlobalSID l):= transform
		self.record_sid := hash64(l.phone + l.source + l.account_owner + l.carrier_name + l.vendor_first_reported_dt + l.vendor_first_reported_time + l.spid + l.operator_fullname + l.serv + l.line + l.high_risk_indicator + l.prepaid + l.reference_id) + (integer)l.phone;	
		//self.serv				:= if(l.serv='', '3', l.serv); //DF-27012
		//self.line				:= if(l.line='', '3', l.line); //DF-27012	
		self 						:= l;
	end;
	
	idAll							:= project(addGlobalSID, trID(left));

EXPORT Map_Phones_Type_Main := idAll;