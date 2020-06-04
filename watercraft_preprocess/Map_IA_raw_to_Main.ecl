import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates ia_phase01_update.mp Ab intio graph into ECL

transaction_type_desc(string1 code)
:= case(code,
'0' => 'NO FEE',
'1' => 'NEW',
'2' => 'RENEW',
'3' => 'TRANSFER',
'4' => 'RENEW & TRANSFER',
'5' => 'DUPLICATE',
'6' => 'NAME/ADDRESS CHANGE',
'7' => 'RENEW WITHOUT CHANGE',
'8' => 'UNUSED',
'9' => 'TYPE CHANGE',
'' );
					
					
county_reg(string2 code)
:= case(code, 	
'1' => 'ADAIR',
'2' => 'ADAMS',
'3' => 'ALAMAKEE',
'4' => 'APPANOOSE',
'5' => 'AUDUBON',
'6' => 'BENTON',
'7' => 'BLACK HAWK',
'8' => 'BOONE',
'9' => 'BREMER',
'10' => 'BUCHANAN',
'11' => 'BUENA VISTA',
'12' => 'BUTLER',
'13' => 'CALHOUN',
'14' => 'CARROLL',
'15' => 'CASS',
'16' => 'CEDAR',
'17' => 'CERRO GORDO',
'18' => 'CHEROKEE',
'19' => 'CHICKASAW',
'20' => 'CLARKE',
'21' => 'CLAY',
'22' => 'CLAYTON',
'23' => 'CLINTON',
'24' => 'CRAWFORD',
'25' => 'DALLAS',
'26' => 'DAVIS',
'27' => 'DECATUR',
'28' => 'DELAWARE',
'29' => 'DES MOINES',
'30' => 'DICKINSON',
'31' => 'DUBUQUE',
'32' => 'EMMET',
'33' => 'FAYETTE',
'34' => 'FLOLYD',
'35' => 'FRANKLIN',
'36' => 'FREMONT',
'37' => 'GREENE',
'38' => 'GRUNDY',
'39' => 'GUTHRIE',
'40' => 'HAMILTON',
'41' => 'HANCOCK',
'42' => 'HARDIN',
'43' => 'HARRISON',
'44' => 'HENRY',
'45' => 'HOWARD',
'46' => 'HUMBOLDT',
'47' => 'IDA',
'48' => 'IOWA',
'49' => 'JACKSON',
'50' => 'JASPER',
'51' => 'JEFFERSON',
'52' => 'JOHNSON',
'53' => 'JONES',
'54' => 'KEOKUK',
'55' => 'KOSSUTH',
'56' => 'LEE',
'57' => 'LINN',
'58' => 'LOUISA',
'59' => 'LUCAS',
'60' => 'LYON',
'61' => 'MADISON',
'62' => 'MAHASKA',
'63' => 'MARION',
'64' => 'MARSHALL',
'65' => 'MILLS',
'66' => 'MITCHELL',
'67' => 'MONONA',
'68' => 'MONROE',
'69' => 'MONTGOMERY',
'70' => 'MUSCATINE',
'71' => 'OBRIEN',
'72' => 'OSCEOLA',
'73' => 'PAGE',
'74' => 'PALO ALTO',
'75' => 'PLYMOUTH',
'76' => 'POCAHONTAS',
'77' => 'POLK',
'78' => 'POTTAWATTAMIE',
'79' => 'POWESHIEK',
'80' => 'RINGGOLD',
'81' => 'SAC',
'82' => 'SCOTT',
'83' => 'SHELBY',
'84' => 'SIOUX',
'85' => 'STORY',
'86' => 'TAMA',
'87' => 'TAYLOR',
'88' => 'UNION',
'89' => 'VAN BUREN',
'90' => 'WAPELLO',
'91' => 'WARREN',
'92' => 'WASHINGTON',
'93' => 'WAYNE',
'94' => 'WEBSTER',
'95' => 'WINNEBAGO',
'96' => 'WINNESHIEK',
'97' => 'WOODBURY',
'98' => 'WORTH',
'99' => 'WRIGHT',
'' );  
				
boat_desc ( string bt_type) 
:= case(bt_type,
'1' => 'CABIN CRUISER',       
'2'	=> 'CANOE',               
'3'	=> 'PERSONAL WATERCRAFT', 
'4'	=> 'HOUSEBOAT',           
'5'	=> 'PONTOON',             
'6'	=> 'ROWBOAT',             
'7'	=> 'RUNABOUT',            
'8'	=> 'SAILBOAT',            
'9'	=> 'OTHER',               
'10'=> 'KAYAK',               
'11'=> 'BASS BOAT',           
'12'=> 'JON BOAT',            
'');


reg_status_desc( string code) 
:= case(code,
'5'	=> 'NEW',                   
'10'	=> 'RENEWED',        
'15'	=> 'TRANSFERRED',                     
'17'	=> 'DUPLICATE ISSUED',                   
'19'	=> 'IN STORAGE',                
'20'	=> 'CANCELED-SOLD',
'21'	=> 'CANCELED-TRADED',                
'22'	=> 'CANCELED-DONATED',                
'23'	=> 'CANCELED-SOLD OUT OF STATE',                
'24'	=> 'CANCELED-ABANDONED',                
'25'	=> 'CANCELED-DESTROYED',                
'26'	=> 'CANCELED-LOST',                
'27'	=> 'CANCELED-OTHER',                
'28'	=> 'CANCELED-GAVE AWAY',                
'29'	=> 'CANCELED-SOLD TO DEALER',                
'35'	=> 'STOLEN',                
'40'	=> 'RECOVERED',                
'45'	=> 'SALVAGE', 
'50'	=> 'ACTIVE',                
'80'	=> 'REGISTRATION DENIED',                
'85'	=> 'FLAGGED INVESTIGATE YES',                        
 '90'	=> 'FLAGGED INVESTIGATE NO',                        
  '95'	=> 'EXPIRED',                 
'135'	=> 'UNKNOWN DISPOSITION',                  

'');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_IA_clean_in,Watercraft.Layout_IA_new, hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key		:=	stringlib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
																													// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV+trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																														// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30])),' ','');                                        
	self.watercraft_key			:=	IF(L.HULL_ID = '', trim(L.REG_NUM,left,right), if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
	                               (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]));
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'IA';
	self.source_code				:=	'AW';
	self.st_registration		:=	L.STATEABREV;
	
	self.county_registration	:=	county_reg(trim(L.COUNTY));
	self.registration_number	:=	trim(L.REG_NUM,left,right);
	self.hull_number					:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	//self.vehicle_type_Description	:=	map(L.VEH_TYPE <> '' and L.VEH_TYPE <> 'CABIN' => L.VEH_TYPE,
	   //                                   L.BOAT_TYPE <> '' and L.VEH_TYPE = 'CABIN' => boat_desc(L.BOAT_TYPE),
																			//	'');
	self.fuel_description				:=	L.FUEL;
	self.hull_type_description	:=	L.HULL;
	self.use_description				:=	L.USE_1;
	self.watercraft_length			:=	L.TOTAL_INCH;
	self.model_year							:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_model_description	:=	L.MODEL;
	//self.watercraft_width							:=	L.BOAT_WIDTH;
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date						:=	If(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate									:=	STD.DATE.IsValidDate((integer)L.EXPIRATION_Date);
	self.registration_expiration_date	:=	If(IsValidExpireDate,L.EXPIRATION_Date,'');
	self.registration_status_code			:=	L.REG_STATUS;
	self.registration_status_description	:=	reg_status_desc(trim(L.REG_STATUS));
	self.title_number							:=	IF(L.TITLE_NUMBER <> '000000000', L.TITLE_NUMBER,'');
	IsValidTitleDate							:=	STD.DATE.IsValidDate((integer)L.ISSUE_DATE);
	self.title_issue_date					:=	If(IsValidTitleDate,L.ISSUE_DATE,'');
	self.title_type_code					:=	L.REG_TYPE;
	self.title_type_description		:=	case(trim(L.REG_TYPE),
	                                                                                                    '5' => 'REGISTRATION',
																				'10' => 'TITLE AND REGISTRATION',
																				'32' => 'DOCUMENTED',
																				'');
	self.watercraft_status_code      := L.RECORD_STATUS;
	self.watercraft_status_description := case(trim(L.RECORD_STATUS),
	                                                                                                                 '4' => 'COMPLETE',
																						'');
	self := L;
	self := [];
  end;

EXPORT Map_IA_raw_to_Main := project(hull_clean_in, main_mapping_format(left));