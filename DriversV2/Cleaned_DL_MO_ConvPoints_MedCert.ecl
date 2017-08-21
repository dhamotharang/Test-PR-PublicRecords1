IMPORT Drivers, DriversV2, ut, lib_stringlib, _Validate;

EXPORT Cleaned_DL_MO_ConvPoints_MedCert(STRING processDate, STRING fileDate) := FUNCTION

  in_file := DriversV2.File_DL_MO_MedCert_RAW(fileDate);
 
  TrimUpper(STRING s):= FUNCTION
		RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
  END;

  // Indicates whether the record layout is the new layout containing medical certification info
  layout_out := DriversV2.Layouts_DL_MO_New_In.Layout_MO_Fixed_MedCert;
	
  layout_out  trans1(in_file l) := TRANSFORM
	  SELF.Unique_Key           := l.Line[1..10];
	  SELF.Rec_Len              := l.Line[11..15];
	 //********* Basic Record          101-350   ****************
	 SELF.Lic_Number           := l.Line[101..110];             
	 SELF.Last_Name            := l.Line[111..150];            
	 SELF.First_Name           := l.Line[151..190];             
	 SELF.Middle_Name          := l.Line[191..225];             
	 SELF.Suffix               := l.Line[226..230]; 
	 //The new layout contains unused field in 231-236
	 SELF.Birthdate            := l.Line[237..244];             
	 SELF.Gender               := l.Line[245..245];             
	 SELF.Address              := l.Line[246..270];             
	 SELF.City                 := l.Line[271..290];             
	 SELF.State                := l.Line[291..292];             
	 SELF.Zip5                 := l.Line[293..297];             
	 SELF.Zip4                 := l.Line[298..301];            
	 SELF.Mailing_Address1     := l.Line[302..326];             
	 SELF.Mailing_Address2     := l.Line[327..351];             
	 SELF.Mailing_City         := l.Line[352..371];             
	 SELF.Mailing_State        := l.Line[372..373];             
	 SELF.Mailing_Zip          := l.Line[374..382];             
	 SELF.Height               := l.Line[383..385];             
	 SELF.Weight               := l.Line[386..388];             
	 SELF.Eye_Color            := l.Line[389..389];             
	 SELF.Operator_Status      := l.Line[390..391];             
	 SELF.Commercial_Status    := l.Line[392..393];             
	 SELF.Sch_Bus_Status       := l.Line[394..395];             
	 SELF.Pending_Act_Code     := l.Line[396..396];             
	 SELF.Must_Test_Ind        := l.Line[397..397];             
	 SELF.Deceased_Ind         := l.Line[398..398];              
	 SELF.Prev_CDL_Class       := l.Line[399..400];             
	 SELF.CDL_Ptr              := l.Line[401..401];             
	 SELF.PDPS_Ptr             := l.Line[402..402];             
	 SELF.MVR_Privacy_Code     := l.Line[403..403];             
	 SELF.BRC_Status_Code      := l.Line[404..404];             
	 SELF.BRC_Status_Date      := l.Line[405..412];             
	 //********* License Issuance Record   ****************
	 SELF.Lic_Iss_Code         := l.Line[461..461];             
	 SELF.Lic_Class            := l.Line[462..463];             
	 SELF.Lic_Exp_Date         := l.Line[464..471];             
	 SELF.Lic_Seq_Number       := l.Line[472..483];             
	 SELF.Lic_Surrender_From   := l.Line[484..485];             
	 SELF.Lic_Surrender_To     := l.Line[486..487];             
	 SELF.New_Out_of_St_DL_Num := l.Line[488..512];             
	 SELF.Lic_Endorsements     := l.Line[513..522];             
	 SELF.Lic_Restrictions     := l.Line[523..527];             
	 SELF.Lic_Trans_Type       := l.Line[533..534];             
	 SELF.Lic_Print_Date       := l.Line[535..542];             
	 SELF.Permit_Iss_Code      := l.Line[553..553];             
	 SELF.Permit_Class         := l.Line[554..555];             
	 SELF.Permit_Exp_Date      := l.Line[556..563];             
	 SELF.Permit_Seq_Number    := l.Line[564..575];             
	 SELF.Permit_Endorse_Codes := l.Line[576..585];             
	 SELF.Permit_Restric_Codes := l.Line[586..590];             
	 SELF.Permit_Trans_Type    := l.Line[596..597];             
	 SELF.Permit_Print_Date    := l.Line[598..605];             
	 SELF.Non_Drvr_Code        := l.Line[608..608];             
	 SELF.Non_Drvr_Exp_Date    := l.Line[609..616];             
	 SELF.Non_Drvr_Seq_Num     := l.Line[617..628];             
	 SELF.Non_Drvr_Trans_Type  := l.Line[629..630];             
	 SELF.Non_Drvr_Print_Date  := l.Line[631..638];             
	 //********* Other Records    ****************
	 SELF.Action_Surrender_Date:= l.Line[709..716];             
	 SELF.Action_Counts        := (UNSIGNED4)l.Line[1137..1139];  
	 SELF.Driv_Priv_Counts     := (UNSIGNED4)l.Line[1140..1142];  
	 SELF.Conv_Counts          := (UNSIGNED4)l.Line[1143..1145];  
	 SELF.Accidents_Counts     := (UNSIGNED4)l.Line[1146..1148];  
	 SELF.AKA_Counts           := (UNSIGNED4)l.Line[1149..1151];  
	 //********* Starting Position of the other records
	 UNSIGNED4 Act_st          := 1158;   
	 UNSIGNED4 Act_end         := Act_st + (SELF.Action_Counts * 120);	
	 UNSIGNED4 DP_st           := Act_end; 
	 UNSIGNED4 DP_end          := DP_st + (SELF.Driv_Priv_Counts * 40);	 
	 UNSIGNED4 Con_st          := DP_end;
	 UNSIGNED4 Con_end         := Con_st + (SELF.Conv_Counts * 110);	
	 UNSIGNED4 Acc_st          := Con_end;
	 UNSIGNED4 Acc_end         := Acc_st +(SELF.Accidents_Counts * 50);	
	 UNSIGNED4 AKA_st          := Acc_end;
	 UNSIGNED4 AKA_end         := AKA_st +(SELF.AKA_Counts * 171);
	 SELF.Action_Recs          := IF(SELF.Action_Counts > 0, L.Line[Act_st..(Act_end - 1)],'');
	 SELF.Driv_Priv_Recs       := IF(SELF.Driv_Priv_Counts > 0, L.Line[DP_st..(DP_end - 1)],'');
	 SELF.Convict_Recs         := IF(SELF.Conv_Counts > 0, L.Line[Con_st..(Con_end - 1)],'');
	 SELF.Accident_Recs        := IF(SELF.Accidents_Counts > 0, L.Line[Acc_st..(Acc_end - 1)],'');
	 SELF.AKA_Recs             := IF(SELF.AKA_Counts > 0, L.Line[AKA_st..(AKA_end - 1)],'');
 END;
 
  inrecs := PROJECT(in_file, trans1(left));
	
	//********* Action Records *****************************************************************************
	Layouts_DL_MO_New_In.Layout_MO_Actions transActions1(inrecs l, UNSIGNED4 C) := TRANSFORM,SKIP(l.Action_Recs = '')
	  SELF.Unique_Key        := l.Unique_Key;
	  SELF.Action_Type       := CHOOSE(C,l.Action_Recs[1..4], l.Action_Recs[121..124], l.Action_Recs[241..244], l.Action_Recs[361..364], l.Action_Recs[481..484],l.Action_Recs[601..604],
																			 l.Action_Recs[721..724],l.Action_Recs[841..844],l.Action_Recs[961..964], l.Action_Recs[1081..1084],l.Action_Recs[1201..1204], l.Action_Recs[1321..1324],
																			 l.Action_Recs[1441..1444], l.Action_Recs[1561..1564], l.Action_Recs[1681..1684], l.Action_Recs[1801..1804], l.Action_Recs[1921..1924], l.Action_Recs[2041..2044],
																			 l.Action_Recs[2161..2164], l.Action_Recs[2281..2284], l.Action_Recs[2401..2404], l.Action_Recs[2521..2524], l.Action_Recs[2641..2644], l.Action_Recs[2761..2764],
																			 l.Action_Recs[2881..2884], l.Action_Recs[3001..3004], l.Action_Recs[3121..3124], l.Action_Recs[3241..3244], l.Action_Recs[3361..3364], l.Action_Recs[3481..3484],
																			 l.Action_Recs[3601..3604], l.Action_Recs[3721..3724], l.Action_Recs[3841..3844], l.Action_Recs[3961..3964], l.Action_Recs[4081..4084], l.Action_Recs[4201..4204],
																			 l.Action_Recs[4321..4324], l.Action_Recs[4441..4444], l.Action_Recs[4561..4564], l.Action_Recs[4681..4684], l.Action_Recs[4801..4804], l.Action_Recs[4921..4924],
																			 l.Action_Recs[5041..5044], l.Action_Recs[5161..5164], l.Action_Recs[5281..5284], l.Action_Recs[5401..5404], l.Action_Recs[5521..5524], l.Action_Recs[5641..5644],
																			 l.Action_Recs[5761..5764], l.Action_Recs[5881..5884], l.Action_Recs[6001..6004], l.Action_Recs[6121..6124], l.Action_Recs[6241..6244], l.Action_Recs[6361..6364],
																			 l.Action_Recs[6481..6484], l.Action_Recs[6601..6604], l.Action_Recs[6721..6724], l.Action_Recs[6841..6844], l.Action_Recs[6961..6964], l.Action_Recs[7081..7084]);
																			 
		SELF.Action_Case_Num   := CHOOSE(C,l.Action_Recs[5..22],  l.Action_Recs[125..142], l.Action_Recs[245..262],  l.Action_Recs[365..382], l.Action_Recs[485..502],  l.Action_Recs[605..622],
																			 l.Action_Recs[725..742],  l.Action_Recs[845..862], l.Action_Recs[965..982], l.Action_Recs[1085..1102], l.Action_Recs[1205..1222], l.Action_Recs[1325..1342],
																			 l.Action_Recs[1445..1462], l.Action_Recs[1565..1582], l.Action_Recs[1685..1702], l.Action_Recs[1805..1822], l.Action_Recs[1925..1942], l.Action_Recs[2045..2062],
																			 l.Action_Recs[2165..2182], l.Action_Recs[2285..2302], l.Action_Recs[2405..2422], l.Action_Recs[2525..2542], l.Action_Recs[2645..2662], l.Action_Recs[2765..2782],
																			 l.Action_Recs[2885..2902], l.Action_Recs[3005..3022], l.Action_Recs[3125..3132], l.Action_Recs[3245..3252], l.Action_Recs[3365..3382], l.Action_Recs[3485..3502],
																			 l.Action_Recs[3605..3622], l.Action_Recs[3725..3742], l.Action_Recs[3845..3862], l.Action_Recs[3965..3982], l.Action_Recs[4085..4102], l.Action_Recs[4205..4222],
																			 l.Action_Recs[4325..4342], l.Action_Recs[4445..4462], l.Action_Recs[4565..4582], l.Action_Recs[4685..4702], l.Action_Recs[4805..4822], l.Action_Recs[4925..4942],
																			 l.Action_Recs[5045..5062], l.Action_Recs[5165..5182], l.Action_Recs[5285..5302], l.Action_Recs[5405..5422], l.Action_Recs[5525..5542], l.Action_Recs[5645..5662],
																			 l.Action_Recs[5765..5782], l.Action_Recs[5885..5902], l.Action_Recs[6005..6022], l.Action_Recs[6125..6132], l.Action_Recs[6245..6252], l.Action_Recs[6365..6382],
																			 l.Action_Recs[6485..6502], l.Action_Recs[6605..6622], l.Action_Recs[6725..6742], l.Action_Recs[6845..6862], l.Action_Recs[6965..6982], l.Action_Recs[7085..7102]);
																			 
		SELF.Action_Eff_Date   := CHOOSE(C,l.Action_Recs[23..30], l.Action_Recs[143..150], l.Action_Recs[263..270], l.Action_Recs[383..390], l.Action_Recs[503..510], l.Action_Recs[623..630],
																			 l.Action_Recs[743..750], l.Action_Recs[863..870], l.Action_Recs[983..990], l.Action_Recs[1103..1110], l.Action_Recs[1223..1230], l.Action_Recs[1343..1350],
																			 l.Action_Recs[1463..1470], l.Action_Recs[1583..1590], l.Action_Recs[1703..1710], l.Action_Recs[1823..1830], l.Action_Recs[1943..1950], l.Action_Recs[2063..2070],
																			 l.Action_Recs[2183..2190], l.Action_Recs[2303..2310], l.Action_Recs[2423..2430], l.Action_Recs[2543..2550], l.Action_Recs[2663..2670], l.Action_Recs[2783..2790],
																			 l.Action_Recs[2903..2910], l.Action_Recs[3023..3030], l.Action_Recs[3133..3150], l.Action_Recs[3253..3270], l.Action_Recs[3383..3390], l.Action_Recs[3503..3510],
																			 l.Action_Recs[3623..3630], l.Action_Recs[3743..3750], l.Action_Recs[3863..3870], l.Action_Recs[3983..3990], l.Action_Recs[4103..4110], l.Action_Recs[4223..4230],
																			 l.Action_Recs[4343..4350], l.Action_Recs[4463..4470], l.Action_Recs[4583..4590], l.Action_Recs[4703..4710], l.Action_Recs[4823..4830], l.Action_Recs[4943..4950],
																			 l.Action_Recs[5063..5070], l.Action_Recs[5183..5190], l.Action_Recs[5303..5310], l.Action_Recs[5423..5430], l.Action_Recs[5543..5550], l.Action_Recs[5663..5670],
																			 l.Action_Recs[5783..5790], l.Action_Recs[5903..5910], l.Action_Recs[6023..6030], l.Action_Recs[6143..6150], l.Action_Recs[6263..6270], l.Action_Recs[6383..6390],
																			 l.Action_Recs[6503..6510], l.Action_Recs[6623..6630], l.Action_Recs[6743..6750], l.Action_Recs[6863..6870], l.Action_Recs[6983..6990], l.Action_Recs[7103..7110]);

		SELF.Action_Reinst_Date:= CHOOSE(C,l.Action_Recs[31..38], l.Action_Recs[151..158], l.Action_Recs[271..278], l.Action_Recs[391..398], l.Action_Recs[511..518], l.Action_Recs[631..638],
																			 l.Action_Recs[751..758], l.Action_Recs[871..878], l.Action_Recs[991..998], l.Action_Recs[1111..1118], l.Action_Recs[1231..1238], l.Action_Recs[1351..1358],
																			 l.Action_Recs[1471..1478], l.Action_Recs[1591..1598], l.Action_Recs[1711..1718], l.Action_Recs[1831..1838], l.Action_Recs[1951..1958], l.Action_Recs[2071..2078],
																			 l.Action_Recs[2191..2198], l.Action_Recs[2311..2318], l.Action_Recs[2431..2438], l.Action_Recs[2551..2558], l.Action_Recs[2671..2678], l.Action_Recs[2791..2798],
																			 l.Action_Recs[2911..2918], l.Action_Recs[3031..3038], l.Action_Recs[3151..3158], l.Action_Recs[3271..3278], l.Action_Recs[3391..3398], l.Action_Recs[3511..3518],
																			 l.Action_Recs[3631..3638], l.Action_Recs[3751..3758], l.Action_Recs[3871..3878], l.Action_Recs[3991..3998], l.Action_Recs[4111..4118], l.Action_Recs[4231..4238],
																			 l.Action_Recs[4351..4358], l.Action_Recs[4471..4478], l.Action_Recs[4591..4598], l.Action_Recs[4711..4718], l.Action_Recs[4831..4838], l.Action_Recs[4951..4958],
																			 l.Action_Recs[5071..5078], l.Action_Recs[5191..5198], l.Action_Recs[5311..5318], l.Action_Recs[5431..5438], l.Action_Recs[5551..5558], l.Action_Recs[5671..5678],
																			 l.Action_Recs[5791..5798], l.Action_Recs[5911..5918], l.Action_Recs[6031..6038], l.Action_Recs[6151..6158], l.Action_Recs[6271..6278], l.Action_Recs[6391..6398],
																			 l.Action_Recs[6511..6518], l.Action_Recs[6631..6638], l.Action_Recs[6751..6758], l.Action_Recs[6871..6878], l.Action_Recs[6991..6998], l.Action_Recs[7111..7118]);

		SELF.Action_Status_Code := CHOOSE(C,l.Action_Recs[39..41], l.Action_Recs[159..161], l.Action_Recs[279..281], l.Action_Recs[399..401], l.Action_Recs[519..521], l.Action_Recs[639..641],
																			 l.Action_Recs[759..761], l.Action_Recs[879..881], l.Action_Recs[999..1001], l.Action_Recs[1119..1121], l.Action_Recs[1239..1241], l.Action_Recs[1359..1361],
																			 l.Action_Recs[1479..1481], l.Action_Recs[1599..1601], l.Action_Recs[1719..1721], l.Action_Recs[1839..1841], l.Action_Recs[1959..1961], l.Action_Recs[2079..2081],
																			 l.Action_Recs[2199..2201], l.Action_Recs[2319..2321], l.Action_Recs[2439..2441], l.Action_Recs[2559..2561], l.Action_Recs[2679..2681], l.Action_Recs[2799..2801],
																			 l.Action_Recs[2919..2921], l.Action_Recs[3039..3041], l.Action_Recs[3159..3161], l.Action_Recs[3279..3281], l.Action_Recs[3399..3401], l.Action_Recs[3519..3521],
																			 l.Action_Recs[3639..3641], l.Action_Recs[3759..3761], l.Action_Recs[3879..3881], l.Action_Recs[3999..4001], l.Action_Recs[4119..4121], l.Action_Recs[4239..4241],
																			 l.Action_Recs[4359..4361], l.Action_Recs[4479..4481], l.Action_Recs[4599..4601], l.Action_Recs[4719..4721], l.Action_Recs[4839..4841], l.Action_Recs[4959..4961],
																			 l.Action_Recs[5079..5081], l.Action_Recs[5199..5201], l.Action_Recs[5319..5321], l.Action_Recs[5439..5441], l.Action_Recs[5559..5561], l.Action_Recs[5679..5681],
																			 l.Action_Recs[5799..5801], l.Action_Recs[5919..5921], l.Action_Recs[6039..6041], l.Action_Recs[6159..6161], l.Action_Recs[6279..6281], l.Action_Recs[6399..6401],
																			 l.Action_Recs[6519..6521], l.Action_Recs[6639..6641], l.Action_Recs[6759..6761], l.Action_Recs[6879..6881], l.Action_Recs[6999..7001], l.Action_Recs[7119..7121]);

		SELF.Action_Status_Date  := CHOOSE(C,l.Action_Recs[42..49], l.Action_Recs[162..169], l.Action_Recs[282..289], l.Action_Recs[402..409], l.Action_Recs[522..529], l.Action_Recs[642..649],
																			 l.Action_Recs[762..769], l.Action_Recs[882..889], l.Action_Recs[1002..1009], l.Action_Recs[1122..1129], l.Action_Recs[1242..1249], l.Action_Recs[1362..1369],
																			 l.Action_Recs[1482..1489], l.Action_Recs[1602..1609], l.Action_Recs[1722..1729], l.Action_Recs[1842..1849], l.Action_Recs[1962..1969], l.Action_Recs[2082..2089],
																			 l.Action_Recs[2202..2209], l.Action_Recs[2322..2329], l.Action_Recs[2442..2449], l.Action_Recs[2562..2569], l.Action_Recs[2682..2689], l.Action_Recs[2802..2809],
																			 l.Action_Recs[2922..2929], l.Action_Recs[3042..3049], l.Action_Recs[3162..3169], l.Action_Recs[3282..3289], l.Action_Recs[3402..3409], l.Action_Recs[3522..3529],
																			 l.Action_Recs[3642..3649], l.Action_Recs[3762..3769], l.Action_Recs[3882..3889], l.Action_Recs[4002..4009], l.Action_Recs[4122..4129], l.Action_Recs[4242..4249],
																			 l.Action_Recs[4362..4369], l.Action_Recs[4482..4489], l.Action_Recs[4602..4609], l.Action_Recs[4722..4729], l.Action_Recs[4842..4849], l.Action_Recs[4962..4969],
																			 l.Action_Recs[5082..5089], l.Action_Recs[5202..5209], l.Action_Recs[5322..5329], l.Action_Recs[5442..5449], l.Action_Recs[5562..5569], l.Action_Recs[5682..5689],
																			 l.Action_Recs[5802..5809], l.Action_Recs[5922..5929], l.Action_Recs[6042..6049], l.Action_Recs[6162..6169], l.Action_Recs[6282..6289], l.Action_Recs[6402..6409],
																			 l.Action_Recs[6522..6529], l.Action_Recs[6642..6649], l.Action_Recs[6762..6769], l.Action_Recs[6882..6889], l.Action_Recs[7002..7009], l.Action_Recs[7122..7129]);

		SELF.Action_State_Offense := CHOOSE(C,l.Action_Recs[50..51], l.Action_Recs[170..171], L.Action_Recs[290..291], L.Action_Recs[410..411], l.Action_Recs[530..531], l.Action_Recs[650..651],
																			 l.Action_Recs[770..771], l.Action_Recs[890..891], l.Action_Recs[1010..1011], l.Action_Recs[1130..1131], l.Action_Recs[1250..1251], l.Action_Recs[1370..1371],
																			 l.Action_Recs[1490..1491], l.Action_Recs[1610..1611], l.Action_Recs[1730..1731], l.Action_Recs[1850..1851], l.Action_Recs[1970..1971], l.Action_Recs[2090..2091],
																			 l.Action_Recs[2210..2211], l.Action_Recs[2330..2331], l.Action_Recs[2450..2451], l.Action_Recs[2570..2571], l.Action_Recs[2690..2691], l.Action_Recs[2810..2811],
																			 l.Action_Recs[2930..2931], l.Action_Recs[3050..3051], l.Action_Recs[3170..3171], l.Action_Recs[3290..3291], l.Action_Recs[3410..3411], l.Action_Recs[3530..3531],
																			 l.Action_Recs[3650..3651], l.Action_Recs[3770..3771], l.Action_Recs[3890..3891], l.Action_Recs[4010..4011], l.Action_Recs[4130..4131], l.Action_Recs[4250..4251],
																			 l.Action_Recs[4370..4371], l.Action_Recs[4490..4491], l.Action_Recs[4610..4611], l.Action_Recs[4730..4731], l.Action_Recs[4850..4851], l.Action_Recs[4970..4971],
																			 l.Action_Recs[5090..5091], l.Action_Recs[5210..5211], l.Action_Recs[5330..5331], l.Action_Recs[5450..5451], l.Action_Recs[5570..5571], l.Action_Recs[5690..5691],
																			 l.Action_Recs[5810..5811], l.Action_Recs[5930..5931], l.Action_Recs[6050..6051], l.Action_Recs[6170..6171], l.Action_Recs[6290..6291], l.Action_Recs[6410..6411],
																			 l.Action_Recs[6530..6531], l.Action_Recs[6650..6651], l.Action_Recs[6770..6771], l.Action_Recs[6890..6891], l.Action_Recs[7010..7011], l.Action_Recs[7130..7131]);

		SELF.Action_Offense_Date  := CHOOSE(C,l.Action_Recs[52..59], l.Action_Recs[172..179], l.Action_Recs[292..299], l.Action_Recs[412..419], l.Action_Recs[532..539], l.Action_Recs[652..659],
																			 l.Action_Recs[772..779], l.Action_Recs[892..899], l.Action_Recs[1012..1019], l.Action_Recs[1132..1139], l.Action_Recs[1252..1259], l.Action_Recs[1372..1379],
																			 l.Action_Recs[1492..1499], l.Action_Recs[1612..1619], l.Action_Recs[1732..1739], l.Action_Recs[1852..1859], l.Action_Recs[1972..1979], l.Action_Recs[2092..2099],
																			 l.Action_Recs[2212..2219], l.Action_Recs[2332..2339], l.Action_Recs[2452..2459], l.Action_Recs[2572..2579], l.Action_Recs[2692..2699], l.Action_Recs[2812..2819],
																			 l.Action_Recs[2932..2939], l.Action_Recs[3052..3059], l.Action_Recs[3172..3179], l.Action_Recs[3292..3299], l.Action_Recs[3412..3419], l.Action_Recs[3532..3539],
																			 l.Action_Recs[3652..3659], l.Action_Recs[3772..3779], l.Action_Recs[3892..3899], l.Action_Recs[4012..4019], l.Action_Recs[4132..4139], l.Action_Recs[4252..4259],
																			 l.Action_Recs[4372..4379], l.Action_Recs[4492..4499], l.Action_Recs[4612..4619], l.Action_Recs[4732..4739], l.Action_Recs[4852..4859], l.Action_Recs[4972..4979],
																			 l.Action_Recs[5092..5099], l.Action_Recs[5212..5219], l.Action_Recs[5332..5339], l.Action_Recs[5452..5459], l.Action_Recs[5572..5579], l.Action_Recs[5692..5699],
																			 l.Action_Recs[5812..5819], l.Action_Recs[5932..5939], l.Action_Recs[6052..6059], l.Action_Recs[6172..6179], l.Action_Recs[6292..6299], l.Action_Recs[6412..6419],
																			 l.Action_Recs[6532..6539], l.Action_Recs[6652..6659], l.Action_Recs[6772..6779], l.Action_Recs[6892..6899], l.Action_Recs[7012..7019], l.Action_Recs[7132..7139]);

		SELF.Action_Tkt_Num       := CHOOSE(C,l.Action_Recs[60..68], l.Action_Recs[180..188], l.Action_Recs[300..308], l.Action_Recs[420..428], l.Action_Recs[540..548], l.Action_Recs[660..668],
																			 l.Action_Recs[780..788], l.Action_Recs[900..908], l.Action_Recs[1020..1028], l.Action_Recs[1140..1148], l.Action_Recs[1260..1268], l.Action_Recs[1380..1388],
																			 l.Action_Recs[1500..1508], l.Action_Recs[1620..1628], l.Action_Recs[1740..1748], l.Action_Recs[1860..1868], l.Action_Recs[1980..1988], l.Action_Recs[2100..2108],
																			 l.Action_Recs[2220..2228], l.Action_Recs[2340..2348], l.Action_Recs[2460..2468], l.Action_Recs[2580..2588], l.Action_Recs[2700..2708], l.Action_Recs[2820..2828],
																			 l.Action_Recs[2940..2948], l.Action_Recs[3060..3068], l.Action_Recs[3180..3188], l.Action_Recs[3300..3308], l.Action_Recs[3420..3428], l.Action_Recs[3540..3548],
																			 l.Action_Recs[3660..3668], l.Action_Recs[3780..3788], l.Action_Recs[3900..3908], l.Action_Recs[4020..4028], l.Action_Recs[4140..4148], l.Action_Recs[4260..4268],
																			 l.Action_Recs[4380..4388], l.Action_Recs[4500..4508], l.Action_Recs[4620..4628], l.Action_Recs[4740..4748], l.Action_Recs[4860..4868], l.Action_Recs[4980..4988],
																			 l.Action_Recs[5100..5108], l.Action_Recs[5220..5228], l.Action_Recs[5340..5348], l.Action_Recs[5460..5468], l.Action_Recs[5580..5588], l.Action_Recs[5700..5708],
																			 l.Action_Recs[5820..5828], l.Action_Recs[5940..5948], l.Action_Recs[6060..6068], l.Action_Recs[6180..6188], l.Action_Recs[6300..6308], l.Action_Recs[6420..6428],
																			 l.Action_Recs[6540..6548], l.Action_Recs[6660..6668], l.Action_Recs[6780..6788], l.Action_Recs[6900..6908], l.Action_Recs[7020..7028], l.Action_Recs[7140..7148]);

		SELF.Action_Haz_Mat_Ind  :=  CHOOSE(C,l.Action_Recs[69..69], l.Action_Recs[189..189], l.Action_Recs[309..309], l.Action_Recs[429..429], l.Action_Recs[549..549], l.Action_Recs[669..669],
																			 l.Action_Recs[789..789], l.Action_Recs[909..909], l.Action_Recs[1029..1029], l.Action_Recs[1149..1149], l.Action_Recs[1269..1269], l.Action_Recs[1389..1389],
																			 l.Action_Recs[1509..1509], l.Action_Recs[1629..1629], l.Action_Recs[1749..1749], l.Action_Recs[1869..1869], l.Action_Recs[1989..1989], l.Action_Recs[2109..2109],
																			 l.Action_Recs[2229..2229], l.Action_Recs[2349..2349], l.Action_Recs[2469..2469], l.Action_Recs[2589..2589], l.Action_Recs[2709..2709], l.Action_Recs[2829..2829],
																			 l.Action_Recs[2949..2949], l.Action_Recs[3069..3069], l.Action_Recs[3189..3189], l.Action_Recs[3309..3309], l.Action_Recs[3429..3429], l.Action_Recs[3549..3549],
																			 l.Action_Recs[3669..3669], l.Action_Recs[3789..3789], l.Action_Recs[3909..3909], l.Action_Recs[4029..4029], l.Action_Recs[4149..4149], l.Action_Recs[4269..4269],
																			 l.Action_Recs[4389..4389], l.Action_Recs[4509..4509], l.Action_Recs[4629..4629], l.Action_Recs[4749..4749], l.Action_Recs[4869..4869], l.Action_Recs[4989..4989],
																			 l.Action_Recs[5109..5109], l.Action_Recs[5229..5229], l.Action_Recs[5349..5349], l.Action_Recs[5469..5469], l.Action_Recs[5589..5589], l.Action_Recs[5709..5709],
																			 l.Action_Recs[5829..5829], l.Action_Recs[5949..5949], l.Action_Recs[6069..6069], l.Action_Recs[6189..6189], l.Action_Recs[6309..6309], l.Action_Recs[6429..6429],
																			 l.Action_Recs[6549..6549], l.Action_Recs[6669..6669], l.Action_Recs[6789..6789], l.Action_Recs[6909..6909], l.Action_Recs[7029..7029], l.Action_Recs[7149..7149]);

		SELF.Action_State        :=  CHOOSE(C,l.Action_Recs[70..71], l.Action_Recs[190..191], l.Action_Recs[310..311], l.Action_Recs[430..431], l.Action_Recs[550..551], l.Action_Recs[670..671],
																			 l.Action_Recs[790..791], l.Action_Recs[910..911], l.Action_Recs[1030..1031], l.Action_Recs[1150..1151], l.Action_Recs[1270..1271], l.Action_Recs[1390..1391],
																			 l.Action_Recs[1510..1511], l.Action_Recs[1630..1631], l.Action_Recs[1750..1751], l.Action_Recs[1870..1871], l.Action_Recs[1990..1991], l.Action_Recs[2110..2111],
																			 l.Action_Recs[2230..2231], l.Action_Recs[2350..2351], l.Action_Recs[2470..2471], l.Action_Recs[2590..2591], l.Action_Recs[2710..2711], l.Action_Recs[2830..2831],
																			 l.Action_Recs[2950..2951], l.Action_Recs[3070..3071], l.Action_Recs[3190..3191], l.Action_Recs[3310..3311], l.Action_Recs[3430..3431], l.Action_Recs[3550..3551],
																			 l.Action_Recs[3670..3671], l.Action_Recs[3790..3791], l.Action_Recs[3910..3911], l.Action_Recs[4030..4031], l.Action_Recs[4150..4151], l.Action_Recs[4270..4271],
																			 l.Action_Recs[4390..4391], l.Action_Recs[4510..4511], l.Action_Recs[4630..4631], l.Action_Recs[4750..4751], l.Action_Recs[4870..4871], l.Action_Recs[4990..4991],
																			 l.Action_Recs[5110..5111], l.Action_Recs[5230..5231], l.Action_Recs[5350..5351], l.Action_Recs[5470..5471], l.Action_Recs[5590..5591], l.Action_Recs[5710..5711],
																			 l.Action_Recs[5830..5831], l.Action_Recs[5950..5951], l.Action_Recs[6070..6071], l.Action_Recs[6190..6191], l.Action_Recs[6310..6311], l.Action_Recs[6430..6431],
																			 l.Action_Recs[6550..6551], l.Action_Recs[6670..6671], l.Action_Recs[6790..6791], l.Action_Recs[6910..6911], l.Action_Recs[7030..7031], l.Action_Recs[7150..7151]);

		SELF.Action_Filler1  := CHOOSE(C,l.Action_Recs[72..78], l.Action_Recs[192..198], l.Action_Recs[312..318], l.Action_Recs[432..438], l.Action_Recs[552..558], l.Action_Recs[672..678],
																			 l.Action_Recs[792..798], l.Action_Recs[912..918], l.Action_Recs[1032..1038], l.Action_Recs[1152..1158], l.Action_Recs[1272..1278], l.Action_Recs[1392..1398],
																			 l.Action_Recs[1512..1518], l.Action_Recs[1632..1638], l.Action_Recs[1752..1758], l.Action_Recs[1872..1878], l.Action_Recs[1992..1998], l.Action_Recs[2112..2118],
																			 l.Action_Recs[2232..2238], l.Action_Recs[2352..2358], l.Action_Recs[2472..2478], l.Action_Recs[2592..2598], l.Action_Recs[2712..2718], l.Action_Recs[2832..2838],
																			 l.Action_Recs[2952..2958], l.Action_Recs[3072..3078], l.Action_Recs[3192..3198], l.Action_Recs[3312..3318], l.Action_Recs[3432..3438], l.Action_Recs[3552..3558],
																			 l.Action_Recs[3672..3678], l.Action_Recs[3792..3798], l.Action_Recs[3912..3918], l.Action_Recs[4032..4038], l.Action_Recs[4152..4158], l.Action_Recs[4272..4278],
																			 l.Action_Recs[4392..4398], l.Action_Recs[4512..4518], l.Action_Recs[4632..4638], l.Action_Recs[4752..4758], l.Action_Recs[4872..4878], l.Action_Recs[4992..4998],
																			 l.Action_Recs[5112..5118], l.Action_Recs[5232..5238], l.Action_Recs[5352..5358], l.Action_Recs[5472..5478], l.Action_Recs[5592..5598], l.Action_Recs[5712..5718],
																			 l.Action_Recs[5832..5838], l.Action_Recs[5952..5958], l.Action_Recs[6072..6078], l.Action_Recs[6192..6198], l.Action_Recs[6312..6318], l.Action_Recs[6432..6438],
																			 l.Action_Recs[6552..6558], l.Action_Recs[6672..6678], l.Action_Recs[6792..6798], l.Action_Recs[6912..6918], l.Action_Recs[7032..7038], l.Action_Recs[7152..7158]);

		SELF.Action_OOS_Eval_Date  := CHOOSE(C,l.Action_Recs[79..86], l.Action_Recs[199..206], l.Action_Recs[319..326], l.Action_Recs[439..446], l.Action_Recs[559..566], l.Action_Recs[679..686],
																			 l.Action_Recs[799..806], l.Action_Recs[919..926], l.Action_Recs[1039..1046], l.Action_Recs[1159..1166], l.Action_Recs[1279..1286], l.Action_Recs[1399..1406],
																			 l.Action_Recs[1519..1526], l.Action_Recs[1639..1646], l.Action_Recs[1759..1766], l.Action_Recs[1879..1886], l.Action_Recs[1999..2006], l.Action_Recs[2119..2126],
																			 l.Action_Recs[2239..2246], l.Action_Recs[2359..2366], l.Action_Recs[2479..2486], l.Action_Recs[2599..2606], l.Action_Recs[2719..2726], l.Action_Recs[2839..2846],
																			 l.Action_Recs[2959..2966], l.Action_Recs[3079..3086], l.Action_Recs[3199..3206], l.Action_Recs[3319..3326], l.Action_Recs[3439..3446], l.Action_Recs[3559..3566],
																			 l.Action_Recs[3679..3686], l.Action_Recs[3799..3806], l.Action_Recs[3919..3926], l.Action_Recs[4039..4046], l.Action_Recs[4159..4166], l.Action_Recs[4279..4286],
																			 l.Action_Recs[4399..4406], l.Action_Recs[4519..4526], l.Action_Recs[4639..4646], l.Action_Recs[4759..4766], l.Action_Recs[4879..4886], l.Action_Recs[4999..5006],
																			 l.Action_Recs[5119..5126], l.Action_Recs[5239..5246], l.Action_Recs[5359..5366], l.Action_Recs[5479..5486], l.Action_Recs[5599..5606], l.Action_Recs[5719..5726],
																			 l.Action_Recs[5839..5846], l.Action_Recs[5959..5966], l.Action_Recs[6079..6086], l.Action_Recs[6199..6206], l.Action_Recs[6319..6326], l.Action_Recs[6439..6446],
																			 l.Action_Recs[6559..6566], l.Action_Recs[6679..6686], l.Action_Recs[6799..6806], l.Action_Recs[6919..6926], l.Action_Recs[7039..7046], l.Action_Recs[7159..7166]);

		SELF.Action_ACD_Code    := CHOOSE(C,l.Action_Recs[87..89], l.Action_Recs[207..209], l.Action_Recs[327..329], l.Action_Recs[447..449], l.Action_Recs[567..569], l.Action_Recs[687..689],
																			 l.Action_Recs[807..809], l.Action_Recs[927..929], l.Action_Recs[1047..1049], l.Action_Recs[1167..1169], l.Action_Recs[1287..1289], l.Action_Recs[1407..1409],
																			 l.Action_Recs[1527..1529], l.Action_Recs[1647..1649], l.Action_Recs[1767..1769], l.Action_Recs[1887..1889], l.Action_Recs[2007..2009], l.Action_Recs[2127..2129],
																			 l.Action_Recs[2247..2249], l.Action_Recs[2367..2369], l.Action_Recs[2487..2489], l.Action_Recs[2607..2609], l.Action_Recs[2727..2729], l.Action_Recs[2847..2849],
																			 l.Action_Recs[2967..2969], l.Action_Recs[3087..3089], l.Action_Recs[3207..3209], l.Action_Recs[3327..3329], l.Action_Recs[3447..3449], l.Action_Recs[3567..3569],
																			 l.Action_Recs[3687..3689], l.Action_Recs[3807..3809], l.Action_Recs[3927..3929], l.Action_Recs[4047..4049], l.Action_Recs[4167..4169], l.Action_Recs[4287..4289],
																			 l.Action_Recs[4407..4409], l.Action_Recs[4527..4529], l.Action_Recs[4647..4649], l.Action_Recs[4767..4769], l.Action_Recs[4887..4889], l.Action_Recs[5007..5009],
																			 l.Action_Recs[5127..5129], l.Action_Recs[5247..5249], l.Action_Recs[5367..5369], l.Action_Recs[5487..5489], l.Action_Recs[5607..5609], l.Action_Recs[5727..5729],
																			 l.Action_Recs[5847..5849], l.Action_Recs[5967..5969], l.Action_Recs[6087..6089], l.Action_Recs[6207..6209], l.Action_Recs[6327..6329], l.Action_Recs[6447..6449],
																			 l.Action_Recs[6567..6569], l.Action_Recs[6687..6689], l.Action_Recs[6807..6809], l.Action_Recs[6927..6929], l.Action_Recs[7047..7049], l.Action_Recs[7167..7169]);

		SELF.Action_WDraw_Code   := CHOOSE(C,l.Action_Recs[90..90], l.Action_Recs[210..210], l.Action_Recs[330..330], l.Action_Recs[450..450], l.Action_Recs[570..570], l.Action_Recs[690..690],
																			 l.Action_Recs[810..810], l.Action_Recs[930..930], l.Action_Recs[1050..1050], l.Action_Recs[1170..1170], l.Action_Recs[1290..1290], l.Action_Recs[1410..1410],
																			 l.Action_Recs[1530..1530], l.Action_Recs[1650..1650], l.Action_Recs[1770..1770], l.Action_Recs[1890..1890], l.Action_Recs[2010..2010], l.Action_Recs[2130..2130],
																			 l.Action_Recs[2250..2250], l.Action_Recs[2370..2370], l.Action_Recs[2490..2490], l.Action_Recs[2610..2610], l.Action_Recs[2730..2730], l.Action_Recs[2850..2850],
																			 l.Action_Recs[2970..2970], l.Action_Recs[3090..3090], l.Action_Recs[3210..3210], l.Action_Recs[3330..3330], l.Action_Recs[3450..3450], l.Action_Recs[3570..3570],
																			 l.Action_Recs[3690..3690], l.Action_Recs[3810..3810], l.Action_Recs[3930..3930], l.Action_Recs[4050..4050], l.Action_Recs[4170..4170], l.Action_Recs[4290..4290],
																			 l.Action_Recs[4410..4410], l.Action_Recs[4530..4530], l.Action_Recs[4650..4650], l.Action_Recs[4770..4770], l.Action_Recs[4890..4890], l.Action_Recs[5010..5010],
																			 l.Action_Recs[5130..5130], l.Action_Recs[5250..5250], l.Action_Recs[5370..5370], l.Action_Recs[5490..5490], l.Action_Recs[5610..5610], l.Action_Recs[5730..5730],
																			 l.Action_Recs[5850..5850], l.Action_Recs[5970..5970], l.Action_Recs[6090..6090], l.Action_Recs[6210..6210], l.Action_Recs[6330..6330], l.Action_Recs[6450..6450],
																			 l.Action_Recs[6570..6570], l.Action_Recs[6690..6690], l.Action_Recs[6810..6810], l.Action_Recs[6930..6930], l.Action_Recs[7050..7050], l.Action_Recs[7170..7170]);

		SELF.Action_WDraw_Basis   := CHOOSE(C,l.Action_Recs[91..91], l.Action_Recs[211..211], l.Action_Recs[331..331], l.Action_Recs[451..451], l.Action_Recs[571..571], l.Action_Recs[691..691],
																			 l.Action_Recs[811..811], l.Action_Recs[931..931], l.Action_Recs[1051..1051], l.Action_Recs[1171..1171], l.Action_Recs[1291..1291], l.Action_Recs[1411..1411],
																			 l.Action_Recs[1531..1531], l.Action_Recs[1651..1651], l.Action_Recs[1771..1771], l.Action_Recs[1891..1891], l.Action_Recs[2011..2011], l.Action_Recs[2131..2131],
																			 l.Action_Recs[2251..2251], l.Action_Recs[2371..2371], l.Action_Recs[2491..2491], l.Action_Recs[2611..2611], l.Action_Recs[2731..2731], l.Action_Recs[2851..2851],
																			 l.Action_Recs[2971..2971], l.Action_Recs[3091..3091], l.Action_Recs[3211..3211], l.Action_Recs[3331..3331], l.Action_Recs[3451..3451], l.Action_Recs[3571..3571],
																			 l.Action_Recs[3691..3691], l.Action_Recs[3811..3811], l.Action_Recs[3931..3931], l.Action_Recs[4051..4051], l.Action_Recs[4171..4171], l.Action_Recs[4291..4291],
																			 l.Action_Recs[4411..4411], l.Action_Recs[4531..4531], l.Action_Recs[4651..4651], l.Action_Recs[4771..4771], l.Action_Recs[4891..4891], l.Action_Recs[5011..5011],
																			 l.Action_Recs[5131..5131], l.Action_Recs[5251..5251], l.Action_Recs[5371..5371], l.Action_Recs[5491..5491], l.Action_Recs[5611..5611], l.Action_Recs[5731..5731],
																			 l.Action_Recs[5851..5851], l.Action_Recs[5971..5971], l.Action_Recs[6091..6091], l.Action_Recs[6211..6211], l.Action_Recs[6331..6331], l.Action_Recs[6451..6451],
																			 l.Action_Recs[6571..6571], l.Action_Recs[6691..6691], l.Action_Recs[6811..6811], l.Action_Recs[6931..6931], l.Action_Recs[7051..7051], l.Action_Recs[7171..7171]);

		SELF.Action_Process_Code  := CHOOSE(C,l.Action_Recs[92..92], l.Action_Recs[212..212], l.Action_Recs[332..332], l.Action_Recs[452..452], l.Action_Recs[572..572], l.Action_Recs[692..692],
																			 l.Action_Recs[812..812], l.Action_Recs[932..932], l.Action_Recs[1052..1052], l.Action_Recs[1172..1172], l.Action_Recs[1292..1292], l.Action_Recs[1412..1412],
																			 l.Action_Recs[1532..1532], l.Action_Recs[1652..1652], l.Action_Recs[1772..1772], l.Action_Recs[1892..1892], l.Action_Recs[2012..2012], l.Action_Recs[2132..2132],
																			 l.Action_Recs[2252..2252], l.Action_Recs[2372..2372], l.Action_Recs[2492..2492], l.Action_Recs[2612..2612], l.Action_Recs[2732..2732], l.Action_Recs[2852..2852],
																			 l.Action_Recs[2972..2972], l.Action_Recs[3092..3092], l.Action_Recs[3212..3212], l.Action_Recs[3332..3332], l.Action_Recs[3452..3452], l.Action_Recs[3572..3572],
																			 l.Action_Recs[3692..3692], l.Action_Recs[3812..3812], l.Action_Recs[3932..3932], l.Action_Recs[4052..4052], l.Action_Recs[4172..4172], l.Action_Recs[4292..4292],
																			 l.Action_Recs[4412..4412], l.Action_Recs[4532..4532], l.Action_Recs[4652..4652], l.Action_Recs[4772..4772], l.Action_Recs[4892..4892], l.Action_Recs[5012..5012],
																			 l.Action_Recs[5132..5132], l.Action_Recs[5252..5252], l.Action_Recs[5372..5372], l.Action_Recs[5492..5492], l.Action_Recs[5612..5612], l.Action_Recs[5732..5732],
																			 l.Action_Recs[5852..5852], l.Action_Recs[5972..5972], l.Action_Recs[6092..6092], l.Action_Recs[6212..6212], l.Action_Recs[6332..6332], l.Action_Recs[6452..6452],
																			 l.Action_Recs[6572..6572], l.Action_Recs[6692..6692], l.Action_Recs[6812..6812], l.Action_Recs[6932..6932], l.Action_Recs[7052..7052], l.Action_Recs[7172..7172]);

		SELF.Action_Extent_Code     := CHOOSE(C,l.Action_Recs[93..93], l.Action_Recs[213..213], l.Action_Recs[333..333], l.Action_Recs[453..453], l.Action_Recs[573..573], l.Action_Recs[693..693],
																			 l.Action_Recs[813..813], l.Action_Recs[933..933], l.Action_Recs[1053..1053], l.Action_Recs[1173..1173], l.Action_Recs[1293..1293], l.Action_Recs[1413..1413],
																			 l.Action_Recs[1533..1533], l.Action_Recs[1653..1653], l.Action_Recs[1773..1773], l.Action_Recs[1893..1893], l.Action_Recs[2013..2013], l.Action_Recs[2133..2133],
																			 l.Action_Recs[2253..2253], l.Action_Recs[2373..2373], l.Action_Recs[2493..2493], l.Action_Recs[2613..2613], l.Action_Recs[2733..2733], l.Action_Recs[2853..2853],
																			 l.Action_Recs[2973..2973], l.Action_Recs[3093..3093], l.Action_Recs[3213..3213], l.Action_Recs[3333..3333], l.Action_Recs[3453..3453], l.Action_Recs[3573..3573],
																			 l.Action_Recs[3693..3693], l.Action_Recs[3813..3813], l.Action_Recs[3933..3933], l.Action_Recs[4053..4053], l.Action_Recs[4173..4173], l.Action_Recs[4293..4293],
																			 l.Action_Recs[4413..4413], l.Action_Recs[4533..4533], l.Action_Recs[4653..4653], l.Action_Recs[4773..4773], l.Action_Recs[4893..4893], l.Action_Recs[5013..5013],
																			 l.Action_Recs[5133..5133], l.Action_Recs[5253..5253], l.Action_Recs[5373..5373], l.Action_Recs[5493..5493], l.Action_Recs[5613..5613], l.Action_Recs[5733..5733],
																			 l.Action_Recs[5853..5853], l.Action_Recs[5973..5973], l.Action_Recs[6093..6093], l.Action_Recs[6213..6213], l.Action_Recs[6333..6333], l.Action_Recs[6453..6453],
																			 l.Action_Recs[6573..6573], l.Action_Recs[6693..6693], l.Action_Recs[6813..6813], l.Action_Recs[6933..6933], l.Action_Recs[7053..7053], l.Action_Recs[7173..7173]);

		SELF.Action_WD_Ref_Num   := CHOOSE(C,l.Action_Recs[94..101], l.Action_Recs[214..221], l.Action_Recs[334..341], l.Action_Recs[454..461], l.Action_Recs[574..581], l.Action_Recs[694..701],
																			 l.Action_Recs[814..821], l.Action_Recs[934..941], l.Action_Recs[1054..1061], l.Action_Recs[1174..1181], l.Action_Recs[1294..1301], l.Action_Recs[1414..1421],
																			 l.Action_Recs[1534..1541], l.Action_Recs[1654..1661], l.Action_Recs[1774..1781], l.Action_Recs[1894..1901], l.Action_Recs[2014..2021], l.Action_Recs[2134..2141],
																			 l.Action_Recs[2254..2261], l.Action_Recs[2374..2381], l.Action_Recs[2494..2501], l.Action_Recs[2614..2621], l.Action_Recs[2734..2741], l.Action_Recs[2854..2861],
																			 l.Action_Recs[2974..2981], l.Action_Recs[3094..3101], l.Action_Recs[3214..3221], l.Action_Recs[3334..3341], l.Action_Recs[3454..3461], l.Action_Recs[3574..3581],
																			 l.Action_Recs[3694..3701], l.Action_Recs[3814..3821], l.Action_Recs[3934..3941], l.Action_Recs[4054..4061], l.Action_Recs[4174..4181], l.Action_Recs[4294..4301],
																			 l.Action_Recs[4414..4421], l.Action_Recs[4534..4541], l.Action_Recs[4654..4661], l.Action_Recs[4774..4781], l.Action_Recs[4894..4901], l.Action_Recs[5014..5021],
																			 l.Action_Recs[5134..5141], l.Action_Recs[5254..5261], l.Action_Recs[5374..5381], l.Action_Recs[5494..5501], l.Action_Recs[5614..5621], l.Action_Recs[5734..5741],
																			 l.Action_Recs[5854..5861], l.Action_Recs[5974..5981], l.Action_Recs[6094..6101], l.Action_Recs[6214..6221], l.Action_Recs[6334..6341], l.Action_Recs[6454..6461],
																			 l.Action_Recs[6574..6581], l.Action_Recs[6694..6701], l.Action_Recs[6814..6821], l.Action_Recs[6934..6941], l.Action_Recs[7054..7061], l.Action_Recs[7174..7181]);

		SELF.Action_CDL_Ind   := CHOOSE(C,l.Action_Recs[102..102], l.Action_Recs[222..222], l.Action_Recs[342..342], l.Action_Recs[462..462], l.Action_Recs[582..582], l.Action_Recs[702..702],
																			 l.Action_Recs[822..822], l.Action_Recs[942..942], l.Action_Recs[1062..1062], l.Action_Recs[1182..1182], l.Action_Recs[1302..1302], l.Action_Recs[1422..1422],
																			 l.Action_Recs[1542..1542], l.Action_Recs[1662..1662], l.Action_Recs[1782..1782], l.Action_Recs[1902..1902], l.Action_Recs[2022..2022], l.Action_Recs[2142..2142],
																			 l.Action_Recs[2262..2262], l.Action_Recs[2382..2382], l.Action_Recs[2502..2502], l.Action_Recs[2622..2622], l.Action_Recs[2742..2742], l.Action_Recs[2862..2862],
																			 l.Action_Recs[2982..2982], l.Action_Recs[3102..3102], l.Action_Recs[3222..3222], l.Action_Recs[3342..3342], l.Action_Recs[3462..3462], l.Action_Recs[3582..3582],
																			 l.Action_Recs[3702..3702], l.Action_Recs[3822..3822], l.Action_Recs[3942..3942], l.Action_Recs[4062..4062], l.Action_Recs[4182..4182], l.Action_Recs[4302..4302],
																			 l.Action_Recs[4422..4422], l.Action_Recs[4542..4542], l.Action_Recs[4662..4662], l.Action_Recs[4782..4782], l.Action_Recs[4902..4902], l.Action_Recs[5022..5022],
																			 l.Action_Recs[5142..5142], l.Action_Recs[5262..5262], l.Action_Recs[5382..5382], l.Action_Recs[5502..5502], l.Action_Recs[5622..5622], l.Action_Recs[5742..5742],
																			 l.Action_Recs[5862..5862], l.Action_Recs[5982..5982], l.Action_Recs[6102..6102], l.Action_Recs[6222..6222], l.Action_Recs[6342..6342], l.Action_Recs[6462..6462],
																			 l.Action_Recs[6582..6582], l.Action_Recs[6702..6702], l.Action_Recs[6822..6822], l.Action_Recs[6942..6942], l.Action_Recs[7062..7062], l.Action_Recs[7182..7182]);

		SELF.Action_WDraw_ID    := CHOOSE(C,l.Action_Recs[103..104], l.Action_Recs[223..224], l.Action_Recs[343..344], l.Action_Recs[463..464], l.Action_Recs[583..584], l.Action_Recs[703..704],
																			 l.Action_Recs[823..824], l.Action_Recs[943..944], l.Action_Recs[1063..1064], l.Action_Recs[1183..1184], l.Action_Recs[1303..1304], l.Action_Recs[1423..1424],
																			 l.Action_Recs[1543..1544], l.Action_Recs[1663..1664], l.Action_Recs[1783..1784], l.Action_Recs[1903..1904], l.Action_Recs[2023..2024], l.Action_Recs[2143..2144],
																			 l.Action_Recs[2263..2264], l.Action_Recs[2383..2384], l.Action_Recs[2503..2504], l.Action_Recs[2623..2624], l.Action_Recs[2743..2744], l.Action_Recs[2863..2864],
																			 l.Action_Recs[2983..2984], l.Action_Recs[3103..3104], l.Action_Recs[3223..3224], l.Action_Recs[3343..3344], l.Action_Recs[3463..3464], l.Action_Recs[3583..5384],
																			 l.Action_Recs[3703..3704], l.Action_Recs[3823..3824], l.Action_Recs[3943..3944], l.Action_Recs[4063..4064], l.Action_Recs[4183..4184], l.Action_Recs[4303..4304],
																			 l.Action_Recs[4423..4424], l.Action_Recs[4543..4544], l.Action_Recs[4663..4664], l.Action_Recs[4783..4784], l.Action_Recs[4903..4904], l.Action_Recs[5023..5024],
																			 l.Action_Recs[5143..5144], l.Action_Recs[5263..5264], l.Action_Recs[5383..5384], l.Action_Recs[5503..5504], l.Action_Recs[5623..5624], l.Action_Recs[5743..5744],
																			 l.Action_Recs[5863..5864], l.Action_Recs[5983..5984], l.Action_Recs[6103..6104], l.Action_Recs[6223..6224], l.Action_Recs[6343..6344], l.Action_Recs[6463..6464],
																			 l.Action_Recs[6583..6584], l.Action_Recs[6703..6704], l.Action_Recs[6823..6824], l.Action_Recs[6943..6944], l.Action_Recs[7063..7064], l.Action_Recs[7183..7184]);

		SELF.Action_WD_BAC_Lvl  := CHOOSE(C,l.Action_Recs[105..107], l.Action_Recs[225..227], l.Action_Recs[345..347], l.Action_Recs[465..467], l.Action_Recs[585..587], l.Action_Recs[705..707],
																			 l.Action_Recs[825..827], l.Action_Recs[945..947], l.Action_Recs[1065..1067], l.Action_Recs[1185..1187], l.Action_Recs[1305..1307], l.Action_Recs[1425..1427],
																			 l.Action_Recs[1545..1547], l.Action_Recs[1665..1667], l.Action_Recs[1785..1787], l.Action_Recs[1905..1907], l.Action_Recs[2025..2027], l.Action_Recs[2145..2147],
																			 l.Action_Recs[2265..2267], l.Action_Recs[2385..2387], l.Action_Recs[2505..2507], l.Action_Recs[2625..2627], l.Action_Recs[2745..2747], l.Action_Recs[2865..2867],
																			 l.Action_Recs[2985..2987], l.Action_Recs[3105..3107], l.Action_Recs[3225..3227], l.Action_Recs[3345..3347], l.Action_Recs[3465..3467], l.Action_Recs[3585..3587],
																			 l.Action_Recs[3705..3707], l.Action_Recs[3825..3827], l.Action_Recs[3945..3947], l.Action_Recs[4065..4067], l.Action_Recs[4185..4187], l.Action_Recs[4305..4307],
																			 l.Action_Recs[4425..4427], l.Action_Recs[4545..4547], l.Action_Recs[4665..4667], l.Action_Recs[4785..4787], l.Action_Recs[4905..4907], l.Action_Recs[5025..5027],
																			 l.Action_Recs[5145..5147], l.Action_Recs[5265..5267], l.Action_Recs[5385..5387], l.Action_Recs[5505..5507], l.Action_Recs[5625..5627], l.Action_Recs[5745..5747],
																			 l.Action_Recs[5865..5867], l.Action_Recs[5985..5987], l.Action_Recs[6105..6107], l.Action_Recs[6225..6227], l.Action_Recs[6345..6347], l.Action_Recs[6465..6467],
																			 l.Action_Recs[6585..6587], l.Action_Recs[6705..6707], l.Action_Recs[6825..6827], l.Action_Recs[6945..6947], l.Action_Recs[7065..7067], l.Action_Recs[7185..7187]);

		SELF.Action_Filler2   := CHOOSE(C,l.Action_Recs[108..120], l.Action_Recs[228..240], l.Action_Recs[348..360], l.Action_Recs[468..480], l.Action_Recs[588..600], l.Action_Recs[708..720],
																			l.Action_Recs[828..840], l.Action_Recs[948..960], l.Action_Recs[1068..1080], l.Action_Recs[1188..1200], l.Action_Recs[1308..1320], l.Action_Recs[1428..1440],
																			l.Action_Recs[1548..1560], l.Action_Recs[1668..1680], l.Action_Recs[1788..1800], l.Action_Recs[1908..1920], l.Action_Recs[2028..2040], l.Action_Recs[2148..2160],
																			l.Action_Recs[2268..2280], l.Action_Recs[2388..2400], l.Action_Recs[2508..2520], l.Action_Recs[2628..2640], l.Action_Recs[2748..2760], l.Action_Recs[2868..2880],
																			l.Action_Recs[2988..3000], l.Action_Recs[3108..3120], l.Action_Recs[3228..3240], l.Action_Recs[3348..3360], l.Action_Recs[3468..3480], l.Action_Recs[3588..3600],
																			l.Action_Recs[3708..3720], l.Action_Recs[3828..3840], l.Action_Recs[3948..3960], l.Action_Recs[4068..4080], l.Action_Recs[4188..4200], l.Action_Recs[4308..4320],
																			l.Action_Recs[4428..4440], l.Action_Recs[4548..4560], l.Action_Recs[4668..4680], l.Action_Recs[4788..4800], l.Action_Recs[4908..4920], l.Action_Recs[5028..5040],
																			l.Action_Recs[5148..5160], l.Action_Recs[5268..5280], l.Action_Recs[5388..5400], l.Action_Recs[5508..5520], l.Action_Recs[5628..5640], l.Action_Recs[5748..5760],
																			l.Action_Recs[5868..5880], l.Action_Recs[5988..6000], l.Action_Recs[6108..6120], l.Action_Recs[6228..6240], l.Action_Recs[6348..6360], l.Action_Recs[6468..6480],
																			l.Action_Recs[6588..6600], l.Action_Recs[6708..6720], l.Action_Recs[6828..6840], l.Action_Recs[6948..6960], l.Action_Recs[7068..7080], l.Action_Recs[7188..7200]);
	 END;
	 
	 accrecs := NORMALIZE(inrecs,
                        IF(LEFT.action_counts > 60,ERROR('THE NUMBER OF ACTION RECORDS ARE OVER THE EXPECTED LIMIT OF 60'),LEFT.action_counts),	 
                        transActions1(LEFT,COUNTER));
	 
	 Layouts_DL_MO_New_In.Layout_MO_Actions_Pdate transActions2(accrecs l) := TRANSFORM
		 SELF.process_date          := IF(_Validate.Date.fIsValid(processDate),processDate,'');
		 SELF.Unique_Key            := trimUpper(l.Unique_Key);
		 SELF.action_type           := trimUpper(l.action_type);
		 SELF.action_case_num       := trimUpper(l.action_case_num);
		 SELF.action_eff_date       := IF(_Validate.Date.fIsValid(l.action_eff_date),l.action_eff_date,'');
		 SELF.action_reinst_date    := IF(_Validate.Date.fIsValid(l.action_reinst_date),l.action_reinst_date,'');
		 SELF.action_status_code    := trimUpper(l.action_status_code);
		 SELF.action_status_date    := IF(_Validate.Date.fIsValid(l.action_status_date) AND
	                                    _Validate.Date.fIsValid(l.action_status_date,_Validate.Date.Rules.DateInPast),l.action_status_date,'');
		 SELF.action_state_offense  := trimUpper(l.action_state_offense);
		 SELF.action_offense_date   := IF(_Validate.Date.fIsValid(l.action_offense_date) AND
	                                    _Validate.Date.fIsValid(l.action_offense_date,_Validate.Date.Rules.DateInPast),l.action_offense_date,'');
		 SELF.action_tkt_num        := trimUpper(l.action_tkt_num);
		 SELF.action_haz_mat_ind    := trimUpper(l.action_haz_mat_ind); 
		 SELF.action_state          := trimUpper(l.action_state); 
		 SELF.action_oos_eval_date  := IF(_Validate.Date.fIsValid(l.action_eff_date) AND
	                                    _Validate.Date.fIsValid(l.action_eff_date,_Validate.Date.Rules.DateInPast),l.action_eff_date,'');
		 SELF.action_acd_code       := trimUpper(l.action_acd_code);  
		 SELF.action_wdraw_code     := IF((INTEGER)stringlib.stringfilter(l.action_wdraw_code,'0123456789')<>0,stringlib.stringfilter(l.action_wdraw_code,'0123456789'),'');
		 SELF.action_wdraw_basis    := IF((INTEGER)stringlib.stringfilter(l.action_wdraw_basis,'0123456789')<>0,stringlib.stringfilter(l.action_wdraw_basis,'0123456789'),'');
		 SELF.action_process_code   := IF((INTEGER)stringlib.stringfilter(l.action_process_code,'0123456789')<>0,stringlib.stringfilter(l.action_process_code,'0123456789'),'');
		 SELF.action_extent_code    := IF((INTEGER)stringlib.stringfilter(l.action_extent_code,'0123456789')<>0,stringlib.stringfilter(l.action_extent_code,'0123456789'),'');
		 SELF.action_wd_ref_num     := trimUpper(l.action_wd_ref_num);
		 SELF.action_cdl_ind        := trimUpper(l.action_cdl_ind);
		 SELF.action_wdraw_id       := trimUpper(l.action_wdraw_id);
		 SELF.action_wd_bac_lvl     := IF((INTEGER)stringlib.stringfilter(l.action_wd_bac_lvl,'0123456789')<>0,stringlib.stringfilter(l.action_wd_bac_lvl,'0123456789'),'');
		 SELF := L;
	 END;
	 
	 MO_DL_Action_Recs := PROJECT(accrecs,transActions2(LEFT));
	 
	 //********* Accidents Records *****************************************************************************
	 Layouts_DL_MO_New_In.Layout_MO_Accidents transAcci1(inrecs l, UNSIGNED4 C) := TRANSFORM,SKIP(l.Accident_Recs = '')
		 SELF.Unique_Key         := l.Unique_Key;
		 SELF.acci_state         := CHOOSE(C,l.Accident_Recs[1..2], l.Accident_Recs[51..52], l.Accident_Recs[101..102], l.Accident_Recs[151..152], l.Accident_Recs[201..202], 
																				 l.Accident_Recs[251..252], l.Accident_Recs[301..302], l.Accident_Recs[351..352], l.Accident_Recs[401..402], l.Accident_Recs[451..452],
																				 l.Accident_Recs[501..502], l.Accident_Recs[551..552], l.Accident_Recs[601..602], l.Accident_Recs[651..652], l.Accident_Recs[701..702],
																				 l.Accident_Recs[751..752], l.Accident_Recs[801..802], l.Accident_Recs[851..852], l.Accident_Recs[901..902], l.Accident_Recs[951..952],
																				 l.Accident_Recs[1001..1002], l.Accident_Recs[1051..1052], l.Accident_Recs[1101..1102], l.Accident_Recs[1151..1152], l.Accident_Recs[1201..1202],
																				 l.Accident_Recs[1251..1252], l.Accident_Recs[1301..1302], l.Accident_Recs[1351..1352], l.Accident_Recs[1401..1402], l.Accident_Recs[1451..1452],
																				 l.Accident_Recs[1501..1502], l.Accident_Recs[1551..1552], l.Accident_Recs[1601..1602], l.Accident_Recs[1651..1652], l.Accident_Recs[1701..1702],
																				 l.Accident_Recs[1751..1752], l.Accident_Recs[1801..1802], l.Accident_Recs[1851..1852], l.Accident_Recs[1901..1902], l.Accident_Recs[1951..1952],
																				 l.Accident_Recs[2001..2002], l.Accident_Recs[2051..2052], l.Accident_Recs[2101..2102], l.Accident_Recs[2151..2152], l.Accident_Recs[2201..2202],
																				 l.Accident_Recs[2251..2252], l.Accident_Recs[2301..2302], l.Accident_Recs[2351..2352], l.Accident_Recs[2401..2402], l.Accident_Recs[2451..2452]);
																				 
		 SELF.acci_date          := CHOOSE(C,l.Accident_Recs[3..10], l.Accident_Recs[53..60], l.Accident_Recs[103..110], l.Accident_Recs[153..160], l.Accident_Recs[203..210],
																				 l.Accident_Recs[253..260], l.Accident_Recs[303..310], l.Accident_Recs[353..360], l.Accident_Recs[403..410], l.Accident_Recs[453..460],
																				 l.Accident_Recs[503..510], l.Accident_Recs[553..560], l.Accident_Recs[603..610], l.Accident_Recs[653..660], l.Accident_Recs[703..710],
																				 l.Accident_Recs[753..760], l.Accident_Recs[803..810], l.Accident_Recs[853..860], l.Accident_Recs[903..910], l.Accident_Recs[953..960],
																				 l.Accident_Recs[1003..1010], l.Accident_Recs[1053..1060], l.Accident_Recs[1103..1110], l.Accident_Recs[1153..1160], l.Accident_Recs[1203..1210],
																				 l.Accident_Recs[1253..1260], l.Accident_Recs[1303..1310], l.Accident_Recs[1353..1360], l.Accident_Recs[1403..1410], l.Accident_Recs[1453..1460],
																				 l.Accident_Recs[1503..1510], l.Accident_Recs[1553..1560], l.Accident_Recs[1603..1610], l.Accident_Recs[1653..1660], l.Accident_Recs[1703..1710],
																				 l.Accident_Recs[1753..1760], l.Accident_Recs[1803..1810], l.Accident_Recs[1853..1860], l.Accident_Recs[1903..1910], l.Accident_Recs[1953..1960],
																				 l.Accident_Recs[2003..2010], l.Accident_Recs[2053..2060], l.Accident_Recs[2103..2110], l.Accident_Recs[2153..2160], l.Accident_Recs[2203..2210],
																				 l.Accident_Recs[2253..2260], l.Accident_Recs[2303..2310], l.Accident_Recs[2353..2360], l.Accident_Recs[2403..2410], l.Accident_Recs[2453..2460]);
																				 
		 SELF.acci_sev_code      := CHOOSE(C,l.Accident_Recs[11..11], l.Accident_Recs[61..61], l.Accident_Recs[111..111], l.Accident_Recs[161..161], l.Accident_Recs[211..211],
																				 l.Accident_Recs[261..261], l.Accident_Recs[311..311], l.Accident_Recs[361..361], l.Accident_Recs[411..411], l.Accident_Recs[461..461],
																				 l.Accident_Recs[511..511], l.Accident_Recs[561..561], l.Accident_Recs[611..611], l.Accident_Recs[661..661], l.Accident_Recs[711..711],
																				 l.Accident_Recs[761..761], l.Accident_Recs[811..811], l.Accident_Recs[861..861], l.Accident_Recs[911..911], l.Accident_Recs[961..961],
																				 l.Accident_Recs[1011..1011], l.Accident_Recs[1061..1061], l.Accident_Recs[1111..1111], l.Accident_Recs[1161..1161],l.Accident_Recs[1211..1211],
																				 l.Accident_Recs[1261..1261], l.Accident_Recs[1311..1311], l.Accident_Recs[1361..1361], l.Accident_Recs[1411..1411], l.Accident_Recs[1461..1461],
																				 l.Accident_Recs[1511..1511], l.Accident_Recs[1561..1561], l.Accident_Recs[1611..1611], l.Accident_Recs[1661..1661], l.Accident_Recs[1711..1711],
																				 l.Accident_Recs[1761..1761], l.Accident_Recs[1811..1811], l.Accident_Recs[1861..1861], l.Accident_Recs[1911..1911], l.Accident_Recs[1961..1961],
																				 l.Accident_Recs[2011..2011], l.Accident_Recs[2061..2061], l.Accident_Recs[2111..2111], l.Accident_Recs[2161..2161], l.Accident_Recs[2211..2211],
																				 l.Accident_Recs[2261..2261], l.Accident_Recs[2311..2311], l.Accident_Recs[2361..2361], l.Accident_Recs[2411..2411], l.Accident_Recs[2461..2461]);
																				 
		 SELF.acci_cmv_ind       := CHOOSE(C,l.Accident_Recs[12..12], l.Accident_Recs[62..62], l.Accident_Recs[112..112], l.Accident_Recs[162..162], l.Accident_Recs[212..212],
																				 l.Accident_Recs[262..262], l.Accident_Recs[312..312], l.Accident_Recs[362..362], l.Accident_Recs[412..412], l.Accident_Recs[462..462],
																				 l.Accident_Recs[512..512], l.Accident_Recs[562..562], l.Accident_Recs[612..612], l.Accident_Recs[662..662], l.Accident_Recs[712..712],
																				 l.Accident_Recs[762..762], l.Accident_Recs[812..812], l.Accident_Recs[862..862], l.Accident_Recs[912..912], l.Accident_Recs[962..962],
																				 l.Accident_Recs[1012..1012], l.Accident_Recs[1062..1062], l.Accident_Recs[1112..1112], l.Accident_Recs[1162..1162], l.Accident_Recs[1212..1212],
																				 l.Accident_Recs[1262..1262], l.Accident_Recs[1312..1312], l.Accident_Recs[1362..1362], l.Accident_Recs[1412..1412], l.Accident_Recs[1462..1462],
																				 l.Accident_Recs[1512..1512], l.Accident_Recs[1562..1562], l.Accident_Recs[1612..1612], l.Accident_Recs[1662..1662], l.Accident_Recs[1712..1712],
																				 l.Accident_Recs[1762..1762], l.Accident_Recs[1812..1812], l.Accident_Recs[1862..1862], l.Accident_Recs[1912..1912], l.Accident_Recs[1962..1962],
																				 l.Accident_Recs[2012..2012], l.Accident_Recs[2062..2062], l.Accident_Recs[2112..2112], l.Accident_Recs[2162..2162], l.Accident_Recs[2212..2212],
																				 l.Accident_Recs[2262..2262], l.Accident_Recs[2312..2312], l.Accident_Recs[2362..2362], l.Accident_Recs[2412..2412], l.Accident_Recs[2462..2462]);
																				 
		 SELF.acci_haz_mat_ind   := CHOOSE(C,l.Accident_Recs[13..13], l.Accident_Recs[63..63], l.Accident_Recs[113..113], l.Accident_Recs[163..163], l.Accident_Recs[213..213],
																				 l.Accident_Recs[263..263], l.Accident_Recs[313..313], l.Accident_Recs[363..363], l.Accident_Recs[413..413], l.Accident_Recs[463..463],
																				 l.Accident_Recs[513..513], l.Accident_Recs[563..563], l.Accident_Recs[613..613], l.Accident_Recs[663..663], l.Accident_Recs[713..713],
																				 l.Accident_Recs[763..763], l.Accident_Recs[813..813], l.Accident_Recs[863..863], l.Accident_Recs[913..913], l.Accident_Recs[963..963],
																				 l.Accident_Recs[1013..1013], l.Accident_Recs[1063..1063], l.Accident_Recs[1113..1113], l.Accident_Recs[1163..1163], l.Accident_Recs[1213..1213],
																				 l.Accident_Recs[1263..1263], l.Accident_Recs[1313..1313], l.Accident_Recs[1363..1363], l.Accident_Recs[1413..1413], l.Accident_Recs[1463..1463],
																				 l.Accident_Recs[1513..1513], l.Accident_Recs[1563..1563], l.Accident_Recs[1613..1613], l.Accident_Recs[1663..1663], l.Accident_Recs[1713..1713],
																				 l.Accident_Recs[1763..1763], l.Accident_Recs[1813..1813], l.Accident_Recs[1863..1863], l.Accident_Recs[1913..1913], l.Accident_Recs[1963..1963],
																				 l.Accident_Recs[2013..2013], l.Accident_Recs[2063..2063], l.Accident_Recs[2113..2113], l.Accident_Recs[2163..2163], l.Accident_Recs[2213..2213],
																				 l.Accident_Recs[2263..2263], l.Accident_Recs[2313..2313], l.Accident_Recs[2363..2363], l.Accident_Recs[2413..2413], l.Accident_Recs[2463..2463]);
																				 
		 SELF.acci_loc_num       := CHOOSE(C,l.Accident_Recs[14..31], l.Accident_Recs[64..81], l.Accident_Recs[114..131], l.Accident_Recs[164..181], l.Accident_Recs[214..231],
																				 l.Accident_Recs[264..281], l.Accident_Recs[314..331], l.Accident_Recs[364..381], l.Accident_Recs[414..431], l.Accident_Recs[464..481],
																				 l.Accident_Recs[514..531], l.Accident_Recs[564..581], l.Accident_Recs[614..631], l.Accident_Recs[664..681], l.Accident_Recs[714..731],
																				 l.Accident_Recs[764..781], l.Accident_Recs[814..831], l.Accident_Recs[864..881], l.Accident_Recs[914..931], l.Accident_Recs[964..981],
																				 l.Accident_Recs[1014..1031], l.Accident_Recs[1064..1081], l.Accident_Recs[1114..1131], l.Accident_Recs[1164..1181], l.Accident_Recs[1214..1231],
																				 l.Accident_Recs[1264..1281], l.Accident_Recs[1314..1331], l.Accident_Recs[1364..1381], l.Accident_Recs[1414..1431], l.Accident_Recs[1464..1481],
																				 l.Accident_Recs[1514..1531], l.Accident_Recs[1564..1581], l.Accident_Recs[1614..1631], l.Accident_Recs[1664..1681], l.Accident_Recs[1714..1731],
																				 l.Accident_Recs[1764..1781], l.Accident_Recs[1814..1831], l.Accident_Recs[1864..1881], l.Accident_Recs[1914..1931], l.Accident_Recs[1964..1981],
																				 l.Accident_Recs[2014..2031], l.Accident_Recs[2064..2081], l.Accident_Recs[2114..2131], l.Accident_Recs[2164..2181], l.Accident_Recs[2214..2231],
																				 l.Accident_Recs[2264..2281], l.Accident_Recs[2314..2331], l.Accident_Recs[2364..2381], l.Accident_Recs[2414..2431], l.Accident_Recs[2464..2481]);
																				 
		 SELF.acci_filler2       := CHOOSE(C,l.Accident_Recs[32..50], l.Accident_Recs[82..100], l.Accident_Recs[132..150], l.Accident_Recs[182..200], l.Accident_Recs[232..250],
																				 l.Accident_Recs[282..300], l.Accident_Recs[332..350], l.Accident_Recs[382..400], l.Accident_Recs[432..450], l.Accident_Recs[482..500],
																				 l.Accident_Recs[532..550], l.Accident_Recs[582..600], l.Accident_Recs[632..650], l.Accident_Recs[682..700], l.Accident_Recs[732..750],
																				 l.Accident_Recs[782..800], l.Accident_Recs[832..850], l.Accident_Recs[882..900], l.Accident_Recs[932..950], l.Accident_Recs[982..1000],
																				 l.Accident_Recs[1032..1050], l.Accident_Recs[1082..1100], l.Accident_Recs[1132..1150], l.Accident_Recs[1182..1200], l.Accident_Recs[1232..1250],
																				 l.Accident_Recs[1282..1300], l.Accident_Recs[1332..1350], l.Accident_Recs[1382..1400], l.Accident_Recs[1432..1450], l.Accident_Recs[1482..1500],
																				 l.Accident_Recs[1532..1550], l.Accident_Recs[1582..1600], l.Accident_Recs[1632..1650], l.Accident_Recs[1682..1700], l.Accident_Recs[1732..1750],
																				 l.Accident_Recs[1782..1800], l.Accident_Recs[1832..1850], l.Accident_Recs[1882..1900], l.Accident_Recs[1932..1950], l.Accident_Recs[1982..2000],
																				 l.Accident_Recs[2032..2050], l.Accident_Recs[2082..2100], l.Accident_Recs[2132..2150], l.Accident_Recs[2182..2200], l.Accident_Recs[2232..2250],
																				 l.Accident_Recs[2282..2300], l.Accident_Recs[2332..2350], l.Accident_Recs[2382..2400], l.Accident_Recs[2432..2450], l.Accident_Recs[2482..2500]);
	 END;
		
	 accirecs := NORMALIZE(inrecs,
                         IF(LEFT.Accidents_Counts > 50,ERROR('THE NUMBER OF ACCIDENT RECORDS ARE OVER THE EXPECTED LIMIT OF 50'),LEFT.Accidents_Counts),	 
                         transAcci1(LEFT,COUNTER));
	 
	 Layouts_DL_MO_New_In.Layout_MO_Accidents_Pdate transAcci2(accirecs l) := TRANSFORM
		 SELF.process_date     := IF(_Validate.Date.fIsValid(processDate),processDate,'');
		 SELF.Unique_Key       := trimUpper(l.Unique_Key);
		 SELF.acci_state       := trimUpper(l.acci_state);
		 SELF.acci_date        := IF(_Validate.Date.fIsValid(l.acci_date) AND
	                               _Validate.Date.fIsValid(l.acci_date,_Validate.Date.Rules.DateInPast),l.acci_date,'');
		 SELF.acci_sev_code    := trimUpper(l.acci_sev_code);
		 SELF.acci_cmv_ind     := trimUpper(l.acci_cmv_ind);
		 SELF.acci_haz_mat_ind := trimUpper(l.acci_haz_mat_ind);
		 SELF.acci_loc_num     := trimUpper(l.acci_loc_num);
		 SELF                  := L;
	 END;
	 
	 MO_DL_Accident_Recs := PROJECT(accirecs,transAcci2(LEFT)); 

	 //********* AKA Records *****************************************************************************
	 Layouts_DL_MO_New_In.Layout_MO_AKA_MedCert transAKA1(inrecs l, UNSIGNED4 C) := TRANSFORM,SKIP(l.AKA_Recs = '')
		 SELF.Unique_Key      := l.Unique_Key;
	   SELF.AKA_Lic_State   := trimUpper(CHOOSE(C,l.AKA_Recs[1..2], l.AKA_Recs[172..173],l.AKA_Recs[343..344]));
	   SELF.AKA_Lic_Num     := trimUpper(CHOOSE(C,l.AKA_Recs[3..27],l.AKA_Recs[174..198],l.AKA_Recs[345..369]));
		 SELF.AKA_LName       := trimUpper(CHOOSE(C,l.AKA_Recs[28..67],l.AKA_Recs[199..238],l.AKA_Recs[370..409]));
	   SELF.AKA_FName       := trimUpper(CHOOSE(C,l.AKA_Recs[68..107],l.AKA_Recs[239..278],l.AKA_Recs[410..449]));
	   SELF.AKA_MName       := trimUpper(CHOOSE(C,l.AKA_Recs[108..142],l.AKA_Recs[279..313],l.AKA_Recs[450..484]));  
	   SELF.AKA_Suffix      := trimUpper(CHOOSE(C,l.AKA_Recs[143..147],l.AKA_Recs[314..318],l.AKA_Recs[485..489]));
	   SELF.AKA_DOB         := lib_stringlib.stringlib.stringfilter(CHOOSE(C,l.AKA_Recs[148..155],l.AKA_Recs[319..326],l.AKA_Recs[490..497]),'0123456789');
   END;
	 
	 akarecs := NORMALIZE(inrecs, 
                        IF(LEFT.AKA_Counts > 3,ERROR('THE NUMBER OF AKA RECORDS ARE OVER THE EXPECTED LIMIT OF 3'),LEFT.AKA_Counts),	 
                        transAKA1(LEFT,COUNTER));
	 
	 Layouts_DL_MO_New_In.Layout_MO_AKA_Pdate_MedCert transAKA2(akarecs l) := TRANSFORM
		 SELF.process_date     := IF(_Validate.Date.fIsValid(processDate),processDate,'');
		 SELF.Unique_Key       := trimUpper(l.Unique_Key);   
		 SELF.AKA_Lic_State    := trimUpper(l.AKA_Lic_State);
		 SELF.AKA_Lic_Num      := trimUpper(l.AKA_Lic_Num);
		 SELF.AKA_LName        := trimUpper(l.AKA_LName);
		 SELF.AKA_FName        := trimUpper(l.AKA_FName);
		 SELF.AKA_MName        := trimUpper(l.AKA_MName);
		 SELF.AKA_Suffix       := trimUpper(l.AKA_Suffix);
		 SELF.AKA_DOB          := IF(_Validate.Date.fIsValid(l.AKA_DOB) AND
	                               _Validate.Date.fIsValid(l.AKA_DOB,_Validate.Date.Rules.DateInPast),l.AKA_DOB,'');
	 END;
	 
	 MO_DL_AKA_Recs := PROJECT(akarecs,transAKA2(LEFT)); 
	 
	 //********* Conviction Records *****************************************************************************
	 Layouts_DL_MO_New_In.Layout_MO_Points transConv1(inrecs l, UNSIGNED4 C) := TRANSFORM,SKIP(l.Convict_Recs = '')
		 SELF.Unique_Key         := l.Unique_Key;
		 SELF.conv_viol_code     := CHOOSE(C,l.Convict_Recs[1..4], l.Convict_Recs[111..114], l.Convict_Recs[221..224], l.Convict_Recs[331..334], l.Convict_Recs[441..444], l.Convict_Recs[551..554], 
																				 l.Convict_Recs[661..664], l.Convict_Recs[771..774], l.Convict_Recs[881..884], l.Convict_Recs[991..994], l.Convict_Recs[1101..1104], l.Convict_Recs[1211..1214],
																				 l.Convict_Recs[1321..1324], l.Convict_Recs[1431..1434], l.Convict_Recs[1541..1544], l.Convict_Recs[1651..1654], l.Convict_Recs[1761..1764], l.Convict_Recs[1871..1874],
																				 l.Convict_Recs[1981..1984], l.Convict_Recs[2091..2094], l.Convict_Recs[2201..2204], l.Convict_Recs[2311..2314], l.Convict_Recs[2421..2424], l.Convict_Recs[2531..2534],
																				 l.Convict_Recs[2641..2644], l.Convict_Recs[2751..2754], l.Convict_Recs[2861..2864], l.Convict_Recs[2971..2974], l.Convict_Recs[3081..3084], l.Convict_Recs[3191..3194],
																				 l.Convict_Recs[3301..3304], l.Convict_Recs[3411..3414], l.Convict_Recs[3521..3524], l.Convict_Recs[3631..3634], l.Convict_Recs[3741..3744], l.Convict_Recs[3851..3854],
																				 l.Convict_Recs[3961..3964], l.Convict_Recs[4071..4074], l.Convict_Recs[4181..4184], l.Convict_Recs[4291..4294], l.Convict_Recs[4401..4404], l.Convict_Recs[4511..4514],
																				 l.Convict_Recs[4621..4624], l.Convict_Recs[4731..4734], l.Convict_Recs[4841..4844], l.Convict_Recs[4951..4954], l.Convict_Recs[5061..5064], l.Convict_Recs[5171..5174],
																				 l.Convict_Recs[5281..5284], l.Convict_Recs[5391..5394], l.Convict_Recs[5501..5504], l.Convict_Recs[5611..5614], l.Convict_Recs[5721..5724], l.Convict_Recs[5831..5834],
																				 l.Convict_Recs[5941..5944], l.Convict_Recs[6051..6054], l.Convict_Recs[6161..6164], l.Convict_Recs[6271..6274], l.Convict_Recs[6381..6384], l.Convict_Recs[6491..6494],
																				 l.Convict_Recs[6601..6604], l.Convict_Recs[6711..6714], l.Convict_Recs[6821..6824], l.Convict_Recs[6931..6934], l.Convict_Recs[7041..7044], l.Convict_Recs[7151..7154],
																				 l.Convict_Recs[7261..7264], l.Convict_Recs[7371..7374], l.Convict_Recs[7481..7484], l.Convict_Recs[7591..7594], l.Convict_Recs[7701..7704], l.Convict_Recs[7811..7814],
																				 l.Convict_Recs[7921..7924], l.Convict_Recs[8031..8034], l.Convict_Recs[8141..8144]);
																				 
		 SELF.conv_pts_date      := CHOOSE(C,l.Convict_Recs[5..12], l.Convict_Recs[115..122], l.Convict_Recs[225..232], l.Convict_Recs[335..342], l.Convict_Recs[445..452], l.Convict_Recs[555..562],
																				 l.Convict_Recs[665..672], l.Convict_Recs[775..782], l.Convict_Recs[885..892], l.Convict_Recs[995..1002], l.Convict_Recs[1105..1112], l.Convict_Recs[1215..1222], 
																				 l.Convict_Recs[1325..1332], l.Convict_Recs[1435..1442], l.Convict_Recs[1545..1552], l.Convict_Recs[1655..1662], l.Convict_Recs[1765..1772], l.Convict_Recs[1875..1882],
																				 l.Convict_Recs[1985..1992], l.Convict_Recs[2095..2102], l.Convict_Recs[2205..2212], l.Convict_Recs[2315..2322], l.Convict_Recs[2425..2432], l.Convict_Recs[2535..2542],
																				 l.Convict_Recs[2645..2652], l.Convict_Recs[2755..2762], l.Convict_Recs[2865..2872], l.Convict_Recs[2975..2982], l.Convict_Recs[3085..3092], l.Convict_Recs[3195..3202],
																				 l.Convict_Recs[3305..3312], l.Convict_Recs[3415..3422], l.Convict_Recs[3525..3532], l.Convict_Recs[3635..3642], l.Convict_Recs[3745..3752], l.Convict_Recs[3855..3862],
																				 l.Convict_Recs[3965..3972], l.Convict_Recs[4075..4082], l.Convict_Recs[4185..4192], l.Convict_Recs[4295..4302], l.Convict_Recs[4405..4412], l.Convict_Recs[4515..4522],
																				 l.Convict_Recs[4625..4632], l.Convict_Recs[4735..4742], l.Convict_Recs[4845..4852], l.Convict_Recs[4955..4962], l.Convict_Recs[5065..5072], l.Convict_Recs[5175..5182],
																				 l.Convict_Recs[5285..5292], l.Convict_Recs[5395..5402], l.Convict_Recs[5505..5512], l.Convict_Recs[5615..5622], l.Convict_Recs[5725..5732], l.Convict_Recs[5835..5842],
																				 l.Convict_Recs[5945..5952], l.Convict_Recs[6055..6062], l.Convict_Recs[6165..6172], l.Convict_Recs[6275..6282], l.Convict_Recs[6385..6392], l.Convict_Recs[6495..6502],
																				 l.Convict_Recs[6605..6612], l.Convict_Recs[6715..6722], l.Convict_Recs[6825..6832], l.Convict_Recs[6935..6942], l.Convict_Recs[7045..7052], l.Convict_Recs[7155..7162],
																				 l.Convict_Recs[7265..7272], l.Convict_Recs[7375..7382], l.Convict_Recs[7485..7492], l.Convict_Recs[7595..7602], l.Convict_Recs[7705..7712], l.Convict_Recs[7815..7822],
																				 l.Convict_Recs[7925..7932], l.Convict_Recs[8035..8042], l.Convict_Recs[8145..8152]);
																				 
		 SELF.conv_date          := CHOOSE(C,l.Convict_Recs[13..20], l.Convict_Recs[123..130], l.Convict_Recs[233..240], l.Convict_Recs[343..350], l.Convict_Recs[453..460], l.Convict_Recs[563..570],
																				 l.Convict_Recs[673..680], l.Convict_Recs[783..790], l.Convict_Recs[893..900], l.Convict_Recs[1003..1010], l.Convict_Recs[1113..1120], l.Convict_Recs[1223..1230], 
																				 l.Convict_Recs[1333..1340], l.Convict_Recs[1443..1450], l.Convict_Recs[1553..1560], l.Convict_Recs[1663..1670], l.Convict_Recs[1773..1780], l.Convict_Recs[1883..1890],
																				 l.Convict_Recs[1993..2000], l.Convict_Recs[2103..2110], l.Convict_Recs[2213..2220], l.Convict_Recs[2323..2330], l.Convict_Recs[2433..2440], l.Convict_Recs[2543..2550],
																				 l.Convict_Recs[2653..2660], l.Convict_Recs[2763..2770], l.Convict_Recs[2873..2880], l.Convict_Recs[2983..2990], l.Convict_Recs[3093..3100], l.Convict_Recs[3203..3210],
																				 l.Convict_Recs[3313..3320], l.Convict_Recs[3423..3430], l.Convict_Recs[3533..3540], l.Convict_Recs[3643..3650], l.Convict_Recs[3753..3760], l.Convict_Recs[3863..3870],
																				 l.Convict_Recs[3973..3980], l.Convict_Recs[4083..4090], l.Convict_Recs[4193..4200], l.Convict_Recs[4303..4310], l.Convict_Recs[4413..4420], l.Convict_Recs[4523..4530],
																				 l.Convict_Recs[4633..4640], l.Convict_Recs[4743..4750], l.Convict_Recs[4853..4860], l.Convict_Recs[4963..4970], l.Convict_Recs[5073..5080], l.Convict_Recs[5183..5190],
																				 l.Convict_Recs[5293..5300], l.Convict_Recs[5403..5410], l.Convict_Recs[5513..5520], l.Convict_Recs[5623..5630], l.Convict_Recs[5733..5740], l.Convict_Recs[5843..5850],
																				 l.Convict_Recs[5953..5960], l.Convict_Recs[6063..6070], l.Convict_Recs[6173..6180], l.Convict_Recs[6283..6290], l.Convict_Recs[6393..6400], l.Convict_Recs[6503..6510],
																				 l.Convict_Recs[6613..6620], l.Convict_Recs[6723..6730], l.Convict_Recs[6833..6840], l.Convict_Recs[6943..6950], l.Convict_Recs[7053..7060], l.Convict_Recs[7163..7170],
																				 l.Convict_Recs[7273..7280], l.Convict_Recs[7383..7390], l.Convict_Recs[7493..7500], l.Convict_Recs[7603..7610], l.Convict_Recs[7713..7720], l.Convict_Recs[7823..7830],
																				 l.Convict_Recs[7933..7940], l.Convict_Recs[8043..8050], l.Convict_Recs[8153..8160]);
																				 
		 SELF.conv_crt_loc       := CHOOSE(C,l.Convict_Recs[21..29], l.Convict_Recs[131..139], l.Convict_Recs[241..249], l.Convict_Recs[351..359], l.Convict_Recs[461..469], l.Convict_Recs[571..579],
																				 l.Convict_Recs[681..689], l.Convict_Recs[791..799], l.Convict_Recs[901..909], l.Convict_Recs[1011..1019], l.Convict_Recs[1121..1129], l.Convict_Recs[1231..1239], 
																				 l.Convict_Recs[1341..1349], l.Convict_Recs[1451..1459], l.Convict_Recs[1561..1569], l.Convict_Recs[1671..1679], l.Convict_Recs[1781..1789], l.Convict_Recs[1891..1899],
																				 l.Convict_Recs[2001..2009], l.Convict_Recs[2111..2119], l.Convict_Recs[2221..2229], l.Convict_Recs[2331..2339], l.Convict_Recs[2441..2449], l.Convict_Recs[2551..2559],
																				 l.Convict_Recs[2661..2669], l.Convict_Recs[2771..2779], l.Convict_Recs[2881..2889], l.Convict_Recs[2991..2999], l.Convict_Recs[3101..3109], l.Convict_Recs[3211..3219],
																				 l.Convict_Recs[3321..3329], l.Convict_Recs[3431..3439], l.Convict_Recs[3541..3549], l.Convict_Recs[3651..3659], l.Convict_Recs[3761..3769], l.Convict_Recs[3871..3879],
																				 l.Convict_Recs[3981..3989], l.Convict_Recs[4091..4099], l.Convict_Recs[4201..4209], l.Convict_Recs[4311..4319], l.Convict_Recs[4421..4429], l.Convict_Recs[4531..4539],
																				 l.Convict_Recs[4641..4649], l.Convict_Recs[4751..4759], l.Convict_Recs[4861..4869], l.Convict_Recs[4971..4979], l.Convict_Recs[5081..5089], l.Convict_Recs[5191..5199],
																				 l.Convict_Recs[5301..5309], l.Convict_Recs[5411..5419], l.Convict_Recs[5521..5529], l.Convict_Recs[5631..5639], l.Convict_Recs[5741..5749], l.Convict_Recs[5851..5859],
																				 l.Convict_Recs[5961..5969], l.Convict_Recs[6071..6079], l.Convict_Recs[6181..6189], l.Convict_Recs[6291..6299], l.Convict_Recs[6401..6409], l.Convict_Recs[6511..6519],
																				 l.Convict_Recs[6621..6629], l.Convict_Recs[6731..6739], l.Convict_Recs[6841..6849], l.Convict_Recs[6951..6959], l.Convict_Recs[7061..7069], l.Convict_Recs[7171..7179],
																				 l.Convict_Recs[7281..7289], l.Convict_Recs[7391..7399], l.Convict_Recs[7501..7509], l.Convict_Recs[7611..7619], l.Convict_Recs[7721..7729], l.Convict_Recs[7831..7839],
																				 l.Convict_Recs[7941..7949], l.Convict_Recs[8051..8059], l.Convict_Recs[8161..8169]);
																				 
		 SELF.conv_crt_type      := CHOOSE(C,l.Convict_Recs[30..32], l.Convict_Recs[140..142], l.Convict_Recs[250..252], l.Convict_Recs[360..362], l.Convict_Recs[470..472], l.Convict_Recs[580..582],
																				 l.Convict_Recs[690..692], l.Convict_Recs[800..802], l.Convict_Recs[910..912], l.Convict_Recs[1020..1022], l.Convict_Recs[1130..1132], l.Convict_Recs[1240..1242], 
																				 l.Convict_Recs[1350..1352], l.Convict_Recs[1460..1462], l.Convict_Recs[1570..1572], l.Convict_Recs[1680..1682], l.Convict_Recs[1790..1792], l.Convict_Recs[1900..1902],
																				 l.Convict_Recs[2010..2012], l.Convict_Recs[2120..2122], l.Convict_Recs[2230..2232], l.Convict_Recs[2340..2342], l.Convict_Recs[2450..2452], l.Convict_Recs[2560..2562],
																				 l.Convict_Recs[2670..2672], l.Convict_Recs[2780..2782], l.Convict_Recs[2890..2892], l.Convict_Recs[3000..3002], l.Convict_Recs[3110..3112], l.Convict_Recs[3220..3222],
																				 l.Convict_Recs[3330..3332], l.Convict_Recs[3440..3442], l.Convict_Recs[3550..3552], l.Convict_Recs[3660..3662], l.Convict_Recs[3770..3772], l.Convict_Recs[3880..3882],
																				 l.Convict_Recs[3990..3992], l.Convict_Recs[4100..4102], l.Convict_Recs[4210..4212], l.Convict_Recs[4320..4322], l.Convict_Recs[4430..4432], l.Convict_Recs[4540..4542],
																				 l.Convict_Recs[4650..4652], l.Convict_Recs[4760..4762], l.Convict_Recs[4870..4872], l.Convict_Recs[4980..4982], l.Convict_Recs[5090..5092], l.Convict_Recs[5200..5202],
																				 l.Convict_Recs[5310..5312], l.Convict_Recs[5420..5422], l.Convict_Recs[5530..5532], l.Convict_Recs[5640..5642], l.Convict_Recs[5750..5752], l.Convict_Recs[5860..5862],
																				 l.Convict_Recs[5970..5972], l.Convict_Recs[6080..6082], l.Convict_Recs[6190..6192], l.Convict_Recs[6300..6302], l.Convict_Recs[6410..6412], l.Convict_Recs[6520..6522],
																				 l.Convict_Recs[6630..6632], l.Convict_Recs[6740..6742], l.Convict_Recs[6850..6852], l.Convict_Recs[6960..6962], l.Convict_Recs[7070..7072], l.Convict_Recs[7180..7182],
																				 l.Convict_Recs[7290..7292], l.Convict_Recs[7400..7402], l.Convict_Recs[7510..7512], l.Convict_Recs[7620..7622], l.Convict_Recs[7730..7732], l.Convict_Recs[7840..7842],
																				 l.Convict_Recs[7950..7952], l.Convict_Recs[8060..8062], l.Convict_Recs[8170..8172]);
																				 
		 SELF.conv_cmv_ind       := CHOOSE(C,l.Convict_Recs[33..33], l.Convict_Recs[143..143], l.Convict_Recs[253..253], l.Convict_Recs[363..363], l.Convict_Recs[473..473], l.Convict_Recs[583..583],
																				 l.Convict_Recs[693..693], l.Convict_Recs[803..803], l.Convict_Recs[913..913], l.Convict_Recs[1023..1023], l.Convict_Recs[1133..1133], l.Convict_Recs[1243..1243], 
																				 l.Convict_Recs[1353..1353], l.Convict_Recs[1463..1463], l.Convict_Recs[1573..1573], l.Convict_Recs[1683..1683], l.Convict_Recs[1793..1793], l.Convict_Recs[1903..1903],
																				 l.Convict_Recs[2013..2013], l.Convict_Recs[2123..2123], l.Convict_Recs[2233..2233], l.Convict_Recs[2343..2343], l.Convict_Recs[2453..2453], l.Convict_Recs[2563..2563],
																				 l.Convict_Recs[2673..2673], l.Convict_Recs[2783..2783], l.Convict_Recs[2893..2893], l.Convict_Recs[3003..3003], l.Convict_Recs[3113..3113], l.Convict_Recs[3223..3223],
																				 l.Convict_Recs[3333..3333], l.Convict_Recs[3443..3443], l.Convict_Recs[3553..3553], l.Convict_Recs[3663..3663], l.Convict_Recs[3773..3773], l.Convict_Recs[3883..3883],
																				 l.Convict_Recs[3993..3993], l.Convict_Recs[4103..4103], l.Convict_Recs[4213..4213], l.Convict_Recs[4323..4323], l.Convict_Recs[4433..4433], l.Convict_Recs[4543..4543],
																				 l.Convict_Recs[4653..4653], l.Convict_Recs[4763..4763], l.Convict_Recs[4873..4873], l.Convict_Recs[4983..4983], l.Convict_Recs[5093..5093], l.Convict_Recs[5203..5203],
																				 l.Convict_Recs[5313..5313], l.Convict_Recs[5423..5423], l.Convict_Recs[5533..5533], l.Convict_Recs[5643..5643], l.Convict_Recs[5753..5753], l.Convict_Recs[5863..5863],
																				 l.Convict_Recs[5973..5973], l.Convict_Recs[6083..6083], l.Convict_Recs[6193..6193], l.Convict_Recs[6303..6303], l.Convict_Recs[6413..6413], l.Convict_Recs[6523..6523],
																				 l.Convict_Recs[6633..6633], l.Convict_Recs[6743..6743], l.Convict_Recs[6853..6853], l.Convict_Recs[6963..6963], l.Convict_Recs[7073..7073], l.Convict_Recs[7183..7183],
																				 l.Convict_Recs[7293..7293], l.Convict_Recs[7403..7403], l.Convict_Recs[7513..7513], l.Convict_Recs[7623..7623], l.Convict_Recs[7733..7733], l.Convict_Recs[7843..7843],
																				 l.Convict_Recs[7953..7953], l.Convict_Recs[8063..8063], l.Convict_Recs[8173..8173]);
																				 
		 SELF.conv_haz_mat_ind   := CHOOSE(C,l.Convict_Recs[34..34], l.Convict_Recs[144..144], l.Convict_Recs[254..254], l.Convict_Recs[364..364], l.Convict_Recs[474..474], l.Convict_Recs[584..584],
																				 l.Convict_Recs[694..694], l.Convict_Recs[804..804], l.Convict_Recs[914..914], l.Convict_Recs[1024..1024], l.Convict_Recs[1134..1134], l.Convict_Recs[1244..1244],
																				 l.Convict_Recs[1354..1354], l.Convict_Recs[1464..1464], l.Convict_Recs[1574..1574], l.Convict_Recs[1684..1684], l.Convict_Recs[1794..1794], l.Convict_Recs[1904..1904],
																				 l.Convict_Recs[2014..2014], l.Convict_Recs[2124..2124], l.Convict_Recs[2234..2234], l.Convict_Recs[2344..2344], l.Convict_Recs[2454..2454], l.Convict_Recs[2564..2564],
																				 l.Convict_Recs[2674..2674], l.Convict_Recs[2784..2784], l.Convict_Recs[2894..2894], l.Convict_Recs[3004..3004], l.Convict_Recs[3114..3114], l.Convict_Recs[3224..3224],
																				 l.Convict_Recs[3334..3334], l.Convict_Recs[3444..3444], l.Convict_Recs[3554..3554], l.Convict_Recs[3664..3664], l.Convict_Recs[3774..3774], l.Convict_Recs[3884..3884],
																				 l.Convict_Recs[3994..3994], l.Convict_Recs[4104..4104], l.Convict_Recs[4214..4214], l.Convict_Recs[4324..4324], l.Convict_Recs[4434..4434], l.Convict_Recs[4544..4544],
																				 l.Convict_Recs[4654..4654], l.Convict_Recs[4764..4764], l.Convict_Recs[4874..4874], l.Convict_Recs[4984..4984], l.Convict_Recs[5094..5094], l.Convict_Recs[5204..5204],
																				 l.Convict_Recs[5314..5314], l.Convict_Recs[5424..5424], l.Convict_Recs[5534..5534], l.Convict_Recs[5644..5644], l.Convict_Recs[5754..5754], l.Convict_Recs[5864..5864],
																				 l.Convict_Recs[5974..5974], l.Convict_Recs[6084..6084], l.Convict_Recs[6194..6194], l.Convict_Recs[6304..6304], l.Convict_Recs[6414..6414], l.Convict_Recs[6524..6524],
																				 l.Convict_Recs[6634..6634], l.Convict_Recs[6744..6744], l.Convict_Recs[6854..6854], l.Convict_Recs[6964..6964], l.Convict_Recs[7074..7074], l.Convict_Recs[7184..7184],
																				 l.Convict_Recs[7294..7294], l.Convict_Recs[7404..7404], l.Convict_Recs[7514..7514], l.Convict_Recs[7624..7624], l.Convict_Recs[7734..7734], l.Convict_Recs[7844..7844],
																				 l.Convict_Recs[7954..7954], l.Convict_Recs[8064..8064], l.Convict_Recs[8174..8174]);
																				 
		 SELF.conv_pts_assessed  := CHOOSE(C,l.Convict_Recs[35..36], l.Convict_Recs[145..146], l.Convict_Recs[255..256], l.Convict_Recs[365..366], l.Convict_Recs[475..476], l.Convict_Recs[585..586],
																				 l.Convict_Recs[695..696], l.Convict_Recs[805..806], l.Convict_Recs[915..916], l.Convict_Recs[1025..1026], l.Convict_Recs[1135..1136], l.Convict_Recs[1245..1246],
																				 l.Convict_Recs[1355..1356], l.Convict_Recs[1465..1466], l.Convict_Recs[1575..1576], l.Convict_Recs[1685..1686], l.Convict_Recs[1795..1796], l.Convict_Recs[1905..1906],
																				 l.Convict_Recs[2015..2016], l.Convict_Recs[2125..2126], l.Convict_Recs[2235..2236], l.Convict_Recs[2345..2346], l.Convict_Recs[2455..2456], l.Convict_Recs[2565..2566],
																				 l.Convict_Recs[2675..2676], l.Convict_Recs[2785..2786], l.Convict_Recs[2895..2896], l.Convict_Recs[3005..3006], l.Convict_Recs[3115..3116], l.Convict_Recs[3225..3226],
																				 l.Convict_Recs[3335..3336], l.Convict_Recs[3445..3446], l.Convict_Recs[3555..3556], l.Convict_Recs[3665..3666], l.Convict_Recs[3775..3776], l.Convict_Recs[3885..3886],
																				 l.Convict_Recs[3995..3996], l.Convict_Recs[4105..4106], l.Convict_Recs[4215..4216], l.Convict_Recs[4325..4326], l.Convict_Recs[4435..4436], l.Convict_Recs[4545..4546],
																				 l.Convict_Recs[4655..4656], l.Convict_Recs[4765..4766], l.Convict_Recs[4875..4876], l.Convict_Recs[4985..4986], l.Convict_Recs[5095..5096], l.Convict_Recs[5205..5206],
																				 l.Convict_Recs[5315..5316], l.Convict_Recs[5425..5426], l.Convict_Recs[5535..5536], l.Convict_Recs[5645..5646], l.Convict_Recs[5755..5756], l.Convict_Recs[5865..5866],
																				 l.Convict_Recs[5975..5976], l.Convict_Recs[6085..6086], l.Convict_Recs[6195..6196], l.Convict_Recs[6305..6306], l.Convict_Recs[6415..6416], l.Convict_Recs[6525..6526],
																				 l.Convict_Recs[6635..6636], l.Convict_Recs[6745..6746], l.Convict_Recs[6855..6856], l.Convict_Recs[6965..6966], l.Convict_Recs[7075..7076], l.Convict_Recs[7185..7186],
																				 l.Convict_Recs[7295..7296], l.Convict_Recs[7405..7406], l.Convict_Recs[7515..7516], l.Convict_Recs[7625..7626], l.Convict_Recs[7735..7736], l.Convict_Recs[7845..7846],
																				 l.Convict_Recs[7955..7956], l.Convict_Recs[8065..8066], l.Convict_Recs[8175..8176]);
																				 
		 SELF.conv_driv_imp_ind  := CHOOSE(C,l.Convict_Recs[37..37], l.Convict_Recs[147..147], l.Convict_Recs[257..257], l.Convict_Recs[367..367], l.Convict_Recs[477..477], l.Convict_Recs[587..587], 
																				 l.Convict_Recs[697..697], l.Convict_Recs[807..807], l.Convict_Recs[917..917], l.Convict_Recs[1027..1027], l.Convict_Recs[1137..1137], l.Convict_Recs[1247..1247],
																				 l.Convict_Recs[1357..1357], l.Convict_Recs[1467..1467], l.Convict_Recs[1577..1577], l.Convict_Recs[1687..1687], l.Convict_Recs[1797..1797], l.Convict_Recs[1907..1907],
																				 l.Convict_Recs[2017..2017], l.Convict_Recs[2127..2127], l.Convict_Recs[2237..2237], l.Convict_Recs[2347..2347], l.Convict_Recs[2457..2457], l.Convict_Recs[2567..2567],
																				 l.Convict_Recs[2677..2677], l.Convict_Recs[2787..2787], l.Convict_Recs[2897..2897], l.Convict_Recs[3007..3007], l.Convict_Recs[3117..3117], l.Convict_Recs[3227..3227],
																				 l.Convict_Recs[3337..3337], l.Convict_Recs[3447..3447], l.Convict_Recs[3557..3557], l.Convict_Recs[3667..3667], l.Convict_Recs[3777..3777], l.Convict_Recs[3887..3887],
																				 l.Convict_Recs[3997..3997], l.Convict_Recs[4107..4107], l.Convict_Recs[4217..4217], l.Convict_Recs[4327..4327], l.Convict_Recs[4437..4437], l.Convict_Recs[4547..4547],
																				 l.Convict_Recs[4657..4657], l.Convict_Recs[4767..4767], l.Convict_Recs[4877..4877], l.Convict_Recs[4987..4987], l.Convict_Recs[5097..5097], l.Convict_Recs[5207..5207],
																				 l.Convict_Recs[5317..5317], l.Convict_Recs[5427..5427], l.Convict_Recs[5537..5537], l.Convict_Recs[5647..5647], l.Convict_Recs[5757..5757], l.Convict_Recs[5867..5867],
																				 l.Convict_Recs[5977..5977], l.Convict_Recs[6087..6087], l.Convict_Recs[6197..6197], l.Convict_Recs[6307..6307], l.Convict_Recs[6417..6417], l.Convict_Recs[6527..6527],
																				 l.Convict_Recs[6637..6637], l.Convict_Recs[6747..6747], l.Convict_Recs[6857..6857], l.Convict_Recs[6967..6967], l.Convict_Recs[7077..7077], l.Convict_Recs[7187..7187],
																				 l.Convict_Recs[7297..7297], l.Convict_Recs[7407..7407], l.Convict_Recs[7517..7517], l.Convict_Recs[7627..7627], l.Convict_Recs[7737..7737], l.Convict_Recs[7847..7847],
																				 l.Convict_Recs[7957..7957], l.Convict_Recs[8067..8067], l.Convict_Recs[8177..8177]);
																				 
		 SELF.conv_viol_date     := CHOOSE(C,l.Convict_Recs[38..45], l.Convict_Recs[148..155], l.Convict_Recs[258..265], l.Convict_Recs[368..375], l.Convict_Recs[478..485], l.Convict_Recs[588..595],
																				 l.Convict_Recs[698..705], l.Convict_Recs[808..815], l.Convict_Recs[918..925], l.Convict_Recs[1028..1035], l.Convict_Recs[1138..1145], l.Convict_Recs[1248..1255],
																				 l.Convict_Recs[1358..1365], l.Convict_Recs[1468..1475], l.Convict_Recs[1578..1585], l.Convict_Recs[1688..1695], l.Convict_Recs[1798..1805], l.Convict_Recs[1908..1915],
																				 l.Convict_Recs[2018..2025], l.Convict_Recs[2128..2135], l.Convict_Recs[2238..2245], l.Convict_Recs[2348..2355], l.Convict_Recs[2458..2465], l.Convict_Recs[2568..2575],
																				 l.Convict_Recs[2678..2685], l.Convict_Recs[2788..2795], l.Convict_Recs[2898..2905], l.Convict_Recs[3008..3015], l.Convict_Recs[3118..3125], l.Convict_Recs[3228..3235],
																				 l.Convict_Recs[3338..3345], l.Convict_Recs[3448..3455], l.Convict_Recs[3558..3565], l.Convict_Recs[3668..3675], l.Convict_Recs[3778..3785], l.Convict_Recs[3888..3895],
																				 l.Convict_Recs[3998..4005], l.Convict_Recs[4108..4115], l.Convict_Recs[4218..4225], l.Convict_Recs[4328..4335], l.Convict_Recs[4438..4445], l.Convict_Recs[4548..4555],
																				 l.Convict_Recs[4658..4665], l.Convict_Recs[4768..4775], l.Convict_Recs[4878..4885], l.Convict_Recs[4988..4995], l.Convict_Recs[5098..5105], l.Convict_Recs[5208..5215],
																				 l.Convict_Recs[5318..5325], l.Convict_Recs[5428..5435], l.Convict_Recs[5538..5545], l.Convict_Recs[5648..5655], l.Convict_Recs[5758..5765], l.Convict_Recs[5868..5875],
																				 l.Convict_Recs[5978..5985], l.Convict_Recs[6088..6095], l.Convict_Recs[6198..6205], l.Convict_Recs[6308..6315], l.Convict_Recs[6418..6425], l.Convict_Recs[6528..6535],
																				 l.Convict_Recs[6638..6645], l.Convict_Recs[6748..6755], l.Convict_Recs[6858..6865], l.Convict_Recs[6968..6975], l.Convict_Recs[7078..7085], l.Convict_Recs[7188..7195],
																				 l.Convict_Recs[7298..7305], l.Convict_Recs[7408..7415], l.Convict_Recs[7518..7525], l.Convict_Recs[7628..7635], l.Convict_Recs[7738..7745], l.Convict_Recs[7848..7855],
																				 l.Convict_Recs[7958..7965], l.Convict_Recs[8068..8075], l.Convict_Recs[8178..8185]);
																				 
		 SELF.conv_tkt_num       := CHOOSE(C,l.Convict_Recs[46..54], l.Convict_Recs[156..164], l.Convict_Recs[266..274], l.Convict_Recs[376..384], l.Convict_Recs[486..494], l.Convict_Recs[596..604],
																				 l.Convict_Recs[706..714], l.Convict_Recs[816..824], l.Convict_Recs[926..934], l.Convict_Recs[1036..1044], l.Convict_Recs[1146..1154], l.Convict_Recs[1256..1264],
																				 l.Convict_Recs[1366..1374], l.Convict_Recs[1476..1484], l.Convict_Recs[1586..1594], l.Convict_Recs[1696..1704], l.Convict_Recs[1806..1814], l.Convict_Recs[1916..1924],
																				 l.Convict_Recs[2026..2034], l.Convict_Recs[2136..2144], l.Convict_Recs[2246..2254], l.Convict_Recs[2356..2364], l.Convict_Recs[2466..2474], l.Convict_Recs[2576..2584],
																				 l.Convict_Recs[2686..2694], l.Convict_Recs[2796..2804], l.Convict_Recs[2906..2914], l.Convict_Recs[3016..3024], l.Convict_Recs[3126..3134], l.Convict_Recs[3236..3244],
																				 l.Convict_Recs[3346..3354], l.Convict_Recs[3456..3464], l.Convict_Recs[3566..3574], l.Convict_Recs[3676..3684], l.Convict_Recs[3786..3794], l.Convict_Recs[3896..3904],
																				 l.Convict_Recs[4006..4014], l.Convict_Recs[4116..4124], l.Convict_Recs[4226..4234], l.Convict_Recs[4336..4344], l.Convict_Recs[4446..4454], l.Convict_Recs[4556..4564],
																				 l.Convict_Recs[4666..4674], l.Convict_Recs[4776..4784], l.Convict_Recs[4886..4894], l.Convict_Recs[4996..5004], l.Convict_Recs[5106..5114], l.Convict_Recs[5216..5224],
																				 l.Convict_Recs[5326..5334], l.Convict_Recs[5436..5444], l.Convict_Recs[5546..5554], l.Convict_Recs[5656..5664], l.Convict_Recs[5766..5774], l.Convict_Recs[5876..5884],
																				 l.Convict_Recs[5986..5994], l.Convict_Recs[6096..6104], l.Convict_Recs[6206..6214], l.Convict_Recs[6316..6324], l.Convict_Recs[6426..6434], l.Convict_Recs[6536..6544],
																				 l.Convict_Recs[6646..6654], l.Convict_Recs[6756..6764], l.Convict_Recs[6866..6874], l.Convict_Recs[6976..6984], l.Convict_Recs[7086..7094], l.Convict_Recs[7196..7204],
																				 l.Convict_Recs[7306..7314], l.Convict_Recs[7416..7424], l.Convict_Recs[7526..7534], l.Convict_Recs[7636..7644], l.Convict_Recs[7746..7754], l.Convict_Recs[7856..7864],
																				 l.Convict_Recs[7966..7974], l.Convict_Recs[8076..8084], l.Convict_Recs[8186..8194]);
																				 
		 SELF.conv_oos_eval_date := CHOOSE(C,l.Convict_Recs[55..62], l.Convict_Recs[165..172], l.Convict_Recs[275..282], l.Convict_Recs[385..392], l.Convict_Recs[495..502], l.Convict_Recs[605..612],
																				 l.Convict_Recs[715..722], l.Convict_Recs[825..832], l.Convict_Recs[935..942], l.Convict_Recs[1045..1052], l.Convict_Recs[1155..1162], l.Convict_Recs[1265..1272],
																				 l.Convict_Recs[1375..1382], l.Convict_Recs[1485..1492], l.Convict_Recs[1595..1602], l.Convict_Recs[1705..1712], l.Convict_Recs[1815..1822], l.Convict_Recs[1925..1932],
																				 l.Convict_Recs[2035..2042], l.Convict_Recs[2145..2152], l.Convict_Recs[2255..2262], l.Convict_Recs[2365..2372], l.Convict_Recs[2475..2482], l.Convict_Recs[2585..2592],
																				 l.Convict_Recs[2695..2702], l.Convict_Recs[2805..2812], l.Convict_Recs[2915..2922], l.Convict_Recs[3025..3032], l.Convict_Recs[3135..3142], l.Convict_Recs[3245..3252],
																				 l.Convict_Recs[3355..3362], l.Convict_Recs[3465..3472], l.Convict_Recs[3575..3582], l.Convict_Recs[3685..3692], l.Convict_Recs[3795..3802], l.Convict_Recs[3905..3912],
																				 l.Convict_Recs[4015..4022], l.Convict_Recs[4125..4132], l.Convict_Recs[4235..4242], l.Convict_Recs[4345..4352], l.Convict_Recs[4455..4462], l.Convict_Recs[4565..4572],
																				 l.Convict_Recs[4675..4682], l.Convict_Recs[4785..4792], l.Convict_Recs[4895..4902], l.Convict_Recs[5005..5012], l.Convict_Recs[5115..5122], l.Convict_Recs[5225..5232],
																				 l.Convict_Recs[5335..5342], l.Convict_Recs[5445..5452], l.Convict_Recs[5555..5562], l.Convict_Recs[5665..5672], l.Convict_Recs[5775..5782], l.Convict_Recs[5885..5892],
																				 l.Convict_Recs[5995..6002], l.Convict_Recs[6105..6112], l.Convict_Recs[6215..6222], l.Convict_Recs[6325..6332], l.Convict_Recs[6435..6442], l.Convict_Recs[6545..6552],
																				 l.Convict_Recs[6655..6662], l.Convict_Recs[6765..6772], l.Convict_Recs[6875..6882], l.Convict_Recs[6985..6992], l.Convict_Recs[7095..7102], l.Convict_Recs[7205..7212],
																				 l.Convict_Recs[7315..7322], l.Convict_Recs[7425..7432], l.Convict_Recs[7535..7542], l.Convict_Recs[7645..7652], l.Convict_Recs[7755..7762], l.Convict_Recs[7865..7872],
																				 l.Convict_Recs[7975..7982], l.Convict_Recs[8085..8092], l.Convict_Recs[8195..8202]);
																				 
		 SELF.conv_loc_num       := CHOOSE(C,l.Convict_Recs[63..80], l.Convict_Recs[173..190], l.Convict_Recs[283..300], l.Convict_Recs[393..410], l.Convict_Recs[503..520], l.Convict_Recs[613..630],
																				 l.Convict_Recs[723..740], l.Convict_Recs[833..850], l.Convict_Recs[943..960], l.Convict_Recs[1053..1070], l.Convict_Recs[1163..1180], l.Convict_Recs[1273..1290], 
																				 l.Convict_Recs[1383..1400], l.Convict_Recs[1493..1510], l.Convict_Recs[1603..1620], l.Convict_Recs[1713..1730], l.Convict_Recs[1823..1840], l.Convict_Recs[1933..1950],
																				 l.Convict_Recs[2043..2060], l.Convict_Recs[2153..2170], l.Convict_Recs[2263..2280], l.Convict_Recs[2373..2390], l.Convict_Recs[2483..2500], l.Convict_Recs[2593..2610],
																				 l.Convict_Recs[2703..2720], l.Convict_Recs[2813..2830], l.Convict_Recs[2923..2940], l.Convict_Recs[3033..3050], l.Convict_Recs[3143..3160], l.Convict_Recs[3253..3270],
																				 l.Convict_Recs[3363..3380], l.Convict_Recs[3473..3490], l.Convict_Recs[3583..3600], l.Convict_Recs[3693..3710], l.Convict_Recs[3803..3820], l.Convict_Recs[3913..3930],
																				 l.Convict_Recs[4023..4040], l.Convict_Recs[4133..4150], l.Convict_Recs[4243..4260], l.Convict_Recs[4353..4370], l.Convict_Recs[4463..4480], l.Convict_Recs[4573..4590],
																				 l.Convict_Recs[4683..4700], l.Convict_Recs[4793..4810], l.Convict_Recs[4903..4920], l.Convict_Recs[5013..5030], l.Convict_Recs[5123..5140], l.Convict_Recs[5233..5250],
																				 l.Convict_Recs[5343..5360], l.Convict_Recs[5453..5470], l.Convict_Recs[5563..5580], l.Convict_Recs[5673..5690], l.Convict_Recs[5783..5800], l.Convict_Recs[5893..5910],
																				 l.Convict_Recs[6003..6020], l.Convict_Recs[6113..6130], l.Convict_Recs[6223..6240], l.Convict_Recs[6333..6350], l.Convict_Recs[6443..6460], l.Convict_Recs[6553..6570],
																				 l.Convict_Recs[6663..6680], l.Convict_Recs[6773..6790], l.Convict_Recs[6883..6900], l.Convict_Recs[6993..7010], l.Convict_Recs[7103..7120], l.Convict_Recs[7213..7230],
																				 l.Convict_Recs[7323..7340], l.Convict_Recs[7433..7450], l.Convict_Recs[7543..7560], l.Convict_Recs[7653..7670], l.Convict_Recs[7763..7780], l.Convict_Recs[7873..7890],
																				 l.Convict_Recs[7983..8000], l.Convict_Recs[8093..8110], l.Convict_Recs[8203..8220]);
																				 
		 SELF.conv_acd_code      := CHOOSE(C,l.Convict_Recs[81..83], l.Convict_Recs[191..193], l.Convict_Recs[301..303], l.Convict_Recs[411..413], l.Convict_Recs[521..523], l.Convict_Recs[631..633],
																				 l.Convict_Recs[741..743], l.Convict_Recs[851..853], l.Convict_Recs[961..963], l.Convict_Recs[1071..1073], l.Convict_Recs[1181..1183], l.Convict_Recs[1291..1293],
																				 l.Convict_Recs[1401..1403], l.Convict_Recs[1511..1513], l.Convict_Recs[1621..1623], l.Convict_Recs[1731..1733], l.Convict_Recs[1841..1843], l.Convict_Recs[1951..1953],
																				 l.Convict_Recs[2061..2063], l.Convict_Recs[2171..2173], l.Convict_Recs[2281..2283], l.Convict_Recs[2391..2393], l.Convict_Recs[2501..2503], l.Convict_Recs[2611..2613],
																				 l.Convict_Recs[2721..2723], l.Convict_Recs[2831..2833], l.Convict_Recs[2941..2943], l.Convict_Recs[3051..3053], l.Convict_Recs[3161..3163], l.Convict_Recs[3271..3273],
																				 l.Convict_Recs[3381..3383], l.Convict_Recs[3491..3493], l.Convict_Recs[3601..3603], l.Convict_Recs[3711..3713], l.Convict_Recs[3821..3823], l.Convict_Recs[3931..3933],
																				 l.Convict_Recs[4041..4043], l.Convict_Recs[4151..4153], l.Convict_Recs[4261..4263], l.Convict_Recs[4371..4373], l.Convict_Recs[4481..4483], l.Convict_Recs[4591..4593],
																				 l.Convict_Recs[4701..4703], l.Convict_Recs[4811..4813], l.Convict_Recs[4921..4923], l.Convict_Recs[5031..5033], l.Convict_Recs[5141..5143], l.Convict_Recs[5251..5253],
																				 l.Convict_Recs[5361..5363], l.Convict_Recs[5471..5473], l.Convict_Recs[5581..5583], l.Convict_Recs[5691..5693], l.Convict_Recs[5801..5803], l.Convict_Recs[5911..5913],
																				 l.Convict_Recs[6021..6023], l.Convict_Recs[6131..6133], l.Convict_Recs[6241..6243], l.Convict_Recs[6351..6353], l.Convict_Recs[6461..6463], l.Convict_Recs[6571..6573],
																				 l.Convict_Recs[6681..6683], l.Convict_Recs[6791..6793], l.Convict_Recs[6901..6903], l.Convict_Recs[7011..7013], l.Convict_Recs[7121..7123], l.Convict_Recs[7231..7233],
																				 l.Convict_Recs[7341..7343], l.Convict_Recs[7451..7453], l.Convict_Recs[7561..7563], l.Convict_Recs[7671..7673], l.Convict_Recs[7781..7783], l.Convict_Recs[7891..7893],
																				 l.Convict_Recs[8001..8003], l.Convict_Recs[8111..8113], l.Convict_Recs[8221..8223]);
																				 
		 SELF.conv_ref_num       := CHOOSE(C,l.Convict_Recs[84..91], l.Convict_Recs[194..201], l.Convict_Recs[304..311], l.Convict_Recs[414..421], l.Convict_Recs[524..531], l.Convict_Recs[634..641],
																				 l.Convict_Recs[744..751], l.Convict_Recs[854..861], l.Convict_Recs[964..971], l.Convict_Recs[1074..1081], l.Convict_Recs[1184..1191], l.Convict_Recs[1294..1301],
																				 l.Convict_Recs[1404..1411], l.Convict_Recs[1514..1521], l.Convict_Recs[1624..1631], l.Convict_Recs[1734..1741], l.Convict_Recs[1844..1851], l.Convict_Recs[1954..1961],
																				 l.Convict_Recs[2064..2071], l.Convict_Recs[2174..2181], l.Convict_Recs[2284..2291], l.Convict_Recs[2394..2401], l.Convict_Recs[2504..2511], l.Convict_Recs[2614..2621],
																				 l.Convict_Recs[2724..2731], l.Convict_Recs[2834..2841], l.Convict_Recs[2944..2951], l.Convict_Recs[3054..3061], l.Convict_Recs[3164..3171], l.Convict_Recs[3274..3281],
																				 l.Convict_Recs[3384..3391], l.Convict_Recs[3494..3501], l.Convict_Recs[3604..3611], l.Convict_Recs[3714..3721], l.Convict_Recs[3824..3831], l.Convict_Recs[3934..3941],
																				 l.Convict_Recs[4044..4051], l.Convict_Recs[4154..4161], l.Convict_Recs[4264..4271], l.Convict_Recs[4374..4381], l.Convict_Recs[4484..4491], l.Convict_Recs[4594..4601],
																				 l.Convict_Recs[4704..4711], l.Convict_Recs[4814..4821], l.Convict_Recs[4924..4931], l.Convict_Recs[5034..5041], l.Convict_Recs[5144..5151], l.Convict_Recs[5254..5261],
																				 l.Convict_Recs[5364..5371], l.Convict_Recs[5474..5481], l.Convict_Recs[5584..5591], l.Convict_Recs[5694..5701], l.Convict_Recs[5804..5811], l.Convict_Recs[5914..5921],
																				 l.Convict_Recs[6024..6031], l.Convict_Recs[6134..6141], l.Convict_Recs[6244..6251], l.Convict_Recs[6354..6361], l.Convict_Recs[6464..6471], l.Convict_Recs[6574..6581],
																				 l.Convict_Recs[6684..6691], l.Convict_Recs[6794..6801], l.Convict_Recs[6904..6911], l.Convict_Recs[7014..7021], l.Convict_Recs[7124..7131], l.Convict_Recs[7234..7241],
																				 l.Convict_Recs[7344..7351], l.Convict_Recs[7454..7461], l.Convict_Recs[7564..7571], l.Convict_Recs[7674..7681], l.Convict_Recs[7784..7791], l.Convict_Recs[7894..7901],
																				 l.Convict_Recs[8004..8011], l.Convict_Recs[8114..8121], l.Convict_Recs[8224..8231]); 
																				 
		 SELF.conv_pstd_speed    := CHOOSE(C,l.Convict_Recs[92..94], l.Convict_Recs[202..204], l.Convict_Recs[312..314], l.Convict_Recs[422..424], l.Convict_Recs[532..534], l.Convict_Recs[642..644],
																				 l.Convict_Recs[752..754], l.Convict_Recs[862..864], l.Convict_Recs[972..974], l.Convict_Recs[1082..1084], l.Convict_Recs[1192..1194], l.Convict_Recs[1302..1304],
																				 l.Convict_Recs[1412..1414], l.Convict_Recs[1522..1524], l.Convict_Recs[1632..1634], l.Convict_Recs[1742..1744], l.Convict_Recs[1852..1854], l.Convict_Recs[1962..1964],
																				 l.Convict_Recs[2072..2074], l.Convict_Recs[2182..2184], l.Convict_Recs[2292..2294], l.Convict_Recs[2402..2404], l.Convict_Recs[2512..2514], l.Convict_Recs[2622..2624],
																				 l.Convict_Recs[2732..2734], l.Convict_Recs[2842..2844], l.Convict_Recs[2952..2954], l.Convict_Recs[3062..3064], l.Convict_Recs[3172..3174], l.Convict_Recs[3282..3284],
																				 l.Convict_Recs[3392..3394], l.Convict_Recs[3502..3504], l.Convict_Recs[3612..3614], l.Convict_Recs[3722..3724], l.Convict_Recs[3832..3834], l.Convict_Recs[3942..3944],
																				 l.Convict_Recs[4052..4054], l.Convict_Recs[4162..4164], l.Convict_Recs[4272..4274], l.Convict_Recs[4382..4384], l.Convict_Recs[4492..4494], l.Convict_Recs[4602..4604],
																				 l.Convict_Recs[4712..4714], l.Convict_Recs[4822..4824], l.Convict_Recs[4932..4934], l.Convict_Recs[5042..5044], l.Convict_Recs[5152..5154], l.Convict_Recs[5262..5264],
																				 l.Convict_Recs[5372..5374], l.Convict_Recs[5482..5484], l.Convict_Recs[5592..5594], l.Convict_Recs[5702..5704], l.Convict_Recs[5812..5814], l.Convict_Recs[5922..5924],
																				 l.Convict_Recs[6032..6034], l.Convict_Recs[6142..6144], l.Convict_Recs[6252..6254], l.Convict_Recs[6362..6364], l.Convict_Recs[6472..6474], l.Convict_Recs[6582..6584],
																				 l.Convict_Recs[6692..6694], l.Convict_Recs[6802..6804], l.Convict_Recs[6912..6914], l.Convict_Recs[7022..7024], l.Convict_Recs[7132..7134], l.Convict_Recs[7242..7244],
																				 l.Convict_Recs[7352..7354], l.Convict_Recs[7462..7464], l.Convict_Recs[7572..7574], l.Convict_Recs[7682..7684], l.Convict_Recs[7792..7794], l.Convict_Recs[7902..7904],
																				 l.Convict_Recs[8012..8014], l.Convict_Recs[8122..8124], l.Convict_Recs[8232..8234]);  
																				 
		 SELF.conv_chrgd_speed   := CHOOSE(C,l.Convict_Recs[95..97], l.Convict_Recs[205..207], l.Convict_Recs[315..317], l.Convict_Recs[425..427], l.Convict_Recs[535..537], l.Convict_Recs[645..647],
																				 l.Convict_Recs[755..757], l.Convict_Recs[865..867], l.Convict_Recs[975..977], l.Convict_Recs[1085..1087], l.Convict_Recs[1195..1197], l.Convict_Recs[1305..1307],
																				 l.Convict_Recs[1415..1417], l.Convict_Recs[1525..1527], l.Convict_Recs[1635..1637], l.Convict_Recs[1745..1747], l.Convict_Recs[1855..1857], l.Convict_Recs[1965..1967],
																				 l.Convict_Recs[2075..2077], l.Convict_Recs[2185..2187], l.Convict_Recs[2295..2297], l.Convict_Recs[2405..2407], l.Convict_Recs[2515..2517], l.Convict_Recs[2625..2627],
																				 l.Convict_Recs[2735..2737], l.Convict_Recs[2845..2847], l.Convict_Recs[2955..2957], l.Convict_Recs[3065..3067], l.Convict_Recs[3175..3177], l.Convict_Recs[3285..3287],
																				 l.Convict_Recs[3395..3397], l.Convict_Recs[3505..3507], l.Convict_Recs[3615..3617], l.Convict_Recs[3725..3727], l.Convict_Recs[3835..3837], l.Convict_Recs[3945..3947],
																				 l.Convict_Recs[4055..4057], l.Convict_Recs[4165..4167], l.Convict_Recs[4275..4277], l.Convict_Recs[4385..4387], l.Convict_Recs[4495..4497], l.Convict_Recs[4605..4607],
																				 l.Convict_Recs[4715..4717], l.Convict_Recs[4825..4827], l.Convict_Recs[4935..4937], l.Convict_Recs[5045..5047], l.Convict_Recs[5155..5157], l.Convict_Recs[5265..5267],
																				 l.Convict_Recs[5375..5377], l.Convict_Recs[5485..5487], l.Convict_Recs[5595..5597], l.Convict_Recs[5705..5707], l.Convict_Recs[5815..5817], l.Convict_Recs[5925..5927],
																				 l.Convict_Recs[6035..6037], l.Convict_Recs[6145..6147], l.Convict_Recs[6255..6257], l.Convict_Recs[6365..6367], l.Convict_Recs[6475..6477], l.Convict_Recs[6585..6587],
																				 l.Convict_Recs[6695..6697], l.Convict_Recs[6805..6807], l.Convict_Recs[6915..6917], l.Convict_Recs[7025..7027], l.Convict_Recs[7135..7137], l.Convict_Recs[7245..7247],
																				 l.Convict_Recs[7355..7357], l.Convict_Recs[7465..7467], l.Convict_Recs[7575..7577], l.Convict_Recs[7685..7687], l.Convict_Recs[7795..7797], l.Convict_Recs[7905..7907],
																				 l.Convict_Recs[8015..8017], l.Convict_Recs[8125..8127], l.Convict_Recs[8235..8237]);
																				 
		 SELF.conv_cdl_ind       := CHOOSE(C,l.Convict_Recs[98..98], l.Convict_Recs[208..208], l.Convict_Recs[318..318], l.Convict_Recs[428..428], l.Convict_Recs[538..538], l.Convict_Recs[648..648],
																				 l.Convict_Recs[758..758], l.Convict_Recs[868..868], l.Convict_Recs[978..978], l.Convict_Recs[1088..1088], l.Convict_Recs[1198..1198], l.Convict_Recs[1308..1308],
																				 l.Convict_Recs[1418..1418], l.Convict_Recs[1528..1528], l.Convict_Recs[1638..1638], l.Convict_Recs[1748..1748], l.Convict_Recs[1858..1858], l.Convict_Recs[1968..1968],
																				 l.Convict_Recs[2078..2078], l.Convict_Recs[2188..2188], l.Convict_Recs[2298..2298], l.Convict_Recs[2408..2408], l.Convict_Recs[2518..2518], l.Convict_Recs[2628..2628],
																				 l.Convict_Recs[2738..2738], l.Convict_Recs[2848..2848], l.Convict_Recs[2958..2958], l.Convict_Recs[3068..3068], l.Convict_Recs[3178..3178], l.Convict_Recs[3288..3288],
																				 l.Convict_Recs[3398..3398], l.Convict_Recs[3508..3508], l.Convict_Recs[3618..3618], l.Convict_Recs[3728..3728], l.Convict_Recs[3838..3838], l.Convict_Recs[3948..3948],
																				 l.Convict_Recs[4058..4058], l.Convict_Recs[4168..4168], l.Convict_Recs[4278..4278], l.Convict_Recs[4388..4388], l.Convict_Recs[4498..4498], l.Convict_Recs[4608..4608],
																				 l.Convict_Recs[4718..4718], l.Convict_Recs[4828..4828], l.Convict_Recs[4938..4938], l.Convict_Recs[5048..5048], l.Convict_Recs[5158..5158], l.Convict_Recs[5268..5268],
																				 l.Convict_Recs[5378..5378], l.Convict_Recs[5488..5488], l.Convict_Recs[5598..5598], l.Convict_Recs[5708..5708], l.Convict_Recs[5818..5818], l.Convict_Recs[5928..5928],
																				 l.Convict_Recs[6038..6038], l.Convict_Recs[6148..6148], l.Convict_Recs[6258..6258], l.Convict_Recs[6368..6368], l.Convict_Recs[6478..6478], l.Convict_Recs[6588..6588],
																				 l.Convict_Recs[6698..6698], l.Convict_Recs[6808..6808], l.Convict_Recs[6918..6918], l.Convict_Recs[7028..7028], l.Convict_Recs[7138..7138], l.Convict_Recs[7248..7248],
																				 l.Convict_Recs[7358..7358], l.Convict_Recs[7468..7468], l.Convict_Recs[7578..7578], l.Convict_Recs[7688..7688], l.Convict_Recs[7798..7798], l.Convict_Recs[7908..7908],
																				 l.Convict_Recs[8018..8018], l.Convict_Recs[8128..8128], l.Convict_Recs[8238..8238]);
																				 
		 SELF.conv_id            := CHOOSE(C,l.Convict_Recs[99..100], l.Convict_Recs[209..210], l.Convict_Recs[319..320], l.Convict_Recs[429..430], l.Convict_Recs[539..540], l.Convict_Recs[649..650],
																				 l.Convict_Recs[759..760], l.Convict_Recs[869..870], l.Convict_Recs[979..980], l.Convict_Recs[1089..1090], l.Convict_Recs[1199..1200], l.Convict_Recs[1309..1310],
																				 l.Convict_Recs[1419..1420], l.Convict_Recs[1529..1530], l.Convict_Recs[1639..1640], l.Convict_Recs[1749..1750], l.Convict_Recs[1859..1860], l.Convict_Recs[1969..1970],
																				 l.Convict_Recs[2079..2080], l.Convict_Recs[2189..2190], l.Convict_Recs[2299..2300], l.Convict_Recs[2409..2410], l.Convict_Recs[2519..2520], l.Convict_Recs[2629..2630],
																				 l.Convict_Recs[2739..2740], l.Convict_Recs[2849..2850], l.Convict_Recs[2959..2960], l.Convict_Recs[3069..3070], l.Convict_Recs[3179..3180], l.Convict_Recs[3289..3290],
																				 l.Convict_Recs[3399..3400], l.Convict_Recs[3509..3510], l.Convict_Recs[3619..3620], l.Convict_Recs[3729..3730], l.Convict_Recs[3839..3840], l.Convict_Recs[3949..3950],
																				 l.Convict_Recs[4059..4060], l.Convict_Recs[4169..4170], l.Convict_Recs[4279..4280], l.Convict_Recs[4389..4390], l.Convict_Recs[4499..4500], l.Convict_Recs[4609..4610],
																				 l.Convict_Recs[4719..4720], l.Convict_Recs[4829..4830], l.Convict_Recs[4939..4940], l.Convict_Recs[5049..5050], l.Convict_Recs[5159..5160], l.Convict_Recs[5269..5270],
																				 l.Convict_Recs[5379..5380], l.Convict_Recs[5489..5490], l.Convict_Recs[5599..5600], l.Convict_Recs[5709..5710], l.Convict_Recs[5819..5820], l.Convict_Recs[5929..5930],
																				 l.Convict_Recs[6039..6040], l.Convict_Recs[6149..6150], l.Convict_Recs[6259..6260], l.Convict_Recs[6369..6370], l.Convict_Recs[6479..6480], l.Convict_Recs[6589..6590],
																				 l.Convict_Recs[6699..6700], l.Convict_Recs[6809..6810], l.Convict_Recs[6919..6920], l.Convict_Recs[7029..7030], l.Convict_Recs[7139..7140], l.Convict_Recs[7249..7250],
																				 l.Convict_Recs[7359..7360], l.Convict_Recs[7469..7470], l.Convict_Recs[7579..7580], l.Convict_Recs[7689..7690], l.Convict_Recs[7799..7800], l.Convict_Recs[7909..7910],
																				 l.Convict_Recs[8019..8020], l.Convict_Recs[8129..8130], l.Convict_Recs[8239..8240]);
																				 
		 SELF.conv_sis           := CHOOSE(C,l.Convict_Recs[101..101], l.Convict_Recs[211..211], l.Convict_Recs[321..321], l.Convict_Recs[431..431], l.Convict_Recs[541..541], l.Convict_Recs[651..651],
																				 l.Convict_Recs[761..761], l.Convict_Recs[871..871], l.Convict_Recs[981..981], l.Convict_Recs[1091..1091], l.Convict_Recs[1201..1201], l.Convict_Recs[1311..1311],
																				 l.Convict_Recs[1421..1421], l.Convict_Recs[1531..1531], l.Convict_Recs[1641..1641], l.Convict_Recs[1751..1751], l.Convict_Recs[1861..1861], l.Convict_Recs[1971..1971],
																				 l.Convict_Recs[2081..2081], l.Convict_Recs[2191..2191], l.Convict_Recs[2301..2301], l.Convict_Recs[2411..2411], l.Convict_Recs[2521..2521], l.Convict_Recs[2631..2631],
																				 l.Convict_Recs[2741..2741], l.Convict_Recs[2851..2851], l.Convict_Recs[2961..2961], l.Convict_Recs[3071..3071], l.Convict_Recs[3181..3181], l.Convict_Recs[3291..3291],
																				 l.Convict_Recs[3401..3401], l.Convict_Recs[3511..3511], l.Convict_Recs[3621..3621], l.Convict_Recs[3731..3731], l.Convict_Recs[3841..3841], l.Convict_Recs[3951..3951],
																				 l.Convict_Recs[4061..4061], l.Convict_Recs[4171..4171], l.Convict_Recs[4281..4281], l.Convict_Recs[4391..4391], l.Convict_Recs[4501..4501], l.Convict_Recs[4611..4611],
																				 l.Convict_Recs[4721..4721], l.Convict_Recs[4831..4831], l.Convict_Recs[4941..4941], l.Convict_Recs[5051..5051], l.Convict_Recs[5161..5161], l.Convict_Recs[5271..5271],
																				 l.Convict_Recs[5381..5381], l.Convict_Recs[5491..5491], l.Convict_Recs[5601..5601], l.Convict_Recs[5711..5711], l.Convict_Recs[5821..5821], l.Convict_Recs[5931..5931],
																				 l.Convict_Recs[6041..6041], l.Convict_Recs[6151..6151], l.Convict_Recs[6261..6261], l.Convict_Recs[6371..6371], l.Convict_Recs[6481..6481], l.Convict_Recs[6591..6591],
																				 l.Convict_Recs[6701..6701], l.Convict_Recs[6811..6811], l.Convict_Recs[6921..6921], l.Convict_Recs[7031..7031], l.Convict_Recs[7141..7141], l.Convict_Recs[7251..7251],
																				 l.Convict_Recs[7361..7361], l.Convict_Recs[7471..7471], l.Convict_Recs[7581..7581], l.Convict_Recs[7691..7691], l.Convict_Recs[7801..7801], l.Convict_Recs[7911..7911],
																				 l.Convict_Recs[8021..8021], l.Convict_Recs[8131..8131], l.Convict_Recs[8241..8241]);
																				 
		 SELF.conv_bac_lvl       := CHOOSE(C,l.Convict_Recs[102..104], l.Convict_Recs[212..214], l.Convict_Recs[322..324], l.Convict_Recs[432..434], l.Convict_Recs[542..544], l.Convict_Recs[652..654],
																				 l.Convict_Recs[762..764], l.Convict_Recs[872..874], l.Convict_Recs[982..984], l.Convict_Recs[1092..1094], l.Convict_Recs[1202..1204], l.Convict_Recs[1312..1314],
																				 l.Convict_Recs[1422..1424], l.Convict_Recs[1532..1534], l.Convict_Recs[1642..1644], l.Convict_Recs[1752..1754], l.Convict_Recs[1862..1864], l.Convict_Recs[1972..1974],
																				 l.Convict_Recs[2082..2084], l.Convict_Recs[2192..2194], l.Convict_Recs[2302..2304], l.Convict_Recs[2412..2414], l.Convict_Recs[2522..2524], l.Convict_Recs[2632..2634],
																				 l.Convict_Recs[2742..2744], l.Convict_Recs[2852..2854], l.Convict_Recs[2962..2964], l.Convict_Recs[3072..3074], l.Convict_Recs[3182..3184], l.Convict_Recs[3292..3294],
																				 l.Convict_Recs[3402..3404], l.Convict_Recs[3512..3514], l.Convict_Recs[3622..3624], l.Convict_Recs[3732..3734], l.Convict_Recs[3842..3844], l.Convict_Recs[3952..3954],
																				 l.Convict_Recs[4062..4064], l.Convict_Recs[4172..4174], l.Convict_Recs[4282..4284], l.Convict_Recs[4392..4394], l.Convict_Recs[4502..4504], l.Convict_Recs[4612..4614],
																				 l.Convict_Recs[4722..4724], l.Convict_Recs[4832..4834], l.Convict_Recs[4942..4944], l.Convict_Recs[5052..5054], l.Convict_Recs[5162..5164], l.Convict_Recs[5272..5274],
																				 l.Convict_Recs[5382..5384], l.Convict_Recs[5492..5494], l.Convict_Recs[5602..5604], l.Convict_Recs[5712..5714], l.Convict_Recs[5822..5824], l.Convict_Recs[5932..5934],
																				 l.Convict_Recs[6042..6044], l.Convict_Recs[6152..6154], l.Convict_Recs[6262..6264], l.Convict_Recs[6372..6374], l.Convict_Recs[6482..6484], l.Convict_Recs[6592..6594],
																				 l.Convict_Recs[6702..6704], l.Convict_Recs[6812..6814], l.Convict_Recs[6922..6924], l.Convict_Recs[7032..7034], l.Convict_Recs[7142..7144], l.Convict_Recs[7252..7254],
																				 l.Convict_Recs[7362..7364], l.Convict_Recs[7472..7474], l.Convict_Recs[7582..7584], l.Convict_Recs[7692..7694], l.Convict_Recs[7802..7804], l.Convict_Recs[7912..7914],
																				 l.Convict_Recs[8022..8024], l.Convict_Recs[8132..8134], l.Convict_Recs[8242..8244]);
																				 
		 SELF.conv_filler2       := CHOOSE(C,l.Convict_Recs[105..110], l.Convict_Recs[215..220], l.Convict_Recs[325..330], l.Convict_Recs[435..440], l.Convict_Recs[545..550], l.Convict_Recs[655..660],
																				 l.Convict_Recs[765..770], l.Convict_Recs[875..880], l.Convict_Recs[985..990], l.Convict_Recs[1095..1100], l.Convict_Recs[1205..1210], l.Convict_Recs[1315..1320],
																				 l.Convict_Recs[1425..1430], l.Convict_Recs[1535..1540], l.Convict_Recs[1645..1650], l.Convict_Recs[1755..1760], l.Convict_Recs[1865..1870],l.Convict_Recs[1975..1980],
																				 l.Convict_Recs[2085..2090], l.Convict_Recs[2195..2200], l.Convict_Recs[2305..2310], l.Convict_Recs[2415..2420], l.Convict_Recs[2525..2530], l.Convict_Recs[2635..2640],
																				 l.Convict_Recs[2745..2750], l.Convict_Recs[2855..2860], l.Convict_Recs[2965..2970], l.Convict_Recs[3075..3080], l.Convict_Recs[3185..3190], l.Convict_Recs[3295..3300],
																				 l.Convict_Recs[3405..3410], l.Convict_Recs[3515..3520], l.Convict_Recs[3625..3630], l.Convict_Recs[3735..3740], l.Convict_Recs[3845..3850], l.Convict_Recs[3955..3960],
																				 l.Convict_Recs[4065..4070], l.Convict_Recs[4175..4180], l.Convict_Recs[4285..4290], l.Convict_Recs[4395..4400], l.Convict_Recs[4505..4510], l.Convict_Recs[4615..4620],
																				 l.Convict_Recs[4725..4730], l.Convict_Recs[4835..4840], l.Convict_Recs[4945..4950], l.Convict_Recs[5055..5060], l.Convict_Recs[5165..5170], l.Convict_Recs[5275..5280],
																				 l.Convict_Recs[5385..5390], l.Convict_Recs[5495..5500], l.Convict_Recs[5605..5610], l.Convict_Recs[5715..5720], l.Convict_Recs[5825..5830], l.Convict_Recs[5935..5940],
																				 l.Convict_Recs[6045..6050], l.Convict_Recs[6155..6160], l.Convict_Recs[6265..6270], l.Convict_Recs[6375..6380], l.Convict_Recs[6485..6490], l.Convict_Recs[6595..6600],
																				 l.Convict_Recs[6705..6710], l.Convict_Recs[6815..6820], l.Convict_Recs[6925..6930], l.Convict_Recs[7035..7040], l.Convict_Recs[7145..7150], l.Convict_Recs[7255..7260],
																				 l.Convict_Recs[7365..7370], l.Convict_Recs[7475..7480], l.Convict_Recs[7585..7590], l.Convict_Recs[7695..7700], l.Convict_Recs[7805..7810], l.Convict_Recs[7915..7920],
																				 l.Convict_Recs[8025..8030], l.Convict_Recs[8135..8140], l.Convict_Recs[8245..8250]);
	 END; 
	 
	 convrecs := NORMALIZE(inrecs, 
                         IF(LEFT.Conv_Counts > 75,ERROR('THE NUMBER OF CONVICTION RECORDS ARE OVER THE EXPECTED LIMIT OF 75'),LEFT.Conv_Counts),	 
	                       transConv1(LEFT,COUNTER));
	 
	 Layouts_DL_MO_New_In.Layout_MO_Points_Pdate transConv2(convrecs l) := TRANSFORM
		 SELF.process_date      := IF(_Validate.Date.fIsValid(processDate),processDate,'');
		 SELF.Unique_Key        := trimUpper(l.Unique_Key); 
		 SELF.conv_viol_code    := IF((INTEGER)stringlib.stringfilter(l.conv_viol_code,'0123456789')<>0,stringlib.stringfilter(l.conv_viol_code,'0123456789'),'');
		 SELF.conv_pts_date     := IF(_Validate.Date.fIsValid(l.conv_pts_date) AND
	                                _Validate.Date.fIsValid(l.conv_pts_date,_Validate.Date.Rules.DateInPast),l.conv_pts_date,'');
		 SELF.conv_date         := IF(_Validate.Date.fIsValid(l.conv_date) AND
	                                _Validate.Date.fIsValid(l.conv_date,_Validate.Date.Rules.DateInPast),l.conv_date,'');
		 SELF.conv_crt_loc      := trimUpper(l.conv_crt_loc);
		 SELF.conv_crt_type     := trimUpper(l.conv_crt_type);
		 SELF.conv_cmv_ind      := trimUpper(l.conv_cmv_ind);
		 SELF.conv_haz_mat_ind  := trimUpper(l.conv_haz_mat_ind);
		 SELF.conv_pts_assessed := IF((INTEGER)stringlib.stringfilter(l.conv_pts_assessed,'0123456789')<>0,stringlib.stringfilter(l.conv_pts_assessed,'0123456789'),'');
		 SELF.conv_driv_imp_ind := trimUpper(l.conv_driv_imp_ind);
		 SELF.conv_viol_date    := IF(_Validate.Date.fIsValid(l.conv_viol_date) AND
	                                _Validate.Date.fIsValid(l.conv_viol_date,_Validate.Date.Rules.DateInPast),l.conv_viol_date,'');
		 SELF.conv_tkt_num      := trimUpper(l.conv_tkt_num);
		 SELF.conv_oos_eval_date:= IF(_Validate.Date.fIsValid(l.conv_oos_eval_date) AND
	                                _Validate.Date.fIsValid(l.conv_oos_eval_date,_Validate.Date.Rules.DateInPast),l.conv_oos_eval_date,'');
		 SELF.conv_loc_num      := trimUpper(l.conv_loc_num);
		 SELF.conv_acd_code     := trimUpper(l.conv_acd_code);
		 SELF.conv_ref_num      := trimUpper(l.conv_ref_num);
		 SELF.conv_pstd_speed   := IF((INTEGER)stringlib.stringfilter(l.conv_pstd_speed,'0123456789')<>0,stringlib.stringfilter(l.conv_pstd_speed,'0123456789'),'');
		 SELF.conv_chrgd_speed  := IF((INTEGER)stringlib.stringfilter(l.conv_chrgd_speed,'0123456789')<>0,stringlib.stringfilter(l.conv_chrgd_speed,'0123456789'),'');
		 SELF.conv_cdl_ind      := trimUpper(l.conv_cdl_ind);
		 SELF.conv_id           := trimUpper(l.conv_id);
		 SELF.conv_sis          := trimUpper(l.conv_sis);
		 SELF.conv_bac_lvl      := IF((INTEGER)stringlib.stringfilter(l.conv_bac_lvl,'0123456789')<>0,stringlib.stringfilter(l.conv_bac_lvl,'0123456789'),'');
		 SELF                   := L;
	 END;
	 
	 MO_DL_Conv_Recs := PROJECT(convrecs,transConv2(LEFT)); 

	 //********* Driving Privilege Records **************************************************************************
	 Layouts_DL_MO_New_In.Layout_MO_DPRDPS transDPRDPS1(inrecs l, UNSIGNED4 C) := TRANSFORM,SKIP(l.Driv_Priv_Recs = '')
		 SELF.Unique_Key         := l.Unique_Key;
		 SELF.driv_priv_type     := CHOOSE(C,l.Driv_Priv_Recs[1..4], l.Driv_Priv_Recs[41..44], l.Driv_Priv_Recs[81..84], l.Driv_Priv_Recs[121..124], l.Driv_Priv_Recs[161..164]);
		 SELF.driv_priv_eff_date := CHOOSE(C,l.Driv_Priv_Recs[5..12], l.Driv_Priv_Recs[45..52], l.Driv_Priv_Recs[85..92], l.Driv_Priv_Recs[125..132], l.Driv_Priv_Recs[165..172]);
		 SELF.driv_priv_exp_date := CHOOSE(C,l.Driv_Priv_Recs[13..20], l.Driv_Priv_Recs[53..60], l.Driv_Priv_Recs[93..100], l.Driv_Priv_Recs[133..140], l.Driv_Priv_Recs[173..180]);
		 SELF.driv_priv_sts_code := CHOOSE(C,l.Driv_Priv_Recs[21..23], l.Driv_Priv_Recs[61..63], l.Driv_Priv_Recs[101..103], l.Driv_Priv_Recs[141..143], l.Driv_Priv_Recs[181..183]);
		 SELF.driv_priv_sts_date := CHOOSE(C,l.Driv_Priv_Recs[24..31], l.Driv_Priv_Recs[64..71], l.Driv_Priv_Recs[104..111], l.Driv_Priv_Recs[144..151], l.Driv_Priv_Recs[184..191]);
		 SELF.dp_filler2         := CHOOSE(C,l.Driv_Priv_Recs[32..40], l.Driv_Priv_Recs[72..80], l.Driv_Priv_Recs[112..120], l.Driv_Priv_Recs[152..160], l.Driv_Priv_Recs[192..200]);
	 END;
	 
	 dprecs := NORMALIZE(inrecs, 
                       IF(LEFT.Driv_Priv_Counts > 5,ERROR('THE NUMBER OF DRIVING PRIV RECORDS ARE OVER THE EXPECTED LIMIT OF 5'),LEFT.Driv_Priv_Counts),	 
	                     transDPRDPS1(LEFT,COUNTER));
	 
	 Layouts_DL_MO_New_In.Layout_MO_DPRDPS_Pdate transDPRDPS2(dprecs l) := TRANSFORM
		 SELF.process_date       := IF(_Validate.Date.fIsValid(processDate),processDate,'');
		 SELF.Unique_Key         := trimUpper(l.Unique_Key); 
		 SELF.driv_priv_type     := trimUpper(l.driv_priv_type);
     SELF.driv_priv_eff_date := IF(_Validate.Date.fIsValid(l.driv_priv_eff_date),l.driv_priv_eff_date,'');
     SELF.driv_priv_exp_date := IF(_Validate.Date.fIsValid(l.driv_priv_exp_date) AND
	                                 _Validate.Date.fIsValid(l.driv_priv_exp_date,_Validate.Date.Rules.DateInPast),l.driv_priv_exp_date,'');
     SELF.driv_priv_sts_code := trimUpper(l.driv_priv_sts_code);
     SELF.driv_priv_sts_date := IF(_Validate.Date.fIsValid(l.driv_priv_sts_date),l.driv_priv_sts_date,'');
     SELF                    := L;
	 END;
	 
	 MO_DL_DrvPrv_Recs := PROJECT(dprecs,transDPRDPS2(LEFT));

   // OUTPUT(MO_DL_Action_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_action_cp_update::'+ filedate,OVERWRITE);
	 // OUTPUT(MO_DL_Accident_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_accidents_cp_update::'+ filedate,OVERWRITE);
	 // OUTPUT(MO_DL_Conv_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_points_cp_update::'+ filedate,OVERWRITE);
	 // OUTPUT(MO_DL_DrvPrv_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_dprdps_cp_update::'+ filedate,OVERWRITE);
	 // OUTPUT(MO_DL_AKA_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_aka2_cp_update::'+ filedate,OVERWRITE);
	 
	 Cleaned_MO_DL_CP_Recs_MedCert   := SEQUENTIAL(
	            OUTPUT(MO_DL_Action_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_action_cp_update::'+ filedate,OVERWRITE),
	            OUTPUT(MO_DL_Accident_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_accidents_cp_update::'+ filedate,OVERWRITE),
	            OUTPUT(MO_DL_Conv_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_points_cp_update::'+ filedate,OVERWRITE),
	            OUTPUT(MO_DL_DrvPrv_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_dprdps_cp_update::'+ filedate,OVERWRITE),
	            OUTPUT(MO_DL_AKA_Recs,,DriversV2.Constants.cluster+'in::dl2::mo_aka2_cp_update::'+ filedate,OVERWRITE),
	            FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::mo_new_action_cp_updates::superfile', 
											  DriversV2.Constants.cluster +'in::dl2::mo_action_cp_update::'+filedate), 
							FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::mo_new_accidents_cp_updates::superfile', 
						          	DriversV2.Constants.cluster +'in::dl2::mo_accidents_cp_update::'+filedate), 
              FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::mo_new_aka2_cp_updates::superfile', 
						         	DriversV2.Constants.cluster +'in::dl2::mo_aka2_cp_update::'+filedate), 
							FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::mo_new_dprdps_cp_updates::superfile', 
						          	DriversV2.Constants.cluster +'in::dl2::mo_dprdps_cp_update::'+filedate), 
							FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::mo_new_points_cp_updates::superfile', 
						          	DriversV2.Constants.cluster +'in::dl2::mo_points_cp_update::'+filedate), 					
							FileServices.FinishSuperFileTransaction());
	 
	 RETURN  Cleaned_MO_DL_CP_Recs_MedCert;
END;