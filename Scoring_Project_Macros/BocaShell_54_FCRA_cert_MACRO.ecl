EXPORT BocaShell_54_FCRA_cert_MACRO ( bs_version, fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun, retro_date = 999999):= functionmacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, std, UT, Scoring_Project_PIP;

unsigned8 no_of_records := records_ToRun;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;
integer version := bs_version;

String neutralroxieIP := neutralroxie_IP ; 
String fcraroxieIP := fcraroxie_IP ;

infile_name :=  Input_file_name;
String out_name_head :=  Output_file_name ;

bs_service := 'risk_indicators.Boca_Shell_FCRA';


string8 today := ut.GetDate;
integer archive_date := retro_date;

string DataRestrictionMask := '10000100010001'; // to restrict fares, experian, transunion and experian FCRA 

//===================  input-output files  ======================
// infile_name :=  '~bweiner::in::aetna_4630_50k_sample_in';
// out_name_head := '~bweiner::out::tracking::bocashell50::cert_bs_50_FCRA_';
// outfile_name := out_name_head + (string)archive_date + '_' + today;

//==================  input file layout  ========================
	
	layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;


//====================================================
//=====================  R U N  ======================
//====================================================
ds_in_need_adate := dataset (infile_name, layout_input, CSV(HEADING(SINGLE), QUOTE('"')));

ds_in  := project(ds_in_need_adate,
									TRANSFORM(layout_input, self.historydateyyyymm := archive_date, self:= LEFT));

ds_input := IF (no_of_records = 0, ds_in, CHOOSEN (ds_in, no_of_records));
// op := output (ds_input, NAMED ('input'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := (string)le.AccountNumber;
  SELF.AccountNumber := (STRING)c;

  self.neutral_gateway := neutralroxieIP;

  //**************************************************************************************** 
  // When hard-coding archive dates, uncomment and modify one of the following sets of code 
	//   below and comment out the existing  code for self.historydateyyyymm and self.historyDateTimeStamp 
	//****************************************************************************************
	//	self.historydateyyyymm := 201109;  
	//	self.historyDateTimeStamp := '20110901 00000100';  

	//	self.historydateyyyymm := 999999;  
	//	self.historyDateTimeStamp := '';  // leave timestamp blank, query will populate it with the current date  


  self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', (string)le.historydateyyyymm) => (unsigned)le.historydateyyyymm[..6],
			regexfind('^\\d{8}$',        (string)le.historydateyyyymm) => (unsigned)le.historydateyyyymm[..6],
			                                                (unsigned)le.historydateyyyymm
	);
	
  self.historyDateTimeStamp := map(
      (string)le.historydateyyyymm in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', (string)le.historydateyyyymm) => (string)le.historydateyyyymm,
			regexfind('^\\d{8}$',        (string)le.historydateyyyymm) => (string)le.historydateyyyymm +   ' 00000100',
			regexfind('^\\d{6}$',        (string)le.historydateyyyymm) => (string)le.historydateyyyymm + '01 00000100',		                                                
			                                                (string)le.historydateyyyymm
	);

  self.IncludeScore := true;
	SELF.datarestrictionmask := datarestrictionmask;
	self.bsversion := version;		
	SELF := le;
	SELF := [];
END;
p_f := Distribute(PROJECT (ds_input, assignAccount (LEFT,COUNTER)), random());
//output(choosen(p_f, eyeball), named('BSInput'));

s := Scoring_Project_PIP.test_BocaShell_SoapCall  (PROJECT (p_f, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
                                                bs_service, fcraroxieIP, threads);
		
riskprocessing.layouts.layout_internal_shell_noDatasets getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;
	
res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

//OUTPUT (choosen(res, eyeball), NAMED ('result'));
//OUTPUT (choosen(res_err, eyeball), NAMED ('res_err'));
//output(count(res_err), named('error_count'));

// op1 := OUTPUT (res, , out_name_head , CSV(QUOTE('"')), overwrite);
// op1 := OUTPUT (res, , out_name_head , thor, overwrite);

//compressing and copyng to hthor_11 02/13/2015 as per Nathan suggestion

 op1 := OUTPUT (res, , out_name_head , thor,cluster('thor50_dev'),compressed, overwrite,expire(30));

// the conversion portion-----------------------------------------------------------------------

// f := dataset(out_name_head + 'NO_edina', riskprocessing.layouts.layout_internal_shell_noDatasets, csv(quote('"'), maxlength(20000)));
//output(choosen(f, eyeball), named('infile'));
// isFCRA := true;

//// temporary patch until January 14th roxie release, blank out the collection inquiries until new input option is added to query
// edina_prior_to_patch := risk_indicators.ToEdina_v50(f, isFCRA, DataRestrictionMask);
// edina := project(edina_prior_to_patch, transform(risk_indicators.Layout_Boca_Shell_Edina_v50, 
// self.acc_logs.collection := [], self := left));

// edina := risk_indicators.ToEdina_v50(f, isFCRA, DataRestrictionMask);

//output(choosen(edina,eyeball), named('edina'));
// op2 := output(edina,, outfile_name,CSV(QUOTE('"')));

fin_res := sequential(op1);

return fin_res;

ENDMACRO;