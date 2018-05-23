/* *********************************************************************************************** 
		PRTE2_WaterCraft_Ins.Utilities.BWR_Gather_Live_Prod_Samples
5/17/18 - added logic to capture only records not already in use in the ProdGatherMainDS
Because of the uniqueness problem I tried linking on watercraft_key+sequence_key+registration_Date+hull_number
COUNT(PROD_ReadOnly_DS);	//91,770,210  
COUNT(Gathered)				//19,000
COUNT(NEW_Only);				//91,552,834 
So yeah it is eliminating some but boy - eliminating a lot more than I thought. Back to the unique issue I guess.
*********************************************************************************************** */
IMPORT PromoteSupers,PRTE2_WaterCraft_Ins;

GatherCount := 5000;

PROD_ReadOnly_DS	:= PRTE2_WaterCraft_Ins.Utilities.Files.LIVEProdMainReadOnly;
G_WC := PRTE2_WaterCraft_Ins.Utilities.Files.ProdGatherMainDS;

NEW_Only := JOIN(PROD_ReadOnly_DS,G_WC,
					LEFT.watercraft_key=RIGHT.watercraft_key 
							AND LEFT.sequence_key=RIGHT.sequence_key
							AND LEFT.registration_date=RIGHT.registration_date
							AND LEFT.hull_number=RIGHT.hull_number,
					TRANSFORM({PROD_ReadOnly_DS}, SELF := LEFT),
					LEFT ONLY);

// any filters to get better records?  Let's get year 2000 or later
DS1 := NEW_Only(Sequence_key[1..4]>'2000');
// --------------------------------------------------------------------------------------------------------------
// NOTE: NH and UT fail with this sequence_key filter... so we may not want that (or at least for those 2 states)
//       I worked around it with second run using BWR_Gather_Live_Prod_Samples_NHUT
// --------------------------------------------------------------------------------------------------------------
DS2a := CHOOSEN(NEW_Only(State_Origin='NH'),GatherCount);
DS2b := CHOOSEN(NEW_Only(State_Origin='UT'),GatherCount);
DS2 := CHOOSESETS(DS1,
										State_Origin='AK'=>GatherCount,State_Origin='AL'=>GatherCount,State_Origin='AR'=>GatherCount,State_Origin='AZ'=>GatherCount,
										State_Origin='CA'=>GatherCount,State_Origin='CO'=>GatherCount,State_Origin='CT'=>GatherCount,State_Origin='DC'=>GatherCount,
										State_Origin='DE'=>GatherCount,State_Origin='FL'=>GatherCount,State_Origin='GA'=>GatherCount,State_Origin='HI'=>GatherCount,
										State_Origin='IA'=>GatherCount,State_Origin='ID'=>GatherCount,State_Origin='IL'=>GatherCount,State_Origin='IN'=>GatherCount,
										State_Origin='KS'=>GatherCount,State_Origin='KY'=>GatherCount,State_Origin='LA'=>GatherCount,State_Origin='MA'=>GatherCount,
										State_Origin='MD'=>GatherCount,State_Origin='ME'=>GatherCount,State_Origin='MI'=>GatherCount,State_Origin='MN'=>GatherCount,
										State_Origin='MO'=>GatherCount,State_Origin='MS'=>GatherCount,State_Origin='MT'=>GatherCount,State_Origin='NC'=>GatherCount,
										State_Origin='ND'=>GatherCount,State_Origin='NE'=>GatherCount,State_Origin='NH'=>GatherCount,State_Origin='NJ'=>GatherCount,
										State_Origin='NM'=>GatherCount,State_Origin='NV'=>GatherCount,State_Origin='NY'=>GatherCount,State_Origin='OH'=>GatherCount,
										State_Origin='OK'=>GatherCount,State_Origin='OR'=>GatherCount,State_Origin='PA'=>GatherCount,State_Origin='RI'=>GatherCount,
										State_Origin='SC'=>GatherCount,State_Origin='SD'=>GatherCount,State_Origin='TN'=>GatherCount,State_Origin='TX'=>GatherCount,
										State_Origin='UT'=>GatherCount,State_Origin='VA'=>GatherCount,State_Origin='VT'=>GatherCount,State_Origin='WA'=>GatherCount,
										State_Origin='WI'=>GatherCount,State_Origin='WV'=>GatherCount,State_Origin='WY'=>GatherCount, 0);

DS2z := DS2+DS2a+DS2b;
COUNT(DS2z);

OutLay := PRTE2_WaterCraft_Ins.Utilities.Layouts.GatheredBaseMainLayout;
OutLay trxForm(DS2z L,INTEGER C) := TRANSFORM
	SELF.UniqueCnt := C;
	SELF.In_use := '';
	SELF := L;
END;

DS3 := PROJECT(DS2z,trxForm(LEFT,COUNTER));

//***************************************************************************************
DataIn := DS3;
OUTPUT(COUNT(dataIn));

report0 := RECORD
	recTypeSrc	 := DataIn.State_Origin;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,State_Origin);
OUTPUT(SORT(RepTable0,-GroupCount));
//***************************************************************************************
PromoteSupers.Mac_SF_BuildProcess(DS3, Files.ProdGatherMainName, Build1,,,TRUE);
Build1;
//***************************************************************************************