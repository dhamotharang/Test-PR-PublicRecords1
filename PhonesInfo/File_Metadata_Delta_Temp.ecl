EXPORT File_Metadata_Delta_Temp := MODULE

	EXPORT In_Port_DailyDelta 				:= dataset('~thor_data400::in::phones::telo_dailydelta', PhonesInfo.Layout_Port.Daily, csv(terminator('\n'), separator(',')));
	
END;