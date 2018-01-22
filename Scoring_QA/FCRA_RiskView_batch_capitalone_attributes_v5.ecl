EXPORT FCRA_RiskView_batch_capitalone_attributes_v5 (route,current_dt,previous_dt) := functionmacro

import Scoring_Project_Macros, deurlein_Jon, scoring_project_pip;

// previous_dt := '20160803';
// Current_dt := '20160804';

 file1_2:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V5_BATCH_CapOne_outfile + previous_dt ,
								Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Capone_allflagships_Attributes_V5_Batch_Layout,thor);

 // file1:= dataset( scoring_project_pip.Output_Sample_Names.RV_Attributes_V5_XML_Generic_outfile + previous_dt + '_1',
								// Deurlein_Jon.Riskview_Layout.lay,thor);

 file2_2:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Attributes_V5_BATCH_CapOne_outfile + current_dt , 
								Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Capone_allflagships_Attributes_V5_Batch_Layout,thor);
								
 // file2:= dataset( scoring_project_pip.Output_Sample_Names.RV_Attributes_V5_XML_Generic_outfile + current_dt + '_1', 
								// Deurlein_Jon.Riskview_Layout.lay,thor);

 	   file1 := file1_2(errorcode='');
file2 := file2_2(errorcode='');

aa1:=join(file1,file2,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');


DS1:=join(file1,aa,left.acctno=right.acctno,inner);
DS2:=join(file2,aa,left.acctno=right.acctno,inner);

                           
                              Missing_values:= JOIN(DS2,DS1,LEFT.acctno=RIGHT.acctno and LEFT.did!=RIGHT.did,local);
																												

													
	pfc := count(ds1);
  cfc := count(DS2);
	 
  fcd :=cfc-pfc;
pf:=count(Missing_values);
cf:=count(Missing_values);

pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
abd:=abs(pd);
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);
	 
	 
					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric2(DS2, 'auto_score_name', ran1);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_300(DS2, 'auto_score', ran2);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'auto_reason1', ran3);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'auto_reason2', ran4);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'auto_reason3', ran5);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'auto_reason4', ran6);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'auto_reason5', ran7);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'bankcard_index', ran8);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric2(DS2, 'bankcard_score_name', ran9);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_302(DS2, 'bankcard_score', ran10);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'bankcard_reason1', ran11);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'bankcard_reason2', ran12);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'bankcard_reason3', ran13);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'bankcard_reason4', ran14);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'bankcard_reason5', ran15);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'short_term_lending_index', ran16);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric2(DS2, 'short_term_lending_score_name', ran17);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_303(DS2, 'short_term_lending_score', ran18);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'short_term_lending_reason1', ran19);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'short_term_lending_reason2', ran20);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'short_term_lending_reason3', ran21);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'short_term_lending_reason4', ran22);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'short_term_lending_reason5', ran23);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'telecommunications_index', ran24);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric2(DS2, 'telecommunications_score_name', ran25);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_304(DS2, 'telecommunications_score', ran26);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'telecommunications_reason1', ran27);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'telecommunications_reason2', ran28);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'telecommunications_reason3', ran29);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'telecommunications_reason4', ran30);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'telecommunications_reason5', ran31);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'custom_index', ran32);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'custom_score_name', ran33);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_305(DS2, 'custom_score', ran34);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'custom_reason1', ran35);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'custom_reason2', ran36);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'custom_reason3', ran37);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'custom_reason4', ran38);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'custom_reason5', ran39);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_301(DS2, 'attribute_index', ran40);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_306(DS2, 'inputprovidedfirstname', ran41);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_306(DS2, 'inputprovidedlastname', ran42);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_306(DS2, 'inputprovidedstreetaddress', ran43);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_306(DS2, 'inputprovidedcity', ran44);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_306(DS2, 'inputprovidedstate', ran45);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_306(DS2, 'inputprovidedzipcode', ran46);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_307(DS2, 'inputprovidedssn', ran47);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_308(DS2, 'inputprovideddateofbirth', ran48);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_306(DS2, 'inputprovidedphone', ran49);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_309(DS2, 'inputprovidedlexid', ran50);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_310(DS2, 'subjectrecordtimeoldest', ran51);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_311(DS2, 'subjectrecordtimenewest', ran52);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'subjectnewestrecord12month', ran53);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_313(DS2, 'subjectactivityindex03month', ran54);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_313(DS2, 'subjectactivityindex06month', ran55);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_313(DS2, 'subjectactivityindex12month', ran56);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_314(DS2, 'subjectage', ran57);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'subjectdeceased', ran58);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_315(DS2, 'subjectssncount', ran59);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_316(DS2, 'subjectstabilityindex', ran60);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric(DS2, 'subjectstabilityprimaryfactor', ran61);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_317(DS2, 'subjectabilityindex', ran62);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric(DS2, 'subjectabilityprimaryfactor', ran63);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_318(DS2, 'subjectwillingnessindex', ran64);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric(DS2, 'subjectwillingnessprimaryfactor', ran65);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_319(DS2, 'confirmationsubjectfound', ran66);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_320(DS2, 'confirmationinputname', ran67);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_321(DS2, 'confirmationinputdob', ran68);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_320(DS2, 'confirmationinputssn', ran69);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'confirmationinputaddress', ran70);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_322(DS2, 'sourcenonderogprofileindex', ran71);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_323(DS2, 'sourcenonderogcount', ran72);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_324(DS2, 'sourcenonderogcount03month', ran73);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_324(DS2, 'sourcenonderogcount06month', ran74);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_324(DS2, 'sourcenonderogcount12month', ran75);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_325(DS2, 'sourcecredheadertimeoldest', ran76);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_311(DS2, 'sourcecredheadertimenewest', ran77);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'sourcevoterregistration', ran78);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'educationattendance', ran79);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'educationevidence', ran80);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_320(DS2, 'educationprogramattended', ran81);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'educationinstitutionprivate', ran82);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_326(DS2, 'educationinstitutionrating', ran83);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_327(DS2, 'profliccount', ran84);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_328(DS2, 'proflictypecategory', ran85);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'businessassociation', ran86);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_320(DS2, 'businessassociationindex', ran87);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_329(DS2, 'businessassociationtimeoldest', ran88);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_330(DS2, 'businesstitleleadership', ran89);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_331(DS2, 'assetindex', ran90);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric(DS2, 'assetindexprimaryfactor', ran91);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'assetownership', ran92);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'assetprop', ran93);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_332(DS2, 'assetpropindex', ran94);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_333(DS2, 'assetpropevercount', ran95);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_333(DS2, 'assetpropcurrentcount', ran96);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_386(DS2, 'assetpropcurrenttaxtotal', ran97);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_327(DS2, 'assetproppurchasecount12month', ran98);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_334(DS2, 'assetproppurchasetimeoldest', ran99);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_335(DS2, 'assetproppurchasetimenewest', ran100);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_330(DS2, 'assetpropnewestmortgagetype', ran101);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_333(DS2, 'assetpropeversoldcount', ran102);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'assetpropsoldcount12month', ran103);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_337(DS2, 'assetpropsaletimeoldest', ran104);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_337(DS2, 'assetpropsaletimenewest', ran105);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_338(DS2, 'assetpropnewestsaleprice', ran106);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_339(DS2, 'assetpropsalepurchaseratio', ran107);				
							Scoring_QA.Range_function_module_2.range_Function_339(DS2,'assetpropsalepurchaseratio',ran107);

Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'assetpersonal', ran108);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'assetpersonalcount', ran109);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_320(DS2, 'purchaseactivityindex', ran110);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_340(DS2, 'purchaseactivitycount', ran111);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_341(DS2, 'purchaseactivitydollartotal', ran112);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_342(DS2, 'derogseverityindex', ran113);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_343(DS2, 'derogcount', ran114);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_327(DS2, 'derogcount12month', ran115);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_344(DS2, 'derogtimenewest', ran116);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_327(DS2, 'criminalfelonycount', ran117);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_327(DS2, 'criminalfelonycount12month', ran118);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_345(DS2, 'criminalfelonytimenewest', ran119);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_327(DS2, 'criminalnonfelonycount', ran120);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_327(DS2, 'criminalnonfelonycount12month', ran121);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_345(DS2, 'criminalnonfelonytimenewest', ran122);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'evictioncount', ran123);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'evictioncount12month', ran124);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_345(DS2, 'evictiontimenewest', ran125);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_346(DS2, 'lienjudgmentseverityindex', ran126);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_347(DS2, 'lienjudgmentcount', ran127);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'lienjudgmentcount12month', ran128);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'lienjudgmentsmallclaimscount', ran129);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'lienjudgmentcourtcount', ran130);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'lienjudgmenttaxcount', ran131);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'lienjudgmentforeclosurecount', ran132);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'lienjudgmentothercount', ran133);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_348(DS2, 'lienjudgmenttimenewest', ran134);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_349(DS2, 'lienjudgmentdollartotal', ran135);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_327(DS2, 'bankruptcycount', ran136);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_327(DS2, 'bankruptcycount24month', ran137);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_350(DS2, 'bankruptcytimenewest', ran138);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_330(DS2, 'bankruptcychapter', ran139);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_330(DS2, 'bankruptcystatus', ran140);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'bankruptcydismissed24month', ran141);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'shorttermloanrequest', ran142);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'shorttermloanrequest12month', ran143);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'shorttermloanrequest24month', ran144);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'inquiryauto12month', ran145);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'inquirybanking12month', ran146);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'inquirytelcom12month', ran147);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'inquirynonshortterm12month', ran148);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'inquiryshortterm12month', ran149);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'inquirycollections12month', ran150);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_315(DS2, 'ssnsubjectcount', ran151);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'ssndeceased', ran152);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_351(DS2, 'ssnproblems', ran154);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_352(DS2, 'addronfilecount', ran155);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addronfilecorrectional', ran156);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addronfilecollege', ran157);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addronfilehighrisk', ran158);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_353(DS2, 'addrinputtimeoldest', ran159);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_354(DS2, 'addrinputtimenewest', ran160);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_355(DS2, 'addrinputlengthofres', ran161);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_356(DS2, 'addrinputsubjectcount', ran162);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_330(DS2, 'addrinputmatchindex', ran163);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addrinputsubjectowned', ran164);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addrinputdeedmailing', ran165);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_332(DS2, 'addrinputownershipindex', ran166);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addrinputphoneservice', ran167);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_333(DS2, 'addrinputphonecount', ran168);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric(DS2, 'addrinputdwelltype', ran169);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_320(DS2, 'addrinputdwelltypeindex', ran170);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_332(DS2, 'addrinputdelivery', ran171);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_357(DS2, 'addrinputtimelastsale', ran172);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_358(DS2, 'addrinputlastsaleprice', ran173);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_358(DS2, 'addrinputtaxvalue', ran174);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_387(DS2, 'addrinputtaxyr', ran175);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_359(DS2, 'addrinputtaxmarketvalue', ran176);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_360(DS2, 'addrinputavmvalue', ran177);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_361(DS2, 'addrinputavmvalue12month', ran178);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_339(DS2, 'addrinputavmratio12monthprior', ran179);					
						Scoring_QA.Range_function_module_2.range_Function_339(DS2,'addrinputavmratio12monthprior',ran179);
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_361(DS2, 'addrinputavmvalue60month', ran180);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_363(DS2, 'addrinputavmratio60monthprior', ran181);					
					Scoring_QA.Range_function_module_2.range_Function_363(DS2,'addrinputavmratio60monthprior',ran181);

// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_364(DS2, 'addrinputcountyratio', ran182);					
					Scoring_QA.Range_function_module_2.range_Function_364(DS2,'addrinputcountyratio',ran182);

Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_365(DS2, 'addrinputtractratio', ran183);		
							// Scoring_QA.Range_function_module_2.range_Function_365(DS2,'addrinputtractratio',183);
	
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_366(DS2, 'addrinputblockratio', ran184);					
					Scoring_QA.Range_function_module_2.range_Function_366(DS2,'addrinputblockratio',ran184);

Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_351(DS2, 'addrinputproblems', ran185);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_367(DS2, 'addrcurrenttimeoldest', ran186);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_311(DS2, 'addrcurrenttimenewest', ran187);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_368(DS2, 'addrcurrentlengthofres', ran188);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addrcurrentsubjectowned', ran189);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addrcurrentdeedmailing', ran190);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_332(DS2, 'addrcurrentownershipindex', ran191);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addrcurrentphoneservice', ran192);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric(DS2, 'addrcurrentdwelltype', ran193);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_320(DS2, 'addrcurrentdwelltypeindex', ran194);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_369(DS2, 'addrcurrenttimelastsale', ran195);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_370(DS2, 'addrcurrentlastsalesprice', ran196);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_370(DS2, 'addrcurrenttaxvalue', ran197);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_387(DS2, 'addrcurrenttaxyr', ran198);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_371(DS2, 'addrcurrenttaxmarketvalue', ran199);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_372(DS2, 'addrcurrentavmvalue', ran200);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_372(DS2, 'addrcurrentavmvalue12month', ran201);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_339(DS2, 'addrcurrentavmratio12monthprior', ran202);					
						Scoring_QA.Range_function_module_2.range_Function_339(DS2,'addrcurrentavmratio12monthprior',ran202);

Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_361(DS2, 'addrcurrentavmvalue60month', ran203);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_373(DS2, 'addrcurrentavmratio60monthprior', ran204);					
					Scoring_QA.Range_function_module_2.range_Function_373(DS2,'addrcurrentavmratio60monthprior',ran204);

// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_374(DS2, 'addrcurrentcountyratio', ran205);					
					Scoring_QA.Range_function_module_2.range_Function_374(DS2,'addrcurrentcountyratio',ran205);

// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_375(DS2, 'addrcurrenttractratio', ran206);					
					Scoring_QA.Range_function_module_2.range_Function_375(DS2,'addrcurrenttractratio',ran206);

// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_375(DS2, 'addrcurrentblockratio', ran207);	
								Scoring_QA.Range_function_module_2.range_Function_375(DS2,'addrcurrentblockratio',ran207);
	
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addrcurrentcorrectional', ran208);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_376(DS2, 'addrprevioustimeoldest', ran209);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_377(DS2, 'addrprevioustimenewest', ran210);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_378(DS2, 'addrpreviouslengthofres', ran211);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_379(DS2, 'addrprevioussubjectowned', ran212);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_380(DS2, 'addrpreviousownershipindex', ran213);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_distinct_alphanumeric(DS2, 'addrpreviousdwelltype', ran214);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_320(DS2, 'addrpreviousdwelltypeindex', ran215);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'addrpreviouscorrectional', ran216);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_381(DS2, 'addrstabilityindex', ran217);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'addrchangecount03month', ran218);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'addrchangecount06month', ran219);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_333(DS2, 'addrchangecount12month', ran220);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_333(DS2, 'addrchangecount24month', ran221);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_382(DS2, 'addrchangecount60month', ran222);					
// Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_383(DS2, 'addrlastmovetaxratiodiff', ran223);
									Scoring_QA.Range_function_module_2.range_Function_383(DS2,'addrlastmovetaxratiodiff',ran223);

Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_384(DS2, 'addrlastmoveecontrajectory', ran224);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_385(DS2, 'addrlastmoveecontrajectoryindex', ran225);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'phoneinputproblems', ran226);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_336(DS2, 'phoneinputsubjectcount', ran227);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_312(DS2, 'phoneinputmobile', ran228);					
Deurlein_Jon.Functions_Module_RV5_BSS.range_Function_307(DS2, 'alertregulatorycondition', ran229);					
								
					
RV5 :=  ran9 + ran10 + ran11 + ran12 + ran13 + ran14 + ran15 +  ran40 + ran41 + ran42 + ran43 + 
			 ran44 + ran45 + ran46 + ran47 + ran48 + ran49 + ran50 + ran51 + ran52 + ran53 + ran54 + ran55 + ran56 + ran57 + ran58 + ran59 + ran60 + ran61 + ran62 + ran63 + ran64 + 
			 ran65 + ran66 + ran67 + ran68 + ran69 + ran70 + ran71 + ran72 + ran73 + ran74 + ran75 + ran76 + ran77 + ran78 + ran79 + ran80 + ran81 + ran82 + ran83 + ran84 + ran85 + 
			 ran86 + ran87 + ran88 + ran89 + ran90 + ran91 + ran92 + ran93 + ran94 + ran95 + ran96 + ran97 + ran98 + ran99 + ran100 + ran101 + ran102 + ran103 + ran104 + ran105 + 
			 ran106 + ran107 + ran108 + ran109 + ran110 + ran111 + ran112 + ran113 + ran114 + ran115 + ran116 + ran117 + ran118 + ran119 + ran120 + ran121 + ran122 + ran123 + ran124 + 
			 ran125 + ran126 + ran127 + ran128 + ran129 + ran130 + ran131 + ran132 + ran133 + ran134 + ran135 + ran136 + ran137 + ran138 + ran139 + ran140 + ran141 + ran142 + ran143 + 
			 ran144 + ran145 + ran146 + ran147 + ran148 + ran149 + ran150 + ran151 + ran152 + ran154 + ran155 + ran156 + ran157 + ran158 + ran159 + ran160 + ran161 + ran162 + ran163 + 
			 ran164 + ran165 + ran166 + ran167 + ran168 + ran169 + ran170 + ran171 + ran172 + ran173 + ran174 + ran175 + ran176 + ran177 + ran178 + ran179 + ran180 + ran181 + ran182 + 
			 ran183 + ran184 + ran185 + ran186 + ran187 + ran188 + ran189 + ran190 + ran191 + ran192 + ran193 + ran194 + ran195 + ran196 + ran197 + ran198 + ran199 + ran200 + ran201 + 
			 ran202 + ran203 + ran204 + ran205 + ran206 + ran207 + ran208 + ran209 + ran210 + ran211 + ran212 + ran213 + ran214 + ran215 + ran216 + ran217 + ran218 + ran219 + ran220 + 
			 ran221 + ran222 + ran223 + ran224 + ran225 + ran226 + ran227 + ran228 + ran229 ; 								
 
  // Deurlein_Jon.Functions_Module_RV5_BSS.Average_func1(DS2, 'auto_score', ave_1);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func1(DS2, 'bankcard_score', ave_2);
 // Deurlein_Jon.Functions_Module_RV5_BSS.Average_func1(DS2, 'short_term_lending_score', ave_3);
 // Deurlein_Jon.Functions_Module_RV5_BSS.Average_func1(DS2, 'telecommunications_score', ave_4);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovidedfirstname', ave_5);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovidedlastname', ave_6);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovidedstreetaddress', ave_7);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovidedcity', ave_8);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovidedstate', ave_9);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovidedzipcode', ave_10);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovidedssn', ave_11);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovideddateofbirth', ave_12);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovidedphone', ave_13);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inputprovidedlexid', ave_14);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectrecordtimeoldest', ave_15);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectrecordtimenewest', ave_16);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectnewestrecord12month', ave_17);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectactivityindex03month', ave_18);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectactivityindex06month', ave_19);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectactivityindex12month', ave_20);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectage', ave_21);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectdeceased', ave_22);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectssncount', ave_23);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectstabilityindex', ave_24);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectabilityindex', ave_25);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'subjectwillingnessindex', ave_26);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'confirmationsubjectfound', ave_27);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'confirmationinputname', ave_28);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'confirmationinputdob', ave_29);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'confirmationinputssn', ave_30);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'confirmationinputaddress', ave_31);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'sourcenonderogprofileindex', ave_32);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'sourcenonderogcount', ave_33);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'sourcenonderogcount03month', ave_34);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'sourcenonderogcount06month', ave_35);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'sourcenonderogcount12month', ave_36);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'sourcecredheadertimeoldest', ave_37);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'sourcecredheadertimenewest', ave_38);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'sourcevoterregistration', ave_39);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'educationattendance', ave_40);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'educationevidence', ave_41);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'educationprogramattended', ave_42);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'educationinstitutionprivate', ave_43);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'educationinstitutionrating', ave_44);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'profliccount', ave_45);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'proflictypecategory', ave_46);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'businessassociation', ave_47);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'businessassociationindex', ave_48);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'businessassociationtimeoldest', ave_49);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'businesstitleleadership', ave_50);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetindex', ave_51);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetownership', ave_52);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetprop', ave_53);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropindex', ave_54);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropevercount', ave_55);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropcurrentcount', ave_56);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropcurrenttaxtotal', ave_57);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetproppurchasecount12month', ave_58);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetproppurchasetimeoldest', ave_59);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetproppurchasetimenewest', ave_60);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropnewestmortgagetype', ave_61);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropeversoldcount', ave_62);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropsoldcount12month', ave_63);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropsaletimeoldest', ave_64);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropsaletimenewest', ave_65);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropnewestsaleprice', ave_66);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpropsalepurchaseratio', ave_67);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpersonal', ave_68);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'assetpersonalcount', ave_69);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'purchaseactivityindex', ave_70);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'purchaseactivitycount', ave_71);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'purchaseactivitydollartotal', ave_72);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'derogseverityindex', ave_73);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'derogcount', ave_74);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'derogcount12month', ave_75);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'derogtimenewest', ave_76);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'criminalfelonycount', ave_77);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'criminalfelonycount12month', ave_78);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'criminalfelonytimenewest', ave_79);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'criminalnonfelonycount', ave_80);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'criminalnonfelonycount12month', ave_81);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'criminalnonfelonytimenewest', ave_82);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'evictioncount', ave_83);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'evictioncount12month', ave_84);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'evictiontimenewest', ave_85);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmentseverityindex', ave_86);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmentcount', ave_87);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmentcount12month', ave_88);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmentsmallclaimscount', ave_89);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmentcourtcount', ave_90);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmenttaxcount', ave_91);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmentforeclosurecount', ave_92);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmentothercount', ave_93);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmenttimenewest', ave_94);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'lienjudgmentdollartotal', ave_95);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'bankruptcycount', ave_96);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'bankruptcycount24month', ave_97);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'bankruptcytimenewest', ave_98);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'bankruptcychapter', ave_99);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'bankruptcystatus', ave_100);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'bankruptcydismissed24month', ave_101);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'shorttermloanrequest', ave_102);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'shorttermloanrequest12month', ave_103);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'shorttermloanrequest24month', ave_104);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inquiryauto12month', ave_105);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inquirybanking12month', ave_106);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inquirytelcom12month', ave_107);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inquirynonshortterm12month', ave_108);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inquiryshortterm12month', ave_109);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'inquirycollections12month', ave_110);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'ssnsubjectcount', ave_111);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'ssndeceased', ave_112);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'ssnproblems', ave_113);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addronfilecount', ave_114);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addronfilecorrectional', ave_115);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addronfilecollege', ave_116);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addronfilehighrisk', ave_117);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputtimeoldest', ave_118);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputtimenewest', ave_119);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputlengthofres', ave_120);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputsubjectcount', ave_121);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputmatchindex', ave_122);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputsubjectowned', ave_123);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputdeedmailing', ave_124);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputownershipindex', ave_125);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputphoneservice', ave_126);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputphonecount', ave_127);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputdwelltypeindex', ave_128);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputdelivery', ave_129);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputtimelastsale', ave_130);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputlastsaleprice', ave_131);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputtaxvalue', ave_132);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputtaxmarketvalue', ave_133);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputavmvalue', ave_134);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputavmvalue12month', ave_135);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputavmratio12monthprior', ave_136);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputavmvalue60month', ave_137);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputavmratio60monthprior', ave_138);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputcountyratio', ave_139);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputtractratio', ave_140);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputblockratio', ave_141);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrinputproblems', ave_142);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrenttimeoldest', ave_143);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrenttimenewest', ave_144);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentlengthofres', ave_145);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentsubjectowned', ave_146);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentdeedmailing', ave_147);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentownershipindex', ave_148);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentphoneservice', ave_149);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentdwelltypeindex', ave_150);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrenttimelastsale', ave_151);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentlastsalesprice', ave_152);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrenttaxvalue', ave_153);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrenttaxmarketvalue', ave_154);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentavmvalue', ave_155);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentavmvalue12month', ave_156);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentavmratio12monthprior', ave_157);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentavmvalue60month', ave_158);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentavmratio60monthprior', ave_159);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentcountyratio', ave_160);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrenttractratio', ave_161);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentblockratio', ave_162);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrcurrentcorrectional', ave_163);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrprevioustimeoldest', ave_164);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrprevioustimenewest', ave_165);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrpreviouslengthofres', ave_166);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrprevioussubjectowned', ave_167);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrpreviousownershipindex', ave_168);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrpreviousdwelltypeindex', ave_169);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrpreviouscorrectional', ave_170);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrstabilityindex', ave_171);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrchangecount03month', ave_172);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrchangecount06month', ave_173);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrchangecount12month', ave_174);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrchangecount24month', ave_175);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrlastmovetaxratiodiff', ave_176);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrlastmoveecontrajectory', ave_177);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'addrlastmoveecontrajectoryindex', ave_178);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'phoneinputproblems', ave_179);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'phoneinputsubjectcount', ave_180);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'phoneinputmobile', ave_181);
 Deurlein_Jon.Functions_Module_RV5_BSS.Average_func2(DS2, 'alertregulatorycondition', ave_182);

 
 
average :=  ave_2 + ave_5 + ave_6 + ave_7 + ave_8 + ave_9 + ave_10 + ave_11 + ave_12 + ave_13 + ave_14 + ave_15 + ave_16 + ave_17 + ave_18 + ave_19 + 
					 ave_20 + ave_21 + ave_22 + ave_23 + ave_24 + ave_25 + ave_26 + ave_27 + ave_28 + ave_29 + ave_30 + ave_31 + ave_32 + ave_33 + ave_34 + ave_35 + ave_36 + ave_37 + 
					 ave_38 + ave_39 + ave_40 + ave_41 + ave_42 + ave_43 + ave_44 + ave_45 + ave_46 + ave_47 + ave_48 + ave_49 + ave_50 + ave_51 + ave_52 + ave_53 + ave_54 + ave_55 + 
					 ave_56 + ave_57 + ave_58 + ave_59 + ave_60 + ave_61 + ave_62 + ave_63 + ave_64 + ave_65 + ave_66 + ave_67 + ave_68 + ave_69 + ave_70 + ave_71 + ave_72 + ave_73 + 
					 ave_74 + ave_75 + ave_76 + ave_77 + ave_78 + ave_79 + ave_80 + ave_81 + ave_82 + ave_83 + ave_84 + ave_85 + ave_86 + ave_87 + ave_88 + ave_89 + ave_90 + ave_91 + 
					 ave_92 + ave_93 + ave_94 + ave_95 + ave_96 + ave_97 + ave_98 + ave_99 + ave_100 + ave_101 + ave_102 + ave_103 + ave_104 + ave_105 + ave_106 + ave_107 + ave_108 + 
					 ave_109 + ave_110 + ave_111 + ave_112 + ave_113 + ave_114 + ave_115 + ave_116 + ave_117 + ave_118 + ave_119 + ave_120 + ave_121 + ave_122 + ave_123 + ave_124 + 
					 ave_125 + ave_126 + ave_127 + ave_128 + ave_129 + ave_130 + ave_131 + ave_132 + ave_133 + ave_134 + ave_135 + ave_136 + ave_137 + ave_138 + ave_139 + ave_140 + 
					 ave_141 + ave_142 + ave_143 + ave_144 + ave_145 + ave_146 + ave_147 + ave_148 + ave_149 + ave_150 + ave_151 + ave_152 + ave_153 + ave_154 + ave_155 + ave_156 + 
					 ave_157 + ave_158 + ave_159 + ave_160 + ave_161 + ave_162 + ave_163 + ave_164 + ave_165 + ave_166 + ave_167 + ave_168 + ave_169 + ave_170 + ave_171 + ave_172 + 
					 ave_173 + ave_174 + ave_175 + ave_176 + ave_177 + ave_178 + ave_179 + ave_180 + ave_181 + ave_182 ;


	 result2_stats := RV5;
   result4_stats := average;
	 
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
                                         self.file_version:='RISKVIEW_v5_capone_prescreen';
																				 self.mode:='batch';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(DS2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	


compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='RISKVIEW_v5_capone_prescreen';
																				 self.mode:='batch';
																			   self.file_count:=count(file2),
																				 self.ds_count:=count(DS2),
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

		  did_results := DATASET([{'RISKVIEW_v5_capone_prescreen','batch','did','<did not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<did not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V5_BATCH_CapOne_outfile[2..] + current_dt ;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V5_BATCH_CapOne_outfile[2..] + current_dt ;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.RV_Attributes_V5_BATCH_CapOne_outfile[2..] + current_dt ;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10)); 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile, SaveNewFile1,SaveNewFile2,res,res1,res2);


return seq;

endmacro;