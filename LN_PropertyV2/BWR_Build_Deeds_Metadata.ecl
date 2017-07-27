import text_search;
import LN_PropertyV2;

export BWR_Build_Deeds_Metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'ln_propertyv2::deeds', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;


segmentMetaData := DATASET([
         {'state',  TextType,       [1]},
        {'county-trans-tax',       TextType,       [2]},
        {'apn',  TextType,       [3]},
        {'buyer', TextType,       [4]},
         {'borrower',   TextType,       [5]},
        {'seller',        TextType,       [6]},
				{'lender',        TextType,       [7]},
				{'phone-number',       TextType,       [8]},
        {'buyer-address',		TextType,		[9]},
				{'borrower-address',	DateType,	[10]},
				{'seller-address',	texttype, [11]},
				{'property-address',	texttype,	[12]},
				{'lender-address',	texttype, [13]},
				{'lot-desc', texttype, [14]},
				{'lot-number', texttype, [15]},
				{'block', Texttype, [16]},
				{'section', Texttype, [17]},
				{'land-lot', Texttype, [18]},
				{'unit', Texttype, [19]},
				{'subdivision', Texttype, [20]},
				{'phase', Texttype, [21]},
				{'tract', Texttype, [22]},
				{'brief-legal', Texttype, [23]},
				{'contract-date', Texttype, [24]},
				{'recorded-date', Texttype, [25]},
				{'number', Texttype, [26]},
				{'mortgage-type', Texttype, [27]},
				{'loan-number', Texttype, [28]},
				{'book/page', Texttype, [29]},
				{'condo-desc', Texttype, [30]},
				{'condo-name', Texttype, [31]},
				{'sale-price', Texttype, [32]},
				{'sale-price-desc', Texttype, [33]},
				{'city-trans-tax', Texttype, [34]},
				{'district', Texttype, [35]},
				{'total-trans-tax', Texttype, [36]},
				{'excise-trans-number', Texttype, [37]},
				{'land-use', Texttype, [38]},
				{'property-use', Texttype, [39]},
				{'timeshare', Texttype, [40]},
				{'rate-change', Texttype, [41]},
				{'change-index', Texttype, [42]},
				{'adj-index', Texttype, [43]},
				{'rider', Texttype, [44]},
				{'loan-amt', Texttype, [45]},
				{'second-loan-amt', Texttype, [46]},
				{'lender-type', Texttype, [47]},
				{'loan-type', Texttype, [48]},
				{'type-finance', Texttype, [49]},
				{'rate', Texttype, [50]},
				{'due-date', Texttype, [51]},
				{'title-company', Texttype, [52]},
				{'interest-trans', Texttype, [53]},
				{'term', Texttype, [54]},
				{'county-trans-tax',texttype,[55]},
				{'mortgage-date',texttype,[56]},
				{'terms', Texttype,[57]},
				
				{'name', ConcatSeg, [4,5,6,7]},
				{'address', ConcatSeg, [9,10,11,12,13]},
				{'legal-desc', ConcatSeg, [14,15,16,17,35,18,19,20,21,22]},
				{'mortgage', ConcatSeg, [27,48,49]}
				
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