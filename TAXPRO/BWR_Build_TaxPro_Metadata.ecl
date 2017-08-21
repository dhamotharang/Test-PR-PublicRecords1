

















// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import TAXPRO;
import text_search;

export BWR_Build_TaxPro_Metadata(string filename) := 

function

// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400::BASE', 'TAXPRO', filename);


						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
keyType := Text_search.Types.SegmentType.ExternalKey;

/// add stuff


segmentMetaData := DATASET([
		{'NAME',					textType,		[1]},
		{'ENROLL-YEAR',				textType,		[2]},
		{'ADDRESS',					TextType,		[3]},
				{'EXTERNALKEY',       keyType, [250]}
		//{'CITY',					textType,		[4]},
		//{'STATE',					textType,		[5]},
		//{'ZIP',						textType,		[6]},
		//{'PROVINCE',				textType,		[7]},
		//{'COUNTRY',					textType,		[8]}
			

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