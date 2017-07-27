import text_search;
import LN_PropertyV2;

export BWR_Build_Segment_Assess_Metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'ln_propertyv2::assessment', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;


segmentMetaData := DATASET([
         {'state',  TextType,       [1]},
        {'county',       TextType,       [2]},
        {'apn',  TextType,       [3]},
        {'cert-date', TextType,       [4]},
         {'owners',   TextType,       [5]},
        {'phone-number',        TextType,       [6]},
				{'mailing-address',        TextType,       [7]},
				{'property-address',       TextType,       [8]},
        {'lot-desc',		TextType,		[9]},
				{'lot-number',	DateType,	[10]},
				{'land-lot',	texttype, [11]},
				{'block',	texttype,	[12]},
				{'section',	texttype, [13]},
				{'district', texttype, [14]},
				{'unit', texttype, [15]},
				{'subdivision', Texttype, [16]},
				{'phase', Texttype, [17]},
				{'tract', Texttype, [18]},
				{'brief-legal', Texttype, [19]},
				{'ownership-type', Texttype, [20]},
				{'land-use', Texttype, [21]},
				{'zoning', Texttype, [22]},
				{'owner-occupied', Texttype, [23]},
				{'number', Texttype, [24]},
				{'book/page', Texttype, [25]},
				{'transfer-date', Texttype, [26]},
				{'recorded-date', Texttype, [27]},
				{'deed-type', Texttype, [28]},
				{'sale-date', Texttype, [29]},
				{'sale-price', Texttype, [30]},
				{'loan-amount', Texttype, [31]},
				{'loan-type', Texttype, [32]},
				{'lender', Texttype, [33]},
				{'lender-type', Texttype, [34]},
				{'land-value', Texttype, [35]},
				{'asses-imp-value', Texttype, [36]},
				{'total-value', Texttype, [37]},
				{'year-assess', Texttype, [38]},
				{'mar-land-value', Texttype, [39]},
				{'tot-imp-value', Texttype, [40]},
				{'tot-mar-value', Texttype, [41]},
				{'mar-year-access', Texttype, [42]},
				{'homeowner-exempt', Texttype, [43]},
				{'exemption', Texttype, [44]},
				{'tax-rate', Texttype, [45]},
				{'tax-amount', Texttype, [46]},
				{'tax-year', Texttype, [47]},
				{'year-built', Texttype, [48]},
				{'effect-year-built', Texttype, [49]},
				{'neighbour-desc', Texttype, [50]},
				{'condo-proj-name', Texttype, [51]},
				{'building-name', Texttype, [52]},
				{'date', ConcatSeg, [4,29]},
				{'name', ConcatSeg, [5]},
				{'address', ConcatSeg, [7,8]},
				{'legal-desc', ConcatSeg, [9,10,11,12,13,14,15,16,17,18,19]},
				{'characteristics', ConcatSeg, [43,48,49,50,51,52]}
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