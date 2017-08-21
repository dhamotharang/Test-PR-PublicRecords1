// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import Oshair;
import text_search;
// May need to change high level

export bwr_build_segment_metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'oshair', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;

segmentMetaData := DATASET([
         {'prev-act-type',  TextType,       [1]},
        {'prev-activity-no',       TextType,       [2]},
        {'activity-no',  TextType,       [3]},
        {'reporting-office-id', TextType,       [4]},
         {'inspector',   TextType,       [5]},
        {'company-name',        TextType,       [6]},
				{'address',        TextType,       [7]},
				//{'state-address',        TextType,       [8]},
				//{'zip-address',        TextType,       [9]},
				//{'city-address',        TextType,       [10]},
				{'county',        TextType,       [11]},
				{'duns-no',        TextType,       [12]},
				{'establishment-id',        TextType,       [13]},
				{'owner-type',        TextType,       [14]},
				{'agency',        TextType,       [15]},
				{'adv-notice-indc',        TextType,       [16]},
				{'open-inspect-dt',        DateType,       [17]},
				{'close-inspect-dt',        DateType,       [18]},
				{'inspect-category',        TextType,       [19]},
				{'sic',        TextType,       [20]},
				{'naics',        TextType,       [21]},
				{'inspect-type',        TextType,       [22]},
				{'scope',        TextType,       [23]},
				{'case-close-dt',        DateType,       [24]},
				{'victim-name',        TextType,       [25]},
				{'gender',        TextType,       [26]},
				{'agency',        TextType,       [27]},
				{'injury-degree',        TextType,       [28]},
				{'injury-nature',        TextType,       [29]},
				{'event-type',        TextType,       [30]},
				{'name',	ConcatSeg, [6,25]},
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