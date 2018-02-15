#workunit('name','NonFCRA-pi02-Batch');
#option ('hthorMemoryLimit', 1000);


IMPORT Models, Risk_Indicators, RiskWise, UT, sghatti;
/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * isFCRA: Set to TRUE for the FCRA product, FALSE for non-FCRA.      *
 * fcraRoxie: IP Address of the FCRA roxie.                           *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
recordsToRun := 1000;
eyeball := 50;

threads := 1;

//isFCRA := FALSE;

//fcraRoxie := riskwise.shortcuts.staging_fcra_roxieIP;

fcraroxie := RiskWise.shortcuts.Dev192; 

//roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
roxieIP := RiskWise.shortcuts.Dev192;

// infile_name_25000     := '~cgrinsteiner::in::Chase_PIO2'; 

inputFile := '~sghatti::in::Chase_PIO2_data';
// infile_name_25000;


outfile_name := '~nkoubsky::out::Chase_PI02_Batch_Cust_Rec__DEV192_' + thorlib.wuid();

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_prii := record
    STRING Account;
    STRING First;
    STRING MiddleName;
    STRING Last;
    STRING addr;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HPhone;
    STRING socs;
    STRING dob;
    STRING WorkPhone;
    STRING income;  
    string Drlc;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    integer historydateyyyymm;
end;


f1 := IF(recordsToRun <= 0, dataset(ut.foreign_prod + inputFile, layout_prii, thor), 
CHOOSEN(DATASET(ut.foreign_prod + inputFile, layout_prii, thor), recordsToRun));

f := f1;  //Turn on if not testing														
//f := f1 (Account = '110836U102079');  //Turn on for testing 1 Account at a time


// output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));
// output(count(f), NAMED('Number_Of_Records_On_Input'));


//mapping

layout_soap_input := RECORD
  string tribcode := '';	
	DATASET(RiskWise.Layout_PB1O_BatchIn) batch_in;
	unsigned1	DPPAPurpose:= '';
  unsigned1	GLBPurpose:= '';
	STRING DataRestrictionMask := '';
	integer	HistoryDateyyyymm := '';
	string Gateways := '';
	end;
	
sghatti.Layout_PB1O_BatchIn make_batch_in(f le, integer c) := transform
	  // !! replace the tribcode here !!
  SELF.acctno := le.account;	
	
	SELF.name_first := le.First;
	SELF.name_last := le.Last;
	SELF.street_addr := le.addr;
	SELF.p_city_name:= le.CITY;
	SELF.st := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.home_phone := le.HPhone;
	SELF.ssn := le.socs;
	SELF.DOB := le.dob;
	self.historydateyyyymm := 999999 ;
	self := le;
	self := [];
end;

layout_soap_input make_Chase_in(f le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.tribcode := 'pi02';
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;
	SELF.DataRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction;
	SELF.HistoryDateYYYYMM := 999999;
END;

soap_in := DISTRIBUTE(project(f,make_Chase_in(LEFT, counter)));
// output(soap_in, named('Sample_soap_in'));



// ip := if(isFCRA, fcraRoxie, roxieIP);

xlayout := RECORD
  Riskwise.Layout_PRIO;
	STRING errorcode;
END;

xlayout myFail(soap_in l) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	// self.account := l.batch_in[1].account;
	SELF := [];
END;

s := SOAPCALL(soap_in, roxieIP,
				'RiskWise.PRIO_Batch_Service.1', {soap_in}, 
				DATASET(xlayout),
        RETRY(1), TIMEOUT(120),
        PARALLEL(threads), onFail(myFail(LEFT)));

// output(CHOOSEN(s, eyeball), named('Sample_results'));
//output(s);

op_final := output(s,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

sequential(op_final);

EXPORT Chase_PIO2_Batch_Cust_Rec_dev192 := 'Success';