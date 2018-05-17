// PRTE2_WaterCraft_Ins.Utilities.BWR_Gather_Live_Prod_Samples

IMPORT PromoteSupers,PRTE2_WaterCraft_Ins;

PROD_ReadOnly_DS	:= Files.LIVEProdMainReadOnly;

// any filters to get better records?  Let's get year 2000 or later
DS := PROD_ReadOnly_DS(Sequence_key[1..4]>'2000');
// NOTE: NH and UT fail with this sequence key filter... so we may not want that (or at least for those 2 states)
//       I worked around it with second run using BWR_Gather_Live_Prod_Samples_NHUT
DS1 := PRTE2_WaterCraft_Ins.Utilities.Files.ProdGatherMainDS;
COUNT(DS);
GatherCount := 5000;
DS2 := CHOOSESETS(DS,
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

OutLay := PRTE2_WaterCraft_Ins.Utilities.Layouts.GatheredBaseMainLayout;
OutLay trxForm(DS2 L,INTEGER C) := TRANSFORM
	SELF.UniqueCnt := C;
	SELF := L;
END;
DS3 := PROJECT(DS2,trxForm(LEFT,COUNTER));

PromoteSupers.Mac_SF_BuildProcess(DS3, Files.ProdGatherMainName, Build1,,,TRUE);

Build1;

DataIn := DS3;
OUTPUT(COUNT(dataIn));

report0 := RECORD
	recTypeSrc	 := DataIn.State_Origin;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,State_Origin);
OUTPUT(SORT(RepTable0,-GroupCount));



