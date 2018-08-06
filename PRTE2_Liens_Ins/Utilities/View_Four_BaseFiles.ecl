IMPORT PRTE2_Liens_Ins,PRTE2_Common,Address;

IDsLinda := ['17272013003100','17271233003396','17271233004331','17272093001033','17272003001904','17272033000153','17272033003262','17272063004816','17271233002091',
'17272093000553','17271233000885','17272003004922','17271223000123','17271233002617','17272023000506','17272033000854','17272003003197','17272013003403',
'17271223000290','17272013001356','17272023000516','17272033003331','17272073000058','HG123ERT4958000OHCUYM7','HG123ERT4968000OHCOSM1',
'HG123ERT4978000OHCUYM7','HG123ERT4988000OHCOSM1'];

// SORT(PRTE2_Liens_Ins.Files.Main_IN_DS_PROD,tmsid); //Prod file.
// SORT(PRTE2_Liens_Ins.Files.Main_DS_Prod,tmsid); //Prod file.
// SORT(PRTE2_Liens_Ins.Files.Party_IN_DS_Prod,tmsid); //Prod file.
// SORT(PRTE2_Liens_Ins.Files.Party_Base_DS_Prod,tmsid); //Prod file.

SORT(PRTE2_Liens_Ins.Files.Main_IN_DS_PROD(tmsid in IDsLinda),tmsid); //Prod file.
SORT(PRTE2_Liens_Ins.Files.Main_DS_Prod(tmsid in IDsLinda),tmsid); //Prod file.
SORT(PRTE2_Liens_Ins.Files.Party_IN_DS_Prod(tmsid in IDsLinda),tmsid); //Prod file.
SORT(PRTE2_Liens_Ins.Files.Party_Base_DS_Prod(tmsid in IDsLinda),tmsid); //Prod file.

DSP := SORT(PRTE2_Liens_Ins.Files.Party_IN_DS_Prod(tmsid in IDsLinda),tmsid);
FMLSwapLFM := PRTE2_Common.Functions.FMLSwapLFM;
DSP;
SLayout := {STRING SNAME};
DSP2a := PROJECT(DSP,
						TRANSFORM({SLayout},
									SELF.SNAME := FMLSwapLFM(LEFT.orig_full_debtorname,LEFT.orig_suffix);
									));
DSP2a;
DSP2b := PROJECT(DSP,
						TRANSFORM({DSP},
									LFM_Name := FMLSwapLFM(LEFT.orig_full_debtorname,LEFT.orig_suffix);
									TempPname					:= Address.CleanPersonLFM73(LFM_Name);
									self.title				:= TempPname[1..5];
									self.fname				:= TempPname[6..25];
									self.mname				:= TempPname[26..45];
									self.lname				:= TempPname[46..65];
									SELF := LEFT;
									));

DSP2b;