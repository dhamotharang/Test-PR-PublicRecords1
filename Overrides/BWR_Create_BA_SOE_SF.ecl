IMPORT $,STD;

//Adding sub files to super file 
f1 :='~wwba::BA-SOE-link_matches_1';
f2 :='~wwba::BA-SOE-link_matches_2';
f3 :='~wwba::BA-SOE-link_matches_3';
f4 :='~wwba::BA-SOE-link_matches_4';
f5 :='~wwba::BA-SOE-link_matches_5';
f6 :='~wwba::BA-SOE-link_matches_6';
f7 :='~wwba::BA-SOE-link_matches_7';
f8 :='~wwba::BA-SOE-link_matches_8';
f9 :='~wwba::BA-SOE-link_matches_9';
f10 :='~wwba::BA-SOE-link_matches_10';
f11 :='~wwba::BA-SOE-link_matches_11';

SEQUENTIAL(STD.File.StartSuperFileTransaction(),

					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f1),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f2),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f3),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f4),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f5),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f6),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f7),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f8),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f9),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f10),
					 STD.File.AddSuperFile($.File_BA_SOE_AllData.AllDataSF,f11),
					 
					 STD.File.FinishSuperFileTransaction());