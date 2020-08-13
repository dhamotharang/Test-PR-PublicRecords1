import PublicRecords_KEL, dx_header;

EXPORT Person_Header_LexID(DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC(PublicRecords_KEL.Interface_Options).Layout_FDC) shell, 
													PublicRecords_KEL.Interface_Options Options, 
													PublicRecords_KEL.CFG_Compile CFG_file,
													INTEGER iType
													) := function;
	
	NotRegulated := PublicRecords_KEL.ECL_Functions.Constants.NotRegulated;
	SetDPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue;
	Layouts_FDC  := PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options);
	Doxie__Key_Header := dx_header.key_header(iType);

	Header_data :=	JOIN(shell, Doxie__Key_Header,
	PublicRecords_KEL.ECL_Functions.Common(Options).DoFDCJoin_Doxie__Key_Header = TRUE AND
		LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.s_did),
				TRANSFORM(Layouts_FDC.Layout_Doxie__Key_Header,
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.HeaderRec := TRUE,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

return Header_data;
end;												