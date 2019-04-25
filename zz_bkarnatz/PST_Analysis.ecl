Import std;

Input_Data_Layout := RECORD
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
  string3 cdn1404_1_0_score;
  string2 cdn1404_1_0_reason1;
  string2 cdn1404_1_0_reason2;
  string2 cdn1404_1_0_reason3;
  string2 cdn1404_1_0_reason4;
  string3 cdn1410_1_0_score;
  string2 cdn1410_1_0_reason1;
  string2 cdn1410_1_0_reason2;
  string2 cdn1410_1_0_reason3;
  string2 cdn1410_1_0_reason4;
  string3 cdn1506_1_0_score;
  string2 cdn1506_1_0_reason1;
  string2 cdn1506_1_0_reason2;
  string2 cdn1506_1_0_reason3;
  string2 cdn1506_1_0_reason4;
  string3 cdn1508_1_0_score;
  string2 cdn1508_1_0_reason1;
  string2 cdn1508_1_0_reason2;
  string2 cdn1508_1_0_reason3;
  string2 cdn1508_1_0_reason4;
  string2 cdn1508_1_0_reason5;
  string2 cdn1508_1_0_reason6;
  string3 osn1504_0_0_score;
  string2 osn1504_0_0_reason1;
  string2 osn1504_0_0_reason2;
  string2 osn1504_0_0_reason3;
  string2 osn1504_0_0_reason4;
  string2 osn1504_0_0_reason5;
  string2 osn1504_0_0_reason6;
  string3 osn1608_1_0_score;
  string2 osn1608_1_0_reason1;
  string2 osn1608_1_0_reason2;
  string2 osn1608_1_0_reason3;
  string2 osn1608_1_0_reason4;
  string2 osn1608_1_0_reason5;
  string2 osn1608_1_0_reason6;
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
  string3 fp1403_1_0_score;
  string3 fp1409_2_0_score;
  string3 fp1403_2_0_score;
  string2 fp1403_2_0_reason1;
  string2 fp1403_2_0_reason2;
  string2 fp1403_2_0_reason3;
  string2 fp1403_2_0_reason4;
  string2 fp1403_2_0_reason5;
  string2 fp1403_2_0_reason6;
  string3 fp1404_1_0_score;
  string2 fp1404_1_0_reason1;
  string2 fp1404_1_0_reason2;
  string2 fp1404_1_0_reason3;
  string2 fp1404_1_0_reason4;
  string2 fp1404_1_0_reason5;
  string2 fp1404_1_0_reason6;
  string3 fp1407_1_0_score;
  string2 fp1407_1_0_reason1;
  string2 fp1407_1_0_reason2;
  string2 fp1407_1_0_reason3;
  string2 fp1407_1_0_reason4;
  string2 fp1407_1_0_reason5;
  string2 fp1407_1_0_reason6;
  string3 fp1407_2_0_score;
  string2 fp1407_2_0_reason1;
  string2 fp1407_2_0_reason2;
  string2 fp1407_2_0_reason3;
  string2 fp1407_2_0_reason4;
  string2 fp1407_2_0_reason5;
  string2 fp1407_2_0_reason6;
  string3 fp1406_1_0_score;
  string2 fp1406_1_0_reason1;
  string2 fp1406_1_0_reason2;
  string2 fp1406_1_0_reason3;
  string2 fp1406_1_0_reason4;
  string2 fp1406_1_0_reason5;
  string2 fp1406_1_0_reason6;
  string3 fp1506_1_0_score;
  string2 fp1506_1_0_reason1;
  string2 fp1506_1_0_reason2;
  string2 fp1506_1_0_reason3;
  string2 fp1506_1_0_reason4;
  string2 fp1506_1_0_reason5;
  string2 fp1506_1_0_reason6;
  string3 fp1509_1_0_score;
  string2 fp1509_1_0_reason1;
  string2 fp1509_1_0_reason2;
  string2 fp1509_1_0_reason3;
  string2 fp1509_1_0_reason4;
  string2 fp1509_1_0_reason5;
  string2 fp1509_1_0_reason6;
  string3 fp1509_2_0_score;
  string2 fp1509_2_0_reason1;
  string2 fp1509_2_0_reason2;
  string2 fp1509_2_0_reason3;
  string2 fp1509_2_0_reason4;
  string2 fp1509_2_0_reason5;
  string2 fp1509_2_0_reason6;
  string3 fp1510_2_0_score;
  string2 fp1510_2_0_reason1;
  string2 fp1510_2_0_reason2;
  string2 fp1510_2_0_reason3;
  string2 fp1510_2_0_reason4;
  string2 fp1510_2_0_reason5;
  string2 fp1510_2_0_reason6;
  string3 fp1511_1_0_score;
  string2 fp1511_1_0_reason1;
  string2 fp1511_1_0_reason2;
  string2 fp1511_1_0_reason3;
  string2 fp1511_1_0_reason4;
  string2 fp1511_1_0_reason5;
  string2 fp1511_1_0_reason6;
  string3 fp1512_1_0_score;
  string2 fp1512_1_0_reason1;
  string2 fp1512_1_0_reason2;
  string2 fp1512_1_0_reason3;
  string2 fp1512_1_0_reason4;
  string2 fp1512_1_0_reason5;
  string2 fp1512_1_0_reason6;
  string3 fp1609_1_0_score;
  string2 fp1609_1_0_reason1;
  string2 fp1609_1_0_reason2;
  string2 fp1609_1_0_reason3;
  string2 fp1609_1_0_reason4;
  string2 fp1609_1_0_reason5;
  string2 fp1609_1_0_reason6;
  string3 fp1606_1_0_score;
  string2 fp1606_1_0_reason1;
  string2 fp1606_1_0_reason2;
  string2 fp1606_1_0_reason3;
  string2 fp1606_1_0_reason4;
  string2 fp1606_1_0_reason5;
  string2 fp1606_1_0_reason6;
  string3 fp1610_1_0_score;
  string2 fp1610_1_0_reason1;
  string2 fp1610_1_0_reason2;
  string2 fp1610_1_0_reason3;
  string2 fp1610_1_0_reason4;
  string2 fp1610_1_0_reason5;
  string2 fp1610_1_0_reason6;
  string3 fp1610_2_0_score;
  string2 fp1610_2_0_reason1;
  string2 fp1610_2_0_reason2;
  string2 fp1610_2_0_reason3;
  string2 fp1610_2_0_reason4;
  string2 fp1610_2_0_reason5;
  string2 fp1610_2_0_reason6;
  string3 fp1611_1_0_score;
  string2 fp1611_1_0_reason1;
  string2 fp1611_1_0_reason2;
  string2 fp1611_1_0_reason3;
  string2 fp1611_1_0_reason4;
  string2 fp1611_1_0_reason5;
  string2 fp1611_1_0_reason6;
  string3 fp1702_2_0_score;
  string2 fp1702_2_0_reason1;
  string2 fp1702_2_0_reason2;
  string2 fp1702_2_0_reason3;
  string2 fp1702_2_0_reason4;
  string2 fp1702_2_0_reason5;
  string2 fp1702_2_0_reason6;
  string3 fp1702_1_0_score;
  string2 fp1702_1_0_reason1;
  string2 fp1702_1_0_reason2;
  string2 fp1702_1_0_reason3;
  string2 fp1702_1_0_reason4;
  string2 fp1702_1_0_reason5;
  string2 fp1702_1_0_reason6;
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
  string3 fp31505_0_0_score;
  string2 fp31505_0_0_reason1;
  string2 fp31505_0_0_reason2;
  string2 fp31505_0_0_reason3;
  string2 fp31505_0_0_reason4;
  string2 fp31505_0_0_reason5;
  string2 fp31505_0_0_reason6;
  string3 fp31604_0_0_score;
  string2 fp31604_0_0_reason1;
  string2 fp31604_0_0_reason2;
  string2 fp31604_0_0_reason3;
  string2 fp31604_0_0_reason4;
  string2 fp31604_0_0_reason5;
  string2 fp31604_0_0_reason6;
  string3 fp3fdn1505_0_0_score;
  string2 fp3fdn1505_0_0_reason1;
  string2 fp3fdn1505_0_0_reason2;
  string2 fp3fdn1505_0_0_reason3;
  string2 fp3fdn1505_0_0_reason4;
  string2 fp3fdn1505_0_0_reason5;
  string2 fp3fdn1505_0_0_reason6;
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
  string3 msn1210_1_0_score;
  string2 msn1210_1_0_reason1;
  string2 msn1210_1_0_reason2;
  string2 msn1210_1_0_reason3;
  string2 msn1210_1_0_reason4;
  string2 msn1210_1_0_reason5;
  string2 msn1210_1_0_reason6;
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
  string3 rva1503_0_0_score;
  string3 rva1503_0_0_reason1;
  string3 rva1503_0_0_reason2;
  string3 rva1503_0_0_reason3;
  string3 rva1503_0_0_reason4;
  string3 rva1504_1_0_score;
  string2 rva1504_1_0_reason1;
  string2 rva1504_1_0_reason2;
  string2 rva1504_1_0_reason3;
  string2 rva1504_1_0_reason4;
  string3 rva1504_2_0_score;
  string2 rva1504_2_0_reason1;
  string2 rva1504_2_0_reason2;
  string2 rva1504_2_0_reason3;
  string2 rva1504_2_0_reason4;
  string3 rva1601_1_0_score;
  string3 rva1601_1_0_reason1;
  string3 rva1601_1_0_reason2;
  string3 rva1601_1_0_reason3;
  string3 rva1601_1_0_reason4;
  string3 rva1603_1_0_score;
  string3 rva1603_1_0_reason1;
  string3 rva1603_1_0_reason2;
  string3 rva1603_1_0_reason3;
  string3 rva1603_1_0_reason4;
  string3 rva1605_1_0_score;
  string3 rva1605_1_0_reason1;
  string3 rva1605_1_0_reason2;
  string3 rva1605_1_0_reason3;
  string3 rva1605_1_0_reason4;
  string3 rva1607_1_0_score;
  string3 rva1607_1_0_reason1;
  string3 rva1607_1_0_reason2;
  string3 rva1607_1_0_reason3;
  string3 rva1607_1_0_reason4;
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
  string3 rva1611_1_0_score;
  string3 rva1611_1_0_reason1;
  string3 rva1611_1_0_reason2;
  string3 rva1611_1_0_reason3;
  string3 rva1611_1_0_reason4;
  string3 rva1611_2_0_score;
  string3 rva1611_2_0_reason1;
  string3 rva1611_2_0_reason2;
  string3 rva1611_2_0_reason3;
  string3 rva1611_2_0_reason4;
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
  string3 rvb1104_1_0_score;
  string2 rvb1104_1_0_reason1;
  string2 rvb1104_1_0_reason2;
  string2 rvb1104_1_0_reason3;
  string2 rvb1104_1_0_reason4;
  string3 rvb1310_1_0_score;
  string2 rvb1310_1_0_reason1;
  string2 rvb1310_1_0_reason2;
  string2 rvb1310_1_0_reason3;
  string2 rvb1310_1_0_reason4;
  string3 rvb1402_1_0_score;
  string2 rvb1402_1_0_reason1;
  string2 rvb1402_1_0_reason2;
  string2 rvb1402_1_0_reason3;
  string2 rvb1402_1_0_reason4;
  string3 rvb1503_0_0_score;
  string3 rvb1503_0_0_reason1;
  string3 rvb1503_0_0_reason2;
  string3 rvb1503_0_0_reason3;
  string3 rvb1503_0_0_reason4;
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
  string3 rvb1610_1_0_score;
  string3 rvb1610_1_0_reason1;
  string3 rvb1610_1_0_reason2;
  string3 rvb1610_1_0_reason3;
  string3 rvb1610_1_0_reason4;
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
  string3 rvc1405_1_0_score;
  string2 rvc1405_1_0_reason1;
  string2 rvc1405_1_0_reason2;
  string2 rvc1405_1_0_reason3;
  string2 rvc1405_1_0_reason4;
  string3 rvc1405_2_0_score;
  string2 rvc1405_2_0_reason1;
  string2 rvc1405_2_0_reason2;
  string2 rvc1405_2_0_reason3;
  string2 rvc1405_2_0_reason4;
  string3 rvc1405_3_0_score;
  string2 rvc1405_3_0_reason1;
  string2 rvc1405_3_0_reason2;
  string2 rvc1405_3_0_reason3;
  string2 rvc1405_3_0_reason4;
  string3 rvc1405_4_0_score;
  string2 rvc1405_4_0_reason1;
  string2 rvc1405_4_0_reason2;
  string2 rvc1405_4_0_reason3;
  string2 rvc1405_4_0_reason4;
  string3 rvc1412_1_0_score;
  string2 rvc1412_1_0_reason1;
  string2 rvc1412_1_0_reason2;
  string2 rvc1412_1_0_reason3;
  string2 rvc1412_1_0_reason4;
  string3 rvc1412_2_0_score;
  string2 rvc1412_2_0_reason1;
  string2 rvc1412_2_0_reason2;
  string2 rvc1412_2_0_reason3;
  string2 rvc1412_2_0_reason4;
  string3 rvc1602_1_0_score;
  string2 rvc1602_1_0_reason1;
  string2 rvc1602_1_0_reason2;
  string2 rvc1602_1_0_reason3;
  string2 rvc1602_1_0_reason4;
  string3 rvc1609_1_0_score;
  string2 rvc1609_1_0_reason1;
  string2 rvc1609_1_0_reason2;
  string2 rvc1609_1_0_reason3;
  string2 rvc1609_1_0_reason4;
  string3 rvc1703_1_0_score;
  string2 rvc1703_1_0_reason1;
  string2 rvc1703_1_0_reason2;
  string2 rvc1703_1_0_reason3;
  string2 rvc1703_1_0_reason4;
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
  string3 rvg1310_1_0_score;
  string2 rvg1310_1_0_reason1;
  string2 rvg1310_1_0_reason2;
  string2 rvg1310_1_0_reason3;
  string2 rvg1310_1_0_reason4;
  string3 rvg1404_1_0_score;
  string2 rvg1404_1_0_reason1;
  string2 rvg1404_1_0_reason2;
  string2 rvg1404_1_0_reason3;
  string2 rvg1404_1_0_reason4;
  string3 rvg1502_0_0_score;
  string3 rvg1502_0_0_reason1;
  string3 rvg1502_0_0_reason2;
  string3 rvg1502_0_0_reason3;
  string3 rvg1502_0_0_reason4;
  string3 rvg1511_1_0_score;
  string3 rvg1511_1_0_reason1;
  string3 rvg1511_1_0_reason2;
  string3 rvg1511_1_0_reason3;
  string3 rvg1511_1_0_reason4;
  string3 rvg1601_1_0_score;
  string3 rvg1601_1_0_reason1;
  string3 rvg1601_1_0_reason2;
  string3 rvg1601_1_0_reason3;
  string3 rvg1601_1_0_reason4;
  string3 rvg1601_1_0_reason5;
  string3 rvg1605_1_0_score;
  string3 rvg1605_1_0_reason1;
  string3 rvg1605_1_0_reason2;
  string3 rvg1605_1_0_reason3;
  string3 rvg1605_1_0_reason4;
  string3 rvg1605_1_0_reason5;
  string3 rvg1702_1_0_score;
  string2 rvg1702_1_0_reason1;
  string2 rvg1702_1_0_reason2;
  string2 rvg1702_1_0_reason3;
  string2 rvg1702_1_0_reason4;
  string3 rvg1705_1_0_score;
  string2 rvg1705_1_0_reason1;
  string2 rvg1705_1_0_reason2;
  string2 rvg1705_1_0_reason3;
  string2 rvg1705_1_0_reason4;
  string3 rvg1706_1_0_score;
  string3 rvg1706_1_0_reason1;
  string3 rvg1706_1_0_reason2;
  string3 rvg1706_1_0_reason3;
  string3 rvg1706_1_0_reason4;
  string3 rvp804_0_0_score;
  string2 rvp804_0_0_reason1;
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
  string3 rvp1503_1_0_score;
  string2 rvp1503_1_0_reason1;
  string3 rvp1605_1_0_score;
  string2 rvp1605_1_0_reason1;
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
  string3 rvr1410_1_0_score;
  string2 rvr1410_1_0_reason1;
  string2 rvr1410_1_0_reason2;
  string2 rvr1410_1_0_reason3;
  string2 rvr1410_1_0_reason4;
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
  string3 rvt1503_0_0_score;
  string3 rvt1503_0_0_reason1;
  string3 rvt1503_0_0_reason2;
  string3 rvt1503_0_0_reason3;
  string3 rvt1503_0_0_reason4;
  string3 rvt1601_1_0_score;
  string3 rvt1601_1_0_reason1;
  string3 rvt1601_1_0_reason2;
  string3 rvt1601_1_0_reason3;
  string3 rvt1601_1_0_reason4;
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
  string3 rvt1605_1_0_score;
  string2 rvt1605_1_0_reason1;
  string2 rvt1605_1_0_reason2;
  string2 rvt1605_1_0_reason3;
  string2 rvt1605_1_0_reason4;
  string3 rvt1605_2_0_score;
  string2 rvt1605_2_0_reason1;
  string2 rvt1605_2_0_reason2;
  string2 rvt1605_2_0_reason3;
  string2 rvt1605_2_0_reason4;
  string3 rvt1608_1_0_score;
  string2 rvt1608_1_0_reason1;
  string2 rvt1608_1_0_reason2;
  string2 rvt1608_1_0_reason3;
  string2 rvt1608_1_0_reason4;
  string2 rvt1608_1_0_reason5;
  string3 rvt1608_2_score;
  string2 rvt1608_2_reason1;
  string2 rvt1608_2_reason2;
  string2 rvt1608_2_reason3;
  string2 rvt1608_2_reason4;
  string2 rvt1608_2_reason5;
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




NewLay := Record
integer Order;
Input_Data_Layout - ie912_0_0_score - ien1006_0_1_score - mnc21106_0_0_score - mpx1211_0_0_score-msd1010_0_0_score - mv361006_0_0_score - mv361006_1_0_score - mx361006_0_0_score - mx361006_1_0_score - win704_0_0_score - womv002_0_0_score

//Removing below scores as they do not output to clean up layout
- ain509_0_0_score - ain509_0_0_reason1 - ain509_0_0_reason2 - ain509_0_0_reason3 - ain509_0_0_reason4 - ain602_1_0_score - ain602_1_0_reason1 - ain602_1_0_reason2 - ain602_1_0_reason3 - ain602_1_0_reason4 - ain605_1_0_score - ain605_1_0_reason1 - ain605_1_0_reason2 - ain605_1_0_reason3 - ain605_1_0_reason4 - ain605_2_0_score - ain605_2_0_reason1 - ain605_2_0_reason2 - ain605_2_0_reason3 - ain605_2_0_reason4 - ain605_3_0_score - ain605_3_0_reason1 - ain605_3_0_reason2 - ain605_3_0_reason3 - ain605_3_0_reason4 - ain801_1_0_score - ain801_1_0_reason1 - ain801_1_0_reason2 - ain801_1_0_reason3 - ain801_1_0_reason4 - anmk909_0_1_score
- awn510_0_0_score - awn510_0_0_reason1 - awn510_0_0_reason2 - awn510_0_0_reason3 - awn510_0_0_reason4 - awn603_1_0_score - awn603_1_0_reason1 - awn603_1_0_reason2 - awn603_1_0_reason3 - awn603_1_0_reason4 - bd3605_0_0_score - bd3605_0_0_reason1 - bd3605_0_0_reason2 - bd3605_0_0_reason3 - bd3605_0_0_reason4 - bd5605_0_0_score - bd5605_0_0_reason1 - bd5605_0_0_reason2 - bd5605_0_0_reason3 - bd5605_0_0_reason4 - bd5605_1_0_score - bd5605_1_0_reason1 - bd5605_1_0_reason2 - bd5605_1_0_reason3 - bd5605_1_0_reason4 - bd5605_2_0_score - bd5605_2_0_reason1 - bd5605_2_0_reason2 - bd5605_2_0_reason3 - bd5605_2_0_reason4 - bd5605_3_0_score - bd5605_3_0_reason1 - bd5605_3_0_reason2 - bd5605_3_0_reason3 - bd5605_3_0_reason4 - bd9605_0_0_score - bd9605_0_0_reason1 - bd9605_0_0_reason2 - bd9605_0_0_reason3 - bd9605_0_0_reason4 - bd9605_1_0_score - bd9605_1_0_reason1 - bd9605_1_0_reason2 - bd9605_1_0_reason3 - bd9605_1_0_reason4 - cdn1109_1_0_score - cdn1109_1_0_reason1 - cdn1109_1_0_reason2 - cdn1109_1_0_reason3 - cdn1109_1_0_reason4 - cdn1205_1_0_score - cdn1205_1_0_reason1 - cdn1205_1_0_reason2 - cdn1205_1_0_reason3 - cdn1205_1_0_reason4 - cdn1305_1_0_score - cdn1305_1_0_reason1 - cdn1305_1_0_reason2 - cdn1305_1_0_reason3 - cdn1305_1_0_reason4 - cdn1404_1_0_score - cdn1404_1_0_reason1 - cdn1404_1_0_reason2 - cdn1404_1_0_reason3 - cdn1404_1_0_reason4 - cdn1410_1_0_score - cdn1410_1_0_reason1 - cdn1410_1_0_reason2 - cdn1410_1_0_reason3 - cdn1410_1_0_reason4 - cdn1506_1_0_score - cdn1506_1_0_reason1 - cdn1506_1_0_reason2 - cdn1506_1_0_reason3 - cdn1506_1_0_reason4 - cdn1508_1_0_score - cdn1508_1_0_reason1 - cdn1508_1_0_reason2 - cdn1508_1_0_reason3 - cdn1508_1_0_reason4 - cdn1508_1_0_reason5 - cdn1508_1_0_reason6 - osn1504_0_0_score - osn1504_0_0_reason1 - osn1504_0_0_reason2 - osn1504_0_0_reason3 - osn1504_0_0_reason4 - osn1504_0_0_reason5 - osn1504_0_0_reason6 - osn1608_1_0_score - osn1608_1_0_reason1 - osn1608_1_0_reason2 - osn1608_1_0_reason3 - osn1608_1_0_reason4 - osn1608_1_0_reason5 - osn1608_1_0_reason6 - cdn604_0_0_score - cdn604_0_0_reason1 - cdn604_0_0_reason2 - cdn604_0_0_reason3 - cdn604_0_0_reason4 - cdn604_1_0_score - cdn604_2_0_score - cdn604_2_0_reason1 - cdn604_2_0_reason2 - cdn604_2_0_reason3 - cdn604_2_0_reason4 - cdn604_3_0_score - cdn604_3_0_reason1 - cdn604_3_0_reason2 - cdn604_3_0_reason3 - cdn604_3_0_reason4 - cdn604_4_0_score - cdn604_4_0_reason1 - cdn604_4_0_reason2 - cdn604_4_0_reason3 - cdn604_4_0_reason4 - cdn605_1_0_score - cdn605_1_0_reason1 - cdn605_1_0_reason2 - cdn605_1_0_reason3 - cdn605_1_0_reason4 - cdn606_2_0_score - cdn606_2_0_reason1 - cdn606_2_0_reason2 - cdn606_2_0_reason3 - cdn606_2_0_reason4 - cdn706_1_0_score - cdn706_1_0_bt_reason1 - cdn706_1_0_bt_reason2 - cdn706_1_0_bt_reason3 - cdn706_1_0_bt_reason4 - cdn706_1_0_st_reason1 - cdn706_1_0_st_reason2 - cdn706_1_0_st_reason3 - cdn706_1_0_st_reason4 - cdn707_1_0_score - cdn707_1_0_reason1 - cdn707_1_0_reason2 - cdn707_1_0_reason3 - cdn707_1_0_reason4 - cdn712_0_0_score - cdn712_0_0_reason1 - cdn712_0_0_reason2 - cdn712_0_0_reason3 - cdn712_0_0_reason4 - cdn806_1_0_score - cdn806_1_0_reason1 - cdn806_1_0_reason2 - cdn806_1_0_reason3 - cdn806_1_0_reason4 - cdn908_1_0_score - cdn908_1_0_reason1 - cdn908_1_0_reason2 - cdn908_1_0_reason3 - cdn908_1_0_reason4 - cen509_0_0_score - csn1007_0_0_score - fd3510_0_0_score - fd3510_0_0_reason1 - fd3510_0_0_reason2 - fd3510_0_0_reason3 - fd3510_0_0_reason4 - fd3606_0_0_score - fd3606_0_0_reason1 - fd3606_0_0_reason2 - fd3606_0_0_reason3 - fd3606_0_0_reason4 - fd5510_0_0_score - fd5510_0_0_reason1 - fd5510_0_0_reason2 - fd5510_0_0_reason3 - fd5510_0_0_reason4 - fd5603_1_0_score - fd5603_1_0_reason1 - fd5603_1_0_reason2 - fd5603_1_0_reason3 - fd5603_1_0_reason4 - fd5603_2_0_score - fd5603_2_0_reason1 - fd5603_2_0_reason2 - fd5603_2_0_reason3 - fd5603_2_0_reason4 - fd5603_3_0_score - fd5603_3_0_reason1 - fd5603_3_0_reason2 - fd5603_3_0_reason3 - fd5603_3_0_reason4 - fd5607_1_0_score - fd5607_1_0_reason1 - fd5607_1_0_reason2 - fd5607_1_0_reason3 - fd5607_1_0_reason4 - fd5609_1_0_score - fd5609_1_0_reason1 - fd5609_1_0_reason2 - fd5609_1_0_reason3 - fd5609_1_0_reason4 - fd5609_2_0_score - fd5609_2_0_reason1 - fd5609_2_0_reason2 - fd5609_2_0_reason3 - fd5609_2_0_reason4 - fd5709_1_0_score - fd5709_1_0_reason1 - fd5709_1_0_reason2 - fd5709_1_0_reason3 - fd5709_1_0_reason4 - fd9510_0_0_score - fd9510_0_0_reason1 - fd9510_0_0_reason2 - fd9510_0_0_reason3 - fd9510_0_0_reason4 - fd9603_1_0_score - fd9603_1_0_reason1 - fd9603_1_0_reason2 - fd9603_1_0_reason3 - fd9603_1_0_reason4 - fd9603_2_0_score - fd9603_2_0_reason1 - fd9603_2_0_reason2 - fd9603_2_0_reason3 - fd9603_2_0_reason4 - fd9603_3_0_score - fd9603_3_0_reason1 - fd9603_3_0_reason2 - fd9603_3_0_reason3 - fd9603_3_0_reason4 - fd9603_4_0_score - fd9603_4_0_reason1 - fd9603_4_0_reason2 - fd9603_4_0_reason3 - fd9603_4_0_reason4 - fd9604_1_0_score - fd9604_1_0_reason1 - fd9604_1_0_reason2 - fd9604_1_0_reason3 - fd9604_1_0_reason4 - fd9606_0_0_score - fd9606_0_0_reason1 - fd9606_0_0_reason2 - fd9606_0_0_reason3 - fd9606_0_0_reason4 - fd9607_1_0_score - fd9607_1_0_reason1 - fd9607_1_0_reason2 - fd9607_1_0_reason3 - fd9607_1_0_reason4 - fp1109_0_0_score - fp1109_0_0_reason1 - fp1109_0_0_reason2 - fp1109_0_0_reason3 - fp1109_0_0_reason4 - fp1210_1_0_score - fp1303_1_0_score - fp1303_1_0_reason1 - fp1303_1_0_reason2 - fp1303_1_0_reason3 - fp1303_1_0_reason4 - fp1401_1_0_score - fp1401_1_0_reason1 - fp1401_1_0_reason2 - fp1401_1_0_reason3 - fp1401_1_0_reason4 - fp1401_1_0_reason5 - fp1401_1_0_reason6 - fp1310_1_0_score - fp1310_1_0_reason1 - fp1310_1_0_reason2 - fp1310_1_0_reason3 - fp1310_1_0_reason4 - fp1310_1_0_reason5 - fp1310_1_0_reason6 - fp1307_1_0_score - fp1307_1_0_reason1 - fp1307_1_0_reason2 - fp1307_1_0_reason3 - fp1307_1_0_reason4 - fp1307_1_0_reason5 - fp1307_1_0_reason6 - fp1303_2_0_score - fp1403_1_0_score - fp1409_2_0_score - fp1403_2_0_score - fp1403_2_0_reason1 - fp1403_2_0_reason2 - fp1403_2_0_reason3 - fp1403_2_0_reason4 - fp1403_2_0_reason5 - fp1403_2_0_reason6 - fp1404_1_0_score - fp1404_1_0_reason1 - fp1404_1_0_reason2 - fp1404_1_0_reason3 - fp1404_1_0_reason4 - fp1404_1_0_reason5 - fp1404_1_0_reason6 - fp1407_1_0_score - fp1407_1_0_reason1 - fp1407_1_0_reason2 - fp1407_1_0_reason3 - fp1407_1_0_reason4 - fp1407_1_0_reason5 - fp1407_1_0_reason6 - fp1407_2_0_score - fp1407_2_0_reason1 - fp1407_2_0_reason2 - fp1407_2_0_reason3 - fp1407_2_0_reason4 - fp1407_2_0_reason5 - fp1407_2_0_reason6 - fp1406_1_0_score - fp1406_1_0_reason1 - fp1406_1_0_reason2 - fp1406_1_0_reason3 - fp1406_1_0_reason4 - fp1406_1_0_reason5 - fp1406_1_0_reason6 - fp1506_1_0_score - fp1506_1_0_reason1 - fp1506_1_0_reason2 - fp1506_1_0_reason3 - fp1506_1_0_reason4 - fp1506_1_0_reason5 - fp1506_1_0_reason6 - fp1509_1_0_score - fp1509_1_0_reason1 - fp1509_1_0_reason2 - fp1509_1_0_reason3 - fp1509_1_0_reason4 - fp1509_1_0_reason5 - fp1509_1_0_reason6 - fp1509_2_0_score - fp1509_2_0_reason1 - fp1509_2_0_reason2 - fp1509_2_0_reason3 - fp1509_2_0_reason4 - fp1509_2_0_reason5 - fp1509_2_0_reason6 - fp1510_2_0_score - fp1510_2_0_reason1 - fp1510_2_0_reason2 - fp1510_2_0_reason3 - fp1510_2_0_reason4 - fp1510_2_0_reason5 - fp1510_2_0_reason6 - fp1511_1_0_score - fp1511_1_0_reason1 - fp1511_1_0_reason2 - fp1511_1_0_reason3 - fp1511_1_0_reason4 - fp1511_1_0_reason5 - fp1511_1_0_reason6 - fp1512_1_0_score - fp1512_1_0_reason1 - fp1512_1_0_reason2 - fp1512_1_0_reason3 - fp1512_1_0_reason4 - fp1512_1_0_reason5 - fp1512_1_0_reason6 - fp1609_1_0_score - fp1609_1_0_reason1 - fp1609_1_0_reason2 - fp1609_1_0_reason3 - fp1609_1_0_reason4 - fp1609_1_0_reason5 - fp1609_1_0_reason6 - fp1606_1_0_score - fp1606_1_0_reason1 - fp1606_1_0_reason2 - fp1606_1_0_reason3 - fp1606_1_0_reason4 - fp1606_1_0_reason5 - fp1606_1_0_reason6 - fp1610_1_0_score - fp1610_1_0_reason1 - fp1610_1_0_reason2 - fp1610_1_0_reason3 - fp1610_1_0_reason4 - fp1610_1_0_reason5 - fp1610_1_0_reason6 - fp1610_2_0_score - fp1610_2_0_reason1 - fp1610_2_0_reason2 - fp1610_2_0_reason3 - fp1610_2_0_reason4 - fp1610_2_0_reason5 - fp1610_2_0_reason6 - fp1611_1_0_score - fp1611_1_0_reason1 - fp1611_1_0_reason2 - fp1611_1_0_reason3 - fp1611_1_0_reason4 - fp1611_1_0_reason5 - fp1611_1_0_reason6 - fp1702_2_0_score - fp1702_2_0_reason1 - fp1702_2_0_reason2 - fp1702_2_0_reason3 - fp1702_2_0_reason4 - fp1702_2_0_reason5 - fp1702_2_0_reason6 - fp1702_1_0_score - fp1702_1_0_reason1 - fp1702_1_0_reason2 - fp1702_1_0_reason3 - fp1702_1_0_reason4 - fp1702_1_0_reason5 - fp1702_1_0_reason6 - fp31105_1_0_score - fp31105_1_0_reason1 - fp31105_1_0_reason2 - fp31105_1_0_reason3 - fp31105_1_0_reason4 - fp31203_1_0_score - fp31203_1_0_reason1 - fp31203_1_0_reason2 - fp31203_1_0_reason3 - fp31203_1_0_reason4 - fp31310_2_0_score - fp31310_2_0_reason1 - fp31310_2_0_reason2 - fp31310_2_0_reason3 - fp31310_2_0_reason4 - fp31310_2_0_reason5 - fp31310_2_0_reason6 - fp31505_0_0_score - fp31505_0_0_reason1 - fp31505_0_0_reason2 - fp31505_0_0_reason3 - fp31505_0_0_reason4 - fp31505_0_0_reason5 - fp31505_0_0_reason6 - fp31604_0_0_score - fp31604_0_0_reason1 - fp31604_0_0_reason2 - fp31604_0_0_reason3 - fp31604_0_0_reason4 - fp31604_0_0_reason5 - fp31604_0_0_reason6 - fp3fdn1505_0_0_score - fp3fdn1505_0_0_reason1 - fp3fdn1505_0_0_reason2 - fp3fdn1505_0_0_reason3 - fp3fdn1505_0_0_reason4 - fp3fdn1505_0_0_reason5 - fp3fdn1505_0_0_reason6 - fp3710_0_0_score - fp3710_0_0_reason1 - fp3710_0_0_reason2 - fp3710_0_0_reason3 - fp3710_0_0_reason4 - fp3904_1_0_score - fp3904_1_0_reason1 - fp3904_1_0_reason2 - fp3904_1_0_reason3 - fp3904_1_0_reason4 - fp3905_1_0_score - fp3905_1_0_reason1 - fp3905_1_0_reason2 - fp3905_1_0_reason3 - fp3905_1_0_reason4 - fp5812_1_0_score - fp5812_1_0_reason1 - fp5812_1_0_reason2 - fp5812_1_0_reason3 - fp5812_1_0_reason4 - hcp1206_0_0_score - hcp1206_0_0_reason1 - hcp1206_0_0_reason2 - hcp1206_0_0_reason3 - hcp1206_0_0_reason4 - idn605_1_0_score - idn605_1_0_reason1 - idn605_1_0_reason2 - idn605_1_0_reason3 - idn605_1_0_reason4 - ie912_0_0_reason1 - ie912_0_0_reason2 - ie912_0_0_reason3 - ie912_0_0_reason4
;

// string ie912_0_0_score;   //removed as it was not outputting
string ien1006_0_1_score;
string mnc21106_0_0_score;
string mpx1211_0_0_score;
string msd1010_0_0_score;
string mv361006_0_0_score;
string mv361006_1_0_score;
string mx361006_0_0_score;
string mx361006_1_0_score;
string win704_0_0_score;
string womv002_0_0_score;
End;


curr_date := (String8)std.date.Today();
// prev_date := (String8)std.Date.AdjustDate(std.date.Today(), 0,0,-1);
prev_date := '20171012';

filetag := '1';

curr_file := '~scoringqa::out::bs_41_fcra_runway_file::PersonalScoreTracker_' + curr_date + '_' + filetag;
prev_file := '~scoringqa::out::bs_41_fcra_runway_file::PersonalScoreTracker_' + prev_date + '_' + filetag;

curr_ds := DATASET(curr_file, Input_Data_Layout, THOR);
prev_ds := DATASET(prev_file, Input_Data_Layout, THOR);

prev_ds_1 := project(prev_ds, Transform(NewLay, Self.Order := 1,
																								// self.ie912_0_0_score := (String)Left.ie912_0_0_score,    //removed as it was not outputting
																								self.ien1006_0_1_score := (String)Left.ien1006_0_1_score,
																								self.mnc21106_0_0_score := (String)Left.mnc21106_0_0_score,
																								self.mpx1211_0_0_score := (String)Left.mpx1211_0_0_score,
																								self.msd1010_0_0_score := (String)Left.msd1010_0_0_score,
																								self.mv361006_0_0_score := (String)Left.mv361006_0_0_score,
																								self.mv361006_1_0_score := (String)Left.mv361006_1_0_score,
																								self.mx361006_0_0_score := (String)Left.mx361006_0_0_score,
																								self.mx361006_1_0_score := (String)Left.mx361006_1_0_score,
																								self.win704_0_0_score := (String)Left.win704_0_0_score,
																								self.womv002_0_0_score := (String)Left.womv002_0_0_score,																				
																								Self := Left));

curr_ds_1 := join(prev_ds_1, curr_ds, left.did = right.did,
				  TRANSFORM(NewLay, 
Self.Order := 2;					
Self.did := right.did, 
self.nap := if(Left.nap <> right.nap, Right.nap, ''),
self.nas := if(Left.nas <> right.nas, Right.nas, ''),
self.cvi_score := if(Left.cvi_score <> right.cvi_score, Right.cvi_score, ''),
self.cvi_reason1 := if(Left.cvi_reason1 <> right.cvi_reason1, Right.cvi_reason1, ''),
self.cvi_reason2 := if(Left.cvi_reason2 <> right.cvi_reason2, Right.cvi_reason2, ''),
self.cvi_reason3 := if(Left.cvi_reason3 <> right.cvi_reason3, Right.cvi_reason3, ''),
self.cvi_reason4 := if(Left.cvi_reason4 <> right.cvi_reason4, Right.cvi_reason4, ''),
self.aid605_1_0_score := if(Left.aid605_1_0_score <> right.aid605_1_0_score, Right.aid605_1_0_score, ''),
self.aid605_1_0_reason1 := if(Left.aid605_1_0_reason1 <> right.aid605_1_0_reason1, Right.aid605_1_0_reason1, ''),
self.aid605_1_0_reason2 := if(Left.aid605_1_0_reason2 <> right.aid605_1_0_reason2, Right.aid605_1_0_reason2, ''),
self.aid605_1_0_reason3 := if(Left.aid605_1_0_reason3 <> right.aid605_1_0_reason3, Right.aid605_1_0_reason3, ''),
self.aid605_1_0_reason4 := if(Left.aid605_1_0_reason4 <> right.aid605_1_0_reason4, Right.aid605_1_0_reason4, ''),
self.aid606_0_0_score := if(Left.aid606_0_0_score <> right.aid606_0_0_score, Right.aid606_0_0_score, ''),
self.aid606_0_0_reason1 := if(Left.aid606_0_0_reason1 <> right.aid606_0_0_reason1, Right.aid606_0_0_reason1, ''),
self.aid606_0_0_reason2 := if(Left.aid606_0_0_reason2 <> right.aid606_0_0_reason2, Right.aid606_0_0_reason2, ''),
self.aid606_0_0_reason3 := if(Left.aid606_0_0_reason3 <> right.aid606_0_0_reason3, Right.aid606_0_0_reason3, ''),
self.aid606_0_0_reason4 := if(Left.aid606_0_0_reason4 <> right.aid606_0_0_reason4, Right.aid606_0_0_reason4, ''),
self.aid606_1_0_score := if(Left.aid606_1_0_score <> right.aid606_1_0_score, Right.aid606_1_0_score, ''),
self.aid606_1_0_reason1 := if(Left.aid606_1_0_reason1 <> right.aid606_1_0_reason1, Right.aid606_1_0_reason1, ''),
self.aid606_1_0_reason2 := if(Left.aid606_1_0_reason2 <> right.aid606_1_0_reason2, Right.aid606_1_0_reason2, ''),
self.aid606_1_0_reason3 := if(Left.aid606_1_0_reason3 <> right.aid606_1_0_reason3, Right.aid606_1_0_reason3, ''),
self.aid606_1_0_reason4 := if(Left.aid606_1_0_reason4 <> right.aid606_1_0_reason4, Right.aid606_1_0_reason4, ''),
self.aid607_0_0_score := if(Left.aid607_0_0_score <> right.aid607_0_0_score, Right.aid607_0_0_score, ''),
self.aid607_0_0_reason1 := if(Left.aid607_0_0_reason1 <> right.aid607_0_0_reason1, Right.aid607_0_0_reason1, ''),
self.aid607_0_0_reason2 := if(Left.aid607_0_0_reason2 <> right.aid607_0_0_reason2, Right.aid607_0_0_reason2, ''),
self.aid607_0_0_reason3 := if(Left.aid607_0_0_reason3 <> right.aid607_0_0_reason3, Right.aid607_0_0_reason3, ''),
self.aid607_0_0_reason4 := if(Left.aid607_0_0_reason4 <> right.aid607_0_0_reason4, Right.aid607_0_0_reason4, ''),
self.aid607_1_0_score := if(Left.aid607_1_0_score <> right.aid607_1_0_score, Right.aid607_1_0_score, ''),
self.aid607_1_0_reason1 := if(Left.aid607_1_0_reason1 <> right.aid607_1_0_reason1, Right.aid607_1_0_reason1, ''),
self.aid607_1_0_reason2 := if(Left.aid607_1_0_reason2 <> right.aid607_1_0_reason2, Right.aid607_1_0_reason2, ''),
self.aid607_1_0_reason3 := if(Left.aid607_1_0_reason3 <> right.aid607_1_0_reason3, Right.aid607_1_0_reason3, ''),
self.aid607_1_0_reason4 := if(Left.aid607_1_0_reason4 <> right.aid607_1_0_reason4, Right.aid607_1_0_reason4, ''),
self.aid607_2_0_score := if(Left.aid607_2_0_score <> right.aid607_2_0_score, Right.aid607_2_0_score, ''),
self.aid607_2_0_reason1 := if(Left.aid607_2_0_reason1 <> right.aid607_2_0_reason1, Right.aid607_2_0_reason1, ''),
self.aid607_2_0_reason2 := if(Left.aid607_2_0_reason2 <> right.aid607_2_0_reason2, Right.aid607_2_0_reason2, ''),
self.aid607_2_0_reason3 := if(Left.aid607_2_0_reason3 <> right.aid607_2_0_reason3, Right.aid607_2_0_reason3, ''),
self.aid607_2_0_reason4 := if(Left.aid607_2_0_reason4 <> right.aid607_2_0_reason4, Right.aid607_2_0_reason4, ''),
// self.ain509_0_0_score := if(Left.ain509_0_0_score <> right.ain509_0_0_score, Right.ain509_0_0_score, ''),             //These were removed from layout as they did not output
// self.ain509_0_0_reason1 := if(Left.ain509_0_0_reason1 <> right.ain509_0_0_reason1, Right.ain509_0_0_reason1, ''),
// self.ain509_0_0_reason2 := if(Left.ain509_0_0_reason2 <> right.ain509_0_0_reason2, Right.ain509_0_0_reason2, ''),
// self.ain509_0_0_reason3 := if(Left.ain509_0_0_reason3 <> right.ain509_0_0_reason3, Right.ain509_0_0_reason3, ''),
// self.ain509_0_0_reason4 := if(Left.ain509_0_0_reason4 <> right.ain509_0_0_reason4, Right.ain509_0_0_reason4, ''),
// self.ain602_1_0_score := if(Left.ain602_1_0_score <> right.ain602_1_0_score, Right.ain602_1_0_score, ''),
// self.ain602_1_0_reason1 := if(Left.ain602_1_0_reason1 <> right.ain602_1_0_reason1, Right.ain602_1_0_reason1, ''),
// self.ain602_1_0_reason2 := if(Left.ain602_1_0_reason2 <> right.ain602_1_0_reason2, Right.ain602_1_0_reason2, ''),
// self.ain602_1_0_reason3 := if(Left.ain602_1_0_reason3 <> right.ain602_1_0_reason3, Right.ain602_1_0_reason3, ''),
// self.ain602_1_0_reason4 := if(Left.ain602_1_0_reason4 <> right.ain602_1_0_reason4, Right.ain602_1_0_reason4, ''),
// self.ain605_1_0_score := if(Left.ain605_1_0_score <> right.ain605_1_0_score, Right.ain605_1_0_score, ''),
// self.ain605_1_0_reason1 := if(Left.ain605_1_0_reason1 <> right.ain605_1_0_reason1, Right.ain605_1_0_reason1, ''),
// self.ain605_1_0_reason2 := if(Left.ain605_1_0_reason2 <> right.ain605_1_0_reason2, Right.ain605_1_0_reason2, ''),
// self.ain605_1_0_reason3 := if(Left.ain605_1_0_reason3 <> right.ain605_1_0_reason3, Right.ain605_1_0_reason3, ''),
// self.ain605_1_0_reason4 := if(Left.ain605_1_0_reason4 <> right.ain605_1_0_reason4, Right.ain605_1_0_reason4, ''),
// self.ain605_2_0_score := if(Left.ain605_2_0_score <> right.ain605_2_0_score, Right.ain605_2_0_score, ''),
// self.ain605_2_0_reason1 := if(Left.ain605_2_0_reason1 <> right.ain605_2_0_reason1, Right.ain605_2_0_reason1, ''),
// self.ain605_2_0_reason2 := if(Left.ain605_2_0_reason2 <> right.ain605_2_0_reason2, Right.ain605_2_0_reason2, ''),
// self.ain605_2_0_reason3 := if(Left.ain605_2_0_reason3 <> right.ain605_2_0_reason3, Right.ain605_2_0_reason3, ''),
// self.ain605_2_0_reason4 := if(Left.ain605_2_0_reason4 <> right.ain605_2_0_reason4, Right.ain605_2_0_reason4, ''),
// self.ain605_3_0_score := if(Left.ain605_3_0_score <> right.ain605_3_0_score, Right.ain605_3_0_score, ''),
// self.ain605_3_0_reason1 := if(Left.ain605_3_0_reason1 <> right.ain605_3_0_reason1, Right.ain605_3_0_reason1, ''),
// self.ain605_3_0_reason2 := if(Left.ain605_3_0_reason2 <> right.ain605_3_0_reason2, Right.ain605_3_0_reason2, ''),
// self.ain605_3_0_reason3 := if(Left.ain605_3_0_reason3 <> right.ain605_3_0_reason3, Right.ain605_3_0_reason3, ''),
// self.ain605_3_0_reason4 := if(Left.ain605_3_0_reason4 <> right.ain605_3_0_reason4, Right.ain605_3_0_reason4, ''),
// self.ain801_1_0_score := if(Left.ain801_1_0_score <> right.ain801_1_0_score, Right.ain801_1_0_score, ''),
// self.ain801_1_0_reason1 := if(Left.ain801_1_0_reason1 <> right.ain801_1_0_reason1, Right.ain801_1_0_reason1, ''),
// self.ain801_1_0_reason2 := if(Left.ain801_1_0_reason2 <> right.ain801_1_0_reason2, Right.ain801_1_0_reason2, ''),
// self.ain801_1_0_reason3 := if(Left.ain801_1_0_reason3 <> right.ain801_1_0_reason3, Right.ain801_1_0_reason3, ''),
// self.ain801_1_0_reason4 := if(Left.ain801_1_0_reason4 <> right.ain801_1_0_reason4, Right.ain801_1_0_reason4, ''),
// self.anmk909_0_1_score := if(Left.anmk909_0_1_score <> right.anmk909_0_1_score, Right.anmk909_0_1_score, ''),
self.awd605_0_0_score := if(Left.awd605_0_0_score <> right.awd605_0_0_score, Right.awd605_0_0_score, ''),
self.awd605_0_0_reason1 := if(Left.awd605_0_0_reason1 <> right.awd605_0_0_reason1, Right.awd605_0_0_reason1, ''),
self.awd605_0_0_reason2 := if(Left.awd605_0_0_reason2 <> right.awd605_0_0_reason2, Right.awd605_0_0_reason2, ''),
self.awd605_0_0_reason3 := if(Left.awd605_0_0_reason3 <> right.awd605_0_0_reason3, Right.awd605_0_0_reason3, ''),
self.awd605_0_0_reason4 := if(Left.awd605_0_0_reason4 <> right.awd605_0_0_reason4, Right.awd605_0_0_reason4, ''),
self.awd605_2_0_score := if(Left.awd605_2_0_score <> right.awd605_2_0_score, Right.awd605_2_0_score, ''),
self.awd605_2_0_reason1 := if(Left.awd605_2_0_reason1 <> right.awd605_2_0_reason1, Right.awd605_2_0_reason1, ''),
self.awd605_2_0_reason2 := if(Left.awd605_2_0_reason2 <> right.awd605_2_0_reason2, Right.awd605_2_0_reason2, ''),
self.awd605_2_0_reason3 := if(Left.awd605_2_0_reason3 <> right.awd605_2_0_reason3, Right.awd605_2_0_reason3, ''),
self.awd605_2_0_reason4 := if(Left.awd605_2_0_reason4 <> right.awd605_2_0_reason4, Right.awd605_2_0_reason4, ''),
self.awd606_10_0_score := if(Left.awd606_10_0_score <> right.awd606_10_0_score, Right.awd606_10_0_score, ''),
self.awd606_10_0_reason1 := if(Left.awd606_10_0_reason1 <> right.awd606_10_0_reason1, Right.awd606_10_0_reason1, ''),
self.awd606_10_0_reason2 := if(Left.awd606_10_0_reason2 <> right.awd606_10_0_reason2, Right.awd606_10_0_reason2, ''),
self.awd606_10_0_reason3 := if(Left.awd606_10_0_reason3 <> right.awd606_10_0_reason3, Right.awd606_10_0_reason3, ''),
self.awd606_10_0_reason4 := if(Left.awd606_10_0_reason4 <> right.awd606_10_0_reason4, Right.awd606_10_0_reason4, ''),
self.awd606_11_0_score := if(Left.awd606_11_0_score <> right.awd606_11_0_score, Right.awd606_11_0_score, ''),
self.awd606_11_0_reason1 := if(Left.awd606_11_0_reason1 <> right.awd606_11_0_reason1, Right.awd606_11_0_reason1, ''),
self.awd606_11_0_reason2 := if(Left.awd606_11_0_reason2 <> right.awd606_11_0_reason2, Right.awd606_11_0_reason2, ''),
self.awd606_11_0_reason3 := if(Left.awd606_11_0_reason3 <> right.awd606_11_0_reason3, Right.awd606_11_0_reason3, ''),
self.awd606_11_0_reason4 := if(Left.awd606_11_0_reason4 <> right.awd606_11_0_reason4, Right.awd606_11_0_reason4, ''),
self.awd606_1_0_score := if(Left.awd606_1_0_score <> right.awd606_1_0_score, Right.awd606_1_0_score, ''),
self.awd606_1_0_reason1 := if(Left.awd606_1_0_reason1 <> right.awd606_1_0_reason1, Right.awd606_1_0_reason1, ''),
self.awd606_1_0_reason2 := if(Left.awd606_1_0_reason2 <> right.awd606_1_0_reason2, Right.awd606_1_0_reason2, ''),
self.awd606_1_0_reason3 := if(Left.awd606_1_0_reason3 <> right.awd606_1_0_reason3, Right.awd606_1_0_reason3, ''),
self.awd606_1_0_reason4 := if(Left.awd606_1_0_reason4 <> right.awd606_1_0_reason4, Right.awd606_1_0_reason4, ''),
self.awd606_2_0_score := if(Left.awd606_2_0_score <> right.awd606_2_0_score, Right.awd606_2_0_score, ''),
self.awd606_2_0_reason1 := if(Left.awd606_2_0_reason1 <> right.awd606_2_0_reason1, Right.awd606_2_0_reason1, ''),
self.awd606_2_0_reason2 := if(Left.awd606_2_0_reason2 <> right.awd606_2_0_reason2, Right.awd606_2_0_reason2, ''),
self.awd606_2_0_reason3 := if(Left.awd606_2_0_reason3 <> right.awd606_2_0_reason3, Right.awd606_2_0_reason3, ''),
self.awd606_2_0_reason4 := if(Left.awd606_2_0_reason4 <> right.awd606_2_0_reason4, Right.awd606_2_0_reason4, ''),
self.awd606_3_0_score := if(Left.awd606_3_0_score <> right.awd606_3_0_score, Right.awd606_3_0_score, ''),
self.awd606_3_0_reason1 := if(Left.awd606_3_0_reason1 <> right.awd606_3_0_reason1, Right.awd606_3_0_reason1, ''),
self.awd606_3_0_reason2 := if(Left.awd606_3_0_reason2 <> right.awd606_3_0_reason2, Right.awd606_3_0_reason2, ''),
self.awd606_3_0_reason3 := if(Left.awd606_3_0_reason3 <> right.awd606_3_0_reason3, Right.awd606_3_0_reason3, ''),
self.awd606_3_0_reason4 := if(Left.awd606_3_0_reason4 <> right.awd606_3_0_reason4, Right.awd606_3_0_reason4, ''),
self.awd606_4_0_score := if(Left.awd606_4_0_score <> right.awd606_4_0_score, Right.awd606_4_0_score, ''),
self.awd606_4_0_reason1 := if(Left.awd606_4_0_reason1 <> right.awd606_4_0_reason1, Right.awd606_4_0_reason1, ''),
self.awd606_4_0_reason2 := if(Left.awd606_4_0_reason2 <> right.awd606_4_0_reason2, Right.awd606_4_0_reason2, ''),
self.awd606_4_0_reason3 := if(Left.awd606_4_0_reason3 <> right.awd606_4_0_reason3, Right.awd606_4_0_reason3, ''),
self.awd606_4_0_reason4 := if(Left.awd606_4_0_reason4 <> right.awd606_4_0_reason4, Right.awd606_4_0_reason4, ''),
self.awd606_6_0_score := if(Left.awd606_6_0_score <> right.awd606_6_0_score, Right.awd606_6_0_score, ''),
self.awd606_6_0_reason1 := if(Left.awd606_6_0_reason1 <> right.awd606_6_0_reason1, Right.awd606_6_0_reason1, ''),
self.awd606_6_0_reason2 := if(Left.awd606_6_0_reason2 <> right.awd606_6_0_reason2, Right.awd606_6_0_reason2, ''),
self.awd606_6_0_reason3 := if(Left.awd606_6_0_reason3 <> right.awd606_6_0_reason3, Right.awd606_6_0_reason3, ''),
self.awd606_6_0_reason4 := if(Left.awd606_6_0_reason4 <> right.awd606_6_0_reason4, Right.awd606_6_0_reason4, ''),
self.awd606_7_0_score := if(Left.awd606_7_0_score <> right.awd606_7_0_score, Right.awd606_7_0_score, ''),
self.awd606_7_0_reason1 := if(Left.awd606_7_0_reason1 <> right.awd606_7_0_reason1, Right.awd606_7_0_reason1, ''),
self.awd606_7_0_reason2 := if(Left.awd606_7_0_reason2 <> right.awd606_7_0_reason2, Right.awd606_7_0_reason2, ''),
self.awd606_7_0_reason3 := if(Left.awd606_7_0_reason3 <> right.awd606_7_0_reason3, Right.awd606_7_0_reason3, ''),
self.awd606_7_0_reason4 := if(Left.awd606_7_0_reason4 <> right.awd606_7_0_reason4, Right.awd606_7_0_reason4, ''),
self.awd606_8_0_score := if(Left.awd606_8_0_score <> right.awd606_8_0_score, Right.awd606_8_0_score, ''),
self.awd606_8_0_reason1 := if(Left.awd606_8_0_reason1 <> right.awd606_8_0_reason1, Right.awd606_8_0_reason1, ''),
self.awd606_8_0_reason2 := if(Left.awd606_8_0_reason2 <> right.awd606_8_0_reason2, Right.awd606_8_0_reason2, ''),
self.awd606_8_0_reason3 := if(Left.awd606_8_0_reason3 <> right.awd606_8_0_reason3, Right.awd606_8_0_reason3, ''),
self.awd606_8_0_reason4 := if(Left.awd606_8_0_reason4 <> right.awd606_8_0_reason4, Right.awd606_8_0_reason4, ''),
self.awd606_9_0_score := if(Left.awd606_9_0_score <> right.awd606_9_0_score, Right.awd606_9_0_score, ''),
self.awd606_9_0_reason1 := if(Left.awd606_9_0_reason1 <> right.awd606_9_0_reason1, Right.awd606_9_0_reason1, ''),
self.awd606_9_0_reason2 := if(Left.awd606_9_0_reason2 <> right.awd606_9_0_reason2, Right.awd606_9_0_reason2, ''),
self.awd606_9_0_reason3 := if(Left.awd606_9_0_reason3 <> right.awd606_9_0_reason3, Right.awd606_9_0_reason3, ''),
self.awd606_9_0_reason4 := if(Left.awd606_9_0_reason4 <> right.awd606_9_0_reason4, Right.awd606_9_0_reason4, ''),
self.awd710_1_0_score := if(Left.awd710_1_0_score <> right.awd710_1_0_score, Right.awd710_1_0_score, ''),
self.awd710_1_0_reason1 := if(Left.awd710_1_0_reason1 <> right.awd710_1_0_reason1, Right.awd710_1_0_reason1, ''),
self.awd710_1_0_reason2 := if(Left.awd710_1_0_reason2 <> right.awd710_1_0_reason2, Right.awd710_1_0_reason2, ''),
self.awd710_1_0_reason3 := if(Left.awd710_1_0_reason3 <> right.awd710_1_0_reason3, Right.awd710_1_0_reason3, ''),
self.awd710_1_0_reason4 := if(Left.awd710_1_0_reason4 <> right.awd710_1_0_reason4, Right.awd710_1_0_reason4, ''),
// self.awn510_0_0_score := if(Left.awn510_0_0_score <> right.awn510_0_0_score, Right.awn510_0_0_score, ''),             //These were removed from layout as they did not output
// self.awn510_0_0_reason1 := if(Left.awn510_0_0_reason1 <> right.awn510_0_0_reason1, Right.awn510_0_0_reason1, ''),
// self.awn510_0_0_reason2 := if(Left.awn510_0_0_reason2 <> right.awn510_0_0_reason2, Right.awn510_0_0_reason2, ''),
// self.awn510_0_0_reason3 := if(Left.awn510_0_0_reason3 <> right.awn510_0_0_reason3, Right.awn510_0_0_reason3, ''),
// self.awn510_0_0_reason4 := if(Left.awn510_0_0_reason4 <> right.awn510_0_0_reason4, Right.awn510_0_0_reason4, ''),
// self.awn603_1_0_score := if(Left.awn603_1_0_score <> right.awn603_1_0_score, Right.awn603_1_0_score, ''),
// self.awn603_1_0_reason1 := if(Left.awn603_1_0_reason1 <> right.awn603_1_0_reason1, Right.awn603_1_0_reason1, ''),
// self.awn603_1_0_reason2 := if(Left.awn603_1_0_reason2 <> right.awn603_1_0_reason2, Right.awn603_1_0_reason2, ''),
// self.awn603_1_0_reason3 := if(Left.awn603_1_0_reason3 <> right.awn603_1_0_reason3, Right.awn603_1_0_reason3, ''),
// self.awn603_1_0_reason4 := if(Left.awn603_1_0_reason4 <> right.awn603_1_0_reason4, Right.awn603_1_0_reason4, ''),
// self.bd3605_0_0_score := if(Left.bd3605_0_0_score <> right.bd3605_0_0_score, Right.bd3605_0_0_score, ''),
// self.bd3605_0_0_reason1 := if(Left.bd3605_0_0_reason1 <> right.bd3605_0_0_reason1, Right.bd3605_0_0_reason1, ''),
// self.bd3605_0_0_reason2 := if(Left.bd3605_0_0_reason2 <> right.bd3605_0_0_reason2, Right.bd3605_0_0_reason2, ''),
// self.bd3605_0_0_reason3 := if(Left.bd3605_0_0_reason3 <> right.bd3605_0_0_reason3, Right.bd3605_0_0_reason3, ''),
// self.bd3605_0_0_reason4 := if(Left.bd3605_0_0_reason4 <> right.bd3605_0_0_reason4, Right.bd3605_0_0_reason4, ''),
// self.bd5605_0_0_score := if(Left.bd5605_0_0_score <> right.bd5605_0_0_score, Right.bd5605_0_0_score, ''),
// self.bd5605_0_0_reason1 := if(Left.bd5605_0_0_reason1 <> right.bd5605_0_0_reason1, Right.bd5605_0_0_reason1, ''),
// self.bd5605_0_0_reason2 := if(Left.bd5605_0_0_reason2 <> right.bd5605_0_0_reason2, Right.bd5605_0_0_reason2, ''),
// self.bd5605_0_0_reason3 := if(Left.bd5605_0_0_reason3 <> right.bd5605_0_0_reason3, Right.bd5605_0_0_reason3, ''),
// self.bd5605_0_0_reason4 := if(Left.bd5605_0_0_reason4 <> right.bd5605_0_0_reason4, Right.bd5605_0_0_reason4, ''),
// self.bd5605_1_0_score := if(Left.bd5605_1_0_score <> right.bd5605_1_0_score, Right.bd5605_1_0_score, ''),
// self.bd5605_1_0_reason1 := if(Left.bd5605_1_0_reason1 <> right.bd5605_1_0_reason1, Right.bd5605_1_0_reason1, ''),
// self.bd5605_1_0_reason2 := if(Left.bd5605_1_0_reason2 <> right.bd5605_1_0_reason2, Right.bd5605_1_0_reason2, ''),
// self.bd5605_1_0_reason3 := if(Left.bd5605_1_0_reason3 <> right.bd5605_1_0_reason3, Right.bd5605_1_0_reason3, ''),
// self.bd5605_1_0_reason4 := if(Left.bd5605_1_0_reason4 <> right.bd5605_1_0_reason4, Right.bd5605_1_0_reason4, ''),
// self.bd5605_2_0_score := if(Left.bd5605_2_0_score <> right.bd5605_2_0_score, Right.bd5605_2_0_score, ''),
// self.bd5605_2_0_reason1 := if(Left.bd5605_2_0_reason1 <> right.bd5605_2_0_reason1, Right.bd5605_2_0_reason1, ''),
// self.bd5605_2_0_reason2 := if(Left.bd5605_2_0_reason2 <> right.bd5605_2_0_reason2, Right.bd5605_2_0_reason2, ''),
// self.bd5605_2_0_reason3 := if(Left.bd5605_2_0_reason3 <> right.bd5605_2_0_reason3, Right.bd5605_2_0_reason3, ''),
// self.bd5605_2_0_reason4 := if(Left.bd5605_2_0_reason4 <> right.bd5605_2_0_reason4, Right.bd5605_2_0_reason4, ''),
// self.bd5605_3_0_score := if(Left.bd5605_3_0_score <> right.bd5605_3_0_score, Right.bd5605_3_0_score, ''),
// self.bd5605_3_0_reason1 := if(Left.bd5605_3_0_reason1 <> right.bd5605_3_0_reason1, Right.bd5605_3_0_reason1, ''),
// self.bd5605_3_0_reason2 := if(Left.bd5605_3_0_reason2 <> right.bd5605_3_0_reason2, Right.bd5605_3_0_reason2, ''),
// self.bd5605_3_0_reason3 := if(Left.bd5605_3_0_reason3 <> right.bd5605_3_0_reason3, Right.bd5605_3_0_reason3, ''),
// self.bd5605_3_0_reason4 := if(Left.bd5605_3_0_reason4 <> right.bd5605_3_0_reason4, Right.bd5605_3_0_reason4, ''),
// self.bd9605_0_0_score := if(Left.bd9605_0_0_score <> right.bd9605_0_0_score, Right.bd9605_0_0_score, ''),
// self.bd9605_0_0_reason1 := if(Left.bd9605_0_0_reason1 <> right.bd9605_0_0_reason1, Right.bd9605_0_0_reason1, ''),
// self.bd9605_0_0_reason2 := if(Left.bd9605_0_0_reason2 <> right.bd9605_0_0_reason2, Right.bd9605_0_0_reason2, ''),
// self.bd9605_0_0_reason3 := if(Left.bd9605_0_0_reason3 <> right.bd9605_0_0_reason3, Right.bd9605_0_0_reason3, ''),
// self.bd9605_0_0_reason4 := if(Left.bd9605_0_0_reason4 <> right.bd9605_0_0_reason4, Right.bd9605_0_0_reason4, ''),
// self.bd9605_1_0_score := if(Left.bd9605_1_0_score <> right.bd9605_1_0_score, Right.bd9605_1_0_score, ''),
// self.bd9605_1_0_reason1 := if(Left.bd9605_1_0_reason1 <> right.bd9605_1_0_reason1, Right.bd9605_1_0_reason1, ''),
// self.bd9605_1_0_reason2 := if(Left.bd9605_1_0_reason2 <> right.bd9605_1_0_reason2, Right.bd9605_1_0_reason2, ''),
// self.bd9605_1_0_reason3 := if(Left.bd9605_1_0_reason3 <> right.bd9605_1_0_reason3, Right.bd9605_1_0_reason3, ''),
// self.bd9605_1_0_reason4 := if(Left.bd9605_1_0_reason4 <> right.bd9605_1_0_reason4, Right.bd9605_1_0_reason4, ''),
// self.cdn1109_1_0_score := if(Left.cdn1109_1_0_score <> right.cdn1109_1_0_score, Right.cdn1109_1_0_score, ''),
// self.cdn1109_1_0_reason1 := if(Left.cdn1109_1_0_reason1 <> right.cdn1109_1_0_reason1, Right.cdn1109_1_0_reason1, ''),
// self.cdn1109_1_0_reason2 := if(Left.cdn1109_1_0_reason2 <> right.cdn1109_1_0_reason2, Right.cdn1109_1_0_reason2, ''),
// self.cdn1109_1_0_reason3 := if(Left.cdn1109_1_0_reason3 <> right.cdn1109_1_0_reason3, Right.cdn1109_1_0_reason3, ''),
// self.cdn1109_1_0_reason4 := if(Left.cdn1109_1_0_reason4 <> right.cdn1109_1_0_reason4, Right.cdn1109_1_0_reason4, ''),
// self.cdn1205_1_0_score := if(Left.cdn1205_1_0_score <> right.cdn1205_1_0_score, Right.cdn1205_1_0_score, ''),
// self.cdn1205_1_0_reason1 := if(Left.cdn1205_1_0_reason1 <> right.cdn1205_1_0_reason1, Right.cdn1205_1_0_reason1, ''),
// self.cdn1205_1_0_reason2 := if(Left.cdn1205_1_0_reason2 <> right.cdn1205_1_0_reason2, Right.cdn1205_1_0_reason2, ''),
// self.cdn1205_1_0_reason3 := if(Left.cdn1205_1_0_reason3 <> right.cdn1205_1_0_reason3, Right.cdn1205_1_0_reason3, ''),
// self.cdn1205_1_0_reason4 := if(Left.cdn1205_1_0_reason4 <> right.cdn1205_1_0_reason4, Right.cdn1205_1_0_reason4, ''),
// self.cdn1305_1_0_score := if(Left.cdn1305_1_0_score <> right.cdn1305_1_0_score, Right.cdn1305_1_0_score, ''),
// self.cdn1305_1_0_reason1 := if(Left.cdn1305_1_0_reason1 <> right.cdn1305_1_0_reason1, Right.cdn1305_1_0_reason1, ''),
// self.cdn1305_1_0_reason2 := if(Left.cdn1305_1_0_reason2 <> right.cdn1305_1_0_reason2, Right.cdn1305_1_0_reason2, ''),
// self.cdn1305_1_0_reason3 := if(Left.cdn1305_1_0_reason3 <> right.cdn1305_1_0_reason3, Right.cdn1305_1_0_reason3, ''),
// self.cdn1305_1_0_reason4 := if(Left.cdn1305_1_0_reason4 <> right.cdn1305_1_0_reason4, Right.cdn1305_1_0_reason4, ''),
// self.cdn1404_1_0_score := if(Left.cdn1404_1_0_score <> right.cdn1404_1_0_score, Right.cdn1404_1_0_score, ''),
// self.cdn1404_1_0_reason1 := if(Left.cdn1404_1_0_reason1 <> right.cdn1404_1_0_reason1, Right.cdn1404_1_0_reason1, ''),
// self.cdn1404_1_0_reason2 := if(Left.cdn1404_1_0_reason2 <> right.cdn1404_1_0_reason2, Right.cdn1404_1_0_reason2, ''),
// self.cdn1404_1_0_reason3 := if(Left.cdn1404_1_0_reason3 <> right.cdn1404_1_0_reason3, Right.cdn1404_1_0_reason3, ''),
// self.cdn1404_1_0_reason4 := if(Left.cdn1404_1_0_reason4 <> right.cdn1404_1_0_reason4, Right.cdn1404_1_0_reason4, ''),
// self.cdn1410_1_0_score := if(Left.cdn1410_1_0_score <> right.cdn1410_1_0_score, Right.cdn1410_1_0_score, ''),
// self.cdn1410_1_0_reason1 := if(Left.cdn1410_1_0_reason1 <> right.cdn1410_1_0_reason1, Right.cdn1410_1_0_reason1, ''),
// self.cdn1410_1_0_reason2 := if(Left.cdn1410_1_0_reason2 <> right.cdn1410_1_0_reason2, Right.cdn1410_1_0_reason2, ''),
// self.cdn1410_1_0_reason3 := if(Left.cdn1410_1_0_reason3 <> right.cdn1410_1_0_reason3, Right.cdn1410_1_0_reason3, ''),
// self.cdn1410_1_0_reason4 := if(Left.cdn1410_1_0_reason4 <> right.cdn1410_1_0_reason4, Right.cdn1410_1_0_reason4, ''),
// self.cdn1506_1_0_score := if(Left.cdn1506_1_0_score <> right.cdn1506_1_0_score, Right.cdn1506_1_0_score, ''),
// self.cdn1506_1_0_reason1 := if(Left.cdn1506_1_0_reason1 <> right.cdn1506_1_0_reason1, Right.cdn1506_1_0_reason1, ''),
// self.cdn1506_1_0_reason2 := if(Left.cdn1506_1_0_reason2 <> right.cdn1506_1_0_reason2, Right.cdn1506_1_0_reason2, ''),
// self.cdn1506_1_0_reason3 := if(Left.cdn1506_1_0_reason3 <> right.cdn1506_1_0_reason3, Right.cdn1506_1_0_reason3, ''),
// self.cdn1506_1_0_reason4 := if(Left.cdn1506_1_0_reason4 <> right.cdn1506_1_0_reason4, Right.cdn1506_1_0_reason4, ''),
// self.cdn1508_1_0_score := if(Left.cdn1508_1_0_score <> right.cdn1508_1_0_score, Right.cdn1508_1_0_score, ''),
// self.cdn1508_1_0_reason1 := if(Left.cdn1508_1_0_reason1 <> right.cdn1508_1_0_reason1, Right.cdn1508_1_0_reason1, ''),
// self.cdn1508_1_0_reason2 := if(Left.cdn1508_1_0_reason2 <> right.cdn1508_1_0_reason2, Right.cdn1508_1_0_reason2, ''),
// self.cdn1508_1_0_reason3 := if(Left.cdn1508_1_0_reason3 <> right.cdn1508_1_0_reason3, Right.cdn1508_1_0_reason3, ''),
// self.cdn1508_1_0_reason4 := if(Left.cdn1508_1_0_reason4 <> right.cdn1508_1_0_reason4, Right.cdn1508_1_0_reason4, ''),
// self.cdn1508_1_0_reason5 := if(Left.cdn1508_1_0_reason5 <> right.cdn1508_1_0_reason5, Right.cdn1508_1_0_reason5, ''),
// self.cdn1508_1_0_reason6 := if(Left.cdn1508_1_0_reason6 <> right.cdn1508_1_0_reason6, Right.cdn1508_1_0_reason6, ''),
// self.osn1504_0_0_score := if(Left.osn1504_0_0_score <> right.osn1504_0_0_score, Right.osn1504_0_0_score, ''),
// self.osn1504_0_0_reason1 := if(Left.osn1504_0_0_reason1 <> right.osn1504_0_0_reason1, Right.osn1504_0_0_reason1, ''),
// self.osn1504_0_0_reason2 := if(Left.osn1504_0_0_reason2 <> right.osn1504_0_0_reason2, Right.osn1504_0_0_reason2, ''),
// self.osn1504_0_0_reason3 := if(Left.osn1504_0_0_reason3 <> right.osn1504_0_0_reason3, Right.osn1504_0_0_reason3, ''),
// self.osn1504_0_0_reason4 := if(Left.osn1504_0_0_reason4 <> right.osn1504_0_0_reason4, Right.osn1504_0_0_reason4, ''),
// self.osn1504_0_0_reason5 := if(Left.osn1504_0_0_reason5 <> right.osn1504_0_0_reason5, Right.osn1504_0_0_reason5, ''),
// self.osn1504_0_0_reason6 := if(Left.osn1504_0_0_reason6 <> right.osn1504_0_0_reason6, Right.osn1504_0_0_reason6, ''),
// self.osn1608_1_0_score := if(Left.osn1608_1_0_score <> right.osn1608_1_0_score, Right.osn1608_1_0_score, ''),
// self.osn1608_1_0_reason1 := if(Left.osn1608_1_0_reason1 <> right.osn1608_1_0_reason1, Right.osn1608_1_0_reason1, ''),
// self.osn1608_1_0_reason2 := if(Left.osn1608_1_0_reason2 <> right.osn1608_1_0_reason2, Right.osn1608_1_0_reason2, ''),
// self.osn1608_1_0_reason3 := if(Left.osn1608_1_0_reason3 <> right.osn1608_1_0_reason3, Right.osn1608_1_0_reason3, ''),
// self.osn1608_1_0_reason4 := if(Left.osn1608_1_0_reason4 <> right.osn1608_1_0_reason4, Right.osn1608_1_0_reason4, ''),
// self.osn1608_1_0_reason5 := if(Left.osn1608_1_0_reason5 <> right.osn1608_1_0_reason5, Right.osn1608_1_0_reason5, ''),
// self.osn1608_1_0_reason6 := if(Left.osn1608_1_0_reason6 <> right.osn1608_1_0_reason6, Right.osn1608_1_0_reason6, ''),
// self.cdn604_0_0_score := if(Left.cdn604_0_0_score <> right.cdn604_0_0_score, Right.cdn604_0_0_score, ''),
// self.cdn604_0_0_reason1 := if(Left.cdn604_0_0_reason1 <> right.cdn604_0_0_reason1, Right.cdn604_0_0_reason1, ''),
// self.cdn604_0_0_reason2 := if(Left.cdn604_0_0_reason2 <> right.cdn604_0_0_reason2, Right.cdn604_0_0_reason2, ''),
// self.cdn604_0_0_reason3 := if(Left.cdn604_0_0_reason3 <> right.cdn604_0_0_reason3, Right.cdn604_0_0_reason3, ''),
// self.cdn604_0_0_reason4 := if(Left.cdn604_0_0_reason4 <> right.cdn604_0_0_reason4, Right.cdn604_0_0_reason4, ''),
// self.cdn604_1_0_score := if(Left.cdn604_1_0_score <> right.cdn604_1_0_score, Right.cdn604_1_0_score, ''),
// self.cdn604_2_0_score := if(Left.cdn604_2_0_score <> right.cdn604_2_0_score, Right.cdn604_2_0_score, ''),
// self.cdn604_2_0_reason1 := if(Left.cdn604_2_0_reason1 <> right.cdn604_2_0_reason1, Right.cdn604_2_0_reason1, ''),
// self.cdn604_2_0_reason2 := if(Left.cdn604_2_0_reason2 <> right.cdn604_2_0_reason2, Right.cdn604_2_0_reason2, ''),
// self.cdn604_2_0_reason3 := if(Left.cdn604_2_0_reason3 <> right.cdn604_2_0_reason3, Right.cdn604_2_0_reason3, ''),
// self.cdn604_2_0_reason4 := if(Left.cdn604_2_0_reason4 <> right.cdn604_2_0_reason4, Right.cdn604_2_0_reason4, ''),
// self.cdn604_3_0_score := if(Left.cdn604_3_0_score <> right.cdn604_3_0_score, Right.cdn604_3_0_score, ''),
// self.cdn604_3_0_reason1 := if(Left.cdn604_3_0_reason1 <> right.cdn604_3_0_reason1, Right.cdn604_3_0_reason1, ''),
// self.cdn604_3_0_reason2 := if(Left.cdn604_3_0_reason2 <> right.cdn604_3_0_reason2, Right.cdn604_3_0_reason2, ''),
// self.cdn604_3_0_reason3 := if(Left.cdn604_3_0_reason3 <> right.cdn604_3_0_reason3, Right.cdn604_3_0_reason3, ''),
// self.cdn604_3_0_reason4 := if(Left.cdn604_3_0_reason4 <> right.cdn604_3_0_reason4, Right.cdn604_3_0_reason4, ''),
// self.cdn604_4_0_score := if(Left.cdn604_4_0_score <> right.cdn604_4_0_score, Right.cdn604_4_0_score, ''),
// self.cdn604_4_0_reason1 := if(Left.cdn604_4_0_reason1 <> right.cdn604_4_0_reason1, Right.cdn604_4_0_reason1, ''),
// self.cdn604_4_0_reason2 := if(Left.cdn604_4_0_reason2 <> right.cdn604_4_0_reason2, Right.cdn604_4_0_reason2, ''),
// self.cdn604_4_0_reason3 := if(Left.cdn604_4_0_reason3 <> right.cdn604_4_0_reason3, Right.cdn604_4_0_reason3, ''),
// self.cdn604_4_0_reason4 := if(Left.cdn604_4_0_reason4 <> right.cdn604_4_0_reason4, Right.cdn604_4_0_reason4, ''),
// self.cdn605_1_0_score := if(Left.cdn605_1_0_score <> right.cdn605_1_0_score, Right.cdn605_1_0_score, ''),
// self.cdn605_1_0_reason1 := if(Left.cdn605_1_0_reason1 <> right.cdn605_1_0_reason1, Right.cdn605_1_0_reason1, ''),
// self.cdn605_1_0_reason2 := if(Left.cdn605_1_0_reason2 <> right.cdn605_1_0_reason2, Right.cdn605_1_0_reason2, ''),
// self.cdn605_1_0_reason3 := if(Left.cdn605_1_0_reason3 <> right.cdn605_1_0_reason3, Right.cdn605_1_0_reason3, ''),
// self.cdn605_1_0_reason4 := if(Left.cdn605_1_0_reason4 <> right.cdn605_1_0_reason4, Right.cdn605_1_0_reason4, ''),
// self.cdn606_2_0_score := if(Left.cdn606_2_0_score <> right.cdn606_2_0_score, Right.cdn606_2_0_score, ''),
// self.cdn606_2_0_reason1 := if(Left.cdn606_2_0_reason1 <> right.cdn606_2_0_reason1, Right.cdn606_2_0_reason1, ''),
// self.cdn606_2_0_reason2 := if(Left.cdn606_2_0_reason2 <> right.cdn606_2_0_reason2, Right.cdn606_2_0_reason2, ''),
// self.cdn606_2_0_reason3 := if(Left.cdn606_2_0_reason3 <> right.cdn606_2_0_reason3, Right.cdn606_2_0_reason3, ''),
// self.cdn606_2_0_reason4 := if(Left.cdn606_2_0_reason4 <> right.cdn606_2_0_reason4, Right.cdn606_2_0_reason4, ''),
// self.cdn706_1_0_score := if(Left.cdn706_1_0_score <> right.cdn706_1_0_score, Right.cdn706_1_0_score, ''),
// self.cdn706_1_0_bt_reason1 := if(Left.cdn706_1_0_bt_reason1 <> right.cdn706_1_0_bt_reason1, Right.cdn706_1_0_bt_reason1, ''),
// self.cdn706_1_0_bt_reason2 := if(Left.cdn706_1_0_bt_reason2 <> right.cdn706_1_0_bt_reason2, Right.cdn706_1_0_bt_reason2, ''),
// self.cdn706_1_0_bt_reason3 := if(Left.cdn706_1_0_bt_reason3 <> right.cdn706_1_0_bt_reason3, Right.cdn706_1_0_bt_reason3, ''),
// self.cdn706_1_0_bt_reason4 := if(Left.cdn706_1_0_bt_reason4 <> right.cdn706_1_0_bt_reason4, Right.cdn706_1_0_bt_reason4, ''),
// self.cdn706_1_0_st_reason1 := if(Left.cdn706_1_0_st_reason1 <> right.cdn706_1_0_st_reason1, Right.cdn706_1_0_st_reason1, ''),
// self.cdn706_1_0_st_reason2 := if(Left.cdn706_1_0_st_reason2 <> right.cdn706_1_0_st_reason2, Right.cdn706_1_0_st_reason2, ''),
// self.cdn706_1_0_st_reason3 := if(Left.cdn706_1_0_st_reason3 <> right.cdn706_1_0_st_reason3, Right.cdn706_1_0_st_reason3, ''),
// self.cdn706_1_0_st_reason4 := if(Left.cdn706_1_0_st_reason4 <> right.cdn706_1_0_st_reason4, Right.cdn706_1_0_st_reason4, ''),
// self.cdn707_1_0_score := if(Left.cdn707_1_0_score <> right.cdn707_1_0_score, Right.cdn707_1_0_score, ''),
// self.cdn707_1_0_reason1 := if(Left.cdn707_1_0_reason1 <> right.cdn707_1_0_reason1, Right.cdn707_1_0_reason1, ''),
// self.cdn707_1_0_reason2 := if(Left.cdn707_1_0_reason2 <> right.cdn707_1_0_reason2, Right.cdn707_1_0_reason2, ''),
// self.cdn707_1_0_reason3 := if(Left.cdn707_1_0_reason3 <> right.cdn707_1_0_reason3, Right.cdn707_1_0_reason3, ''),
// self.cdn707_1_0_reason4 := if(Left.cdn707_1_0_reason4 <> right.cdn707_1_0_reason4, Right.cdn707_1_0_reason4, ''),
// self.cdn712_0_0_score := if(Left.cdn712_0_0_score <> right.cdn712_0_0_score, Right.cdn712_0_0_score, ''),
// self.cdn712_0_0_reason1 := if(Left.cdn712_0_0_reason1 <> right.cdn712_0_0_reason1, Right.cdn712_0_0_reason1, ''),
// self.cdn712_0_0_reason2 := if(Left.cdn712_0_0_reason2 <> right.cdn712_0_0_reason2, Right.cdn712_0_0_reason2, ''),
// self.cdn712_0_0_reason3 := if(Left.cdn712_0_0_reason3 <> right.cdn712_0_0_reason3, Right.cdn712_0_0_reason3, ''),
// self.cdn712_0_0_reason4 := if(Left.cdn712_0_0_reason4 <> right.cdn712_0_0_reason4, Right.cdn712_0_0_reason4, ''),
// self.cdn806_1_0_score := if(Left.cdn806_1_0_score <> right.cdn806_1_0_score, Right.cdn806_1_0_score, ''),
// self.cdn806_1_0_reason1 := if(Left.cdn806_1_0_reason1 <> right.cdn806_1_0_reason1, Right.cdn806_1_0_reason1, ''),
// self.cdn806_1_0_reason2 := if(Left.cdn806_1_0_reason2 <> right.cdn806_1_0_reason2, Right.cdn806_1_0_reason2, ''),
// self.cdn806_1_0_reason3 := if(Left.cdn806_1_0_reason3 <> right.cdn806_1_0_reason3, Right.cdn806_1_0_reason3, ''),
// self.cdn806_1_0_reason4 := if(Left.cdn806_1_0_reason4 <> right.cdn806_1_0_reason4, Right.cdn806_1_0_reason4, ''),
// self.cdn908_1_0_score := if(Left.cdn908_1_0_score <> right.cdn908_1_0_score, Right.cdn908_1_0_score, ''),
// self.cdn908_1_0_reason1 := if(Left.cdn908_1_0_reason1 <> right.cdn908_1_0_reason1, Right.cdn908_1_0_reason1, ''),
// self.cdn908_1_0_reason2 := if(Left.cdn908_1_0_reason2 <> right.cdn908_1_0_reason2, Right.cdn908_1_0_reason2, ''),
// self.cdn908_1_0_reason3 := if(Left.cdn908_1_0_reason3 <> right.cdn908_1_0_reason3, Right.cdn908_1_0_reason3, ''),
// self.cdn908_1_0_reason4 := if(Left.cdn908_1_0_reason4 <> right.cdn908_1_0_reason4, Right.cdn908_1_0_reason4, ''),
// self.cen509_0_0_score := if(Left.cen509_0_0_score <> right.cen509_0_0_score, Right.cen509_0_0_score, ''),
// self.csn1007_0_0_score := if(Left.csn1007_0_0_score <> right.csn1007_0_0_score, Right.csn1007_0_0_score, ''),
// self.fd3510_0_0_score := if(Left.fd3510_0_0_score <> right.fd3510_0_0_score, Right.fd3510_0_0_score, ''),
// self.fd3510_0_0_reason1 := if(Left.fd3510_0_0_reason1 <> right.fd3510_0_0_reason1, Right.fd3510_0_0_reason1, ''),
// self.fd3510_0_0_reason2 := if(Left.fd3510_0_0_reason2 <> right.fd3510_0_0_reason2, Right.fd3510_0_0_reason2, ''),
// self.fd3510_0_0_reason3 := if(Left.fd3510_0_0_reason3 <> right.fd3510_0_0_reason3, Right.fd3510_0_0_reason3, ''),
// self.fd3510_0_0_reason4 := if(Left.fd3510_0_0_reason4 <> right.fd3510_0_0_reason4, Right.fd3510_0_0_reason4, ''),
// self.fd3606_0_0_score := if(Left.fd3606_0_0_score <> right.fd3606_0_0_score, Right.fd3606_0_0_score, ''),
// self.fd3606_0_0_reason1 := if(Left.fd3606_0_0_reason1 <> right.fd3606_0_0_reason1, Right.fd3606_0_0_reason1, ''),
// self.fd3606_0_0_reason2 := if(Left.fd3606_0_0_reason2 <> right.fd3606_0_0_reason2, Right.fd3606_0_0_reason2, ''),
// self.fd3606_0_0_reason3 := if(Left.fd3606_0_0_reason3 <> right.fd3606_0_0_reason3, Right.fd3606_0_0_reason3, ''),
// self.fd3606_0_0_reason4 := if(Left.fd3606_0_0_reason4 <> right.fd3606_0_0_reason4, Right.fd3606_0_0_reason4, ''),
// self.fd5510_0_0_score := if(Left.fd5510_0_0_score <> right.fd5510_0_0_score, Right.fd5510_0_0_score, ''),
// self.fd5510_0_0_reason1 := if(Left.fd5510_0_0_reason1 <> right.fd5510_0_0_reason1, Right.fd5510_0_0_reason1, ''),
// self.fd5510_0_0_reason2 := if(Left.fd5510_0_0_reason2 <> right.fd5510_0_0_reason2, Right.fd5510_0_0_reason2, ''),
// self.fd5510_0_0_reason3 := if(Left.fd5510_0_0_reason3 <> right.fd5510_0_0_reason3, Right.fd5510_0_0_reason3, ''),
// self.fd5510_0_0_reason4 := if(Left.fd5510_0_0_reason4 <> right.fd5510_0_0_reason4, Right.fd5510_0_0_reason4, ''),
// self.fd5603_1_0_score := if(Left.fd5603_1_0_score <> right.fd5603_1_0_score, Right.fd5603_1_0_score, ''),
// self.fd5603_1_0_reason1 := if(Left.fd5603_1_0_reason1 <> right.fd5603_1_0_reason1, Right.fd5603_1_0_reason1, ''),
// self.fd5603_1_0_reason2 := if(Left.fd5603_1_0_reason2 <> right.fd5603_1_0_reason2, Right.fd5603_1_0_reason2, ''),
// self.fd5603_1_0_reason3 := if(Left.fd5603_1_0_reason3 <> right.fd5603_1_0_reason3, Right.fd5603_1_0_reason3, ''),
// self.fd5603_1_0_reason4 := if(Left.fd5603_1_0_reason4 <> right.fd5603_1_0_reason4, Right.fd5603_1_0_reason4, ''),
// self.fd5603_2_0_score := if(Left.fd5603_2_0_score <> right.fd5603_2_0_score, Right.fd5603_2_0_score, ''),
// self.fd5603_2_0_reason1 := if(Left.fd5603_2_0_reason1 <> right.fd5603_2_0_reason1, Right.fd5603_2_0_reason1, ''),
// self.fd5603_2_0_reason2 := if(Left.fd5603_2_0_reason2 <> right.fd5603_2_0_reason2, Right.fd5603_2_0_reason2, ''),
// self.fd5603_2_0_reason3 := if(Left.fd5603_2_0_reason3 <> right.fd5603_2_0_reason3, Right.fd5603_2_0_reason3, ''),
// self.fd5603_2_0_reason4 := if(Left.fd5603_2_0_reason4 <> right.fd5603_2_0_reason4, Right.fd5603_2_0_reason4, ''),
// self.fd5603_3_0_score := if(Left.fd5603_3_0_score <> right.fd5603_3_0_score, Right.fd5603_3_0_score, ''),
// self.fd5603_3_0_reason1 := if(Left.fd5603_3_0_reason1 <> right.fd5603_3_0_reason1, Right.fd5603_3_0_reason1, ''),
// self.fd5603_3_0_reason2 := if(Left.fd5603_3_0_reason2 <> right.fd5603_3_0_reason2, Right.fd5603_3_0_reason2, ''),
// self.fd5603_3_0_reason3 := if(Left.fd5603_3_0_reason3 <> right.fd5603_3_0_reason3, Right.fd5603_3_0_reason3, ''),
// self.fd5603_3_0_reason4 := if(Left.fd5603_3_0_reason4 <> right.fd5603_3_0_reason4, Right.fd5603_3_0_reason4, ''),
// self.fd5607_1_0_score := if(Left.fd5607_1_0_score <> right.fd5607_1_0_score, Right.fd5607_1_0_score, ''),
// self.fd5607_1_0_reason1 := if(Left.fd5607_1_0_reason1 <> right.fd5607_1_0_reason1, Right.fd5607_1_0_reason1, ''),
// self.fd5607_1_0_reason2 := if(Left.fd5607_1_0_reason2 <> right.fd5607_1_0_reason2, Right.fd5607_1_0_reason2, ''),
// self.fd5607_1_0_reason3 := if(Left.fd5607_1_0_reason3 <> right.fd5607_1_0_reason3, Right.fd5607_1_0_reason3, ''),
// self.fd5607_1_0_reason4 := if(Left.fd5607_1_0_reason4 <> right.fd5607_1_0_reason4, Right.fd5607_1_0_reason4, ''),
// self.fd5609_1_0_score := if(Left.fd5609_1_0_score <> right.fd5609_1_0_score, Right.fd5609_1_0_score, ''),
// self.fd5609_1_0_reason1 := if(Left.fd5609_1_0_reason1 <> right.fd5609_1_0_reason1, Right.fd5609_1_0_reason1, ''),
// self.fd5609_1_0_reason2 := if(Left.fd5609_1_0_reason2 <> right.fd5609_1_0_reason2, Right.fd5609_1_0_reason2, ''),
// self.fd5609_1_0_reason3 := if(Left.fd5609_1_0_reason3 <> right.fd5609_1_0_reason3, Right.fd5609_1_0_reason3, ''),
// self.fd5609_1_0_reason4 := if(Left.fd5609_1_0_reason4 <> right.fd5609_1_0_reason4, Right.fd5609_1_0_reason4, ''),
// self.fd5609_2_0_score := if(Left.fd5609_2_0_score <> right.fd5609_2_0_score, Right.fd5609_2_0_score, ''),
// self.fd5609_2_0_reason1 := if(Left.fd5609_2_0_reason1 <> right.fd5609_2_0_reason1, Right.fd5609_2_0_reason1, ''),
// self.fd5609_2_0_reason2 := if(Left.fd5609_2_0_reason2 <> right.fd5609_2_0_reason2, Right.fd5609_2_0_reason2, ''),
// self.fd5609_2_0_reason3 := if(Left.fd5609_2_0_reason3 <> right.fd5609_2_0_reason3, Right.fd5609_2_0_reason3, ''),
// self.fd5609_2_0_reason4 := if(Left.fd5609_2_0_reason4 <> right.fd5609_2_0_reason4, Right.fd5609_2_0_reason4, ''),
// self.fd5709_1_0_score := if(Left.fd5709_1_0_score <> right.fd5709_1_0_score, Right.fd5709_1_0_score, ''),
// self.fd5709_1_0_reason1 := if(Left.fd5709_1_0_reason1 <> right.fd5709_1_0_reason1, Right.fd5709_1_0_reason1, ''),
// self.fd5709_1_0_reason2 := if(Left.fd5709_1_0_reason2 <> right.fd5709_1_0_reason2, Right.fd5709_1_0_reason2, ''),
// self.fd5709_1_0_reason3 := if(Left.fd5709_1_0_reason3 <> right.fd5709_1_0_reason3, Right.fd5709_1_0_reason3, ''),
// self.fd5709_1_0_reason4 := if(Left.fd5709_1_0_reason4 <> right.fd5709_1_0_reason4, Right.fd5709_1_0_reason4, ''),
// self.fd9510_0_0_score := if(Left.fd9510_0_0_score <> right.fd9510_0_0_score, Right.fd9510_0_0_score, ''),
// self.fd9510_0_0_reason1 := if(Left.fd9510_0_0_reason1 <> right.fd9510_0_0_reason1, Right.fd9510_0_0_reason1, ''),
// self.fd9510_0_0_reason2 := if(Left.fd9510_0_0_reason2 <> right.fd9510_0_0_reason2, Right.fd9510_0_0_reason2, ''),
// self.fd9510_0_0_reason3 := if(Left.fd9510_0_0_reason3 <> right.fd9510_0_0_reason3, Right.fd9510_0_0_reason3, ''),
// self.fd9510_0_0_reason4 := if(Left.fd9510_0_0_reason4 <> right.fd9510_0_0_reason4, Right.fd9510_0_0_reason4, ''),
// self.fd9603_1_0_score := if(Left.fd9603_1_0_score <> right.fd9603_1_0_score, Right.fd9603_1_0_score, ''),
// self.fd9603_1_0_reason1 := if(Left.fd9603_1_0_reason1 <> right.fd9603_1_0_reason1, Right.fd9603_1_0_reason1, ''),
// self.fd9603_1_0_reason2 := if(Left.fd9603_1_0_reason2 <> right.fd9603_1_0_reason2, Right.fd9603_1_0_reason2, ''),
// self.fd9603_1_0_reason3 := if(Left.fd9603_1_0_reason3 <> right.fd9603_1_0_reason3, Right.fd9603_1_0_reason3, ''),
// self.fd9603_1_0_reason4 := if(Left.fd9603_1_0_reason4 <> right.fd9603_1_0_reason4, Right.fd9603_1_0_reason4, ''),
// self.fd9603_2_0_score := if(Left.fd9603_2_0_score <> right.fd9603_2_0_score, Right.fd9603_2_0_score, ''),
// self.fd9603_2_0_reason1 := if(Left.fd9603_2_0_reason1 <> right.fd9603_2_0_reason1, Right.fd9603_2_0_reason1, ''),
// self.fd9603_2_0_reason2 := if(Left.fd9603_2_0_reason2 <> right.fd9603_2_0_reason2, Right.fd9603_2_0_reason2, ''),
// self.fd9603_2_0_reason3 := if(Left.fd9603_2_0_reason3 <> right.fd9603_2_0_reason3, Right.fd9603_2_0_reason3, ''),
// self.fd9603_2_0_reason4 := if(Left.fd9603_2_0_reason4 <> right.fd9603_2_0_reason4, Right.fd9603_2_0_reason4, ''),
// self.fd9603_3_0_score := if(Left.fd9603_3_0_score <> right.fd9603_3_0_score, Right.fd9603_3_0_score, ''),
// self.fd9603_3_0_reason1 := if(Left.fd9603_3_0_reason1 <> right.fd9603_3_0_reason1, Right.fd9603_3_0_reason1, ''),
// self.fd9603_3_0_reason2 := if(Left.fd9603_3_0_reason2 <> right.fd9603_3_0_reason2, Right.fd9603_3_0_reason2, ''),
// self.fd9603_3_0_reason3 := if(Left.fd9603_3_0_reason3 <> right.fd9603_3_0_reason3, Right.fd9603_3_0_reason3, ''),
// self.fd9603_3_0_reason4 := if(Left.fd9603_3_0_reason4 <> right.fd9603_3_0_reason4, Right.fd9603_3_0_reason4, ''),
// self.fd9603_4_0_score := if(Left.fd9603_4_0_score <> right.fd9603_4_0_score, Right.fd9603_4_0_score, ''),
// self.fd9603_4_0_reason1 := if(Left.fd9603_4_0_reason1 <> right.fd9603_4_0_reason1, Right.fd9603_4_0_reason1, ''),
// self.fd9603_4_0_reason2 := if(Left.fd9603_4_0_reason2 <> right.fd9603_4_0_reason2, Right.fd9603_4_0_reason2, ''),
// self.fd9603_4_0_reason3 := if(Left.fd9603_4_0_reason3 <> right.fd9603_4_0_reason3, Right.fd9603_4_0_reason3, ''),
// self.fd9603_4_0_reason4 := if(Left.fd9603_4_0_reason4 <> right.fd9603_4_0_reason4, Right.fd9603_4_0_reason4, ''),
// self.fd9604_1_0_score := if(Left.fd9604_1_0_score <> right.fd9604_1_0_score, Right.fd9604_1_0_score, ''),
// self.fd9604_1_0_reason1 := if(Left.fd9604_1_0_reason1 <> right.fd9604_1_0_reason1, Right.fd9604_1_0_reason1, ''),
// self.fd9604_1_0_reason2 := if(Left.fd9604_1_0_reason2 <> right.fd9604_1_0_reason2, Right.fd9604_1_0_reason2, ''),
// self.fd9604_1_0_reason3 := if(Left.fd9604_1_0_reason3 <> right.fd9604_1_0_reason3, Right.fd9604_1_0_reason3, ''),
// self.fd9604_1_0_reason4 := if(Left.fd9604_1_0_reason4 <> right.fd9604_1_0_reason4, Right.fd9604_1_0_reason4, ''),
// self.fd9606_0_0_score := if(Left.fd9606_0_0_score <> right.fd9606_0_0_score, Right.fd9606_0_0_score, ''),
// self.fd9606_0_0_reason1 := if(Left.fd9606_0_0_reason1 <> right.fd9606_0_0_reason1, Right.fd9606_0_0_reason1, ''),
// self.fd9606_0_0_reason2 := if(Left.fd9606_0_0_reason2 <> right.fd9606_0_0_reason2, Right.fd9606_0_0_reason2, ''),
// self.fd9606_0_0_reason3 := if(Left.fd9606_0_0_reason3 <> right.fd9606_0_0_reason3, Right.fd9606_0_0_reason3, ''),
// self.fd9606_0_0_reason4 := if(Left.fd9606_0_0_reason4 <> right.fd9606_0_0_reason4, Right.fd9606_0_0_reason4, ''),
// self.fd9607_1_0_score := if(Left.fd9607_1_0_score <> right.fd9607_1_0_score, Right.fd9607_1_0_score, ''),
// self.fd9607_1_0_reason1 := if(Left.fd9607_1_0_reason1 <> right.fd9607_1_0_reason1, Right.fd9607_1_0_reason1, ''),
// self.fd9607_1_0_reason2 := if(Left.fd9607_1_0_reason2 <> right.fd9607_1_0_reason2, Right.fd9607_1_0_reason2, ''),
// self.fd9607_1_0_reason3 := if(Left.fd9607_1_0_reason3 <> right.fd9607_1_0_reason3, Right.fd9607_1_0_reason3, ''),
// self.fd9607_1_0_reason4 := if(Left.fd9607_1_0_reason4 <> right.fd9607_1_0_reason4, Right.fd9607_1_0_reason4, ''),
// self.fp1109_0_0_score := if(Left.fp1109_0_0_score <> right.fp1109_0_0_score, Right.fp1109_0_0_score, ''),
// self.fp1109_0_0_reason1 := if(Left.fp1109_0_0_reason1 <> right.fp1109_0_0_reason1, Right.fp1109_0_0_reason1, ''),
// self.fp1109_0_0_reason2 := if(Left.fp1109_0_0_reason2 <> right.fp1109_0_0_reason2, Right.fp1109_0_0_reason2, ''),
// self.fp1109_0_0_reason3 := if(Left.fp1109_0_0_reason3 <> right.fp1109_0_0_reason3, Right.fp1109_0_0_reason3, ''),
// self.fp1109_0_0_reason4 := if(Left.fp1109_0_0_reason4 <> right.fp1109_0_0_reason4, Right.fp1109_0_0_reason4, ''),
// self.fp1210_1_0_score := if(Left.fp1210_1_0_score <> right.fp1210_1_0_score, Right.fp1210_1_0_score, ''),
// self.fp1303_1_0_score := if(Left.fp1303_1_0_score <> right.fp1303_1_0_score, Right.fp1303_1_0_score, ''),
// self.fp1303_1_0_reason1 := if(Left.fp1303_1_0_reason1 <> right.fp1303_1_0_reason1, Right.fp1303_1_0_reason1, ''),
// self.fp1303_1_0_reason2 := if(Left.fp1303_1_0_reason2 <> right.fp1303_1_0_reason2, Right.fp1303_1_0_reason2, ''),
// self.fp1303_1_0_reason3 := if(Left.fp1303_1_0_reason3 <> right.fp1303_1_0_reason3, Right.fp1303_1_0_reason3, ''),
// self.fp1303_1_0_reason4 := if(Left.fp1303_1_0_reason4 <> right.fp1303_1_0_reason4, Right.fp1303_1_0_reason4, ''),
// self.fp1401_1_0_score := if(Left.fp1401_1_0_score <> right.fp1401_1_0_score, Right.fp1401_1_0_score, ''),
// self.fp1401_1_0_reason1 := if(Left.fp1401_1_0_reason1 <> right.fp1401_1_0_reason1, Right.fp1401_1_0_reason1, ''),
// self.fp1401_1_0_reason2 := if(Left.fp1401_1_0_reason2 <> right.fp1401_1_0_reason2, Right.fp1401_1_0_reason2, ''),
// self.fp1401_1_0_reason3 := if(Left.fp1401_1_0_reason3 <> right.fp1401_1_0_reason3, Right.fp1401_1_0_reason3, ''),
// self.fp1401_1_0_reason4 := if(Left.fp1401_1_0_reason4 <> right.fp1401_1_0_reason4, Right.fp1401_1_0_reason4, ''),
// self.fp1401_1_0_reason5 := if(Left.fp1401_1_0_reason5 <> right.fp1401_1_0_reason5, Right.fp1401_1_0_reason5, ''),
// self.fp1401_1_0_reason6 := if(Left.fp1401_1_0_reason6 <> right.fp1401_1_0_reason6, Right.fp1401_1_0_reason6, ''),
// self.fp1310_1_0_score := if(Left.fp1310_1_0_score <> right.fp1310_1_0_score, Right.fp1310_1_0_score, ''),
// self.fp1310_1_0_reason1 := if(Left.fp1310_1_0_reason1 <> right.fp1310_1_0_reason1, Right.fp1310_1_0_reason1, ''),
// self.fp1310_1_0_reason2 := if(Left.fp1310_1_0_reason2 <> right.fp1310_1_0_reason2, Right.fp1310_1_0_reason2, ''),
// self.fp1310_1_0_reason3 := if(Left.fp1310_1_0_reason3 <> right.fp1310_1_0_reason3, Right.fp1310_1_0_reason3, ''),
// self.fp1310_1_0_reason4 := if(Left.fp1310_1_0_reason4 <> right.fp1310_1_0_reason4, Right.fp1310_1_0_reason4, ''),
// self.fp1310_1_0_reason5 := if(Left.fp1310_1_0_reason5 <> right.fp1310_1_0_reason5, Right.fp1310_1_0_reason5, ''),
// self.fp1310_1_0_reason6 := if(Left.fp1310_1_0_reason6 <> right.fp1310_1_0_reason6, Right.fp1310_1_0_reason6, ''),
// self.fp1307_1_0_score := if(Left.fp1307_1_0_score <> right.fp1307_1_0_score, Right.fp1307_1_0_score, ''),
// self.fp1307_1_0_reason1 := if(Left.fp1307_1_0_reason1 <> right.fp1307_1_0_reason1, Right.fp1307_1_0_reason1, ''),
// self.fp1307_1_0_reason2 := if(Left.fp1307_1_0_reason2 <> right.fp1307_1_0_reason2, Right.fp1307_1_0_reason2, ''),
// self.fp1307_1_0_reason3 := if(Left.fp1307_1_0_reason3 <> right.fp1307_1_0_reason3, Right.fp1307_1_0_reason3, ''),
// self.fp1307_1_0_reason4 := if(Left.fp1307_1_0_reason4 <> right.fp1307_1_0_reason4, Right.fp1307_1_0_reason4, ''),
// self.fp1307_1_0_reason5 := if(Left.fp1307_1_0_reason5 <> right.fp1307_1_0_reason5, Right.fp1307_1_0_reason5, ''),
// self.fp1307_1_0_reason6 := if(Left.fp1307_1_0_reason6 <> right.fp1307_1_0_reason6, Right.fp1307_1_0_reason6, ''),
// self.fp1303_2_0_score := if(Left.fp1303_2_0_score <> right.fp1303_2_0_score, Right.fp1303_2_0_score, ''),
// self.fp1403_1_0_score := if(Left.fp1403_1_0_score <> right.fp1403_1_0_score, Right.fp1403_1_0_score, ''),
// self.fp1409_2_0_score := if(Left.fp1409_2_0_score <> right.fp1409_2_0_score, Right.fp1409_2_0_score, ''),
// self.fp1403_2_0_score := if(Left.fp1403_2_0_score <> right.fp1403_2_0_score, Right.fp1403_2_0_score, ''),
// self.fp1403_2_0_reason1 := if(Left.fp1403_2_0_reason1 <> right.fp1403_2_0_reason1, Right.fp1403_2_0_reason1, ''),
// self.fp1403_2_0_reason2 := if(Left.fp1403_2_0_reason2 <> right.fp1403_2_0_reason2, Right.fp1403_2_0_reason2, ''),
// self.fp1403_2_0_reason3 := if(Left.fp1403_2_0_reason3 <> right.fp1403_2_0_reason3, Right.fp1403_2_0_reason3, ''),
// self.fp1403_2_0_reason4 := if(Left.fp1403_2_0_reason4 <> right.fp1403_2_0_reason4, Right.fp1403_2_0_reason4, ''),
// self.fp1403_2_0_reason5 := if(Left.fp1403_2_0_reason5 <> right.fp1403_2_0_reason5, Right.fp1403_2_0_reason5, ''),
// self.fp1403_2_0_reason6 := if(Left.fp1403_2_0_reason6 <> right.fp1403_2_0_reason6, Right.fp1403_2_0_reason6, ''),
// self.fp1404_1_0_score := if(Left.fp1404_1_0_score <> right.fp1404_1_0_score, Right.fp1404_1_0_score, ''),
// self.fp1404_1_0_reason1 := if(Left.fp1404_1_0_reason1 <> right.fp1404_1_0_reason1, Right.fp1404_1_0_reason1, ''),
// self.fp1404_1_0_reason2 := if(Left.fp1404_1_0_reason2 <> right.fp1404_1_0_reason2, Right.fp1404_1_0_reason2, ''),
// self.fp1404_1_0_reason3 := if(Left.fp1404_1_0_reason3 <> right.fp1404_1_0_reason3, Right.fp1404_1_0_reason3, ''),
// self.fp1404_1_0_reason4 := if(Left.fp1404_1_0_reason4 <> right.fp1404_1_0_reason4, Right.fp1404_1_0_reason4, ''),
// self.fp1404_1_0_reason5 := if(Left.fp1404_1_0_reason5 <> right.fp1404_1_0_reason5, Right.fp1404_1_0_reason5, ''),
// self.fp1404_1_0_reason6 := if(Left.fp1404_1_0_reason6 <> right.fp1404_1_0_reason6, Right.fp1404_1_0_reason6, ''),
// self.fp1407_1_0_score := if(Left.fp1407_1_0_score <> right.fp1407_1_0_score, Right.fp1407_1_0_score, ''),
// self.fp1407_1_0_reason1 := if(Left.fp1407_1_0_reason1 <> right.fp1407_1_0_reason1, Right.fp1407_1_0_reason1, ''),
// self.fp1407_1_0_reason2 := if(Left.fp1407_1_0_reason2 <> right.fp1407_1_0_reason2, Right.fp1407_1_0_reason2, ''),
// self.fp1407_1_0_reason3 := if(Left.fp1407_1_0_reason3 <> right.fp1407_1_0_reason3, Right.fp1407_1_0_reason3, ''),
// self.fp1407_1_0_reason4 := if(Left.fp1407_1_0_reason4 <> right.fp1407_1_0_reason4, Right.fp1407_1_0_reason4, ''),
// self.fp1407_1_0_reason5 := if(Left.fp1407_1_0_reason5 <> right.fp1407_1_0_reason5, Right.fp1407_1_0_reason5, ''),
// self.fp1407_1_0_reason6 := if(Left.fp1407_1_0_reason6 <> right.fp1407_1_0_reason6, Right.fp1407_1_0_reason6, ''),
// self.fp1407_2_0_score := if(Left.fp1407_2_0_score <> right.fp1407_2_0_score, Right.fp1407_2_0_score, ''),
// self.fp1407_2_0_reason1 := if(Left.fp1407_2_0_reason1 <> right.fp1407_2_0_reason1, Right.fp1407_2_0_reason1, ''),
// self.fp1407_2_0_reason2 := if(Left.fp1407_2_0_reason2 <> right.fp1407_2_0_reason2, Right.fp1407_2_0_reason2, ''),
// self.fp1407_2_0_reason3 := if(Left.fp1407_2_0_reason3 <> right.fp1407_2_0_reason3, Right.fp1407_2_0_reason3, ''),
// self.fp1407_2_0_reason4 := if(Left.fp1407_2_0_reason4 <> right.fp1407_2_0_reason4, Right.fp1407_2_0_reason4, ''),
// self.fp1407_2_0_reason5 := if(Left.fp1407_2_0_reason5 <> right.fp1407_2_0_reason5, Right.fp1407_2_0_reason5, ''),
// self.fp1407_2_0_reason6 := if(Left.fp1407_2_0_reason6 <> right.fp1407_2_0_reason6, Right.fp1407_2_0_reason6, ''),
// self.fp1406_1_0_score := if(Left.fp1406_1_0_score <> right.fp1406_1_0_score, Right.fp1406_1_0_score, ''),
// self.fp1406_1_0_reason1 := if(Left.fp1406_1_0_reason1 <> right.fp1406_1_0_reason1, Right.fp1406_1_0_reason1, ''),
// self.fp1406_1_0_reason2 := if(Left.fp1406_1_0_reason2 <> right.fp1406_1_0_reason2, Right.fp1406_1_0_reason2, ''),
// self.fp1406_1_0_reason3 := if(Left.fp1406_1_0_reason3 <> right.fp1406_1_0_reason3, Right.fp1406_1_0_reason3, ''),
// self.fp1406_1_0_reason4 := if(Left.fp1406_1_0_reason4 <> right.fp1406_1_0_reason4, Right.fp1406_1_0_reason4, ''),
// self.fp1406_1_0_reason5 := if(Left.fp1406_1_0_reason5 <> right.fp1406_1_0_reason5, Right.fp1406_1_0_reason5, ''),
// self.fp1406_1_0_reason6 := if(Left.fp1406_1_0_reason6 <> right.fp1406_1_0_reason6, Right.fp1406_1_0_reason6, ''),
// self.fp1506_1_0_score := if(Left.fp1506_1_0_score <> right.fp1506_1_0_score, Right.fp1506_1_0_score, ''),
// self.fp1506_1_0_reason1 := if(Left.fp1506_1_0_reason1 <> right.fp1506_1_0_reason1, Right.fp1506_1_0_reason1, ''),
// self.fp1506_1_0_reason2 := if(Left.fp1506_1_0_reason2 <> right.fp1506_1_0_reason2, Right.fp1506_1_0_reason2, ''),
// self.fp1506_1_0_reason3 := if(Left.fp1506_1_0_reason3 <> right.fp1506_1_0_reason3, Right.fp1506_1_0_reason3, ''),
// self.fp1506_1_0_reason4 := if(Left.fp1506_1_0_reason4 <> right.fp1506_1_0_reason4, Right.fp1506_1_0_reason4, ''),
// self.fp1506_1_0_reason5 := if(Left.fp1506_1_0_reason5 <> right.fp1506_1_0_reason5, Right.fp1506_1_0_reason5, ''),
// self.fp1506_1_0_reason6 := if(Left.fp1506_1_0_reason6 <> right.fp1506_1_0_reason6, Right.fp1506_1_0_reason6, ''),
// self.fp1509_1_0_score := if(Left.fp1509_1_0_score <> right.fp1509_1_0_score, Right.fp1509_1_0_score, ''),
// self.fp1509_1_0_reason1 := if(Left.fp1509_1_0_reason1 <> right.fp1509_1_0_reason1, Right.fp1509_1_0_reason1, ''),
// self.fp1509_1_0_reason2 := if(Left.fp1509_1_0_reason2 <> right.fp1509_1_0_reason2, Right.fp1509_1_0_reason2, ''),
// self.fp1509_1_0_reason3 := if(Left.fp1509_1_0_reason3 <> right.fp1509_1_0_reason3, Right.fp1509_1_0_reason3, ''),
// self.fp1509_1_0_reason4 := if(Left.fp1509_1_0_reason4 <> right.fp1509_1_0_reason4, Right.fp1509_1_0_reason4, ''),
// self.fp1509_1_0_reason5 := if(Left.fp1509_1_0_reason5 <> right.fp1509_1_0_reason5, Right.fp1509_1_0_reason5, ''),
// self.fp1509_1_0_reason6 := if(Left.fp1509_1_0_reason6 <> right.fp1509_1_0_reason6, Right.fp1509_1_0_reason6, ''),
// self.fp1509_2_0_score := if(Left.fp1509_2_0_score <> right.fp1509_2_0_score, Right.fp1509_2_0_score, ''),
// self.fp1509_2_0_reason1 := if(Left.fp1509_2_0_reason1 <> right.fp1509_2_0_reason1, Right.fp1509_2_0_reason1, ''),
// self.fp1509_2_0_reason2 := if(Left.fp1509_2_0_reason2 <> right.fp1509_2_0_reason2, Right.fp1509_2_0_reason2, ''),
// self.fp1509_2_0_reason3 := if(Left.fp1509_2_0_reason3 <> right.fp1509_2_0_reason3, Right.fp1509_2_0_reason3, ''),
// self.fp1509_2_0_reason4 := if(Left.fp1509_2_0_reason4 <> right.fp1509_2_0_reason4, Right.fp1509_2_0_reason4, ''),
// self.fp1509_2_0_reason5 := if(Left.fp1509_2_0_reason5 <> right.fp1509_2_0_reason5, Right.fp1509_2_0_reason5, ''),
// self.fp1509_2_0_reason6 := if(Left.fp1509_2_0_reason6 <> right.fp1509_2_0_reason6, Right.fp1509_2_0_reason6, ''),
// self.fp1510_2_0_score := if(Left.fp1510_2_0_score <> right.fp1510_2_0_score, Right.fp1510_2_0_score, ''),
// self.fp1510_2_0_reason1 := if(Left.fp1510_2_0_reason1 <> right.fp1510_2_0_reason1, Right.fp1510_2_0_reason1, ''),
// self.fp1510_2_0_reason2 := if(Left.fp1510_2_0_reason2 <> right.fp1510_2_0_reason2, Right.fp1510_2_0_reason2, ''),
// self.fp1510_2_0_reason3 := if(Left.fp1510_2_0_reason3 <> right.fp1510_2_0_reason3, Right.fp1510_2_0_reason3, ''),
// self.fp1510_2_0_reason4 := if(Left.fp1510_2_0_reason4 <> right.fp1510_2_0_reason4, Right.fp1510_2_0_reason4, ''),
// self.fp1510_2_0_reason5 := if(Left.fp1510_2_0_reason5 <> right.fp1510_2_0_reason5, Right.fp1510_2_0_reason5, ''),
// self.fp1510_2_0_reason6 := if(Left.fp1510_2_0_reason6 <> right.fp1510_2_0_reason6, Right.fp1510_2_0_reason6, ''),
// self.fp1511_1_0_score := if(Left.fp1511_1_0_score <> right.fp1511_1_0_score, Right.fp1511_1_0_score, ''),
// self.fp1511_1_0_reason1 := if(Left.fp1511_1_0_reason1 <> right.fp1511_1_0_reason1, Right.fp1511_1_0_reason1, ''),
// self.fp1511_1_0_reason2 := if(Left.fp1511_1_0_reason2 <> right.fp1511_1_0_reason2, Right.fp1511_1_0_reason2, ''),
// self.fp1511_1_0_reason3 := if(Left.fp1511_1_0_reason3 <> right.fp1511_1_0_reason3, Right.fp1511_1_0_reason3, ''),
// self.fp1511_1_0_reason4 := if(Left.fp1511_1_0_reason4 <> right.fp1511_1_0_reason4, Right.fp1511_1_0_reason4, ''),
// self.fp1511_1_0_reason5 := if(Left.fp1511_1_0_reason5 <> right.fp1511_1_0_reason5, Right.fp1511_1_0_reason5, ''),
// self.fp1511_1_0_reason6 := if(Left.fp1511_1_0_reason6 <> right.fp1511_1_0_reason6, Right.fp1511_1_0_reason6, ''),
// self.fp1512_1_0_score := if(Left.fp1512_1_0_score <> right.fp1512_1_0_score, Right.fp1512_1_0_score, ''),
// self.fp1512_1_0_reason1 := if(Left.fp1512_1_0_reason1 <> right.fp1512_1_0_reason1, Right.fp1512_1_0_reason1, ''),
// self.fp1512_1_0_reason2 := if(Left.fp1512_1_0_reason2 <> right.fp1512_1_0_reason2, Right.fp1512_1_0_reason2, ''),
// self.fp1512_1_0_reason3 := if(Left.fp1512_1_0_reason3 <> right.fp1512_1_0_reason3, Right.fp1512_1_0_reason3, ''),
// self.fp1512_1_0_reason4 := if(Left.fp1512_1_0_reason4 <> right.fp1512_1_0_reason4, Right.fp1512_1_0_reason4, ''),
// self.fp1512_1_0_reason5 := if(Left.fp1512_1_0_reason5 <> right.fp1512_1_0_reason5, Right.fp1512_1_0_reason5, ''),
// self.fp1512_1_0_reason6 := if(Left.fp1512_1_0_reason6 <> right.fp1512_1_0_reason6, Right.fp1512_1_0_reason6, ''),
// self.fp1609_1_0_score := if(Left.fp1609_1_0_score <> right.fp1609_1_0_score, Right.fp1609_1_0_score, ''),
// self.fp1609_1_0_reason1 := if(Left.fp1609_1_0_reason1 <> right.fp1609_1_0_reason1, Right.fp1609_1_0_reason1, ''),
// self.fp1609_1_0_reason2 := if(Left.fp1609_1_0_reason2 <> right.fp1609_1_0_reason2, Right.fp1609_1_0_reason2, ''),
// self.fp1609_1_0_reason3 := if(Left.fp1609_1_0_reason3 <> right.fp1609_1_0_reason3, Right.fp1609_1_0_reason3, ''),
// self.fp1609_1_0_reason4 := if(Left.fp1609_1_0_reason4 <> right.fp1609_1_0_reason4, Right.fp1609_1_0_reason4, ''),
// self.fp1609_1_0_reason5 := if(Left.fp1609_1_0_reason5 <> right.fp1609_1_0_reason5, Right.fp1609_1_0_reason5, ''),
// self.fp1609_1_0_reason6 := if(Left.fp1609_1_0_reason6 <> right.fp1609_1_0_reason6, Right.fp1609_1_0_reason6, ''),
// self.fp1606_1_0_score := if(Left.fp1606_1_0_score <> right.fp1606_1_0_score, Right.fp1606_1_0_score, ''),
// self.fp1606_1_0_reason1 := if(Left.fp1606_1_0_reason1 <> right.fp1606_1_0_reason1, Right.fp1606_1_0_reason1, ''),
// self.fp1606_1_0_reason2 := if(Left.fp1606_1_0_reason2 <> right.fp1606_1_0_reason2, Right.fp1606_1_0_reason2, ''),
// self.fp1606_1_0_reason3 := if(Left.fp1606_1_0_reason3 <> right.fp1606_1_0_reason3, Right.fp1606_1_0_reason3, ''),
// self.fp1606_1_0_reason4 := if(Left.fp1606_1_0_reason4 <> right.fp1606_1_0_reason4, Right.fp1606_1_0_reason4, ''),
// self.fp1606_1_0_reason5 := if(Left.fp1606_1_0_reason5 <> right.fp1606_1_0_reason5, Right.fp1606_1_0_reason5, ''),
// self.fp1606_1_0_reason6 := if(Left.fp1606_1_0_reason6 <> right.fp1606_1_0_reason6, Right.fp1606_1_0_reason6, ''),
// self.fp1610_1_0_score := if(Left.fp1610_1_0_score <> right.fp1610_1_0_score, Right.fp1610_1_0_score, ''),
// self.fp1610_1_0_reason1 := if(Left.fp1610_1_0_reason1 <> right.fp1610_1_0_reason1, Right.fp1610_1_0_reason1, ''),
// self.fp1610_1_0_reason2 := if(Left.fp1610_1_0_reason2 <> right.fp1610_1_0_reason2, Right.fp1610_1_0_reason2, ''),
// self.fp1610_1_0_reason3 := if(Left.fp1610_1_0_reason3 <> right.fp1610_1_0_reason3, Right.fp1610_1_0_reason3, ''),
// self.fp1610_1_0_reason4 := if(Left.fp1610_1_0_reason4 <> right.fp1610_1_0_reason4, Right.fp1610_1_0_reason4, ''),
// self.fp1610_1_0_reason5 := if(Left.fp1610_1_0_reason5 <> right.fp1610_1_0_reason5, Right.fp1610_1_0_reason5, ''),
// self.fp1610_1_0_reason6 := if(Left.fp1610_1_0_reason6 <> right.fp1610_1_0_reason6, Right.fp1610_1_0_reason6, ''),
// self.fp1610_2_0_score := if(Left.fp1610_2_0_score <> right.fp1610_2_0_score, Right.fp1610_2_0_score, ''),
// self.fp1610_2_0_reason1 := if(Left.fp1610_2_0_reason1 <> right.fp1610_2_0_reason1, Right.fp1610_2_0_reason1, ''),
// self.fp1610_2_0_reason2 := if(Left.fp1610_2_0_reason2 <> right.fp1610_2_0_reason2, Right.fp1610_2_0_reason2, ''),
// self.fp1610_2_0_reason3 := if(Left.fp1610_2_0_reason3 <> right.fp1610_2_0_reason3, Right.fp1610_2_0_reason3, ''),
// self.fp1610_2_0_reason4 := if(Left.fp1610_2_0_reason4 <> right.fp1610_2_0_reason4, Right.fp1610_2_0_reason4, ''),
// self.fp1610_2_0_reason5 := if(Left.fp1610_2_0_reason5 <> right.fp1610_2_0_reason5, Right.fp1610_2_0_reason5, ''),
// self.fp1610_2_0_reason6 := if(Left.fp1610_2_0_reason6 <> right.fp1610_2_0_reason6, Right.fp1610_2_0_reason6, ''),
// self.fp1611_1_0_score := if(Left.fp1611_1_0_score <> right.fp1611_1_0_score, Right.fp1611_1_0_score, ''),
// self.fp1611_1_0_reason1 := if(Left.fp1611_1_0_reason1 <> right.fp1611_1_0_reason1, Right.fp1611_1_0_reason1, ''),
// self.fp1611_1_0_reason2 := if(Left.fp1611_1_0_reason2 <> right.fp1611_1_0_reason2, Right.fp1611_1_0_reason2, ''),
// self.fp1611_1_0_reason3 := if(Left.fp1611_1_0_reason3 <> right.fp1611_1_0_reason3, Right.fp1611_1_0_reason3, ''),
// self.fp1611_1_0_reason4 := if(Left.fp1611_1_0_reason4 <> right.fp1611_1_0_reason4, Right.fp1611_1_0_reason4, ''),
// self.fp1611_1_0_reason5 := if(Left.fp1611_1_0_reason5 <> right.fp1611_1_0_reason5, Right.fp1611_1_0_reason5, ''),
// self.fp1611_1_0_reason6 := if(Left.fp1611_1_0_reason6 <> right.fp1611_1_0_reason6, Right.fp1611_1_0_reason6, ''),
// self.fp31105_1_0_score := if(Left.fp31105_1_0_score <> right.fp31105_1_0_score, Right.fp31105_1_0_score, ''),
// self.fp31105_1_0_reason1 := if(Left.fp31105_1_0_reason1 <> right.fp31105_1_0_reason1, Right.fp31105_1_0_reason1, ''),
// self.fp31105_1_0_reason2 := if(Left.fp31105_1_0_reason2 <> right.fp31105_1_0_reason2, Right.fp31105_1_0_reason2, ''),
// self.fp31105_1_0_reason3 := if(Left.fp31105_1_0_reason3 <> right.fp31105_1_0_reason3, Right.fp31105_1_0_reason3, ''),
// self.fp31105_1_0_reason4 := if(Left.fp31105_1_0_reason4 <> right.fp31105_1_0_reason4, Right.fp31105_1_0_reason4, ''),
// self.fp31203_1_0_score := if(Left.fp31203_1_0_score <> right.fp31203_1_0_score, Right.fp31203_1_0_score, ''),
// self.fp31203_1_0_reason1 := if(Left.fp31203_1_0_reason1 <> right.fp31203_1_0_reason1, Right.fp31203_1_0_reason1, ''),
// self.fp31203_1_0_reason2 := if(Left.fp31203_1_0_reason2 <> right.fp31203_1_0_reason2, Right.fp31203_1_0_reason2, ''),
// self.fp31203_1_0_reason3 := if(Left.fp31203_1_0_reason3 <> right.fp31203_1_0_reason3, Right.fp31203_1_0_reason3, ''),
// self.fp31203_1_0_reason4 := if(Left.fp31203_1_0_reason4 <> right.fp31203_1_0_reason4, Right.fp31203_1_0_reason4, ''),
// self.fp31310_2_0_score := if(Left.fp31310_2_0_score <> right.fp31310_2_0_score, Right.fp31310_2_0_score, ''),
// self.fp31310_2_0_reason1 := if(Left.fp31310_2_0_reason1 <> right.fp31310_2_0_reason1, Right.fp31310_2_0_reason1, ''),
// self.fp31310_2_0_reason2 := if(Left.fp31310_2_0_reason2 <> right.fp31310_2_0_reason2, Right.fp31310_2_0_reason2, ''),
// self.fp31310_2_0_reason3 := if(Left.fp31310_2_0_reason3 <> right.fp31310_2_0_reason3, Right.fp31310_2_0_reason3, ''),
// self.fp31310_2_0_reason4 := if(Left.fp31310_2_0_reason4 <> right.fp31310_2_0_reason4, Right.fp31310_2_0_reason4, ''),
// self.fp31310_2_0_reason5 := if(Left.fp31310_2_0_reason5 <> right.fp31310_2_0_reason5, Right.fp31310_2_0_reason5, ''),
// self.fp31310_2_0_reason6 := if(Left.fp31310_2_0_reason6 <> right.fp31310_2_0_reason6, Right.fp31310_2_0_reason6, ''),
// self.fp31505_0_0_score := if(Left.fp31505_0_0_score <> right.fp31505_0_0_score, Right.fp31505_0_0_score, ''),
// self.fp31505_0_0_reason1 := if(Left.fp31505_0_0_reason1 <> right.fp31505_0_0_reason1, Right.fp31505_0_0_reason1, ''),
// self.fp31505_0_0_reason2 := if(Left.fp31505_0_0_reason2 <> right.fp31505_0_0_reason2, Right.fp31505_0_0_reason2, ''),
// self.fp31505_0_0_reason3 := if(Left.fp31505_0_0_reason3 <> right.fp31505_0_0_reason3, Right.fp31505_0_0_reason3, ''),
// self.fp31505_0_0_reason4 := if(Left.fp31505_0_0_reason4 <> right.fp31505_0_0_reason4, Right.fp31505_0_0_reason4, ''),
// self.fp31505_0_0_reason5 := if(Left.fp31505_0_0_reason5 <> right.fp31505_0_0_reason5, Right.fp31505_0_0_reason5, ''),
// self.fp31505_0_0_reason6 := if(Left.fp31505_0_0_reason6 <> right.fp31505_0_0_reason6, Right.fp31505_0_0_reason6, ''),
// self.fp31604_0_0_score := if(Left.fp31604_0_0_score <> right.fp31604_0_0_score, Right.fp31604_0_0_score, ''),
// self.fp31604_0_0_reason1 := if(Left.fp31604_0_0_reason1 <> right.fp31604_0_0_reason1, Right.fp31604_0_0_reason1, ''),
// self.fp31604_0_0_reason2 := if(Left.fp31604_0_0_reason2 <> right.fp31604_0_0_reason2, Right.fp31604_0_0_reason2, ''),
// self.fp31604_0_0_reason3 := if(Left.fp31604_0_0_reason3 <> right.fp31604_0_0_reason3, Right.fp31604_0_0_reason3, ''),
// self.fp31604_0_0_reason4 := if(Left.fp31604_0_0_reason4 <> right.fp31604_0_0_reason4, Right.fp31604_0_0_reason4, ''),
// self.fp31604_0_0_reason5 := if(Left.fp31604_0_0_reason5 <> right.fp31604_0_0_reason5, Right.fp31604_0_0_reason5, ''),
// self.fp31604_0_0_reason6 := if(Left.fp31604_0_0_reason6 <> right.fp31604_0_0_reason6, Right.fp31604_0_0_reason6, ''),
// self.fp3fdn1505_0_0_score := if(Left.fp3fdn1505_0_0_score <> right.fp3fdn1505_0_0_score, Right.fp3fdn1505_0_0_score, ''),
// self.fp3fdn1505_0_0_reason1 := if(Left.fp3fdn1505_0_0_reason1 <> right.fp3fdn1505_0_0_reason1, Right.fp3fdn1505_0_0_reason1, ''),
// self.fp3fdn1505_0_0_reason2 := if(Left.fp3fdn1505_0_0_reason2 <> right.fp3fdn1505_0_0_reason2, Right.fp3fdn1505_0_0_reason2, ''),
// self.fp3fdn1505_0_0_reason3 := if(Left.fp3fdn1505_0_0_reason3 <> right.fp3fdn1505_0_0_reason3, Right.fp3fdn1505_0_0_reason3, ''),
// self.fp3fdn1505_0_0_reason4 := if(Left.fp3fdn1505_0_0_reason4 <> right.fp3fdn1505_0_0_reason4, Right.fp3fdn1505_0_0_reason4, ''),
// self.fp3fdn1505_0_0_reason5 := if(Left.fp3fdn1505_0_0_reason5 <> right.fp3fdn1505_0_0_reason5, Right.fp3fdn1505_0_0_reason5, ''),
// self.fp3fdn1505_0_0_reason6 := if(Left.fp3fdn1505_0_0_reason6 <> right.fp3fdn1505_0_0_reason6, Right.fp3fdn1505_0_0_reason6, ''),
// self.fp3710_0_0_score := if(Left.fp3710_0_0_score <> right.fp3710_0_0_score, Right.fp3710_0_0_score, ''),
// self.fp3710_0_0_reason1 := if(Left.fp3710_0_0_reason1 <> right.fp3710_0_0_reason1, Right.fp3710_0_0_reason1, ''),
// self.fp3710_0_0_reason2 := if(Left.fp3710_0_0_reason2 <> right.fp3710_0_0_reason2, Right.fp3710_0_0_reason2, ''),
// self.fp3710_0_0_reason3 := if(Left.fp3710_0_0_reason3 <> right.fp3710_0_0_reason3, Right.fp3710_0_0_reason3, ''),
// self.fp3710_0_0_reason4 := if(Left.fp3710_0_0_reason4 <> right.fp3710_0_0_reason4, Right.fp3710_0_0_reason4, ''),
// self.fp3904_1_0_score := if(Left.fp3904_1_0_score <> right.fp3904_1_0_score, Right.fp3904_1_0_score, ''),
// self.fp3904_1_0_reason1 := if(Left.fp3904_1_0_reason1 <> right.fp3904_1_0_reason1, Right.fp3904_1_0_reason1, ''),
// self.fp3904_1_0_reason2 := if(Left.fp3904_1_0_reason2 <> right.fp3904_1_0_reason2, Right.fp3904_1_0_reason2, ''),
// self.fp3904_1_0_reason3 := if(Left.fp3904_1_0_reason3 <> right.fp3904_1_0_reason3, Right.fp3904_1_0_reason3, ''),
// self.fp3904_1_0_reason4 := if(Left.fp3904_1_0_reason4 <> right.fp3904_1_0_reason4, Right.fp3904_1_0_reason4, ''),
// self.fp3905_1_0_score := if(Left.fp3905_1_0_score <> right.fp3905_1_0_score, Right.fp3905_1_0_score, ''),
// self.fp3905_1_0_reason1 := if(Left.fp3905_1_0_reason1 <> right.fp3905_1_0_reason1, Right.fp3905_1_0_reason1, ''),
// self.fp3905_1_0_reason2 := if(Left.fp3905_1_0_reason2 <> right.fp3905_1_0_reason2, Right.fp3905_1_0_reason2, ''),
// self.fp3905_1_0_reason3 := if(Left.fp3905_1_0_reason3 <> right.fp3905_1_0_reason3, Right.fp3905_1_0_reason3, ''),
// self.fp3905_1_0_reason4 := if(Left.fp3905_1_0_reason4 <> right.fp3905_1_0_reason4, Right.fp3905_1_0_reason4, ''),
// self.fp5812_1_0_score := if(Left.fp5812_1_0_score <> right.fp5812_1_0_score, Right.fp5812_1_0_score, ''),
// self.fp5812_1_0_reason1 := if(Left.fp5812_1_0_reason1 <> right.fp5812_1_0_reason1, Right.fp5812_1_0_reason1, ''),
// self.fp5812_1_0_reason2 := if(Left.fp5812_1_0_reason2 <> right.fp5812_1_0_reason2, Right.fp5812_1_0_reason2, ''),
// self.fp5812_1_0_reason3 := if(Left.fp5812_1_0_reason3 <> right.fp5812_1_0_reason3, Right.fp5812_1_0_reason3, ''),
// self.fp5812_1_0_reason4 := if(Left.fp5812_1_0_reason4 <> right.fp5812_1_0_reason4, Right.fp5812_1_0_reason4, ''),
// self.hcp1206_0_0_score := if(Left.hcp1206_0_0_score <> right.hcp1206_0_0_score, Right.hcp1206_0_0_score, ''),
// self.hcp1206_0_0_reason1 := if(Left.hcp1206_0_0_reason1 <> right.hcp1206_0_0_reason1, Right.hcp1206_0_0_reason1, ''),
// self.hcp1206_0_0_reason2 := if(Left.hcp1206_0_0_reason2 <> right.hcp1206_0_0_reason2, Right.hcp1206_0_0_reason2, ''),
// self.hcp1206_0_0_reason3 := if(Left.hcp1206_0_0_reason3 <> right.hcp1206_0_0_reason3, Right.hcp1206_0_0_reason3, ''),
// self.hcp1206_0_0_reason4 := if(Left.hcp1206_0_0_reason4 <> right.hcp1206_0_0_reason4, Right.hcp1206_0_0_reason4, ''),
// self.idn605_1_0_score := if(Left.idn605_1_0_score <> right.idn605_1_0_score, Right.idn605_1_0_score, ''),
// self.idn605_1_0_reason1 := if(Left.idn605_1_0_reason1 <> right.idn605_1_0_reason1, Right.idn605_1_0_reason1, ''),
// self.idn605_1_0_reason2 := if(Left.idn605_1_0_reason2 <> right.idn605_1_0_reason2, Right.idn605_1_0_reason2, ''),
// self.idn605_1_0_reason3 := if(Left.idn605_1_0_reason3 <> right.idn605_1_0_reason3, Right.idn605_1_0_reason3, ''),
// self.idn605_1_0_reason4 := if(Left.idn605_1_0_reason4 <> right.idn605_1_0_reason4, Right.idn605_1_0_reason4, ''),
// self.ie912_0_0_score := if(Left.ie912_0_0_score <> (String)right.ie912_0_0_score, (String)Right.ie912_0_0_score, ''),                 //Was unsigned8, casting
// self.ie912_0_0_reason1 := if(Left.ie912_0_0_reason1 <> right.ie912_0_0_reason1, Right.ie912_0_0_reason1, ''),
// self.ie912_0_0_reason2 := if(Left.ie912_0_0_reason2 <> right.ie912_0_0_reason2, Right.ie912_0_0_reason2, ''),
// self.ie912_0_0_reason3 := if(Left.ie912_0_0_reason3 <> right.ie912_0_0_reason3, Right.ie912_0_0_reason3, ''),
// self.ie912_0_0_reason4 := if(Left.ie912_0_0_reason4 <> right.ie912_0_0_reason4, Right.ie912_0_0_reason4, ''),
// self.ie912_1_0_score := if(Left.ie912_1_0_score <> right.ie912_1_0_score, Right.ie912_1_0_score, ''),
// self.ie912_1_0_reason1 := if(Left.ie912_1_0_reason1 <> right.ie912_1_0_reason1, Right.ie912_1_0_reason1, ''),
// self.ie912_1_0_reason2 := if(Left.ie912_1_0_reason2 <> right.ie912_1_0_reason2, Right.ie912_1_0_reason2, ''),
// self.ie912_1_0_reason3 := if(Left.ie912_1_0_reason3 <> right.ie912_1_0_reason3, Right.ie912_1_0_reason3, ''),
// self.ie912_1_0_reason4 := if(Left.ie912_1_0_reason4 <> right.ie912_1_0_reason4, Right.ie912_1_0_reason4, ''),
self.ied1106_1_0_score := if(Left.ied1106_1_0_score <> right.ied1106_1_0_score, Right.ied1106_1_0_score, ''),
self.ien1006_0_1_score := if(Left.ien1006_0_1_score <> (String)right.ien1006_0_1_score, (String)Right.ien1006_0_1_score, ''),         //Was unsigned3, casting
self.mnc21106_0_0_score := if(Left.mnc21106_0_0_score <> (String)right.mnc21106_0_0_score, (String)Right.mnc21106_0_0_score, ''),     //Was real8, casting
self.mpx1211_0_0_score := if(Left.mpx1211_0_0_score <> (String)right.mpx1211_0_0_score, (String)Right.mpx1211_0_0_score, ''),         //Was real8, casting
self.msd1010_0_0_score := if(Left.msd1010_0_0_score <> (String)right.msd1010_0_0_score, (String)Right.msd1010_0_0_score, ''),         //was unsigned3, casting
self.msn1106_0_0_score := if(Left.msn1106_0_0_score <> right.msn1106_0_0_score, Right.msn1106_0_0_score, ''),
self.msn1106_0_0_reason1 := if(Left.msn1106_0_0_reason1 <> right.msn1106_0_0_reason1, Right.msn1106_0_0_reason1, ''),
self.msn1106_0_0_reason2 := if(Left.msn1106_0_0_reason2 <> right.msn1106_0_0_reason2, Right.msn1106_0_0_reason2, ''),
self.msn1106_0_0_reason3 := if(Left.msn1106_0_0_reason3 <> right.msn1106_0_0_reason3, Right.msn1106_0_0_reason3, ''),
self.msn1106_0_0_reason4 := if(Left.msn1106_0_0_reason4 <> right.msn1106_0_0_reason4, Right.msn1106_0_0_reason4, ''),
self.msn1210_1_0_score := if(Left.msn1210_1_0_score <> right.msn1210_1_0_score, Right.msn1210_1_0_score, ''),
self.msn1210_1_0_reason1 := if(Left.msn1210_1_0_reason1 <> right.msn1210_1_0_reason1, Right.msn1210_1_0_reason1, ''),
self.msn1210_1_0_reason2 := if(Left.msn1210_1_0_reason2 <> right.msn1210_1_0_reason2, Right.msn1210_1_0_reason2, ''),
self.msn1210_1_0_reason3 := if(Left.msn1210_1_0_reason3 <> right.msn1210_1_0_reason3, Right.msn1210_1_0_reason3, ''),
self.msn1210_1_0_reason4 := if(Left.msn1210_1_0_reason4 <> right.msn1210_1_0_reason4, Right.msn1210_1_0_reason4, ''),
self.msn1210_1_0_reason5 := if(Left.msn1210_1_0_reason5 <> right.msn1210_1_0_reason5, Right.msn1210_1_0_reason5, ''),
self.msn1210_1_0_reason6 := if(Left.msn1210_1_0_reason6 <> right.msn1210_1_0_reason6, Right.msn1210_1_0_reason6, ''),
self.msn605_1_0_score := if(Left.msn605_1_0_score <> right.msn605_1_0_score, Right.msn605_1_0_score, ''),
self.msn610_0_0_score := if(Left.msn610_0_0_score <> right.msn610_0_0_score, Right.msn610_0_0_score, ''),
self.mv361006_0_0_score := if(Left.mv361006_0_0_score <> (String)right.mv361006_0_0_score, (String)Right.mv361006_0_0_score, ''),         //Was real8, casting
self.mv361006_1_0_score := if(Left.mv361006_1_0_score <> (String)right.mv361006_1_0_score, (String)Right.mv361006_1_0_score, ''),         //Was real8, casting
self.mx361006_0_0_score := if(Left.mx361006_0_0_score <> (String)right.mx361006_0_0_score, (String)Right.mx361006_0_0_score, ''),         //was unsigned3, casting
self.mx361006_1_0_score := if(Left.mx361006_1_0_score <> (String)right.mx361006_1_0_score, (String)Right.mx361006_1_0_score, ''),         //Was real8, casting
self.rsb801_1_0_score := if(Left.rsb801_1_0_score <> right.rsb801_1_0_score, Right.rsb801_1_0_score, ''),
self.rsn1001_1_0_score := if(Left.rsn1001_1_0_score <> right.rsn1001_1_0_score, Right.rsn1001_1_0_score, ''),
self.rsn1009_1_0_score := if(Left.rsn1009_1_0_score <> right.rsn1009_1_0_score, Right.rsn1009_1_0_score, ''),
self.rsn1010_1_0_score := if(Left.rsn1010_1_0_score <> right.rsn1010_1_0_score, Right.rsn1010_1_0_score, ''),
self.rsn1103_1_0_score := if(Left.rsn1103_1_0_score <> right.rsn1103_1_0_score, Right.rsn1103_1_0_score, ''),
self.rsn1105_1_0_score := if(Left.rsn1105_1_0_score <> right.rsn1105_1_0_score, Right.rsn1105_1_0_score, ''),
self.rsn1105_2_0_score := if(Left.rsn1105_2_0_score <> right.rsn1105_2_0_score, Right.rsn1105_2_0_score, ''),
self.rsn1105_3_0_score := if(Left.rsn1105_3_0_score <> right.rsn1105_3_0_score, Right.rsn1105_3_0_score, ''),
self.rsn1108_1_0_score := if(Left.rsn1108_1_0_score <> right.rsn1108_1_0_score, Right.rsn1108_1_0_score, ''),
self.rsn1108_2_0_score := if(Left.rsn1108_2_0_score <> right.rsn1108_2_0_score, Right.rsn1108_2_0_score, ''),
self.rsn1108_3_0_score := if(Left.rsn1108_3_0_score <> right.rsn1108_3_0_score, Right.rsn1108_3_0_score, ''),
self.rsn508_1_0_score := if(Left.rsn508_1_0_score <> right.rsn508_1_0_score, Right.rsn508_1_0_score, ''),
self.rsn509_1_0_score := if(Left.rsn509_1_0_score <> right.rsn509_1_0_score, Right.rsn509_1_0_score, ''),
self.rsn509_2_0_score := if(Left.rsn509_2_0_score <> right.rsn509_2_0_score, Right.rsn509_2_0_score, ''),
self.rsn604_2_0_score := if(Left.rsn604_2_0_score <> right.rsn604_2_0_score, Right.rsn604_2_0_score, ''),
self.rsn607_0_0_score := if(Left.rsn607_0_0_score <> right.rsn607_0_0_score, Right.rsn607_0_0_score, ''),
self.rsn607_1_0_score := if(Left.rsn607_1_0_score <> right.rsn607_1_0_score, Right.rsn607_1_0_score, ''),
self.rsn702_1_0_score := if(Left.rsn702_1_0_score <> right.rsn702_1_0_score, Right.rsn702_1_0_score, ''),
self.rsn704_0_0_score := if(Left.rsn704_0_0_score <> right.rsn704_0_0_score, Right.rsn704_0_0_score, ''),
self.rsn704_1_0_score := if(Left.rsn704_1_0_score <> right.rsn704_1_0_score, Right.rsn704_1_0_score, ''),
self.rsn802_1_0_score := if(Left.rsn802_1_0_score <> right.rsn802_1_0_score, Right.rsn802_1_0_score, ''),
self.rsn803_1_0_score := if(Left.rsn803_1_0_score <> right.rsn803_1_0_score, Right.rsn803_1_0_score, ''),
self.rsn803_2_0_score := if(Left.rsn803_2_0_score <> right.rsn803_2_0_score, Right.rsn803_2_0_score, ''),
self.rsn804_1_0_score := if(Left.rsn804_1_0_score <> right.rsn804_1_0_score, Right.rsn804_1_0_score, ''),
self.rsn807_0_0_score := if(Left.rsn807_0_0_score <> right.rsn807_0_0_score, Right.rsn807_0_0_score, ''),
self.rsn810_1_0_score := if(Left.rsn810_1_0_score <> right.rsn810_1_0_score, Right.rsn810_1_0_score, ''),
self.rsn912_1_0_score := if(Left.rsn912_1_0_score <> right.rsn912_1_0_score, Right.rsn912_1_0_score, ''),
self.rva1003_0_0_score := if(Left.rva1003_0_0_score <> right.rva1003_0_0_score, Right.rva1003_0_0_score, ''),
self.rva1003_0_0_reason1 := if(Left.rva1003_0_0_reason1 <> right.rva1003_0_0_reason1, Right.rva1003_0_0_reason1, ''),
self.rva1003_0_0_reason2 := if(Left.rva1003_0_0_reason2 <> right.rva1003_0_0_reason2, Right.rva1003_0_0_reason2, ''),
self.rva1003_0_0_reason3 := if(Left.rva1003_0_0_reason3 <> right.rva1003_0_0_reason3, Right.rva1003_0_0_reason3, ''),
self.rva1003_0_0_reason4 := if(Left.rva1003_0_0_reason4 <> right.rva1003_0_0_reason4, Right.rva1003_0_0_reason4, ''),
self.rva1007_1_0_score := if(Left.rva1007_1_0_score <> right.rva1007_1_0_score, Right.rva1007_1_0_score, ''),
self.rva1007_1_0_reason1 := if(Left.rva1007_1_0_reason1 <> right.rva1007_1_0_reason1, Right.rva1007_1_0_reason1, ''),
self.rva1007_1_0_reason2 := if(Left.rva1007_1_0_reason2 <> right.rva1007_1_0_reason2, Right.rva1007_1_0_reason2, ''),
self.rva1007_1_0_reason3 := if(Left.rva1007_1_0_reason3 <> right.rva1007_1_0_reason3, Right.rva1007_1_0_reason3, ''),
self.rva1007_1_0_reason4 := if(Left.rva1007_1_0_reason4 <> right.rva1007_1_0_reason4, Right.rva1007_1_0_reason4, ''),
self.rva1007_2_0_score := if(Left.rva1007_2_0_score <> right.rva1007_2_0_score, Right.rva1007_2_0_score, ''),
self.rva1007_2_0_reason1 := if(Left.rva1007_2_0_reason1 <> right.rva1007_2_0_reason1, Right.rva1007_2_0_reason1, ''),
self.rva1007_2_0_reason2 := if(Left.rva1007_2_0_reason2 <> right.rva1007_2_0_reason2, Right.rva1007_2_0_reason2, ''),
self.rva1007_2_0_reason3 := if(Left.rva1007_2_0_reason3 <> right.rva1007_2_0_reason3, Right.rva1007_2_0_reason3, ''),
self.rva1007_2_0_reason4 := if(Left.rva1007_2_0_reason4 <> right.rva1007_2_0_reason4, Right.rva1007_2_0_reason4, ''),
self.rva1007_3_0_score := if(Left.rva1007_3_0_score <> right.rva1007_3_0_score, Right.rva1007_3_0_score, ''),
self.rva1007_3_0_reason1 := if(Left.rva1007_3_0_reason1 <> right.rva1007_3_0_reason1, Right.rva1007_3_0_reason1, ''),
self.rva1007_3_0_reason2 := if(Left.rva1007_3_0_reason2 <> right.rva1007_3_0_reason2, Right.rva1007_3_0_reason2, ''),
self.rva1007_3_0_reason3 := if(Left.rva1007_3_0_reason3 <> right.rva1007_3_0_reason3, Right.rva1007_3_0_reason3, ''),
self.rva1007_3_0_reason4 := if(Left.rva1007_3_0_reason4 <> right.rva1007_3_0_reason4, Right.rva1007_3_0_reason4, ''),
self.rva1008_1_0_score := if(Left.rva1008_1_0_score <> right.rva1008_1_0_score, Right.rva1008_1_0_score, ''),
self.rva1008_1_0_reason1 := if(Left.rva1008_1_0_reason1 <> right.rva1008_1_0_reason1, Right.rva1008_1_0_reason1, ''),
self.rva1008_1_0_reason2 := if(Left.rva1008_1_0_reason2 <> right.rva1008_1_0_reason2, Right.rva1008_1_0_reason2, ''),
self.rva1008_1_0_reason3 := if(Left.rva1008_1_0_reason3 <> right.rva1008_1_0_reason3, Right.rva1008_1_0_reason3, ''),
self.rva1008_1_0_reason4 := if(Left.rva1008_1_0_reason4 <> right.rva1008_1_0_reason4, Right.rva1008_1_0_reason4, ''),
self.rva1008_2_0_score := if(Left.rva1008_2_0_score <> right.rva1008_2_0_score, Right.rva1008_2_0_score, ''),
self.rva1008_2_0_reason1 := if(Left.rva1008_2_0_reason1 <> right.rva1008_2_0_reason1, Right.rva1008_2_0_reason1, ''),
self.rva1008_2_0_reason2 := if(Left.rva1008_2_0_reason2 <> right.rva1008_2_0_reason2, Right.rva1008_2_0_reason2, ''),
self.rva1008_2_0_reason3 := if(Left.rva1008_2_0_reason3 <> right.rva1008_2_0_reason3, Right.rva1008_2_0_reason3, ''),
self.rva1008_2_0_reason4 := if(Left.rva1008_2_0_reason4 <> right.rva1008_2_0_reason4, Right.rva1008_2_0_reason4, ''),
self.rva1104_0_0_score := if(Left.rva1104_0_0_score <> right.rva1104_0_0_score, Right.rva1104_0_0_score, ''),
self.rva1104_0_0_reason1 := if(Left.rva1104_0_0_reason1 <> right.rva1104_0_0_reason1, Right.rva1104_0_0_reason1, ''),
self.rva1104_0_0_reason2 := if(Left.rva1104_0_0_reason2 <> right.rva1104_0_0_reason2, Right.rva1104_0_0_reason2, ''),
self.rva1104_0_0_reason3 := if(Left.rva1104_0_0_reason3 <> right.rva1104_0_0_reason3, Right.rva1104_0_0_reason3, ''),
self.rva1104_0_0_reason4 := if(Left.rva1104_0_0_reason4 <> right.rva1104_0_0_reason4, Right.rva1104_0_0_reason4, ''),
self.rva1304_1_0_score := if(Left.rva1304_1_0_score <> right.rva1304_1_0_score, Right.rva1304_1_0_score, ''),
self.rva1304_1_0_reason1 := if(Left.rva1304_1_0_reason1 <> right.rva1304_1_0_reason1, Right.rva1304_1_0_reason1, ''),
self.rva1304_1_0_reason2 := if(Left.rva1304_1_0_reason2 <> right.rva1304_1_0_reason2, Right.rva1304_1_0_reason2, ''),
self.rva1304_1_0_reason3 := if(Left.rva1304_1_0_reason3 <> right.rva1304_1_0_reason3, Right.rva1304_1_0_reason3, ''),
self.rva1304_1_0_reason4 := if(Left.rva1304_1_0_reason4 <> right.rva1304_1_0_reason4, Right.rva1304_1_0_reason4, ''),
self.rva1304_2_0_score := if(Left.rva1304_2_0_score <> right.rva1304_2_0_score, Right.rva1304_2_0_score, ''),
self.rva1304_2_0_reason1 := if(Left.rva1304_2_0_reason1 <> right.rva1304_2_0_reason1, Right.rva1304_2_0_reason1, ''),
self.rva1304_2_0_reason2 := if(Left.rva1304_2_0_reason2 <> right.rva1304_2_0_reason2, Right.rva1304_2_0_reason2, ''),
self.rva1304_2_0_reason3 := if(Left.rva1304_2_0_reason3 <> right.rva1304_2_0_reason3, Right.rva1304_2_0_reason3, ''),
self.rva1304_2_0_reason4 := if(Left.rva1304_2_0_reason4 <> right.rva1304_2_0_reason4, Right.rva1304_2_0_reason4, ''),
self.rva1305_1_0_score := if(Left.rva1305_1_0_score <> right.rva1305_1_0_score, Right.rva1305_1_0_score, ''),
self.rva1305_1_0_reason1 := if(Left.rva1305_1_0_reason1 <> right.rva1305_1_0_reason1, Right.rva1305_1_0_reason1, ''),
self.rva1305_1_0_reason2 := if(Left.rva1305_1_0_reason2 <> right.rva1305_1_0_reason2, Right.rva1305_1_0_reason2, ''),
self.rva1305_1_0_reason3 := if(Left.rva1305_1_0_reason3 <> right.rva1305_1_0_reason3, Right.rva1305_1_0_reason3, ''),
self.rva1305_1_0_reason4 := if(Left.rva1305_1_0_reason4 <> right.rva1305_1_0_reason4, Right.rva1305_1_0_reason4, ''),
self.rva1306_1_0_score := if(Left.rva1306_1_0_score <> right.rva1306_1_0_score, Right.rva1306_1_0_score, ''),
self.rva1306_1_0_reason1 := if(Left.rva1306_1_0_reason1 <> right.rva1306_1_0_reason1, Right.rva1306_1_0_reason1, ''),
self.rva1306_1_0_reason2 := if(Left.rva1306_1_0_reason2 <> right.rva1306_1_0_reason2, Right.rva1306_1_0_reason2, ''),
self.rva1306_1_0_reason3 := if(Left.rva1306_1_0_reason3 <> right.rva1306_1_0_reason3, Right.rva1306_1_0_reason3, ''),
self.rva1306_1_0_reason4 := if(Left.rva1306_1_0_reason4 <> right.rva1306_1_0_reason4, Right.rva1306_1_0_reason4, ''),
self.rva1309_1_0_score := if(Left.rva1309_1_0_score <> right.rva1309_1_0_score, Right.rva1309_1_0_score, ''),
self.rva1309_1_0_reason1 := if(Left.rva1309_1_0_reason1 <> right.rva1309_1_0_reason1, Right.rva1309_1_0_reason1, ''),
self.rva1309_1_0_reason2 := if(Left.rva1309_1_0_reason2 <> right.rva1309_1_0_reason2, Right.rva1309_1_0_reason2, ''),
self.rva1309_1_0_reason3 := if(Left.rva1309_1_0_reason3 <> right.rva1309_1_0_reason3, Right.rva1309_1_0_reason3, ''),
self.rva1309_1_0_reason4 := if(Left.rva1309_1_0_reason4 <> right.rva1309_1_0_reason4, Right.rva1309_1_0_reason4, ''),
self.rva1310_1_0_score := if(Left.rva1310_1_0_score <> right.rva1310_1_0_score, Right.rva1310_1_0_score, ''),
self.rva1310_1_0_reason1 := if(Left.rva1310_1_0_reason1 <> right.rva1310_1_0_reason1, Right.rva1310_1_0_reason1, ''),
self.rva1310_1_0_reason2 := if(Left.rva1310_1_0_reason2 <> right.rva1310_1_0_reason2, Right.rva1310_1_0_reason2, ''),
self.rva1310_1_0_reason3 := if(Left.rva1310_1_0_reason3 <> right.rva1310_1_0_reason3, Right.rva1310_1_0_reason3, ''),
self.rva1310_1_0_reason4 := if(Left.rva1310_1_0_reason4 <> right.rva1310_1_0_reason4, Right.rva1310_1_0_reason4, ''),
self.rva1310_2_0_score := if(Left.rva1310_2_0_score <> right.rva1310_2_0_score, Right.rva1310_2_0_score, ''),
self.rva1310_2_0_reason1 := if(Left.rva1310_2_0_reason1 <> right.rva1310_2_0_reason1, Right.rva1310_2_0_reason1, ''),
self.rva1310_2_0_reason2 := if(Left.rva1310_2_0_reason2 <> right.rva1310_2_0_reason2, Right.rva1310_2_0_reason2, ''),
self.rva1310_2_0_reason3 := if(Left.rva1310_2_0_reason3 <> right.rva1310_2_0_reason3, Right.rva1310_2_0_reason3, ''),
self.rva1310_2_0_reason4 := if(Left.rva1310_2_0_reason4 <> right.rva1310_2_0_reason4, Right.rva1310_2_0_reason4, ''),
self.rva1310_3_0_score := if(Left.rva1310_3_0_score <> right.rva1310_3_0_score, Right.rva1310_3_0_score, ''),
self.rva1310_3_0_reason1 := if(Left.rva1310_3_0_reason1 <> right.rva1310_3_0_reason1, Right.rva1310_3_0_reason1, ''),
self.rva1310_3_0_reason2 := if(Left.rva1310_3_0_reason2 <> right.rva1310_3_0_reason2, Right.rva1310_3_0_reason2, ''),
self.rva1310_3_0_reason3 := if(Left.rva1310_3_0_reason3 <> right.rva1310_3_0_reason3, Right.rva1310_3_0_reason3, ''),
self.rva1310_3_0_reason4 := if(Left.rva1310_3_0_reason4 <> right.rva1310_3_0_reason4, Right.rva1310_3_0_reason4, ''),
self.rva1311_1_0_score := if(Left.rva1311_1_0_score <> right.rva1311_1_0_score, Right.rva1311_1_0_score, ''),
self.rva1311_1_0_reason1 := if(Left.rva1311_1_0_reason1 <> right.rva1311_1_0_reason1, Right.rva1311_1_0_reason1, ''),
self.rva1311_1_0_reason2 := if(Left.rva1311_1_0_reason2 <> right.rva1311_1_0_reason2, Right.rva1311_1_0_reason2, ''),
self.rva1311_1_0_reason3 := if(Left.rva1311_1_0_reason3 <> right.rva1311_1_0_reason3, Right.rva1311_1_0_reason3, ''),
self.rva1311_1_0_reason4 := if(Left.rva1311_1_0_reason4 <> right.rva1311_1_0_reason4, Right.rva1311_1_0_reason4, ''),
self.rva1311_2_0_score := if(Left.rva1311_2_0_score <> right.rva1311_2_0_score, Right.rva1311_2_0_score, ''),
self.rva1311_2_0_reason1 := if(Left.rva1311_2_0_reason1 <> right.rva1311_2_0_reason1, Right.rva1311_2_0_reason1, ''),
self.rva1311_2_0_reason2 := if(Left.rva1311_2_0_reason2 <> right.rva1311_2_0_reason2, Right.rva1311_2_0_reason2, ''),
self.rva1311_2_0_reason3 := if(Left.rva1311_2_0_reason3 <> right.rva1311_2_0_reason3, Right.rva1311_2_0_reason3, ''),
self.rva1311_2_0_reason4 := if(Left.rva1311_2_0_reason4 <> right.rva1311_2_0_reason4, Right.rva1311_2_0_reason4, ''),
self.rva1311_3_0_score := if(Left.rva1311_3_0_score <> right.rva1311_3_0_score, Right.rva1311_3_0_score, ''),
self.rva1311_3_0_reason1 := if(Left.rva1311_3_0_reason1 <> right.rva1311_3_0_reason1, Right.rva1311_3_0_reason1, ''),
self.rva1311_3_0_reason2 := if(Left.rva1311_3_0_reason2 <> right.rva1311_3_0_reason2, Right.rva1311_3_0_reason2, ''),
self.rva1311_3_0_reason3 := if(Left.rva1311_3_0_reason3 <> right.rva1311_3_0_reason3, Right.rva1311_3_0_reason3, ''),
self.rva1311_3_0_reason4 := if(Left.rva1311_3_0_reason4 <> right.rva1311_3_0_reason4, Right.rva1311_3_0_reason4, ''),
self.rva1503_0_0_score := if(Left.rva1503_0_0_score <> right.rva1503_0_0_score, Right.rva1503_0_0_score, ''),
self.rva1503_0_0_reason1 := if(Left.rva1503_0_0_reason1 <> right.rva1503_0_0_reason1, Right.rva1503_0_0_reason1, ''),
self.rva1503_0_0_reason2 := if(Left.rva1503_0_0_reason2 <> right.rva1503_0_0_reason2, Right.rva1503_0_0_reason2, ''),
self.rva1503_0_0_reason3 := if(Left.rva1503_0_0_reason3 <> right.rva1503_0_0_reason3, Right.rva1503_0_0_reason3, ''),
self.rva1503_0_0_reason4 := if(Left.rva1503_0_0_reason4 <> right.rva1503_0_0_reason4, Right.rva1503_0_0_reason4, ''),
self.rva1504_1_0_score := if(Left.rva1504_1_0_score <> right.rva1504_1_0_score, Right.rva1504_1_0_score, ''),
self.rva1504_1_0_reason1 := if(Left.rva1504_1_0_reason1 <> right.rva1504_1_0_reason1, Right.rva1504_1_0_reason1, ''),
self.rva1504_1_0_reason2 := if(Left.rva1504_1_0_reason2 <> right.rva1504_1_0_reason2, Right.rva1504_1_0_reason2, ''),
self.rva1504_1_0_reason3 := if(Left.rva1504_1_0_reason3 <> right.rva1504_1_0_reason3, Right.rva1504_1_0_reason3, ''),
self.rva1504_1_0_reason4 := if(Left.rva1504_1_0_reason4 <> right.rva1504_1_0_reason4, Right.rva1504_1_0_reason4, ''),
self.rva1504_2_0_score := if(Left.rva1504_2_0_score <> right.rva1504_2_0_score, Right.rva1504_2_0_score, ''),
self.rva1504_2_0_reason1 := if(Left.rva1504_2_0_reason1 <> right.rva1504_2_0_reason1, Right.rva1504_2_0_reason1, ''),
self.rva1504_2_0_reason2 := if(Left.rva1504_2_0_reason2 <> right.rva1504_2_0_reason2, Right.rva1504_2_0_reason2, ''),
self.rva1504_2_0_reason3 := if(Left.rva1504_2_0_reason3 <> right.rva1504_2_0_reason3, Right.rva1504_2_0_reason3, ''),
self.rva1504_2_0_reason4 := if(Left.rva1504_2_0_reason4 <> right.rva1504_2_0_reason4, Right.rva1504_2_0_reason4, ''),
self.rva1601_1_0_score := if(Left.rva1601_1_0_score <> right.rva1601_1_0_score, Right.rva1601_1_0_score, ''),
self.rva1601_1_0_reason1 := if(Left.rva1601_1_0_reason1 <> right.rva1601_1_0_reason1, Right.rva1601_1_0_reason1, ''),
self.rva1601_1_0_reason2 := if(Left.rva1601_1_0_reason2 <> right.rva1601_1_0_reason2, Right.rva1601_1_0_reason2, ''),
self.rva1601_1_0_reason3 := if(Left.rva1601_1_0_reason3 <> right.rva1601_1_0_reason3, Right.rva1601_1_0_reason3, ''),
self.rva1601_1_0_reason4 := if(Left.rva1601_1_0_reason4 <> right.rva1601_1_0_reason4, Right.rva1601_1_0_reason4, ''),
self.rva1603_1_0_score := if(Left.rva1603_1_0_score <> right.rva1603_1_0_score, Right.rva1603_1_0_score, ''),
self.rva1603_1_0_reason1 := if(Left.rva1603_1_0_reason1 <> right.rva1603_1_0_reason1, Right.rva1603_1_0_reason1, ''),
self.rva1603_1_0_reason2 := if(Left.rva1603_1_0_reason2 <> right.rva1603_1_0_reason2, Right.rva1603_1_0_reason2, ''),
self.rva1603_1_0_reason3 := if(Left.rva1603_1_0_reason3 <> right.rva1603_1_0_reason3, Right.rva1603_1_0_reason3, ''),
self.rva1603_1_0_reason4 := if(Left.rva1603_1_0_reason4 <> right.rva1603_1_0_reason4, Right.rva1603_1_0_reason4, ''),
self.rva1605_1_0_score := if(Left.rva1605_1_0_score <> right.rva1605_1_0_score, Right.rva1605_1_0_score, ''),
self.rva1605_1_0_reason1 := if(Left.rva1605_1_0_reason1 <> right.rva1605_1_0_reason1, Right.rva1605_1_0_reason1, ''),
self.rva1605_1_0_reason2 := if(Left.rva1605_1_0_reason2 <> right.rva1605_1_0_reason2, Right.rva1605_1_0_reason2, ''),
self.rva1605_1_0_reason3 := if(Left.rva1605_1_0_reason3 <> right.rva1605_1_0_reason3, Right.rva1605_1_0_reason3, ''),
self.rva1605_1_0_reason4 := if(Left.rva1605_1_0_reason4 <> right.rva1605_1_0_reason4, Right.rva1605_1_0_reason4, ''),
self.rva1607_1_0_score := if(Left.rva1607_1_0_score <> right.rva1607_1_0_score, Right.rva1607_1_0_score, ''),
self.rva1607_1_0_reason1 := if(Left.rva1607_1_0_reason1 <> right.rva1607_1_0_reason1, Right.rva1607_1_0_reason1, ''),
self.rva1607_1_0_reason2 := if(Left.rva1607_1_0_reason2 <> right.rva1607_1_0_reason2, Right.rva1607_1_0_reason2, ''),
self.rva1607_1_0_reason3 := if(Left.rva1607_1_0_reason3 <> right.rva1607_1_0_reason3, Right.rva1607_1_0_reason3, ''),
self.rva1607_1_0_reason4 := if(Left.rva1607_1_0_reason4 <> right.rva1607_1_0_reason4, Right.rva1607_1_0_reason4, ''),
self.rva611_0_0_score := if(Left.rva611_0_0_score <> right.rva611_0_0_score, Right.rva611_0_0_score, ''),
self.rva611_0_0_reason1 := if(Left.rva611_0_0_reason1 <> right.rva611_0_0_reason1, Right.rva611_0_0_reason1, ''),
self.rva611_0_0_reason2 := if(Left.rva611_0_0_reason2 <> right.rva611_0_0_reason2, Right.rva611_0_0_reason2, ''),
self.rva611_0_0_reason3 := if(Left.rva611_0_0_reason3 <> right.rva611_0_0_reason3, Right.rva611_0_0_reason3, ''),
self.rva611_0_0_reason4 := if(Left.rva611_0_0_reason4 <> right.rva611_0_0_reason4, Right.rva611_0_0_reason4, ''),
self.rva707_0_0_score := if(Left.rva707_0_0_score <> right.rva707_0_0_score, Right.rva707_0_0_score, ''),
self.rva707_0_0_reason1 := if(Left.rva707_0_0_reason1 <> right.rva707_0_0_reason1, Right.rva707_0_0_reason1, ''),
self.rva707_0_0_reason2 := if(Left.rva707_0_0_reason2 <> right.rva707_0_0_reason2, Right.rva707_0_0_reason2, ''),
self.rva707_0_0_reason3 := if(Left.rva707_0_0_reason3 <> right.rva707_0_0_reason3, Right.rva707_0_0_reason3, ''),
self.rva707_0_0_reason4 := if(Left.rva707_0_0_reason4 <> right.rva707_0_0_reason4, Right.rva707_0_0_reason4, ''),
self.rva707_1_0_score := if(Left.rva707_1_0_score <> right.rva707_1_0_score, Right.rva707_1_0_score, ''),
self.rva707_1_0_reason1 := if(Left.rva707_1_0_reason1 <> right.rva707_1_0_reason1, Right.rva707_1_0_reason1, ''),
self.rva707_1_0_reason2 := if(Left.rva707_1_0_reason2 <> right.rva707_1_0_reason2, Right.rva707_1_0_reason2, ''),
self.rva707_1_0_reason3 := if(Left.rva707_1_0_reason3 <> right.rva707_1_0_reason3, Right.rva707_1_0_reason3, ''),
self.rva707_1_0_reason4 := if(Left.rva707_1_0_reason4 <> right.rva707_1_0_reason4, Right.rva707_1_0_reason4, ''),
self.rva709_1_0_score := if(Left.rva709_1_0_score <> right.rva709_1_0_score, Right.rva709_1_0_score, ''),
self.rva709_1_0_reason1 := if(Left.rva709_1_0_reason1 <> right.rva709_1_0_reason1, Right.rva709_1_0_reason1, ''),
self.rva709_1_0_reason2 := if(Left.rva709_1_0_reason2 <> right.rva709_1_0_reason2, Right.rva709_1_0_reason2, ''),
self.rva709_1_0_reason3 := if(Left.rva709_1_0_reason3 <> right.rva709_1_0_reason3, Right.rva709_1_0_reason3, ''),
self.rva709_1_0_reason4 := if(Left.rva709_1_0_reason4 <> right.rva709_1_0_reason4, Right.rva709_1_0_reason4, ''),
self.rva711_0_0_score := if(Left.rva711_0_0_score <> right.rva711_0_0_score, Right.rva711_0_0_score, ''),
self.rva711_0_0_reason1 := if(Left.rva711_0_0_reason1 <> right.rva711_0_0_reason1, Right.rva711_0_0_reason1, ''),
self.rva711_0_0_reason2 := if(Left.rva711_0_0_reason2 <> right.rva711_0_0_reason2, Right.rva711_0_0_reason2, ''),
self.rva711_0_0_reason3 := if(Left.rva711_0_0_reason3 <> right.rva711_0_0_reason3, Right.rva711_0_0_reason3, ''),
self.rva711_0_0_reason4 := if(Left.rva711_0_0_reason4 <> right.rva711_0_0_reason4, Right.rva711_0_0_reason4, ''),
self.rva1611_1_0_score := if(Left.rva1611_1_0_score <> right.rva1611_1_0_score, Right.rva1611_1_0_score, ''),
self.rva1611_1_0_reason1 := if(Left.rva1611_1_0_reason1 <> right.rva1611_1_0_reason1, Right.rva1611_1_0_reason1, ''),
self.rva1611_1_0_reason2 := if(Left.rva1611_1_0_reason2 <> right.rva1611_1_0_reason2, Right.rva1611_1_0_reason2, ''),
self.rva1611_1_0_reason3 := if(Left.rva1611_1_0_reason3 <> right.rva1611_1_0_reason3, Right.rva1611_1_0_reason3, ''),
self.rva1611_1_0_reason4 := if(Left.rva1611_1_0_reason4 <> right.rva1611_1_0_reason4, Right.rva1611_1_0_reason4, ''),
self.rva1611_2_0_score := if(Left.rva1611_2_0_score <> right.rva1611_2_0_score, Right.rva1611_2_0_score, ''),
self.rva1611_2_0_reason1 := if(Left.rva1611_2_0_reason1 <> right.rva1611_2_0_reason1, Right.rva1611_2_0_reason1, ''),
self.rva1611_2_0_reason2 := if(Left.rva1611_2_0_reason2 <> right.rva1611_2_0_reason2, Right.rva1611_2_0_reason2, ''),
self.rva1611_2_0_reason3 := if(Left.rva1611_2_0_reason3 <> right.rva1611_2_0_reason3, Right.rva1611_2_0_reason3, ''),
self.rva1611_2_0_reason4 := if(Left.rva1611_2_0_reason4 <> right.rva1611_2_0_reason4, Right.rva1611_2_0_reason4, ''),
self.rvb1003_0_0_score := if(Left.rvb1003_0_0_score <> right.rvb1003_0_0_score, Right.rvb1003_0_0_score, ''),
self.rvb1003_0_0_reason1 := if(Left.rvb1003_0_0_reason1 <> right.rvb1003_0_0_reason1, Right.rvb1003_0_0_reason1, ''),
self.rvb1003_0_0_reason2 := if(Left.rvb1003_0_0_reason2 <> right.rvb1003_0_0_reason2, Right.rvb1003_0_0_reason2, ''),
self.rvb1003_0_0_reason3 := if(Left.rvb1003_0_0_reason3 <> right.rvb1003_0_0_reason3, Right.rvb1003_0_0_reason3, ''),
self.rvb1003_0_0_reason4 := if(Left.rvb1003_0_0_reason4 <> right.rvb1003_0_0_reason4, Right.rvb1003_0_0_reason4, ''),
self.rvb1104_0_0_score := if(Left.rvb1104_0_0_score <> right.rvb1104_0_0_score, Right.rvb1104_0_0_score, ''),
self.rvb1104_0_0_reason1 := if(Left.rvb1104_0_0_reason1 <> right.rvb1104_0_0_reason1, Right.rvb1104_0_0_reason1, ''),
self.rvb1104_0_0_reason2 := if(Left.rvb1104_0_0_reason2 <> right.rvb1104_0_0_reason2, Right.rvb1104_0_0_reason2, ''),
self.rvb1104_0_0_reason3 := if(Left.rvb1104_0_0_reason3 <> right.rvb1104_0_0_reason3, Right.rvb1104_0_0_reason3, ''),
self.rvb1104_0_0_reason4 := if(Left.rvb1104_0_0_reason4 <> right.rvb1104_0_0_reason4, Right.rvb1104_0_0_reason4, ''),
self.rvb1104_1_0_score := if(Left.rvb1104_1_0_score <> right.rvb1104_1_0_score, Right.rvb1104_1_0_score, ''),
self.rvb1104_1_0_reason1 := if(Left.rvb1104_1_0_reason1 <> right.rvb1104_1_0_reason1, Right.rvb1104_1_0_reason1, ''),
self.rvb1104_1_0_reason2 := if(Left.rvb1104_1_0_reason2 <> right.rvb1104_1_0_reason2, Right.rvb1104_1_0_reason2, ''),
self.rvb1104_1_0_reason3 := if(Left.rvb1104_1_0_reason3 <> right.rvb1104_1_0_reason3, Right.rvb1104_1_0_reason3, ''),
self.rvb1104_1_0_reason4 := if(Left.rvb1104_1_0_reason4 <> right.rvb1104_1_0_reason4, Right.rvb1104_1_0_reason4, ''),
self.rvb1310_1_0_score := if(Left.rvb1310_1_0_score <> right.rvb1310_1_0_score, Right.rvb1310_1_0_score, ''),
self.rvb1310_1_0_reason1 := if(Left.rvb1310_1_0_reason1 <> right.rvb1310_1_0_reason1, Right.rvb1310_1_0_reason1, ''),
self.rvb1310_1_0_reason2 := if(Left.rvb1310_1_0_reason2 <> right.rvb1310_1_0_reason2, Right.rvb1310_1_0_reason2, ''),
self.rvb1310_1_0_reason3 := if(Left.rvb1310_1_0_reason3 <> right.rvb1310_1_0_reason3, Right.rvb1310_1_0_reason3, ''),
self.rvb1310_1_0_reason4 := if(Left.rvb1310_1_0_reason4 <> right.rvb1310_1_0_reason4, Right.rvb1310_1_0_reason4, ''),
self.rvb1402_1_0_score := if(Left.rvb1402_1_0_score <> right.rvb1402_1_0_score, Right.rvb1402_1_0_score, ''),
self.rvb1402_1_0_reason1 := if(Left.rvb1402_1_0_reason1 <> right.rvb1402_1_0_reason1, Right.rvb1402_1_0_reason1, ''),
self.rvb1402_1_0_reason2 := if(Left.rvb1402_1_0_reason2 <> right.rvb1402_1_0_reason2, Right.rvb1402_1_0_reason2, ''),
self.rvb1402_1_0_reason3 := if(Left.rvb1402_1_0_reason3 <> right.rvb1402_1_0_reason3, Right.rvb1402_1_0_reason3, ''),
self.rvb1402_1_0_reason4 := if(Left.rvb1402_1_0_reason4 <> right.rvb1402_1_0_reason4, Right.rvb1402_1_0_reason4, ''),
self.rvb1503_0_0_score := if(Left.rvb1503_0_0_score <> right.rvb1503_0_0_score, Right.rvb1503_0_0_score, ''),
self.rvb1503_0_0_reason1 := if(Left.rvb1503_0_0_reason1 <> right.rvb1503_0_0_reason1, Right.rvb1503_0_0_reason1, ''),
self.rvb1503_0_0_reason2 := if(Left.rvb1503_0_0_reason2 <> right.rvb1503_0_0_reason2, Right.rvb1503_0_0_reason2, ''),
self.rvb1503_0_0_reason3 := if(Left.rvb1503_0_0_reason3 <> right.rvb1503_0_0_reason3, Right.rvb1503_0_0_reason3, ''),
self.rvb1503_0_0_reason4 := if(Left.rvb1503_0_0_reason4 <> right.rvb1503_0_0_reason4, Right.rvb1503_0_0_reason4, ''),
self.rvb609_0_0_score := if(Left.rvb609_0_0_score <> right.rvb609_0_0_score, Right.rvb609_0_0_score, ''),
self.rvb609_0_0_reason1 := if(Left.rvb609_0_0_reason1 <> right.rvb609_0_0_reason1, Right.rvb609_0_0_reason1, ''),
self.rvb609_0_0_reason2 := if(Left.rvb609_0_0_reason2 <> right.rvb609_0_0_reason2, Right.rvb609_0_0_reason2, ''),
self.rvb609_0_0_reason3 := if(Left.rvb609_0_0_reason3 <> right.rvb609_0_0_reason3, Right.rvb609_0_0_reason3, ''),
self.rvb609_0_0_reason4 := if(Left.rvb609_0_0_reason4 <> right.rvb609_0_0_reason4, Right.rvb609_0_0_reason4, ''),
self.rvb703_1_0_score := if(Left.rvb703_1_0_score <> right.rvb703_1_0_score, Right.rvb703_1_0_score, ''),
self.rvb703_1_0_reason1 := if(Left.rvb703_1_0_reason1 <> right.rvb703_1_0_reason1, Right.rvb703_1_0_reason1, ''),
self.rvb703_1_0_reason2 := if(Left.rvb703_1_0_reason2 <> right.rvb703_1_0_reason2, Right.rvb703_1_0_reason2, ''),
self.rvb703_1_0_reason3 := if(Left.rvb703_1_0_reason3 <> right.rvb703_1_0_reason3, Right.rvb703_1_0_reason3, ''),
self.rvb703_1_0_reason4 := if(Left.rvb703_1_0_reason4 <> right.rvb703_1_0_reason4, Right.rvb703_1_0_reason4, ''),
self.rvb705_1_0_score := if(Left.rvb705_1_0_score <> right.rvb705_1_0_score, Right.rvb705_1_0_score, ''),
self.rvb705_1_0_reason1 := if(Left.rvb705_1_0_reason1 <> right.rvb705_1_0_reason1, Right.rvb705_1_0_reason1, ''),
self.rvb705_1_0_reason2 := if(Left.rvb705_1_0_reason2 <> right.rvb705_1_0_reason2, Right.rvb705_1_0_reason2, ''),
self.rvb705_1_0_reason3 := if(Left.rvb705_1_0_reason3 <> right.rvb705_1_0_reason3, Right.rvb705_1_0_reason3, ''),
self.rvb705_1_0_reason4 := if(Left.rvb705_1_0_reason4 <> right.rvb705_1_0_reason4, Right.rvb705_1_0_reason4, ''),
self.rvb711_0_0_score := if(Left.rvb711_0_0_score <> right.rvb711_0_0_score, Right.rvb711_0_0_score, ''),
self.rvb711_0_0_reason1 := if(Left.rvb711_0_0_reason1 <> right.rvb711_0_0_reason1, Right.rvb711_0_0_reason1, ''),
self.rvb711_0_0_reason2 := if(Left.rvb711_0_0_reason2 <> right.rvb711_0_0_reason2, Right.rvb711_0_0_reason2, ''),
self.rvb711_0_0_reason3 := if(Left.rvb711_0_0_reason3 <> right.rvb711_0_0_reason3, Right.rvb711_0_0_reason3, ''),
self.rvb711_0_0_reason4 := if(Left.rvb711_0_0_reason4 <> right.rvb711_0_0_reason4, Right.rvb711_0_0_reason4, ''),
self.rvb1610_1_0_score := if(Left.rvb1610_1_0_score <> right.rvb1610_1_0_score, Right.rvb1610_1_0_score, ''),
self.rvb1610_1_0_reason1 := if(Left.rvb1610_1_0_reason1 <> right.rvb1610_1_0_reason1, Right.rvb1610_1_0_reason1, ''),
self.rvb1610_1_0_reason2 := if(Left.rvb1610_1_0_reason2 <> right.rvb1610_1_0_reason2, Right.rvb1610_1_0_reason2, ''),
self.rvb1610_1_0_reason3 := if(Left.rvb1610_1_0_reason3 <> right.rvb1610_1_0_reason3, Right.rvb1610_1_0_reason3, ''),
self.rvb1610_1_0_reason4 := if(Left.rvb1610_1_0_reason4 <> right.rvb1610_1_0_reason4, Right.rvb1610_1_0_reason4, ''),
self.rvc1110_1_0_score := if(Left.rvc1110_1_0_score <> right.rvc1110_1_0_score, Right.rvc1110_1_0_score, ''),
self.rvc1110_1_0_reason1 := if(Left.rvc1110_1_0_reason1 <> right.rvc1110_1_0_reason1, Right.rvc1110_1_0_reason1, ''),
self.rvc1110_1_0_reason2 := if(Left.rvc1110_1_0_reason2 <> right.rvc1110_1_0_reason2, Right.rvc1110_1_0_reason2, ''),
self.rvc1110_1_0_reason3 := if(Left.rvc1110_1_0_reason3 <> right.rvc1110_1_0_reason3, Right.rvc1110_1_0_reason3, ''),
self.rvc1110_1_0_reason4 := if(Left.rvc1110_1_0_reason4 <> right.rvc1110_1_0_reason4, Right.rvc1110_1_0_reason4, ''),
self.rvc1110_2_0_score := if(Left.rvc1110_2_0_score <> right.rvc1110_2_0_score, Right.rvc1110_2_0_score, ''),
self.rvc1110_2_0_reason1 := if(Left.rvc1110_2_0_reason1 <> right.rvc1110_2_0_reason1, Right.rvc1110_2_0_reason1, ''),
self.rvc1110_2_0_reason2 := if(Left.rvc1110_2_0_reason2 <> right.rvc1110_2_0_reason2, Right.rvc1110_2_0_reason2, ''),
self.rvc1110_2_0_reason3 := if(Left.rvc1110_2_0_reason3 <> right.rvc1110_2_0_reason3, Right.rvc1110_2_0_reason3, ''),
self.rvc1110_2_0_reason4 := if(Left.rvc1110_2_0_reason4 <> right.rvc1110_2_0_reason4, Right.rvc1110_2_0_reason4, ''),
self.rvc1112_0_0_score := if(Left.rvc1112_0_0_score <> right.rvc1112_0_0_score, Right.rvc1112_0_0_score, ''),
self.rvc1112_0_0_reason1 := if(Left.rvc1112_0_0_reason1 <> right.rvc1112_0_0_reason1, Right.rvc1112_0_0_reason1, ''),
self.rvc1112_0_0_reason2 := if(Left.rvc1112_0_0_reason2 <> right.rvc1112_0_0_reason2, Right.rvc1112_0_0_reason2, ''),
self.rvc1112_0_0_reason3 := if(Left.rvc1112_0_0_reason3 <> right.rvc1112_0_0_reason3, Right.rvc1112_0_0_reason3, ''),
self.rvc1112_0_0_reason4 := if(Left.rvc1112_0_0_reason4 <> right.rvc1112_0_0_reason4, Right.rvc1112_0_0_reason4, ''),
self.rvc1208_1_0_score := if(Left.rvc1208_1_0_score <> right.rvc1208_1_0_score, Right.rvc1208_1_0_score, ''),
self.rvc1208_1_0_reason1 := if(Left.rvc1208_1_0_reason1 <> right.rvc1208_1_0_reason1, Right.rvc1208_1_0_reason1, ''),
self.rvc1208_1_0_reason2 := if(Left.rvc1208_1_0_reason2 <> right.rvc1208_1_0_reason2, Right.rvc1208_1_0_reason2, ''),
self.rvc1208_1_0_reason3 := if(Left.rvc1208_1_0_reason3 <> right.rvc1208_1_0_reason3, Right.rvc1208_1_0_reason3, ''),
self.rvc1208_1_0_reason4 := if(Left.rvc1208_1_0_reason4 <> right.rvc1208_1_0_reason4, Right.rvc1208_1_0_reason4, ''),
self.rvc1210_1_0_score := if(Left.rvc1210_1_0_score <> right.rvc1210_1_0_score, Right.rvc1210_1_0_score, ''),
self.rvc1210_1_0_reason1 := if(Left.rvc1210_1_0_reason1 <> right.rvc1210_1_0_reason1, Right.rvc1210_1_0_reason1, ''),
self.rvc1210_1_0_reason2 := if(Left.rvc1210_1_0_reason2 <> right.rvc1210_1_0_reason2, Right.rvc1210_1_0_reason2, ''),
self.rvc1210_1_0_reason3 := if(Left.rvc1210_1_0_reason3 <> right.rvc1210_1_0_reason3, Right.rvc1210_1_0_reason3, ''),
self.rvc1210_1_0_reason4 := if(Left.rvc1210_1_0_reason4 <> right.rvc1210_1_0_reason4, Right.rvc1210_1_0_reason4, ''),
self.rvc1301_1_0_score := if(Left.rvc1301_1_0_score <> right.rvc1301_1_0_score, Right.rvc1301_1_0_score, ''),
self.rvc1301_1_0_reason1 := if(Left.rvc1301_1_0_reason1 <> right.rvc1301_1_0_reason1, Right.rvc1301_1_0_reason1, ''),
self.rvc1301_1_0_reason2 := if(Left.rvc1301_1_0_reason2 <> right.rvc1301_1_0_reason2, Right.rvc1301_1_0_reason2, ''),
self.rvc1301_1_0_reason3 := if(Left.rvc1301_1_0_reason3 <> right.rvc1301_1_0_reason3, Right.rvc1301_1_0_reason3, ''),
self.rvc1301_1_0_reason4 := if(Left.rvc1301_1_0_reason4 <> right.rvc1301_1_0_reason4, Right.rvc1301_1_0_reason4, ''),
self.rvc1307_1_0_score := if(Left.rvc1307_1_0_score <> right.rvc1307_1_0_score, Right.rvc1307_1_0_score, ''),
self.rvc1307_1_0_reason1 := if(Left.rvc1307_1_0_reason1 <> right.rvc1307_1_0_reason1, Right.rvc1307_1_0_reason1, ''),
self.rvc1307_1_0_reason2 := if(Left.rvc1307_1_0_reason2 <> right.rvc1307_1_0_reason2, Right.rvc1307_1_0_reason2, ''),
self.rvc1307_1_0_reason3 := if(Left.rvc1307_1_0_reason3 <> right.rvc1307_1_0_reason3, Right.rvc1307_1_0_reason3, ''),
self.rvc1307_1_0_reason4 := if(Left.rvc1307_1_0_reason4 <> right.rvc1307_1_0_reason4, Right.rvc1307_1_0_reason4, ''),
self.rvc1405_1_0_score := if(Left.rvc1405_1_0_score <> right.rvc1405_1_0_score, Right.rvc1405_1_0_score, ''),
self.rvc1405_1_0_reason1 := if(Left.rvc1405_1_0_reason1 <> right.rvc1405_1_0_reason1, Right.rvc1405_1_0_reason1, ''),
self.rvc1405_1_0_reason2 := if(Left.rvc1405_1_0_reason2 <> right.rvc1405_1_0_reason2, Right.rvc1405_1_0_reason2, ''),
self.rvc1405_1_0_reason3 := if(Left.rvc1405_1_0_reason3 <> right.rvc1405_1_0_reason3, Right.rvc1405_1_0_reason3, ''),
self.rvc1405_1_0_reason4 := if(Left.rvc1405_1_0_reason4 <> right.rvc1405_1_0_reason4, Right.rvc1405_1_0_reason4, ''),
self.rvc1405_2_0_score := if(Left.rvc1405_2_0_score <> right.rvc1405_2_0_score, Right.rvc1405_2_0_score, ''),
self.rvc1405_2_0_reason1 := if(Left.rvc1405_2_0_reason1 <> right.rvc1405_2_0_reason1, Right.rvc1405_2_0_reason1, ''),
self.rvc1405_2_0_reason2 := if(Left.rvc1405_2_0_reason2 <> right.rvc1405_2_0_reason2, Right.rvc1405_2_0_reason2, ''),
self.rvc1405_2_0_reason3 := if(Left.rvc1405_2_0_reason3 <> right.rvc1405_2_0_reason3, Right.rvc1405_2_0_reason3, ''),
self.rvc1405_2_0_reason4 := if(Left.rvc1405_2_0_reason4 <> right.rvc1405_2_0_reason4, Right.rvc1405_2_0_reason4, ''),
self.rvc1405_3_0_score := if(Left.rvc1405_3_0_score <> right.rvc1405_3_0_score, Right.rvc1405_3_0_score, ''),
self.rvc1405_3_0_reason1 := if(Left.rvc1405_3_0_reason1 <> right.rvc1405_3_0_reason1, Right.rvc1405_3_0_reason1, ''),
self.rvc1405_3_0_reason2 := if(Left.rvc1405_3_0_reason2 <> right.rvc1405_3_0_reason2, Right.rvc1405_3_0_reason2, ''),
self.rvc1405_3_0_reason3 := if(Left.rvc1405_3_0_reason3 <> right.rvc1405_3_0_reason3, Right.rvc1405_3_0_reason3, ''),
self.rvc1405_3_0_reason4 := if(Left.rvc1405_3_0_reason4 <> right.rvc1405_3_0_reason4, Right.rvc1405_3_0_reason4, ''),
self.rvc1405_4_0_score := if(Left.rvc1405_4_0_score <> right.rvc1405_4_0_score, Right.rvc1405_4_0_score, ''),
self.rvc1405_4_0_reason1 := if(Left.rvc1405_4_0_reason1 <> right.rvc1405_4_0_reason1, Right.rvc1405_4_0_reason1, ''),
self.rvc1405_4_0_reason2 := if(Left.rvc1405_4_0_reason2 <> right.rvc1405_4_0_reason2, Right.rvc1405_4_0_reason2, ''),
self.rvc1405_4_0_reason3 := if(Left.rvc1405_4_0_reason3 <> right.rvc1405_4_0_reason3, Right.rvc1405_4_0_reason3, ''),
self.rvc1405_4_0_reason4 := if(Left.rvc1405_4_0_reason4 <> right.rvc1405_4_0_reason4, Right.rvc1405_4_0_reason4, ''),
self.rvc1412_1_0_score := if(Left.rvc1412_1_0_score <> right.rvc1412_1_0_score, Right.rvc1412_1_0_score, ''),
self.rvc1412_1_0_reason1 := if(Left.rvc1412_1_0_reason1 <> right.rvc1412_1_0_reason1, Right.rvc1412_1_0_reason1, ''),
self.rvc1412_1_0_reason2 := if(Left.rvc1412_1_0_reason2 <> right.rvc1412_1_0_reason2, Right.rvc1412_1_0_reason2, ''),
self.rvc1412_1_0_reason3 := if(Left.rvc1412_1_0_reason3 <> right.rvc1412_1_0_reason3, Right.rvc1412_1_0_reason3, ''),
self.rvc1412_1_0_reason4 := if(Left.rvc1412_1_0_reason4 <> right.rvc1412_1_0_reason4, Right.rvc1412_1_0_reason4, ''),
self.rvc1412_2_0_score := if(Left.rvc1412_2_0_score <> right.rvc1412_2_0_score, Right.rvc1412_2_0_score, ''),
self.rvc1412_2_0_reason1 := if(Left.rvc1412_2_0_reason1 <> right.rvc1412_2_0_reason1, Right.rvc1412_2_0_reason1, ''),
self.rvc1412_2_0_reason2 := if(Left.rvc1412_2_0_reason2 <> right.rvc1412_2_0_reason2, Right.rvc1412_2_0_reason2, ''),
self.rvc1412_2_0_reason3 := if(Left.rvc1412_2_0_reason3 <> right.rvc1412_2_0_reason3, Right.rvc1412_2_0_reason3, ''),
self.rvc1412_2_0_reason4 := if(Left.rvc1412_2_0_reason4 <> right.rvc1412_2_0_reason4, Right.rvc1412_2_0_reason4, ''),
self.rvc1602_1_0_score := if(Left.rvc1602_1_0_score <> right.rvc1602_1_0_score, Right.rvc1602_1_0_score, ''),
self.rvc1602_1_0_reason1 := if(Left.rvc1602_1_0_reason1 <> right.rvc1602_1_0_reason1, Right.rvc1602_1_0_reason1, ''),
self.rvc1602_1_0_reason2 := if(Left.rvc1602_1_0_reason2 <> right.rvc1602_1_0_reason2, Right.rvc1602_1_0_reason2, ''),
self.rvc1602_1_0_reason3 := if(Left.rvc1602_1_0_reason3 <> right.rvc1602_1_0_reason3, Right.rvc1602_1_0_reason3, ''),
self.rvc1602_1_0_reason4 := if(Left.rvc1602_1_0_reason4 <> right.rvc1602_1_0_reason4, Right.rvc1602_1_0_reason4, ''),
self.rvc1609_1_0_score := if(Left.rvc1609_1_0_score <> right.rvc1609_1_0_score, Right.rvc1609_1_0_score, ''),
self.rvc1609_1_0_reason1 := if(Left.rvc1609_1_0_reason1 <> right.rvc1609_1_0_reason1, Right.rvc1609_1_0_reason1, ''),
self.rvc1609_1_0_reason2 := if(Left.rvc1609_1_0_reason2 <> right.rvc1609_1_0_reason2, Right.rvc1609_1_0_reason2, ''),
self.rvc1609_1_0_reason3 := if(Left.rvc1609_1_0_reason3 <> right.rvc1609_1_0_reason3, Right.rvc1609_1_0_reason3, ''),
self.rvc1609_1_0_reason4 := if(Left.rvc1609_1_0_reason4 <> right.rvc1609_1_0_reason4, Right.rvc1609_1_0_reason4, ''),
self.rvc1703_1_0_score := if(Left.rvc1703_1_0_score <> right.rvc1703_1_0_score, Right.rvc1703_1_0_score, ''),
self.rvc1703_1_0_reason1 := if(Left.rvc1703_1_0_reason1 <> right.rvc1703_1_0_reason1, Right.rvc1703_1_0_reason1, ''),
self.rvc1703_1_0_reason2 := if(Left.rvc1703_1_0_reason2 <> right.rvc1703_1_0_reason2, Right.rvc1703_1_0_reason2, ''),
self.rvc1703_1_0_reason3 := if(Left.rvc1703_1_0_reason3 <> right.rvc1703_1_0_reason3, Right.rvc1703_1_0_reason3, ''),
self.rvc1703_1_0_reason4 := if(Left.rvc1703_1_0_reason4 <> right.rvc1703_1_0_reason4, Right.rvc1703_1_0_reason4, ''),
self.rvd1010_0_0_score := if(Left.rvd1010_0_0_score <> right.rvd1010_0_0_score, Right.rvd1010_0_0_score, ''),
self.rvd1010_0_0_reason1 := if(Left.rvd1010_0_0_reason1 <> right.rvd1010_0_0_reason1, Right.rvd1010_0_0_reason1, ''),
self.rvd1010_0_0_reason2 := if(Left.rvd1010_0_0_reason2 <> right.rvd1010_0_0_reason2, Right.rvd1010_0_0_reason2, ''),
self.rvd1010_0_0_reason3 := if(Left.rvd1010_0_0_reason3 <> right.rvd1010_0_0_reason3, Right.rvd1010_0_0_reason3, ''),
self.rvd1010_0_0_reason4 := if(Left.rvd1010_0_0_reason4 <> right.rvd1010_0_0_reason4, Right.rvd1010_0_0_reason4, ''),
self.rvd1010_1_0_score := if(Left.rvd1010_1_0_score <> right.rvd1010_1_0_score, Right.rvd1010_1_0_score, ''),
self.rvd1010_1_0_reason1 := if(Left.rvd1010_1_0_reason1 <> right.rvd1010_1_0_reason1, Right.rvd1010_1_0_reason1, ''),
self.rvd1010_1_0_reason2 := if(Left.rvd1010_1_0_reason2 <> right.rvd1010_1_0_reason2, Right.rvd1010_1_0_reason2, ''),
self.rvd1010_1_0_reason3 := if(Left.rvd1010_1_0_reason3 <> right.rvd1010_1_0_reason3, Right.rvd1010_1_0_reason3, ''),
self.rvd1010_1_0_reason4 := if(Left.rvd1010_1_0_reason4 <> right.rvd1010_1_0_reason4, Right.rvd1010_1_0_reason4, ''),
self.rvd1010_2_0_score := if(Left.rvd1010_2_0_score <> right.rvd1010_2_0_score, Right.rvd1010_2_0_score, ''),
self.rvd1010_2_0_reason1 := if(Left.rvd1010_2_0_reason1 <> right.rvd1010_2_0_reason1, Right.rvd1010_2_0_reason1, ''),
self.rvd1010_2_0_reason2 := if(Left.rvd1010_2_0_reason2 <> right.rvd1010_2_0_reason2, Right.rvd1010_2_0_reason2, ''),
self.rvd1010_2_0_reason3 := if(Left.rvd1010_2_0_reason3 <> right.rvd1010_2_0_reason3, Right.rvd1010_2_0_reason3, ''),
self.rvd1010_2_0_reason4 := if(Left.rvd1010_2_0_reason4 <> right.rvd1010_2_0_reason4, Right.rvd1010_2_0_reason4, ''),
self.rvd1110_1_0_score := if(Left.rvd1110_1_0_score <> right.rvd1110_1_0_score, Right.rvd1110_1_0_score, ''),
self.rvd1110_1_0_reason1 := if(Left.rvd1110_1_0_reason1 <> right.rvd1110_1_0_reason1, Right.rvd1110_1_0_reason1, ''),
self.rvd1110_1_0_reason2 := if(Left.rvd1110_1_0_reason2 <> right.rvd1110_1_0_reason2, Right.rvd1110_1_0_reason2, ''),
self.rvd1110_1_0_reason3 := if(Left.rvd1110_1_0_reason3 <> right.rvd1110_1_0_reason3, Right.rvd1110_1_0_reason3, ''),
self.rvd1110_1_0_reason4 := if(Left.rvd1110_1_0_reason4 <> right.rvd1110_1_0_reason4, Right.rvd1110_1_0_reason4, ''),
self.rvg812_0_0_score := if(Left.rvg812_0_0_score <> right.rvg812_0_0_score, Right.rvg812_0_0_score, ''),
self.rvg812_0_0_reason1 := if(Left.rvg812_0_0_reason1 <> right.rvg812_0_0_reason1, Right.rvg812_0_0_reason1, ''),
self.rvg812_0_0_reason2 := if(Left.rvg812_0_0_reason2 <> right.rvg812_0_0_reason2, Right.rvg812_0_0_reason2, ''),
self.rvg812_0_0_reason3 := if(Left.rvg812_0_0_reason3 <> right.rvg812_0_0_reason3, Right.rvg812_0_0_reason3, ''),
self.rvg812_0_0_reason4 := if(Left.rvg812_0_0_reason4 <> right.rvg812_0_0_reason4, Right.rvg812_0_0_reason4, ''),
self.rvg903_1_0_score := if(Left.rvg903_1_0_score <> right.rvg903_1_0_score, Right.rvg903_1_0_score, ''),
self.rvg904_1_0_score := if(Left.rvg904_1_0_score <> right.rvg904_1_0_score, Right.rvg904_1_0_score, ''),
self.rvg904_1_0_reason1 := if(Left.rvg904_1_0_reason1 <> right.rvg904_1_0_reason1, Right.rvg904_1_0_reason1, ''),
self.rvg904_1_0_reason2 := if(Left.rvg904_1_0_reason2 <> right.rvg904_1_0_reason2, Right.rvg904_1_0_reason2, ''),
self.rvg904_1_0_reason3 := if(Left.rvg904_1_0_reason3 <> right.rvg904_1_0_reason3, Right.rvg904_1_0_reason3, ''),
self.rvg904_1_0_reason4 := if(Left.rvg904_1_0_reason4 <> right.rvg904_1_0_reason4, Right.rvg904_1_0_reason4, ''),
self.rvg1003_0_0_score := if(Left.rvg1003_0_0_score <> right.rvg1003_0_0_score, Right.rvg1003_0_0_score, ''),
self.rvg1003_0_0_reason1 := if(Left.rvg1003_0_0_reason1 <> right.rvg1003_0_0_reason1, Right.rvg1003_0_0_reason1, ''),
self.rvg1003_0_0_reason2 := if(Left.rvg1003_0_0_reason2 <> right.rvg1003_0_0_reason2, Right.rvg1003_0_0_reason2, ''),
self.rvg1003_0_0_reason3 := if(Left.rvg1003_0_0_reason3 <> right.rvg1003_0_0_reason3, Right.rvg1003_0_0_reason3, ''),
self.rvg1003_0_0_reason4 := if(Left.rvg1003_0_0_reason4 <> right.rvg1003_0_0_reason4, Right.rvg1003_0_0_reason4, ''),
self.rvg1103_0_0_score := if(Left.rvg1103_0_0_score <> right.rvg1103_0_0_score, Right.rvg1103_0_0_score, ''),
self.rvg1103_0_0_reason1 := if(Left.rvg1103_0_0_reason1 <> right.rvg1103_0_0_reason1, Right.rvg1103_0_0_reason1, ''),
self.rvg1103_0_0_reason2 := if(Left.rvg1103_0_0_reason2 <> right.rvg1103_0_0_reason2, Right.rvg1103_0_0_reason2, ''),
self.rvg1103_0_0_reason3 := if(Left.rvg1103_0_0_reason3 <> right.rvg1103_0_0_reason3, Right.rvg1103_0_0_reason3, ''),
self.rvg1103_0_0_reason4 := if(Left.rvg1103_0_0_reason4 <> right.rvg1103_0_0_reason4, Right.rvg1103_0_0_reason4, ''),
self.rvg1106_1_0_score := if(Left.rvg1106_1_0_score <> right.rvg1106_1_0_score, Right.rvg1106_1_0_score, ''),
self.rvg1106_1_0_reason1 := if(Left.rvg1106_1_0_reason1 <> right.rvg1106_1_0_reason1, Right.rvg1106_1_0_reason1, ''),
self.rvg1106_1_0_reason2 := if(Left.rvg1106_1_0_reason2 <> right.rvg1106_1_0_reason2, Right.rvg1106_1_0_reason2, ''),
self.rvg1106_1_0_reason3 := if(Left.rvg1106_1_0_reason3 <> right.rvg1106_1_0_reason3, Right.rvg1106_1_0_reason3, ''),
self.rvg1106_1_0_reason4 := if(Left.rvg1106_1_0_reason4 <> right.rvg1106_1_0_reason4, Right.rvg1106_1_0_reason4, ''),
self.rvg1201_1_0_score := if(Left.rvg1201_1_0_score <> right.rvg1201_1_0_score, Right.rvg1201_1_0_score, ''),
self.rvg1201_1_0_reason1 := if(Left.rvg1201_1_0_reason1 <> right.rvg1201_1_0_reason1, Right.rvg1201_1_0_reason1, ''),
self.rvg1201_1_0_reason2 := if(Left.rvg1201_1_0_reason2 <> right.rvg1201_1_0_reason2, Right.rvg1201_1_0_reason2, ''),
self.rvg1201_1_0_reason3 := if(Left.rvg1201_1_0_reason3 <> right.rvg1201_1_0_reason3, Right.rvg1201_1_0_reason3, ''),
self.rvg1201_1_0_reason4 := if(Left.rvg1201_1_0_reason4 <> right.rvg1201_1_0_reason4, Right.rvg1201_1_0_reason4, ''),
self.rvg1302_1_0_score := if(Left.rvg1302_1_0_score <> right.rvg1302_1_0_score, Right.rvg1302_1_0_score, ''),
self.rvg1302_1_0_reason1 := if(Left.rvg1302_1_0_reason1 <> right.rvg1302_1_0_reason1, Right.rvg1302_1_0_reason1, ''),
self.rvg1302_1_0_reason2 := if(Left.rvg1302_1_0_reason2 <> right.rvg1302_1_0_reason2, Right.rvg1302_1_0_reason2, ''),
self.rvg1302_1_0_reason3 := if(Left.rvg1302_1_0_reason3 <> right.rvg1302_1_0_reason3, Right.rvg1302_1_0_reason3, ''),
self.rvg1302_1_0_reason4 := if(Left.rvg1302_1_0_reason4 <> right.rvg1302_1_0_reason4, Right.rvg1302_1_0_reason4, ''),
self.rvg1304_1_0_score := if(Left.rvg1304_1_0_score <> right.rvg1304_1_0_score, Right.rvg1304_1_0_score, ''),
self.rvg1304_1_0_reason1 := if(Left.rvg1304_1_0_reason1 <> right.rvg1304_1_0_reason1, Right.rvg1304_1_0_reason1, ''),
self.rvg1304_1_0_reason2 := if(Left.rvg1304_1_0_reason2 <> right.rvg1304_1_0_reason2, Right.rvg1304_1_0_reason2, ''),
self.rvg1304_1_0_reason3 := if(Left.rvg1304_1_0_reason3 <> right.rvg1304_1_0_reason3, Right.rvg1304_1_0_reason3, ''),
self.rvg1304_1_0_reason4 := if(Left.rvg1304_1_0_reason4 <> right.rvg1304_1_0_reason4, Right.rvg1304_1_0_reason4, ''),
self.rvg1304_2_0_score := if(Left.rvg1304_2_0_score <> right.rvg1304_2_0_score, Right.rvg1304_2_0_score, ''),
self.rvg1304_2_0_reason1 := if(Left.rvg1304_2_0_reason1 <> right.rvg1304_2_0_reason1, Right.rvg1304_2_0_reason1, ''),
self.rvg1304_2_0_reason2 := if(Left.rvg1304_2_0_reason2 <> right.rvg1304_2_0_reason2, Right.rvg1304_2_0_reason2, ''),
self.rvg1304_2_0_reason3 := if(Left.rvg1304_2_0_reason3 <> right.rvg1304_2_0_reason3, Right.rvg1304_2_0_reason3, ''),
self.rvg1304_2_0_reason4 := if(Left.rvg1304_2_0_reason4 <> right.rvg1304_2_0_reason4, Right.rvg1304_2_0_reason4, ''),
self.rvg1401_1_0_score := if(Left.rvg1401_1_0_score <> right.rvg1401_1_0_score, Right.rvg1401_1_0_score, ''),
self.rvg1401_1_0_reason1 := if(Left.rvg1401_1_0_reason1 <> right.rvg1401_1_0_reason1, Right.rvg1401_1_0_reason1, ''),
self.rvg1401_1_0_reason2 := if(Left.rvg1401_1_0_reason2 <> right.rvg1401_1_0_reason2, Right.rvg1401_1_0_reason2, ''),
self.rvg1401_1_0_reason3 := if(Left.rvg1401_1_0_reason3 <> right.rvg1401_1_0_reason3, Right.rvg1401_1_0_reason3, ''),
self.rvg1401_1_0_reason4 := if(Left.rvg1401_1_0_reason4 <> right.rvg1401_1_0_reason4, Right.rvg1401_1_0_reason4, ''),
self.rvg1401_2_0_score := if(Left.rvg1401_2_0_score <> right.rvg1401_2_0_score, Right.rvg1401_2_0_score, ''),
self.rvg1401_2_0_reason1 := if(Left.rvg1401_2_0_reason1 <> right.rvg1401_2_0_reason1, Right.rvg1401_2_0_reason1, ''),
self.rvg1401_2_0_reason2 := if(Left.rvg1401_2_0_reason2 <> right.rvg1401_2_0_reason2, Right.rvg1401_2_0_reason2, ''),
self.rvg1401_2_0_reason3 := if(Left.rvg1401_2_0_reason3 <> right.rvg1401_2_0_reason3, Right.rvg1401_2_0_reason3, ''),
self.rvg1401_2_0_reason4 := if(Left.rvg1401_2_0_reason4 <> right.rvg1401_2_0_reason4, Right.rvg1401_2_0_reason4, ''),
self.rvg1310_1_0_score := if(Left.rvg1310_1_0_score <> right.rvg1310_1_0_score, Right.rvg1310_1_0_score, ''),
self.rvg1310_1_0_reason1 := if(Left.rvg1310_1_0_reason1 <> right.rvg1310_1_0_reason1, Right.rvg1310_1_0_reason1, ''),
self.rvg1310_1_0_reason2 := if(Left.rvg1310_1_0_reason2 <> right.rvg1310_1_0_reason2, Right.rvg1310_1_0_reason2, ''),
self.rvg1310_1_0_reason3 := if(Left.rvg1310_1_0_reason3 <> right.rvg1310_1_0_reason3, Right.rvg1310_1_0_reason3, ''),
self.rvg1310_1_0_reason4 := if(Left.rvg1310_1_0_reason4 <> right.rvg1310_1_0_reason4, Right.rvg1310_1_0_reason4, ''),
self.rvg1404_1_0_score := if(Left.rvg1404_1_0_score <> right.rvg1404_1_0_score, Right.rvg1404_1_0_score, ''),
self.rvg1404_1_0_reason1 := if(Left.rvg1404_1_0_reason1 <> right.rvg1404_1_0_reason1, Right.rvg1404_1_0_reason1, ''),
self.rvg1404_1_0_reason2 := if(Left.rvg1404_1_0_reason2 <> right.rvg1404_1_0_reason2, Right.rvg1404_1_0_reason2, ''),
self.rvg1404_1_0_reason3 := if(Left.rvg1404_1_0_reason3 <> right.rvg1404_1_0_reason3, Right.rvg1404_1_0_reason3, ''),
self.rvg1404_1_0_reason4 := if(Left.rvg1404_1_0_reason4 <> right.rvg1404_1_0_reason4, Right.rvg1404_1_0_reason4, ''),
self.rvg1502_0_0_score := if(Left.rvg1502_0_0_score <> right.rvg1502_0_0_score, Right.rvg1502_0_0_score, ''),
self.rvg1502_0_0_reason1 := if(Left.rvg1502_0_0_reason1 <> right.rvg1502_0_0_reason1, Right.rvg1502_0_0_reason1, ''),
self.rvg1502_0_0_reason2 := if(Left.rvg1502_0_0_reason2 <> right.rvg1502_0_0_reason2, Right.rvg1502_0_0_reason2, ''),
self.rvg1502_0_0_reason3 := if(Left.rvg1502_0_0_reason3 <> right.rvg1502_0_0_reason3, Right.rvg1502_0_0_reason3, ''),
self.rvg1502_0_0_reason4 := if(Left.rvg1502_0_0_reason4 <> right.rvg1502_0_0_reason4, Right.rvg1502_0_0_reason4, ''),
self.rvg1511_1_0_score := if(Left.rvg1511_1_0_score <> right.rvg1511_1_0_score, Right.rvg1511_1_0_score, ''),
self.rvg1511_1_0_reason1 := if(Left.rvg1511_1_0_reason1 <> right.rvg1511_1_0_reason1, Right.rvg1511_1_0_reason1, ''),
self.rvg1511_1_0_reason2 := if(Left.rvg1511_1_0_reason2 <> right.rvg1511_1_0_reason2, Right.rvg1511_1_0_reason2, ''),
self.rvg1511_1_0_reason3 := if(Left.rvg1511_1_0_reason3 <> right.rvg1511_1_0_reason3, Right.rvg1511_1_0_reason3, ''),
self.rvg1511_1_0_reason4 := if(Left.rvg1511_1_0_reason4 <> right.rvg1511_1_0_reason4, Right.rvg1511_1_0_reason4, ''),
self.rvg1601_1_0_score := if(Left.rvg1601_1_0_score <> right.rvg1601_1_0_score, Right.rvg1601_1_0_score, ''),
self.rvg1601_1_0_reason1 := if(Left.rvg1601_1_0_reason1 <> right.rvg1601_1_0_reason1, Right.rvg1601_1_0_reason1, ''),
self.rvg1601_1_0_reason2 := if(Left.rvg1601_1_0_reason2 <> right.rvg1601_1_0_reason2, Right.rvg1601_1_0_reason2, ''),
self.rvg1601_1_0_reason3 := if(Left.rvg1601_1_0_reason3 <> right.rvg1601_1_0_reason3, Right.rvg1601_1_0_reason3, ''),
self.rvg1601_1_0_reason4 := if(Left.rvg1601_1_0_reason4 <> right.rvg1601_1_0_reason4, Right.rvg1601_1_0_reason4, ''),
self.rvg1601_1_0_reason5 := if(Left.rvg1601_1_0_reason5 <> right.rvg1601_1_0_reason5, Right.rvg1601_1_0_reason5, ''),
self.rvg1605_1_0_score := if(Left.rvg1605_1_0_score <> right.rvg1605_1_0_score, Right.rvg1605_1_0_score, ''),
self.rvg1605_1_0_reason1 := if(Left.rvg1605_1_0_reason1 <> right.rvg1605_1_0_reason1, Right.rvg1605_1_0_reason1, ''),
self.rvg1605_1_0_reason2 := if(Left.rvg1605_1_0_reason2 <> right.rvg1605_1_0_reason2, Right.rvg1605_1_0_reason2, ''),
self.rvg1605_1_0_reason3 := if(Left.rvg1605_1_0_reason3 <> right.rvg1605_1_0_reason3, Right.rvg1605_1_0_reason3, ''),
self.rvg1605_1_0_reason4 := if(Left.rvg1605_1_0_reason4 <> right.rvg1605_1_0_reason4, Right.rvg1605_1_0_reason4, ''),
self.rvg1605_1_0_reason5 := if(Left.rvg1605_1_0_reason5 <> right.rvg1605_1_0_reason5, Right.rvg1605_1_0_reason5, ''),
self.rvg1702_1_0_score := if(Left.rvg1702_1_0_score <> right.rvg1702_1_0_score, Right.rvg1702_1_0_score, ''),
self.rvg1702_1_0_reason1 := if(Left.rvg1702_1_0_reason1 <> right.rvg1702_1_0_reason1, Right.rvg1702_1_0_reason1, ''),
self.rvg1702_1_0_reason2 := if(Left.rvg1702_1_0_reason2 <> right.rvg1702_1_0_reason2, Right.rvg1702_1_0_reason2, ''),
self.rvg1702_1_0_reason3 := if(Left.rvg1702_1_0_reason3 <> right.rvg1702_1_0_reason3, Right.rvg1702_1_0_reason3, ''),
self.rvg1702_1_0_reason4 := if(Left.rvg1702_1_0_reason4 <> right.rvg1702_1_0_reason4, Right.rvg1702_1_0_reason4, ''),
self.rvg1705_1_0_score := if(Left.rvg1705_1_0_score <> right.rvg1705_1_0_score, Right.rvg1705_1_0_score, ''),
self.rvg1705_1_0_reason1 := if(Left.rvg1705_1_0_reason1 <> right.rvg1705_1_0_reason1, Right.rvg1705_1_0_reason1, ''),
self.rvg1705_1_0_reason2 := if(Left.rvg1705_1_0_reason2 <> right.rvg1705_1_0_reason2, Right.rvg1705_1_0_reason2, ''),
self.rvg1705_1_0_reason3 := if(Left.rvg1705_1_0_reason3 <> right.rvg1705_1_0_reason3, Right.rvg1705_1_0_reason3, ''),
self.rvg1705_1_0_reason4 := if(Left.rvg1705_1_0_reason4 <> right.rvg1705_1_0_reason4, Right.rvg1705_1_0_reason4, ''),
self.rvp804_0_0_score := if(Left.rvp804_0_0_score <> right.rvp804_0_0_score, Right.rvp804_0_0_score, ''),
self.rvp804_0_0_reason1 := if(Left.rvp804_0_0_reason1 <> right.rvp804_0_0_reason1, Right.rvp804_0_0_reason1, ''),
self.rvp1003_0_0_score := if(Left.rvp1003_0_0_score <> right.rvp1003_0_0_score, Right.rvp1003_0_0_score, ''),
self.rvp1003_0_0_reason1 := if(Left.rvp1003_0_0_reason1 <> right.rvp1003_0_0_reason1, Right.rvp1003_0_0_reason1, ''),
self.rvp1012_1_0_score := if(Left.rvp1012_1_0_score <> right.rvp1012_1_0_score, Right.rvp1012_1_0_score, ''),
self.rvp1012_1_0_reason1 := if(Left.rvp1012_1_0_reason1 <> right.rvp1012_1_0_reason1, Right.rvp1012_1_0_reason1, ''),
self.rvp1104_0_0_score := if(Left.rvp1104_0_0_score <> right.rvp1104_0_0_score, Right.rvp1104_0_0_score, ''),
self.rvp1104_0_0_reason1 := if(Left.rvp1104_0_0_reason1 <> right.rvp1104_0_0_reason1, Right.rvp1104_0_0_reason1, ''),
self.rvp1208_1_0_score := if(Left.rvp1208_1_0_score <> right.rvp1208_1_0_score, Right.rvp1208_1_0_score, ''),
self.rvp1208_1_0_reason1 := if(Left.rvp1208_1_0_reason1 <> right.rvp1208_1_0_reason1, Right.rvp1208_1_0_reason1, ''),
self.rvp1401_1_0_score := if(Left.rvp1401_1_0_score <> right.rvp1401_1_0_score, Right.rvp1401_1_0_score, ''),
self.rvp1401_1_0_reason1 := if(Left.rvp1401_1_0_reason1 <> right.rvp1401_1_0_reason1, Right.rvp1401_1_0_reason1, ''),
self.rvp1401_2_0_score := if(Left.rvp1401_2_0_score <> right.rvp1401_2_0_score, Right.rvp1401_2_0_score, ''),
self.rvp1401_2_0_reason1 := if(Left.rvp1401_2_0_reason1 <> right.rvp1401_2_0_reason1, Right.rvp1401_2_0_reason1, ''),
self.rvp1503_1_0_score := if(Left.rvp1503_1_0_score <> right.rvp1503_1_0_score, Right.rvp1503_1_0_score, ''),
self.rvp1503_1_0_reason1 := if(Left.rvp1503_1_0_reason1 <> right.rvp1503_1_0_reason1, Right.rvp1503_1_0_reason1, ''),
self.rvp1605_1_0_score := if(Left.rvp1605_1_0_score <> right.rvp1605_1_0_score, Right.rvp1605_1_0_score, ''),
self.rvp1605_1_0_reason1 := if(Left.rvp1605_1_0_reason1 <> right.rvp1605_1_0_reason1, Right.rvp1605_1_0_reason1, ''),
self.rvr1003_0_0_score := if(Left.rvr1003_0_0_score <> right.rvr1003_0_0_score, Right.rvr1003_0_0_score, ''),
self.rvr1003_0_0_reason1 := if(Left.rvr1003_0_0_reason1 <> right.rvr1003_0_0_reason1, Right.rvr1003_0_0_reason1, ''),
self.rvr1003_0_0_reason2 := if(Left.rvr1003_0_0_reason2 <> right.rvr1003_0_0_reason2, Right.rvr1003_0_0_reason2, ''),
self.rvr1003_0_0_reason3 := if(Left.rvr1003_0_0_reason3 <> right.rvr1003_0_0_reason3, Right.rvr1003_0_0_reason3, ''),
self.rvr1003_0_0_reason4 := if(Left.rvr1003_0_0_reason4 <> right.rvr1003_0_0_reason4, Right.rvr1003_0_0_reason4, ''),
self.rvr1008_1_0_score := if(Left.rvr1008_1_0_score <> right.rvr1008_1_0_score, Right.rvr1008_1_0_score, ''),
self.rvr1008_1_0_reason1 := if(Left.rvr1008_1_0_reason1 <> right.rvr1008_1_0_reason1, Right.rvr1008_1_0_reason1, ''),
self.rvr1008_1_0_reason2 := if(Left.rvr1008_1_0_reason2 <> right.rvr1008_1_0_reason2, Right.rvr1008_1_0_reason2, ''),
self.rvr1008_1_0_reason3 := if(Left.rvr1008_1_0_reason3 <> right.rvr1008_1_0_reason3, Right.rvr1008_1_0_reason3, ''),
self.rvr1008_1_0_reason4 := if(Left.rvr1008_1_0_reason4 <> right.rvr1008_1_0_reason4, Right.rvr1008_1_0_reason4, ''),
self.rvr1103_0_0_score := if(Left.rvr1103_0_0_score <> right.rvr1103_0_0_score, Right.rvr1103_0_0_score, ''),
self.rvr1103_0_0_reason1 := if(Left.rvr1103_0_0_reason1 <> right.rvr1103_0_0_reason1, Right.rvr1103_0_0_reason1, ''),
self.rvr1103_0_0_reason2 := if(Left.rvr1103_0_0_reason2 <> right.rvr1103_0_0_reason2, Right.rvr1103_0_0_reason2, ''),
self.rvr1103_0_0_reason3 := if(Left.rvr1103_0_0_reason3 <> right.rvr1103_0_0_reason3, Right.rvr1103_0_0_reason3, ''),
self.rvr1103_0_0_reason4 := if(Left.rvr1103_0_0_reason4 <> right.rvr1103_0_0_reason4, Right.rvr1103_0_0_reason4, ''),
self.rvr1104_2_0_score := if(Left.rvr1104_2_0_score <> right.rvr1104_2_0_score, Right.rvr1104_2_0_score, ''),
self.rvr1104_2_0_reason1 := if(Left.rvr1104_2_0_reason1 <> right.rvr1104_2_0_reason1, Right.rvr1104_2_0_reason1, ''),
self.rvr1104_2_0_reason2 := if(Left.rvr1104_2_0_reason2 <> right.rvr1104_2_0_reason2, Right.rvr1104_2_0_reason2, ''),
self.rvr1104_2_0_reason3 := if(Left.rvr1104_2_0_reason3 <> right.rvr1104_2_0_reason3, Right.rvr1104_2_0_reason3, ''),
self.rvr1104_2_0_reason4 := if(Left.rvr1104_2_0_reason4 <> right.rvr1104_2_0_reason4, Right.rvr1104_2_0_reason4, ''),
self.rvr1210_1_0_score := if(Left.rvr1210_1_0_score <> right.rvr1210_1_0_score, Right.rvr1210_1_0_score, ''),
self.rvr1210_1_0_reason1 := if(Left.rvr1210_1_0_reason1 <> right.rvr1210_1_0_reason1, Right.rvr1210_1_0_reason1, ''),
self.rvr1210_1_0_reason2 := if(Left.rvr1210_1_0_reason2 <> right.rvr1210_1_0_reason2, Right.rvr1210_1_0_reason2, ''),
self.rvr1210_1_0_reason3 := if(Left.rvr1210_1_0_reason3 <> right.rvr1210_1_0_reason3, Right.rvr1210_1_0_reason3, ''),
self.rvr1210_1_0_reason4 := if(Left.rvr1210_1_0_reason4 <> right.rvr1210_1_0_reason4, Right.rvr1210_1_0_reason4, ''),
self.rvr1303_1_0_score := if(Left.rvr1303_1_0_score <> right.rvr1303_1_0_score, Right.rvr1303_1_0_score, ''),
self.rvr1303_1_0_reason1 := if(Left.rvr1303_1_0_reason1 <> right.rvr1303_1_0_reason1, Right.rvr1303_1_0_reason1, ''),
self.rvr1303_1_0_reason2 := if(Left.rvr1303_1_0_reason2 <> right.rvr1303_1_0_reason2, Right.rvr1303_1_0_reason2, ''),
self.rvr1303_1_0_reason3 := if(Left.rvr1303_1_0_reason3 <> right.rvr1303_1_0_reason3, Right.rvr1303_1_0_reason3, ''),
self.rvr1303_1_0_reason4 := if(Left.rvr1303_1_0_reason4 <> right.rvr1303_1_0_reason4, Right.rvr1303_1_0_reason4, ''),
self.rvr1311_1_0_score := if(Left.rvr1311_1_0_score <> right.rvr1311_1_0_score, Right.rvr1311_1_0_score, ''),
self.rvr1311_1_0_reason1 := if(Left.rvr1311_1_0_reason1 <> right.rvr1311_1_0_reason1, Right.rvr1311_1_0_reason1, ''),
self.rvr1311_1_0_reason2 := if(Left.rvr1311_1_0_reason2 <> right.rvr1311_1_0_reason2, Right.rvr1311_1_0_reason2, ''),
self.rvr1311_1_0_reason3 := if(Left.rvr1311_1_0_reason3 <> right.rvr1311_1_0_reason3, Right.rvr1311_1_0_reason3, ''),
self.rvr1311_1_0_reason4 := if(Left.rvr1311_1_0_reason4 <> right.rvr1311_1_0_reason4, Right.rvr1311_1_0_reason4, ''),
self.rvr1410_1_0_score := if(Left.rvr1410_1_0_score <> right.rvr1410_1_0_score, Right.rvr1410_1_0_score, ''),
self.rvr1410_1_0_reason1 := if(Left.rvr1410_1_0_reason1 <> right.rvr1410_1_0_reason1, Right.rvr1410_1_0_reason1, ''),
self.rvr1410_1_0_reason2 := if(Left.rvr1410_1_0_reason2 <> right.rvr1410_1_0_reason2, Right.rvr1410_1_0_reason2, ''),
self.rvr1410_1_0_reason3 := if(Left.rvr1410_1_0_reason3 <> right.rvr1410_1_0_reason3, Right.rvr1410_1_0_reason3, ''),
self.rvr1410_1_0_reason4 := if(Left.rvr1410_1_0_reason4 <> right.rvr1410_1_0_reason4, Right.rvr1410_1_0_reason4, ''),
self.rvr611_0_0_score := if(Left.rvr611_0_0_score <> right.rvr611_0_0_score, Right.rvr611_0_0_score, ''),
self.rvr611_0_0_reason1 := if(Left.rvr611_0_0_reason1 <> right.rvr611_0_0_reason1, Right.rvr611_0_0_reason1, ''),
self.rvr611_0_0_reason2 := if(Left.rvr611_0_0_reason2 <> right.rvr611_0_0_reason2, Right.rvr611_0_0_reason2, ''),
self.rvr611_0_0_reason3 := if(Left.rvr611_0_0_reason3 <> right.rvr611_0_0_reason3, Right.rvr611_0_0_reason3, ''),
self.rvr611_0_0_reason4 := if(Left.rvr611_0_0_reason4 <> right.rvr611_0_0_reason4, Right.rvr611_0_0_reason4, ''),
self.rvr704_1_0_score := if(Left.rvr704_1_0_score <> right.rvr704_1_0_score, Right.rvr704_1_0_score, ''),
self.rvr704_1_0_reason1 := if(Left.rvr704_1_0_reason1 <> right.rvr704_1_0_reason1, Right.rvr704_1_0_reason1, ''),
self.rvr704_1_0_reason2 := if(Left.rvr704_1_0_reason2 <> right.rvr704_1_0_reason2, Right.rvr704_1_0_reason2, ''),
self.rvr704_1_0_reason3 := if(Left.rvr704_1_0_reason3 <> right.rvr704_1_0_reason3, Right.rvr704_1_0_reason3, ''),
self.rvr704_1_0_reason4 := if(Left.rvr704_1_0_reason4 <> right.rvr704_1_0_reason4, Right.rvr704_1_0_reason4, ''),
self.rvr711_0_0_score := if(Left.rvr711_0_0_score <> right.rvr711_0_0_score, Right.rvr711_0_0_score, ''),
self.rvr711_0_0_reason1 := if(Left.rvr711_0_0_reason1 <> right.rvr711_0_0_reason1, Right.rvr711_0_0_reason1, ''),
self.rvr711_0_0_reason2 := if(Left.rvr711_0_0_reason2 <> right.rvr711_0_0_reason2, Right.rvr711_0_0_reason2, ''),
self.rvr711_0_0_reason3 := if(Left.rvr711_0_0_reason3 <> right.rvr711_0_0_reason3, Right.rvr711_0_0_reason3, ''),
self.rvr711_0_0_reason4 := if(Left.rvr711_0_0_reason4 <> right.rvr711_0_0_reason4, Right.rvr711_0_0_reason4, ''),
self.rvr803_1_0_score := if(Left.rvr803_1_0_score <> right.rvr803_1_0_score, Right.rvr803_1_0_score, ''),
self.rvr803_1_0_reason1 := if(Left.rvr803_1_0_reason1 <> right.rvr803_1_0_reason1, Right.rvr803_1_0_reason1, ''),
self.rvr803_1_0_reason2 := if(Left.rvr803_1_0_reason2 <> right.rvr803_1_0_reason2, Right.rvr803_1_0_reason2, ''),
self.rvr803_1_0_reason3 := if(Left.rvr803_1_0_reason3 <> right.rvr803_1_0_reason3, Right.rvr803_1_0_reason3, ''),
self.rvr803_1_0_reason4 := if(Left.rvr803_1_0_reason4 <> right.rvr803_1_0_reason4, Right.rvr803_1_0_reason4, ''),
self.rvs811_0_0_score := if(Left.rvs811_0_0_score <> right.rvs811_0_0_score, Right.rvs811_0_0_score, ''),
self.rvs811_0_0_reason1 := if(Left.rvs811_0_0_reason1 <> right.rvs811_0_0_reason1, Right.rvs811_0_0_reason1, ''),
self.rvs811_0_0_reason2 := if(Left.rvs811_0_0_reason2 <> right.rvs811_0_0_reason2, Right.rvs811_0_0_reason2, ''),
self.rvs811_0_0_reason3 := if(Left.rvs811_0_0_reason3 <> right.rvs811_0_0_reason3, Right.rvs811_0_0_reason3, ''),
self.rvs811_0_0_reason4 := if(Left.rvs811_0_0_reason4 <> right.rvs811_0_0_reason4, Right.rvs811_0_0_reason4, ''),
self.rvt1003_0_0_score := if(Left.rvt1003_0_0_score <> right.rvt1003_0_0_score, Right.rvt1003_0_0_score, ''),
self.rvt1003_0_0_reason1 := if(Left.rvt1003_0_0_reason1 <> right.rvt1003_0_0_reason1, Right.rvt1003_0_0_reason1, ''),
self.rvt1003_0_0_reason2 := if(Left.rvt1003_0_0_reason2 <> right.rvt1003_0_0_reason2, Right.rvt1003_0_0_reason2, ''),
self.rvt1003_0_0_reason3 := if(Left.rvt1003_0_0_reason3 <> right.rvt1003_0_0_reason3, Right.rvt1003_0_0_reason3, ''),
self.rvt1003_0_0_reason4 := if(Left.rvt1003_0_0_reason4 <> right.rvt1003_0_0_reason4, Right.rvt1003_0_0_reason4, ''),
self.rvt1006_1_0_score := if(Left.rvt1006_1_0_score <> right.rvt1006_1_0_score, Right.rvt1006_1_0_score, ''),
self.rvt1006_1_0_reason1 := if(Left.rvt1006_1_0_reason1 <> right.rvt1006_1_0_reason1, Right.rvt1006_1_0_reason1, ''),
self.rvt1006_1_0_reason2 := if(Left.rvt1006_1_0_reason2 <> right.rvt1006_1_0_reason2, Right.rvt1006_1_0_reason2, ''),
self.rvt1006_1_0_reason3 := if(Left.rvt1006_1_0_reason3 <> right.rvt1006_1_0_reason3, Right.rvt1006_1_0_reason3, ''),
self.rvt1006_1_0_reason4 := if(Left.rvt1006_1_0_reason4 <> right.rvt1006_1_0_reason4, Right.rvt1006_1_0_reason4, ''),
self.rvt1104_0_0_score := if(Left.rvt1104_0_0_score <> right.rvt1104_0_0_score, Right.rvt1104_0_0_score, ''),
self.rvt1104_0_0_reason1 := if(Left.rvt1104_0_0_reason1 <> right.rvt1104_0_0_reason1, Right.rvt1104_0_0_reason1, ''),
self.rvt1104_0_0_reason2 := if(Left.rvt1104_0_0_reason2 <> right.rvt1104_0_0_reason2, Right.rvt1104_0_0_reason2, ''),
self.rvt1104_0_0_reason3 := if(Left.rvt1104_0_0_reason3 <> right.rvt1104_0_0_reason3, Right.rvt1104_0_0_reason3, ''),
self.rvt1104_0_0_reason4 := if(Left.rvt1104_0_0_reason4 <> right.rvt1104_0_0_reason4, Right.rvt1104_0_0_reason4, ''),
self.rvt1104_1_0_score := if(Left.rvt1104_1_0_score <> right.rvt1104_1_0_score, Right.rvt1104_1_0_score, ''),
self.rvt1104_1_0_reason1 := if(Left.rvt1104_1_0_reason1 <> right.rvt1104_1_0_reason1, Right.rvt1104_1_0_reason1, ''),
self.rvt1104_1_0_reason2 := if(Left.rvt1104_1_0_reason2 <> right.rvt1104_1_0_reason2, Right.rvt1104_1_0_reason2, ''),
self.rvt1104_1_0_reason3 := if(Left.rvt1104_1_0_reason3 <> right.rvt1104_1_0_reason3, Right.rvt1104_1_0_reason3, ''),
self.rvt1104_1_0_reason4 := if(Left.rvt1104_1_0_reason4 <> right.rvt1104_1_0_reason4, Right.rvt1104_1_0_reason4, ''),
self.rvt1204_1_score := if(Left.rvt1204_1_score <> right.rvt1204_1_score, Right.rvt1204_1_score, ''),
self.rvt1204_1_reason1 := if(Left.rvt1204_1_reason1 <> right.rvt1204_1_reason1, Right.rvt1204_1_reason1, ''),
self.rvt1204_1_reason2 := if(Left.rvt1204_1_reason2 <> right.rvt1204_1_reason2, Right.rvt1204_1_reason2, ''),
self.rvt1204_1_reason3 := if(Left.rvt1204_1_reason3 <> right.rvt1204_1_reason3, Right.rvt1204_1_reason3, ''),
self.rvt1204_1_reason4 := if(Left.rvt1204_1_reason4 <> right.rvt1204_1_reason4, Right.rvt1204_1_reason4, ''),
self.rvt1210_1_0_score := if(Left.rvt1210_1_0_score <> right.rvt1210_1_0_score, Right.rvt1210_1_0_score, ''),
self.rvt1210_1_0_reason1 := if(Left.rvt1210_1_0_reason1 <> right.rvt1210_1_0_reason1, Right.rvt1210_1_0_reason1, ''),
self.rvt1210_1_0_reason2 := if(Left.rvt1210_1_0_reason2 <> right.rvt1210_1_0_reason2, Right.rvt1210_1_0_reason2, ''),
self.rvt1210_1_0_reason3 := if(Left.rvt1210_1_0_reason3 <> right.rvt1210_1_0_reason3, Right.rvt1210_1_0_reason3, ''),
self.rvt1210_1_0_reason4 := if(Left.rvt1210_1_0_reason4 <> right.rvt1210_1_0_reason4, Right.rvt1210_1_0_reason4, ''),
self.rvt1212_1_0_score := if(Left.rvt1212_1_0_score <> right.rvt1212_1_0_score, Right.rvt1212_1_0_score, ''),
self.rvt1212_1_0_reason1 := if(Left.rvt1212_1_0_reason1 <> right.rvt1212_1_0_reason1, Right.rvt1212_1_0_reason1, ''),
self.rvt1212_1_0_reason2 := if(Left.rvt1212_1_0_reason2 <> right.rvt1212_1_0_reason2, Right.rvt1212_1_0_reason2, ''),
self.rvt1212_1_0_reason3 := if(Left.rvt1212_1_0_reason3 <> right.rvt1212_1_0_reason3, Right.rvt1212_1_0_reason3, ''),
self.rvt1212_1_0_reason4 := if(Left.rvt1212_1_0_reason4 <> right.rvt1212_1_0_reason4, Right.rvt1212_1_0_reason4, ''),
self.rvt612_0_score := if(Left.rvt612_0_score <> right.rvt612_0_score, Right.rvt612_0_score, ''),
self.rvt612_0_reason1 := if(Left.rvt612_0_reason1 <> right.rvt612_0_reason1, Right.rvt612_0_reason1, ''),
self.rvt612_0_reason2 := if(Left.rvt612_0_reason2 <> right.rvt612_0_reason2, Right.rvt612_0_reason2, ''),
self.rvt612_0_reason3 := if(Left.rvt612_0_reason3 <> right.rvt612_0_reason3, Right.rvt612_0_reason3, ''),
self.rvt612_0_reason4 := if(Left.rvt612_0_reason4 <> right.rvt612_0_reason4, Right.rvt612_0_reason4, ''),
self.rvt1307_3_0_score := if(Left.rvt1307_3_0_score <> right.rvt1307_3_0_score, Right.rvt1307_3_0_score, ''),
self.rvt1307_3_0_reason1 := if(Left.rvt1307_3_0_reason1 <> right.rvt1307_3_0_reason1, Right.rvt1307_3_0_reason1, ''),
self.rvt1307_3_0_reason2 := if(Left.rvt1307_3_0_reason2 <> right.rvt1307_3_0_reason2, Right.rvt1307_3_0_reason2, ''),
self.rvt1307_3_0_reason3 := if(Left.rvt1307_3_0_reason3 <> right.rvt1307_3_0_reason3, Right.rvt1307_3_0_reason3, ''),
self.rvt1307_3_0_reason4 := if(Left.rvt1307_3_0_reason4 <> right.rvt1307_3_0_reason4, Right.rvt1307_3_0_reason4, ''),
self.rvt1402_1_0_score := if(Left.rvt1402_1_0_score <> right.rvt1402_1_0_score, Right.rvt1402_1_0_score, ''),
self.rvt1402_1_0_reason1 := if(Left.rvt1402_1_0_reason1 <> right.rvt1402_1_0_reason1, Right.rvt1402_1_0_reason1, ''),
self.rvt1402_1_0_reason2 := if(Left.rvt1402_1_0_reason2 <> right.rvt1402_1_0_reason2, Right.rvt1402_1_0_reason2, ''),
self.rvt1402_1_0_reason3 := if(Left.rvt1402_1_0_reason3 <> right.rvt1402_1_0_reason3, Right.rvt1402_1_0_reason3, ''),
self.rvt1402_1_0_reason4 := if(Left.rvt1402_1_0_reason4 <> right.rvt1402_1_0_reason4, Right.rvt1402_1_0_reason4, ''),
self.rvt1503_0_0_score := if(Left.rvt1503_0_0_score <> right.rvt1503_0_0_score, Right.rvt1503_0_0_score, ''),
self.rvt1503_0_0_reason1 := if(Left.rvt1503_0_0_reason1 <> right.rvt1503_0_0_reason1, Right.rvt1503_0_0_reason1, ''),
self.rvt1503_0_0_reason2 := if(Left.rvt1503_0_0_reason2 <> right.rvt1503_0_0_reason2, Right.rvt1503_0_0_reason2, ''),
self.rvt1503_0_0_reason3 := if(Left.rvt1503_0_0_reason3 <> right.rvt1503_0_0_reason3, Right.rvt1503_0_0_reason3, ''),
self.rvt1503_0_0_reason4 := if(Left.rvt1503_0_0_reason4 <> right.rvt1503_0_0_reason4, Right.rvt1503_0_0_reason4, ''),
self.rvt1601_1_0_score := if(Left.rvt1601_1_0_score <> right.rvt1601_1_0_score, Right.rvt1601_1_0_score, ''),
self.rvt1601_1_0_reason1 := if(Left.rvt1601_1_0_reason1 <> right.rvt1601_1_0_reason1, Right.rvt1601_1_0_reason1, ''),
self.rvt1601_1_0_reason2 := if(Left.rvt1601_1_0_reason2 <> right.rvt1601_1_0_reason2, Right.rvt1601_1_0_reason2, ''),
self.rvt1601_1_0_reason3 := if(Left.rvt1601_1_0_reason3 <> right.rvt1601_1_0_reason3, Right.rvt1601_1_0_reason3, ''),
self.rvt1601_1_0_reason4 := if(Left.rvt1601_1_0_reason4 <> right.rvt1601_1_0_reason4, Right.rvt1601_1_0_reason4, ''),
self.rvt711_0_0_score := if(Left.rvt711_0_0_score <> right.rvt711_0_0_score, Right.rvt711_0_0_score, ''),
self.rvt711_0_0_reason1 := if(Left.rvt711_0_0_reason1 <> right.rvt711_0_0_reason1, Right.rvt711_0_0_reason1, ''),
self.rvt711_0_0_reason2 := if(Left.rvt711_0_0_reason2 <> right.rvt711_0_0_reason2, Right.rvt711_0_0_reason2, ''),
self.rvt711_0_0_reason3 := if(Left.rvt711_0_0_reason3 <> right.rvt711_0_0_reason3, Right.rvt711_0_0_reason3, ''),
self.rvt711_0_0_reason4 := if(Left.rvt711_0_0_reason4 <> right.rvt711_0_0_reason4, Right.rvt711_0_0_reason4, ''),
self.rvt711_1_0_score := if(Left.rvt711_1_0_score <> right.rvt711_1_0_score, Right.rvt711_1_0_score, ''),
self.rvt711_1_0_reason1 := if(Left.rvt711_1_0_reason1 <> right.rvt711_1_0_reason1, Right.rvt711_1_0_reason1, ''),
self.rvt711_1_0_reason2 := if(Left.rvt711_1_0_reason2 <> right.rvt711_1_0_reason2, Right.rvt711_1_0_reason2, ''),
self.rvt711_1_0_reason3 := if(Left.rvt711_1_0_reason3 <> right.rvt711_1_0_reason3, Right.rvt711_1_0_reason3, ''),
self.rvt711_1_0_reason4 := if(Left.rvt711_1_0_reason4 <> right.rvt711_1_0_reason4, Right.rvt711_1_0_reason4, ''),
self.rvt803_1_0_score := if(Left.rvt803_1_0_score <> right.rvt803_1_0_score, Right.rvt803_1_0_score, ''),
self.rvt803_1_0_reason1 := if(Left.rvt803_1_0_reason1 <> right.rvt803_1_0_reason1, Right.rvt803_1_0_reason1, ''),
self.rvt803_1_0_reason2 := if(Left.rvt803_1_0_reason2 <> right.rvt803_1_0_reason2, Right.rvt803_1_0_reason2, ''),
self.rvt803_1_0_reason3 := if(Left.rvt803_1_0_reason3 <> right.rvt803_1_0_reason3, Right.rvt803_1_0_reason3, ''),
self.rvt803_1_0_reason4 := if(Left.rvt803_1_0_reason4 <> right.rvt803_1_0_reason4, Right.rvt803_1_0_reason4, ''),
self.rvt809_1_0_score := if(Left.rvt809_1_0_score <> right.rvt809_1_0_score, Right.rvt809_1_0_score, ''),
self.rvt809_1_0_reason1 := if(Left.rvt809_1_0_reason1 <> right.rvt809_1_0_reason1, Right.rvt809_1_0_reason1, ''),
self.rvt809_1_0_reason2 := if(Left.rvt809_1_0_reason2 <> right.rvt809_1_0_reason2, Right.rvt809_1_0_reason2, ''),
self.rvt809_1_0_reason3 := if(Left.rvt809_1_0_reason3 <> right.rvt809_1_0_reason3, Right.rvt809_1_0_reason3, ''),
self.rvt809_1_0_reason4 := if(Left.rvt809_1_0_reason4 <> right.rvt809_1_0_reason4, Right.rvt809_1_0_reason4, ''),
self.rvt1605_1_0_score := if(Left.rvt1605_1_0_score <> right.rvt1605_1_0_score, Right.rvt1605_1_0_score, ''),
self.rvt1605_1_0_reason1 := if(Left.rvt1605_1_0_reason1 <> right.rvt1605_1_0_reason1, Right.rvt1605_1_0_reason1, ''),
self.rvt1605_1_0_reason2 := if(Left.rvt1605_1_0_reason2 <> right.rvt1605_1_0_reason2, Right.rvt1605_1_0_reason2, ''),
self.rvt1605_1_0_reason3 := if(Left.rvt1605_1_0_reason3 <> right.rvt1605_1_0_reason3, Right.rvt1605_1_0_reason3, ''),
self.rvt1605_1_0_reason4 := if(Left.rvt1605_1_0_reason4 <> right.rvt1605_1_0_reason4, Right.rvt1605_1_0_reason4, ''),
self.rvt1605_2_0_score := if(Left.rvt1605_2_0_score <> right.rvt1605_2_0_score, Right.rvt1605_2_0_score, ''),
self.rvt1605_2_0_reason1 := if(Left.rvt1605_2_0_reason1 <> right.rvt1605_2_0_reason1, Right.rvt1605_2_0_reason1, ''),
self.rvt1605_2_0_reason2 := if(Left.rvt1605_2_0_reason2 <> right.rvt1605_2_0_reason2, Right.rvt1605_2_0_reason2, ''),
self.rvt1605_2_0_reason3 := if(Left.rvt1605_2_0_reason3 <> right.rvt1605_2_0_reason3, Right.rvt1605_2_0_reason3, ''),
self.rvt1605_2_0_reason4 := if(Left.rvt1605_2_0_reason4 <> right.rvt1605_2_0_reason4, Right.rvt1605_2_0_reason4, ''),
self.rvt1608_1_0_score := if(Left.rvt1608_1_0_score <> right.rvt1608_1_0_score, Right.rvt1608_1_0_score, ''),
self.rvt1608_1_0_reason1 := if(Left.rvt1608_1_0_reason1 <> right.rvt1608_1_0_reason1, Right.rvt1608_1_0_reason1, ''),
self.rvt1608_1_0_reason2 := if(Left.rvt1608_1_0_reason2 <> right.rvt1608_1_0_reason2, Right.rvt1608_1_0_reason2, ''),
self.rvt1608_1_0_reason3 := if(Left.rvt1608_1_0_reason3 <> right.rvt1608_1_0_reason3, Right.rvt1608_1_0_reason3, ''),
self.rvt1608_1_0_reason4 := if(Left.rvt1608_1_0_reason4 <> right.rvt1608_1_0_reason4, Right.rvt1608_1_0_reason4, ''),
self.rvt1608_1_0_reason5 := if(Left.rvt1608_1_0_reason5 <> right.rvt1608_1_0_reason5, Right.rvt1608_1_0_reason5, ''),
self.rvt1608_2_score := if(Left.rvt1608_2_score <> right.rvt1608_2_score, Right.rvt1608_2_score, ''),
self.rvt1608_2_reason1 := if(Left.rvt1608_2_reason1 <> right.rvt1608_2_reason1, Right.rvt1608_2_reason1, ''),
self.rvt1608_2_reason2 := if(Left.rvt1608_2_reason2 <> right.rvt1608_2_reason2, Right.rvt1608_2_reason2, ''),
self.rvt1608_2_reason3 := if(Left.rvt1608_2_reason3 <> right.rvt1608_2_reason3, Right.rvt1608_2_reason3, ''),
self.rvt1608_2_reason4 := if(Left.rvt1608_2_reason4 <> right.rvt1608_2_reason4, Right.rvt1608_2_reason4, ''),
self.rvt1608_2_reason5 := if(Left.rvt1608_2_reason5 <> right.rvt1608_2_reason5, Right.rvt1608_2_reason5, ''),
self.tbd605_0_0_score := if(Left.tbd605_0_0_score <> right.tbd605_0_0_score, Right.tbd605_0_0_score, ''),
self.tbd605_0_0_reason1 := if(Left.tbd605_0_0_reason1 <> right.tbd605_0_0_reason1, Right.tbd605_0_0_reason1, ''),
self.tbd605_0_0_reason2 := if(Left.tbd605_0_0_reason2 <> right.tbd605_0_0_reason2, Right.tbd605_0_0_reason2, ''),
self.tbd605_0_0_reason3 := if(Left.tbd605_0_0_reason3 <> right.tbd605_0_0_reason3, Right.tbd605_0_0_reason3, ''),
self.tbd605_0_0_reason4 := if(Left.tbd605_0_0_reason4 <> right.tbd605_0_0_reason4, Right.tbd605_0_0_reason4, ''),
self.tbd609_1_0_score := if(Left.tbd609_1_0_score <> right.tbd609_1_0_score, Right.tbd609_1_0_score, ''),
self.tbd609_1_0_reason1 := if(Left.tbd609_1_0_reason1 <> right.tbd609_1_0_reason1, Right.tbd609_1_0_reason1, ''),
self.tbd609_1_0_reason2 := if(Left.tbd609_1_0_reason2 <> right.tbd609_1_0_reason2, Right.tbd609_1_0_reason2, ''),
self.tbd609_1_0_reason3 := if(Left.tbd609_1_0_reason3 <> right.tbd609_1_0_reason3, Right.tbd609_1_0_reason3, ''),
self.tbd609_1_0_reason4 := if(Left.tbd609_1_0_reason4 <> right.tbd609_1_0_reason4, Right.tbd609_1_0_reason4, ''),
self.tbd609_2_0_score := if(Left.tbd609_2_0_score <> right.tbd609_2_0_score, Right.tbd609_2_0_score, ''),
self.tbd609_2_0_reason1 := if(Left.tbd609_2_0_reason1 <> right.tbd609_2_0_reason1, Right.tbd609_2_0_reason1, ''),
self.tbd609_2_0_reason2 := if(Left.tbd609_2_0_reason2 <> right.tbd609_2_0_reason2, Right.tbd609_2_0_reason2, ''),
self.tbd609_2_0_reason3 := if(Left.tbd609_2_0_reason3 <> right.tbd609_2_0_reason3, Right.tbd609_2_0_reason3, ''),
self.tbd609_2_0_reason4 := if(Left.tbd609_2_0_reason4 <> right.tbd609_2_0_reason4, Right.tbd609_2_0_reason4, ''),
self.tbn509_0_0_score := if(Left.tbn509_0_0_score <> right.tbn509_0_0_score, Right.tbn509_0_0_score, ''),
self.tbn509_0_0_reason1 := if(Left.tbn509_0_0_reason1 <> right.tbn509_0_0_reason1, Right.tbn509_0_0_reason1, ''),
self.tbn509_0_0_reason2 := if(Left.tbn509_0_0_reason2 <> right.tbn509_0_0_reason2, Right.tbn509_0_0_reason2, ''),
self.tbn509_0_0_reason3 := if(Left.tbn509_0_0_reason3 <> right.tbn509_0_0_reason3, Right.tbn509_0_0_reason3, ''),
self.tbn509_0_0_reason4 := if(Left.tbn509_0_0_reason4 <> right.tbn509_0_0_reason4, Right.tbn509_0_0_reason4, ''),
self.tbn604_1_0_score := if(Left.tbn604_1_0_score <> right.tbn604_1_0_score, Right.tbn604_1_0_score, ''),
self.tbn604_1_0_reason1 := if(Left.tbn604_1_0_reason1 <> right.tbn604_1_0_reason1, Right.tbn604_1_0_reason1, ''),
self.tbn604_1_0_reason2 := if(Left.tbn604_1_0_reason2 <> right.tbn604_1_0_reason2, Right.tbn604_1_0_reason2, ''),
self.tbn604_1_0_reason3 := if(Left.tbn604_1_0_reason3 <> right.tbn604_1_0_reason3, Right.tbn604_1_0_reason3, ''),
self.tbn604_1_0_reason4 := if(Left.tbn604_1_0_reason4 <> right.tbn604_1_0_reason4, Right.tbn604_1_0_reason4, ''),
self.trd605_0_0_score := if(Left.trd605_0_0_score <> right.trd605_0_0_score, Right.trd605_0_0_score, ''),
self.trd605_0_0_reason1 := if(Left.trd605_0_0_reason1 <> right.trd605_0_0_reason1, Right.trd605_0_0_reason1, ''),
self.trd605_0_0_reason2 := if(Left.trd605_0_0_reason2 <> right.trd605_0_0_reason2, Right.trd605_0_0_reason2, ''),
self.trd605_0_0_reason3 := if(Left.trd605_0_0_reason3 <> right.trd605_0_0_reason3, Right.trd605_0_0_reason3, ''),
self.trd605_0_0_reason4 := if(Left.trd605_0_0_reason4 <> right.trd605_0_0_reason4, Right.trd605_0_0_reason4, ''),
self.trd609_1_0_score := if(Left.trd609_1_0_score <> right.trd609_1_0_score, Right.trd609_1_0_score, ''),
self.trd609_1_0_reason1 := if(Left.trd609_1_0_reason1 <> right.trd609_1_0_reason1, Right.trd609_1_0_reason1, ''),
self.trd609_1_0_reason2 := if(Left.trd609_1_0_reason2 <> right.trd609_1_0_reason2, Right.trd609_1_0_reason2, ''),
self.trd609_1_0_reason3 := if(Left.trd609_1_0_reason3 <> right.trd609_1_0_reason3, Right.trd609_1_0_reason3, ''),
self.trd609_1_0_reason4 := if(Left.trd609_1_0_reason4 <> right.trd609_1_0_reason4, Right.trd609_1_0_reason4, ''),
self.win704_0_0_score := if(Left.win704_0_0_score <> (String)right.win704_0_0_score, (String)Right.win704_0_0_score, ''),          //Was unsigned3, casting
self.womv002_0_0_score := if(Left.womv002_0_0_score <> (String)right.womv002_0_0_score, (String)Right.womv002_0_0_score, ''),          //Was real8, casting
self.wwn604_1_0_score := if(Left.wwn604_1_0_score <> right.wwn604_1_0_score, Right.wwn604_1_0_score, ''),
self.wwn604_1_0_reason1 := if(Left.wwn604_1_0_reason1 <> right.wwn604_1_0_reason1, Right.wwn604_1_0_reason1, ''),
self.wwn604_1_0_reason2 := if(Left.wwn604_1_0_reason2 <> right.wwn604_1_0_reason2, Right.wwn604_1_0_reason2, ''),
self.wwn604_1_0_reason3 := if(Left.wwn604_1_0_reason3 <> right.wwn604_1_0_reason3, Right.wwn604_1_0_reason3, ''),
self.wwn604_1_0_reason4 := if(Left.wwn604_1_0_reason4 <> right.wwn604_1_0_reason4, Right.wwn604_1_0_reason4, ''),
self.errorcode := if(Left.errorcode <> right.errorcode, Right.errorcode, ''),							
								SELF := Right));


append_ds := prev_ds_1 + curr_ds_1;


Sorted_append_ds := sort(append_ds, did, Order);
// OUTPUT(count(Sorted_append_ds), NAMED('Sorted_append_ds_count'));
// OUTPUT(CHOOSEN(Sorted_append_ds, 25), named('Sorted_append_ds'));

out_file := output(Sorted_append_ds , ,'~ScoringQA::out::PersonalScoreTracker::41RunwayResults_' +  prev_date + '_VS_' + curr_date, CSV(heading(single), quote('"')), overwrite, compressed, EXPIRE(30));
// out_file;

string out_file_layout := '';
out_ds := dataset('~ScoringQA::out::PersonalScoreTracker::41RunwayResults_' +  prev_date + '_VS_' + curr_date, typeof(out_file_layout));
// out_ds;

no_of_records := count(out_ds);
// no_of_records;

myrec := record, maxlength(9999999) 
unsigned code0; 
unsigned code1;
string line; end;

myrec ref(out_ds l, integer c) := transform 
self.code0 := c; 
self.code1 := c + 1 ;
self.line := if( c = 1, 	'                        Personal Score Tracker Dates   ' +  prev_date + '_VS_' + curr_date + '\n' + l.line 	, l.line);
end;

outputs := project(out_ds, ref(left, counter));
// outputs;


MyRec Xform(myrec L, myrec R) := TRANSFORM
SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
self := L;
END;

XtabOut := iterate(outputs,Xform(left,right));
// XtabOut;


		send_file := fileservices.SendEmailAttachText('Benjamin.Karnatz@lexisnexisrisk.com',
						 'Personal Score Tracker'  +  ' results',
																	 prev_date + ' vs ' + curr_date + '\nPlease view attachment.',
																	 XtabOut[no_of_records].line ,
																	 'text/plain; charset=ISO-8859-3', 
																	 'Personal_Score_Tracker' +  prev_date + '_VS_' + curr_date + '.csv',
																	 ,
																	 ,
																	 'Benjamin.Karnatz@lexisnexisrisk.com');			 
																	 
sequential (out_file, send_file);																				 
     																 