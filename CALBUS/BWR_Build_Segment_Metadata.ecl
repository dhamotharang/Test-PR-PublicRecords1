// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import Calbus, text_search;

// May need to change high level

export bwr_build_segment_metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'calbus', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;

segmentMetaData := DATASET([
		{'company-name',		TextType,       [1]},
        {'business-address',	TextType,       [2]},
        //{'city',				TextType,       [3]},
        //{'state',				TextType,       [4]},
		//{'zip',					TextType,       [5]},
        {'foreign-zip',        TextType,       [6]},
		{'country',        TextType,       [7]},
		{'mailing-address',       TextType,       [8]},
        {'taxpayer-name',		TextType,		[9]},
		{'start-date',	DateType,	[10]},
		{'industry',	texttype, [11]},
		{'tax-code',	texttype,	[12]},
		{'city-code',	texttype, [13]},
		{'district-branch', texttype, [14]},
		{'district', texttype, [15]},
		{'name', ConcatSeg, [1,9]},
		{'address', ConcatSeg, [2,8]},
		{'date', GroupType, [10]},
		{'EXTERNALKEY',       keyType, [250]}
		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfilename := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := if (fileservices.fileexists(lfilename),
								output('Metadata file '+lfilename+' already exists'),
								sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										)
							);

return retval;

end;