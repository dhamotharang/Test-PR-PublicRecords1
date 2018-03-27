// PRTE2_LNProperty.BWR_Despray_Boca_Base 

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
#workunit('name', 'PRCT LNProperty Base Studies');

LNP_Base_SF_DS			:= LNP.Files.BOCA_BASE_SF_DS_PROD;		// Boca base only on PROD THOR
BaseSort						:= SORT(LNP_Base_SF_DS,RECORD);
BaseDedup						:= DEDUP(BaseSort,RECORD);

DS1 := BaseDedup(LN_Fares_ID[1]='R');
DS2 := BaseDedup(LN_Fares_ID[1]='O');
DS3 := BaseDedup(LN_Fares_ID[1]='D');
DS4 := BaseDedup(LN_Fares_ID[2]='A');
DS5 := BaseDedup(LN_Fares_ID[2]='D');
DS6 := BaseDedup(LN_Fares_ID[2]='M');

OUTPUT(COUNT(BaseSort));			//ORIG 2,996,195
OUTPUT(COUNT(BaseDedup));			//DEDUP 2,993,973
OUTPUT(COUNT(DS1));			// LN_Fares_ID[1]='R'			1,533,973 => 1,533,259
OUTPUT(COUNT(DS2));			// LN_Fares_ID[1]='O'			744,423 => 743,693
OUTPUT(COUNT(DS3));			// LN_Fares_ID[1]='D'			717,779 => 717,021

OUTPUT(COUNT(DS4));			// LN_Fares_ID[2]='A'			1,538,102 => 1,537,326
OUTPUT(COUNT(DS5));			// LN_Fares_ID[2]='D'			1,325,474 => 1,324,064
OUTPUT(COUNT(DS6));			// LN_Fares_ID[2]='M'			132,619 => 132,583
