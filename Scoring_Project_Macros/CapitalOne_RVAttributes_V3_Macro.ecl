EXPORT CapitalOne_RVAttributes_V3_Macro(fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= functionmacro

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

unsigned8 no_of_records := records_ToRun;
integer eyeball := 50;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String neutralroxieIP := neutralroxie_IP ; 
String fcraroxieIP := fcraroxie_IP ;


Infile_name :=  Input_file_name;

String outfile_name :=  Output_file_name ;


include_internal_extras := true;

// archive_date := (integer) ut.getdate ;

// string DataRestrictionMask  := '10000100010001 '; // to restrict fares, experian, transunion and experian FCRA


//*********custom settings**********

DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_CapOne_settings.DRM;

IsPreScreen:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_CapOne_settings.IsPreScreen;

IncludeVersion3:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_CapOne_settings.IncludeVersion3;

isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_CapOne_settings.isFCRA=true,'FCRA','NONFCRA');

HistoryDate := 999999;

//***********************************

//==================  input file layout  ========================
// layout_input := RECORD
    // STRING Account;
    // STRING FirstName;
    // STRING MiddleName;
    // STRING LastName;
    // STRING StreetAddress;
    // STRING City;
    // STRING State;
    // STRING Zip;
    // STRING HomePhone;
    // STRING SSN;
    // STRING DateOfBirth;
    // STRING WorkPhone;
    // STRING income;  
    // string DLNumber;
    // string DLState;													
    // string BALANCE; 
    // string CHARGEOFFD;  
    // string FormerName;
    // string EMAIL;  
    // string employername;
    // integer historydateyyyymm;
  // END;
	
layout_input :=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
End;



raw_input := IF(no_of_records <= 0, dataset( infile_name, layout_input,thor) ,
                            CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));



ds_input := distribute(raw_input, hash64(AccountNumber));

layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion3;
	BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := (string)le.AccountNumber;
	SELF.Name_First := le.FirstName;
	SELF.Name_Middle := le.MiddleName;
	SELF.Name_Last := le.LastName;
	SELF.street_addr := le.StreetAddress;
	SELF.p_City_name := le.City;
	SELF.St := le.State;
	SELF.z5 := le.Zip;
	// SELF.Home_Phone := le.HomePhone;
	SELF.SSN := le.SSN;
	// SELF.DOB := le.DateOfBirth;
	// SELF.Work_Phone := le.WorkPhone;
	self.historydateyyyymm := HistoryDate;//le.historydateyyyymm ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', neutralroxieIP}], risk_indicators.layout_gateways_in);
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
                    dataset(roxie_out_layout),
										RETRY(retry), TIMEOUT(timeout),
										parallel(threads) ,
										onfail(myfail(LEFT)));

// output(choosen(resu, eyeball), named('soap_results'));
errors := resu(errorcode<>'');
// output(choosen(errors, eyeball), named('errors'));
op1 := output(count(errors), named('capone_v3_attributes_error_count'));

/************************************************
 *  Added output for new layout - Nathan 5/5    *
 ************************************************/
batchlay_with_extras := record
		Scoring_Project_Macros.Global_Output_Layouts.RiskViewAttributes_v3;
end;

batchlay_with_extras add_iextras(resu l, raw_input r) := TRANSFORM
		#if(include_internal_extras)
				// self.DID := l.did; 
				self.historydate := '999999';
				self.FNamePop := r.firstname<>'';
				self.LNamePop := r.lastname<>'';
				self.AddrPop := r.streetaddress<>'';
				self.SSNLength := (string)(length(trim(r.ssn))) ;
				self.DOBPop := r.dateofbirth<>'';
				// self.EmailPop := r.email<>'';
				// self.IPAddrPop := r.ipaddress<>'';
				self.HPhnPop := r.homephone<>'';
		#end;
		self := l;
		self := [];
end;
	
batch_final_output := join(resu, raw_input, left.acctno = (string)right.accountnumber, add_iextras(left, right));

batch_outfile_name := outfile_name + '_batchlay';
op_batch_final := output(batch_final_output,, batch_outfile_name, thor, compressed, overwrite);
	
/************************************************/



			//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V3_Global_Layout;		 
END;

rv_attributes_v3 := project(resu, 
	transform(Global_output_lay, 
	self.accountnumber := left.acctno;
	self.history_date := '999999';
  self.invalidssn := left.isSSNInvalid;	

SELF.verifiedphonefullname:=  left.isPhoneFullNameMatch ;
SELF.verifiedphonelastname:=  left.isPhoneLastNameMatch ;
SELF.invalidphone:=  left.isPhoneInvalid;
SELF.invalidaddr:=  left.isAddrInvalid;
SELF.invaliddl:=  left.isDLInvalid;
SELF.ssndeceased:=  left.isDeceased;
SELF.ssnvalid:=  left.isSSNValid;
SELF.recentissue:=  left.isRecentIssue;
SELF.nonus:=  left.isNonUS;
SELF.issued3:=  left.isIssued3;
SELF.issuedage5:=  left.isIssuedAge5;
SELF.iaownedbysubject:=  left.IAisOwnedBySubject;
SELF.iafamilyowned:=  left.IAisFamilyOwned;
SELF.iaoccupantowned:=  left.IAisOccupantOwned;
SELF.ianotprimaryres:=  left.IAisNotPrimaryRes;
SELF.caownedbysubject:=  left.CAisOwnedBySubject;
SELF.cafamilyowned:=  left.CAisFamilyOwned;
SELF.caoccupantowned:=  left.CAisOccupantOwned;
SELF.canotprimaryres:=  left.CAisNotPrimaryRes;
SELF.paownedbysubject:=  left.PAisOwnedBySubject;
SELF.pafamilyowned:=  left.PAisFamilyOwned;
SELF.paoccupantowned:=  left.PAisOccupantOwned;
SELF.inputcurrmatch:=  left.isInputCurrMatch;
SELF.diffstate:=  left.isDiffState;
SELF.inputprevmatch:=  left.isInputPrevMatch;
SELF.diffstate2:=  left.isDiffState2;
SELF.addrhighrisk:=  left.isAddrHighRisk;
SELF.phonehighrisk:=  left.isPhoneHighRisk;
SELF.addrprison:=  left.isAddrPrison;
SELF.zippobox:=  left.isZipPOBox;
SELF.zipcorpmil:=  left.isZipCorpMil;
SELF.phonepager:=  left.isPhonePager;
SELF.phonemobile:=  left.isPhoneMobile;
SELF.phonezipmismatch:=  left.isPhoneZipMismatch;
	
	
	// self.RecentUpdate	:= left.isrecentupdate		;
	// self.SrcsConfirmIDAddrCount	:= left.numsources		;
	// self.VerificationFailure	:= left.isnover		;
	// self.SSNDateDeceased	:= left.deceaseddate		;
	// self.SSNRecent	:= left.isrecentissue		;
	// self.SSNLowIssueDate	:= left.lowissuedate		;
	// self.InputAddrAgeNewestRecord	:= left.iaagenewestrecord		;
	// self.InputAddrAleft.OfRes	:= left.ialeft.ofres		;
	// self.InputAddrDwellType	:= left.iadwelltype		;
	// self.InputAddrLandUseCode	:= left.ialandusecode		;
	// self.InputAddrOwnedBySubject	:= left.iaownedbysubject		;
	// self.InputAddrFamilyOwned	:= left.iafamilyowned		;
	// self.InputAddrOccupantOwned	:= left.iaoccupantowned		;
	// self.InputAddrAgeLastSaleft.:= left.iaagelastsaleft.	;
	// self.InputAddrLastSaleft.Price	:= left.ialastsaleft.mount		;
	// self.InputAddrNotPrimaryRes	:= left.ianotprimaryres		;
	// self.InputAddrActivePhoneList	:= left.iaphonelisted		;
	// self.InputAddrActivePhoneNumber	:= left.iaphonenumber		;
	// self.InputAddrTaxValue	:= left.iaassessedvalue		;
	// self.CurrAddrAgeOldestRecord	:= left.caageoldestrecord		;
	// self.CurrAddrAgeNewestRecord	:= left.caagenewestrecord		;
	// self.CurrAddrleft.OfRes	:= left.caleft.ofres		;
	// self.CurrAddrDwellType	:= left.cadwelltype		;
	// self.CurrAddrALandUseCode	:= left.calandusecode		;
	// self.CurrAddrApplicantOwned	:= left.caownedbysubject		;
	// self.CurrAddrFamilyOwned	:= left.cafamilyowned		;
	// self.CurrAddrOccupantOwned	:= left.caoccupantowned		;
	// self.CurrAddrAgeLastSaleft.:= left.caagelastsaleft.	;
	// self.CurrAddrLastSaleft.Price	:= left.calastsaleft.mount		;
	// self.CurrAddrNotPrimaryRes	:= left.canotprimaryres		;
	// self.CurrAddrActivePhoneList	:= left.caphonelisted		;
	// self.CurrAddrActivePhoneNumber	:= left.caphonenumber		;
	// self.CurrAddrTaxValue	:= left.caassessedvalue		;
	// self.PrevAddrAgeOldestRecord	:= left.paageoldestrecord		;
	// self.PrevAddrAgeNewestRecord	:= left.paagenewestrecord		;
	// self.PrevAddrleft.OfRes	:= left.paleft.ofres		;
	// self.PrevAddrDwellType	:= left.padwelltype		;
	// self.PrevAddrLandUseCode	:= left.palandusecode		;
	// self.PrevAddrApplicantOwned	:= left.paownedbysubject		;
	// self.PrevAddrFamilyOwned	:= left.pafamilyowned		;
	// self.PrevAddrOccupantOwned	:= left.paoccupantowned		;
	// self.PrevAddrAgeLastSaleft.:= left.paagelastsaleft.	;
	// self.PrevAddrLastSaleft.Price	:= left.palastsaleft.mount		;
	// self.PrevAddrPhoneListed	:= left.paphonelisted		;
	// self.PrevAddrPhoneNumber	:= left.paphonenumber		;
	// self.PrevAddrAssessedValue	:= left.paassessedvalue		;
	// self.InputCurrAddrMatch	:= left.inputcurrmatch		;
	// self.InputCurrAddrDistance	:= left.distinputcurr		;
	// self.InputCurrAddrStateDiff	:= left.diffstate		;
	// self.InputCurrAddrTaxDiff	:= left.assesseddiff		;
	// self.InputCurrEconTrajectory	:= left.ecotrajectory		;
	// self.InputPrevAddrMatch	:= left.inputprevmatch		;
	// self.CurrPrevAddrDistance	:= left.distcurrprev		;
	// self.CurrPrevAddrStateDiff	:= left.diffstate2		;
	// self.CurrPrevAddrTaxDiff	:= left.assesseddiff2		;
	// self.PrevCurrEconTrajectory	:= left.ecotrajectory2		;
	// self.AddrStability	:= left.mobility_indicator		;
	// self.StatusMostRecent	:= left.statusaddr		;
	// self.StatusPrevious	:= left.statusaddr2		;
	// self.StatusNextPrevious	:= left.statusaddr3		;
	// self.AddrChangeCount01	:= left.addrchanges30		;
	// self.AddrChangeCount03	:= left.addrchanges90		;
	// self.AddrChangeCount06	:= left.addrchanges180		;
	// self.AddrChangeCount12	:= left.addrchanges12		;
	// self.AddrChangeCount24	:= left.addrchanges24		;
	// self.AddrChangeCount36	:= left.addrchanges36		;
	// self.AddrChangeCount60	:= left.addrchanges60		;
	// self.PropOwnedCount	:= left.property_owned_total		;
	// self.PropOwnedTaxTotal	:= left.property_owned_assessed_total		;
	// self.PropOwnedHistoricalCount	:= left.property_historically_owned		;
	// self.PropPurchasedCount01	:= left.numpurchase30		;
	// self.PropPurchasedCount03	:= left.numpurchase90		;
	// self.PropPurchasedCount06	:= left.numpurchase180		;
	// self.PropPurchasedCount12	:= left.numpurchase12		;
	// self.PropPurchasedCount24	:= left.numpurchase24		;
	// self.PropPurchasedCount36	:= left.numpurchase36		;
	// self.PropPurchasedCount60	:= left.numpurchase60		;
	// self.PropSoldCount01	:= left.numsold30		;
	// self.PropSoldCount03	:= left.numsold90		;
	// self.PropSoldCount06	:= left.numsold180		;
	// self.PropSoldCount12	:= left.numsold12		;
	// self.PropSoldCount24	:= left.numsold24		;
	// self.PropSoldCount36	:= left.numsold36		;
	// self.PropSoldCount60	:= left.numsold60		;
	// self.WatercraftCount	:= left.numwatercraft		;
	// self.WatercraftCount01	:= left.numwatercraft30		;
	// self.WatercraftCount03	:= left.numwatercraft90		;
	// self.WatercraftCount06	:= left.numwatercraft180		;
	// self.WatercraftCount12	:= left.numwatercraft12		;
	// self.WatercraftCount24	:= left.numwatercraft24		;
	// self.WatercraftCount36	:= left.numwatercraft36		;
	// self.WatercraftCount60	:= left.numwatercraft60		;
	// self.AircraftCount	:= left.numaircraft		;
	// self.AircraftCount01	:= left.numaircraft30		;
	// self.AircraftCount03	:= left.numaircraft90		;
	// self.AircraftCount06	:= left.numaircraft180		;
	// self.AircraftCount12	:= left.numaircraft12		;
	// self.AircraftCount24	:= left.numaircraft24		;
	// self.AircraftCount36	:= left.numaircraft36		;
	// self.AircraftCount60	:= left.numaircraft60		;
	// self.WealthIndex	:= left.wealth_indicator		;
	// self.DerogCount	:= left.total_number_derogs		;
	// self.FelonyCount	:= left.felonies		;
	// self.FelonyCount01	:= left.felonies30		;
	// self.FelonyCount03	:= left.felonies90		;
	// self.FelonyCount06	:= left.felonies180		;
	// self.FelonyCount12	:= left.felonies12		;
	// self.FelonyCount24	:= left.felonies24		;
	// self.FelonyCount36	:= left.felonies36		;
	// self.FelonyCount60	:= left.felonies60		;
	// self.LienCount	:= left.num_liens		;
	// self.LienFileft.Count	:= left.num_unreleft.sed_liens		;
	// self.LienFileft.Count01	:= left.num_unreleft.sed_liens30		;
	// self.LienFileft.Count03	:= left.num_unreleft.sed_liens90		;
	// self.LienFileft.Count06	:= left.num_unreleft.sed_liens180		;
	// self.LienFileft.Count12	:= left.num_unreleft.sed_liens12		;
	// self.LienFileft.Count24	:= left.num_unreleft.sed_liens24		;
	// self.LienFileft.Count36	:= left.num_unreleft.sed_liens36		;
	// self.LienFileft.Count60	:= left.num_unreleft.sed_liens60		;
	// self.LienReleft.sedCount	:= left.num_releft.sed_liens		;
	// self.LienReleft.sedCount01	:= left.num_releft.sed_liens30		;
	// self.LienReleft.sedCount03	:= left.num_releft.sed_liens90		;
	// self.LienReleft.sedCount06	:= left.num_releft.sed_liens180		;
	// self.LienReleft.sedCount12	:= left.num_releft.sed_liens12		;
	// self.LienReleft.sedCount24	:= left.num_releft.sed_liens24		;
	// self.LienReleft.sedCount36	:= left.num_releft.sed_liens36		;
	// self.LienReleft.sedCount60	:= left.num_releft.sed_liens60		;
	// self.BankruptcyCount	:= left.bankruptcy_count		;
	// self.BankruptcyType	:= left.filing_type		;
	// self.BankruptcyStatus	:= left.disposition		;
	// self.BankruptcyCount01	:= left.bankruptcy_count30		;
	// self.BankruptcyCount03	:= left.bankruptcy_count90		;
	// self.BankruptcyCount06	:= left.bankruptcy_count180		;
	// self.BankruptcyCount12	:= left.bankruptcy_count12		;
	// self.BankruptcyCount24	:= left.bankruptcy_count24		;
	// self.BankruptcyCount36	:= left.bankruptcy_count36		;
	// self.BankruptcyCount60	:= left.bankruptcy_count60		;
	// self.EvictionCount	:= left.eviction_count		;
	// self.EvictionCount01	:= left.eviction_count30		;
	// self.EvictionCount03	:= left.eviction_count90		;
	// self.EvictionCount06	:= left.eviction_count180		;
	// self.EvictionCount12	:= left.eviction_count12		;
	// self.EvictionCount24	:= left.eviction_count24		;
	// self.EvictionCount36	:= left.eviction_count36		;
	// self.EvictionCount60	:= left.eviction_count60		;
	// self.NonDerogCount	:= left.num_nonderogs		;
	// self.NonDerogCount01	:= left.num_nonderogs30		;
	// self.NonDerogCount03	:= left.num_nonderogs90		;
	// self.NonDerogCount06	:= left.num_nonderogs180		;
	// self.NonDerogCount12	:= left.num_nonderogs12		;
	// self.NonDerogCount24	:= left.num_nonderogs24		;
	// self.NonDerogCount36	:= left.num_nonderogs36		;
	// self.NonDerogCount60	:= left.num_nonderogs60		;
	// self.ProfLicCount	:= left.num_proflic		;
	// self.ProfLicCount01	:= left.num_proflic30		;
	// self.ProfLicCount03	:= left.num_proflic90		;
	// self.ProfLicCount06	:= left.num_proflic180		;
	// self.ProfLicCount12	:= left.num_proflic12		;
	// self.ProfLicCount24	:= left.num_proflic24		;
	// self.ProfLicCount36	:= left.num_proflic36		;
	// self.ProfLicCount60	:= left.num_proflic60		;
	// self.ProflicExpireCount01	:= left.num_proflic_exp30		;
	// self.ProflicExpireCount03	:= left.num_proflic_exp90		;
	// self.ProflicExpireCount06	:= left.num_proflic_exp180		;
	// self.ProflicExpireCount12	:= left.num_proflic_exp12		;
	// self.ProflicExpireCount24	:= left.num_proflic_exp24		;
	// self.ProflicExpireCount36	:= left.num_proflic_exp36		;
	// self.ProflicExpireCount60	:= left.num_proflic_exp60		;
	// self.InputPhoneStatus	:= left.phonestatus		;
	// self.InputPhonePager	:= left.phonepager		;
	// self.InputPhoneMobileft.:= left.phonemobileft.	;
	// self.InvalidPhoneZip	:= left.phonezipmismatch		;
	// self.InputPhoneAddrDist	:= left.phoneaddrdist		;
	// self.InputAddrHighRisk	:= left.addrhighrisk		;
	// self.InputPhoneHighRisk	:= left.phonehighrisk		;
	// self.InputAddrPrison	:= left.addrprison		;
	// self.InputZipPOBox	:= left.zippobox		;
	// self.InputZipCorpMil	:= left.zipcorpmil		;
	self.did:=(integer)left.did;
	self := left;
	self:=[];
		));			
// output(choosen(rv_attributes_v2, eyeball), named('rv_attributes_v2'));
// output(rv_attributes_v2,,outfile_name, thor);



// output(rv_attributes_v3);

//op_despray := FileServices.DeSpray('~sghatti::out::batch_fcra_rvattributes_v3_' + ut.getdate ,'10.48.72.175', 'G:\\Scoring Project\\landing\\'+ 'batch_fcra_rvattributes_v3_' + ut.getdate  + '_' + ut.getTime()  + '.csv',,,,TRUE);

//sequential(op_final, op1);

// final_layout := record
// recordof(rv_attributes_v3);
	// #if(include_internal_extras)
		// RiskProcessing.layout_internal_extras;
	// #end	
// end;	


Global_output_lay xform1(rv_attributes_v3 l, soap_in r) := TRANSFORM
	#if(include_internal_extras)
		                        self.DID := (integer)l.did; 
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
	self := l;
	self := [];
	
	end;
	
		final_output:=join(rv_attributes_v3,soap_in,left.accountnumber=(string)right.batch_in[1].acctno ,xform1(left, right));	

op_final := output(final_output,,outfile_name,thor,compressed, overwrite);

return sequential (op_batch_final, op_final);

endmacro;