import PublicRecords_KEL, Header_Quick;

EXPORT Person_Quick_Header_LexID(DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC(PublicRecords_KEL.Interface_Options).Layout_FDC) shell, 
													PublicRecords_KEL.Interface_Options Options, 
													PublicRecords_KEL.CFG_Compile CFG_file
													) := function;
	
	NotRegulated := PublicRecords_KEL.ECL_Functions.Constants.NotRegulated;
	SetDPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue;
	Layouts_FDC  := PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options);
	Header_Quick__Key_Did := IF(Options.IsFCRA, Header_Quick.Key_Did_FCRA, Header_Quick.Key_Did);

Quick_Header_data := 
		JOIN(shell, Header_Quick__Key_Did,
				PublicRecords_KEL.ECL_Functions.Common(Options).DoFDCJoin_Doxie__Key_Header = TRUE AND //we would never run QH without running header
				LEFT.P_LexID > 0 AND
				KEYED(LEFT.P_LexID = (UNSIGNED)RIGHT.did),
				TRANSFORM(Layouts_FDC.Layout_Header_Quick__Key_Did,//for corrections we need to start out with the same layout as header.
					SELF.UIDAppend := LEFT.UIDAppend,
					SELF.G_ProcUID := LEFT.G_ProcUID,
					SELF.P_LexID := LEFT.P_LexID,
					SELF.HeaderRec := FALSE,
					SELF := RIGHT,
					SELF := LEFT,
					SELF := []), 
				ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT));

return Quick_Header_data;
end;												