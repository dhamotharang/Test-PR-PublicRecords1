EXPORT Experian_RVA_30_BATCH_Macro (fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

unsigned8 no_of_records := records_ToRun;
integer eyeball := 50;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String neutralroxieIP := neutralroxie_IP ; 
String fcraroxieIP := fcraroxie_IP ;

include_internal_extras:= true;


Infile_name :=  Input_file_name;

String outfile_name :=  Output_file_name ;


archive_date := (integer) ut.getdate ;

//*********custom settings**********

DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Experian_settings.DRM;
isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Experian_settings.isFCRA=true,'FCRA','NONFCRA');
IsPreScreen:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Experian_settings.IsPreScreen;
IncludeVersion3:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Experian_settings.IncludeVersion3;

// string DataRestrictionMask  := '10000001010000'; // to restrict fares, experian, transunion and experian FCRA

HistoryDate := 999999;

//*********************************

//==================  input file layout  ========================
layout_input :=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
End;




f1 := IF(no_of_records <= 0, dataset( infile_name, layout_input, thor),
                            CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));



ds_input := distribute(f1, hash64(AccountNumber));



layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion3;
	BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno :=(STRING) le.AccountNumber;
	SELF.Name_First := le.FirstName;
	SELF.Name_Middle := le.MiddleName;
	SELF.Name_Last := le.LastName;
	SELF.street_addr := le.StreetAddress;
	SELF.p_City_name := le.CITY;
	SELF.St := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.HomePhone;
	SELF.SSN := le.SSN;
	SELF.DOB := le.DateOfBirth;
	SELF.Work_Phone := le.WorkPhone;
	self.historydateyyyymm := HistoryDate ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{isFCRA, neutralroxieIP}], risk_indicators.layout_gateways_in);
	SELF.IsPreScreen := IsPreScreen;		
	self.IncludeVersion3 := IncludeVersion3;
	SELF.DataRestrictionMask := DRM;
END;
	
soap_in := DISTRIBUTE(PROJECT(ds_input, make_rv_in(LEFT, counter)), RANDOM());
// OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

roxie_out_layout := RECORD
	models.Layout_RiskView_Batch_Out;
	string200 errorcode;
END;
       
roxie_out_layout myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno := l.batch_in[1].acctno;
	self := [];
end;

resu := soapcall(soap_in, fcraroxieIP ,
										'models.RiskView_Batch_Service', 
										{soap_in},
                    dataset(roxie_out_layout), RETRY(retry), TIMEOUT(timeout),
										parallel(threads) ,
										onfail(myfail(LEFT)));

//output(choosen(resu, eyeball), named('soap_results'));
errors := resu(errorcode<>'');
// output(choosen(errors, eyeball), named('errors'));
op1 := output(count(errors), named('experian_rv_batch30_error_count'));


// output(choosen(rv_attributes_v2, eyeball), named('rv_attributes_v2'));
// output(rv_attributes_v2,,outfile_name,thor, quote('"')));
//output(rv_attributes_v3);

/* 	ox := RECORD
   	recordof(just_rv_attributes_v3);
   	#if(include_internal_extras)
   		RiskProcessing.layout_internal_extras;
   	#end
   
   END;
*/

			//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout;			 
END;

 Global_output_lay normit(resu L, soap_in R) := transform
   	SELF.accountnumber :=(string) L.acctno;
   	
   	#if(include_internal_extras)
   	                      	self.DID :=(integer) l.did; 
                            self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
				                    self.FNamePop := r.batch_in[1].Name_First<>'';
			                     	self.LNamePop := r.batch_in[1].Name_Last<>'';
				                    self.AddrPop := r.batch_in[1].street_addr<>'';
			                    	self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
			                    	self.DOBPop := r.batch_in[1].dob<>'';
	                      			// self.EmailPop := right.batch_in[1].email<>'';
			                     	self.IPAddrPop := r.batch_in[1].ip_addr<>''; 
			                    	self.HPhnPop := r.batch_in[1].Home_Phone<>'';   	
   	#end;
self.history_date := (string6)archive_date;
  self.invalidssn := L.isSSNInvalid;	

SELF.verifiedphonefullname:=  L.isPhoneFullNameMatch ;
SELF.verifiedphonelastname:=  L.isPhoneLastNameMatch ;
SELF.invalidphone:=  L.isPhoneInvalid;
SELF.invalidaddr:=  L.isAddrInvalid;
SELF.invaliddl:=  L.isDLInvalid;
SELF.ssndeceased:=  L.isDeceased;
SELF.ssnvalid:=  L.isSSNValid;
SELF.recentissue:=  L.isRecentIssue;
SELF.nonus:=  L.isNonUS;
SELF.issued3:=  L.isIssued3;
SELF.issuedage5:=  L.isIssuedAge5;
SELF.iaownedbysubject:=  L.IAisOwnedBySubject;
SELF.iafamilyowned:=  L.IAisFamilyOwned;
SELF.iaoccupantowned:=  L.IAisOccupantOwned;
SELF.ianotprimaryres:=  L.IAisNotPrimaryRes;
SELF.caownedbysubject:=  L.CAisOwnedBySubject;
SELF.cafamilyowned:=  L.CAisFamilyOwned;
SELF.caoccupantowned:=  L.CAisOccupantOwned;
SELF.canotprimaryres:=  L.CAisNotPrimaryRes;
SELF.paownedbysubject:=  L.PAisOwnedBySubject;
SELF.pafamilyowned:=  L.PAisFamilyOwned;
SELF.paoccupantowned:=  L.PAisOccupantOwned;
SELF.inputcurrmatch:=  L.isInputCurrMatch;
SELF.diffstate:=  L.isDiffState;
SELF.inputprevmatch:=  L.isInputPrevMatch;
SELF.diffstate2:=  L.isDiffState2;
SELF.addrhighrisk:=  L.isAddrHighRisk;
SELF.phonehighrisk:=  L.isPhoneHighRisk;
SELF.addrprison:=  L.isAddrPrison;
SELF.zippobox:=  L.isZipPOBox;
SELF.zipcorpmil:=  L.isZipCorpMil;
SELF.phonepager:=  L.isPhonePager;
SELF.phonemobile:=  L.isPhoneMobile;
SELF.phonezipmismatch:=  L.isPhoneZipMismatch;
	

   	self := L;
   self := [];
   end;
   
   j_f := JOIN(resu,soap_in,LEFT.Acctno=(string)RIGHT.batch_in[1].acctno,normit(LEFT,RIGHT));


op_final := output(j_f,, outfile_name,thor,compressed, OVERWRITE);


return op_final;

endmacro;