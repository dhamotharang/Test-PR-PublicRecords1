EXPORT File_Metadata_Delta_Temp := MODULE

	EXPORT In_Port_DailyDelta 				:= dataset('~thor_data400::in::phones::telo_dailydelta', PhonesInfo.Layout_Port.Daily, csv(terminator('\n'), separator(',')));
	
	keyLayout := record
			string10 phone;
			PhonesInfo.Layout_Common.portedMetadata_Main-phone;
			unsigned8 __internal_fpos__;
		end;

	EXPORT PortedMetadata_DeltaMain		:= dataset('~thor_data400::base::phones::ported_metadata_deltamain', keyLayout, csv(heading(1), terminator('\n'), separator('\t')));		
	
END;