//This is my own data, rather than QAs sensitive data

//
corp_bug_137300 :=
	dataset([
    {'06-200726010045',37556480},
    {'08-19971164910',37556480},
    {'29-2985881',76249693},
    {'42-957367',130178935}	
		], {string ck, unsigned6 seleid});


//bug_125269
prop_Dataset_sele_37556480_bug_125269 :=
  dataset([
    {'OA0601831302'},
    {'OA0746969447'},
    {'OA0891468930'},
    {'OA1053259861'}], {string ln_fares_id});

prop_Dataset_sele_113471768_bug_125269 :=
  dataset([
    {'OA0322407945'},
    {'OA0507700295'},
    {'RA1013335609'}], {string ln_fares_id});

prop_Dataset_sele_130178935_bug_125269 :=
  dataset([
    {'RA1990342762'},
    {'OA0873954621'},
    {'OA1049992326'}], {string ln_fares_id});
		
//bug_124584
prop_Dataset_sele_28063_bug_124584 :=
  dataset([
    {'RD0757991670'}, 
    {'RD0757991670'}, 
    {'RD0621993110'}, 
    {'RD0611697299'}, 
    {'RD0602512079'}, 
    {'RD0602511948'}, 
    {'RD0550286359'}, 
    {'RD0500677885'}, 
    {'RD0500321787'}, 
    {'RD0252387347'}, 
    {'RA2057266132'}, 
    {'RA2057263653'}, 
    {'RA2057263653'}, 
    {'RA2053962826'}, 
    {'RA2053962826'}, 
    {'RA2033729489'}, 
    {'RA2033727826'}, 
    {'RA2033727826'}, 
    {'RA2033726128'}, 
    {'RA2031120448'}, 
    {'RA2031120448'}, 
    {'RA1959585645'}, 
    {'RA1959584636'}, 
    {'RA1959579602'}, 
    {'RA1956664071'}, 
    {'RA1956664071'}, 
    {'RA1685747480'}, 
    {'RA1685746807'}, 
    {'RA1685744101'}, 
    {'RA1506783846'}, 
    {'RA1506783509'}, 
    {'RA1506781835'}, 
    {'RA1353054442'}, 
    {'RA1353054089'}, 
    {'RA1353053608'}, 
    {'RA1232121705'}, 
    {'RA1232120560'}, 
    {'RA1232119791'}, 
    {'RA1225067441'}, 
    {'RA1225066440'}, 
    {'RA1225065767'}, 
    {'RA1046353526'}, 
    {'RA1046348709'}, 
    {'RA1046345492'}, 
    {'RA0908088311'}, 
    {'RA0908086588'}, 
    {'RA0908085443'}, 
    {'RA0908085435'}, 
    {'RA0755553780'}, 
    {'RA0755553407'}, 
    {'RA0755551897'}, 
    {'RA0755551766'}, 
    {'RA0661501967'}, 
    {'RA0661501961'}, 
    {'RA0661498610'}, 
    {'RA0661498602'}, 
    {'RA0371661686'}, 
    {'RA0371661674'}, 
    {'RA0371641020'}, 
    {'RA0371627031'}, 
    {'RA0371627005'}, 
    {'RA0136048684'}, 
    {'RA0136048678'}, 
    {'RA0136048567'}, 
    {'RA0136048559'}, 
    {'RA0136048418'}, 
    {'RA0136048268'}, 
    {'RA0136048268'}, 
    {'RA0136048254'}, 
    {'RA0136048254'}, 
    {'RA0033567721'}, 
    {'RA0033567701'}, 
    {'RA0033567695'}, 
    {'RA0033567585'}, 
    {'RA0033567577'}, 
    {'OD0011098337'}, 
    {'OA0815006645'}, 
    {'OA0662268245'}, 
    {'OA0569152349'}, 
    {'OA0511120844'}, 
    {'OA0393772108'}, 
    {'OA0056604232'}, 
    {'OA0056604026'}, 
    {'DD0052004500'}, 
    {'DD0052004500'}, 
    {'DD0047152746'}, 
    {'DD0046528649'}, 
    {'DD0040063742'}, 
    {'DA0312175832'}, 
    {'DA0282580742'}, 
    {'DA0259659534'}, 
    {'DA0231189190'}, 
    {'DA0205490517'}, 
    {'DA0186996024'}, 
    {'DA0169191038'}, 
    {'DA0142101909'}, 
    {'DA0142101909'}, 
    {'DA0142101908'}, 
    {'DA0142101908'}, 
    {'DA0095299114'}], {string ln_fares_id});



prop_Dataset_sele_14771_bug_126198 :=
  dataset([
    {'RA1908775124'}, 
    {'RD0054206929'}, 
    {'RA0053531717'}, 
    {'RA0136729416'}, 
    {'RA0504029524'}, 
    {'RA0610666687'}, 
    {'DA0192731496'}, 
    {'DA0248309502'}, 
    {'DA0261114478'}, 
    {'DD0008521868'}, 
    {'DD0072186807'}, 
    {'RA0742130241'}, 
    {'RA0414441202'}, 
    {'RA0639416618'}, 
    {'RA0699132475'}, 
    {'RA0901943356'}, 
    {'RA0902884623'}, 
    {'OA0084824448'}, 
    {'OA0134152879'}, 
    {'RA0983628293'}, 
    {'OA0313432805'}, 
    {'RA1918882892'}, 
    {'OA1022852534'}, 
    {'RA2006403729'}, 
    {'RA2093443349'}, 
    {'RA0111890625'}, 
    {'RA0393477130'}, 
    {'RA0629206323'}, 
    {'DD0045682604'}, 
    {'RA0783532611'}, 
    {'RA0850745224'}, 
    {'RA1823537520'}, 
    {'RD0028542712'}], {string ln_fares_id});
		
prop_Dataset_sele_261926_bug_125269 :=
  dataset([
    {'OA1168881467'},
    {'RA2006144440'},
    {'OA0965364535'}, 
    {'OA1168733281'}, 
    {'RA1055538229'}, 
    {'RA1055538230'}], {string ln_fares_id});		

prop_Dataset_sele_102130419_bug_125269 :=
  dataset([
    {'OA0436922436'}, 
    {'OA0505909995'}], {string ln_fares_id});	


prop_Dataset_sele_102645263_bug_125269 :=
  dataset([
    {'OA0505890398'}, 
    {'RD0729665612'}], {string ln_fares_id});	

prop_Dataset_sele_358453829_bug_125269 :=
  dataset([
    {'RD0109159354'}], {string ln_fares_id});	



mvr_bug_125285 :=
	dataset([
		{'12480921586999737456', 102856493} 	//NCO YOUTH & FAMILY SERVICES 
		,{'18355738227963920890', 152574711 } //USA LAWN & LANDSCAPING, INC. 
		
		
// CREATIVE COUNTERTOP SOLUTIONS INC     
// 300 PEABODY ST     
// NASHVILLE, TN 37210
// prox/sele/org/ult = 36624149
// Vehicle Keys | Iteration Key | Sequence Key:
		,{'10350192553926162240',36624149}
		,{'15102973656431807472',36624149}
		,{'3309535756167348500',36624149}
		,{'3309535756167348500',36624149}
		,{'3309535756167348500',36624149}
		,{'3309535756167348500',36624149}
		,{'6984959996543562643',36624149}


// GALATI BUILDING CLEANING CO     
// 1136 CHAVANIAC DR                         
// BALLWIN, MO 63011
// prox/sele/org/ult = 57515227
// Vehicle Keys | Iteration Key | Sequence Key:
		,{'10459971710085127093',57515227}
		,{'13700815083242713154',57515227}
		,{'7157528690617610054',57515227}
		,{'7888196856353235951',57515227}
		,{'7888196856353235951',57515227}		
		
		], {string vk, unsigned6 seleid});


ucc_dataset_sele_14771_bug_126198 :=
  dataset([
    {'CA0016460606'}, 
    {'CA057016206845'}, 
    {'CA097215599401'}, 
    {'CA137357520962'}, 
    {'CA9504860279'}, 
    {'CA9517260240'}, 
    {'CA9934460109'}, 
    {'CA9934460138'}, 
    {'CA9934460148'}, 
    {'CA087166816851'}, 
    {'CA087166816851'}, 
    {'CA087166816851'}, 
    {'CA9531060733'}, 
    {'CA9724060946'}], {string tmsid});


lj_dataset_sele_25428_bug_123991 :=
dataset([
    {'SUDPAJC004009241988001000514400101'}, 
    {'SUDPASC004009241988001000057529000'}, 
    {'SUDPACC030200881998001007467390000'}, 
    {'SUDPACC043032421998001007534460000'}, 
    {'SUDPACC052930151997001007218829000'}, 
    {'SUDPACC052930301998001008301313000'}, 
    {'SUDPACC052930311998001008301312000'}, 
    {'SUDPACC120303041999001010232503000'}, 
    {'SUDPACV000000832006TM003014227514000'}, 
    {'SUDPACV000001841998TG003008865881000'}, 
    {'SUDPACV000002981999TM003009738002000'}, 
    {'SUDPACV000004392006TM003014594528000'}, 
    {'SUDPADJ000002981999TM003009773795000'}, 
    {'SUDPAFL004033581992003005167329000'}, 
    {'SUDPAJC000027821996003006029742000'}, 
    {'SUDPAJC000027821996003006029742000'}, 
    {'SUDPAJC000028161996003006029747000'}, 
    {'SUDPAJC000120481997003007335330000'}, 
    {'SUDPAJC000128571994003005711328000'}, 
    {'SUDPAJC000153611994003005750541000'}, 
    {'SUDPAJC000515441993003005532071000'}, 
    {'SUDPAJC000516291993003005588279000'}, 
    {'SUDPAJC000528011994003005742745000'}, 
    {'SUDPAJC002004612005001014877334000'}, 
    {'SUDPAJC010025241988001000527084100'}, 
    {'SUDPAJC011023231996001007073567000'}, 
    {'SUDPAJC012016871994001001239102100'}, 
    {'SUDPAJC012020551994001001319225101'}, 
    {'SUDPASC000034732000003010364955000'}, 
    {'SUDPASC000072172000003010456196000'}, 
    {'SUDPASC000072172000003010456196000'}, 
    {'SUDPASC000210561998003009626631000'}, 
    {'SUDPASC000507791994003005622163000'}, 
    {'SUDPASC000515441993003005477153000'}, 
    {'SUDPASC000519481993003005558080000'}, 
    {'SUDPASC002004612005001013523835000'}, 
    {'SUDPASC003018531999001009540247000'}, 
    {'SUDPASC003018531999001009540247000'}, 
    {'SUDPASC003028191993001000964887000'}, 
    {'SUDPASC004005942001001010685158000'}, 
    {'SUDPASC004008572006001014342353000'}, 
    {'SUDPASC004008572006001014342353000'}, 
    {'SUDPASC006008562002001011652160000'}, 
    {'SUDPASC006008562002001011652160000'}, 
    {'SUDPASC006015652001001010837050000'}, 
    {'SUDPASC007024562005001013844459000'}, 
    {'SUDPASC010028682001001011216859000'}, 
    {'SUDPASC011023231996001007094111000'}, 
    {'SUDPAJT000000121997TM003008343853000'}, 
    {'SUDPASC005044211993001001011196000'}, 
    {'SUDPAJC000060611993003005347586000'}, 
    {'SUDPASC003018531999001009540247000'}], {string tmsid});


bk_dataset_sele_97466557_bug_117358 :=
dataset([
    {'BKME0010810832'}], {string tmsid});

bk_dataset_sele_109559559_bug_117358 :=
dataset([
    {'BKNC0029831272'}], {string tmsid});

rec := record
	string datasource_name;
	string mtype;
	string id1;
	string id2;
	unsigned6 ultid;
	unsigned6 orgid;
	unsigned6 seleid;
end;	

EXPORT ShortCycleDataTest := /*
project(
	prop_Dataset_sele_28063_bug_124584,
	transform(
		rec,
		self.datasource_name := 'Real Property';
		self.mtype := 'B';
		self.id1 := left.ln_fares_id,
		self.id2 := '',
		self.ultid := 28063,
		self.orgid := 28063,
		self.seleid := 28063
	)
)
+
project(
	prop_Dataset_sele_14771_bug_126198,
	transform(
		rec,
		self.datasource_name := 'Real Property';
		self.mtype := 'B';
		self.id1 := left.ln_fares_id,
		self.id2 := '',
		self.ultid := 14771,
		self.orgid := 14771,
		self.seleid := 14771
	)
)
+*/
project(
	prop_Dataset_sele_261926_bug_125269,
	transform(
		rec,
		self.datasource_name := 'Real Property';
		self.mtype := 'B';
		self.id1 := left.ln_fares_id,
		self.id2 := '',
		self.ultid := 261926,
		self.orgid := 261926,
		self.seleid := 261926
	)
)
+
project(
	prop_Dataset_sele_102130419_bug_125269,
	transform(
		rec,
		self.datasource_name := 'Real Property';
		self.mtype := 'B';
		self.id1 := left.ln_fares_id,
		self.id2 := '',
		self.ultid := 102130419,
		self.orgid := 102130419,
		self.seleid := 102130419
	)
)
+
project(
	prop_Dataset_sele_102645263_bug_125269,
	transform(
		rec,
		self.datasource_name := 'Real Property';
		self.mtype := 'B';
		self.id1 := left.ln_fares_id,
		self.id2 := '',
		self.ultid := 102645263,
		self.orgid := 102645263,
		self.seleid := 102645263
	)
)+
project(
	prop_Dataset_sele_358453829_bug_125269,
	transform(
		rec,
		self.datasource_name := 'Real Property';
		self.mtype := 'B';
		self.id1 := left.ln_fares_id,
		self.id2 := '',
		self.ultid := 358453829,
		self.orgid := 358453829,
		self.seleid := 358453829
	)
)

+

project(
	prop_Dataset_sele_37556480_bug_125269,
	transform(
		rec,
		self.datasource_name := 'Real Property';
		self.mtype := 'B';
		self.id1 := left.ln_fares_id,
		self.id2 := '',
		self.ultid := 37556480,
		self.orgid := 37556480,
		self.seleid := 37556480
	)
)

+

project(
	prop_Dataset_sele_113471768_bug_125269,
	transform(
		rec,
		self.datasource_name := 'Real Property';
		self.mtype := 'B';
		self.id1 := left.ln_fares_id,
		self.id2 := '',
		self.ultid := 113471768,
		self.orgid := 113471768,
		self.seleid := 113471768
	)
)

+

project(
	prop_Dataset_sele_130178935_bug_125269,
	transform(
		rec,
		self.datasource_name := 'Real Property';
		self.mtype := 'B';
		self.id1 := left.ln_fares_id,
		self.id2 := '',
		self.ultid := 130178935,
		self.orgid := 130178935,
		self.seleid := 130178935
	)
)

+




//MVR
project(
	mvr_bug_125285,
	transform(
		rec,
		self.datasource_name := 'MVR';
		self.mtype := 'G';
		self.id1 := left.vk,
		self.id2 := '',
		self.ultid := left.seleid,
		self.orgid := left.seleid,
		self.seleid := left.seleid
	)
)	

+

project(
	lj_dataset_sele_25428_bug_123991,
	transform(
		rec,
		self.datasource_name := 'Judgement';
		self.mtype := 'B';
		self.id1 := left.tmsid,
		self.id2 := '',
		self.ultid := 25428,
		self.orgid := 25428,
		self.seleid := 25428
	)
)		

+

project(
	ucc_dataset_sele_14771_bug_126198,
	transform(
		rec,
		self.datasource_name := 'UCC';
		self.mtype := 'B';
		self.id1 := left.tmsid,
		self.id2 := '',
		self.ultid := 14771,
		self.orgid := 14771,
		self.seleid := 14771
	)
)	

//Bankruptcy	

+

project(
	bk_dataset_sele_97466557_bug_117358,
	transform(
		rec,
		self.datasource_name := 'Bankruptcy';
		self.mtype := 'G';
		self.id1 := left.tmsid,
		self.id2 := '',
		self.ultid := 97466557,
		self.orgid := 97466557,
		self.seleid := 97466557
	)
)	

+

project(
	bk_dataset_sele_109559559_bug_117358,
	transform(
		rec,
		self.datasource_name := 'Bankruptcy';
		self.mtype := 'G';
		self.id1 := left.tmsid,
		self.id2 := '',
		self.ultid := 109559559,
		self.orgid := 109559559,
		self.seleid := 109559559
	)
)	

+
project(
	corp_bug_137300,
	transform(
		rec,
		self.datasource_name := BIPV2_Testing.Constants.SC.DSNames.corp[1];
		self.mtype := 'B';//precision bug
		self.id1 := left.ck,
		self.id2 := '',
		self.ultid := 0,//not given
		self.orgid := 0,
		self.seleid := left.seleid
	)
)	
;