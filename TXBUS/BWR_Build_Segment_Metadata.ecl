// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import Txbus;
import text_search;
// May need to change high level

export bwr_build_segment_metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'txbus', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;


segmentMetaData := DATASET([
         {'taxpayer-name',  TextType,       [1]},
        {'mailing-address',       TextType,       [2]},
        {'city-mailing-address',  TextType,       [3]},
        {'state-mailing-address', TextType,       [4]},
         {'zip-mailing-address',   TextType,       [5]},
        //{'country-mailing-address',        TextType,       [7]},
				{'telephone',       TextType,       [6]},
        {'type',		TextType,		[7]},
				{'taxpayer-number',	TextType,	[8]},
				{'company-name',	texttype, [9]},
				{'business-address',	texttype,	[10]},
				{'city-business-address',	texttype, [11]},
				{'state-business-address', texttype, [12]},
				{'zip-business-address', texttype, [13]},
				{'scis', texttype, [14]},
				{'permit-issue-date', texttype, [15]},
				{'first-sale-date', texttype, [16]},
				{'outlet-number', texttype, [17]},
				{'name', ConcatSeg, [1,9]},
				{'address', ConcatSeg, [2,10]},
				{'number', ConcatSeg, [8,17]},
				{'date', ConcatSeg, [15,16]}
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