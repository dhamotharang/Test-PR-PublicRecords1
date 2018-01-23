// #workunit('name','Business IID Process');
// #option ('hthorMemoryLimit', 1000);

EXPORT Business_Instant_Id_XML_Macro (roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

import models, Risk_Indicators, Business_Risk, ut, riskwise;

/* *****************************************************
 *                   Options Section                   *
 *******************************************************/

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
// gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


// gateways := Gateway;
Gateway := DATASET([], Gateway.Layouts.Config);

include_internal_extras:=true;

//***********custom settings**************************

DPPA:=Scoring_Project_PIP.User_Settings_Module.BIID_XML_Generic_settings.DPPA;
GLB:=Scoring_Project_PIP.User_Settings_Module.BIID_XML_Generic_settings.GLB;
DRM:=Scoring_Project_PIP.User_Settings_Module.BIID_XML_Generic_settings.DRM;

	// unsigned1	DPPAPurpose:= 3;//CHANGED FROM '' TO 3 
  // unsigned1	GLBPurpose:= 1;//CHANGED FROM '' TO 1
	// STRING DataRestrictionMask := '';
	// UNSIGNED1 BSversion := 41;
	// boolean isFCRA := false;
  HistoryDate := 999999;
	
//*****************************************************

/* *****************************************************
 *                      Main Script                    *
 *******************************************************/
rec_input := RECORD
  string account_number;
  string date_added;
  string source_info;
  string _clientip;
  string _companyid;
  string _loginid;
  string _queryid;
  string _referencecode;
  string addr;
  string alternatecompanyname;
  string applicationtype;
  string bdid;
  string businessphone;
  string city;
  string companyname;
  string county;
  string datapermissionmask;
  string datarestrictionmask;
  string disallowtarguseid3220;
  string dlmask_overload;
  string dlmask;
  string dobmask_overload;
  string dobmask;
  string dobradius;
  string dppapurpose;
  string encryptedlogging;
  string excludewatchlists;
  string format_;
  string glbpurpose;
  string globalwatchlistthreshold;
  string includeadditionalwatchlists;
  string includeallriskindicators;
  string includedlverification;
  string includemsoverride;
  string includeofac;
  string includetarguse3220;
  string industryclass;
  string noschemas_;
  string ofaconly;
  string ofacversion;
  string poboxcompliance;
  string postalcode;
  string representativeaddr;
  string representativeage;
  string representativecity;
  string representativedlnumber;
  string representativedlstate;
  string representativedob;
  string representativefirstname;
  string representativehomephone;
  string representativelastname;
  string representativemiddlename;
  string representativenamesuffix;
  string representativessn;
  string representativestate;
  string representativezip;
  string state;
  string taxidnumber;
  string testdataenabled;
  string unparsedfullname;
  string usedobfilter;
  string zip;
 END;
 
																						
								
 layout:=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.bus_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
End;


								
f1 := IF(no_of_records = 0, 
                DATASET(Infile_name, Layout, thor) ,
                CHOOSEN(DATASET(Infile_name, Layout, thor), no_of_records));


layout_input := record
// rec_input - [account_number];
  String30 accountnumber;
	string HistoryDateYYYYMM;
	string GLBPurpose;
	string DPPAPurpose;
	string DataRestrictionMask;
	string businessphone;
	string addr;
  string city;
  string companyname;
	string state;
  string taxidnumber;
  string zip;
	string representativedob;
  string representativefirstname;
  string representativehomephone;
  string representativelastname;
  string representativessn;
  string representativestate;
  string representativezip;

end;

indata := Distribute(project(f1, TRANSFORM(layout_input, self.accountnumber := (string)left.accountnumber;
                                               
                                               self.HistoryDateYYYYMM := (string)HistoryDate;
																							 SELF.DPPAPurpose := (string)DPPA;
	                                             SELF.GLBPurpose := (string)GLB;	
	                                             self.DataRestrictionMask := DRM;	
																							 self.businessphone := left.phoneno;
																							 self.addr := left.street_addr2;
																							 self.city := left.p_city_name_2;
																							 self.companyname := left.name_company;
																							 self.state := left.st_2;
																							 self.zip := left.z5_2;
																							 self.taxidnumber:=left.fein;
																							 self.representativedob := left.dateofbirth;
																							 self.representativefirstname := left.firstname;
																							 self.representativehomephone := left.homephone;
																							 self.representativelastname := left.lastname;
																							 self.representativessn := left.ssn;
																							 self.representativestate := left.state;
																							 self.representativezip := left.zip;
																																										
																							 
																							 )), Random());
// output(indata, named('biid_in'));

  errx := record
   	string errorcode := '';
   	business_risk.Layout_Final_Denorm - score - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators;  // requested to take the score field out of the layout during testprocessing because batch customers don't see it
   	DATASET(Models.Layout_Model) models;
   end;
   
   errx err_out(indata L) := transform
   	SELF.errorcode := FAILCODE + FAILMESSAGE;
		self.account:=L.accountnumber;
   	self.company_name := L.companyname;
   	self.addr1 := L.addr;
   	self.p_city_name := L.city;
   	self.st := L.state;
   	self.z5 := L.zip;
   	self.phone10 := L.businessphone;
   	self := L;
   	self := [];
   end;


results := soapcall(indata, roxieIP,
				'Business_Risk.InstantID_Service', {indata},
				dataset(errx), 
        RETRY(retry), TIMEOUT(timeout), LITERAL,
        XPATH('Business_Risk.InstantID_ServiceResponse/Results/Result/Dataset[@name=\'Result 1\']/Row'),
				PARALLEL(threads), onfail(err_out(LEFT)));

// output(results, named('biid_xml_results'));

//GLOBAL OUTPUT LAYOUT
Global_output_lay:= RECORD	 
Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout;			 
END;



NewRecs := PROJECT(results,TRANSFORM(Global_output_lay,self.bnap:=left.bnap_indicator;
                                             self.bnas:=left.bnas_indicator;
																						 self.bnat:=left.bnat_indicator;
																						 self.acctno:=left.account;
																						 SELF :=LEFT;
																						 SELF:=[];
																						 ));
					
					
			
					
				did_results:=Scoring_Project_Macros.IID_macro(f1,threads,roxieIP,DPPA,GLB,DRM,HistoryDate);
         
         							
         // fin_layout := record
         // recordof(NewRecs);
         // unsigned6 did;
         // end;
         
         Global_output_lay xform(did_results l, NewRecs r) := TRANSFORM
         self.did := l.did;
         self := r;
         end;
         
         res := JOIN(did_results, NewRecs, left.acctno = right.acctno, xform(left, right),right outer);
         
        
         
         // final_layout := record
         // recordof(res);
         	// #if(include_internal_extras)
         		// RiskProcessing.layout_internal_extras;
         	// #end	
         // end;	
         
         
         Global_output_lay xform1(res l, indata r) := TRANSFORM
         	#if(include_internal_extras)
         		self.DID := l.did; 
         		self.historydate := (string)r.HistoryDateYYYYMM;
         		self.FNamePop := r.representativefirstname<>'';
         		self.LNamePop := r.representativelastname<>'';
         		self.AddrPop := r.addr<>'';
         		self.SSNLength := (string)(length(trim(r.representativessn,left,right))) ;
         		self.DOBPop := r.representativedob<>'';
         		// self.EmailPop := r.email<>'';
         		// self.IPAddrPop := r.ipaddress<>'';
         		self.HPhnPop := r.representativehomephone<>'';
         	#end;
         	self := l;
         	self := [];
         	
         	end;
         	
         	final_output:=join(res,indata,left.acctno=(string)right.accountnumber ,xform1(left, right));	


// output(results, named('biid_results'));
op_final := output(final_output,, outfile_name,thor,compressed, OVERWRITE);


return op_final ;
endmacro;