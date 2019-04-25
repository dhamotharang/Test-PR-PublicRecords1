EXPORT RiskView_v5_generic_XML(route,current_dt,previous_dt) := functionmacro

import Scoring_Project_Macros, Scoring_QA, Scoring_QA;

 file1:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout,


thor);

 file2:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout,


thor);



	


aa1:=join(file1,file2,left.accountnumber=right.accountnumber,inner);

aa:=aa1(accountnumber<>'');


DS1:=join(file1,aa,left.accountnumber=right.accountnumber,inner);

DS2:=join(file2,aa,left.accountnumber=right.accountnumber,inner);

                           
                              Missing_values:= JOIN(DS2,DS1,LEFT.accountnumber=RIGHT.accountnumber and LEFT.did!=RIGHT.did,local);
													
															
													
		pfc := count(ds1);
   cfc := count(ds2);
	 
   fcd :=cfc-pfc;
pf:=count(Missing_values);
cf:=count(Missing_values);

pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
abd:=abs(pd);
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);
	 
	 

   	  	
Scoring_QA.Range_function_module_2.range_Function_300(DS2,'auto_score',Ran1);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'auto_reason1',Ran2);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'auto_reason2',Ran3);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'auto_reason3',Ran4);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'auto_reason4',Ran5);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'auto_reason5',Ran6);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'bankcard_index',Ran7);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'bankcard_reason1',Ran8);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'bankcard_reason2',Ran9);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'bankcard_reason3',Ran10);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'bankcard_reason4',Ran11);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'bankcard_reason5',Ran12);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'short_term_lending_index',Ran13);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'short_term_lending_reason1',Ran14);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'short_term_lending_reason2',Ran15);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'short_term_lending_reason3',Ran16);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'short_term_lending_reason4',Ran17);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'short_term_lending_reason5',Ran18);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'telecommunications_index',Ran19);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'telecommunications_reason1',Ran20);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'telecommunications_reason2',Ran21);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'telecommunications_reason3',Ran22);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'telecommunications_reason4',Ran23);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'telecommunications_reason5',Ran24);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'custom_index',Ran25);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'custom_score_name',Ran26);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'custom_reason1',Ran27);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'custom_reason2',Ran28);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'custom_reason3',Ran29);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'custom_reason4',Ran30);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'custom_reason5',Ran31);
Scoring_QA.Range_function_module_2.range_Function_301(DS2,'attribute_index',Ran32);
Scoring_QA.Range_function_module_2.range_Function_302(DS2,'bankcard_score',Ran33);
Scoring_QA.Range_function_module_2.range_Function_303(DS2,'short_term_lending_score',Ran34);
Scoring_QA.Range_function_module_2.range_Function_304(DS2,'telecommunications_score',Ran35);
Scoring_QA.Range_function_module_2.range_Function_305(DS2,'custom_score',Ran36);
Scoring_QA.Range_function_module_2.range_Function_306(DS2,'inputprovidedfirstname',Ran37);
Scoring_QA.Range_function_module_2.range_Function_306(DS2,'inputprovidedlastname',Ran38);
Scoring_QA.Range_function_module_2.range_Function_306(DS2,'inputprovidedstreetaddress',Ran39);
Scoring_QA.Range_function_module_2.range_Function_306(DS2,'inputprovidedcity',Ran40);
Scoring_QA.Range_function_module_2.range_Function_306(DS2,'inputprovidedstate',Ran41);
Scoring_QA.Range_function_module_2.range_Function_306(DS2,'inputprovidedzipcode',Ran42);
Scoring_QA.Range_function_module_2.range_Function_306(DS2,'inputprovidedphone',Ran43);
Scoring_QA.Range_function_module_2.range_Function_307(DS2,'inputprovidedssn',Ran44);
Scoring_QA.Range_function_module_2.range_Function_307(DS2,'alertregulatorycondition',Ran45);
Scoring_QA.Range_function_module_2.range_Function_308(DS2,'inputprovideddateofbirth',Ran46);
Scoring_QA.Range_function_module_2.range_Function_309(DS2,'inputprovidedlexid',Ran47);
Scoring_QA.Range_function_module_2.range_Function_310(DS2,'subjectrecordtimeoldest',Ran48);
Scoring_QA.Range_function_module_2.range_Function_311(DS2,'subjectrecordtimenewest',Ran49);
Scoring_QA.Range_function_module_2.range_Function_311(DS2,'sourcecredheadertimenewest',Ran50);
Scoring_QA.Range_function_module_2.range_Function_311(DS2,'addrcurrenttimenewest',Ran51);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'subjectnewestrecord12month',Ran52);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'subjectdeceased',Ran53);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'confirmationinputaddress',Ran54);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'sourcevoterregistration',Ran55);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'educationattendance',Ran56);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'educationevidence',Ran57);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'educationinstitutionprivate',Ran58);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'businessassociation',Ran59);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'assetownership',Ran60);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'assetprop',Ran61);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'assetpersonal',Ran62);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'lienjudgmentforeclosurecount',Ran63);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'bankruptcydismissed24month',Ran64);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'shorttermloanrequest',Ran65);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'shorttermloanrequest12month',Ran66);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'shorttermloanrequest24month',Ran67);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'inquiryauto12month',Ran68);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'inquirybanking12month',Ran69);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'inquirytelcom12month',Ran70);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'inquirynonshortterm12month',Ran71);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'inquiryshortterm12month',Ran72);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'inquirycollections12month',Ran73);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'ssndeceased',Ran74);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addronfilecorrectional',Ran75);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addronfilecollege',Ran76);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addronfilehighrisk',Ran77);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addrinputsubjectowned',Ran78);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addrinputdeedmailing',Ran79);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addrinputphoneservice',Ran80);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addrcurrentsubjectowned',Ran81);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addrcurrentdeedmailing',Ran82);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addrcurrentphoneservice',Ran83);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addrcurrentcorrectional',Ran84);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'addrpreviouscorrectional',Ran85);
Scoring_QA.Range_function_module_2.range_Function_312(DS2,'phoneinputmobile',Ran86);
Scoring_QA.Range_function_module_2.range_Function_313(DS2,'subjectactivityindex03month',Ran87);
Scoring_QA.Range_function_module_2.range_Function_313(DS2,'subjectactivityindex06month',Ran88);
Scoring_QA.Range_function_module_2.range_Function_313(DS2,'subjectactivityindex12month',Ran89);
Scoring_QA.Range_function_module_2.range_Function_314(DS2,'subjectage',Ran90);
Scoring_QA.Range_function_module_2.range_Function_315(DS2,'subjectssncount',Ran91);
Scoring_QA.Range_function_module_2.range_Function_315(DS2,'ssnsubjectcount',Ran92);
Scoring_QA.Range_function_module_2.range_Function_316(DS2,'subjectstabilityindex',Ran93);
Scoring_QA.Range_function_module_2.range_Function_317(DS2,'subjectabilityindex',Ran94);
Scoring_QA.Range_function_module_2.range_Function_318(DS2,'subjectwillingnessindex',Ran95);
Scoring_QA.Range_function_module_2.range_Function_319(DS2,'confirmationsubjectfound',Ran96);
Scoring_QA.Range_function_module_2.range_Function_320(DS2,'confirmationinputname',Ran97);
Scoring_QA.Range_function_module_2.range_Function_320(DS2,'confirmationinputssn',Ran98);
Scoring_QA.Range_function_module_2.range_Function_320(DS2,'educationprogramattended',Ran99);
Scoring_QA.Range_function_module_2.range_Function_320(DS2,'businessassociationindex',Ran100);
Scoring_QA.Range_function_module_2.range_Function_320(DS2,'purchaseactivityindex',Ran101);
Scoring_QA.Range_function_module_2.range_Function_320(DS2,'addrinputdwelltypeindex',Ran102);
Scoring_QA.Range_function_module_2.range_Function_320(DS2,'addrcurrentdwelltypeindex',Ran103);
Scoring_QA.Range_function_module_2.range_Function_320(DS2,'addrpreviousdwelltypeindex',Ran104);
Scoring_QA.Range_function_module_2.range_Function_321(DS2,'confirmationinputdob',Ran105);
Scoring_QA.Range_function_module_2.range_Function_322(DS2,'sourcenonderogprofileindex',Ran106);
Scoring_QA.Range_function_module_2.range_Function_323(DS2,'sourcenonderogcount',Ran107);
Scoring_QA.Range_function_module_2.range_Function_324(DS2,'sourcenonderogcount03month',Ran108);
Scoring_QA.Range_function_module_2.range_Function_324(DS2,'sourcenonderogcount06month',Ran109);
Scoring_QA.Range_function_module_2.range_Function_324(DS2,'sourcenonderogcount12month',Ran110);
Scoring_QA.Range_function_module_2.range_Function_325(DS2,'sourcecredheadertimeoldest',Ran111);
Scoring_QA.Range_function_module_2.range_Function_326(DS2,'educationinstitutionrating',Ran112);
Scoring_QA.Range_function_module_2.range_Function_327(DS2,'profliccount',Ran113);
Scoring_QA.Range_function_module_2.range_Function_327(DS2,'assetproppurchasecount12month',Ran114);
Scoring_QA.Range_function_module_2.range_Function_327(DS2,'derogcount12month',Ran115);
Scoring_QA.Range_function_module_2.range_Function_327(DS2,'criminalfelonycount',Ran116);
Scoring_QA.Range_function_module_2.range_Function_327(DS2,'criminalfelonycount12month',Ran117);
Scoring_QA.Range_function_module_2.range_Function_327(DS2,'criminalnonfelonycount',Ran118);
Scoring_QA.Range_function_module_2.range_Function_327(DS2,'criminalnonfelonycount12month',Ran119);
Scoring_QA.Range_function_module_2.range_Function_327(DS2,'bankruptcycount',Ran120);
Scoring_QA.Range_function_module_2.range_Function_327(DS2,'bankruptcycount24month',Ran121);
Scoring_QA.Range_function_module_2.range_Function_328(DS2,'proflictypecategory',Ran122);
Scoring_QA.Range_function_module_2.range_Function_329(DS2,'businessassociationtimeoldest',Ran123);
Scoring_QA.Range_function_module_2.range_Function_330(DS2,'businesstitleleadership',Ran124);
Scoring_QA.Range_function_module_2.range_Function_330(DS2,'assetpropnewestmortgagetype',Ran125);
Scoring_QA.Range_function_module_2.range_Function_330(DS2,'bankruptcychapter',Ran126);
Scoring_QA.Range_function_module_2.range_Function_330(DS2,'bankruptcystatus',Ran127);
Scoring_QA.Range_function_module_2.range_Function_330(DS2,'addrinputmatchindex',Ran128);
Scoring_QA.Range_function_module_2.range_Function_331(DS2,'assetindex',Ran129);
Scoring_QA.Range_function_module_2.range_Function_332(DS2,'assetpropindex',Ran130);
Scoring_QA.Range_function_module_2.range_Function_332(DS2,'addrinputownershipindex',Ran131);
Scoring_QA.Range_function_module_2.range_Function_332(DS2,'addrinputdelivery',Ran132);
Scoring_QA.Range_function_module_2.range_Function_332(DS2,'addrcurrentownershipindex',Ran133);
Scoring_QA.Range_function_module_2.range_Function_333(DS2,'assetpropevercount',Ran134);
Scoring_QA.Range_function_module_2.range_Function_333(DS2,'assetpropcurrentcount',Ran135);
Scoring_QA.Range_function_module_2.range_Function_333(DS2,'assetpropeversoldcount',Ran136);
Scoring_QA.Range_function_module_2.range_Function_333(DS2,'addrinputphonecount',Ran137);
Scoring_QA.Range_function_module_2.range_Function_333(DS2,'addrchangecount12month',Ran138);
Scoring_QA.Range_function_module_2.range_Function_333(DS2,'addrchangecount24month',Ran139);
Scoring_QA.Range_function_module_2.range_Function_334(DS2,'assetproppurchasetimeoldest',Ran140);
Scoring_QA.Range_function_module_2.range_Function_335(DS2,'assetproppurchasetimenewest',Ran141);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'assetpropsoldcount12month',Ran142);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'assetpersonalcount',Ran143);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'evictioncount',Ran144);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'evictioncount12month',Ran145);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'lienjudgmentcount12month',Ran146);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'lienjudgmentsmallclaimscount',Ran147);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'lienjudgmentcourtcount',Ran148);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'lienjudgmenttaxcount',Ran149);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'lienjudgmentothercount',Ran150);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'addrchangecount03month',Ran151);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'addrchangecount06month',Ran152);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'phoneinputproblems',Ran153);
Scoring_QA.Range_function_module_2.range_Function_336(DS2,'phoneinputsubjectcount',Ran154);
Scoring_QA.Range_function_module_2.range_Function_337(DS2,'assetpropsaletimeoldest',Ran155);
Scoring_QA.Range_function_module_2.range_Function_337(DS2,'assetpropsaletimenewest',Ran156);
Scoring_QA.Range_function_module_2.range_Function_338(DS2,'assetpropnewestsaleprice',Ran157);
Scoring_QA.Range_function_module_2.range_Function_339(DS2,'assetpropsalepurchaseratio',Ran158);
Scoring_QA.Range_function_module_2.range_Function_339(DS2,'addrinputavmratio12monthprior',Ran159);
Scoring_QA.Range_function_module_2.range_Function_339(DS2,'addrcurrentavmratio12monthprior',Ran160);
Scoring_QA.Range_function_module_2.range_Function_340(DS2,'purchaseactivitycount',Ran161);
Scoring_QA.Range_function_module_2.range_Function_341(DS2,'purchaseactivitydollartotal',Ran162);
Scoring_QA.Range_function_module_2.range_Function_342(DS2,'derogseverityindex',Ran163);
Scoring_QA.Range_function_module_2.range_Function_343(DS2,'derogcount',Ran164);
Scoring_QA.Range_function_module_2.range_Function_344(DS2,'derogtimenewest',Ran165);
Scoring_QA.Range_function_module_2.range_Function_345(DS2,'criminalfelonytimenewest',Ran166);
Scoring_QA.Range_function_module_2.range_Function_345(DS2,'criminalnonfelonytimenewest',Ran167);
Scoring_QA.Range_function_module_2.range_Function_345(DS2,'evictiontimenewest',Ran168);
Scoring_QA.Range_function_module_2.range_Function_346(DS2,'lienjudgmentseverityindex',Ran169);
Scoring_QA.Range_function_module_2.range_Function_347(DS2,'lienjudgmentcount',Ran170);
Scoring_QA.Range_function_module_2.range_Function_348(DS2,'lienjudgmenttimenewest',Ran171);
Scoring_QA.Range_function_module_2.range_Function_349(DS2,'lienjudgmentdollartotal',Ran172);
Scoring_QA.Range_function_module_2.range_Function_350(DS2,'bankruptcytimenewest',Ran173);
Scoring_QA.Range_function_module_2.range_Function_351(DS2,'ssnproblems',Ran174);
Scoring_QA.Range_function_module_2.range_Function_351(DS2,'addrinputproblems',Ran175);
Scoring_QA.Range_function_module_2.range_Function_352(DS2,'addronfilecount',Ran176);
Scoring_QA.Range_function_module_2.range_Function_353(DS2,'addrinputtimeoldest',Ran177);
Scoring_QA.Range_function_module_2.range_Function_354(DS2,'addrinputtimenewest',Ran178);
Scoring_QA.Range_function_module_2.range_Function_355(DS2,'addrinputlengthofres',Ran179);
Scoring_QA.Range_function_module_2.range_Function_356(DS2,'addrinputsubjectcount',Ran180);
Scoring_QA.Range_function_module_2.range_Function_357(DS2,'addrinputtimelastsale',Ran181);
Scoring_QA.Range_function_module_2.range_Function_358(DS2,'addrinputlastsaleprice',Ran182);
Scoring_QA.Range_function_module_2.range_Function_358(DS2,'addrinputtaxvalue',Ran183);
Scoring_QA.Range_function_module_2.range_Function_359(DS2,'addrinputtaxmarketvalue',Ran184);
Scoring_QA.Range_function_module_2.range_Function_360(DS2,'addrinputavmvalue',Ran185);
Scoring_QA.Range_function_module_2.range_Function_361(DS2,'addrinputavmvalue12month',Ran186);
Scoring_QA.Range_function_module_2.range_Function_361(DS2,'addrinputavmvalue60month',Ran187);
Scoring_QA.Range_function_module_2.range_Function_361(DS2,'addrcurrentavmvalue60month',Ran188);
Scoring_QA.Range_function_module_2.range_Function_363(DS2,'addrinputavmratio60monthprior',Ran189);
Scoring_QA.Range_function_module_2.range_Function_364(DS2,'addrinputcountyratio',Ran190);
Scoring_QA.Range_function_module_2.range_Function_365(DS2,'addrinputtractratio',Ran191);
Scoring_QA.Range_function_module_2.range_Function_366(DS2,'addrinputblockratio',Ran192);
Scoring_QA.Range_function_module_2.range_Function_367(DS2,'addrcurrenttimeoldest',Ran193);
Scoring_QA.Range_function_module_2.range_Function_368(DS2,'addrcurrentlengthofres',Ran194);
Scoring_QA.Range_function_module_2.range_Function_369(DS2,'addrcurrenttimelastsale',Ran195);
Scoring_QA.Range_function_module_2.range_Function_370(DS2,'addrcurrentlastsalesprice',Ran196);
Scoring_QA.Range_function_module_2.range_Function_370(DS2,'addrcurrenttaxvalue',Ran197);
Scoring_QA.Range_function_module_2.range_Function_371(DS2,'addrcurrenttaxmarketvalue',Ran198);
Scoring_QA.Range_function_module_2.range_Function_372(DS2,'addrcurrentavmvalue',Ran199);
Scoring_QA.Range_function_module_2.range_Function_372(DS2,'addrcurrentavmvalue12month',Ran200);
Scoring_QA.Range_function_module_2.range_Function_373(DS2,'addrcurrentavmratio60monthprior',Ran201);
Scoring_QA.Range_function_module_2.range_Function_374(DS2,'addrcurrentcountyratio',Ran202);
Scoring_QA.Range_function_module_2.range_Function_375(DS2,'addrcurrenttractratio',Ran203);
Scoring_QA.Range_function_module_2.range_Function_375(DS2,'addrcurrentblockratio',Ran204);
Scoring_QA.Range_function_module_2.range_Function_376(DS2,'addrprevioustimeoldest',Ran205);
Scoring_QA.Range_function_module_2.range_Function_377(DS2,'addrprevioustimenewest',Ran206);
Scoring_QA.Range_function_module_2.range_Function_378(DS2,'addrpreviouslengthofres',Ran207);
Scoring_QA.Range_function_module_2.range_Function_379(DS2,'addrprevioussubjectowned',Ran208);
Scoring_QA.Range_function_module_2.range_Function_380(DS2,'addrpreviousownershipindex',Ran209);
Scoring_QA.Range_function_module_2.range_Function_381(DS2,'addrstabilityindex',Ran210);
Scoring_QA.Range_function_module_2.range_Function_382(DS2,'addrchangecount60month',Ran211);
Scoring_QA.Range_function_module_2.range_Function_383(DS2,'addrlastmovetaxratiodiff',Ran212);
Scoring_QA.Range_function_module_2.range_Function_384(DS2,'addrlastmoveecontrajectory',Ran213);
Scoring_QA.Range_function_module_2.range_Function_385(DS2,'addrlastmoveecontrajectoryindex',Ran214);
Scoring_QA.Range_function_module_2.range_Function_386(DS2,'assetpropcurrenttaxtotal',Ran215);
Scoring_QA.Range_function_module_2.range_Function_387(DS2,'addrinputtaxyr',Ran216);
Scoring_QA.Range_function_module_2.range_Function_387(DS2,'addrcurrenttaxyr',Ran217);

      	ran:= Ran1  + Ran2  + Ran3  + Ran4  + Ran5  + Ran6  + Ran7  + Ran8  + Ran9  + Ran10 +
				           Ran11 + Ran12 + Ran13 + Ran14 + Ran15 + Ran16 + Ran17 + Ran18 + Ran19 + Ran20 +
						       Ran21 + Ran22 + Ran23 + Ran24 + Ran25 + Ran26 + Ran27 + Ran28 + Ran29 + Ran30 +
				           Ran31 + Ran32 + Ran33 + Ran34 + Ran35 + Ran36 + Ran37 + Ran38 + Ran39 + Ran40 +
				           Ran41 + Ran42 + Ran43 + Ran44 + Ran45 + Ran46 + Ran47 + Ran48 + Ran49 + Ran50 +
									 Ran51 + Ran52 + Ran53 + Ran54 + Ran55 + Ran56 + Ran57 + Ran58 + Ran59 + Ran60 +
                   Ran61 + Ran62 + Ran63 + Ran64 + Ran65 + Ran66 + Ran67 + Ran68 + Ran69 + Ran70 + 
                   Ran71 + Ran72 + Ran73 + Ran74 + Ran75 + Ran76 + Ran77 + Ran78 + Ran79 + Ran80 + 
                   Ran81 + Ran82 + Ran83 + Ran84 + Ran85 + Ran86 + Ran94 + Ran95 + Ran96 + Ran97 + Ran98 + Ran99 + Ran100 + 
				           Ran101 + Ran102 + Ran103 + Ran104 + Ran105 + Ran106 + Ran107 + Ran108 + Ran109 + Ran110 + 
									 Ran111 + Ran112 + Ran113 + Ran114 + Ran115 + Ran116 + Ran117 + Ran118 + Ran119 + Ran120 +
									 Ran121 + Ran122 + Ran123 + Ran124 + Ran125 + Ran126 + Ran127 + Ran128 + Ran129 + Ran130 +
				           Ran131 + Ran132 + Ran133 + Ran134 + Ran135 + Ran136 + Ran137 + Ran138 + Ran139 + Ran140 +
				           Ran141 + Ran142 + Ran143 + Ran144 + Ran145 + Ran146 + Ran147 + Ran148 + Ran149 + Ran150 +
                   Ran151 + Ran152 + Ran153 + Ran154 + Ran155 + Ran156 + Ran157 + Ran158 + Ran159 + Ran160 +
                   Ran161 + Ran162 + Ran163 + Ran164 + Ran165 + Ran166 + Ran167 + Ran168 + Ran169 + Ran170 + 
                   Ran171 + Ran172 + Ran173 + Ran174 + Ran175 + Ran176 + Ran177 + Ran178 + Ran179 + Ran180 + 
									 Ran181 + Ran182 + Ran183+Ran184+Ran185+Ran186+Ran187+Ran188+Ran189+Ran190+Ran191+Ran192+Ran193+ 
									 Ran194+Ran195+Ran196+Ran197+Ran198+Ran199+Ran200+Ran201+Ran202+Ran203+Ran204+Ran205+Ran206+Ran207+ 
									 Ran208+Ran209+Ran210+Ran211+Ran212+Ran213+Ran214+Ran215+Ran216+Ran217;
			
								 
					Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'auto_score_name',dis1);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'bankcard_score_name',dis2);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'short_term_lending_score_name',dis3);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'telecommunications_score_name',dis4);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'subjectstabilityprimaryfactor',dis5);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'subjectabilityprimaryfactor',dis6);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'subjectwillingnessprimaryfactor',dis7);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'assetindexprimaryfactor',dis8);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'addrinputdwelltype',dis9);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'addrcurrentdwelltype',dis10);
Scoring_QA.Range_function_module_2.range_Function_distinct_alphanumeric2(DS2,'addrpreviousdwelltype',dis11);

				
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				         dis11;

   	

							 Scoring_QA.Range_function_module.Length_Function(DS2,'did',len1);
							
      len:=len1;
			
				 Scoring_QA.Range_function_module.Distinct_function7(DS2,'did',did1);
	 
	 
	 did_stats:=did1;
	 
			result2_stats:= ran + dis + did_stats;		
		
Scoring_QA.Range_function_module_2.Average_func1(DS2,'auto_score',Ave1);
Scoring_QA.Range_function_module_2.Average_func1(DS2,'bankcard_score',Ave2);
Scoring_QA.Range_function_module_2.Average_func1(DS2,'short_term_lending_score',Ave3);
Scoring_QA.Range_function_module_2.Average_func1(DS2,'telecommunications_score',Ave4);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovidedfirstname',Ave5);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovidedlastname',Ave6);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovidedstreetaddress',Ave7);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovidedcity',Ave8);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovidedstate',Ave9);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovidedzipcode',Ave10);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovidedssn',Ave11);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovideddateofbirth',Ave12);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovidedphone',Ave13);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inputprovidedlexid',Ave14);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectrecordtimeoldest',Ave15);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectrecordtimenewest',Ave16);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectnewestrecord12month',Ave17);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectactivityindex03month',Ave18);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectactivityindex06month',Ave19);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectactivityindex12month',Ave20);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectage',Ave21);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectdeceased',Ave22);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectssncount',Ave23);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectstabilityindex',Ave24);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectabilityindex',Ave25);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'subjectwillingnessindex',Ave26);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'confirmationsubjectfound',Ave27);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'confirmationinputname',Ave28);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'confirmationinputdob',Ave29);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'confirmationinputssn',Ave30);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'confirmationinputaddress',Ave31);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'sourcenonderogprofileindex',Ave32);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'sourcenonderogcount',Ave33);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'sourcenonderogcount03month',Ave34);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'sourcenonderogcount06month',Ave35);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'sourcenonderogcount12month',Ave36);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'sourcecredheadertimeoldest',Ave37);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'sourcecredheadertimenewest',Ave38);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'sourcevoterregistration',Ave39);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'educationattendance',Ave40);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'educationevidence',Ave41);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'educationprogramattended',Ave42);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'educationinstitutionprivate',Ave43);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'educationinstitutionrating',Ave44);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'profliccount',Ave45);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'proflictypecategory',Ave46);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'businessassociation',Ave47);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'businessassociationindex',Ave48);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'businessassociationtimeoldest',Ave49);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'businesstitleleadership',Ave50);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetindex',Ave51);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetownership',Ave52);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetprop',Ave53);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropindex',Ave54);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropevercount',Ave55);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropcurrentcount',Ave56);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropcurrenttaxtotal',Ave57);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetproppurchasecount12month',Ave58);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetproppurchasetimeoldest',Ave59);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetproppurchasetimenewest',Ave60);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropnewestmortgagetype',Ave61);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropeversoldcount',Ave62);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropsoldcount12month',Ave63);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropsaletimeoldest',Ave64);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropsaletimenewest',Ave65);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropnewestsaleprice',Ave66);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpropsalepurchaseratio',Ave67);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpersonal',Ave68);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'assetpersonalcount',Ave69);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'purchaseactivityindex',Ave70);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'purchaseactivitycount',Ave71);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'purchaseactivitydollartotal',Ave72);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'derogseverityindex',Ave73);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'derogcount',Ave74);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'derogcount12month',Ave75);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'derogtimenewest',Ave76);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'criminalfelonycount',Ave77);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'criminalfelonycount12month',Ave78);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'criminalfelonytimenewest',Ave79);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'criminalnonfelonycount',Ave80);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'criminalnonfelonycount12month',Ave81);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'criminalnonfelonytimenewest',Ave82);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'evictioncount',Ave83);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'evictioncount12month',Ave84);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'evictiontimenewest',Ave85);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmentseverityindex',Ave86);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmentcount',Ave87);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmentcount12month',Ave88);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmentsmallclaimscount',Ave89);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmentcourtcount',Ave90);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmenttaxcount',Ave91);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmentforeclosurecount',Ave92);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmentothercount',Ave93);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmenttimenewest',Ave94);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'lienjudgmentdollartotal',Ave95);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'bankruptcycount',Ave96);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'bankruptcycount24month',Ave97);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'bankruptcytimenewest',Ave98);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'bankruptcychapter',Ave99);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'bankruptcystatus',Ave100);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'bankruptcydismissed24month',Ave101);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'shorttermloanrequest',Ave102);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'shorttermloanrequest12month',Ave103);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'shorttermloanrequest24month',Ave104);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inquiryauto12month',Ave105);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inquirybanking12month',Ave106);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inquirytelcom12month',Ave107);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inquirynonshortterm12month',Ave108);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inquiryshortterm12month',Ave109);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'inquirycollections12month',Ave110);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'ssnsubjectcount',Ave111);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'ssndeceased',Ave112);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'ssnproblems',Ave113);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addronfilecount',Ave114);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addronfilecorrectional',Ave115);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addronfilecollege',Ave116);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addronfilehighrisk',Ave117);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputtimeoldest',Ave118);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputtimenewest',Ave119);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputlengthofres',Ave120);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputsubjectcount',Ave121);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputmatchindex',Ave122);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputsubjectowned',Ave123);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputdeedmailing',Ave124);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputownershipindex',Ave125);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputphoneservice',Ave126);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputphonecount',Ave127);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputdwelltypeindex',Ave128);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputdelivery',Ave129);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputtimelastsale',Ave130);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputlastsaleprice',Ave131);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputtaxvalue',Ave132);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputtaxmarketvalue',Ave133);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputavmvalue',Ave134);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputavmvalue12month',Ave135);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputavmratio12monthprior',Ave136);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputavmvalue60month',Ave137);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputavmratio60monthprior',Ave138);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputcountyratio',Ave139);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputtractratio',Ave140);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputblockratio',Ave141);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrinputproblems',Ave142);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrenttimeoldest',Ave143);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrenttimenewest',Ave144);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentlengthofres',Ave145);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentsubjectowned',Ave146);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentdeedmailing',Ave147);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentownershipindex',Ave148);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentphoneservice',Ave149);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentdwelltypeindex',Ave150);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrenttimelastsale',Ave151);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentlastsalesprice',Ave152);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrenttaxvalue',Ave153);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrenttaxmarketvalue',Ave154);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentavmvalue',Ave155);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentavmvalue12month',Ave156);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentavmratio12monthprior',Ave157);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentavmvalue60month',Ave158);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentavmratio60monthprior',Ave159);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentcountyratio',Ave160);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrenttractratio',Ave161);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentblockratio',Ave162);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrcurrentcorrectional',Ave163);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrprevioustimeoldest',Ave164);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrprevioustimenewest',Ave165);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrpreviouslengthofres',Ave166);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrprevioussubjectowned',Ave167);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrpreviousownershipindex',Ave168);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrpreviousdwelltypeindex',Ave169);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrpreviouscorrectional',Ave170);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrstabilityindex',Ave171);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrchangecount03month',Ave172);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrchangecount06month',Ave173);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrchangecount12month',Ave174);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrchangecount24month',Ave175);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrlastmovetaxratiodiff',Ave176);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrlastmoveecontrajectory',Ave177);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'addrlastmoveecontrajectoryindex',Ave178);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'phoneinputproblems',Ave179);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'phoneinputsubjectcount',Ave180);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'phoneinputmobile',Ave181);
Scoring_QA.Range_function_module_2.Average_func2(DS2,'alertregulatorycondition',Ave182);

      
				
      	avearage:= ave1  + ave2  + ave3  + ave4  + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				           ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						       ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27 + ave28 + ave29 + ave30 +
				           ave31 + ave32 + ave33 + ave34 + ave35 + ave36 + ave37 + ave38 + ave39 + ave40 +
				           ave41 + ave42 + ave43 + ave44 + ave45 + ave46 + ave47 + ave48 + ave49 + ave50 +
									 ave51 + ave52 + ave53 + ave54 + ave55 + ave56 + ave57 + ave58 + ave59 + ave60 +
                   ave61 + ave62 + ave63 + ave64 + ave65 + ave66 + ave67 + ave68 + ave69 + ave70 + 
                   ave71 + ave72 + ave73 + ave74 + ave75 + ave76 + ave77 + ave78 + ave79 + ave80 + 
                   ave81 + ave82 + ave83 + ave84 + ave85 + ave86 + ave94 + ave95 + ave96 + ave97 + ave98 + ave99 + ave100 + 
				           ave101 + ave102 + ave103 + ave104 + ave105 + ave106 + ave107 + ave108 + ave109 + ave110 + 
									 ave111 + ave112 + ave113 + ave114 + ave115 + ave116 + ave117 + ave118 + ave119 + ave120 +
									 ave121 + ave122 + ave123 + ave124 + ave125 + ave126 + ave127 + ave128 + ave129 + ave130 +
				           ave131 + ave132 + ave133 + ave134 + ave135 + ave136 + ave137 + ave138 + ave139 + ave140 +
				           ave141 + ave142 + ave143 + ave144 + ave145 + ave146 + ave147 + ave148 + ave149 + ave150 +
                   ave151 + ave152 + ave153 + ave154 + ave155 + ave156 + ave157 + ave158 + ave159 + ave160 +
                   ave161 + ave162 + ave163 + ave164 + ave165 + ave166 + ave167 + ave168 + ave169 + ave170 + 
                   ave171 + ave172 + ave173 + ave174 + ave175 + ave176 + ave177 + ave178 + ave179 + ave180 + 
									 ave181 + ave182;
					
					result4_stats:=avearage;
					
								 // Scoring_QA.Range_function_module.Range_Average_Function_0(DS1,'addrmostrecenttaxdiff',ranav0_1);
											 
											 // ranav0:=ranav0_1;	
											 
									// Scoring_QA.Range_function_module.Range_Average_Function_0(DS2,'addrmostrecenttaxdiff',ranave0_1);
											 
											 // ranave0:=ranave0_1;				 
	

   // result4_stats:=avearage + ranave0;
	 
	 
	  compare_layout_stats := RECORD
		  string file_version;
			string mode;
      string field_name;
      string distribution_type;		
      STRING50 attribute_value; 
			decimal20_4 Count1;
      decimal20_4 file_count;
      decimal20_4 ds_count;

     						
    END;
		
		
		compare_layout_stats func(result4_stats l):=transform
                                         self.file_version:='fcra_rvattributes_v5';
																				 self.mode:='xml';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='fcra_rvattributes_v5';
																				 self.mode:='xml';
																			   self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 
																				 self:=l;
		
		end;
		
		result2_stats_project:= project(result2_stats,func1(left));

		compare_layout := RECORD
            		  string file_version;
            			string mode;
                  string field_name;
                  string distribution_type;
            			decimal20_4 p_file_count;
                  decimal20_4 c_file_count;
                  decimal20_4 file_count_diff;
									decimal20_4 matched_file_count;
                  STRING50 attribute_value; 
                  decimal20_4 p_frequency;
                  decimal20_4 c_frequency;
                  decimal20_4 frequency_diff;
            			decimal20_4 perc_frequency_diff;
               	  decimal20_4 p_proportion;
                  decimal20_4 c_proportion;
                  decimal20_4 proportion_diff;
            			decimal20_4 abs_proportion_diff;
            			decimal20_4 perc_proportion_diff;
            			decimal20_4 PSI;
            								
                        END;	

		  did_results := DATASET([{'fcra_rvattributes_v5','xml','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;