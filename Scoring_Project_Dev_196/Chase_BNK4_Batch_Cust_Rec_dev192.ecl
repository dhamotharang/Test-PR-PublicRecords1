#workunit('name','nonfcra-bnk4-Batch');
#option ('hthorMemoryLimit', 1000);

IMPORT Models, Risk_Indicators, RiskWise, UT, scoring;
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
eyeball := 25;
UNSIGNED1 parallel_threads := 1;

threads := 1;

//roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
roxieIP := RiskWise.shortcuts.Dev192; // DEV 192
// infile_name_25000     := '~cgrinsteiner::in::Chase_BNK4'; 

inputFile := '~sghatti::in::Chase_BNK4_data';

outfile_name := '~nkoubsky::out::Chase_BNK4_batch_DEV192_' + thorlib.wuid();

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
Layout_BC1O_soapcall := RECORD
	string account ;	
	string first;     
	string last ;
	string addr ; 
	string city ; 
	string state ;    
	string zip ;     
	string socs ;   
	string dob ; 
	string hphone ;
	string drlc ;  
	string drlcstate ;	
	string income ;  
	string cmpy ;  
//	string dbaname ;  
	string cmpyaddr ;   
	string cmpycity ;  
	string cmpystate ;    
	string cmpyzip ;     
	string cmpyphone ;     
	string fin ;     
	string internetcommflag ;   
	string emailaddr ;    
	string emailheadr ;   
	string ipaddr ;    
	integer  HistoryDateyyyymm ;	
	string apptime ;
end;


f := ChooseN(dataset(ut.foreign_prod + inputFile, Layout_BC1O_soapcall, thor), recordstorun);
                           
//f := f1;  //Turn on if not testing														
// f := f1 (Account = '110836U102079');  //Turn on for testing 1 Account at a time 110836U102079

// output(CHOOSEN(f, eyeball), NAMED('Sample_Raw_Input'));

layout_soap_input := RECORD
	string tribcode := '' ;	
	DATASET(Riskwise.Layout_BC1O_BatchIn) batch_in;
	unsigned1	DPPAPurpose:= 3;//CHANGED FROM '' TO 3 
  unsigned1	GLBPurpose:= 1;//CHANGED FROM '' TO 1
	STRING DataRestrictionMask := '';
	integer	HistoryDateyyyymm := 0;
END;

Riskwise.Layout_BC1O_BatchIn make_batch_in(f le, integer c) := transform
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
	self.historydateyyyymm := 999999;
		
	self.name_company := le.cmpy;
	self.street_addr2 := le.cmpyaddr;
	self.p_city_name_2 := le.cmpycity;
	self.st_2 := le.cmpystate;
	self.z5_2 := le.cmpyzip;
	self.phoneno := le.cmpyphone;
	self.fein := le.fin;
	self.internetcommflag := le.internetcommflag;
	self.email  := le.emailaddr ;
	self.emailheadr := le.emailheadr ;
	self.ip_addr := le.ipaddr;
	self.apptime := le.apptime;
	
	self := le;
	self := [];
end;

layout_soap_input make_Chase_in(f le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(left, c));
	SELF.batch_in := batch;
	SELF.tribcode := 'bnk4';
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;
	SELF.DataRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction;
	SELF.HistoryDateYYYYMM := 999999;
END;

soap_in := Distribute(project(f, make_Chase_in(LEFT, counter)));
// output(CHOOSEN(soap_in, eyeball), named('sample_soap_in'));

xlayout := RECORD
  RiskWise.Layout_BC1O;
	STRING errorcode;
END;

xlayout myFail(soap_in l) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.account := l.batch_in[1].account;
	SELF := [];
END;


s_f := SOAPCALL(soap_in, roxieIP,
				'RiskWise.BC1O_Batch_Service.1', {soap_in}, 
				DATASET(xlayout),
        RETRY(1), TIMEOUT(120),
        PARALLEL(threads), onFail(myFail(LEFT)));


// output(CHOOSEN(s_f, eyeball), named('sample_results'));
//output(s,, outputFile, CSV(heading(single), QUOTE('"')), overwrite);
//output(s_f(errorcode<>''),, outputFile + '_error', CSV(heading(single), QUOTE('"')), overwrite);

op_final := output(s_f,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);

sequential(op_final);

EXPORT Chase_BNK4_Batch_Cust_Rec_dev192 := 'Success';