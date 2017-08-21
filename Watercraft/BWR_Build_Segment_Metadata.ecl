// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import watercraft;
import text_search;
// May need to change high level

export BWR_Build_Segment_Metadata(string filedate) := function


info := text_search.FileName_Info_Instance('~THOR_DATA400', 'WATERCRAFT', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;
ssnType := Text_search.Types.SegmentType.SSN;

segmentMetaData := DATASET([
		{'registrant',											textType,		[1]},
		{'dob',										DateType,		[2]},
		{'ssn',								ssnType,		[3]},
		{'fein',								textType,		[4]},
		{'gender',												textType,		[5]},
		{'registrant-address',						textType,		[6]},
		//{'registrant-city',					textType,		[7]},
		//{'registrant-state',									textType,		[8]},
		//{'registrant-zip',							textType,		[9]},
		{'telephone',										textType,		[10]},
		{'reg-state',										textType,		[11]},
		{'reg-no',			textType,		[12]},
		{'reg-issue-date', 			DateType,		[13]},
		{'reg-expire-date',			DateType,		[14]},
		{'status',												textType,		[15]},
		{'status-date',		DateType,		[16]},
		{'renewal-date',		DateType,		[17]},
		{'decal-number',									textType,		[18]},
		{'prev-plate-st',			textType,		[19]},
		{'hull-id', 									textType,		[20]},
		{'vessel-id',										textType,		[21]},
		{'vessel-db-key',										textType,		[22]},
		{'party-id-no',											textType,		[23]},
		{'imo-no',											textType,		[24]},
		{'callsign',											textType,		[25]},
		{'prop',											textType,		[26]},
		{'vessel-type',												textType,		[27]},
		{'fuel',										textType,		[28]},
		{'hull-type',										textType,		[29]},
		{'use',										textType,		[30]},
		{'vessel-year',											textType,		[31]},
		{'vessel-name',											textType,		[32]},
		{'class',											textType,		[33]},
		{'make',											textType,		[34]},
		{'model',												textType,		[35]},
		{'length',								textType,		[36]},
		{'width',		textType,		[37]},
		{'weight',											textType,		[38]},
		{'color',			textType,		[39]},
		{'toilet',												textType,		[40]},
		{'cgi-number',					textType,		[41]},
		{'purchase-state',											textType,		[42]},
		{'purchase-date',						DateType,		[43]},
		{'dealer',												textType,		[44]},
		{'purchase-price',										textType,		[45]},
		{'reg-gross-tons',												textType,		[46]},
		{'reg-net-tons',										textType,		[47]},
		{'reg-breadth',															textType,		[48]},
		{'reg-depth',										textType,		[49]},
		{'itc-gross-tons',														textType,		[50]},
		{'itc-net-tons',											textType,		[51]},
		{'itc-length',			textType,		[52]},
		{'itc-breadth',											textType,		[53]},
		{'itc-depth',													textType,		[54]},
		{'hailing-port',				textType,		[55]},
		{'home-port',											textType,		[56]},
		{'vessel-comp-place',													textType,		[57]},
		{'vessel-build-place',													textType,		[58]},
		{'hp-astern',														textType,		[59]},
		{'hp-ahead',															textType,		[60]},
		{'fleet-id',															textType,		[61]},
		{'engine-hp',															textType,		[62]},
		{'engine-number',															textType,		[63]},
		{'engine-make',															textType,		[64]},
		{'engine-model',															textType,		[65]},
		{'engine-year',															textType,		[66]},
		{'transaction-type',																textType,		[67]},
		{'title-state',																textType,		[68]},
		// dates
		{'title-status',									textType,		[69]},
		{'title-no',			textType,		[70]},
		{'title-date',					DateType,		[71]},
		{'title-type',					textType,		[72]},
		{'signatory',									textType,		[73]},
		{'lienholder',												textType,		[74]},
		{'lien-date',												dateType,		[75]},
		{'lienholder-address',											textType,		[76]},
		//{'city',										textType,		[77]},
		//{'state',										textType,		[78]},
		//{'zip',				textType,		[79]},
		{'name',				concatSeg,	[1,74]},
		{'date',				groupType,	[2,13,14,16,71,75]},
		{'address',				concatSeg,	[6,76]},
		{'EXTERNALKEY',       keyType, [250]}
		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := if (fileservices.fileexists(lfilename),
								output('Metadata file '+lfilename+' already exists'),
								sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										)
							);
return retval;

end;