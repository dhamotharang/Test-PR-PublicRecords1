﻿IMPORT Risk_Indicators, ut, models;

xlayout := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

EXPORT Runway_Join_Function(dataset(xlayout) nonfcra_runway, dataset(xlayout) fcra_runway, String dt):= function

nonfcra_runway_data := nonfcra_runway;
fcra_runway_data := fcra_runway;

models.Layout_Runway join_them(xlayout l, xlayout r) := Transform
self.CVI_reason1 := l.CVI_reason1;
self.CVI_reason2 := l.CVI_reason2;
self.CVI_reason3 := l.CVI_reason3;
self.CVI_reason4 := l.CVI_reason4;
self.CVI_score := l.CVI_score;
self.did := l.did;
self.NAP := l.NAP;
self.NAS := l.NAS;
self.seq := l.seq;
self.WIN704_0_0_score := l.WIN704_0_0_score;
self.RVA1310_1_0_score := r.RVA1310_1_0_score;
self.RVA1310_2_0_score := r.RVA1310_2_0_score;
self.RVA1310_3_0_score := r.RVA1310_3_0_score;
self.RVA1311_1_0_score := r.RVA1311_1_0_score;
self.RVA1311_2_0_score := r.RVA1311_2_0_score;
self.RVA1311_3_0_score := r.RVA1311_3_0_score;
self.RVT1608_2_score := r.RVT1608_2_score;
self.FP1403_1_0_score    := l.FP1403_1_0_score   ;
self.FP1409_2_0_score    := l.FP1409_2_0_score   ;
self.AID605_1_0_score := r.AID605_1_0_score;
self.AID606_0_0_score := r.AID606_0_0_score;
self.AID606_1_0_score := r.AID606_1_0_score;
self.AID607_0_0_score := r.AID607_0_0_score;
self.AID607_1_0_score := r.AID607_1_0_score;
self.AID607_2_0_score := r.AID607_2_0_score;
self.AWD605_0_0_score := r.AWD605_0_0_score;
self.AWD605_2_0_score := r.AWD605_2_0_score;
self.AWD606_1_0_score := r.AWD606_1_0_score;
self.AWD606_10_0_score := r.AWD606_10_0_score;
self.AWD606_11_0_score := r.AWD606_11_0_score;
self.AWD606_2_0_score := r.AWD606_2_0_score;
self.AWD606_3_0_score := r.AWD606_3_0_score;
self.AWD606_4_0_score := r.AWD606_4_0_score;
self.AWD606_6_0_score := r.AWD606_6_0_score;
self.AWD606_7_0_score := r.AWD606_7_0_score;
self.AWD606_8_0_score := r.AWD606_8_0_score;
self.AWD606_9_0_score := r.AWD606_9_0_score;
self.AWD710_1_0_score := r.AWD710_1_0_score;
self.IE912_0_0_score := r.IE912_0_0_score;
self.IE912_1_0_score := r.IE912_1_0_score;
self.IED1106_1_0_score := r.IED1106_1_0_score;
self.MNC21106_0_0_score := r.MNC21106_0_0_score;
self.MPX1211_0_0_score := r.MPX1211_0_0_score;
self.MSD1010_0_0_score := r.MSD1010_0_0_score;
self.MV361006_0_0_score := r.MV361006_0_0_score;
self.MV361006_1_0_score := r.MV361006_1_0_score;
self.MX361006_0_0_score := r.MX361006_0_0_score;
self.MX361006_1_0_score := r.MX361006_1_0_score;
self.RVA1003_0_0_score := r.RVA1003_0_0_score;
self.RVA1007_1_0_score := r.RVA1007_1_0_score;
self.RVA1007_2_0_score := r.RVA1007_2_0_score;
self.RVA1007_3_0_score := r.RVA1007_3_0_score;
self.RVA1008_1_0_score := r.RVA1008_1_0_score;
self.RVA1008_2_0_score := r.RVA1008_2_0_score;
self.RVA1104_0_0_score := r.RVA1104_0_0_score;
self.RVA1304_1_0_score := r.RVA1304_1_0_score;
self.RVA1304_2_0_score := r.RVA1304_2_0_score;
self.RVA1305_1_0_score := r.RVA1305_1_0_score;
self.RVA1306_1_0_score := r.RVA1306_1_0_score;
self.RVA1309_1_0_score := r.RVA1309_1_0_score;
self.RVA1503_0_0_score := r.RVA1503_0_0_score;
self.RVA1504_1_0_score := r.RVA1504_1_0_score;
self.RVA1504_2_0_score := r.RVA1504_2_0_score;
self.RVA1603_1_0_score := r.RVA1603_1_0_score;
self.RVA1605_1_0_score := r.RVA1605_1_0_score;
self.RVA1607_1_0_score := r.RVA1607_1_0_score;
self.RVA611_0_0_score := r.RVA611_0_0_score;
self.RVA707_0_0_score := r.RVA707_0_0_score;
self.RVA707_1_0_score := r.RVA707_1_0_score;
self.RVA709_1_0_score := r.RVA709_1_0_score;
self.RVA711_0_0_score := r.RVA711_0_0_score;
self.RVB1003_0_0_score := r.RVB1003_0_0_score;
self.RVB1104_0_0_score := r.RVB1104_0_0_score;
self.RVB1104_1_0_score := r.RVB1104_1_0_score;
self.RVB1310_1_0_score := r.RVB1310_1_0_score;
self.RVB1402_1_0_score := r.RVB1402_1_0_score;
self.RVB1503_0_0_score := r.RVB1503_0_0_score;
self.RVB1610_1_0_score := r.RVB1610_1_0_score;
self.RVB609_0_0_score := r.RVB609_0_0_score;
self.RVB703_1_0_score := r.RVB703_1_0_score;
self.RVB705_1_0_score := r.RVB705_1_0_score;
self.RVB711_0_0_score := r.RVB711_0_0_score;
self.RVC1110_1_0_score := r.RVC1110_1_0_score;
self.RVC1110_2_0_score := r.RVC1110_2_0_score;
self.RVC1112_0_0_score := r.RVC1112_0_0_score;
self.RVC1208_1_0_score := r.RVC1208_1_0_score;
self.RVC1210_1_0_score := r.RVC1210_1_0_score;
self.RVC1301_1_0_score := r.RVC1301_1_0_score;
self.RVC1307_1_0_score := r.RVC1307_1_0_score;
self.RVC1405_1_0_score := r.RVC1405_1_0_score;
self.RVC1405_2_0_score := r.RVC1405_2_0_score;
self.RVC1405_3_0_score := r.RVC1405_3_0_score;
self.RVC1405_4_0_score := r.RVC1405_4_0_score;
self.RVC1412_1_0_score := r.RVC1412_1_0_score;
self.RVC1412_2_0_score := r.RVC1412_2_0_score;
self.RVC1602_1_0_score := r.RVC1602_1_0_score;
self.RVC1609_1_0_score := r.RVC1609_1_0_score;
self.RVC1703_1_0_score := r.RVC1703_1_0_score;
self.RVD1010_0_0_score := r.RVD1010_0_0_score;
self.RVD1010_1_0_score := r.RVD1010_1_0_score;
self.RVD1010_2_0_score := r.RVD1010_2_0_score;
self.RVD1110_1_0_score := r.RVD1110_1_0_score;
self.RVG1003_0_0_score := r.RVG1003_0_0_score;
self.RVG1103_0_0_score := r.RVG1103_0_0_score;
self.RVG1106_1_0_score := r.RVG1106_1_0_score;
self.RVG1201_1_0_score := r.RVG1201_1_0_score;
self.RVG1302_1_0_score := r.RVG1302_1_0_score;
self.RVG1304_1_0_score := r.RVG1304_1_0_score;
self.RVG1304_2_0_score := r.RVG1304_2_0_score;
self.RVG1310_1_0_score := r.RVG1310_1_0_score;
self.RVG1401_1_0_score := r.RVG1401_1_0_score;
self.RVG1401_2_0_score := r.RVG1401_2_0_score;
self.RVG1404_1_0_score := r.RVG1404_1_0_score;
self.RVG1502_0_0_score := r.RVG1502_0_0_score;
self.RVG1511_1_0_score := r.RVG1511_1_0_score;
self.RVG1601_1_0_score := r.RVG1601_1_0_score;
self.RVG1605_1_0_score := r.RVG1605_1_0_score;
self.RVG1702_1_0_score := r.RVG1702_1_0_score;
self.RVG1705_1_0_score := r.RVG1705_1_0_score;
self.RVG812_0_0_score := r.RVG812_0_0_score;
self.RVG903_1_0_score := r.RVG903_1_0_score;
self.RVG904_1_0_score := r.RVG904_1_0_score;
self.RVP1003_0_0_score := r.RVP1003_0_0_score;
self.RVP1012_1_0_score := r.RVP1012_1_0_score;
self.RVP1104_0_0_score := r.RVP1104_0_0_score;
self.RVP1208_1_0_score := r.RVP1208_1_0_score;
self.RVP1401_1_0_score := r.RVP1401_1_0_score;
self.RVP1401_2_0_score := r.RVP1401_2_0_score;
self.RVP1503_1_0_score := r.RVP1503_1_0_score;
self.RVP1605_1_0_score := r.RVP1605_1_0_score;
self.RVP804_0_0_score := r.RVP804_0_0_score;
self.RVR1003_0_0_score := r.RVR1003_0_0_score;
self.RVR1008_1_0_score := r.RVR1008_1_0_score;
self.RVR1103_0_0_score := r.RVR1103_0_0_score;
self.RVR1104_2_0_score := r.RVR1104_2_0_score;
// self.RVR1104_3_0_score := r.RVR1104_3_0_score;
self.RVR1210_1_0_score := r.RVR1210_1_0_score;
self.RVR1303_1_0_score := r.RVR1303_1_0_score;
self.RVR1311_1_0_score := r.RVR1311_1_0_score;
self.RVR1410_1_0_score := r.RVR1410_1_0_score;
self.RVR611_0_0_score := r.RVR611_0_0_score;
self.RVR704_1_0_score := r.RVR704_1_0_score;
self.RVR711_0_0_score := r.RVR711_0_0_score;
self.RVR803_1_0_score := r.RVR803_1_0_score;
self.RVT1003_0_0_score := r.RVT1003_0_0_score;
self.RVT1006_1_0_score := r.RVT1006_1_0_score;
self.RVT1104_0_0_score := r.RVT1104_0_0_score;
self.RVT1104_1_0_score := r.RVT1104_1_0_score;
self.RVT1204_1_score := r.RVT1204_1_score;
self.RVT1210_1_0_score := r.RVT1210_1_0_score;
self.RVT1212_1_0_score := r.RVT1212_1_0_score;
self.RVT1307_3_0_score := r.RVT1307_3_0_score;
self.RVT1402_1_0_score := r.RVT1402_1_0_score;
self.RVT1503_0_0_score := r.RVT1503_0_0_score;
self.RVT1601_1_0_score := r.RVT1601_1_0_score;
self.RVT1605_1_0_score := r.RVT1605_1_0_score;
self.RVT1605_2_0_score := r.RVT1605_2_0_score;
self.RVT1608_1_0_score := r.RVT1608_1_0_score;
self.RVT612_0_score := r.RVT612_0_score;
self.RVT711_0_0_score := r.RVT711_0_0_score;
self.RVT711_1_0_score := r.RVT711_1_0_score;
self.RVT803_1_0_score := r.RVT803_1_0_score;
self.RVT809_1_0_score := r.RVT809_1_0_score;
self.TBD605_0_0_score := r.TBD605_0_0_score;
self.TBD609_1_0_score := r.TBD609_1_0_score;
self.TBD609_2_0_score := r.TBD609_2_0_score;
self.TRD605_0_0_score := r.TRD605_0_0_score;
self.TRD609_1_0_score := r.TRD609_1_0_score;
self.WOMV002_0_0_score := r.WOMV002_0_0_score;
self.fp1512_1_0_score := l.fp1512_1_0_score;
self.fp31604_0_0_score := l.fp31604_0_0_score;
self.AIN509_0_0_score := l.AIN509_0_0_score;
self.AIN602_1_0_score := l.AIN602_1_0_score;
self.AIN605_1_0_score := l.AIN605_1_0_score;
self.AIN605_2_0_score := l.AIN605_2_0_score;
self.AIN605_3_0_score := l.AIN605_3_0_score;
self.AIN801_1_0_score := l.AIN801_1_0_score;
self.ANMK909_0_1_score := l.ANMK909_0_1_score;
self.AWN510_0_0_score := l.AWN510_0_0_score;
self.AWN603_1_0_score := l.AWN603_1_0_score;
self.BD3605_0_0_score := l.BD3605_0_0_score;
self.BD5605_0_0_score := l.BD5605_0_0_score;
self.BD5605_1_0_score := l.BD5605_1_0_score;
self.BD5605_2_0_score := l.BD5605_2_0_score;
self.BD5605_3_0_score := l.BD5605_3_0_score;
self.BD9605_0_0_score := l.BD9605_0_0_score;
self.BD9605_1_0_score := l.BD9605_1_0_score;
self.CDN1109_1_0_score := l.CDN1109_1_0_score;
self.CDN1205_1_0_score := l.CDN1205_1_0_score;
self.CDN1305_1_0_score := l.CDN1305_1_0_score;
self.CDN1404_1_0_score := l.CDN1404_1_0_score;
self.CDN1410_1_0_score := l.CDN1410_1_0_score;
self.CDN1506_1_0_score := l.CDN1506_1_0_score;
self.CDN1508_1_0_score := l.CDN1508_1_0_score;
self.CDN604_0_0_score := l.CDN604_0_0_score;
self.CDN604_1_0_score := l.CDN604_1_0_score;
self.CDN604_2_0_score := l.CDN604_2_0_score;
self.CDN604_3_0_score := l.CDN604_3_0_score;
self.CDN604_4_0_score := l.CDN604_4_0_score;
self.CDN605_1_0_score := l.CDN605_1_0_score;
self.CDN606_2_0_score := l.CDN606_2_0_score;
self.CDN706_1_0_score := l.CDN706_1_0_score;
self.CDN707_1_0_score := l.CDN707_1_0_score;
self.CDN712_0_0_score := l.CDN712_0_0_score;
self.CDN806_1_0_score := l.CDN806_1_0_score;
// self.CDN810_1_0_score := l.CDN810_1_0_score;
self.CDN908_1_0_score := l.CDN908_1_0_score;
self.CEN509_0_0_score := l.CEN509_0_0_score;
self.CSN1007_0_0_score := l.CSN1007_0_0_score;
self.FD3510_0_0_score := l.FD3510_0_0_score;
self.FD3606_0_0_score := l.FD3606_0_0_score;
self.FD5510_0_0_score := l.FD5510_0_0_score;
self.FD5603_1_0_score := l.FD5603_1_0_score;
self.FD5603_2_0_score := l.FD5603_2_0_score;
self.FD5603_3_0_score := l.FD5603_3_0_score;
self.FD5607_1_0_score := l.FD5607_1_0_score;
self.FD5609_1_0_score := l.FD5609_1_0_score;
self.FD5609_2_0_score := l.FD5609_2_0_score;
self.FD5709_1_0_score := l.FD5709_1_0_score;
self.FD9510_0_0_score := l.FD9510_0_0_score;
self.FD9603_1_0_score := l.FD9603_1_0_score;
self.FD9603_2_0_score := l.FD9603_2_0_score;
self.FD9603_3_0_score := l.FD9603_3_0_score;
self.FD9603_4_0_score := l.FD9603_4_0_score;
self.FD9604_1_0_score := l.FD9604_1_0_score;
self.FD9606_0_0_score := l.FD9606_0_0_score;
self.FD9607_1_0_score := l.FD9607_1_0_score;
self.FP1109_0_0_score := l.FP1109_0_0_score;
self.FP1210_1_0_score := l.FP1210_1_0_score;
self.FP1303_1_0_score := l.FP1303_1_0_score;
self.FP1303_2_0_score := l.FP1303_2_0_score;
self.FP1307_1_0_score := l.FP1307_1_0_score;
self.FP1310_1_0_score := l.FP1310_1_0_score;
self.FP1401_1_0_score := l.FP1401_1_0_score;
self.FP1403_2_0_score := l.FP1403_2_0_score;
self.FP1404_1_0_score := l.FP1404_1_0_score;
self.FP1406_1_0_score := l.FP1406_1_0_score;
self.FP1407_1_0_score := l.FP1407_1_0_score;
self.FP1407_2_0_score := l.FP1407_2_0_score;
self.FP1506_1_0_score := l.FP1506_1_0_score;
self.FP1509_1_0_score := l.FP1509_1_0_score;
self.FP1509_2_0_score := l.FP1509_2_0_score;
self.FP1510_2_0_score := l.FP1510_2_0_score;
self.fp1511_1_0_score := l.fp1511_1_0_score;
self.FP1606_1_0_score := l.FP1606_1_0_score;
self.FP1609_1_0_score := l.FP1609_1_0_score;
self.FP1610_1_0_score := l.FP1610_1_0_score;
self.FP1610_2_0_score := l.FP1610_2_0_score;
self.FP1611_1_0_score := l.FP1611_1_0_score;
self.FP31105_1_0_score := l.FP31105_1_0_score;
self.FP31203_1_0_score := l.FP31203_1_0_score;
self.FP31310_2_0_score := l.FP31310_2_0_score;
self.FP31505_0_0_score := l.FP31505_0_0_score;
self.FP3710_0_0_score := l.FP3710_0_0_score;
self.FP3904_1_0_score := l.FP3904_1_0_score;
self.FP3905_1_0_score := l.FP3905_1_0_score;
self.FP3FDN1505_0_0_score := l.FP3FDN1505_0_0_score;
self.FP5812_1_0_score := l.FP5812_1_0_score;
self.HCP1206_0_0_score := l.HCP1206_0_0_score;
self.IDN605_1_0_score := l.IDN605_1_0_score;
self.IEN1006_0_1_score := l.IEN1006_0_1_score;
self.MSN1106_0_0_score := l.MSN1106_0_0_score;
self.MSN605_1_0_score := l.MSN605_1_0_score;
self.MSN610_0_0_score := l.MSN610_0_0_score;
self.OSN1504_0_0_score := l.OSN1504_0_0_score;
self.OSN1608_1_0_score := l.OSN1608_1_0_score;
self.RSB801_1_0_score := l.RSB801_1_0_score;
self.RSN1001_1_0_score := l.RSN1001_1_0_score;
self.RSN1009_1_0_score := l.RSN1009_1_0_score;
self.RSN1010_1_0_score := l.RSN1010_1_0_score;
self.RSN1103_1_0_score := l.RSN1103_1_0_score;
self.RSN1105_1_0_score := l.RSN1105_1_0_score;
self.RSN1105_2_0_score := l.RSN1105_2_0_score;
self.RSN1105_3_0_score := l.RSN1105_3_0_score;
self.RSN1108_1_0_score := l.RSN1108_1_0_score;
self.RSN1108_2_0_score := l.RSN1108_2_0_score;
self.RSN1108_3_0_score := l.RSN1108_3_0_score;
self.RSN508_1_0_score := l.RSN508_1_0_score;
self.RSN509_1_0_score := l.RSN509_1_0_score;
self.RSN509_2_0_score := l.RSN509_2_0_score;
self.RSN604_2_0_score := l.RSN604_2_0_score;
self.RSN607_0_0_score := l.RSN607_0_0_score;
self.RSN607_1_0_score := l.RSN607_1_0_score;
self.RSN702_1_0_score := l.RSN702_1_0_score;
self.RSN704_0_0_score := l.RSN704_0_0_score;
self.RSN704_1_0_score := l.RSN704_1_0_score;
self.RSN802_1_0_score := l.RSN802_1_0_score;
self.RSN803_1_0_score := l.RSN803_1_0_score;
self.RSN803_2_0_score := l.RSN803_2_0_score;
self.RSN804_1_0_score := l.RSN804_1_0_score;
self.RSN807_0_0_score := l.RSN807_0_0_score;
self.RSN810_1_0_score := l.RSN810_1_0_score;
self.RSN912_1_0_score := l.RSN912_1_0_score;
self.RVS811_0_0_score := l.RVS811_0_0_score;
self.TBN509_0_0_score := l.TBN509_0_0_score;
self.TBN604_1_0_score := l.TBN604_1_0_score;
self.WWN604_1_0_score := l.WWN604_1_0_score;
self := [];
End;

all_runway := join(nonfcra_runway_data, fcra_runway_data, left.seq = right.seq  and left.seq <>0 and right.seq<>0, join_them(left,right));//11/9/2015 - Adding the filter (seq<>0) in order to counter duplicates when seq = 0

 output(all_runway, ,'~Scoring_Project::out::runway_join_results_' + dt + '_1', thor, overwrite);

result := all_runway;
Return result;

End;