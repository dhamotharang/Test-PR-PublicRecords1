import data_services;
EXPORT Superfile_List := module

	export in_old    := '~nac::in::consortium_old_layout';
	export in        := '~nac::in::consortium';
	export in_history := '~nac::in::consortium_history';
	export Base      := '~nac::base::consortium';
	export Base_prev := '~nac::base::consortium_father';
	export Collisions  := data_services.foreign_prod + 'nac::out::collisions';
	//export Collisions  := '~nac::poc::collisions';
	//export temp      := '~nac::in::'+st+'::temp';
	export rejectedFiles  := '~nac::in::rejected';
	export Flag      := '~thor_data400::out::NAC_NewHeader_flag';
	
	// for NCF2
	export sfContactRecords := '~nac::in::statecontacts';
	export sfExceptionRecords := '~nac::in::exceptions';
	export sfAddressRecords := '~nac::in::addresses';
	export sfCaseRecords := '~nac::in::cases';
	export sfClientRecords := '~nac::in::clients';
	
	export sfNCF2 := '~nac::in::ncf2';
	export sfPayload := '~nac::out::payload';
	export sfBase2 := '~nac::out::base2';
	export sfBase1 := '~nac::in::base1';
	export sfCollisions := '~nac::out::collisions2';
	export sfNewCollisions := '~nac::out::newcollisions2';
	
/*
		new base file sequence: ready, processing, processed, father, delete
*/
	export sfReady := '~nac::out::ready';			// New Base2 file prepped for ingest
	export sfProcessing := '~nac::out::processing';			// New Base2 file being processed for ingest
	export sfProcesed := '~nac::out::processed';			// New Base2 file archived after ingest
	
	//export 
	
end;