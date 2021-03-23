import dx_PhonesInfo, PhonesInfo, Ut;

EXPORT File_LIDB := module

	EXPORT Send_File_Path		  									:= '~thor_data400::out::phones::lidb_send';
	
	//Not Deduped - All Records
	EXPORT Send_History 												:= dataset(Send_File_Path+'_history', PhonesInfo.Layout_Common.lidbSendHistory,THOR);

	//Deduped by Phone & Sent to AT&T
	EXPORT Send	 																:= dataset(Send_File_Path, PhonesInfo.Layout_Common.lidbSend, CSV(HEADING(0), TERMINATOR('\n'), SEPARATOR('\t')));

	//Return Files from AT&T
	EXPORT Response_Received 										:= dataset('~thor_data400::in::phones::lidb_response', 		PhonesInfo.Layout_Common.lidbRespRecvd, csv(heading(0), terminator('\n'), separator('\t')));
	EXPORT Response_Processed										:= dataset('~thor_data400::base::phones::lidb_reference', PhonesInfo.Layout_Common.lidbRespProcess, flat);

	//Reformat w/ Appended Carrier Info
	EXPORT Response_Processed_CR_Append_PType 	:= dataset('~thor_data400::base::phones::lidb_reference_cr_append_ptype', dx_PhonesInfo.Layouts.Phones_Type_Main, flat);							//DF-26977

end;