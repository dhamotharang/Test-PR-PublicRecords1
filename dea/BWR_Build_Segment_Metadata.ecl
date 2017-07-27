// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import DEA;
import text_search;
// May need to change high level

export bwr_build_segment_metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'dea', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;


segmentMetaData := DATASET([
         {'license-number',  TextType,       [1]},
        {'bus-activity',       TextType,       [2]},
        {'drug-schedules',  TextType,       [3]},
        {'expiration-date', TextType,       [4]},
         {'address',   TextType,       [5]},
        {'person-name',        TextType,       [6]},
				{'company-name',        TextType,       [7]}
				
				
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