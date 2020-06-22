
/*
MyRules := DATASET([
  {0, 0, 1, 'Rule1', 'IP Address City is Miami and Address out of state.', 't15_ssnpopflag', '1', 0, 0, 3},
  {0, 0, 1, 'Rule1', 'IP Address City is Miami and Address out of state.', 't1_lexidpopflag', '1', 0, 0, 3},
	{0, 0, 1, 'Rule99_1', 'Unscorable', 'p1_idriskunscrbleflag', '1', 0, 0, 99},
	{0, 0, 9, 'Rule99_9', 'Unscorable', 'p9_addrriskunscrbleflag', '1', 0, 0, 99},
	{0, 0, 15, 'Rule99_15', 'Unscorable', 'p15_ssnriskunscrbleflag', '1', 0, 0, 99},
	{0, 0, 16, 'Rule99_16', 'Unscorable', 'p16_phnriskunscrbleflag', '1', 0, 0, 99},
	{0, 0, 17, 'Rule99_17', 'Unscorable', 'p17_emailriskunscrbleflag', '1', 0, 0, 99},
	{0, 0, 18, 'Rule99_18', 'Unscorable', 'p18_ipaddrriskunscrbleflag', '1', 0, 0, 99},
	{0, 0, 19, 'Rule99_19', 'Unscorable', 'p19_bnkacctriskunscrbleflag', '1', 0, 0, 99},
	{0, 0, 20, 'Rule99_20', 'Unscorable', 'p20_dlriskunscrbleflag', '1', 0, 0, 99},
  {0, 0, 1, 'Rule3', 'Address is out of state and IP Address is NOT in the US.', 'addressoutofstate', '1', 0, 0, 3},
  {0, 0, 1, 'Rule3', 'Address is out of state and IP Address is NOT in the US.', 't18_ipaddrlocnonusflag', '1', 0, 0, 3},
	{0, 0, 1, 'Rule1-1', 'Identity Deceased', 'deceased', '1', 0, 0, 3},
	{0, 0, 1, 'Rule1-2', 'Identity is currently incarcerated', 'currentlyincarceratedflag', '1', 0, 0, 3},
  {8342784, 1014, 1, 'Rule3', 'Address is out of state and IP Address NOT is in the US.', 'addressoutofstate', '1', 0, 0, 1},
  {8342784, 1014, 1, 'Rule3', 'Address is out of state and IP Address NOT is in the US.', 't18_ipaddrlocnonusflag', '1', 0, 0, 1},
  {0, 0, 18, 'Rule4', 'Address is a PO Box and IP Address is NOT in the US.', 't18_ipaddrlocnonusflag', '1', 0, 0, 3},
  {0, 0, 18, 'Rule4', 'Address is a PO Box and IP Address is NOT in the US.', 'addressispobox', '1', 0, 0, 3},
  {0, 0, 9, 'Rule5', 'Address is vacant.', 'address_is_vacant_', '1', 0, 0, 1},
  {0, 0, 9, 'Rule6', 'Address is Commercial Receiving Agency', 'addressiscmra', '1', 0, 0, 1},
  {0, 0, 9, 'Rule7', 'Address is out of state.', 'addressoutofstate', '1', 0, 0, 3},
  {0, 0, 1, 'Rule9', 'p1_aotidkrgenfrdactflagev.', 'p1_aotidkrgenfrdactflagev', '1', 0, 0, 3},
  {0, 0, 9, 'Rule11', 'Address is known risk.', 'p9_aotaddrkractflagev', '1', 0, 0, 3},
  {0, 0, 15, 'Rule11', 'SSN is known risk.', 'p15_aotssnkractflagev', '1', 0, 0, 3},
  {20995369, 1014, 9, 'Rule5', 'Address is vacant.', 'addressisvacant', '1', 0, 0, 3}
  ],
  {UNSIGNED Customerid, UNSIGNED industrytype, INTEGER1 entitytype, STRING RuleName, STRING Description, STRING200 Field, STRING Value, DECIMAL6_2 Low, DECIMAL6_2 High, INTEGER RiskLevel});
*/

IMPORT Std;
IMPORT FraudgovKEL;

RulesIn := DATASET([
{'1', 'Rule99_1', 'Unscorable', 'p1_idriskunscrbleflag=1', 99},
{'9', 'Rule99_9', 'Unscorable', 'p9_addrriskunscrbleflag=1', 99},
{'15', 'Rule99_15', 'Unscorable', 'p15_ssnriskunscrbleflag', 99},
{'16', 'Rule99_16', 'Unscorable', 'p16_phnriskunscrbleflag=1', 99},
{'17', 'Rule99_17', 'Unscorable', 'p17_emailriskunscrbleflag=1', 99},
{'18', 'Rule99_18', 'Unscorable', 'p18_ipaddrriskunscrbleflag=1', 99},
{'19', 'Rule99_19', 'Unscorable', 'p19_bnkacctriskunscrbleflag', 99},
{'20', 'Rule99_20', 'Unscorable', 'p20_dlriskunscrbleflag', 99},
{'1', 'Identity01', 'KR Identity Theft and Potential Compromised-Manipulated Identities', 'P1_AoTIDKRStolIDActFlagEv=1, T1_StolIDFlag=1, T1_ManipIDFlag=1', 3},
{'1', 'Identity02', 'KR Identity Theft and Potential Compromised Identities','P1_AoTIDKRStolIDActFlagEv=1, T1_StolIDFlag=1', 3},
{'1', 'Identity03', 'KR Identity Theft and Potential Manipulated Identities','P1_AoTIDKRStolIDActFlagEv=1, T1_ManipIDFlag=1', 3},
{'1', 'Identity04', 'Active Deceased', 'T1L_IDDeceasedFlag=1,T1L_IDDtOfDeathAftIDActFlagEv=1', 3},
{'1', 'Identity05', 'Adult records missing, Compromised, Synthetic', 'T1_AdultIDNotSeenFlag=1, T1_StolIDFlag=1, T1_SynthIDFlag=1', 3},
{'1', 'Identity06', 'Adult records missing', 'T1_AdultIDNotSeenFlag=1', 3},
{'1', 'Identity07', 'Out of agency state DL and Address', 'T1L_CurrAddrNotInAgcyJurStFlag=1, T1L_BestDLNotInAgcyJurStFlag=1', 2},
{'1', 'Identity08', 'Minor with public records, Manipulated', 'T1_MinorWLexIDFlag=1, T1_ManipIDFlag=1', 2},
{'1', 'Identity09', 'Minor with public records, Synthetic', 'T1_MinorWLexIDFlag=1,T1_SynthIDFlag=1', 2},
{'1', 'Identity10', 'Minor with public records, Compromised', 'T1_MinorWLexIDFlag=1,T1_StolIDFlag=1', 2},
{'1', 'Identity11', 'Minor with public records, Compromised-Synthetic-Manipulated', 'T1_MinorWLexIDFlag=1, T1_ManipIDFlag=1, T1_StolIDFlag=1, T1_SynthIDFlag=1', 3},
{'1', 'Identity12', 'Potentially Deceased', 'T1L_IDDeceasedFlag=1', 3},
{'1', 'Identity13', 'SSN issued before DOB, Compromised', 'T1_SSNPriorDOBFlag=1,T1_StolIDFlag=1', 3},
{'1', 'Identity14', 'SSN issued before DOB, Manipulated', 'T1_SSNPriorDOBFlag=1,T1_ManipIDFlag=1', 3},
{'1', 'Identity15', 'SSN issued before DOB, Synthetic', 'T1_SSNPriorDOBFlag=1,T1_SynthIDFlag=1', 3},
{'1', 'Identity16', 'Potential Compromised-Manipulated-Synthetic Identities', 'T1_StolIDFlag=1,T1_SynthIDFlag=1,T1_ManipIDFlag=1', 3},
{'1', 'Identity17', 'Minor with public records', 'T1_MinorWLexIDFlag=1', 1},
{'1', 'Identity18', 'Address out of state, Compromised, Manipulated', 'T1L_CurrAddrNotInAgcyJurStFlag=1,T1_StolIDFlag=1,T1_ManipIDFlag=1', 3},
{'1', 'Identity19', 'DL out of state, Compromised, Manipulated', 'T1L_BestDLNotInAgcyJurStFlag=1,T1_StolIDFlag=1,T1_ManipIDFlag=1', 3},
{'1', 'Identity20', 'Minor with public records, Out of state DL and Address', 'T1_MinorWLexIDFlag=1,T1L_CurrAddrNotInAgcyJurStFlag=1,T1L_BestDLNotInAgcyJurStFlag=1', 2},
{'1', 'Identity21', 'Known Risk Application', 'P1_AoTIDKRAppFrdActFlagEv=1', 3},
{'1', 'Identity22', 'Known Risk General', 'P1_AoTIDKRGenFrdActFlagEv=1', 3},
{'1', 'Identity23', 'Known Risk Other', 'P1_AoTIDKROthFrdActFlagEv=1', 3},
{'1', 'Identity24', 'Known Risk Identity Theft', 'P1_AoTIDKRStolIDActFlagEv=1', 3},
{'1', 'Identity25', 'Potentially Incarcerated', 'T1L_IDCurrIncarcFlag=1', 3},
{'1', 'Identity26', 'Activity after death', 'T1L_IDDtOfDeathAftIDActFlagEv=1', 3},
{'1', 'Identity27', 'SSN issued before DOB', 'T1_SSNPriorDOBFlag=1', 3},
{'1', 'Identity28', 'Compromised', 'T1_StolIDFlag=1', 3},
{'1', 'Identity29', 'Manipulated', 'T1_ManipIDFlag=1', 3},
{'1', 'Identity30', 'Synthetic', 'T1_SynthIDFlag=1', 3},
{'1', 'Identity31', 'Address out of agency state', 'T1L_CurrAddrNotInAgcyJurStFlag=1', 2},
{'1', 'Identity32', 'DL out of agency state', 'T1L_BestDLNotInAgcyJurStFlag=1', 2},
{'1', 'Identity33', 'Low source counts', 'T1L_HdrSrcCatCntLwFlag=1', 2}

/*
{'18', 'IPAddress1', 'IP Address City is Miami', 't18_ipaddrlocmiamiflag', 3}, 
{'18', 'IPAddress2', 'IP Address not US and is a VPN', 't18_ipaddrlocnonusflag,t18_ipaddrvpnflag', 3},
{'18', 'IPAddress3', 'IP Address is Hosted', 't18_ipaddrhostedflag', 2}, // risk level 2
{'1', 'Identity1', 'Address and SSN not verified', 't1_addrnotverflag=1,t1l_ssnnotverflag', 3},
{'1', 'Identity2', 'Current Address not in Agency Jurisdiction and Address not verified', 't1l_curraddrnotinagcyjurstflag=1,t1_addrnotverflag', 3},
{'1', 'Identity3', 'Current Address and Best Drivers License not in Agency Jurisdiction', 't1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag', 3},
{'1', 'Identity4', 'Best Drivers License is not in Agency Jurisdiction and address is invalid', 't9_addrisinvalidflag', 2},
{'1', 'Identity5', 'Identity associated with deceased individual', 't1l_iddeceasedflag', 2},
{'1', 'Identity6', 'Best Drivers license not in Agency Jurisdiction while current address is', 't1l_curraddrnotinagcyjurstflag=0,t1l_bestdlnotinagcyjurstflag=1', 2},
{'9', 'Address1', 'Invalid Address', 't9_addrisinvalidflag', 2},
{'9', 'Address2', 'Vacant Address', 't9_addrisvacantflag', 2},
{'17', 'Email1', 'Disposable email address', 't17_emaildomaindispflag', 2}
*/
],
{integer1 EntityType, string Rulename, string Description, string AttributeFlags, INTEGER RiskLevel});
 
output(RulesIn);

rulesrec := {UNSIGNED Customerid, UNSIGNED industrytype, INTEGER1 entitytype, STRING RuleName, STRING Description, STRING200 Field, STRING Value, DECIMAL6_2 Low, DECIMAL6_2 High, INTEGER RiskLevel};

RulesPrep := PROJECT(RulesIn, TRANSFORM(rulesrec, self.field := Std.Str.ToLowerCase(Std.Str.FindReplace(LEFT.AttributeFlags, ' ', '')), SELF := LEFT, SELF := []));
output(RulesPrep);


rulesrec tNormRules(rulesrec L, INTEGER C) := TRANSFORM
  Words := Std.Str.SplitWords(L.Field, ',');
  Word := Words[C];
  FieldSplit := Std.Str.SplitWords(Word, '=');
  SELF.field := FieldSplit[1];
  SELF.Value := MAP(FieldSplit[2]='' => '1', FieldSplit[2]);
  SELF := L;
END;

NormRules :=
            NORMALIZE(RulesPrep,Std.Str.CountWords(LEFT.Field, ','),tNormRules(LEFT,COUNTER));

NormRules;            

RulesAttr := 't1_adultidnotseenflag,t1_minorwlexidflag,t1l_iddeceasedflag,t1l_iddtofdeathaftidactflagev,t1l_idcurrincarcflag,t1_ssnpriordobflag,t1_firstnmnotverflag,t1_lastnmnotverflag,t1_addrnotverflag,' +
't1l_ssnnotverflag,t1l_ssnwaltnaverflag,t1l_ssnwaddrnotverflag,t1_phnnotverflag,t1l_dobnotverflag,t1_hiriskcviflag,t1_medriskcviflag,t1l_hdrsrccatcntlwflag,t1_stolidflag,t1_synthidflag,' +
't1_manipidflag,t1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag,t9_addrisvacantflag,t9_addrisinvalidflag,t9_addriscmraflag,t15_ssnisinvalidflag,t20_dlisinvalidflag,t16_phnisinvalidflag,t16_phnprepdflag,' +
't18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,t18_ipaddrlocmiamiflag,t17_emaildomaindispflag,t19_bnkaccthrprepdrtgflag,t9_addrpoboxmultcurridflagev,t15_ssnmultcurridflagev,t20_dlmultcurridflagev,' +
't19_bnkacctmultcurridflagev,p1_aotidkrappfrdactflagev,p1_aotidkrgenfrdactflagev,p1_aotidkrothfrdactflagev,p1_aotidkrstolidactflagev,p9_aotaddrkractflagev,p15_aotssnkractflagev,p16_aotphnkractflagev,p17_aotemailkractflagev,p18_aotipaddrkractflagev,' +
'p19_aotbnkacctkractflagev,p20_aotdlkractflagev,p1_idriskunscrbleflag,p9_addrriskunscrbleflag,p15_ssnriskunscrbleflag,p16_phnriskunscrbleflag,p17_emailriskunscrbleflag,p18_ipaddrriskunscrbleflag,p19_bnkacctriskunscrbleflag,p20_dlriskunscrbleflag';

MissingRules := NormRules(Std.Str.FindCount(RulesAttr, TRIM(Field))<1);
//'p1_idriskunscrbleflag,p9_addrriskunscrbleflag,p15_ssnriskunscrbleflag,p16_phnriskunscrbleflag,p17_emailriskunscrbleflag,p18_ipaddrriskunscrbleflag,p19_bnkacctriskunscrbleflag,p20_dlriskunscrbleflag,t18_ipaddrlocmiamiflag,t18_ipaddrlocnonusflag,t18_ipaddrvpnflag,t18_ipaddrhostedflag,t1l_ssnnotverflag,t1_addrnotverflag,t1l_iddeceasedflag,t1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag,t17_emaildomaindispflag', Field)>0);
output(MissingRules, named('MissingRules'));
      
output(NormRules,,'~fraudgov::in::sprayed::configrules', CSV, overwrite);
