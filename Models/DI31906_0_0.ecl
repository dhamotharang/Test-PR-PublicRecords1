import risk_indicators, ut, Models, STD;

EXPORT DI31906_0_0(dataset(risk_indicators.Layout_Output) iid_out) := FUNCTION

DEBUG := false;

#if(DEBUG)
Layout_Debug := RECORD

//Intermediate variables
  Unsigned seq;
	String today;
	String processing_yr;
	String processing_mo;
	String processing_dy;
	String processing_mdy;
	Integer blacklist_sum2;
	Boolean any_blacklist;
	Integer finstatus_reject_sum;
	Boolean any_finstatus_reject;
	Integer fraudbyuser_sum;
	Boolean any_fraudbyuser;
	Integer smartidperemailintxinqcnt;
	Integer smartidperemailintxinqcnt1y;
	Integer smartidperemailintxinqcnt3m;
	Integer smartidperemailintxinqcnt1m;
	Integer smartidperphoneintxinqcnt1y;
	Integer smartidperphoneintxinqcnt1m;
	Integer exactidperemailintxinqcnt;
	Integer exactidperemailintxinqcnt6m;
	Integer exactidperemailintxinqcnt3m;
	Integer exactidperemailintxinqcnt1m;
	Integer exactidperphoneintxinqcnt3m;
	Integer emailperphoneintxinqcnt;
	Integer emailperphoneintxinqcnt1y;
	Integer emailperphoneintxinqcnt3m;
	Integer emailperphoneintxinqcnt6m;
	Integer phoneperemailintxinqcnt1y;
	Integer phoneperemailintxinqcnt1m;
	Integer phoneperemailintxinqcnt3m;
	Integer tmxidperemailintxinqcnt;
	Integer tmxidperemailintxinqcnt1y;
	Integer tmxidperemailintxinqcnt1m;
	Integer tmxidperphoneintxinqcnt1y;
	Integer tmxidperphoneintxinqcnt3m;
	Integer orgidperemailintxinqcnt;
	Integer trueipperemailintxinqcnt;
	Integer trueipperphoneintxinqcnt;
	Integer dnsipperemailintxinqcnt;
	Integer proxyipperemailintxinqcnt;
	Integer proxyipgperemailintxinqcnt;
	Integer browserhashperemailintxinqcnt;
	Integer browserhashperphoneintxinqcnt;
	Integer loginidperphoneintxinqcnt;
	Integer txinqcorremailwphonecnt;
	Integer txinqcorremailwphonecnt1y;
	Integer txinqcorremailwphonecnt3m;
	Integer txinqcorremailwphonecnt1m;
	Integer txinqwemailcnt6m;
	Integer txinqwphonecnt1y;
	Integer txinqcorremailwaddresscnt;
	Integer txinqcorremailwaddresscnt6m;
	Integer txinqcorremailwnamecnt1y;
	Real distbtwtrueipwemailavg;
	Real distbtwtrueipwphoneavg;
	Real timebtwtxinqwemailavg;
	Real timebtwtxinqwphoneavg;
	Integer trueippertmxidintxinqcnt1m;
	Integer exactidpertmxidintxinqcnt;
	Integer txinqwaddrfirst_dayssince;
	Integer txinqwaddrlast_dayssince;
	Integer txinqwemailfirst_dayssince;
	Integer txinqwemaillast_dayssince;
	Integer txinqwnamefirst_dayssince;
	Integer txinqwnamelast_dayssince;
	Integer txinqwphonefirst_dayssince;
	Integer txinqwphonelast_dayssince;
	Integer txinqwtmxidfirst_dayssince;
	Real gbm10_wc_lgt_0;
	Real rc004_1_9;
	Real gbm10_wc_lgt_1;
	Real rc008_1_4;
	Real rc003_1_2;
	Real rc001_1_1;
	Real rc001_2_9;
	Real rc003_2_2;
	Real gbm10_wc_lgt_2;
	Real rc004_2_1;
	Real rc002_2_4;
	Real rc002_3_6;
	Real rc009_3_1;
	Real gbm10_wc_lgt_3;
	Real rc010_3_2;
	Real rc019_3_8;
	Real rc004_4_9;
	Real rc034_4_4;
	Real gbm10_wc_lgt_4;
	Real rc006_4_1;
	Real rc009_4_2;
	Real rc004_5_1;
	Real rc015_5_5;
	Real gbm10_wc_lgt_5;
	Real rc014_5_2;
	Real rc005_5_4;
	Real rc001_6_2;
	Real gbm10_wc_lgt_6;
	Real rc010_6_1;
	Real rc012_6_3;
	Real rc028_6_9;
	Real rc001_7_3;
	Real gbm10_wc_lgt_7;
	Real rc028_7_5;
	Real rc009_7_2;
	Real rc030_7_1;
	Real gbm10_wc_lgt_8;
	Real rc020_8_6;
	Real rc003_8_10;
	Real rc006_8_1;
	Real rc009_8_2;
	Real rc027_9_7;
	Real rc002_9_6;
	Real rc019_9_2;
	Real gbm10_wc_lgt_9;
	Real rc030_9_1;
	Real rc014_10_2;
	Real rc013_10_6;
	Real rc011_10_8;
	Real gbm10_wc_lgt_10;
	Real rc001_10_1;
	Real rc012_11_7;
	Real rc010_11_2;
	Real rc021_11_1;
	Real gbm10_wc_lgt_11;
	Real rc037_11_3;
	Real gbm10_wc_lgt_12;
	Real rc011_12_4;
	Real rc018_12_1;
	Real rc013_12_7;
	Real rc001_12_2;
	Real rc009_13_3;
	Real rc008_13_1;
	Real rc003_13_9;
	Real gbm10_wc_lgt_13;
	Real rc020_13_2;
	Real rc045_14_1;
	Real rc008_14_8;
	Real rc008_14_3;
	Real gbm10_wc_lgt_14;
	Real rc012_14_2;
	Real rc015_15_7;
	Real rc004_15_1;
	Real rc017_15_5;
	Real gbm10_wc_lgt_15;
	Real rc007_15_3;
	Real rc037_16_1;
	Real rc006_16_7;
	Real rc005_16_6;
	Real gbm10_wc_lgt_16;
	Real rc010_16_4;
	Real gbm10_wc_lgt_17;
	Real rc004_17_1;
	Real rc024_17_4;
	Real rc008_17_8;
	Real rc027_17_3;
	Real rc021_18_4;
	Real rc001_18_1;
	Real rc013_18_9;
	Real gbm10_wc_lgt_18;
	Real rc014_18_2;
	Real gbm10_wc_lgt_19;
	Real rc018_19_1;
	Real rc002_19_7;
	Real rc011_19_3;
	Real rc007_19_5;
	Real rc029_20_4;
	Real gbm10_wc_lgt_20;
	Real rc002_20_3;
	Real rc020_20_1;
	Real rc029_20_6;
	Real rc024_21_7;
	Real rc002_21_9;
	Real rc045_21_1;
	Real gbm10_wc_lgt_21;
	Real rc006_21_2;
	Real rc001_22_3;
	Real rc009_22_1;
	Real gbm10_wc_lgt_22;
	Real rc002_22_4;
	Real rc022_22_8;
	Real rc002_23_1;
	Real rc004_23_7;
	Real gbm10_wc_lgt_23;
	Real rc052_23_2;
	Real rc005_23_9;
	Real gbm10_wc_lgt_24;
	Real rc005_24_3;
	Real rc015_24_1;
	Real rc033_24_6;
	Real rc002_24_4;
	Real gbm10_wc_lgt_25;
	Real rc036_25_5;
	Real rc027_25_4;
	Real rc021_25_1;
	Real rc003_25_2;
	Real rc003_26_6;
	Real gbm10_wc_lgt_26;
	Real rc008_26_2;
	Real rc008_26_1;
	Real rc018_26_8;
	Real rc014_27_2;
	Real rc001_27_1;
	Real rc007_27_5;
	Real gbm10_wc_lgt_27;
	Real rc026_27_4;
	Real gbm10_wc_lgt_28;
	Real rc001_28_10;
	Real rc037_28_1;
	Real rc016_28_6;
	Real rc015_28_2;
	Real rc020_29_10;
	Real rc038_29_1;
	Real rc017_29_2;
	Real gbm10_wc_lgt_29;
	Real rc002_29_4;
	Real rc002_30_1;
	Real rc015_30_3;
	Real gbm10_wc_lgt_30;
	Real rc052_30_2;
	Real rc021_30_4;
	Real rc033_31_2;
	Real rc024_31_1;
	Real gbm10_wc_lgt_31;
	Real rc016_31_6;
	Real rc020_31_5;
	Real rc037_32_3;
	Real rc023_32_6;
	Real rc005_32_7;
	Real rc033_32_1;
	Real gbm10_wc_lgt_32;
	Real rc022_33_4;
	Real rc016_33_9;
	Real gbm10_wc_lgt_33;
	Real rc011_33_3;
	Real rc001_33_1;
	Real gbm10_wc_lgt_34;
	Real rc007_34_3;
	Real rc002_34_9;
	Real rc030_34_1;
	Real rc002_34_4;
	Real rc008_35_2;
	Real gbm10_wc_lgt_35;
	Real rc008_35_1;
	Real rc003_35_6;
	Real rc003_35_8;
	Real rc036_36_4;
	Real rc038_36_1;
	Real gbm10_wc_lgt_36;
	Real rc002_36_5;
	Real rc032_36_2;
	Real rc002_37_5;
	Real rc023_37_2;
	Real gbm10_wc_lgt_37;
	Real rc022_37_1;
	Real rc039_37_3;
	Real rc006_38_7;
	Real rc035_38_3;
	Real rc001_38_1;
	Real gbm10_wc_lgt_38;
	Real rc005_38_6;
	Real rc025_39_3;
	Real gbm10_wc_lgt_39;
	Real rc002_39_4;
	Real rc011_39_9;
	Real rc018_39_1;
	Real rc007_40_4;
	Real gbm10_wc_lgt_40;
	Real rc002_40_1;
	Real rc042_40_6;
	Real rc046_40_2;
	Real gbm10_wc_lgt_41;
	Real rc002_41_4;
	Real rc015_41_1;
	Real rc005_41_3;
	Real rc012_41_5;
	Real rc017_42_3;
	Real rc001_42_10;
	Real rc035_42_1;
	Real rc015_42_2;
	Real gbm10_wc_lgt_42;
	Real rc003_43_1;
	Real rc006_43_3;
	Real rc008_43_4;
	Real gbm10_wc_lgt_43;
	Real rc023_43_8;
	Real gbm10_wc_lgt_44;
	Real rc001_44_2;
	Real rc031_44_1;
	Real rc026_44_9;
	Real rc002_44_6;
	Real rc007_45_5;
	Real gbm10_wc_lgt_45;
	Real rc004_45_1;
	Real rc007_45_3;
	Real rc017_45_7;
	Real rc036_46_4;
	Real rc051_46_3;
	Real rc029_46_1;
	Real gbm10_wc_lgt_46;
	Real rc002_46_2;
	Real rc005_47_2;
	Real rc003_47_4;
	Real rc012_47_1;
	Real gbm10_wc_lgt_47;
	Real rc032_47_3;
	Real rc017_48_8;
	Real gbm10_wc_lgt_48;
	Real rc047_48_3;
	Real rc033_48_1;
	Real rc030_48_2;
	Real rc011_49_6;
	Real rc003_49_1;
	Real rc016_49_3;
	Real rc026_49_9;
	Real gbm10_wc_lgt_49;
	Real rc033_50_1;
	Real gbm10_wc_lgt_50;
	Real rc005_50_3;
	Real rc005_50_7;
	Real rc011_50_5;
	Real rc002_51_9;
	Real rc049_51_5;
	Real gbm10_wc_lgt_51;
	Real rc038_51_1;
	Real rc012_51_2;
	Real rc001_52_1;
	Real rc031_52_3;
	Real rc046_52_6;
	Real rc004_52_5;
	Real gbm10_wc_lgt_52;
	Real rc003_53_1;
	Real rc013_53_9;
	Real rc038_53_4;
	Real gbm10_wc_lgt_53;
	Real rc019_53_3;
	Real rc017_54_4;
	Real rc005_54_2;
	Real rc002_54_1;
	Real gbm10_wc_lgt_54;
	Real rc017_54_3;
	Real rc049_55_3;
	Real rc002_55_1;
	Real gbm10_wc_lgt_55;
	Real rc018_55_2;
	Real rc024_55_5;
	Real rc006_56_2;
	Real rc029_56_1;
	Real gbm10_wc_lgt_56;
	Real rc010_56_3;
	Real rc027_56_5;
	Real rc005_57_6;
	Real gbm10_wc_lgt_57;
	Real rc003_57_1;
	Real rc006_57_3;
	Real rc023_57_5;
	Real gbm10_wc_lgt_58;
	Real rc002_58_5;
	Real rc032_58_1;
	Real rc011_58_4;
	Real rc007_58_3;
	Real gbm10_wc_lgt_59;
	Real rc044_59_3;
	Real rc049_59_1;
	Real rc044_59_4;
	Real rc011_59_6;
	Real rc007_60_6;
	Real rc004_60_1;
	Real rc007_60_4;
	Real rc004_60_2;
	Real gbm10_wc_lgt_60;
	Real rc041_61_4;
	Real rc032_61_1;
	Real rc007_61_5;
	Real rc032_61_2;
	Real gbm10_wc_lgt_61;
	Real rc005_62_3;
	Real rc009_62_8;
	Real rc033_62_1;
	Real rc037_62_5;
	Real gbm10_wc_lgt_62;
	Real gbm10_wc_lgt_63;
	Real rc029_63_3;
	Real rc012_63_5;
	Real rc001_63_1;
	Real rc002_63_7;
	Real gbm10_wc_lgt_64;
	Real rc002_64_4;
	Real rc003_64_1;
	Real rc037_64_3;
	Real rc042_64_6;
	Real rc009_65_1;
	Real rc031_65_5;
	Real rc007_65_4;
	Real rc045_65_2;
	Real gbm10_wc_lgt_65;
	Real rc019_66_3;
	Real rc001_66_1;
	Real gbm10_wc_lgt_66;
	Real rc018_66_4;
	Real rc021_66_8;
	Real rc032_67_3;
	Real rc012_67_1;
	Real gbm10_wc_lgt_67;
	Real rc005_67_2;
	Real rc003_67_4;
	Real gbm10_wc_lgt_68;
	Real rc001_68_1;
	Real rc005_68_7;
	Real rc013_68_5;
	Real rc010_68_3;
	Real rc055_69_3;
	Real rc043_69_6;
	Real gbm10_wc_lgt_69;
	Real rc040_69_4;
	Real rc003_69_1;
	Real rc035_70_1;
	Real rc016_70_4;
	Real rc044_70_2;
	Real gbm10_wc_lgt_70;
	Real rc011_70_5;
	Real rc001_71_2;
	Real rc031_71_1;
	Real rc008_71_4;
	Real gbm10_wc_lgt_71;
	Real rc007_71_9;
	Real gbm10_wc_lgt_72;
	Real rc032_72_4;
	Real rc039_72_3;
	Real rc011_72_2;
	Real rc002_72_1;
	Real gbm10_wc_lgt_73;
	Real rc014_73_9;
	Real rc047_73_1;
	Real rc008_73_2;
	Real rc025_73_6;
	Real rc036_74_5;
	Real rc020_74_1;
	Real rc003_74_9;
	Real rc013_74_3;
	Real gbm10_wc_lgt_74;
	Real rc034_75_4;
	Real rc021_75_2;
	Real rc019_75_9;
	Real rc015_75_1;
	Real gbm10_wc_lgt_75;
	Real gbm10_wc_lgt_76;
	Real rc041_76_6;
	Real rc017_76_2;
	Real rc038_76_1;
	Real rc015_76_9;
	Real rc032_77_1;
	Real rc032_77_2;
	Real rc007_77_9;
	Real gbm10_wc_lgt_77;
	Real rc038_77_4;
	Real rc006_78_3;
	Real gbm10_wc_lgt_78;
	Real rc023_78_8;
	Real rc008_78_4;
	Real rc003_78_1;
	Real gbm10_wc_lgt_79;
	Real rc041_79_3;
	Real rc012_79_9;
	Real rc003_79_1;
	Real rc026_79_4;
	Real rc029_80_7;
	Real gbm10_wc_lgt_80;
	Real rc006_80_5;
	Real rc018_80_1;
	Real rc007_80_3;
	Real rc030_81_1;
	Real rc039_81_4;
	Real gbm10_wc_lgt_81;
	Real rc030_81_2;
	Real rc004_81_10;
	Real gbm10_wc_lgt_82;
	Real rc018_82_7;
	Real rc050_82_4;
	Real rc046_82_1;
	Real rc006_82_3;
	Real rc034_83_5;
	Real rc006_83_3;
	Real gbm10_wc_lgt_83;
	Real rc021_83_1;
	Real rc006_83_6;
	Real gbm10_wc_lgt_84;
	Real rc038_84_5;
	Real rc015_84_1;
	Real rc006_84_4;
	Real rc010_84_2;
	Real gbm10_wc_lgt_85;
	Real rc003_85_1;
	Real rc029_85_6;
	Real rc006_85_8;
	Real rc016_85_3;
	Real rc025_86_5;
	Real gbm10_wc_lgt_86;
	Real rc006_86_8;
	Real rc002_86_4;
	Real rc033_86_1;
	Real rc049_87_1;
	Real rc011_87_8;
	Real rc017_87_3;
	Real rc027_87_4;
	Real gbm10_wc_lgt_87;
	Real rc040_88_6;
	Real rc024_88_1;
	Real gbm10_wc_lgt_88;
	Real rc023_88_4;
	Real rc048_88_3;
	Real rc031_89_3;
	Real gbm10_wc_lgt_89;
	Real rc001_89_1;
	Real rc008_89_8;
	Real rc017_89_4;
	Real rc033_90_3;
	Real rc008_90_1;
	Real rc005_90_5;
	Real rc003_90_4;
	Real gbm10_wc_lgt_90;
	Real rc039_91_2;
	Real gbm10_wc_lgt_91;
	Real rc020_91_3;
	Real rc002_91_1;
	Real rc012_91_7;
	Real rc012_92_6;
	Real rc002_92_5;
	Real gbm10_wc_lgt_92;
	Real rc011_92_1;
	Real rc002_92_3;
	Real rc025_93_1;
	Real rc003_93_2;
	Real rc005_93_4;
	Real gbm10_wc_lgt_93;
	Real rc047_93_9;
	Real rc001_94_1;
	Real gbm10_wc_lgt_94;
	Real rc014_94_5;
	Real rc005_94_7;
	Real rc024_94_2;
	Real rc048_95_3;
	Real rc040_95_2;
	Real gbm10_wc_lgt_95;
	Real rc048_95_1;
	Real rc005_95_5;
	Real rc053_96_6;
	Real rc032_96_2;
	Real rc032_96_1;
	Real rc002_96_7;
	Real gbm10_wc_lgt_96;
	Real rc005_97_4;
	Real rc022_97_5;
	Real rc032_97_1;
	Real gbm10_wc_lgt_97;
	Real rc003_97_2;
	Real gbm10_wc_lgt_98;
	Real rc042_98_4;
	Real rc032_98_1;
	Real rc002_98_8;
	Real rc007_98_3;
	Real rc011_99_6;
	Real rc021_99_1;
	Real rc010_99_2;
	Real rc020_99_4;
	Real gbm10_wc_lgt_99;
	Real gbm10_wc_lgt_100;
	Real rc031_100_1;
	Real rc005_100_7;
	Real rc011_100_5;
	Real rc013_100_3;
	Real rc006_101_8;
	Real rc003_101_1;
	Real rc031_101_4;
	Real gbm10_wc_lgt_101;
	Real rc038_101_3;
	Real rc001_102_1;
	Real rc012_102_3;
	Real rc003_102_5;
	Real gbm10_wc_lgt_102;
	Real rc013_102_7;
	Real rc019_103_10;
	Real rc003_103_3;
	Real rc006_103_5;
	Real gbm10_wc_lgt_103;
	Real rc012_103_1;
	Real rc026_104_9;
	Real rc043_104_5;
	Real gbm10_wc_lgt_104;
	Real rc003_104_1;
	Real rc016_104_3;
	Real rc046_105_1;
	Real rc002_105_4;
	Real rc012_105_6;
	Real rc033_105_3;
	Real gbm10_wc_lgt_105;
	Real rc005_106_3;
	Real rc012_106_5;
	Real rc015_106_1;
	Real gbm10_wc_lgt_106;
	Real rc018_106_4;
	Real rc035_107_6;
	Real rc001_107_1;
	Real rc016_107_9;
	Real gbm10_wc_lgt_107;
	Real rc028_107_2;
	Real rc022_108_2;
	Real rc011_108_7;
	Real rc050_108_4;
	Real rc029_108_1;
	Real gbm10_wc_lgt_108;
	Real gbm10_wc_lgt_109;
	Real rc054_109_1;
	Real rc020_109_8;
	Real rc017_109_3;
	Real rc005_109_2;
	Real gbm10_wc_lgt_110;
	Real rc015_110_3;
	Real rc030_110_1;
	Real rc043_110_2;
	Real rc006_110_5;
	Real gbm10_wc_lgt_111;
	Real rc032_111_2;
	Real rc023_111_4;
	Real rc041_111_1;
	Real rc044_111_9;
	Real rc021_112_1;
	Real gbm10_wc_lgt_112;
	Real rc006_112_3;
	Real rc011_112_5;
	Real rc002_112_7;
	Real rc003_113_1;
	Real rc012_113_6;
	Real rc006_113_7;
	Real rc025_113_3;
	Real gbm10_wc_lgt_113;
	Real gbm10_wc_lgt_114;
	Real rc024_114_3;
	Real rc038_114_8;
	Real rc053_114_1;
	Real rc009_114_4;
	Real gbm10_wc_lgt_115;
	Real rc056_115_2;
	Real rc035_115_1;
	Real rc010_115_3;
	Real rc016_115_7;
	Real rc005_116_3;
	Real gbm10_wc_lgt_116;
	Real rc022_116_1;
	Real rc009_116_4;
	Real rc027_116_2;
	Real rc010_117_4;
	Real gbm10_wc_lgt_117;
	Real rc001_117_1;
	Real rc016_117_3;
	Real rc031_117_5;
	Real rc013_118_8;
	Real gbm10_wc_lgt_118;
	Real rc010_118_6;
	Real rc014_118_4;
	Real rc029_118_1;
	Real rc004_119_1;
	Real rc031_119_3;
	Real gbm10_wc_lgt_119;
	Real rc031_119_2;
	Real rc001_119_4;
	Real rc005_120_5;
	Real rc033_120_3;
	Real rc003_120_4;
	Real gbm10_wc_lgt_120;
	Real rc008_120_1;
	Real rc022_121_4;
	Real rc020_121_7;
	Real rc016_121_1;
	Real gbm10_wc_lgt_121;
	Real rc029_121_5;
	Real gbm10_wc_lgt_122;
	Real rc010_122_5;
	Real rc001_122_1;
	Real rc010_122_3;
	Real rc031_122_7;
	Real rc004_123_2;
	Real rc013_123_4;
	Real gbm10_wc_lgt_123;
	Real rc012_123_3;
	Real rc022_123_1;
	Real rc029_124_8;
	Real rc033_124_1;
	Real gbm10_wc_lgt_124;
	Real rc013_124_3;
	Real rc039_124_4;
	Real rc018_125_7;
	Real rc022_125_9;
	Real rc013_125_2;
	Real rc013_125_1;
	Real gbm10_wc_lgt_125;
	Real rc044_126_3;
	Real gbm10_wc_lgt_126;
	Real rc019_126_2;
	Real rc046_126_4;
	Real rc019_126_1;
	Real rc030_127_1;
	Real gbm10_wc_lgt_127;
	Real rc021_127_4;
	Real rc005_127_7;
	Real rc004_127_5;
	Real rc047_128_2;
	Real rc054_128_3;
	Real gbm10_wc_lgt_128;
	Real rc005_128_7;
	Real rc054_128_1;
	Real rc023_129_9;
	Real gbm10_wc_lgt_129;
	Real rc041_129_3;
	Real rc051_129_5;
	Real rc003_129_1;
	Real gbm10_wc_lgt_130;
	Real rc030_130_4;
	Real rc005_130_3;
	Real rc003_130_1;
	Real rc034_130_5;
	Real rc032_131_1;
	Real gbm10_wc_lgt_131;
	Real rc011_131_4;
	Real rc025_131_3;
	Real rc047_131_5;
	Real rc012_132_5;
	Real gbm10_wc_lgt_132;
	Real rc033_132_3;
	Real rc033_132_1;
	Real rc028_132_2;
	Real rc005_133_3;
	Real rc010_133_6;
	Real rc035_133_5;
	Real rc038_133_1;
	Real gbm10_wc_lgt_133;
	Real rc001_134_1;
	Real gbm10_wc_lgt_134;
	Real rc007_134_5;
	Real rc006_134_6;
	Real rc026_134_3;
	Real rc021_135_8;
	Real rc025_135_3;
	Real rc003_135_1;
	Real gbm10_wc_lgt_135;
	Real rc016_135_4;
	Real rc010_136_1;
	Real rc002_136_7;
	Real gbm10_wc_lgt_136;
	Real rc006_136_8;
	Real rc010_136_2;
	Real rc002_137_5;
	Real rc010_137_2;
	Real gbm10_wc_lgt_137;
	Real rc048_137_1;
	Real rc048_137_3;
	Real rc009_138_7;
	Real rc026_138_5;
	Real rc005_138_3;
	Real gbm10_wc_lgt_138;
	Real rc033_138_1;
	Real rc038_139_7;
	Real rc035_139_5;
	Real gbm10_wc_lgt_139;
	Real rc001_139_1;
	Real rc010_139_3;
	Real gbm10_wc_lgt_140;
	Real rc013_140_3;
	Real rc017_140_10;
	Real rc007_140_5;
	Real rc023_140_1;
	Real rc011_141_3;
	Real rc024_141_1;
	Real rc025_141_9;
	Real gbm10_wc_lgt_141;
	Real rc048_141_4;
	Real rc012_142_2;
	Real rc042_142_1;
	Real rc047_142_4;
	Real gbm10_wc_lgt_142;
	Real rc041_142_8;
	Real rc035_143_3;
	Real rc035_143_5;
	Real rc036_143_7;
	Real gbm10_wc_lgt_143;
	Real rc003_143_1;
	Real gbm10_wc_lgt_144;
	Real rc039_144_3;
	Real rc014_144_7;
	Real rc002_144_1;
	Real rc043_144_2;
	Real aa_rc000;
	Real gbm10_wc_lgt;
	Real lgt;
	Real offset;
	Real base;
	Real pts;
	Real gbm_mod10;
	Real aa_rc032;
	Real aa_rc027;
	Real aa_rc051;
	Real aa_rc023;
	Real aa_rc041;
	Real aa_rc050;
	Real aa_rc053;
	Real aa_rc001;
	Real aa_rc014;
	Real aa_rc045;
	Real aa_rc033;
	Real aa_rc009;
	Real aa_rc044;
	Real aa_rc046;
	Real aa_rc047;
	Real aa_rc034;
	Real aa_rc036;
	Real aa_rc056;
	Real aa_rc040;
	Real aa_rc039;
	Real aa_rc030;
	Real aa_rc020;
	Real aa_rc008;
	Real aa_rc019;
	Real aa_rc054;
	Real aa_rc042;
	Real aa_rc003;
	Real aa_rc028;
	Real aa_rc024;
	Real aa_rc052;
	Real aa_rc049;
	Real aa_rc004;
	Real aa_rc031;
	Real aa_rc016;
	Real aa_rc025;
	Real aa_rc002;
	Real aa_rc029;
	Real aa_rc013;
	Real aa_rc026;
	Real aa_rc005;
	Real aa_rc022;
	Real aa_rc035;
	Real aa_rc006;
	Real aa_rc012;
	Real aa_rc055;
	Real aa_rc038;
	Real aa_rc007;
	Real aa_rc018;
	Real aa_rc010;
	Real aa_rc021;
	Real aa_rc037;
	Real aa_rc017;
	Real aa_rc048;
	Real aa_rc015;
	Real aa_rc043;
	Real wccat_corremailphone;
	Real wccat_corremailname;
	Real wccat_corremailaddr;
	Real wccat_emailperphone;
	Real wccat_deviceperemail;
	Real wccat_ipperemail;
	Real wccat_phoneperemail;
	Real wccat_deviceperphone;
	Real wccat_tmxidperemail;
	Real wccat_tmxidperphone;
	Real wccat_addrdayssincefirstseen;
	Real wccat_addrdayssincelastseen;
	Real wccat_emaildayssincefirstseen;
	Real wccat_emaildayssincelastseen;
	Real wccat_namedayssincefirstseen;
	Real wccat_namedayssincelastseen;
	Real wccat_phonedayssincefirstseen;
	Real wccat_phonedayssincelastseen;
	Real wccat_tmxiddayssincefirstseen;
	Real wccat_avgtimebetweentxwemail;
	Real wccat_avgtimebetweentxwphone;
	Real wccat_browserhashperemail;
	Real wccat_browserhashperphone;
	Real wccat_distbetweenipwphone;
	Real wccat_eventsperemail;
	Real wccat_eventsperphone;
	Real wccat_devicepertmxid;
	Real wccat_ipperphone;
	Real wccat_ippertmxid;
	Real wccat_loginidperphone;
	Real wccat_orgidperemail;
	Real wccat_fraudbyuser;
	Real wccat_blacklist;
	Real wccat_finalstatusreject;
	String wc00_code;
	String wc00_catname;
	String wc01_code;
	String wc01_catname;
	String wc02_code;
	String wc02_catname;
	String wc03_code;
	String wc03_catname;
	String wc04_code;
	String wc04_catname;
	String wc05_code;
	String wc05_catname;
	String wc06_code;
	String wc06_catname;
	String wc10_code;
	String wc10_catname;
	String wc11_code;
	String wc11_catname;
	String wc12_code;
	String wc12_catname;
	String wc13_code;
	String wc13_catname;
	String wc14_code;
	String wc14_catname;
	String wc15_code;
	String wc15_catname;
	String wc16_code;
	String wc16_catname;
	String wc20_code;
	String wc20_catname;
	String wc21_code;
	String wc21_catname;
	String wc30_code;
	String wc30_catname;
	String wc31_code;
	String wc31_catname;
	String wc32_code;
	String wc32_catname;
	String wc40_code;
	String wc40_catname;
	String wc41_code;
	String wc41_catname;
	String wc42_code;
	String wc42_catname;
	String wc43_code;
	String wc43_catname;
	String wc44_code;
	String wc44_catname;
	String wc45_code;
	String wc45_catname;
	String wc46_code;
	String wc46_catname;
	String wc47_code;
	String wc47_catname;
	String wc48_code;
	String wc48_catname;
	String wc50_code;
	String wc50_catname;
	String wc51_code;
	String wc51_catname;
	String wc60_code;
	String wc60_catname;
	String wc97_code;
	String wc97_catname;
	String wc98_code;
	String wc98_catname;
	String wc99_code;
	String wc99_catname;
	Real wc_outpts1;
	Real wc_outpts2;
	Real wc_outpts3;
	Real wc_outpts4;
	Real wc_outpts5;
	Real wc_outpts6;
  String wc_outcatname1;
	String wc_outcatname2;
	String wc_outcatname3;
	String wc_outcatname4;
	String wc_outcatname5;
	String wc_outcatname6;
	String wc1;
  String wc2;
	String wc3;
	String wc4;
	String wc5;
	String wc6;
	String di31906;
  // Dataset(risk_indicators.Layout_Desc) ri;


  // models.layouts.layout_fp1109;
  // Risk_Indicators.Layout_Boca_Shell clam;
END;
			
  layout_debug doModel( iid_out le ) := TRANSFORM
#else
  models.layouts.layout_fp1109 doModel( iid_out le ) := TRANSFORM

#end	

/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
  txinqwaddrfirst                  := le.threatmetrix.TxinqWAddrFirst;
  txinqwaddrlast                   := le.threatmetrix.TxinqWAddrLast;
  txinqwemailfirst                 := le.threatmetrix.TxinqWEmailFirst;
  txinqwemaillast                  := le.threatmetrix.TxinqWEmailLast;
  txinqwnamefirst                  := le.threatmetrix.TxinqWNameFirst;
  txinqwnamelast                   := le.threatmetrix.TxinqWNameLast;
  txinqwphonefirst                 := le.threatmetrix.TxinqWPhoneFirst;
  txinqwphonelast                  := le.threatmetrix.TxinqWPhoneLast;
  txinqwtmxidfirst                 := le.threatmetrix.TxinqWTmxidFirst;
  ruleemailblistflag               := (Integer)le.threatmetrix.RuleEmailBlistFlag;
  ruleemailblistbybankflag         := (Integer)le.threatmetrix.RuleEmailBlistByBankFlag;
  ruleemailblistbyfintechflag      := (Integer)le.threatmetrix.RuleEmailBlistByFinTechFlag;
  ruleemailblistbyecommflag        := (Integer)le.threatmetrix.RuleEmailBlistByEcommFlag;
  ruleexactidblistintxinqweflag1m  := (Integer)le.threatmetrix.RuleExactidBlistInTxinqWEFlag1M;
  ruleexactidblistintxinqweflag    := (Integer)le.threatmetrix.RuleExactidBlistInTxinqWEFlag;
  rulesmartidblistintxinqweflag1m  := (Integer)le.threatmetrix.RuleSmartidBlistInTxinqWEFlag1M;
  rulesmartidblistintxinqweflag    := (Integer)le.threatmetrix.RuleSmartidBlistInTxinqWEFlag;
  ruleexactidblistintxinqwpflag1m  := (Integer)le.threatmetrix.RuleExactidBlistInTxinqWPFlag1M;
  ruleexactidblistintxinqwpflag1y  := (Integer)le.threatmetrix.RuleExactidBlistInTxinqWPFlag1Y;
  rulesmartidblistintxinqwpflag1m  := (Integer)le.threatmetrix.RuleSmartidBlistInTxinqWPFlag1M;
  rulesmartidblistintxinqwpflag1y  := (Integer)le.threatmetrix.RuleSmartidBlistInTxinqWPFlag1Y;
  txinqwemailfinstatusrejcnt       := (Integer)le.threatmetrix.TxinqWEmailFinStatusRejCnt;
  txinqwemailfinstatusrejcnt1m     := (Integer)le.threatmetrix.TxinqWEmailFinStatusRejCnt1M;
  txinqwphonefinstatusrejcnt       := (Integer)le.threatmetrix.TxinqWPhoneFinStatusRejCnt;
  txinqwphonefinstatusrejcnt1m     := (Integer)le.threatmetrix.TxinqWPhoneFinStatusRejCnt1M;
  ruletmxidfraudbyuserflag1m       := (Integer)le.threatmetrix.RuleTmxidFraudByUserFlag1M;
  ruletmxidfraudbyuserflag3m       := (Integer)le.threatmetrix.RuleTmxidFraudByUserFlag3M;
  ruletmxidfraudbyuserflag6m       := (Integer)le.threatmetrix.RuleTmxidFraudByUserFlag6M;
  ruletmxidfraudbyuserflag1y       := (Integer)le.threatmetrix.RuleTmxidFraudByUserFlag1Y;
  _smartidperemailintxinqcnt        := (Integer)le.threatmetrix.SmartidPerEmailInTxinqCnt;
  _smartidperemailintxinqcnt1y      := (Integer)le.threatmetrix.SmartidPerEmailInTxinqCnt1Y;
  _smartidperemailintxinqcnt3m      := (Integer)le.threatmetrix.SmartidPerEmailInTxinqCnt3M;
  _smartidperemailintxinqcnt1m      := (Integer)le.threatmetrix.SmartidPerEmailInTxinqCnt1M;
  _smartidperphoneintxinqcnt1y      := (Integer)le.threatmetrix.SmartidPerPhoneInTxinqCnt1Y;
  _smartidperphoneintxinqcnt1m      := (Integer)le.threatmetrix.SmartidPerPhoneInTxinqCnt1M;
  _exactidperemailintxinqcnt        := (Integer)le.threatmetrix.ExactidPerEmailInTxinqCnt;
  _exactidperemailintxinqcnt6m      := (Integer)le.threatmetrix.ExactidPerEmailInTxinqCnt6M;
  _exactidperemailintxinqcnt3m      := (Integer)le.threatmetrix.ExactidPerEmailInTxinqCnt3M;
  _exactidperemailintxinqcnt1m      := (Integer)le.threatmetrix.ExactidPerEmailInTxinqCnt1M;
  _exactidperphoneintxinqcnt3m      := (Integer)le.threatmetrix.ExactidPerPhoneInTxinqCnt3M;
  _emailperphoneintxinqcnt          := (Integer)le.threatmetrix.EmailPerPhoneInTxinqCnt;
  _emailperphoneintxinqcnt1y        := (Integer)le.threatmetrix.EmailPerPhoneInTxinqCnt1Y;
  _emailperphoneintxinqcnt3m        := (Integer)le.threatmetrix.EmailPerPhoneInTxinqCnt3M;
  _emailperphoneintxinqcnt6m        := (Integer)le.threatmetrix.EmailPerPhoneInTxinqCnt6M;
  _phoneperemailintxinqcnt1y        := (Integer)le.threatmetrix.PhonePerEmailInTxinqCnt1Y;
  _phoneperemailintxinqcnt1m        := (Integer)le.threatmetrix.PhonePerEmailInTxinqCnt1M;
  _phoneperemailintxinqcnt3m        := (Integer)le.threatmetrix.PhonePerEmailInTxinqCnt3M;
  _tmxidperemailintxinqcnt          := (Integer)le.threatmetrix.TmxidPerEmailInTxinqCnt;
  _tmxidperemailintxinqcnt1y        := (Integer)le.threatmetrix.TmxidPerEmailInTxinqCnt1Y;
  _tmxidperemailintxinqcnt1m        := (Integer)le.threatmetrix.TmxidPerEmailInTxinqCnt1M;
  _tmxidperphoneintxinqcnt1y        := (Integer)le.threatmetrix.TmxidPerPhoneInTxinqCnt1Y;
  _tmxidperphoneintxinqcnt3m        := (Integer)le.threatmetrix.TmxidPerPhoneInTxinqCnt3M;
  _orgidperemailintxinqcnt          := (Integer)le.threatmetrix.OrgidPerEmailInTxinqCnt;
  _trueipperemailintxinqcnt         := (Integer)le.threatmetrix.TrueipPerEmailInTxinqCnt;
  _trueipperphoneintxinqcnt         := (Integer)le.threatmetrix.TrueipPerPhoneInTxinqCnt;
  _dnsipperemailintxinqcnt          := (Integer)le.threatmetrix.DnsipPerEmailInTxinqCnt;
  _proxyipperemailintxinqcnt        := (Integer)le.threatmetrix.ProxyipPerEmailInTxinqCnt;
  _proxyipgperemailintxinqcnt       := (Integer)le.threatmetrix.ProxyipgPerEmailInTxinqCnt;
  _browserhashperemailintxinqcnt    := (Integer)le.threatmetrix.BrowserHashPerEmailInTxinqCnt;
  _browserhashperphoneintxinqcnt    := (Integer)le.threatmetrix.BrowserHashPerPhoneInTxinqCnt;
  _loginidperphoneintxinqcnt        := (Integer)le.threatmetrix.LoginidPerPhoneInTxinqCnt;
  _txinqcorremailwphonecnt          := (Integer)le.threatmetrix.TxinqCorrEmailWPhoneCnt;
  _txinqcorremailwphonecnt1y        := (Integer)le.threatmetrix.TxinqCorrEmailWPhoneCnt1Y;
  _txinqcorremailwphonecnt3m        := (Integer)le.threatmetrix.TxinqCorrEmailWPhoneCnt3M;
  _txinqcorremailwphonecnt1m        := (Integer)le.threatmetrix.TxinqCorrEmailWPhoneCnt1M;
  _txinqwemailcnt6m                 := (Integer)le.threatmetrix.TxinqWEmailCnt6M;
  _txinqwphonecnt1y                 := (Integer)le.threatmetrix.TxinqWPhoneCnt1Y;
  _txinqcorremailwaddresscnt        := (Integer)le.threatmetrix.TxinqCorrEmailWAddressCnt;
  _txinqcorremailwaddresscnt6m      := (Integer)le.threatmetrix.TxinqCorrEmailWAddressCnt6M;
  _txinqcorremailwnamecnt1y         := (Integer)le.threatmetrix.TxinqCorrEmailWNameCnt1Y;
  _distbtwtrueipwemailavg           := (Real)le.threatmetrix.DistBtwTrueipWEmailAvg;
  _distbtwtrueipwphoneavg           := (Real)le.threatmetrix.DistBtwTrueipWPhoneAvg;
  _timebtwtxinqwemailavg            := (Real)le.threatmetrix.TimeBtwTxinqWEmailAvg;
  _timebtwtxinqwphoneavg            := (Real)le.threatmetrix.TimeBtwTxinqWPhoneAvg;
  _trueippertmxidintxinqcnt1m       := (Integer)le.threatmetrix.TrueipPerTmxidInTxinqCnt1M;
  _exactidpertmxidintxinqcnt        := (Integer)le.threatmetrix.ExactidPerTmxidInTxinqCnt;


	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
   
NULL := -999999999;

today := Models.common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

TMX_Inf := (string8)Std.Date.Today();

processing_yr := (trim((string)TMX_Inf, LEFT))[1..4];

processing_mo := (trim((string)TMX_Inf, LEFT))[5..6];

processing_dy := (trim((string)TMX_Inf, LEFT))[7..8];

processing_mdy := (ut.DaysSince1900(processing_yr, processing_mo, processing_dy) - ut.DaysSince1900('1960', '1', '1'));

txinqwaddrfirst_mdy_c1_b2 := (ut.DaysSince1900((trim((string)TxinqWAddrFirst, LEFT))[1..4], (trim((string)TxinqWAddrFirst, LEFT))[5..6], (trim((string)TxinqWAddrFirst, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwaddrfirst_dayssince_1 := if((trim(trim((string)TxinqWAddrFirst, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(processing_mdy - txinqwaddrfirst_mdy_c1_b2, 0));

txinqwaddrlast_mdy_c2_b2 := (ut.DaysSince1900((trim((string)TxinqWAddrLast, LEFT))[1..4], (trim((string)TxinqWAddrLast, LEFT))[5..6], (trim((string)TxinqWAddrLast, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwaddrlast_dayssince_1 := if((trim(trim((string)TxinqWAddrLast, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(processing_mdy - txinqwaddrlast_mdy_c2_b2, 0));

txinqwemailfirst_mdy_c3_b2 := (ut.DaysSince1900((trim((string)TxinqWEmailFirst, LEFT))[1..4], (trim((string)TxinqWEmailFirst, LEFT))[5..6], (trim((string)TxinqWEmailFirst, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwemailfirst_dayssince_1 := if((trim(trim((string)TxinqWEmailFirst, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(processing_mdy - txinqwemailfirst_mdy_c3_b2, 0));

txinqwemaillast_mdy_c4_b2 := (ut.DaysSince1900((trim((string)TxinqWEmailLast, LEFT))[1..4], (trim((string)TxinqWEmailLast, LEFT))[5..6], (trim((string)TxinqWEmailLast, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwemaillast_dayssince_1 := if((trim(trim((string)TxinqWEmailLast, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(processing_mdy - txinqwemaillast_mdy_c4_b2, 0));

txinqwnamefirst_mdy_c5_b2 := (ut.DaysSince1900((trim((string)TxinqWNameFirst, LEFT))[1..4], (trim((string)TxinqWNameFirst, LEFT))[5..6], (trim((string)TxinqWNameFirst, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwnamefirst_dayssince_1 := if((trim(trim((string)TxinqWNameFirst, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(processing_mdy - txinqwnamefirst_mdy_c5_b2, 0));

txinqwnamelast_mdy_c6_b2 := (ut.DaysSince1900((trim((string)TxinqWNameLast, LEFT))[1..4], (trim((string)TxinqWNameLast, LEFT))[5..6], (trim((string)TxinqWNameLast, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwnamelast_dayssince_1 := if((trim(trim((string)TxinqWNameLast, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(processing_mdy - txinqwnamelast_mdy_c6_b2, 0));

txinqwphonefirst_mdy_c7_b2 := (ut.DaysSince1900((trim((string)TxinqWPhoneFirst, LEFT))[1..4], (trim((string)TxinqWPhoneFirst, LEFT))[5..6], (trim((string)TxinqWPhoneFirst, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwphonefirst_dayssince_1 := if((trim(trim((string)TxinqWPhoneFirst, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(processing_mdy - txinqwphonefirst_mdy_c7_b2, 0));

txinqwphonelast_mdy_c8_b2 := (ut.DaysSince1900((trim((string)TxinqWPhoneLast, LEFT))[1..4], (trim((string)TxinqWPhoneLast, LEFT))[5..6], (trim((string)TxinqWPhoneLast, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwphonelast_dayssince_1 := if((trim(trim((string)TxinqWPhoneLast, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(processing_mdy - txinqwphonelast_mdy_c8_b2, 0));

txinqwtmxidfirst_mdy_c9_b2 := (ut.DaysSince1900((trim((string)TxinqWTmxidFirst, LEFT))[1..4], (trim((string)TxinqWTmxidFirst, LEFT))[5..6], (trim((string)TxinqWTmxidFirst, LEFT))[7..8]) - ut.DaysSince1900('1960', '1', '1'));

txinqwtmxidfirst_dayssince_1 := if((trim(trim((string)TxinqWTmxidFirst, LEFT), LEFT, RIGHT) in ['-99999', '-99998', '-99997']), NULL, max(processing_mdy - txinqwtmxidfirst_mdy_c9_b2, 0));

blacklist_sum2 := (integer)(RuleEmailBlistFlag > 0) +
    (integer)(RuleEmailBlistByBankFlag > 0) +
    (integer)(RuleEmailBlistByFinTechFlag > 0) +
    (integer)(RuleEmailBlistByEcommFlag > 0) +
    (integer)(RuleExactidBlistInTxinqWEFlag1M > 0) +
    (integer)(RuleExactidBlistInTxinqWEFlag > 0) +
    (integer)(RuleSmartidBlistInTxinqWEFlag1M > 0) +
    (integer)(RuleSmartidBlistInTxinqWEFlag > 0) +
    (integer)(RuleExactidBlistInTxinqWPFlag1M > 0) +
    (integer)(RuleExactidBlistInTxinqWPFlag1Y > 0) +
    (integer)(RuleSmartidBlistInTxinqWPFlag1M > 0) +
    (integer)(RuleSmartidBlistInTxinqWPFlag1Y > 0);

any_blacklist := blacklist_sum2 > 0;

finstatus_reject_sum := (integer)(TxinqWEmailFinStatusRejCnt > 0) +
    (integer)(TxinqWEmailFinStatusRejCnt1M > 0) +
    (integer)(TxinqWPhoneFinStatusRejCnt > 0) +
    (integer)(TxinqWPhoneFinStatusRejCnt1M > 0);

any_finstatus_reject := finstatus_reject_sum > 0;

fraudbyuser_sum := (integer)(RuleTmxidFraudByUserFlag1M > 0) +
    (integer)(RuleTmxidFraudByUserFlag3M > 0) +
    (integer)(RuleTmxidFraudByUserFlag6M > 0) +
    (integer)(RuleTmxidFraudByUserFlag1Y > 0);

any_fraudbyuser := fraudbyuser_sum > 0;

smartidperemailintxinqcnt := if((_SmartidPerEmailInTxinqCnt in [-99997, -99998, -99999]), NULL, _SmartidPerEmailInTxinqCnt);

smartidperemailintxinqcnt1y := if((_SmartidPerEmailInTxinqCnt1Y in [-99997, -99998, -99999]), NULL, _SmartidPerEmailInTxinqCnt1Y);

smartidperemailintxinqcnt3m := if((_SmartidPerEmailInTxinqCnt3M in [-99997, -99998, -99999]), NULL, _SmartidPerEmailInTxinqCnt3M);

smartidperemailintxinqcnt1m := if((_SmartidPerEmailInTxinqCnt1M in [-99997, -99998, -99999]), NULL, _SmartidPerEmailInTxinqCnt1M);

smartidperphoneintxinqcnt1y := if((_SmartidPerPhoneInTxinqCnt1Y in [-99997, -99998, -99999]), NULL, _SmartidPerPhoneInTxinqCnt1Y);

smartidperphoneintxinqcnt1m := if((_SmartidPerPhoneInTxinqCnt1M in [-99997, -99998, -99999]), NULL, _SmartidPerPhoneInTxinqCnt1M);

exactidperemailintxinqcnt := if((_ExactidPerEmailInTxinqCnt in [-99997, -99998, -99999]), NULL, _ExactidPerEmailInTxinqCnt);

exactidperemailintxinqcnt6m := if((_ExactidPerEmailInTxinqCnt6M in [-99997, -99998, -99999]), NULL, _ExactidPerEmailInTxinqCnt6M);

exactidperemailintxinqcnt3m := if((_ExactidPerEmailInTxinqCnt3M in [-99997, -99998, -99999]), NULL, _ExactidPerEmailInTxinqCnt3M);

exactidperemailintxinqcnt1m := if((_ExactidPerEmailInTxinqCnt1M in [-99997, -99998, -99999]), NULL, _ExactidPerEmailInTxinqCnt1M);

exactidperphoneintxinqcnt3m := if((_ExactidPerPhoneInTxinqCnt3M in [-99997, -99998, -99999]), NULL, _ExactidPerPhoneInTxinqCnt3M);

emailperphoneintxinqcnt := if((_EmailPerPhoneInTxinqCnt in [-99997, -99998, -99999]), NULL, _EmailPerPhoneInTxinqCnt);

emailperphoneintxinqcnt1y := if((_EmailPerPhoneInTxinqCnt1Y in [-99997, -99998, -99999]), NULL, _EmailPerPhoneInTxinqCnt1Y);

emailperphoneintxinqcnt3m := if((_EmailPerPhoneInTxinqCnt3M in [-99997, -99998, -99999]), NULL, _EmailPerPhoneInTxinqCnt3M);

emailperphoneintxinqcnt6m := if((_EmailPerPhoneInTxinqCnt6M in [-99997, -99998, -99999]), NULL, _EmailPerPhoneInTxinqCnt6M);

phoneperemailintxinqcnt1y := if((_PhonePerEmailInTxinqCnt1Y in [-99997, -99998, -99999]), NULL, _PhonePerEmailInTxinqCnt1Y);

phoneperemailintxinqcnt1m := if((_PhonePerEmailInTxinqCnt1M in [-99997, -99998, -99999]), NULL, _PhonePerEmailInTxinqCnt1M);

phoneperemailintxinqcnt3m := if((_PhonePerEmailInTxinqCnt3M in [-99997, -99998, -99999]), NULL, _PhonePerEmailInTxinqCnt3M);

tmxidperemailintxinqcnt := if((_TmxidPerEmailInTxinqCnt in [-99997, -99998, -99999]), NULL, _TmxidPerEmailInTxinqCnt);

tmxidperemailintxinqcnt1y := if((_TmxidPerEmailInTxinqCnt1Y in [-99997, -99998, -99999]), NULL, _TmxidPerEmailInTxinqCnt1Y);

tmxidperemailintxinqcnt1m := if((_TmxidPerEmailInTxinqCnt1M in [-99997, -99998, -99999]), NULL, _TmxidPerEmailInTxinqCnt1M);

tmxidperphoneintxinqcnt1y := if((_TmxidPerPhoneInTxinqCnt1Y in [-99997, -99998, -99999]), NULL, _TmxidPerPhoneInTxinqCnt1Y);

tmxidperphoneintxinqcnt3m := if((_TmxidPerPhoneInTxinqCnt3M in [-99997, -99998, -99999]), NULL, _TmxidPerPhoneInTxinqCnt3M);

orgidperemailintxinqcnt := if((_OrgidPerEmailInTxinqCnt in [-99997, -99998, -99999]), NULL, _OrgidPerEmailInTxinqCnt);

trueipperemailintxinqcnt := if((_TrueipPerEmailInTxinqCnt in [-99997, -99998, -99999]), NULL, _TrueipPerEmailInTxinqCnt);

trueipperphoneintxinqcnt := if((_TrueipPerPhoneInTxinqCnt in [-99997, -99998, -99999]), NULL, _TrueipPerPhoneInTxinqCnt);

dnsipperemailintxinqcnt := if((_DnsipPerEmailInTxinqCnt in [-99997, -99998, -99999]), NULL, _DnsipPerEmailInTxinqCnt);

proxyipperemailintxinqcnt := if((_ProxyipPerEmailInTxinqCnt in [-99997, -99998, -99999]), NULL, _ProxyipPerEmailInTxinqCnt);

proxyipgperemailintxinqcnt := if((_ProxyipgPerEmailInTxinqCnt in [-99997, -99998, -99999]), NULL, _ProxyipgPerEmailInTxinqCnt);

browserhashperemailintxinqcnt := if((_BrowserHashPerEmailInTxinqCnt in [-99997, -99998, -99999]), NULL, _BrowserHashPerEmailInTxinqCnt);

browserhashperphoneintxinqcnt := if((_BrowserHashPerPhoneInTxinqCnt in [-99997, -99998, -99999]), NULL, _BrowserHashPerPhoneInTxinqCnt);

loginidperphoneintxinqcnt := if((_LoginidPerPhoneInTxinqCnt in [-99997, -99998, -99999]), NULL, _LoginidPerPhoneInTxinqCnt);

txinqcorremailwphonecnt := if((_TxinqCorrEmailWPhoneCnt in [-99997, -99998, -99999]), NULL, _TxinqCorrEmailWPhoneCnt);

txinqcorremailwphonecnt1y := if((_TxinqCorrEmailWPhoneCnt1Y in [-99997, -99998, -99999]), NULL, _TxinqCorrEmailWPhoneCnt1Y);

txinqcorremailwphonecnt3m := if((_TxinqCorrEmailWPhoneCnt3M in [-99997, -99998, -99999]), NULL, _TxinqCorrEmailWPhoneCnt3M);

txinqcorremailwphonecnt1m := if((_TxinqCorrEmailWPhoneCnt1M in [-99997, -99998, -99999]), NULL, _TxinqCorrEmailWPhoneCnt1M);

txinqwemailcnt6m := if((_TxinqWEmailCnt6M in [-99997, -99998, -99999]), NULL, _TxinqWEmailCnt6M);

txinqwphonecnt1y := if((_TxinqWPhoneCnt1Y in [-99997, -99998, -99999]), NULL, _TxinqWPhoneCnt1Y);

txinqcorremailwaddresscnt := if((_TxinqCorrEmailWAddressCnt in [-99997, -99998, -99999]), NULL, _TxinqCorrEmailWAddressCnt);

txinqcorremailwaddresscnt6m := if((_TxinqCorrEmailWAddressCnt6M in [-99997, -99998, -99999]), NULL, _TxinqCorrEmailWAddressCnt6M);

txinqcorremailwnamecnt1y := if((_TxinqCorrEmailWNameCnt1Y in [-99997, -99998, -99999]), NULL, _TxinqCorrEmailWNameCnt1Y);

distbtwtrueipwemailavg := if((_DistBtwTrueipWEmailAvg in [-99997, -99998, -99999]), NULL, _DistBtwTrueipWEmailAvg);

distbtwtrueipwphoneavg := if((_DistBtwTrueipWPhoneAvg in [-99997, -99998, -99999]), NULL, _DistBtwTrueipWPhoneAvg);

timebtwtxinqwemailavg := if((_TimeBtwTxinqWEmailAvg in [-99997, -99998, -99999]), NULL, _TimeBtwTxinqWEmailAvg);

timebtwtxinqwphoneavg := if((_TimeBtwTxinqWPhoneAvg in [-99997, -99998, -99999]), NULL, _TimeBtwTxinqWPhoneAvg);

trueippertmxidintxinqcnt1m := if((_TrueipPerTmxidInTxinqCnt1M in [-99997, -99998, -99999]), NULL, _TrueipPerTmxidInTxinqCnt1M);

exactidpertmxidintxinqcnt := if((_ExactidPerTmxidInTxinqCnt in [-99997, -99998, -99999]), NULL, _ExactidPerTmxidInTxinqCnt);

txinqwaddrfirst_dayssince := if((txinqwaddrfirst_dayssince_1 in [-99997, -99998, -99999]), NULL, txinqwaddrfirst_dayssince_1);

txinqwaddrlast_dayssince := if((txinqwaddrlast_dayssince_1 in [-99997, -99998, -99999]), NULL, txinqwaddrlast_dayssince_1);

txinqwemailfirst_dayssince := if((txinqwemailfirst_dayssince_1 in [-99997, -99998, -99999]), NULL, txinqwemailfirst_dayssince_1);

txinqwemaillast_dayssince := if((txinqwemaillast_dayssince_1 in [-99997, -99998, -99999]), NULL, txinqwemaillast_dayssince_1);

txinqwnamefirst_dayssince := if((txinqwnamefirst_dayssince_1 in [-99997, -99998, -99999]), NULL, txinqwnamefirst_dayssince_1);

txinqwnamelast_dayssince := if((txinqwnamelast_dayssince_1 in [-99997, -99998, -99999]), NULL, txinqwnamelast_dayssince_1);

txinqwphonefirst_dayssince := if((txinqwphonefirst_dayssince_1 in [-99997, -99998, -99999]), NULL, txinqwphonefirst_dayssince_1);

txinqwphonelast_dayssince := if((txinqwphonelast_dayssince_1 in [-99997, -99998, -99999]), NULL, txinqwphonelast_dayssince_1);

txinqwtmxidfirst_dayssince := if((txinqwtmxidfirst_dayssince_1 in [-99997, -99998, -99999]), NULL, txinqwtmxidfirst_dayssince_1);

gbm10_wc_lgt_0 := -4.0642350099;

gbm10_wc_lgt_1_c68 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.7233857090,
    smartidperemailintxinqcnt1m > 8.5                                         => 5.0886196725,
    smartidperemailintxinqcnt1m = NULL                                        => 0.6125311563,
                                                                                 0.7964649856);

rc008_1_4_c68 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => -0.0730792766,
    smartidperemailintxinqcnt1m > 8.5                                         => 4.2921546869,
    smartidperemailintxinqcnt1m = NULL                                        => -0.1839338293,
                                                                                 0);

gbm10_wc_lgt_1_c67 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => -0.0417065355,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_1_c68,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0011293519,
                                                                                 0.0011293519);

rc003_1_2_c67 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => -0.0428358874,
    smartidperphoneintxinqcnt1m > 1.5                                         => 0.7953356337,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc008_1_4_c67 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc008_1_4_c68,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc004_1_9_c69 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => -0.9413708055,
    tmxidperphoneintxinqcnt3m > 5.5                                       => 3.4077341901,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_1_c69 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 2.4170856698,
    tmxidperphoneintxinqcnt3m > 5.5                                       => 6.7661906654,
    tmxidperphoneintxinqcnt3m = NULL                                      => 3.3584564753,
                                                                             3.3584564753);

gbm10_wc_lgt_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => gbm10_wc_lgt_1_c67,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_1_c69,
    emailperphoneintxinqcnt3m = NULL                                      => -0.1222427546,
                                                                             0.0000000000);

rc004_1_9 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc004_1_9_c69,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc003_1_2 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc003_1_2_c67,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc008_1_4 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc008_1_4_c67,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_1_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0011293519,
    emailperphoneintxinqcnt3m > 2.5                                       => 3.3584564753,
    emailperphoneintxinqcnt3m = NULL                                      => -0.1222427546,
                                                                             0);

rc002_2_4_c72 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 122.5 => 0.2897115227,
    txinqwemailfirst_dayssince > 122.5                                        => -0.0895160016,
    txinqwemailfirst_dayssince = NULL                                         => 0.0086337392,
                                                                                 0);

gbm10_wc_lgt_2_c72 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 122.5 => 0.4526550756,
    txinqwemailfirst_dayssince > 122.5                                        => 0.0734275513,
    txinqwemailfirst_dayssince = NULL                                         => 0.1715772921,
                                                                                 0.1629435529);

gbm10_wc_lgt_2_c71 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 0.5 => -0.0839981438,
    smartidperphoneintxinqcnt1m > 0.5                                         => gbm10_wc_lgt_2_c72,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0275373197,
                                                                                 -0.0275373197);

rc002_2_4_c71 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 0.5 => 0,
    smartidperphoneintxinqcnt1m > 0.5                                         => rc002_2_4_c72,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_2_2_c71 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 0.5 => -0.0564608240,
    smartidperphoneintxinqcnt1m > 0.5                                         => 0.1904808727,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc001_2_9_c73 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 1.7595468023,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.3639295512,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_2_c73 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.9058604573,
    emailperphoneintxinqcnt3m > 2.5                                       => -1.2176158963,
    emailperphoneintxinqcnt3m = NULL                                      => -0.8536863451,
                                                                             -0.8536863451);

gbm10_wc_lgt_2 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => gbm10_wc_lgt_2_c71,
    tmxidperphoneintxinqcnt3m > 5.5                                       => gbm10_wc_lgt_2_c73,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.1116463468,
                                                                             -0.0480676425);

rc004_2_1 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0205303227,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.8056187026,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0635787043,
                                                                             0);

rc002_2_4 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => rc002_2_4_c71,
    tmxidperphoneintxinqcnt3m > 5.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc003_2_2 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => rc003_2_2_c71,
    tmxidperphoneintxinqcnt3m > 5.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_2_9 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0,
    tmxidperphoneintxinqcnt3m > 5.5                                       => rc001_2_9_c73,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc010_3_2_c75 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 111.5 => 0.0103137112,
    txinqwphonecnt1y > 111.5                              => 1.8946895102,
    txinqwphonecnt1y = NULL                               => -0.0548499972,
                                                             0);

gbm10_wc_lgt_3_c75 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 111.5 => -0.0470905984,
    txinqwphonecnt1y > 111.5                              => 1.8372852006,
    txinqwphonecnt1y = NULL                               => -0.1122543068,
                                                             -0.0574043096);

rc019_3_8_c77 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 31.5 => -0.0124212358,
    smartidperemailintxinqcnt3m > 31.5                                         => 2.1538100269,
    smartidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_3_c77 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 31.5 => 0.1775810050,
    smartidperemailintxinqcnt3m > 31.5                                         => 2.3438122677,
    smartidperemailintxinqcnt3m = NULL                                         => 0.1900022408,
                                                                                  0.1900022408);

gbm10_wc_lgt_3_c76 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 8.5 => 1.1234505411,
    txinqwemailfirst_dayssince > 8.5                                        => gbm10_wc_lgt_3_c77,
    txinqwemailfirst_dayssince = NULL                                       => 0.2191158551,
                                                                               0.2191158551);

rc002_3_6_c76 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 8.5 => 0.9043346861,
    txinqwemailfirst_dayssince > 8.5                                        => -0.0291136143,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc019_3_8_c76 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 8.5 => 0,
    txinqwemailfirst_dayssince > 8.5                                        => rc019_3_8_c77,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc019_3_8 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 2.5 => 0,
    exactidperemailintxinqcnt1m > 2.5                                         => rc019_3_8_c76,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc002_3_6 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 2.5 => 0,
    exactidperemailintxinqcnt1m > 2.5                                         => rc002_3_6_c76,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_3 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 2.5 => gbm10_wc_lgt_3_c75,
    exactidperemailintxinqcnt1m > 2.5                                         => gbm10_wc_lgt_3_c76,
    exactidperemailintxinqcnt1m = NULL                                        => -0.1092277965,
                                                                                 -0.0444904263);

rc010_3_2 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 2.5 => rc010_3_2_c75,
    exactidperemailintxinqcnt1m > 2.5                                         => 0,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc009_3_1 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 2.5 => -0.0129138832,
    exactidperemailintxinqcnt1m > 2.5                                         => 0.2636062814,
    exactidperemailintxinqcnt1m = NULL                                        => -0.0647373702,
                                                                                 0);

rc034_4_4_c80 := map(
    NULL < dnsipperemailintxinqcnt AND dnsipperemailintxinqcnt <= 11.5 => 0.1672921636,
    dnsipperemailintxinqcnt > 11.5                                     => -0.1486373733,
    dnsipperemailintxinqcnt = NULL                                     => 0,
                                                                          0);

gbm10_wc_lgt_4_c80 := map(
    NULL < dnsipperemailintxinqcnt AND dnsipperemailintxinqcnt <= 11.5 => 0.5220863381,
    dnsipperemailintxinqcnt > 11.5                                     => 0.2061568012,
    dnsipperemailintxinqcnt = NULL                                     => 0.3547941745,
                                                                          0.3547941745);

rc034_4_4_c79 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 1.5 => 0,
    exactidperemailintxinqcnt1m > 1.5                                         => rc034_4_4_c80,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc009_4_2_c79 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 1.5 => -0.1305157666,
    exactidperemailintxinqcnt1m > 1.5                                         => 0.1843644800,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_4_c79 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 1.5 => 0.0399139280,
    exactidperemailintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_4_c80,
    exactidperemailintxinqcnt1m = NULL                                        => 0.1704296945,
                                                                                 0.1704296945);

rc004_4_9_c81 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0127211942,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.3616673984,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0563499303,
                                                                             0);

gbm10_wc_lgt_4_c81 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => -0.0304661600,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.4048547525,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0995372844,
                                                                             -0.0431873541);

rc004_4_9 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2234.665 => 0,
    timebtwtxinqwemailavg > 2234.665                                   => rc004_4_9_c81,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc009_4_2 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2234.665 => rc009_4_2_c79,
    timebtwtxinqwemailavg > 2234.665                                   => 0,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc034_4_4 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2234.665 => rc034_4_4_c79,
    timebtwtxinqwemailavg > 2234.665                                   => 0,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc006_4_1 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2234.665 => 0.2082975188,
    timebtwtxinqwemailavg > 2234.665                                   => -0.0053195298,
    timebtwtxinqwemailavg = NULL                                       => -0.0357292239,
                                                                          0);

gbm10_wc_lgt_4 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2234.665 => gbm10_wc_lgt_4_c79,
    timebtwtxinqwemailavg > 2234.665                                   => gbm10_wc_lgt_4_c81,
    timebtwtxinqwemailavg = NULL                                       => -0.0735970482,
                                                                          -0.0378678243);

gbm10_wc_lgt_5_c85 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 1.5 => 0.2364922472,
    loginidperphoneintxinqcnt > 1.5                                       => 0.9063103261,
    loginidperphoneintxinqcnt = NULL                                      => 0.3342932184,
                                                                             0.3342932184);

rc015_5_5_c85 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 1.5 => -0.0978009713,
    loginidperphoneintxinqcnt > 1.5                                       => 0.5720171076,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc005_5_4_c84 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 59.5 => 0.1937302714,
    txinqwphonefirst_dayssince > 59.5                                        => -0.0230077074,
    txinqwphonefirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_5_c84 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 59.5 => gbm10_wc_lgt_5_c85,
    txinqwphonefirst_dayssince > 59.5                                        => 0.1175552396,
    txinqwphonefirst_dayssince = NULL                                        => 0.1405629470,
                                                                                0.1405629470);

rc015_5_5_c84 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 59.5 => rc015_5_5_c85,
    txinqwphonefirst_dayssince > 59.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                        => 0,
                                                                                0);

rc014_5_2_c83 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 1.5 => -0.0136653108,
    emailperphoneintxinqcnt6m > 1.5                                       => 0.1641041791,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

rc005_5_4_c83 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 1.5 => 0,
    emailperphoneintxinqcnt6m > 1.5                                       => rc005_5_4_c84,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_5_c83 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 1.5 => -0.0372065429,
    emailperphoneintxinqcnt6m > 1.5                                       => gbm10_wc_lgt_5_c84,
    emailperphoneintxinqcnt6m = NULL                                      => -0.0235412321,
                                                                             -0.0235412321);

rc015_5_5_c83 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 1.5 => 0,
    emailperphoneintxinqcnt6m > 1.5                                       => rc015_5_5_c84,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

rc004_5_1 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0137956269,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.1909762576,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0459482706,
                                                                             0);

gbm10_wc_lgt_5 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => gbm10_wc_lgt_5_c83,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.2283131166,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0832851296,
                                                                             -0.0373368590);

rc015_5_5 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => rc015_5_5_c83,
    tmxidperphoneintxinqcnt3m > 5.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc014_5_2 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => rc014_5_2_c83,
    tmxidperphoneintxinqcnt3m > 5.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc005_5_4 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => rc005_5_4_c83,
    tmxidperphoneintxinqcnt3m > 5.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc012_6_3_c88 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 16209.34 => 0.1611050244,
    timebtwtxinqwphoneavg > 16209.34                                   => 0.0274808592,
    timebtwtxinqwphoneavg = NULL                                       => -0.0564636407,
                                                                          0);

gbm10_wc_lgt_6_c88 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 16209.34 => 0.1376203900,
    timebtwtxinqwphoneavg > 16209.34                                   => 0.0039962248,
    timebtwtxinqwphoneavg = NULL                                       => -0.0799482751,
                                                                          -0.0234846343);

rc012_6_3_c87 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 4.5 => rc012_6_3_c88,
    emailperphoneintxinqcnt3m > 4.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_6_c87 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 4.5 => gbm10_wc_lgt_6_c88,
    emailperphoneintxinqcnt3m > 4.5                                       => -0.1850163517,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0238292158,
                                                                             -0.0238292158);

rc001_6_2_c87 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 4.5 => 0.0003445815,
    emailperphoneintxinqcnt3m > 4.5                                       => -0.1611871359,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_6_c89 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 6.5 => 0.8864821511,
    smartidperphoneintxinqcnt1y > 6.5                                         => -0.2207975753,
    smartidperphoneintxinqcnt1y = NULL                                        => 0.5001315677,
                                                                                 0.5001315677);

rc028_6_9_c89 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 6.5 => 0.3863505833,
    smartidperphoneintxinqcnt1y > 6.5                                         => -0.7209291430,
    smartidperphoneintxinqcnt1y = NULL                                        => 0,
                                                                                 0);

rc001_6_2 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 102.5 => rc001_6_2_c87,
    txinqwphonecnt1y > 102.5                              => 0,
    txinqwphonecnt1y = NULL                               => 0,
                                                             0);

rc028_6_9 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 102.5 => 0,
    txinqwphonecnt1y > 102.5                              => rc028_6_9_c89,
    txinqwphonecnt1y = NULL                               => 0,
                                                             0);

rc010_6_1 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 102.5 => 0.0103804270,
    txinqwphonecnt1y > 102.5                              => 0.5343412105,
    txinqwphonecnt1y = NULL                               => -0.0387740731,
                                                             0);

rc012_6_3 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 102.5 => rc012_6_3_c87,
    txinqwphonecnt1y > 102.5                              => 0,
    txinqwphonecnt1y = NULL                               => 0,
                                                             0);

gbm10_wc_lgt_6 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 102.5 => gbm10_wc_lgt_6_c87,
    txinqwphonecnt1y > 102.5                              => gbm10_wc_lgt_6_c89,
    txinqwphonecnt1y = NULL                               => -0.0729837158,
                                                             -0.0342096428);

rc028_7_5_c93 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 11.5 => 0.0362533951,
    smartidperphoneintxinqcnt1y > 11.5                                         => -0.1979814554,
    smartidperphoneintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_7_c93 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 11.5 => -0.0444402724,
    smartidperphoneintxinqcnt1y > 11.5                                         => -0.2786751228,
    smartidperphoneintxinqcnt1y = NULL                                         => -0.0806936674,
                                                                                  -0.0806936674);

rc001_7_3_c92 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0066375276,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0645183174,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0295554536,
                                                                             0);

rc028_7_5_c92 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc028_7_5_c93,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_7_c92 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => -0.0095378224,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_7_c93,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0457308037,
                                                                             -0.0161753501);

rc009_7_2_c91 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 25.5 => -0.0003827426,
    exactidperemailintxinqcnt1m > 25.5                                         => 0.7747517127,
    exactidperemailintxinqcnt1m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_7_c91 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 25.5 => gbm10_wc_lgt_7_c92,
    exactidperemailintxinqcnt1m > 25.5                                         => 0.7589591052,
    exactidperemailintxinqcnt1m = NULL                                         => -0.0157926074,
                                                                                  -0.0157926074);

rc001_7_3_c91 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 25.5 => rc001_7_3_c92,
    exactidperemailintxinqcnt1m > 25.5                                         => 0,
    exactidperemailintxinqcnt1m = NULL                                         => 0,
                                                                                  0);

rc028_7_5_c91 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 25.5 => rc028_7_5_c92,
    exactidperemailintxinqcnt1m > 25.5                                         => 0,
    exactidperemailintxinqcnt1m = NULL                                         => 0,
                                                                                  0);

rc001_7_3 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 2.5 => rc001_7_3_c91,
    phoneperemailintxinqcnt3m > 2.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc030_7_1 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 2.5 => 0.0058010605,
    phoneperemailintxinqcnt3m > 2.5                                       => 0.3103806926,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0588637070,
                                                                             0);

rc028_7_5 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 2.5 => rc028_7_5_c91,
    phoneperemailintxinqcnt3m > 2.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc009_7_2 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 2.5 => rc009_7_2_c91,
    phoneperemailintxinqcnt3m > 2.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_7 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 2.5 => gbm10_wc_lgt_7_c91,
    phoneperemailintxinqcnt3m > 2.5                                       => 0.2887870246,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0804573750,
                                                                             -0.0215936680);

gbm10_wc_lgt_8_c95 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => -0.0990138724,
    exactidperemailintxinqcnt1m > 0.5                                         => 0.2115876648,
    exactidperemailintxinqcnt1m = NULL                                        => 0.0905758054,
                                                                                 0.0905758054);

rc009_8_2_c95 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => -0.1895896777,
    exactidperemailintxinqcnt1m > 0.5                                         => 0.1210118595,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc020_8_6_c96 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 6.5 => -0.0013577582,
    phoneperemailintxinqcnt1y > 6.5                                       => 0.9913942540,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_8_c96 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 6.5 => -0.0342990806,
    phoneperemailintxinqcnt1y > 6.5                                       => 0.9584529316,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0329413224,
                                                                             -0.0329413224);

rc003_8_10_c97 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 0.5 => -0.0339775797,
    smartidperphoneintxinqcnt1m > 0.5                                         => 0.2333248623,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0186563946,
                                                                                 0);

gbm10_wc_lgt_8_c97 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 0.5 => -0.1192796301,
    smartidperphoneintxinqcnt1m > 0.5                                         => 0.1480228119,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.1039584450,
                                                                                 -0.0853020504);

rc003_8_10 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2196.795 => 0,
    timebtwtxinqwemailavg > 2196.795                                   => 0,
    timebtwtxinqwemailavg = NULL                                       => rc003_8_10_c97,
                                                                          0);

rc006_8_1 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2196.795 => 0.1318955276,
    timebtwtxinqwemailavg > 2196.795                                   => 0.0083783998,
    timebtwtxinqwemailavg = NULL                                       => -0.0439823281,
                                                                          0);

rc020_8_6 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2196.795 => 0,
    timebtwtxinqwemailavg > 2196.795                                   => rc020_8_6_c96,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

gbm10_wc_lgt_8 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2196.795 => gbm10_wc_lgt_8_c95,
    timebtwtxinqwemailavg > 2196.795                                   => gbm10_wc_lgt_8_c96,
    timebtwtxinqwemailavg = NULL                                       => gbm10_wc_lgt_8_c97,
                                                                          -0.0413197222);

rc009_8_2 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 2196.795 => rc009_8_2_c95,
    timebtwtxinqwemailavg > 2196.795                                   => 0,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc019_9_2_c99 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 25.5 => -0.0003117027,
    smartidperemailintxinqcnt3m > 25.5                                         => 0.5002881035,
    smartidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_9_c99 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 25.5 => -0.0319314509,
    smartidperemailintxinqcnt3m > 25.5                                         => 0.4686683553,
    smartidperemailintxinqcnt3m = NULL                                         => -0.0316197482,
                                                                                  -0.0316197482);

gbm10_wc_lgt_9_c101 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => 0.7668648678,
    txinqcorremailwphonecnt3m > 0.5                                       => 0.0996429196,
    txinqcorremailwphonecnt3m = NULL                                      => 1.4809340517,
                                                                             0.3606405266);

rc027_9_7_c101 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => 0.4062243412,
    txinqcorremailwphonecnt3m > 0.5                                       => -0.2609976069,
    txinqcorremailwphonecnt3m = NULL                                      => 1.1202935252,
                                                                             0);

rc002_9_6_c100 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 316.5 => 0.2310965663,
    txinqwemailfirst_dayssince > 316.5                                        => -0.0640639278,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_9_c100 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 316.5 => gbm10_wc_lgt_9_c101,
    txinqwemailfirst_dayssince > 316.5                                        => 0.0654800325,
    txinqwemailfirst_dayssince = NULL                                         => 0.1295439603,
                                                                                 0.1295439603);

rc027_9_7_c100 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 316.5 => rc027_9_7_c101,
    txinqwemailfirst_dayssince > 316.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc030_9_1 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => -0.0071724763,
    phoneperemailintxinqcnt3m > 1.5                                       => 0.1539912322,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0388376649,
                                                                             0);

rc027_9_7 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => 0,
    phoneperemailintxinqcnt3m > 1.5                                       => rc027_9_7_c100,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc002_9_6 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => 0,
    phoneperemailintxinqcnt3m > 1.5                                       => rc002_9_6_c100,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc019_9_2 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => rc019_9_2_c99,
    phoneperemailintxinqcnt3m > 1.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_9 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => gbm10_wc_lgt_9_c99,
    phoneperemailintxinqcnt3m > 1.5                                       => gbm10_wc_lgt_9_c100,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0632849368,
                                                                             -0.0244472719);

rc014_10_2_c103 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 1.5 => -0.0140361989,
    emailperphoneintxinqcnt6m > 1.5                                       => 0.1873307838,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_10_c103 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 1.5 => -0.0231223480,
    emailperphoneintxinqcnt6m > 1.5                                       => 0.1782446346,
    emailperphoneintxinqcnt6m = NULL                                      => -0.0090861492,
                                                                             -0.0090861492);

gbm10_wc_lgt_10_c105 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 57.965 => -0.2122607976,
    distbtwtrueipwemailavg > 57.965                                    => 0.0925502555,
    distbtwtrueipwemailavg = NULL                                      => 0.2225522209,
                                                                          0.0314798496);

rc011_10_8_c105 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 57.965 => -0.2437406473,
    distbtwtrueipwemailavg > 57.965                                    => 0.0610704059,
    distbtwtrueipwemailavg = NULL                                      => 0.1910723713,
                                                                          0);

gbm10_wc_lgt_10_c104 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 573.5 => -0.1372101280,
    txinqwnamefirst_dayssince > 573.5                                       => gbm10_wc_lgt_10_c105,
    txinqwnamefirst_dayssince = NULL                                        => 0.0122961743,
                                                                               -0.0726452602);

rc011_10_8_c104 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 573.5 => 0,
    txinqwnamefirst_dayssince > 573.5                                       => rc011_10_8_c105,
    txinqwnamefirst_dayssince = NULL                                        => 0,
                                                                               0);

rc013_10_6_c104 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 573.5 => -0.0645648678,
    txinqwnamefirst_dayssince > 573.5                                       => 0.1041251098,
    txinqwnamefirst_dayssince = NULL                                        => 0.0849414345,
                                                                               0);

gbm10_wc_lgt_10 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => gbm10_wc_lgt_10_c103,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_10_c104,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0487942496,
                                                                             -0.0184762158);

rc014_10_2 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc014_10_2_c103,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_10_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0093900666,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0541690444,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0303180338,
                                                                             0);

rc011_10_8 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc011_10_8_c104,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc013_10_6 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc013_10_6_c104,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_11_c108 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 20.5 => 0.0490045955,
    exactidpertmxidintxinqcnt > 20.5                                       => 0.6777067160,
    exactidpertmxidintxinqcnt = NULL                                       => -0.0128651464,
                                                                              -0.0056101824);

rc037_11_3_c108 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 20.5 => 0.0546147779,
    exactidpertmxidintxinqcnt > 20.5                                       => 0.6833168984,
    exactidpertmxidintxinqcnt = NULL                                       => -0.0072549640,
                                                                              0);

rc012_11_7_c109 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 857.155 => 0.1745700707,
    timebtwtxinqwphoneavg > 857.155                                   => -0.0897135252,
    timebtwtxinqwphoneavg = NULL                                      => 0,
                                                                         0);

gbm10_wc_lgt_11_c109 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 857.155 => 0.3869784794,
    timebtwtxinqwphoneavg > 857.155                                   => 0.1226948835,
    timebtwtxinqwphoneavg = NULL                                      => 0.2124084087,
                                                                         0.2124084087);

gbm10_wc_lgt_11_c107 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 91.5 => gbm10_wc_lgt_11_c108,
    txinqwphonecnt1y > 91.5                              => gbm10_wc_lgt_11_c109,
    txinqwphonecnt1y = NULL                              => -0.0052257808,
                                                            -0.0052257808);

rc012_11_7_c107 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 91.5 => 0,
    txinqwphonecnt1y > 91.5                              => rc012_11_7_c109,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc010_11_2_c107 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 91.5 => -0.0003844016,
    txinqwphonecnt1y > 91.5                              => 0.2176341895,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc037_11_3_c107 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 91.5 => rc037_11_3_c108,
    txinqwphonecnt1y > 91.5                              => 0,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

gbm10_wc_lgt_11 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => gbm10_wc_lgt_11_c107,
    exactidperphoneintxinqcnt3m > 8.5                                         => -0.2154344680,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0411630620,
                                                                                 -0.0136599061);

rc021_11_1 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => 0.0084341253,
    exactidperphoneintxinqcnt3m > 8.5                                         => -0.2017745619,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0275031559,
                                                                                 0);

rc012_11_7 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => rc012_11_7_c107,
    exactidperphoneintxinqcnt3m > 8.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc010_11_2 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => rc010_11_2_c107,
    exactidperphoneintxinqcnt3m > 8.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc037_11_3 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => rc037_11_3_c107,
    exactidperphoneintxinqcnt3m > 8.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_12_c113 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 618 => -0.1160568975,
    txinqwnamefirst_dayssince > 618                                       => 0.2152080745,
    txinqwnamefirst_dayssince = NULL                                      => -0.0252518180,
                                                                             -0.0252518180);

rc013_12_7_c113 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 618 => -0.0908050796,
    txinqwnamefirst_dayssince > 618                                       => 0.2404598924,
    txinqwnamefirst_dayssince = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_12_c112 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1227.345 => -0.1080776974,
    distbtwtrueipwemailavg > 1227.345                                    => 0.1929822503,
    distbtwtrueipwemailavg = NULL                                        => gbm10_wc_lgt_12_c113,
                                                                            -0.0752537327);

rc011_12_4_c112 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1227.345 => -0.0328239647,
    distbtwtrueipwemailavg > 1227.345                                    => 0.2682359829,
    distbtwtrueipwemailavg = NULL                                        => 0.0500019147,
                                                                            0);

rc013_12_7_c112 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1227.345 => 0,
    distbtwtrueipwemailavg > 1227.345                                    => 0,
    distbtwtrueipwemailavg = NULL                                        => rc013_12_7_c113,
                                                                            0);

rc001_12_2_c111 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0019905421,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0666503816,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0064196390,
                                                                             0);

gbm10_wc_lgt_12_c111 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => -0.0066128089,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_12_c112,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0150229900,
                                                                             -0.0086033510);

rc011_12_4_c111 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc011_12_4_c112,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc013_12_7_c111 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc013_12_7_c112,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc013_12_7 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => rc013_12_7_c111,
    txinqwemailcnt6m > 100.5                              => 0,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

rc011_12_4 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => rc011_12_4_c111,
    txinqwemailcnt6m > 100.5                              => 0,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

gbm10_wc_lgt_12 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => gbm10_wc_lgt_12_c111,
    txinqwemailcnt6m > 100.5                              => 0.2310513058,
    txinqwemailcnt6m = NULL                               => -0.0474710933,
                                                             -0.0099997824);

rc001_12_2 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => rc001_12_2_c111,
    txinqwemailcnt6m > 100.5                              => 0,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

rc018_12_1 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => 0.0013964313,
    txinqwemailcnt6m > 100.5                              => 0.2410510882,
    txinqwemailcnt6m = NULL                               => -0.0374713109,
                                                             0);

rc009_13_3_c116 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => -0.0543335921,
    exactidperemailintxinqcnt1m > 0.5                                         => 0.0795010190,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_13_c116 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => -0.0737659772,
    exactidperemailintxinqcnt1m > 0.5                                         => 0.0600686338,
    exactidperemailintxinqcnt1m = NULL                                        => -0.0194323852,
                                                                                 -0.0194323852);

rc020_13_2_c115 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 7.5 => -0.0003302679,
    phoneperemailintxinqcnt1y > 7.5                                       => 0.6433195178,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc009_13_3_c115 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 7.5 => rc009_13_3_c116,
    phoneperemailintxinqcnt1y > 7.5                                       => 0,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_13_c115 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 7.5 => gbm10_wc_lgt_13_c116,
    phoneperemailintxinqcnt1y > 7.5                                       => 0.6242174006,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0191021172,
                                                                             -0.0191021172);

rc003_13_9_c117 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.3213294233,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.4513998479,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0100981236,
                                                                                 0);

gbm10_wc_lgt_13_c117 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.2063986371,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.5663306341,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.1048326626,
                                                                                 -0.1149307862);

rc008_13_1 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0034372049,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.0923914641,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0173925618,
                                                                                 0);

rc003_13_9 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc003_13_9_c117,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_13 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => gbm10_wc_lgt_13_c115,
    smartidperemailintxinqcnt1m > 8.5                                         => gbm10_wc_lgt_13_c117,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0399318839,
                                                                                 -0.0225393221);

rc009_13_3 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => rc009_13_3_c115,
    smartidperemailintxinqcnt1m > 8.5                                         => 0,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc020_13_2 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => rc020_13_2_c115,
    smartidperemailintxinqcnt1m > 8.5                                         => 0,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_14_c120 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0714708520,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.2524427453,
    smartidperemailintxinqcnt1m = NULL                                        => 0.2747609168,
                                                                                 0.0889551699);

rc008_14_3_c120 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => -0.0174843179,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.3413979152,
    smartidperemailintxinqcnt1m = NULL                                        => 0.1858057469,
                                                                                 0);

rc008_14_8_c121 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 3.5 => -0.0034107713,
    smartidperemailintxinqcnt1m > 3.5                                         => 0.4340142813,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0541483859,
                                                                                 0);

gbm10_wc_lgt_14_c121 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 3.5 => -0.0724965012,
    smartidperemailintxinqcnt1m > 3.5                                         => 0.3649285514,
    smartidperemailintxinqcnt1m = NULL                                        => -0.1232341158,
                                                                                 -0.0690857299);

rc008_14_8_c119 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 26492.875 => 0,
    timebtwtxinqwphoneavg > 26492.875                                   => 0,
    timebtwtxinqwphoneavg = NULL                                        => rc008_14_8_c121,
                                                                           0);

gbm10_wc_lgt_14_c119 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 26492.875 => gbm10_wc_lgt_14_c120,
    timebtwtxinqwphoneavg > 26492.875                                   => -0.0031719483,
    timebtwtxinqwphoneavg = NULL                                        => gbm10_wc_lgt_14_c121,
                                                                           -0.0228638216);

rc012_14_2_c119 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 26492.875 => 0.1118189915,
    timebtwtxinqwphoneavg > 26492.875                                   => 0.0196918733,
    timebtwtxinqwphoneavg = NULL                                        => -0.0462219083,
                                                                           0);

rc008_14_3_c119 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 26492.875 => rc008_14_3_c120,
    timebtwtxinqwphoneavg > 26492.875                                   => 0,
    timebtwtxinqwphoneavg = NULL                                        => 0,
                                                                           0);

rc008_14_3 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 13.5 => rc008_14_3_c119,
    emailperphoneintxinqcnt1y > 13.5                                       => 0,
    emailperphoneintxinqcnt1y = NULL                                       => 0,
                                                                              0);

rc012_14_2 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 13.5 => rc012_14_2_c119,
    emailperphoneintxinqcnt1y > 13.5                                       => 0,
    emailperphoneintxinqcnt1y = NULL                                       => 0,
                                                                              0);

rc045_14_1 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 13.5 => 0.0011184374,
    emailperphoneintxinqcnt1y > 13.5                                       => -0.2411117807,
    emailperphoneintxinqcnt1y = NULL                                       => -0.0033019073,
                                                                              0);

gbm10_wc_lgt_14 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 13.5 => gbm10_wc_lgt_14_c119,
    emailperphoneintxinqcnt1y > 13.5                                       => -0.2650940397,
    emailperphoneintxinqcnt1y = NULL                                       => -0.0272841663,
                                                                              -0.0239822590);

rc008_14_8 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 13.5 => rc008_14_8_c119,
    emailperphoneintxinqcnt1y > 13.5                                       => 0,
    emailperphoneintxinqcnt1y = NULL                                       => 0,
                                                                              0);

rc015_15_7_c125 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => -0.3233162729,
    loginidperphoneintxinqcnt > 2.5                                       => 0.1355580113,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_15_c125 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => -0.6293335154,
    loginidperphoneintxinqcnt > 2.5                                       => -0.1704592312,
    loginidperphoneintxinqcnt = NULL                                      => -0.3060172426,
                                                                             -0.3060172426);

rc017_15_5_c124 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 8.5 => 0.1480557241,
    trueipperphoneintxinqcnt > 8.5                                      => -0.1361738996,
    trueipperphoneintxinqcnt = NULL                                     => 0,
                                                                           0);

rc015_15_7_c124 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 8.5 => 0,
    trueipperphoneintxinqcnt > 8.5                                      => rc015_15_7_c125,
    trueipperphoneintxinqcnt = NULL                                     => 0,
                                                                           0);

gbm10_wc_lgt_15_c124 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 8.5 => -0.0217876189,
    trueipperphoneintxinqcnt > 8.5                                      => gbm10_wc_lgt_15_c125,
    trueipperphoneintxinqcnt = NULL                                     => -0.1698433430,
                                                                           -0.1698433430);

rc017_15_5_c123 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0,
    distbtwtrueipwphoneavg > 15.47                                    => rc017_15_5_c124,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

rc007_15_3_c123 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0.2055067591,
    distbtwtrueipwphoneavg > 15.47                                    => -0.0849957528,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

rc015_15_7_c123 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0,
    distbtwtrueipwphoneavg > 15.47                                    => rc015_15_7_c124,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

gbm10_wc_lgt_15_c123 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0.1206591689,
    distbtwtrueipwphoneavg > 15.47                                    => gbm10_wc_lgt_15_c124,
    distbtwtrueipwphoneavg = NULL                                     => -0.0848475902,
                                                                         -0.0848475902);

rc007_15_3 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0,
    tmxidperphoneintxinqcnt3m > 5.5                                       => rc007_15_3_c123,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc004_15_1 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0053512181,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.0801294535,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0177672716,
                                                                             0);

rc015_15_7 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0,
    tmxidperphoneintxinqcnt3m > 5.5                                       => rc015_15_7_c123,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_15 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0006330814,
    tmxidperphoneintxinqcnt3m > 5.5                                       => gbm10_wc_lgt_15_c123,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0224854083,
                                                                             -0.0047181367);

rc017_15_5 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0,
    tmxidperphoneintxinqcnt3m > 5.5                                       => rc017_15_5_c123,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_16_c129 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3982.525 => -0.1456540426,
    timebtwtxinqwemailavg > 3982.525                                   => 0.4015826597,
    timebtwtxinqwemailavg = NULL                                       => 0.1065999599,
                                                                          0.1065999599);

rc006_16_7_c129 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3982.525 => -0.2522540025,
    timebtwtxinqwemailavg > 3982.525                                   => 0.2949826998,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc005_16_6_c128 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 706.5 => -0.1057301167,
    txinqwphonefirst_dayssince > 706.5                                        => 0.2701965476,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc006_16_7_c128 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 706.5 => rc006_16_7_c129,
    txinqwphonefirst_dayssince > 706.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_16_c128 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 706.5 => gbm10_wc_lgt_16_c129,
    txinqwphonefirst_dayssince > 706.5                                        => 0.4825266241,
    txinqwphonefirst_dayssince = NULL                                         => 0.2123300765,
                                                                                 0.2123300765);

rc010_16_4_c127 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 88.5 => 0.0021579274,
    txinqwphonecnt1y > 88.5                              => 0.2250337564,
    txinqwphonecnt1y = NULL                              => -0.0080374905,
                                                            0);

rc005_16_6_c127 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 88.5 => 0,
    txinqwphonecnt1y > 88.5                              => rc005_16_6_c128,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

gbm10_wc_lgt_16_c127 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 88.5 => -0.0105457525,
    txinqwphonecnt1y > 88.5                              => gbm10_wc_lgt_16_c128,
    txinqwphonecnt1y = NULL                              => -0.0207411704,
                                                            -0.0127036798);

rc006_16_7_c127 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 88.5 => 0,
    txinqwphonecnt1y > 88.5                              => rc006_16_7_c128,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc006_16_7 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0,
    exactidpertmxidintxinqcnt > 17.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                       => rc006_16_7_c127,
                                                                              0);

gbm10_wc_lgt_16 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0.0262685097,
    exactidpertmxidintxinqcnt > 17.5                                       => 0.3637593792,
    exactidpertmxidintxinqcnt = NULL                                       => gbm10_wc_lgt_16_c127,
                                                                              -0.0090021212);

rc005_16_6 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0,
    exactidpertmxidintxinqcnt > 17.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                       => rc005_16_6_c127,
                                                                              0);

rc010_16_4 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0,
    exactidpertmxidintxinqcnt > 17.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                       => rc010_16_4_c127,
                                                                              0);

rc037_16_1 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0.0352706309,
    exactidpertmxidintxinqcnt > 17.5                                       => 0.3727615005,
    exactidpertmxidintxinqcnt = NULL                                       => -0.0037015586,
                                                                              0);

rc024_17_4_c132 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 3.5 => -0.0054539818,
    tmxidperemailintxinqcnt1m > 3.5                                       => 0.5615572778,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_17_c132 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 3.5 => 0.1449814594,
    tmxidperemailintxinqcnt1m > 3.5                                       => 0.7119927189,
    tmxidperemailintxinqcnt1m = NULL                                      => 0.1504354411,
                                                                             0.1504354411);

gbm10_wc_lgt_17_c133 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => -0.0024388193,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.2022798251,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0038782751,
                                                                                 -0.0038782751);

rc008_17_8_c133 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0014394558,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.1984015500,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc008_17_8_c131 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => 0,
    txinqcorremailwphonecnt3m > 0.5                                       => rc008_17_8_c133,
    txinqcorremailwphonecnt3m = NULL                                      => 0,
                                                                             0);

rc027_17_3_c131 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => 0.1051606710,
    txinqcorremailwphonecnt3m > 0.5                                       => -0.0491530452,
    txinqcorremailwphonecnt3m = NULL                                      => 0.0709646368,
                                                                             0);

rc024_17_4_c131 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => rc024_17_4_c132,
    txinqcorremailwphonecnt3m > 0.5                                       => 0,
    txinqcorremailwphonecnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_17_c131 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => gbm10_wc_lgt_17_c132,
    txinqcorremailwphonecnt3m > 0.5                                       => gbm10_wc_lgt_17_c133,
    txinqcorremailwphonecnt3m = NULL                                      => 0.1162394069,
                                                                             0.0452747701);

rc004_17_1 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 0.5 => -0.0447561017,
    tmxidperphoneintxinqcnt3m > 0.5                                       => 0.0648299081,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0.0048617265,
                                                                             0);

rc008_17_8 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 0.5 => 0,
    tmxidperphoneintxinqcnt3m > 0.5                                       => rc008_17_8_c131,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_17 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 0.5 => -0.0643112397,
    tmxidperphoneintxinqcnt3m > 0.5                                       => gbm10_wc_lgt_17_c131,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0146934115,
                                                                             -0.0195551380);

rc027_17_3 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 0.5 => 0,
    tmxidperphoneintxinqcnt3m > 0.5                                       => rc027_17_3_c131,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc024_17_4 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 0.5 => 0,
    tmxidperphoneintxinqcnt3m > 0.5                                       => rc024_17_4_c131,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc021_18_4_c136 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 1.5 => -0.8853842730,
    exactidperphoneintxinqcnt3m > 1.5                                         => 0.7034544793,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_18_c136 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 1.5 => -0.0074890442,
    exactidperphoneintxinqcnt3m > 1.5                                         => 1.5813497081,
    exactidperphoneintxinqcnt3m = NULL                                        => 0.8778952288,
                                                                                 0.8778952288);

rc021_18_4_c135 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 3.5 => 0,
    emailperphoneintxinqcnt6m > 3.5                                       => rc021_18_4_c136,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

rc014_18_2_c135 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 3.5 => -0.0011039450,
    emailperphoneintxinqcnt6m > 3.5                                       => 0.8756085954,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_18_c135 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 3.5 => 0.0011826883,
    emailperphoneintxinqcnt6m > 3.5                                       => gbm10_wc_lgt_18_c136,
    emailperphoneintxinqcnt6m = NULL                                      => 0.0022866333,
                                                                             0.0022866333);

gbm10_wc_lgt_18_c137 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 573.5 => -0.1055244328,
    txinqwnamefirst_dayssince > 573.5                                       => 0.0208184845,
    txinqwnamefirst_dayssince = NULL                                        => 0.0166125721,
                                                                               -0.0551522698);

rc013_18_9_c137 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 573.5 => -0.0503721630,
    txinqwnamefirst_dayssince > 573.5                                       => 0.0759707543,
    txinqwnamefirst_dayssince = NULL                                        => 0.0717648419,
                                                                               0);

rc021_18_4 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc021_18_4_c135,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_18_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0036388193,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0538000838,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0105924627,
                                                                             0);

rc014_18_2 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc014_18_2_c135,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_18 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => gbm10_wc_lgt_18_c135,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_18_c137,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0119446487,
                                                                             -0.0013521860);

rc013_18_9 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc013_18_9_c137,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_19_c141 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 963 => 0.0265397564,
    txinqwemailfirst_dayssince > 963                                        => 1.1508100428,
    txinqwemailfirst_dayssince = NULL                                       => 0.7830068417,
                                                                               0.7830068417);

rc002_19_7_c141 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 963 => -0.7564670852,
    txinqwemailfirst_dayssince > 963                                        => 0.3678032012,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc002_19_7_c140 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 442.005 => 0,
    distbtwtrueipwphoneavg > 442.005                                    => rc002_19_7_c141,
    distbtwtrueipwphoneavg = NULL                                       => 0,
                                                                           0);

gbm10_wc_lgt_19_c140 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 442.005 => 0.0314028418,
    distbtwtrueipwphoneavg > 442.005                                    => gbm10_wc_lgt_19_c141,
    distbtwtrueipwphoneavg = NULL                                       => 0.3381696893,
                                                                           0.3629018106);

rc007_19_5_c140 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 442.005 => -0.3314989688,
    distbtwtrueipwphoneavg > 442.005                                    => 0.4201050311,
    distbtwtrueipwphoneavg = NULL                                       => -0.0247321213,
                                                                           0);

rc007_19_5_c139 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 622.965 => 0,
    distbtwtrueipwemailavg > 622.965                                    => rc007_19_5_c140,
    distbtwtrueipwemailavg = NULL                                       => 0,
                                                                           0);

gbm10_wc_lgt_19_c139 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 622.965 => 0.0728137407,
    distbtwtrueipwemailavg > 622.965                                    => gbm10_wc_lgt_19_c140,
    distbtwtrueipwemailavg = NULL                                       => -0.1036898698,
                                                                           0.1103045370);

rc002_19_7_c139 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 622.965 => 0,
    distbtwtrueipwemailavg > 622.965                                    => rc002_19_7_c140,
    distbtwtrueipwemailavg = NULL                                       => 0,
                                                                           0);

rc011_19_3_c139 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 622.965 => -0.0374907963,
    distbtwtrueipwemailavg > 622.965                                    => 0.2525972736,
    distbtwtrueipwemailavg = NULL                                       => -0.2139944068,
                                                                           0);

rc018_19_1 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => 0.0019516354,
    txinqwemailcnt6m > 100.5                              => 0.1196823079,
    txinqwemailcnt6m = NULL                               => -0.0253969250,
                                                             0);

rc007_19_5 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => 0,
    txinqwemailcnt6m > 100.5                              => rc007_19_5_c139,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

gbm10_wc_lgt_19 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => -0.0074261354,
    txinqwemailcnt6m > 100.5                              => gbm10_wc_lgt_19_c139,
    txinqwemailcnt6m = NULL                               => -0.0347746958,
                                                             -0.0093777708);

rc011_19_3 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => 0,
    txinqwemailcnt6m > 100.5                              => rc011_19_3_c139,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

rc002_19_7 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 100.5 => 0,
    txinqwemailcnt6m > 100.5                              => rc002_19_7_c139,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

gbm10_wc_lgt_20_c145 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 13.5 => 1.1620988813,
    txinqwemaillast_dayssince > 13.5                                       => 0.4382743771,
    txinqwemaillast_dayssince = NULL                                       => 0.6991155543,
                                                                              0.6991155543);

rc029_20_6_c145 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 13.5 => 0.4629833270,
    txinqwemaillast_dayssince > 13.5                                       => -0.2608411772,
    txinqwemaillast_dayssince = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_20_c144 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 7.5 => 0.0550763713,
    txinqwemaillast_dayssince > 7.5                                       => gbm10_wc_lgt_20_c145,
    txinqwemaillast_dayssince = NULL                                      => 0.3448019703,
                                                                             0.3448019703);

rc029_20_6_c144 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 7.5 => 0,
    txinqwemaillast_dayssince > 7.5                                       => rc029_20_6_c145,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

rc029_20_4_c144 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 7.5 => -0.2897255990,
    txinqwemaillast_dayssince > 7.5                                       => 0.3543135840,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_20_c143 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 316.5 => gbm10_wc_lgt_20_c144,
    txinqwemailfirst_dayssince > 316.5                                        => 0.0944487856,
    txinqwemailfirst_dayssince = NULL                                         => 0.1291252205,
                                                                                 0.1291252205);

rc002_20_3_c143 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 316.5 => 0.2156767498,
    txinqwemailfirst_dayssince > 316.5                                        => -0.0346764349,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc029_20_6_c143 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 316.5 => rc029_20_6_c144,
    txinqwemailfirst_dayssince > 316.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc029_20_4_c143 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 316.5 => rc029_20_4_c144,
    txinqwemailfirst_dayssince > 316.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc029_20_4 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => 0,
    phoneperemailintxinqcnt1y > 3.5                                       => rc029_20_4_c143,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc020_20_1 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => 0.0008616542,
    phoneperemailintxinqcnt1y > 3.5                                       => 0.1373933120,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0205823246,
                                                                             0);

rc002_20_3 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => 0,
    phoneperemailintxinqcnt1y > 3.5                                       => rc002_20_3_c143,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc029_20_6 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => 0,
    phoneperemailintxinqcnt1y > 3.5                                       => rc029_20_6_c143,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_20 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => -0.0074064373,
    phoneperemailintxinqcnt1y > 3.5                                       => gbm10_wc_lgt_20_c143,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0288504161,
                                                                             -0.0082680915);

gbm10_wc_lgt_21_c147 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 1060.525 => 0.0965998189,
    timebtwtxinqwemailavg > 1060.525                                   => -0.0144310748,
    timebtwtxinqwemailavg = NULL                                       => 0.0003282835,
                                                                          -0.0057055774);

rc006_21_2_c147 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 1060.525 => 0.1023053962,
    timebtwtxinqwemailavg > 1060.525                                   => -0.0087254975,
    timebtwtxinqwemailavg = NULL                                       => 0.0060338608,
                                                                          0);

gbm10_wc_lgt_21_c149 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 41.5 => 0.6342357640,
    txinqwemailfirst_dayssince > 41.5                                        => 0.3342717793,
    txinqwemailfirst_dayssince = NULL                                        => 0.3796484700,
                                                                                0.3796484700);

rc002_21_9_c149 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 41.5 => 0.2545872940,
    txinqwemailfirst_dayssince > 41.5                                        => -0.0453766906,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc024_21_7_c148 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 2.5 => 0.0224978585,
    tmxidperemailintxinqcnt1m > 2.5                                       => 0.4145831523,
    tmxidperemailintxinqcnt1m = NULL                                      => -0.0531933919,
                                                                             0);

gbm10_wc_lgt_21_c148 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 2.5 => -0.0124368238,
    tmxidperemailintxinqcnt1m > 2.5                                       => gbm10_wc_lgt_21_c149,
    tmxidperemailintxinqcnt1m = NULL                                      => -0.0881280741,
                                                                             -0.0349346823);

rc002_21_9_c148 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 2.5 => 0,
    tmxidperemailintxinqcnt1m > 2.5                                       => rc002_21_9_c149,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc024_21_7 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 12.5 => 0,
    emailperphoneintxinqcnt1y > 12.5                                       => 0,
    emailperphoneintxinqcnt1y = NULL                                       => rc024_21_7_c148,
                                                                              0);

rc045_21_1 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 12.5 => 0.0066601794,
    emailperphoneintxinqcnt1y > 12.5                                       => -0.1946131170,
    emailperphoneintxinqcnt1y = NULL                                       => -0.0225689256,
                                                                              0);

rc006_21_2 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 12.5 => rc006_21_2_c147,
    emailperphoneintxinqcnt1y > 12.5                                       => 0,
    emailperphoneintxinqcnt1y = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_21 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 12.5 => gbm10_wc_lgt_21_c147,
    emailperphoneintxinqcnt1y > 12.5                                       => -0.2069788737,
    emailperphoneintxinqcnt1y = NULL                                       => gbm10_wc_lgt_21_c148,
                                                                              -0.0123657567);

rc002_21_9 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 12.5 => 0,
    emailperphoneintxinqcnt1y > 12.5                                       => 0,
    emailperphoneintxinqcnt1y = NULL                                       => rc002_21_9_c148,
                                                                              0);

rc002_22_4_c152 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 36.5 => 0.1142893655,
    txinqwemailfirst_dayssince > 36.5                                        => -0.0133709895,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_22_c152 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 36.5 => 0.1455637199,
    txinqwemailfirst_dayssince > 36.5                                        => 0.0179033649,
    txinqwemailfirst_dayssince = NULL                                        => 0.0312743544,
                                                                                0.0312743544);

rc022_22_8_c153 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 19.5 => -0.0326042920,
    txinqwphonelast_dayssince > 19.5                                       => 0.1831054828,
    txinqwphonelast_dayssince = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_22_c153 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 19.5 => -0.1044514590,
    txinqwphonelast_dayssince > 19.5                                       => 0.1112583158,
    txinqwphonelast_dayssince = NULL                                       => -0.0718471670,
                                                                              -0.0718471670);

gbm10_wc_lgt_22_c151 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => gbm10_wc_lgt_22_c152,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_22_c153,
    emailperphoneintxinqcnt3m = NULL                                      => 0.1422931376,
                                                                             0.0452145965);

rc022_22_8_c151 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc022_22_8_c153,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc002_22_4_c151 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc002_22_4_c152,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_22_3_c151 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => -0.0139402421,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.1170617635,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0970785411,
                                                                             0);

rc022_22_8 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => 0,
    exactidperemailintxinqcnt1m > 0.5                                         => rc022_22_8_c151,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_22 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => -0.0563015879,
    exactidperemailintxinqcnt1m > 0.5                                         => gbm10_wc_lgt_22_c151,
    exactidperemailintxinqcnt1m = NULL                                        => -0.0179549245,
                                                                                 -0.0153559365);

rc001_22_3 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => 0,
    exactidperemailintxinqcnt1m > 0.5                                         => rc001_22_3_c151,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc009_22_1 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => -0.0409456514,
    exactidperemailintxinqcnt1m > 0.5                                         => 0.0605705330,
    exactidperemailintxinqcnt1m = NULL                                        => -0.0025989880,
                                                                                 0);

rc002_22_4 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => 0,
    exactidperemailintxinqcnt1m > 0.5                                         => rc002_22_4_c151,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc052_23_2_c155 := map(
    NULL < tmxidperemailintxinqcnt1y AND tmxidperemailintxinqcnt1y <= 16.5 => -0.0001569708,
    tmxidperemailintxinqcnt1y > 16.5                                       => 0.3724890496,
    tmxidperemailintxinqcnt1y = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_23_c155 := map(
    NULL < tmxidperemailintxinqcnt1y AND tmxidperemailintxinqcnt1y <= 16.5 => -0.0011526666,
    tmxidperemailintxinqcnt1y > 16.5                                       => 0.3714933538,
    tmxidperemailintxinqcnt1y = NULL                                       => -0.0009956958,
                                                                              -0.0009956958);

rc005_23_9_c157 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 53.5 => 0.3795003310,
    txinqwphonefirst_dayssince > 53.5                                        => -0.0609480227,
    txinqwphonefirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_23_c157 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 53.5 => 0.5518803892,
    txinqwphonefirst_dayssince > 53.5                                        => 0.1114320355,
    txinqwphonefirst_dayssince = NULL                                        => 0.1723800582,
                                                                                0.1723800582);

rc004_23_7_c156 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => -0.0060574985,
    tmxidperphoneintxinqcnt3m > 1.5                                       => 0.2345664517,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0133279650,
                                                                             0);

gbm10_wc_lgt_23_c156 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => -0.0682438920,
    tmxidperphoneintxinqcnt3m > 1.5                                       => gbm10_wc_lgt_23_c157,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0755143585,
                                                                             -0.0621863935);

rc005_23_9_c156 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => 0,
    tmxidperphoneintxinqcnt3m > 1.5                                       => rc005_23_9_c157,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_23 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2940.5 => gbm10_wc_lgt_23_c155,
    txinqwemailfirst_dayssince > 2940.5                                        => -0.3587093248,
    txinqwemailfirst_dayssince = NULL                                          => gbm10_wc_lgt_23_c156,
                                                                                  -0.0104812932);

rc005_23_9 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2940.5 => 0,
    txinqwemailfirst_dayssince > 2940.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                          => rc005_23_9_c156,
                                                                                  0);

rc052_23_2 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2940.5 => rc052_23_2_c155,
    txinqwemailfirst_dayssince > 2940.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                          => 0,
                                                                                  0);

rc004_23_7 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2940.5 => 0,
    txinqwemailfirst_dayssince > 2940.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                          => rc004_23_7_c156,
                                                                                  0);

rc002_23_1 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2940.5 => 0.0094855975,
    txinqwemailfirst_dayssince > 2940.5                                        => -0.3482280316,
    txinqwemailfirst_dayssince = NULL                                          => -0.0517051003,
                                                                                  0);

rc033_24_6_c161 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => -0.0207150742,
    emailperphoneintxinqcnt > 1.5                                     => 0.1227118737,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_24_c161 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0.0451946034,
    emailperphoneintxinqcnt > 1.5                                     => 0.1886215513,
    emailperphoneintxinqcnt = NULL                                    => 0.0659096776,
                                                                         0.0659096776);

rc002_24_4_c160 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 26.5 => 0.1745619785,
    txinqwemailfirst_dayssince > 26.5                                        => -0.0763227582,
    txinqwemailfirst_dayssince = NULL                                        => 0.3062403411,
                                                                                0);

rc033_24_6_c160 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 26.5 => 0,
    txinqwemailfirst_dayssince > 26.5                                        => rc033_24_6_c161,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_24_c160 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 26.5 => 0.3167944142,
    txinqwemailfirst_dayssince > 26.5                                        => gbm10_wc_lgt_24_c161,
    txinqwemailfirst_dayssince = NULL                                        => 0.4484727768,
                                                                                0.1422324357);

rc005_24_3_c159 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 113.5 => 0.1202575111,
    txinqwphonefirst_dayssince > 113.5                                        => -0.0131887043,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc002_24_4_c159 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 113.5 => rc002_24_4_c160,
    txinqwphonefirst_dayssince > 113.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc033_24_6_c159 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 113.5 => rc033_24_6_c160,
    txinqwphonefirst_dayssince > 113.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_24_c159 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 113.5 => gbm10_wc_lgt_24_c160,
    txinqwphonefirst_dayssince > 113.5                                        => 0.0087862203,
    txinqwphonefirst_dayssince = NULL                                         => 0.0219749246,
                                                                                 0.0219749246);

rc015_24_1 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => -0.0286821756,
    loginidperphoneintxinqcnt > 0.5                                       => 0.0373828712,
    loginidperphoneintxinqcnt = NULL                                      => 0.0074678491,
                                                                             0);

rc033_24_6 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => 0,
    loginidperphoneintxinqcnt > 0.5                                       => rc033_24_6_c159,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_24 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => -0.0440901222,
    loginidperphoneintxinqcnt > 0.5                                       => gbm10_wc_lgt_24_c159,
    loginidperphoneintxinqcnt = NULL                                      => -0.0079400976,
                                                                             -0.0154079466);

rc005_24_3 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => 0,
    loginidperphoneintxinqcnt > 0.5                                       => rc005_24_3_c159,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc002_24_4 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => 0,
    loginidperphoneintxinqcnt > 0.5                                       => rc002_24_4_c159,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_25_c165 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 34.5 => 0.0602214009,
    trueipperemailintxinqcnt > 34.5                                      => 0.3787059150,
    trueipperemailintxinqcnt = NULL                                      => 0.1128333387,
                                                                            0.1128333387);

rc036_25_5_c165 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 34.5 => -0.0526119378,
    trueipperemailintxinqcnt > 34.5                                      => 0.2658725763,
    trueipperemailintxinqcnt = NULL                                      => 0,
                                                                            0);

gbm10_wc_lgt_25_c164 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 29.5 => gbm10_wc_lgt_25_c165,
    txinqcorremailwphonecnt3m > 29.5                                       => -0.3182538952,
    txinqcorremailwphonecnt3m = NULL                                       => 0.2389496302,
                                                                              0.0928941439);

rc027_25_4_c164 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 29.5 => 0.0199391948,
    txinqcorremailwphonecnt3m > 29.5                                       => -0.4111480392,
    txinqcorremailwphonecnt3m = NULL                                       => 0.1460554863,
                                                                              0);

rc036_25_5_c164 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 29.5 => rc036_25_5_c165,
    txinqcorremailwphonecnt3m > 29.5                                       => 0,
    txinqcorremailwphonecnt3m = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_25_c163 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0028322543,
    smartidperphoneintxinqcnt1m > 3.5                                         => gbm10_wc_lgt_25_c164,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0022786799,
                                                                                 -0.0022786799);

rc003_25_2_c163 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0005535744,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.0951728239,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc027_25_4_c163 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc027_25_4_c164,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc036_25_5_c163 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc036_25_5_c164,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc027_25_4 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => rc027_25_4_c163,
    exactidperphoneintxinqcnt3m > 8.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc036_25_5 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => rc036_25_5_c163,
    exactidperphoneintxinqcnt3m > 8.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc003_25_2 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => rc003_25_2_c163,
    exactidperphoneintxinqcnt3m > 8.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc021_25_1 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => 0.0011620424,
    exactidperphoneintxinqcnt3m > 8.5                                         => -0.1273100834,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0029654432,
                                                                                 0);

gbm10_wc_lgt_25 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 8.5 => gbm10_wc_lgt_25_c163,
    exactidperphoneintxinqcnt3m > 8.5                                         => -0.1307508057,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0064061655,
                                                                                 -0.0034407223);

gbm10_wc_lgt_26_c167 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 6.5 => -0.0009271728,
    smartidperemailintxinqcnt1m > 6.5                                         => 0.2380023308,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0000849683,
                                                                                 -0.0000849683);

rc008_26_2_c167 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 6.5 => -0.0008422045,
    smartidperemailintxinqcnt1m > 6.5                                         => 0.2380872991,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_26_c169 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 71.5 => -0.0518857399,
    txinqwemailcnt6m > 71.5                              => -0.4644469566,
    txinqwemailcnt6m = NULL                              => -0.2694290902,
                                                            -0.2694290902);

rc018_26_8_c169 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 71.5 => 0.2175433503,
    txinqwemailcnt6m > 71.5                              => -0.1950178665,
    txinqwemailcnt6m = NULL                              => 0,
                                                            0);

gbm10_wc_lgt_26_c168 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.1186592445,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_26_c169,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.1532590936,
                                                                                 -0.0586109544);

rc018_26_8_c168 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc018_26_8_c169,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_26_6_c168 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.1772701990,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.2108181358,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0946481392,
                                                                                 0);

rc018_26_8 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc018_26_8_c168,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc008_26_2 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => rc008_26_2_c167,
    smartidperemailintxinqcnt1m > 8.5                                         => 0,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc008_26_1 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0029095745,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.0556164116,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0150971738,
                                                                                 0);

rc003_26_6 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc003_26_6_c168,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_26 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => gbm10_wc_lgt_26_c167,
    smartidperemailintxinqcnt1m > 8.5                                         => gbm10_wc_lgt_26_c168,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0180917166,
                                                                                 -0.0029945428);

gbm10_wc_lgt_27_c173 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 6.14 => 0.9301176313,
    distbtwtrueipwphoneavg > 6.14                                    => -0.0529685970,
    distbtwtrueipwphoneavg = NULL                                    => 0.1203560213,
                                                                        0.1203560213);

rc007_27_5_c173 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 6.14 => 0.8097616099,
    distbtwtrueipwphoneavg > 6.14                                    => -0.1733246183,
    distbtwtrueipwphoneavg = NULL                                    => 0,
                                                                        0);

gbm10_wc_lgt_27_c172 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 19.5 => gbm10_wc_lgt_27_c173,
    txinqwnamelast_dayssince > 19.5                                      => 0.8959998086,
    txinqwnamelast_dayssince = NULL                                      => 0.0467743412,
                                                                            0.2910761889);

rc026_27_4_c172 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 19.5 => -0.1707201675,
    txinqwnamelast_dayssince > 19.5                                      => 0.6049236197,
    txinqwnamelast_dayssince = NULL                                      => -0.2443018476,
                                                                            0);

rc007_27_5_c172 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 19.5 => rc007_27_5_c173,
    txinqwnamelast_dayssince > 19.5                                      => 0,
    txinqwnamelast_dayssince = NULL                                      => 0,
                                                                            0);

rc007_27_5_c171 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => 0,
    emailperphoneintxinqcnt6m > 2.5                                       => rc007_27_5_c172,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

rc026_27_4_c171 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => 0,
    emailperphoneintxinqcnt6m > 2.5                                       => rc026_27_4_c172,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_27_c171 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => -0.0013908433,
    emailperphoneintxinqcnt6m > 2.5                                       => gbm10_wc_lgt_27_c172,
    emailperphoneintxinqcnt6m = NULL                                      => 0.0005588639,
                                                                             0.0005588639);

rc014_27_2_c171 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => -0.0019497072,
    emailperphoneintxinqcnt6m > 2.5                                       => 0.2905173250,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

rc014_27_2 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc014_27_2_c171,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_27_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0013825117,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0428501231,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0032346244,
                                                                             0);

gbm10_wc_lgt_27 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => gbm10_wc_lgt_27_c171,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0436737709,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0040582722,
                                                                             -0.0008236479);

rc026_27_4 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc026_27_4_c171,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc007_27_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc007_27_5_c171,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_28_c175 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 4.5 => 0.0075673597,
    loginidperphoneintxinqcnt > 4.5                                       => 0.4853925961,
    loginidperphoneintxinqcnt = NULL                                      => 0.2657537192,
                                                                             0.0146776364);

rc015_28_2_c175 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 4.5 => -0.0071102767,
    loginidperphoneintxinqcnt > 4.5                                       => 0.4707149597,
    loginidperphoneintxinqcnt = NULL                                      => 0.2510760828,
                                                                             0);

rc016_28_6_c176 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 481 => -0.2460068229,
    txinqwaddrfirst_dayssince > 481                                       => 0.3934650172,
    txinqwaddrfirst_dayssince = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_28_c176 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 481 => 0.0139741430,
    txinqwaddrfirst_dayssince > 481                                       => 0.6534459831,
    txinqwaddrfirst_dayssince = NULL                                      => 0.2599809659,
                                                                             0.2599809659);

rc001_28_10_c177 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0015147476,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0441590925,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0033158614,
                                                                             0);

gbm10_wc_lgt_28_c177 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => -0.0008002957,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0464741358,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0056309047,
                                                                             -0.0023150433);

rc015_28_2 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => rc015_28_2_c175,
    exactidpertmxidintxinqcnt > 17.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                       => 0,
                                                                              0);

rc016_28_6 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0,
    exactidpertmxidintxinqcnt > 17.5                                       => rc016_28_6_c176,
    exactidpertmxidintxinqcnt = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_28 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => gbm10_wc_lgt_28_c175,
    exactidpertmxidintxinqcnt > 17.5                                       => gbm10_wc_lgt_28_c176,
    exactidpertmxidintxinqcnt = NULL                                       => gbm10_wc_lgt_28_c177,
                                                                              -0.0006041129);

rc037_28_1 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0.0152817493,
    exactidpertmxidintxinqcnt > 17.5                                       => 0.2605850788,
    exactidpertmxidintxinqcnt = NULL                                       => -0.0017109304,
                                                                              0);

rc001_28_10 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0,
    exactidpertmxidintxinqcnt > 17.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                       => rc001_28_10_c177,
                                                                              0);

gbm10_wc_lgt_29_c180 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 696 => -0.1604551801,
    txinqwemailfirst_dayssince > 696                                        => 0.3630963614,
    txinqwemailfirst_dayssince = NULL                                       => 0.1329403455,
                                                                               0.1329403455);

rc002_29_4_c180 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 696 => -0.2933955255,
    txinqwemailfirst_dayssince > 696                                        => 0.2301560159,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc002_29_4_c179 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 39.5 => 0,
    trueipperphoneintxinqcnt > 39.5                                      => rc002_29_4_c180,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

rc017_29_2_c179 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 39.5 => -0.0001615534,
    trueipperphoneintxinqcnt > 39.5                                      => 0.1299924404,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

gbm10_wc_lgt_29_c179 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 39.5 => 0.0027863517,
    trueipperphoneintxinqcnt > 39.5                                      => gbm10_wc_lgt_29_c180,
    trueipperphoneintxinqcnt = NULL                                      => 0.0029479051,
                                                                            0.0029479051);

rc020_29_10_c181 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 4.5 => 0.0197724593,
    phoneperemailintxinqcnt1y > 4.5                                       => 0.3974834160,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0383884131,
                                                                             0);

gbm10_wc_lgt_29_c181 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 4.5 => -0.0017725753,
    phoneperemailintxinqcnt1y > 4.5                                       => 0.3759383814,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0599334477,
                                                                             -0.0215450346);

rc020_29_10 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => 0,
    browserhashperphoneintxinqcnt > 15.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                           => rc020_29_10_c181,
                                                                                      0);

gbm10_wc_lgt_29 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => gbm10_wc_lgt_29_c179,
    browserhashperphoneintxinqcnt > 15.5                                           => -0.0962362958,
    browserhashperphoneintxinqcnt = NULL                                           => gbm10_wc_lgt_29_c181,
                                                                                      -0.0040263541);

rc038_29_1 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => 0.0069742592,
    browserhashperphoneintxinqcnt > 15.5                                           => -0.0922099417,
    browserhashperphoneintxinqcnt = NULL                                           => -0.0175186805,
                                                                                      0);

rc002_29_4 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => rc002_29_4_c179,
    browserhashperphoneintxinqcnt > 15.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc017_29_2 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => rc017_29_2_c179,
    browserhashperphoneintxinqcnt > 15.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

gbm10_wc_lgt_30_c185 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 7.5 => -0.0062207147,
    exactidperphoneintxinqcnt3m > 7.5                                         => -0.1645174050,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0066165899,
                                                                                 -0.0066165899);

rc021_30_4_c185 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 7.5 => 0.0003958752,
    exactidperphoneintxinqcnt3m > 7.5                                         => -0.1579008151,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_30_c184 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => gbm10_wc_lgt_30_c185,
    loginidperphoneintxinqcnt > 2.5                                       => 0.0850661593,
    loginidperphoneintxinqcnt = NULL                                      => 0.0127978504,
                                                                             -0.0008169822);

rc015_30_3_c184 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => -0.0057996078,
    loginidperphoneintxinqcnt > 2.5                                       => 0.0858831415,
    loginidperphoneintxinqcnt = NULL                                      => 0.0136148326,
                                                                             0);

rc021_30_4_c184 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => rc021_30_4_c185,
    loginidperphoneintxinqcnt > 2.5                                       => 0,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc021_30_4_c183 := map(
    NULL < tmxidperemailintxinqcnt1y AND tmxidperemailintxinqcnt1y <= 16.5 => rc021_30_4_c184,
    tmxidperemailintxinqcnt1y > 16.5                                       => 0,
    tmxidperemailintxinqcnt1y = NULL                                       => 0,
                                                                              0);

rc015_30_3_c183 := map(
    NULL < tmxidperemailintxinqcnt1y AND tmxidperemailintxinqcnt1y <= 16.5 => rc015_30_3_c184,
    tmxidperemailintxinqcnt1y > 16.5                                       => 0,
    tmxidperemailintxinqcnt1y = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_30_c183 := map(
    NULL < tmxidperemailintxinqcnt1y AND tmxidperemailintxinqcnt1y <= 16.5 => gbm10_wc_lgt_30_c184,
    tmxidperemailintxinqcnt1y > 16.5                                       => 0.2447202021,
    tmxidperemailintxinqcnt1y = NULL                                       => -0.0007217251,
                                                                              -0.0007217251);

rc052_30_2_c183 := map(
    NULL < tmxidperemailintxinqcnt1y AND tmxidperemailintxinqcnt1y <= 16.5 => -0.0000952570,
    tmxidperemailintxinqcnt1y > 16.5                                       => 0.2454419272,
    tmxidperemailintxinqcnt1y = NULL                                       => 0,
                                                                              0);

rc052_30_2 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => rc052_30_2_c183,
    txinqwemailfirst_dayssince > 2916                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_30 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => gbm10_wc_lgt_30_c183,
    txinqwemailfirst_dayssince > 2916                                        => -0.3369609459,
    txinqwemailfirst_dayssince = NULL                                        => -0.0099537737,
                                                                                -0.0022441379);

rc015_30_3 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => rc015_30_3_c183,
    txinqwemailfirst_dayssince > 2916                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc002_30_1 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => 0.0015224128,
    txinqwemailfirst_dayssince > 2916                                        => -0.3347168080,
    txinqwemailfirst_dayssince = NULL                                        => -0.0077096358,
                                                                                0);

rc021_30_4 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => rc021_30_4_c183,
    txinqwemailfirst_dayssince > 2916                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_31_c189 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 2025 => 0.0422572666,
    txinqwaddrfirst_dayssince > 2025                                       => 2.5254041171,
    txinqwaddrfirst_dayssince = NULL                                       => -0.0388139621,
                                                                              -0.0034465429);

rc016_31_6_c189 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 2025 => 0.0457038096,
    txinqwaddrfirst_dayssince > 2025                                       => 2.5288506600,
    txinqwaddrfirst_dayssince = NULL                                       => -0.0353674192,
                                                                              0);

rc020_31_5_c188 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 5.5 => -0.0010585603,
    phoneperemailintxinqcnt1y > 5.5                                       => 0.3971217508,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc016_31_6_c188 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 5.5 => rc016_31_6_c189,
    phoneperemailintxinqcnt1y > 5.5                                       => 0,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_31_c188 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 5.5 => gbm10_wc_lgt_31_c189,
    phoneperemailintxinqcnt1y > 5.5                                       => 0.3947337681,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0023879827,
                                                                             -0.0023879827);

gbm10_wc_lgt_31_c187 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 14.5 => 0.0009958421,
    emailperphoneintxinqcnt > 14.5                                     => -0.1971401165,
    emailperphoneintxinqcnt = NULL                                     => gbm10_wc_lgt_31_c188,
                                                                          0.0002596160);

rc016_31_6_c187 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 14.5 => 0,
    emailperphoneintxinqcnt > 14.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => rc016_31_6_c188,
                                                                          0);

rc020_31_5_c187 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 14.5 => 0,
    emailperphoneintxinqcnt > 14.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => rc020_31_5_c188,
                                                                          0);

rc033_31_2_c187 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 14.5 => 0.0007362261,
    emailperphoneintxinqcnt > 14.5                                     => -0.1973997325,
    emailperphoneintxinqcnt = NULL                                     => -0.0026475987,
                                                                          0);

rc033_31_2 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 7.5 => rc033_31_2_c187,
    tmxidperemailintxinqcnt1m > 7.5                                       => 0,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc020_31_5 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 7.5 => rc020_31_5_c187,
    tmxidperemailintxinqcnt1m > 7.5                                       => 0,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc016_31_6 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 7.5 => rc016_31_6_c187,
    tmxidperemailintxinqcnt1m > 7.5                                       => 0,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc024_31_1 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 7.5 => 0.0013682134,
    tmxidperemailintxinqcnt1m > 7.5                                       => -0.1612313199,
    tmxidperemailintxinqcnt1m = NULL                                      => -0.0069357375,
                                                                             0);

gbm10_wc_lgt_31 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 7.5 => gbm10_wc_lgt_31_c187,
    tmxidperemailintxinqcnt1m > 7.5                                       => -0.1623399173,
    tmxidperemailintxinqcnt1m = NULL                                      => -0.0080443349,
                                                                             -0.0011085974);

gbm10_wc_lgt_32_c193 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 184.5 => 0.2064895031,
    txinqwphonefirst_dayssince > 184.5                                        => 0.0835526365,
    txinqwphonefirst_dayssince = NULL                                         => 0.1006670373,
                                                                                 0.1006670373);

rc005_32_7_c193 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 184.5 => 0.1058224659,
    txinqwphonefirst_dayssince > 184.5                                        => -0.0171144008,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc023_32_6_c192 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0.0725003561,
    txinqcorremailwphonecnt > 0.5                                     => -0.0231150729,
    txinqcorremailwphonecnt = NULL                                    => 0.0280868862,
                                                                         0);

gbm10_wc_lgt_32_c192 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => gbm10_wc_lgt_32_c193,
    txinqcorremailwphonecnt > 0.5                                     => 0.0050516083,
    txinqcorremailwphonecnt = NULL                                    => 0.0562535674,
                                                                         0.0281666812);

rc005_32_7_c192 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => rc005_32_7_c193,
    txinqcorremailwphonecnt > 0.5                                     => 0,
    txinqcorremailwphonecnt = NULL                                    => 0,
                                                                         0);

rc037_32_3_c191 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0.0081759521,
    exactidpertmxidintxinqcnt > 17.5                                       => 0.3097484736,
    exactidpertmxidintxinqcnt = NULL                                       => -0.0021029554,
                                                                              0);

rc005_32_7_c191 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0,
    exactidpertmxidintxinqcnt > 17.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                       => rc005_32_7_c192,
                                                                              0);

gbm10_wc_lgt_32_c191 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0.0384455886,
    exactidpertmxidintxinqcnt > 17.5                                       => 0.3400181101,
    exactidpertmxidintxinqcnt = NULL                                       => gbm10_wc_lgt_32_c192,
                                                                              0.0302696366);

rc023_32_6_c191 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0,
    exactidpertmxidintxinqcnt > 17.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                       => rc023_32_6_c192,
                                                                              0);

rc023_32_6 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc023_32_6_c191,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc033_32_1 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => -0.0123741203,
    emailperphoneintxinqcnt > 1.5                                     => 0.0420226689,
    emailperphoneintxinqcnt = NULL                                    => 0.0040795538,
                                                                         0);

rc037_32_3 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc037_32_3_c191,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc005_32_7 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc005_32_7_c191,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_32 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => -0.0241271527,
    emailperphoneintxinqcnt > 1.5                                     => gbm10_wc_lgt_32_c191,
    emailperphoneintxinqcnt = NULL                                    => -0.0076734785,
                                                                         -0.0117530324);

gbm10_wc_lgt_33_c196 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 17.5 => -0.0978221668,
    txinqwphonelast_dayssince > 17.5                                       => 0.0671493153,
    txinqwphonelast_dayssince = NULL                                       => -0.0623106026,
                                                                              -0.0623106026);

rc022_33_4_c196 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 17.5 => -0.0355115642,
    txinqwphonelast_dayssince > 17.5                                       => 0.1294599178,
    txinqwphonelast_dayssince = NULL                                       => 0,
                                                                              0);

rc016_33_9_c197 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 424 => -0.1216779846,
    txinqwaddrfirst_dayssince > 424                                       => -0.0063150379,
    txinqwaddrfirst_dayssince = NULL                                      => 0.1585642912,
                                                                             0);

gbm10_wc_lgt_33_c197 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 424 => -0.1333378712,
    txinqwaddrfirst_dayssince > 424                                       => -0.0179749245,
    txinqwaddrfirst_dayssince = NULL                                      => 0.1469044047,
                                                                             -0.0116598866);

rc016_33_9_c195 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1227.345 => 0,
    distbtwtrueipwemailavg > 1227.345                                    => 0,
    distbtwtrueipwemailavg = NULL                                        => rc016_33_9_c197,
                                                                            0);

rc011_33_3_c195 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1227.345 => -0.0266090674,
    distbtwtrueipwemailavg > 1227.345                                    => 0.2362621665,
    distbtwtrueipwemailavg = NULL                                        => 0.0240416486,
                                                                            0);

rc022_33_4_c195 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1227.345 => rc022_33_4_c196,
    distbtwtrueipwemailavg > 1227.345                                    => 0,
    distbtwtrueipwemailavg = NULL                                        => 0,
                                                                            0);

gbm10_wc_lgt_33_c195 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1227.345 => gbm10_wc_lgt_33_c196,
    distbtwtrueipwemailavg > 1227.345                                    => 0.2005606313,
    distbtwtrueipwemailavg = NULL                                        => gbm10_wc_lgt_33_c197,
                                                                            -0.0357015352);

rc016_33_9 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc016_33_9_c195,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc022_33_4 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc022_33_4_c195,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc011_33_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc011_33_3_c195,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_33 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0037746241,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_33_c195,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0061885652,
                                                                             0.0012329291);

rc001_33_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0025416950,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0369344643,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0074214943,
                                                                             0);

gbm10_wc_lgt_34_c200 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 10.5 => -0.2313807101,
    txinqwemailfirst_dayssince > 10.5                                        => 0.0115408531,
    txinqwemailfirst_dayssince = NULL                                        => 0.0067786494,
                                                                                0.0067786494);

rc002_34_4_c200 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 10.5 => -0.2381593595,
    txinqwemailfirst_dayssince > 10.5                                        => 0.0047622038,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_34_c201 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 8.5 => 0.3356502712,
    txinqwemailfirst_dayssince > 8.5                                        => 0.1021331544,
    txinqwemailfirst_dayssince = NULL                                       => 0.1135320610,
                                                                               0.1135320610);

rc002_34_9_c201 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 8.5 => 0.2221182102,
    txinqwemailfirst_dayssince > 8.5                                        => -0.0113989066,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc007_34_3_c199 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 758.905 => -0.0486933200,
    distbtwtrueipwphoneavg > 758.905                                    => 0.1166524497,
    distbtwtrueipwphoneavg = NULL                                       => 0.0580600916,
                                                                           0);

gbm10_wc_lgt_34_c199 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 758.905 => gbm10_wc_lgt_34_c200,
    distbtwtrueipwphoneavg > 758.905                                    => 0.1721244191,
    distbtwtrueipwphoneavg = NULL                                       => gbm10_wc_lgt_34_c201,
                                                                           0.0554719694);

rc002_34_4_c199 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 758.905 => rc002_34_4_c200,
    distbtwtrueipwphoneavg > 758.905                                    => 0,
    distbtwtrueipwphoneavg = NULL                                       => 0,
                                                                           0);

rc002_34_9_c199 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 758.905 => 0,
    distbtwtrueipwphoneavg > 758.905                                    => 0,
    distbtwtrueipwphoneavg = NULL                                       => rc002_34_9_c201,
                                                                           0);

rc007_34_3 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => 0,
    phoneperemailintxinqcnt3m > 1.5                                       => rc007_34_3_c199,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc002_34_4 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => 0,
    phoneperemailintxinqcnt3m > 1.5                                       => rc002_34_4_c199,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc030_34_1 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => -0.0057873968,
    phoneperemailintxinqcnt3m > 1.5                                       => 0.0623208245,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0011921366,
                                                                             0);

rc002_34_9 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => 0,
    phoneperemailintxinqcnt3m > 1.5                                       => rc002_34_9_c199,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_34 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => -0.0126362518,
    phoneperemailintxinqcnt3m > 1.5                                       => gbm10_wc_lgt_34_c199,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0080409917,
                                                                             -0.0068488551);

gbm10_wc_lgt_35_c203 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 6.5 => -0.0010305602,
    smartidperemailintxinqcnt1m > 6.5                                         => 0.1500741091,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0004979302,
                                                                                 -0.0004979302);

rc008_35_2_c203 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 6.5 => -0.0005326300,
    smartidperemailintxinqcnt1m > 6.5                                         => 0.1505720393,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_35_c205 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.3731087098,
    smartidperphoneintxinqcnt1m > 3.5                                         => -0.0216512826,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.1857836395,
                                                                                 -0.1857836395);

rc003_35_8_c205 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.1873250703,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.1641323569,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_35_c204 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0998447561,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_35_c205,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.2087748390,
                                                                                 -0.0455345123);

rc003_35_8_c204 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc003_35_8_c205,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_35_6_c204 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.1453792684,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.1402491272,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.1632403267,
                                                                                 0);

rc008_35_1 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0010324885,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.0440040936,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0049551241,
                                                                                 0);

gbm10_wc_lgt_35 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => gbm10_wc_lgt_35_c203,
    smartidperemailintxinqcnt1m > 8.5                                         => gbm10_wc_lgt_35_c204,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0064855428,
                                                                                 -0.0015304187);

rc003_35_8 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc003_35_8_c204,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_35_6 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc003_35_6_c204,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc008_35_2 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => rc008_35_2_c203,
    smartidperemailintxinqcnt1m > 8.5                                         => 0,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_36_c209 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 1447.5 => 0.0207278868,
    txinqwemailfirst_dayssince > 1447.5                                        => 0.3380972224,
    txinqwemailfirst_dayssince = NULL                                          => 0.0448516066,
                                                                                  0.0448516066);

rc002_36_5_c209 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 1447.5 => -0.0241237197,
    txinqwemailfirst_dayssince > 1447.5                                        => 0.2932456158,
    txinqwemailfirst_dayssince = NULL                                          => 0,
                                                                                  0);

gbm10_wc_lgt_36_c208 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 70.5 => gbm10_wc_lgt_36_c209,
    trueipperemailintxinqcnt > 70.5                                      => 0.8680780124,
    trueipperemailintxinqcnt = NULL                                      => 0.0984845517,
                                                                            0.0984845517);

rc002_36_5_c208 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 70.5 => rc002_36_5_c209,
    trueipperemailintxinqcnt > 70.5                                      => 0,
    trueipperemailintxinqcnt = NULL                                      => 0,
                                                                            0);

rc036_36_4_c208 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 70.5 => -0.0536329452,
    trueipperemailintxinqcnt > 70.5                                      => 0.7695934607,
    trueipperemailintxinqcnt = NULL                                      => 0,
                                                                            0);

rc032_36_2_c207 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => -0.0018097577,
    txinqcorremailwphonecnt1m > 7.5                                       => 0.0961494661,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0104971927,
                                                                             0);

rc036_36_4_c207 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => 0,
    txinqcorremailwphonecnt1m > 7.5                                       => rc036_36_4_c208,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_36_c207 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => 0.0005253279,
    txinqcorremailwphonecnt1m > 7.5                                       => gbm10_wc_lgt_36_c208,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0128322783,
                                                                             0.0023350857);

rc002_36_5_c207 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => 0,
    txinqcorremailwphonecnt1m > 7.5                                       => rc002_36_5_c208,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc032_36_2 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => rc032_36_2_c207,
    browserhashperphoneintxinqcnt > 15.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc038_36_1 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => 0.0032748276,
    browserhashperphoneintxinqcnt > 15.5                                           => -0.0866144888,
    browserhashperphoneintxinqcnt = NULL                                           => -0.0053160826,
                                                                                      0);

rc036_36_4 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => rc036_36_4_c207,
    browserhashperphoneintxinqcnt > 15.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc002_36_5 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => rc002_36_5_c207,
    browserhashperphoneintxinqcnt > 15.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

gbm10_wc_lgt_36 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => gbm10_wc_lgt_36_c207,
    browserhashperphoneintxinqcnt > 15.5                                           => -0.0875542307,
    browserhashperphoneintxinqcnt = NULL                                           => -0.0062558245,
                                                                                      -0.0009397419);

gbm10_wc_lgt_37_c213 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 5.5 => 0.3445602071,
    txinqwemailfirst_dayssince > 5.5                                        => 0.1587826459,
    txinqwemailfirst_dayssince = NULL                                       => 0.1850838903,
                                                                               0.1850838903);

rc002_37_5_c213 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 5.5 => 0.1594763168,
    txinqwemailfirst_dayssince > 5.5                                        => -0.0263012444,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc002_37_5_c212 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 0.5 => 0,
    phoneperemailintxinqcnt1m > 0.5                                       => rc002_37_5_c213,
    phoneperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_37_c212 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 0.5 => 0.0860796435,
    phoneperemailintxinqcnt1m > 0.5                                       => gbm10_wc_lgt_37_c213,
    phoneperemailintxinqcnt1m = NULL                                      => 0.0973993531,
                                                                             0.0973993531);

rc039_37_3_c212 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 0.5 => -0.0113197097,
    phoneperemailintxinqcnt1m > 0.5                                       => 0.0876845372,
    phoneperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc023_37_2_c211 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0.0759778412,
    txinqcorremailwphonecnt > 0.5                                     => -0.0271238775,
    txinqcorremailwphonecnt = NULL                                    => 0.0636907116,
                                                                         0);

rc039_37_3_c211 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => rc039_37_3_c212,
    txinqcorremailwphonecnt > 0.5                                     => 0,
    txinqcorremailwphonecnt = NULL                                    => 0,
                                                                         0);

rc002_37_5_c211 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => rc002_37_5_c212,
    txinqcorremailwphonecnt > 0.5                                     => 0,
    txinqcorremailwphonecnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_37_c211 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => gbm10_wc_lgt_37_c212,
    txinqcorremailwphonecnt > 0.5                                     => -0.0057023656,
    txinqcorremailwphonecnt = NULL                                    => 0.0851122235,
                                                                         0.0214215120);

rc022_37_1 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 158.5 => 0.0393961541,
    txinqwphonelast_dayssince > 158.5                                       => -0.0504842596,
    txinqwphonelast_dayssince = NULL                                        => -0.0122338162,
                                                                               0);

gbm10_wc_lgt_37 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 158.5 => gbm10_wc_lgt_37_c211,
    txinqwphonelast_dayssince > 158.5                                       => -0.0684589018,
    txinqwphonelast_dayssince = NULL                                        => -0.0302084584,
                                                                               -0.0179746422);

rc002_37_5 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 158.5 => rc002_37_5_c211,
    txinqwphonelast_dayssince > 158.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                        => 0,
                                                                               0);

rc023_37_2 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 158.5 => rc023_37_2_c211,
    txinqwphonelast_dayssince > 158.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                        => 0,
                                                                               0);

rc039_37_3 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 158.5 => rc039_37_3_c211,
    txinqwphonelast_dayssince > 158.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                        => 0,
                                                                               0);

rc006_38_7_c217 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 1639.145 => -0.1463318650,
    timebtwtxinqwemailavg > 1639.145                                   => 0.0403925631,
    timebtwtxinqwemailavg = NULL                                       => 0.0040210360,
                                                                          0);

gbm10_wc_lgt_38_c217 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 1639.145 => -0.1590093032,
    timebtwtxinqwemailavg > 1639.145                                   => 0.0277151248,
    timebtwtxinqwemailavg = NULL                                       => -0.0086564023,
                                                                          -0.0126774383);

gbm10_wc_lgt_38_c216 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 574 => gbm10_wc_lgt_38_c217,
    txinqwphonefirst_dayssince > 574                                        => -0.1490059737,
    txinqwphonefirst_dayssince = NULL                                       => -0.0479000960,
                                                                               -0.0479000960);

rc005_38_6_c216 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 574 => 0.0352226577,
    txinqwphonefirst_dayssince > 574                                        => -0.1011058778,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc006_38_7_c216 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 574 => rc006_38_7_c217,
    txinqwphonefirst_dayssince > 574                                        => 0,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc035_38_3_c215 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 35.5 => 0.2202952367,
    txinqwtmxidfirst_dayssince > 35.5                                        => -0.0510460223,
    txinqwtmxidfirst_dayssince = NULL                                        => -0.0091309471,
                                                                                0);

gbm10_wc_lgt_38_c215 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 35.5 => 0.1815260878,
    txinqwtmxidfirst_dayssince > 35.5                                        => -0.0898151712,
    txinqwtmxidfirst_dayssince = NULL                                        => gbm10_wc_lgt_38_c216,
                                                                                -0.0387691489);

rc006_38_7_c215 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 35.5 => 0,
    txinqwtmxidfirst_dayssince > 35.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                        => rc006_38_7_c216,
                                                                                0);

rc005_38_6_c215 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 35.5 => 0,
    txinqwtmxidfirst_dayssince > 35.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                        => rc005_38_6_c216,
                                                                                0);

rc001_38_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0007518338,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0408559187,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0011403899,
                                                                             0);

rc005_38_6 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc005_38_6_c215,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_38 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0028386036,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_38_c215,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0009463799,
                                                                             0.0020867698);

rc006_38_7 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc006_38_7_c215,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc035_38_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc035_38_3_c215,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc002_39_4_c220 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 407.5 => 0.9956763898,
    txinqwemailfirst_dayssince > 407.5                                        => -0.0704547901,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_39_c220 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 407.5 => 1.1580569683,
    txinqwemailfirst_dayssince > 407.5                                        => 0.0919257885,
    txinqwemailfirst_dayssince = NULL                                         => 0.1623805785,
                                                                                 0.1623805785);

rc011_39_9_c221 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 618.84 => -0.0790868234,
    distbtwtrueipwemailavg > 618.84                                    => 0.3230621677,
    distbtwtrueipwemailavg = NULL                                      => -0.1251777331,
                                                                          0);

gbm10_wc_lgt_39_c221 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 618.84 => -0.1572434009,
    distbtwtrueipwemailavg > 618.84                                    => 0.2449055902,
    distbtwtrueipwemailavg = NULL                                      => -0.2033343106,
                                                                          -0.0781565775);

gbm10_wc_lgt_39_c219 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 513 => gbm10_wc_lgt_39_c220,
    txinqwaddrlast_dayssince > 513                                      => 1.7338057035,
    txinqwaddrlast_dayssince = NULL                                     => gbm10_wc_lgt_39_c221,
                                                                           0.0843141422);

rc011_39_9_c219 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 513 => 0,
    txinqwaddrlast_dayssince > 513                                      => 0,
    txinqwaddrlast_dayssince = NULL                                     => rc011_39_9_c221,
                                                                           0);

rc025_39_3_c219 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 513 => 0.0780664363,
    txinqwaddrlast_dayssince > 513                                      => 1.6494915613,
    txinqwaddrlast_dayssince = NULL                                     => -0.1624707197,
                                                                           0);

rc002_39_4_c219 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 513 => rc002_39_4_c220,
    txinqwaddrlast_dayssince > 513                                      => 0,
    txinqwaddrlast_dayssince = NULL                                     => 0,
                                                                           0);

gbm10_wc_lgt_39 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 119.5 => -0.0040122912,
    txinqwemailcnt6m > 119.5                              => gbm10_wc_lgt_39_c219,
    txinqwemailcnt6m = NULL                               => -0.0107596128,
                                                             -0.0038847496);

rc018_39_1 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 119.5 => -0.0001275416,
    txinqwemailcnt6m > 119.5                              => 0.0881988918,
    txinqwemailcnt6m = NULL                               => -0.0068748633,
                                                             0);

rc002_39_4 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 119.5 => 0,
    txinqwemailcnt6m > 119.5                              => rc002_39_4_c219,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

rc011_39_9 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 119.5 => 0,
    txinqwemailcnt6m > 119.5                              => rc011_39_9_c219,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

rc025_39_3 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 119.5 => 0,
    txinqwemailcnt6m > 119.5                              => rc025_39_3_c219,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

gbm10_wc_lgt_40_c225 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 16.5 => 0.6044649116,
    smartidperemailintxinqcnt > 16.5                                       => -0.0994738087,
    smartidperemailintxinqcnt = NULL                                       => 0.2785072220,
                                                                              0.2785072220);

rc042_40_6_c225 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 16.5 => 0.3259576896,
    smartidperemailintxinqcnt > 16.5                                       => -0.3779810307,
    smartidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

rc007_40_4_c224 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 925.895 => -0.0661738314,
    distbtwtrueipwphoneavg > 925.895                                    => 0.2029277207,
    distbtwtrueipwphoneavg = NULL                                       => 0.0884266075,
                                                                           0);

rc042_40_6_c224 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 925.895 => 0,
    distbtwtrueipwphoneavg > 925.895                                    => rc042_40_6_c225,
    distbtwtrueipwphoneavg = NULL                                       => 0,
                                                                           0);

gbm10_wc_lgt_40_c224 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 925.895 => 0.0094056700,
    distbtwtrueipwphoneavg > 925.895                                    => gbm10_wc_lgt_40_c225,
    distbtwtrueipwphoneavg = NULL                                       => 0.1640061089,
                                                                           0.0755795014);

rc042_40_6_c223 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 9.5 => 0,
    exactidperemailintxinqcnt6m > 9.5                                         => rc042_40_6_c224,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_40_c223 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 9.5 => -0.0069541118,
    exactidperemailintxinqcnt6m > 9.5                                         => gbm10_wc_lgt_40_c224,
    exactidperemailintxinqcnt6m = NULL                                        => -0.0038303315,
                                                                                 -0.0038303315);

rc007_40_4_c223 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 9.5 => 0,
    exactidperemailintxinqcnt6m > 9.5                                         => rc007_40_4_c224,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

rc046_40_2_c223 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 9.5 => -0.0031237803,
    exactidperemailintxinqcnt6m > 9.5                                         => 0.0794098328,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

rc002_40_1 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2934 => 0.0008447987,
    txinqwemailfirst_dayssince > 2934                                        => -0.3262000062,
    txinqwemailfirst_dayssince = NULL                                        => -0.0040266662,
                                                                                0);

rc042_40_6 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2934 => rc042_40_6_c223,
    txinqwemailfirst_dayssince > 2934                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_40 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2934 => gbm10_wc_lgt_40_c223,
    txinqwemailfirst_dayssince > 2934                                        => -0.3308751364,
    txinqwemailfirst_dayssince = NULL                                        => -0.0087017964,
                                                                                -0.0046751301);

rc007_40_4 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2934 => rc007_40_4_c223,
    txinqwemailfirst_dayssince > 2934                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc046_40_2 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2934 => rc046_40_2_c223,
    txinqwemailfirst_dayssince > 2934                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc012_41_5_c229 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1848.54 => -0.0128662158,
    timebtwtxinqwphoneavg > 1848.54                                   => -0.2083771977,
    timebtwtxinqwphoneavg = NULL                                      => 0.2335047316,
                                                                         0);

gbm10_wc_lgt_41_c229 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1848.54 => 0.2557631223,
    timebtwtxinqwphoneavg > 1848.54                                   => 0.0602521404,
    timebtwtxinqwphoneavg = NULL                                      => 0.5021340698,
                                                                         0.2686293382);

rc002_41_4_c228 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 68.5 => 0.1541737333,
    txinqwemailfirst_dayssince > 68.5                                        => -0.0691743993,
    txinqwemailfirst_dayssince = NULL                                        => 0.1320685429,
                                                                                0);

rc012_41_5_c228 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 68.5 => rc012_41_5_c229,
    txinqwemailfirst_dayssince > 68.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_41_c228 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 68.5 => gbm10_wc_lgt_41_c229,
    txinqwemailfirst_dayssince > 68.5                                        => 0.0452812055,
    txinqwemailfirst_dayssince = NULL                                        => 0.2465241477,
                                                                                0.1144556048);

rc002_41_4_c227 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 127.5 => rc002_41_4_c228,
    txinqwphonefirst_dayssince > 127.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_41_c227 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 127.5 => gbm10_wc_lgt_41_c228,
    txinqwphonefirst_dayssince > 127.5                                        => 0.0046792361,
    txinqwphonefirst_dayssince = NULL                                         => 0.0162361964,
                                                                                 0.0162361964);

rc012_41_5_c227 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 127.5 => rc012_41_5_c228,
    txinqwphonefirst_dayssince > 127.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc005_41_3_c227 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 127.5 => 0.0982194085,
    txinqwphonefirst_dayssince > 127.5                                        => -0.0115569602,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc002_41_4 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => 0,
    loginidperphoneintxinqcnt > 0.5                                       => rc002_41_4_c227,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc015_41_1 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => -0.0234004162,
    loginidperphoneintxinqcnt > 0.5                                       => 0.0269966540,
    loginidperphoneintxinqcnt = NULL                                      => 0.0109688016,
                                                                             0);

rc012_41_5 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => 0,
    loginidperphoneintxinqcnt > 0.5                                       => rc012_41_5_c227,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_41 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => -0.0341608738,
    loginidperphoneintxinqcnt > 0.5                                       => gbm10_wc_lgt_41_c227,
    loginidperphoneintxinqcnt = NULL                                      => 0.0002083439,
                                                                             -0.0107604577);

rc005_41_3 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => 0,
    loginidperphoneintxinqcnt > 0.5                                       => rc005_41_3_c227,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc017_42_3_c232 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 38.5 => -0.0016320786,
    trueipperphoneintxinqcnt > 38.5                                      => 0.4200353214,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

gbm10_wc_lgt_42_c232 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 38.5 => -0.0028932399,
    trueipperphoneintxinqcnt > 38.5                                      => 0.4187741601,
    trueipperphoneintxinqcnt = NULL                                      => -0.0012611613,
                                                                            -0.0012611613);

rc017_42_3_c231 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 4.5 => rc017_42_3_c232,
    loginidperphoneintxinqcnt > 4.5                                       => 0,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc015_42_2_c231 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 4.5 => -0.0038780266,
    loginidperphoneintxinqcnt > 4.5                                       => 0.3028657012,
    loginidperphoneintxinqcnt = NULL                                      => 0.1238092249,
                                                                             0);

gbm10_wc_lgt_42_c231 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 4.5 => gbm10_wc_lgt_42_c232,
    loginidperphoneintxinqcnt > 4.5                                       => 0.3054825666,
    loginidperphoneintxinqcnt = NULL                                      => 0.1264260902,
                                                                             0.0026168654);

gbm10_wc_lgt_42_c233 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0000224493,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0393105942,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0014782484,
                                                                             -0.0006352368);

rc001_42_10_c233 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0006576861,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0386753574,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0008430116,
                                                                             0);

rc017_42_3 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => rc017_42_3_c231,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc035_42_1 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => 0.0026349920,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0.5224508108,
    txinqwtmxidfirst_dayssince = NULL                                         => -0.0006171101,
                                                                                 0);

rc015_42_2 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => rc015_42_2_c231,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc001_42_10 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => 0,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => rc001_42_10_c233,
                                                                                 0);

gbm10_wc_lgt_42 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => gbm10_wc_lgt_42_c231,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0.5224326841,
    txinqwtmxidfirst_dayssince = NULL                                         => gbm10_wc_lgt_42_c233,
                                                                                 -0.0000181267);

gbm10_wc_lgt_43_c236 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => -0.0562458021,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.2275658612,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0676080219,
                                                                                 -0.0676080219);

rc008_43_4_c236 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0113622198,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.1599578393,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_43_c237 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0.1889858337,
    txinqcorremailwphonecnt > 0.5                                     => -0.0346678331,
    txinqcorremailwphonecnt = NULL                                    => -0.0115615229,
                                                                         -0.0115615229);

rc023_43_8_c237 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0.2005473566,
    txinqcorremailwphonecnt > 0.5                                     => -0.0231063102,
    txinqcorremailwphonecnt = NULL                                    => 0,
                                                                         0);

rc023_43_8_c235 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3444.27 => 0,
    timebtwtxinqwemailavg > 3444.27                                   => rc023_43_8_c237,
    timebtwtxinqwemailavg = NULL                                      => 0,
                                                                         0);

gbm10_wc_lgt_43_c235 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3444.27 => gbm10_wc_lgt_43_c236,
    timebtwtxinqwemailavg > 3444.27                                   => gbm10_wc_lgt_43_c237,
    timebtwtxinqwemailavg = NULL                                      => 0.0065247666,
                                                                         -0.0204215565);

rc008_43_4_c235 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3444.27 => rc008_43_4_c236,
    timebtwtxinqwemailavg > 3444.27                                   => 0,
    timebtwtxinqwemailavg = NULL                                      => 0,
                                                                         0);

rc006_43_3_c235 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3444.27 => -0.0471864654,
    timebtwtxinqwemailavg > 3444.27                                   => 0.0088600336,
    timebtwtxinqwemailavg = NULL                                      => 0.0269463231,
                                                                         0);

rc023_43_8 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc023_43_8_c235,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc008_43_4 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc008_43_4_c235,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_43_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0030781499,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0255421863,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0050118775,
                                                                                 0);

gbm10_wc_lgt_43 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0081987798,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_43_c235,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0001087523,
                                                                                 0.0051206298);

rc006_43_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc006_43_3_c235,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc001_44_2_c239 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0003218852,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.1038746995,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_44_c239 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => -0.0058329846,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.1100295693,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0061548698,
                                                                             -0.0061548698);

gbm10_wc_lgt_44_c241 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 2.5 => 0.5543778483,
    txinqwnamelast_dayssince > 2.5                                      => -0.2186546673,
    txinqwnamelast_dayssince = NULL                                     => 0.0687529213,
                                                                           0.0586676575);

rc026_44_9_c241 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 2.5 => 0.4957101907,
    txinqwnamelast_dayssince > 2.5                                      => -0.2773223248,
    txinqwnamelast_dayssince = NULL                                     => 0.0100852637,
                                                                           0);

rc002_44_6_c240 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2249 => -0.0060556658,
    txinqwemailfirst_dayssince > 2249                                        => 0.4160315129,
    txinqwemailfirst_dayssince = NULL                                        => 0.0225164720,
                                                                                0);

gbm10_wc_lgt_44_c240 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2249 => 0.0300955198,
    txinqwemailfirst_dayssince > 2249                                        => 0.4521826985,
    txinqwemailfirst_dayssince = NULL                                        => gbm10_wc_lgt_44_c241,
                                                                                0.0361511855);

rc026_44_9_c240 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2249 => 0,
    txinqwemailfirst_dayssince > 2249                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => rc026_44_9_c241,
                                                                                0);

rc002_44_6 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => 0,
    tmxidperphoneintxinqcnt1y > 3.5                                       => rc002_44_6_c240,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc001_44_2 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => rc001_44_2_c239,
    tmxidperphoneintxinqcnt1y > 3.5                                       => 0,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_44 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => gbm10_wc_lgt_44_c239,
    tmxidperphoneintxinqcnt1y > 3.5                                       => gbm10_wc_lgt_44_c240,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0.0000869920,
                                                                             -0.0030843846);

rc026_44_9 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => 0,
    tmxidperphoneintxinqcnt1y > 3.5                                       => rc026_44_9_c240,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc031_44_1 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => -0.0030704852,
    tmxidperphoneintxinqcnt1y > 3.5                                       => 0.0392355702,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0.0031713766,
                                                                             0);

gbm10_wc_lgt_45_c245 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 8.5 => 0.1559975667,
    trueipperphoneintxinqcnt > 8.5                                      => -0.1686470194,
    trueipperphoneintxinqcnt = NULL                                     => -0.0229847352,
                                                                           -0.0229847352);

rc017_45_7_c245 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 8.5 => 0.1789823019,
    trueipperphoneintxinqcnt > 8.5                                      => -0.1456622841,
    trueipperphoneintxinqcnt = NULL                                     => 0,
                                                                           0);

gbm10_wc_lgt_45_c244 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 94.125 => -0.3514062174,
    distbtwtrueipwphoneavg > 94.125                                    => gbm10_wc_lgt_45_c245,
    distbtwtrueipwphoneavg = NULL                                      => -0.1028984532,
                                                                          -0.1028984532);

rc007_45_5_c244 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 94.125 => -0.2485077642,
    distbtwtrueipwphoneavg > 94.125                                    => 0.0799137179,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

rc017_45_7_c244 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 94.125 => 0,
    distbtwtrueipwphoneavg > 94.125                                    => rc017_45_7_c245,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_45_c243 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0.0863114180,
    distbtwtrueipwphoneavg > 15.47                                    => gbm10_wc_lgt_45_c244,
    distbtwtrueipwphoneavg = NULL                                     => -0.0475390852,
                                                                         -0.0475390852);

rc007_45_5_c243 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0,
    distbtwtrueipwphoneavg > 15.47                                    => rc007_45_5_c244,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

rc007_45_3_c243 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0.1338505032,
    distbtwtrueipwphoneavg > 15.47                                    => -0.0553593679,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

rc017_45_7_c243 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0,
    distbtwtrueipwphoneavg > 15.47                                    => rc017_45_7_c244,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

rc004_45_1 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0002660279,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.0480859148,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0004772422,
                                                                             0);

rc017_45_7 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0,
    tmxidperphoneintxinqcnt3m > 5.5                                       => rc017_45_7_c243,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc007_45_3 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0,
    tmxidperphoneintxinqcnt3m > 5.5                                       => rc007_45_3_c243,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc007_45_5 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0,
    tmxidperphoneintxinqcnt3m > 5.5                                       => rc007_45_5_c243,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_45 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0008128574,
    tmxidperphoneintxinqcnt3m > 5.5                                       => gbm10_wc_lgt_45_c243,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0.0000695873,
                                                                             0.0005468295);

gbm10_wc_lgt_46_c249 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 3.5 => 0.1726314083,
    trueipperemailintxinqcnt > 3.5                                      => 0.3154271939,
    trueipperemailintxinqcnt = NULL                                     => 0.1787580945,
                                                                           0.1787580945);

rc036_46_4_c249 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 3.5 => -0.0061266861,
    trueipperemailintxinqcnt > 3.5                                      => 0.1366690994,
    trueipperemailintxinqcnt = NULL                                     => 0,
                                                                           0);

rc051_46_3_c248 := map(
    NULL < txinqcorremailwphonecnt1y AND txinqcorremailwphonecnt1y <= 0.5 => 0.0586834866,
    txinqcorremailwphonecnt1y > 0.5                                       => -0.1222686333,
    txinqcorremailwphonecnt1y = NULL                                      => 0.1452416171,
                                                                             0);

gbm10_wc_lgt_46_c248 := map(
    NULL < txinqcorremailwphonecnt1y AND txinqcorremailwphonecnt1y <= 0.5 => gbm10_wc_lgt_46_c249,
    txinqcorremailwphonecnt1y > 0.5                                       => -0.0021940255,
    txinqcorremailwphonecnt1y = NULL                                      => 0.2653162249,
                                                                             0.1200746078);

rc036_46_4_c248 := map(
    NULL < txinqcorremailwphonecnt1y AND txinqcorremailwphonecnt1y <= 0.5 => rc036_46_4_c249,
    txinqcorremailwphonecnt1y > 0.5                                       => 0,
    txinqcorremailwphonecnt1y = NULL                                      => 0,
                                                                             0);

rc051_46_3_c247 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 22.5 => rc051_46_3_c248,
    txinqwemailfirst_dayssince > 22.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_46_c247 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 22.5 => gbm10_wc_lgt_46_c248,
    txinqwemailfirst_dayssince > 22.5                                        => 0.0072284056,
    txinqwemailfirst_dayssince = NULL                                        => 0.0151448476,
                                                                                0.0151448476);

rc002_46_2_c247 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 22.5 => 0.1049297602,
    txinqwemailfirst_dayssince > 22.5                                        => -0.0079164420,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc036_46_4_c247 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 22.5 => rc036_46_4_c248,
    txinqwemailfirst_dayssince > 22.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_46 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => gbm10_wc_lgt_46_c247,
    txinqwemaillast_dayssince > 97.5                                       => -0.0931681441,
    txinqwemaillast_dayssince = NULL                                       => -0.0198709913,
                                                                              -0.0160090677);

rc051_46_3 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => rc051_46_3_c247,
    txinqwemaillast_dayssince > 97.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                       => 0,
                                                                              0);

rc036_46_4 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => rc036_46_4_c247,
    txinqwemaillast_dayssince > 97.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                       => 0,
                                                                              0);

rc029_46_1 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => 0.0311539153,
    txinqwemaillast_dayssince > 97.5                                       => -0.0771590764,
    txinqwemaillast_dayssince = NULL                                       => -0.0038619236,
                                                                              0);

rc002_46_2 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => rc002_46_2_c247,
    txinqwemaillast_dayssince > 97.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                       => 0,
                                                                              0);

rc003_47_4_c253 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0021183145,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.1366462166,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_47_c253 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0.0622978563,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.2010623875,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0644161709,
                                                                                 0.0644161709);

gbm10_wc_lgt_47_c252 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => gbm10_wc_lgt_47_c253,
    txinqcorremailwphonecnt1m > 21.5                                       => -0.2325872527,
    txinqcorremailwphonecnt1m = NULL                                       => 0.1774798046,
                                                                              0.0709461735);

rc003_47_4_c252 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => rc003_47_4_c253,
    txinqcorremailwphonecnt1m > 21.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

rc032_47_3_c252 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => -0.0065300026,
    txinqcorremailwphonecnt1m > 21.5                                       => -0.3035334262,
    txinqcorremailwphonecnt1m = NULL                                       => 0.1065336311,
                                                                              0);

gbm10_wc_lgt_47_c251 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 705.5 => gbm10_wc_lgt_47_c252,
    txinqwphonefirst_dayssince > 705.5                                        => 0.2989716577,
    txinqwphonefirst_dayssince = NULL                                         => 0.0739258343,
                                                                                 0.0739258343);

rc005_47_2_c251 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 705.5 => -0.0029796609,
    txinqwphonefirst_dayssince > 705.5                                        => 0.2250458234,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc032_47_3_c251 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 705.5 => rc032_47_3_c252,
    txinqwphonefirst_dayssince > 705.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc003_47_4_c251 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 705.5 => rc003_47_4_c252,
    txinqwphonefirst_dayssince > 705.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_47 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => gbm10_wc_lgt_47_c251,
    timebtwtxinqwphoneavg > 1404.665                                   => 0.0010066820,
    timebtwtxinqwphoneavg = NULL                                       => -0.0187030580,
                                                                          -0.0083968076);

rc005_47_2 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => rc005_47_2_c251,
    timebtwtxinqwphoneavg > 1404.665                                   => 0,
    timebtwtxinqwphoneavg = NULL                                       => 0,
                                                                          0);

rc012_47_1 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => 0.0823226419,
    timebtwtxinqwphoneavg > 1404.665                                   => 0.0094034895,
    timebtwtxinqwphoneavg = NULL                                       => -0.0103062504,
                                                                          0);

rc032_47_3 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => rc032_47_3_c251,
    timebtwtxinqwphoneavg > 1404.665                                   => 0,
    timebtwtxinqwphoneavg = NULL                                       => 0,
                                                                          0);

rc003_47_4 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => rc003_47_4_c251,
    timebtwtxinqwphoneavg > 1404.665                                   => 0,
    timebtwtxinqwphoneavg = NULL                                       => 0,
                                                                          0);

rc047_48_3_c256 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 51.5 => -0.0007308309,
    exactidperemailintxinqcnt > 51.5                                       => 0.2497440548,
    exactidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_48_c256 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 51.5 => -0.0009943757,
    exactidperemailintxinqcnt > 51.5                                       => 0.2494805099,
    exactidperemailintxinqcnt = NULL                                       => -0.0002635448,
                                                                              -0.0002635448);

gbm10_wc_lgt_48_c257 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 32.5 => -0.0108872214,
    trueipperphoneintxinqcnt > 32.5                                      => 0.5732360764,
    trueipperphoneintxinqcnt = NULL                                      => -0.0084211232,
                                                                            -0.0084211232);

rc017_48_8_c257 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 32.5 => -0.0024660983,
    trueipperphoneintxinqcnt > 32.5                                      => 0.5816571995,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

rc047_48_3_c255 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => rc047_48_3_c256,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_48_c255 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => gbm10_wc_lgt_48_c256,
    phoneperemailintxinqcnt3m > 5.5                                       => -0.2134319656,
    phoneperemailintxinqcnt3m = NULL                                      => gbm10_wc_lgt_48_c257,
                                                                             -0.0011043837);

rc030_48_2_c255 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => 0.0008408389,
    phoneperemailintxinqcnt3m > 5.5                                       => -0.2123275819,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0073167394,
                                                                             0);

rc017_48_8_c255 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => 0,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => rc017_48_8_c257,
                                                                             0);

rc047_48_3 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => rc047_48_3_c255,
    emailperphoneintxinqcnt > 17.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => 0,
                                                                          0);

gbm10_wc_lgt_48 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => gbm10_wc_lgt_48_c255,
    emailperphoneintxinqcnt > 17.5                                     => -0.1874230990,
    emailperphoneintxinqcnt = NULL                                     => 0.0021936511,
                                                                          -0.0004941929);

rc030_48_2 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => rc030_48_2_c255,
    emailperphoneintxinqcnt > 17.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => 0,
                                                                          0);

rc017_48_8 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => rc017_48_8_c255,
    emailperphoneintxinqcnt > 17.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => 0,
                                                                          0);

rc033_48_1 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => -0.0006101909,
    emailperphoneintxinqcnt > 17.5                                     => -0.1869289061,
    emailperphoneintxinqcnt = NULL                                     => 0.0026878440,
                                                                          0);

rc026_49_9_c261 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 2.5 => 0.1277130646,
    txinqwnamelast_dayssince > 2.5                                      => -0.2697950740,
    txinqwnamelast_dayssince = NULL                                     => 0.1895203933,
                                                                           0);

gbm10_wc_lgt_49_c261 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 2.5 => 0.2136484766,
    txinqwnamelast_dayssince > 2.5                                      => -0.1838596620,
    txinqwnamelast_dayssince = NULL                                     => 0.2754558053,
                                                                           0.0859354120);

rc026_49_9_c260 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 209.34 => 0,
    distbtwtrueipwemailavg > 209.34                                    => 0,
    distbtwtrueipwemailavg = NULL                                      => rc026_49_9_c261,
                                                                          0);

gbm10_wc_lgt_49_c260 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 209.34 => -0.0847108556,
    distbtwtrueipwemailavg > 209.34                                    => 0.1546125332,
    distbtwtrueipwemailavg = NULL                                      => gbm10_wc_lgt_49_c261,
                                                                          0.0302239312);

rc011_49_6_c260 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 209.34 => -0.1149347868,
    distbtwtrueipwemailavg > 209.34                                    => 0.1243886020,
    distbtwtrueipwemailavg = NULL                                      => 0.0557114808,
                                                                          0);

gbm10_wc_lgt_49_c259 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 975.5 => -0.0414644806,
    txinqwaddrfirst_dayssince > 975.5                                       => -0.1548444423,
    txinqwaddrfirst_dayssince = NULL                                        => gbm10_wc_lgt_49_c260,
                                                                               -0.0278454141);

rc026_49_9_c259 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 975.5 => 0,
    txinqwaddrfirst_dayssince > 975.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                        => rc026_49_9_c260,
                                                                               0);

rc016_49_3_c259 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 975.5 => -0.0136190666,
    txinqwaddrfirst_dayssince > 975.5                                       => -0.1269990283,
    txinqwaddrfirst_dayssince = NULL                                        => 0.0580693453,
                                                                               0);

rc011_49_6_c259 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 975.5 => 0,
    txinqwaddrfirst_dayssince > 975.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                        => rc011_49_6_c260,
                                                                               0);

gbm10_wc_lgt_49 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0082826531,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_49_c259,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0017509430,
                                                                                 0.0052209160);

rc016_49_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc016_49_3_c259,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc026_49_9 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc026_49_9_c259,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_49_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0030617372,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0330663300,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0034699729,
                                                                                 0);

rc011_49_6 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc011_49_6_c259,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc005_50_7_c265 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 59.5 => 0.0978793447,
    txinqwphonefirst_dayssince > 59.5                                        => -0.0030295338,
    txinqwphonefirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_50_c265 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 59.5 => 0.1872176807,
    txinqwphonefirst_dayssince > 59.5                                        => 0.0863088022,
    txinqwphonefirst_dayssince = NULL                                        => 0.0893383360,
                                                                                0.0893383360);

gbm10_wc_lgt_50_c264 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 234.36 => -0.0145288926,
    distbtwtrueipwemailavg > 234.36                                    => gbm10_wc_lgt_50_c265,
    distbtwtrueipwemailavg = NULL                                      => 0.0387012869,
                                                                          0.0317681697);

rc005_50_7_c264 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 234.36 => 0,
    distbtwtrueipwemailavg > 234.36                                    => rc005_50_7_c265,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

rc011_50_5_c264 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 234.36 => -0.0462970622,
    distbtwtrueipwemailavg > 234.36                                    => 0.0575701663,
    distbtwtrueipwemailavg = NULL                                      => 0.0069331172,
                                                                          0);

gbm10_wc_lgt_50_c263 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 3.5 => -0.3005727309,
    txinqwphonefirst_dayssince > 3.5                                        => gbm10_wc_lgt_50_c264,
    txinqwphonefirst_dayssince = NULL                                       => 0.0311676431,
                                                                               0.0311676431);

rc005_50_7_c263 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 3.5 => 0,
    txinqwphonefirst_dayssince > 3.5                                        => rc005_50_7_c264,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc011_50_5_c263 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 3.5 => 0,
    txinqwphonefirst_dayssince > 3.5                                        => rc011_50_5_c264,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc005_50_3_c263 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 3.5 => -0.3317403740,
    txinqwphonefirst_dayssince > 3.5                                        => 0.0006005266,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc011_50_5 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc011_50_5_c263,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_50 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => -0.0207099813,
    emailperphoneintxinqcnt > 1.5                                     => gbm10_wc_lgt_50_c263,
    emailperphoneintxinqcnt = NULL                                    => 0.0013982197,
                                                                         -0.0074725876);

rc005_50_7 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc005_50_7_c263,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc033_50_1 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => -0.0132373937,
    emailperphoneintxinqcnt > 1.5                                     => 0.0386402307,
    emailperphoneintxinqcnt = NULL                                    => 0.0088708072,
                                                                         0);

rc005_50_3 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc005_50_3_c263,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc049_51_5_c268 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 11.5 => 0.0043898341,
    tmxidperemailintxinqcnt > 11.5                                     => 0.5597286310,
    tmxidperemailintxinqcnt = NULL                                     => -0.0559153720,
                                                                          0);

gbm10_wc_lgt_51_c268 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 11.5 => -0.0218042824,
    tmxidperemailintxinqcnt > 11.5                                     => 0.5335345145,
    tmxidperemailintxinqcnt = NULL                                     => -0.0821094885,
                                                                          -0.0261941165);

rc012_51_2_c267 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.625 => 0.0389500175,
    timebtwtxinqwphoneavg > 85032.625                                   => -0.0153066346,
    timebtwtxinqwphoneavg = NULL                                        => -0.0143990726,
                                                                           0);

gbm10_wc_lgt_51_c267 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.625 => 0.0271549737,
    timebtwtxinqwphoneavg > 85032.625                                   => -0.0271016784,
    timebtwtxinqwphoneavg = NULL                                        => gbm10_wc_lgt_51_c268,
                                                                           -0.0117950439);

rc049_51_5_c267 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.625 => 0,
    timebtwtxinqwphoneavg > 85032.625                                   => 0,
    timebtwtxinqwphoneavg = NULL                                        => rc049_51_5_c268,
                                                                           0);

gbm10_wc_lgt_51_c269 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2012 => -0.2001686855,
    txinqwemailfirst_dayssince > 2012                                        => 0.2435939646,
    txinqwemailfirst_dayssince = NULL                                        => -0.2361933652,
                                                                                -0.1556070692);

rc002_51_9_c269 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2012 => -0.0445616163,
    txinqwemailfirst_dayssince > 2012                                        => 0.3992010338,
    txinqwemailfirst_dayssince = NULL                                        => -0.0805862960,
                                                                                0);

rc002_51_9 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 24.5 => 0,
    browserhashperphoneintxinqcnt > 24.5                                           => rc002_51_9_c269,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc012_51_2 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 24.5 => rc012_51_2_c267,
    browserhashperphoneintxinqcnt > 24.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

gbm10_wc_lgt_51 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 24.5 => gbm10_wc_lgt_51_c267,
    browserhashperphoneintxinqcnt > 24.5                                           => gbm10_wc_lgt_51_c269,
    browserhashperphoneintxinqcnt = NULL                                           => 0.0011169591,
                                                                                      -0.0095937770);

rc049_51_5 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 24.5 => rc049_51_5_c267,
    browserhashperphoneintxinqcnt > 24.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc038_51_1 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 24.5 => -0.0022012668,
    browserhashperphoneintxinqcnt > 24.5                                           => -0.1460132922,
    browserhashperphoneintxinqcnt = NULL                                           => 0.0107107361,
                                                                                      0);

rc046_52_6_c273 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 7.5 => -0.0648116969,
    exactidperemailintxinqcnt6m > 7.5                                         => 0.1605054410,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_52_c273 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 7.5 => 0.0215784920,
    exactidperemailintxinqcnt6m > 7.5                                         => 0.2468956299,
    exactidperemailintxinqcnt6m = NULL                                        => 0.0863901889,
                                                                                 0.0863901889);

rc046_52_6_c272 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => rc046_52_6_c273,
    tmxidperphoneintxinqcnt3m > 5.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_52_c272 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => gbm10_wc_lgt_52_c273,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.0853562739,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0.0163994210,
                                                                             0.0163994210);

rc004_52_5_c272 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0699907679,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.1017556949,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_52_c271 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => -0.0868941698,
    tmxidperphoneintxinqcnt1y > 4.5                                       => gbm10_wc_lgt_52_c272,
    tmxidperphoneintxinqcnt1y = NULL                                      => -0.0320309552,
                                                                             -0.0320309552);

rc046_52_6_c271 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => 0,
    tmxidperphoneintxinqcnt1y > 4.5                                       => rc046_52_6_c272,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc004_52_5_c271 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => 0,
    tmxidperphoneintxinqcnt1y > 4.5                                       => rc004_52_5_c272,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc031_52_3_c271 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => -0.0548632146,
    tmxidperphoneintxinqcnt1y > 4.5                                       => 0.0484303762,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc001_52_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0006726980,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0340327607,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0011092700,
                                                                             0);

rc004_52_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc004_52_5_c271,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc031_52_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc031_52_3_c271,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_52 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0026745035,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_52_c271,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0008925355,
                                                                             0.0020018055);

rc046_52_6 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc046_52_6_c271,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_53_c276 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 6.5 => 0.0065087730,
    browserhashperphoneintxinqcnt > 6.5                                           => -0.0781562597,
    browserhashperphoneintxinqcnt = NULL                                          => -0.0255653608,
                                                                                     -0.0255653608);

rc038_53_4_c276 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 6.5 => 0.0320741337,
    browserhashperphoneintxinqcnt > 6.5                                           => -0.0525908989,
    browserhashperphoneintxinqcnt = NULL                                          => 0,
                                                                                     0);

rc013_53_9_c277 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 1670.5 => -0.1181070516,
    txinqwnamefirst_dayssince > 1670.5                                       => 0.3519114650,
    txinqwnamefirst_dayssince = NULL                                         => 0.1578209086,
                                                                                0);

gbm10_wc_lgt_53_c277 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 1670.5 => -0.1181883144,
    txinqwnamefirst_dayssince > 1670.5                                       => 0.3518302022,
    txinqwnamefirst_dayssince = NULL                                         => 0.1577396458,
                                                                                -0.0000812628);

rc013_53_9_c275 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 17.5 => 0,
    smartidperemailintxinqcnt3m > 17.5                                         => 0,
    smartidperemailintxinqcnt3m = NULL                                         => rc013_53_9_c277,
                                                                                  0);

rc019_53_3_c275 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 17.5 => -0.0003696417,
    smartidperemailintxinqcnt3m > 17.5                                         => -0.2130171479,
    smartidperemailintxinqcnt3m = NULL                                         => 0.0251144563,
                                                                                  0);

rc038_53_4_c275 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 17.5 => rc038_53_4_c276,
    smartidperemailintxinqcnt3m > 17.5                                         => 0,
    smartidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_53_c275 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 17.5 => gbm10_wc_lgt_53_c276,
    smartidperemailintxinqcnt3m > 17.5                                         => -0.2382128669,
    smartidperemailintxinqcnt3m = NULL                                         => gbm10_wc_lgt_53_c277,
                                                                                  -0.0251957191);

gbm10_wc_lgt_53 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0083741199,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_53_c275,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0007133695,
                                                                                 0.0051729172);

rc038_53_4 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc038_53_4_c275,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_53_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0032012027,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0303686362,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0044595477,
                                                                                 0);

rc013_53_9 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc013_53_9_c275,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc019_53_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc019_53_3_c275,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_54_c281 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 41.5 => 0.0027691789,
    trueipperphoneintxinqcnt > 41.5                                      => 0.1995654160,
    trueipperphoneintxinqcnt = NULL                                      => 0.0029014488,
                                                                            0.0029014488);

rc017_54_4_c281 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 41.5 => -0.0001322699,
    trueipperphoneintxinqcnt > 41.5                                      => 0.1966639672,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

gbm10_wc_lgt_54_c280 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 48.5 => gbm10_wc_lgt_54_c281,
    trueipperphoneintxinqcnt > 48.5                                      => -0.3542654310,
    trueipperphoneintxinqcnt = NULL                                      => 0.0027454022,
                                                                            0.0027454022);

rc017_54_4_c280 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 48.5 => rc017_54_4_c281,
    trueipperphoneintxinqcnt > 48.5                                      => 0,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

rc017_54_3_c280 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 48.5 => 0.0001560466,
    trueipperphoneintxinqcnt > 48.5                                      => -0.3570108332,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

rc005_54_2_c279 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 1236.5 => -0.0001020673,
    txinqwphonefirst_dayssince > 1236.5                                        => -0.1574211243,
    txinqwphonefirst_dayssince = NULL                                          => 0.0075656920,
                                                                                  0);

rc017_54_4_c279 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 1236.5 => rc017_54_4_c280,
    txinqwphonefirst_dayssince > 1236.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                          => 0,
                                                                                  0);

gbm10_wc_lgt_54_c279 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 1236.5 => gbm10_wc_lgt_54_c280,
    txinqwphonefirst_dayssince > 1236.5                                        => -0.1545736547,
    txinqwphonefirst_dayssince = NULL                                          => 0.0104131616,
                                                                                  0.0028474695);

rc017_54_3_c279 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 1236.5 => rc017_54_3_c280,
    txinqwphonefirst_dayssince > 1236.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                          => 0,
                                                                                  0);

rc005_54_2 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => rc005_54_2_c279,
    txinqwemailfirst_dayssince > 2916                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc017_54_4 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => rc017_54_4_c279,
    txinqwemailfirst_dayssince > 2916                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_54 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => gbm10_wc_lgt_54_c279,
    txinqwemailfirst_dayssince > 2916                                        => -0.3168777301,
    txinqwemailfirst_dayssince = NULL                                        => -0.0122010439,
                                                                                0.0004385131);

rc017_54_3 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => rc017_54_3_c279,
    txinqwemailfirst_dayssince > 2916                                        => 0,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc002_54_1 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 2916 => 0.0024089565,
    txinqwemailfirst_dayssince > 2916                                        => -0.3173162432,
    txinqwemailfirst_dayssince = NULL                                        => -0.0126395570,
                                                                                0);

rc024_55_5_c285 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 3.5 => 0.1541783124,
    tmxidperemailintxinqcnt1m > 3.5                                       => -0.2688469696,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_55_c285 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 3.5 => 0.3516886702,
    tmxidperemailintxinqcnt1m > 3.5                                       => -0.0713366118,
    tmxidperemailintxinqcnt1m = NULL                                      => 0.1975103578,
                                                                             0.1975103578);

rc049_55_3_c284 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => -0.0008971632,
    tmxidperemailintxinqcnt > 7.5                                     => 0.1694632995,
    tmxidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_55_c284 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => 0.0271498951,
    tmxidperemailintxinqcnt > 7.5                                     => gbm10_wc_lgt_55_c285,
    tmxidperemailintxinqcnt = NULL                                    => 0.0280470583,
                                                                         0.0280470583);

rc024_55_5_c284 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => 0,
    tmxidperemailintxinqcnt > 7.5                                     => rc024_55_5_c285,
    tmxidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_55_c283 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 108 => gbm10_wc_lgt_55_c284,
    txinqwemailcnt6m > 108                              => 0.3374705686,
    txinqwemailcnt6m = NULL                             => 0.0284993177,
                                                           0.0284993177);

rc049_55_3_c283 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 108 => rc049_55_3_c284,
    txinqwemailcnt6m > 108                              => 0,
    txinqwemailcnt6m = NULL                             => 0,
                                                           0);

rc024_55_5_c283 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 108 => rc024_55_5_c284,
    txinqwemailcnt6m > 108                              => 0,
    txinqwemailcnt6m = NULL                             => 0,
                                                           0);

rc018_55_2_c283 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 108 => -0.0004522594,
    txinqwemailcnt6m > 108                              => 0.3089712509,
    txinqwemailcnt6m = NULL                             => 0,
                                                           0);

gbm10_wc_lgt_55 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 284.5 => gbm10_wc_lgt_55_c283,
    txinqwemailfirst_dayssince > 284.5                                        => -0.0194290724,
    txinqwemailfirst_dayssince = NULL                                         => -0.0098792397,
                                                                                 -0.0056585923);

rc049_55_3 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 284.5 => rc049_55_3_c283,
    txinqwemailfirst_dayssince > 284.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc002_55_1 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 284.5 => 0.0341579100,
    txinqwemailfirst_dayssince > 284.5                                        => -0.0137704800,
    txinqwemailfirst_dayssince = NULL                                         => -0.0042206474,
                                                                                 0);

rc024_55_5 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 284.5 => rc024_55_5_c283,
    txinqwemailfirst_dayssince > 284.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc018_55_2 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 284.5 => rc018_55_2_c283,
    txinqwemailfirst_dayssince > 284.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_56_c289 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 17.5 => 0.6007451484,
    txinqcorremailwphonecnt3m > 17.5                                       => -0.0298198552,
    txinqcorremailwphonecnt3m = NULL                                       => 0.3351875041,
                                                                              0.3351875041);

rc027_56_5_c289 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 17.5 => 0.2655576443,
    txinqcorremailwphonecnt3m > 17.5                                       => -0.3650073593,
    txinqcorremailwphonecnt3m = NULL                                       => 0,
                                                                              0);

rc010_56_3_c288 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 8.5 => -0.0353971667,
    txinqwphonecnt1y > 8.5                              => 0.1798061203,
    txinqwphonecnt1y = NULL                             => -0.1070028248,
                                                           0);

gbm10_wc_lgt_56_c288 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 8.5 => 0.1199842171,
    txinqwphonecnt1y > 8.5                              => gbm10_wc_lgt_56_c289,
    txinqwphonecnt1y = NULL                             => 0.0483785590,
                                                           0.1553813838);

rc027_56_5_c288 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 8.5 => 0,
    txinqwphonecnt1y > 8.5                              => rc027_56_5_c289,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

gbm10_wc_lgt_56_c287 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 464.025 => gbm10_wc_lgt_56_c288,
    timebtwtxinqwemailavg > 464.025                                   => 0.0196669583,
    timebtwtxinqwemailavg = NULL                                      => 0.1498064304,
                                                                         0.0285087290);

rc010_56_3_c287 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 464.025 => rc010_56_3_c288,
    timebtwtxinqwemailavg > 464.025                                   => 0,
    timebtwtxinqwemailavg = NULL                                      => 0,
                                                                         0);

rc027_56_5_c287 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 464.025 => rc027_56_5_c288,
    timebtwtxinqwemailavg > 464.025                                   => 0,
    timebtwtxinqwemailavg = NULL                                      => 0,
                                                                         0);

rc006_56_2_c287 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 464.025 => 0.1268726549,
    timebtwtxinqwemailavg > 464.025                                   => -0.0088417706,
    timebtwtxinqwemailavg = NULL                                      => 0.1212977014,
                                                                         0);

rc006_56_2 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 1.5 => rc006_56_2_c287,
    txinqwemaillast_dayssince > 1.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

rc027_56_5 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 1.5 => rc027_56_5_c287,
    txinqwemaillast_dayssince > 1.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

rc010_56_3 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 1.5 => rc010_56_3_c287,
    txinqwemaillast_dayssince > 1.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

rc029_56_1 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 1.5 => 0.0359802583,
    txinqwemaillast_dayssince > 1.5                                       => -0.0019651299,
    txinqwemaillast_dayssince = NULL                                      => -0.0095260620,
                                                                             0);

gbm10_wc_lgt_56 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 1.5 => gbm10_wc_lgt_56_c287,
    txinqwemaillast_dayssince > 1.5                                       => -0.0094366592,
    txinqwemaillast_dayssince = NULL                                      => -0.0169975914,
                                                                             -0.0074715294);

rc005_57_6_c293 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 430.5 => 0.1070084311,
    txinqwphonefirst_dayssince > 430.5                                        => -0.1779848190,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_57_c293 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 430.5 => 0.2306152473,
    txinqwphonefirst_dayssince > 430.5                                        => -0.0543780029,
    txinqwphonefirst_dayssince = NULL                                         => 0.1236068162,
                                                                                 0.1236068162);

rc023_57_5_c292 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0.1350557827,
    txinqcorremailwphonecnt > 0.5                                     => -0.0155606180,
    txinqcorremailwphonecnt = NULL                                    => 0,
                                                                         0);

rc005_57_6_c292 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => rc005_57_6_c293,
    txinqcorremailwphonecnt > 0.5                                     => 0,
    txinqcorremailwphonecnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_57_c292 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => gbm10_wc_lgt_57_c293,
    txinqcorremailwphonecnt > 0.5                                     => -0.0270095845,
    txinqcorremailwphonecnt = NULL                                    => -0.0114489665,
                                                                         -0.0114489665);

rc023_57_5_c291 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3444.27 => 0,
    timebtwtxinqwemailavg > 3444.27                                   => rc023_57_5_c292,
    timebtwtxinqwemailavg = NULL                                      => 0,
                                                                         0);

rc005_57_6_c291 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3444.27 => 0,
    timebtwtxinqwemailavg > 3444.27                                   => rc005_57_6_c292,
    timebtwtxinqwemailavg = NULL                                      => 0,
                                                                         0);

gbm10_wc_lgt_57_c291 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3444.27 => -0.0643742522,
    timebtwtxinqwemailavg > 3444.27                                   => gbm10_wc_lgt_57_c292,
    timebtwtxinqwemailavg = NULL                                      => -0.0028752541,
                                                                         -0.0212602819);

rc006_57_3_c291 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 3444.27 => -0.0431139703,
    timebtwtxinqwemailavg > 3444.27                                   => 0.0098113154,
    timebtwtxinqwemailavg = NULL                                      => 0.0183850279,
                                                                         0);

rc006_57_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc006_57_3_c291,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_57 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0074182348,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_57_c291,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0014152529,
                                                                                 0.0048046921);

rc023_57_5 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc023_57_5_c291,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc005_57_6 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc005_57_6_c291,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_57_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0026135428,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0260649740,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0033894392,
                                                                                 0);

gbm10_wc_lgt_58_c297 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 25.5 => 0.3836430759,
    txinqwemailfirst_dayssince > 25.5                                        => 0.0896826782,
    txinqwemailfirst_dayssince = NULL                                        => 0.1914347197,
                                                                                0.1914347197);

rc002_58_5_c297 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 25.5 => 0.1922083562,
    txinqwemailfirst_dayssince > 25.5                                        => -0.1017520415,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc011_58_4_c296 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 0.33 => 0.1827999119,
    distbtwtrueipwemailavg > 0.33                                    => -0.0193785163,
    distbtwtrueipwemailavg = NULL                                    => 0,
                                                                        0);

gbm10_wc_lgt_58_c296 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 0.33 => gbm10_wc_lgt_58_c297,
    distbtwtrueipwemailavg > 0.33                                    => -0.0107437085,
    distbtwtrueipwemailavg = NULL                                    => 0.0086348078,
                                                                        0.0086348078);

rc002_58_5_c296 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 0.33 => rc002_58_5_c297,
    distbtwtrueipwemailavg > 0.33                                    => 0,
    distbtwtrueipwemailavg = NULL                                    => 0,
                                                                        0);

rc011_58_4_c295 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 949.02 => rc011_58_4_c296,
    distbtwtrueipwphoneavg > 949.02                                    => 0,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_58_c295 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 949.02 => gbm10_wc_lgt_58_c296,
    distbtwtrueipwphoneavg > 949.02                                    => 0.3469959789,
    distbtwtrueipwphoneavg = NULL                                      => 0.0325712698,
                                                                          0.0325712698);

rc007_58_3_c295 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 949.02 => -0.0239364620,
    distbtwtrueipwphoneavg > 949.02                                    => 0.3144247091,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

rc002_58_5_c295 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 949.02 => rc002_58_5_c296,
    distbtwtrueipwphoneavg > 949.02                                    => 0,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

rc011_58_4 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => 0,
    txinqcorremailwphonecnt1m > 4.5                                       => rc011_58_4_c295,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc002_58_5 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => 0,
    txinqcorremailwphonecnt1m > 4.5                                       => rc002_58_5_c295,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc007_58_3 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => 0,
    txinqcorremailwphonecnt1m > 4.5                                       => rc007_58_3_c295,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc032_58_1 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => -0.0020352147,
    txinqcorremailwphonecnt1m > 4.5                                       => 0.0349548745,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0034559171,
                                                                             0);

gbm10_wc_lgt_58 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => -0.0044188194,
    txinqcorremailwphonecnt1m > 4.5                                       => gbm10_wc_lgt_58_c295,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0010723124,
                                                                             -0.0023836047);

rc011_59_6_c301 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 227.305 => -0.3469036160,
    distbtwtrueipwemailavg > 227.305                                    => 0.1973759164,
    distbtwtrueipwemailavg = NULL                                       => 0,
                                                                           0);

gbm10_wc_lgt_59_c301 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 227.305 => -0.1771215619,
    distbtwtrueipwemailavg > 227.305                                    => 0.3671579705,
    distbtwtrueipwemailavg = NULL                                       => 0.1697820541,
                                                                           0.1697820541);

rc011_59_6_c300 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 14.5 => 0,
    exactidperemailintxinqcnt3m > 14.5                                         => rc011_59_6_c301,
    exactidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

rc044_59_4_c300 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 14.5 => -0.0023354040,
    exactidperemailintxinqcnt3m > 14.5                                         => 0.0988658473,
    exactidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_59_c300 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 14.5 => 0.0685808029,
    exactidperemailintxinqcnt3m > 14.5                                         => gbm10_wc_lgt_59_c301,
    exactidperemailintxinqcnt3m = NULL                                         => 0.0709162068,
                                                                                  0.0709162068);

gbm10_wc_lgt_59_c299 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 21.5 => gbm10_wc_lgt_59_c300,
    exactidperemailintxinqcnt3m > 21.5                                         => -0.2741659368,
    exactidperemailintxinqcnt3m = NULL                                         => 0.0663466538,
                                                                                  0.0663466538);

rc044_59_3_c299 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 21.5 => 0.0045695530,
    exactidperemailintxinqcnt3m > 21.5                                         => -0.3405125906,
    exactidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

rc044_59_4_c299 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 21.5 => rc044_59_4_c300,
    exactidperemailintxinqcnt3m > 21.5                                         => 0,
    exactidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

rc011_59_6_c299 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 21.5 => rc011_59_6_c300,
    exactidperemailintxinqcnt3m > 21.5                                         => 0,
    exactidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_59 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => -0.0054917052,
    tmxidperemailintxinqcnt > 7.5                                     => gbm10_wc_lgt_59_c299,
    tmxidperemailintxinqcnt = NULL                                    => -0.0055873541,
                                                                         -0.0031139539);

rc044_59_4 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => 0,
    tmxidperemailintxinqcnt > 7.5                                     => rc044_59_4_c299,
    tmxidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

rc044_59_3 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => 0,
    tmxidperemailintxinqcnt > 7.5                                     => rc044_59_3_c299,
    tmxidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

rc049_59_1 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => -0.0023777513,
    tmxidperemailintxinqcnt > 7.5                                     => 0.0694606077,
    tmxidperemailintxinqcnt = NULL                                    => -0.0024734002,
                                                                         0);

rc011_59_6 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => 0,
    tmxidperemailintxinqcnt > 7.5                                     => rc011_59_6_c299,
    tmxidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_60_c305 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 94.125 => -0.3346644050,
    distbtwtrueipwphoneavg > 94.125                                    => -0.0476967063,
    distbtwtrueipwphoneavg = NULL                                      => -0.1262814381,
                                                                          -0.1262814381);

rc007_60_6_c305 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 94.125 => -0.2083829670,
    distbtwtrueipwphoneavg > 94.125                                    => 0.0785847318,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

rc007_60_4_c304 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0.1358560653,
    distbtwtrueipwphoneavg > 15.47                                    => -0.0613715724,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

rc007_60_6_c304 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0,
    distbtwtrueipwphoneavg > 15.47                                    => rc007_60_6_c305,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

gbm10_wc_lgt_60_c304 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 15.47 => 0.0709461996,
    distbtwtrueipwphoneavg > 15.47                                    => gbm10_wc_lgt_60_c305,
    distbtwtrueipwphoneavg = NULL                                     => -0.0649098657,
                                                                         -0.0649098657);

rc007_60_4_c303 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0,
    tmxidperphoneintxinqcnt3m > 5.5                                       => rc007_60_4_c304,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_60_c303 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0004882883,
    tmxidperphoneintxinqcnt3m > 5.5                                       => gbm10_wc_lgt_60_c304,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0.0003473810,
                                                                             0.0003473810);

rc007_60_6_c303 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0,
    tmxidperphoneintxinqcnt3m > 5.5                                       => rc007_60_6_c304,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc004_60_2_c303 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 5.5 => 0.0001409073,
    tmxidperphoneintxinqcnt3m > 5.5                                       => -0.0652572467,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc004_60_2 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => rc004_60_2_c303,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc004_60_1 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => -0.0002833759,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0.1089679524,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0.0007924886,
                                                                             0);

gbm10_wc_lgt_60 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => gbm10_wc_lgt_60_c303,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0.1095987093,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0.0014232456,
                                                                             0.0006307570);

rc007_60_6 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => rc007_60_6_c303,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc007_60_4 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => rc007_60_4_c303,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc007_61_5_c309 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 789.41 => -0.0276753233,
    distbtwtrueipwphoneavg > 789.41                                    => 0.2987825641,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_61_c309 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 789.41 => 0.0952248485,
    distbtwtrueipwphoneavg > 789.41                                    => 0.4216827359,
    distbtwtrueipwphoneavg = NULL                                      => 0.1229001718,
                                                                          0.1229001718);

rc007_61_5_c308 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 12.5 => rc007_61_5_c309,
    txinqcorremailwnamecnt1y > 12.5                                      => 0,
    txinqcorremailwnamecnt1y = NULL                                      => 0,
                                                                            0);

rc041_61_4_c308 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 12.5 => 0.0727649815,
    txinqcorremailwnamecnt1y > 12.5                                      => -0.3239880483,
    txinqcorremailwnamecnt1y = NULL                                      => -0.1834254460,
                                                                            0);

gbm10_wc_lgt_61_c308 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 12.5 => gbm10_wc_lgt_61_c309,
    txinqcorremailwnamecnt1y > 12.5                                      => -0.2738528580,
    txinqcorremailwnamecnt1y = NULL                                      => -0.1332902557,
                                                                            0.0501351903);

rc007_61_5_c307 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => 0,
    txinqcorremailwphonecnt1m > 7.5                                       => rc007_61_5_c308,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc041_61_4_c307 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => 0,
    txinqcorremailwphonecnt1m > 7.5                                       => rc041_61_4_c308,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc032_61_2_c307 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => -0.0004248527,
    txinqcorremailwphonecnt1m > 7.5                                       => 0.0523147868,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_61_c307 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => -0.0026044493,
    txinqcorremailwphonecnt1m > 7.5                                       => gbm10_wc_lgt_61_c308,
    txinqcorremailwphonecnt1m = NULL                                      => -0.0021795966,
                                                                             -0.0021795966);

rc032_61_1 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 44.5 => -0.0009652068,
    txinqcorremailwphonecnt1m > 44.5                                       => -0.1187322713,
    txinqcorremailwphonecnt1m = NULL                                       => 0.0024865881,
                                                                              0);

rc007_61_5 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 44.5 => rc007_61_5_c307,
    txinqcorremailwphonecnt1m > 44.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

rc041_61_4 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 44.5 => rc041_61_4_c307,
    txinqcorremailwphonecnt1m > 44.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_61 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 44.5 => gbm10_wc_lgt_61_c307,
    txinqcorremailwphonecnt1m > 44.5                                       => -0.1199466611,
    txinqcorremailwphonecnt1m = NULL                                       => 0.0012721983,
                                                                              -0.0012143898);

rc032_61_2 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 44.5 => rc032_61_2_c307,
    txinqcorremailwphonecnt1m > 44.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

rc009_62_8_c313 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 6.5 => 0.0025266659,
    exactidperemailintxinqcnt1m > 6.5                                         => -0.1246285991,
    exactidperemailintxinqcnt1m = NULL                                        => -0.0014181158,
                                                                                 0);

gbm10_wc_lgt_62_c313 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 6.5 => 0.0314479180,
    exactidperemailintxinqcnt1m > 6.5                                         => -0.0957073470,
    exactidperemailintxinqcnt1m = NULL                                        => 0.0275031363,
                                                                                 0.0289212521);

rc009_62_8_c312 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0,
    exactidpertmxidintxinqcnt > 17.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                       => rc009_62_8_c313,
                                                                              0);

rc037_62_5_c312 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => -0.0047579978,
    exactidpertmxidintxinqcnt > 17.5                                       => 0.1607293279,
    exactidpertmxidintxinqcnt = NULL                                       => 0.0002251378,
                                                                              0);

gbm10_wc_lgt_62_c312 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 17.5 => 0.0239381166,
    exactidpertmxidintxinqcnt > 17.5                                       => 0.1894254422,
    exactidpertmxidintxinqcnt = NULL                                       => gbm10_wc_lgt_62_c313,
                                                                              0.0286961143);

rc005_62_3_c311 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 3.5 => -0.3199952717,
    txinqwphonefirst_dayssince > 3.5                                        => 0.0005792652,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc009_62_8_c311 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 3.5 => 0,
    txinqwphonefirst_dayssince > 3.5                                        => rc009_62_8_c312,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_62_c311 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 3.5 => -0.2918784226,
    txinqwphonefirst_dayssince > 3.5                                        => gbm10_wc_lgt_62_c312,
    txinqwphonefirst_dayssince = NULL                                       => 0.0281168491,
                                                                               0.0281168491);

rc037_62_5_c311 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 3.5 => 0,
    txinqwphonefirst_dayssince > 3.5                                        => rc037_62_5_c312,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_62 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => -0.0169196745,
    emailperphoneintxinqcnt > 1.5                                     => gbm10_wc_lgt_62_c311,
    emailperphoneintxinqcnt = NULL                                    => 0.0008813118,
                                                                         -0.0057394502);

rc037_62_5 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc037_62_5_c311,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc033_62_1 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => -0.0111802243,
    emailperphoneintxinqcnt > 1.5                                     => 0.0338562993,
    emailperphoneintxinqcnt = NULL                                    => 0.0066207620,
                                                                         0);

rc009_62_8 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc009_62_8_c311,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc005_62_3 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc005_62_3_c311,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_63_c317 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 450.5 => 0.1407378354,
    txinqwemailfirst_dayssince > 450.5                                        => -0.0706969417,
    txinqwemailfirst_dayssince = NULL                                         => 0.0583674205,
                                                                                 0.0583674205);

rc002_63_7_c317 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 450.5 => 0.0823704150,
    txinqwemailfirst_dayssince > 450.5                                        => -0.1290643622,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_63_c316 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 4703.18 => -0.2089785869,
    timebtwtxinqwphoneavg > 4703.18                                   => gbm10_wc_lgt_63_c317,
    timebtwtxinqwphoneavg = NULL                                      => 0.0244708815,
                                                                         0.0244708815);

rc012_63_5_c316 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 4703.18 => -0.2334494684,
    timebtwtxinqwphoneavg > 4703.18                                   => 0.0338965390,
    timebtwtxinqwphoneavg = NULL                                      => 0,
                                                                         0);

rc002_63_7_c316 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 4703.18 => 0,
    timebtwtxinqwphoneavg > 4703.18                                   => rc002_63_7_c317,
    timebtwtxinqwphoneavg = NULL                                      => 0,
                                                                         0);

gbm10_wc_lgt_63_c315 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 9.5 => -0.0642647671,
    txinqwemaillast_dayssince > 9.5                                       => gbm10_wc_lgt_63_c316,
    txinqwemaillast_dayssince = NULL                                      => -0.0370815639,
                                                                             -0.0292285914);

rc012_63_5_c315 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 9.5 => 0,
    txinqwemaillast_dayssince > 9.5                                       => rc012_63_5_c316,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

rc002_63_7_c315 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 9.5 => 0,
    txinqwemaillast_dayssince > 9.5                                       => rc002_63_7_c316,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

rc029_63_3_c315 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 9.5 => -0.0350361757,
    txinqwemaillast_dayssince > 9.5                                       => 0.0536994729,
    txinqwemaillast_dayssince = NULL                                      => -0.0078529725,
                                                                             0);

gbm10_wc_lgt_63 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0026792712,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_63_c315,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0007044094,
                                                                             0.0019854655);

rc001_63_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0006938057,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0312140569,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0012810561,
                                                                             0);

rc029_63_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc029_63_3_c315,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc012_63_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc012_63_5_c315,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc002_63_7 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc002_63_7_c315,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_64_c321 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 8.5 => 0.5179968936,
    smartidperemailintxinqcnt > 8.5                                       => -0.0255276596,
    smartidperemailintxinqcnt = NULL                                      => 0.2054111798,
                                                                             0.2054111798);

rc042_64_6_c321 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 8.5 => 0.3125857138,
    smartidperemailintxinqcnt > 8.5                                       => -0.2309388394,
    smartidperemailintxinqcnt = NULL                                      => 0,
                                                                             0);

rc042_64_6_c320 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 178.5 => 0,
    txinqwemailfirst_dayssince > 178.5                                        => rc042_64_6_c321,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc002_64_4_c320 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 178.5 => -0.3417753994,
    txinqwemailfirst_dayssince > 178.5                                        => 0.1087703111,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_64_c320 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 178.5 => -0.2451345307,
    txinqwemailfirst_dayssince > 178.5                                        => gbm10_wc_lgt_64_c321,
    txinqwemailfirst_dayssince = NULL                                         => 0.0966408687,
                                                                                 0.0966408687);

gbm10_wc_lgt_64_c319 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 0.5 => gbm10_wc_lgt_64_c320,
    exactidpertmxidintxinqcnt > 0.5                                       => -0.0826529020,
    exactidpertmxidintxinqcnt = NULL                                      => -0.0165475261,
                                                                             -0.0230590913);

rc002_64_4_c319 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 0.5 => rc002_64_4_c320,
    exactidpertmxidintxinqcnt > 0.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                      => 0,
                                                                             0);

rc042_64_6_c319 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 0.5 => rc042_64_6_c320,
    exactidpertmxidintxinqcnt > 0.5                                       => 0,
    exactidpertmxidintxinqcnt = NULL                                      => 0,
                                                                             0);

rc037_64_3_c319 := map(
    NULL < exactidpertmxidintxinqcnt AND exactidpertmxidintxinqcnt <= 0.5 => 0.1196999599,
    exactidpertmxidintxinqcnt > 0.5                                       => -0.0595938107,
    exactidpertmxidintxinqcnt = NULL                                      => 0.0065115651,
                                                                             0);

rc003_64_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0028608764,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0275304428,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0039082330,
                                                                                 0);

rc037_64_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc037_64_3_c319,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc042_64_6 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc042_64_6_c319,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_64 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0073322279,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_64_c319,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0005631185,
                                                                                 0.0044713515);

rc002_64_4 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc002_64_4_c319,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_65_c325 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 5.5 => 0.1850434347,
    tmxidperphoneintxinqcnt1y > 5.5                                       => 0.3241983070,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0.2073169457,
                                                                             0.2073169457);

rc031_65_5_c325 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 5.5 => -0.0222735110,
    tmxidperphoneintxinqcnt1y > 5.5                                       => 0.1168813612,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc031_65_5_c324 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 133.86 => rc031_65_5_c325,
    distbtwtrueipwphoneavg > 133.86                                    => 0,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

rc007_65_4_c324 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 133.86 => 0.1097060710,
    distbtwtrueipwphoneavg > 133.86                                    => -0.0992482657,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_65_c324 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 133.86 => gbm10_wc_lgt_65_c325,
    distbtwtrueipwphoneavg > 133.86                                    => -0.0016373910,
    distbtwtrueipwphoneavg = NULL                                      => 0.0976108748,
                                                                          0.0976108748);

rc007_65_4_c323 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 2.5 => 0,
    emailperphoneintxinqcnt1y > 2.5                                       => rc007_65_4_c324,
    emailperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc045_65_2_c323 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 2.5 => 0.0020705658,
    emailperphoneintxinqcnt1y > 2.5                                       => 0.1487763672,
    emailperphoneintxinqcnt1y = NULL                                      => -0.0226163255,
                                                                             0);

gbm10_wc_lgt_65_c323 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 2.5 => -0.0490949266,
    emailperphoneintxinqcnt1y > 2.5                                       => gbm10_wc_lgt_65_c324,
    emailperphoneintxinqcnt1y = NULL                                      => -0.0737818179,
                                                                             -0.0511654924);

rc031_65_5_c323 := map(
    NULL < emailperphoneintxinqcnt1y AND emailperphoneintxinqcnt1y <= 2.5 => 0,
    emailperphoneintxinqcnt1y > 2.5                                       => rc031_65_5_c324,
    emailperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc009_65_1 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => -0.0312840774,
    exactidperemailintxinqcnt1m > 0.5                                         => 0.0390232920,
    exactidperemailintxinqcnt1m = NULL                                        => 0.0143591949,
                                                                                 0);

rc031_65_5 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => rc031_65_5_c323,
    exactidperemailintxinqcnt1m > 0.5                                         => 0,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc007_65_4 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => rc007_65_4_c323,
    exactidperemailintxinqcnt1m > 0.5                                         => 0,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc045_65_2 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => rc045_65_2_c323,
    exactidperemailintxinqcnt1m > 0.5                                         => 0,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_65 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => gbm10_wc_lgt_65_c323,
    exactidperemailintxinqcnt1m > 0.5                                         => 0.0191418770,
    exactidperemailintxinqcnt1m = NULL                                        => -0.0055222201,
                                                                                 -0.0198814150);

rc018_66_4_c328 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 10.5 => 0.0353151778,
    txinqwemailcnt6m > 10.5                              => -0.0916847223,
    txinqwemailcnt6m = NULL                              => 0,
                                                            0);

gbm10_wc_lgt_66_c328 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 10.5 => -0.0156422485,
    txinqwemailcnt6m > 10.5                              => -0.1426421486,
    txinqwemailcnt6m = NULL                              => -0.0509574263,
                                                            -0.0509574263);

gbm10_wc_lgt_66_c329 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 5.5 => 0.2045195534,
    exactidperphoneintxinqcnt3m > 5.5                                         => -0.1115891189,
    exactidperphoneintxinqcnt3m = NULL                                        => 0.0636126213,
                                                                                 0.0636126213);

rc021_66_8_c329 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 5.5 => 0.1409069321,
    exactidperphoneintxinqcnt3m > 5.5                                         => -0.1752017402,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc021_66_8_c327 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 6.5 => 0,
    smartidperemailintxinqcnt3m > 6.5                                         => rc021_66_8_c329,
    smartidperemailintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc018_66_4_c327 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 6.5 => rc018_66_4_c328,
    smartidperemailintxinqcnt3m > 6.5                                         => 0,
    smartidperemailintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_66_c327 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 6.5 => gbm10_wc_lgt_66_c328,
    smartidperemailintxinqcnt3m > 6.5                                         => gbm10_wc_lgt_66_c329,
    smartidperemailintxinqcnt3m = NULL                                        => -0.0358158758,
                                                                                 -0.0348386908);

rc019_66_3_c327 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 6.5 => -0.0161187355,
    smartidperemailintxinqcnt3m > 6.5                                         => 0.0984513121,
    smartidperemailintxinqcnt3m = NULL                                        => -0.0009771850,
                                                                                 0);

rc018_66_4 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc018_66_4_c327,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc021_66_8 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc021_66_8_c327,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_66_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => -0.0000776839,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0372291155,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0015787328,
                                                                             0);

rc019_66_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc019_66_3_c327,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_66 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0023127407,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_66_c327,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0039691574,
                                                                             0.0023904247);

rc003_67_4_c333 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0018485273,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.1192430390,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_67_c333 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0.0461767957,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.1672683621,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0480253231,
                                                                                 0.0480253231);

gbm10_wc_lgt_67_c332 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => gbm10_wc_lgt_67_c333,
    txinqcorremailwphonecnt1m > 21.5                                       => -0.2001550262,
    txinqcorremailwphonecnt1m = NULL                                       => 0.1213129363,
                                                                              0.0513912695);

rc003_67_4_c332 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => rc003_67_4_c333,
    txinqcorremailwphonecnt1m > 21.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

rc032_67_3_c332 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => -0.0033659465,
    txinqcorremailwphonecnt1m > 21.5                                       => -0.2515462957,
    txinqcorremailwphonecnt1m = NULL                                       => 0.0699216668,
                                                                              0);

gbm10_wc_lgt_67_c331 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 705.5 => gbm10_wc_lgt_67_c332,
    txinqwphonefirst_dayssince > 705.5                                        => 0.2753463004,
    txinqwphonefirst_dayssince = NULL                                         => 0.0543177408,
                                                                                 0.0543177408);

rc003_67_4_c331 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 705.5 => rc003_67_4_c332,
    txinqwphonefirst_dayssince > 705.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc032_67_3_c331 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 705.5 => rc032_67_3_c332,
    txinqwphonefirst_dayssince > 705.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc005_67_2_c331 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 705.5 => -0.0029264713,
    txinqwphonefirst_dayssince > 705.5                                        => 0.2210285596,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc012_67_1 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => 0.0591496792,
    timebtwtxinqwphoneavg > 1404.665                                   => 0.0025395857,
    timebtwtxinqwphoneavg = NULL                                       => -0.0047682279,
                                                                          0);

rc005_67_2 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => rc005_67_2_c331,
    timebtwtxinqwphoneavg > 1404.665                                   => 0,
    timebtwtxinqwphoneavg = NULL                                       => 0,
                                                                          0);

rc032_67_3 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => rc032_67_3_c331,
    timebtwtxinqwphoneavg > 1404.665                                   => 0,
    timebtwtxinqwphoneavg = NULL                                       => 0,
                                                                          0);

rc003_67_4 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => rc003_67_4_c331,
    timebtwtxinqwphoneavg > 1404.665                                   => 0,
    timebtwtxinqwphoneavg = NULL                                       => 0,
                                                                          0);

gbm10_wc_lgt_67 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1404.665 => gbm10_wc_lgt_67_c331,
    timebtwtxinqwphoneavg > 1404.665                                   => -0.0022923527,
    timebtwtxinqwphoneavg = NULL                                       => -0.0096001663,
                                                                          -0.0048319384);

gbm10_wc_lgt_68_c337 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 139.5 => 0.1552979295,
    txinqwphonefirst_dayssince > 139.5                                        => -0.0993323269,
    txinqwphonefirst_dayssince = NULL                                         => 0.0141611077,
                                                                                 0.0141611077);

rc005_68_7_c337 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 139.5 => 0.1411368218,
    txinqwphonefirst_dayssince > 139.5                                        => -0.1134934346,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc013_68_5_c336 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 573.5 => -0.0337491766,
    txinqwnamefirst_dayssince > 573.5                                       => 0.0360736686,
    txinqwnamefirst_dayssince = NULL                                        => 0.0641967537,
                                                                               0);

gbm10_wc_lgt_68_c336 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 573.5 => -0.0556617376,
    txinqwnamefirst_dayssince > 573.5                                       => gbm10_wc_lgt_68_c337,
    txinqwnamefirst_dayssince = NULL                                        => 0.0422841927,
                                                                               -0.0219125610);

rc005_68_7_c336 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 573.5 => 0,
    txinqwnamefirst_dayssince > 573.5                                       => rc005_68_7_c337,
    txinqwnamefirst_dayssince = NULL                                        => 0,
                                                                               0);

rc005_68_7_c335 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => 0,
    txinqwphonecnt1y > 3.5                              => rc005_68_7_c336,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

gbm10_wc_lgt_68_c335 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => -0.2315167674,
    txinqwphonecnt1y > 3.5                              => gbm10_wc_lgt_68_c336,
    txinqwphonecnt1y = NULL                             => -0.0301807984,
                                                           -0.0301807984);

rc013_68_5_c335 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => 0,
    txinqwphonecnt1y > 3.5                              => rc013_68_5_c336,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

rc010_68_3_c335 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => -0.2013359690,
    txinqwphonecnt1y > 3.5                              => 0.0082682374,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

rc010_68_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc010_68_3_c335,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_68_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => -0.0004962681,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0324525532,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0028469879,
                                                                             0);

rc005_68_7 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc005_68_7_c335,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_68 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0017754867,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_68_c335,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0051187427,
                                                                             0.0022717548);

rc013_68_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc013_68_5_c335,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_69_c341 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 5.5 => 0.0047494786,
    orgidperemailintxinqcnt > 5.5                                     => 0.4678172775,
    orgidperemailintxinqcnt = NULL                                    => 0.1843208489,
                                                                         0.1843208489);

rc043_69_6_c341 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 5.5 => -0.1795713703,
    orgidperemailintxinqcnt > 5.5                                     => 0.2834964286,
    orgidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

rc040_69_4_c340 := map(
    NULL < proxyipperemailintxinqcnt AND proxyipperemailintxinqcnt <= 4.5 => -0.0090866537,
    proxyipperemailintxinqcnt > 4.5                                       => 0.1829157586,
    proxyipperemailintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_69_c340 := map(
    NULL < proxyipperemailintxinqcnt AND proxyipperemailintxinqcnt <= 4.5 => -0.0076815635,
    proxyipperemailintxinqcnt > 4.5                                       => gbm10_wc_lgt_69_c341,
    proxyipperemailintxinqcnt = NULL                                      => 0.0014050902,
                                                                             0.0014050902);

rc043_69_6_c340 := map(
    NULL < proxyipperemailintxinqcnt AND proxyipperemailintxinqcnt <= 4.5 => 0,
    proxyipperemailintxinqcnt > 4.5                                       => rc043_69_6_c341,
    proxyipperemailintxinqcnt = NULL                                      => 0,
                                                                             0);

rc055_69_3_c339 := map(
    NULL < browserhashperemailintxinqcnt AND browserhashperemailintxinqcnt <= 8.5 => 0.0308882883,
    browserhashperemailintxinqcnt > 8.5                                           => -0.0546225484,
    browserhashperemailintxinqcnt = NULL                                          => 0.0515454997,
                                                                                     0);

rc043_69_6_c339 := map(
    NULL < browserhashperemailintxinqcnt AND browserhashperemailintxinqcnt <= 8.5 => rc043_69_6_c340,
    browserhashperemailintxinqcnt > 8.5                                           => 0,
    browserhashperemailintxinqcnt = NULL                                          => 0,
                                                                                     0);

gbm10_wc_lgt_69_c339 := map(
    NULL < browserhashperemailintxinqcnt AND browserhashperemailintxinqcnt <= 8.5 => gbm10_wc_lgt_69_c340,
    browserhashperemailintxinqcnt > 8.5                                           => -0.0841057465,
    browserhashperemailintxinqcnt = NULL                                          => 0.0220623016,
                                                                                     -0.0294831981);

rc040_69_4_c339 := map(
    NULL < browserhashperemailintxinqcnt AND browserhashperemailintxinqcnt <= 8.5 => rc040_69_4_c340,
    browserhashperemailintxinqcnt > 8.5                                           => 0,
    browserhashperemailintxinqcnt = NULL                                          => 0,
                                                                                     0);

rc055_69_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc055_69_3_c339,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_69 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0065133650,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_69_c339,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0040734934,
                                                                                 0.0043734047);

rc043_69_6 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc043_69_6_c339,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc040_69_4 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc040_69_4_c339,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_69_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0021399603,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0338566028,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0002999113,
                                                                                 0);

rc011_70_5_c345 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 35.455 => 0.2972753951,
    distbtwtrueipwemailavg > 35.455                                    => -0.1526710536,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_70_c345 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 35.455 => 0.5522349880,
    distbtwtrueipwemailavg > 35.455                                    => 0.1022885393,
    distbtwtrueipwemailavg = NULL                                      => 0.2549595929,
                                                                          0.2549595929);

rc011_70_5_c344 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 648 => rc011_70_5_c345,
    txinqwaddrfirst_dayssince > 648                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                      => 0,
                                                                             0);

rc016_70_4_c344 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 648 => 0.0924325831,
    txinqwaddrfirst_dayssince > 648                                       => -0.4018712337,
    txinqwaddrfirst_dayssince = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_70_c344 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 648 => gbm10_wc_lgt_70_c345,
    txinqwaddrfirst_dayssince > 648                                       => -0.2393442239,
    txinqwaddrfirst_dayssince = NULL                                      => 0.1625270098,
                                                                             0.1625270098);

rc044_70_2_c343 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 9.5 => -0.0007092664,
    exactidperemailintxinqcnt3m > 9.5                                         => 0.1624937073,
    exactidperemailintxinqcnt3m = NULL                                        => -0.0650391933,
                                                                                 0);

rc011_70_5_c343 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 9.5 => 0,
    exactidperemailintxinqcnt3m > 9.5                                         => rc011_70_5_c344,
    exactidperemailintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_70_c343 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 9.5 => -0.0006759639,
    exactidperemailintxinqcnt3m > 9.5                                         => gbm10_wc_lgt_70_c344,
    exactidperemailintxinqcnt3m = NULL                                        => -0.0650058908,
                                                                                 0.0000333025);

rc016_70_4_c343 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 9.5 => 0,
    exactidperemailintxinqcnt3m > 9.5                                         => rc016_70_4_c344,
    exactidperemailintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc035_70_1 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => 0.0018987307,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0.2720737125,
    txinqwtmxidfirst_dayssince = NULL                                         => -0.0003708047,
                                                                                 0);

gbm10_wc_lgt_70 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => gbm10_wc_lgt_70_c343,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0.2702082843,
    txinqwtmxidfirst_dayssince = NULL                                         => -0.0022362329,
                                                                                 -0.0018654282);

rc016_70_4 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => rc016_70_4_c343,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc044_70_2 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => rc044_70_2_c343,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc011_70_5 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => rc011_70_5_c343,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc008_71_4_c348 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 2.5 => 0.0565150936,
    smartidperemailintxinqcnt1m > 2.5                                         => -0.2385995329,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_71_c348 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 2.5 => -0.0353611372,
    smartidperemailintxinqcnt1m > 2.5                                         => -0.3304757637,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0918762307,
                                                                                 -0.0918762307);

rc001_71_2_c347 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => 0.0002186392,
    emailperphoneintxinqcnt3m > 3.5                                       => -0.0915850016,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc008_71_4_c347 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => 0,
    emailperphoneintxinqcnt3m > 3.5                                       => rc008_71_4_c348,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_71_c347 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => -0.0000725899,
    emailperphoneintxinqcnt3m > 3.5                                       => gbm10_wc_lgt_71_c348,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0002912292,
                                                                             -0.0002912292);

gbm10_wc_lgt_71_c349 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 20.13 => 0.1740445035,
    distbtwtrueipwphoneavg > 20.13                                    => 0.0060460477,
    distbtwtrueipwphoneavg = NULL                                     => 0.0499785782,
                                                                         0.0499785782);

rc007_71_9_c349 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 20.13 => 0.1240659253,
    distbtwtrueipwphoneavg > 20.13                                    => -0.0439325304,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

gbm10_wc_lgt_71 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 7.5 => gbm10_wc_lgt_71_c347,
    tmxidperphoneintxinqcnt1y > 7.5                                       => gbm10_wc_lgt_71_c349,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0.0036087762,
                                                                             0.0007158011);

rc031_71_1 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 7.5 => -0.0010070303,
    tmxidperphoneintxinqcnt1y > 7.5                                       => 0.0492627770,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0.0028929751,
                                                                             0);

rc008_71_4 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 7.5 => rc008_71_4_c347,
    tmxidperphoneintxinqcnt1y > 7.5                                       => 0,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc007_71_9 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 7.5 => 0,
    tmxidperphoneintxinqcnt1y > 7.5                                       => rc007_71_9_c349,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc001_71_2 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 7.5 => rc001_71_2_c347,
    tmxidperphoneintxinqcnt1y > 7.5                                       => 0,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc032_72_4_c353 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 6.5 => -0.0077628864,
    txinqcorremailwphonecnt1m > 6.5                                       => 0.1865960492,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0216452154,
                                                                             0);

gbm10_wc_lgt_72_c353 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 6.5 => -0.0064866044,
    txinqcorremailwphonecnt1m > 6.5                                       => 0.1878723312,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0229214974,
                                                                             0.0012762820);

rc032_72_4_c352 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => rc032_72_4_c353,
    phoneperemailintxinqcnt1m > 2.5                                       => 0,
    phoneperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc039_72_3_c352 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => 0.0024851085,
    phoneperemailintxinqcnt1m > 2.5                                       => -0.1643353217,
    phoneperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_72_c352 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => gbm10_wc_lgt_72_c353,
    phoneperemailintxinqcnt1m > 2.5                                       => -0.1655441482,
    phoneperemailintxinqcnt1m = NULL                                      => -0.0012088265,
                                                                             -0.0012088265);

gbm10_wc_lgt_72_c351 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 39.025 => gbm10_wc_lgt_72_c352,
    distbtwtrueipwemailavg > 39.025                                    => 0.0922768043,
    distbtwtrueipwemailavg = NULL                                      => 0.0190145184,
                                                                          0.0254747412);

rc011_72_2_c351 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 39.025 => -0.0266835677,
    distbtwtrueipwemailavg > 39.025                                    => 0.0668020631,
    distbtwtrueipwemailavg = NULL                                      => -0.0064602228,
                                                                          0);

rc039_72_3_c351 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 39.025 => rc039_72_3_c352,
    distbtwtrueipwemailavg > 39.025                                    => 0,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

rc032_72_4_c351 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 39.025 => rc032_72_4_c352,
    distbtwtrueipwemailavg > 39.025                                    => 0,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

rc011_72_2 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 245.5 => rc011_72_2_c351,
    txinqwemailfirst_dayssince > 245.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc002_72_1 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 245.5 => 0.0300891644,
    txinqwemailfirst_dayssince > 245.5                                        => -0.0115124714,
    txinqwemailfirst_dayssince = NULL                                         => -0.0012468056,
                                                                                 0);

rc039_72_3 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 245.5 => rc039_72_3_c351,
    txinqwemailfirst_dayssince > 245.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc032_72_4 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 245.5 => rc032_72_4_c351,
    txinqwemailfirst_dayssince > 245.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_72 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 245.5 => gbm10_wc_lgt_72_c351,
    txinqwemailfirst_dayssince > 245.5                                        => -0.0161268945,
    txinqwemailfirst_dayssince = NULL                                         => -0.0058612288,
                                                                                 -0.0046144232);

gbm10_wc_lgt_73_c355 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 18.5 => -0.0000611745,
    smartidperemailintxinqcnt1m > 18.5                                         => -0.2374858678,
    smartidperemailintxinqcnt1m = NULL                                         => -0.0001853891,
                                                                                  -0.0001853891);

rc008_73_2_c355 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 18.5 => 0.0001242146,
    smartidperemailintxinqcnt1m > 18.5                                         => -0.2373004786,
    smartidperemailintxinqcnt1m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_73_c357 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 0.5 => -0.3209299585,
    emailperphoneintxinqcnt6m > 0.5                                       => 0.4593108229,
    emailperphoneintxinqcnt6m = NULL                                      => 0.0952083582,
                                                                             0.0952083582);

rc014_73_9_c357 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 0.5 => -0.4161383168,
    emailperphoneintxinqcnt6m > 0.5                                       => 0.3641024647,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

rc014_73_9_c356 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 97 => 0,
    txinqwaddrlast_dayssince > 97                                      => 0,
    txinqwaddrlast_dayssince = NULL                                    => rc014_73_9_c357,
                                                                          0);

rc025_73_6_c356 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 97 => -0.3069580098,
    txinqwaddrlast_dayssince > 97                                      => 0.4345707104,
    txinqwaddrlast_dayssince = NULL                                    => -0.0479276873,
                                                                          0);

gbm10_wc_lgt_73_c356 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 97 => -0.1638219643,
    txinqwaddrlast_dayssince > 97                                      => 0.5777067559,
    txinqwaddrlast_dayssince = NULL                                    => gbm10_wc_lgt_73_c357,
                                                                          0.1431360455);

rc008_73_2 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 57.5 => rc008_73_2_c355,
    exactidperemailintxinqcnt > 57.5                                       => 0,
    exactidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

rc047_73_1 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 57.5 => 0.0004788926,
    exactidperemailintxinqcnt > 57.5                                       => 0.1438003272,
    exactidperemailintxinqcnt = NULL                                       => -0.0040520005,
                                                                              0);

gbm10_wc_lgt_73 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 57.5 => gbm10_wc_lgt_73_c355,
    exactidperemailintxinqcnt > 57.5                                       => gbm10_wc_lgt_73_c356,
    exactidperemailintxinqcnt = NULL                                       => -0.0047162822,
                                                                              -0.0006642817);

rc025_73_6 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 57.5 => 0,
    exactidperemailintxinqcnt > 57.5                                       => rc025_73_6_c356,
    exactidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

rc014_73_9 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 57.5 => 0,
    exactidperemailintxinqcnt > 57.5                                       => rc014_73_9_c356,
    exactidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

rc036_74_5_c360 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 3.5 => 0.3607433217,
    trueipperemailintxinqcnt > 3.5                                      => -0.0188456209,
    trueipperemailintxinqcnt = NULL                                     => 0,
                                                                           0);

gbm10_wc_lgt_74_c360 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 3.5 => 0.4757750277,
    trueipperemailintxinqcnt > 3.5                                      => 0.0961860851,
    trueipperemailintxinqcnt = NULL                                     => 0.1150317060,
                                                                           0.1150317060);

gbm10_wc_lgt_74_c361 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => -0.1414417351,
    smartidperphoneintxinqcnt1m > 1.5                                         => 0.2635472171,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0791215943,
                                                                                 -0.0504476217);

rc003_74_9_c361 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => -0.0909941133,
    smartidperphoneintxinqcnt1m > 1.5                                         => 0.3139948388,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.1295692161,
                                                                                 0);

rc013_74_3_c359 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 87.5 => -0.1065800943,
    txinqwnamefirst_dayssince > 87.5                                       => 0.0891161418,
    txinqwnamefirst_dayssince = NULL                                       => -0.0763631859,
                                                                              0);

gbm10_wc_lgt_74_c359 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 87.5 => -0.0806645301,
    txinqwnamefirst_dayssince > 87.5                                       => gbm10_wc_lgt_74_c360,
    txinqwnamefirst_dayssince = NULL                                       => gbm10_wc_lgt_74_c361,
                                                                              0.0259155642);

rc036_74_5_c359 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 87.5 => 0,
    txinqwnamefirst_dayssince > 87.5                                       => rc036_74_5_c360,
    txinqwnamefirst_dayssince = NULL                                       => 0,
                                                                              0);

rc003_74_9_c359 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 87.5 => 0,
    txinqwnamefirst_dayssince > 87.5                                       => 0,
    txinqwnamefirst_dayssince = NULL                                       => rc003_74_9_c361,
                                                                              0);

gbm10_wc_lgt_74 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => -0.0035686710,
    phoneperemailintxinqcnt1y > 3.5                                       => gbm10_wc_lgt_74_c359,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0037906940,
                                                                             -0.0030787719);

rc013_74_3 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => 0,
    phoneperemailintxinqcnt1y > 3.5                                       => rc013_74_3_c359,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc003_74_9 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => 0,
    phoneperemailintxinqcnt1y > 3.5                                       => rc003_74_9_c359,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc020_74_1 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => -0.0004898991,
    phoneperemailintxinqcnt1y > 3.5                                       => 0.0289943361,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0007119221,
                                                                             0);

rc036_74_5 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 3.5 => 0,
    phoneperemailintxinqcnt1y > 3.5                                       => rc036_74_5_c359,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc034_75_4_c364 := map(
    NULL < dnsipperemailintxinqcnt AND dnsipperemailintxinqcnt <= 5.5 => -0.2063645978,
    dnsipperemailintxinqcnt > 5.5                                     => 0.0707857056,
    dnsipperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_75_c364 := map(
    NULL < dnsipperemailintxinqcnt AND dnsipperemailintxinqcnt <= 5.5 => -0.3155775799,
    dnsipperemailintxinqcnt > 5.5                                     => -0.0384272765,
    dnsipperemailintxinqcnt = NULL                                    => -0.1092129821,
                                                                         -0.1092129821);

rc034_75_4_c363 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 7.5 => 0,
    exactidperphoneintxinqcnt3m > 7.5                                         => rc034_75_4_c364,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc021_75_2_c363 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 7.5 => 0.0002620041,
    exactidperphoneintxinqcnt3m > 7.5                                         => -0.1059354233,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_75_c363 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 7.5 => -0.0030155547,
    exactidperphoneintxinqcnt3m > 7.5                                         => gbm10_wc_lgt_75_c364,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0032775588,
                                                                                 -0.0032775588);

gbm10_wc_lgt_75_c365 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 11.5 => 0.0466850541,
    smartidperemailintxinqcnt3m > 11.5                                         => 0.2586168456,
    smartidperemailintxinqcnt3m = NULL                                         => -0.0749654267,
                                                                                  0.0391133934);

rc019_75_9_c365 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 11.5 => 0.0075716606,
    smartidperemailintxinqcnt3m > 11.5                                         => 0.2195034522,
    smartidperemailintxinqcnt3m = NULL                                         => -0.1140788202,
                                                                                  0);

rc019_75_9 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => 0,
    loginidperphoneintxinqcnt > 2.5                                       => rc019_75_9_c365,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_75 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => gbm10_wc_lgt_75_c363,
    loginidperphoneintxinqcnt > 2.5                                       => gbm10_wc_lgt_75_c365,
    loginidperphoneintxinqcnt = NULL                                      => 0.0033308610,
                                                                             -0.0006979783);

rc015_75_1 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => -0.0025795805,
    loginidperphoneintxinqcnt > 2.5                                       => 0.0398113717,
    loginidperphoneintxinqcnt = NULL                                      => 0.0040288393,
                                                                             0);

rc021_75_2 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => rc021_75_2_c363,
    loginidperphoneintxinqcnt > 2.5                                       => 0,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc034_75_4 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => rc034_75_4_c363,
    loginidperphoneintxinqcnt > 2.5                                       => 0,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_76_c367 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 26.5 => 0.0009972953,
    trueipperphoneintxinqcnt > 26.5                                      => 0.1156350377,
    trueipperphoneintxinqcnt = NULL                                      => 0.0013722145,
                                                                            0.0013722145);

rc017_76_2_c367 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 26.5 => -0.0003749192,
    trueipperphoneintxinqcnt > 26.5                                      => 0.1142628232,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

rc015_76_9_c369 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 4.5 => -0.0437510539,
    loginidperphoneintxinqcnt > 4.5                                       => 0.3477977271,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_76_c369 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 4.5 => -0.1656079729,
    loginidperphoneintxinqcnt > 4.5                                       => 0.2259408081,
    loginidperphoneintxinqcnt = NULL                                      => -0.1218569190,
                                                                             -0.1218569190);

rc041_76_6_c368 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 6.5 => -0.0008222308,
    txinqcorremailwnamecnt1y > 6.5                                      => 0.4559765467,
    txinqcorremailwnamecnt1y = NULL                                     => -0.0275709254,
                                                                           0);

gbm10_wc_lgt_76_c368 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 6.5 => -0.0951082244,
    txinqcorremailwnamecnt1y > 6.5                                      => 0.3616905531,
    txinqcorremailwnamecnt1y = NULL                                     => gbm10_wc_lgt_76_c369,
                                                                           -0.0942859936);

rc015_76_9_c368 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 6.5 => 0,
    txinqcorremailwnamecnt1y > 6.5                                      => 0,
    txinqcorremailwnamecnt1y = NULL                                     => rc015_76_9_c369,
                                                                           0);

rc015_76_9 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => 0,
    browserhashperphoneintxinqcnt > 15.5                                           => rc015_76_9_c368,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc017_76_2 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => rc017_76_2_c367,
    browserhashperphoneintxinqcnt > 15.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc038_76_1 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => 0.0011512289,
    browserhashperphoneintxinqcnt > 15.5                                           => -0.0945069792,
    browserhashperphoneintxinqcnt = NULL                                           => 0.0024346125,
                                                                                      0);

rc041_76_6 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => 0,
    browserhashperphoneintxinqcnt > 15.5                                           => rc041_76_6_c368,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

gbm10_wc_lgt_76 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 15.5 => gbm10_wc_lgt_76_c367,
    browserhashperphoneintxinqcnt > 15.5                                           => gbm10_wc_lgt_76_c368,
    browserhashperphoneintxinqcnt = NULL                                           => 0.0026555981,
                                                                                      0.0002209856);

rc038_77_4_c372 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 8.5 => 0.0903885309,
    browserhashperphoneintxinqcnt > 8.5                                           => -0.1541727321,
    browserhashperphoneintxinqcnt = NULL                                          => 0,
                                                                                     0);

gbm10_wc_lgt_77_c372 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 8.5 => 0.1798747101,
    browserhashperphoneintxinqcnt > 8.5                                           => -0.0646865529,
    browserhashperphoneintxinqcnt = NULL                                          => 0.0894861793,
                                                                                     0.0894861793);

rc032_77_2_c371 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 8.5 => -0.0004919913,
    txinqcorremailwphonecnt1m > 8.5                                       => 0.0914759698,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc038_77_4_c371 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 8.5 => 0,
    txinqcorremailwphonecnt1m > 8.5                                       => rc038_77_4_c372,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_77_c371 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 8.5 => -0.0024817819,
    txinqcorremailwphonecnt1m > 8.5                                       => gbm10_wc_lgt_77_c372,
    txinqcorremailwphonecnt1m = NULL                                      => -0.0019897906,
                                                                             -0.0019897906);

gbm10_wc_lgt_77_c373 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 81.05 => -0.0701415595,
    distbtwtrueipwphoneavg > 81.05                                    => -0.1398004962,
    distbtwtrueipwphoneavg = NULL                                     => -0.1120619731,
                                                                         -0.1120619731);

rc007_77_9_c373 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 81.05 => 0.0419204136,
    distbtwtrueipwphoneavg > 81.05                                    => -0.0277385232,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

rc007_77_9 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => 0,
    txinqcorremailwphonecnt1m > 21.5                                       => rc007_77_9_c373,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

rc032_77_1 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => -0.0013778213,
    txinqcorremailwphonecnt1m > 21.5                                       => -0.1114500038,
    txinqcorremailwphonecnt1m = NULL                                       => 0.0038221814,
                                                                              0);

rc038_77_4 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => rc038_77_4_c371,
    txinqcorremailwphonecnt1m > 21.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

rc032_77_2 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => rc032_77_2_c371,
    txinqcorremailwphonecnt1m > 21.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_77 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => gbm10_wc_lgt_77_c371,
    txinqcorremailwphonecnt1m > 21.5                                       => gbm10_wc_lgt_77_c373,
    txinqcorremailwphonecnt1m = NULL                                       => 0.0032102121,
                                                                              -0.0006119693);

rc008_78_4_c376 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 9.5 => 0.0057227326,
    smartidperemailintxinqcnt1m > 9.5                                         => -0.1496861860,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_78_c376 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 9.5 => -0.0442958806,
    smartidperemailintxinqcnt1m > 9.5                                         => -0.1997047993,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0500186132,
                                                                                 -0.0500186132);

gbm10_wc_lgt_78_c377 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0.1543229958,
    txinqcorremailwphonecnt > 0.5                                     => -0.0210735505,
    txinqcorremailwphonecnt = NULL                                    => -0.0022608798,
                                                                         -0.0022608798);

rc023_78_8_c377 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0.1565838755,
    txinqcorremailwphonecnt > 0.5                                     => -0.0188126707,
    txinqcorremailwphonecnt = NULL                                    => 0,
                                                                         0);

rc006_78_3_c375 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 7191.265 => -0.0335480014,
    timebtwtxinqwemailavg > 7191.265                                   => 0.0142097321,
    timebtwtxinqwemailavg = NULL                                       => 0.0185950016,
                                                                          0);

gbm10_wc_lgt_78_c375 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 7191.265 => gbm10_wc_lgt_78_c376,
    timebtwtxinqwemailavg > 7191.265                                   => gbm10_wc_lgt_78_c377,
    timebtwtxinqwemailavg = NULL                                       => 0.0021243897,
                                                                          -0.0164706119);

rc023_78_8_c375 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 7191.265 => 0,
    timebtwtxinqwemailavg > 7191.265                                   => rc023_78_8_c377,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc008_78_4_c375 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 7191.265 => rc008_78_4_c376,
    timebtwtxinqwemailavg > 7191.265                                   => 0,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc003_78_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0021321830,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0207991955,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0028571816,
                                                                                 0);

rc006_78_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc006_78_3_c375,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc008_78_4 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc008_78_4_c375,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc023_78_8 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc023_78_8_c375,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_78 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0064607666,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_78_c375,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0014714019,
                                                                                 0.0043285836);

rc026_79_4_c380 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 13.5 => -0.0856924854,
    txinqwnamelast_dayssince > 13.5                                      => 0.1548904352,
    txinqwnamelast_dayssince = NULL                                      => 0.0072422312,
                                                                            0);

gbm10_wc_lgt_79_c380 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 13.5 => -0.1110497410,
    txinqwnamelast_dayssince > 13.5                                      => 0.1295331796,
    txinqwnamelast_dayssince = NULL                                      => -0.0181150244,
                                                                            -0.0253572556);

gbm10_wc_lgt_79_c381 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 15168.765 => -0.0535476932,
    timebtwtxinqwphoneavg > 15168.765                                   => 0.2775241875,
    timebtwtxinqwphoneavg = NULL                                        => 0.0707068189,
                                                                           0.0707068189);

rc012_79_9_c381 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 15168.765 => -0.1242545121,
    timebtwtxinqwphoneavg > 15168.765                                   => 0.2068173686,
    timebtwtxinqwphoneavg = NULL                                        => 0,
                                                                           0);

rc012_79_9_c379 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 1.5 => 0,
    txinqcorremailwnamecnt1y > 1.5                                      => 0,
    txinqcorremailwnamecnt1y = NULL                                     => rc012_79_9_c381,
                                                                           0);

gbm10_wc_lgt_79_c379 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 1.5 => gbm10_wc_lgt_79_c380,
    txinqcorremailwnamecnt1y > 1.5                                      => 0.1383835584,
    txinqcorremailwnamecnt1y = NULL                                     => gbm10_wc_lgt_79_c381,
                                                                           0.0320243499);

rc026_79_4_c379 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 1.5 => rc026_79_4_c380,
    txinqcorremailwnamecnt1y > 1.5                                      => 0,
    txinqcorremailwnamecnt1y = NULL                                     => 0,
                                                                           0);

rc041_79_3_c379 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 1.5 => -0.0573816055,
    txinqcorremailwnamecnt1y > 1.5                                      => 0.1063592085,
    txinqcorremailwnamecnt1y = NULL                                     => 0.0386824690,
                                                                           0);

gbm10_wc_lgt_79 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0024489146,
    smartidperphoneintxinqcnt1m > 3.5                                         => gbm10_wc_lgt_79_c379,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0011753461,
                                                                                 -0.0014452607);

rc003_79_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0010036539,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.0334696106,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0026206068,
                                                                                 0);

rc026_79_4 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc026_79_4_c379,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc041_79_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc041_79_3_c379,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc012_79_9 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc012_79_9_c379,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_80_c385 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 5.5 => -0.0269114237,
    txinqwemaillast_dayssince > 5.5                                       => 0.7117142756,
    txinqwemaillast_dayssince = NULL                                      => 0.1665054961,
                                                                             0.1665054961);

rc029_80_7_c385 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 5.5 => -0.1934169199,
    txinqwemaillast_dayssince > 5.5                                       => 0.5452087795,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_80_c384 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 659.56 => 0.4345584512,
    timebtwtxinqwemailavg > 659.56                                   => gbm10_wc_lgt_80_c385,
    timebtwtxinqwemailavg = NULL                                     => 0.2076794888,
                                                                        0.2076794888);

rc029_80_7_c384 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 659.56 => 0,
    timebtwtxinqwemailavg > 659.56                                   => rc029_80_7_c385,
    timebtwtxinqwemailavg = NULL                                     => 0,
                                                                        0);

rc006_80_5_c384 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 659.56 => 0.2268789624,
    timebtwtxinqwemailavg > 659.56                                   => -0.0411739927,
    timebtwtxinqwemailavg = NULL                                     => 0,
                                                                        0);

rc007_80_3_c383 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 947.34 => -0.0402225960,
    distbtwtrueipwphoneavg > 947.34                                    => 0.1630713092,
    distbtwtrueipwphoneavg = NULL                                      => 0.0244003010,
                                                                          0);

rc006_80_5_c383 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 947.34 => 0,
    distbtwtrueipwphoneavg > 947.34                                    => rc006_80_5_c384,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

rc029_80_7_c383 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 947.34 => 0,
    distbtwtrueipwphoneavg > 947.34                                    => rc029_80_7_c384,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_80_c383 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 947.34 => 0.0043855836,
    distbtwtrueipwphoneavg > 947.34                                    => gbm10_wc_lgt_80_c384,
    distbtwtrueipwphoneavg = NULL                                      => 0.0690084805,
                                                                          0.0446081796);

gbm10_wc_lgt_80 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 80.5 => -0.0051602072,
    txinqwemailcnt6m > 80.5                              => gbm10_wc_lgt_80_c383,
    txinqwemailcnt6m = NULL                              => -0.0041710399,
                                                            -0.0031670626);

rc029_80_7 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 80.5 => 0,
    txinqwemailcnt6m > 80.5                              => rc029_80_7_c383,
    txinqwemailcnt6m = NULL                              => 0,
                                                            0);

rc006_80_5 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 80.5 => 0,
    txinqwemailcnt6m > 80.5                              => rc006_80_5_c383,
    txinqwemailcnt6m = NULL                              => 0,
                                                            0);

rc007_80_3 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 80.5 => 0,
    txinqwemailcnt6m > 80.5                              => rc007_80_3_c383,
    txinqwemailcnt6m = NULL                              => 0,
                                                            0);

rc018_80_1 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 80.5 => -0.0019931445,
    txinqwemailcnt6m > 80.5                              => 0.0477752422,
    txinqwemailcnt6m = NULL                              => -0.0010039772,
                                                            0);

gbm10_wc_lgt_81_c388 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 3.5 => 0.3124610371,
    phoneperemailintxinqcnt1m > 3.5                                       => -0.1059450317,
    phoneperemailintxinqcnt1m = NULL                                      => 0.1205853783,
                                                                             0.1205853783);

rc039_81_4_c388 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 3.5 => 0.1918756588,
    phoneperemailintxinqcnt1m > 3.5                                       => -0.2265304100,
    phoneperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_81_c387 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 4.5 => -0.0001284605,
    phoneperemailintxinqcnt3m > 4.5                                       => gbm10_wc_lgt_81_c388,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0000418954,
                                                                             -0.0000418954);

rc030_81_2_c387 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 4.5 => -0.0000865651,
    phoneperemailintxinqcnt3m > 4.5                                       => 0.1206272738,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc039_81_4_c387 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 4.5 => 0,
    phoneperemailintxinqcnt3m > 4.5                                       => rc039_81_4_c388,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_81_c389 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => -0.0497471089,
    tmxidperphoneintxinqcnt3m > 1.5                                       => 0.0878305459,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0223217407,
                                                                             -0.0293403483);

rc004_81_10_c389 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => -0.0204067606,
    tmxidperphoneintxinqcnt3m > 1.5                                       => 0.1171708942,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0.0070186076,
                                                                             0);

rc030_81_1 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => 0.0045488548,
    phoneperemailintxinqcnt3m > 5.5                                       => -0.0983723437,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0247495980,
                                                                             0);

rc030_81_2 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => rc030_81_2_c387,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc004_81_10 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => 0,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => rc004_81_10_c389,
                                                                             0);

gbm10_wc_lgt_81 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => gbm10_wc_lgt_81_c387,
    phoneperemailintxinqcnt3m > 5.5                                       => -0.1029630940,
    phoneperemailintxinqcnt3m = NULL                                      => gbm10_wc_lgt_81_c389,
                                                                             -0.0045907503);

rc039_81_4 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => rc039_81_4_c387,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_82_c393 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 106.5 => 0.0046610276,
    txinqwemailcnt6m > 106.5                              => 0.4701299443,
    txinqwemailcnt6m = NULL                               => 0.0340931303,
                                                             0.0340931303);

rc018_82_7_c393 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 106.5 => -0.0294321028,
    txinqwemailcnt6m > 106.5                              => 0.4360368140,
    txinqwemailcnt6m = NULL                               => 0,
                                                             0);

rc050_82_4_c392 := map(
    NULL < txinqcorremailwaddresscnt6m AND txinqcorremailwaddresscnt6m <= 1.5 => -0.0139335669,
    txinqcorremailwaddresscnt6m > 1.5                                         => 0.2655271042,
    txinqcorremailwaddresscnt6m = NULL                                        => -0.0134377821,
                                                                                 0);

gbm10_wc_lgt_82_c392 := map(
    NULL < txinqcorremailwaddresscnt6m AND txinqcorremailwaddresscnt6m <= 1.5 => 0.0335973455,
    txinqcorremailwaddresscnt6m > 1.5                                         => 0.3130580166,
    txinqcorremailwaddresscnt6m = NULL                                        => gbm10_wc_lgt_82_c393,
                                                                                 0.0475309124);

rc018_82_7_c392 := map(
    NULL < txinqcorremailwaddresscnt6m AND txinqcorremailwaddresscnt6m <= 1.5 => 0,
    txinqcorremailwaddresscnt6m > 1.5                                         => 0,
    txinqcorremailwaddresscnt6m = NULL                                        => rc018_82_7_c393,
                                                                                 0);

rc006_82_3_c391 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 495.61 => 0.0395988764,
    timebtwtxinqwemailavg > 495.61                                   => -0.0061602034,
    timebtwtxinqwemailavg = NULL                                     => 0.0750958949,
                                                                        0);

gbm10_wc_lgt_82_c391 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 495.61 => gbm10_wc_lgt_82_c392,
    timebtwtxinqwemailavg > 495.61                                   => 0.0017718327,
    timebtwtxinqwemailavg = NULL                                     => 0.0830279309,
                                                                        0.0079320361);

rc018_82_7_c391 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 495.61 => rc018_82_7_c392,
    timebtwtxinqwemailavg > 495.61                                   => 0,
    timebtwtxinqwemailavg = NULL                                     => 0,
                                                                        0);

rc050_82_4_c391 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 495.61 => rc050_82_4_c392,
    timebtwtxinqwemailavg > 495.61                                   => 0,
    timebtwtxinqwemailavg = NULL                                     => 0,
                                                                        0);

rc050_82_4 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 0.5 => 0,
    exactidperemailintxinqcnt6m > 0.5                                         => rc050_82_4_c391,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

rc046_82_1 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 0.5 => -0.0530198846,
    exactidperemailintxinqcnt6m > 0.5                                         => 0.0197488167,
    exactidperemailintxinqcnt6m = NULL                                        => 0.0088425977,
                                                                                 0);

rc018_82_7 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 0.5 => 0,
    exactidperemailintxinqcnt6m > 0.5                                         => rc018_82_7_c391,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_82 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 0.5 => -0.0648366653,
    exactidperemailintxinqcnt6m > 0.5                                         => gbm10_wc_lgt_82_c391,
    exactidperemailintxinqcnt6m = NULL                                        => -0.0029741829,
                                                                                 -0.0118167807);

rc006_82_3 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 0.5 => 0,
    exactidperemailintxinqcnt6m > 0.5                                         => rc006_82_3_c391,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_83_c397 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 25340.56 => 0.3475561671,
    timebtwtxinqwemailavg > 25340.56                                   => 0.0869238876,
    timebtwtxinqwemailavg = NULL                                       => 0.1564623104,
                                                                          0.1564623104);

rc006_83_6_c397 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 25340.56 => 0.1910938566,
    timebtwtxinqwemailavg > 25340.56                                   => -0.0695384228,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc034_83_5_c396 := map(
    NULL < dnsipperemailintxinqcnt AND dnsipperemailintxinqcnt <= 6.5 => 0.1200905822,
    dnsipperemailintxinqcnt > 6.5                                     => -0.0577458692,
    dnsipperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_83_c396 := map(
    NULL < dnsipperemailintxinqcnt AND dnsipperemailintxinqcnt <= 6.5 => gbm10_wc_lgt_83_c397,
    dnsipperemailintxinqcnt > 6.5                                     => -0.0213741409,
    dnsipperemailintxinqcnt = NULL                                    => 0.0363717283,
                                                                         0.0363717283);

rc006_83_6_c396 := map(
    NULL < dnsipperemailintxinqcnt AND dnsipperemailintxinqcnt <= 6.5 => rc006_83_6_c397,
    dnsipperemailintxinqcnt > 6.5                                     => 0,
    dnsipperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_83_c395 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13800.15 => -0.0706370341,
    timebtwtxinqwemailavg > 13800.15                                   => gbm10_wc_lgt_83_c396,
    timebtwtxinqwemailavg = NULL                                       => -0.0192764983,
                                                                          -0.0265068771);

rc034_83_5_c395 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13800.15 => 0,
    timebtwtxinqwemailavg > 13800.15                                   => rc034_83_5_c396,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc006_83_6_c395 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13800.15 => 0,
    timebtwtxinqwemailavg > 13800.15                                   => rc006_83_6_c396,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc006_83_3_c395 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13800.15 => -0.0441301571,
    timebtwtxinqwemailavg > 13800.15                                   => 0.0628786053,
    timebtwtxinqwemailavg = NULL                                       => 0.0072303788,
                                                                          0);

rc006_83_3 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0,
    exactidperphoneintxinqcnt3m > 3.5                                         => rc006_83_3_c395,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc034_83_5 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0,
    exactidperphoneintxinqcnt3m > 3.5                                         => rc034_83_5_c395,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc021_83_1 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0.0009733140,
    exactidperphoneintxinqcnt3m > 3.5                                         => -0.0291858532,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0005357837,
                                                                                 0);

gbm10_wc_lgt_83 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0.0036522902,
    exactidperphoneintxinqcnt3m > 3.5                                         => gbm10_wc_lgt_83_c395,
    exactidperphoneintxinqcnt3m = NULL                                        => 0.0021431925,
                                                                                 0.0026789762);

rc006_83_6 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0,
    exactidperphoneintxinqcnt3m > 3.5                                         => rc006_83_6_c395,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc038_84_5_c401 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 7.5 => 0.2651499050,
    browserhashperphoneintxinqcnt > 7.5                                           => -0.3244187425,
    browserhashperphoneintxinqcnt = NULL                                          => 0,
                                                                                     0);

gbm10_wc_lgt_84_c401 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 7.5 => 0.6900101693,
    browserhashperphoneintxinqcnt > 7.5                                           => 0.1004415218,
    browserhashperphoneintxinqcnt = NULL                                          => 0.4248602643,
                                                                                     0.4248602643);

gbm10_wc_lgt_84_c400 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 18890.05 => gbm10_wc_lgt_84_c401,
    timebtwtxinqwemailavg > 18890.05                                   => -0.1215949622,
    timebtwtxinqwemailavg = NULL                                       => 0.0499230302,
                                                                          0.1609609524);

rc038_84_5_c400 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 18890.05 => rc038_84_5_c401,
    timebtwtxinqwemailavg > 18890.05                                   => 0,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc006_84_4_c400 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 18890.05 => 0.2638993119,
    timebtwtxinqwemailavg > 18890.05                                   => -0.2825559146,
    timebtwtxinqwemailavg = NULL                                       => -0.1110379223,
                                                                          0);

gbm10_wc_lgt_84_c399 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 34.5 => -0.0296971867,
    txinqwphonecnt1y > 34.5                              => gbm10_wc_lgt_84_c400,
    txinqwphonecnt1y = NULL                              => -0.0288487274,
                                                            -0.0288487274);

rc038_84_5_c399 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 34.5 => 0,
    txinqwphonecnt1y > 34.5                              => rc038_84_5_c400,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc010_84_2_c399 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 34.5 => -0.0008484593,
    txinqwphonecnt1y > 34.5                              => 0.1898096798,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc006_84_4_c399 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 34.5 => 0,
    txinqwphonecnt1y > 34.5                              => rc006_84_4_c400,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc006_84_4 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => rc006_84_4_c399,
    loginidperphoneintxinqcnt > 0.5                                       => 0,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc015_84_1 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => -0.0216073800,
    loginidperphoneintxinqcnt > 0.5                                       => 0.0257728401,
    loginidperphoneintxinqcnt = NULL                                      => 0.0089521467,
                                                                             0);

rc010_84_2 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => rc010_84_2_c399,
    loginidperphoneintxinqcnt > 0.5                                       => 0,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc038_84_5 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => rc038_84_5_c399,
    loginidperphoneintxinqcnt > 0.5                                       => 0,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_84 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => gbm10_wc_lgt_84_c399,
    loginidperphoneintxinqcnt > 0.5                                       => 0.0185314927,
    loginidperphoneintxinqcnt = NULL                                      => 0.0017107993,
                                                                             -0.0072413474);

gbm10_wc_lgt_85_c405 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 36007.285 => 0.6887400363,
    timebtwtxinqwemailavg > 36007.285                                   => 0.0469018279,
    timebtwtxinqwemailavg = NULL                                        => 0.3900470531,
                                                                           0.3900470531);

rc006_85_8_c405 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 36007.285 => 0.2986929832,
    timebtwtxinqwemailavg > 36007.285                                   => -0.3431452251,
    timebtwtxinqwemailavg = NULL                                        => 0,
                                                                           0);

gbm10_wc_lgt_85_c404 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 51.5 => -0.0110254187,
    txinqwemaillast_dayssince > 51.5                                       => gbm10_wc_lgt_85_c405,
    txinqwemaillast_dayssince = NULL                                       => 0.1054762064,
                                                                              0.0294444524);

rc006_85_8_c404 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 51.5 => 0,
    txinqwemaillast_dayssince > 51.5                                       => rc006_85_8_c405,
    txinqwemaillast_dayssince = NULL                                       => 0,
                                                                              0);

rc029_85_6_c404 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 51.5 => -0.0404698711,
    txinqwemaillast_dayssince > 51.5                                       => 0.3606026007,
    txinqwemaillast_dayssince = NULL                                       => 0.0760317540,
                                                                              0);

rc016_85_3_c403 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 598.5 => -0.0276684986,
    txinqwaddrfirst_dayssince > 598.5                                       => 0.0325644660,
    txinqwaddrfirst_dayssince = NULL                                        => 0.0484730544,
                                                                               0);

rc029_85_6_c403 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 598.5 => 0,
    txinqwaddrfirst_dayssince > 598.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                        => rc029_85_6_c404,
                                                                               0);

gbm10_wc_lgt_85_c403 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 598.5 => -0.0466971006,
    txinqwaddrfirst_dayssince > 598.5                                       => 0.0135358640,
    txinqwaddrfirst_dayssince = NULL                                        => gbm10_wc_lgt_85_c404,
                                                                               -0.0190286020);

rc006_85_8_c403 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 598.5 => 0,
    txinqwaddrfirst_dayssince > 598.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                        => rc006_85_8_c404,
                                                                               0);

gbm10_wc_lgt_85 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0066146023,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_85_c403,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0013662465,
                                                                                 0.0043043745);

rc006_85_8 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc006_85_8_c403,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc029_85_6 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc029_85_6_c403,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_85_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0023102277,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0233329765,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0029381280,
                                                                                 0);

rc016_85_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc016_85_3_c403,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_86_c409 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 1094.19 => -0.1433051785,
    timebtwtxinqwemailavg > 1094.19                                   => 0.3942270069,
    timebtwtxinqwemailavg = NULL                                      => 0.4227119265,
                                                                         0.3401414372);

rc006_86_8_c409 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 1094.19 => -0.4834466157,
    timebtwtxinqwemailavg > 1094.19                                   => 0.0540855697,
    timebtwtxinqwemailavg = NULL                                      => 0.0825704893,
                                                                         0);

rc025_86_5_c408 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 2.5 => 0.7427534556,
    txinqwaddrlast_dayssince > 2.5                                      => -0.1951528285,
    txinqwaddrlast_dayssince = NULL                                     => 0.0383899752,
                                                                           0);

gbm10_wc_lgt_86_c408 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 2.5 => 1.0445049177,
    txinqwaddrlast_dayssince > 2.5                                      => 0.1065986335,
    txinqwaddrlast_dayssince = NULL                                     => gbm10_wc_lgt_86_c409,
                                                                           0.3017514620);

rc006_86_8_c408 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 2.5 => 0,
    txinqwaddrlast_dayssince > 2.5                                      => 0,
    txinqwaddrlast_dayssince = NULL                                     => rc006_86_8_c409,
                                                                           0);

rc025_86_5_c407 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 9.5 => rc025_86_5_c408,
    txinqwemailfirst_dayssince > 9.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc002_86_4_c407 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 9.5 => 0.3133755858,
    txinqwemailfirst_dayssince > 9.5                                        => -0.0168618000,
    txinqwemailfirst_dayssince = NULL                                       => -0.0070917629,
                                                                               0);

gbm10_wc_lgt_86_c407 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 9.5 => gbm10_wc_lgt_86_c408,
    txinqwemailfirst_dayssince > 9.5                                        => -0.0284859237,
    txinqwemailfirst_dayssince = NULL                                       => -0.0187158867,
                                                                               -0.0116241237);

rc006_86_8_c407 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 9.5 => rc006_86_8_c408,
    txinqwemailfirst_dayssince > 9.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc002_86_4 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => 0,
    emailperphoneintxinqcnt > 17.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => rc002_86_4_c407,
                                                                          0);

gbm10_wc_lgt_86 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => 0.0000758578,
    emailperphoneintxinqcnt > 17.5                                     => -0.1650292714,
    emailperphoneintxinqcnt = NULL                                     => gbm10_wc_lgt_86_c407,
                                                                          -0.0026566618);

rc006_86_8 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => 0,
    emailperphoneintxinqcnt > 17.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => rc006_86_8_c407,
                                                                          0);

rc033_86_1 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => 0.0027325196,
    emailperphoneintxinqcnt > 17.5                                     => -0.1623726096,
    emailperphoneintxinqcnt = NULL                                     => -0.0089674620,
                                                                          0);

rc025_86_5 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => 0,
    emailperphoneintxinqcnt > 17.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => rc025_86_5_c407,
                                                                          0);

gbm10_wc_lgt_87_c412 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => 0.2138034909,
    txinqcorremailwphonecnt3m > 0.5                                       => -0.0307927987,
    txinqcorremailwphonecnt3m = NULL                                      => 0.0551034506,
                                                                             0.0551034506);

rc027_87_4_c412 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => 0.1587000403,
    txinqcorremailwphonecnt3m > 0.5                                       => -0.0858962493,
    txinqcorremailwphonecnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_87_c413 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 616.79 => 0.0507713628,
    distbtwtrueipwemailavg > 616.79                                    => 0.4030022501,
    distbtwtrueipwemailavg = NULL                                      => 0.1806489695,
                                                                          0.1806489695);

rc011_87_8_c413 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 616.79 => -0.1298776067,
    distbtwtrueipwemailavg > 616.79                                    => 0.2223532806,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_87_c411 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 19.5 => gbm10_wc_lgt_87_c412,
    trueipperphoneintxinqcnt > 19.5                                      => gbm10_wc_lgt_87_c413,
    trueipperphoneintxinqcnt = NULL                                      => 0.1293179320,
                                                                            0.0659514575);

rc027_87_4_c411 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 19.5 => rc027_87_4_c412,
    trueipperphoneintxinqcnt > 19.5                                      => 0,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

rc011_87_8_c411 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 19.5 => 0,
    trueipperphoneintxinqcnt > 19.5                                      => rc011_87_8_c413,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

rc017_87_3_c411 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 19.5 => -0.0108480069,
    trueipperphoneintxinqcnt > 19.5                                      => 0.1146975120,
    trueipperphoneintxinqcnt = NULL                                      => 0.0633664745,
                                                                            0);

rc049_87_1 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => -0.0026101043,
    tmxidperemailintxinqcnt > 7.5                                     => 0.0682445713,
    tmxidperemailintxinqcnt = NULL                                    => -0.0009766382,
                                                                         0);

rc017_87_3 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => 0,
    tmxidperemailintxinqcnt > 7.5                                     => rc017_87_3_c411,
    tmxidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

rc011_87_8 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => 0,
    tmxidperemailintxinqcnt > 7.5                                     => rc011_87_8_c411,
    tmxidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

rc027_87_4 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => 0,
    tmxidperemailintxinqcnt > 7.5                                     => rc027_87_4_c411,
    tmxidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_87 := map(
    NULL < tmxidperemailintxinqcnt AND tmxidperemailintxinqcnt <= 7.5 => -0.0049032181,
    tmxidperemailintxinqcnt > 7.5                                     => gbm10_wc_lgt_87_c411,
    tmxidperemailintxinqcnt = NULL                                    => -0.0032697520,
                                                                         -0.0022931138);

rc040_88_6_c417 := map(
    NULL < proxyipperemailintxinqcnt AND proxyipperemailintxinqcnt <= 10.5 => -0.0650950484,
    proxyipperemailintxinqcnt > 10.5                                       => 0.8864577323,
    proxyipperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_88_c417 := map(
    NULL < proxyipperemailintxinqcnt AND proxyipperemailintxinqcnt <= 10.5 => 0.0836314326,
    proxyipperemailintxinqcnt > 10.5                                       => 1.0351842134,
    proxyipperemailintxinqcnt = NULL                                       => 0.1487264810,
                                                                              0.1487264810);

rc023_88_4_c416 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0.3934443068,
    txinqcorremailwphonecnt > 0.5                                     => -0.0661970362,
    txinqcorremailwphonecnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_88_c416 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0.6083678240,
    txinqcorremailwphonecnt > 0.5                                     => gbm10_wc_lgt_88_c417,
    txinqcorremailwphonecnt = NULL                                    => 0.2149235172,
                                                                         0.2149235172);

rc040_88_6_c416 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 0.5 => 0,
    txinqcorremailwphonecnt > 0.5                                     => rc040_88_6_c417,
    txinqcorremailwphonecnt = NULL                                    => 0,
                                                                         0);

rc048_88_3_c415 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 0.5 => 0.1948007754,
    trueippertmxidintxinqcnt1m > 0.5                                        => -0.0443919824,
    trueippertmxidintxinqcnt1m = NULL                                       => -0.0070394074,
                                                                               0);

rc040_88_6_c415 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 0.5 => rc040_88_6_c416,
    trueippertmxidintxinqcnt1m > 0.5                                        => 0,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

rc023_88_4_c415 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 0.5 => rc023_88_4_c416,
    trueippertmxidintxinqcnt1m > 0.5                                        => 0,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_88_c415 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 0.5 => gbm10_wc_lgt_88_c416,
    trueippertmxidintxinqcnt1m > 0.5                                        => -0.0242692406,
    trueippertmxidintxinqcnt1m = NULL                                       => 0.0130833344,
                                                                               0.0201227418);

rc024_88_1 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => -0.0053948469,
    tmxidperemailintxinqcnt1m > 1.5                                       => 0.0265159043,
    tmxidperemailintxinqcnt1m = NULL                                      => 0.0037689904,
                                                                             0);

rc040_88_6 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => 0,
    tmxidperemailintxinqcnt1m > 1.5                                       => rc040_88_6_c415,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc023_88_4 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => 0,
    tmxidperemailintxinqcnt1m > 1.5                                       => rc023_88_4_c415,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_88 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => -0.0117880095,
    tmxidperemailintxinqcnt1m > 1.5                                       => gbm10_wc_lgt_88_c415,
    tmxidperemailintxinqcnt1m = NULL                                      => -0.0026241722,
                                                                             -0.0063931626);

rc048_88_3 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => 0,
    tmxidperemailintxinqcnt1m > 1.5                                       => rc048_88_3_c415,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc017_89_4_c420 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 1.5 => 0.1942046123,
    trueipperphoneintxinqcnt > 1.5                                      => -0.0243197175,
    trueipperphoneintxinqcnt = NULL                                     => 0,
                                                                           0);

gbm10_wc_lgt_89_c420 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 1.5 => 0.1165411868,
    trueipperphoneintxinqcnt > 1.5                                      => -0.1019831431,
    trueipperphoneintxinqcnt = NULL                                     => -0.0776634255,
                                                                           -0.0776634255);

gbm10_wc_lgt_89_c421 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 5.5 => 0.0040045515,
    smartidperemailintxinqcnt1m > 5.5                                         => 0.1820311303,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0634979052,
                                                                                 0.0177216571);

rc008_89_8_c421 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 5.5 => -0.0137171057,
    smartidperemailintxinqcnt1m > 5.5                                         => 0.1643094731,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0812195623,
                                                                                 0);

rc031_89_3_c419 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => -0.0506627006,
    tmxidperphoneintxinqcnt1y > 4.5                                       => 0.0447223821,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc017_89_4_c419 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => rc017_89_4_c420,
    tmxidperphoneintxinqcnt1y > 4.5                                       => 0,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc008_89_8_c419 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => 0,
    tmxidperphoneintxinqcnt1y > 4.5                                       => rc008_89_8_c421,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_89_c419 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => gbm10_wc_lgt_89_c420,
    tmxidperphoneintxinqcnt1y > 4.5                                       => gbm10_wc_lgt_89_c421,
    tmxidperphoneintxinqcnt1y = NULL                                      => -0.0270007249,
                                                                             -0.0270007249);

rc031_89_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc031_89_3_c419,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc008_89_8 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc008_89_8_c419,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc017_89_4 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc017_89_4_c419,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_89 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0016453187,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_89_c419,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0000672760,
                                                                             0.0010359552);

rc001_89_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0006093636,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0280366801,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0011032312,
                                                                             0);

rc005_90_5_c425 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 6.5 => -0.3129709699,
    txinqwphonefirst_dayssince > 6.5                                        => 0.0996525971,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_90_c425 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 6.5 => -0.2866128660,
    txinqwphonefirst_dayssince > 6.5                                        => 0.1260107011,
    txinqwphonefirst_dayssince = NULL                                       => 0.0263581039,
                                                                               0.0263581039);

rc003_90_4_c424 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0791076711,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.1449554824,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc005_90_5_c424 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => rc005_90_5_c425,
    smartidperphoneintxinqcnt1m > 1.5                                         => 0,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_90_c424 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => gbm10_wc_lgt_90_c425,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.1977050496,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0527495672,
                                                                                 -0.0527495672);

rc003_90_4_c423 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => rc003_90_4_c424,
    emailperphoneintxinqcnt > 2.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc033_90_3_c423 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => -0.0189614112,
    emailperphoneintxinqcnt > 2.5                                     => 0.2289894128,
    emailperphoneintxinqcnt = NULL                                    => -0.1461439263,
                                                                         0);

rc005_90_5_c423 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => rc005_90_5_c424,
    emailperphoneintxinqcnt > 2.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_90_c423 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => gbm10_wc_lgt_90_c424,
    emailperphoneintxinqcnt > 2.5                                     => 0.1952012567,
    emailperphoneintxinqcnt = NULL                                    => -0.1799320823,
                                                                         -0.0337881560);

rc033_90_3 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc033_90_3_c423,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_90_4 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc003_90_4_c423,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_90 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0008275293,
    smartidperemailintxinqcnt1m > 8.5                                         => gbm10_wc_lgt_90_c423,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0010068303,
                                                                                 0.0004583111);

rc005_90_5 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc005_90_5_c423,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc008_90_1 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0003692182,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.0342464672,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0014651414,
                                                                                 0);

rc020_91_3_c428 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 2.5 => -0.0016836957,
    phoneperemailintxinqcnt1y > 2.5                                       => 0.1205751913,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_91_c428 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 2.5 => 0.0247130022,
    phoneperemailintxinqcnt1y > 2.5                                       => 0.1469718892,
    phoneperemailintxinqcnt1y = NULL                                      => 0.0263966978,
                                                                             0.0263966978);

rc012_91_7_c429 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 7105 => 0.0215056578,
    timebtwtxinqwphoneavg > 7105                                   => -0.1587751296,
    timebtwtxinqwphoneavg = NULL                                   => 0.1257546542,
                                                                      0);

gbm10_wc_lgt_91_c429 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 7105 => -0.0557202241,
    timebtwtxinqwphoneavg > 7105                                   => -0.2360010115,
    timebtwtxinqwphoneavg = NULL                                   => 0.0485287723,
                                                                      -0.0772258819);

rc039_91_2_c427 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => 0.0006819558,
    phoneperemailintxinqcnt1m > 2.5                                       => -0.1029406240,
    phoneperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc020_91_3_c427 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => rc020_91_3_c428,
    phoneperemailintxinqcnt1m > 2.5                                       => 0,
    phoneperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc012_91_7_c427 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => 0,
    phoneperemailintxinqcnt1m > 2.5                                       => rc012_91_7_c429,
    phoneperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_91_c427 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => gbm10_wc_lgt_91_c428,
    phoneperemailintxinqcnt1m > 2.5                                       => gbm10_wc_lgt_91_c429,
    phoneperemailintxinqcnt1m = NULL                                      => 0.0257147421,
                                                                             0.0257147421);

rc020_91_3 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 224.5 => rc020_91_3_c427,
    txinqwemailfirst_dayssince > 224.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc012_91_7 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 224.5 => rc012_91_7_c427,
    txinqwemailfirst_dayssince > 224.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_91 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 224.5 => gbm10_wc_lgt_91_c427,
    txinqwemailfirst_dayssince > 224.5                                        => -0.0149027788,
    txinqwemailfirst_dayssince = NULL                                         => -0.0008062592,
                                                                                 -0.0033264091);

rc002_91_1 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 224.5 => 0.0290411512,
    txinqwemailfirst_dayssince > 224.5                                        => -0.0115763697,
    txinqwemailfirst_dayssince = NULL                                         => 0.0025201499,
                                                                                 0);

rc039_91_2 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 224.5 => rc039_91_2_c427,
    txinqwemailfirst_dayssince > 224.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc012_92_6_c433 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1277.72 => 0.2389488977,
    timebtwtxinqwphoneavg > 1277.72                                   => -0.1782342277,
    timebtwtxinqwphoneavg = NULL                                      => 0.1047637415,
                                                                         0);

gbm10_wc_lgt_92_c433 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 1277.72 => 0.4284044702,
    timebtwtxinqwphoneavg > 1277.72                                   => 0.0112213448,
    timebtwtxinqwphoneavg = NULL                                      => 0.2942193140,
                                                                         0.1894555725);

gbm10_wc_lgt_92_c432 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 168.5 => gbm10_wc_lgt_92_c433,
    txinqwemailfirst_dayssince > 168.5                                        => 0.0181221186,
    txinqwemailfirst_dayssince = NULL                                         => 0.0253229472,
                                                                                 0.0253229472);

rc002_92_5_c432 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 168.5 => 0.1641326253,
    txinqwemailfirst_dayssince > 168.5                                        => -0.0072008286,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc012_92_6_c432 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 168.5 => rc012_92_6_c433,
    txinqwemailfirst_dayssince > 168.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_92_c431 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 5.5 => -0.1792760588,
    txinqwemailfirst_dayssince > 5.5                                        => gbm10_wc_lgt_92_c432,
    txinqwemailfirst_dayssince = NULL                                       => 0.0249415152,
                                                                               0.0249415152);

rc002_92_3_c431 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 5.5 => -0.2042175740,
    txinqwemailfirst_dayssince > 5.5                                        => 0.0003814320,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc012_92_6_c431 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 5.5 => 0,
    txinqwemailfirst_dayssince > 5.5                                        => rc012_92_6_c432,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc002_92_5_c431 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 5.5 => 0,
    txinqwemailfirst_dayssince > 5.5                                        => rc002_92_5_c432,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc002_92_5 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 262.725 => 0,
    distbtwtrueipwemailavg > 262.725                                    => rc002_92_5_c431,
    distbtwtrueipwemailavg = NULL                                       => 0,
                                                                           0);

rc012_92_6 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 262.725 => 0,
    distbtwtrueipwemailavg > 262.725                                    => rc012_92_6_c431,
    distbtwtrueipwemailavg = NULL                                       => 0,
                                                                           0);

rc002_92_3 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 262.725 => 0,
    distbtwtrueipwemailavg > 262.725                                    => rc002_92_3_c431,
    distbtwtrueipwemailavg = NULL                                       => 0,
                                                                           0);

gbm10_wc_lgt_92 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 262.725 => -0.0170499455,
    distbtwtrueipwemailavg > 262.725                                    => gbm10_wc_lgt_92_c431,
    distbtwtrueipwemailavg = NULL                                       => -0.0024463776,
                                                                           -0.0007885318);

rc011_92_1 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 262.725 => -0.0162614138,
    distbtwtrueipwemailavg > 262.725                                    => 0.0257300470,
    distbtwtrueipwemailavg = NULL                                       => -0.0016578458,
                                                                           0);

gbm10_wc_lgt_93_c436 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 716 => 0.1236328055,
    txinqwphonefirst_dayssince > 716                                        => -0.1317906548,
    txinqwphonefirst_dayssince = NULL                                       => 0.0522074341,
                                                                               0.0522074341);

rc005_93_4_c436 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 716 => 0.0714253714,
    txinqwphonefirst_dayssince > 716                                        => -0.1839980889,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc005_93_4_c435 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc005_93_4_c436,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_93_c435 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0.0181349869,
    smartidperphoneintxinqcnt1m > 3.5                                         => gbm10_wc_lgt_93_c436,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0433940552,
                                                                                 0.0225383429);

rc003_93_2_c435 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0044033560,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.0296690912,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0208557123,
                                                                                 0);

rc047_93_9_c437 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 54.5 => 0.0181039550,
    exactidperemailintxinqcnt > 54.5                                       => 0.5147696500,
    exactidperemailintxinqcnt = NULL                                       => -0.1115094766,
                                                                              0);

gbm10_wc_lgt_93_c437 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 54.5 => -0.0223535407,
    exactidperemailintxinqcnt > 54.5                                       => 0.4743121543,
    exactidperemailintxinqcnt = NULL                                       => -0.1519669723,
                                                                              -0.0404574957);

rc047_93_9 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 153.5 => 0,
    txinqwaddrlast_dayssince > 153.5                                      => rc047_93_9_c437,
    txinqwaddrlast_dayssince = NULL                                       => 0,
                                                                             0);

gbm10_wc_lgt_93 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 153.5 => gbm10_wc_lgt_93_c435,
    txinqwaddrlast_dayssince > 153.5                                      => gbm10_wc_lgt_93_c437,
    txinqwaddrlast_dayssince = NULL                                       => -0.0112238975,
                                                                             -0.0064198483);

rc003_93_2 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 153.5 => rc003_93_2_c435,
    txinqwaddrlast_dayssince > 153.5                                      => 0,
    txinqwaddrlast_dayssince = NULL                                       => 0,
                                                                             0);

rc025_93_1 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 153.5 => 0.0289581911,
    txinqwaddrlast_dayssince > 153.5                                      => -0.0340376475,
    txinqwaddrlast_dayssince = NULL                                       => -0.0048040493,
                                                                             0);

rc005_93_4 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 153.5 => rc005_93_4_c435,
    txinqwaddrlast_dayssince > 153.5                                      => 0,
    txinqwaddrlast_dayssince = NULL                                       => 0,
                                                                             0);

rc005_94_7_c441 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 450.5 => 0.6033412953,
    txinqwphonefirst_dayssince > 450.5                                        => -0.5933573826,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_94_c441 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 450.5 => 1.0912430670,
    txinqwphonefirst_dayssince > 450.5                                        => -0.1054556109,
    txinqwphonefirst_dayssince = NULL                                         => 0.4879017716,
                                                                                 0.4879017716);

gbm10_wc_lgt_94_c440 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => -0.0066583708,
    emailperphoneintxinqcnt6m > 2.5                                       => gbm10_wc_lgt_94_c441,
    emailperphoneintxinqcnt6m = NULL                                      => -0.0025001986,
                                                                             -0.0025001986);

rc014_94_5_c440 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => -0.0041581722,
    emailperphoneintxinqcnt6m > 2.5                                       => 0.4904019702,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

rc005_94_7_c440 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => 0,
    emailperphoneintxinqcnt6m > 2.5                                       => rc005_94_7_c441,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

rc014_94_5_c439 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 6.5 => 0,
    tmxidperemailintxinqcnt1m > 6.5                                       => 0,
    tmxidperemailintxinqcnt1m = NULL                                      => rc014_94_5_c440,
                                                                             0);

gbm10_wc_lgt_94_c439 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 6.5 => 0.0025368014,
    tmxidperemailintxinqcnt1m > 6.5                                       => -0.1620662114,
    tmxidperemailintxinqcnt1m = NULL                                      => gbm10_wc_lgt_94_c440,
                                                                             0.0019277616);

rc024_94_2_c439 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 6.5 => 0.0006090398,
    tmxidperemailintxinqcnt1m > 6.5                                       => -0.1639939730,
    tmxidperemailintxinqcnt1m = NULL                                      => -0.0044279602,
                                                                             0);

rc005_94_7_c439 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 6.5 => 0,
    tmxidperemailintxinqcnt1m > 6.5                                       => 0,
    tmxidperemailintxinqcnt1m = NULL                                      => rc005_94_7_c440,
                                                                             0);

rc005_94_7 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc005_94_7_c439,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc024_94_2 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc024_94_2_c439,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc014_94_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc014_94_5_c439,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_94_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0006642764,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0240427253,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0014324592,
                                                                             0);

gbm10_wc_lgt_94 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => gbm10_wc_lgt_94_c439,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0227792401,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0001689740,
                                                                             0.0012634852);

rc005_95_5_c445 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 469.5 => -0.3463492122,
    txinqwphonefirst_dayssince > 469.5                                        => 0.4745049467,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_95_c445 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 469.5 => -0.0841286556,
    txinqwphonefirst_dayssince > 469.5                                        => 0.7367255033,
    txinqwphonefirst_dayssince = NULL                                         => 0.2622205566,
                                                                                 0.2622205566);

gbm10_wc_lgt_95_c444 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 5.5 => -0.0033942248,
    trueippertmxidintxinqcnt1m > 5.5                                        => gbm10_wc_lgt_95_c445,
    trueippertmxidintxinqcnt1m = NULL                                       => -0.0007532752,
                                                                               -0.0007532752);

rc048_95_3_c444 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 5.5 => -0.0026409495,
    trueippertmxidintxinqcnt1m > 5.5                                        => 0.2629738318,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

rc005_95_5_c444 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 5.5 => 0,
    trueippertmxidintxinqcnt1m > 5.5                                        => rc005_95_5_c445,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

rc040_95_2_c443 := map(
    NULL < proxyipperemailintxinqcnt AND proxyipperemailintxinqcnt <= 26.5 => -0.0003232157,
    proxyipperemailintxinqcnt > 26.5                                       => 0.8569489592,
    proxyipperemailintxinqcnt = NULL                                       => -0.0693098459,
                                                                              0);

rc048_95_3_c443 := map(
    NULL < proxyipperemailintxinqcnt AND proxyipperemailintxinqcnt <= 26.5 => rc048_95_3_c444,
    proxyipperemailintxinqcnt > 26.5                                       => 0,
    proxyipperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

rc005_95_5_c443 := map(
    NULL < proxyipperemailintxinqcnt AND proxyipperemailintxinqcnt <= 26.5 => rc005_95_5_c444,
    proxyipperemailintxinqcnt > 26.5                                       => 0,
    proxyipperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_95_c443 := map(
    NULL < proxyipperemailintxinqcnt AND proxyipperemailintxinqcnt <= 26.5 => gbm10_wc_lgt_95_c444,
    proxyipperemailintxinqcnt > 26.5                                       => 0.8565188997,
    proxyipperemailintxinqcnt = NULL                                       => -0.0697399054,
                                                                              -0.0004300595);

rc048_95_3 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => rc048_95_3_c443,
    trueippertmxidintxinqcnt1m > 7.5                                        => 0,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

rc048_95_1 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => 0.0003682580,
    trueippertmxidintxinqcnt1m > 7.5                                        => -0.1144269124,
    trueippertmxidintxinqcnt1m = NULL                                       => 0.0001475043,
                                                                               0);

rc005_95_5 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => rc005_95_5_c443,
    trueippertmxidintxinqcnt1m > 7.5                                        => 0,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_95 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => gbm10_wc_lgt_95_c443,
    trueippertmxidintxinqcnt1m > 7.5                                        => -0.1152252299,
    trueippertmxidintxinqcnt1m = NULL                                       => -0.0006508132,
                                                                               -0.0007983175);

rc040_95_2 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => rc040_95_2_c443,
    trueippertmxidintxinqcnt1m > 7.5                                        => 0,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

rc032_96_2_c447 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 18.5 => -0.0001943947,
    txinqcorremailwphonecnt1m > 18.5                                       => 0.3114041689,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_96_c447 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 18.5 => -0.0007658244,
    txinqcorremailwphonecnt1m > 18.5                                       => 0.3108327393,
    txinqcorremailwphonecnt1m = NULL                                       => -0.0005714296,
                                                                              -0.0005714296);

gbm10_wc_lgt_96_c449 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 634.5 => -0.1929429908,
    txinqwemailfirst_dayssince > 634.5                                        => 0.2659499094,
    txinqwemailfirst_dayssince = NULL                                         => 0.0507961363,
                                                                                 0.0507961363);

rc002_96_7_c449 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 634.5 => -0.2437391272,
    txinqwemailfirst_dayssince > 634.5                                        => 0.2151537730,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc002_96_7_c448 := map(
    NULL < txinqcorremailwaddresscnt AND txinqcorremailwaddresscnt <= 0.5 => rc002_96_7_c449,
    txinqcorremailwaddresscnt > 0.5                                       => 0,
    txinqcorremailwaddresscnt = NULL                                      => 0,
                                                                             0);

rc053_96_6_c448 := map(
    NULL < txinqcorremailwaddresscnt AND txinqcorremailwaddresscnt <= 0.5 => 0.1513205308,
    txinqcorremailwaddresscnt > 0.5                                       => -0.1824414557,
    txinqcorremailwaddresscnt = NULL                                      => -0.0572927465,
                                                                             0);

gbm10_wc_lgt_96_c448 := map(
    NULL < txinqcorremailwaddresscnt AND txinqcorremailwaddresscnt <= 0.5 => gbm10_wc_lgt_96_c449,
    txinqcorremailwaddresscnt > 0.5                                       => -0.2829658502,
    txinqcorremailwaddresscnt = NULL                                      => -0.1578171410,
                                                                             -0.1005243945);

rc053_96_6 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => 0,
    txinqcorremailwphonecnt1m > 21.5                                       => rc053_96_6_c448,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

rc002_96_7 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => 0,
    txinqcorremailwphonecnt1m > 21.5                                       => rc002_96_7_c448,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_96 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => gbm10_wc_lgt_96_c447,
    txinqcorremailwphonecnt1m > 21.5                                       => gbm10_wc_lgt_96_c448,
    txinqcorremailwphonecnt1m = NULL                                       => 0.0016711183,
                                                                              -0.0000514930);

rc032_96_2 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => rc032_96_2_c447,
    txinqcorremailwphonecnt1m > 21.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                       => 0,
                                                                              0);

rc032_96_1 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 21.5 => -0.0005199367,
    txinqcorremailwphonecnt1m > 21.5                                       => -0.1004729015,
    txinqcorremailwphonecnt1m = NULL                                       => 0.0017226113,
                                                                              0);

gbm10_wc_lgt_97_c453 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 27.5 => 0.0931463366,
    txinqwphonelast_dayssince > 27.5                                       => 0.7330704024,
    txinqwphonelast_dayssince = NULL                                       => 0.1146263585,
                                                                              0.1146263585);

rc022_97_5_c453 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 27.5 => -0.0214800219,
    txinqwphonelast_dayssince > 27.5                                       => 0.6184440439,
    txinqwphonelast_dayssince = NULL                                       => 0,
                                                                              0);

rc005_97_4_c452 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 380.5 => 0.0675342374,
    txinqwphonefirst_dayssince > 380.5                                        => -0.0780814460,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_97_c452 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 380.5 => gbm10_wc_lgt_97_c453,
    txinqwphonefirst_dayssince > 380.5                                        => -0.0309893249,
    txinqwphonefirst_dayssince = NULL                                         => 0.0470921211,
                                                                                 0.0470921211);

rc022_97_5_c452 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 380.5 => rc022_97_5_c453,
    txinqwphonefirst_dayssince > 380.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc005_97_4_c451 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 0.5 => 0,
    smartidperphoneintxinqcnt1m > 0.5                                         => rc005_97_4_c452,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_97_c451 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 0.5 => -0.0041974204,
    smartidperphoneintxinqcnt1m > 0.5                                         => gbm10_wc_lgt_97_c452,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0002136006,
                                                                                 -0.0002136006);

rc003_97_2_c451 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 0.5 => -0.0039838198,
    smartidperphoneintxinqcnt1m > 0.5                                         => 0.0473057217,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc022_97_5_c451 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 0.5 => 0,
    smartidperphoneintxinqcnt1m > 0.5                                         => rc022_97_5_c452,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc022_97_5 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 0.5 => rc022_97_5_c451,
    txinqcorremailwphonecnt1m > 0.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc003_97_2 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 0.5 => rc003_97_2_c451,
    txinqcorremailwphonecnt1m > 0.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_97 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 0.5 => gbm10_wc_lgt_97_c451,
    txinqcorremailwphonecnt1m > 0.5                                       => -0.0196915603,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0013347040,
                                                                             -0.0021951278);

rc005_97_4 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 0.5 => rc005_97_4_c451,
    txinqcorremailwphonecnt1m > 0.5                                       => 0,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc032_97_1 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 0.5 => 0.0019815272,
    txinqcorremailwphonecnt1m > 0.5                                       => -0.0174964325,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0035298319,
                                                                             0);

rc042_98_4_c456 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 27.5 => -0.0140302910,
    smartidperemailintxinqcnt > 27.5                                       => 0.2712159734,
    smartidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_98_c456 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 27.5 => -0.0003110538,
    smartidperemailintxinqcnt > 27.5                                       => 0.2849352106,
    smartidperemailintxinqcnt = NULL                                       => 0.0137192371,
                                                                              0.0137192371);

rc002_98_8_c457 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 712 => -0.1968822772,
    txinqwemailfirst_dayssince > 712                                        => 0.1928453655,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_98_c457 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 712 => -0.0188413838,
    txinqwemailfirst_dayssince > 712                                        => 0.3708862589,
    txinqwemailfirst_dayssince = NULL                                       => 0.1780408934,
                                                                               0.1780408934);

rc007_98_3_c455 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 949.02 => -0.0116244990,
    distbtwtrueipwphoneavg > 949.02                                    => 0.1526971573,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_98_c455 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 949.02 => gbm10_wc_lgt_98_c456,
    distbtwtrueipwphoneavg > 949.02                                    => gbm10_wc_lgt_98_c457,
    distbtwtrueipwphoneavg = NULL                                      => 0.0253437361,
                                                                          0.0253437361);

rc002_98_8_c455 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 949.02 => 0,
    distbtwtrueipwphoneavg > 949.02                                    => rc002_98_8_c457,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

rc042_98_4_c455 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 949.02 => rc042_98_4_c456,
    distbtwtrueipwphoneavg > 949.02                                    => 0,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

rc002_98_8 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => 0,
    txinqcorremailwphonecnt1m > 4.5                                       => rc002_98_8_c455,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_98 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => -0.0034265786,
    txinqcorremailwphonecnt1m > 4.5                                       => gbm10_wc_lgt_98_c455,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0010663656,
                                                                             -0.0017781407);

rc032_98_1 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => -0.0016484379,
    txinqcorremailwphonecnt1m > 4.5                                       => 0.0271218768,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0028445063,
                                                                             0);

rc007_98_3 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => 0,
    txinqcorremailwphonecnt1m > 4.5                                       => rc007_98_3_c455,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc042_98_4 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => 0,
    txinqcorremailwphonecnt1m > 4.5                                       => rc042_98_4_c455,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_99_c461 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 143.325 => 0.0158143402,
    distbtwtrueipwemailavg > 143.325                                    => 0.3947253070,
    distbtwtrueipwemailavg = NULL                                       => 0.2475371142,
                                                                           0.2475371142);

rc011_99_6_c461 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 143.325 => -0.2317227740,
    distbtwtrueipwemailavg > 143.325                                    => 0.1471881928,
    distbtwtrueipwemailavg = NULL                                       => 0,
                                                                           0);

rc011_99_6_c460 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 1.5 => 0,
    phoneperemailintxinqcnt1y > 1.5                                       => rc011_99_6_c461,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_99_c460 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 1.5 => -0.0314278342,
    phoneperemailintxinqcnt1y > 1.5                                       => gbm10_wc_lgt_99_c461,
    phoneperemailintxinqcnt1y = NULL                                      => 0.0841483572,
                                                                             0.0841483572);

rc020_99_4_c460 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 1.5 => -0.1155761914,
    phoneperemailintxinqcnt1y > 1.5                                       => 0.1633887571,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc020_99_4_c459 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 69.5 => 0,
    txinqwphonecnt1y > 69.5                              => rc020_99_4_c460,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc011_99_6_c459 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 69.5 => 0,
    txinqwphonecnt1y > 69.5                              => rc011_99_6_c460,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc010_99_2_c459 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 69.5 => -0.0002267969,
    txinqwphonecnt1y > 69.5                              => 0.0828194364,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

gbm10_wc_lgt_99_c459 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 69.5 => 0.0011021239,
    txinqwphonecnt1y > 69.5                              => gbm10_wc_lgt_99_c460,
    txinqwphonecnt1y = NULL                              => 0.0013289208,
                                                            0.0013289208);

rc020_99_4 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => rc020_99_4_c459,
    exactidperphoneintxinqcnt3m > 3.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc021_99_1 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0.0010052849,
    exactidperphoneintxinqcnt3m > 3.5                                         => -0.0240446605,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0011275845,
                                                                                 0);

rc010_99_2 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => rc010_99_2_c459,
    exactidperphoneintxinqcnt3m > 3.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_99 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => gbm10_wc_lgt_99_c459,
    exactidperphoneintxinqcnt3m > 3.5                                         => -0.0237210246,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0008039486,
                                                                                 0.0003236358);

rc011_99_6 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => rc011_99_6_c459,
    exactidperphoneintxinqcnt3m > 3.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc005_100_7_c465 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 654 => -0.1356592366,
    txinqwphonefirst_dayssince > 654                                        => 0.2433122253,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_100_c465 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 654 => 0.0551496628,
    txinqwphonefirst_dayssince > 654                                        => 0.4341211246,
    txinqwphonefirst_dayssince = NULL                                       => 0.1908088993,
                                                                               0.1908088993);

rc005_100_7_c464 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 874.41 => 0,
    distbtwtrueipwemailavg > 874.41                                    => rc005_100_7_c465,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

rc011_100_5_c464 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 874.41 => -0.0284664265,
    distbtwtrueipwemailavg > 874.41                                    => 0.1517535176,
    distbtwtrueipwemailavg = NULL                                      => 0.0480215330,
                                                                          0);

gbm10_wc_lgt_100_c464 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 874.41 => 0.0105889553,
    distbtwtrueipwemailavg > 874.41                                    => gbm10_wc_lgt_100_c465,
    distbtwtrueipwemailavg = NULL                                      => 0.0870769147,
                                                                          0.0390553817);

rc011_100_5_c463 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 37.5 => 0,
    txinqwnamefirst_dayssince > 37.5                                       => rc011_100_5_c464,
    txinqwnamefirst_dayssince = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_100_c463 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 37.5 => -0.0618097595,
    txinqwnamefirst_dayssince > 37.5                                       => gbm10_wc_lgt_100_c464,
    txinqwnamefirst_dayssince = NULL                                       => 0.0597852927,
                                                                              0.0217629529);

rc005_100_7_c463 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 37.5 => 0,
    txinqwnamefirst_dayssince > 37.5                                       => rc005_100_7_c464,
    txinqwnamefirst_dayssince = NULL                                       => 0,
                                                                              0);

rc013_100_3_c463 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 37.5 => -0.0835727124,
    txinqwnamefirst_dayssince > 37.5                                       => 0.0172924289,
    txinqwnamefirst_dayssince = NULL                                       => 0.0380223398,
                                                                              0);

rc013_100_3 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => 0,
    tmxidperphoneintxinqcnt1y > 3.5                                       => rc013_100_3_c463,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc031_100_1 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => -0.0021711092,
    tmxidperphoneintxinqcnt1y > 3.5                                       => 0.0251136657,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0.0027070298,
                                                                             0);

rc011_100_5 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => 0,
    tmxidperphoneintxinqcnt1y > 3.5                                       => rc011_100_5_c463,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_100 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => -0.0055218220,
    tmxidperphoneintxinqcnt1y > 3.5                                       => gbm10_wc_lgt_100_c463,
    tmxidperphoneintxinqcnt1y = NULL                                      => -0.0006436830,
                                                                             -0.0033507128);

rc005_100_7 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => 0,
    tmxidperphoneintxinqcnt1y > 3.5                                       => rc005_100_7_c463,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_101_c468 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => -0.0193404998,
    tmxidperphoneintxinqcnt1y > 3.5                                       => 0.0646718960,
    tmxidperphoneintxinqcnt1y = NULL                                      => -0.0017287809,
                                                                             -0.0017287809);

rc031_101_4_c468 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 3.5 => -0.0176117189,
    tmxidperphoneintxinqcnt1y > 3.5                                       => 0.0664006769,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_101_c469 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 277.26 => 0.1658997619,
    timebtwtxinqwemailavg > 277.26                                   => -0.0746029845,
    timebtwtxinqwemailavg = NULL                                     => -0.0787992859,
                                                                        -0.0700386670);

rc006_101_8_c469 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 277.26 => 0.2359384289,
    timebtwtxinqwemailavg > 277.26                                   => -0.0045643176,
    timebtwtxinqwemailavg = NULL                                     => -0.0087606190,
                                                                        0);

rc038_101_3_c467 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 6.5 => 0.0265221149,
    browserhashperphoneintxinqcnt > 6.5                                           => -0.0417877712,
    browserhashperphoneintxinqcnt = NULL                                          => 0,
                                                                                     0);

rc031_101_4_c467 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 6.5 => rc031_101_4_c468,
    browserhashperphoneintxinqcnt > 6.5                                           => 0,
    browserhashperphoneintxinqcnt = NULL                                          => 0,
                                                                                     0);

gbm10_wc_lgt_101_c467 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 6.5 => gbm10_wc_lgt_101_c468,
    browserhashperphoneintxinqcnt > 6.5                                           => gbm10_wc_lgt_101_c469,
    browserhashperphoneintxinqcnt = NULL                                          => -0.0282508958,
                                                                                     -0.0282508958);

rc006_101_8_c467 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 6.5 => 0,
    browserhashperphoneintxinqcnt > 6.5                                           => rc006_101_8_c469,
    browserhashperphoneintxinqcnt = NULL                                          => 0,
                                                                                     0);

gbm10_wc_lgt_101 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0059888295,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_101_c467,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0005152823,
                                                                                 0.0030168791);

rc003_101_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0029719504,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0312677749,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0035321614,
                                                                                 0);

rc006_101_8 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc006_101_8_c467,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc031_101_4 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc031_101_4_c467,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc038_101_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc038_101_3_c467,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc013_102_7_c473 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 26.5 => 0.1932766235,
    txinqwnamefirst_dayssince > 26.5                                       => -0.0769258331,
    txinqwnamefirst_dayssince = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_102_c473 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 26.5 => 0.2543872639,
    txinqwnamefirst_dayssince > 26.5                                       => -0.0158151927,
    txinqwnamefirst_dayssince = NULL                                       => 0.0611106404,
                                                                              0.0611106404);

rc003_102_5_c472 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 2.5 => -0.0327714468,
    smartidperphoneintxinqcnt1m > 2.5                                         => 0.0677305417,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc013_102_7_c472 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 2.5 => 0,
    smartidperphoneintxinqcnt1m > 2.5                                         => rc013_102_7_c473,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_102_c472 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 2.5 => -0.0393913481,
    smartidperphoneintxinqcnt1m > 2.5                                         => gbm10_wc_lgt_102_c473,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0066199013,
                                                                                 -0.0066199013);

rc013_102_7_c471 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 11329.775 => 0,
    timebtwtxinqwphoneavg > 11329.775                                   => rc013_102_7_c472,
    timebtwtxinqwphoneavg = NULL                                        => 0,
                                                                           0);

gbm10_wc_lgt_102_c471 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 11329.775 => -0.0660581201,
    timebtwtxinqwphoneavg > 11329.775                                   => gbm10_wc_lgt_102_c472,
    timebtwtxinqwphoneavg = NULL                                        => -0.0288889287,
                                                                           -0.0288889287);

rc003_102_5_c471 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 11329.775 => 0,
    timebtwtxinqwphoneavg > 11329.775                                   => rc003_102_5_c472,
    timebtwtxinqwphoneavg = NULL                                        => 0,
                                                                           0);

rc012_102_3_c471 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 11329.775 => -0.0371691914,
    timebtwtxinqwphoneavg > 11329.775                                   => 0.0222690274,
    timebtwtxinqwphoneavg = NULL                                        => 0,
                                                                           0);

rc003_102_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc003_102_5_c471,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc012_102_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc012_102_3_c471,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_102_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0007716873,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0300653238,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0015888362,
                                                                             0);

rc013_102_7 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc013_102_7_c471,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_102 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0019480824,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_102_c471,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0004124411,
                                                                             0.0011763951);

rc006_103_5_c476 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13908.36 => 0.3482545065,
    timebtwtxinqwemailavg > 13908.36                                   => -0.2530298673,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

gbm10_wc_lgt_103_c476 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13908.36 => 0.3817233644,
    timebtwtxinqwemailavg > 13908.36                                   => -0.2195610094,
    timebtwtxinqwemailavg = NULL                                       => 0.0334688579,
                                                                          0.0334688579);

rc003_103_3_c475 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 2.5 => -0.0004196020,
    smartidperphoneintxinqcnt1m > 2.5                                         => 0.0626775902,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_103_c475 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 2.5 => -0.0296283343,
    smartidperphoneintxinqcnt1m > 2.5                                         => gbm10_wc_lgt_103_c476,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0292087323,
                                                                                 -0.0292087323);

rc006_103_5_c475 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 2.5 => 0,
    smartidperphoneintxinqcnt1m > 2.5                                         => rc006_103_5_c476,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc019_103_10_c477 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 27.5 => 0.0039239779,
    smartidperemailintxinqcnt3m > 27.5                                         => -0.2533278433,
    smartidperemailintxinqcnt3m = NULL                                         => -0.0158335344,
                                                                                  0);

gbm10_wc_lgt_103_c477 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 27.5 => -0.0047280836,
    smartidperemailintxinqcnt3m > 27.5                                         => -0.2619799048,
    smartidperemailintxinqcnt3m = NULL                                         => -0.0244855959,
                                                                                  -0.0086520615);

rc003_103_3 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.625 => 0,
    timebtwtxinqwphoneavg > 85032.625                                   => rc003_103_3_c475,
    timebtwtxinqwphoneavg = NULL                                        => 0,
                                                                           0);

rc019_103_10 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.625 => 0,
    timebtwtxinqwphoneavg > 85032.625                                   => 0,
    timebtwtxinqwphoneavg = NULL                                        => rc019_103_10_c477,
                                                                           0);

gbm10_wc_lgt_103 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.625 => 0.0160446771,
    timebtwtxinqwphoneavg > 85032.625                                   => gbm10_wc_lgt_103_c475,
    timebtwtxinqwphoneavg = NULL                                        => gbm10_wc_lgt_103_c477,
                                                                           -0.0071830034);

rc006_103_5 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.625 => 0,
    timebtwtxinqwphoneavg > 85032.625                                   => rc006_103_5_c475,
    timebtwtxinqwphoneavg = NULL                                        => 0,
                                                                           0);

rc012_103_1 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.625 => 0.0232276805,
    timebtwtxinqwphoneavg > 85032.625                                   => -0.0220257289,
    timebtwtxinqwphoneavg = NULL                                        => -0.0014690581,
                                                                           0);

gbm10_wc_lgt_104_c480 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 9.5 => -0.0494888244,
    orgidperemailintxinqcnt > 9.5                                     => 0.2206656464,
    orgidperemailintxinqcnt = NULL                                    => 0.0884308164,
                                                                         0.0025307553);

rc043_104_5_c480 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 9.5 => -0.0520195797,
    orgidperemailintxinqcnt > 9.5                                     => 0.2181348911,
    orgidperemailintxinqcnt = NULL                                    => 0.0859000612,
                                                                         0);

rc026_104_9_c481 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 1.5 => 0.1080297107,
    txinqwnamelast_dayssince > 1.5                                      => -0.0725418886,
    txinqwnamelast_dayssince = NULL                                     => 0.0328034264,
                                                                           0);

gbm10_wc_lgt_104_c481 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 1.5 => 0.1212312086,
    txinqwnamelast_dayssince > 1.5                                      => -0.0593403907,
    txinqwnamelast_dayssince = NULL                                     => 0.0460049243,
                                                                           0.0132014979);

gbm10_wc_lgt_104_c479 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 372.5 => -0.0475297658,
    txinqwaddrfirst_dayssince > 372.5                                       => gbm10_wc_lgt_104_c480,
    txinqwaddrfirst_dayssince = NULL                                        => gbm10_wc_lgt_104_c481,
                                                                               -0.0168379395);

rc026_104_9_c479 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 372.5 => 0,
    txinqwaddrfirst_dayssince > 372.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                        => rc026_104_9_c481,
                                                                               0);

rc043_104_5_c479 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 372.5 => 0,
    txinqwaddrfirst_dayssince > 372.5                                       => rc043_104_5_c480,
    txinqwaddrfirst_dayssince = NULL                                        => 0,
                                                                               0);

rc016_104_3_c479 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 372.5 => -0.0306918263,
    txinqwaddrfirst_dayssince > 372.5                                       => 0.0193686947,
    txinqwaddrfirst_dayssince = NULL                                        => 0.0300394373,
                                                                               0);

rc003_104_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0018399877,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0205904571,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0019431367,
                                                                                 0);

gbm10_wc_lgt_104 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0055925053,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_104_c479,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0018093810,
                                                                                 0.0037525176);

rc026_104_9 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc026_104_9_c479,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc016_104_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc016_104_3_c479,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc043_104_5 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc043_104_5_c479,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_105_c485 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 220394.21 => -0.0156599658,
    timebtwtxinqwphoneavg > 220394.21                                   => 0.4331987329,
    timebtwtxinqwphoneavg = NULL                                        => 0.1033409168,
                                                                           0.0386652836);

rc012_105_6_c485 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 220394.21 => -0.0543252494,
    timebtwtxinqwphoneavg > 220394.21                                   => 0.3945334493,
    timebtwtxinqwphoneavg = NULL                                        => 0.0646756332,
                                                                           0);

gbm10_wc_lgt_105_c484 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 83.5 => 0.1656704029,
    txinqwemailfirst_dayssince > 83.5                                        => gbm10_wc_lgt_105_c485,
    txinqwemailfirst_dayssince = NULL                                        => 0.0411698270,
                                                                                0.0411698270);

rc012_105_6_c484 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 83.5 => 0,
    txinqwemailfirst_dayssince > 83.5                                        => rc012_105_6_c485,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc002_105_4_c484 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 83.5 => 0.1245005759,
    txinqwemailfirst_dayssince > 83.5                                        => -0.0025045434,
    txinqwemailfirst_dayssince = NULL                                        => 0,
                                                                                0);

rc002_105_4_c483 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 6.5 => rc002_105_4_c484,
    emailperphoneintxinqcnt > 6.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc012_105_6_c483 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 6.5 => rc012_105_6_c484,
    emailperphoneintxinqcnt > 6.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc033_105_3_c483 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 6.5 => 0.0026424467,
    emailperphoneintxinqcnt > 6.5                                     => 0.1987134645,
    emailperphoneintxinqcnt = NULL                                    => -0.0451486021,
                                                                         0);

gbm10_wc_lgt_105_c483 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 6.5 => gbm10_wc_lgt_105_c484,
    emailperphoneintxinqcnt > 6.5                                     => 0.2372408448,
    emailperphoneintxinqcnt = NULL                                    => -0.0066212218,
                                                                         0.0385273803);

gbm10_wc_lgt_105 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 9.5 => -0.0041854236,
    exactidperemailintxinqcnt6m > 9.5                                         => gbm10_wc_lgt_105_c483,
    exactidperemailintxinqcnt6m = NULL                                        => -0.0000851474,
                                                                                 -0.0021777254);

rc033_105_3 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 9.5 => 0,
    exactidperemailintxinqcnt6m > 9.5                                         => rc033_105_3_c483,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

rc046_105_1 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 9.5 => -0.0020076982,
    exactidperemailintxinqcnt6m > 9.5                                         => 0.0407051058,
    exactidperemailintxinqcnt6m = NULL                                        => 0.0020925781,
                                                                                 0);

rc012_105_6 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 9.5 => 0,
    exactidperemailintxinqcnt6m > 9.5                                         => rc012_105_6_c483,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

rc002_105_4 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 9.5 => 0,
    exactidperemailintxinqcnt6m > 9.5                                         => rc002_105_4_c483,
    exactidperemailintxinqcnt6m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_106_c489 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 26512.215 => 0.1413026280,
    timebtwtxinqwphoneavg > 26512.215                                   => -0.0453420993,
    timebtwtxinqwphoneavg = NULL                                        => 0.1354010262,
                                                                           0.1074601384);

rc012_106_5_c489 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 26512.215 => 0.0338424896,
    timebtwtxinqwphoneavg > 26512.215                                   => -0.1528022377,
    timebtwtxinqwphoneavg = NULL                                        => 0.0279408878,
                                                                           0);

gbm10_wc_lgt_106_c488 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 17.5 => gbm10_wc_lgt_106_c489,
    txinqwemailcnt6m > 17.5                              => -0.0891401425,
    txinqwemailcnt6m = NULL                              => 0.1537774430,
                                                            0.0703796273);

rc018_106_4_c488 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 17.5 => 0.0370805111,
    txinqwemailcnt6m > 17.5                              => -0.1595197698,
    txinqwemailcnt6m = NULL                              => 0.0833978156,
                                                            0);

rc012_106_5_c488 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 17.5 => rc012_106_5_c489,
    txinqwemailcnt6m > 17.5                              => 0,
    txinqwemailcnt6m = NULL                              => 0,
                                                            0);

rc005_106_3_c487 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 145.5 => 0.0622064440,
    txinqwphonefirst_dayssince > 145.5                                        => -0.0081261552,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_106_c487 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 145.5 => gbm10_wc_lgt_106_c488,
    txinqwphonefirst_dayssince > 145.5                                        => 0.0000470281,
    txinqwphonefirst_dayssince = NULL                                         => 0.0081731833,
                                                                                 0.0081731833);

rc018_106_4_c487 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 145.5 => rc018_106_4_c488,
    txinqwphonefirst_dayssince > 145.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc012_106_5_c487 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 145.5 => rc012_106_5_c488,
    txinqwphonefirst_dayssince > 145.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc005_106_3 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => 0,
    loginidperphoneintxinqcnt > 0.5                                       => rc005_106_3_c487,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_106 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => -0.0212400022,
    loginidperphoneintxinqcnt > 0.5                                       => gbm10_wc_lgt_106_c487,
    loginidperphoneintxinqcnt = NULL                                      => 0.0021673367,
                                                                             -0.0068332914);

rc015_106_1 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => -0.0144067108,
    loginidperphoneintxinqcnt > 0.5                                       => 0.0150064747,
    loginidperphoneintxinqcnt = NULL                                      => 0.0090006282,
                                                                             0);

rc012_106_5 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => 0,
    loginidperphoneintxinqcnt > 0.5                                       => rc012_106_5_c487,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc018_106_4 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 0.5 => 0,
    loginidperphoneintxinqcnt > 0.5                                       => rc018_106_4_c487,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_107_c491 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 20.5 => 0.0009864427,
    smartidperphoneintxinqcnt1y > 20.5                                         => 0.3146043836,
    smartidperphoneintxinqcnt1y = NULL                                         => 0.0011162285,
                                                                                  0.0011162285);

rc028_107_2_c491 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 20.5 => -0.0001297858,
    smartidperphoneintxinqcnt1y > 20.5                                         => 0.3134881551,
    smartidperphoneintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_107_c493 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 471.5 => 0.0013136156,
    txinqwaddrfirst_dayssince > 471.5                                       => -0.1321142435,
    txinqwaddrfirst_dayssince = NULL                                        => -0.0210338271,
                                                                               -0.0316891200);

rc016_107_9_c493 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 471.5 => 0.0330027356,
    txinqwaddrfirst_dayssince > 471.5                                       => -0.1004251235,
    txinqwaddrfirst_dayssince = NULL                                        => 0.0106552929,
                                                                               0);

gbm10_wc_lgt_107_c492 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 130 => 0.0767697893,
    txinqwtmxidfirst_dayssince > 130                                        => -0.1274211899,
    txinqwtmxidfirst_dayssince = NULL                                       => gbm10_wc_lgt_107_c493,
                                                                               -0.0271001142);

rc016_107_9_c492 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 130 => 0,
    txinqwtmxidfirst_dayssince > 130                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                       => rc016_107_9_c493,
                                                                               0);

rc035_107_6_c492 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 130 => 0.1038699035,
    txinqwtmxidfirst_dayssince > 130                                        => -0.1003210757,
    txinqwtmxidfirst_dayssince = NULL                                       => -0.0045890058,
                                                                               0);

rc001_107_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0000852044,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0281311383,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0006990391,
                                                                             0);

rc016_107_9 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc016_107_9_c492,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc035_107_6 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc035_107_6_c492,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc028_107_2 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => rc028_107_2_c491,
    emailperphoneintxinqcnt3m > 2.5                                       => 0,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_107 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => gbm10_wc_lgt_107_c491,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_107_c492,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0017300633,
                                                                             0.0010310241);

gbm10_wc_lgt_108_c497 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 799.55 => -0.1068769436,
    distbtwtrueipwemailavg > 799.55                                    => 0.6646674682,
    distbtwtrueipwemailavg = NULL                                      => -0.0352262226,
                                                                          -0.0352262226);

rc011_108_7_c497 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 799.55 => -0.0716507210,
    distbtwtrueipwemailavg > 799.55                                    => 0.6998936908,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

rc011_108_7_c496 := map(
    NULL < txinqcorremailwaddresscnt6m AND txinqcorremailwaddresscnt6m <= 6.5 => 0,
    txinqcorremailwaddresscnt6m > 6.5                                         => 0,
    txinqcorremailwaddresscnt6m = NULL                                        => rc011_108_7_c497,
                                                                                 0);

gbm10_wc_lgt_108_c496 := map(
    NULL < txinqcorremailwaddresscnt6m AND txinqcorremailwaddresscnt6m <= 6.5 => 0.1316409358,
    txinqcorremailwaddresscnt6m > 6.5                                         => 0.6763770615,
    txinqcorremailwaddresscnt6m = NULL                                        => gbm10_wc_lgt_108_c497,
                                                                                 0.0889613589);

rc050_108_4_c496 := map(
    NULL < txinqcorremailwaddresscnt6m AND txinqcorremailwaddresscnt6m <= 6.5 => 0.0426795769,
    txinqcorremailwaddresscnt6m > 6.5                                         => 0.5874157026,
    txinqcorremailwaddresscnt6m = NULL                                        => -0.1241875815,
                                                                                 0);

rc022_108_2_c495 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 18.5 => -0.0903585912,
    txinqwphonelast_dayssince > 18.5                                       => 0.0393002563,
    txinqwphonelast_dayssince = NULL                                       => 0.0559276411,
                                                                              0);

gbm10_wc_lgt_108_c495 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 18.5 => -0.0406974886,
    txinqwphonelast_dayssince > 18.5                                       => gbm10_wc_lgt_108_c496,
    txinqwphonelast_dayssince = NULL                                       => 0.1055887437,
                                                                              0.0496611026);

rc011_108_7_c495 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 18.5 => 0,
    txinqwphonelast_dayssince > 18.5                                       => rc011_108_7_c496,
    txinqwphonelast_dayssince = NULL                                       => 0,
                                                                              0);

rc050_108_4_c495 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 18.5 => 0,
    txinqwphonelast_dayssince > 18.5                                       => rc050_108_4_c496,
    txinqwphonelast_dayssince = NULL                                       => 0,
                                                                              0);

rc050_108_4 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 0.5 => rc050_108_4_c495,
    txinqwemaillast_dayssince > 0.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

rc029_108_1 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 0.5 => 0.0518684818,
    txinqwemaillast_dayssince > 0.5                                       => -0.0035788003,
    txinqwemaillast_dayssince = NULL                                      => -0.0041622033,
                                                                             0);

gbm10_wc_lgt_108 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 0.5 => gbm10_wc_lgt_108_c495,
    txinqwemaillast_dayssince > 0.5                                       => -0.0057861796,
    txinqwemaillast_dayssince = NULL                                      => -0.0063695825,
                                                                             -0.0022073792);

rc022_108_2 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 0.5 => rc022_108_2_c495,
    txinqwemaillast_dayssince > 0.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

rc011_108_7 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 0.5 => rc011_108_7_c495,
    txinqwemaillast_dayssince > 0.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_109_c500 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 48.5 => 0.0025298001,
    trueipperphoneintxinqcnt > 48.5                                      => -0.3048814859,
    trueipperphoneintxinqcnt = NULL                                      => 0.0024002922,
                                                                            0.0024002922);

rc017_109_3_c500 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 48.5 => 0.0001295079,
    trueipperphoneintxinqcnt > 48.5                                      => -0.3072817781,
    trueipperphoneintxinqcnt = NULL                                      => 0,
                                                                            0);

rc020_109_8_c501 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 4.5 => -0.0010827628,
    phoneperemailintxinqcnt1y > 4.5                                       => 0.1706102755,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_109_c501 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 4.5 => -0.0057698049,
    phoneperemailintxinqcnt1y > 4.5                                       => 0.1659232334,
    phoneperemailintxinqcnt1y = NULL                                      => -0.0046870421,
                                                                             -0.0046870421);

gbm10_wc_lgt_109_c499 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 1236.5 => gbm10_wc_lgt_109_c500,
    txinqwphonefirst_dayssince > 1236.5                                        => -0.1355166027,
    txinqwphonefirst_dayssince = NULL                                          => gbm10_wc_lgt_109_c501,
                                                                                  0.0001798118);

rc020_109_8_c499 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 1236.5 => 0,
    txinqwphonefirst_dayssince > 1236.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                          => rc020_109_8_c501,
                                                                                  0);

rc017_109_3_c499 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 1236.5 => rc017_109_3_c500,
    txinqwphonefirst_dayssince > 1236.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                          => 0,
                                                                                  0);

rc005_109_2_c499 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 1236.5 => 0.0022204804,
    txinqwphonefirst_dayssince > 1236.5                                        => -0.1356964145,
    txinqwphonefirst_dayssince = NULL                                          => -0.0048668539,
                                                                                  0);

rc005_109_2 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 37.5 => rc005_109_2_c499,
    smartidperemailintxinqcnt1y > 37.5                                         => 0,
    smartidperemailintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

rc017_109_3 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 37.5 => rc017_109_3_c499,
    smartidperemailintxinqcnt1y > 37.5                                         => 0,
    smartidperemailintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

rc054_109_1 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 37.5 => 0.0004133963,
    smartidperemailintxinqcnt1y > 37.5                                         => -0.1164723031,
    smartidperemailintxinqcnt1y = NULL                                         => -0.0017061103,
                                                                                  0);

rc020_109_8 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 37.5 => rc020_109_8_c499,
    smartidperemailintxinqcnt1y > 37.5                                         => 0,
    smartidperemailintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_109 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 37.5 => gbm10_wc_lgt_109_c499,
    smartidperemailintxinqcnt1y > 37.5                                         => -0.1167058876,
    smartidperemailintxinqcnt1y = NULL                                         => -0.0019396949,
                                                                                  -0.0002335845);

gbm10_wc_lgt_110_c505 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 33.915 => 0.3856137741,
    timebtwtxinqwemailavg > 33.915                                   => 0.0416950380,
    timebtwtxinqwemailavg = NULL                                     => 0.0189074464,
                                                                        0.0438259024);

rc006_110_5_c505 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 33.915 => 0.3417878717,
    timebtwtxinqwemailavg > 33.915                                   => -0.0021308644,
    timebtwtxinqwemailavg = NULL                                     => -0.0249184560,
                                                                        0);

gbm10_wc_lgt_110_c504 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => -0.0047741310,
    loginidperphoneintxinqcnt > 2.5                                       => gbm10_wc_lgt_110_c505,
    loginidperphoneintxinqcnt = NULL                                      => 0.0019975656,
                                                                             -0.0022905955);

rc015_110_3_c504 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => -0.0024835355,
    loginidperphoneintxinqcnt > 2.5                                       => 0.0461164979,
    loginidperphoneintxinqcnt = NULL                                      => 0.0042881612,
                                                                             0);

rc006_110_5_c504 := map(
    NULL < loginidperphoneintxinqcnt AND loginidperphoneintxinqcnt <= 2.5 => 0,
    loginidperphoneintxinqcnt > 2.5                                       => rc006_110_5_c505,
    loginidperphoneintxinqcnt = NULL                                      => 0,
                                                                             0);

rc043_110_2_c503 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 19.5 => -0.0001057176,
    orgidperemailintxinqcnt > 19.5                                     => 0.2464042585,
    orgidperemailintxinqcnt = NULL                                     => 0,
                                                                          0);

rc006_110_5_c503 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 19.5 => rc006_110_5_c504,
    orgidperemailintxinqcnt > 19.5                                     => 0,
    orgidperemailintxinqcnt = NULL                                     => 0,
                                                                          0);

gbm10_wc_lgt_110_c503 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 19.5 => gbm10_wc_lgt_110_c504,
    orgidperemailintxinqcnt > 19.5                                     => 0.2442193806,
    orgidperemailintxinqcnt = NULL                                     => -0.0021848779,
                                                                          -0.0021848779);

rc015_110_3_c503 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 19.5 => rc015_110_3_c504,
    orgidperemailintxinqcnt > 19.5                                     => 0,
    orgidperemailintxinqcnt = NULL                                     => 0,
                                                                          0);

rc030_110_1 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => -0.0000457048,
    phoneperemailintxinqcnt3m > 5.5                                       => -0.0924132744,
    phoneperemailintxinqcnt3m = NULL                                      => 0.0005845122,
                                                                             0);

rc043_110_2 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => rc043_110_2_c503,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc015_110_3 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => rc015_110_3_c503,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_110 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => gbm10_wc_lgt_110_c503,
    phoneperemailintxinqcnt3m > 5.5                                       => -0.0945524475,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0015546609,
                                                                             -0.0021391731);

rc006_110_5 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => rc006_110_5_c503,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc023_111_4_c508 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 15.5 => 0.1388662927,
    txinqcorremailwphonecnt > 15.5                                     => -0.0368236374,
    txinqcorremailwphonecnt = NULL                                     => 0,
                                                                          0);

gbm10_wc_lgt_111_c508 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 15.5 => 0.2158984579,
    txinqcorremailwphonecnt > 15.5                                     => 0.0402085278,
    txinqcorremailwphonecnt = NULL                                     => 0.0770321652,
                                                                          0.0770321652);

rc023_111_4_c507 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => 0,
    txinqcorremailwphonecnt1m > 7.5                                       => rc023_111_4_c508,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_111_c507 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => -0.0094887895,
    txinqcorremailwphonecnt1m > 7.5                                       => gbm10_wc_lgt_111_c508,
    txinqcorremailwphonecnt1m = NULL                                      => -0.0122698177,
                                                                             -0.0092105282);

rc032_111_2_c507 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 7.5 => -0.0002782613,
    txinqcorremailwphonecnt1m > 7.5                                       => 0.0862426934,
    txinqcorremailwphonecnt1m = NULL                                      => -0.0030592895,
                                                                             0);

rc044_111_9_c509 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 10.5 => -0.0365834971,
    exactidperemailintxinqcnt3m > 10.5                                         => 0.2894625974,
    exactidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_111_c509 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 10.5 => 0.0081961136,
    exactidperemailintxinqcnt3m > 10.5                                         => 0.3342422080,
    exactidperemailintxinqcnt3m = NULL                                         => 0.0447796107,
                                                                                  0.0447796107);

rc041_111_1 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 6.5 => -0.0071673716,
    txinqcorremailwnamecnt1y > 6.5                                      => 0.0468227673,
    txinqcorremailwnamecnt1y = NULL                                     => 0.0113506111,
                                                                           0);

rc044_111_9 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 6.5 => 0,
    txinqcorremailwnamecnt1y > 6.5                                      => rc044_111_9_c509,
    txinqcorremailwnamecnt1y = NULL                                     => 0,
                                                                           0);

gbm10_wc_lgt_111 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 6.5 => gbm10_wc_lgt_111_c507,
    txinqcorremailwnamecnt1y > 6.5                                      => gbm10_wc_lgt_111_c509,
    txinqcorremailwnamecnt1y = NULL                                     => 0.0093074545,
                                                                           -0.0020431566);

rc023_111_4 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 6.5 => rc023_111_4_c507,
    txinqcorremailwnamecnt1y > 6.5                                      => 0,
    txinqcorremailwnamecnt1y = NULL                                     => 0,
                                                                           0);

rc032_111_2 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 6.5 => rc032_111_2_c507,
    txinqcorremailwnamecnt1y > 6.5                                      => 0,
    txinqcorremailwnamecnt1y = NULL                                     => 0,
                                                                           0);

gbm10_wc_lgt_112_c513 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 555.5 => 0.4630347705,
    txinqwemailfirst_dayssince > 555.5                                        => -0.0504799780,
    txinqwemailfirst_dayssince = NULL                                         => 0.2207086963,
                                                                                 0.2207086963);

rc002_112_7_c513 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 555.5 => 0.2423260742,
    txinqwemailfirst_dayssince > 555.5                                        => -0.2711886743,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_112_c512 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1047.75 => 0.0133263149,
    distbtwtrueipwemailavg > 1047.75                                    => gbm10_wc_lgt_112_c513,
    distbtwtrueipwemailavg = NULL                                       => 0.0329893424,
                                                                           0.0329893424);

rc011_112_5_c512 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1047.75 => -0.0196630275,
    distbtwtrueipwemailavg > 1047.75                                    => 0.1877193539,
    distbtwtrueipwemailavg = NULL                                       => 0,
                                                                           0);

rc002_112_7_c512 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 1047.75 => 0,
    distbtwtrueipwemailavg > 1047.75                                    => rc002_112_7_c513,
    distbtwtrueipwemailavg = NULL                                       => 0,
                                                                           0);

gbm10_wc_lgt_112_c511 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13800.15 => -0.0620536543,
    timebtwtxinqwemailavg > 13800.15                                   => gbm10_wc_lgt_112_c512,
    timebtwtxinqwemailavg = NULL                                       => -0.0156557733,
                                                                          -0.0227291331);

rc011_112_5_c511 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13800.15 => 0,
    timebtwtxinqwemailavg > 13800.15                                   => rc011_112_5_c512,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc002_112_7_c511 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13800.15 => 0,
    timebtwtxinqwemailavg > 13800.15                                   => rc002_112_7_c512,
    timebtwtxinqwemailavg = NULL                                       => 0,
                                                                          0);

rc006_112_3_c511 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 13800.15 => -0.0393245212,
    timebtwtxinqwemailavg > 13800.15                                   => 0.0557184755,
    timebtwtxinqwemailavg = NULL                                       => 0.0070733598,
                                                                          0);

rc002_112_7 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0,
    exactidperphoneintxinqcnt3m > 3.5                                         => rc002_112_7_c511,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc021_112_1 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0.0012663465,
    exactidperphoneintxinqcnt3m > 3.5                                         => -0.0246434362,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0019518227,
                                                                                 0);

rc006_112_3 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0,
    exactidperphoneintxinqcnt3m > 3.5                                         => rc006_112_3_c511,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_112 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0.0031806496,
    exactidperphoneintxinqcnt3m > 3.5                                         => gbm10_wc_lgt_112_c511,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0000375196,
                                                                                 0.0019143031);

rc011_112_5 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 3.5 => 0,
    exactidperphoneintxinqcnt3m > 3.5                                         => rc011_112_5_c511,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_113_c517 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 14682.715 => -0.1530879426,
    timebtwtxinqwemailavg > 14682.715                                   => 0.1521350256,
    timebtwtxinqwemailavg = NULL                                        => -0.1585104492,
                                                                           -0.0799079284);

rc006_113_7_c517 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 14682.715 => -0.0731800142,
    timebtwtxinqwemailavg > 14682.715                                   => 0.2320429540,
    timebtwtxinqwemailavg = NULL                                        => -0.0786025208,
                                                                           0);

gbm10_wc_lgt_113_c516 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 18416.22 => gbm10_wc_lgt_113_c517,
    timebtwtxinqwphoneavg > 18416.22                                   => 0.1772833463,
    timebtwtxinqwphoneavg = NULL                                       => 0.0054149155,
                                                                          0.0054149155);

rc012_113_6_c516 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 18416.22 => -0.0853228439,
    timebtwtxinqwphoneavg > 18416.22                                   => 0.1718684308,
    timebtwtxinqwphoneavg = NULL                                       => 0,
                                                                          0);

rc006_113_7_c516 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 18416.22 => rc006_113_7_c517,
    timebtwtxinqwphoneavg > 18416.22                                   => 0,
    timebtwtxinqwphoneavg = NULL                                       => 0,
                                                                          0);

rc006_113_7_c515 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 16.5 => 0,
    txinqwaddrlast_dayssince > 16.5                                      => 0,
    txinqwaddrlast_dayssince = NULL                                      => rc006_113_7_c516,
                                                                            0);

rc012_113_6_c515 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 16.5 => 0,
    txinqwaddrlast_dayssince > 16.5                                      => 0,
    txinqwaddrlast_dayssince = NULL                                      => rc012_113_6_c516,
                                                                            0);

rc025_113_3_c515 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 16.5 => -0.0398931404,
    txinqwaddrlast_dayssince > 16.5                                      => 0.0801570139,
    txinqwaddrlast_dayssince = NULL                                      => -0.0271265060,
                                                                            0);

gbm10_wc_lgt_113_c515 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 16.5 => -0.0073517189,
    txinqwaddrlast_dayssince > 16.5                                      => 0.1126984354,
    txinqwaddrlast_dayssince = NULL                                      => gbm10_wc_lgt_113_c516,
                                                                            0.0325414215);

rc012_113_6 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc012_113_6_c515,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc006_113_7 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc006_113_7_c515,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc025_113_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc025_113_3_c515,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_113 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0018574727,
    smartidperphoneintxinqcnt1m > 3.5                                         => gbm10_wc_lgt_113_c515,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0000300168,
                                                                                 -0.0012564469);

rc003_113_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0006010258,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.0337978684,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0012264301,
                                                                                 0);

rc009_114_4_c520 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 3.5 => 0.0170733192,
    exactidperemailintxinqcnt1m > 3.5                                         => -0.1116515409,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_114_c520 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 3.5 => -0.0580613827,
    exactidperemailintxinqcnt1m > 3.5                                         => -0.1867862427,
    exactidperemailintxinqcnt1m = NULL                                        => -0.0751347018,
                                                                                 -0.0751347018);

gbm10_wc_lgt_114_c521 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 9.5 => 0.3091223543,
    browserhashperphoneintxinqcnt > 9.5                                           => -0.0778689447,
    browserhashperphoneintxinqcnt = NULL                                          => 0.1349014455,
                                                                                     0.1349014455);

rc038_114_8_c521 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 9.5 => 0.1742209087,
    browserhashperphoneintxinqcnt > 9.5                                           => -0.2127703902,
    browserhashperphoneintxinqcnt = NULL                                          => 0,
                                                                                     0);

rc024_114_3_c519 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 4.5 => -0.0061412473,
    tmxidperemailintxinqcnt1m > 4.5                                       => 0.2038949000,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc038_114_8_c519 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 4.5 => 0,
    tmxidperemailintxinqcnt1m > 4.5                                       => rc038_114_8_c521,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc009_114_4_c519 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 4.5 => rc009_114_4_c520,
    tmxidperemailintxinqcnt1m > 4.5                                       => 0,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_114_c519 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 4.5 => gbm10_wc_lgt_114_c520,
    tmxidperemailintxinqcnt1m > 4.5                                       => gbm10_wc_lgt_114_c521,
    tmxidperemailintxinqcnt1m = NULL                                      => -0.0689934545,
                                                                             -0.0689934545);

rc038_114_8 := map(
    NULL < txinqcorremailwaddresscnt AND txinqcorremailwaddresscnt <= 5.5 => 0,
    txinqcorremailwaddresscnt > 5.5                                       => rc038_114_8_c519,
    txinqcorremailwaddresscnt = NULL                                      => 0,
                                                                             0);

rc024_114_3 := map(
    NULL < txinqcorremailwaddresscnt AND txinqcorremailwaddresscnt <= 5.5 => 0,
    txinqcorremailwaddresscnt > 5.5                                       => rc024_114_3_c519,
    txinqcorremailwaddresscnt = NULL                                      => 0,
                                                                             0);

rc009_114_4 := map(
    NULL < txinqcorremailwaddresscnt AND txinqcorremailwaddresscnt <= 5.5 => 0,
    txinqcorremailwaddresscnt > 5.5                                       => rc009_114_4_c519,
    txinqcorremailwaddresscnt = NULL                                      => 0,
                                                                             0);

rc053_114_1 := map(
    NULL < txinqcorremailwaddresscnt AND txinqcorremailwaddresscnt <= 5.5 => 0.0028331851,
    txinqcorremailwaddresscnt > 5.5                                       => -0.0698430910,
    txinqcorremailwaddresscnt = NULL                                      => -0.0000560689,
                                                                             0);

gbm10_wc_lgt_114 := map(
    NULL < txinqcorremailwaddresscnt AND txinqcorremailwaddresscnt <= 5.5 => 0.0036828215,
    txinqcorremailwaddresscnt > 5.5                                       => gbm10_wc_lgt_114_c519,
    txinqcorremailwaddresscnt = NULL                                      => 0.0007935675,
                                                                             0.0008496365);

gbm10_wc_lgt_115_c524 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 85.5 => -0.0016361944,
    txinqwphonecnt1y > 85.5                              => -0.1834672257,
    txinqwphonecnt1y = NULL                              => 0.0711927838,
                                                            -0.0009993195);

rc010_115_3_c524 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 85.5 => -0.0006368749,
    txinqwphonecnt1y > 85.5                              => -0.1824679061,
    txinqwphonecnt1y = NULL                              => 0.0721921033,
                                                            0);

gbm10_wc_lgt_115_c525 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 154.5 => 0.9790208301,
    txinqwaddrfirst_dayssince > 154.5                                       => -0.0034747187,
    txinqwaddrfirst_dayssince = NULL                                        => 0.3369925238,
                                                                               0.3369925238);

rc016_115_7_c525 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 154.5 => 0.6420283063,
    txinqwaddrfirst_dayssince > 154.5                                       => -0.3404672424,
    txinqwaddrfirst_dayssince = NULL                                        => 0,
                                                                               0);

gbm10_wc_lgt_115_c523 := map(
    NULL < proxyipgperemailintxinqcnt AND proxyipgperemailintxinqcnt <= 1.5 => gbm10_wc_lgt_115_c524,
    proxyipgperemailintxinqcnt > 1.5                                        => gbm10_wc_lgt_115_c525,
    proxyipgperemailintxinqcnt = NULL                                       => -0.0717591831,
                                                                               -0.0003198941);

rc016_115_7_c523 := map(
    NULL < proxyipgperemailintxinqcnt AND proxyipgperemailintxinqcnt <= 1.5 => 0,
    proxyipgperemailintxinqcnt > 1.5                                        => rc016_115_7_c525,
    proxyipgperemailintxinqcnt = NULL                                       => 0,
                                                                               0);

rc010_115_3_c523 := map(
    NULL < proxyipgperemailintxinqcnt AND proxyipgperemailintxinqcnt <= 1.5 => rc010_115_3_c524,
    proxyipgperemailintxinqcnt > 1.5                                        => 0,
    proxyipgperemailintxinqcnt = NULL                                       => 0,
                                                                               0);

rc056_115_2_c523 := map(
    NULL < proxyipgperemailintxinqcnt AND proxyipgperemailintxinqcnt <= 1.5 => -0.0006794254,
    proxyipgperemailintxinqcnt > 1.5                                        => 0.3373124179,
    proxyipgperemailintxinqcnt = NULL                                       => -0.0714392890,
                                                                               0);

rc016_115_7 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => rc016_115_7_c523,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc035_115_1 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => 0.0002461121,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0.1653782095,
    txinqwtmxidfirst_dayssince = NULL                                         => -0.0001401360,
                                                                                 0);

rc010_115_3 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => rc010_115_3_c523,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc056_115_2 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => rc056_115_2_c523,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_115 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 512.5 => gbm10_wc_lgt_115_c523,
    txinqwtmxidfirst_dayssince > 512.5                                        => 0.1648122033,
    txinqwtmxidfirst_dayssince = NULL                                         => -0.0007061423,
                                                                                 -0.0005660063);

rc009_116_4_c529 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => -0.0664386853,
    exactidperemailintxinqcnt1m > 0.5                                         => 0.0983717669,
    exactidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_116_c529 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 0.5 => 0.1202005104,
    exactidperemailintxinqcnt1m > 0.5                                         => 0.2850109626,
    exactidperemailintxinqcnt1m = NULL                                        => 0.1866391957,
                                                                                 0.1866391957);

gbm10_wc_lgt_116_c528 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 7.5 => gbm10_wc_lgt_116_c529,
    txinqwphonefirst_dayssince > 7.5                                        => 0.0344410022,
    txinqwphonefirst_dayssince = NULL                                       => 0.0395025221,
                                                                               0.0395025221);

rc009_116_4_c528 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 7.5 => rc009_116_4_c529,
    txinqwphonefirst_dayssince > 7.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc005_116_3_c528 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 7.5 => 0.1471366736,
    txinqwphonefirst_dayssince > 7.5                                        => -0.0050615199,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_116_c527 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => gbm10_wc_lgt_116_c528,
    txinqcorremailwphonecnt3m > 0.5                                       => -0.0126859165,
    txinqcorremailwphonecnt3m = NULL                                      => 0.0478992940,
                                                                             0.0121601517);

rc009_116_4_c527 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => rc009_116_4_c528,
    txinqcorremailwphonecnt3m > 0.5                                       => 0,
    txinqcorremailwphonecnt3m = NULL                                      => 0,
                                                                             0);

rc027_116_2_c527 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => 0.0273423704,
    txinqcorremailwphonecnt3m > 0.5                                       => -0.0248460683,
    txinqcorremailwphonecnt3m = NULL                                      => 0.0357391423,
                                                                             0);

rc005_116_3_c527 := map(
    NULL < txinqcorremailwphonecnt3m AND txinqcorremailwphonecnt3m <= 0.5 => rc005_116_3_c528,
    txinqcorremailwphonecnt3m > 0.5                                       => 0,
    txinqcorremailwphonecnt3m = NULL                                      => 0,
                                                                             0);

rc009_116_4 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 160.5 => rc009_116_4_c527,
    txinqwphonelast_dayssince > 160.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                        => 0,
                                                                               0);

rc005_116_3 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 160.5 => rc005_116_3_c527,
    txinqwphonelast_dayssince > 160.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                        => 0,
                                                                               0);

rc027_116_2 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 160.5 => rc027_116_2_c527,
    txinqwphonelast_dayssince > 160.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                        => 0,
                                                                               0);

rc022_116_1 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 160.5 => 0.0210484078,
    txinqwphonelast_dayssince > 160.5                                       => -0.0418146159,
    txinqwphonelast_dayssince = NULL                                        => -0.0004171691,
                                                                               0);

gbm10_wc_lgt_116 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 160.5 => gbm10_wc_lgt_116_c527,
    txinqwphonelast_dayssince > 160.5                                       => -0.0507028721,
    txinqwphonelast_dayssince = NULL                                        => -0.0093054252,
                                                                               -0.0088882561);

gbm10_wc_lgt_117_c533 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 6.5 => -0.0573388497,
    tmxidperphoneintxinqcnt1y > 6.5                                       => 0.1305110304,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0.0439009741,
                                                                             0.0439009741);

rc031_117_5_c533 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 6.5 => -0.1012398239,
    tmxidperphoneintxinqcnt1y > 6.5                                       => 0.0866100563,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc031_117_5_c532 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 33.5 => rc031_117_5_c533,
    txinqwphonecnt1y > 33.5                              => 0,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc010_117_4_c532 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 33.5 => 0.0524522152,
    txinqwphonecnt1y > 33.5                              => -0.2085444959,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

gbm10_wc_lgt_117_c532 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 33.5 => gbm10_wc_lgt_117_c533,
    txinqwphonecnt1y > 33.5                              => -0.2170957369,
    txinqwphonecnt1y = NULL                              => -0.0085512410,
                                                            -0.0085512410);

gbm10_wc_lgt_117_c531 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 459.5 => gbm10_wc_lgt_117_c532,
    txinqwaddrfirst_dayssince > 459.5                                       => -0.1623586295,
    txinqwaddrfirst_dayssince = NULL                                        => -0.0207165835,
                                                                               -0.0403222649);

rc031_117_5_c531 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 459.5 => rc031_117_5_c532,
    txinqwaddrfirst_dayssince > 459.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                        => 0,
                                                                               0);

rc010_117_4_c531 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 459.5 => rc010_117_4_c532,
    txinqwaddrfirst_dayssince > 459.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                        => 0,
                                                                               0);

rc016_117_3_c531 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 459.5 => 0.0317710239,
    txinqwaddrfirst_dayssince > 459.5                                       => -0.1220363645,
    txinqwaddrfirst_dayssince = NULL                                        => 0.0196056815,
                                                                               0);

rc016_117_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => 0,
    emailperphoneintxinqcnt3m > 3.5                                       => rc016_117_3_c531,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_117_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => -0.0000747854,
    emailperphoneintxinqcnt3m > 3.5                                       => -0.0410615083,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0008220616,
                                                                             0);

rc031_117_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => 0,
    emailperphoneintxinqcnt3m > 3.5                                       => rc031_117_5_c531,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc010_117_4 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => 0,
    emailperphoneintxinqcnt3m > 3.5                                       => rc010_117_4_c531,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_117 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => 0.0006644579,
    emailperphoneintxinqcnt3m > 3.5                                       => gbm10_wc_lgt_117_c531,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0015613049,
                                                                             0.0007392433);

gbm10_wc_lgt_118_c537 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 375 => -0.1448918832,
    txinqwnamefirst_dayssince > 375                                       => 0.1254688728,
    txinqwnamefirst_dayssince = NULL                                      => -0.0016677688,
                                                                             -0.0346893520);

rc013_118_8_c537 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 375 => -0.1102025312,
    txinqwnamefirst_dayssince > 375                                       => 0.1601582248,
    txinqwnamefirst_dayssince = NULL                                      => 0.0330215832,
                                                                             0);

rc013_118_8_c536 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 4.5 => 0,
    txinqwphonecnt1y > 4.5                              => rc013_118_8_c537,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

rc010_118_6_c536 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 4.5 => 0.3380240107,
    txinqwphonecnt1y > 4.5                              => -0.0734315934,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

gbm10_wc_lgt_118_c536 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 4.5 => 0.3767662521,
    txinqwphonecnt1y > 4.5                              => gbm10_wc_lgt_118_c537,
    txinqwphonecnt1y = NULL                             => 0.0387422413,
                                                           0.0387422413);

rc013_118_8_c535 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => 0,
    emailperphoneintxinqcnt6m > 2.5                                       => rc013_118_8_c536,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_118_c535 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => -0.0240739627,
    emailperphoneintxinqcnt6m > 2.5                                       => gbm10_wc_lgt_118_c536,
    emailperphoneintxinqcnt6m = NULL                                      => 0.0130274434,
                                                                             -0.0110399320);

rc014_118_4_c535 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => -0.0130340307,
    emailperphoneintxinqcnt6m > 2.5                                       => 0.0497821734,
    emailperphoneintxinqcnt6m = NULL                                      => 0.0240673754,
                                                                             0);

rc010_118_6_c535 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 2.5 => 0,
    emailperphoneintxinqcnt6m > 2.5                                       => rc010_118_6_c536,
    emailperphoneintxinqcnt6m = NULL                                      => 0,
                                                                             0);

rc029_118_1 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => 0.0212523078,
    txinqwemaillast_dayssince > 97.5                                       => -0.0563117416,
    txinqwemaillast_dayssince = NULL                                       => 0.0002784386,
                                                                              0);

gbm10_wc_lgt_118 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => 0.0099339371,
    txinqwemaillast_dayssince > 97.5                                       => -0.0676301122,
    txinqwemaillast_dayssince = NULL                                       => gbm10_wc_lgt_118_c535,
                                                                              -0.0113183706);

rc010_118_6 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => 0,
    txinqwemaillast_dayssince > 97.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                       => rc010_118_6_c535,
                                                                              0);

rc014_118_4 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => 0,
    txinqwemaillast_dayssince > 97.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                       => rc014_118_4_c535,
                                                                              0);

rc013_118_8 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 97.5 => 0,
    txinqwemaillast_dayssince > 97.5                                       => 0,
    txinqwemaillast_dayssince = NULL                                       => rc013_118_8_c535,
                                                                              0);

gbm10_wc_lgt_119_c541 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => 0.0005279859,
    emailperphoneintxinqcnt3m > 3.5                                       => -0.0558866035,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0003645287,
                                                                             0.0003645287);

rc001_119_4_c541 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 3.5 => 0.0001634572,
    emailperphoneintxinqcnt3m > 3.5                                       => -0.0562511322,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_119_c540 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 9.5 => gbm10_wc_lgt_119_c541,
    tmxidperphoneintxinqcnt1y > 9.5                                       => 0.1156433178,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0.0004370808,
                                                                             0.0004370808);

rc031_119_3_c540 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 9.5 => -0.0000725521,
    tmxidperphoneintxinqcnt1y > 9.5                                       => 0.1152062371,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc001_119_4_c540 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 9.5 => rc001_119_4_c541,
    tmxidperphoneintxinqcnt1y > 9.5                                       => 0,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc001_119_4_c539 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 12.5 => rc001_119_4_c540,
    tmxidperphoneintxinqcnt1y > 12.5                                       => 0,
    tmxidperphoneintxinqcnt1y = NULL                                       => 0,
                                                                              0);

rc031_119_2_c539 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 12.5 => 0.0000802319,
    tmxidperphoneintxinqcnt1y > 12.5                                       => -0.1800984354,
    tmxidperphoneintxinqcnt1y = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_119_c539 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 12.5 => gbm10_wc_lgt_119_c540,
    tmxidperphoneintxinqcnt1y > 12.5                                       => -0.1797415864,
    tmxidperphoneintxinqcnt1y = NULL                                       => 0.0003568489,
                                                                              0.0003568489);

rc031_119_3_c539 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 12.5 => rc031_119_3_c540,
    tmxidperphoneintxinqcnt1y > 12.5                                       => 0,
    tmxidperphoneintxinqcnt1y = NULL                                       => 0,
                                                                              0);

rc001_119_4 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => rc001_119_4_c539,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc031_119_2 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => rc031_119_2_c539,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc004_119_1 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => -0.0002663232,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0.0835645606,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0.0007775847,
                                                                             0);

rc031_119_3 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => rc031_119_3_c539,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_119 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 9.5 => gbm10_wc_lgt_119_c539,
    tmxidperphoneintxinqcnt3m > 9.5                                       => 0.0841877328,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0.0014007568,
                                                                             0.0006231722);

gbm10_wc_lgt_120_c545 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 6.5 => -0.2831981243,
    txinqwphonefirst_dayssince > 6.5                                        => 0.0761741302,
    txinqwphonefirst_dayssince = NULL                                       => -0.0106177580,
                                                                               -0.0106177580);

rc005_120_5_c545 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 6.5 => -0.2725803663,
    txinqwphonefirst_dayssince > 6.5                                        => 0.0867918882,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_120_c544 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => gbm10_wc_lgt_120_c545,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.1595479473,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0631990069,
                                                                                 -0.0631990069);

rc005_120_5_c544 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => rc005_120_5_c545,
    smartidperphoneintxinqcnt1m > 1.5                                         => 0,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_120_4_c544 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0525812488,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0963489404,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_120_4_c543 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => rc003_120_4_c544,
    emailperphoneintxinqcnt > 2.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc005_120_5_c543 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => rc005_120_5_c544,
    emailperphoneintxinqcnt > 2.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc033_120_3_c543 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => -0.0222620501,
    emailperphoneintxinqcnt > 2.5                                     => 0.2081568599,
    emailperphoneintxinqcnt = NULL                                    => -0.1066807590,
                                                                         0);

gbm10_wc_lgt_120_c543 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => gbm10_wc_lgt_120_c544,
    emailperphoneintxinqcnt > 2.5                                     => 0.1672199031,
    emailperphoneintxinqcnt = NULL                                    => -0.1476177158,
                                                                         -0.0409369568);

rc003_120_4 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc003_120_4_c543,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc008_120_1 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0013018317,
    smartidperemailintxinqcnt1m > 8.5                                         => -0.0409515416,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0064886213,
                                                                                 0);

gbm10_wc_lgt_120 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0.0013164165,
    smartidperemailintxinqcnt1m > 8.5                                         => gbm10_wc_lgt_120_c543,
    smartidperemailintxinqcnt1m = NULL                                        => -0.0064740365,
                                                                                 0.0000145848);

rc033_120_3 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc033_120_3_c543,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc005_120_5 := map(
    NULL < smartidperemailintxinqcnt1m AND smartidperemailintxinqcnt1m <= 8.5 => 0,
    smartidperemailintxinqcnt1m > 8.5                                         => rc005_120_5_c543,
    smartidperemailintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_121_c549 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 1.5 => 0.2276202775,
    phoneperemailintxinqcnt1y > 1.5                                       => 0.6240745509,
    phoneperemailintxinqcnt1y = NULL                                      => 0.3631965391,
                                                                             0.3631965391);

rc020_121_7_c549 := map(
    NULL < phoneperemailintxinqcnt1y AND phoneperemailintxinqcnt1y <= 1.5 => -0.1355762617,
    phoneperemailintxinqcnt1y > 1.5                                       => 0.2608780117,
    phoneperemailintxinqcnt1y = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_121_c548 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 7.5 => -0.0110394125,
    txinqwemaillast_dayssince > 7.5                                       => gbm10_wc_lgt_121_c549,
    txinqwemaillast_dayssince = NULL                                      => 0.1397018311,
                                                                             0.0630808300);

rc029_121_5_c548 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 7.5 => -0.0741202425,
    txinqwemaillast_dayssince > 7.5                                       => 0.3001157091,
    txinqwemaillast_dayssince = NULL                                      => 0.0766210010,
                                                                             0);

rc020_121_7_c548 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 7.5 => 0,
    txinqwemaillast_dayssince > 7.5                                       => rc020_121_7_c549,
    txinqwemaillast_dayssince = NULL                                      => 0,
                                                                             0);

rc022_121_4_c547 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 1.5 => 0.0657874738,
    txinqwphonelast_dayssince > 1.5                                       => 0.0015777577,
    txinqwphonelast_dayssince = NULL                                      => -0.0042609989,
                                                                             0);

rc020_121_7_c547 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 1.5 => rc020_121_7_c548,
    txinqwphonelast_dayssince > 1.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_121_c547 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 1.5 => gbm10_wc_lgt_121_c548,
    txinqwphonelast_dayssince > 1.5                                       => -0.0011288861,
    txinqwphonelast_dayssince = NULL                                      => -0.0069676427,
                                                                             -0.0027066438);

rc029_121_5_c547 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 1.5 => rc029_121_5_c548,
    txinqwphonelast_dayssince > 1.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                      => 0,
                                                                             0);

rc029_121_5 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 2435.5 => 0,
    txinqwaddrfirst_dayssince > 2435.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                         => rc029_121_5_c547,
                                                                                0);

gbm10_wc_lgt_121 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 2435.5 => -0.0030558293,
    txinqwaddrfirst_dayssince > 2435.5                                       => 0.4532640931,
    txinqwaddrfirst_dayssince = NULL                                         => gbm10_wc_lgt_121_c547,
                                                                                -0.0028082026);

rc016_121_1 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 2435.5 => -0.0002476267,
    txinqwaddrfirst_dayssince > 2435.5                                       => 0.4560722957,
    txinqwaddrfirst_dayssince = NULL                                         => 0.0001015588,
                                                                                0);

rc020_121_7 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 2435.5 => 0,
    txinqwaddrfirst_dayssince > 2435.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                         => rc020_121_7_c547,
                                                                                0);

rc022_121_4 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 2435.5 => 0,
    txinqwaddrfirst_dayssince > 2435.5                                       => 0,
    txinqwaddrfirst_dayssince = NULL                                         => rc022_121_4_c547,
                                                                                0);

gbm10_wc_lgt_122_c553 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => -0.0843663395,
    tmxidperphoneintxinqcnt1y > 4.5                                       => 0.0131891782,
    tmxidperphoneintxinqcnt1y = NULL                                      => -0.0267196072,
                                                                             -0.0267196072);

rc031_122_7_c553 := map(
    NULL < tmxidperphoneintxinqcnt1y AND tmxidperphoneintxinqcnt1y <= 4.5 => -0.0576467323,
    tmxidperphoneintxinqcnt1y > 4.5                                       => 0.0399087854,
    tmxidperphoneintxinqcnt1y = NULL                                      => 0,
                                                                             0);

rc010_122_5_c552 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 4.5 => 0.1332297035,
    txinqwphonecnt1y > 4.5                              => -0.0091465030,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

rc031_122_7_c552 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 4.5 => 0,
    txinqwphonecnt1y > 4.5                              => rc031_122_7_c553,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

gbm10_wc_lgt_122_c552 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 4.5 => 0.1156565993,
    txinqwphonecnt1y > 4.5                              => gbm10_wc_lgt_122_c553,
    txinqwphonecnt1y = NULL                             => -0.0175731041,
                                                           -0.0175731041);

gbm10_wc_lgt_122_c551 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => -0.2331568121,
    txinqwphonecnt1y > 3.5                              => gbm10_wc_lgt_122_c552,
    txinqwphonecnt1y = NULL                             => -0.0260772144,
                                                           -0.0260772144);

rc010_122_3_c551 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => -0.2070795977,
    txinqwphonecnt1y > 3.5                              => 0.0085041103,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

rc031_122_7_c551 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => 0,
    txinqwphonecnt1y > 3.5                              => rc031_122_7_c552,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

rc010_122_5_c551 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => 0,
    txinqwphonecnt1y > 3.5                              => rc010_122_5_c552,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

rc010_122_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc010_122_5_c551,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc031_122_7 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc031_122_7_c551,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_122_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0000453482,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0274841688,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0008130256,
                                                                             0);

rc010_122_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc010_122_3_c551,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_122 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0014523026,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_122_c551,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0022199800,
                                                                             0.0014069544);

rc013_123_4_c557 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 326 => 0.1600577224,
    txinqwnamefirst_dayssince > 326                                       => -0.2552648519,
    txinqwnamefirst_dayssince = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_123_c557 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 326 => 0.3606764587,
    txinqwnamefirst_dayssince > 326                                       => -0.0546461156,
    txinqwnamefirst_dayssince = NULL                                      => 0.2006187363,
                                                                             0.2006187363);

gbm10_wc_lgt_123_c556 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 972.86 => gbm10_wc_lgt_123_c557,
    timebtwtxinqwphoneavg > 972.86                                   => -0.0258398951,
    timebtwtxinqwphoneavg = NULL                                     => 0.1812043228,
                                                                        0.0413421315);

rc012_123_3_c556 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 972.86 => 0.1592766048,
    timebtwtxinqwphoneavg > 972.86                                   => -0.0671820267,
    timebtwtxinqwphoneavg = NULL                                     => 0.1398621912,
                                                                        0);

rc013_123_4_c556 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 972.86 => rc013_123_4_c557,
    timebtwtxinqwphoneavg > 972.86                                   => 0,
    timebtwtxinqwphoneavg = NULL                                     => 0,
                                                                        0);

gbm10_wc_lgt_123_c555 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => gbm10_wc_lgt_123_c556,
    tmxidperphoneintxinqcnt3m > 1.5                                       => -0.0837389906,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0151011585,
                                                                             -0.0151011585);

rc013_123_4_c555 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => rc013_123_4_c556,
    tmxidperphoneintxinqcnt3m > 1.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc004_123_2_c555 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => 0.0564432900,
    tmxidperphoneintxinqcnt3m > 1.5                                       => -0.0686378321,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc012_123_3_c555 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => rc012_123_3_c556,
    tmxidperphoneintxinqcnt3m > 1.5                                       => 0,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc013_123_4 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 0.5 => rc013_123_4_c555,
    txinqwphonelast_dayssince > 0.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                      => 0,
                                                                             0);

rc004_123_2 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 0.5 => rc004_123_2_c555,
    txinqwphonelast_dayssince > 0.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                      => 0,
                                                                             0);

rc012_123_3 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 0.5 => rc012_123_3_c555,
    txinqwphonelast_dayssince > 0.5                                       => 0,
    txinqwphonelast_dayssince = NULL                                      => 0,
                                                                             0);

rc022_123_1 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 0.5 => -0.0146799537,
    txinqwphonelast_dayssince > 0.5                                       => 0.0048454995,
    txinqwphonelast_dayssince = NULL                                      => -0.0054566435,
                                                                             0);

gbm10_wc_lgt_123 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 0.5 => gbm10_wc_lgt_123_c555,
    txinqwphonelast_dayssince > 0.5                                       => 0.0044242947,
    txinqwphonelast_dayssince = NULL                                      => -0.0058778483,
                                                                             -0.0004212048);

rc039_124_4_c560 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => 0.0084211504,
    phoneperemailintxinqcnt1m > 2.5                                       => -0.1625844343,
    phoneperemailintxinqcnt1m = NULL                                      => -0.0586973757,
                                                                             0);

gbm10_wc_lgt_124_c560 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => 0.0129023005,
    phoneperemailintxinqcnt1m > 2.5                                       => -0.1581032842,
    phoneperemailintxinqcnt1m = NULL                                      => -0.0542162256,
                                                                             0.0044811501);

rc029_124_8_c561 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 11 => 0.2561130442,
    txinqwemaillast_dayssince > 11                                       => -0.3083027438,
    txinqwemaillast_dayssince = NULL                                     => 0,
                                                                            0);

gbm10_wc_lgt_124_c561 := map(
    NULL < txinqwemaillast_dayssince AND txinqwemaillast_dayssince <= 11 => 0.3024430532,
    txinqwemaillast_dayssince > 11                                       => -0.2619727348,
    txinqwemaillast_dayssince = NULL                                     => 0.0463300090,
                                                                            0.0463300090);

gbm10_wc_lgt_124_c559 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2324.5 => gbm10_wc_lgt_124_c560,
    txinqwnamefirst_dayssince > 2324.5                                       => gbm10_wc_lgt_124_c561,
    txinqwnamefirst_dayssince = NULL                                         => 0.0741913039,
                                                                                0.0218436420);

rc039_124_4_c559 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2324.5 => rc039_124_4_c560,
    txinqwnamefirst_dayssince > 2324.5                                       => 0,
    txinqwnamefirst_dayssince = NULL                                         => 0,
                                                                                0);

rc029_124_8_c559 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2324.5 => 0,
    txinqwnamefirst_dayssince > 2324.5                                       => rc029_124_8_c561,
    txinqwnamefirst_dayssince = NULL                                         => 0,
                                                                                0);

rc013_124_3_c559 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2324.5 => -0.0173624918,
    txinqwnamefirst_dayssince > 2324.5                                       => 0.0244863671,
    txinqwnamefirst_dayssince = NULL                                         => 0.0523476619,
                                                                                0);

rc013_124_3 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => 0,
    emailperphoneintxinqcnt > 2.5                                     => rc013_124_3_c559,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc029_124_8 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => 0,
    emailperphoneintxinqcnt > 2.5                                     => rc029_124_8_c559,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc039_124_4 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => 0,
    emailperphoneintxinqcnt > 2.5                                     => rc039_124_4_c559,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc033_124_1 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => -0.0031415453,
    emailperphoneintxinqcnt > 2.5                                     => 0.0242629847,
    emailperphoneintxinqcnt = NULL                                    => 0.0053793978,
                                                                         0);

gbm10_wc_lgt_124 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 2.5 => -0.0055608881,
    emailperphoneintxinqcnt > 2.5                                     => gbm10_wc_lgt_124_c559,
    emailperphoneintxinqcnt = NULL                                    => 0.0029600550,
                                                                         -0.0024193427);

gbm10_wc_lgt_125_c563 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2123.5 => -0.0026969008,
    txinqwnamefirst_dayssince > 2123.5                                       => 1.0729058543,
    txinqwnamefirst_dayssince = NULL                                         => -0.0018041666,
                                                                                -0.0018041666);

rc013_125_2_c563 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2123.5 => -0.0008927341,
    txinqwnamefirst_dayssince > 2123.5                                       => 1.0747100209,
    txinqwnamefirst_dayssince = NULL                                         => 0,
                                                                                0);

gbm10_wc_lgt_125_c565 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 4.5 => -0.2352202257,
    txinqwphonelast_dayssince > 4.5                                       => 0.1102926482,
    txinqwphonelast_dayssince = NULL                                      => 0.4192629005,
                                                                             0.1729815208);

rc022_125_9_c565 := map(
    NULL < txinqwphonelast_dayssince AND txinqwphonelast_dayssince <= 4.5 => -0.4082017465,
    txinqwphonelast_dayssince > 4.5                                       => -0.0626888726,
    txinqwphonelast_dayssince = NULL                                      => 0.2462813797,
                                                                             0);

gbm10_wc_lgt_125_c564 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 80.5 => -0.0038826738,
    txinqwemailcnt6m > 80.5                              => gbm10_wc_lgt_125_c565,
    txinqwemailcnt6m = NULL                              => 0.0394245977,
                                                            0.0118485381);

rc018_125_7_c564 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 80.5 => -0.0157312119,
    txinqwemailcnt6m > 80.5                              => 0.1611329828,
    txinqwemailcnt6m = NULL                              => 0.0275760597,
                                                            0);

rc022_125_9_c564 := map(
    NULL < txinqwemailcnt6m AND txinqwemailcnt6m <= 80.5 => 0,
    txinqwemailcnt6m > 80.5                              => rc022_125_9_c565,
    txinqwemailcnt6m = NULL                              => 0,
                                                            0);

rc013_125_1 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2162.5 => -0.0014630847,
    txinqwnamefirst_dayssince > 2162.5                                       => -0.0899616080,
    txinqwnamefirst_dayssince = NULL                                         => 0.0121896200,
                                                                                0);

rc022_125_9 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2162.5 => 0,
    txinqwnamefirst_dayssince > 2162.5                                       => 0,
    txinqwnamefirst_dayssince = NULL                                         => rc022_125_9_c564,
                                                                                0);

rc018_125_7 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2162.5 => 0,
    txinqwnamefirst_dayssince > 2162.5                                       => 0,
    txinqwnamefirst_dayssince = NULL                                         => rc018_125_7_c564,
                                                                                0);

rc013_125_2 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2162.5 => rc013_125_2_c563,
    txinqwnamefirst_dayssince > 2162.5                                       => 0,
    txinqwnamefirst_dayssince = NULL                                         => 0,
                                                                                0);

gbm10_wc_lgt_125 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 2162.5 => gbm10_wc_lgt_125_c563,
    txinqwnamefirst_dayssince > 2162.5                                       => -0.0903026899,
    txinqwnamefirst_dayssince = NULL                                         => gbm10_wc_lgt_125_c564,
                                                                                -0.0003410819);

rc046_126_4_c569 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 21.5 => -0.0005066249,
    exactidperemailintxinqcnt6m > 21.5                                         => 0.1820379414,
    exactidperemailintxinqcnt6m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_126_c569 := map(
    NULL < exactidperemailintxinqcnt6m AND exactidperemailintxinqcnt6m <= 21.5 => -0.0003321114,
    exactidperemailintxinqcnt6m > 21.5                                         => 0.1822124549,
    exactidperemailintxinqcnt6m = NULL                                         => 0.0001745135,
                                                                                  0.0001745135);

gbm10_wc_lgt_126_c568 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 21.5 => gbm10_wc_lgt_126_c569,
    exactidperemailintxinqcnt3m > 21.5                                         => -0.1891157171,
    exactidperemailintxinqcnt3m = NULL                                         => -0.0001551046,
                                                                                  -0.0001551046);

rc046_126_4_c568 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 21.5 => rc046_126_4_c569,
    exactidperemailintxinqcnt3m > 21.5                                         => 0,
    exactidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

rc044_126_3_c568 := map(
    NULL < exactidperemailintxinqcnt3m AND exactidperemailintxinqcnt3m <= 21.5 => 0.0003296181,
    exactidperemailintxinqcnt3m > 21.5                                         => -0.1889606124,
    exactidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

rc046_126_4_c567 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 21.5 => rc046_126_4_c568,
    smartidperemailintxinqcnt3m > 21.5                                         => 0,
    smartidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_126_c567 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 21.5 => gbm10_wc_lgt_126_c568,
    smartidperemailintxinqcnt3m > 21.5                                         => 0.2366237723,
    smartidperemailintxinqcnt3m = NULL                                         => -0.0000445331,
                                                                                  -0.0000445331);

rc044_126_3_c567 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 21.5 => rc044_126_3_c568,
    smartidperemailintxinqcnt3m > 21.5                                         => 0,
    smartidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

rc019_126_2_c567 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 21.5 => -0.0001105715,
    smartidperemailintxinqcnt3m > 21.5                                         => 0.2366683054,
    smartidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

rc019_126_1 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 26.5 => 0.0010707131,
    smartidperemailintxinqcnt3m > 26.5                                         => -0.0915579253,
    smartidperemailintxinqcnt3m = NULL                                         => -0.0054963354,
                                                                                  0);

rc019_126_2 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 26.5 => rc019_126_2_c567,
    smartidperemailintxinqcnt3m > 26.5                                         => 0,
    smartidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

rc044_126_3 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 26.5 => rc044_126_3_c567,
    smartidperemailintxinqcnt3m > 26.5                                         => 0,
    smartidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_126 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 26.5 => gbm10_wc_lgt_126_c567,
    smartidperemailintxinqcnt3m > 26.5                                         => -0.0926731715,
    smartidperemailintxinqcnt3m = NULL                                         => -0.0066115816,
                                                                                  -0.0011152462);

rc046_126_4 := map(
    NULL < smartidperemailintxinqcnt3m AND smartidperemailintxinqcnt3m <= 26.5 => rc046_126_4_c567,
    smartidperemailintxinqcnt3m > 26.5                                         => 0,
    smartidperemailintxinqcnt3m = NULL                                         => 0,
                                                                                  0);

rc005_127_7_c573 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 315.5 => 0.2478322233,
    txinqwphonefirst_dayssince > 315.5                                        => -0.1909920283,
    txinqwphonefirst_dayssince = NULL                                         => 0,
                                                                                 0);

gbm10_wc_lgt_127_c573 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 315.5 => 0.3524373251,
    txinqwphonefirst_dayssince > 315.5                                        => -0.0863869265,
    txinqwphonefirst_dayssince = NULL                                         => 0.1046051018,
                                                                                 0.1046051018);

rc005_127_7_c572 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => 0,
    tmxidperphoneintxinqcnt3m > 1.5                                       => rc005_127_7_c573,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc004_127_5_c572 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => -0.0074172939,
    tmxidperphoneintxinqcnt3m > 1.5                                       => 0.1303604536,
    tmxidperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_127_c572 := map(
    NULL < tmxidperphoneintxinqcnt3m AND tmxidperphoneintxinqcnt3m <= 1.5 => -0.0331726458,
    tmxidperphoneintxinqcnt3m > 1.5                                       => gbm10_wc_lgt_127_c573,
    tmxidperphoneintxinqcnt3m = NULL                                      => -0.0257553518,
                                                                             -0.0257553518);

gbm10_wc_lgt_127_c571 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 2.5 => gbm10_wc_lgt_127_c572,
    exactidperphoneintxinqcnt3m > 2.5                                         => -0.0843381156,
    exactidperphoneintxinqcnt3m = NULL                                        => -0.0076534708,
                                                                                 -0.0173771798);

rc021_127_4_c571 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 2.5 => -0.0083781720,
    exactidperphoneintxinqcnt3m > 2.5                                         => -0.0669609358,
    exactidperphoneintxinqcnt3m = NULL                                        => 0.0097237091,
                                                                                 0);

rc004_127_5_c571 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 2.5 => rc004_127_5_c572,
    exactidperphoneintxinqcnt3m > 2.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc005_127_7_c571 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 2.5 => rc005_127_7_c572,
    exactidperphoneintxinqcnt3m > 2.5                                         => 0,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

rc005_127_7 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => 0,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => rc005_127_7_c571,
                                                                             0);

rc030_127_1 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => 0.0028017498,
    phoneperemailintxinqcnt3m > 5.5                                       => -0.0928244022,
    phoneperemailintxinqcnt3m = NULL                                      => -0.0151279725,
                                                                             0);

gbm10_wc_lgt_127 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => 0.0005525425,
    phoneperemailintxinqcnt3m > 5.5                                       => -0.0950736095,
    phoneperemailintxinqcnt3m = NULL                                      => gbm10_wc_lgt_127_c571,
                                                                             -0.0022492073);

rc021_127_4 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => 0,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => rc021_127_4_c571,
                                                                             0);

rc004_127_5 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 5.5 => 0,
    phoneperemailintxinqcnt3m > 5.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => rc004_127_5_c571,
                                                                             0);

gbm10_wc_lgt_128_c576 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 33.5 => 0.0002846141,
    smartidperemailintxinqcnt1y > 33.5                                         => -0.2241838388,
    smartidperemailintxinqcnt1y = NULL                                         => 0.0001062570,
                                                                                  0.0001062570);

rc054_128_3_c576 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 33.5 => 0.0001783571,
    smartidperemailintxinqcnt1y > 33.5                                         => -0.2242900958,
    smartidperemailintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_128_c577 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 364 => 0.4870330036,
    txinqwphonefirst_dayssince > 364                                        => -0.0926640744,
    txinqwphonefirst_dayssince = NULL                                       => 0.1732614121,
                                                                               0.1732614121);

rc005_128_7_c577 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 364 => 0.3137715915,
    txinqwphonefirst_dayssince > 364                                        => -0.2659254865,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc054_128_3_c575 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 57.5 => rc054_128_3_c576,
    exactidperemailintxinqcnt > 57.5                                       => 0,
    exactidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

rc005_128_7_c575 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 57.5 => 0,
    exactidperemailintxinqcnt > 57.5                                       => rc005_128_7_c577,
    exactidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

rc047_128_2_c575 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 57.5 => -0.0002807756,
    exactidperemailintxinqcnt > 57.5                                       => 0.1728743795,
    exactidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_128_c575 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 57.5 => gbm10_wc_lgt_128_c576,
    exactidperemailintxinqcnt > 57.5                                       => gbm10_wc_lgt_128_c577,
    exactidperemailintxinqcnt = NULL                                       => 0.0003870326,
                                                                              0.0003870326);

rc054_128_3 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 45.5 => rc054_128_3_c575,
    smartidperemailintxinqcnt1y > 45.5                                         => 0,
    smartidperemailintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

rc005_128_7 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 45.5 => rc005_128_7_c575,
    smartidperemailintxinqcnt1y > 45.5                                         => 0,
    smartidperemailintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_128 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 45.5 => gbm10_wc_lgt_128_c575,
    smartidperemailintxinqcnt1y > 45.5                                         => -0.1794447169,
    smartidperemailintxinqcnt1y = NULL                                         => -0.0051827159,
                                                                                  -0.0005268260);

rc047_128_2 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 45.5 => rc047_128_2_c575,
    smartidperemailintxinqcnt1y > 45.5                                         => 0,
    smartidperemailintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

rc054_128_1 := map(
    NULL < smartidperemailintxinqcnt1y AND smartidperemailintxinqcnt1y <= 45.5 => 0.0009138587,
    smartidperemailintxinqcnt1y > 45.5                                         => -0.1789178909,
    smartidperemailintxinqcnt1y = NULL                                         => -0.0046558899,
                                                                                  0);

gbm10_wc_lgt_129_c580 := map(
    NULL < txinqcorremailwphonecnt1y AND txinqcorremailwphonecnt1y <= 12.5 => 0.1909754872,
    txinqcorremailwphonecnt1y > 12.5                                       => -0.0760825892,
    txinqcorremailwphonecnt1y = NULL                                       => 0.1002857933,
                                                                              0.1002857933);

rc051_129_5_c580 := map(
    NULL < txinqcorremailwphonecnt1y AND txinqcorremailwphonecnt1y <= 12.5 => 0.0906896940,
    txinqcorremailwphonecnt1y > 12.5                                       => -0.1763683824,
    txinqcorremailwphonecnt1y = NULL                                       => 0,
                                                                              0);

rc023_129_9_c581 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 4.5 => 0.1076937652,
    txinqcorremailwphonecnt > 4.5                                     => -0.1917473662,
    txinqcorremailwphonecnt = NULL                                    => 0.0407746034,
                                                                         0);

gbm10_wc_lgt_129_c581 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 4.5 => 0.1221395749,
    txinqcorremailwphonecnt > 4.5                                     => -0.1773015565,
    txinqcorremailwphonecnt = NULL                                    => 0.0552204130,
                                                                         0.0144458096);

rc023_129_9_c579 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 1.5 => 0,
    txinqcorremailwnamecnt1y > 1.5                                      => 0,
    txinqcorremailwnamecnt1y = NULL                                     => rc023_129_9_c581,
                                                                           0);

rc051_129_5_c579 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 1.5 => 0,
    txinqcorremailwnamecnt1y > 1.5                                      => rc051_129_5_c580,
    txinqcorremailwnamecnt1y = NULL                                     => 0,
                                                                           0);

gbm10_wc_lgt_129_c579 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 1.5 => -0.0158215195,
    txinqcorremailwnamecnt1y > 1.5                                      => gbm10_wc_lgt_129_c580,
    txinqcorremailwnamecnt1y = NULL                                     => gbm10_wc_lgt_129_c581,
                                                                           0.0159008983);

rc041_129_3_c579 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 1.5 => -0.0317224178,
    txinqcorremailwnamecnt1y > 1.5                                      => 0.0843848950,
    txinqcorremailwnamecnt1y = NULL                                     => -0.0014550886,
                                                                           0);

gbm10_wc_lgt_129 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0019962472,
    smartidperphoneintxinqcnt1m > 3.5                                         => gbm10_wc_lgt_129_c579,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0003942897,
                                                                                 -0.0013612587);

rc003_129_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0006349885,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.0172621570,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0017555484,
                                                                                 0);

rc041_129_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc041_129_3_c579,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc023_129_9 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc023_129_9_c579,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc051_129_5 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc051_129_5_c579,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_130_c585 := map(
    NULL < dnsipperemailintxinqcnt AND dnsipperemailintxinqcnt <= 2.5 => -0.2474650900,
    dnsipperemailintxinqcnt > 2.5                                     => 0.0676529719,
    dnsipperemailintxinqcnt = NULL                                    => -0.0674733890,
                                                                         -0.0674733890);

rc034_130_5_c585 := map(
    NULL < dnsipperemailintxinqcnt AND dnsipperemailintxinqcnt <= 2.5 => -0.1799917010,
    dnsipperemailintxinqcnt > 2.5                                     => 0.1351263609,
    dnsipperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_130_c584 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => gbm10_wc_lgt_130_c585,
    phoneperemailintxinqcnt3m > 1.5                                       => -0.3471415970,
    phoneperemailintxinqcnt3m = NULL                                      => -0.1210755116,
                                                                             -0.1210755116);

rc034_130_5_c584 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => rc034_130_5_c585,
    phoneperemailintxinqcnt3m > 1.5                                       => 0,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc030_130_4_c584 := map(
    NULL < phoneperemailintxinqcnt3m AND phoneperemailintxinqcnt3m <= 1.5 => 0.0536021226,
    phoneperemailintxinqcnt3m > 1.5                                       => -0.2260660854,
    phoneperemailintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc005_130_3_c583 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 4.5 => -0.1072361216,
    txinqwphonefirst_dayssince > 4.5                                        => 0.0030573112,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_130_c583 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 4.5 => gbm10_wc_lgt_130_c584,
    txinqwphonefirst_dayssince > 4.5                                        => -0.0107820787,
    txinqwphonefirst_dayssince = NULL                                       => -0.0138393900,
                                                                               -0.0138393900);

rc030_130_4_c583 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 4.5 => rc030_130_4_c584,
    txinqwphonefirst_dayssince > 4.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc034_130_5_c583 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 4.5 => rc034_130_5_c584,
    txinqwphonefirst_dayssince > 4.5                                        => 0,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc005_130_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc005_130_3_c583,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_130_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0018642893,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0169060473,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0027513511,
                                                                                 0);

gbm10_wc_lgt_130 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0049309466,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_130_c583,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0003153063,
                                                                                 0.0030666573);

rc030_130_4 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc030_130_4_c583,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc034_130_5 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc034_130_5_c583,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_131_c589 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 5.5 => 0.2340941993,
    exactidperemailintxinqcnt > 5.5                                       => -0.0339426415,
    exactidperemailintxinqcnt = NULL                                      => 0.0280567843,
                                                                             0.0280567843);

rc047_131_5_c589 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 5.5 => 0.2060374150,
    exactidperemailintxinqcnt > 5.5                                       => -0.0619994258,
    exactidperemailintxinqcnt = NULL                                      => 0,
                                                                             0);

rc011_131_4_c588 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 581.22 => -0.0479141252,
    distbtwtrueipwemailavg > 581.22                                    => 0.2240277726,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

rc047_131_5_c588 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 581.22 => rc047_131_5_c589,
    distbtwtrueipwemailavg > 581.22                                    => 0,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_131_c588 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 581.22 => gbm10_wc_lgt_131_c589,
    distbtwtrueipwemailavg > 581.22                                    => 0.2999986821,
    distbtwtrueipwemailavg = NULL                                      => 0.0759709095,
                                                                          0.0759709095);

rc011_131_4_c587 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 71.5 => rc011_131_4_c588,
    txinqwaddrlast_dayssince > 71.5                                      => 0,
    txinqwaddrlast_dayssince = NULL                                      => 0,
                                                                            0);

rc047_131_5_c587 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 71.5 => rc047_131_5_c588,
    txinqwaddrlast_dayssince > 71.5                                      => 0,
    txinqwaddrlast_dayssince = NULL                                      => 0,
                                                                            0);

gbm10_wc_lgt_131_c587 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 71.5 => gbm10_wc_lgt_131_c588,
    txinqwaddrlast_dayssince > 71.5                                      => -0.0862820644,
    txinqwaddrlast_dayssince = NULL                                      => 0.0203028696,
                                                                            0.0227342042);

rc025_131_3_c587 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 71.5 => 0.0532367053,
    txinqwaddrlast_dayssince > 71.5                                      => -0.1090162686,
    txinqwaddrlast_dayssince = NULL                                      => -0.0024313346,
                                                                            0);

gbm10_wc_lgt_131 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => -0.0024926200,
    txinqcorremailwphonecnt1m > 4.5                                       => gbm10_wc_lgt_131_c587,
    txinqcorremailwphonecnt1m = NULL                                      => -0.0013274362,
                                                                             -0.0018654249);

rc047_131_5 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => 0,
    txinqcorremailwphonecnt1m > 4.5                                       => rc047_131_5_c587,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc025_131_3 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => 0,
    txinqcorremailwphonecnt1m > 4.5                                       => rc025_131_3_c587,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc032_131_1 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => -0.0006271951,
    txinqcorremailwphonecnt1m > 4.5                                       => 0.0245996291,
    txinqcorremailwphonecnt1m = NULL                                      => 0.0005379888,
                                                                             0);

rc011_131_4 := map(
    NULL < txinqcorremailwphonecnt1m AND txinqcorremailwphonecnt1m <= 4.5 => 0,
    txinqcorremailwphonecnt1m > 4.5                                       => rc011_131_4_c587,
    txinqcorremailwphonecnt1m = NULL                                      => 0,
                                                                             0);

rc012_132_5_c593 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 21601.115 => -0.1206566305,
    timebtwtxinqwphoneavg > 21601.115                                   => 0.0570017416,
    timebtwtxinqwphoneavg = NULL                                        => 0,
                                                                           0);

gbm10_wc_lgt_132_c593 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 21601.115 => -0.0614615626,
    timebtwtxinqwphoneavg > 21601.115                                   => 0.1161968095,
    timebtwtxinqwphoneavg = NULL                                        => 0.0591950679,
                                                                           0.0591950679);

gbm10_wc_lgt_132_c592 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 4.5 => -0.0023580667,
    emailperphoneintxinqcnt > 4.5                                     => gbm10_wc_lgt_132_c593,
    emailperphoneintxinqcnt = NULL                                    => -0.0018189907,
                                                                         -0.0018189907);

rc033_132_3_c592 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 4.5 => -0.0005390761,
    emailperphoneintxinqcnt > 4.5                                     => 0.0610140586,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc012_132_5_c592 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 4.5 => 0,
    emailperphoneintxinqcnt > 4.5                                     => rc012_132_5_c593,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc012_132_5_c591 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 20.5 => rc012_132_5_c592,
    smartidperphoneintxinqcnt1y > 20.5                                         => 0,
    smartidperphoneintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_132_c591 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 20.5 => gbm10_wc_lgt_132_c592,
    smartidperphoneintxinqcnt1y > 20.5                                         => 0.1157555700,
    smartidperphoneintxinqcnt1y = NULL                                         => -0.0017477650,
                                                                                  -0.0017477650);

rc028_132_2_c591 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 20.5 => -0.0000712256,
    smartidperphoneintxinqcnt1y > 20.5                                         => 0.1175033351,
    smartidperphoneintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

rc033_132_3_c591 := map(
    NULL < smartidperphoneintxinqcnt1y AND smartidperphoneintxinqcnt1y <= 20.5 => rc033_132_3_c592,
    smartidperphoneintxinqcnt1y > 20.5                                         => 0,
    smartidperphoneintxinqcnt1y = NULL                                         => 0,
                                                                                  0);

gbm10_wc_lgt_132 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => gbm10_wc_lgt_132_c591,
    emailperphoneintxinqcnt > 17.5                                     => -0.1447897745,
    emailperphoneintxinqcnt = NULL                                     => 0.0005181105,
                                                                          -0.0013388747);

rc033_132_1 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => -0.0004088904,
    emailperphoneintxinqcnt > 17.5                                     => -0.1434508999,
    emailperphoneintxinqcnt = NULL                                     => 0.0018569852,
                                                                          0);

rc033_132_3 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => rc033_132_3_c591,
    emailperphoneintxinqcnt > 17.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => 0,
                                                                          0);

rc028_132_2 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => rc028_132_2_c591,
    emailperphoneintxinqcnt > 17.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => 0,
                                                                          0);

rc012_132_5 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 17.5 => rc012_132_5_c591,
    emailperphoneintxinqcnt > 17.5                                     => 0,
    emailperphoneintxinqcnt = NULL                                     => 0,
                                                                          0);

rc010_133_6_c597 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 20.5 => -0.2111236075,
    txinqwphonecnt1y > 20.5                              => 0.2749792195,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

gbm10_wc_lgt_133_c597 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 20.5 => -0.2171430227,
    txinqwphonecnt1y > 20.5                              => 0.2689598043,
    txinqwphonecnt1y = NULL                              => -0.0060194152,
                                                            -0.0060194152);

gbm10_wc_lgt_133_c596 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 343.5 => gbm10_wc_lgt_133_c597,
    txinqwtmxidfirst_dayssince > 343.5                                        => -0.1740015372,
    txinqwtmxidfirst_dayssince = NULL                                         => -0.0644457775,
                                                                                 -0.0772276149);

rc035_133_5_c596 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 343.5 => 0.0712081997,
    txinqwtmxidfirst_dayssince > 343.5                                        => -0.0967739223,
    txinqwtmxidfirst_dayssince = NULL                                         => 0.0127818375,
                                                                                 0);

rc010_133_6_c596 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 343.5 => rc010_133_6_c597,
    txinqwtmxidfirst_dayssince > 343.5                                        => 0,
    txinqwtmxidfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc005_133_3_c595 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 325 => 0.2711472580,
    txinqwphonefirst_dayssince > 325                                        => -0.0042958939,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_133_c595 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 325 => 0.1982155369,
    txinqwphonefirst_dayssince > 325                                        => gbm10_wc_lgt_133_c596,
    txinqwphonefirst_dayssince = NULL                                       => -0.0729317210,
                                                                               -0.0729317210);

rc010_133_6_c595 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 325 => 0,
    txinqwphonefirst_dayssince > 325                                        => rc010_133_6_c596,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc035_133_5_c595 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 325 => 0,
    txinqwphonefirst_dayssince > 325                                        => rc035_133_5_c596,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc038_133_1 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 13.5 => 0.0019569662,
    browserhashperphoneintxinqcnt > 13.5                                           => -0.0734548692,
    browserhashperphoneintxinqcnt = NULL                                           => -0.0001088764,
                                                                                      0);

rc010_133_6 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 13.5 => 0,
    browserhashperphoneintxinqcnt > 13.5                                           => rc010_133_6_c595,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc035_133_5 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 13.5 => 0,
    browserhashperphoneintxinqcnt > 13.5                                           => rc035_133_5_c595,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

gbm10_wc_lgt_133 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 13.5 => 0.0024801144,
    browserhashperphoneintxinqcnt > 13.5                                           => gbm10_wc_lgt_133_c595,
    browserhashperphoneintxinqcnt = NULL                                           => 0.0004142718,
                                                                                      0.0005231482);

rc005_133_3 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 13.5 => 0,
    browserhashperphoneintxinqcnt > 13.5                                           => rc005_133_3_c595,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc006_134_6_c601 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 9072.68 => 0.1396999585,
    timebtwtxinqwemailavg > 9072.68                                   => -0.1970946179,
    timebtwtxinqwemailavg = NULL                                      => 0,
                                                                         0);

gbm10_wc_lgt_134_c601 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 9072.68 => 0.2521190180,
    timebtwtxinqwemailavg > 9072.68                                   => -0.0846755583,
    timebtwtxinqwemailavg = NULL                                      => 0.1124190596,
                                                                         0.1124190596);

rc006_134_6_c600 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 94.01 => rc006_134_6_c601,
    distbtwtrueipwphoneavg > 94.01                                    => 0,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

gbm10_wc_lgt_134_c600 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 94.01 => gbm10_wc_lgt_134_c601,
    distbtwtrueipwphoneavg > 94.01                                    => -0.0636397222,
    distbtwtrueipwphoneavg = NULL                                     => 0.0204897028,
                                                                         0.0204897028);

rc007_134_5_c600 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 94.01 => 0.0919293567,
    distbtwtrueipwphoneavg > 94.01                                    => -0.0841294250,
    distbtwtrueipwphoneavg = NULL                                     => 0,
                                                                         0);

rc007_134_5_c599 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 8.5 => 0,
    txinqwnamelast_dayssince > 8.5                                      => rc007_134_5_c600,
    txinqwnamelast_dayssince = NULL                                     => 0,
                                                                           0);

rc006_134_6_c599 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 8.5 => 0,
    txinqwnamelast_dayssince > 8.5                                      => rc006_134_6_c600,
    txinqwnamelast_dayssince = NULL                                     => 0,
                                                                           0);

gbm10_wc_lgt_134_c599 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 8.5 => -0.0566154374,
    txinqwnamelast_dayssince > 8.5                                      => gbm10_wc_lgt_134_c600,
    txinqwnamelast_dayssince = NULL                                     => -0.0079442549,
                                                                           -0.0195953073);

rc026_134_3_c599 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 8.5 => -0.0370201301,
    txinqwnamelast_dayssince > 8.5                                      => 0.0400850101,
    txinqwnamelast_dayssince = NULL                                     => 0.0116510523,
                                                                           0);

rc026_134_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc026_134_3_c599,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc007_134_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc007_134_5_c599,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc001_134_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0004514202,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0207447473,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0008181612,
                                                                             0);

gbm10_wc_lgt_134 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0016008603,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_134_c599,
    emailperphoneintxinqcnt3m = NULL                                      => 0.0003312789,
                                                                             0.0011494401);

rc006_134_6 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc006_134_6_c599,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc016_135_4_c604 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 19.5 => 0.2008956692,
    txinqwaddrfirst_dayssince > 19.5                                       => -0.0574824277,
    txinqwaddrfirst_dayssince = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_135_c604 := map(
    NULL < txinqwaddrfirst_dayssince AND txinqwaddrfirst_dayssince <= 19.5 => 0.1850631755,
    txinqwaddrfirst_dayssince > 19.5                                       => -0.0733149214,
    txinqwaddrfirst_dayssince = NULL                                       => -0.0158324937,
                                                                              -0.0158324937);

gbm10_wc_lgt_135_c605 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 5.5 => -0.0489876603,
    exactidperphoneintxinqcnt3m > 5.5                                         => 0.1731167956,
    exactidperphoneintxinqcnt3m = NULL                                        => 0.0855165023,
                                                                                 0.0855165023);

rc021_135_8_c605 := map(
    NULL < exactidperphoneintxinqcnt3m AND exactidperphoneintxinqcnt3m <= 5.5 => -0.1345041626,
    exactidperphoneintxinqcnt3m > 5.5                                         => 0.0876002933,
    exactidperphoneintxinqcnt3m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_135_c603 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 16.5 => gbm10_wc_lgt_135_c604,
    txinqwaddrlast_dayssince > 16.5                                      => gbm10_wc_lgt_135_c605,
    txinqwaddrlast_dayssince = NULL                                      => -0.0092744044,
                                                                            0.0160919866);

rc016_135_4_c603 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 16.5 => rc016_135_4_c604,
    txinqwaddrlast_dayssince > 16.5                                      => 0,
    txinqwaddrlast_dayssince = NULL                                      => 0,
                                                                            0);

rc025_135_3_c603 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 16.5 => -0.0319244803,
    txinqwaddrlast_dayssince > 16.5                                      => 0.0694245157,
    txinqwaddrlast_dayssince = NULL                                      => -0.0253663910,
                                                                            0);

rc021_135_8_c603 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 16.5 => 0,
    txinqwaddrlast_dayssince > 16.5                                      => rc021_135_8_c605,
    txinqwaddrlast_dayssince = NULL                                      => 0,
                                                                            0);

rc016_135_4 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc016_135_4_c603,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

gbm10_wc_lgt_135 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0017430341,
    smartidperphoneintxinqcnt1m > 3.5                                         => gbm10_wc_lgt_135_c603,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0002649346,
                                                                                 -0.0011940298);

rc003_135_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => -0.0005490043,
    smartidperphoneintxinqcnt1m > 3.5                                         => 0.0172860164,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0014589643,
                                                                                 0);

rc025_135_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc025_135_3_c603,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc021_135_8 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 3.5 => 0,
    smartidperphoneintxinqcnt1m > 3.5                                         => rc021_135_8_c603,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc010_136_2_c607 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 102.5 => -0.0000928229,
    txinqwphonecnt1y > 102.5                              => 0.1228408617,
    txinqwphonecnt1y = NULL                               => 0,
                                                             0);

gbm10_wc_lgt_136_c607 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 102.5 => -0.0004105107,
    txinqwphonecnt1y > 102.5                              => 0.1225231738,
    txinqwphonecnt1y = NULL                               => -0.0003176879,
                                                             -0.0003176879);

gbm10_wc_lgt_136_c609 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 1688.75 => -0.0083123238,
    timebtwtxinqwemailavg > 1688.75                                   => 0.4720042281,
    timebtwtxinqwemailavg = NULL                                      => 0.2096751998,
                                                                         0.1835554958);

rc006_136_8_c609 := map(
    NULL < timebtwtxinqwemailavg AND timebtwtxinqwemailavg <= 1688.75 => -0.1918678196,
    timebtwtxinqwemailavg > 1688.75                                   => 0.2884487322,
    timebtwtxinqwemailavg = NULL                                      => 0.0261197040,
                                                                         0);

rc006_136_8_c608 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 9.5 => rc006_136_8_c609,
    txinqwemailfirst_dayssince > 9.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc002_136_7_c608 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 9.5 => 0.1929035260,
    txinqwemailfirst_dayssince > 9.5                                        => -0.0155705423,
    txinqwemailfirst_dayssince = NULL                                       => 0.0040025951,
                                                                               0);

gbm10_wc_lgt_136_c608 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 9.5 => gbm10_wc_lgt_136_c609,
    txinqwemailfirst_dayssince > 9.5                                        => -0.0249185725,
    txinqwemailfirst_dayssince = NULL                                       => -0.0053454351,
                                                                               -0.0093480302);

gbm10_wc_lgt_136 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 113.5 => gbm10_wc_lgt_136_c607,
    txinqwphonecnt1y > 113.5                              => -0.0665954795,
    txinqwphonecnt1y = NULL                               => gbm10_wc_lgt_136_c608,
                                                             -0.0023790858);

rc006_136_8 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 113.5 => 0,
    txinqwphonecnt1y > 113.5                              => 0,
    txinqwphonecnt1y = NULL                               => rc006_136_8_c608,
                                                             0);

rc002_136_7 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 113.5 => 0,
    txinqwphonecnt1y > 113.5                              => 0,
    txinqwphonecnt1y = NULL                               => rc002_136_7_c608,
                                                             0);

rc010_136_2 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 113.5 => rc010_136_2_c607,
    txinqwphonecnt1y > 113.5                              => 0,
    txinqwphonecnt1y = NULL                               => 0,
                                                             0);

rc010_136_1 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 113.5 => 0.0020613979,
    txinqwphonecnt1y > 113.5                              => -0.0642163937,
    txinqwphonecnt1y = NULL                               => -0.0069689444,
                                                             0);

gbm10_wc_lgt_137_c613 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 1098.5 => 0.0129922302,
    txinqwemailfirst_dayssince > 1098.5                                        => 0.5303894363,
    txinqwemailfirst_dayssince = NULL                                          => 0.1358911475,
                                                                                  0.1358911475);

rc002_137_5_c613 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 1098.5 => -0.1228989173,
    txinqwemailfirst_dayssince > 1098.5                                        => 0.3944982888,
    txinqwemailfirst_dayssince = NULL                                          => 0,
                                                                                  0);

gbm10_wc_lgt_137_c612 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 4.5 => 0.0008319950,
    trueippertmxidintxinqcnt1m > 4.5                                        => gbm10_wc_lgt_137_c613,
    trueippertmxidintxinqcnt1m = NULL                                       => 0.0034562109,
                                                                               0.0034562109);

rc002_137_5_c612 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 4.5 => 0,
    trueippertmxidintxinqcnt1m > 4.5                                        => rc002_137_5_c613,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

rc048_137_3_c612 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 4.5 => -0.0026242159,
    trueippertmxidintxinqcnt1m > 4.5                                        => 0.1324349367,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_137_c611 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 85.5 => gbm10_wc_lgt_137_c612,
    txinqwphonecnt1y > 85.5                              => -0.2841640187,
    txinqwphonecnt1y = NULL                              => 0.0573302504,
                                                            0.0035632548);

rc002_137_5_c611 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 85.5 => rc002_137_5_c612,
    txinqwphonecnt1y > 85.5                              => 0,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc048_137_3_c611 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 85.5 => rc048_137_3_c612,
    txinqwphonecnt1y > 85.5                              => 0,
    txinqwphonecnt1y = NULL                              => 0,
                                                            0);

rc010_137_2_c611 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 85.5 => -0.0001070439,
    txinqwphonecnt1y > 85.5                              => -0.2877272735,
    txinqwphonecnt1y = NULL                              => 0.0537669956,
                                                            0);

rc010_137_2 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => rc010_137_2_c611,
    trueippertmxidintxinqcnt1m > 7.5                                        => 0,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

rc048_137_1 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => 0.0039201146,
    trueippertmxidintxinqcnt1m > 7.5                                        => -0.1019384115,
    trueippertmxidintxinqcnt1m = NULL                                       => -0.0002026929,
                                                                               0);

gbm10_wc_lgt_137 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => gbm10_wc_lgt_137_c611,
    trueippertmxidintxinqcnt1m > 7.5                                        => -0.1022952713,
    trueippertmxidintxinqcnt1m = NULL                                       => -0.0005595527,
                                                                               -0.0003568598);

rc048_137_3 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => rc048_137_3_c611,
    trueippertmxidintxinqcnt1m > 7.5                                        => 0,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

rc002_137_5 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 7.5 => rc002_137_5_c611,
    trueippertmxidintxinqcnt1m > 7.5                                        => 0,
    trueippertmxidintxinqcnt1m = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_138_c617 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 6.5 => 0.0919117617,
    exactidperemailintxinqcnt1m > 6.5                                         => -0.1609769981,
    exactidperemailintxinqcnt1m = NULL                                        => -0.1867262018,
                                                                                 0.0631268238);

rc009_138_7_c617 := map(
    NULL < exactidperemailintxinqcnt1m AND exactidperemailintxinqcnt1m <= 6.5 => 0.0287849379,
    exactidperemailintxinqcnt1m > 6.5                                         => -0.2241038220,
    exactidperemailintxinqcnt1m = NULL                                        => -0.2498530256,
                                                                                 0);

rc009_138_7_c616 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 16.5 => 0,
    txinqwnamelast_dayssince > 16.5                                      => rc009_138_7_c617,
    txinqwnamelast_dayssince = NULL                                      => 0,
                                                                            0);

rc026_138_5_c616 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 16.5 => -0.0354923528,
    txinqwnamelast_dayssince > 16.5                                      => 0.0428320985,
    txinqwnamelast_dayssince = NULL                                      => 0.0075351916,
                                                                            0);

gbm10_wc_lgt_138_c616 := map(
    NULL < txinqwnamelast_dayssince AND txinqwnamelast_dayssince <= 16.5 => -0.0151976275,
    txinqwnamelast_dayssince > 16.5                                      => gbm10_wc_lgt_138_c617,
    txinqwnamelast_dayssince = NULL                                      => 0.0278299169,
                                                                            0.0202947253);

rc009_138_7_c615 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 4.5 => 0,
    txinqwphonefirst_dayssince > 4.5                                        => rc009_138_7_c616,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc026_138_5_c615 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 4.5 => 0,
    txinqwphonefirst_dayssince > 4.5                                        => rc026_138_5_c616,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_138_c615 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 4.5 => -0.1859527173,
    txinqwphonefirst_dayssince > 4.5                                        => gbm10_wc_lgt_138_c616,
    txinqwphonefirst_dayssince = NULL                                       => 0.0197211570,
                                                                               0.0197211570);

rc005_138_3_c615 := map(
    NULL < txinqwphonefirst_dayssince AND txinqwphonefirst_dayssince <= 4.5 => -0.2056738743,
    txinqwphonefirst_dayssince > 4.5                                        => 0.0005735683,
    txinqwphonefirst_dayssince = NULL                                       => 0,
                                                                               0);

rc005_138_3 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc005_138_3_c615,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_138 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => -0.0112951320,
    emailperphoneintxinqcnt > 1.5                                     => gbm10_wc_lgt_138_c615,
    emailperphoneintxinqcnt = NULL                                    => -0.0004111662,
                                                                         -0.0039032906);

rc026_138_5 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc026_138_5_c615,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc009_138_7 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => 0,
    emailperphoneintxinqcnt > 1.5                                     => rc009_138_7_c615,
    emailperphoneintxinqcnt = NULL                                    => 0,
                                                                         0);

rc033_138_1 := map(
    NULL < emailperphoneintxinqcnt AND emailperphoneintxinqcnt <= 1.5 => -0.0073918414,
    emailperphoneintxinqcnt > 1.5                                     => 0.0236244477,
    emailperphoneintxinqcnt = NULL                                    => 0.0034921245,
                                                                         0);

gbm10_wc_lgt_139_c621 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 10.5 => -0.1812244385,
    browserhashperphoneintxinqcnt > 10.5                                           => 0.0743610890,
    browserhashperphoneintxinqcnt = NULL                                           => -0.0538115551,
                                                                                      -0.0538115551);

rc038_139_7_c621 := map(
    NULL < browserhashperphoneintxinqcnt AND browserhashperphoneintxinqcnt <= 10.5 => -0.1274128834,
    browserhashperphoneintxinqcnt > 10.5                                           => 0.1281726441,
    browserhashperphoneintxinqcnt = NULL                                           => 0,
                                                                                      0);

rc038_139_7_c620 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 37.5 => 0,
    txinqwtmxidfirst_dayssince > 37.5                                        => rc038_139_7_c621,
    txinqwtmxidfirst_dayssince = NULL                                        => 0,
                                                                                0);

gbm10_wc_lgt_139_c620 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 37.5 => 0.0943236739,
    txinqwtmxidfirst_dayssince > 37.5                                        => gbm10_wc_lgt_139_c621,
    txinqwtmxidfirst_dayssince = NULL                                        => -0.0174367285,
                                                                                -0.0138648992);

rc035_139_5_c620 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 37.5 => 0.1081885730,
    txinqwtmxidfirst_dayssince > 37.5                                        => -0.0399466560,
    txinqwtmxidfirst_dayssince = NULL                                        => -0.0035718293,
                                                                                0);

rc035_139_5_c619 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => 0,
    txinqwphonecnt1y > 3.5                              => rc035_139_5_c620,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

rc010_139_3_c619 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => -0.1879151158,
    txinqwphonecnt1y > 3.5                              => 0.0077170850,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

gbm10_wc_lgt_139_c619 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => -0.2094971000,
    txinqwphonecnt1y > 3.5                              => gbm10_wc_lgt_139_c620,
    txinqwphonecnt1y = NULL                             => -0.0215819842,
                                                           -0.0215819842);

rc038_139_7_c619 := map(
    NULL < txinqwphonecnt1y AND txinqwphonecnt1y <= 3.5 => 0,
    txinqwphonecnt1y > 3.5                              => rc038_139_7_c620,
    txinqwphonecnt1y = NULL                             => 0,
                                                           0);

rc001_139_1 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0006276723,
    emailperphoneintxinqcnt3m > 2.5                                       => -0.0226102348,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0013573195,
                                                                             0);

rc035_139_5 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc035_139_5_c619,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc010_139_3 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc010_139_3_c619,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_139 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0.0016559229,
    emailperphoneintxinqcnt3m > 2.5                                       => gbm10_wc_lgt_139_c619,
    emailperphoneintxinqcnt3m = NULL                                      => -0.0003290689,
                                                                             0.0010282506);

rc038_139_7 := map(
    NULL < emailperphoneintxinqcnt3m AND emailperphoneintxinqcnt3m <= 2.5 => 0,
    emailperphoneintxinqcnt3m > 2.5                                       => rc038_139_7_c619,
    emailperphoneintxinqcnt3m = NULL                                      => 0,
                                                                             0);

rc007_140_5_c624 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 221.35 => -0.1113571693,
    distbtwtrueipwphoneavg > 221.35                                    => 0.1547548442,
    distbtwtrueipwphoneavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_140_c624 := map(
    NULL < distbtwtrueipwphoneavg AND distbtwtrueipwphoneavg <= 221.35 => -0.2023573092,
    distbtwtrueipwphoneavg > 221.35                                    => 0.0637547043,
    distbtwtrueipwphoneavg = NULL                                      => -0.0910001399,
                                                                          -0.0910001399);

rc013_140_3_c623 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 17 => 0.3470076919,
    txinqwnamefirst_dayssince > 17                                       => -0.1119943932,
    txinqwnamefirst_dayssince = NULL                                     => -0.0309091893,
                                                                            0);

gbm10_wc_lgt_140_c623 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 17 => 0.3680019452,
    txinqwnamefirst_dayssince > 17                                       => gbm10_wc_lgt_140_c624,
    txinqwnamefirst_dayssince = NULL                                     => -0.0099149360,
                                                                            0.0209942533);

rc007_140_5_c623 := map(
    NULL < txinqwnamefirst_dayssince AND txinqwnamefirst_dayssince <= 17 => 0,
    txinqwnamefirst_dayssince > 17                                       => rc007_140_5_c624,
    txinqwnamefirst_dayssince = NULL                                     => 0,
                                                                            0);

gbm10_wc_lgt_140_c625 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 32.5 => -0.0069981717,
    trueipperphoneintxinqcnt > 32.5                                      => 0.2057317043,
    trueipperphoneintxinqcnt = NULL                                      => -0.0002633422,
                                                                            -0.0016320403);

rc017_140_10_c625 := map(
    NULL < trueipperphoneintxinqcnt AND trueipperphoneintxinqcnt <= 32.5 => -0.0053661314,
    trueipperphoneintxinqcnt > 32.5                                      => 0.2073637446,
    trueipperphoneintxinqcnt = NULL                                      => 0.0013686981,
                                                                            0);

rc023_140_1 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 81.5 => 0.0001301317,
    txinqcorremailwphonecnt > 81.5                                     => 0.0221781075,
    txinqcorremailwphonecnt = NULL                                     => -0.0004481860,
                                                                          0);

rc013_140_3 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 81.5 => 0,
    txinqcorremailwphonecnt > 81.5                                     => rc013_140_3_c623,
    txinqcorremailwphonecnt = NULL                                     => 0,
                                                                          0);

gbm10_wc_lgt_140 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 81.5 => -0.0010537226,
    txinqcorremailwphonecnt > 81.5                                     => gbm10_wc_lgt_140_c623,
    txinqcorremailwphonecnt = NULL                                     => gbm10_wc_lgt_140_c625,
                                                                          -0.0011838543);

rc007_140_5 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 81.5 => 0,
    txinqcorremailwphonecnt > 81.5                                     => rc007_140_5_c623,
    txinqcorremailwphonecnt = NULL                                     => 0,
                                                                          0);

rc017_140_10 := map(
    NULL < txinqcorremailwphonecnt AND txinqcorremailwphonecnt <= 81.5 => 0,
    txinqcorremailwphonecnt > 81.5                                     => 0,
    txinqcorremailwphonecnt = NULL                                     => rc017_140_10_c625,
                                                                          0);

gbm10_wc_lgt_141_c628 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 0.5 => 0.1521530065,
    trueippertmxidintxinqcnt1m > 0.5                                        => -0.0128644148,
    trueippertmxidintxinqcnt1m = NULL                                       => 0.0057228896,
                                                                               0.0115677712);

rc048_141_4_c628 := map(
    NULL < trueippertmxidintxinqcnt1m AND trueippertmxidintxinqcnt1m <= 0.5 => 0.1405852353,
    trueippertmxidintxinqcnt1m > 0.5                                        => -0.0244321860,
    trueippertmxidintxinqcnt1m = NULL                                       => -0.0058448816,
                                                                               0);

gbm10_wc_lgt_141_c629 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 74.5 => -0.2214846393,
    txinqwaddrlast_dayssince > 74.5                                      => 1.3244389793,
    txinqwaddrlast_dayssince = NULL                                      => -0.0450383141,
                                                                            0.1529899289);

rc025_141_9_c629 := map(
    NULL < txinqwaddrlast_dayssince AND txinqwaddrlast_dayssince <= 74.5 => -0.3744745683,
    txinqwaddrlast_dayssince > 74.5                                      => 1.1714490504,
    txinqwaddrlast_dayssince = NULL                                      => -0.1980282430,
                                                                            0);

rc025_141_9_c627 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 5404.2 => 0,
    distbtwtrueipwemailavg > 5404.2                                    => 0,
    distbtwtrueipwemailavg = NULL                                      => rc025_141_9_c629,
                                                                          0);

rc048_141_4_c627 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 5404.2 => rc048_141_4_c628,
    distbtwtrueipwemailavg > 5404.2                                    => 0,
    distbtwtrueipwemailavg = NULL                                      => 0,
                                                                          0);

gbm10_wc_lgt_141_c627 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 5404.2 => gbm10_wc_lgt_141_c628,
    distbtwtrueipwemailavg > 5404.2                                    => 0.4948517886,
    distbtwtrueipwemailavg = NULL                                      => gbm10_wc_lgt_141_c629,
                                                                          0.0148925397);

rc011_141_3_c627 := map(
    NULL < distbtwtrueipwemailavg AND distbtwtrueipwemailavg <= 5404.2 => -0.0033247686,
    distbtwtrueipwemailavg > 5404.2                                    => 0.4799592489,
    distbtwtrueipwemailavg = NULL                                      => 0.1380973892,
                                                                          0);

rc011_141_3 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => 0,
    tmxidperemailintxinqcnt1m > 1.5                                       => rc011_141_3_c627,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_141 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => -0.0089647062,
    tmxidperemailintxinqcnt1m > 1.5                                       => gbm10_wc_lgt_141_c627,
    tmxidperemailintxinqcnt1m = NULL                                      => -0.0010640565,
                                                                             -0.0047704699);

rc025_141_9 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => 0,
    tmxidperemailintxinqcnt1m > 1.5                                       => rc025_141_9_c627,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc048_141_4 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => 0,
    tmxidperemailintxinqcnt1m > 1.5                                       => rc048_141_4_c627,
    tmxidperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

rc024_141_1 := map(
    NULL < tmxidperemailintxinqcnt1m AND tmxidperemailintxinqcnt1m <= 1.5 => -0.0041942363,
    tmxidperemailintxinqcnt1m > 1.5                                       => 0.0196630097,
    tmxidperemailintxinqcnt1m = NULL                                      => 0.0037064135,
                                                                             0);

rc047_142_4_c632 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 51.5 => -0.0012726899,
    exactidperemailintxinqcnt > 51.5                                       => 0.6362179571,
    exactidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_142_c632 := map(
    NULL < exactidperemailintxinqcnt AND exactidperemailintxinqcnt <= 51.5 => -0.0268183732,
    exactidperemailintxinqcnt > 51.5                                       => 0.6106722738,
    exactidperemailintxinqcnt = NULL                                       => -0.0255456833,
                                                                              -0.0255456833);

rc041_142_8_c633 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 10.5 => -0.0016510546,
    txinqcorremailwnamecnt1y > 10.5                                      => 0.7390840857,
    txinqcorremailwnamecnt1y = NULL                                      => 0.0003906240,
                                                                            0);

gbm10_wc_lgt_142_c633 := map(
    NULL < txinqcorremailwnamecnt1y AND txinqcorremailwnamecnt1y <= 10.5 => -0.0061625708,
    txinqcorremailwnamecnt1y > 10.5                                      => 0.7345725695,
    txinqcorremailwnamecnt1y = NULL                                      => -0.0041208922,
                                                                            -0.0045115162);

gbm10_wc_lgt_142_c631 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.695 => 0.0140871523,
    timebtwtxinqwphoneavg > 85032.695                                   => gbm10_wc_lgt_142_c632,
    timebtwtxinqwphoneavg = NULL                                        => gbm10_wc_lgt_142_c633,
                                                                           -0.0044544799);

rc047_142_4_c631 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.695 => 0,
    timebtwtxinqwphoneavg > 85032.695                                   => rc047_142_4_c632,
    timebtwtxinqwphoneavg = NULL                                        => 0,
                                                                           0);

rc041_142_8_c631 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.695 => 0,
    timebtwtxinqwphoneavg > 85032.695                                   => 0,
    timebtwtxinqwphoneavg = NULL                                        => rc041_142_8_c633,
                                                                           0);

rc012_142_2_c631 := map(
    NULL < timebtwtxinqwphoneavg AND timebtwtxinqwphoneavg <= 85032.695 => 0.0185416322,
    timebtwtxinqwphoneavg > 85032.695                                   => -0.0210912034,
    timebtwtxinqwphoneavg = NULL                                        => -0.0000570363,
                                                                           0);

rc012_142_2 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 38.5 => rc012_142_2_c631,
    smartidperemailintxinqcnt > 38.5                                       => 0,
    smartidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

rc041_142_8 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 38.5 => rc041_142_8_c631,
    smartidperemailintxinqcnt > 38.5                                       => 0,
    smartidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

rc047_142_4 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 38.5 => rc047_142_4_c631,
    smartidperemailintxinqcnt > 38.5                                       => 0,
    smartidperemailintxinqcnt = NULL                                       => 0,
                                                                              0);

gbm10_wc_lgt_142 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 38.5 => gbm10_wc_lgt_142_c631,
    smartidperemailintxinqcnt > 38.5                                       => -0.1107030838,
    smartidperemailintxinqcnt = NULL                                       => -0.0008521055,
                                                                              -0.0042302691);

rc042_142_1 := map(
    NULL < smartidperemailintxinqcnt AND smartidperemailintxinqcnt <= 38.5 => -0.0002242107,
    smartidperemailintxinqcnt > 38.5                                       => -0.1064728147,
    smartidperemailintxinqcnt = NULL                                       => 0.0033781636,
                                                                              0);

rc036_143_7_c637 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 5.5 => -0.1423660742,
    trueipperemailintxinqcnt > 5.5                                      => 0.0493616961,
    trueipperemailintxinqcnt = NULL                                     => 0.1241799038,
                                                                           0);

gbm10_wc_lgt_143_c637 := map(
    NULL < trueipperemailintxinqcnt AND trueipperemailintxinqcnt <= 5.5 => -0.1909703178,
    trueipperemailintxinqcnt > 5.5                                      => 0.0007574525,
    trueipperemailintxinqcnt = NULL                                     => 0.0755756603,
                                                                           -0.0486042436);

rc035_143_5_c636 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 8.5 => 0.3161201866,
    txinqwtmxidfirst_dayssince > 8.5                                        => -0.0222824604,
    txinqwtmxidfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc036_143_7_c636 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 8.5 => 0,
    txinqwtmxidfirst_dayssince > 8.5                                        => rc036_143_7_c637,
    txinqwtmxidfirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_143_c636 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 8.5 => 0.2897984034,
    txinqwtmxidfirst_dayssince > 8.5                                        => gbm10_wc_lgt_143_c637,
    txinqwtmxidfirst_dayssince = NULL                                       => -0.0263217832,
                                                                               -0.0263217832);

rc035_143_5_c635 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 5.5 => 0,
    txinqwtmxidfirst_dayssince > 5.5                                        => rc035_143_5_c636,
    txinqwtmxidfirst_dayssince = NULL                                       => 0,
                                                                               0);

rc036_143_7_c635 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 5.5 => 0,
    txinqwtmxidfirst_dayssince > 5.5                                        => rc036_143_7_c636,
    txinqwtmxidfirst_dayssince = NULL                                       => 0,
                                                                               0);

gbm10_wc_lgt_143_c635 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 5.5 => -0.1717425805,
    txinqwtmxidfirst_dayssince > 5.5                                        => gbm10_wc_lgt_143_c636,
    txinqwtmxidfirst_dayssince = NULL                                       => -0.0105051556,
                                                                               -0.0161333172);

rc035_143_3_c635 := map(
    NULL < txinqwtmxidfirst_dayssince AND txinqwtmxidfirst_dayssince <= 5.5 => -0.1556092633,
    txinqwtmxidfirst_dayssince > 5.5                                        => -0.0101884659,
    txinqwtmxidfirst_dayssince = NULL                                       => 0.0056281617,
                                                                               0);

gbm10_wc_lgt_143 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0046428967,
    smartidperphoneintxinqcnt1m > 1.5                                         => gbm10_wc_lgt_143_c635,
    smartidperphoneintxinqcnt1m = NULL                                        => 0.0008795436,
                                                                                 0.0028805781);

rc035_143_3 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc035_143_3_c635,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc035_143_5 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc035_143_5_c635,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc003_143_1 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0.0017623186,
    smartidperphoneintxinqcnt1m > 1.5                                         => -0.0190138954,
    smartidperphoneintxinqcnt1m = NULL                                        => -0.0020010346,
                                                                                 0);

rc036_143_7 := map(
    NULL < smartidperphoneintxinqcnt1m AND smartidperphoneintxinqcnt1m <= 1.5 => 0,
    smartidperphoneintxinqcnt1m > 1.5                                         => rc036_143_7_c635,
    smartidperphoneintxinqcnt1m = NULL                                        => 0,
                                                                                 0);

rc039_144_3_c640 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => 0.0005189348,
    phoneperemailintxinqcnt1m > 2.5                                       => -0.2588362513,
    phoneperemailintxinqcnt1m = NULL                                      => 0,
                                                                             0);

gbm10_wc_lgt_144_c640 := map(
    NULL < phoneperemailintxinqcnt1m AND phoneperemailintxinqcnt1m <= 2.5 => 0.0157229564,
    phoneperemailintxinqcnt1m > 2.5                                       => -0.2436322298,
    phoneperemailintxinqcnt1m = NULL                                      => 0.0152040215,
                                                                             0.0152040215);

gbm10_wc_lgt_144_c641 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 1.5 => 0.1492040901,
    emailperphoneintxinqcnt6m > 1.5                                       => -0.0307756349,
    emailperphoneintxinqcnt6m = NULL                                      => 0.0450061602,
                                                                             0.0905742188);

rc014_144_7_c641 := map(
    NULL < emailperphoneintxinqcnt6m AND emailperphoneintxinqcnt6m <= 1.5 => 0.0586298713,
    emailperphoneintxinqcnt6m > 1.5                                       => -0.1213498537,
    emailperphoneintxinqcnt6m = NULL                                      => -0.0455680586,
                                                                             0);

rc014_144_7_c639 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 3.5 => 0,
    orgidperemailintxinqcnt > 3.5                                     => rc014_144_7_c641,
    orgidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

gbm10_wc_lgt_144_c639 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 3.5 => gbm10_wc_lgt_144_c640,
    orgidperemailintxinqcnt > 3.5                                     => gbm10_wc_lgt_144_c641,
    orgidperemailintxinqcnt = NULL                                    => 0.0187537985,
                                                                         0.0187537985);

rc043_144_2_c639 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 3.5 => -0.0035497769,
    orgidperemailintxinqcnt > 3.5                                     => 0.0718204204,
    orgidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

rc039_144_3_c639 := map(
    NULL < orgidperemailintxinqcnt AND orgidperemailintxinqcnt <= 3.5 => rc039_144_3_c640,
    orgidperemailintxinqcnt > 3.5                                     => 0,
    orgidperemailintxinqcnt = NULL                                    => 0,
                                                                         0);

rc043_144_2 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 208.5 => rc043_144_2_c639,
    txinqwemailfirst_dayssince > 208.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc039_144_3 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 208.5 => rc039_144_3_c639,
    txinqwemailfirst_dayssince > 208.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc014_144_7 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 208.5 => rc014_144_7_c639,
    txinqwemailfirst_dayssince > 208.5                                        => 0,
    txinqwemailfirst_dayssince = NULL                                         => 0,
                                                                                 0);

rc002_144_1 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 208.5 => 0.0218774170,
    txinqwemailfirst_dayssince > 208.5                                        => -0.0085691998,
    txinqwemailfirst_dayssince = NULL                                         => 0.0021993751,
                                                                                 0);

gbm10_wc_lgt_144 := map(
    NULL < txinqwemailfirst_dayssince AND txinqwemailfirst_dayssince <= 208.5 => gbm10_wc_lgt_144_c639,
    txinqwemailfirst_dayssince > 208.5                                        => -0.0116928183,
    txinqwemailfirst_dayssince = NULL                                         => -0.0009242435,
                                                                                 -0.0031236185);

aa_rc000 := -4.7861109516;

aa_rc001_2 := rc001_1_1 +
    rc001_2_9 +
    rc001_6_2 +
    rc001_7_3 +
    rc001_10_1 +
    rc001_12_2 +
    rc001_18_1 +
    rc001_22_3 +
    rc001_27_1 +
    rc001_28_10 +
    rc001_33_1 +
    rc001_38_1 +
    rc001_42_10 +
    rc001_44_2 +
    rc001_52_1 +
    rc001_63_1 +
    rc001_66_1 +
    rc001_68_1 +
    rc001_71_2 +
    rc001_89_1 +
    rc001_94_1 +
    rc001_102_1 +
    rc001_107_1 +
    rc001_117_1 +
    rc001_119_4 +
    rc001_122_1 +
    rc001_134_1 +
    rc001_139_1;

aa_rc002_2 := rc002_2_4 +
    rc002_3_6 +
    rc002_9_6 +
    rc002_19_7 +
    rc002_20_3 +
    rc002_21_9 +
    rc002_22_4 +
    rc002_23_1 +
    rc002_24_4 +
    rc002_29_4 +
    rc002_30_1 +
    rc002_34_4 +
    rc002_34_9 +
    rc002_36_5 +
    rc002_37_5 +
    rc002_39_4 +
    rc002_40_1 +
    rc002_41_4 +
    rc002_44_6 +
    rc002_46_2 +
    rc002_51_9 +
    rc002_54_1 +
    rc002_55_1 +
    rc002_58_5 +
    rc002_63_7 +
    rc002_64_4 +
    rc002_72_1 +
    rc002_86_4 +
    rc002_91_1 +
    rc002_92_3 +
    rc002_92_5 +
    rc002_96_7 +
    rc002_98_8 +
    rc002_105_4 +
    rc002_112_7 +
    rc002_136_7 +
    rc002_137_5 +
    rc002_144_1;

aa_rc003_2 := rc003_1_2 +
    rc003_2_2 +
    rc003_8_10 +
    rc003_13_9 +
    rc003_25_2 +
    rc003_26_6 +
    rc003_35_6 +
    rc003_35_8 +
    rc003_43_1 +
    rc003_47_4 +
    rc003_49_1 +
    rc003_53_1 +
    rc003_57_1 +
    rc003_64_1 +
    rc003_67_4 +
    rc003_69_1 +
    rc003_74_9 +
    rc003_78_1 +
    rc003_79_1 +
    rc003_85_1 +
    rc003_90_4 +
    rc003_93_2 +
    rc003_97_2 +
    rc003_101_1 +
    rc003_102_5 +
    rc003_103_3 +
    rc003_104_1 +
    rc003_113_1 +
    rc003_120_4 +
    rc003_129_1 +
    rc003_130_1 +
    rc003_135_1 +
    rc003_143_1;

aa_rc004_2 := rc004_1_9 +
    rc004_2_1 +
    rc004_4_9 +
    rc004_5_1 +
    rc004_15_1 +
    rc004_17_1 +
    rc004_23_7 +
    rc004_45_1 +
    rc004_52_5 +
    rc004_60_1 +
    rc004_60_2 +
    rc004_81_10 +
    rc004_119_1 +
    rc004_123_2 +
    rc004_127_5;

aa_rc005_2 := rc005_5_4 +
    rc005_16_6 +
    rc005_23_9 +
    rc005_24_3 +
    rc005_32_7 +
    rc005_38_6 +
    rc005_41_3 +
    rc005_47_2 +
    rc005_50_3 +
    rc005_50_7 +
    rc005_54_2 +
    rc005_57_6 +
    rc005_62_3 +
    rc005_67_2 +
    rc005_68_7 +
    rc005_90_5 +
    rc005_93_4 +
    rc005_94_7 +
    rc005_95_5 +
    rc005_97_4 +
    rc005_100_7 +
    rc005_106_3 +
    rc005_109_2 +
    rc005_116_3 +
    rc005_120_5 +
    rc005_127_7 +
    rc005_128_7 +
    rc005_130_3 +
    rc005_133_3 +
    rc005_138_3;

aa_rc006_2 := rc006_4_1 +
    rc006_8_1 +
    rc006_16_7 +
    rc006_21_2 +
    rc006_38_7 +
    rc006_43_3 +
    rc006_56_2 +
    rc006_57_3 +
    rc006_78_3 +
    rc006_80_5 +
    rc006_82_3 +
    rc006_83_3 +
    rc006_83_6 +
    rc006_84_4 +
    rc006_85_8 +
    rc006_86_8 +
    rc006_101_8 +
    rc006_103_5 +
    rc006_110_5 +
    rc006_112_3 +
    rc006_113_7 +
    rc006_134_6 +
    rc006_136_8;

aa_rc007_2 := rc007_15_3 +
    rc007_19_5 +
    rc007_27_5 +
    rc007_34_3 +
    rc007_40_4 +
    rc007_45_3 +
    rc007_45_5 +
    rc007_58_3 +
    rc007_60_4 +
    rc007_60_6 +
    rc007_61_5 +
    rc007_65_4 +
    rc007_71_9 +
    rc007_77_9 +
    rc007_80_3 +
    rc007_98_3 +
    rc007_134_5 +
    rc007_140_5;

aa_rc008_2 := rc008_1_4 +
    rc008_13_1 +
    rc008_14_3 +
    rc008_14_8 +
    rc008_17_8 +
    rc008_26_1 +
    rc008_26_2 +
    rc008_35_1 +
    rc008_35_2 +
    rc008_43_4 +
    rc008_71_4 +
    rc008_73_2 +
    rc008_78_4 +
    rc008_89_8 +
    rc008_90_1 +
    rc008_120_1;

aa_rc009_2 := rc009_3_1 +
    rc009_4_2 +
    rc009_7_2 +
    rc009_8_2 +
    rc009_13_3 +
    rc009_22_1 +
    rc009_62_8 +
    rc009_65_1 +
    rc009_114_4 +
    rc009_116_4 +
    rc009_138_7;

aa_rc010_2 := rc010_3_2 +
    rc010_6_1 +
    rc010_11_2 +
    rc010_16_4 +
    rc010_56_3 +
    rc010_68_3 +
    rc010_84_2 +
    rc010_99_2 +
    rc010_115_3 +
    rc010_117_4 +
    rc010_118_6 +
    rc010_122_3 +
    rc010_122_5 +
    rc010_133_6 +
    rc010_136_1 +
    rc010_136_2 +
    rc010_137_2 +
    rc010_139_3;

aa_rc011_1 := rc011_10_8 +
    rc011_12_4 +
    rc011_19_3 +
    rc011_33_3 +
    rc011_39_9 +
    rc011_49_6 +
    rc011_50_5 +
    rc011_58_4 +
    rc011_59_6 +
    rc011_70_5 +
    rc011_72_2 +
    rc011_87_8 +
    rc011_92_1 +
    rc011_99_6 +
    rc011_100_5 +
    rc011_108_7 +
    rc011_112_5 +
    rc011_131_4 +
    rc011_141_3;

aa_rc012_2 := rc012_6_3 +
    rc012_11_7 +
    rc012_14_2 +
    rc012_41_5 +
    rc012_47_1 +
    rc012_51_2 +
    rc012_63_5 +
    rc012_67_1 +
    rc012_79_9 +
    rc012_91_7 +
    rc012_92_6 +
    rc012_102_3 +
    rc012_103_1 +
    rc012_105_6 +
    rc012_106_5 +
    rc012_113_6 +
    rc012_123_3 +
    rc012_132_5 +
    rc012_142_2;

aa_rc013_2 := rc013_10_6 +
    rc013_12_7 +
    rc013_18_9 +
    rc013_53_9 +
    rc013_68_5 +
    rc013_74_3 +
    rc013_100_3 +
    rc013_102_7 +
    rc013_118_8 +
    rc013_123_4 +
    rc013_124_3 +
    rc013_125_1 +
    rc013_125_2 +
    rc013_140_3;

aa_rc014_2 := rc014_5_2 +
    rc014_10_2 +
    rc014_18_2 +
    rc014_27_2 +
    rc014_73_9 +
    rc014_94_5 +
    rc014_118_4 +
    rc014_144_7;

aa_rc015_2 := rc015_5_5 +
    rc015_15_7 +
    rc015_24_1 +
    rc015_28_2 +
    rc015_30_3 +
    rc015_41_1 +
    rc015_42_2 +
    rc015_75_1 +
    rc015_76_9 +
    rc015_84_1 +
    rc015_106_1 +
    rc015_110_3;

aa_rc016_2 := rc016_28_6 +
    rc016_31_6 +
    rc016_33_9 +
    rc016_49_3 +
    rc016_70_4 +
    rc016_85_3 +
    rc016_104_3 +
    rc016_107_9 +
    rc016_115_7 +
    rc016_117_3 +
    rc016_121_1 +
    rc016_135_4;

aa_rc017_2 := rc017_15_5 +
    rc017_29_2 +
    rc017_42_3 +
    rc017_45_7 +
    rc017_48_8 +
    rc017_54_3 +
    rc017_54_4 +
    rc017_76_2 +
    rc017_87_3 +
    rc017_89_4 +
    rc017_109_3 +
    rc017_140_10;

aa_rc018_2 := rc018_12_1 +
    rc018_19_1 +
    rc018_26_8 +
    rc018_39_1 +
    rc018_55_2 +
    rc018_66_4 +
    rc018_80_1 +
    rc018_82_7 +
    rc018_106_4 +
    rc018_125_7;

aa_rc019_2 := rc019_3_8 +
    rc019_9_2 +
    rc019_53_3 +
    rc019_66_3 +
    rc019_75_9 +
    rc019_103_10 +
    rc019_126_1 +
    rc019_126_2;

aa_rc020_2 := rc020_8_6 +
    rc020_13_2 +
    rc020_20_1 +
    rc020_29_10 +
    rc020_31_5 +
    rc020_74_1 +
    rc020_91_3 +
    rc020_99_4 +
    rc020_109_8 +
    rc020_121_7;

aa_rc021_2 := rc021_11_1 +
    rc021_18_4 +
    rc021_25_1 +
    rc021_30_4 +
    rc021_66_8 +
    rc021_75_2 +
    rc021_83_1 +
    rc021_99_1 +
    rc021_112_1 +
    rc021_127_4 +
    rc021_135_8;

aa_rc022_2 := rc022_22_8 +
    rc022_33_4 +
    rc022_37_1 +
    rc022_97_5 +
    rc022_108_2 +
    rc022_116_1 +
    rc022_121_4 +
    rc022_123_1 +
    rc022_125_9;

aa_rc023_2 := rc023_32_6 +
    rc023_37_2 +
    rc023_43_8 +
    rc023_57_5 +
    rc023_78_8 +
    rc023_88_4 +
    rc023_111_4 +
    rc023_129_9 +
    rc023_140_1;

aa_rc024_2 := rc024_17_4 +
    rc024_21_7 +
    rc024_31_1 +
    rc024_55_5 +
    rc024_88_1 +
    rc024_94_2 +
    rc024_114_3 +
    rc024_141_1;

aa_rc025_2 := rc025_39_3 +
    rc025_73_6 +
    rc025_86_5 +
    rc025_93_1 +
    rc025_113_3 +
    rc025_131_3 +
    rc025_135_3 +
    rc025_141_9;

aa_rc026_2 := rc026_27_4 +
    rc026_44_9 +
    rc026_49_9 +
    rc026_79_4 +
    rc026_104_9 +
    rc026_134_3 +
    rc026_138_5;

aa_rc027_2 := rc027_9_7 +
    rc027_17_3 +
    rc027_25_4 +
    rc027_56_5 +
    rc027_87_4 +
    rc027_116_2;

aa_rc028_2 := rc028_6_9 +
    rc028_7_5 +
    rc028_107_2 +
    rc028_132_2;

aa_rc029_2 := rc029_20_4 +
    rc029_20_6 +
    rc029_46_1 +
    rc029_56_1 +
    rc029_63_3 +
    rc029_80_7 +
    rc029_85_6 +
    rc029_108_1 +
    rc029_118_1 +
    rc029_121_5 +
    rc029_124_8;

aa_rc030_2 := rc030_7_1 +
    rc030_9_1 +
    rc030_34_1 +
    rc030_48_2 +
    rc030_81_1 +
    rc030_81_2 +
    rc030_110_1 +
    rc030_127_1 +
    rc030_130_4;

aa_rc031_2 := rc031_44_1 +
    rc031_52_3 +
    rc031_65_5 +
    rc031_71_1 +
    rc031_89_3 +
    rc031_100_1 +
    rc031_101_4 +
    rc031_117_5 +
    rc031_119_2 +
    rc031_119_3 +
    rc031_122_7;

aa_rc032_2 := rc032_36_2 +
    rc032_47_3 +
    rc032_58_1 +
    rc032_61_1 +
    rc032_61_2 +
    rc032_67_3 +
    rc032_72_4 +
    rc032_77_1 +
    rc032_77_2 +
    rc032_96_1 +
    rc032_96_2 +
    rc032_97_1 +
    rc032_98_1 +
    rc032_111_2 +
    rc032_131_1;

aa_rc033_2 := rc033_24_6 +
    rc033_31_2 +
    rc033_32_1 +
    rc033_48_1 +
    rc033_50_1 +
    rc033_62_1 +
    rc033_86_1 +
    rc033_90_3 +
    rc033_105_3 +
    rc033_120_3 +
    rc033_124_1 +
    rc033_132_1 +
    rc033_132_3 +
    rc033_138_1;

aa_rc034_2 := rc034_4_4 +
    rc034_75_4 +
    rc034_83_5 +
    rc034_130_5;

aa_rc035_2 := rc035_38_3 +
    rc035_42_1 +
    rc035_70_1 +
    rc035_107_6 +
    rc035_115_1 +
    rc035_133_5 +
    rc035_139_5 +
    rc035_143_3 +
    rc035_143_5;

aa_rc036_2 := rc036_25_5 +
    rc036_36_4 +
    rc036_46_4 +
    rc036_74_5 +
    rc036_143_7;

aa_rc037_2 := rc037_11_3 +
    rc037_16_1 +
    rc037_28_1 +
    rc037_32_3 +
    rc037_62_5 +
    rc037_64_3;

aa_rc038_2 := rc038_29_1 +
    rc038_36_1 +
    rc038_51_1 +
    rc038_53_4 +
    rc038_76_1 +
    rc038_77_4 +
    rc038_84_5 +
    rc038_101_3 +
    rc038_114_8 +
    rc038_133_1 +
    rc038_139_7;

aa_rc039_2 := rc039_37_3 +
    rc039_72_3 +
    rc039_81_4 +
    rc039_91_2 +
    rc039_124_4 +
    rc039_144_3;

aa_rc040_2 := rc040_69_4 +
    rc040_88_6 +
    rc040_95_2;

aa_rc041_2 := rc041_61_4 +
    rc041_76_6 +
    rc041_79_3 +
    rc041_111_1 +
    rc041_129_3 +
    rc041_142_8;

aa_rc042_2 := rc042_40_6 +
    rc042_64_6 +
    rc042_98_4 +
    rc042_142_1;

aa_rc043_2 := rc043_69_6 +
    rc043_104_5 +
    rc043_110_2 +
    rc043_144_2;

aa_rc044_2 := rc044_59_3 +
    rc044_59_4 +
    rc044_70_2 +
    rc044_111_9 +
    rc044_126_3;

aa_rc045_2 := rc045_14_1 +
    rc045_21_1 +
    rc045_65_2;

aa_rc046_2 := rc046_40_2 +
    rc046_52_6 +
    rc046_82_1 +
    rc046_105_1 +
    rc046_126_4;

aa_rc047_2 := rc047_48_3 +
    rc047_73_1 +
    rc047_93_9 +
    rc047_128_2 +
    rc047_131_5 +
    rc047_142_4;

aa_rc048_2 := rc048_88_3 +
    rc048_95_1 +
    rc048_95_3 +
    rc048_137_1 +
    rc048_137_3 +
    rc048_141_4;

aa_rc049_2 := rc049_51_5 +
    rc049_55_3 +
    rc049_59_1 +
    rc049_87_1;

aa_rc050_2 := rc050_82_4 + rc050_108_4;

aa_rc051_2 := rc051_46_3 + rc051_129_5;

aa_rc052_2 := rc052_23_2 + rc052_30_2;

aa_rc053_2 := rc053_96_6 + rc053_114_1;

aa_rc054_2 := rc054_109_1 +
    rc054_128_1 +
    rc054_128_3;

aa_rc055_2 := rc055_69_3;

aa_rc056_2 := rc056_115_2;

gbm10_wc_lgt := gbm10_wc_lgt_0 +
    gbm10_wc_lgt_1 +
    gbm10_wc_lgt_2 +
    gbm10_wc_lgt_3 +
    gbm10_wc_lgt_4 +
    gbm10_wc_lgt_5 +
    gbm10_wc_lgt_6 +
    gbm10_wc_lgt_7 +
    gbm10_wc_lgt_8 +
    gbm10_wc_lgt_9 +
    gbm10_wc_lgt_10 +
    gbm10_wc_lgt_11 +
    gbm10_wc_lgt_12 +
    gbm10_wc_lgt_13 +
    gbm10_wc_lgt_14 +
    gbm10_wc_lgt_15 +
    gbm10_wc_lgt_16 +
    gbm10_wc_lgt_17 +
    gbm10_wc_lgt_18 +
    gbm10_wc_lgt_19 +
    gbm10_wc_lgt_20 +
    gbm10_wc_lgt_21 +
    gbm10_wc_lgt_22 +
    gbm10_wc_lgt_23 +
    gbm10_wc_lgt_24 +
    gbm10_wc_lgt_25 +
    gbm10_wc_lgt_26 +
    gbm10_wc_lgt_27 +
    gbm10_wc_lgt_28 +
    gbm10_wc_lgt_29 +
    gbm10_wc_lgt_30 +
    gbm10_wc_lgt_31 +
    gbm10_wc_lgt_32 +
    gbm10_wc_lgt_33 +
    gbm10_wc_lgt_34 +
    gbm10_wc_lgt_35 +
    gbm10_wc_lgt_36 +
    gbm10_wc_lgt_37 +
    gbm10_wc_lgt_38 +
    gbm10_wc_lgt_39 +
    gbm10_wc_lgt_40 +
    gbm10_wc_lgt_41 +
    gbm10_wc_lgt_42 +
    gbm10_wc_lgt_43 +
    gbm10_wc_lgt_44 +
    gbm10_wc_lgt_45 +
    gbm10_wc_lgt_46 +
    gbm10_wc_lgt_47 +
    gbm10_wc_lgt_48 +
    gbm10_wc_lgt_49 +
    gbm10_wc_lgt_50 +
    gbm10_wc_lgt_51 +
    gbm10_wc_lgt_52 +
    gbm10_wc_lgt_53 +
    gbm10_wc_lgt_54 +
    gbm10_wc_lgt_55 +
    gbm10_wc_lgt_56 +
    gbm10_wc_lgt_57 +
    gbm10_wc_lgt_58 +
    gbm10_wc_lgt_59 +
    gbm10_wc_lgt_60 +
    gbm10_wc_lgt_61 +
    gbm10_wc_lgt_62 +
    gbm10_wc_lgt_63 +
    gbm10_wc_lgt_64 +
    gbm10_wc_lgt_65 +
    gbm10_wc_lgt_66 +
    gbm10_wc_lgt_67 +
    gbm10_wc_lgt_68 +
    gbm10_wc_lgt_69 +
    gbm10_wc_lgt_70 +
    gbm10_wc_lgt_71 +
    gbm10_wc_lgt_72 +
    gbm10_wc_lgt_73 +
    gbm10_wc_lgt_74 +
    gbm10_wc_lgt_75 +
    gbm10_wc_lgt_76 +
    gbm10_wc_lgt_77 +
    gbm10_wc_lgt_78 +
    gbm10_wc_lgt_79 +
    gbm10_wc_lgt_80 +
    gbm10_wc_lgt_81 +
    gbm10_wc_lgt_82 +
    gbm10_wc_lgt_83 +
    gbm10_wc_lgt_84 +
    gbm10_wc_lgt_85 +
    gbm10_wc_lgt_86 +
    gbm10_wc_lgt_87 +
    gbm10_wc_lgt_88 +
    gbm10_wc_lgt_89 +
    gbm10_wc_lgt_90 +
    gbm10_wc_lgt_91 +
    gbm10_wc_lgt_92 +
    gbm10_wc_lgt_93 +
    gbm10_wc_lgt_94 +
    gbm10_wc_lgt_95 +
    gbm10_wc_lgt_96 +
    gbm10_wc_lgt_97 +
    gbm10_wc_lgt_98 +
    gbm10_wc_lgt_99 +
    gbm10_wc_lgt_100 +
    gbm10_wc_lgt_101 +
    gbm10_wc_lgt_102 +
    gbm10_wc_lgt_103 +
    gbm10_wc_lgt_104 +
    gbm10_wc_lgt_105 +
    gbm10_wc_lgt_106 +
    gbm10_wc_lgt_107 +
    gbm10_wc_lgt_108 +
    gbm10_wc_lgt_109 +
    gbm10_wc_lgt_110 +
    gbm10_wc_lgt_111 +
    gbm10_wc_lgt_112 +
    gbm10_wc_lgt_113 +
    gbm10_wc_lgt_114 +
    gbm10_wc_lgt_115 +
    gbm10_wc_lgt_116 +
    gbm10_wc_lgt_117 +
    gbm10_wc_lgt_118 +
    gbm10_wc_lgt_119 +
    gbm10_wc_lgt_120 +
    gbm10_wc_lgt_121 +
    gbm10_wc_lgt_122 +
    gbm10_wc_lgt_123 +
    gbm10_wc_lgt_124 +
    gbm10_wc_lgt_125 +
    gbm10_wc_lgt_126 +
    gbm10_wc_lgt_127 +
    gbm10_wc_lgt_128 +
    gbm10_wc_lgt_129 +
    gbm10_wc_lgt_130 +
    gbm10_wc_lgt_131 +
    gbm10_wc_lgt_132 +
    gbm10_wc_lgt_133 +
    gbm10_wc_lgt_134 +
    gbm10_wc_lgt_135 +
    gbm10_wc_lgt_136 +
    gbm10_wc_lgt_137 +
    gbm10_wc_lgt_138 +
    gbm10_wc_lgt_139 +
    gbm10_wc_lgt_140 +
    gbm10_wc_lgt_141 +
    gbm10_wc_lgt_142 +
    gbm10_wc_lgt_143 +
    gbm10_wc_lgt_144;

lgt := ln(1 / 200);

offset := -0.7354385;

base := 913.7083;

pts := -102.4264;

gbm_mod10 := min(if(max(round(base + pts * (gbm10_wc_lgt - offset - lgt) / ln(2)), 300) = NULL, -NULL, max(round(base + pts * (gbm10_wc_lgt - offset - lgt) / ln(2)), 300)), 999);

aa_rc032_1 := if((txinqcorremailwphonecnt1m in [NULL, -99999, -99998, -99997]), 0, aa_rc032_2);

aa_rc027_1 := if((txinqcorremailwphonecnt3m in [NULL, -99999, -99998, -99997]), 0, aa_rc027_2);

aa_rc051_1 := if((txinqcorremailwphonecnt1y in [NULL, -99999, -99998, -99997]), 0, aa_rc051_2);

aa_rc023_1 := if((txinqcorremailwphonecnt in [NULL, -99999, -99998, -99997]), 0, aa_rc023_2);

aa_rc041_1 := if((txinqcorremailwnamecnt1y in [NULL, -99999, -99998, -99997]), 0, aa_rc041_2);

aa_rc050_1 := if((txinqcorremailwaddresscnt6m in [NULL, -99999, -99998, -99997]), 0, aa_rc050_2);

aa_rc053_1 := if((txinqcorremailwaddresscnt in [NULL, -99999, -99998, -99997]), 0, aa_rc053_2);

aa_rc001_1 := if((emailperphoneintxinqcnt3m in [NULL, -99999, -99998, -99997]), 0, aa_rc001_2);

aa_rc014_1 := if((emailperphoneintxinqcnt6m in [NULL, -99999, -99998, -99997]), 0, aa_rc014_2);

aa_rc045_1 := if((emailperphoneintxinqcnt1y in [NULL, -99999, -99998, -99997]), 0, aa_rc045_2);

aa_rc033_1 := if((emailperphoneintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc033_2);

aa_rc009_1 := if((exactidperemailintxinqcnt1m in [NULL, -99999, -99998, -99997]), 0, aa_rc009_2);

aa_rc044_1 := if((exactidperemailintxinqcnt3m in [NULL, -99999, -99998, -99997]), 0, aa_rc044_2);

aa_rc046_1 := if((exactidperemailintxinqcnt6m in [NULL, -99999, -99998, -99997]), 0, aa_rc046_2);

aa_rc047_1 := if((exactidperemailintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc047_2);

aa_rc034_1 := if((dnsipperemailintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc034_2);

aa_rc036_1 := if((trueipperemailintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc036_2);

aa_rc056_1 := if((proxyipgperemailintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc056_2);

aa_rc040_1 := if((proxyipperemailintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc040_2);

aa_rc039_1 := if((phoneperemailintxinqcnt1m in [NULL, -99999, -99998, -99997]), 0, aa_rc039_2);

aa_rc030_1 := if((phoneperemailintxinqcnt3m in [NULL, -99999, -99998, -99997]), 0, aa_rc030_2);

aa_rc020_1 := if((phoneperemailintxinqcnt1y in [NULL, -99999, -99998, -99997]), 0, aa_rc020_2);

aa_rc008_1 := if((smartidperemailintxinqcnt1m in [NULL, -99999, -99998, -99997]), 0, aa_rc008_2);

aa_rc019_1 := if((smartidperemailintxinqcnt3m in [NULL, -99999, -99998, -99997]), 0, aa_rc019_2);

aa_rc054_1 := if((smartidperemailintxinqcnt1y in [NULL, -99999, -99998, -99997]), 0, aa_rc054_2);

aa_rc042_1 := if((smartidperemailintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc042_2);

aa_rc003_1 := if((smartidperphoneintxinqcnt1m in [NULL, -99999, -99998, -99997]), 0, aa_rc003_2);

aa_rc028_1 := if((smartidperphoneintxinqcnt1y in [NULL, -99999, -99998, -99997]), 0, aa_rc028_2);

aa_rc024_1 := if((tmxidperemailintxinqcnt1m in [NULL, -99999, -99998, -99997]), 0, aa_rc024_2);

aa_rc052_1 := if((tmxidperemailintxinqcnt1y in [NULL, -99999, -99998, -99997]), 0, aa_rc052_2);

aa_rc049_1 := if((tmxidperemailintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc049_2);

aa_rc004_1 := if((tmxidperphoneintxinqcnt3m in [NULL, -99999, -99998, -99997]), 0, aa_rc004_2);

aa_rc031_1 := if((tmxidperphoneintxinqcnt1y in [NULL, -99999, -99998, -99997]), 0, aa_rc031_2);

aa_rc016_1 := if((txinqwaddrfirst_dayssince in [NULL, -99999, -99998, -99997]), 0, aa_rc016_2);

aa_rc025_1 := if((txinqwaddrlast_dayssince in [NULL, -99999, -99998, -99997]), 0, aa_rc025_2);

aa_rc002_1 := if((txinqwemailfirst_dayssince in [NULL, -99999, -99998, -99997]), 0, aa_rc002_2);

aa_rc029_1 := if((txinqwemaillast_dayssince in [NULL, -99999, -99998, -99997]), 0, aa_rc029_2);

aa_rc013_1 := if((txinqwnamefirst_dayssince in [NULL, -99999, -99998, -99997]), 0, aa_rc013_2);

aa_rc026_1 := if((txinqwnamelast_dayssince in [NULL, -99999, -99998, -99997]), 0, aa_rc026_2);

aa_rc005_1 := if((txinqwphonefirst_dayssince in [NULL, -99999, -99998, -99997]), 0, aa_rc005_2);

aa_rc022_1 := if((txinqwphonelast_dayssince in [NULL, -99999, -99998, -99997]), 0, aa_rc022_2);

aa_rc035_1 := if((txinqwtmxidfirst_dayssince in [NULL, -99999, -99998, -99997]), 0, aa_rc035_2);

aa_rc006_1 := if((timebtwtxinqwemailavg in [NULL, -99999, -99998, -99997]), 0, aa_rc006_2);

aa_rc012_1 := if((timebtwtxinqwphoneavg in [NULL, -99999, -99998, -99997]), 0, aa_rc012_2);

aa_rc055_1 := if((browserhashperemailintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc055_2);

aa_rc038_1 := if((browserhashperphoneintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc038_2);

aa_rc007_1 := if((distbtwtrueipwphoneavg in [NULL, -99999, -99998, -99997]), 0, aa_rc007_2);

aa_rc018_1 := if((txinqwemailcnt6m in [NULL, -99999, -99998, -99997]), 0, aa_rc018_2);

aa_rc010_1 := if((txinqwphonecnt1y in [NULL, -99999, -99998, -99997]), 0, aa_rc010_2);

aa_rc021_1 := if((exactidperphoneintxinqcnt3m in [NULL, -99999, -99998, -99997]), 0, aa_rc021_2);

aa_rc037_1 := if((exactidpertmxidintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc037_2);

aa_rc017_1 := if((trueipperphoneintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc017_2);

aa_rc048_1 := if((trueippertmxidintxinqcnt1m in [NULL, -99999, -99998, -99997]), 0, aa_rc048_2);

aa_rc015_1 := if((loginidperphoneintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc015_2);

aa_rc043_1 := if((orgidperemailintxinqcnt in [NULL, -99999, -99998, -99997]), 0, aa_rc043_2);

aa_rc032 := if(txinqcorremailwphonecnt1m < 2, 0, aa_rc032_1);

aa_rc027 := if(txinqcorremailwphonecnt3m < 2, 0, aa_rc027_1);

aa_rc051 := if(txinqcorremailwphonecnt1y < 3, 0, aa_rc051_1);

aa_rc023 := if(txinqcorremailwphonecnt < 10, 0, aa_rc023_1);

aa_rc041 := if(txinqcorremailwnamecnt1y < 2, 0, aa_rc041_1);

aa_rc050 := if(txinqcorremailwaddresscnt6m < 2, 0, aa_rc050_1);

aa_rc053 := if(txinqcorremailwaddresscnt < 2, 0, aa_rc053_1);

aa_rc001 := if(emailperphoneintxinqcnt3m < 2, 0, aa_rc001_1);

aa_rc014 := if(emailperphoneintxinqcnt6m < 2, 0, aa_rc014_1);

aa_rc045 := if(emailperphoneintxinqcnt1y < 2, 0, aa_rc045_1);

aa_rc033 := if(emailperphoneintxinqcnt < 2, 0, aa_rc033_1);

aa_rc009 := if(exactidperemailintxinqcnt1m < 2, 0, aa_rc009_1);

aa_rc044 := if(exactidperemailintxinqcnt3m < 3, 0, aa_rc044_1);

aa_rc046 := if(exactidperemailintxinqcnt6m < 4, 0, aa_rc046_1);

aa_rc047 := if(exactidperemailintxinqcnt < 15, 0, aa_rc047_1);

aa_rc034 := if(dnsipperemailintxinqcnt < 3, 0, aa_rc034_1);

aa_rc036 := if(trueipperemailintxinqcnt < 16, 0, aa_rc036_1);

aa_rc056 := if(proxyipgperemailintxinqcnt < 2, 0, aa_rc056_1);

aa_rc040 := if(proxyipperemailintxinqcnt < 2, 0, aa_rc040_1);

aa_rc039 := if(phoneperemailintxinqcnt1m < 2, 0, aa_rc039_1);

aa_rc030 := if(phoneperemailintxinqcnt3m < 2, 0, aa_rc030_1);

aa_rc020 := if(phoneperemailintxinqcnt1y < 2, 0, aa_rc020_1);

aa_rc008 := if(smartidperemailintxinqcnt1m < 2, 0, aa_rc008_1);

aa_rc019 := if(smartidperemailintxinqcnt3m < 2, 0, aa_rc019_1);

aa_rc054 := if(smartidperemailintxinqcnt1y < 4, 0, aa_rc054_1);

aa_rc042 := if(smartidperemailintxinqcnt < 10, 0, aa_rc042_1);

aa_rc003 := if(smartidperphoneintxinqcnt1m < 2, 0, aa_rc003_1);

aa_rc028 := if(smartidperphoneintxinqcnt1y < 3, 0, aa_rc028_1);

aa_rc024 := if(tmxidperemailintxinqcnt1m < 2, 0, aa_rc024_1);

aa_rc052 := if(tmxidperemailintxinqcnt1y < 4, 0, aa_rc052_1);

aa_rc049 := if(tmxidperemailintxinqcnt < 5, 0, aa_rc049_1);

aa_rc004 := if(tmxidperphoneintxinqcnt3m < 2, 0, aa_rc004_1);

aa_rc031 := if(tmxidperphoneintxinqcnt1y < 2, 0, aa_rc031_1);

aa_rc016 := if(txinqwaddrfirst_dayssince > 180 or txinqwaddrfirst_dayssince < 1, 0, aa_rc016_1);

aa_rc025 := if(txinqwaddrlast_dayssince > 60 or txinqwaddrlast_dayssince < 0, 0, aa_rc025_1);

aa_rc002 := if(txinqwemailfirst_dayssince > 132 or txinqwemailfirst_dayssince < 1, 0, aa_rc002_1);

aa_rc029 := if(txinqwemaillast_dayssince > 30 or txinqwemaillast_dayssince < 0, 0, aa_rc029_1);

aa_rc013 := if(txinqwnamefirst_dayssince > 60 or txinqwnamefirst_dayssince < 1, 0, aa_rc013_1);

aa_rc026 := if(txinqwnamelast_dayssince > 7 or txinqwnamelast_dayssince < 1, 0, aa_rc026_1);

aa_rc005 := if(txinqwphonefirst_dayssince > 180 or txinqwphonefirst_dayssince < 1, 0, aa_rc005_1);

aa_rc022 := if(txinqwphonelast_dayssince > 60 or txinqwphonelast_dayssince < 0, 0, aa_rc022_1);

aa_rc035 := if(txinqwtmxidfirst_dayssince > 30 or txinqwtmxidfirst_dayssince < 1, 0, aa_rc035_1);

aa_rc006 := if(timebtwtxinqwemailavg > 8400 or timebtwtxinqwemailavg < 14, 0, aa_rc006_1);

aa_rc012 := if(timebtwtxinqwphoneavg > 38000 or timebtwtxinqwphoneavg < 14, 0, aa_rc012_1);

aa_rc055 := if(browserhashperemailintxinqcnt < 4, 0, aa_rc055_1);

aa_rc038 := if(browserhashperphoneintxinqcnt < 3, 0, aa_rc038_1);

aa_rc007 := if(distbtwtrueipwphoneavg < 68, 0, aa_rc007_1);

aa_rc018 := if(txinqwemailcnt6m < 6, 0, aa_rc018_1);

aa_rc010 := if(txinqwphonecnt1y < 2, 0, aa_rc010_1);

aa_rc021 := if(exactidperphoneintxinqcnt3m < 2, 0, aa_rc021_1);

aa_rc037 := if(exactidpertmxidintxinqcnt < 3, 0, aa_rc037_1);

aa_rc017 := if(trueipperphoneintxinqcnt < 2, 0, aa_rc017_1);

aa_rc048 := if(trueippertmxidintxinqcnt1m < 2, 0, aa_rc048_1);

aa_rc015 := if(loginidperphoneintxinqcnt < 2, 0, aa_rc015_1);

aa_rc043 := if(orgidperemailintxinqcnt < 5, 0, aa_rc043_1);

wccat_corremailphone := if(max(aa_rc032, aa_rc027, aa_rc051, aa_rc023) = NULL, NULL, sum(if(aa_rc032 = NULL, 0, aa_rc032), if(aa_rc027 = NULL, 0, aa_rc027), if(aa_rc051 = NULL, 0, aa_rc051), if(aa_rc023 = NULL, 0, aa_rc023)));

wccat_corremailname := if(max(aa_rc041) = NULL, NULL, sum(if(aa_rc041 = NULL, 0, aa_rc041)));

wccat_corremailaddr := if(max(aa_rc050, aa_rc053) = NULL, NULL, sum(if(aa_rc050 = NULL, 0, aa_rc050), if(aa_rc053 = NULL, 0, aa_rc053)));

wccat_emailperphone := if(max(aa_rc001, aa_rc014, aa_rc045, aa_rc033) = NULL, NULL, sum(if(aa_rc001 = NULL, 0, aa_rc001), if(aa_rc014 = NULL, 0, aa_rc014), if(aa_rc045 = NULL, 0, aa_rc045), if(aa_rc033 = NULL, 0, aa_rc033)));

wccat_deviceperemail := if(max(aa_rc009, aa_rc044, aa_rc046, aa_rc047, aa_rc008, aa_rc019, aa_rc054, aa_rc042) = NULL, NULL, sum(if(aa_rc009 = NULL, 0, aa_rc009), if(aa_rc044 = NULL, 0, aa_rc044), if(aa_rc046 = NULL, 0, aa_rc046), if(aa_rc047 = NULL, 0, aa_rc047), if(aa_rc008 = NULL, 0, aa_rc008), if(aa_rc019 = NULL, 0, aa_rc019), if(aa_rc054 = NULL, 0, aa_rc054), if(aa_rc042 = NULL, 0, aa_rc042)));

wccat_ipperemail := if(max(aa_rc034, aa_rc036, aa_rc056, aa_rc040) = NULL, NULL, sum(if(aa_rc034 = NULL, 0, aa_rc034), if(aa_rc036 = NULL, 0, aa_rc036), if(aa_rc056 = NULL, 0, aa_rc056), if(aa_rc040 = NULL, 0, aa_rc040)));

wccat_phoneperemail := if(max(aa_rc039, aa_rc030, aa_rc020) = NULL, NULL, sum(if(aa_rc039 = NULL, 0, aa_rc039), if(aa_rc030 = NULL, 0, aa_rc030), if(aa_rc020 = NULL, 0, aa_rc020)));

wccat_deviceperphone := if(max(aa_rc003, aa_rc028, aa_rc021) = NULL, NULL, sum(if(aa_rc003 = NULL, 0, aa_rc003), if(aa_rc028 = NULL, 0, aa_rc028), if(aa_rc021 = NULL, 0, aa_rc021)));

wccat_tmxidperemail := if(max(aa_rc024, aa_rc052, aa_rc049) = NULL, NULL, sum(if(aa_rc024 = NULL, 0, aa_rc024), if(aa_rc052 = NULL, 0, aa_rc052), if(aa_rc049 = NULL, 0, aa_rc049)));

wccat_tmxidperphone := if(max(aa_rc004, aa_rc031) = NULL, NULL, sum(if(aa_rc004 = NULL, 0, aa_rc004), if(aa_rc031 = NULL, 0, aa_rc031)));

wccat_addrdayssincefirstseen := aa_rc016;

wccat_addrdayssincelastseen := aa_rc025;

wccat_emaildayssincefirstseen := aa_rc002;

wccat_emaildayssincelastseen := aa_rc029;

wccat_namedayssincefirstseen := aa_rc013;

wccat_namedayssincelastseen := aa_rc026;

wccat_phonedayssincefirstseen := aa_rc005;

wccat_phonedayssincelastseen := aa_rc022;

wccat_tmxiddayssincefirstseen := aa_rc035;

wccat_avgtimebetweentxwemail := aa_rc006;

wccat_avgtimebetweentxwphone := aa_rc012;

wccat_browserhashperemail := aa_rc055;

wccat_browserhashperphone := aa_rc038;

wccat_distbetweenipwphone := aa_rc007;

wccat_eventsperemail := aa_rc018;

wccat_eventsperphone := aa_rc010;

wccat_devicepertmxid := aa_rc037;

wccat_ipperphone := aa_rc017;

wccat_ippertmxid := aa_rc048;

wccat_loginidperphone := aa_rc015;

wccat_orgidperemail := aa_rc043;

wccat_fraudbyuser := if((Integer)any_fraudbyuser > 0, 1000, 0);

wccat_blacklist := if((Integer)any_blacklist > 0, 999, 0);

wccat_finalstatusreject := if((Integer)any_finstatus_reject > 0, 998, 0);

wc00_code := 'DI00';

wc00_catname := 'EventsPerPhone';

wc01_code := 'DI01';

wc01_catname := 'EmailPerPhone';

wc02_code := 'DI02';

wc02_catname := 'DevicePerPhone';

wc03_code := 'DI03';

wc03_catname := 'TMXIDPerPhone';

wc04_code := 'DI04';

wc04_catname := 'IPPerPhone';

wc05_code := 'DI05';

wc05_catname := 'BrowserHashPerPhone';

wc06_code := 'DI06';

wc06_catname := 'LoginIDPerPhone';

wc10_code := 'DI10';

wc10_catname := 'EventsPerEmail';

wc11_code := 'DI11';

wc11_catname := 'PhonePerEmail';

wc12_code := 'DI12';

wc12_catname := 'DevicePerEmail';

wc13_code := 'DI13';

wc13_catname := 'TMXIDPerEmail';

wc14_code := 'DI14';

wc14_catname := 'IPPerEmail';

wc15_code := 'DI15';

wc15_catname := 'BrowserHashPerEmail';

wc16_code := 'DI16';

wc16_catname := 'OrgIDPerEmail';

wc20_code := 'DI20';

wc20_catname := 'DevicePerTMXID';

wc21_code := 'DI21';

wc21_catname := 'IPPerTMXID';

wc30_code := 'DI30';

wc30_catname := 'CorroborationEmailPhone';

wc31_code := 'DI31';

wc31_catname := 'CorroborationEmailName';

wc32_code := 'DI32';

wc32_catname := 'CorroborationEmailAddr';

wc40_code := 'DI40';

wc40_catname := 'EmailDaysSinceFirstSeen';

wc41_code := 'DI41';

wc41_catname := 'EmailDaysSinceLastSeen';

wc42_code := 'DI42';

wc42_catname := 'PhoneDaysSinceFirstSeen';

wc43_code := 'DI43';

wc43_catname := 'PhoneDaysSinceLastSeen';

wc44_code := 'DI44';

wc44_catname := 'NameDaysSinceFirstSeen';

wc45_code := 'DI45';

wc45_catname := 'NameDaysSinceLastSeen';

wc46_code := 'DI46';

wc46_catname := 'AddrDaysSinceFirstSeen';

wc47_code := 'DI47';

wc47_catname := 'AddrDaysSinceLastSeen';

wc48_code := 'DI48';

wc48_catname := 'TMXIDDaysSinceFirstSeen';

wc50_code := 'DI50';

wc50_catname := 'AvgTimeBetweenTXwEmail';

wc51_code := 'DI51';

wc51_catname := 'AvgTimeBetweenTXwPhone';

wc60_code := 'DI60';

wc60_catname := 'DistBetweenIPwPhone';

wc97_code := 'DI97';

wc97_catname := 'FinalStatusReject';

wc98_code := 'DI98';

wc98_catname := 'BlackList';

wc99_code := 'DI99';

wc99_catname := 'FraudByUser';

//*************************************************************************************//

ds_layout := {STRING wc, STRING catname, REAL value};

rc_dataset := DATASET([
    {WC00_Code, WC00_CatName, WCCat_EventsPerPhone},
    {WC01_Code, WC01_CatName, WCCat_EmailPerPhone},
    {WC02_Code, WC02_CatName, WCCat_DevicePerPhone},
    {WC03_Code, WC03_CatName, WCCat_TMXIDPerPhone},
    {WC04_Code, WC04_CatName, WCCat_IPPerPhone},
    {WC05_Code, WC05_CatName, WCCat_BrowserHashPerPhone},
    {WC06_Code, WC06_CatName, WCCat_LoginIDPerPhone},
    {WC10_Code, WC10_CatName, WCCat_EventsPerEmail},
    {WC11_Code, WC11_CatName, WCCat_PhonePerEmail},
    {WC12_Code, WC12_CatName, WCCat_DevicePerEmail},
    {WC13_Code, WC13_CatName, WCCat_TMXIDPerEmail},
    {WC14_Code, WC14_CatName, WCCat_IPPerEmail},
    {WC15_Code, WC15_CatName, WCCat_BrowserHashPerEmail},
    {WC16_Code, WC16_CatName, WCCat_OrgIDPerEmail},
    {WC20_Code, WC20_CatName, WCCat_DevicePerTMXID},
    {WC21_Code, WC21_CatName, WCCat_IPPerTMXID},
    {WC30_Code, WC30_CatName, WCCat_CorrEmailPhone},
    {WC31_Code, WC31_CatName, WCCat_CorrEmailName},
    {WC32_Code, WC32_CatName, WCCat_CorrEmailAddr},
    {WC40_Code, WC40_CatName, WCCat_EmailDaysSinceFirstSeen},
    {WC41_Code, WC41_CatName, WCCat_EmailDaysSinceLastSeen},
    {WC42_Code, WC42_CatName, WCCat_PhoneDaysSinceFirstSeen},
    {WC43_Code, WC43_CatName, WCCat_PhoneDaysSinceLastSeen},
    {WC44_Code, WC44_CatName, WCCat_NameDaysSinceFirstSeen},
    {WC45_Code, WC45_CatName, WCCat_NameDaysSinceLastSeen},
    {WC46_Code, WC46_CatName, WCCat_AddrDaysSinceFirstSeen},
    {WC47_Code, WC47_CatName, WCCat_AddrDaysSinceLastSeen},
    {WC48_Code, WC48_CatName, WCCat_TMXIDDaysSinceFirstSeen},
    {WC50_Code, WC50_CatName, WCCat_AvgTimeBetweenTXwEmail},
    {WC51_Code, WC51_CatName, WCCat_AvgTimeBetweenTXwPhone},
    {WC60_Code, WC60_CatName, WCCat_DistBetweenIPwPhone},
    {WC97_Code, WC97_CatName, WCCat_FinalStatusReject},
    {WC98_Code, WC98_CatName, WCCat_BlackList},
    {WC99_Code, WC99_CatName, WCCat_FraudByUser}
    ], ds_layout);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue > 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_sorted := sort(rc_dataset(rc_dataset.value > 0), -rc_dataset.value);

WC1_1 := rc_dataset_sorted[1].wc;
WC2 := rc_dataset_sorted[2].wc;
WC3 := rc_dataset_sorted[3].wc;
WC4 := rc_dataset_sorted[4].wc;
WC5 := rc_dataset_sorted[5].wc;
WC6 := rc_dataset_sorted[6].wc;

WC_OutPts1 := rc_dataset_sorted[1].value;
WC_OutPts2 := rc_dataset_sorted[2].value;
WC_OutPts3 := rc_dataset_sorted[3].value;
WC_OutPts4 := rc_dataset_sorted[4].value;
WC_OutPts5 := rc_dataset_sorted[5].value;
WC_OutPts6 := rc_dataset_sorted[6].value;

WC_OutCatName1_1 := rc_dataset_sorted[1].catname;
WC_OutCatName2 := rc_dataset_sorted[2].catname;
WC_OutCatName3 := rc_dataset_sorted[3].catname;
WC_OutCatName4 := rc_dataset_sorted[4].catname;
WC_OutCatName5 := rc_dataset_sorted[5].catname;
WC_OutCatName6 := rc_dataset_sorted[6].catname;
//*************************************************************************************//

wc1 := if(gbm_mod10 <= 760 and trim(trim(wc1_1, LEFT), LEFT, RIGHT) = '', 'DI90', wc1_1);

wc_outcatname1 := if(gbm_mod10 <= 760 and trim(trim(wc1_1, LEFT), LEFT, RIGHT) = '', 'NoDigitalHistory', wc_outcatname1_1);

di31906 := gbm_mod10;

Final_reasons1 := Dataset([{wc1, ''},
                           {wc2, ''},
                           {wc3, ''},
                           {wc4, ''},
                           {wc5, ''},
                           {wc6, ''}], risk_indicators.Layout_Desc);

Final_reasons := Final_reasons1(hri != '');

//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(DEBUG)
		/* Model Input Variables */
  self.seq                              := le.seq;
  self.today                            := (String)today;
  self.processing_yr                    := (String)processing_yr;
  self.processing_mo                    := (String)processing_mo;
  self.processing_dy                    := (String)processing_dy;
  self.processing_mdy                   := (String)processing_mdy;
  self.blacklist_sum2                   := blacklist_sum2;
  self.any_blacklist                    := any_blacklist;
  self.finstatus_reject_sum             := finstatus_reject_sum;
  self.any_finstatus_reject             := any_finstatus_reject;
  self.fraudbyuser_sum                  := fraudbyuser_sum;
  self.any_fraudbyuser                  := any_fraudbyuser;
  self.smartidperemailintxinqcnt        := smartidperemailintxinqcnt;
  self.smartidperemailintxinqcnt1y      := smartidperemailintxinqcnt1y;
  self.smartidperemailintxinqcnt3m      := smartidperemailintxinqcnt3m;
  self.smartidperemailintxinqcnt1m      := smartidperemailintxinqcnt1m;
  self.smartidperphoneintxinqcnt1y      := smartidperphoneintxinqcnt1y;
  self.smartidperphoneintxinqcnt1m      := smartidperphoneintxinqcnt1m;
  self.exactidperemailintxinqcnt        := exactidperemailintxinqcnt;
  self.exactidperemailintxinqcnt6m      := exactidperemailintxinqcnt6m;
  self.exactidperemailintxinqcnt3m      := exactidperemailintxinqcnt3m;
  self.exactidperemailintxinqcnt1m      := exactidperemailintxinqcnt1m;
  self.exactidperphoneintxinqcnt3m      := exactidperphoneintxinqcnt3m;
  self.emailperphoneintxinqcnt          := emailperphoneintxinqcnt;
  self.emailperphoneintxinqcnt1y        := emailperphoneintxinqcnt1y;
  self.emailperphoneintxinqcnt3m        := emailperphoneintxinqcnt3m;
  self.emailperphoneintxinqcnt6m        := emailperphoneintxinqcnt6m;
  self.phoneperemailintxinqcnt1y        := phoneperemailintxinqcnt1y;
  self.phoneperemailintxinqcnt1m        := phoneperemailintxinqcnt1m;
  self.phoneperemailintxinqcnt3m        := phoneperemailintxinqcnt3m;
  self.tmxidperemailintxinqcnt          := tmxidperemailintxinqcnt;
  self.tmxidperemailintxinqcnt1y        := tmxidperemailintxinqcnt1y;
  self.tmxidperemailintxinqcnt1m        := tmxidperemailintxinqcnt1m;
  self.tmxidperphoneintxinqcnt1y        := tmxidperphoneintxinqcnt1y;
  self.tmxidperphoneintxinqcnt3m        := tmxidperphoneintxinqcnt3m;
  self.orgidperemailintxinqcnt          := orgidperemailintxinqcnt;
  self.trueipperemailintxinqcnt         := trueipperemailintxinqcnt;
  self.trueipperphoneintxinqcnt         := trueipperphoneintxinqcnt;
  self.dnsipperemailintxinqcnt          := dnsipperemailintxinqcnt;
  self.proxyipperemailintxinqcnt        := proxyipperemailintxinqcnt;
  self.proxyipgperemailintxinqcnt       := proxyipgperemailintxinqcnt;
  self.browserhashperemailintxinqcnt    := browserhashperemailintxinqcnt;
  self.browserhashperphoneintxinqcnt    := browserhashperphoneintxinqcnt;
  self.loginidperphoneintxinqcnt        := loginidperphoneintxinqcnt;
  self.txinqcorremailwphonecnt          := txinqcorremailwphonecnt;
  self.txinqcorremailwphonecnt1y        := txinqcorremailwphonecnt1y;
  self.txinqcorremailwphonecnt3m        := txinqcorremailwphonecnt3m;
  self.txinqcorremailwphonecnt1m        := txinqcorremailwphonecnt1m;
  self.txinqwemailcnt6m                 := txinqwemailcnt6m;
  self.txinqwphonecnt1y                 := txinqwphonecnt1y;
  self.txinqcorremailwaddresscnt        := txinqcorremailwaddresscnt;
  self.txinqcorremailwaddresscnt6m      := txinqcorremailwaddresscnt6m;
  self.txinqcorremailwnamecnt1y         := txinqcorremailwnamecnt1y;
  self.distbtwtrueipwemailavg           := distbtwtrueipwemailavg;
  self.distbtwtrueipwphoneavg           := distbtwtrueipwphoneavg;
  self.timebtwtxinqwemailavg            := timebtwtxinqwemailavg;
  self.timebtwtxinqwphoneavg            := timebtwtxinqwphoneavg;
  self.trueippertmxidintxinqcnt1m       := trueippertmxidintxinqcnt1m;
  self.exactidpertmxidintxinqcnt        := exactidpertmxidintxinqcnt;
  self.txinqwaddrfirst_dayssince        := txinqwaddrfirst_dayssince;
  self.txinqwaddrlast_dayssince         := txinqwaddrlast_dayssince;
  self.txinqwemailfirst_dayssince       := txinqwemailfirst_dayssince;
  self.txinqwemaillast_dayssince        := txinqwemaillast_dayssince;
  self.txinqwnamefirst_dayssince        := txinqwnamefirst_dayssince;
  self.txinqwnamelast_dayssince         := txinqwnamelast_dayssince;
  self.txinqwphonefirst_dayssince       := txinqwphonefirst_dayssince;
  self.txinqwphonelast_dayssince        := txinqwphonelast_dayssince;
  self.txinqwtmxidfirst_dayssince       := txinqwtmxidfirst_dayssince;
  self.gbm10_wc_lgt_0                   := gbm10_wc_lgt_0;
  self.rc004_1_9                        := rc004_1_9;
  self.gbm10_wc_lgt_1                   := gbm10_wc_lgt_1;
  self.rc008_1_4                        := rc008_1_4;
  self.rc003_1_2                        := rc003_1_2;
  self.rc001_1_1                        := rc001_1_1;
  self.rc001_2_9                        := rc001_2_9;
  self.rc003_2_2                        := rc003_2_2;
  self.gbm10_wc_lgt_2                   := gbm10_wc_lgt_2;
  self.rc004_2_1                        := rc004_2_1;
  self.rc002_2_4                        := rc002_2_4;
  self.rc002_3_6                        := rc002_3_6;
  self.rc009_3_1                        := rc009_3_1;
  self.gbm10_wc_lgt_3                   := gbm10_wc_lgt_3;
  self.rc010_3_2                        := rc010_3_2;
  self.rc019_3_8                        := rc019_3_8;
  self.rc004_4_9                        := rc004_4_9;
  self.rc034_4_4                        := rc034_4_4;
  self.gbm10_wc_lgt_4                   := gbm10_wc_lgt_4;
  self.rc006_4_1                        := rc006_4_1;
  self.rc009_4_2                        := rc009_4_2;
  self.rc004_5_1                        := rc004_5_1;
  self.rc015_5_5                        := rc015_5_5;
  self.gbm10_wc_lgt_5                   := gbm10_wc_lgt_5;
  self.rc014_5_2                        := rc014_5_2;
  self.rc005_5_4                        := rc005_5_4;
  self.rc001_6_2                        := rc001_6_2;
  self.gbm10_wc_lgt_6                   := gbm10_wc_lgt_6;
  self.rc010_6_1                        := rc010_6_1;
  self.rc012_6_3                        := rc012_6_3;
  self.rc028_6_9                        := rc028_6_9;
  self.rc001_7_3                        := rc001_7_3;
  self.gbm10_wc_lgt_7                   := gbm10_wc_lgt_7;
  self.rc028_7_5                        := rc028_7_5;
  self.rc009_7_2                        := rc009_7_2;
  self.rc030_7_1                        := rc030_7_1;
  self.gbm10_wc_lgt_8                   := gbm10_wc_lgt_8;
  self.rc020_8_6                        := rc020_8_6;
  self.rc003_8_10                       := rc003_8_10;
  self.rc006_8_1                        := rc006_8_1;
  self.rc009_8_2                        := rc009_8_2;
  self.rc027_9_7                        := rc027_9_7;
  self.rc002_9_6                        := rc002_9_6;
  self.rc019_9_2                        := rc019_9_2;
  self.gbm10_wc_lgt_9                   := gbm10_wc_lgt_9;
  self.rc030_9_1                        := rc030_9_1;
  self.rc014_10_2                       := rc014_10_2;
  self.rc013_10_6                       := rc013_10_6;
  self.rc011_10_8                       := rc011_10_8;
  self.gbm10_wc_lgt_10                  := gbm10_wc_lgt_10;
  self.rc001_10_1                       := rc001_10_1;
  self.rc012_11_7                       := rc012_11_7;
  self.rc010_11_2                       := rc010_11_2;
  self.rc021_11_1                       := rc021_11_1;
  self.gbm10_wc_lgt_11                  := gbm10_wc_lgt_11;
  self.rc037_11_3                       := rc037_11_3;
  self.gbm10_wc_lgt_12                  := gbm10_wc_lgt_12;
  self.rc011_12_4                       := rc011_12_4;
  self.rc018_12_1                       := rc018_12_1;
  self.rc013_12_7                       := rc013_12_7;
  self.rc001_12_2                       := rc001_12_2;
  self.rc009_13_3                       := rc009_13_3;
  self.rc008_13_1                       := rc008_13_1;
  self.rc003_13_9                       := rc003_13_9;
  self.gbm10_wc_lgt_13                  := gbm10_wc_lgt_13;
  self.rc020_13_2                       := rc020_13_2;
  self.rc045_14_1                       := rc045_14_1;
  self.rc008_14_8                       := rc008_14_8;
  self.rc008_14_3                       := rc008_14_3;
  self.gbm10_wc_lgt_14                  := gbm10_wc_lgt_14;
  self.rc012_14_2                       := rc012_14_2;
  self.rc015_15_7                       := rc015_15_7;
  self.rc004_15_1                       := rc004_15_1;
  self.rc017_15_5                       := rc017_15_5;
  self.gbm10_wc_lgt_15                  := gbm10_wc_lgt_15;
  self.rc007_15_3                       := rc007_15_3;
  self.rc037_16_1                       := rc037_16_1;
  self.rc006_16_7                       := rc006_16_7;
  self.rc005_16_6                       := rc005_16_6;
  self.gbm10_wc_lgt_16                  := gbm10_wc_lgt_16;
  self.rc010_16_4                       := rc010_16_4;
  self.gbm10_wc_lgt_17                  := gbm10_wc_lgt_17;
  self.rc004_17_1                       := rc004_17_1;
  self.rc024_17_4                       := rc024_17_4;
  self.rc008_17_8                       := rc008_17_8;
  self.rc027_17_3                       := rc027_17_3;
  self.rc021_18_4                       := rc021_18_4;
  self.rc001_18_1                       := rc001_18_1;
  self.rc013_18_9                       := rc013_18_9;
  self.gbm10_wc_lgt_18                  := gbm10_wc_lgt_18;
  self.rc014_18_2                       := rc014_18_2;
  self.gbm10_wc_lgt_19                  := gbm10_wc_lgt_19;
  self.rc018_19_1                       := rc018_19_1;
  self.rc002_19_7                       := rc002_19_7;
  self.rc011_19_3                       := rc011_19_3;
  self.rc007_19_5                       := rc007_19_5;
  self.rc029_20_4                       := rc029_20_4;
  self.gbm10_wc_lgt_20                  := gbm10_wc_lgt_20;
  self.rc002_20_3                       := rc002_20_3;
  self.rc020_20_1                       := rc020_20_1;
  self.rc029_20_6                       := rc029_20_6;
  self.rc024_21_7                       := rc024_21_7;
  self.rc002_21_9                       := rc002_21_9;
  self.rc045_21_1                       := rc045_21_1;
  self.gbm10_wc_lgt_21                  := gbm10_wc_lgt_21;
  self.rc006_21_2                       := rc006_21_2;
  self.rc001_22_3                       := rc001_22_3;
  self.rc009_22_1                       := rc009_22_1;
  self.gbm10_wc_lgt_22                  := gbm10_wc_lgt_22;
  self.rc002_22_4                       := rc002_22_4;
  self.rc022_22_8                       := rc022_22_8;
  self.rc002_23_1                       := rc002_23_1;
  self.rc004_23_7                       := rc004_23_7;
  self.gbm10_wc_lgt_23                  := gbm10_wc_lgt_23;
  self.rc052_23_2                       := rc052_23_2;
  self.rc005_23_9                       := rc005_23_9;
  self.gbm10_wc_lgt_24                  := gbm10_wc_lgt_24;
  self.rc005_24_3                       := rc005_24_3;
  self.rc015_24_1                       := rc015_24_1;
  self.rc033_24_6                       := rc033_24_6;
  self.rc002_24_4                       := rc002_24_4;
  self.gbm10_wc_lgt_25                  := gbm10_wc_lgt_25;
  self.rc036_25_5                       := rc036_25_5;
  self.rc027_25_4                       := rc027_25_4;
  self.rc021_25_1                       := rc021_25_1;
  self.rc003_25_2                       := rc003_25_2;
  self.rc003_26_6                       := rc003_26_6;
  self.gbm10_wc_lgt_26                  := gbm10_wc_lgt_26;
  self.rc008_26_2                       := rc008_26_2;
  self.rc008_26_1                       := rc008_26_1;
  self.rc018_26_8                       := rc018_26_8;
  self.rc014_27_2                       := rc014_27_2;
  self.rc001_27_1                       := rc001_27_1;
  self.rc007_27_5                       := rc007_27_5;
  self.gbm10_wc_lgt_27                  := gbm10_wc_lgt_27;
  self.rc026_27_4                       := rc026_27_4;
  self.gbm10_wc_lgt_28                  := gbm10_wc_lgt_28;
  self.rc001_28_10                      := rc001_28_10;
  self.rc037_28_1                       := rc037_28_1;
  self.rc016_28_6                       := rc016_28_6;
  self.rc015_28_2                       := rc015_28_2;
  self.rc020_29_10                      := rc020_29_10;
  self.rc038_29_1                       := rc038_29_1;
  self.rc017_29_2                       := rc017_29_2;
  self.gbm10_wc_lgt_29                  := gbm10_wc_lgt_29;
  self.rc002_29_4                       := rc002_29_4;
  self.rc002_30_1                       := rc002_30_1;
  self.rc015_30_3                       := rc015_30_3;
  self.gbm10_wc_lgt_30                  := gbm10_wc_lgt_30;
  self.rc052_30_2                       := rc052_30_2;
  self.rc021_30_4                       := rc021_30_4;
  self.rc033_31_2                       := rc033_31_2;
  self.rc024_31_1                       := rc024_31_1;
  self.gbm10_wc_lgt_31                  := gbm10_wc_lgt_31;
  self.rc016_31_6                       := rc016_31_6;
  self.rc020_31_5                       := rc020_31_5;
  self.rc037_32_3                       := rc037_32_3;
  self.rc023_32_6                       := rc023_32_6;
  self.rc005_32_7                       := rc005_32_7;
  self.rc033_32_1                       := rc033_32_1;
  self.gbm10_wc_lgt_32                  := gbm10_wc_lgt_32;
  self.rc022_33_4                       := rc022_33_4;
  self.rc016_33_9                       := rc016_33_9;
  self.gbm10_wc_lgt_33                  := gbm10_wc_lgt_33;
  self.rc011_33_3                       := rc011_33_3;
  self.rc001_33_1                       := rc001_33_1;
  self.gbm10_wc_lgt_34                  := gbm10_wc_lgt_34;
  self.rc007_34_3                       := rc007_34_3;
  self.rc002_34_9                       := rc002_34_9;
  self.rc030_34_1                       := rc030_34_1;
  self.rc002_34_4                       := rc002_34_4;
  self.rc008_35_2                       := rc008_35_2;
  self.gbm10_wc_lgt_35                  := gbm10_wc_lgt_35;
  self.rc008_35_1                       := rc008_35_1;
  self.rc003_35_6                       := rc003_35_6;
  self.rc003_35_8                       := rc003_35_8;
  self.rc036_36_4                       := rc036_36_4;
  self.rc038_36_1                       := rc038_36_1;
  self.gbm10_wc_lgt_36                  := gbm10_wc_lgt_36;
  self.rc002_36_5                       := rc002_36_5;
  self.rc032_36_2                       := rc032_36_2;
  self.rc002_37_5                       := rc002_37_5;
  self.rc023_37_2                       := rc023_37_2;
  self.gbm10_wc_lgt_37                  := gbm10_wc_lgt_37;
  self.rc022_37_1                       := rc022_37_1;
  self.rc039_37_3                       := rc039_37_3;
  self.rc006_38_7                       := rc006_38_7;
  self.rc035_38_3                       := rc035_38_3;
  self.rc001_38_1                       := rc001_38_1;
  self.gbm10_wc_lgt_38                  := gbm10_wc_lgt_38;
  self.rc005_38_6                       := rc005_38_6;
  self.rc025_39_3                       := rc025_39_3;
  self.gbm10_wc_lgt_39                  := gbm10_wc_lgt_39;
  self.rc002_39_4                       := rc002_39_4;
  self.rc011_39_9                       := rc011_39_9;
  self.rc018_39_1                       := rc018_39_1;
  self.rc007_40_4                       := rc007_40_4;
  self.gbm10_wc_lgt_40                  := gbm10_wc_lgt_40;
  self.rc002_40_1                       := rc002_40_1;
  self.rc042_40_6                       := rc042_40_6;
  self.rc046_40_2                       := rc046_40_2;
  self.gbm10_wc_lgt_41                  := gbm10_wc_lgt_41;
  self.rc002_41_4                       := rc002_41_4;
  self.rc015_41_1                       := rc015_41_1;
  self.rc005_41_3                       := rc005_41_3;
  self.rc012_41_5                       := rc012_41_5;
  self.rc017_42_3                       := rc017_42_3;
  self.rc001_42_10                      := rc001_42_10;
  self.rc035_42_1                       := rc035_42_1;
  self.rc015_42_2                       := rc015_42_2;
  self.gbm10_wc_lgt_42                  := gbm10_wc_lgt_42;
  self.rc003_43_1                       := rc003_43_1;
  self.rc006_43_3                       := rc006_43_3;
  self.rc008_43_4                       := rc008_43_4;
  self.gbm10_wc_lgt_43                  := gbm10_wc_lgt_43;
  self.rc023_43_8                       := rc023_43_8;
  self.gbm10_wc_lgt_44                  := gbm10_wc_lgt_44;
  self.rc001_44_2                       := rc001_44_2;
  self.rc031_44_1                       := rc031_44_1;
  self.rc026_44_9                       := rc026_44_9;
  self.rc002_44_6                       := rc002_44_6;
  self.rc007_45_5                       := rc007_45_5;
  self.gbm10_wc_lgt_45                  := gbm10_wc_lgt_45;
  self.rc004_45_1                       := rc004_45_1;
  self.rc007_45_3                       := rc007_45_3;
  self.rc017_45_7                       := rc017_45_7;
  self.rc036_46_4                       := rc036_46_4;
  self.rc051_46_3                       := rc051_46_3;
  self.rc029_46_1                       := rc029_46_1;
  self.gbm10_wc_lgt_46                  := gbm10_wc_lgt_46;
  self.rc002_46_2                       := rc002_46_2;
  self.rc005_47_2                       := rc005_47_2;
  self.rc003_47_4                       := rc003_47_4;
  self.rc012_47_1                       := rc012_47_1;
  self.gbm10_wc_lgt_47                  := gbm10_wc_lgt_47;
  self.rc032_47_3                       := rc032_47_3;
  self.rc017_48_8                       := rc017_48_8;
  self.gbm10_wc_lgt_48                  := gbm10_wc_lgt_48;
  self.rc047_48_3                       := rc047_48_3;
  self.rc033_48_1                       := rc033_48_1;
  self.rc030_48_2                       := rc030_48_2;
  self.rc011_49_6                       := rc011_49_6;
  self.rc003_49_1                       := rc003_49_1;
  self.rc016_49_3                       := rc016_49_3;
  self.rc026_49_9                       := rc026_49_9;
  self.gbm10_wc_lgt_49                  := gbm10_wc_lgt_49;
  self.rc033_50_1                       := rc033_50_1;
  self.gbm10_wc_lgt_50                  := gbm10_wc_lgt_50;
  self.rc005_50_3                       := rc005_50_3;
  self.rc005_50_7                       := rc005_50_7;
  self.rc011_50_5                       := rc011_50_5;
  self.rc002_51_9                       := rc002_51_9;
  self.rc049_51_5                       := rc049_51_5;
  self.gbm10_wc_lgt_51                  := gbm10_wc_lgt_51;
  self.rc038_51_1                       := rc038_51_1;
  self.rc012_51_2                       := rc012_51_2;
  self.rc001_52_1                       := rc001_52_1;
  self.rc031_52_3                       := rc031_52_3;
  self.rc046_52_6                       := rc046_52_6;
  self.rc004_52_5                       := rc004_52_5;
  self.gbm10_wc_lgt_52                  := gbm10_wc_lgt_52;
  self.rc003_53_1                       := rc003_53_1;
  self.rc013_53_9                       := rc013_53_9;
  self.rc038_53_4                       := rc038_53_4;
  self.gbm10_wc_lgt_53                  := gbm10_wc_lgt_53;
  self.rc019_53_3                       := rc019_53_3;
  self.rc017_54_4                       := rc017_54_4;
  self.rc005_54_2                       := rc005_54_2;
  self.rc002_54_1                       := rc002_54_1;
  self.gbm10_wc_lgt_54                  := gbm10_wc_lgt_54;
  self.rc017_54_3                       := rc017_54_3;
  self.rc049_55_3                       := rc049_55_3;
  self.rc002_55_1                       := rc002_55_1;
  self.gbm10_wc_lgt_55                  := gbm10_wc_lgt_55;
  self.rc018_55_2                       := rc018_55_2;
  self.rc024_55_5                       := rc024_55_5;
  self.rc006_56_2                       := rc006_56_2;
  self.rc029_56_1                       := rc029_56_1;
  self.gbm10_wc_lgt_56                  := gbm10_wc_lgt_56;
  self.rc010_56_3                       := rc010_56_3;
  self.rc027_56_5                       := rc027_56_5;
  self.rc005_57_6                       := rc005_57_6;
  self.gbm10_wc_lgt_57                  := gbm10_wc_lgt_57;
  self.rc003_57_1                       := rc003_57_1;
  self.rc006_57_3                       := rc006_57_3;
  self.rc023_57_5                       := rc023_57_5;
  self.gbm10_wc_lgt_58                  := gbm10_wc_lgt_58;
  self.rc002_58_5                       := rc002_58_5;
  self.rc032_58_1                       := rc032_58_1;
  self.rc011_58_4                       := rc011_58_4;
  self.rc007_58_3                       := rc007_58_3;
  self.gbm10_wc_lgt_59                  := gbm10_wc_lgt_59;
  self.rc044_59_3                       := rc044_59_3;
  self.rc049_59_1                       := rc049_59_1;
  self.rc044_59_4                       := rc044_59_4;
  self.rc011_59_6                       := rc011_59_6;
  self.rc007_60_6                       := rc007_60_6;
  self.rc004_60_1                       := rc004_60_1;
  self.rc007_60_4                       := rc007_60_4;
  self.rc004_60_2                       := rc004_60_2;
  self.gbm10_wc_lgt_60                  := gbm10_wc_lgt_60;
  self.rc041_61_4                       := rc041_61_4;
  self.rc032_61_1                       := rc032_61_1;
  self.rc007_61_5                       := rc007_61_5;
  self.rc032_61_2                       := rc032_61_2;
  self.gbm10_wc_lgt_61                  := gbm10_wc_lgt_61;
  self.rc005_62_3                       := rc005_62_3;
  self.rc009_62_8                       := rc009_62_8;
  self.rc033_62_1                       := rc033_62_1;
  self.rc037_62_5                       := rc037_62_5;
  self.gbm10_wc_lgt_62                  := gbm10_wc_lgt_62;
  self.gbm10_wc_lgt_63                  := gbm10_wc_lgt_63;
  self.rc029_63_3                       := rc029_63_3;
  self.rc012_63_5                       := rc012_63_5;
  self.rc001_63_1                       := rc001_63_1;
  self.rc002_63_7                       := rc002_63_7;
  self.gbm10_wc_lgt_64                  := gbm10_wc_lgt_64;
  self.rc002_64_4                       := rc002_64_4;
  self.rc003_64_1                       := rc003_64_1;
  self.rc037_64_3                       := rc037_64_3;
  self.rc042_64_6                       := rc042_64_6;
  self.rc009_65_1                       := rc009_65_1;
  self.rc031_65_5                       := rc031_65_5;
  self.rc007_65_4                       := rc007_65_4;
  self.rc045_65_2                       := rc045_65_2;
  self.gbm10_wc_lgt_65                  := gbm10_wc_lgt_65;
  self.rc019_66_3                       := rc019_66_3;
  self.rc001_66_1                       := rc001_66_1;
  self.gbm10_wc_lgt_66                  := gbm10_wc_lgt_66;
  self.rc018_66_4                       := rc018_66_4;
  self.rc021_66_8                       := rc021_66_8;
  self.rc032_67_3                       := rc032_67_3;
  self.rc012_67_1                       := rc012_67_1;
  self.gbm10_wc_lgt_67                  := gbm10_wc_lgt_67;
  self.rc005_67_2                       := rc005_67_2;
  self.rc003_67_4                       := rc003_67_4;
  self.gbm10_wc_lgt_68                  := gbm10_wc_lgt_68;
  self.rc001_68_1                       := rc001_68_1;
  self.rc005_68_7                       := rc005_68_7;
  self.rc013_68_5                       := rc013_68_5;
  self.rc010_68_3                       := rc010_68_3;
  self.rc055_69_3                       := rc055_69_3;
  self.rc043_69_6                       := rc043_69_6;
  self.gbm10_wc_lgt_69                  := gbm10_wc_lgt_69;
  self.rc040_69_4                       := rc040_69_4;
  self.rc003_69_1                       := rc003_69_1;
  self.rc035_70_1                       := rc035_70_1;
  self.rc016_70_4                       := rc016_70_4;
  self.rc044_70_2                       := rc044_70_2;
  self.gbm10_wc_lgt_70                  := gbm10_wc_lgt_70;
  self.rc011_70_5                       := rc011_70_5;
  self.rc001_71_2                       := rc001_71_2;
  self.rc031_71_1                       := rc031_71_1;
  self.rc008_71_4                       := rc008_71_4;
  self.gbm10_wc_lgt_71                  := gbm10_wc_lgt_71;
  self.rc007_71_9                       := rc007_71_9;
  self.gbm10_wc_lgt_72                  := gbm10_wc_lgt_72;
  self.rc032_72_4                       := rc032_72_4;
  self.rc039_72_3                       := rc039_72_3;
  self.rc011_72_2                       := rc011_72_2;
  self.rc002_72_1                       := rc002_72_1;
  self.gbm10_wc_lgt_73                  := gbm10_wc_lgt_73;
  self.rc014_73_9                       := rc014_73_9;
  self.rc047_73_1                       := rc047_73_1;
  self.rc008_73_2                       := rc008_73_2;
  self.rc025_73_6                       := rc025_73_6;
  self.rc036_74_5                       := rc036_74_5;
  self.rc020_74_1                       := rc020_74_1;
  self.rc003_74_9                       := rc003_74_9;
  self.rc013_74_3                       := rc013_74_3;
  self.gbm10_wc_lgt_74                  := gbm10_wc_lgt_74;
  self.rc034_75_4                       := rc034_75_4;
  self.rc021_75_2                       := rc021_75_2;
  self.rc019_75_9                       := rc019_75_9;
  self.rc015_75_1                       := rc015_75_1;
  self.gbm10_wc_lgt_75                  := gbm10_wc_lgt_75;
  self.gbm10_wc_lgt_76                  := gbm10_wc_lgt_76;
  self.rc041_76_6                       := rc041_76_6;
  self.rc017_76_2                       := rc017_76_2;
  self.rc038_76_1                       := rc038_76_1;
  self.rc015_76_9                       := rc015_76_9;
  self.rc032_77_1                       := rc032_77_1;
  self.rc032_77_2                       := rc032_77_2;
  self.rc007_77_9                       := rc007_77_9;
  self.gbm10_wc_lgt_77                  := gbm10_wc_lgt_77;
  self.rc038_77_4                       := rc038_77_4;
  self.rc006_78_3                       := rc006_78_3;
  self.gbm10_wc_lgt_78                  := gbm10_wc_lgt_78;
  self.rc023_78_8                       := rc023_78_8;
  self.rc008_78_4                       := rc008_78_4;
  self.rc003_78_1                       := rc003_78_1;
  self.gbm10_wc_lgt_79                  := gbm10_wc_lgt_79;
  self.rc041_79_3                       := rc041_79_3;
  self.rc012_79_9                       := rc012_79_9;
  self.rc003_79_1                       := rc003_79_1;
  self.rc026_79_4                       := rc026_79_4;
  self.rc029_80_7                       := rc029_80_7;
  self.gbm10_wc_lgt_80                  := gbm10_wc_lgt_80;
  self.rc006_80_5                       := rc006_80_5;
  self.rc018_80_1                       := rc018_80_1;
  self.rc007_80_3                       := rc007_80_3;
  self.rc030_81_1                       := rc030_81_1;
  self.rc039_81_4                       := rc039_81_4;
  self.gbm10_wc_lgt_81                  := gbm10_wc_lgt_81;
  self.rc030_81_2                       := rc030_81_2;
  self.rc004_81_10                      := rc004_81_10;
  self.gbm10_wc_lgt_82                  := gbm10_wc_lgt_82;
  self.rc018_82_7                       := rc018_82_7;
  self.rc050_82_4                       := rc050_82_4;
  self.rc046_82_1                       := rc046_82_1;
  self.rc006_82_3                       := rc006_82_3;
  self.rc034_83_5                       := rc034_83_5;
  self.rc006_83_3                       := rc006_83_3;
  self.gbm10_wc_lgt_83                  := gbm10_wc_lgt_83;
  self.rc021_83_1                       := rc021_83_1;
  self.rc006_83_6                       := rc006_83_6;
  self.gbm10_wc_lgt_84                  := gbm10_wc_lgt_84;
  self.rc038_84_5                       := rc038_84_5;
  self.rc015_84_1                       := rc015_84_1;
  self.rc006_84_4                       := rc006_84_4;
  self.rc010_84_2                       := rc010_84_2;
  self.gbm10_wc_lgt_85                  := gbm10_wc_lgt_85;
  self.rc003_85_1                       := rc003_85_1;
  self.rc029_85_6                       := rc029_85_6;
  self.rc006_85_8                       := rc006_85_8;
  self.rc016_85_3                       := rc016_85_3;
  self.rc025_86_5                       := rc025_86_5;
  self.gbm10_wc_lgt_86                  := gbm10_wc_lgt_86;
  self.rc006_86_8                       := rc006_86_8;
  self.rc002_86_4                       := rc002_86_4;
  self.rc033_86_1                       := rc033_86_1;
  self.rc049_87_1                       := rc049_87_1;
  self.rc011_87_8                       := rc011_87_8;
  self.rc017_87_3                       := rc017_87_3;
  self.rc027_87_4                       := rc027_87_4;
  self.gbm10_wc_lgt_87                  := gbm10_wc_lgt_87;
  self.rc040_88_6                       := rc040_88_6;
  self.rc024_88_1                       := rc024_88_1;
  self.gbm10_wc_lgt_88                  := gbm10_wc_lgt_88;
  self.rc023_88_4                       := rc023_88_4;
  self.rc048_88_3                       := rc048_88_3;
  self.rc031_89_3                       := rc031_89_3;
  self.gbm10_wc_lgt_89                  := gbm10_wc_lgt_89;
  self.rc001_89_1                       := rc001_89_1;
  self.rc008_89_8                       := rc008_89_8;
  self.rc017_89_4                       := rc017_89_4;
  self.rc033_90_3                       := rc033_90_3;
  self.rc008_90_1                       := rc008_90_1;
  self.rc005_90_5                       := rc005_90_5;
  self.rc003_90_4                       := rc003_90_4;
  self.gbm10_wc_lgt_90                  := gbm10_wc_lgt_90;
  self.rc039_91_2                       := rc039_91_2;
  self.gbm10_wc_lgt_91                  := gbm10_wc_lgt_91;
  self.rc020_91_3                       := rc020_91_3;
  self.rc002_91_1                       := rc002_91_1;
  self.rc012_91_7                       := rc012_91_7;
  self.rc012_92_6                       := rc012_92_6;
  self.rc002_92_5                       := rc002_92_5;
  self.gbm10_wc_lgt_92                  := gbm10_wc_lgt_92;
  self.rc011_92_1                       := rc011_92_1;
  self.rc002_92_3                       := rc002_92_3;
  self.rc025_93_1                       := rc025_93_1;
  self.rc003_93_2                       := rc003_93_2;
  self.rc005_93_4                       := rc005_93_4;
  self.gbm10_wc_lgt_93                  := gbm10_wc_lgt_93;
  self.rc047_93_9                       := rc047_93_9;
  self.rc001_94_1                       := rc001_94_1;
  self.gbm10_wc_lgt_94                  := gbm10_wc_lgt_94;
  self.rc014_94_5                       := rc014_94_5;
  self.rc005_94_7                       := rc005_94_7;
  self.rc024_94_2                       := rc024_94_2;
  self.rc048_95_3                       := rc048_95_3;
  self.rc040_95_2                       := rc040_95_2;
  self.gbm10_wc_lgt_95                  := gbm10_wc_lgt_95;
  self.rc048_95_1                       := rc048_95_1;
  self.rc005_95_5                       := rc005_95_5;
  self.rc053_96_6                       := rc053_96_6;
  self.rc032_96_2                       := rc032_96_2;
  self.rc032_96_1                       := rc032_96_1;
  self.rc002_96_7                       := rc002_96_7;
  self.gbm10_wc_lgt_96                  := gbm10_wc_lgt_96;
  self.rc005_97_4                       := rc005_97_4;
  self.rc022_97_5                       := rc022_97_5;
  self.rc032_97_1                       := rc032_97_1;
  self.gbm10_wc_lgt_97                  := gbm10_wc_lgt_97;
  self.rc003_97_2                       := rc003_97_2;
  self.gbm10_wc_lgt_98                  := gbm10_wc_lgt_98;
  self.rc042_98_4                       := rc042_98_4;
  self.rc032_98_1                       := rc032_98_1;
  self.rc002_98_8                       := rc002_98_8;
  self.rc007_98_3                       := rc007_98_3;
  self.rc011_99_6                       := rc011_99_6;
  self.rc021_99_1                       := rc021_99_1;
  self.rc010_99_2                       := rc010_99_2;
  self.rc020_99_4                       := rc020_99_4;
  self.gbm10_wc_lgt_99                  := gbm10_wc_lgt_99;
  self.gbm10_wc_lgt_100                 := gbm10_wc_lgt_100;
  self.rc031_100_1                      := rc031_100_1;
  self.rc005_100_7                      := rc005_100_7;
  self.rc011_100_5                      := rc011_100_5;
  self.rc013_100_3                      := rc013_100_3;
  self.rc006_101_8                      := rc006_101_8;
  self.rc003_101_1                      := rc003_101_1;
  self.rc031_101_4                      := rc031_101_4;
  self.gbm10_wc_lgt_101                 := gbm10_wc_lgt_101;
  self.rc038_101_3                      := rc038_101_3;
  self.rc001_102_1                      := rc001_102_1;
  self.rc012_102_3                      := rc012_102_3;
  self.rc003_102_5                      := rc003_102_5;
  self.gbm10_wc_lgt_102                 := gbm10_wc_lgt_102;
  self.rc013_102_7                      := rc013_102_7;
  self.rc019_103_10                     := rc019_103_10;
  self.rc003_103_3                      := rc003_103_3;
  self.rc006_103_5                      := rc006_103_5;
  self.gbm10_wc_lgt_103                 := gbm10_wc_lgt_103;
  self.rc012_103_1                      := rc012_103_1;
  self.rc026_104_9                      := rc026_104_9;
  self.rc043_104_5                      := rc043_104_5;
  self.gbm10_wc_lgt_104                 := gbm10_wc_lgt_104;
  self.rc003_104_1                      := rc003_104_1;
  self.rc016_104_3                      := rc016_104_3;
  self.rc046_105_1                      := rc046_105_1;
  self.rc002_105_4                      := rc002_105_4;
  self.rc012_105_6                      := rc012_105_6;
  self.rc033_105_3                      := rc033_105_3;
  self.gbm10_wc_lgt_105                 := gbm10_wc_lgt_105;
  self.rc005_106_3                      := rc005_106_3;
  self.rc012_106_5                      := rc012_106_5;
  self.rc015_106_1                      := rc015_106_1;
  self.gbm10_wc_lgt_106                 := gbm10_wc_lgt_106;
  self.rc018_106_4                      := rc018_106_4;
  self.rc035_107_6                      := rc035_107_6;
  self.rc001_107_1                      := rc001_107_1;
  self.rc016_107_9                      := rc016_107_9;
  self.gbm10_wc_lgt_107                 := gbm10_wc_lgt_107;
  self.rc028_107_2                      := rc028_107_2;
  self.rc022_108_2                      := rc022_108_2;
  self.rc011_108_7                      := rc011_108_7;
  self.rc050_108_4                      := rc050_108_4;
  self.rc029_108_1                      := rc029_108_1;
  self.gbm10_wc_lgt_108                 := gbm10_wc_lgt_108;
  self.gbm10_wc_lgt_109                 := gbm10_wc_lgt_109;
  self.rc054_109_1                      := rc054_109_1;
  self.rc020_109_8                      := rc020_109_8;
  self.rc017_109_3                      := rc017_109_3;
  self.rc005_109_2                      := rc005_109_2;
  self.gbm10_wc_lgt_110                 := gbm10_wc_lgt_110;
  self.rc015_110_3                      := rc015_110_3;
  self.rc030_110_1                      := rc030_110_1;
  self.rc043_110_2                      := rc043_110_2;
  self.rc006_110_5                      := rc006_110_5;
  self.gbm10_wc_lgt_111                 := gbm10_wc_lgt_111;
  self.rc032_111_2                      := rc032_111_2;
  self.rc023_111_4                      := rc023_111_4;
  self.rc041_111_1                      := rc041_111_1;
  self.rc044_111_9                      := rc044_111_9;
  self.rc021_112_1                      := rc021_112_1;
  self.gbm10_wc_lgt_112                 := gbm10_wc_lgt_112;
  self.rc006_112_3                      := rc006_112_3;
  self.rc011_112_5                      := rc011_112_5;
  self.rc002_112_7                      := rc002_112_7;
  self.rc003_113_1                      := rc003_113_1;
  self.rc012_113_6                      := rc012_113_6;
  self.rc006_113_7                      := rc006_113_7;
  self.rc025_113_3                      := rc025_113_3;
  self.gbm10_wc_lgt_113                 := gbm10_wc_lgt_113;
  self.gbm10_wc_lgt_114                 := gbm10_wc_lgt_114;
  self.rc024_114_3                      := rc024_114_3;
  self.rc038_114_8                      := rc038_114_8;
  self.rc053_114_1                      := rc053_114_1;
  self.rc009_114_4                      := rc009_114_4;
  self.gbm10_wc_lgt_115                 := gbm10_wc_lgt_115;
  self.rc056_115_2                      := rc056_115_2;
  self.rc035_115_1                      := rc035_115_1;
  self.rc010_115_3                      := rc010_115_3;
  self.rc016_115_7                      := rc016_115_7;
  self.rc005_116_3                      := rc005_116_3;
  self.gbm10_wc_lgt_116                 := gbm10_wc_lgt_116;
  self.rc022_116_1                      := rc022_116_1;
  self.rc009_116_4                      := rc009_116_4;
  self.rc027_116_2                      := rc027_116_2;
  self.rc010_117_4                      := rc010_117_4;
  self.gbm10_wc_lgt_117                 := gbm10_wc_lgt_117;
  self.rc001_117_1                      := rc001_117_1;
  self.rc016_117_3                      := rc016_117_3;
  self.rc031_117_5                      := rc031_117_5;
  self.rc013_118_8                      := rc013_118_8;
  self.gbm10_wc_lgt_118                 := gbm10_wc_lgt_118;
  self.rc010_118_6                      := rc010_118_6;
  self.rc014_118_4                      := rc014_118_4;
  self.rc029_118_1                      := rc029_118_1;
  self.rc004_119_1                      := rc004_119_1;
  self.rc031_119_3                      := rc031_119_3;
  self.gbm10_wc_lgt_119                 := gbm10_wc_lgt_119;
  self.rc031_119_2                      := rc031_119_2;
  self.rc001_119_4                      := rc001_119_4;
  self.rc005_120_5                      := rc005_120_5;
  self.rc033_120_3                      := rc033_120_3;
  self.rc003_120_4                      := rc003_120_4;
  self.gbm10_wc_lgt_120                 := gbm10_wc_lgt_120;
  self.rc008_120_1                      := rc008_120_1;
  self.rc022_121_4                      := rc022_121_4;
  self.rc020_121_7                      := rc020_121_7;
  self.rc016_121_1                      := rc016_121_1;
  self.gbm10_wc_lgt_121                 := gbm10_wc_lgt_121;
  self.rc029_121_5                      := rc029_121_5;
  self.gbm10_wc_lgt_122                 := gbm10_wc_lgt_122;
  self.rc010_122_5                      := rc010_122_5;
  self.rc001_122_1                      := rc001_122_1;
  self.rc010_122_3                      := rc010_122_3;
  self.rc031_122_7                      := rc031_122_7;
  self.rc004_123_2                      := rc004_123_2;
  self.rc013_123_4                      := rc013_123_4;
  self.gbm10_wc_lgt_123                 := gbm10_wc_lgt_123;
  self.rc012_123_3                      := rc012_123_3;
  self.rc022_123_1                      := rc022_123_1;
  self.rc029_124_8                      := rc029_124_8;
  self.rc033_124_1                      := rc033_124_1;
  self.gbm10_wc_lgt_124                 := gbm10_wc_lgt_124;
  self.rc013_124_3                      := rc013_124_3;
  self.rc039_124_4                      := rc039_124_4;
  self.rc018_125_7                      := rc018_125_7;
  self.rc022_125_9                      := rc022_125_9;
  self.rc013_125_2                      := rc013_125_2;
  self.rc013_125_1                      := rc013_125_1;
  self.gbm10_wc_lgt_125                 := gbm10_wc_lgt_125;
  self.rc044_126_3                      := rc044_126_3;
  self.gbm10_wc_lgt_126                 := gbm10_wc_lgt_126;
  self.rc019_126_2                      := rc019_126_2;
  self.rc046_126_4                      := rc046_126_4;
  self.rc019_126_1                      := rc019_126_1;
  self.rc030_127_1                      := rc030_127_1;
  self.gbm10_wc_lgt_127                 := gbm10_wc_lgt_127;
  self.rc021_127_4                      := rc021_127_4;
  self.rc005_127_7                      := rc005_127_7;
  self.rc004_127_5                      := rc004_127_5;
  self.rc047_128_2                      := rc047_128_2;
  self.rc054_128_3                      := rc054_128_3;
  self.gbm10_wc_lgt_128                 := gbm10_wc_lgt_128;
  self.rc005_128_7                      := rc005_128_7;
  self.rc054_128_1                      := rc054_128_1;
  self.rc023_129_9                      := rc023_129_9;
  self.gbm10_wc_lgt_129                 := gbm10_wc_lgt_129;
  self.rc041_129_3                      := rc041_129_3;
  self.rc051_129_5                      := rc051_129_5;
  self.rc003_129_1                      := rc003_129_1;
  self.gbm10_wc_lgt_130                 := gbm10_wc_lgt_130;
  self.rc030_130_4                      := rc030_130_4;
  self.rc005_130_3                      := rc005_130_3;
  self.rc003_130_1                      := rc003_130_1;
  self.rc034_130_5                      := rc034_130_5;
  self.rc032_131_1                      := rc032_131_1;
  self.gbm10_wc_lgt_131                 := gbm10_wc_lgt_131;
  self.rc011_131_4                      := rc011_131_4;
  self.rc025_131_3                      := rc025_131_3;
  self.rc047_131_5                      := rc047_131_5;
  self.rc012_132_5                      := rc012_132_5;
  self.gbm10_wc_lgt_132                 := gbm10_wc_lgt_132;
  self.rc033_132_3                      := rc033_132_3;
  self.rc033_132_1                      := rc033_132_1;
  self.rc028_132_2                      := rc028_132_2;
  self.rc005_133_3                      := rc005_133_3;
  self.rc010_133_6                      := rc010_133_6;
  self.rc035_133_5                      := rc035_133_5;
  self.rc038_133_1                      := rc038_133_1;
  self.gbm10_wc_lgt_133                 := gbm10_wc_lgt_133;
  self.rc001_134_1                      := rc001_134_1;
  self.gbm10_wc_lgt_134                 := gbm10_wc_lgt_134;
  self.rc007_134_5                      := rc007_134_5;
  self.rc006_134_6                      := rc006_134_6;
  self.rc026_134_3                      := rc026_134_3;
  self.rc021_135_8                      := rc021_135_8;
  self.rc025_135_3                      := rc025_135_3;
  self.rc003_135_1                      := rc003_135_1;
  self.gbm10_wc_lgt_135                 := gbm10_wc_lgt_135;
  self.rc016_135_4                      := rc016_135_4;
  self.rc010_136_1                      := rc010_136_1;
  self.rc002_136_7                      := rc002_136_7;
  self.gbm10_wc_lgt_136                 := gbm10_wc_lgt_136;
  self.rc006_136_8                      := rc006_136_8;
  self.rc010_136_2                      := rc010_136_2;
  self.rc002_137_5                      := rc002_137_5;
  self.rc010_137_2                      := rc010_137_2;
  self.gbm10_wc_lgt_137                 := gbm10_wc_lgt_137;
  self.rc048_137_1                      := rc048_137_1;
  self.rc048_137_3                      := rc048_137_3;
  self.rc009_138_7                      := rc009_138_7;
  self.rc026_138_5                      := rc026_138_5;
  self.rc005_138_3                      := rc005_138_3;
  self.gbm10_wc_lgt_138                 := gbm10_wc_lgt_138;
  self.rc033_138_1                      := rc033_138_1;
  self.rc038_139_7                      := rc038_139_7;
  self.rc035_139_5                      := rc035_139_5;
  self.gbm10_wc_lgt_139                 := gbm10_wc_lgt_139;
  self.rc001_139_1                      := rc001_139_1;
  self.rc010_139_3                      := rc010_139_3;
  self.gbm10_wc_lgt_140                 := gbm10_wc_lgt_140;
  self.rc013_140_3                      := rc013_140_3;
  self.rc017_140_10                     := rc017_140_10;
  self.rc007_140_5                      := rc007_140_5;
  self.rc023_140_1                      := rc023_140_1;
  self.rc011_141_3                      := rc011_141_3;
  self.rc024_141_1                      := rc024_141_1;
  self.rc025_141_9                      := rc025_141_9;
  self.gbm10_wc_lgt_141                 := gbm10_wc_lgt_141;
  self.rc048_141_4                      := rc048_141_4;
  self.rc012_142_2                      := rc012_142_2;
  self.rc042_142_1                      := rc042_142_1;
  self.rc047_142_4                      := rc047_142_4;
  self.gbm10_wc_lgt_142                 := gbm10_wc_lgt_142;
  self.rc041_142_8                      := rc041_142_8;
  self.rc035_143_3                      := rc035_143_3;
  self.rc035_143_5                      := rc035_143_5;
  self.rc036_143_7                      := rc036_143_7;
  self.gbm10_wc_lgt_143                 := gbm10_wc_lgt_143;
  self.rc003_143_1                      := rc003_143_1;
  self.gbm10_wc_lgt_144                 := gbm10_wc_lgt_144;
  self.rc039_144_3                      := rc039_144_3;
  self.rc014_144_7                      := rc014_144_7;
  self.rc002_144_1                      := rc002_144_1;
  self.rc043_144_2                      := rc043_144_2;
  self.aa_rc000                         := aa_rc000;
  self.gbm10_wc_lgt                     := gbm10_wc_lgt;
  self.lgt                              := lgt;
  self.offset                           := offset;
  self.base                             := base;
  self.pts                              := pts;
  self.gbm_mod10                        := gbm_mod10;
  self.aa_rc032                         := aa_rc032;
  self.aa_rc027                         := aa_rc027;
  self.aa_rc051                         := aa_rc051;
  self.aa_rc023                         := aa_rc023;
  self.aa_rc041                         := aa_rc041;
  self.aa_rc050                         := aa_rc050;
  self.aa_rc053                         := aa_rc053;
  self.aa_rc001                         := aa_rc001;
  self.aa_rc014                         := aa_rc014;
  self.aa_rc045                         := aa_rc045;
  self.aa_rc033                         := aa_rc033;
  self.aa_rc009                         := aa_rc009;
  self.aa_rc044                         := aa_rc044;
  self.aa_rc046                         := aa_rc046;
  self.aa_rc047                         := aa_rc047;
  self.aa_rc034                         := aa_rc034;
  self.aa_rc036                         := aa_rc036;
  self.aa_rc056                         := aa_rc056;
  self.aa_rc040                         := aa_rc040;
  self.aa_rc039                         := aa_rc039;
  self.aa_rc030                         := aa_rc030;
  self.aa_rc020                         := aa_rc020;
  self.aa_rc008                         := aa_rc008;
  self.aa_rc019                         := aa_rc019;
  self.aa_rc054                         := aa_rc054;
  self.aa_rc042                         := aa_rc042;
  self.aa_rc003                         := aa_rc003;
  self.aa_rc028                         := aa_rc028;
  self.aa_rc024                         := aa_rc024;
  self.aa_rc052                         := aa_rc052;
  self.aa_rc049                         := aa_rc049;
  self.aa_rc004                         := aa_rc004;
  self.aa_rc031                         := aa_rc031;
  self.aa_rc016                         := aa_rc016;
  self.aa_rc025                         := aa_rc025;
  self.aa_rc002                         := aa_rc002;
  self.aa_rc029                         := aa_rc029;
  self.aa_rc013                         := aa_rc013;
  self.aa_rc026                         := aa_rc026;
  self.aa_rc005                         := aa_rc005;
  self.aa_rc022                         := aa_rc022;
  self.aa_rc035                         := aa_rc035;
  self.aa_rc006                         := aa_rc006;
  self.aa_rc012                         := aa_rc012;
  self.aa_rc055                         := aa_rc055;
  self.aa_rc038                         := aa_rc038;
  self.aa_rc007                         := aa_rc007;
  self.aa_rc018                         := aa_rc018;
  self.aa_rc010                         := aa_rc010;
  self.aa_rc021                         := aa_rc021;
  self.aa_rc037                         := aa_rc037;
  self.aa_rc017                         := aa_rc017;
  self.aa_rc048                         := aa_rc048;
  self.aa_rc015                         := aa_rc015;
  self.aa_rc043                         := aa_rc043;
  self.wccat_corremailphone             := wccat_corremailphone;
  self.wccat_corremailname              := wccat_corremailname;
  self.wccat_corremailaddr              := wccat_corremailaddr;
  self.wccat_emailperphone              := wccat_emailperphone;
  self.wccat_deviceperemail             := wccat_deviceperemail;
  self.wccat_ipperemail                 := wccat_ipperemail;
  self.wccat_phoneperemail              := wccat_phoneperemail;
  self.wccat_deviceperphone             := wccat_deviceperphone;
  self.wccat_tmxidperemail              := wccat_tmxidperemail;
  self.wccat_tmxidperphone              := wccat_tmxidperphone;
  self.wccat_addrdayssincefirstseen     := wccat_addrdayssincefirstseen;
  self.wccat_addrdayssincelastseen      := wccat_addrdayssincelastseen;
  self.wccat_emaildayssincefirstseen    := wccat_emaildayssincefirstseen;
  self.wccat_emaildayssincelastseen     := wccat_emaildayssincelastseen;
  self.wccat_namedayssincefirstseen     := wccat_namedayssincefirstseen;
  self.wccat_namedayssincelastseen      := wccat_namedayssincelastseen;
  self.wccat_phonedayssincefirstseen    := wccat_phonedayssincefirstseen;
  self.wccat_phonedayssincelastseen     := wccat_phonedayssincelastseen;
  self.wccat_tmxiddayssincefirstseen    := wccat_tmxiddayssincefirstseen;
  self.wccat_avgtimebetweentxwemail     := wccat_avgtimebetweentxwemail;
  self.wccat_avgtimebetweentxwphone     := wccat_avgtimebetweentxwphone;
  self.wccat_browserhashperemail        := wccat_browserhashperemail;
  self.wccat_browserhashperphone        := wccat_browserhashperphone;
  self.wccat_distbetweenipwphone        := wccat_distbetweenipwphone;
  self.wccat_eventsperemail             := wccat_eventsperemail;
  self.wccat_eventsperphone             := wccat_eventsperphone;
  self.wccat_devicepertmxid             := wccat_devicepertmxid;
  self.wccat_ipperphone                 := wccat_ipperphone;
  self.wccat_ippertmxid                 := wccat_ippertmxid;
  self.wccat_loginidperphone            := wccat_loginidperphone;
  self.wccat_orgidperemail              := wccat_orgidperemail;
  self.wccat_fraudbyuser                := wccat_fraudbyuser;
  self.wccat_blacklist                  := wccat_blacklist;
  self.wccat_finalstatusreject          := wccat_finalstatusreject;
  self.wc00_code                        := wc00_code;
  self.wc00_catname                     := wc00_catname;
  self.wc01_code                        := wc01_code;
  self.wc01_catname                     := wc01_catname;
  self.wc02_code                        := wc02_code;
  self.wc02_catname                     := wc02_catname;
  self.wc03_code                        := wc03_code;
  self.wc03_catname                     := wc03_catname;
  self.wc04_code                        := wc04_code;
  self.wc04_catname                     := wc04_catname;
  self.wc05_code                        := wc05_code;
  self.wc05_catname                     := wc05_catname;
  self.wc06_code                        := wc06_code;
  self.wc06_catname                     := wc06_catname;
  self.wc10_code                        := wc10_code;
  self.wc10_catname                     := wc10_catname;
  self.wc11_code                        := wc11_code;
  self.wc11_catname                     := wc11_catname;
  self.wc12_code                        := wc12_code;
  self.wc12_catname                     := wc12_catname;
  self.wc13_code                        := wc13_code;
  self.wc13_catname                     := wc13_catname;
  self.wc14_code                        := wc14_code;
  self.wc14_catname                     := wc14_catname;
  self.wc15_code                        := wc15_code;
  self.wc15_catname                     := wc15_catname;
  self.wc16_code                        := wc16_code;
  self.wc16_catname                     := wc16_catname;
  self.wc20_code                        := wc20_code;
  self.wc20_catname                     := wc20_catname;
  self.wc21_code                        := wc21_code;
  self.wc21_catname                     := wc21_catname;
  self.wc30_code                        := wc30_code;
  self.wc30_catname                     := wc30_catname;
  self.wc31_code                        := wc31_code;
  self.wc31_catname                     := wc31_catname;
  self.wc32_code                        := wc32_code;
  self.wc32_catname                     := wc32_catname;
  self.wc40_code                        := wc40_code;
  self.wc40_catname                     := wc40_catname;
  self.wc41_code                        := wc41_code;
  self.wc41_catname                     := wc41_catname;
  self.wc42_code                        := wc42_code;
  self.wc42_catname                     := wc42_catname;
  self.wc43_code                        := wc43_code;
  self.wc43_catname                     := wc43_catname;
  self.wc44_code                        := wc44_code;
  self.wc44_catname                     := wc44_catname;
  self.wc45_code                        := wc45_code;
  self.wc45_catname                     := wc45_catname;
  self.wc46_code                        := wc46_code;
  self.wc46_catname                     := wc46_catname;
  self.wc47_code                        := wc47_code;
  self.wc47_catname                     := wc47_catname;
  self.wc48_code                        := wc48_code;
  self.wc48_catname                     := wc48_catname;
  self.wc50_code                        := wc50_code;
  self.wc50_catname                     := wc50_catname;
  self.wc51_code                        := wc51_code;
  self.wc51_catname                     := wc51_catname;
  self.wc60_code                        := wc60_code;
  self.wc60_catname                     := wc60_catname;
  self.wc97_code                        := wc97_code;
  self.wc97_catname                     := wc97_catname;
  self.wc98_code                        := wc98_code;
  self.wc98_catname                     := wc98_catname;
  self.wc99_code                        := wc99_code;
  self.wc99_catname                     := wc99_catname;
  self.wc_outpts1                       := wc_outpts1;
  self.wc_outpts2                       := wc_outpts2;
  self.wc_outpts3                       := wc_outpts3;
  self.wc_outpts4                       := wc_outpts4;
  self.wc_outpts5                       := wc_outpts5;
  self.wc_outpts6                       := wc_outpts6;
  self.wc_outcatname2                   := wc_outcatname2;
  self.wc_outcatname3                   := wc_outcatname3;
  self.wc_outcatname4                   := wc_outcatname4;
  self.wc_outcatname5                   := wc_outcatname5;
  self.wc_outcatname6                   := wc_outcatname6;
  self.wc1                              := wc1;
  self.wc2                              := wc2;
  self.wc3                              := wc3;
  self.wc4                              := wc4;
  self.wc5                              := wc5;
  self.wc6                              := wc6;
  self.wc_outcatname1                   := wc_outcatname1;
  self.di31906                          := (String)di31906;

// SELF.clam := le;
#else

	 self.seq := le.seq;
	 reasons := Project(Final_reasons, transform(risk_indicators.Layout_Desc,
                                             self.hri := left.hri,
                                             self.desc := Models.getTMX_reasons(left.hri)
                      ));
                       
	self.ri := reasons;
	self.score := (string)di31906;
	self := [];
#end	
END;

  model :=   project(iid_out, doModel(left) );
	
	return model;
  
END;
