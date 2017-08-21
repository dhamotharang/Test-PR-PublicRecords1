import watercraft;

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

'01' => 'ADAIR',
'02' => 'ADAMS',
'03' => 'ALAMAKEE',
'04' => 'APPANOOSE',
'05' => 'AUDUBON',
'06' => 'BENTON',
'08' => 'BOONE',
'09' => 'BREMER',
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
				
boat_desc ( string1 bt_type) 

:= case(bt_type,

'1' => 'Cabin Cruiser',       
'2'	=> 'Canoe',               
'3'	=> 'Personal Watercraft', 
'4'	=> 'Houseboat',           
'5'	=> 'Pontoon',             
'6'	=> 'Rowboat',             
'7'	=> 'Runabout',            
'8'	=> 'Sailboat',            
'9'	=> 'Other',               
'10'=> 'Kayak',               
'11'=> 'Bass Boat',           
'12'=> 'Jon Boat',            
'');


reg_status_desc( string1 code) 

:= case(code,

'1'	=> 'Active',                   
'2'	=> 'Sold Out of State',        
'3'	=> 'Lost',                     
'4'	=> 'Stolen',                   
'5'	=> 'Cancelled',                
'6'	=> 'Abandoned',                
'7'	=> 'Inactive',                 
'8'	=> 'Storage',                  
'9'	=> 'Transferred Out of County',
'10'=> 'Destroyed/Junked',         
'');

trim2upper (string s) := function

return StringLib.StringtoUpperCase(trim(s));
end;


Watercraft.Macro_Clean_Hull_ID(watercraft.file_IA_clean_in, watercraft.Layout_IA_clean_in,hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform


    self.watercraft_key				        :=	if(L.HULL_ID = '', trim(L.REG_NUM, left, right), if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left, right),
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]));                                          
	self.sequence_key				            :=	trim(L.REG_DATE[1..6], left, right);
	self.watercraft_id						      :=	'';
	self.state_origin						        :=	'IA';
	self.source_code						        :=	'AW';
	self.st_registration					      :=	L.STATEABREV;
	self.county_registration				    :=	county_reg(trim(L.county));
	self.registration_number				    :=	trim(L.REG_NUM, left, right);
	self.hull_number						        :=	L.hull_id;
	self.propulsion_code					      :=	case ( trim2upper(L.PROP) ,
	                                                        'OUTBOARD' => '1',
																													'INBOARD'  => '2',
																													'OUTBOARD/INBOARD' => '3',
																													'SAIL' => '4',
																													'OTHER NONPOWER/NONSAIL' => '5',
																													'PADDLE/OAR' => '6',
																													'');
	self.propulsion_description				  :=	L.PROP;
	self.vehicle_type_Code					    :=	'';
	self.vehicle_type_Description			  :=	map ( L.VEH_TYPE <> '' and L.VEH_TYPE <> 'CABIN' => L.VEH_TYPE,
	                                               L.BOAT_TYPE <> '' and L.VEH_TYPE = 'CABIN' => trim2upper(boat_desc(L.BOAT_TYPE)),
																								 '');
	self.fuel_code							        :=	     case(trim2upper(L.FUEL) ,
	                                             'GAS' => '1',
																							  'DIESEL' => '2',
																								'OTHER' => '3','');
	self.fuel_description					      :=	L.FUEL;
	self.hull_type_code						      :=	case( trim2upper(L.HULL) ,
	                                                'ALUMINIUM' => '1',
																									'FIBERGLASS' => '2',
																									'WOOD'       => '3',
																									'STEEL'      => '4',
																									'PLASTIC'    => '5',
																									'OTHER'      => '6',
																									'UNKNOWN'    => '7',
																									'');
	self.hull_type_description				:=	L.HULL;
	self.use_code							        :=	 case ( trim2upper(L.USE_1) ,
	                                                  'PLEASURE' => '1',
																										'DEALER'   => '2',
																										'LIVERY RENTAL' => '3',
																										'OFFICIAL'     => '4',
																										'COMMERCIAL PASSENGER' => '5',
																										'COMMERCIAL FISHING'  => '6',
																										'OTHER'  => '7',
																										'');
	self.use_description					     :=	L.USE_1;
	self.watercraft_length					   :=	L.TOTAL_INCH;
	self.model_year							       :=	L.YEAR;
	self.watercraft_name					      :=	'';
	self.watercraft_class_code				  :=	'';
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	L.MODEL;
	self.watercraft_width					:=	L.Boat_WIDTH;
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	'';
	self.watercraft_color_1_description		:=	'';
	self.watercraft_color_2_code			:=	'';
	self.watercraft_color_2_description		:=	'';
	self.watercraft_toilet_code				:=	L.TOILET;
	self.watercraft_toilet_description		:=	case(L.TOILET, 'N' => 'BOAT HAS NO TOILET', 'Y' => 'BOAT HAS TOILET', '');
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	'';
	self.watercraft_hp_2					:=	'';
	self.watercraft_hp_3					:=	'';
	self.engine_number_1					:=	'';
	self.engine_number_2					:=	'';
	self.engine_number_3					:=	'';
	self.engine_make_1						:=	'';
	self.engine_make_2						:=	'';
	self.engine_make_3						:=	'';
	self.engine_model_1						:=	'';
	self.engine_model_2						:=	'';
	self.engine_model_3						:=	'';
	self.engine_year_1						:=	'';
	self.engine_year_2						:=	'';
	self.engine_year_3						:=	'';
	self.coast_guard_documented_flag		:=	'';
	self.coast_guard_number					:=	'';
	self.registration_date					:=	L.REG_DATE[1..6];
	self.registration_expiration_date		:=	L.Expiration_Date;
	self.registration_status_code			:=	L.REG_STATUS;
	self.registration_status_description	:=	trim2upper(reg_status_desc(L.REG_STATUS));
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	 L.DECAL_number;
	self.transaction_type_code				:=	L.Transaction_Code;
	self.transaction_type_description		:=	transaction_type_desc(L.Transaction_Code);
	self.title_state						:=	'';
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
	self.title_number						:=	if(L.Title_Number <> '000000000', L.Title_Number,'');
	self.title_issue_date					:=	L.ISSUE_DATE[1..6];
	self.title_type_code					:=	L.REG_TYPE;
	self.title_type_description				:=	case( L.REG_TYPE,
	                                                       '1' => 'REGULAR',
																												 '2'  => 'DNR',
																												  '3' => 'FARM',
																													'4' => 'DOCUMENTED',
																													'5' => 'TITLE ONLY',
																													'');
	self.watercraft_status_code      := L.Record_status;
	self.watercraft_status_description := case (  L.Record_status,
	                                                           '1' => 'CURRENT',
																														 '2' => 'PREVIOUS','');
	                                                           
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	'';
	self.lien_1_name						:=	'';
	self.lien_1_date						:=	'';
	self.lien_1_address_1					:=	'';
	self.lien_1_address_2					:=	'';
	self.lien_1_city						:=	'';
	self.lien_1_state						:=	'';
	self.lien_1_zip							:=	'';
	self.lien_2_indicator					:=	'';
	self.lien_2_name						:=	'';
	self.lien_2_date						:=	'';
	self.lien_2_address_1					:=	'';
	self.lien_2_address_2					:=	'';
	self.lien_2_city						:=	'';
	self.lien_2_state						:=	'';
	self.lien_2_zip							:=	'';
	self.state_purchased					:=	'';
	self.purchase_date						:=	'';
	self.dealer								:=	'';
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
    
  end;



export Mapping_IA_as_Main := project(hull_clean_in, main_mapping_format(left));


