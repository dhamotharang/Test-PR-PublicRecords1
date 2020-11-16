IMPORT mdr, ut;

	/////////////////////////////////////////////////////////////////////	
	//iConectiv Main/////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////
	
	//Reformat iConectiv PortData Validate Base File to Common Port Layout
	dsPortVal		:= project(PhonesInfo.File_iConectiv.Main_PortData_Validate, PhonesInfo.Layout_iConectiv.Main); //Reformat iConectiv PortData Validate Base File			
	
	//Rollup Port Records and Assign Source Code
	icPort			:= PhonesInfo._fn_Map_Common_PortedPhones(PhonesInfo.File_iConectiv.Main_Current, mdr.sourceTools.src_PhonesPorted_iConectiv); 	//iConectiv + Telo Port (source='PK') - Need to convert spid-to-ocn
	icPortVal		:= PhonesInfo._fn_Map_Common_PortedPhones(dsPortVal, mdr.sourceTools.src_PhonesPorted2_iConectiv);															//iConectiv PortData Validate (source='P!')
	
	//Concat Files//////////////////////////////////////////////////////
	concatComm 	:= icPort + icPortVal;

EXPORT Map_Common_Port_Main := dedup(sort(concatComm, record, local), record, local);