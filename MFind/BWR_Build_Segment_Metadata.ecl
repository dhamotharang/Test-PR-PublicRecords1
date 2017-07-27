// export BWR_Build_Segment_Metadata := 'todo';


//export BWR_Build_Segment_Metadata := 'todo';

// just pasted in   needs to be changed



//export BWR_Build_Segment_Metadata := 'todo';

// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import MFIND;
import text_search;
// May need to change high level

export bwr_build_segment_metadata(string filedate) := function


info := text_search.FileName_Info_Instance('~THOR_DATA400', 'MFIND', filedate);


						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;




segmentMetaData := DATASET([
		{'LAST_NAME',					textType,		[1]},
		{'FIRST_NAME',					textType,		[2]},
		{'MIDDLE_NAME',					textType,		[3]},
		{'SUFFIX',						textType,		[4]},
		{'SEX',							textType,		[5]},
		{'LEGAL_RESIDENCE',				textType,		[6]},
		{'MILITARY_SERVICE_BRANCH',		textType,		[7]},
		{'DATE_OF_RETIREMENT',			textType,		[8]},
		{'YEARS_OF_SERVICE',		 	textType,		[9]},
		{'name',						textType,		[10]}


		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := sequential(
					OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
					Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
					);

return retval;

end;