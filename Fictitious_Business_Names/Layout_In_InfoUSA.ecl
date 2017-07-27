
export Layout_In_InfoUSA := record, maxlength(1710470) 
string lni  																			{xpath('@lni')};
string minrev 																		{xpath('@minrev')}; 
string src																				{xpath('@src')}; 
string f 																					{xpath('@f')};
string Date_last_updated     										  {xpath('TD')};
string LEGEND2               										  {xpath('LG2')};
string StateDesc              										{xpath('PU')};
string BusinessName          											{xpath('DN')};
string BusinessTelephone_AreaCode     						{xpath('AR')};
string BusinessTelephone_Number                   {xpath('TP')};
string FilingDate             										{xpath('FD')};
string BusinessCounty        											{xpath('BIC')};
string BusinessCounty_Name   										  {xpath('BIC/CU')};
string BusinessDesc   								            {xpath('DP')};
string SIC										                    {xpath('SIC')};
string NULL_TAG													          {xpath('LXD')};
string FileCode          											    {xpath('FI')};
string File                  											{xpath('FLE')};
string Cite_ID								                    {xpath('CI')};
string BusinessAddress     												{xpath('BA')};
string BusinessAddress_S1    											{xpath('BA/S1')};
string BusinessAddress_CY    											{xpath('BA/CY')};
string BusinessAddress_ST    											{xpath('BA/ST')};
string BusinessAddress_ZP    											{xpath('BA/ZP')};
string ContactPersonAddress 											{xpath('CCA')};
string ContactPersonAddress_S1										{xpath('CCA/S1')};
string ContactPersonAddress_CY										{xpath('CCA/CY')};
string ContactPersonAddress_ST										{xpath('CCA/ST')};
string ContactPersonAddress_ZP										{xpath('CCA/ZP')};
string Telephone_AreaCode													{xpath('CCA/AR')};
string Telephone_Number														{xpath('CCA/TP')};
string CCT_lastname       											  {xpath('CCT/LN')};
string CCT_Suffix         											  {xpath('SF')};
string CCT_firstname        											{xpath('CCT/GN')};
string NAME_SEQUENCE       											  {xpath('NS')};
string Filing_Type    											      {xpath('TYP')};
string DUMMY_SEG           											  {xpath('DUMMY-SEG')};
 end;





































