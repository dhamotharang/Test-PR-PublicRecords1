﻿// EXPORT statistics_runway_scores := 'todo';

#workunit('name', 'runway_score_distributions');
IMPORT riskview;

// ******* Input report info here ********
basefilename := '~nkoubsky::out::lab_runway_baseline_w20140616-003826'; 
testfilename := '~nkoubsky::out::lab_runway_secondrun_w20140616-003923'; 
eyeball := 20;
// ***************************************

input_lay := RECORD
  unsigned8 seq;
  unsigned8 did;
  string2 nap;
  string2 nas;
  string2 cvi_score;
  string2 cvi_reason1;
  string2 cvi_reason2;
  string2 cvi_reason3;
  string2 cvi_reason4;
  string3 aid605_1_0_score;
  string2 aid605_1_0_reason1;
  string2 aid605_1_0_reason2;
  string2 aid605_1_0_reason3;
  string2 aid605_1_0_reason4;
  string3 aid606_0_0_score;
  string2 aid606_0_0_reason1;
  string2 aid606_0_0_reason2;
  string2 aid606_0_0_reason3;
  string2 aid606_0_0_reason4;
  string3 aid606_1_0_score;
  string2 aid606_1_0_reason1;
  string2 aid606_1_0_reason2;
  string2 aid606_1_0_reason3;
  string2 aid606_1_0_reason4;
  string3 aid607_0_0_score;
  string2 aid607_0_0_reason1;
  string2 aid607_0_0_reason2;
  string2 aid607_0_0_reason3;
  string2 aid607_0_0_reason4;
  string3 aid607_1_0_score;
  string2 aid607_1_0_reason1;
  string2 aid607_1_0_reason2;
  string2 aid607_1_0_reason3;
  string2 aid607_1_0_reason4;
  string3 aid607_2_0_score;
  string2 aid607_2_0_reason1;
  string2 aid607_2_0_reason2;
  string2 aid607_2_0_reason3;
  string2 aid607_2_0_reason4;
  string3 ain509_0_0_score;
  string2 ain509_0_0_reason1;
  string2 ain509_0_0_reason2;
  string2 ain509_0_0_reason3;
  string2 ain509_0_0_reason4;
  string3 ain602_1_0_score;
  string2 ain602_1_0_reason1;
  string2 ain602_1_0_reason2;
  string2 ain602_1_0_reason3;
  string2 ain602_1_0_reason4;
  string3 ain605_1_0_score;
  string2 ain605_1_0_reason1;
  string2 ain605_1_0_reason2;
  string2 ain605_1_0_reason3;
  string2 ain605_1_0_reason4;
  string3 ain605_2_0_score;
  string2 ain605_2_0_reason1;
  string2 ain605_2_0_reason2;
  string2 ain605_2_0_reason3;
  string2 ain605_2_0_reason4;
  string3 ain605_3_0_score;
  string2 ain605_3_0_reason1;
  string2 ain605_3_0_reason2;
  string2 ain605_3_0_reason3;
  string2 ain605_3_0_reason4;
  string3 ain801_1_0_score;
  string2 ain801_1_0_reason1;
  string2 ain801_1_0_reason2;
  string2 ain801_1_0_reason3;
  string2 ain801_1_0_reason4;
  string3 anmk909_0_1_score;
  string3 awd605_0_0_score;
  string2 awd605_0_0_reason1;
  string2 awd605_0_0_reason2;
  string2 awd605_0_0_reason3;
  string2 awd605_0_0_reason4;
  string3 awd605_2_0_score;
  string2 awd605_2_0_reason1;
  string2 awd605_2_0_reason2;
  string2 awd605_2_0_reason3;
  string2 awd605_2_0_reason4;
  string3 awd606_10_0_score;
  string2 awd606_10_0_reason1;
  string2 awd606_10_0_reason2;
  string2 awd606_10_0_reason3;
  string2 awd606_10_0_reason4;
  string3 awd606_11_0_score;
  string2 awd606_11_0_reason1;
  string2 awd606_11_0_reason2;
  string2 awd606_11_0_reason3;
  string2 awd606_11_0_reason4;
  string3 awd606_1_0_score;
  string2 awd606_1_0_reason1;
  string2 awd606_1_0_reason2;
  string2 awd606_1_0_reason3;
  string2 awd606_1_0_reason4;
  string3 awd606_2_0_score;
  string2 awd606_2_0_reason1;
  string2 awd606_2_0_reason2;
  string2 awd606_2_0_reason3;
  string2 awd606_2_0_reason4;
  string3 awd606_3_0_score;
  string2 awd606_3_0_reason1;
  string2 awd606_3_0_reason2;
  string2 awd606_3_0_reason3;
  string2 awd606_3_0_reason4;
  string3 awd606_4_0_score;
  string2 awd606_4_0_reason1;
  string2 awd606_4_0_reason2;
  string2 awd606_4_0_reason3;
  string2 awd606_4_0_reason4;
  string3 awd606_6_0_score;
  string2 awd606_6_0_reason1;
  string2 awd606_6_0_reason2;
  string2 awd606_6_0_reason3;
  string2 awd606_6_0_reason4;
  string3 awd606_7_0_score;
  string2 awd606_7_0_reason1;
  string2 awd606_7_0_reason2;
  string2 awd606_7_0_reason3;
  string2 awd606_7_0_reason4;
  string3 awd606_8_0_score;
  string2 awd606_8_0_reason1;
  string2 awd606_8_0_reason2;
  string2 awd606_8_0_reason3;
  string2 awd606_8_0_reason4;
  string3 awd606_9_0_score;
  string2 awd606_9_0_reason1;
  string2 awd606_9_0_reason2;
  string2 awd606_9_0_reason3;
  string2 awd606_9_0_reason4;
  string3 awd710_1_0_score;
  string2 awd710_1_0_reason1;
  string2 awd710_1_0_reason2;
  string2 awd710_1_0_reason3;
  string2 awd710_1_0_reason4;
  string3 awn510_0_0_score;
  string2 awn510_0_0_reason1;
  string2 awn510_0_0_reason2;
  string2 awn510_0_0_reason3;
  string2 awn510_0_0_reason4;
  string3 awn603_1_0_score;
  string2 awn603_1_0_reason1;
  string2 awn603_1_0_reason2;
  string2 awn603_1_0_reason3;
  string2 awn603_1_0_reason4;
  string3 bd3605_0_0_score;
  string2 bd3605_0_0_reason1;
  string2 bd3605_0_0_reason2;
  string2 bd3605_0_0_reason3;
  string2 bd3605_0_0_reason4;
  string3 bd5605_0_0_score;
  string2 bd5605_0_0_reason1;
  string2 bd5605_0_0_reason2;
  string2 bd5605_0_0_reason3;
  string2 bd5605_0_0_reason4;
  string3 bd5605_1_0_score;
  string2 bd5605_1_0_reason1;
  string2 bd5605_1_0_reason2;
  string2 bd5605_1_0_reason3;
  string2 bd5605_1_0_reason4;
  string3 bd5605_2_0_score;
  string2 bd5605_2_0_reason1;
  string2 bd5605_2_0_reason2;
  string2 bd5605_2_0_reason3;
  string2 bd5605_2_0_reason4;
  string3 bd5605_3_0_score;
  string2 bd5605_3_0_reason1;
  string2 bd5605_3_0_reason2;
  string2 bd5605_3_0_reason3;
  string2 bd5605_3_0_reason4;
  string3 bd9605_0_0_score;
  string2 bd9605_0_0_reason1;
  string2 bd9605_0_0_reason2;
  string2 bd9605_0_0_reason3;
  string2 bd9605_0_0_reason4;
  string3 bd9605_1_0_score;
  string2 bd9605_1_0_reason1;
  string2 bd9605_1_0_reason2;
  string2 bd9605_1_0_reason3;
  string2 bd9605_1_0_reason4;
  string3 cdn1109_1_0_score;
  string2 cdn1109_1_0_reason1;
  string2 cdn1109_1_0_reason2;
  string2 cdn1109_1_0_reason3;
  string2 cdn1109_1_0_reason4;
  string3 cdn1205_1_0_score;
  string2 cdn1205_1_0_reason1;
  string2 cdn1205_1_0_reason2;
  string2 cdn1205_1_0_reason3;
  string2 cdn1205_1_0_reason4;
  string3 cdn1305_1_0_score;
  string2 cdn1305_1_0_reason1;
  string2 cdn1305_1_0_reason2;
  string2 cdn1305_1_0_reason3;
  string2 cdn1305_1_0_reason4;
  string3 cdn604_0_0_score;
  string2 cdn604_0_0_reason1;
  string2 cdn604_0_0_reason2;
  string2 cdn604_0_0_reason3;
  string2 cdn604_0_0_reason4;
  string3 cdn604_1_0_score;
  string3 cdn604_2_0_score;
  string2 cdn604_2_0_reason1;
  string2 cdn604_2_0_reason2;
  string2 cdn604_2_0_reason3;
  string2 cdn604_2_0_reason4;
  string3 cdn604_3_0_score;
  string2 cdn604_3_0_reason1;
  string2 cdn604_3_0_reason2;
  string2 cdn604_3_0_reason3;
  string2 cdn604_3_0_reason4;
  string3 cdn604_4_0_score;
  string2 cdn604_4_0_reason1;
  string2 cdn604_4_0_reason2;
  string2 cdn604_4_0_reason3;
  string2 cdn604_4_0_reason4;
  string3 cdn605_1_0_score;
  string2 cdn605_1_0_reason1;
  string2 cdn605_1_0_reason2;
  string2 cdn605_1_0_reason3;
  string2 cdn605_1_0_reason4;
  string3 cdn606_2_0_score;
  string2 cdn606_2_0_reason1;
  string2 cdn606_2_0_reason2;
  string2 cdn606_2_0_reason3;
  string2 cdn606_2_0_reason4;
  string3 cdn706_1_0_score;
  string2 cdn706_1_0_bt_reason1;
  string2 cdn706_1_0_bt_reason2;
  string2 cdn706_1_0_bt_reason3;
  string2 cdn706_1_0_bt_reason4;
  string2 cdn706_1_0_st_reason1;
  string2 cdn706_1_0_st_reason2;
  string2 cdn706_1_0_st_reason3;
  string2 cdn706_1_0_st_reason4;
  string3 cdn707_1_0_score;
  string2 cdn707_1_0_reason1;
  string2 cdn707_1_0_reason2;
  string2 cdn707_1_0_reason3;
  string2 cdn707_1_0_reason4;
  string3 cdn712_0_0_score;
  string2 cdn712_0_0_reason1;
  string2 cdn712_0_0_reason2;
  string2 cdn712_0_0_reason3;
  string2 cdn712_0_0_reason4;
  string3 cdn806_1_0_score;
  string2 cdn806_1_0_reason1;
  string2 cdn806_1_0_reason2;
  string2 cdn806_1_0_reason3;
  string2 cdn806_1_0_reason4;
  string3 cdn908_1_0_score;
  string2 cdn908_1_0_reason1;
  string2 cdn908_1_0_reason2;
  string2 cdn908_1_0_reason3;
  string2 cdn908_1_0_reason4;
  string3 cen509_0_0_score;
  string3 csn1007_0_0_score;
  string3 fd3510_0_0_score;
  string2 fd3510_0_0_reason1;
  string2 fd3510_0_0_reason2;
  string2 fd3510_0_0_reason3;
  string2 fd3510_0_0_reason4;
  string3 fd3606_0_0_score;
  string2 fd3606_0_0_reason1;
  string2 fd3606_0_0_reason2;
  string2 fd3606_0_0_reason3;
  string2 fd3606_0_0_reason4;
  string3 fd5510_0_0_score;
  string2 fd5510_0_0_reason1;
  string2 fd5510_0_0_reason2;
  string2 fd5510_0_0_reason3;
  string2 fd5510_0_0_reason4;
  string3 fd5603_1_0_score;
  string2 fd5603_1_0_reason1;
  string2 fd5603_1_0_reason2;
  string2 fd5603_1_0_reason3;
  string2 fd5603_1_0_reason4;
  string3 fd5603_2_0_score;
  string2 fd5603_2_0_reason1;
  string2 fd5603_2_0_reason2;
  string2 fd5603_2_0_reason3;
  string2 fd5603_2_0_reason4;
  string3 fd5603_3_0_score;
  string2 fd5603_3_0_reason1;
  string2 fd5603_3_0_reason2;
  string2 fd5603_3_0_reason3;
  string2 fd5603_3_0_reason4;
  string3 fd5607_1_0_score;
  string2 fd5607_1_0_reason1;
  string2 fd5607_1_0_reason2;
  string2 fd5607_1_0_reason3;
  string2 fd5607_1_0_reason4;
  string3 fd5609_1_0_score;
  string2 fd5609_1_0_reason1;
  string2 fd5609_1_0_reason2;
  string2 fd5609_1_0_reason3;
  string2 fd5609_1_0_reason4;
  string3 fd5609_2_0_score;
  string2 fd5609_2_0_reason1;
  string2 fd5609_2_0_reason2;
  string2 fd5609_2_0_reason3;
  string2 fd5609_2_0_reason4;
  string3 fd5709_1_0_score;
  string2 fd5709_1_0_reason1;
  string2 fd5709_1_0_reason2;
  string2 fd5709_1_0_reason3;
  string2 fd5709_1_0_reason4;
  string3 fd9510_0_0_score;
  string2 fd9510_0_0_reason1;
  string2 fd9510_0_0_reason2;
  string2 fd9510_0_0_reason3;
  string2 fd9510_0_0_reason4;
  string3 fd9603_1_0_score;
  string2 fd9603_1_0_reason1;
  string2 fd9603_1_0_reason2;
  string2 fd9603_1_0_reason3;
  string2 fd9603_1_0_reason4;
  string3 fd9603_2_0_score;
  string2 fd9603_2_0_reason1;
  string2 fd9603_2_0_reason2;
  string2 fd9603_2_0_reason3;
  string2 fd9603_2_0_reason4;
  string3 fd9603_3_0_score;
  string2 fd9603_3_0_reason1;
  string2 fd9603_3_0_reason2;
  string2 fd9603_3_0_reason3;
  string2 fd9603_3_0_reason4;
  string3 fd9603_4_0_score;
  string2 fd9603_4_0_reason1;
  string2 fd9603_4_0_reason2;
  string2 fd9603_4_0_reason3;
  string2 fd9603_4_0_reason4;
  string3 fd9604_1_0_score;
  string2 fd9604_1_0_reason1;
  string2 fd9604_1_0_reason2;
  string2 fd9604_1_0_reason3;
  string2 fd9604_1_0_reason4;
  string3 fd9606_0_0_score;
  string2 fd9606_0_0_reason1;
  string2 fd9606_0_0_reason2;
  string2 fd9606_0_0_reason3;
  string2 fd9606_0_0_reason4;
  string3 fd9607_1_0_score;
  string2 fd9607_1_0_reason1;
  string2 fd9607_1_0_reason2;
  string2 fd9607_1_0_reason3;
  string2 fd9607_1_0_reason4;
  string3 fp1109_0_0_score;
  string2 fp1109_0_0_reason1;
  string2 fp1109_0_0_reason2;
  string2 fp1109_0_0_reason3;
  string2 fp1109_0_0_reason4;
  string3 fp1210_1_0_score;
  string3 fp1303_1_0_score;
  string2 fp1303_1_0_reason1;
  string2 fp1303_1_0_reason2;
  string2 fp1303_1_0_reason3;
  string2 fp1303_1_0_reason4;
  string3 fp1401_1_0_score;
  string2 fp1401_1_0_reason1;
  string2 fp1401_1_0_reason2;
  string2 fp1401_1_0_reason3;
  string2 fp1401_1_0_reason4;
  string2 fp1401_1_0_reason5;
  string2 fp1401_1_0_reason6;
  string3 fp1310_1_0_score;
  string2 fp1310_1_0_reason1;
  string2 fp1310_1_0_reason2;
  string2 fp1310_1_0_reason3;
  string2 fp1310_1_0_reason4;
  string2 fp1310_1_0_reason5;
  string2 fp1310_1_0_reason6;
  string3 fp1307_1_0_score;
  string2 fp1307_1_0_reason1;
  string2 fp1307_1_0_reason2;
  string2 fp1307_1_0_reason3;
  string2 fp1307_1_0_reason4;
  string2 fp1307_1_0_reason5;
  string2 fp1307_1_0_reason6;
  string3 fp1303_2_0_score;
  string3 fp31105_1_0_score;
  string2 fp31105_1_0_reason1;
  string2 fp31105_1_0_reason2;
  string2 fp31105_1_0_reason3;
  string2 fp31105_1_0_reason4;
  string3 fp31203_1_0_score;
  string2 fp31203_1_0_reason1;
  string2 fp31203_1_0_reason2;
  string2 fp31203_1_0_reason3;
  string2 fp31203_1_0_reason4;
  string3 fp31310_2_0_score;
  string2 fp31310_2_0_reason1;
  string2 fp31310_2_0_reason2;
  string2 fp31310_2_0_reason3;
  string2 fp31310_2_0_reason4;
  string2 fp31310_2_0_reason5;
  string2 fp31310_2_0_reason6;
  string3 fp3710_0_0_score;
  string2 fp3710_0_0_reason1;
  string2 fp3710_0_0_reason2;
  string2 fp3710_0_0_reason3;
  string2 fp3710_0_0_reason4;
  string3 fp3904_1_0_score;
  string2 fp3904_1_0_reason1;
  string2 fp3904_1_0_reason2;
  string2 fp3904_1_0_reason3;
  string2 fp3904_1_0_reason4;
  string3 fp3905_1_0_score;
  string2 fp3905_1_0_reason1;
  string2 fp3905_1_0_reason2;
  string2 fp3905_1_0_reason3;
  string2 fp3905_1_0_reason4;
  string3 fp5812_1_0_score;
  string2 fp5812_1_0_reason1;
  string2 fp5812_1_0_reason2;
  string2 fp5812_1_0_reason3;
  string2 fp5812_1_0_reason4;
  string3 hcp1206_0_0_score;
  string2 hcp1206_0_0_reason1;
  string2 hcp1206_0_0_reason2;
  string2 hcp1206_0_0_reason3;
  string2 hcp1206_0_0_reason4;
  string3 idn605_1_0_score;
  string2 idn605_1_0_reason1;
  string2 idn605_1_0_reason2;
  string2 idn605_1_0_reason3;
  string2 idn605_1_0_reason4;
  unsigned8 ie912_0_0_score;
  string2 ie912_0_0_reason1;
  string2 ie912_0_0_reason2;
  string2 ie912_0_0_reason3;
  string2 ie912_0_0_reason4;
  string3 ie912_1_0_score;
  string2 ie912_1_0_reason1;
  string2 ie912_1_0_reason2;
  string2 ie912_1_0_reason3;
  string2 ie912_1_0_reason4;
  string3 ied1106_1_0_score;
  unsigned3 ien1006_0_1_score;
  real8 mnc21106_0_0_score;
  real8 mpx1211_0_0_score;
  unsigned3 msd1010_0_0_score;
  string3 msn1106_0_0_score;
  string2 msn1106_0_0_reason1;
  string2 msn1106_0_0_reason2;
  string2 msn1106_0_0_reason3;
  string2 msn1106_0_0_reason4;
  string3 msn605_1_0_score;
  string3 msn610_0_0_score;
  real8 mv361006_0_0_score;
  real8 mv361006_1_0_score;
  unsigned3 mx361006_0_0_score;
  real8 mx361006_1_0_score;
  string3 rsb801_1_0_score;
  string3 rsn1001_1_0_score;
  string3 rsn1009_1_0_score;
  string3 rsn1010_1_0_score;
  string3 rsn1103_1_0_score;
  string3 rsn1105_1_0_score;
  string3 rsn1105_2_0_score;
  string3 rsn1105_3_0_score;
  string3 rsn1108_1_0_score;
  string3 rsn1108_2_0_score;
  string3 rsn1108_3_0_score;
  string3 rsn508_1_0_score;
  string3 rsn509_1_0_score;
  string3 rsn509_2_0_score;
  string3 rsn604_2_0_score;
  string3 rsn607_0_0_score;
  string3 rsn607_1_0_score;
  string3 rsn702_1_0_score;
  string3 rsn704_0_0_score;
  string3 rsn704_1_0_score;
  string3 rsn802_1_0_score;
  string3 rsn803_1_0_score;
  string3 rsn803_2_0_score;
  string3 rsn804_1_0_score;
  string3 rsn807_0_0_score;
  string3 rsn810_1_0_score;
  string3 rsn912_1_0_score;
  string3 rva1003_0_0_score;
  string2 rva1003_0_0_reason1;
  string2 rva1003_0_0_reason2;
  string2 rva1003_0_0_reason3;
  string2 rva1003_0_0_reason4;
  string3 rva1007_1_0_score;
  string2 rva1007_1_0_reason1;
  string2 rva1007_1_0_reason2;
  string2 rva1007_1_0_reason3;
  string2 rva1007_1_0_reason4;
  string3 rva1007_2_0_score;
  string2 rva1007_2_0_reason1;
  string2 rva1007_2_0_reason2;
  string2 rva1007_2_0_reason3;
  string2 rva1007_2_0_reason4;
  string3 rva1007_3_0_score;
  string2 rva1007_3_0_reason1;
  string2 rva1007_3_0_reason2;
  string2 rva1007_3_0_reason3;
  string2 rva1007_3_0_reason4;
  string3 rva1008_1_0_score;
  string2 rva1008_1_0_reason1;
  string2 rva1008_1_0_reason2;
  string2 rva1008_1_0_reason3;
  string2 rva1008_1_0_reason4;
  string3 rva1008_2_0_score;
  string2 rva1008_2_0_reason1;
  string2 rva1008_2_0_reason2;
  string2 rva1008_2_0_reason3;
  string2 rva1008_2_0_reason4;
  string3 rva1104_0_0_score;
  string2 rva1104_0_0_reason1;
  string2 rva1104_0_0_reason2;
  string2 rva1104_0_0_reason3;
  string2 rva1104_0_0_reason4;
  string3 rva1304_1_0_score;
  string2 rva1304_1_0_reason1;
  string2 rva1304_1_0_reason2;
  string2 rva1304_1_0_reason3;
  string2 rva1304_1_0_reason4;
  string3 rva1304_2_0_score;
  string2 rva1304_2_0_reason1;
  string2 rva1304_2_0_reason2;
  string2 rva1304_2_0_reason3;
  string2 rva1304_2_0_reason4;
  string3 rva1305_1_0_score;
  string2 rva1305_1_0_reason1;
  string2 rva1305_1_0_reason2;
  string2 rva1305_1_0_reason3;
  string2 rva1305_1_0_reason4;
  string3 rva1306_1_0_score;
  string2 rva1306_1_0_reason1;
  string2 rva1306_1_0_reason2;
  string2 rva1306_1_0_reason3;
  string2 rva1306_1_0_reason4;
  string3 rva1309_1_0_score;
  string2 rva1309_1_0_reason1;
  string2 rva1309_1_0_reason2;
  string2 rva1309_1_0_reason3;
  string2 rva1309_1_0_reason4;
  string3 rva1310_1_0_score;
  string2 rva1310_1_0_reason1;
  string2 rva1310_1_0_reason2;
  string2 rva1310_1_0_reason3;
  string2 rva1310_1_0_reason4;
  string3 rva1310_2_0_score;
  string2 rva1310_2_0_reason1;
  string2 rva1310_2_0_reason2;
  string2 rva1310_2_0_reason3;
  string2 rva1310_2_0_reason4;
  string3 rva1310_3_0_score;
  string2 rva1310_3_0_reason1;
  string2 rva1310_3_0_reason2;
  string2 rva1310_3_0_reason3;
  string2 rva1310_3_0_reason4;
  string3 rva1311_1_0_score;
  string2 rva1311_1_0_reason1;
  string2 rva1311_1_0_reason2;
  string2 rva1311_1_0_reason3;
  string2 rva1311_1_0_reason4;
  string3 rva1311_2_0_score;
  string2 rva1311_2_0_reason1;
  string2 rva1311_2_0_reason2;
  string2 rva1311_2_0_reason3;
  string2 rva1311_2_0_reason4;
  string3 rva1311_3_0_score;
  string2 rva1311_3_0_reason1;
  string2 rva1311_3_0_reason2;
  string2 rva1311_3_0_reason3;
  string2 rva1311_3_0_reason4;
  string3 rva611_0_0_score;
  string2 rva611_0_0_reason1;
  string2 rva611_0_0_reason2;
  string2 rva611_0_0_reason3;
  string2 rva611_0_0_reason4;
  string3 rva707_0_0_score;
  string2 rva707_0_0_reason1;
  string2 rva707_0_0_reason2;
  string2 rva707_0_0_reason3;
  string2 rva707_0_0_reason4;
  string3 rva707_1_0_score;
  string2 rva707_1_0_reason1;
  string2 rva707_1_0_reason2;
  string2 rva707_1_0_reason3;
  string2 rva707_1_0_reason4;
  string3 rva709_1_0_score;
  string2 rva709_1_0_reason1;
  string2 rva709_1_0_reason2;
  string2 rva709_1_0_reason3;
  string2 rva709_1_0_reason4;
  string3 rva711_0_0_score;
  string2 rva711_0_0_reason1;
  string2 rva711_0_0_reason2;
  string2 rva711_0_0_reason3;
  string2 rva711_0_0_reason4;
  string3 rvb1003_0_0_score;
  string2 rvb1003_0_0_reason1;
  string2 rvb1003_0_0_reason2;
  string2 rvb1003_0_0_reason3;
  string2 rvb1003_0_0_reason4;
  string3 rvb1104_0_0_score;
  string2 rvb1104_0_0_reason1;
  string2 rvb1104_0_0_reason2;
  string2 rvb1104_0_0_reason3;
  string2 rvb1104_0_0_reason4;
  string3 rvb609_0_0_score;
  string2 rvb609_0_0_reason1;
  string2 rvb609_0_0_reason2;
  string2 rvb609_0_0_reason3;
  string2 rvb609_0_0_reason4;
  string3 rvb703_1_0_score;
  string2 rvb703_1_0_reason1;
  string2 rvb703_1_0_reason2;
  string2 rvb703_1_0_reason3;
  string2 rvb703_1_0_reason4;
  string3 rvb705_1_0_score;
  string2 rvb705_1_0_reason1;
  string2 rvb705_1_0_reason2;
  string2 rvb705_1_0_reason3;
  string2 rvb705_1_0_reason4;
  string3 rvb711_0_0_score;
  string2 rvb711_0_0_reason1;
  string2 rvb711_0_0_reason2;
  string2 rvb711_0_0_reason3;
  string2 rvb711_0_0_reason4;
  string3 rvc1110_1_0_score;
  string2 rvc1110_1_0_reason1;
  string2 rvc1110_1_0_reason2;
  string2 rvc1110_1_0_reason3;
  string2 rvc1110_1_0_reason4;
  string3 rvc1110_2_0_score;
  string2 rvc1110_2_0_reason1;
  string2 rvc1110_2_0_reason2;
  string2 rvc1110_2_0_reason3;
  string2 rvc1110_2_0_reason4;
  string3 rvc1112_0_0_score;
  string2 rvc1112_0_0_reason1;
  string2 rvc1112_0_0_reason2;
  string2 rvc1112_0_0_reason3;
  string2 rvc1112_0_0_reason4;
  string3 rvc1208_1_0_score;
  string2 rvc1208_1_0_reason1;
  string2 rvc1208_1_0_reason2;
  string2 rvc1208_1_0_reason3;
  string2 rvc1208_1_0_reason4;
  string3 rvc1210_1_0_score;
  string2 rvc1210_1_0_reason1;
  string2 rvc1210_1_0_reason2;
  string2 rvc1210_1_0_reason3;
  string2 rvc1210_1_0_reason4;
  string3 rvc1301_1_0_score;
  string2 rvc1301_1_0_reason1;
  string2 rvc1301_1_0_reason2;
  string2 rvc1301_1_0_reason3;
  string2 rvc1301_1_0_reason4;
  string3 rvc1307_1_0_score;
  string2 rvc1307_1_0_reason1;
  string2 rvc1307_1_0_reason2;
  string2 rvc1307_1_0_reason3;
  string2 rvc1307_1_0_reason4;
  string3 rvd1010_0_0_score;
  string2 rvd1010_0_0_reason1;
  string2 rvd1010_0_0_reason2;
  string2 rvd1010_0_0_reason3;
  string2 rvd1010_0_0_reason4;
  string3 rvd1010_1_0_score;
  string2 rvd1010_1_0_reason1;
  string2 rvd1010_1_0_reason2;
  string2 rvd1010_1_0_reason3;
  string2 rvd1010_1_0_reason4;
  string3 rvd1010_2_0_score;
  string2 rvd1010_2_0_reason1;
  string2 rvd1010_2_0_reason2;
  string2 rvd1010_2_0_reason3;
  string2 rvd1010_2_0_reason4;
  string3 rvd1110_1_0_score;
  string2 rvd1110_1_0_reason1;
  string2 rvd1110_1_0_reason2;
  string2 rvd1110_1_0_reason3;
  string2 rvd1110_1_0_reason4;
  string3 rvg1003_0_0_score;
  string2 rvg1003_0_0_reason1;
  string2 rvg1003_0_0_reason2;
  string2 rvg1003_0_0_reason3;
  string2 rvg1003_0_0_reason4;
  string3 rvg1103_0_0_score;
  string2 rvg1103_0_0_reason1;
  string2 rvg1103_0_0_reason2;
  string2 rvg1103_0_0_reason3;
  string2 rvg1103_0_0_reason4;
  string3 rvg1106_1_0_score;
  string2 rvg1106_1_0_reason1;
  string2 rvg1106_1_0_reason2;
  string2 rvg1106_1_0_reason3;
  string2 rvg1106_1_0_reason4;
  string3 rvg1201_1_0_score;
  string2 rvg1201_1_0_reason1;
  string2 rvg1201_1_0_reason2;
  string2 rvg1201_1_0_reason3;
  string2 rvg1201_1_0_reason4;
  string3 rvg1302_1_0_score;
  string2 rvg1302_1_0_reason1;
  string2 rvg1302_1_0_reason2;
  string2 rvg1302_1_0_reason3;
  string2 rvg1302_1_0_reason4;
  string3 rvg1304_1_0_score;
  string2 rvg1304_1_0_reason1;
  string2 rvg1304_1_0_reason2;
  string2 rvg1304_1_0_reason3;
  string2 rvg1304_1_0_reason4;
  string3 rvg1304_2_0_score;
  string2 rvg1304_2_0_reason1;
  string2 rvg1304_2_0_reason2;
  string2 rvg1304_2_0_reason3;
  string2 rvg1304_2_0_reason4;
  string3 rvg1401_1_0_score;
  string2 rvg1401_1_0_reason1;
  string2 rvg1401_1_0_reason2;
  string2 rvg1401_1_0_reason3;
  string2 rvg1401_1_0_reason4;
  string3 rvg1401_2_0_score;
  string2 rvg1401_2_0_reason1;
  string2 rvg1401_2_0_reason2;
  string2 rvg1401_2_0_reason3;
  string2 rvg1401_2_0_reason4;
  string3 rvg812_0_0_score;
  string2 rvg812_0_0_reason1;
  string2 rvg812_0_0_reason2;
  string2 rvg812_0_0_reason3;
  string2 rvg812_0_0_reason4;
  string3 rvg903_1_0_score;
  string3 rvg904_1_0_score;
  string2 rvg904_1_0_reason1;
  string2 rvg904_1_0_reason2;
  string2 rvg904_1_0_reason3;
  string2 rvg904_1_0_reason4;
  string3 rvp1003_0_0_score;
  string2 rvp1003_0_0_reason1;
  string3 rvp1012_1_0_score;
  string2 rvp1012_1_0_reason1;
  string3 rvp1104_0_0_score;
  string2 rvp1104_0_0_reason1;
  string3 rvp1208_1_0_score;
  string2 rvp1208_1_0_reason1;
  string3 rvp1401_1_0_score;
  string2 rvp1401_1_0_reason1;
  string3 rvp1401_2_0_score;
  string2 rvp1401_2_0_reason1;
  string3 rvp804_0_0_score;
  string2 rvp804_0_0_reason1;
  string3 rvr1003_0_0_score;
  string2 rvr1003_0_0_reason1;
  string2 rvr1003_0_0_reason2;
  string2 rvr1003_0_0_reason3;
  string2 rvr1003_0_0_reason4;
  string3 rvr1008_1_0_score;
  string2 rvr1008_1_0_reason1;
  string2 rvr1008_1_0_reason2;
  string2 rvr1008_1_0_reason3;
  string2 rvr1008_1_0_reason4;
  string3 rvr1103_0_0_score;
  string2 rvr1103_0_0_reason1;
  string2 rvr1103_0_0_reason2;
  string2 rvr1103_0_0_reason3;
  string2 rvr1103_0_0_reason4;
  string3 rvr1104_2_0_score;
  string2 rvr1104_2_0_reason1;
  string2 rvr1104_2_0_reason2;
  string2 rvr1104_2_0_reason3;
  string2 rvr1104_2_0_reason4;
  string3 rvr1210_1_0_score;
  string2 rvr1210_1_0_reason1;
  string2 rvr1210_1_0_reason2;
  string2 rvr1210_1_0_reason3;
  string2 rvr1210_1_0_reason4;
  string3 rvr1303_1_0_score;
  string2 rvr1303_1_0_reason1;
  string2 rvr1303_1_0_reason2;
  string2 rvr1303_1_0_reason3;
  string2 rvr1303_1_0_reason4;
  string3 rvr1311_1_0_score;
  string2 rvr1311_1_0_reason1;
  string2 rvr1311_1_0_reason2;
  string2 rvr1311_1_0_reason3;
  string2 rvr1311_1_0_reason4;
  string3 rvr611_0_0_score;
  string2 rvr611_0_0_reason1;
  string2 rvr611_0_0_reason2;
  string2 rvr611_0_0_reason3;
  string2 rvr611_0_0_reason4;
  string3 rvr704_1_0_score;
  string2 rvr704_1_0_reason1;
  string2 rvr704_1_0_reason2;
  string2 rvr704_1_0_reason3;
  string2 rvr704_1_0_reason4;
  string3 rvr711_0_0_score;
  string2 rvr711_0_0_reason1;
  string2 rvr711_0_0_reason2;
  string2 rvr711_0_0_reason3;
  string2 rvr711_0_0_reason4;
  string3 rvr803_1_0_score;
  string2 rvr803_1_0_reason1;
  string2 rvr803_1_0_reason2;
  string2 rvr803_1_0_reason3;
  string2 rvr803_1_0_reason4;
  string3 rvs811_0_0_score;
  string2 rvs811_0_0_reason1;
  string2 rvs811_0_0_reason2;
  string2 rvs811_0_0_reason3;
  string2 rvs811_0_0_reason4;
  string3 rvt1003_0_0_score;
  string2 rvt1003_0_0_reason1;
  string2 rvt1003_0_0_reason2;
  string2 rvt1003_0_0_reason3;
  string2 rvt1003_0_0_reason4;
  string3 rvt1006_1_0_score;
  string2 rvt1006_1_0_reason1;
  string2 rvt1006_1_0_reason2;
  string2 rvt1006_1_0_reason3;
  string2 rvt1006_1_0_reason4;
  string3 rvt1104_0_0_score;
  string2 rvt1104_0_0_reason1;
  string2 rvt1104_0_0_reason2;
  string2 rvt1104_0_0_reason3;
  string2 rvt1104_0_0_reason4;
  string3 rvt1104_1_0_score;
  string2 rvt1104_1_0_reason1;
  string2 rvt1104_1_0_reason2;
  string2 rvt1104_1_0_reason3;
  string2 rvt1104_1_0_reason4;
  string3 rvt1204_1_score;
  string2 rvt1204_1_reason1;
  string2 rvt1204_1_reason2;
  string2 rvt1204_1_reason3;
  string2 rvt1204_1_reason4;
  string3 rvt1210_1_0_score;
  string2 rvt1210_1_0_reason1;
  string2 rvt1210_1_0_reason2;
  string2 rvt1210_1_0_reason3;
  string2 rvt1210_1_0_reason4;
  string3 rvt1212_1_0_score;
  string2 rvt1212_1_0_reason1;
  string2 rvt1212_1_0_reason2;
  string2 rvt1212_1_0_reason3;
  string2 rvt1212_1_0_reason4;
  string3 rvt612_0_score;
  string2 rvt612_0_reason1;
  string2 rvt612_0_reason2;
  string2 rvt612_0_reason3;
  string2 rvt612_0_reason4;
  string3 rvt1307_3_0_score;
  string2 rvt1307_3_0_reason1;
  string2 rvt1307_3_0_reason2;
  string2 rvt1307_3_0_reason3;
  string2 rvt1307_3_0_reason4;
  string3 rvt1402_1_0_score;
  string2 rvt1402_1_0_reason1;
  string2 rvt1402_1_0_reason2;
  string2 rvt1402_1_0_reason3;
  string2 rvt1402_1_0_reason4;
  string3 rvt711_0_0_score;
  string2 rvt711_0_0_reason1;
  string2 rvt711_0_0_reason2;
  string2 rvt711_0_0_reason3;
  string2 rvt711_0_0_reason4;
  string3 rvt711_1_0_score;
  string2 rvt711_1_0_reason1;
  string2 rvt711_1_0_reason2;
  string2 rvt711_1_0_reason3;
  string2 rvt711_1_0_reason4;
  string3 rvt803_1_0_score;
  string2 rvt803_1_0_reason1;
  string2 rvt803_1_0_reason2;
  string2 rvt803_1_0_reason3;
  string2 rvt803_1_0_reason4;
  string3 rvt809_1_0_score;
  string2 rvt809_1_0_reason1;
  string2 rvt809_1_0_reason2;
  string2 rvt809_1_0_reason3;
  string2 rvt809_1_0_reason4;
  string3 tbd605_0_0_score;
  string2 tbd605_0_0_reason1;
  string2 tbd605_0_0_reason2;
  string2 tbd605_0_0_reason3;
  string2 tbd605_0_0_reason4;
  string3 tbd609_1_0_score;
  string2 tbd609_1_0_reason1;
  string2 tbd609_1_0_reason2;
  string2 tbd609_1_0_reason3;
  string2 tbd609_1_0_reason4;
  string3 tbd609_2_0_score;
  string2 tbd609_2_0_reason1;
  string2 tbd609_2_0_reason2;
  string2 tbd609_2_0_reason3;
  string2 tbd609_2_0_reason4;
  string3 tbn509_0_0_score;
  string2 tbn509_0_0_reason1;
  string2 tbn509_0_0_reason2;
  string2 tbn509_0_0_reason3;
  string2 tbn509_0_0_reason4;
  string3 tbn604_1_0_score;
  string2 tbn604_1_0_reason1;
  string2 tbn604_1_0_reason2;
  string2 tbn604_1_0_reason3;
  string2 tbn604_1_0_reason4;
  string3 trd605_0_0_score;
  string2 trd605_0_0_reason1;
  string2 trd605_0_0_reason2;
  string2 trd605_0_0_reason3;
  string2 trd605_0_0_reason4;
  string3 trd609_1_0_score;
  string2 trd609_1_0_reason1;
  string2 trd609_1_0_reason2;
  string2 trd609_1_0_reason3;
  string2 trd609_1_0_reason4;
  unsigned3 win704_0_0_score;
  real8 womv002_0_0_score;
  string3 wwn604_1_0_score;
  string2 wwn604_1_0_reason1;
  string2 wwn604_1_0_reason2;
  string2 wwn604_1_0_reason3;
  string2 wwn604_1_0_reason4;
  string errorcode;
 END;
	
slim_lay := RECORD
		unsigned8 seq;
		unsigned8 did;
		string2 nap;
		string2 nas;
		string2 cvi_score;
		string3 BestBuy_cdn1109;
		string3 LeadIntegrity_v4;
		string3 RegionalAcceptance_rva1008;
		string3 Santander_1304_1;
		string3 Santander_1304_2;
		string3 Tmobile_rvt1210;
		string3 Tmobile_rvt1212;
END;

slim_lay slim_trans(input_lay le) := TRANSFORM
		SELF.BestBuy_cdn1109 := le.cdn1109_1_0_score;
		SELF.LeadIntegrity_v4 := le.msn1106_0_0_score;
		SELF.RegionalAcceptance_rva1008 := le.rva1008_1_0_score;
		SELF.Santander_1304_1 := le.rva1304_1_0_score;
		SELF.Santander_1304_2 := le.rva1304_2_0_score;
		SELF.Tmobile_rvt1210 := le.rvt1210_1_0_score;
		SELF.Tmobile_rvt1212 := le.rvt1212_1_0_score;
		SELF := le;
END;


// ds_baseline := dataset(basefilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1)));
ds_baseline := PROJECT(dataset(basefilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1))), slim_trans(LEFT));
// ds_new := dataset(testfilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1)));
ds_new := PROJECT(dataset(testfilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1))), slim_trans(LEFT));
   
output(choosen(ds_baseline, eyeball), NAMED('ds_baseline'));
output(choosen(ds_new, eyeball), NAMED('ds_new'));
output(COUNT(ds_baseline), NAMED('slim_baseline_count'));
output(COUNT(ds_new), NAMED('slim_new_count'));


// Macro to compile statistics for Nick's report

Stats_func(ds1, ds2, at_name) := FUNCTIONMACRO
	
	INTEGER full_count1 := COUNT(ds1);
	INTEGER mid_count1 := full_count1 / 2;
	sorted_ds1 := SORT(ds1, -#expand(at_name));
	medn1 := sorted_ds1[mid_count1];
	
	REAL temp_mean1 := table(ds1, {temp_mean := AVE(group, (real)ds1.#expand(at_name))} )[1].temp_mean;
	STRING temp_median1 := medn1.#expand(at_name);
	REAL temp_std_dev1 := SQRT( VARIANCE(ds1, (REAL) #expand(at_name)));
	
	INTEGER full_count2 := COUNT(ds2);
	INTEGER mid_count2 := full_count2 / 2;
	sorted_ds2 := SORT(ds2, -#expand(at_name));
	medn2 := sorted_ds2[mid_count2];

	REAL temp_mean2 := table(ds2, {temp_mean := AVE(group, (real)ds2.#expand(at_name))} )[1].temp_mean;
	STRING temp_median2 := medn2.#expand(at_name);
	REAL temp_std_dev2 := SQRT( VARIANCE(ds2, (REAL) #expand(at_name)));	
	
	INTEGER first_count := COUNT(ds1);
	INTEGER second_count := COUNT(ds2);

	j1 := JOIN(ds1, ds2,
						LEFT.seq = RIGHT.seq
				AND LEFT.#expand(at_name) <> RIGHT.#expand(at_name),
				TRANSFORM(slim_lay, SELF := LEFT; SELF := []));

	diff_count := COUNT(j1);	
	
	stats_layout := record
		STRING name;
		REAL mean1;
		STRING median1;
		REAL std_dev1;
		STRING X;
		REAL mean2;
		STRING median2;
		REAL std_dev2;
		STRING XX;
		REAL diff_mean;
		INTEGER diff_median;
		REAL diff_std_dev;
		STRING XXX;
		INTEGER full_count_1;
		INTEGER full_count_2;
		INTEGER diff_count;
		REAL diff_percent;
	END;

	stats_layout add_stats(ut.ds_oneRecord le) := transform
		self.name := at_name;
		self.mean1 := temp_mean1;
		self.median1 := temp_median1;
		self.std_dev1 := temp_std_dev1;
		self.X := '';
		self.mean2 := temp_mean2;
		self.median2 := temp_median2;
		self.std_dev2 := temp_std_dev2;
		self.XX := '';
		self.diff_mean := temp_mean2 - temp_mean1;
		self.diff_median := (INTEGER)temp_median2 - (INTEGER)temp_median1;
		self.diff_std_dev := temp_std_dev2 - temp_std_dev1;
		self.XXX := '';
		self.full_count_1 := first_count;
		self.full_count_2 := second_count;
		self.diff_count := diff_count;
		self.diff_percent := diff_count / first_count;		
	END;
	
	dset := project(ut.ds_oneRecord, add_stats(left));

	return dset;
endmacro;

// ****** COMPILE STATS RECORDSET *******
results :=
		Stats_func(ds_baseline, ds_new, 'nap') +
		Stats_func(ds_baseline, ds_new, 'nas') +
		Stats_func(ds_baseline, ds_new, 'cvi_score') +
		Stats_func(ds_baseline, ds_new, 'BestBuy_cdn1109') +
		Stats_func(ds_baseline, ds_new, 'LeadIntegrity_v4') +
		Stats_func(ds_baseline, ds_new, 'RegionalAcceptance_rva1008') +
		Stats_func(ds_baseline, ds_new, 'Santander_1304_1') +
		Stats_func(ds_baseline, ds_new, 'Santander_1304_2') +
		Stats_func(ds_baseline, ds_new, 'Tmobile_rvt1210') +
		Stats_func(ds_baseline, ds_new, 'Tmobile_rvt1212');

OUTPUT(results, NAMED('Runway_stats'));
// OUTPUT(results,,'~nkoubsky::out::runwayoutput_' + thorlib.wuid(), CSV(HEADING(SINGLE), QUOTE('"')) );
