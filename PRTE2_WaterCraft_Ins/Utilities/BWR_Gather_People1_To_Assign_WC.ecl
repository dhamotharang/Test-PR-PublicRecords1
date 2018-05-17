// PRTE2_WaterCraft_Ins.Utilities.BWR_Gather_People1_To_Assign_WC
IMPORT PRTE2_Header_Ins,PRTE2_WaterCraft_Ins,PromoteSupers;

HDR0 := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_Prod;
G_WC := PRTE2_WaterCraft_Ins.Utilities.Files.ProdGatherMainDS;
WC	  := PRTE2_WaterCraft_Ins.Datasets.All_Slim_Internal_Prod;
GathStates := SET(G_WC,st_registration);

HDR  := JOIN(HDR0,WC,
				LEFT.did = (INTEGER)RIGHT.did,
				TRANSFORM({HDR0}, SELF := LEFT),
				LEFT ONLY);
COUNT(HDR);

GatherCount := 10;
HDR2 := CHOOSESETS(HDR,
						st='AK'=>GatherCount,st='AL'=>GatherCount,st='AR'=>GatherCount,st='AZ'=>GatherCount,
						st='CA'=>GatherCount,st='CO'=>GatherCount,st='CT'=>GatherCount,st='DC'=>GatherCount,
						st='DE'=>GatherCount,st='FL'=>GatherCount,st='GA'=>GatherCount,st='HI'=>GatherCount,
						st='IA'=>GatherCount,st='ID'=>GatherCount,st='IL'=>GatherCount,st='IN'=>GatherCount,
						st='KS'=>GatherCount,st='KY'=>GatherCount,st='LA'=>GatherCount,st='MA'=>GatherCount,
						st='MD'=>GatherCount,st='ME'=>GatherCount,st='MI'=>GatherCount,st='MN'=>GatherCount,
						st='MO'=>GatherCount,st='MS'=>GatherCount,st='MT'=>GatherCount,st='NC'=>GatherCount,
						st='ND'=>GatherCount,st='NE'=>GatherCount,st='NH'=>GatherCount,st='NJ'=>GatherCount,
						st='NM'=>GatherCount,st='NV'=>GatherCount,st='NY'=>GatherCount,st='OH'=>GatherCount,
						st='OK'=>GatherCount,st='OR'=>GatherCount,st='PA'=>GatherCount,st='RI'=>GatherCount,
						st='SC'=>GatherCount,st='SD'=>GatherCount,st='TN'=>GatherCount,st='TX'=>GatherCount,
						st='UT'=>GatherCount,st='VA'=>GatherCount,st='VT'=>GatherCount,st='WA'=>GatherCount,
						st='WI'=>GatherCount,st='WV'=>GatherCount,st='WY'=>GatherCount, 0);
HDR2;
COUNT(HDR2);
HDR3 := HDR2(st IN GathStates);
HDR3;
COUNT(HDR3);


PromoteSupers.Mac_SF_BuildProcess(HDR3, Files.FakePIIGatherName, Build1,,,TRUE);
Build1;

DataIn := HDR3;
OUTPUT(COUNT(dataIn));

report0 := RECORD
	recTypeSrc	 := DataIn.st;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,st);
OUTPUT(SORT(RepTable0,recTypeSrc));
