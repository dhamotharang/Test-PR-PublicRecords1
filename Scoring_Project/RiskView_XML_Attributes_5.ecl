import Deurlein_Jon, Scoring_Project_Macros;

EXPORT RiskView_XML_Attributes_5(dateyymmdd_curr,dateyymmdd_prev) := functionmacro


 // lay := RECORD
		// Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout; 
// END;

lay := RECORD
  string accountnumber;
  string30 acctno;
  string12 lexid;
  string3 auto_index;
  string30 auto_score_name;
  string3 auto_score;
  string3 auto_reason1;
  string3 auto_reason2;
  string3 auto_reason3;
  string3 auto_reason4;
  string3 auto_reason5;
  string3 bankcard_index;
  string30 bankcard_score_name;
  string3 bankcard_score;
  string3 bankcard_reason1;
  string3 bankcard_reason2;
  string3 bankcard_reason3;
  string3 bankcard_reason4;
  string3 bankcard_reason5;
  string3 short_term_lending_index;
  string30 short_term_lending_score_name;
  string3 short_term_lending_score;
  string3 short_term_lending_reason1;
  string3 short_term_lending_reason2;
  string3 short_term_lending_reason3;
  string3 short_term_lending_reason4;
  string3 short_term_lending_reason5;
  string3 telecommunications_index;
  string30 telecommunications_score_name;
  string3 telecommunications_score;
  string3 telecommunications_reason1;
  string3 telecommunications_reason2;
  string3 telecommunications_reason3;
  string3 telecommunications_reason4;
  string3 telecommunications_reason5;
  string3 custom_index;
  string30 custom_score_name;
  string3 custom_score;
  string3 custom_reason1;
  string3 custom_reason2;
  string3 custom_reason3;
  string3 custom_reason4;
  string3 custom_reason5;
  string3 attribute_index;
  string1 inputprovidedfirstname;
  string1 inputprovidedlastname;
  string1 inputprovidedstreetaddress;
  string1 inputprovidedcity;
  string1 inputprovidedstate;
  string1 inputprovidedzipcode;
  string1 inputprovidedssn;
  string1 inputprovideddateofbirth;
  string1 inputprovidedphone;
  string1 inputprovidedlexid;
  string3 subjectrecordtimeoldest;
  string3 subjectrecordtimenewest;
  string2 subjectnewestrecord12month;
  string2 subjectactivityindex03month;
  string2 subjectactivityindex06month;
  string2 subjectactivityindex12month;
  string3 subjectage;
  string2 subjectdeceased;
  string3 subjectssncount;
  string2 subjectstabilityindex;
  string3 subjectstabilityprimaryfactor;
  string2 subjectabilityindex;
  string3 subjectabilityprimaryfactor;
  string2 subjectwillingnessindex;
  string3 subjectwillingnessprimaryfactor;
  string1 confirmationsubjectfound;
  string2 confirmationinputname;
  string2 confirmationinputdob;
  string2 confirmationinputssn;
  string2 confirmationinputaddress;
  string2 sourcenonderogprofileindex;
  string3 sourcenonderogcount;
  string3 sourcenonderogcount03month;
  string3 sourcenonderogcount06month;
  string3 sourcenonderogcount12month;
  string3 sourcecredheadertimeoldest;
  string3 sourcecredheadertimenewest;
  string2 sourcevoterregistration;
  string2 educationattendance;
  string2 educationevidence;
  string2 educationprogramattended;
  string2 educationinstitutionprivate;
  string2 educationinstitutionrating;
  string3 profliccount;
  string2 proflictypecategory;
  string2 businessassociation;
  string2 businessassociationindex;
  string3 businessassociationtimeoldest;
  string2 businesstitleleadership;
  string2 assetindex;
  string3 assetindexprimaryfactor;
  string2 assetownership;
  string2 assetprop;
  string2 assetpropindex;
  string3 assetpropevercount;
  string3 assetpropcurrentcount;
  string7 assetpropcurrenttaxtotal;
  string3 assetproppurchasecount12month;
  string3 assetproppurchasetimeoldest;
  string3 assetproppurchasetimenewest;
  string2 assetpropnewestmortgagetype;
  string3 assetpropeversoldcount;
  string3 assetpropsoldcount12month;
  string3 assetpropsaletimeoldest;
  string3 assetpropsaletimenewest;
  string7 assetpropnewestsaleprice;
  string5 assetpropsalepurchaseratio;
  string2 assetpersonal;
  string3 assetpersonalcount;
  string2 purchaseactivityindex;
  string3 purchaseactivitycount;
  string7 purchaseactivitydollartotal;
  string2 derogseverityindex;
  string3 derogcount;
  string3 derogcount12month;
  string3 derogtimenewest;
  string3 criminalfelonycount;
  string3 criminalfelonycount12month;
  string2 criminalfelonytimenewest;
  string3 criminalnonfelonycount;
  string3 criminalnonfelonycount12month;
  string2 criminalnonfelonytimenewest;
  string3 evictioncount;
  string3 evictioncount12month;
  string2 evictiontimenewest;
  string2 lienjudgmentseverityindex;
  string3 lienjudgmentcount;
  string3 lienjudgmentcount12month;
  string3 lienjudgmentsmallclaimscount;
  string3 lienjudgmentcourtcount;
  string3 lienjudgmenttaxcount;
  string3 lienjudgmentforeclosurecount;
  string3 lienjudgmentothercount;
  string2 lienjudgmenttimenewest;
  string7 lienjudgmentdollartotal;
  string3 bankruptcycount;
  string3 bankruptcycount24month;
  string3 bankruptcytimenewest;
  string2 bankruptcychapter;
  string2 bankruptcystatus;
  string2 bankruptcydismissed24month;
  string2 shorttermloanrequest;
  string2 shorttermloanrequest12month;
  string2 shorttermloanrequest24month;
  string2 inquiryauto12month;
  string2 inquirybanking12month;
  string2 inquirytelcom12month;
  string2 inquirynonshortterm12month;
  string2 inquiryshortterm12month;
  string2 inquirycollections12month;
  string3 ssnsubjectcount;
  string2 ssndeceased;
  string8 ssndatelowissued;
  string2 ssnproblems;
  string3 addronfilecount;
  string2 addronfilecorrectional;
  string2 addronfilecollege;
  string2 addronfilehighrisk;
  string3 addrinputtimeoldest;
  string3 addrinputtimenewest;
  string3 addrinputlengthofres;
  string3 addrinputsubjectcount;
  string2 addrinputmatchindex;
  string2 addrinputsubjectowned;
  string2 addrinputdeedmailing;
  string2 addrinputownershipindex;
  string2 addrinputphoneservice;
  string3 addrinputphonecount;
  string2 addrinputdwelltype;
  string2 addrinputdwelltypeindex;
  string2 addrinputdelivery;
  string3 addrinputtimelastsale;
  string7 addrinputlastsaleprice;
  string7 addrinputtaxvalue;
  string4 addrinputtaxyr;
  string7 addrinputtaxmarketvalue;
  string7 addrinputavmvalue;
  string7 addrinputavmvalue12month;
  string5 addrinputavmratio12monthprior;
  string7 addrinputavmvalue60month;
  string5 addrinputavmratio60monthprior;
  string5 addrinputcountyratio;
  string5 addrinputtractratio;
  string5 addrinputblockratio;
  string2 addrinputproblems;
  string3 addrcurrenttimeoldest;
  string3 addrcurrenttimenewest;
  string3 addrcurrentlengthofres;
  string2 addrcurrentsubjectowned;
  string2 addrcurrentdeedmailing;
  string2 addrcurrentownershipindex;
  string2 addrcurrentphoneservice;
  string2 addrcurrentdwelltype;
  string2 addrcurrentdwelltypeindex;
  string3 addrcurrenttimelastsale;
  string7 addrcurrentlastsalesprice;
  string7 addrcurrenttaxvalue;
  string4 addrcurrenttaxyr;
  string7 addrcurrenttaxmarketvalue;
  string7 addrcurrentavmvalue;
  string7 addrcurrentavmvalue12month;
  string5 addrcurrentavmratio12monthprior;
  string7 addrcurrentavmvalue60month;
  string5 addrcurrentavmratio60monthprior;
  string5 addrcurrentcountyratio;
  string5 addrcurrenttractratio;
  string5 addrcurrentblockratio;
  string2 addrcurrentcorrectional;
  string3 addrprevioustimeoldest;
  string3 addrprevioustimenewest;
  string3 addrpreviouslengthofres;
  string2 addrprevioussubjectowned;
  string2 addrpreviousownershipindex;
  string2 addrpreviousdwelltype;
  string2 addrpreviousdwelltypeindex;
  string2 addrpreviouscorrectional;
  string2 addrstabilityindex;
  string3 addrchangecount03month;
  string3 addrchangecount06month;
  string3 addrchangecount12month;
  string3 addrchangecount24month;
  string3 addrchangecount60month;
  string5 addrlastmovetaxratiodiff;
  string2 addrlastmoveecontrajectory;
  string2 addrlastmoveecontrajectoryindex;
  string2 phoneinputproblems;
  string3 phoneinputsubjectcount;
  string2 phoneinputmobile;
  string1 alertregulatorycondition;
  string4 alert1;
  string4 alert2;
  string4 alert3;
  string4 alert4;
  string4 alert5;
  string4 alert6;
  string4 alert7;
  string4 alert8;
  string4 alert9;
  string4 alert10;
  string2000 consumerstatementtext;
  string errorcode;
  string6 historydate;
  unsigned6 did;
  boolean fnamepop;
  boolean lnamepop;
  boolean addrpop;
  string1 ssnlength;
  boolean dobpop;
  boolean emailpop;
  boolean ipaddrpop;
  boolean hphnpop;
 END;

	
			
// dateyymmdd_curr := '20160601';
// dateyymmdd_prev := '20160531';

bs_cert_curr := DISTRIBUTE(dataset('~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v5_' + dateyymmdd_curr + '_1', lay,THOR),HASH32(acctno));


bs_cert_prev := DISTRIBUTE(dataset('~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v5_' + dateyymmdd_prev + '_1', lay,THOR),HASH32(acctno));


matched_ds:=join(bs_cert_curr,bs_cert_prev,left.acctno=right.acctno);

matched_ds_filtered:=matched_ds(acctno<>'');


bs_cert:=join(bs_cert_curr,matched_ds_filtered,left.acctno=right.acctno);

// bs_cert := dataset(ut.foreign_prod +  'nmontpetit::out::bs_41_cert_tracking_full_fcra_' + dateyymmdd + '_999999', lay, CSV(QUOTE('"')));


pj := project(bs_cert, TRANSFORM(lay,



//verification
										self := left));
									

																	 
	// mx := max(pj,(integer)pj.disthphoneaddr); 
	// mini := min(pj,(integer)pj.disthphoneaddr); 
	// av := ave(pj,(integer)pj.disthphoneaddr); ;
	// mx;
	// mini;
	// av;
// choosen(Scoring_Project.mac_profile(pj), all);


// verification, business_activity, business_characteristics, firmographic, organizational_structure, sos, bankruptcy, lien_and_judgment, asset_information, public_record
			 // tradeline, inquiryinfo, business_to_executive_link, business_to_person_link, input_characteristics, associates];
			
/*******************************************************************************************************************************************/
//Verification
/*******************************************************************************************************************************************/	
auto_score_name := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'auto_score_name', 'RV5');
auto_score := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_300(pj, 'auto_score', 'RV5');
auto_score_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func1(pj, 'auto_score', 'RV5');
auto_reason1 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'auto_reason1', 'RV5');
auto_reason2 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'auto_reason2', 'RV5');
auto_reason3 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'auto_reason3', 'RV5');
auto_reason4 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'auto_reason4', 'RV5');
auto_reason5 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'auto_reason5', 'RV5');
bankcard_index := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'bankcard_index', 'RV5');
bankcard_score_name := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'bankcard_score_name', 'RV5');
bankcard_score := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_302(pj, 'bankcard_score', 'RV5');
bankcard_score_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func1(pj, 'bankcard_score', 'RV5');
bankcard_reason1 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'bankcard_reason1', 'RV5');
bankcard_reason2 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'bankcard_reason2', 'RV5');
bankcard_reason3 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'bankcard_reason3', 'RV5');
bankcard_reason4 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'bankcard_reason4', 'RV5');
bankcard_reason5 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'bankcard_reason5', 'RV5');
short_term_lending_index := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'short_term_lending_index', 'RV5');
short_term_lending_score_name := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'short_term_lending_score_name', 'RV5');
short_term_lending_score := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_303(pj, 'short_term_lending_score', 'RV5');
short_term_lending_score_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func1(pj, 'short_term_lending_score', 'RV5');
short_term_lending_reason1 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'short_term_lending_reason1', 'RV5');
short_term_lending_reason2 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'short_term_lending_reason2', 'RV5');
short_term_lending_reason3 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'short_term_lending_reason3', 'RV5');
short_term_lending_reason4 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'short_term_lending_reason4', 'RV5');
short_term_lending_reason5 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'short_term_lending_reason5', 'RV5');
telecommunications_index := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'telecommunications_index', 'RV5');
 telecommunications_score_name := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, ' telecommunications_score_name', 'RV5');
telecommunications_score := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_304(pj, 'telecommunications_score', 'RV5');
telecommunications_score_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func1(pj, 'telecommunications_score', 'RV5');
telecommunications_reason1 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'telecommunications_reason1', 'RV5');
telecommunications_reason2 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'telecommunications_reason2', 'RV5');
telecommunications_reason3 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'telecommunications_reason3', 'RV5');
telecommunications_reason4 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'telecommunications_reason4', 'RV5');
telecommunications_reason5 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'telecommunications_reason5', 'RV5');
custom_index := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'custom_index', 'RV5');
custom_score_name := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'custom_score_name', 'RV5');
custom_score := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_305(pj, 'custom_score', 'RV5');
custom_reason1 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'custom_reason1', 'RV5');
custom_reason2 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'custom_reason2', 'RV5');
custom_reason3 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'custom_reason3', 'RV5');
custom_reason4 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'custom_reason4', 'RV5');
custom_reason5 := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'custom_reason5', 'RV5');
attribute_index := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_301(pj, 'attribute_index', 'RV5');
inputprovidedfirstname := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_306(pj, 'inputprovidedfirstname', 'RV5');
inputprovidedfirstname_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovidedfirstname', 'RV5');
inputprovidedlastname := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_306(pj, 'inputprovidedlastname', 'RV5');
inputprovidedlastname_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovidedlastname', 'RV5');
inputprovidedstreetaddress := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_306(pj, 'inputprovidedstreetaddress', 'RV5');
inputprovidedstreetaddress_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovidedstreetaddress', 'RV5');
inputprovidedcity := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_306(pj, 'inputprovidedcity', 'RV5');
inputprovidedcity_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovidedcity', 'RV5');
inputprovidedstate := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_306(pj, 'inputprovidedstate', 'RV5');
inputprovidedstate_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovidedstate', 'RV5');
inputprovidedzipcode := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_306(pj, 'inputprovidedzipcode', 'RV5');
inputprovidedzipcode_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovidedzipcode', 'RV5');
inputprovidedssn := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_307(pj, 'inputprovidedssn', 'RV5');
inputprovidedssn_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovidedssn', 'RV5');
inputprovideddateofbirth := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_308(pj, 'inputprovideddateofbirth', 'RV5');
inputprovideddateofbirth_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovideddateofbirth', 'RV5');
inputprovidedphone := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_306(pj, 'inputprovidedphone', 'RV5');
inputprovidedphone_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovidedphone', 'RV5');
inputprovidedlexid := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_309(pj, 'inputprovidedlexid', 'RV5');
inputprovidedlexid_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inputprovidedlexid', 'RV5');
subjectrecordtimeoldest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_310(pj, 'subjectrecordtimeoldest', 'RV5');
subjectrecordtimeoldest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectrecordtimeoldest', 'RV5');
subjectrecordtimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_311(pj, 'subjectrecordtimenewest', 'RV5');
subjectrecordtimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectrecordtimenewest', 'RV5');
subjectnewestrecord12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'subjectnewestrecord12month', 'RV5');
subjectnewestrecord12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectnewestrecord12month', 'RV5');
subjectactivityindex03month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_313(pj, 'subjectactivityindex03month', 'RV5');
subjectactivityindex3month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectactivityindex03month', 'RV5');
subjectactivityindex06month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_313(pj, 'subjectactivityindex06month', 'RV5');
subjectactivityindex6month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectactivityindex06month', 'RV5');
subjectactivityindex12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_313(pj, 'subjectactivityindex12month', 'RV5');
subjectactivityindex12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectactivityindex12month', 'RV5');
subjectage := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_314(pj, 'subjectage', 'RV5');
subjectage_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectage', 'RV5');
subjectdeceased := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'subjectdeceased', 'RV5');
subjectdeceased_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectdeceased', 'RV5');
subjectssncount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_315(pj, 'subjectssncount', 'RV5');
subjectssncount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectssncount', 'RV5');
subjectstabilityindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_316(pj, 'subjectstabilityindex', 'RV5');
subjectstabilityindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectstabilityindex', 'RV5');
subjectstabilityprimaryfactor := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'subjectstabilityprimaryfactor', 'RV5');
subjectabilityindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_317(pj, 'subjectabilityindex', 'RV5');
subjectabilityindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectabilityindex', 'RV5');
subjectabilityprimaryfactor := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'subjectabilityprimaryfactor', 'RV5');
subjectwillingnessindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_318(pj, 'subjectwillingnessindex', 'RV5');
subjectwillingnessindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'subjectwillingnessindex', 'RV5');
subjectwillingnessprimaryfactor := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'subjectwillingnessprimaryfactor', 'RV5');
confirmationsubjectfound := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_319(pj, 'confirmationsubjectfound', 'RV5');
confirmationsubjectfound_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'confirmationsubjectfound', 'RV5');
confirmationinputname := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_320(pj, 'confirmationinputname', 'RV5');
confirmationinputname_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'confirmationinputname', 'RV5');
confirmationinputdob := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_321(pj, 'confirmationinputdob', 'RV5');
confirmationinputdob_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'confirmationinputdob', 'RV5');
confirmationinputssn := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_320(pj, 'confirmationinputssn', 'RV5');
confirmationinputssn_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'confirmationinputssn', 'RV5');
confirmationinputaddress := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'confirmationinputaddress', 'RV5');
confirmationinputaddress_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'confirmationinputaddress', 'RV5');
sourcenonderogprofileindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_322(pj, 'sourcenonderogprofileindex', 'RV5');
sourcenonderogprofileindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'sourcenonderogprofileindex', 'RV5');
sourcenonderogcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_323(pj, 'sourcenonderogcount', 'RV5');
sourcenonderogcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'sourcenonderogcount', 'RV5');
sourcenonderogcount03month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_324(pj, 'sourcenonderogcount03month', 'RV5');
sourcenonderogcount3month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'sourcenonderogcount03month', 'RV5');
sourcenonderogcount06month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_324(pj, 'sourcenonderogcount06month', 'RV5');
sourcenonderogcount6month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'sourcenonderogcount06month', 'RV5');
sourcenonderogcount12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_324(pj, 'sourcenonderogcount12month', 'RV5');
sourcenonderogcount12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'sourcenonderogcount12month', 'RV5');
sourcecredheadertimeoldest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_325(pj, 'sourcecredheadertimeoldest', 'RV5');
sourcecredheadertimeoldest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'sourcecredheadertimeoldest', 'RV5');
sourcecredheadertimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_311(pj, 'sourcecredheadertimenewest', 'RV5');
sourcecredheadertimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'sourcecredheadertimenewest', 'RV5');
sourcevoterregistration := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'sourcevoterregistration', 'RV5');
sourcevoterregistration_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'sourcevoterregistration', 'RV5');
educationattendance := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'educationattendance', 'RV5');
educationattendance_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'educationattendance', 'RV5');
educationevidence := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'educationevidence', 'RV5');
educationevidence_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'educationevidence', 'RV5');
educationprogramattended := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_320(pj, 'educationprogramattended', 'RV5');
educationprogramattended_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'educationprogramattended', 'RV5');
educationinstitutionprivate := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'educationinstitutionprivate', 'RV5');
educationinstitutionprivate_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'educationinstitutionprivate', 'RV5');
educationinstitutionrating := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_326(pj, 'educationinstitutionrating', 'RV5');
educationinstitutionrating_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'educationinstitutionrating', 'RV5');
profliccount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_327(pj, 'profliccount', 'RV5');
profliccount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'profliccount', 'RV5');
proflictypecategory := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_328(pj, 'proflictypecategory', 'RV5');
proflictypecategory_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'proflictypecategory', 'RV5');
businessassociation := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'businessassociation', 'RV5');
businessassociation_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'businessassociation', 'RV5');
businessassociationindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_320(pj, 'businessassociationindex', 'RV5');
businessassociationindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'businessassociationindex', 'RV5');
businessassociationtimeoldest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_329(pj, 'businessassociationtimeoldest', 'RV5');
businessassociationtimeoldest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'businessassociationtimeoldest', 'RV5');
businesstitleleadership := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_330(pj, 'businesstitleleadership', 'RV5');
businesstitleleadership_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'businesstitleleadership', 'RV5');
assetindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_331(pj, 'assetindex', 'RV5');
assetindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetindex', 'RV5');
assetindexprimaryfactor := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'assetindexprimaryfactor', 'RV5');
assetownership := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'assetownership', 'RV5');
assetownership_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetownership', 'RV5');
assetprop := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'assetprop', 'RV5');
assetprop_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetprop', 'RV5');
assetpropindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_332(pj, 'assetpropindex', 'RV5');
assetpropindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropindex', 'RV5');
assetpropevercount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_333(pj, 'assetpropevercount', 'RV5');
assetpropevercount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropevercount', 'RV5');
assetpropcurrentcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_333(pj, 'assetpropcurrentcount', 'RV5');
assetpropcurrentcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropcurrentcount', 'RV5');
assetpropcurrenttaxtotal := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_386(pj, 'assetpropcurrenttaxtotal', 'RV5');
assetpropcurrenttaxtotal_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropcurrenttaxtotal', 'RV5');
assetproppurchasecount12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_327(pj, 'assetproppurchasecount12month', 'RV5');
assetproppurchasecount12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetproppurchasecount12month', 'RV5');
assetproppurchasetimeoldest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_334(pj, 'assetproppurchasetimeoldest', 'RV5');
assetproppurchasetimeoldest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetproppurchasetimeoldest', 'RV5');
assetproppurchasetimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_335(pj, 'assetproppurchasetimenewest', 'RV5');
assetproppurchasetimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetproppurchasetimenewest', 'RV5');
assetpropnewestmortgagetype := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_330(pj, 'assetpropnewestmortgagetype', 'RV5');
assetpropnewestmortgagetype_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropnewestmortgagetype', 'RV5');
assetpropeversoldcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_333(pj, 'assetpropeversoldcount', 'RV5');
assetpropeversoldcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropeversoldcount', 'RV5');
assetpropsoldcount12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'assetpropsoldcount12month', 'RV5');
assetpropsoldcount12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropsoldcount12month', 'RV5');
assetpropsaletimeoldest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_337(pj, 'assetpropsaletimeoldest', 'RV5');
assetpropsaletimeoldest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropsaletimeoldest', 'RV5');
assetpropsaletimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_337(pj, 'assetpropsaletimenewest', 'RV5');
assetpropsaletimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropsaletimenewest', 'RV5');
assetpropnewestsaleprice := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_338(pj, 'assetpropnewestsaleprice', 'RV5');
assetpropnewestsaleprice_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropnewestsaleprice', 'RV5');
assetpropsalepurchaseratio := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_339(pj, 'assetpropsalepurchaseratio', 'RV5');
assetpropsalepurchaseratio_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpropsalepurchaseratio', 'RV5');
assetpersonal := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'assetpersonal', 'RV5');
assetpersonal_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpersonal', 'RV5');
assetpersonalcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'assetpersonalcount', 'RV5');
assetpersonalcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'assetpersonalcount', 'RV5');
purchaseactivityindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_320(pj, 'purchaseactivityindex', 'RV5');
purchaseactivityindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'purchaseactivityindex', 'RV5');
purchaseactivitycount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_340(pj, 'purchaseactivitycount', 'RV5');
purchaseactivitycount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'purchaseactivitycount', 'RV5');
purchaseactivitydollartotal := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_341(pj, 'purchaseactivitydollartotal', 'RV5');
purchaseactivitydollartotal_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'purchaseactivitydollartotal', 'RV5');
derogseverityindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_342(pj, 'derogseverityindex', 'RV5');
derogseverityindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'derogseverityindex', 'RV5');
derogcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_343(pj, 'derogcount', 'RV5');
derogcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'derogcount', 'RV5');
derogcount12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_327(pj, 'derogcount12month', 'RV5');
derogcount12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'derogcount12month', 'RV5');
derogtimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_344(pj, 'derogtimenewest', 'RV5');
derogtimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'derogtimenewest', 'RV5');
criminalfelonycount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_327(pj, 'criminalfelonycount', 'RV5');
criminalfelonycount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'criminalfelonycount', 'RV5');
criminalfelonycount12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_327(pj, 'criminalfelonycount12month', 'RV5');
criminalfelonycount12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'criminalfelonycount12month', 'RV5');
criminalfelonytimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_345(pj, 'criminalfelonytimenewest', 'RV5');
criminalfelonytimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'criminalfelonytimenewest', 'RV5');
criminalnonfelonycount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_327(pj, 'criminalnonfelonycount', 'RV5');
criminalnonfelonycount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'criminalnonfelonycount', 'RV5');
criminalnonfelonycount12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_327(pj, 'criminalnonfelonycount12month', 'RV5');
criminalnonfelonycount12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'criminalnonfelonycount12month', 'RV5');
criminalnonfelonytimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_345(pj, 'criminalnonfelonytimenewest', 'RV5');
criminalnonfelonytimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'criminalnonfelonytimenewest', 'RV5');
evictioncount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'evictioncount', 'RV5');
evictioncount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'evictioncount', 'RV5');
evictioncount12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'evictioncount12month', 'RV5');
evictioncount12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'evictioncount12month', 'RV5');
evictiontimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_345(pj, 'evictiontimenewest', 'RV5');
evictiontimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'evictiontimenewest', 'RV5');
lienjudgmentseverityindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_346(pj, 'lienjudgmentseverityindex', 'RV5');
lienjudgmentseverityindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmentseverityindex', 'RV5');
lienjudgmentcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_347(pj, 'lienjudgmentcount', 'RV5');
lienjudgmentcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmentcount', 'RV5');
lienjudgmentcount12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'lienjudgmentcount12month', 'RV5');
lienjudgmentcount12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmentcount12month', 'RV5');
lienjudgmentsmallclaimscount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'lienjudgmentsmallclaimscount', 'RV5');
lienjudgmentsmallclaimscount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmentsmallclaimscount', 'RV5');
lienjudgmentcourtcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'lienjudgmentcourtcount', 'RV5');
lienjudgmentcourtcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmentcourtcount', 'RV5');
lienjudgmenttaxcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'lienjudgmenttaxcount', 'RV5');
lienjudgmenttaxcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmenttaxcount', 'RV5');
lienjudgmentforeclosurecount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'lienjudgmentforeclosurecount', 'RV5');
lienjudgmentforeclosurecount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmentforeclosurecount', 'RV5');
lienjudgmentothercount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'lienjudgmentothercount', 'RV5');
lienjudgmentothercount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmentothercount', 'RV5');
lienjudgmenttimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_348(pj, 'lienjudgmenttimenewest', 'RV5');
lienjudgmenttimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmenttimenewest', 'RV5');
lienjudgmentdollartotal := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_349(pj, 'lienjudgmentdollartotal', 'RV5');
lienjudgmentdollartotal_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'lienjudgmentdollartotal', 'RV5');
bankruptcycount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_327(pj, 'bankruptcycount', 'RV5');
bankruptcycount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'bankruptcycount', 'RV5');
bankruptcycount24month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_327(pj, 'bankruptcycount24month', 'RV5');
bankruptcycount24month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'bankruptcycount24month', 'RV5');
bankruptcytimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_350(pj, 'bankruptcytimenewest', 'RV5');
bankruptcytimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'bankruptcytimenewest', 'RV5');
bankruptcychapter := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_330(pj, 'bankruptcychapter', 'RV5');
bankruptcychapter_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'bankruptcychapter', 'RV5');
bankruptcystatus := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_330(pj, 'bankruptcystatus', 'RV5');
bankruptcystatus_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'bankruptcystatus', 'RV5');
bankruptcydismissed24month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'bankruptcydismissed24month', 'RV5');
bankruptcydismissed24month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'bankruptcydismissed24month', 'RV5');
shorttermloanrequest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'shorttermloanrequest', 'RV5');
shorttermloanrequest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'shorttermloanrequest', 'RV5');
shorttermloanrequest12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'shorttermloanrequest12month', 'RV5');
shorttermloanrequest12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'shorttermloanrequest12month', 'RV5');
shorttermloanrequest24month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'shorttermloanrequest24month', 'RV5');
shorttermloanrequest24month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'shorttermloanrequest24month', 'RV5');
inquiryauto12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'inquiryauto12month', 'RV5');
inquiryauto12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inquiryauto12month', 'RV5');
inquirybanking12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'inquirybanking12month', 'RV5');
inquirybanking12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inquirybanking12month', 'RV5');
inquirytelcom12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'inquirytelcom12month', 'RV5');
inquirytelcom12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inquirytelcom12month', 'RV5');
inquirynonshortterm12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'inquirynonshortterm12month', 'RV5');
inquirynonshortterm12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inquirynonshortterm12month', 'RV5');
inquiryshortterm12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'inquiryshortterm12month', 'RV5');
inquiryshortterm12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inquiryshortterm12month', 'RV5');
inquirycollections12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'inquirycollections12month', 'RV5');
inquirycollections12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'inquirycollections12month', 'RV5');
ssnsubjectcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_315(pj, 'ssnsubjectcount', 'RV5');
ssnsubjectcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'ssnsubjectcount', 'RV5');
ssndeceased := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'ssndeceased', 'RV5');
ssndeceased_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'ssndeceased', 'RV5');
ssnproblems := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_351(pj, 'ssnproblems', 'RV5');
ssnproblems_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'ssnproblems', 'RV5');
addronfilecount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_352(pj, 'addronfilecount', 'RV5');
addronfilecount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addronfilecount', 'RV5');
addronfilecorrectional := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addronfilecorrectional', 'RV5');
addronfilecorrectional_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addronfilecorrectional', 'RV5');
addronfilecollege := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addronfilecollege', 'RV5');
addronfilecollege_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addronfilecollege', 'RV5');
addronfilehighrisk := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addronfilehighrisk', 'RV5');
addronfilehighrisk_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addronfilehighrisk', 'RV5');
addrinputtimeoldest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_353(pj, 'addrinputtimeoldest', 'RV5');
addrinputtimeoldest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputtimeoldest', 'RV5');
addrinputtimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_354(pj, 'addrinputtimenewest', 'RV5');
addrinputtimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputtimenewest', 'RV5');
addrinputlengthofres := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_355(pj, 'addrinputlengthofres', 'RV5');
addrinputlengthofres_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputlengthofres', 'RV5');
addrinputsubjectcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_356(pj, 'addrinputsubjectcount', 'RV5');
addrinputsubjectcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputsubjectcount', 'RV5');
addrinputmatchindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_330(pj, 'addrinputmatchindex', 'RV5');
addrinputmatchindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputmatchindex', 'RV5');
addrinputsubjectowned := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addrinputsubjectowned', 'RV5');
addrinputsubjectowned_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputsubjectowned', 'RV5');
addrinputdeedmailing := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addrinputdeedmailing', 'RV5');
addrinputdeedmailing_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputdeedmailing', 'RV5');
addrinputownershipindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_332(pj, 'addrinputownershipindex', 'RV5');
addrinputownershipindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputownershipindex', 'RV5');
addrinputphoneservice := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addrinputphoneservice', 'RV5');
addrinputphoneservice_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputphoneservice', 'RV5');
addrinputphonecount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_333(pj, 'addrinputphonecount', 'RV5');
addrinputphonecount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputphonecount', 'RV5');
addrinputdwelltype := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'addrinputdwelltype', 'RV5');
addrinputdwelltypeindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_320(pj, 'addrinputdwelltypeindex', 'RV5');
addrinputdwelltypeindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputdwelltypeindex', 'RV5');
addrinputdelivery := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_332(pj, 'addrinputdelivery', 'RV5');
addrinputdelivery_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputdelivery', 'RV5');
addrinputtimelastsale := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_357(pj, 'addrinputtimelastsale', 'RV5');
addrinputtimelastsale_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputtimelastsale', 'RV5');
addrinputlastsaleprice := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_358(pj, 'addrinputlastsaleprice', 'RV5');
addrinputlastsaleprice_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputlastsaleprice', 'RV5');
addrinputtaxvalue := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_358(pj, 'addrinputtaxvalue', 'RV5');
addrinputtaxvalue_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputtaxvalue', 'RV5');
addrinputtaxyr := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_387(pj, 'addrinputtaxyr', 'RV5');
addrinputtaxmarketvalue := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_359(pj, 'addrinputtaxmarketvalue', 'RV5');
addrinputtaxmarketvalue_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputtaxmarketvalue', 'RV5');
addrinputavmvalue := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_360(pj, 'addrinputavmvalue', 'RV5');
addrinputavmvalue_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputavmvalue', 'RV5');
addrinputavmvalue12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_361(pj, 'addrinputavmvalue12month', 'RV5');
addrinputavmvalue12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputavmvalue12month', 'RV5');
addrinputavmratio12monthprior := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_339(pj, 'addrinputavmratio12monthprior', 'RV5');
addrinputavmratio12monthprior_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputavmratio12monthprior', 'RV5');
addrinputavmvalue60month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_361(pj, 'addrinputavmvalue60month', 'RV5');
addrinputavmvalue6month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputavmvalue60month', 'RV5');
addrinputavmratio60monthprior := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_363(pj, 'addrinputavmratio60monthprior', 'RV5');
addrinputavmratio6monthprior_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputavmratio60monthprior', 'RV5');
addrinputcountyratio := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_364(pj, 'addrinputcountyratio', 'RV5');
addrinputcountyratio_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputcountyratio', 'RV5');
addrinputtractratio := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_365(pj, 'addrinputtractratio', 'RV5');
addrinputtractratio_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputtractratio', 'RV5');
addrinputblockratio := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_366(pj, 'addrinputblockratio', 'RV5');
addrinputblockratio_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputblockratio', 'RV5');
addrinputproblems := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_351(pj, 'addrinputproblems', 'RV5');
addrinputproblems_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrinputproblems', 'RV5');
addrcurrenttimeoldest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_367(pj, 'addrcurrenttimeoldest', 'RV5');
addrcurrenttimeoldest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrenttimeoldest', 'RV5');
addrcurrenttimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_311(pj, 'addrcurrenttimenewest', 'RV5');
addrcurrenttimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrenttimenewest', 'RV5');
addrcurrentlengthofres := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_368(pj, 'addrcurrentlengthofres', 'RV5');
addrcurrentlengthofres_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentlengthofres', 'RV5');
addrcurrentsubjectowned := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addrcurrentsubjectowned', 'RV5');
addrcurrentsubjectowned_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentsubjectowned', 'RV5');
addrcurrentdeedmailing := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addrcurrentdeedmailing', 'RV5');
addrcurrentdeedmailing_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentdeedmailing', 'RV5');
addrcurrentownershipindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_332(pj, 'addrcurrentownershipindex', 'RV5');
addrcurrentownershipindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentownershipindex', 'RV5');
addrcurrentphoneservice := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addrcurrentphoneservice', 'RV5');
addrcurrentphoneservice_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentphoneservice', 'RV5');
addrcurrentdwelltype := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'addrcurrentdwelltype', 'RV5');
addrcurrentdwelltypeindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_320(pj, 'addrcurrentdwelltypeindex', 'RV5');
addrcurrentdwelltypeindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentdwelltypeindex', 'RV5');
addrcurrenttimelastsale := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_369(pj, 'addrcurrenttimelastsale', 'RV5');
addrcurrenttimelastsale_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrenttimelastsale', 'RV5');
addrcurrentlastsalesprice := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_370(pj, 'addrcurrentlastsalesprice', 'RV5');
addrcurrentlastsalesprice_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentlastsalesprice', 'RV5');
addrcurrenttaxvalue := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_370(pj, 'addrcurrenttaxvalue', 'RV5');
addrcurrenttaxvalue_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrenttaxvalue', 'RV5');
addrcurrenttaxyr := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_387(pj, 'addrcurrenttaxyr', 'RV5');
addrcurrenttaxmarketvalue := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_371(pj, 'addrcurrenttaxmarketvalue', 'RV5');
addrcurrenttaxmarketvalue_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrenttaxmarketvalue', 'RV5');
addrcurrentavmvalue := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_372(pj, 'addrcurrentavmvalue', 'RV5');
addrcurrentavmvalue_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentavmvalue', 'RV5');
addrcurrentavmvalue12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_372(pj, 'addrcurrentavmvalue12month', 'RV5');
addrcurrentavmvalue12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentavmvalue12month', 'RV5');
addrcurrentavmratio12monthprior := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_339(pj, 'addrcurrentavmratio12monthprior', 'RV5');
addrcurrentavmratio12monthprior_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentavmratio12monthprior', 'RV5');
addrcurrentavmvalue60month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_361(pj, 'addrcurrentavmvalue60month', 'RV5');
addrcurrentavmvalue6month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentavmvalue60month', 'RV5');
addrcurrentavmratio60monthprior := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_373(pj, 'addrcurrentavmratio60monthprior', 'RV5');
addrcurrentavmratio6monthprior_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentavmratio60monthprior', 'RV5');
addrcurrentcountyratio := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_374(pj, 'addrcurrentcountyratio', 'RV5');
addrcurrentcountyratio_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentcountyratio', 'RV5');
addrcurrenttractratio := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_375(pj, 'addrcurrenttractratio', 'RV5');
addrcurrenttractratio_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrenttractratio', 'RV5');
addrcurrentblockratio := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_375(pj, 'addrcurrentblockratio', 'RV5');
addrcurrentblockratio_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentblockratio', 'RV5');
addrcurrentcorrectional := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addrcurrentcorrectional', 'RV5');
addrcurrentcorrectional_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrcurrentcorrectional', 'RV5');
addrprevioustimeoldest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_376(pj, 'addrprevioustimeoldest', 'RV5');
addrprevioustimeoldest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrprevioustimeoldest', 'RV5');
addrprevioustimenewest := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_377(pj, 'addrprevioustimenewest', 'RV5');
addrprevioustimenewest_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrprevioustimenewest', 'RV5');
addrpreviouslengthofres := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_378(pj, 'addrpreviouslengthofres', 'RV5');
addrpreviouslengthofres_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrpreviouslengthofres', 'RV5');
addrprevioussubjectowned := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_379(pj, 'addrprevioussubjectowned', 'RV5');
addrprevioussubjectowned_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrprevioussubjectowned', 'RV5');
addrpreviousownershipindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_380(pj, 'addrpreviousownershipindex', 'RV5');
addrpreviousownershipindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrpreviousownershipindex', 'RV5');
addrpreviousdwelltype := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_distinct_alphanumeric2(pj, 'addrpreviousdwelltype', 'RV5');
addrpreviousdwelltypeindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_320(pj, 'addrpreviousdwelltypeindex', 'RV5');
addrpreviousdwelltypeindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrpreviousdwelltypeindex', 'RV5');
addrpreviouscorrectional := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'addrpreviouscorrectional', 'RV5');
addrpreviouscorrectional_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrpreviouscorrectional', 'RV5');
addrstabilityindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_381(pj, 'addrstabilityindex', 'RV5');
addrstabilityindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrstabilityindex', 'RV5');
addrchangecount03month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'addrchangecount03month', 'RV5');
addrchangecount3month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrchangecount03month', 'RV5');
addrchangecount06month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'addrchangecount06month', 'RV5');
addrchangecount6month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrchangecount06month', 'RV5');
addrchangecount12month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_333(pj, 'addrchangecount12month', 'RV5');
addrchangecount12month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrchangecount12month', 'RV5');
addrchangecount24month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_333(pj, 'addrchangecount24month', 'RV5');
addrchangecount24month_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrchangecount24month', 'RV5');
addrchangecount60month := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_382(pj, 'addrchangecount60month', 'RV5');
addrlastmovetaxratiodiff := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_383(pj, 'addrlastmovetaxratiodiff', 'RV5');
addrlastmovetaxratiodiff_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrlastmovetaxratiodiff', 'RV5');
addrlastmoveecontrajectory := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_384(pj, 'addrlastmoveecontrajectory', 'RV5');
addrlastmoveecontrajectory_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrlastmoveecontrajectory', 'RV5');
addrlastmoveecontrajectoryindex := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_385(pj, 'addrlastmoveecontrajectoryindex', 'RV5');
addrlastmoveecontrajectoryindex_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'addrlastmoveecontrajectoryindex', 'RV5');
phoneinputproblems := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'phoneinputproblems', 'RV5');
phoneinputproblems_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'phoneinputproblems', 'RV5');
phoneinputsubjectcount := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_336(pj, 'phoneinputsubjectcount', 'RV5');
phoneinputsubjectcount_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'phoneinputsubjectcount', 'RV5');
phoneinputmobile := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_312(pj, 'phoneinputmobile', 'RV5');
phoneinputmobile_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'phoneinputmobile', 'RV5');
alertregulatorycondition := Deurlein_Jon.Functions_Module_RV_5_0_1.range_Function_307(pj, 'alertregulatorycondition', 'RV5');
alertregulatorycondition_ave := Deurlein_Jon.Functions_Module_RV_5_0_1.Average_func2(pj, 'alertregulatorycondition', 'RV5');


RV5 := auto_score_name + auto_score + auto_score_ave + auto_reason1 + auto_reason2 + auto_reason3 + auto_reason4 + auto_reason5 + bankcard_index + bankcard_score_name + bankcard_score + 
			 bankcard_score_ave + bankcard_reason1 + bankcard_reason2 + bankcard_reason3 + bankcard_reason4 + bankcard_reason5 + short_term_lending_index + short_term_lending_score_name + 
			 short_term_lending_score + short_term_lending_score_ave + short_term_lending_reason1 + short_term_lending_reason2 + short_term_lending_reason3 + short_term_lending_reason4 + 
			 short_term_lending_reason5 + telecommunications_index +  telecommunications_score_name + telecommunications_score + telecommunications_score_ave + telecommunications_reason1 + 
			 telecommunications_reason2 + telecommunications_reason3 + telecommunications_reason4 + telecommunications_reason5 + custom_index + custom_score_name + custom_score + 
			 custom_reason1 + custom_reason2 + custom_reason3 + custom_reason4 + custom_reason5 + attribute_index + inputprovidedfirstname + inputprovidedfirstname_ave + inputprovidedlastname + 
			 inputprovidedlastname_ave + inputprovidedstreetaddress + inputprovidedstreetaddress_ave + inputprovidedcity + inputprovidedcity_ave + inputprovidedstate + inputprovidedstate_ave + 
			 inputprovidedzipcode + inputprovidedzipcode_ave + inputprovidedssn + inputprovidedssn_ave + inputprovideddateofbirth + inputprovideddateofbirth_ave + inputprovidedphone + 
			 inputprovidedphone_ave + inputprovidedlexid + inputprovidedlexid_ave + subjectrecordtimeoldest + subjectrecordtimeoldest_ave + subjectrecordtimenewest + 
			 subjectrecordtimenewest_ave + subjectnewestrecord12month + subjectnewestrecord12month_ave + subjectactivityindex03month + subjectactivityindex3month_ave + 
			 subjectactivityindex06month + subjectactivityindex6month_ave + subjectactivityindex12month + subjectactivityindex12month_ave + subjectage + subjectage_ave + 
			 subjectdeceased + subjectdeceased_ave + subjectssncount + subjectssncount_ave + subjectstabilityindex + subjectstabilityindex_ave + subjectstabilityprimaryfactor + 
			 subjectabilityindex + subjectabilityindex_ave + subjectabilityprimaryfactor + subjectwillingnessindex + subjectwillingnessindex_ave + subjectwillingnessprimaryfactor + 
			 confirmationsubjectfound + confirmationsubjectfound_ave + confirmationinputname + confirmationinputname_ave + confirmationinputdob + confirmationinputdob_ave + 
			 confirmationinputssn + confirmationinputssn_ave + confirmationinputaddress + confirmationinputaddress_ave + sourcenonderogprofileindex + sourcenonderogprofileindex_ave + 
			 sourcenonderogcount + sourcenonderogcount_ave + sourcenonderogcount03month + sourcenonderogcount3month_ave + sourcenonderogcount06month + sourcenonderogcount6month_ave + 
			 sourcenonderogcount12month + sourcenonderogcount12month_ave + sourcecredheadertimeoldest + sourcecredheadertimeoldest_ave + sourcecredheadertimenewest + 
			 sourcecredheadertimenewest_ave + sourcevoterregistration + sourcevoterregistration_ave + educationattendance + educationattendance_ave + educationevidence + educationevidence_ave + 
			 educationprogramattended + educationprogramattended_ave + educationinstitutionprivate + educationinstitutionprivate_ave + educationinstitutionrating + 
			 educationinstitutionrating_ave + profliccount + profliccount_ave + proflictypecategory + proflictypecategory_ave + businessassociation + businessassociation_ave + 
			 businessassociationindex + businessassociationindex_ave + businessassociationtimeoldest + businessassociationtimeoldest_ave + businesstitleleadership + 
			 businesstitleleadership_ave + assetindex + assetindex_ave + assetindexprimaryfactor + assetownership + assetownership_ave + assetprop + assetprop_ave + assetpropindex + 
			 assetpropindex_ave + assetpropevercount + assetpropevercount_ave + assetpropcurrentcount + assetpropcurrentcount_ave + assetpropcurrenttaxtotal + assetpropcurrenttaxtotal_ave + 
			 assetproppurchasecount12month + assetproppurchasecount12month_ave + assetproppurchasetimeoldest + assetproppurchasetimeoldest_ave + assetproppurchasetimenewest + 
			 assetproppurchasetimenewest_ave + assetpropnewestmortgagetype + assetpropnewestmortgagetype_ave + assetpropeversoldcount + assetpropeversoldcount_ave + assetpropsoldcount12month + 
			 assetpropsoldcount12month_ave + assetpropsaletimeoldest + assetpropsaletimeoldest_ave + assetpropsaletimenewest + assetpropsaletimenewest_ave + assetpropnewestsaleprice + 
			 assetpropnewestsaleprice_ave + assetpropsalepurchaseratio + assetpropsalepurchaseratio_ave + assetpersonal + assetpersonal_ave + assetpersonalcount + assetpersonalcount_ave + 
			 purchaseactivityindex + purchaseactivityindex_ave + purchaseactivitycount + purchaseactivitycount_ave + purchaseactivitydollartotal + purchaseactivitydollartotal_ave + 
			 derogseverityindex + derogseverityindex_ave + derogcount + derogcount_ave + derogcount12month + derogcount12month_ave + derogtimenewest + derogtimenewest_ave + criminalfelonycount + 
			 criminalfelonycount_ave + criminalfelonycount12month + criminalfelonycount12month_ave + criminalfelonytimenewest + criminalfelonytimenewest_ave + criminalnonfelonycount + 
			 criminalnonfelonycount_ave + criminalnonfelonycount12month + criminalnonfelonycount12month_ave + criminalnonfelonytimenewest + criminalnonfelonytimenewest_ave + evictioncount + 
			 evictioncount_ave + evictioncount12month + evictioncount12month_ave + evictiontimenewest + evictiontimenewest_ave + lienjudgmentseverityindex + lienjudgmentseverityindex_ave + 
			 lienjudgmentcount + lienjudgmentcount_ave + lienjudgmentcount12month + lienjudgmentcount12month_ave + lienjudgmentsmallclaimscount + lienjudgmentsmallclaimscount_ave + 
			 lienjudgmentcourtcount + lienjudgmentcourtcount_ave + lienjudgmenttaxcount + lienjudgmenttaxcount_ave + lienjudgmentforeclosurecount + lienjudgmentforeclosurecount_ave + 
			 lienjudgmentothercount + lienjudgmentothercount_ave + lienjudgmenttimenewest + lienjudgmenttimenewest_ave + lienjudgmentdollartotal + lienjudgmentdollartotal_ave + bankruptcycount + 
			 bankruptcycount_ave + bankruptcycount24month + bankruptcycount24month_ave + bankruptcytimenewest + bankruptcytimenewest_ave + bankruptcychapter + bankruptcychapter_ave + 
			 bankruptcystatus + bankruptcystatus_ave + bankruptcydismissed24month + bankruptcydismissed24month_ave + shorttermloanrequest + shorttermloanrequest_ave + 
			 shorttermloanrequest12month + shorttermloanrequest12month_ave + shorttermloanrequest24month + shorttermloanrequest24month_ave + inquiryauto12month + inquiryauto12month_ave + 
			 inquirybanking12month + inquirybanking12month_ave + inquirytelcom12month + inquirytelcom12month_ave + inquirynonshortterm12month + inquirynonshortterm12month_ave + 
			 inquiryshortterm12month + inquiryshortterm12month_ave + inquirycollections12month + inquirycollections12month_ave + ssnsubjectcount + ssnsubjectcount_ave + ssndeceased + 
			 ssndeceased_ave + ssnproblems + ssnproblems_ave + addronfilecount + addronfilecount_ave + addronfilecorrectional + addronfilecorrectional_ave + addronfilecollege + 
			 addronfilecollege_ave + addronfilehighrisk + addronfilehighrisk_ave + addrinputtimeoldest + addrinputtimeoldest_ave + addrinputtimenewest + addrinputtimenewest_ave + 
			 addrinputlengthofres + addrinputlengthofres_ave + addrinputsubjectcount + addrinputsubjectcount_ave + addrinputmatchindex + addrinputmatchindex_ave + addrinputsubjectowned + 
			 addrinputsubjectowned_ave + addrinputdeedmailing + addrinputdeedmailing_ave + addrinputownershipindex + addrinputownershipindex_ave + addrinputphoneservice + 
			 addrinputphoneservice_ave + addrinputphonecount + addrinputphonecount_ave + addrinputdwelltype + addrinputdwelltypeindex + addrinputdwelltypeindex_ave + addrinputdelivery + 
			 addrinputdelivery_ave + addrinputtimelastsale + addrinputtimelastsale_ave + addrinputlastsaleprice + addrinputlastsaleprice_ave + addrinputtaxvalue + addrinputtaxvalue_ave + 
			 addrinputtaxyr + addrinputtaxmarketvalue + addrinputtaxmarketvalue_ave + addrinputavmvalue + addrinputavmvalue_ave + addrinputavmvalue12month + addrinputavmvalue12month_ave + 
			 addrinputavmratio12monthprior + addrinputavmratio12monthprior_ave + addrinputavmvalue60month + addrinputavmvalue6month_ave + addrinputavmratio60monthprior + 
			 addrinputavmratio6monthprior_ave + addrinputcountyratio + addrinputcountyratio_ave + addrinputtractratio + addrinputtractratio_ave + addrinputblockratio + addrinputblockratio_ave + 
			 addrinputproblems + addrinputproblems_ave + addrcurrenttimeoldest + addrcurrenttimeoldest_ave + addrcurrenttimenewest + addrcurrenttimenewest_ave + addrcurrentlengthofres + 
			 addrcurrentlengthofres_ave + addrcurrentsubjectowned + addrcurrentsubjectowned_ave + addrcurrentdeedmailing + addrcurrentdeedmailing_ave + addrcurrentownershipindex + 
			 addrcurrentownershipindex_ave + addrcurrentphoneservice + addrcurrentphoneservice_ave + addrcurrentdwelltype + addrcurrentdwelltypeindex + addrcurrentdwelltypeindex_ave + 
			 addrcurrenttimelastsale + addrcurrenttimelastsale_ave + addrcurrentlastsalesprice + addrcurrentlastsalesprice_ave + addrcurrenttaxvalue + addrcurrenttaxvalue_ave + 
			 addrcurrenttaxyr + addrcurrenttaxmarketvalue + addrcurrenttaxmarketvalue_ave + addrcurrentavmvalue + addrcurrentavmvalue_ave + addrcurrentavmvalue12month + 
			 addrcurrentavmvalue12month_ave + addrcurrentavmratio12monthprior + addrcurrentavmratio12monthprior_ave + addrcurrentavmvalue60month + addrcurrentavmvalue6month_ave + 
			 addrcurrentavmratio60monthprior + addrcurrentavmratio6monthprior_ave + addrcurrentcountyratio + addrcurrentcountyratio_ave + addrcurrenttractratio + addrcurrenttractratio_ave + 
			 addrcurrentblockratio + addrcurrentblockratio_ave + addrcurrentcorrectional + addrcurrentcorrectional_ave + addrprevioustimeoldest + addrprevioustimeoldest_ave + 
			 addrprevioustimenewest + addrprevioustimenewest_ave + addrpreviouslengthofres + addrpreviouslengthofres_ave + addrprevioussubjectowned + addrprevioussubjectowned_ave + 
			 addrpreviousownershipindex + addrpreviousownershipindex_ave + addrpreviousdwelltype + addrpreviousdwelltypeindex + addrpreviousdwelltypeindex_ave + addrpreviouscorrectional + 
			 addrpreviouscorrectional_ave + addrstabilityindex + addrstabilityindex_ave + addrchangecount03month + addrchangecount3month_ave + addrchangecount06month + 
			 addrchangecount6month_ave + addrchangecount12month + addrchangecount12month_ave + addrchangecount24month + addrchangecount24month_ave + addrchangecount60month + 
			 addrlastmovetaxratiodiff + addrlastmovetaxratiodiff_ave + addrlastmoveecontrajectory + addrlastmoveecontrajectory_ave + addrlastmoveecontrajectoryindex + 
			 addrlastmoveecontrajectoryindex_ave + phoneinputproblems + phoneinputproblems_ave + phoneinputsubjectcount + phoneinputsubjectcount_ave + phoneinputmobile + 
			 phoneinputmobile_ave + alertregulatorycondition + alertregulatorycondition_ave ; 



/*******************************************************************************************************************************************/
//Final Summary
/*******************************************************************************************************************************************/	

fields_sum := RV5 ; 
							

 res := output(fields_sum,,'~scoring_project::RiskView_v5_stats_' + dateyymmdd_curr, thor, overwrite);
 
return res;

endmacro; 
