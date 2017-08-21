// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import fcc;
import text_search;
// May need to change high level

export bwr_build_segment_metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'fcc', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;

segmentMetaData := DATASET([
			{'licensee',			TextType,       [1]},
			{'dba-name',			TextType,       [2]},
			{'current-address',		TextType,       [3]},
			//{'city',				TextType,       [4]},
			//{'state',				TextType,       [5]},
			//{'country-mailing-address',        TextType,       [7]},
			//{'zip',				TextType,       [6]},
			{'telephone',			TextType,		[7]},
			{'contact-address',		TextType,		[8]},
			{'fax',					texttype,		[9]},
			{'callsign',			texttype,		[10]},
			{'license-type',		texttype,		[11]},
			{'filing-number',		texttype,		[12]},
			{'application-date',	datetype,		[13]},
			{'issue-date',			datetype,		[14]},
			{'expiration-date',		datetype,		[15]},
			{'change-date',			datetype,		[16]},
			{'status',				texttype,		[17]},
			{'name',				ConcatSeg,		[1,2]},
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