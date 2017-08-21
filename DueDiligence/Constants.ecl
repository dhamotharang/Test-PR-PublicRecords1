IMPORT MDR;

EXPORT Constants := MODULE


EXPORT VERSION_3 := 3;

EXPORT IND_REQ_ATTRIBUTE_V3 := 'DDAINDV3';
EXPORT BUS_REQ_ATTRIBUTE_V3 := 'DDABUSV3';

EXPORT INDIVIDUAL := 'INDIVIDUAL';
EXPORT BUSINESS := 'BUSINESS';

EXPORT VALID_IND_ATTRIBUTE_VERSIONS := [IND_REQ_ATTRIBUTE_V3];
EXPORT VALID_BUS_ATTRIBUTE_VERSIONS := [BUS_REQ_ATTRIBUTE_V3];

EXPORT INVALID := 'INVALID';

EXPORT VALIDATION_INVALID_INDIVIDUAL := 'Minimum input information not met. Minimum input information is: \n (1)  First Name, Last Name, Street Address, City and State or Zip  OR \n (2)  First Name, Last Name, SSN  OR \n (3)  LexID';
EXPORT VALIDATION_INVALID_BUSINESS := 'Minimum input information not met. Minimum input information is: \n (1)  Business Name, Street Address, City and State or Zip  OR \n (2)  Business Name, Tax ID OR \n (3)  LexID';
EXPORT VALIDATION_INVALID_VERSION := 'Please enter a valid attributes version';
EXPORT VALIDATION_INVALID_GLB := 'Not an allowable GLB permissible purpose';
EXPORT VALIDATION_INVALID_DPPA := 'Not an allowable DPPA permissible purpose';

EXPORT DEFAULT_DPPA := 3;
EXPORT DEFAULT_GLBA := 5;


// NOTE: when calling these macros (mac_ListTop*), you will need to add a "#expand(...)" before the actual
// fully qualified macro name or it will sort/dedup/group on the full string below 
// instead of the field names inside the string.
EXPORT mac_ListTop3Linkids := MACRO
    'UltID, OrgID, SeleID'
ENDMACRO;

EXPORT mac_ListTop4Linkids := MACRO
    'UltID, OrgID, SeleID, ProxID'
ENDMACRO;

EXPORT date8Nines := 99999999;

EXPORT Owned_Property_code := 'OP'; 
EXPORT Sold_Property_code  := 'SP';

EXPORT INQUIRED_BUSINESS_DEGREE := 'IB';
EXPORT INQUIRED_BUSINESS_EXEC_DEGREE := 'IE';
EXPORT LINKED_BUSINESS_DEGREE := 'LB';
EXPORT LINKED_BUSINESS_EXEC_DEGREE := 'LE';
EXPORT RELATED_BUSINESS_DEGREE := 'RB';

EXPORT CORP_STATUS_ACTIVE := 'A';
EXPORT CORP_STATUS_INACTIVE := 'I';
EXPORT CORP_STATUS_DISSOLVED := 'D';
EXPORT CORP_STATUS_REINSTATE := 'R';
EXPORT CORP_STATUS_SUSPEND := 'S';
EXPORT COPR_STATUS_UNKNOWN := 'U';

//Company Types
EXPORT CMPTYP_TRUST := 'TRUST';
EXPORT CMPTYP_PROPRIETORSHIP := 'PROPRIETORSHIP';
EXPORT CMPTYP_ASSUMED_NAME_DBA := 'ASSUMED NAME/DBA';
EXPORT CMPTYP_FOREIGN_LLC := 'FOREIGN LLC';
EXPORT CMPTYP_FOREIGN_CORP := 'FOREIGN CORPORATION';
EXPORT CMPTYP_FOREIGN_CORP_NON_PROFIT := 'FOREIGN CORPORATION-NON FOR PROFIT';
EXPORT CMPTYP_CORP_NON_PROFIT := 'CORPORATION-NON FOR PROFIT';
EXPORT CMPTYP_CORP_BUSINESS := 'CORPORATION-BUSINESS';
EXPORT CMPTYP_PROFESSIONAL_CORP := 'PROFESSIONAL CORPORATION';
EXPORT CMPTYP_PROFESSIONAL_ASSOC := 'PROFESSIONAL ASSOCIATION';
EXPORT CMPTYP_LIMITED_PARTNERSHIP := 'LIMITED PARTNERSHIP';
EXPORT CMPTYP_LIMITED_LIABILITY_CORP := 'LIMITED LIABILITY CORPORATION';
EXPORT CMPTYP_LIMITED_LIABILITY_PARTNERSHIP := 'LIMITED LIABILITY PARTNERSHIP';

EXPORT CREDIT_SOURCES := ['ER', 'Q3', 'DN']; 
EXPORT BUS_SHELL_SOURCES := ['BM', 'Y', 'W', 'GB', 'GG', 'UT'];

EXPORT SOURCE_BUSINESS_HEADER := 'BH';
EXPORT SOURCE_BUSINESS_REGISTRATION := MDR.SourceTools.src_Business_Registration;
EXPORT SOURCE_BUSINESS_CORP := 'CO';
EXPORT SOURCE_OSHA := MDR.SourceTools.src_OSHAIR;
EXPORT SOURCE_DCA := MDR.SourceTools.src_DCA;
EXPORT SOURCE_FICTICIOUS_BUSINESS := MDR.SourceTools.src_FBNV2_BusReg;
EXPORT SOURCE_CAL_BUSINESS := MDR.SourceTools.src_CalBus;
EXPORT SOURCE_YELLOW_PAGES := MDR.SourceTools.src_Yellow_Pages;
EXPORT SOURCE_EBR := MDR.SourceTools.src_EBR;

EXPORT INDUSTRY_CASH_INTENSIVE_BUSINESS := 'CIB';
EXPORT INDUSTRY_MONEY_SERVICE_BUSINESS := 'MSB';
EXPORT INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS := 'NBFI';
EXPORT INDUSTRY_CASINO_AND_GAMING := 'CAG';
EXPORT INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL := 'LEGAL';
EXPORT INDUSTRY_AUTOMOTIVE := 'AUTO';
EXPORT INDUSTRY_OTHER := 'OTHER';

EXPORT RISK_LEVEL_HIGH := 'HIGH';
EXPORT RISK_LEVEL_MEDIUM := 'MEDIUM';
EXPORT RISK_LEVEL_LOW := 'LOW';
EXPORT RISK_LEVEL_UNKNOWN := 'UNKNOWN';


EXPORT NAICS_RISK_HIGH	:=  ['42','44','45','48','49'];
EXPORT NAICS_RISK_MED	 	:=  ['23','31','32','33','52','53','54','56','71','72','81','92'];
EXPORT NAICS_RISK_LOW 	:=  ['11','21','22','51','55','61','62'];

EXPORT NAICS_RISK_HIGH_EXCEP := ['522190', '522220', '522291', '522293' , '522298', '522320', '522390', '523110', '523120', '523130', 
																	'523140', '523210', '523910', '523920', '523991', '523999', '525910', '525990', '531210', '541110', 
																	'541211', '541219', '561422', '561499', '561510', '561599', '561990', '611512', '713210', '721120', 
																	'722310', '722320', '722511', '722513', '722514', '722515', '811192', '812930', '812990', '813211', 
																	'813212', '813312', '813319', '813930', '813940'];

//Cash Intensive Businesses
EXPORT CIB_NAICS  := ['813219', '812990', '812930', '812310', '812113', 
											'812112', '811192', '722212', '722211', '722110', 
											'713990', '713120', '485310', '454210', '453998', 
											'453310', '453220', '453210', '453110', '452998', 
											'452112', '452111', '451220', '451211', '451140', 
											'451130', '451120', '451110', '448210', '448190', 
											'448150', '448120', '447110', '446110', '445310', 
											'445120', '444220', '444210', '444120', '444110', 
											'443120', '443112', '443111', '442299', '442210', 
											'442110', '424940', '423930']; 

//Money Services Businesses											
EXPORT  MSB_NAICS  := ['523130', '522390', '522320', '522291'];

//Non-Bank Finaancial Institutions
EXPORT  NBFI_NAICS := ['522298', '522291', '448310', '423940']; 	       

//Casinos & Gaming
EXPORT CASGAM_NAISC := ['721120', '713290', '713210'];   

//Legal, Accountant, Telemarketer, Flight Training or Travel Agency
EXPORT LEGTRAV_NAISC := ['611512', '561990', '561510', '561422', '541211', 
												 '541110'];   

//Automotive
EXPORT AUTO_NAISC := ['811224', '811121', '811118', '811113', '811111', 
											'441310', '441229', '441228', '441222', '441210', 
											'441120', '441110'];	          



EXPORT SIC_LENGTH_2_RISK_HIGH	:= ['58'];

EXPORT SIC_LENGTH_4_RISK_HIGH	:= ['3111', '3151', '3199', '3911', '4724', 
																	'4725', '4729', '4789', '5094', '5411', 
																	'5499', '5500', '5511', '5521', '5551', 
																	'5561', '5571', '5599', '6081', '6082', 
																	'6211', '6722', '6799', '8111', '8721'];
EXPORT SIC_LENGTH_4_2STAR_RISK_HIGH := ['58']; //length of SIC is 4 but must match on first 2 char																	

EXPORT SIC_LENGTH_6_RISK_HIGH	:= ['315100', '315199', '608100', '608199', '608200', 
																	'608299', '609901', '738914', '799913'];
EXPORT SIC_LENGTH_6_2STAR_RISK_HIGH := ['3111', '3199', '3911', '4724', '4725', 
																				'4729', '4789', '5094', '5411', '5499', 
																				'5511', '5521', '5521', '5551', '5561', 
																				'5571', '5599', '6211', '6722', '6799', 
																				'8111', '8721']; //length of SIC is 6 but must mat on first 4 char	
EXPORT SIC_LENGTH_6_4STAR_RISK_HIGH := ['58']; //length of SIC is 6 but must mat on first 2 char	

EXPORT SIC_LENGTH_8_RISK_HIGH	:= ['31510000', '47310101', '47310102', '47310102', '59329904', 
																	'60810000', '60819901', '60820000', '60990100', '60990101', 
																	'60990102', '60990103', '60999901', '60999902', '60999903', 
																	'60999906', '60999908', '60999908', '70110301', '73891005', 
																	'73891400', '73891402', '79930401', '79930402', '79930403', 
																	'79990803', '79990804', '79991301', '79991302', '79991303', 
																	'79991304', '79991305', '79991306'];
EXPORT SIC_LENGTH_8_2STAR_RISK_HIGH := ['315199']; //length of SIC is 8 but must mat on first 6 char																		
EXPORT SIC_LENGTH_8_4STAR_RISK_HIGH := ['3111', '3199', '3911', '4724', '4725', 
																				'4729', '4789', '5094', '5411', '5499', 
																				'5511', '5551', '5561', '5571', '5599', 
																				'6211', '6722', '6799', '8111', '8721']; //length of SIC is 8 but must mat on first 4 char																		
EXPORT SIC_LENGTH_8_6STAR_RISK_HIGH := ['58']; //length of SIC is 8 but must mat on first 2 char																		

//Cash Intensive Businesses
EXPORT CIB_SIC	  := ['8399', '7993', '7699', '7542', '7521', 
											'7299', '7231', '7215', '5999', '5992', 
											'5962', '5949', '5947', '5945', '5943', 
											'5942', '5941', '5932', '5912', '5736', 
											'5719', '5714', '5713', '5712', '5699', 
											'5661', '5632', '5621', '5611', '5541', 
											'5411', '5311', '5292', '5261', '5231', 
											'5211', '5199', '5194', '5193', '5192', 
											'5191', '5182', '5181', '5162', '5159', 
											'5153', '5139', '5137', '5136', '5131', 
											'5122', '5113', '5112', '5111', '5099', 
											'5093', '5092', '5091', '5085', '5083', 
											'5049', '5044', '5031', '5023', '5021', 
											'4121']; 
											
//Money Services Businesses											
EXPORT  MSB_SIC  	:= ['7389', '6799', '6221', '6162', '6153', 
											'6141', '6099'];		
											
//Non-Bank Finaancial Institutions
EXPORT  NBFI_SIC 	:= ['7631', '6159', '6153', '6141', '6111', 
											'6082', '6081', '6019', '5944', '5932', 
											'5094']; 	

//Casinos & Gaming
EXPORT CASGAM_SIC := ['7999', '7993', '7011'];  

//Legal, Accountant, Telemarketer, Flight Training or Travel Agency
EXPORT LEGTRAV_SIC 	:= ['8721', '8299', '8249', '8111', '7389', 
												'7299', '4724'];

//Automotive
EXPORT AUTO_SIC := ['7539', '7538', '7537', '7532', '5731', 
										'5599', '5571', '5561', '5551', '5531', 
										'5521', '5511', '5015', '5013'];	          											
											
											
 // Vehicle key orig_name_type values
 export string1 VEH_OWNER		 		:= '1';
 export string1 VEH_LESSOR			:= '2';
 export string1 VEH_REGISTRANT 	:= '4';
 export string1 VEH_LESSEE			:= '5';
 export string1 VEH_LIENHOLDER  := '7';
	 
	 
											
											
											
											
											


















//BELOW is currently not being used/called - help to clean/maintain what in our constatnts

EXPORT setHIFCA := [
										// California Northern District	
										'06001','06013','06015','06023','06033','06041','06045','06053',
										'06053','06055','06069','06075','06081','06087','06097',
										// California Southern District
										'06037','06059','06065','06071','06079','06083','06111',
										// Southwest Border - Arizona
										'48043','48047','48061','48105','48109','48127','48131','48137',
										'48141','48215','48229','48243','48247','48261','48271','48283',
										'48323','48311','48371','48377','48389','48427','48435','48443',
										'48463','48465','48479','48489','48505','48507',
										// Arizona
										'04001','04003','04005','04007','04009','04011','04012','04013',
										'04015','04017','04019','04021','04023','04025','04027',
										// Chicago
										'17031','17043','17089','17097','17111','17197',
										// New York
										'36001','36003','36005','36007','36009','36011','36013','36015',
										'36017','36019','36021','36023','36025','36027','36029','36031',
										'36033','36035','36037','36039','36041','36043','36045','36047',
										'36049','36051','36053','36055','36057','36059','36061','36063',
										'36065','36067','36069','36071','36073','36075','36077','36079',
										'36081','36083','36085','36087','36089','36091','36093','36095',
										'36097','36099','36101','36103','36105','36107','36109','36111',
										'36113','36115','36117','36119','36121','36123',
										// New Jersey
										'34001','34003','34005','34007','34009','34011','34013','34015',
										'34017','34019','34021','34023','34025','34027','34029','34031',
										'34033','34035','34037','34039','34041',
										// Puerto Rico
										'72001','72003','72005','72007','72009','72011','72013','72015',
										'72017','72019','72021','72023','72025','72027','72029','72031',
										'72033','72035','72037','72039','72041','72043','72045','72047',
										'72049','72051','72053','72054','72055','72057','72059','72061',
										'72063','72065','72067','72069','72071','72073','72075','72077',
										'72079','72081','72083','72085','72087','72089','72091','72093',
										'72095','72097','72099','72101','72103','72105','72107','72109',
										'72111','72113','72115','72117','72119','72121','72123','72125',
										'72127','72129','72131','72133','72135','72137','72139','72141',
										'72143','72145','72147','72149','72151','72153',
										// US Virgin Islands
										'78010','78020','78030',
										// South Florida - Spread sheet has 'St Lucie' but is actually 'St. Lucie' in our file (with period)
										'12011','12061','12085','12086','12087','12093','12099','12111'
										];	

EXPORT setHIDTA := [
										//Gulf Coast HIDTA Alabama		
										'01003','01073','01089','01097','01101','01103',	
										//SW Border-AZ Region
										'04003','04012','04013','04015','04017','04019','04021','04023',
										'04027',
										//Gulf Coast HIDTA Arkansas',	
										'05007','05069','05119','05143',	
										//Los Angeles HIDTA	
										'06037','06059','06065','06071',	
										//Central Valley California HIDTA	
										'06019','06029','06031','06039','06047','06067','06077','06089',	
										'06099','06107',	
										//Northern California HIDTA	
										'06001','06013','06033','06041','06045','06053','06075','06081',	
										'06085','06087','06097',	
										//SW Border-CA Region	
										'06025','06073',	
										//Rocky Mountain HIDTA Colorado 	
										'08001','08005','08013','08031','08035','08037','08041','08045',	
										'08049','08059','08067','08069','08077','08081','08101','08107',	
										'08123',	
										//New England HIDTA Connecticut 	
										'09001','09003','09009',	
										//Central FL HIDTA 	
										'12057','12095','12097','12103','12105','12117','12127',	
										//North Florida HIDTA 	
										'12001','12003','12019','12023','12031','12035','12083',	
										'12089','12107','12109',	
										//South Florida HIDTA 	
										'12011','12086','12087','12099',	
										//Atlanta HIDTA 	
										'13013','13015','13057','13063','13067','13089','13097','13113',	
										'13117','13121','13135','13151',	
										//Hawaii HIDTA 	
										'15001','15003','15007','15009',	
										//Chicago HIDTA 	
										'17031','17063','17093','17197',	
										//Lake County HIDTA 	
										'18089','18127',	
										//Midwest HIDTA Iowa	
										'19013','19113','19127','19139','19153','19155','19163','19193',	
										//Midwest HIDTA Kansas	
										'20009','20021','20037','20055','20059','20091','20099','20103',	
										'20121','20169','20173','20175','20177','20209',	
										//Appalachia HIDTA 	
										'21001','21013','21025','21051','21053','21057','21071','21095',	
										'21109','21119','21121','21125','21129','21131','21133','21153',	
										'21155','21147','21189','21193','21195','21199','21203','21217',	
										'21227','21231','21235',	
										//Gulf Coast HIDTA 	
										'22015','22017','22019','22033','22051','22055','22071','22073',	
										//New England HIDTA Maine	
										'23005',	
										//Wash/Baltimore HIDTA  *** The spread sheet has Prince Georges as a county name (notice the end quote).  Needed to be changed to regular single quote to work.  	
										'24003','24005','24510','24017','24025','24027','24031','24033',	
										//New England HIDTA Massachusetts	
										'25009','25013','25017','25023','25025','25027',	
										//Michigan HIDTA 	
										'26005','26049','26077','26081','26099','26125','26145','26159',	
										'26161','26163',	
										//Gulf Coast HIDTA Mississippi	
										'28045','28047','28049','28059','28071','28089','28121',	
										//Midwest HIDTA Missouri	
										'29019','29021','29031','29043','29047','29051','29071','29077',	
										'29095','29097','29099','29127','29165','29201','29183','29189',	
										'29510','29215',	
										//Rocky Mountain HIDTA Montana	
										'30013','30029','30049','30063','30111',	
										//Midwest HIDTA Nebraska   ***Spread sheet has 'Scott's Bluff' but is actually 'Scotts Bluff' in our data',	
										'31043','31047','31053','31055','31067','31079','31095','31109',	
										'31119','31141','31153','31157',	
										//Nevada HIDTA
										'32003','32031',	
										//New England HIDTA New Hampshire	
										'33011',	
										//NY/NJ HIDTA New Jersey	
										'34003','34013','34017','34021','34023','34031','34039',	
										//Philly/Camden HIDTA New Jersey	
										'34007',	
										//SW Border-NM Region 	
										'35001','35005','35013','35015','35017','35023','35025','35027',
										'35029','35035','35039','35045','35045','35049','35057','35061',	
										//NY/NJ HIDTA New York	
										'36001','36005','36019','36029','36033','36045','36047','36055',	
										'36059','36059','36067','36071','36081','36085','36089','36103',	
										'36119',	
										//Atlanta HIDTA North Carolina	
										'37001','37021','37063','37071','37081','37089','37101','37111',	
										'37119','37151','37179','37183','37191','37195',	
										//Midwest HIDTA North Dakota	
										'38015','38017','38035','38059','38071','38077','38099','38101',	
										//Ohio HIDTA	
										'39035','39045','39049','39057','39061','39095','39099','39113',	
										'39151','39153','39165',	
										//North Texas HIDTA Oklahoma	
										'40027','40031','40101','40109','40135','40143',	
										//Oregon HIDTA  ***Warm Springs Reservation is not a valid county in our Fips2County file, nor is it listed in Wikipedia's list of counties for Oregon. Is the spread sheet incorrect?',	
										'41005','41017','41019','41029','41039','41047','41051','41059',	
										'41067',	
										//Philly/Camden HIDTA Philadelphia	
										'42029','42045','42101',	
										//New England HIDTA Rhode Island	
										'44007',	
										//Atlanta HIDTA South Carolina	
										'45063','45079',	
										//Midwest HIDTA South Dakota	
										'46005','46011','46013','46027','46029','46033','46081','46083',
										'46093','46099','46103','46127','46135',	
										//Appalachia HIDTA Tennessee	
										'47007','47013','47025','47027','47029','47035','47049','47051',	
										'47057','47059','47061','47063','47065','47073','47087','47089',
										'47093','47111','47115','47133','47137','47141','47143','47145',	
										'47151','47153','47155','47171','47179','47185',	
										//Atlanta HIDTA Tennessee	
										'47157',	
										//Houston HIDTA  ***Note - Spread sheet had 'Kennedy' as one of the counties here, but is actually 'Kenedy' in our file',	
										'48007','48047','48157','48167','48199','48201','48245','48249',	
										'48261','48273','48291','48339','48355','48361','48391','48409',
										'48469',	
										//North TX HIDTA Texas	
										'48085','48113','48121','48139','48213','48221','48231','48251',	
										'48257','48303','48349','48367','48397','48423','48439',
										//SW Border-S TX Region	
										'48029','48043','48061','48105','48109','48127','48135','48141',
										'48215','48229','48243','48247','48271','48283','48323','48329',	
										'48371','48377','48389','48427','48443','48453','48465','48479',
										'48489','48505','48507',	
										//SW Border-W TX Region 	
										'48043','48105','48109','48141','48229','48243','48371','48377',
										'48389','48443',	
										//Rocky Mountain HIDTA Utah	
										'49011','49035','49043','49049','49053','49057',	
										//New England HIDTA Vermont	
										'50007',	
										//Wash/Baltimore HIDTA Virginia  *** the spread sheet had 'Loudon' but our file has 'Loudoun'.  Also 'City of Richmond' is actually just 'Richmond' in our file.',	
										'51510','51013','51041','51059','51600','51610','51085','51087',	
										'51670','51107','51683','51685','51730','51149','51153','51159',	
										//Northwest HIDTA	
										'53005','53011','53015','53021','53033','53035','53041','53053',	
										'53057','53061','53063','53067','53073','53077',
										//Appalachia HIDTA West Virginia	
										'54005','54011','54039','54043','54045','54053','54047','54055',	
										'54059','54079','54099',	
										//Milwaukee HIDTA	
										'55009','55025','55059','55079','55101','55105','55133',	
										//Rocky Mountain HIDTA Wyoming	
										'56001','56005','56021','56025','56037','56041'
										];		

EXPORT setBorderStates := [
													'ME','NH','VT','NY','PA','OH','MI','MN',
													'ND','MT','ID','WA','AK','TX','NM','AZ',
													'CA'
													];

EXPORT setHRBusFullSicCds := ['60999906','60999903','60999908','60990100','60990101','60990102','60990103','60999901','70110301',
															'79930401','79930402','79930403','79990803','79990804','799913','79991301','79991302','79991303',
															'79991304','79991305','79991306','60999908','60820000','60810000',
															'60819901','47310101','47310102','73891400','73891402','60999902','59329904', 
															'31510000','47310102', '73891005', '73891400','73891401','73891402','73891403',
															'73891404', '73891405','73891406','73891407','73891408'

															]; 

EXPORT setHRBusCatgSicCds := ['8111', '3199','3151','3011','5500','5511','5521','5551', '5561', '5571', 
															'5599','4724', '4725','4729', '6211', '6081', '6082','8111', '5812', '5813', '5814',
															'5815', '5816', '5817', '5818', '5819', '5820', '5822', '5831', '5841', '5841', '5875',
															'5094', '3911', '6722', '8721', '6799', '5411','5499', '4789'];



EXPORT setHRNAICSCodes := ['523130','522390','522390','713210','721120','522293','448320',
													'448190','424990','316998','316992','316210','316110','315990','315280','315210',
													'336370','336390','336411','336412','336413','336611','336612','336999','441110','441120',
													'441222','441228','561510','425120','522310','523120','523140','523999','524210','531210',
													'423940','448310','488510','522293','453920','454112','523999','522298','541110','541211',
													'541219','523120','445120','447110','447190','722511','722513','442299','443141','446110',
													'442110','443142','445110','452111','452112','452910','451211','451110','448210','448190',
													'448150','448140','448110','448120','448130','812930','483111','483112','483113','483114',
													'488510','485111','485113','485210','485510','561599','481211','481219','561422'];

EXPORT setHRProfLic := ['BIOCHEMICAL GENETICS, CLINICAL (MEDICAL GENETICS)',
												'BIOCHEMICAL/MOLECULAR GENETICS, CLINICAL (MEDICAL)',
												'CANCER, (SURGICAL ONCOLOGY) (SURGERY)',
												'CARDIOLOGY, INTERVENTIONAL (CARDIOVASCULAR DISEASE)',
												'CARDIOLOGY, INTERVENTIONAL (CARDIOVASCULAR DISEASE)',
												'DIAGNOSTIC RADIOLOGICAL PHYSICS, THERAPEUTICS (RADIOLOGY)',
												'ENDOCRINOLOGY ,DIABETES AND METABOLISM',
												'ENDOCRINOLOGY, DIABETES & METABOLISM (INTERNAL MED)',
												'ENDOCRINOLOGY, DIABETES & METABOLISM (INTERNAL MEDICINE)',
												'IMMUNOLOGY, CLINICAL & LABORATORY (INTERNAL MEDICINE)',
												'NUCLEAR PHYSICS, DIAGNOSTIC & MEDICAL (RADIOLOGY)',
												'ONCOLOGY, GYNECOLOGIC (MEDICAL ONCOLOGY/ IM)',
												'ONCOLOGY, MEDICAL (INTERNAL MEDICINE)"',
												'RADIOLOGICAL PHYSICS, DIAGNOSTIC (RADIOLOGY)',
												'RADIOLOGICAL PHYSICS, THERAPEUTIC & DIAGNOSTIC',
												'ABDOMINAL SURGERY',
												'ACCOUNTANT',
												'ACCOUNTANT, PUBLIC CERTIFIED',
												'ACCOUNTANT, PUBLIC REGISTERED',
												'ACCOUNTANTS',
												'ACCOUNTING CORPORATION ASSOC',
												'ACCOUNTING FIRM',
												'ACCOUNTING FIRMS',
												'ACCOUNTING PARTNERSHIP',
												'ANESTHESIA PERMIT/TAB',
												'ANESTHESIA PERMIT/TAC',
												'ANESTHESIA RESTRICTED PERMIT 1',
												'ANESTHESIA RESTRICTED PERMIT 2',
												'ANESTHESIA UNRESTRICTED PERMIT',
												'ANESTHESIOLOGY',
												'ANESTHESIOLOGY - BOARD CERTIFIED',
												'ANESTHESIOLOGY (CERTIFIED 1962)',
												'ANESTHESIOLOGY (CERTIFIED 1965)',
												'ANESTHESIOLOGY (CERTIFIED 1971)',
												'ANESTHESIOLOGY (CERTIFIED 1972)',
												'ANESTHESIOLOGY (CERTIFIED 1973)',
												'ANESTHESIOLOGY (CERTIFIED 1975)',
												'ANESTHESIOLOGY (CERTIFIED 1976)',
												'ANESTHESIOLOGY (CERTIFIED 1977)',
												'ANESTHESIOLOGY (CERTIFIED 1978)',
												'ANESTHESIOLOGY (CERTIFIED 1979)',
												'ANESTHESIOLOGY (CERTIFIED 1981)',
												'ANESTHESIOLOGY (CERTIFIED 1982)',
												'ANESTHESIOLOGY (CERTIFIED 1983)',
												'ANESTHESIOLOGY (CERTIFIED 1984)',
												'ANESTHESIOLOGY (CERTIFIED 1985)',
												'ANESTHESIOLOGY (CERTIFIED 1986)',
												'ANESTHESIOLOGY (CERTIFIED 1987)',
												'ANESTHESIOLOGY (CERTIFIED 1988)',
												'ANESTHESIOLOGY (CERTIFIED 1989)',
												'ANESTHESIOLOGY (CERTIFIED 1990)',
												'ANESTHESIOLOGY (CERTIFIED 1991)',
												'ANESTHESIOLOGY (CERTIFIED 1992)',
												'ANESTHESIOLOGY (CERTIFIED 1993)',
												'ANESTHESIOLOGY (CERTIFIED 1994)',
												'ANESTHESIOLOGY (CERTIFIED 1995)',
												'ANESTHESIOLOGY (CERTIFIED 1996)',
												'ANESTHESIOLOGY (CERTIFIED 1997)',
												'ANESTHESIOLOGY (CERTIFIED 1998)',
												'ANESTHESIOLOGY (CERTIFIED 1999)',
												'ANESTHESIOLOGY (CERTIFIED 2000)',
												'ANESTHESIOLOGY (CERTIFIED 2001)',
												'ANESTHESIOLOGY (CERTIFIED 2002)',
												'ANESTHESIOLOGY (CERTIFIED 2003)',
												'ANESTHESIOLOGY (CERTIFIED 2004)',
												'ANESTHESIOLOGY (CERTIFIED 2005)',
												'ANESTHESIOLOGY (CERTIFIED)',
												'ANESTHETIST',
												'ANORECTAL SURGERY (COLON & RECTAL SURGERY)',
												'ANORECTAL SURGERY (COLON & RECTAL SURGERY)',
												'APRAISER, REAL ESTATE, LICENSED',
												'APRAISER, REAL ESTATE, TEMPORARY',
												'APRAISER, REAL ESTATE, TRAINEE',
												'ASBESTOS CONSULTANT (DOCTORAL DEGREE)',
												'ASSOCIATE REAL ESTATE APPRAISER',
												'ATTORNEY',
												'ATTORNEY AT LAW',
												'ATTORNEY BROKER',
												'ATTORNEY GENERAL',
												'ATTORNEYS',
												'BOARD OF ACCOUNTANCY',
												'BROKER, REAL ESTATE',
												'CANCER, (SURGICAL ONCOLOGY) (SURGERY)',
												'CARDIOTHRACIC SURGERY',
												'CARDIOVASCULAR SURGERY',
												'CEMETERY REAL ESTATE BROKER',
												'CEMETERY REAL ESTATE SALESPERSON',
												'CERTIFIED GENERAL REAL ESTATE APPRAISER',
												'CERTIFIED PUBLIC ACCOUNTANT',
												'CERTIFIED RESIDENTIAL REAL ESTATE APPRAISER',
												'CLINICAL ACADEMIC MEDICAL DOCTOR',
												'COLON & RECTAL SURGERY',
												'COLON & RECTAL SURGERY - BOARD CERT',
												'COLON & RECTAL SURGERY (CERTIFIED 1980)',
												'COLON & RECTAL SURGERY (CERTIFIED 1990)',
												'COLON & RECTAL SURGERY (CERTIFIED 1993)',
												'COLON & RECTAL SURGERY (CERTIFIED 1994)',
												'COLON & RECTAL SURGERY (CERTIFIED 1998)',
												'COLON & RECTAL SURGERY (CERTIFIED 2002)',
												'COLON & RECTAL SURGERY (CERTIFIED 2003)',
												'COLON & RECTAL SURGERY (CERTIFIED 2004)',
												'COLON & ROCTAL SURGERY',
												'COLON AND RECTAL SURGERY',
												'CRITICAL CARE MEDICINE (NEUROLOGICAL SURGERY)',
												'DERMATOLOGIC SURGERY',
												'DOCTOR OF ACUPUNCTURE',
												'DOCTOR OF CHIROPRACTIC',
												'DOCTOR OF DENTAL MEDICINE',
												'DOCTOR OF DENTAL SURGERY',
												'DOCTOR OF DENTAL SURGERY/DENTAL MEDICINE',
												'DOCTOR OF MEDICINE',
												'DOCTOR OF OPTOMETRY',
												'DOCTOR OF OSTEOPATH',
												'DOCTOR OF OSTEOPATHY',
												'DOCTOR OF OSTEOPATHY & SURGERY',
												'DOCTOR OF PODIATRIC MEDICINE',
												'DOCTORS OF CHIROPRACTIC',
												'DOCTORS OF MEDICINE AND SURGERY',
												'DOCTORS OF OSTEOPATHY',
												'DOCTORS OF PODIATRY',
												'EDUCATIONAL LIMITED MEDICAL DOCTOR',
												'FACIAL PLASTIC SURGERY',
												'FLORIDA REAL ESTATE APPRAISAL BD',
												'FOREIGN ACCOUNTANT',
												'GENERAL SURGERY',
												'GENERAL VASCULAR SURGERY (SURGERY)',
												'GENERAL VASCULAR SURGERY (SURGERY) (CERTIFIED 1971)',
												'GENERAL VASCULAR SURGERY (SURGERY) (CERTIFIED 1972)',
												'GENERAL VASCULAR SURGERY (SURGERY) (CERTIFIED 1993)',
												'GENERAL VASCULAR SURGERY (SURGERY) (CERTIFIED 1995)',
												'GENERAL VASCULAR SURGERY (SURGERY) (CERTIFIED 1998)',
												'GENERAL VASCULAR SURGERY (SURGERY) (CERTIFIED 1999)',
												'HAND SURGERY',
												'HAND SURGERY (ORS:PLS:S)',
												'HAND SURGERY (ORS:PLS:S) (CERTIFIED 1994)',
												'HAND SURGERY (ORTHOPEDIC SURGERY)',
												'HAND SURGERY (PLASTIC SURGERY)',
												'HAND SURGERY (SURGERY)',
												'HEAD & NECK SURGERY',
												'HEAD & NECK SURGERY (OTOLARYNGOLOGY)',
												'HEAD AND NECK SURGERY',
												'LICENSED ACCOUNTANT',
												'LICENSED PUBLIC ACCOUNTANT',
												'LICENSED REAL ESTATE BRANCH OFFICE',
												'LICENSED REAL ESTATE BROKER',
												'LICENSED REAL ESTATE BROKER CORPORATION',
												'LICENSED REAL ESTATE BROKER PARTNERSHIP',
												'LICENSED REAL ESTATE CE COURSE',
												'LICENSED REAL ESTATE CE INSTRUCTOR',
												'LICENSED REAL ESTATE CE SCHOOL',
												'LICENSED REAL ESTATE LEASING AGENT',
												'LICENSED REAL ESTATE LEASING AGENT STUDENT',
												'LICENSED REAL ESTATE LIMITED LIABILITY FIRM',
												'LICENSED REAL ESTATE PRE-LICENSE BRANCH',
												'LICENSED REAL ESTATE PRE-LICENSE COURSE',
												'LICENSED REAL ESTATE PRE-LICENSE INSTRUCTOR',
												'LICENSED REAL ESTATE PRE-LICENSE SCHOOL',
												'LICENSED REAL ESTATE SALESPERSON',
												'LIMITED GENERAL REAL ESTATE APPRAISER',
												'LIMITED LICENSE MEDICAL DOCTOR',
												'LIMITED MEDICAL DOCTOR',
												'LIMITED REAL ESTATE APPRAISER',
												'LTD RESIDENTIAL REAL ESTATE APPRAISER',
												'MEDICAL DOC AREA CRITICAL NEED',
												'MEDICAL DOCTOR',
												'MEDICAL DOCTOR AREA CRITICAL NEED',
												'MEDICAL DOCTOR LIMITED TO CLEVELAND CLINIC',
												'MEDICAL DOCTOR LIMITED TO MAYO CLINIC',
												'MEDICAL DOCTOR LTD CLEVLAND',
												'MEDICAL DOCTOR LTD MAYO CLIN',
												'MEDICAL DOCTOR PUBLIC HEALTH CERTIFICATE',
												'MEDICAL DOCTOR PUBLIC HLTH',
												'MEDICAL DOCTOR PUBLIC PSYC',
												'MEDICAL DOCTOR PUBLIC PSYCHIATRY CERTIFICATE',
												'MEDICAL DOCTOR RESTRICTED',
												'MEDICAL DOCTOR VISITING FACULTY CERTIFICATE',
												'MEDICAL DOCTORS',
												'MEDICINE & SURGERY',
												'MEDICINE AND SURGERY',
												'MEDICINE AND SURGERY DO',
												'MEDICINE AND SURGERY MD',
												'NEUROLOGICAL SURGERY',
												'NEUROLOGICAL SURGERY - BOARD CERTIFIED',
												'NEUROLOGICAL SURGERY (CERTIFIED 1956)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1958)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1961)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1969)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1970)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1975)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1977)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1978)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1980)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1986)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1987)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1988)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1993)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1995)',
												'NEUROLOGICAL SURGERY (CERTIFIED 1998)',
												'NEUROLOGICAL SURGERY (CERTIFIED 2000)',
												'NEUROLOGICAL SURGERY (CERTIFIED 2002)',
												'NEUROLOGICAL SURGERY (CERTIFIED 2003)',
												'NEUROLOGICAL SURGERY-FOREIGN CERTIFICATE (CERTIFIED 1971)',
												'NONCLINICAL ACADEMIC MEDICAL DOCTOR',
												'NON-RESIDENT CERTIFIFED PUBLIC ACCOUNTANT',
												'NR REGISTERED PUBLIC ACCOUNTANT',
												'ORAL & MAXI. SURGERY',
												'ORAL & MAXILLOFACIAL SURGERY',
												'ORAL AND MAXILLOFACIAL SURGERY',
												'ORAL SURGERY',
												'ORTHOPAEDIC SURGERY',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1959)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1961)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1962)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1964)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1965)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1966)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1967)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1968)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1969)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1970)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1972)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1973)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1974)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1975)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1976)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1977)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1978)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1979)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1980)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1981)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1982)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1983)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1984)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1985)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1987)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1988)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1989)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1990)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1991)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1992)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1993)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1994)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1995)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1996)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1997)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1998)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 1999)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 2000)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 2001)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 2002)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 2003)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 2004)',
												'ORTHOPAEDIC SURGERY (CERTIFIED 2006)',
												'ORTHOPAEDIC SURGERY (CERTIFIED)',
												'ORTHOPEDIC SURGERY',
												'ORTHOPEDIC SURGERY - BOARD CERTIFIED',
												'ORTHOPEDIC SURGERY OF THE SPINE',
												'OSTEOPATH - OBSTETRICIAN',
												'OSTEOPATHY & SURGERY',
												'OSTEOPATHY AND SURGERY',
												'PEDIATRIC SURGERY',
												'PEDIATRIC SURGERY (SURGERY)',
												'PEDIATRIC SURGERY (SURGERY) (CERTIFIED 1992)',
												'PEDIATRIC SURGERY (SURGERY) (CERTIFIED 1995)',
												'PEDIATRIC SURGERY (SURGERY) (CERTIFIED 1996)',
												'PEDIATRIC SURGERY(NEUROLOGY)',
												'PEDIATRIC SURGERY(SURGERY)',
												'PHYSICIAN AMBULATORY SURGERY CENTER',
												'PHYSICIAN:ABDOMINAL SURGERY',
												'PHYSICIAN:CARDIOVASCULAR SURGERY',
												'PHYSICIAN:COLON AND RECTAL SURGERY',
												'PHYSICIAN:CORNEA REFRACTIVE SURGERY',
												'PHYSICIAN:COSMETIC DERMATOLOGIC SURGERY',
												'PHYSICIAN:COSMETIC SURGERY',
												'PHYSICIAN:CRANIOFACIAL SURGERY',
												'PHYSICIAN:CRITICAL CARE - NEUROSURGERY',
												'PHYSICIAN:CRITICAL CARE (SURGERY)',
												'PHYSICIAN:DERMATOLOGIC SURGERY',
												'PHYSICIAN:FACIAL PLASTIC SURGERY',
												'PHYSICIAN:GENERAL SURGERY',
												'PHYSICIAN:GENERAL VASCULAR SURGERY',
												'PHYSICIAN:GYNECOLOGIC SURGERY',
												'PHYSICIAN:HAND SURGERY',
												'PHYSICIAN:HAND SURGERY - ORTHOPEDIC SURG',
												'PHYSICIAN:HAND SURGERY - SURGERY',
												'PHYSICIAN:HEAD AND NECK SURGERY',
												'PHYSICIAN:MOHS MICROGRAPHIC SURGERY',
												'PHYSICIAN:NEUROLOGICAL SURGERY',
												'PHYSICIAN:ORAL & MAXILLOFACIAL SURGERY',
												'PHYSICIAN:ORTHOPEDIC SURGERY',
												'PHYSICIAN:ORTHOPEDIC SURGERY OF THE SPIN',
												'PHYSICIAN:PEDIATRIC SURGERY',
												'PHYSICIAN:PEDIATRIC SURGERY (NEUROLOGY)',
												'PHYSICIAN:PLASTIC SURGERY',
												'PHYSICIAN:PLASTIC SURGERY WITHIN THE HEA',
												'PHYSICIAN:THORACIC SURGERY',
												'PHYSICIAN:TRANSPLANT SURGERY',
												'PHYSICIAN:TRAUMATIC SURGERY',
												'PHYSICIAN:UROLOGIC SURGERY',
												'PHYSICIAN:VASCULAR SURGERY',
												'PLASTIC SURGERY',
												'PLASTIC SURGERY - BOARD CERTIFIED',
												'PLASTIC SURGERY (CERTIFIED 1955)',
												'PLASTIC SURGERY (CERTIFIED 1975)',
												'PLASTIC SURGERY (CERTIFIED 1976)',
												'PLASTIC SURGERY (CERTIFIED 1979)',
												'PLASTIC SURGERY (CERTIFIED 1981)',
												'PLASTIC SURGERY (CERTIFIED 1983)',
												'PLASTIC SURGERY (CERTIFIED 1987)',
												'PLASTIC SURGERY (CERTIFIED 1989)',
												'PLASTIC SURGERY (CERTIFIED 1990)',
												'PLASTIC SURGERY (CERTIFIED 1991)',
												'PLASTIC SURGERY (CERTIFIED 1992)',
												'PLASTIC SURGERY (CERTIFIED 1993)',
												'PLASTIC SURGERY (CERTIFIED 1995)',
												'PLASTIC SURGERY (CERTIFIED 1996)',
												'PLASTIC SURGERY (CERTIFIED 1997)',
												'PLASTIC SURGERY (CERTIFIED 1999)',
												'PLASTIC SURGERY (CERTIFIED 2000)',
												'PLASTIC SURGERY (CERTIFIED 2005)',
												'PLASTIC SURGERY W/IN HEAD & NECK (OTOLARYNGOLOGY)',
												'PROCTOLOGY (COLON & RECTAL SURGERY)',
												'PROCTOLOGY (COLON & RECTAL SURGERY)',
												'PROVISIONAL REAL ESTATE APPRAISER',
												'PUBLIC ACCOUNTANT',
												'PUBLIC ACCOUNTANT CPE SPONSOR',
												'PUBLIC ACCOUNTANTS',
												'PUBLIC ACCOUNTING FIRM',
												'PUBLIC SCHOOL ACCOUNTANT',
												'REAL ESTATE',
												'REAL ESTATE ADDITIONAL LOCATION',
												'REAL ESTATE AGENT',
												'REAL ESTATE AGENTS, BROKERS & FIRMS',
												'REAL ESTATE APPRAISER',
												'REAL ESTATE APPRAISER - GENERAL',
												'REAL ESTATE APPRAISER - LICENSED',
												'REAL ESTATE APPRAISER,TEMP PRACTICE',
												'REAL ESTATE APPRAISERS',
												'REAL ESTATE ASSOC BROKER',
												'REAL ESTATE ASSOCIATE BROKER',
												'REAL ESTATE BRANCH OFFICE',
												'REAL ESTATE BROKER',
												'REAL ESTATE BROKER MULTI LICENSEE',
												'REAL ESTATE BROKER OR SALES',
												'REAL ESTATE BROKERS',
												'REAL ESTATE BUSINESS ENTITY',
												'REAL ESTATE COMMISSION',
												'REAL ESTATE COMMISSIONERS',
												'REAL ESTATE COMPANY',
												'REAL ESTATE CORPORATION',
												'REAL ESTATE FIRMS',
												'REAL ESTATE INSTRUCTOR',
												'REAL ESTATE INSTRUCTORS',
												'REAL ESTATE PARTNERSHIP',
												'REAL ESTATE SALES PEOPLE & BROKERS',
												'REAL ESTATE SALES PERSON',
												'REAL ESTATE SALES PERSONS & BROKERS',
												'REAL ESTATE SALESPERSON',
												'REAL ESTATE SOLE PROPRIETOR',
												'REG MUNICIPAL ACCOUNTANT',
												'REG MUNICIPAL ACCOUNTANT (ONLY)',
												'REGISTERED ACCOUNTANT',
												'REGISTERED CERTIFIED PUBLIC ACCOUNTANT',
												'REGISTERED PUBLIC ACCOUNTANT',
												'SALES PERSON, REAL ESTATE',
												'STATE LICENSED REAL ESTATE APPRAISAL',
												'STATE LICENSED REAL ESTATE APPRAISER',
												'SURGERY',
												'SURGERY - BOARD CERTIFIED',
												'SURGERY (CERTIFIED 1950)',
												'SURGERY (CERTIFIED 1954)',
												'SURGERY (CERTIFIED 1956)',
												'SURGERY (CERTIFIED 1957)',
												'SURGERY (CERTIFIED 1958)',
												'SURGERY (CERTIFIED 1959)',
												'SURGERY (CERTIFIED 1960)',
												'SURGERY (CERTIFIED 1961)',
												'SURGERY (CERTIFIED 1963)',
												'SURGERY (CERTIFIED 1964)',
												'SURGERY (CERTIFIED 1966)',
												'SURGERY (CERTIFIED 1967)',
												'SURGERY (CERTIFIED 1968)',
												'SURGERY (CERTIFIED 1969)',
												'SURGERY (CERTIFIED 1970)',
												'SURGERY (CERTIFIED 1971)',
												'SURGERY (CERTIFIED 1972)',
												'SURGERY (CERTIFIED 1973)',
												'SURGERY (CERTIFIED 1974)',
												'SURGERY (CERTIFIED 1975)',
												'SURGERY (CERTIFIED 1976)',
												'SURGERY (CERTIFIED 1977)',
												'SURGERY (CERTIFIED 1978)',
												'SURGERY (CERTIFIED 1979)',
												'SURGERY (CERTIFIED 1980)',
												'SURGERY (CERTIFIED 1981)',
												'SURGERY (CERTIFIED 1982)',
												'SURGERY (CERTIFIED 1983)',
												'SURGERY (CERTIFIED 1984)',
												'SURGERY (CERTIFIED 1985)',
												'SURGERY (CERTIFIED 1986)',
												'SURGERY (CERTIFIED 1987)',
												'SURGERY (CERTIFIED 1988)',
												'SURGERY (CERTIFIED 1989)',
												'SURGERY (CERTIFIED 1990)',
												'SURGERY (CERTIFIED 1992)',
												'SURGERY (CERTIFIED 1993)',
												'SURGERY (CERTIFIED 1994)',
												'SURGERY (CERTIFIED 1995)',
												'SURGERY (CERTIFIED 1996)',
												'SURGERY (CERTIFIED 1997)',
												'SURGERY (CERTIFIED 1998)',
												'SURGERY (CERTIFIED 1999)',
												'SURGERY (CERTIFIED 2000)',
												'SURGERY (CERTIFIED 2001)',
												'SURGERY (CERTIFIED 2002)',
												'SURGERY (CERTIFIED 2004)',
												'SURGERY (CERTIFIED 2005)',
												'SURGERY (CERTIFIED 2006)',
												'SURGERY (CERTIFIED)',
												'SURGERY CRITICAL CARE (SURGERY)',
												'SURGICAL CRITICAL CARE (SURGERY)',
												'TEMPORARY ACCOUNTANT',
												'TEMPORARY ACCOUNTING',
												'TEMPORARY CERTIFIED GENERAL REAL ESTATE APPRAISER',
												'TEMPORARY CERTIFIED PUBLIC ACCOUNTANTS',
												'TEMPORARY PRACTICE REAL ESTATE APPRAISER',
												'TEMPORARY PUBLIC ACCOUNTING FIRM',
												'THORACIC SURGERY',
												'THORACIC SURGERY - BOARD CERTIFIED',
												'THORACIC SURGERY (CERTIFIED 1965)',
												'THORACIC SURGERY (CERTIFIED 1968)',
												'THORACIC SURGERY (CERTIFIED 1970)',
												'THORACIC SURGERY (CERTIFIED 1971)',
												'THORACIC SURGERY (CERTIFIED 1973)',
												'THORACIC SURGERY (CERTIFIED 1976)',
												'THORACIC SURGERY (CERTIFIED 1979)',
												'THORACIC SURGERY (CERTIFIED 1980)',
												'THORACIC SURGERY (CERTIFIED 1986)',
												'THORACIC SURGERY (CERTIFIED 1989)',
												'THORACIC SURGERY (CERTIFIED 1991)',
												'THORACIC SURGERY (CERTIFIED 1993)',
												'THORACIC SURGERY (CERTIFIED 1995)',
												'THORACIC SURGERY (CERTIFIED 1996)',
												'THORACIC SURGERY (CERTIFIED 1997)',
												'THORACIC SURGERY (CERTIFIED 1998)',
												'THORACIC SURGERY (CERTIFIED 2004)',
												'THORACIC SURGERY (CERTIFIED 2006)',
												'TRANSPLANT SURGERY',
												'TRAUMA SURGERY',
												'TRAUMATIC SURGERY',
												'VASCULAR SURGERY',
												'WEST VIRGINIA CERTIFIED PUBLIC ACCOUNTANT',
												'WEST VIRGINIA REGISTERED PUBLIC ACCOUNTANT',
												'DENTISTRY',
												'DENTIST',
												'D.D.S' ,
												'PHYSICIAN AND SURGEON OR OSTEOPATH',
												'M.D.',
												'PODIATRIST',
												'PULMONARY DISEASE',
												'MEDICAL',
												'FAMILY PRACTICE'	];

EXPORT StateBorderDiffCountry := ['AK', 'AZ', 'CA', 'ID', 'FL', 'ME', 'MI', 'MN', 'MT', 'NH',
																	'NM', 'NY', 'ND', 'OH', 'TX', 'VT', 'WA'];

EXPORT IslandState := ['HA', 'PR', 'VI'];

EXPORT CountyForeignJurisdic := [
																		'02100', '02110',	'02185','02201','02232','02240','02261','02280','02290',
																		'04003','04019','04023','04027', '06073', '06025', '016021', '23003', '23029',
																		'26033','26095','26003','26103','26013','26061','26083','26131','26053','26031',
																		'26141','26007','26001','26069','26011','26017','26157','26063','26151','26147',
																		'27069','27135','27077','27071','27137','27075','27031','30053','30029','30035',
																		'30101','30051','30041','30005','30071','30105','30019','30091','33007','35023',
																		'35029','35013','35035','35015','35025','36063','36073','36055','36117','36011',
																		'36075','36045','36089','36033','36019','38023','38013','38075','38009','38079',
																		'38095','38019','38067','39095','39123','39143','39043','39093','39035','39085',
																		'39007','48043','48061','48109','48127','48141','48215','48229','48243','48271',
																		'48323','48377','48427','48443','48465','48479','48505','50001','50009','50011',
																		'50013','50019','53019','53047','53051','53065','53073'];
																		
EXPORT CountyBordersOceanForgJur		:= [ '02180','12087','12086'];
																	
																	// '01003','01097','02013','02016','02050','02060','02070','02122','02150','02164',
																	// '02180','02185','02188','02201','02220','02232','02261','02270','06015','06023',
																	// '06045','06097','06041','06075','06053','06079','06083','06111','06037','06059',
																	// '06073','12033','12113','12091','12131','12005','12045','12037','12129','12065',
																	// '12123','12029','12075','12017','12053','12101','12103','12057','12081','12115',
																	// '12015','12071','12021','12087','12086', '12025','12011','12099','12085','12111',
																	// '12061','12009','12127','12035','12109','12031','12089','22023','22113','22045',
																	// '22101','22109','22057','22075','22087','22071','22051','22103','28047','28059',
																	// '48007','48039','48057','48061','48071','48167','48239','48245','48261','48273',
																	// '48321','48355','48391','48409','48469','48489'];









//todo   remove spaces
EXPORT  CityBorderStation  := ['POKER CREEK,AK', 'ALCAN HIGHWAY,AK', 'DALTON CACHE,AK',
					'SKAGWAY,AK', 'HYDER,AK',  'SAN LUIS,AZ', 'LUKEVILLE,AZ',  'SASABE,AZ',  'NOGALES,AZ',
					 'NACO,AZ',  'DOUGLAS,AZ',  'COBURN GORE,CA', 
					 'JACKMAN,ME', 'SAINT ZACHARIE,ME', 'STE. AURELIE,ME',
					 'ST. JUSTE,ME',  'ST. PAMPHILE,ME', 'ESTCOURT STATION,ME', 'FORT KENT,ME', 'MADAWASKA,ME',
					 'VAN BURDEN,ME', 'HAMLIN,ME', 'LIMESTONE,ME', 'EAST ROAD,ME', 'FORT FAIRFIELD,ME', 'EASTON,ME',
					 'BRIDGEWATER,ME', 'MONTICELLO,ME', 'HOULTON,ME', 'ORIENT,ME', 'FOREST CITY,ME', 'VANCEBORO,ME',
					 'CALAIS,ME', 'LUBEC,ME',  
					 'SAN YSIDRO,CA','OTAY MESA,CA','TECATE,CA','CALEXICO,CA','ANDRADE,CA',
						'PORTHILL,ID','EASTPORT,ID',
						'SAULTE STE. MARIE,MI','PORT HURON,MI','DETROIT,MI',
						'BAUDETTE,MN','INTERNATIONAL FALLS,MN','GRAND PORTAGE,MN',
					'ROOSVILLE,MT','CHIEF MOUNTAIN,MT','PIEGAN,MT','DEL BONITA,MT','SWEETGRASS,MT','WHITLASH,MT',
					'WILD HORSE,MT','WILLOW CREEK,MT','TURNER,MT','MORGAN,MT','OPHEIM,MT','SCOBEY,MT','RAYMOND,MT',
					'PITTSBURGH,NH',
					'SANTA TERESA,NM','ANTELOPE WELLS,NM','COLUMBUS,NM',
					'BUFFALO,NY','NIAGARA FALLS,NY','LEWISTON,NY','ALEXANDRIA BAY,NY',
					'OGDENSBURG,NY','MASSENA,NY',
					'FORT COVINGTON,NY','TROUT RIVER,NY','JAMIESON LINE,NY','CHATEAUGAY,NY',
					'CHURUBUSCO,NY','CANNON CORNERS,NY',
					'MOOERS,NY','CHAMPLAIN,NY','OVERTON CORNERS,NY','ROUSES POINT,NY',
					'FORTUNA,ND','AMBROSE,ND','NOONAN,ND','PORTAL,ND','NORTHGATE,ND','SHERWOOD,ND',
					'ANTLER,ND', 'WESTHOPE,ND','CARBURY,ND','DUNSEITH,ND','ST. JOHN,ND','HANSBORO,ND',
					'SARLES,ND','HANNAH,ND','MAIDA,ND','WALHALLA,ND','NECHE,ND','PEMBINA,ND',
					'EL PASO,TX','FABENS,TX','FORT HANCOCK,TX', 'PRESIDIO,TX','BIG BEND,TX', 
					'DEL RIO,TX', 'EAGLE PASS,TX', 'LAREDO,TX', 'FALCON HEIGHTS,TX', 'ROMA,TX', 
					'RIO GRANDE CITY,TX', 'LOS EBANOS,TX','MISSION,TX', 'HIDALGO,TX', 'PHARR,TX', 
					'DONNA,TX', 'PROGRESO,TX', 'LOS INDIOS,TX', 'BROWNSVILLE,TX', 
					'ALBURGH,VT','ALBURGH SPRINGS,VT','HIGHGATE SPRINGS,VT','MORSES LINE,VT','WEST BERKSHIRE,VT',
					'PINNACLE ROAD,VT','RICHFORD,VT','EAST RICHFORD,VT','NORTH TROY,VT','BEEBE PLAIN,VT',
					'DERBY LINE,VT','NORTON,VT','CANAAN,VT','BEECHER FALLS,VT',
					'POINTS ROBERTS,WA','BLAINE,WA','LYNDEN,WA','SUMAS,WA','NIGHTHAWK,WA','OROVILLE,WA',
					'FERRY,WA','DANVILLE,WA','LAURIER,WA','FRONTIER,WA','BOUNDARY,WA','METALINE FALLS,WA'];

EXPORT  CityRailStation  := ['SKAGWAY,AK', 'NOGALES,AZ', 'SAN YSIDRO,CA','CALEXIO,CA',
						'EASTPORT,ID', 'BEATTIE,ME','VAN BUREN,ME','HOULTON,ME','VANCEBORO,ME',
						'WOODLAND,ME','BARING PLANTATION,ME','MILLTOWN,ME',
						'SAULTE STE. MARIE,MI','PORT HURON,MI','DETROIT,MI',
						'LONGWORTH,MN','BAUDETTE,MN','INTERNATIONAL FALLS,MN','RANIER,MN',
						'SWEETGRASS,MT', 'BUFFALO,NY','NIAGARA FALLS,NY','FORT COVINGTON,NY',
						'TROUT RIVER,NY','ROUSES POINT,NY', 'NORTHGATE,ND', 
						'EL PASO,TX','PRESIDIO,TX','EAGLE PASS,TX','LAREDO,TX','BROWNSVILLE,TX',
						'ALBURGH SPRINGS,VT','RICHFORD,VT','EAST RICHFORD,VT','NORTH TROY,VT',
						'NORTON,VT', 'BLAINE,WA', 'SUMAS,WA','DANVILLE,WA','LAURIER,WA','BOUNDARY,WA'];


EXPORT CityFerryCrossing := ['MOBILE, AL', 'KETCHIKAN,AK', 'JUNEAU,AK','WHITTIER,AK',
						'EASTPORT,ME','BAR HARBOR,ME','PORTLAND,ME', 'MARINE CITY,MI',
						'ALGONAC,MI','DETROIT,MI','CAPE VINCENT,NY', 'SANDUSKY,OH', 'LOS EBANOS,TX',
						'SEATTLE,WA',  'PORT ANGELES,WA','BELLINGHAM,WA','ANACORTES,WA'];


EXPORT StatesBorderDiffCountry := ['WA', 'VT', 'TX', 'OH', 'ND', 'NY', 'NM', 'MT', 'MN', 
                                'MI', 'ME', 'FL', 'ID', 'CA', 'AZ', 'AK'];
						
								
EXPORT AMLNewsCategory := ['ADVERSE MEDIA-AIRCRAFT HIJACKING',
				'ADVERSE MEDIA-ANTITRUST VIOLATIONS',
				'ADVERSE MEDIA-ARMS TRAFFICKING',
				'ADVERSE MEDIA-BANK FRAUD',
				'ADVERSE MEDIA-BRIBERY',
				'ADVERSE MEDIA-BURGLARY',
				'ADVERSE MEDIA-CONSPIRACY',
				'ADVERSE MEDIA-CORRUPTION',
				'ADVERSE MEDIA-COUNTERFEITING',
				'ADVERSE MEDIA-CRIME AGNST HUMANITY',
				'ADVERSE MEDIA-DRUG TRAFFICKING',
				'ADVERSE MEDIA-EMBEZZLEMENT',
				'ADVERSE MEDIA-ESPIONAGE',
				'ADVERSE MEDIA-EXPLOSIVES',
				'ADVERSE MEDIA-EXTORT-RACK-THREATS',
				'ADVERSE MEDIA-FINANCIAL CRIMES',
				'ADVERSE MEDIA-FORGERY',
				'ADVERSE MEDIA-FRAUD',
				'ADVERSE MEDIA-FUGITIVE',
				'ADVERSE MEDIA-GAMBLING OPERATIONS',
				'ADVERSE MEDIA-GOVT BRANCH MEMBER',
				'ADVERSE MEDIA-HEALTHCARE FRAUD',
				'ADVERSE MEDIA-HUMAN RIGHTS ABUSE',
				'ADVERSE MEDIA-HUMAN TRAFFICKING',
				'ADVERSE MEDIA-INSIDER TRADING',
				'ADVERSE MEDIA-INTERSTATE COMMERCE',
				'ADVERSE MEDIA-KIDNAPPING',
				'ADVERSE MEDIA-MONEY LAUNDERING',
				'ADVERSE MEDIA-MORTGAGE FRAUD',
				'ADVERSE MEDIA-MURDER',
				'ADVERSE MEDIA-ORGANIZED CRIME',
				'ADVERSE MEDIA-PEONAGE',
				'ADVERSE MEDIA-PHARMA TRAFFICKING',
				'ADVERSE MEDIA-PIRACY',
				'ADVERSE MEDIA-PORNOGRAPHY',
				'ADVERSE MEDIA-PRICE MANIPULATION',
				'ADVERSE MEDIA-RICO',
				'ADVERSE MEDIA-SECURITIES FRAUD',
				'ADVERSE MEDIA-SMUGGLING',
				'ADVERSE MEDIA-STOLEN PROPERTY',
				'ADVERSE MEDIA-TAX EVASION',
				'ADVERSE MEDIA-TERRORISM',
				'ADVERSE MEDIA-WAR CRIMES',
				'ADVERSE MEDIA-WMD',
				'ASSOCIATED ENTITY-ARMS TRAFFICKING',
				'ASSOCIATED ENTITY-BRIBERY',
				'ASSOCIATED ENTITY-DRUG TRAFFICKING',
				'ASSOCIATED ENTITY-EMBEZZLEMENT',
				'ASSOCIATED ENTITY-ESPIONAGE',
				'ASSOCIATED ENTITY-FRAUD',
				'ASSOCIATED ENTITY-HUMAN TRAFFICKING',
				'ASSOCIATED ENTITY-INTERSTATE COMMERCE',
				'ASSOCIATED ENTITY-MONEY LAUNDERING',
				'ASSOCIATED ENTITY-MURDER',
				'ASSOCIATED ENTITY-ORGANIZED CRIME',
				'ASSOCIATED ENTITY-SECURITIES FRAUD',
				'ASSOCIATED ENTITY-TERRORISM',
				'COMPANY OF INTEREST-DRUG TRAFFICKING',
				'COMPANY OF INTEREST-TERRORISM',
				'END-USE CONTROLS-DRUG TRAFFICKING',
				'ENFORCEMENT-AIRCRAFT HIJACKING',
				'ENFORCEMENT-ANTITRUST VIOLATIONS',
				'ENFORCEMENT-ARMS TRAFFICKING',
				'ENFORCEMENT-BANK FRAUD',
				'ENFORCEMENT-BRIBERY',
				'ENFORCEMENT-BURGLARY',
				'ENFORCEMENT-CONSPIRACY',
				'ENFORCEMENT-CORRUPTION',
				'ENFORCEMENT-COUNTERFEITING',
				'ENFORCEMENT-CRIME AGNST HUMANITY',
				'ENFORCEMENT-DRUG TRAFFICKING',
				'ENFORCEMENT-EMBEZZLEMENT',
				'ENFORCEMENT-ENVIRONMENTAL CRIMES',
				'ENFORCEMENT-ESPIONAGE',
				'ENFORCEMENT-EXPLOSIVES',
				'ENFORCEMENT-EXTORT-RACK-THREATS',
				'ENFORCEMENT-FINANCIAL CRIMES',
				'ENFORCEMENT-FORGERY',
				'ENFORCEMENT-FRAUD',
				'ENFORCEMENT-FUGITIVE',
				'ENFORCEMENT-GAMBLING OPERATIONS',
				'ENFORCEMENT-HEALTHCARE FRAUD',
				'ENFORCEMENT-HUMAN RIGHTS ABUSE',
				'ENFORCEMENT-HUMAN TRAFFICKING',
				'ENFORCEMENT-INSIDER TRADING',
				'ENFORCEMENT-INTERSTATE COMMERCE',
				'ENFORCEMENT-KIDNAPPING',
				'ENFORCEMENT-MONEY LAUNDERING',
				'ENFORCEMENT-MORTGAGE FRAUD',
				'ENFORCEMENT-MURDER',
				'ENFORCEMENT-ORGANIZED CRIME',
				'ENFORCEMENT-PEONAGE',
				'ENFORCEMENT-PHARMA TRAFFICKING',
				'ENFORCEMENT-PIRACY',
				'ENFORCEMENT-PORNOGRAPHY',
				'ENFORCEMENT-PRICE MANIPULATION',
				'ENFORCEMENT-RICO',
				'ENFORCEMENT-SECURITIES FRAUD',
				'ENFORCEMENT-SMUGGLING',
				'ENFORCEMENT-STOLEN PROPERTY',
				'ENFORCEMENT-TAX EVASION',
				'ENFORCEMENT-TERRORISM',
				'ENFORCEMENT-WAR CRIMES',
				'ENFORCEMENT-WMD',
				'EXCLUDED PARTY-ARMS TRAFFICKING',
				'EXCLUDED PARTY-BANK FRAUD',
				'EXCLUDED PARTY-BRIBERY',
				'EXCLUDED PARTY-BURGLARY',
				'EXCLUDED PARTY-CONSPIRACY',
				'EXCLUDED PARTY-CORRUPTION',
				'EXCLUDED PARTY-DRUG TRAFFICKING',
				'EXCLUDED PARTY-EMBEZZLEMENT',
				'EXCLUDED PARTY-EXTORT-RACK-THREATS',
				'EXCLUDED PARTY-FRAUD',
				'EXCLUDED PARTY-HEALTHCARE FRAUD',
				'EXCLUDED PARTY-HUMAN TRAFFICKING',
				'EXCLUDED PARTY-MONEY LAUNDERING',
				'EXCLUDED PARTY-MORTGAGE FRAUD',
				'EXCLUDED PARTY-MURDER',
				'EXCLUDED PARTY-ORGANIZED CRIME',
				'EXCLUDED PARTY-RICO',
				'EXCLUDED PARTY-SECURITIES FRAUD',
				'EXCLUDED PARTY-SMUGGLING',
				'EXCLUDED PARTY-STOLEN PROPERTY',
				'EXCLUDED PARTY-TAX EVASION',
				'EXCLUDED PARTY-TERRORISM',
				'EXCLUDED PARTY-WMD',
				'GOVERNMENT CORP-FRAUD',
				'GOVERNMENT CORP-GAMBLING OPERATIONS',
				'GOVERNMENT CORP-INSIDER TRADING',
				'GOVERNMENT CORP-MONEY LAUNDERING',
				'GOVERNMENT CORP-WMD',
				'INFLUENTIAL PERSON-ARMS TRAFFICKING',
				'INFLUENTIAL PERSON-DRUG TRAFFICKING',
				'INFLUENTIAL PERSON-EMBEZZLEMENT',
				'INFLUENTIAL PERSON-EXTORT-RACK-THREATS',
				'INFLUENTIAL PERSON-FRAUD',
				'INFLUENTIAL PERSON-INSIDER TRADING',
				'INFLUENTIAL PERSON-MONEY LAUNDERING',
				'INFLUENTIAL PERSON-MURDER',
				'INVESTIGATION-ARMS TRAFFICKING',
				'INVESTIGATION-BANK FRAUD',
				'INVESTIGATION-BRIBERY',
				'INVESTIGATION-BURGLARY',
				'INVESTIGATION-CONSPIRACY',
				'INVESTIGATION-CORRUPTION',
				'INVESTIGATION-DRUG TRAFFICKING',
				'INVESTIGATION-EMBEZZLEMENT',
				'INVESTIGATION-ESPIONAGE',
				'INVESTIGATION-EXPLOSIVES',
				'INVESTIGATION-EXTORT-RACK-THREATS',
				'INVESTIGATION-FINANCIAL CRIMES',
				'INVESTIGATION-FRAUD',
				'INVESTIGATION-GAMBLING OPERATIONS',
				'INVESTIGATION-HEALTHCARE FRAUD',
				'INVESTIGATION-HUMAN TRAFFICKING',
				'INVESTIGATION-INSIDER TRADING',
				'INVESTIGATION-KIDNAPPING',
				'INVESTIGATION-MONEY LAUNDERING',
				'INVESTIGATION-MURDER',
				'INVESTIGATION-ORGANIZED CRIME',
				'INVESTIGATION-PIRACY',
				'INVESTIGATION-PORNOGRAPHY',
				'INVESTIGATION-PRICE MANIPULATION',
				'INVESTIGATION-RICO',
				'INVESTIGATION-SECURITIES FRAUD',
				'INVESTIGATION-SMUGGLING',
				'INVESTIGATION-STOLEN PROPERTY',
				'INVESTIGATION-TAX EVASION',
				'INVESTIGATION-TERRORISM',
				'INVESTIGATION-WAR CRIMES',
				'PEP-ARMS TRAFFICKING',
				'PEP-BRIBERY',
				'PEP-BURGLARY',
				'PEP-CONSPIRACY',
				'PEP-CORRUPTION',
				'PEP-COUNTERFEITING',
				'PEP-DRUG TRAFFICKING',
				'PEP-EMBEZZLEMENT',
				'PEP-ESPIONAGE',
				'PEP-EXPLOSIVES',
				'PEP-EXTORT-RACK-THREATS',
				'PEP-FINANCIAL CRIMES',
				'PEP-FORGERY',
				'PEP-FRAUD',
				'PEP-FUGITIVE',
				'PEP-GAMBLING OPERATIONS',
				'PEP-HEALTHCARE FRAUD',
				'PEP-INSIDER TRADING',
				'PEP-INTERSTATE COMMERCE',
				'PEP-KIDNAPPING',
				'PEP-MONEY LAUNDERING',
				'PEP-MURDER',
				'PEP-ORGANIZED CRIME',
				'PEP-PEONAGE',
				'PEP-PHARMA TRAFFICKING',
				'PEP-PORNOGRAPHY',
				'PEP-RICO',
				'PEP-TERRORISM',
				'PEP-WAR CRIMES',
				'SANCTION LIST-N/A'];



EXPORT ExcludeSrcs := ['D'];



END;
