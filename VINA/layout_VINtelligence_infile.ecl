EXPORT layout_VINtelligence_infile := RECORD
	STRING64		VIN_SIGNI_PATTRN_MASK;						//1       1-64                  VIN_SIGNI_PATTRN_MASK                 VIN Prefix that includes the significant digits of the VIN 
	STRING4			NCI_MAK_ABBR_CD;								  //2       66-69                 NCI_MAK_ABBR_CD  make_abbreviation    Contains the Polk standardized abbreviation for the OEMs vehicle make.  The vehicle make generally contains what the general public usually considers to be a vehicle brand name, for example, Chrysler, Dodge, Ford, Mercury, Toyota, GMC, Chevy, Cadillac, a 
	STRING4			MDL_YR;														//3       71-74      						MDL_YR                                Contains the marketing year defined by the OEM within which the vehicle was produced.  The value contained in this attribute may not always exactly match the calendar year in which the vehicle was actually manufactured.  For example, many large North Amer 
	STRING1			VEH_TYP_CD;												//4       76-95    							VEH_TYP_CD                            A Polk assigned code that defines the type of a vehicle represented by a specific VIN.  For example:  M,P,C or T.   
	STRING250		VEH_TYP_DESC;											//5       97-346          			VEH_TYP_DESC                          The description of the Polk assigned code for the vehicle type code. For example: passenger, truck, motorcycle, commercial trailer.      
	STRING50		MAK_NM;														//6       348-397 							MAK_NM                                (Make - Name) Full name of the make (i.e. Chevrolet) 
	STRING250		MDL_DESC;													//7       399-648               MDL_DESC                              (Model Code) medium description 
	STRING250		TRIM_DESC;												//8       650-899               TRIM_DESC                             The Trim of the vehicle 
	STRING250		OPT1_TRIM_DESC;										//9       901-1150              OPT1_TRIM_DESC                         The trim of the vehicle.  This field is used when a VIN Pattern could have more than 1 trim assigned. 
	STRING250		OPT2_TRIM_DESC;										//10      1152-1401             OPT2_TRIM_DESC                         The trim of the vehicle.  This field is used when a VIN Pattern could have more than 2 trims assigned. 
	STRING250		OPT3_TRIM_DESC;										//11      1403-1652             OPT3_TRIM_DESC                         The trim of the vehicle.  This field is used when a VIN Pattern could have more than 3 trims assigned. 
	STRING250		OPT4_TRIM_DESC;										//12      1654-1903             OPT4_TRIM_DESC                         The trim of the vehicle.  This field is used when a VIN Pattern could have more than 4 trims assigned. 
	STRING20		BODY_STYLE_CD;										//13      1905-1924             BODY_STYLE_CD                         A Polk assigned code that describes the specification of how a trailer is to be used, based on the body style. For example, DB=Dump Bottom. 
	STRING250		BODY_STYLE_DESC;									//14      1926-2175             BODY_STYLE_DESC                       The description of the availability of Running Lights.  For example Not Available, Optional, etc. 
	STRING2			DOOR_CNT;													//15      2177-2178             DOOR_CNT                              The description of the Polk assigned code that indicates the availability of Power Windows, based on Make, Year, and Model Trim assigned by the VIN Team based on OEM vehicle specifications or secondary research.  For example Not Available, Optional, etc. 
	STRING2			WHL_CNT;													//16      2180-2181             WHL_CNT                               The number of wheel ends on the vehicle.  For example in a 6x4 configuration this would be the 6.   
	STRING2			WHL_DRVN_CNT;											//17      2183-2184             WHL_DRVN_CNT                          Number of wheels driven by the power train.  For example in a 6x4 configuration this would be the 4.  
	STRING20		MFG_CD;														//18      2186-2205             MFG_CD                                (Vehicle Manufacturer Name) Standard abbreviation of the name of the vehicle manufacturer, i.e. General Motors, as defined by the National Crime Information Center 
	STRING250		MFG_DESC;													//19      2207-2456             MFG_DESC                              (Vehicle Manufacturer Name) The name of the vehicle manufacturer, i.e. General Motors, as defined by the National Crime Information Center 
	STRING5			ENG_DISPLCMNT_CI;									//20      2458-2462             ENG_DISPLCMNT_CI                      (Displacement CID) displacement in cubic inches. This is a rounded, marketing value, like 302 cubic inches, instead of 4967 cc. 
	STRING5			ENG_DISPLCMNT_CC;									//21      2464-2468             ENG_DISPLCMNT_CC                      (Displacement CC) displacement in cubic centimeters. We intend to use this as the definitive, exact diplacement value, i.e. 4967 cc. 
	STRING5			ENG_CLNDR_RTR_CNT;								//22      2470-2474             ENG_CLNDR_RTR_CNT                     Contains a code that represents the number of cylinders a vehicles combustion engine can have. 
	STRING1			ENG_CYCL_CNT;											//23      2476-2476             ENG_CYCL_CNT                          (Cycle Count) Refers to the cycle or stroke of an engine. 2-strokes are lightweight and simpler, but they burn oil, by design. Few cars on the road in North America are two-strokes, the last one offered was a 1967 Saab. These days, usually used in chainsa 
	STRING1			ENG_FUEL_CD;											//24      2478-2478             ENG_FUEL_CD                           (Fuel) What an internal combustion burns to move a piston in a cylinder 
	STRING250		ENG_FUEL_DESC;										//25      2480-2729             ENG_FUEL_DESC                         (Fuel) description 
	STRING3			ENG_FUEL_INJ_TYP_CD;							//26      2731-2733             ENG_FUEL_INJ_TYP_CD                   The type of fuel injection 
	STRING250		ENG_FUEL_INJ_TYP_DESC;						//27      2735-2984             ENG_FUEL_INJ_TYP_DESC                 The type of fuel injection used by a vehicle.  For example, Direct, Throttlebody 
	STRING250		ENG_CBRT_TYP_CD;									//28      2986-3235             ENG_CBRT_TYP_CD                       Carburation types include Carbureator Fuel Injection  N/A 
	STRING250		ENG_CBRT_TYP_DESC;								//29      3237-3486             ENG_CBRT_TYP_DESC                     The description of the Polk assigned code which identifies the vehicle carburetion type.   For example Carburator, Fuel Injection, Unknown or Electric n/a. 
	STRING20		ENG_CBRT_BRLS;										//30      3488-3507             ENG_CBRT_BRLS                         The number of barrels on a carbureted engine 
	STRING1			TRK_GRSS_VEH_WGHT_RATG_CD;				//31      3509-3509             TRK_GRSS_VEH_WGHT_RATG_CD             Contains a code that identifies the Polk standard groupings of gross vehicle weights to which a vehicle may belong.  This information is typically captured only for trucks.  Gross vehicle weight is defined as the empty weight of the vehicle, plus the maxi 
	STRING250		TRK_GRSS_VEH_WGHT_RATG_DESC;			//32      3511-3760             TRK_GRSS_VEH_WGHT_RATG_DESC           (Weight - GVW Rating) description 
	STRING6			WHL_BAS_SHRST_INCHS;							//33      3762-3767             WHL_BAS_SHRST_INCHS                   Contains the distance between the front and rear axles of a vehicle in inches of the base model of the vehicle. 
	STRING6			WHL_BAS_LNGST_INCHS;							//34      3769-3774             WHL_BAS_LNGST_INCHS                   Contains the longest distance between the front and rear axles of a vehicle in inches for a particular series of that vehicle. 
	STRING250		FRNT_TYRE_DESC;										//35      3776-4025             FRNT_TYRE_DESC                        more specific tire description (ex. Michelin Eagle P245/40ZR)Ã‚Â¿  
	STRING3			FRNT_TYRE_PRSS_LBS;								//36      4027-4029             FRNT_TYRE_PRSS_LBS                    (Front Tire Pressure) Vehicle Mfr reccomendation for tire pressure, in pounds/sq. in. 
	STRING7			FRNT_TYRE_SIZE_CD;								//37      4031-4037             FRNT_TYRE_SIZE_CD                     Describes the size of the front tire.  For example "17R245" 
	STRING250		FRNT_TYRE_SIZE_DESC;							//38      4039-4288             FRNT_TYRE_SIZE_DESC                   (Front Tire Size Description) As in "17R245" 
	STRING250		REAR_TIRE_DESC;										//39      4290-4539             REAR_TIRE_DESC                        more specific tire description (ex. Michelin Eagle P245/40ZR)Ã‚Â¿  
	STRING3			REAR_TIRE_PRSS_LBS;								//40      4541-4543             REAR_TIRE_PRSS_LBS                    (Rear Tire Pressure) Vehicle Mfr reccomendation for tire pressure, in pounds/sq. in. 
	STRING7			REAR_TIRE_SIZE_CD;								//41      4545-4551             REAR_TIRE_SIZE_CD                     The size of the rear tires.  example 17R245 
	STRING250		REAR_TIRE_SIZE_DESC;							//42      4553-4802             REAR_TIRE_SIZE_DESC                   (Rear Tire Size Description) As in "17R245" 
	STRING2			TRK_TNG_RAT_CD;										//43      4804-4805             TRK_TNG_RAT_CD                        Contains a code that represents the towing / payload capacity of the vehicle as defined in the OEM specifications.  This information is typically only captured for vehicles classified as trucks.(Tonnage Rating) This attribute records the Truck payload 
	STRING250		TRK_TNG_RAT_DESC;									//44      4807-5056             TRK_TNG_RAT_DESC                      (Tonnage Rating) description 
	STRING6			SHIP_WGHT_LBS;										//45      5058-5063             SHIP_WGHT_LBS                         Contains the base weight of the vehicle, rounded to the nearest one hundred pounds, as defined in the OEM specifications.  The base weight of a vehicle is the empty weight of the base model of the vehicle (i.e., the stripped down version of the vehicle  
	STRING6			SHIP_WGHT_VAR_LBS;								//46      5065-5070             SHIP_WGHT_VAR_LBS                     (Weight - Shipping Weight Variance) The difference between the shipping weights of the shortest and longest wheelbase for the model. Optional equipment weight is not included and currently shipping weight variance is only used on trucks. 
	STRING15		MFG_BAS_MSRP;											//47      5072-5086             MFG_BAS_MSRP                          Contains the base price of the vehicle as designated by the OEM specifications.  Base price includes only the price for the base model of the vehicle, excluding any optional equipment that may have been added as a result of the vehicle trim level 
	STRING15		PRIC_VAR;													//48      5088-5102             PRIC_VAR                              (Price Variance) This is the difference between the prices of the shortest wheel base and longest wheel base for the model. Incremental costs for optional equipment is not included. This is the result of a formula of average prices across models and how m 
	STRING3			DRV_TYP_CD;												//49      5104-5106             DRV_TYP_CD                            (Drive Type) This element describes type of driving configuration for cars and trucks such as FWD, AWD, RWD. 
	STRING250		DRV_TYP_DESC;											//50      5108-5357             DRV_TYP_DESC                          (Drive Type) description 
	STRING2			ISO_BASE_2010;										//51      5359-5360             ISO_BASE_2010                         Contains the two position ISO Unadjusted Base Symbol for 2010 and older model years 
	STRING2			ISO_BASE_2011;										//52      5362-5363             ISO_BASE_2011                         Contains the two position ISO Unadjusted Base Symbol for 2011 and newer model years 
	STRING2			ISO_COLL_SYMBOL;									//53      5365-5366             ISO_COLL_SYMBOL                       Contains the two position ISO Collision Symbol for 2011 and newer model years 
	STRING2			ISO_COMP_SYMBOL;									//54      5368-5369             ISO_COMP_SYMBOL                       Contains the two position ISO Comprehensive Symbol for 2011 and newer model years 
	STRING1			ISO_ROLL_IND;											//55      5371-5371             ISO_ROLL_IND                          It is common insurance industry practice to Ã‚Â¿roll overÃ‚Â¿ insurance symbols from the previous model year into the new model year. An Ã‚Â¿RÃ‚Â¿ is placed in this field to indicate that the ISO symbol for an existing series / model has been continued into the new model year and is not yet in the ISO country-wide book for the new model year. These symbols are phased out via normal software updates as the ISO symbols are updated and published.  This code is provided as a service to users, and use of the associated symbol is optional 
	STRING2			ISO_VSR_SYMBOL;										//56      5373-5374             ISO_VSR_SYMBOL                        Contains the two position ISO VSR Symbol for 2010 and older model years 
	STRING1			ISO_PERFORMANCE_IND;							//57      5376-5376             ISO_PERFORMANCE_IND                   Contains the one position ISO High Performance Code 4 = Sporty premium (This previously coded as a Ã‚Â¿PÃ‚Â¿)2 = High Performance (This previously coded as an Ã‚Â¿HÃ‚Â¿)1= Intermediate (This previously coded as an Ã‚Â¿IÃ‚Â¿)3= Sporty (This previously coded as an Ã‚Â¿SÃ‚Â¿) 
	STRING3			SALE_CNTRY_CD;										//58      5378-5380             SALE_CNTRY_CD                         (Country Sold / Specific Market) Country where the vehicle is planned to be sold (may have different emissions standards). 
	STRING250		SALE_CNTRY_DESC;									//59      5382-5631             SALE_CNTRY_DESC                       (Country Sold / Specific Market) description 
	STRING1			AIR_COND_OPT_CD;									//60      5633-5633             AIR_COND_OPT_CD                       (Air Conditioning) A single position code that indicates the availability of Air Conditioning, based on Make, Year, and Model TrimUsed in VIN Plus 
	STRING250		AIR_COND_OPT_DESC;								//61      5635-5884             AIR_COND_OPT_DESC                     (Air Conditioning) description 
	STRING1			PWR_STRNG_OPT_CD;									//62      5886-5886             PWR_STRNG_OPT_CD                      (Steering - Power Steering) A single position code that indicates availability of Power Steering. This is based on Trim Level  
	STRING250		PWR_STRNG_OPT_DESC;								//63      5888-6137             PWR_STRNG_OPT_DESC                    The description of the Polk assigned code that indicates the availability of Power Steering.  For example Not Available, Optional, etc. 
	STRING1			PWR_BRK_OPT_CD;										//64      6139-6139             PWR_BRK_OPT_CD                        (Brakes- Power Brakes) A code that indicates the availability of power brakes as a vehicle option. 
	STRING250		PWR_BRK_OPT_DESC;									//65      6141-6390             PWR_BRK_OPT_DESC                      The description of the Polk assigned code that indicates the availability of Power Brakes.  For example Not Available, Optional, etc. 
	STRING1			PWR_WNDW_OPT_CD;									//66      6392-6392             PWR_WNDW_OPT_CD                       (Windows- Power Windows) A list of Polk assigned codes that describe the standard and optional power windows for this model(if any). 
	STRING250		PWR_WNDW_OPT_DESC;								//67      6394-6643             PWR_WNDW_OPT_DESC                     The description of the Polk assigned code that indicates the availability of Power Windows, based on Make, Year, and Model Trim assigned by the VIN Team based on OEM vehicle specifications or secondary research.  For example Not Available, Optional, etc. 
	STRING1			TLT_STRNG_WHL_OPT_CD;							//68      6645-6645             TLT_STRNG_WHL_OPT_CD                  (Steering - Tilt Steering Wheel) A single position code that indicates availability of Tilt Steering. 
	STRING250		TLT_STRNG_WHL_OPT_DESC;						//69      6647-6896             TLT_STRNG_WHL_OPT_DESC                The description for the availability of Tilt Wheel Steering.  For example Not Available, Optional, etc. 
	STRING20		ROOF_CD;													//70      6898-6917             ROOF_CD                               Code that represents the  type of roof that is standard on the base model/trim of the vehicle. 1= None / not available2 = Manual sun / moon roof3= Power sun / moon roof4= Removable panels5= Removable roof6= Retractable roof panel7= Other / unknown 
	STRING250		ROOF_DESC;												//71      6919-7168             ROOF_DESC                             Description of ROOF_CD that represents the  type of roof that is standard on the base model/trim of the vehicle.  
	STRING20		OPT1_ROOF_CD;											//72      7170-7189             OPT1_ROOF_CD                          Code that represents the  type of roof that is optional of the vehicle.  
	STRING250		OPT1_ROOF_DESC;										//73      7191-7440             OPT1_ROOF_DESC                        Description of  OPT1_ROOF_CD that represents the  type of roof that is optional on the vehicle.  
	STRING20		OPT2_ROOF_CD;											//74      7442-7461             OPT2_ROOF_CD                          Code that represents the  type of roof that is optional of the vehicle.  
	STRING250		OPT2_ROOF_DESC;										//75      7463-7712             OPT2_ROOF_DESC                        Description of  OPT2_ROOF_CD that represents the  type of roof that is optional on the vehicle.  
	STRING20		OPT3_ROOF_CD;											//76      7714-7733             OPT3_ROOF_CD                          Code that represents the  type of roof that is optional of the vehicle.  
	STRING250		OPT3_ROOF_DESC;										//77      7735-7984             OPT3_ROOF_DESC                        Description of  OPT3_ROOF_CD that represents the  type of roof that is optional on the vehicle.  
	STRING20		OPT4_ROOF_CD;											//78      7986-8005             OPT4_ROOF_CD                          Code that represents the  type of roof that is optional of the vehicle.  
	STRING250		OPT4_ROOF_DESC;										//79      8007-8256             OPT4_ROOF_DESC                        Description of  OPT4_ROOF_CD that represents the  type of roof that is optional on the vehicle.  
	STRING20		ENTERTAIN_CD;											//80      8258-8277             ENTERTAIN_CD                          Code that represents the type of entertainment system that is standard on the base model/trim of the vehicle 1 = None2 = AM3 = AM / FM4 = AM / FM Cassette5 = AM / FM CD6 = Unknown7 = Satellite8 = AM/FM CASS/CD9 = AM/FM CD/DVDA = AM/FM CD/MP3 
	STRING250		ENTERTAIN_DESC;										//81      8279-8528             ENTERTAIN_DESC                        Description of ENTERTAIN_CD; Indicates the type of entertainment system that is standard on the base model/trim of the vehicle  
	STRING20		OPT1_ENTERTAIN_CD;								//82      8530-8549             OPT1_ENTERTAIN_CD                     Code that represents the type of entertainment system that is optional on the model/trim of the vehicle  
	STRING250		OPT1_ENTERTAIN_DESC;							//83      8551-8800             OPT1_ENTERTAIN_DESC                   Description of OPT1_ENTERTAIN_CD; Indicates the type of entertainment system that is optional on the model/trim of the vehicle  
	STRING20		OPT2_ENTERTAIN_CD;								//84      8802-8821             OPT2_ENTERTAIN_CD                     Code that represents the type of entertainment system that is optional on the model/trim of the vehicle  
	STRING250		OPT2_ENTERTAIN_DESC;							//85      8823-9072             OPT2_ENTERTAIN_DESC                   Description of OPT2_ENTERTAIN_CD; Indicates the type of entertainment system that is optional on the model/trim of the vehicle  
	STRING20		OPT3_ENTERTAIN_CD;								//86      9074-9093             OPT3_ENTERTAIN_CD                     Code that represents the type of entertainment system that is optional on the model/trim of the vehicle  
	STRING250		OPT3_ENTERTAIN_DESC;							//87      9095-9344             OPT3_ENTERTAIN_DESC                   Description of OPT3_ENTERTAIN_CD; Indicates the type of entertainment system that is optional on the model/trim of the vehicle  
	STRING20		OPT4_ENTERTAIN_CD;								//88      9346-9365             OPT4_ENTERTAIN_CD                     Code that represents the type of entertainment system that is optional on the model/trim of the vehicle  
	STRING250		OPT4_ENTERTAIN_DESC;							//89      9367-9616             OPT4_ENTERTAIN_DESC                   Description of OPT4_ENTERTAIN_CD; Indicates the type of entertainment system that is optional on the model/trim of the vehicle  
	STRING20		TRANS_CD;													//90      9618-9637             TRANS_CD                              Code that represents the  type of transmission that is standard on the base model/trim of the vehicle. (A = Automatic, M= Manual, U= Unknown)  
	STRING250		TRANS_DESC;												//91      9639-9888             TRANS_DESC                            Description of TRANS_CD that represents the  type of transmission that is standard on the base model/trim of the vehicle.  
	STRING20		TRANS_OVERDRV_IND;								//92      9890-9909             TRANS_OVERDRV_IND                     Indicates whether or not TRANS_CD has overdrive (Y,N) 
	STRING20		TRANS_SPEED_CD;										//93      9911-9930             TRANS_SPEED_CD                        Code value that signifies the speed of TRANS_CD( 5 = 5 Speed) 
	STRING20		TRANS_OPT1_CD;										//94      9932-9951             TRANS_OPT1_CD                         Code that represents the  type of transmission that is optional on the vehicle.  
	STRING250		TRANS_OPT1_DESC;									//95      9953-10202            TRANS_OPT1_DESC                       Description of  TRANS_OPT1_DESC that represents the  type of transmission that is optional on the vehicle.  
	STRING20		TRANS_OPT1_OVERDRV_IND;						//96      10204-10223           TRANS_OPT1_OVERDRV_IND                Indicates whether or not TRANS_OPT1_CD has overdrive (Y,N) 
	STRING20		TRANS_OPT1_SPEED_CD;							//97      10225-10244           TRANS_OPT1_SPEED_CD                   Code value that signifies the speed of TRANS_OPT1_CD( 5 = 5 Speed) 
	STRING20		TRANS_OPT2_CD;										//98      10246-10265           TRANS_OPT2_CD                         Code that represents the  type of transmission that is optional on the vehicle.  
	STRING250		TRANS_OPT2_DESC;									//99      10267-10516           TRANS_OPT2_DESC                       Description of  TRANS_OPT2_DESC that represents the  type of transmission that is optional on the vehicle.  
	STRING20		TRANS_OPT2_OVERDRV_IND;						//100     10518-10537           TRANS_OPT2_OVERDRV_IND                Indicates whether or not TRANS_OPT2_CD has overdrive (Y,N) 
	STRING20		TRANS_OPT2_SPEED_CD;							//101     10539-10558           TRANS_OPT2_SPEED_CD                   Code value that signifies the speed of TRANS_OPT2_CD( 5 = 5 Speed) 
	STRING20		TRANS_OPT3_CD;										//102     10560-10579           TRANS_OPT3_CD                         Code that represents the  type of transmission that is optional on the vehicle.  
	STRING250		TRANS_OPT3_DESC;									//103     10581-10830           TRANS_OPT3_DESC                       Description of  TRANS_OPT3_DESC that represents the  type of transmission that is optional on the vehicle.  
	STRING20		TRANS_OPT3_OVERDRV_IND;						//104     10832-10851           TRANS_OPT3_OVERDRV_IND                Indicates whether or not TRANS_OPT3_CD has overdrive (Y,N) 
	STRING20		TRANS_OPT3_SPEED_CD;							//105     10853-10872           TRANS_OPT3_SPEED_CD                   Code value that signifies the speed of TRANS_OPT3_CD( 5 = 5 Speed) 
	STRING20		TRANS_OPT4_CD;										//106     10874-10893           TRANS_OPT4_CD                         Code that represents the  type of transmission that is optional on the vehicle.  
	STRING250		TRANS_OPT4_DESC;									//107     10895-11144           TRANS_OPT4_DESC                       Description of  TRANS_OPT4_DESC that represents the  type of transmission that is optional on the vehicle.  
	STRING20		TRANS_OPT4_OVERDRV_IND;						//108     11146-11165           TRANS_OPT4_OVERDRV_IND                Indicates whether or not TRANS_OPT4_CD has overdrive (Y,N) 
	STRING20		TRANS_OPT4_SPEED_CD;							//109     11167-11186           TRANS_OPT4_SPEED_CD                   Code value that signifies the speed of TRANS_OPT4_CD( 5 = 5 Speed) 
	STRING1			ABS_BRK_CD;												//110     11188-11188           ABS_BRK_CD                            (Brakes- ABS Code) A code that describes wether a vehicle has or does not have anti-lock brakes, and what kind of brakes they are. (Not coded for heavy truck).This is based on the series code that is assigned the vehicle from VINA. 
	STRING250		ABS_BRK_DESC;											//111     11190-11439           ABS_BRK_DESC                          (Brakes- ABS Code) description 
	STRING1			SECUR_TYP_CD;											//112     11441-11441           SECUR_TYP_CD                          (Security Type) Describes the security system (if any) installed on this model. 
	STRING250		SECUR_TYP_DESC;										//113     11443-11692           SECUR_TYP_DESC                        (Security Type) description 
	STRING1			DR_LGHT_OPT_CD;										//114     11694-11694           DR_LGHT_OPT_CD                        The description for the availability of Tilt Wheel Steering.  For example Not Available, Optional, etc. 
	STRING250		DR_LGHT_OPT_DESC;									//115     11696-11945           DR_LGHT_OPT_DESC                      The description for the manufacturers assigned Gross Vehicle Weight (GVW) for trucks.  This rating may or may not equal the actual GVW. 
	STRING1			RSTRNT_TYP_CD;										//116     11947-11947           RSTRNT_TYP_CD                         (Restraint Type) A Polk assigned code that identifies the type of restraints that a vehicle has based on VIN. 
	STRING250		RSTRNT_TYP_DESC;									//117     11949-12198           RSTRNT_TYP_DESC                       (Restraint Type) description 
	STRING3			TRK_CAB_CNFG_CD;									//118     12200-12202           TRK_CAB_CNFG_CD                       (Cab Configuration) Cab Type describes the physical configuration of a truck cabin. 
	STRING250		TRK_CAB_CNFG_DESC;								//119     12204-12453           TRK_CAB_CNFG_DESC                     (Cab Configuration) medium description 
	STRING2			TRK_FRNT_AXL_CD;									//120     12455-12456           TRK_FRNT_AXL_CD                       (Axle- Type, Front Axle) The location of the front axle of a truck tractor. Setforward increases stabiliy on the highway, Setback increases maneuverability in tight spaces. 
	STRING250		TRK_FRNT_AXL_DESC;								//121     12458-12707           TRK_FRNT_AXL_DESC                     (Axle- Type, Front Axle) short description 
	STRING1			TRK_REAR_AXL_CD;									//122     12709-12709           TRK_REAR_AXL_CD                       (Axle- Type, Rear Axle) Represents rear axle configuration on a truck tractor. Tandem axles increase load bearing capability. 
	STRING250		TRK_REAR_AXL_DESC;								//123     12711-12960           TRK_REAR_AXL_DESC                     (Axle- Type, Rear Axle) short description 
	STRING3			TRK_BRK_TYP_CD;										//124     12962-12964           TRK_BRK_TYP_CD                        (Brake Type) The type of brakes on the Vehicle (currently commercial truck only). Truck VIN determines this currently 
	STRING250		TRK_BRK_TYP_DESC;									//125     12966-13215           TRK_BRK_TYP_DESC                      (Brake Type) description 
	STRING20		ENG_MFG_CD;												//126     13217-13236           ENG_MFG_CD                            (Mfr.) A Polk assigned code given to the orginal equipment manufacture of the within a vehicle 
	STRING250		ENG_MFG_DESC;											//127     13238-13487           ENG_MFG_DESC                          (Mfr.) description 
	STRING6			ENG_MDL_CD;												//128     13489-13494           ENG_MDL_CD                            (Model) A Polk assigned code given to the name that an manufacturer applies to a family of engines of the same type. 
	STRING250		ENG_MDL_DESC;											//129     13496-13745           ENG_MDL_DESC                          (Model) description 
	STRING2			ENG_TRK_DUTY_TYP_CD;							//130     13747-13748           ENG_TRK_DUTY_TYP_CD                   (Duty Type) A Polk assigned code that represents the duty type of a truck engine, based on manufacturer information 
	STRING250		ENG_TRK_DUTY_TYP_DESC;						//131     13750-13999           ENG_TRK_DUTY_TYP_DESC                 (Duty Type) medium description 
	STRING1			TRK_BED_LEN_CD;										//132     14001-14001           TRK_BED_LEN_CD                        (Bed Length) Code representing the manufacturers description of the relative size of the cargo area of a pickup truck or van. A "long" Ford Ranger bed (compact pickup) may well be shorter than a "short" bed on an F350. (large industrial pickup). 
	STRING250		TRK_BED_LEN_DESC;									//133     14003-14252           TRK_BED_LEN_DESC                      (Bed Length) description 
	STRING3			CMMRCL_TRLR_BODY_SPC_CD;					//134     14254-14256           CMMRCL_TRLR_BODY_SPC_CD               Indicates if the engine has a supercharger or not.  Yes, No or Unknown. 
	STRING250		CMMRCL_TRLR_BODY_SPC_DESC;				//135     14258-14507           CMMRCL_TRLR_BODY_SPC_DESC             Indicates if the engine has a turbocharger. Yes, No or Unknown. 
	STRING5			TRK_TRLR_AXL_CNT;									//136     14509-14513           TRK_TRLR_AXL_CNT                      (Axle- Count) Number of axles on a (truck or) commercial trailer. 
	STRING10		CMMRCL_TRLR_LEN;									//137     14515-14524           CMMRCL_TRLR_LEN                       The description of the Polk assigned code which identifies the vehicle carburetion type.   For example Carburator, Fuel Injection, Unknown or Electric n/a. ??
																								//																																		the length of the vehicle,rounded to the nearest foot, for only those vehicles identified as trailers
																								//																																		Can also be L20(Less than 20ft), 0X0(trailer is an extended trailer, not given exact length, UNK(unknown).
	STRING5			CMMRCL_TRLR_VSL_CPCT;							//138     14526-14530           CMMRCL_TRLR_VSL_CPCT                  The type of fuel injection used by a vehicle.  For example, Direct, Throttlebody 
	STRING1			CMMRCL_TRLR_VSL_MATR_CD;					//139     14532-14532           CMMRCL_TRLR_VSL_MATR_CD               The description of the Polk assigned code that indicates the availability of Power Brakes.  For example Not Available, Optional, etc. 
	STRING250		CMMRCL_TRLR_VSL_MATR_DESC;				//140     14534-14783           CMMRCL_TRLR_VSL_MATR_DESC             The description of the Polk assigned code that indicates the availability of Power Steering.  For example Not Available, Optional, etc. 
	STRING17		VEH_VIN_POS_DESC;									//141     14785-14801           VEH_VIN_POS_DESC                      The names of the specific positions of the VIN pattern.  For example: OMVCSBREKYPNNNNNN, or  OMVSGEXBKYPNNNNNN.  VIN patterns vary based on manufacturer and vehicle type.  The names of the positions do not vary.  Where OMV    = WMI CODE (O OEM; M Make; V Vehicle)C          = CARLINE       S          = SERIESB          = BODYR          = RESTRAINTE          = ENGINEK         = CHECK DIGITY          =YEAR     P          =PLANT   G          =GVWN          =BASE NUMBER 
	STRING1			SEGMENTATION_CD;									//142     14803-14803           SEGMENTATION_CD                       The Polk standard segmentation code 
	STRING50		SEGMENTATION_DESC;								//143     14805-14854           SEGMENTATION_DESC                     Description of SEGMENTATION_CODE that represents the Polk Standard Segmentation applied. 
	STRING2			PLNT_CD;													//144     14856-14857           PLNT_CD                               (Plant Code) Plant code where vehicle was manufactured. 
	STRING50		PLNT_CNTRY_NM;										//145     14859-14908           PLNT_CNTRY_NM                         (Country) This is the country where the plant is located. Example values are USA, Canada and Japan. 
	STRING50		PLNT_CITY_NM;											//146     14910-14959           PLNT_CITY_NM                          (City) This is the city where the plant is located. 
	STRING3			PLNT_ISO_CNTRY_CD;								//147     14961-14963           PLNT_ISO_CNTRY_CD                     A code value which is maintained in the RDM application. 
	STRING3			PLNT_STAT_PROV_CD;								//148     14965-14967           PLNT_STAT_PROV_CD                     A code value which is maintained in the RDM application. 
	STRING50		PLNT_STAT_PROV_NM;								//149     14969-15018           PLNT_STAT_PROV_NM                     (State or Province) This is the state or province (Canada) location of the plant. 
	STRING1			ORGN_CD;													//150     15020-15020           ORGN_CD                               (Origin) A code that indicates the origin of a vehicle. 
	STRING250		ORGN_DESC;												//151     15022-15271           ORGN_DESC                             (Origin) description 
	STRING5			ENG_DISPLCMNT_CL;									//152     15273-15277           ENG_DISPLCMNT_CL                      (Displacement Liters) displacement in rounded Liters, where 1,000 cubic centimeters = 1 liter. Even domestic makes will advertise displacement in terms of liters (e.g. 5.0 liter mustang, which equates to a 302 CID or 4967 cc displacement). 
	STRING4			ENG_BLCK_TYP_CD;									//153     15279-15282           ENG_BLCK_TYP_CD                       The engine (Block Type) Describes the block type based on the cylinder arrangement: In-Line or "V"  
	STRING250		ENG_BLCK_TYP_DESC;								//154     15284-15533           ENG_BLCK_TYP_DESC                     The engine (Block Type) Description 
	STRING4			ENG_HEAD_CNFG_CD;									//155     15535-15538           ENG_HEAD_CNFG_CD                      (Head Configuration) Describes the cylinder heads camshaft/valve configuration. 
	STRING250		ENG_HEAD_CNFG_DESC;								//156     15540-15789           ENG_HEAD_CNFG_DESC                    (Head Configuration) description 
	STRING2			ENG_VLVS_PER_CLNDR;								//157     15791-15792           ENG_VLVS_PER_CLNDR                    (Valves Per Cylinder) Number of intake/exhaust valves per cylinder. 
	STRING2			ENG_VLVS_TOTL;										//158     15794-15795           ENG_VLVS_TOTL                         (Valves Total) Total number of intake/exhaust valves. 
	STRING10		ENG_VIN_CD;												//159     15797-15806           ENG_VIN_CD                            (Code) Code derived from the VIN (not the secondary VIN for a motorcycle). Usually a single character,  some manufactures give full positions 4-8 and engine information from that; they do not break it down any further. 
	STRING1			VRG_VIS_THEFT;										//160     15808-15808           VRG_VIS_THEFT                          
	STRING11		NADA_ID1;													//161     15810-15820           NADA_ID1                              NADA Key - Internal use 
	STRING36		NADA_SERIES1;											//162     15822-15857           NADA_SERIES1                          NADA Series description of the vehicle 
	STRING50		NADA_BODY1;												//163     15859-15908           NADA_BODY1                            NADA Bodystyle for SERIES1 
	STRING16		NADA_MSRP1;												//164     15910-15925           NADA_MSRP1                            NADA MSRP value for SERIES1 
	STRING16		NADA_GCW1;												//165     15927-15942           NADA_GCW1                             NADA Gross Combined Weight Rating (GCWR) for SERIES1.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GVWC1;												//166     15944-15959           NADA_GVWC1                            NADA Gross Vehicle Weight Rating (GVWR) for SERIES1.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING11		NADA_ID2;													//167     15961-15971           NADA_ID2                              NADA Key for the second series option - Internal use 
	STRING36		NADA_SERIES2;											//168     15973-16008           NADA_SERIES2                          NADA Series description of the vehicle  - Option2 
	STRING50		NADA_BODY2;												//169     16010-16059           NADA_BODY2                            NADA Bodystyle for SERIES2 
	STRING16		NADA_MSRP2;												//170     16061-16076           NADA_MSRP2                            NADA MSRP value for SERIES2 
	STRING16		NADA_GCW2;												//171     16078-16093           NADA_GCW2                             NADA Gross Combined Weight Rating (GCWR) for SERIES2.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GVWC2;												//172     16095-16110           NADA_GVWC2                            NADA Gross Vehicle Weight Rating (GVWR) for SERIES2.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING11		NADA_ID3;													//173     16112-16122           NADA_ID3                              NADA Key for the third series option - Internal use 
	STRING36		NADA_SERIES3;											//174     16124-16159           NADA_SERIES3                          NADA Series description of the vehicle  - Option3 
	STRING50		NADA_BODY3;												//175     16161-16210           NADA_BODY3                            NADA Bodystyle for SERIES3 
	STRING16		NADA_MSRP3;												//176     16212-16227           NADA_MSRP3                            NADA MSRP value for SERIES3 
	STRING16		NADA_GCW3;												//177     16229-16244           NADA_GCW3                             NADA Gross Combined Weight Rating (GCWR) for SERIES3.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GVWC3;												//178     16246-16261           NADA_GVWC3                            NADA Gross Vehicle Weight Rating (GVWR) for SERIES3.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING11		NADA_ID4;													//179     16263-16273           NADA_ID4                              NADA Key for thefourth series option - Internal use 
	STRING36		NADA_SERIES4;											//180     16275-16310           NADA_SERIES4                          NADA Series description of the vehicle  - Option4 
	STRING50		NADA_BODY4;												//181     16312-16361           NADA_BODY4                            NADA Bodystyle for SERIES4 
	STRING16		NADA_MSRP4;												//182     16363-16378           NADA_MSRP4                            NADA MSRP value for SERIES4 
	STRING16		NADA_GCW4;												//183     16380-16395           NADA_GCW4                             NADA Gross Combined Weight Rating (GCWR) for SERIES4.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GVWC4;												//184     16397-16412           NADA_GVWC4                            NADA Gross Vehicle Weight Rating (GVWR) for SERIES4.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING11		NADA_ID5;													//185     16414-16424           NADA_ID5                              NADA Key for the fifth series option - Internal use 
	STRING36		NADA_SERIES5;											//186     16426-16461           NADA_SERIES5                          NADA Series description of the vehicle  - Option5 
	STRING50		NADA_BODY5;												//187     16463-16512           NADA_BODY5                            NADA Bodystyle for SERIES5 
	STRING16		NADA_MSRP5;												//188     16514-16529           NADA_MSRP5                            NADA MSRP value for SERIES5 
	STRING16		NADA_GCW5;												//189     16531-16546           NADA_GCW5                             NADA Gross Combined Weight Rating (GCWR) for SERIES5.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GVWC5;												//190     16548-16563           NADA_GVWC5                            NADA Gross Vehicle Weight Rating (GVWR) for SERIES5.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING11		NADA_ID6;													//191     16565-16575           NADA_ID6                              NADA Key for the sixth series option - Internal use 
	STRING36		NADA_SERIES6;											//192     16577-16612           NADA_SERIES6                          NADA Series description of the vehicle  - Option6 
	STRING50		NADA_BODY6;												//193     16614-16663           NADA_BODY6                            NADA Bodystyle for SERIES6 
	STRING16		NADA_MSRP6;												//194     16665-16680           NADA_MSRP6                            NADA MSRP value for SERIES6 
	STRING16		NADA_GCW6;												//195     16682-16697           NADA_GCW6                             NADA Gross Combined Weight Rating (GCWR) for SERIES6.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GVWC6;												//196     16699-16714           NADA_GVWC6                            NADA Gross Vehicle Weight Rating (GVWR) for SERIES6.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING11		NADA_ID7;													//197     16716-16726           NADA_ID7                              NADA Key for the seventh series option - Internal use 
	STRING36		NADA_SERIES7;											//198     16728-16763           NADA_SERIES7                          NADA Series description of the vehicle  - Option7 
	STRING50		NADA_BODY7;												//199     16765-16814           NADA_BODY7                            NADA Bodystyle for SERIES7 
	STRING16		NADA_MSRP7;												//200     16816-16831           NADA_MSRP7                            NADA MSRP value for SERIES7 
	STRING16		NADA_GCW7;												//201     16833-16848           NADA_GCW7                             NADA Gross Combined Weight Rating (GCWR) for SERIES7.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GVWC7;												//202     16850-16865           NADA_GVWC7                            NADA Gross Vehicle Weight Rating (GVWR) for SERIES7.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING11		NADA_ID8;													//203     16867-16877           NADA_ID8                              NADA Key for the eighth series option - Internal use 
	STRING36		NADA_SERIES8;											//204     16879-16914           NADA_SERIES8                          NADA Series description of the vehicle  - Option8 
	STRING50		NADA_BODY8;												//205     16916-16965           NADA_BODY8                            NADA Bodystyle for SERIES8 
	STRING16		NADA_MSRP8;												//206     16967-16982           NADA_MSRP8                            NADA MSRP value for SERIES8 
	STRING16		NADA_GVWC8;												//207     16984-16999           NADA_GVWC8                            NADA Gross Vehicle Weight Rating (GVWR) for SERIES8.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GCW8;												//208     17001-17016           NADA_GCW8                             NADA Gross Combined Weight Rating (GCWR) for SERIES8.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING11		NADA_ID9;													//209     17018-17028           NADA_ID9                              NADA Key for the ninth series option - Internal use 
	STRING36		NADA_SERIES9;											//210     17030-17065           NADA_SERIES9                          NADA Series description of the vehicle  - Option9 
	STRING50		NADA_BODY9;												//211     17067-17116           NADA_BODY9                            NADA Bodystyle for SERIES9 
	STRING16		NADA_MSRP9;												//212     17118-17133           NADA_MSRP9                            NADA MSRP value for SERIES9 
	STRING16		NADA_GCW9;												//213     17135-17150           NADA_GCW9                             NADA Gross Combined Weight Rating (GCWR) for SERIES9.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GVWC9;												//214     17152-17167           NADA_GVWC9                            NADA Gross Vehicle Weight Rating (GVWR) for SERIES9.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING11		NADA_ID10;												//215     17169-17179           NADA_ID10                             NADA Key for the tenth series option - Internal use 
	STRING36		NADA_SERIES10;										//216     17181-17216           NADA_SERIES10                         NADA Series description of the vehicle  - Option10 
	STRING50		NADA_BODY10;											//217     17218-17267           NADA_BODY10                           NADA Bodystyle for SERIES10 
	STRING16		NADA_MSRP10;											//218     17269-17284           NADA_MSRP10                           NADA MSRP value for SERIES10 
	STRING16		NADA_GCW10;												//219     17286-17301           NADA_GCW10                            NADA Gross Combined Weight Rating (GCWR) for SERIES10.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING16		NADA_GVWC10;											//220     17303-17318           NADA_GVWC10                           NADA Gross Vehicle Weight Rating (GVWR) for SERIES10.  Only populated for NADA USED Commerical Guide Vehicles 1992 - Current 
	STRING1			INCOMPLETE_IND;										//221     17320-17320           INCOMPLETE_IND                        Indicator that signifies whether the vehicle is consider "incomplete" (Y/N) 
	STRING20		BAT_TYP_CD;												//222     17322-17341           BAT_TYP_CD                            A value that identifies the kind of battery in the vehicle. For example: PbA - Lead Acid,NMH - Nickel Metal Hydride. 
	STRING250		BAT_TYP_DESC;											//223     17343-17592           BAT_TYP_DESC                          The description of the Polk assigned code for the Battery Type Code. For example:PbA - Lead Acid,NMH - Nickel Metal Hydride. 
	STRING20		BAT_KW_RATG_CD;										//224     17594-17613           BAT_KW_RATG_CD                        The measure of total battery power expressed in kilowatts.   For example:  71KW, 85KW, 75KW, 67KW. 
	STRING250		BAT_VLT_DESC;											//225     17615-17864           BAT_VLT_DESC                          The voltage rating of the battery as provided by the manufactuer. 
	STRING1			ENG_ASP_SUP_CHGR_CD;							//226     17866-17866           ENG_ASP_SUP_CHGR_CD                   Indicates if the engine has a supercharger or not. 
	STRING250		ENG_ASP_SUP_CHGR_DESC;						//227     17868-18117           ENG_ASP_SUP_CHGR_DESC                 Indicates if the engine has a supercharger or not.  Yes, No or Unknown. 
	STRING1			ENG_ASP_TRBL_CHGR_CD;							//228     18119-18119           ENG_ASP_TRBL_CHGR_CD                  Indicates if the engine has a turbocharger. Yes, No or Unknown. 
	STRING250		ENG_ASP_TRBL_CHGR_DESC;						//229     18121-18370           ENG_ASP_TRBL_CHGR_DESC                The description of the Polk assigned code which identifies the vehicle carburetion type.   For example Carburator, Fuel Injection, Unknown or Electric n/a. 
	STRING20		ENG_ASP_VVTL_CD;									//230     18372-18391           ENG_ASP_VVTL_CD                       The type of fuel injection used by a vehicle.  For example, Direct, Throttlebody 
	STRING250		ENG_ASP_VVTL_DESC;								//231     18393-18642           ENG_ASP_VVTL_DESC                     The description of the Polk assigned code that indicates the availability of Power Brakes.  For example Not Available, Optional, etc. 
	//DF-27656 - following 3 field names are modified from XXXX to XXXX_2018
	STRING3			LPM_LIABILITY_SYMBOL_2018;							//232     18644-18646           LPM_LIABILITY_SYMBOL                  ISO three position Liability Symbol 
	STRING3			LPM_PIP_MED_PAY_SYMBOL_2018;						//233     18648-18650           LPM_PIP_MED_PAY_SYMBOL                ISO three position PIP / Medical Symbol 
	STRING1			LPM_ROLL_IND_2018;									//234     18652-18652           LPM_ROLL_IND                          It is common insurance industry practice to Ã‚Â¿roll overÃ‚Â¿ insurance symbols from the previous model year into the new model year. An Ã‚Â¿RÃ‚Â¿ is placed in this field to indicate that the ISO symbol for an existing series / model has been continued into the new model year and is not yet in the ISO country-wide book for the new model year. These symbols are phased out via normal software updates as the ISO symbols are updated and published.  This code is provided as a service to users, and use of the associated symbol is optional 
	STRING6			ACES_VEHICLE_ID;									//235     18654-18659           ACES_VEHICLE_ID                        
	STRING6			ACES_BASE_VEHICLE;								//236     18661-18666           ACES_BASE_VEHICLE                      
	STRING5			ACES_MAKE_ID;											//237     18668-18672           ACES_MAKE_ID                           
	STRING5			ACES_MDL_ID;											//238     18674-18678           ACES_MDL_ID                            
	STRING5			ACES_SUB_MDL_ID;									//239     18680-18684           ACES_SUB_MDL_ID                        
	STRING2			ACES_VEH_TYP_ID;									//240     18686-18687           ACES_VEH_TYP_ID                        
	STRING4			ACES_YEAR_ID;											//241     18689-18692           ACES_YEAR_ID                           
	STRING2			ACES_FUEL;												//242     18694-18695           ACES_FUEL                              
	STRING2			ACES_FUEL_DELIVERY;								//243     18697-18698           ACES_FUEL_DELIVERY                     
	STRING3			ACES_ENG_VIN_ID;									//244     18700-18702           ACES_ENG_VIN_ID                        
	STRING2			ACES_ASP_ID;											//245     18704-18705           ACES_ASP_ID                            
	STRING2			ACES_DRIVE_ID;										//246     18707-18708           ACES_DRIVE_ID                          
	STRING2			ACES_BODY_NMBR_DR;								//247     18710-18711           ACES_BODY_NMBR_DR                      
	STRING2			ACES_BODY_TYPE;										//248     18713-18714           ACES_BODY_TYPE                         
	STRING2			ACES_REGION_ID;										//249     18716-18717           ACES_REGION_ID                         
	STRING4			ACES_LITERS;											//250     18719-18722           ACES_LITERS                            
	STRING5			ACES_CC_DISPLACEMENT;							//251     18724-18728           ACES_CC_DISPLACEMENT                   
	STRING4			ACES_CI_DISPLACEMENT;							//252     18730-18733           ACES_CI_DISPLACEMENT                   
	STRING2			ACES_CYLINDERS;										//253     18735-18736           ACES_CYLINDERS                         
	STRING1			ACES_RESERVED;										//254     18738-18738           ACES_RESERVED                          
	STRING3			VRG_RESERVED;											//255     18740-18743           VRG_RESERVED                           
	STRING2			VRG_LIABILITY;										//256     18745-18746           VRG_LIABILITY                          
	STRING2			VRG_PIP_MED_PAY;									//257     18748-18749           VRG_PIP_MED_PAY                        
	STRING2			VRG_COLLISION;										//258     18751-18752           VRG_COLLISION                          
	STRING2			VRG_OTHER;												//259     18754-18755           VRG_OTHER                              
	STRING1			VRG_INTERNAL;											//260     18757-18757           VRG_INTERNAL                           
	STRING64		VIN_PATRN;												//261     18759-18822           VIN_PATRN                             Contains the pattern of a VIN established by the Original Equipment Manufacturer (OEM) that is used to identify the characteristics of a given class of vehicle as they were defined by the OEM.  It does not generally identify a specific instance of a vehicle 
	STRING3			MOTR_CYCL_USAG_CD;								//262     18824-18826           MOTR_CYCL_USAG_CD                     A further breakdown of body style for motorcycles to indicate if is it On-Road or Off-Road. 
	STRING50		MOTR_CYCL_USAG_DESC;							//263     18828-19077           MOTR_CYCL_USAG_DESC                   A further breakdown of body style for motorcycles to indicate if is it On-Road or Off-Road. 
	//DF-27656 - following 9 field names are modified from XXXX_2008 to XXXX_2020, XXXX_2010 to XXXX_2022, and XXXX_2012 to XXXX_2024.
	STRING3			LPM_PIP_MED_PAY_SYMBOL_2020;					//264     19079-19081           LPM_PIP_MED_PAY_SYMBOL_2008           ISO three position PIP / Medical Symbol 
	STRING3			LPM_LIABILITY_SYMBOL_2020;						//265     19083-19085           LPM_LIABILITY_SYMBOL_2008							ISO three position Liability Symbol
	STRING1			LPM_ROLL_IND_2020;								//266     19087-19087           LPM_ROLL_IND_2008 										It is common insurance industry practice to Ã‚Â¿roll overÃ‚Â¿ insurance symbols from the previous model year into the new model year. An Ã‚Â¿RÃ‚Â¿ is placed in this field to indicate that the ISO symbol for an existing series / model has been continued into the new model year and is not yet in the ISO country-wide book for the new model year. These symbols are phased out via normal software updates as the ISO symbols are updated and published.  This code is provided as a service to users, and use of the associated symbol is optional
	STRING3			LPM_PIP_MED_PAY_SYMBOL_2022;					//267     19089-19091           LPM_PIP_MED_PAY_SYMBOL_2010						ISO three position PIP / Medical Symbol
	STRING3			LPM_LIABILITY_SYMBOL_2022;						//268     19093-19095           LPM_LIABILITY_SYMBOL_2010							ISO three position Liability Symbol
	STRING1			LPM_ROLL_IND_2022;								//269     19097-19097           LPM_ROLL_IND_2010   									It is common insurance industry practice to Ã‚Â¿roll overÃ‚Â¿ insurance symbols from the previous model year into the new model year. An Ã‚Â¿RÃ‚Â¿ is placed in this field to indicate that the ISO symbol for an existing series / model has been continued into the new model year and is not yet in the ISO country-wide book for the new model year. These symbols are phased out via normal software updates as the ISO symbols are updated and published.  This code is provided as a service to users, and use of the associated symbol is optional
	STRING3			LPM_PIP_MED_PAY_SYMBOL_2024;					//270     19099-19101           LPM_PIP_MED_PAY_SYMBOL_2012 					ISO three position PIP / Medical Symbol
	STRING3			LPM_LIABILITY_SYMBOL_2024;						//271     19103-19105           LPM_LIABILITY_SYMBOL_2012 						ISO three position Liability Symbol
	STRING1			LPM_ROLL_IND_2024;								//272     19107-19107           LPM_ROLL_IND_2012											It is common insurance industry practice to Ã‚Â¿roll overÃ‚Â¿ insurance symbols from the previous model year into the new model year. An Ã‚Â¿RÃ‚Â¿ is placed in this field to indicate that the ISO symbol for an existing series / model has been continued into the new model year and is not yet in the ISO country-wide book for the new model year. These symbols are phased out via normal software updates as the ISO symbols are updated and published.  This code is provided as a service to users, and use of the associated symbol is optional
	STRING3			LPM_PIP_MED_PAY_SYMBOL_2014;			//273     19109-19111           LPM_PIP_MED_PAY_SYMBOL_2014						ISO three position PIP / Medical Symbol
	STRING3			LPM_LIABILITY_SYMBOL_2014;				//274     19113-19115           LPM_LIABILITY_SYMBOL_2014							ISO three position Liability Symbol
	STRING1			LPM_ROLL_IND_2014;								//275     19117-19117           LPM_ROLL_IND_2014 										It is common insurance industry practice to Ã‚Â¿roll overÃ‚Â¿ insurance symbols from the previous model year into the new model year. An Ã‚Â¿RÃ‚Â¿ is placed in this field to indicate that the ISO symbol for an existing series / model has been continued into the new model year and is not yet in the ISO country-wide book for the new model year. These symbols are phased out via normal software updates as the ISO symbols are updated and published.  This code is provided as a service to users, and use of the associated symbol is optional
	STRING3			LPM_PIP_MED_PAY_SYMBOL_2016;			//276     19119-19121           LPM_PIP_MED_PAY_SYMBOL_2016						ISO three position PIP / Medical Symbol
	STRING3			LPM_LIABILITY_SYMBOL_2016;				//277     19123-19125           LPM_LIABILITY_SYMBOL_2016 						ISO three position Liability Symbol
	STRING1			LPM_ROLL_IND_2016;								//278     19127-19127           LPM_ROLL_IND_2016											It is common insurance industry practice to Ã‚Â¿roll overÃ‚Â¿ insurance symbols from the previous model year into the new model year. An Ã‚Â¿RÃ‚Â¿ is placed in this field to indicate that the ISO symbol for an existing series / model has been continued into the new model year and is not yet in the ISO country-wide book for the new model year. These symbols are phased out via normal software updates as the ISO symbols are updated and published.  This code is provided as a service to users, and use of the associated symbol is optional
	STRING5			ACES_POWER_OUTPUT_ID;							//279     19129-19133           ACES_POWER_OUTPUT_ID                    
	STRING4			ACES_FUEL_DEL_CONFIG_ID;					//280     19135-19138						ACES_FUEL_DEL_CONFIG_ID                
	STRING4			ACES_BODY_STYLE_CONFIG_ID;				//281     19140-19143						ACES_BODY_STYLE_CONFIG_ID              
	STRING5			ACES_ENGINE_BASE_ID;							//282     19145-19149						ACES_ENGINE_BASE_ID                    
	STRING6			ACES_ENGINE_CONFIG_ID;						//283     19151-19156           ACES_ENGINE_CONFIG_ID                 
	STRING7			ACES_VEH_ENGCONFIG_ID;						//284     19158-19164						ACES_VEH_ENGCONFIG_ID                  
	STRING1			ACES_BLOCK_TYPE;									//285     19166-19166						ACES_BLOCK_TYPE              
	STRING1			ACES_CYL_HEAD_TYPE_ID;						//286     19168-19168						ACES_CYL_HEAD_TYPE_ID                
	STRING2			ACES_VALVES_ID;										//287     19170-19171						ACES_VALVES_ID                         
	STRING5			ACES_ENGINE_DESIGNATION_ID;				//288     19173-19177						ACES_ENGINE_DESIGNATION_ID             
	STRING50		ACES_MAKE_NAME;										//289     19179-19228 					ACES_MAKE_NAME                       
	STRING50		ACES_MODEL_NAME;									//290     19230-19279						ACES_MODEL_NAME                        
	STRING50		ACES_SUB_MODEL_NAME;							//291     19281-19330          	ACES_SUB_MODEL_NAME                    
	STRING50		ACES_VEH_TYPE_NAME;								//292     19332-19381           ACES_VEH_TYPE_NAME         
	STRING30		ACES_FUEL_TYPE_NAME;							//293     19383-19412           ACES_FUEL_TYPE_NAME                    
	STRING50		ACES_FUEL_DEL_TYPE_NAME;					//294     19414-19463           ACES_FUEL_DEL_TYPE_NAME                
	STRING30		ACES_ASPIRATION_NAME;							//295     19465-19494						ACES_ASPIRATION_NAME                   
	STRING30		ACES_DRIVE_TYPE_NAME;							//296     19496-19525           ACES_DRIVE_TYPE_NAME
 	STRING50		ACES_BODY_TYPE_NAME;							//297     19527-19576						ACES_BODY_TYPE_NAME                  
	STRING50		ACES_REGION_NAME;									//298     19578-19627						ACES_REGION_NAME                  
	STRING25		ACES_CYL_HEAD_TYPE_NM;						//299     19629-19653						ACES_CYL_HEAD_TYPE_NM                  
	STRING5			ACES_VALVES_PER_ENG;							//300     19655-19659						ACES_VALVES_PER_ENG            
	STRING25		ACES_ENGINE_DESIGNATION_NAME;			//301     19661-19685           ACES_ENGINE_DESIGNATION_NAME
	//New 20150930
	STRING2			RP_COMP_RATING_SYM;								//302     19687-19688           RP_COMP_RATING_SYM										Risk AnalyzerÃ‚Â® Comprehensive Rating Symbol
	STRING2			RP_COLL_RATING_SYM;								//303     19690-19691						RP_COLL_RATING_SYM										Risk AnalyzerÃ‚Â® Collision Rating Symbol
	STRING2			RP_COMP_RATING_SYM_GA;						//304     19693-19694						RP_COMP_RATING_SYM_GA									Risk AnalyzerÃ‚Â® Comprehensive Rating Symbol - Georgia
	STRING2			RP_COLL_RATING_SYM_GA;						//305     19696-19697						RP_COLL_RATING_SYM_GA									Risk AnalyzerÃ‚Â® Collision Rating Symbol - Georgia
	STRING2			RP_COMP_IND_SYM;									//306     19699-19700						RP_COMP_IND_SYM												Risk AnalyzerÃ‚Â® Comprehensive Indicated Symbol
	STRING2			RP_COLL_IND_SYM;									//307     19702-19703						RP_COLL_IND_SYM												Risk AnalyzerÃ‚Â® Collision Indicated Symbol
	STRING9			RP_COMP_IND_SYM_RELTIVTY;					//308     19705-19713						RP_COMP_IND_SYM_RELTIVTY							Risk AnalyzerÃ‚Â® Comprehensive Indicated Symbol Relativity
	STRING9			RP_COLL_IND_SYM_RELTIVTY;					//309     19715-19723           RP_COLL_IND_SYM_RELTIVTY							Risk AnalyzerÃ‚Â® Collision Indicated Symbol Relativity
	STRING9			RP_COMP_PRC_NEW_RELTIVTY;					//310     19725-19733						RP_COMP_PRC_NEW_RELTIVTY							Risk AnalyzerÃ‚Â® Comprehensive Price New Relativity
	STRING10		RP_COMP_LUX_ADD_PRC_RELTIVTY;			//311     19735-19744						RP_COMP_LUX_ADD_PRC_RELTIVTY					Risk AnalyzerÃ‚Â® Comprehensive Luxury Price Addtn. To Price New Relativity
	STRING14		RP_COMP_FREQ_THEFT_VAND_FIRE;			//312     19746-19759 					RP_COMP_FREQ_THEFT_VAND_FIRE					Risk AnalyzerÃ‚Â® Comprehensive Frequency - Theft, Vandalism and Fire
	STRING14		RP_COMP_FREQ_WIND_WATER;					//313     19761-19774						RP_COMP_FREQ_WIND_WATER								Risk AnalyzerÃ‚Â® Comprehensive Frequency - Wind and Water
	STRING14		RP_COMP_FREQ_ANIMAL;							//314     19776-19789						RP_COMP_FREQ_ANIMAL										Risk AnalyzerÃ‚Â® Comprehensive Frequency - Animal
	STRING14		RP_COMP_FREQ_OTHER_TYPE_LOSS;			//315     19791-19804						RP_COMP_FREQ_OTHER_TYPE_LOSS					Risk AnalyzerÃ‚Â® Comprehensive Frequency - Other Type of Loss
	STRING14		RP_COMP_FREQ_GLASS;								//316     19806-19819						RP_COMP_FREQ_GLASS										Risk AnalyzerÃ‚Â® Comprehensive Frequency - Glass
	STRING14		RP_COMP_SVRITY_THEFT_VAND_FIRE;		//317     19821-19834						RP_COMP_SVRITY_THEFT_VAND_FIRE				Risk AnalyzerÃ‚Â® Comprehensive Severity - Theft, Vandalism and Fire
	STRING14		RP_COMP_SVRITY_WIND_WATER;				//318     19836-19849						RP_COMP_SVRITY_WIND_WATER							Risk AnalyzerÃ‚Â® Comprehensive Severity - Wind and Water
	STRING14		RP_COMP_SVRITY_ANIMAL;						//319     19851-19864						RP_COMP_SVRITY_ANIMAL									Risk AnalyzerÃ‚Â® Comprehensive Severity - Animal
	STRING14		RP_COMP_SVRITY_OTHER_TYPE_LOSS;		//320     19866-19879						RP_COMP_SVRITY_OTHER_TYPE_LOSS				Risk AnalyzerÃ‚Â® Comprehensive Severity - Other Type of Loss
	STRING14		RP_COMP_SVRITY_GLASS;							//321     19881-19894						RP_COMP_SVRITY_GLASS									Risk AnalyzerÃ‚Â® Comprehensive Severity - Glass
	STRING9			RP_COLL_PRC_NEW_RELTIVTY;					//322     19896-19904						RP_COLL_PRC_NEW_RELTIVTY							Risk AnalyzerÃ‚Â® Collision Price New Relativity
	STRING10		RP_COLL_LUX_ADD_PRC_RELTIVTY;			//323     19906-19915						RP_COLL_LUX_ADD_PRC_RELTIVTY					Risk AnalyzerÃ‚Â® Collision Luxury Price Addtn. to Price New Relativity
	STRING14		RP_COLL_FREQ_BOD_STY_DIMEN;				//324     19917-19930						RP_COLL_FREQ_BOD_STY_DIMEN						Risk AnalyzerÃ‚Â® Collision Frequency - Body Style and Dimensions
	STRING14		RP_COLL_SVRITY_BOD_STY_DIMEN;			//325     19932-19945						RP_COLL_SVRITY_BOD_STY_DIMEN					Risk AnalyzerÃ‚Â® Collision Severity - Body Style and Dimensions
	STRING14		RP_COLL_FREQ_PERFM_SAFETY;				//326     19947-19960						RP_COLL_FREQ_PERFM_SAFETY							Risk AnalyzerÃ‚Â® Collision Frequency - Performance and Safety
	STRING14		RP_COLL_SVRITY_PERFM_SAFETY;			//327     19962-19975						RP_COLL_SVRITY_PERFM_SAFETY						Risk AnalyzerÃ‚Â® Collision Severity - Performance and Safety
	STRING10		RP_DISC_DAYTIME_LIGHT;						//328     19977-19986						RP_DISC_DAYTIME_LIGHT									Risk AnalyzerÃ‚Â® Discount for Daytime Running Lights
	STRING1			RP_PERFORMANCE_IND;								//329     19988-19988						RP_PERFORMANCE_IND										Risk AnalyzerÃ‚Â® Physical Damage Performance Indicator
	STRING1			RP_ROLL_IND;											//330     19990-19990						RP_ROLL_IND														Risk AnalyzerÃ‚Â® Physical Damage Symbol Rolled
	STRING2			RL_SINGLE_LMT_RATING_SYM;					//331     19992-19993						RL_SINGLE_LMT_RATING_SYM							Risk AnalyzerÃ‚Â® Single Limit Rating Symbol
	STRING2			RL_BOD_INJRY_RATING_SYM;					//332     19995-19996						RL_BOD_INJRY_RATING_SYM								Risk AnalyzerÃ‚Â® Bodily Injury Rating Symbol
	STRING2			RL_PROP_DAM_RATING_SYM;						//333     19998-19999						RL_PROP_DAM_RATING_SYM								Risk AnalyzerÃ‚Â® Property Damage Rating Symbol
	STRING2			RL_PIP_RATING_SYM;								//334     20001-20002						RL_PIP_RATING_SYM											Risk AnalyzerÃ‚Â® Personal Injury Protection Rating Symbol
	STRING2			RL_MED_PYMT_RATING_SYM; 					//335     20004-20005						RL_MED_PYMT_RATING_SYM								Risk AnalyzerÃ‚Â® Medical Payments Rating Symbol
	STRING2			RL_SINGLE_LMT_RATING_SYM_GA; 			//336     20007-20008						RL_SINGLE_LMT_RATING_SYM_GA						Risk AnalyzerÃ‚Â® Single Limit Rating Symbol - Georgia
	STRING2			RL_BOD_INJRY_RATING_SYM_GA; 			//337     20010-20011 					RL_BOD_INJRY_RATING_SYM_GA						Risk AnalyzerÃ‚Â® Bodily Injury Rating Symbol - Georgia
	STRING2			RL_PROP_DAM_RATING_SYM_GA; 				//338     20013-20014						RL_PROP_DAM_RATING_SYM_GA							Risk AnalyzerÃ‚Â® Property Damage Rating Symbol - Georgia
	STRING2			RL_PIP_RATING_SYM_GA; 						//339     20016-20017						RL_PIP_RATING_SYM_GA									Risk AnalyzerÃ‚Â® Personal Injury Protection Rating Symbol - Georgia
	STRING2			RL_MED_PYMT_RATING_SYM_GA; 				//340     20019-20020						RL_MED_PYMT_RATING_SYM_GA							Risk AnalyzerÃ‚Â® Medical Payments Rating Symbol - Georgia
	STRING2			RL_SINGLE_LMT_IND_SYM; 						//341     20022-20023						RL_SINGLE_LMT_IND_SYM									Risk AnalyzerÃ‚Â® Single Limit Indicated Symbol
	STRING2			RL_BOD_INJRY_IND_SYM; 						//342     20025-20026						RL_BOD_INJRY_IND_SYM									Risk AnalyzerÃ‚Â® Bodily Injury Indicated Symbol
	STRING2			RL_PROP_DAM_IND_SYM; 							//343     20028-20029						RL_PROP_DAM_IND_SYM										Risk AnalyzerÃ‚Â® Property Damage Indicated Symbol
	STRING2			RL_PIP_IND_SYM; 									//344     20031-20032						RL_PIP_IND_SYM												Risk AnalyzerÃ‚Â® Personal Injury Protection Indicated Symbol
	STRING2			RL_MED_PYMT_IND_SYM; 							//345     20034-20035						RL_MED_PYMT_IND_SYM										Risk AnalyzerÃ‚Â® Medical Payments Indicated Symbol
	STRING9			RL_SINGLE_LMT_IND_SYM_RELTIVTY; 	//346     20037-20045						RL_SINGLE_LMT_IND_SYM_RELTIVTY				Risk AnalyzerÃ‚Â® Single Limit Indicated Symbol Relativity
	STRING9			RL_BOD_INJRY_IND_SYM_RELTIVTY; 		//347     20047-20055						RL_BOD_INJRY_IND_SYM_RELTIVTY					Risk AnalyzerÃ‚Â® Bodily Injury Indicated Symbol Relativity
	STRING9			RL_PROP_DAM_IND_SYM_RELTIVTY; 		//348     20057-20065						RL_PROP_DAM_IND_SYM_RELTIVTY					Risk AnalyzerÃ‚Â® Property Damage Indicated Symbol Relativity
	STRING9			RL_PIP_IND_SYM_RELTIVTY; 					//349     20067-20075						RL_PIP_IND_SYM_RELTIVTY								Risk AnalyzerÃ‚Â® Personal Injury Protection Indicated Symbol Relativity
	STRING9			RL_MED_PYMT_IND_SYM_RELTIVTY; 		//350     20077-20085						RL_MED_PYMT_IND_SYM_RELTIVTY					Risk AnalyzerÃ‚Â® Medical Payments Indicated Symbol Relativity
	STRING14		RL_BOD_INJRY_BOD_STY_DIMN_COMP; 	//543			21746-21759						RL_BOD_INJRY_BOD_STY_DIMN_COMP				Risk AnalyzerÃ‚Â® Bodily Injury - Body Style & Dimensions Component
	STRING14		RL_BOD_INJRY_PERFM_SAFETY_COMP; 	//544			21761-21774						RL_BOD_INJRY_PERFM_SAFETY_COMP				Risk AnalyzerÃ‚Â® Bodily Injury - Performance & Safety Component
	STRING14		RL_BOD_INJRY_PRC_NEW_EXP_COMP; 		//545			21776-21789						RL_BOD_INJRY_PRC_NEW_EXP_COMP					Risk AnalyzerÃ‚Â® Bodily Injury - Price New & Experience Component
	STRING14		RL_PROP_DAM_BOD_STY_DIMN_COMP; 		//546			21791-21804						RL_PROP_DAM_BOD_STY_DIMN_COMP					Risk AnalyzerÃ‚Â® Property Damage - Body Style & Dimensions Component
	STRING14		RL_PROP_DAM_PERFM_SAFETY_COMP; 		//547			21806-21819						RL_PROP_DAM_PERFM_SAFETY_COMP					Risk AnalyzerÃ‚Â® Property Damage - Performance & Safety Component
	STRING14		RL_PROP_DAM_PRICE_NEW_EXP_COMP; 	//548			21821-21834						RL_PROP_DAM_PRICE_NEW_EXP_COMP				Risk AnalyzerÃ‚Â® Property Damage - Price New & Experience Component
	STRING14		RL_PIP_BOD_STY_DIMN_COMP; 				//549			21836-21849						RL_PIP_BOD_STY_DIMN_COMP							Risk AnalyzerÃ‚Â® Personal Injury Protection - Body Style & Dimensions Component
	STRING14		RL_PIP_PRICE_PERFM_SAFETY_COMP; 	//550			21851-21864						RL_PIP_PRICE_PERFM_SAFETY_COMP				Risk AnalyzerÃ‚Â® Personal Injury Protection - Performance & Safety Component
	STRING14		RL_PIP_PRICE_NEW_EXP_COMP;				//551			21866-21879						RL_PIP_PRICE_NEW_EXP_COMP							Risk AnalyzerÃ‚Â® Personal Injury Protection - Price New & Experience Component
	STRING14		RL_MED_PYMT_BOD_STY_DIMN_COMP;		//552			21881-21894						RL_MED_PYMT_BOD_STY_DIMN_COMP					Risk AnalyzerÃ‚Â® Medical Payments - Body Style & Dimensions Component
	STRING14		RL_MED_PYMT_PERFM_SAFETY_COMP;		//553			21896-21909						RL_MED_PYMT_PERFM_SAFETY_COMP					Risk AnalyzerÃ‚Â® Medical Payments - Performance & Safety Component
	STRING14		RL_MED_PYMT_PRICE_NEW_EXP_COMP;		//554			21911-21924						RL_MED_PYMT_PRICE_NEW_EXP_COMP				Risk AnalyzerÃ‚Â® Medical Payments - Price New & Experience Component
	STRING10		RL_SINGLE_LMT_DISC_DAYTM_LGHT;		//555			21926-21935						RL_SINGLE_LMT_DISC_DAYTM_LGHT					Single Limit Discount for Daytime Running Lights
	STRING10		RL_BOD_INJRY_DISC_DAYTM_LGHT;			//556			21937-21946						RL_BOD_INJRY_DISC_DAYTM_LGHT					Bodily Injury Discount for Daytime Running Lights
	STRING10		RL_PROP_DAM_DISC_DAYTM_LGHT;			//557			21948-21957						RL_PROP_DAM_DISC_DAYTM_LGHT						Property Damage Discount for Daytime Running Lights
	STRING10		RL_PIP_DISC_DAYTM_LGHT;						//558			21959-21968						RL_PIP_DISC_DAYTM_LGHT								Personal Injury Protection Discount for Daytime Running Lights
	STRING10		RL_MED_PYMT_DISC_DAYTM_LGHT;			//559			21970-21979						RL_MED_PYMT_DISC_DAYTM_LGHT						Medical Payments Discount for Daytime Running Lights
	STRING10		RL_SINGLE_LMT_DISC_ABS;						//560			21981-21990						RL_SINGLE_LMT_DISC_ABS								Single Limit Discount for Anti-Lock Braking Systems
	STRING10		RL_BOD_INJRY_DISC_ABS;						//561			21992-22001						RL_BOD_INJRY_DISC_ABS									Bodily Injury Discount for Anti-Lock Braking Systems
	STRING10		RL_PROP_DAM_DISC_ABS;							//562			22003-22012						RL_PROP_DAM_DISC_ABS									Property Damage Discount for Anti-Lock Braking Systems
	STRING10		RL_PIP_DISC_ABS;									//563			22014-22023						RL_PIP_DISC_ABS	Personal 							Injury Protection Discount for Anti-Lock Braking Systems
	STRING10		RL_MED_PYMT_DISC_ABS;							//564			22025-22034						RL_MED_PYMT_DISC_ABS									Medical Payments Discount for Anti-Lock Braking Systems
	STRING1			RL_PERFORMANCE_IND;								//565			22036-22036						RL_PERFORMANCE_IND										Risk AnalyzerÃ‚Â® LPM Performance Indicator
	STRING1			RL_ROLL_IND;											//566			22038-22038						RL_ROLL_IND														Risk AnalyzerÃ‚Â® LPM Symbol Rolled
	STRING2			VINA_BODY_TYPE_CD;								//567			22040-22041						VINA_BODY_TYPE_CD											For Passengers, Trucks, and Motorcycles only. A two-character body type code
	STRING6			VINA_SERIES_ABBR_CD;							//568			22043-22048						VINA_SERIES_ABBR_CD										For Passengers, Trucks, and Motorcycles only. Trucks have a full 6 byte code
	STRING3			NCI_SERIES_ABBR_CD;								//569			22050-22052						NCI_SERIES_ABBR_CD										A vehicle series abbreviation code assigned by National Crime Information Center (NCIC)
	// STRING3			VSR_SYMB;											//570			22054-22056						VSR_SYMB															Physical damage comprehensive symbol for Massachusetts exclusively
	// STRING3			BASE_SYMB;										//571			22058-22060						BASE_SYMB															Physical damage base symbol for Massachusetts exclusively
	STRING3			FILLER;														//570			22054-22056						FILLER starting 20151027 update
	STRING3			ZERO_FILLER;											//571			22058-22060						ZERO_FILLER	starting 20151027 update
	STRING1			ADAPT_CRUISE_CTL_CD;							//572			22062-22062						ADAPT_CRUISE_CTL_CD										1
	STRING250		ADAPT_CRUISE_CTL_DESC;						//573			22064-22313						ADAPT_CRUISE_CTL_DESC									1
	STRING1			ADAPT_HEADLIGHT_CD;								//574			22315-22315						ADAPT_HEADLIGHT_CD										1
	STRING250		ADAPT_HEADLIGHT_DESC;							//575			22317-22566						ADAPT_HEADLIGHT_DESC									1
	STRING1			AUTO_BRK_CD;											//576			22568-22568						AUTO_BRK_CD
	STRING250		AUTO_BRK_DESC;										//577			22570-22819						AUTO_BRK_DESC
	STRING1			AUTO_CRASH_NTFCN_CD;							//578			22821-22821						AUTO_CRASH_NTFCN_CD	1
	STRING250		AUTO_CRASH_NTFCN_DESC;						//579			22823-23072						AUTO_CRASH_NTFCN_DESC	1
	STRING1			VISUAL_BACKUP_ASST_CD;						//580			23074-23074						VISUAL_BACKUP_ASST_CD	1
	STRING250		VISUAL_BACKUP_ASST_DESC;					//581			23076-23325						VISUAL_BACKUP_ASST_DESC	1
	STRING1			AUDIBLE_BACKUP_ASST_CD;						//582			23327-23327						AUDIBLE_BACKUP_ASST_CD	1
	STRING250		AUDIBLE_BACKUP_ASST_DESC;					//583			23329-23578						AUDIBLE_BACKUP_ASST_DESC	1
	STRING1			BLIND_SPOT_DETECT_CD;							//584			23580-23580						BLIND_SPOT_DETECT_CD	1
	STRING250		BLIND_SPOT_DETECT_DESC;						//585			23582-23831						BLIND_SPOT_DETECT_DESC	1
	STRING1			HANDS_FREE_CD;										//586			23833-23833						HANDS_FREE_CD	1
	STRING250		HANDS_FREE_DESC;									//587			23835-24084						HANDS_FREE_DESC	1
	STRING1			TOUCH_SCREEN_CD;									//588			24086-24086						TOUCH_SCREEN_CD	1
	STRING250		TOUCH_SCREEN_DESC;								//589			24088-24337						TOUCH_SCREEN_DESC	1
	STRING1			DSTNC_ALERT_CD;										//590			24339-24339						DSTNC_ALERT_CD	1
	STRING250		DSTNC_ALERT_DESC;									//591			24341-24590						DSTNC_ALERT_DESC	1
	STRING1			ELECT_STABILITY_CD;								//592			24592-24592						ELECT_STABILITY_CD	1
	STRING250		ELECT_STABILITY_DESC;							//593			24594-24843						ELECT_STABILITY_DESC	1
	STRING1			MIRROR_SIGNAL_CD;									//594			24845-24845						MIRROR_SIGNAL_CD	1
	STRING250		MIRROR_SIGNAL_DESC;								//595			24847-25096						MIRROR_SIGNAL_DESC	1
	STRING1			FORWARD_CLLISN_WARN_CD;						//596			25098-25098						FORWARD_CLLISN_WARN_CD	1
	STRING250		FORWARD_CLLISN_WARN_DESC;					//597			25100-25349						FORWARD_CLLISN_WARN_DESC	1
	STRING1			LANE_DPRT_CD;											//598			25351-25351						LANE_DPRT_CD	1
	STRING250		LANE_DPRT_DESC;										//599			25353-25602						LANE_DPRT_DESC	1
	STRING1			NAVIGAT_SYS_CD;										//600			25604-25604						NAVIGAT_SYS_CD	1
	STRING250		NAVIGAT_SYS_DESC;									//601			25606-25855						NAVIGAT_SYS_DESC	1
	STRING1			AUTO_PARK_CD;											//602			25857-25857						AUTO_PARK_CD	1
	STRING250		AUTO_PARK_DESC;										//603			25859-26108						AUTO_PARK_DESC	1
	STRING1			PEDESTRIAN_DETECT_CD;							//604			26110-26110						PEDESTRIAN_DETECT_CD	1
	STRING250		PEDESTRIAN_DETECT_DESC;						//605			26112-26361						PEDESTRIAN_DETECT_DESC	1
	STRING1			RAIN_SENSE_WIPER_CD;							//606			26363-26363						RAIN_SENSE_WIPER_CD	1
	STRING250		RAIN_SENSE_WIPER_DESC;						//607			26365-26614						RAIN_SENSE_WIPER_DESC	1
	STRING1			REMOTE_START_CD;									//608			26616-26616						REMOTE_START_CD	1
	STRING250		REMOTE_START_DESC;								//609			26618-26867						REMOTE_START_DESC	1
	STRING1			VOICE_CNTL_NAVIGAT_CD;						//610			26869-26869						VOICE_CNTL_NAVIGAT_CD	1
	STRING250		VOICE_CNTL_NAVIGAT_DESC;					//611			26871-27120						VOICE_CNTL_NAVIGAT_DESC	1
	STRING1			INJURY_PROTN_STS_CD;							//612			27122-27122						INJURY_PROTN_STS_CD	1
	STRING250		INJURY_PROTN_STS_DESC;						//613			27124-27373						INJURY_PROTN_STS_DESC	1
	STRING1			VEH_THEFT_TRACK_CD;								//614			27375-27375						VEH_THEFT_TRACK_CD	1
	STRING250		VEH_THEFT_TRACK_DESC;							//615			27377-27626						VEH_THEFT_TRACK_DESC	1
	STRING1			RADIO_ANTITHEFT_CD;								//616			27628-27628						RADIO_ANTITHEFT_CD	1
	STRING250		RADIO_ANTITHEFT_DESC;							//617			27630-27879						RADIO_ANTITHEFT_DESC	1
	STRING1			BREAK_RESIST_GLASS_CD;						//618			27881-27881						BREAK_RESIST_GLASS_CD	1
	STRING250		BREAK_RESIST_GLASS_DESC;					//619			27883-28132						BREAK_RESIST_GLASS_DESC	1
	STRING1			AUDIBLE_ALARM_CD;									//620			28134-28134						AUDIBLE_ALARM_CD	1
	STRING250		AUDIBLE_ALARM_DESC;								//621			28136-28385						AUDIBLE_ALARM_DESC	1
	STRING1			ANTILIFT_SENSOR_CD;								//622			28387-28387						ANTILIFT_SENSOR_CD	1
	STRING250		ANTILIFT_SENSOR_DESC;							//623			28389-28638						ANTILIFT_SENSOR_DESC	1
	STRING1			ENG_IMMOBILIZER_CD;								//624			28640-28640						ENG_IMMOBILIZER_CD	1
	STRING250		ENG_IMMOBILIZER_DESC;							//625			28642-28891						ENG_IMMOBILIZER_DESC	1
	STRING1			TILT_SENSOR_CD;										//626			28893-28893						TILT_SENSOR_CD	1
	STRING250		TILT_SENSOR_DESC;									//627			28895-29144						TILT_SENSOR_DESC	1
	STRING1			WHEEL_LOCK_CD;										//628			29146-29146						WHEEL_LOCK_CD	1
	STRING250		WHEEL_LOCK_DESC;									//629			29148-29397						WHEEL_LOCK_DESC	1
	STRING1			GLASS_BREAK_SENSOR_CD;						//630			29399-29399						GLASS_BREAK_SENSOR_CD	1
	STRING250		GLASS_BREAK_SENSOR_DESC;					//631			29401-29650						GLASS_BREAK_SENSOR_DESC	1
	STRING5			ADVNC_VEH_TYPE_CD;								//440     27993-27997           ADVNC_VEH_TYPE_CD                     Advance Vehicle Type Code 
	STRING250		ADVNC_VEH_TYPE_DESC;							//441     27999-28248           ADVNC_VEH_TYPE_DESC                   Advance Vehicle Type Description 
	STRING4			HEV_ARCH_CD;											//442     28250-28253           HEV_ARCH_CD                           HEV Architecture Code 
	STRING250		HEV_ARCH_DESC;										//443     28255-28504           HEV_ARCH_DESC                         HEV Architecture Description 
	STRING4			HYBRID_LVL_CD;										//444     28506-28509           HYBRID_LVL_CD                         Hybridization Level Code 
	STRING250		HYBRID_LVL_DESC;									//445     28511-28760           HYBRID_LVL_DESC                       Hybridization Level Description 
	STRING4			EV_RNG;														//446     28762-28765           EV_RNG                                EV Range 
	STRING4			ADVNC_VEH_BATTERY_OUTPUT_KW;			//447     28767-28770           ADVNC_VEH_BATTERY_OUTPUT_KW           Advance Vehicle Battery Output(kW) 
	STRING2			ADVNC_VEH_BATTERY_CHRG_TM_120V;		//448     28772-28773           ADVNC_VEH_BATTERY_CHRG_TM_120V        Advance Vehicle Battery Charging Time(Hrs)@120v 
	STRING2			ADVNC_VEH_BATTERY_CHRG_TM_240V;		//449     28775-28776           ADVNC_VEH_BATTERY_CHRG_TM_240V        Advance Vehicle Battery Charging Time(Hrs)@240v 
	STRING4			MOTOR_PWR_OUTPUT_KW;							//450     28778-28781           MOTOR_PWR_OUTPUT_KW                   Motor Power Output (kW) 
	STRING7			CYL_DEACTV_CD;										//451     28783-28789           CYL_DEACTV_CD                         Cylinder Deactivation Code 
	STRING250		CYL_DEACTV_DESC;									//452     28791-29040           CYL_DEACTV_DESC                       Cylinder Deactivation Description 
	STRING7			ISG_SYS_CD;												//453     29042-29048           ISG_SYS_CD                            ISG System Code 
	STRING250		ISG_SYS_DESC;											//454     29050-29299           ISG_SYS_DESC                          ISG System Description 
	STRING7			REGEN_BRK_CD;											//455     29301-29307           REGEN_BRK_CD                          Regenerative Braking Code 
	STRING250		REGEN_BRK_DESC;										//456     29309-29558           REGEN_BRK_DESC                        Regenerative Braking Description 
	STRING7			MOTOR_DRV_ASST_CD;								//457     29560-29566           MOTOR_DRV_ASST_CD                     Motor Drive Assist Code
	STRING250		MOTOR_DRV_ASST_DESC;							//458     29568-29817						MOTOR_DRV_ASST_DESC                   Motor Drive Assist Description
	STRING3			MPG_CITY;													//459     29819-29821						MPG_CITY                             	MPG or MPGe City
	STRING3			MPG_HIGHWAY;											//460     29823-29825						MPG_HIGHWAY                           MPG or MPGe Hwy 
	STRING3			MPG_CMBND;												//461     29827-29829						MPG_CMBND                             MPG or MPGe Combined 
	STRING4			EPA_CERT_SLS_REGN_CD;							//462     29831-29834						EPA_CERT_SLS_REGN_CD                  EPA Certification Sales Region Code 
	STRING250		EPA_CERT_SLS_REGN_DESC;						//463     29836-30085						EPA_CERT_SLS_REGN_DESC                EPA Certification Sales Region Description 
	STRING2			EPA_AIR_POLLUTION_SCR;						//464     30087-30088						EPA_AIR_POLLUTION_SCR                 EPA Air Pollution Score 
	STRING2			EPA_GREENHOUSE_GAS_SCR;						//465     30090-30091						EPA_GREENHOUSE_GAS_SCR                EPA Greenhouse Gas Score 
	STRING5			EPA_SMART_WAY_CD;									//466     30093-30097						EPA_SMART_WAY_CD                      EPA Smart Way/Smart Way Elite Code 
	STRING250		EPA_SMART_WAY_DESC;								//467     30099-30348 					EPA_SMART_WAY_DESC                    EPA Smart Way/Smart Way Elite Description 
	STRING2			MA_COLL_SYMB;											//468     30350-30351           MA_COLL_SYMB                          Contains the two position Collision Symbol for 2011 and newer model years 
	STRING2			MA_COMP_SYMB;											//469     30353-30354           MA_COMP_SYMB                          Contains the two position Comprehensive Symbol for 2011 and newer model years 
	STRING2			MA_BASE_SYMB;											//470     30356-30357           MA_BASE_SYMB                          Physical damage base symbol for Massachusetts exclusively 
	STRING2			MA_VSR_SYMB;											//471     30359-30360           MA_VSR_SYMB                           Physical damage comprehensive symbol for Massachusetts exclusively 
	STRING1			MA_PERFORMANCE_IND;								//472     30362-30362           MA_PERFORMANCE_IND                    Contains the one position High Performance Code 4 = Sporty premium (This previously coded as a Ã‚Â¿PÃ‚Â¿)2 = High Performance (This previously coded as 
	STRING1			MA_ROLL_IND;											//473     30364-30364           MA_ROLL_IND                           It is common insurance industry practice to Ã‚Â¿roll overÃ‚Â¿ insurance symbols from the previous model year into the new model year. An Ã‚Â¿RÃ‚Â¿ is placed in this field to indicate that the symbol for an existing series / model has been continued into the new model year and is not yet in the country-wide book for the new model year. These symbols are phased out via normal software updates as the symbols are updated and published.  This code is provided as a service to users, and use of the associated symbol is optional 
	STRING1			PROACTIVE_IND;										//474     30366-30366           PROACTIVE_IND                         A Proactive VIN has been created, prior to the new model year's actual VIN production, using manufacturers' data and probable existing VIN 
	STRING5			MAK_CD;														//475     30368-30372           MAK_CD                                The Polk assigned Make Code.  Polk currently assigns a make abbreviation for each new make, using three characters.  The NCIC also assigns a make abbreviation for all makes.  Polk would like to avoid the process of creating a Make Abbreviation for vehicle 
	STRING5			MDL_CD;														//476     30374-30377           MDL_CD                                (Model Code) A Polk assigned code given to a Model Ex. Pontiac (Make) GTO (Model). In VINA the Model is part of the series code. 
	STRING1			RPS_ABS_BRK_CD;										//477     30379-30379           RPS_ABS_BRK_CD                        (Code) Identifies if ABS Brakes are available for the vehicle, i.e., A computer-controlled system that senses when one or more of the tires are skidding during heavy braking and rapidly modulates hydraulic brake pressure to redu 
	STRING250		RPS_ABS_BRK_DESC;									//478     30381-30630           RPS_ABS_BRK_DESC                      (Description) Identifies if ABS Brakes are available for the vehicle, i.e., A computer-controlled system that senses when one or more of the tires are skidding during heavy braking and rapidly modulates hydraulic brake pressure to redu 
	STRING1			RPS_ADAPT_CRUISE_CTL_CD;					//479     30632-30632           RPS_ADAPT_CRUISE_CTL_CD               (Description) Identifies if Intelligent Cruise Control is available for the vehicle, i.e. An advanced cruise control system that allows a vehicle to keep moving at a set speed without use of the gas pedal and maintains a set interval f 
	STRING250		RPS_ADAPT_CRUISE_CTL_DESC;				//480     30634-30883           RPS_ADAPT_CRUISE_CTL_DESC             (Code) Identifies if Intelligent Cruise Control is available for the vehicle, i.e. An advanced cruise control system that allows a vehicle to keep moving at a set speed without use of the gas pedal and maintains a set interval f 
	STRING1			RPS_ADAPT_HEADLIGHT_CD;						//481     30885-30885           RPS_ADAPT_HEADLIGHT_CD                (Code) Identifies if Cornering Lights are available for the vehicle, i.e., Exterior lights mounted on the side of a vehicle that are activated with the directionals to illuminate the road in the direction the vehicle is turning. 
	STRING250		RPS_ADAPT_HEADLIGHT_DESC;					//482     30887-31136           RPS_ADAPT_HEADLIGHT_DESC              (Description) Identifies if Cornering Lights are available for the vehicle, i.e., Exterior lights mounted on the side of a vehicle that are activated with the directionals to illuminate the road in the direction the vehicle is turning. 
	STRING5			RPS_ADVNC_VEH_TYPE_CD;						//483     31138-31142           RPS_ADVNC_VEH_TYPE_CD                 (Code) Identifies a vehicle as a Hybrid Electric Vehicle (HEV), Plug-in Hybrid Electric Vehicle, Fuel Cell Electric Vehicle (FCEV) or an Electric Vehicle (EV).  
	STRING250		RPS_ADVNC_VEH_TYPE_DESC;					//484     31144-31393           RPS_ADVNC_VEH_TYPE_DESC               (Description) Identifies a vehicle as a Hybrid Electric Vehicle (HEV), Plug-in Hybrid Electric Vehicle, Fuel Cell Electric Vehicle (FCEV) or an Electric Vehicle (EV).  
	STRING1			RPS_AUTO_BRK_CD;									//485     31395-31395           RPS_AUTO_BRK_CD                       (Code) Identifies if Electronic Brake Assistance is available for the vehicle, i.e., A system that measures the speed and force with which the brake pedal has been pushed, determining whether the driver has attempted an emergenc 
	STRING250		RPS_AUTO_BRK_DESC;								//486     31397-31646           RPS_AUTO_BRK_DESC                     (Description) Identifies if Electronic Brake Assistance is available for the vehicle, i.e., A system that measures the speed and force with which the brake pedal has been pushed, determining whether the driver has attempted an emergenc 
	STRING1			RPS_AUTO_PARK_CD;									//487     31648-31648           RPS_AUTO_PARK_CD                      (Code) Identifies if an electronic parking aid is available for the system, i.e. A system that utilizes ultrasonic sensors located in the front and/or rear bumper(s) to detect nearby objects. 
	STRING250		RPS_AUTO_PARK_DESC;								//488     31650-31899           RPS_AUTO_PARK_DESC                    (Description) Identifies if an electronic parking aid is available for the system, i.e. A system that utilizes ultrasonic sensors located in the front and/or rear bumper(s) to detect nearby objects. 
	STRING20		RPS_BAT_KW_RATG_CD;								//489     31901-31920           RPS_BAT_KW_RATG_CD                    Battery Output 
	STRING20		RPS_BODY_STYLE_CD;								//490     31922-31941           RPS_BODY_STYLE_CD                     (Code) Body Style: The identification of a vehicle based on the shape of the exterior body configuration.  Body Styles include Coupe, Sedan, Convertible, Wagon, Pick-Up Trick, Passenger Van or Cargo Van. 
	STRING250		RPS_BODY_STYLE_DESC;							//491     31943-32192           RPS_BODY_STYLE_DESC                   (Description) Body Style: The identification of a vehicle based on the shape of the exterior body configuration.  Body Styles include Coupe, Sedan, Convertible, Wagon, Pick-Up Trick, Passenger Van or Cargo Van. 
	STRING4			RPS_BOX_CARGO_HGT_INCH;						//492     32194-32197           RPS_BOX_CARGO_HGT_INCH                Applies to specific body styles: PK - Pick Up, TU - Sport Utility Truck, UT - Sport Utility Vehicle, CG - Van Cargo; For body styles PK and TU the box height is the distance from the floor of the bed to the top of the bed wall. For body styles UT, and CG the cargo height is from the floor of the cargo area to the ceiling as reported by the OEM 
	STRING5			RPS_BOX_CARGO_LEN_INCH;						//493     32199-32203           RPS_BOX_CARGO_LEN_INCH                Applies to specific body styles: PK - Pick Up, TU - Sport Utility Truck, UT - Sport Utility Vehicle, CG - Van Cargo; For body styles PK and TU the box height is the distance from the floor of the bed to the top of the bed wall. For body styles UT, and CG the cargo height is from the floor of the cargo area to the ceiling as reported by the OEM 
	STRING1			RPS_BREAK_RESIST_GLASS_CD;				//494     32205-32205           RPS_BREAK_RESIST_GLASS_CD             (Code) Identifies if Break Resistant Security Glass is available for the vehicle, i.e., A theft deterrent feature that prevents unwanted entry into a vehicle through breaking of the windshield, rear window or side windows. 
	STRING250		RPS_BREAK_RESIST_GLASS_DESC;			//495     32207-32456           RPS_BREAK_RESIST_GLASS_DESC           (Description) Identifies if Break Resistant Security Glass is available for the vehicle, i.e., A theft deterrent feature that prevents unwanted entry into a vehicle through breaking of the windshield, rear window or side windows. 
	STRING5			RPS_CURB_WT_MAN_TRANS;						//496     32458-32462           RPS_CURB_WT_MAN_TRANS                 The weight of the manual transmission version of a given vehicle if a manual transmission option is available 
	STRING2			RPS_DOOR_CNT;											//497     32464-32465           RPS_DOOR_CNT                          Doors (Maximum): The highest number of doors available on the vehicle, taking into account any optional doors. Optional doors may be available on trucks or vans. 
	STRING3			RPS_DRV_TYP_CD;										//498     32467-32469           RPS_DRV_TYP_CD                        (Code) Driveline: The standard location of the driven wheels. FWD = Front Wheel Drive, RWD = Rear Wheel Drive, 4WD-PT = 4WD Part Time, 4WD-FT = 4WD Full Time, AWD = All Wheel Drive and 4WD-SEL = 4WD Selectable. 
	STRING250		RPS_DRV_TYP_DESC;									//499     32471-32720           RPS_DRV_TYP_DESC                      ( Description) Driveline: The standard location of the driven wheels. FWD = Front Wheel Drive, RWD = Rear Wheel Drive, 4WD-PT = 4WD Part Time, 4WD-FT = 4WD Full Time, AWD = All Wheel Drive and 4WD-SEL = 4WD Selectable. 
	STRING1			RPS_DR_LGHT_OPT_CD;								//500     32722-32722           RPS_DR_LGHT_OPT_CD                    (Code) Identifies if a Daytime Running Lights are available for the vehicle 
	STRING250		RPS_DR_LGHT_OPT_DESC;							//501     32724-32973           RPS_DR_LGHT_OPT_DESC                  (Description) Identifies if a Daytime Running Lights are available for the vehicle 
	STRING1			RPS_EMER_FUEL_SHUTOFF_DEV_CD;			//502     32975-32975           RPS_EMER_FUEL_SHUTOFF_DEV_CD          (Code) Fuel Shutoff valve or FSV for short. Blocks the flow of fuel to the engine, releases the working pressure of the fuel system, from the fuel pump to the engine creating negative pressure or a vacuum within milliseconds of impact, so that if the pressurized fuel system is ruptured, the fuel will be drawn back, rather than spray and squirt everywhere. 
	STRING250		RPS_EMER_FUEL_SHUTOFF_DEV_DESC;		//503     32977-33226           RPS_EMER_FUEL_SHUTOFF_DEV_DESC        (Desc) Fuel Shutoff valve or FSV for short. Blocks the flow of fuel to the engine, releases the working pressure of the fuel system, from the fuel pump to the engine creating negative pressure or a vacuum within milliseconds of impact, so that if the pressurized fuel system is ruptured, the fuel will be drawn back, rather than spray and squirt everywhere. 
	STRING1			RPS_ENG_ASP_SUP_CHGR_CD;					//504     33228-33228           RPS_ENG_ASP_SUP_CHGR_CD               (Code) Supercharged: An air pump that is mechanically driven by the engine and is designed to force more air into the engine in order to produce higher power. Designers often use Superchargers to produce power levels similar to 
	STRING250		RPS_ENG_ASP_SUP_CHGR_DESC;				//505     33230-33479           RPS_ENG_ASP_SUP_CHGR_DESC             (Description) Supercharged: An air pump that is mechanically driven by the engine and is designed to force more air into the engine in order to produce higher power. Designers often use Superchargers to produce power levels similar to 
	STRING1			RPS_ENG_ASP_TRBL_CHGR_CD;					//506     33481-33481           RPS_ENG_ASP_TRBL_CHGR_CD              (Code) Turbocharged:  A centrifugal air pump driven by the engineÃ‚Â¿s exhaust designed to force more air into the engine in order to produce higher power. 
	STRING250		RPS_ENG_ASP_TRBL_CHGR_DESC;				//507     33483-33732           RPS_ENG_ASP_TRBL_CHGR_DESC            (Description) Turbocharged:  A centrifugal air pump driven by the engineÃ‚Â¿s exhaust designed to force more air into the engine in order to produce higher power. 
	STRING250		RPS_ENG_CBRT_TYP_CD;							//508     33734-33983           RPS_ENG_CBRT_TYP_CD                   (Code) Identifies the vehicle carburetion type.   For example Carburator, Fuel Injection, Unknown or Electric n/a 
	STRING250		RPS_ENG_CBRT_TYP_DESC;						//509     33985-34234           RPS_ENG_CBRT_TYP_DESC                 (Description) Identifies the vehicle carburetion type.   For example Carburator, Fuel Injection, Unknown or Electric n/a 
	STRING4			RPS_ENG_COMPRESSION_RATIO;				//510     34236-34239           RPS_ENG_COMPRESSION_RATIO             Compression Ratio for the given engine as reported by the OEM 
	STRING1			RPS_ENG_CYCL_CNT;									//511     34241-34241           RPS_ENG_CYCL_CNT                      Cylinders The internal openings of an engine block where the pistons travel and combustion occurs. 
	STRING5			RPS_ENG_DISPLCMNT_CC;							//512     34243-34247           RPS_ENG_DISPLCMNT_CC                  Displacement CC: When the pistons of an internal combustion engine move, they displace a volume of air-fuel mixture. Generally, the larger the displacement, the larger the engine, the more air-fuel is displaced, and the r 
	STRING5			RPS_ENG_DISPLCMNT_CI;							//513     34249-34253           RPS_ENG_DISPLCMNT_CI                  Displacement CI: When the pistons of an internal combustion engine move, they displace a volume of air-fuel mixture. Generally, the larger the displacement, the larger the engine, the more air-fuel is displaced, and the r 
	STRING1			RPS_ENG_FUEL_CD;									//514     34255-34255           RPS_ENG_FUEL_CD                       (Code) Fuel Type: The fuel source typically Gas, Diesel, Flexible Fuel (Ethanol), Compressed Natural Gas, Electric or Hybrid. 
	STRING250		RPS_ENG_FUEL_DESC;								//515     34257-34506           RPS_ENG_FUEL_DESC                     (Description) Fuel Type: The fuel source typically Gas, Diesel, Flexible Fuel (Ethanol), Compressed Natural Gas, Electric or Hybrid. 
	STRING3			RPS_ENG_FUEL_INJ_TYP_CD;					//516     34508-34510           RPS_ENG_FUEL_INJ_TYP_CD               (Code) Fuel System: The type of mechanisms that delivers fuel to the engine. Typical fuel systems are MPFI, EFI, SEFI, etc. 
	STRING250		RPS_ENG_FUEL_INJ_TYP_DESC;				//517     34512-34761           RPS_ENG_FUEL_INJ_TYP_DESC             (Description) Fuel System: The type of mechanisms that delivers fuel to the engine. Typical fuel systems are MPFI, EFI, SEFI, etc. 
	STRING4			RPS_ENG_HEAD_CNFG_CD;							//518     34763-34766           RPS_ENG_HEAD_CNFG_CD                  (Code) Valve Configuration: The arrangement of the camshaft(s) in relationship to their number and their location. Typical valve configurations are SOHC, DOHC, OHV, etc. 
	STRING250		RPS_ENG_HEAD_CNFG_DESC;						//519     34768-35017           RPS_ENG_HEAD_CNFG_DESC                (Description) Valve Configuration: The arrangement of the camshaft(s) in relationship to their number and their location. Typical valve configurations are SOHC, DOHC, OHV, etc. 
	STRING2			RPS_ENG_LOC_CD;										//520     35019-35020           RPS_ENG_LOC_CD                        (Code) The physical location of the engine. 
	STRING250		RPS_ENG_LOC_DESC;									//521     35022-35271           RPS_ENG_LOC_DESC                      (Description) The physical location of the engine. 
	STRING2			RPS_ENG_VLVS_TOTL;								//522     35273-35274           RPS_ENG_VLVS_TOTL                     Valves: Trumpet-shaped valves open and close to control intake and exhaust of fuel and air to the cylinder chambers, where combustion occurs. 
	STRING20		RPS_ENTERTAIN_CD;									//523     35276-35295           RPS_ENTERTAIN_CD                      (Code) Represents the type of entertainment system that is standard on the base model 
	STRING250		RPS_ENTERTAIN_DESC;								//524     35297-35546           RPS_ENTERTAIN_DESC                    (Description) Represents the type of entertainment system that is standard on the base model 
	STRING10		RPS_EPA_CLSFCN_CD;								//525     35548-35557           RPS_EPA_CLSFCN_CD                     (Code) The Classification of a Vehicle by the EPA 
	STRING250		RPS_EPA_CLSFCN_DESC;							//526     35559-35808           RPS_EPA_CLSFCN_DESC                   (Description) The Classification of a Vehicle by the EPA 
	STRING10		RPS_FRNT_CRASH_TST_RATING_CD;			//527     35810-35819           RPS_FRNT_CRASH_TST_RATING_CD          (Code) Crash test rating as reported by the National Highway Traffic Safety Administration (NHTSA) 
	STRING250		RPS_FRNT_CRASH_TST_RATING_DESC;		//528     35821-36070           RPS_FRNT_CRASH_TST_RATING_DESC        (Description) Crash test rating as reported by the National Highway Traffic Safety Administration (NHTSA) 
	STRING4			RPS_FRONT_HEADROOM_INCH;					//529     36072-36075           RPS_FRONT_HEADROOM_INCH               The head room for the first row of a given vehicle in inches as reported by the OEM 
	STRING4			RPS_FRONT_HIPROOM_INCH;						//530     36077-36080           RPS_FRONT_HIPROOM_INCH                The hip room for the first row of a given vehicle in inches as reported by the OEM 
	STRING4			RPS_FRONT_LEGROOM_INCH;						//531     36082-36085           RPS_FRONT_LEGROOM_INCH                The leg room for the first row of a given vehicle in inches as reported by the OEM 
	STRING4			RPS_FRONT_SHOULDER_ROOM_INCH;			//532     36087-36090           RPS_FRONT_SHOULDER_ROOM_INCH          The shoulder room for the first row of a given vehicle in inches as reported by the OEM 
	STRING5			RPS_FRONT_SUSPENSION_TYPE_CD;			//533     36092-36096           RPS_FRONT_SUSPENSION_TYPE_CD          The type of front suspension in a given vehicle as reported by the OEM 
	STRING250		RPS_FRONT_SUSPENSION_TYPE_DESC;		//534     36098-36347           RPS_FRONT_SUSPENSION_TYPE_DESC        The type of front suspension in a given vehicle as reported by the OEM 
	STRING4			RPS_FRONT_TRACK_INCH;							//535     36349-36352           RPS_FRONT_TRACK_INCH                  The length in inches from the center of the front left tire to the center of the front right tire, as reported by the OEM. Also called "Front Tread" 
	STRING4			RPS_FUEL_CPCTY_GALLONS;						//536     36354-36357           RPS_FUEL_CPCTY_GALLONS                The total fuel capacity (in gallons) for the vehicle with standard equipment as reported by the OEM. The Fuel Capacity measurement does not include optional second fuel tanks for trucks 
	STRING1			RPS_HANDS_FREE_CD;								//537     36359-36359           RPS_HANDS_FREE_CD                     (Code) Identifies if a Hands Free or Voice Activated Telephone is available for the vehicle 
	STRING250		RPS_HANDS_FREE_DESC;							//538     36361-36610           RPS_HANDS_FREE_DESC                   (Description) Identifies if a Hands Free or Voice Activated Telephone is available for the vehicle 
	STRING3			RPS_HP_BASE;											//539     36612-36614           RPS_HP_BASE                           Horsepower is a measure of engine output, typically expressed as the amount of work needed to lift a 550 pound mass at a rate of one foot per second. This value is as reported by the OEM for a given vehicle in the standard or base configuration 
	STRING5			RPS_HP_RPM;												//540     36616-36620           RPS_HP_RPM                            RPM at Peak Horsepower: The measurable point at which a given engine is producing its maximum horsepower measured in revolutions per minute. This value is as reported by the OEM for a given vehicle 
	STRING3			RPS_HYBRID_HORSEPOWER_RPM;				//541     36622-36624           RPS_HYBRID_HORSEPOWER_RPM             RPM at Peak Horsepower for a Hybrid vehicle as reported by the OEM 
	STRING3			RPS_HYBRID_TORQUE_FEET_POUND;			//542     36626-36628           RPS_HYBRID_TORQUE_FEET_POUND          Torque Feet Per Pound as reported by the OEM for a Hybrid vehicle 
	STRING5			RPS_HYBRID_TORQUE_RPM;						//543     36630-36634           RPS_HYBRID_TORQUE_RPM                 RPM at Peak Torque as reported by the OEM for a Hybrid vehicle 
	STRING50		RPS_MAK_NM;												//544     36636-36685           RPS_MAK_NM                            OEM division that produces the vehicle 
	STRING10		RPS_MAX_TOW_CPCTY;								//545     36687-36696           RPS_MAX_TOW_CPCTY                     Tow Capacity (Maximum): The highest possible weight that could be pulled, taking into account any optional features that could increase towing capacity for the given vehicle to the extent that can be account for in the VIN pattern, as reported by the OEM 
	STRING4			RPS_MDL_CD;												//546     36698-36701           RPS_MDL_CD                            (Code) Model name of the vehicle 
	STRING250		RPS_MDL_DESC;											//547     36703-36952           RPS_MDL_DESC                          (Description) Model name of the vehicle 
	STRING4			RPS_MDL_YR;												//548     36954-36957           RPS_MDL_YR                            Model year of the vehicle 
	STRING15		RPS_MFG_BAS_MSRP;									//549     36959-36973           RPS_MFG_BAS_MSRP                      Equipped Price: The total of the Manufacturer Suggested Retail Price (MSRP) and Optional Equipment of Base Model  
	STRING10		RPS_MFG_BSC_WRTY_MILES_CD;				//550     36975-36984           RPS_MFG_BSC_WRTY_MILES_CD             Warranty Basic Time (Miles): The length of the manufacturer basic warranty expressed in miles 
	STRING250		RPS_MFG_BSC_WRTY_MILES_DESC;			//551     36986-37235           RPS_MFG_BSC_WRTY_MILES_DESC           Warranty Basic Time (Miles): The length of the manufacturer basic warranty expressed in miles 
	STRING5			RPS_MFG_BSC_WRTY_MTH;							//552     37237-37241           RPS_MFG_BSC_WRTY_MTH                  Warranty Basic Time (Months): The length of the manufacturer basic warranty expressed in months 
	STRING1			RPS_MIRROR_SIGNAL_CD;							//553     37243-37243           RPS_MIRROR_SIGNAL_CD                  (Code) Identifeis if Signaling Exterior Mirrors are available for the vehicle, i.e., Exterior rearview mirrors with integral turn signal indicators that help other vehicles see a drivers turning intentions, especially when trave 
	STRING250		RPS_MIRROR_SIGNAL_DESC;						//554     37245-37494           RPS_MIRROR_SIGNAL_DESC                (Description) Identifeis if Signaling Exterior Mirrors are available for the vehicle, i.e., Exterior rearview mirrors with integral turn signal indicators that help other vehicles see a drivers turning intentions, especially when trave 
	STRING22		RPS_MOTOR_PWR_OUTPUT_KW;					//555     37496-37517           RPS_MOTOR_PWR_OUTPUT_KW               A standard measurement of an electric engine ability to perform work over a given amount of time, measured in BHP (boiler horsepower unit) 
	STRING22		RPS_MPG_CITY;											//556     37519-37540           RPS_MPG_CITY                          Fuel Economy City: The EPA fuel mileage of a vehicle when driven in city conditions. 
	STRING22		RPS_MPG_CMBND;										//557     37542-37563           RPS_MPG_CMBND                         Combined Fuel Economy: The EPA fuel mileage of a vehicle based on the average of both city and highway fuel economies. 
	STRING22		RPS_MPG_HIGHWAY;									//558     37565-37586           RPS_MPG_HIGHWAY                       Fuel Economy Highway: The EPA fuel mileage of a vehicle when driven in highway conditions. 
	STRING20		RPS_OPT1_ENTERTAIN_CD;						//559     37588-37607           RPS_OPT1_ENTERTAIN_CD                 (Code) Type of entertainment system that is optional on the model/trim of the vehicle 
	STRING250		RPS_OPT1_ENTERTAIN_DESC;					//560     37609-37858           RPS_OPT1_ENTERTAIN_DESC               (Description) Type of entertainment system that is optional on the model/trim of the vehicle 
	STRING20		RPS_OPT1_ROOF_CD;									//561     37860-37879           RPS_OPT1_ROOF_CD                      (Code) Type of roof that is optional of the vehicle.   
	STRING250		RPS_OPT1_ROOF_DESC;								//562     37881-38130           RPS_OPT1_ROOF_DESC                    (Description) Type of roof that is optional of the vehicle.   
	STRING250		RPS_OPT1_TRIM_DESC;								//563     38132-38381           RPS_OPT1_TRIM_DESC                    The trim of the vehicle.  This field is used when a VIN Pattern could have more than 1 trim assigned. 
	STRING20		RPS_OPT2_ENTERTAIN_CD;						//564     38383-38402           RPS_OPT2_ENTERTAIN_CD                 (Code) Type of entertainment system that is optional on the model/trim of the vehicle 
	STRING250		RPS_OPT2_ENTERTAIN_DESC;					//565     38404-38653           RPS_OPT2_ENTERTAIN_DESC               (Description) Type of entertainment system that is optional on the model/trim of the vehicle 
	STRING20		RPS_OPT2_ROOF_CD;									//566     38655-38674           RPS_OPT2_ROOF_CD                      (Code) Type of roof that is optional of the vehicle.   
	STRING250		RPS_OPT2_ROOF_DESC;								//567     38676-38925           RPS_OPT2_ROOF_DESC                    (Description) Type of roof that is optional of the vehicle.   
	STRING250		RPS_OPT2_TRIM_DESC;								//568     38927-39176           RPS_OPT2_TRIM_DESC                    The trim of the vehicle.  This field is used when a VIN Pattern could have more than 1 trim assigned. 
	STRING20		RPS_OPT3_ENTERTAIN_CD;						//569     39178-39197           RPS_OPT3_ENTERTAIN_CD                 (Code) Type of entertainment system that is optional on the model/trim of the vehicle 
	STRING250		RPS_OPT3_ENTERTAIN_DESC;					//570     39199-39448           RPS_OPT3_ENTERTAIN_DESC               (Description) Type of entertainment system that is optional on the model/trim of the vehicle 
	STRING20		RPS_OPT3_ROOF_CD;									//571     39450-39469           RPS_OPT3_ROOF_CD                      (Code) Type of roof that is optional of the vehicle.   
	STRING250		RPS_OPT3_ROOF_DESC;								//572     39471-39720           RPS_OPT3_ROOF_DESC                    (Description) Type of roof that is optional of the vehicle.   
	STRING250		RPS_OPT3_TRIM_DESC;								//573     39722-39971           RPS_OPT3_TRIM_DESC                    The trim of the vehicle.  This field is used when a VIN Pattern could have more than 1 trim assigned. 
	STRING20		RPS_OPT4_ENTERTAIN_CD;						//574     39973-39992           RPS_OPT4_ENTERTAIN_CD                 (Code) Type of entertainment system that is optional on the model/trim of the vehicle 
	STRING250		RPS_OPT4_ENTERTAIN_DESC;					//575     39994-40243           RPS_OPT4_ENTERTAIN_DESC               (Description) Type of entertainment system that is optional on the model/trim of the vehicle 
	STRING20		RPS_OPT4_ROOF_CD;									//576     40245-40264           RPS_OPT4_ROOF_CD                      (Code) Type of roof that is optional of the vehicle.   
	STRING250		RPS_OPT4_ROOF_DESC;								//577     40266-40515           RPS_OPT4_ROOF_DESC                    (Description) Type of roof that is optional of the vehicle.   
	STRING250		RPS_OPT4_TRIM_DESC;								//578     40517-40766           RPS_OPT4_TRIM_DESC                    The trim of the vehicle.  This field is used when a VIN Pattern could have more than 1 trim assigned. 
	STRING4			RPS_PASSENGER_VOL;								//579     40768-40771           RPS_PASSENGER_VOL                     The total cubic volume of the passenger compartment in cubic feet of a given vehicle as reported by the OEM; if the passenger volume is not reported by the OEM, the calculation of the cubic inches per row summed and converted to cubic feet 
	STRING5			RPS_PAYLOAD_MAX;									//580     40773-40777           RPS_PAYLOAD_MAX                       Payload (Maximum): The maximum weight of people, cargo and body equipment that is allowed when certain option packages are purchased that would allow more weight to be carried, I.e. heavy duty suspension and shock absorbers.  
	STRING5			RPS_PAYLOAD_STD;									//581     40779-40783           RPS_PAYLOAD_STD                       Payload (Standard): The weight of the actual cargo and occupant(s) that can be carried by the standard or base vehicle, as reported by the OEM 
	STRING50		RPS_PLNT_CNTRY_NM;								//582     40785-40834           RPS_PLNT_CNTRY_NM                     The country the vehicle is produced in. 
	STRING10		RPS_POWERTRAIN_WRTY_MILES_CD;			//583     40836-40845           RPS_POWERTRAIN_WRTY_MILES_CD          Warranty Powertrain Time (Miles): The length of the manufacturer powertrain warranty expressed in miles 
	STRING250		RPS_POWERTRAIN_WRTY_MILES_DESC;		//584     40847-41096           RPS_POWERTRAIN_WRTY_MILES_DESC        Warranty Powertrain Time (Miles): The length of the manufacturer powertrain warranty expressed in miles 
	STRING5			RPS_POWERTRAIN_WRTY_MTHS;					//585     41098-41102           RPS_POWERTRAIN_WRTY_MTHS              Warranty Powertrain Time (Months): The length of the manufacturer powertrain warranty expressed in months 
	STRING4			RPS_PWR_TO_WT_RATIO;							//586     41104-41107           RPS_PWR_TO_WT_RATIO                   Power To Weight Ratio: The ratio of the standard horsepower to the standard curb weight of a vehicle -- read as the number of pounds per 1 horsepower (Curb Weight / Horsepower) as reported by the OEM 
	STRING5			RPS_REAR_SUSPENSION_TYPE_CD;			//587     41109-41113           RPS_REAR_SUSPENSION_TYPE_CD           The type of rear suspension in a given vehicle as reported by the OEM 
	STRING250		RPS_REAR_SUSPENSION_TYPE_DESC;		//588     41115-41364           RPS_REAR_SUSPENSION_TYPE_DESC         The type of rear suspension in a given vehicle as reported by the OEM 
	STRING4			RPS_REAR_TRACK_INCH;							//589     41366-41369           RPS_REAR_TRACK_INCH                   The length from the center of the rear left tire to the center of the rear right tire, as reported by the OEM. Also called "Rear Tread". 
	STRING10		RPS_ROLLOVER_TEST_RATING_CD;			//590     41371-41380           RPS_ROLLOVER_TEST_RATING_CD           Crash test rating as reported by the National Highway Traffic Safety Administration (NHTSA) 
	STRING250		RPS_ROLLOVER_TEST_RATING_DESC;		//591     41382-41631           RPS_ROLLOVER_TEST_RATING_DESC         Crash test rating as reported by the National Highway Traffic Safety Administration (NHTSA) 
	STRING20		RPS_ROOF_CD;											//592     41633-41652           RPS_ROOF_CD                           (Code) Type of roof that is standard on the base model 
	STRING250		RPS_ROOF_DESC;										//593     41654-41903           RPS_ROOF_DESC                         (Description) Type of roof that is standard on the base model 
	STRING1			RPS_RSTRNT_TYP_CD;								//594     41905-41905           RPS_RSTRNT_TYP_CD                     (Code) Identifies the type of restraints that a vehicle has based on VIN 
	STRING250		RPS_RSTRNT_TYP_DESC;							//595     41907-42156           RPS_RSTRNT_TYP_DESC                   (Description) Identifies the type of restraints that a vehicle has based on VIN 
	STRING10		RPS_RUST_WRTY_MILES_CD;						//596     42158-42167           RPS_RUST_WRTY_MILES_CD                Warranty Rust (Miles): The length of the manufacturer rust/corrosion warranty expressed in miles 
	STRING250		RPS_RUST_WRTY_MILES_DESC;					//597     42169-42418           RPS_RUST_WRTY_MILES_DESC              Warranty Rust (Miles): The length of the manufacturer rust/corrosion warranty expressed in miles 
	STRING5			RPS_RUST_WRTY_MTHS;								//598     42420-42424           RPS_RUST_WRTY_MTHS                    Warranty Rust Time (Months): The length of the manufacturer rust/corrosion warranty expressed in months 
	STRING1 		RPS_SECUR_TYP_CD;									//599     42426-42426           RPS_SECUR_TYP_CD                      (Code) Identifies if Vehicle Anti-Theft is available for the vehicle, i.e., A system that provides anti-theft protection to the entire vehicle. 
	STRING250		RPS_SECUR_TYP_DESC;								//600     42428-42677           RPS_SECUR_TYP_DESC                    (Description) Identifies if Vehicle Anti-Theft is available for the vehicle, i.e., A system that provides anti-theft protection to the entire vehicle. 
	STRING4			RPS_SEC_ROW_HEADROOM_INCH;				//601     42679-42682           RPS_SEC_ROW_HEADROOM_INCH             The head room for the second row of a given vehicle in inches as reported by the OEM 
	STRING4			RPS_SEC_ROW_HIPROOM_INCH;					//602     42684-42687           RPS_SEC_ROW_HIPROOM_INCH              The hip room for the second row of a given vehicle in inches as reported by the OEM 
	STRING4			RPS_SEC_ROW_LEGROOM_INCH;					//603     42689-42692           RPS_SEC_ROW_LEGROOM_INCH              The leg room for the second row of a given vehicle in inches as reported by the OEM 
	STRING4			RPS_SEC_ROW_SHOULDER_ROOM_INCH;		//604     42694-42697           RPS_SEC_ROW_SHOULDER_ROOM_INCH        The shoulder room for the second row of a given vehicle in inches as reported by the OEM 
	STRING2			RPS_SEGMENTATION_CD;							//605     42699-42700           RPS_SEGMENTATION_CD                   (Code) Consumer Segment: The identification of a car or sport utility based on the combination of body style and family, sport or luxury classifications; the identification of a pickup as compact or full size; the identification 
	STRING150		RPS_SEGMENTATION_DESC;						//606     42702-42851           RPS_SEGMENTATION_DESC                 (Description) Consumer Segment: The identification of a car or sport utility based on the combination of body style and family, sport or luxury classifications; the identification of a pickup as compact or full size; the identification 
	STRING6			RPS_SHIP_WGHT_LBS;								//607     42853-42858           RPS_SHIP_WGHT_LBS                     Contains the base weight of the vehicle, rounded to the nearest one hundred pounds, as defined in the OEM specifications.  The base weight of a vehicle is the empty weight of the base model of the vehicle (i.e., the stripped down version of the vehicle 
	STRING10		RPS_SIDE_CRASH_TST_RATING_CD;			//608     42860-42869           RPS_SIDE_CRASH_TST_RATING_CD          (Code) Crash test rating as reported by the National Highway Traffic Safety Administration (NHTSA) 
	STRING250		RPS_SIDE_CRASH_TST_RATING_DESC;		//609     42871-43120           RPS_SIDE_CRASH_TST_RATING_DESC        (Description) Crash test rating as reported by the National Highway Traffic Safety Administration (NHTSA) 
	STRING5			RPS_STD_GVWR;											//610     43122-43126           RPS_STD_GVWR                          GVWR (Standard): The maximum loaded weight of the base vehicle 
	STRING5			RPS_STD_PASSENGER_SEAT_CNT;				//611     43128-43132           RPS_STD_PASSENGER_SEAT_CNT            Seating (Standard): The number of passengers that can be accommodated given the standard seating configuration for the vehicle as reported by the OEM 
	STRING10		RPS_STD_TOW_CPCTY;								//612     43134-43143           RPS_STD_TOW_CPCTY                     Tow Capacity (Standard): The weight that could be towed given the standard or base powertrain of a given vehicle as reported by the OEM 
	STRING1 		RPS_STRNG_WHL_MOUNTED_CTL_CD;			//613     43145-43145           RPS_STRNG_WHL_MOUNTED_CTL_CD          Identifies if Steering Wheel Mounted Controls are available for the vehicle 
	STRING250		RPS_STRNG_WHL_MOUNTED_CTL_DESC;		//614     43147-43396           RPS_STRNG_WHL_MOUNTED_CTL_DESC        Identifies if Steering Wheel Mounted Controls are available for the vehicle 
	STRING4			RPS_THRD_ROW_HEADROOM_INCH;				//615     43398-43401           RPS_THRD_ROW_HEADROOM_INCH            The head room for the third row, if applicable, of a given vehicle in inches as reported by the OEM 
	STRING4			RPS_THRD_ROW_HIPROOM_INCH;				//616     43403-43406           RPS_THRD_ROW_HIPROOM_INCH             The hip room for the third row, if applicable, of a given vehicle in inches as reported by the OEM 
	STRING4			RPS_THRD_ROW_LEGROOM_INCH;				//617     43408-43411           RPS_THRD_ROW_LEGROOM_INCH             The leg room for the third row, if applicable, of a given vehicle in inches as reported by the OEM 
	STRING4			RPS_THRD_ROW_SHOULDR_ROOM_INCH;		//618     43413-43416           RPS_THRD_ROW_SHOULDR_ROOM_INCH        The shoulder room for the third row, if applicable, of a given vehicle in inches as reported by the OEM 
	STRING3			RPS_TORQUE_FEET_LB;								//619     43418-43420           RPS_TORQUE_FEET_LB                    Torque Feet Per Pound as reported by the OEM 
	STRING5			RPS_TORQUE_RPM;										//620     43422-43426           RPS_TORQUE_RPM                        RPM at Peak Torque as reported by the OEM 
	STRING20		RPS_TRANS_CD;											//621     43428-43447           RPS_TRANS_CD                          (Code) Standard Transmission: The transmission included in a vehicle at no extra charge. 
	STRING250		RPS_TRANS_DESC;										//622     43449-43698           RPS_TRANS_DESC                        Standard Transmission: The transmission included in a vehicle at no extra charge. 
	STRING20		RPS_TRANS_OVERDRV_IND;						//623     43700-43719           RPS_TRANS_OVERDRV_IND                 Overdrive Transmission: A transmission that features a gear ratio that is less than 1:1 and typically provides for better fuel economy and reduces engine wear. 
	STRING20		RPS_TRANS_SPEED_CD;								//624     43721-43740           RPS_TRANS_SPEED_CD                    Transmission Speeds: The number of available forward speeds typically 3 through 6 or variable . 
	STRING250		RPS_TRIM_DESC;										//625     43742-43991           RPS_TRIM_DESC                         The Trim of the vehicle 
	STRING5			RPS_VEH_HGT_INCH;									//626     43993-43997           RPS_VEH_HGT_INCH                      The height from the vehicle roof to the ground in inches as reported by the OEM 
	STRING1 		RPS_VEH_THEFT_TRACK_CD;						//627     43999-43999           RPS_VEH_THEFT_TRACK_CD                (Code) Identifies if Vehicle Theft Tracking/Notification is available for the vehicle, i.e., A system based upon Global Positioning System(GPS), cell phone technology and/or in-vehicle radio signal transmitters that can assist a 
	STRING250		RPS_VEH_THEFT_TRACK_DESC;					//628     44001-44250           RPS_VEH_THEFT_TRACK_DESC              (Code) Identifies if Vehicle Theft Tracking/Notification is available for the vehicle, i.e., A system based upon Global Positioning System(GPS), cell phone technology and/or in-vehicle radio signal transmitters that can assist a 
	STRING1 		RPS_VISUAL_BACKUP_ASST_CD;				//629     44252-44252           RPS_VISUAL_BACKUP_ASST_CD             (Code) identifies presence of rear visibility technology that expands the field of view to enable the driver of a motor vehicle to detect areas behind the vehicle to reduce death and injury resulting from back over incidents 
	STRING250		RPS_VISUAL_BACKUP_ASST_DESC;			//630     44254-44503           RPS_VISUAL_BACKUP_ASST_DESC           (Description) identifies presence of rear visibility technology that expands the field of view to enable the driver of a motor vehicle to detect areas behind the vehicle to reduce death and injury resulting from back over incidents 
	STRING1 		RPS_VOICE_CNTL_NAVIGAT_CD;				//631     44505-44505           RPS_VOICE_CNTL_NAVIGAT_CD             (Code) Identifies if a navigational aid is available for the vehicle, i.e. a system that provides navigational instructions via a visual display using Global Positioning Satellite (GPS) technology and/or CD-ROM based map databas 
	STRING250		RPS_VOICE_CNTL_NAVIGAT_DESC;			//632     44507-44756           RPS_VOICE_CNTL_NAVIGAT_DESC           (Description) Identifies if a navigational aid is available for the vehicle, i.e. a system that provides navigational instructions via a visual display using Global Positioning Satellite (GPS) technology and/or CD-ROM based map databas 
	STRING1 		RPS_WHEEL_LOCK_CD;								//633     44758-44758           RPS_WHEEL_LOCK_CD                     (Code) Identifies if Wheel Locks are available for the vehicle, i.e., A special lug nut that serves to deter the theft of a wheel by requiring a specific "key" for installation and removal. 
	STRING250		RPS_WHEEL_LOCK_DESC;							//634     44760-45009           RPS_WHEEL_LOCK_DESC                   (Description) Identifies if Wheel Locks are available for the vehicle, i.e., A special lug nut that serves to deter the theft of a wheel by requiring a specific "key" for installation and removal. 
	STRING6			RPS_WHL_BAS_LNGST_INCHS;					//635     45011-45016           RPS_WHL_BAS_LNGST_INCHS               Contains the longest distance between the front and rear axles of a vehicle in inches for a particular series of that vehicle.  
	STRING6			RPS_WHL_BAS_SHRST_INCHS;					//636     45018-45023           RPS_WHL_BAS_SHRST_INCHS               Contains the distance between the front and rear axles of a vehicle in inches of the base model of the vehicle.  

END;
