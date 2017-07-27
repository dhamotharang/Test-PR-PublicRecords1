


// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import SANCTN;
import text_search;

export BWR_Build_Sanc_Metadata(string filename) := 

function

// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400::BASE', 'SANCTN', filename);


						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;




segmentMetaData := DATASET([
		{'NAME',					textType,		[1]},
		{'RESTITUTION',				textType,		[2]},
		{'NUMBER',					textType,		[3]},
		{'DATE',					textType,		[4]},
		{'JURISDICTION',			textType,		[5]},
		{'SOURCE',					textType,		[6]},
		{'AGENCY',					textType,		[7]},
		{'ALLEGED-AMT',				textType,		[8]},
		{'EST-LOSS',				textType,		[9]},
		{'INCIDENT_TEXT',		 	textType,		[10]}

		
		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfilename := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := sequential(
					OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
					Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
					);

return retval;

end;