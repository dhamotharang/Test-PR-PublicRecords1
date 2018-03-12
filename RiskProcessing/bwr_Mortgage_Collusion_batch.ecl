#workunit('name','bwr_Mortgage_Collusion_batch');
import SNA, RiskWise, Risk_indicators, ut;


//==================  input file layout  ========================
mortgage_collusion_input := record
		unsigned1 	transaction_seq;  
	  unsigned1  	input_seq; 
		unsigned2 	seq;  
		
		string30  AcctNo;  
		string120 StreetAddress;  
		string25  City;
		string2   St;
		string5   Zip;

		string30  Buyer1_First_Name;
		string30  Buyer1_Middle_Name;
		string30  Buyer1_Last_Name;
		string9   Buyer1_SSN;
		string8   Buyer1_DateOfBirth;
		string120 Buyer1_StreetAddress;
		string25  Buyer1_City;
		string2   Buyer1_St;
		string5   Buyer1_Zip;
		
		string30  Buyer2_First_Name;
		string30  Buyer2_Middle_Name;
		string30  Buyer2_Last_Name;
		string9   Buyer2_SSN;
		string8   Buyer2_DateOfBirth;
		string120 Buyer2_StreetAddress;
		string25  Buyer2_City;
		string2   Buyer2_St;
		string5   Buyer2_Zip;
		
		string30  Buyer3_First_Name;
		string30  Buyer3_Middle_Name;
		string30  Buyer3_Last_Name;
		string9   Buyer3_SSN;
		string8   Buyer3_DateOfBirth;
		string120 Buyer3_StreetAddress;
		string25  Buyer3_City;
		string2   Buyer3_St;
		string5   Buyer3_Zip;
	
		string30  Seller1_First_Name;
		string30  Seller1_Middle_Name;
		string30  Seller1_Last_Name;
		string9   Seller1_SSN;
		string8   Seller1_DateOfBirth;
		string120 Seller1_StreetAddress;
		string25  Seller1_City;
		string2   Seller1_St;
		string5   Seller1_Zip;
		
		string30  Seller2_First_Name;
		string30  Seller2_Middle_Name;
		string30  Seller2_Last_Name;
		string9   Seller2_SSN;
		string8   Seller2_DateOfBirth;
		string120 Seller2_StreetAddress;
		string25  Seller2_City;
		string2   Seller2_St;
		string5   Seller2_Zip;
		
		string30  Seller3_First_Name;
		string30  Seller3_Middle_Name;
		string30  Seller3_Last_Name;
		string9   Seller3_SSN;
		string8   Seller3_DateOfBirth;
		string120 Seller3_StreetAddress;
		string25  Seller3_City;
		string2   Seller3_St;
		string5   Seller3_Zip;
	
		string30  Professional1_First_Name;
		string30  Professional1_Middle_Name;
		string30  Professional1_Last_Name;
		string9   Professional1_SSN;
		string8   Professional1_DateOfBirth;
		string120 Professional1_StreetAddress;
		string25  Professional1_City;
		string2   Professional1_St;
		string5   Professional1_Zip;
		string30    Professional1_License_Number;
		string10    Professional1_License_Type;
		
		string30  Professional2_First_Name;
		string30  Professional2_Middle_Name;
		string30  Professional2_Last_Name;
		string9   Professional2_SSN;
		string8   Professional2_DateOfBirth;
		string120 Professional2_StreetAddress;
		string25  Professional2_City;
		string2   Professional2_St;
		string5   Professional2_Zip;
		string30    Professional2_License_Number;       
		string10    Professional2_License_Type;         
		
		string30  Professional3_First_Name;
		string30  Professional3_Middle_Name;
		string30  Professional3_Last_Name;
		string9   Professional3_SSN;
		string8   Professional3_DateOfBirth;
		string120 Professional3_StreetAddress;
		string25  Professional3_City;
		string2   Professional3_St;
		string5   Professional3_Zip;
		string30    Professional3_License_Number;
		string10    Professional3_License_Type;
		integer   HistoryDateYYYYMM;

	end; 

	



eyeball := 50;

roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

inputFile := '~nmontpetit::in::etrade_boca_input';
outputFile := '~tfuerstenberg::out::Fraudpoint_test';
threads := 2;

ds_in := dataset(inputFile, mortgage_collusion_input, csv(heading(1),quote('"')));

ds_inRecs := if(eyeball=0, ds_in, choosen(ds_in, eyeball));

	

mortgage_collusion_input_batch := record
	dataset(mortgage_collusion_input) batch_in;
	unsigned1 glb       								:= 8;
	unsigned1 dppa      								:= 0 ;
	string50 DataRestrictionMask       	:= risk_indicators.iid_constants.default_DataRestriction ;
	integer	bsVersion           				:= 4;
	boolean	isFCRA              				:= false;
	unsigned1 AppendBest 								:= 0;
 DATASET(risk_indicators.Layout_Gateways_In) gateways;
END;
	
mortgage_collusion_input_batch finalin(ds_inRecs le, INTEGER c) := transform
	r2 := project(ut.ds_oneRecord, transform(mortgage_collusion_input, 
		self.transaction_seq          := (integer)le.AcctNo; 
	  self.input_seq 								:= c;
		self.seq                      := (c * 10) + C; 
		
		self.AcctNo          					:= le.AcctNo;
		self.StreetAddress   					:= le.StreetAddress;
		self.City            					:= le.City;
		self.St												:= le.st;
		self.Zip               				:= le.Zip;

		self.Buyer1_First_Name    		:= le.Buyer1_First_Name;
		self.Buyer1_Middle_Name   		:= le.Buyer1_Middle_Name;
		self.Buyer1_Last_Name     		:= le.Buyer1_Last_Name;
		self.Buyer1_SSN								:= le.Buyer1_SSN;
		self.Buyer1_DateOfBirth    		:= le.Buyer1_DateOfBirth;
		self.Buyer1_StreetAddress  		:= le.Buyer1_StreetAddress;
		self.Buyer1_City            	:= le.Buyer1_City;
		self.Buyer1_St            		 := le.Buyer1_St;
		self.Buyer1_Zip            		:= le.Buyer1_Zip;
		self.HistoryDateYYYYMM     		:= le.HistoryDateYYYYMM;

    self.Buyer2_First_Name    		:= le.Buyer2_First_Name;
		self.Buyer2_Middle_Name   			:= le.Buyer2_Middle_Name;
		self.Buyer2_Last_Name     		:= le.Buyer2_Last_Name;
		self.Buyer2_SSN								:= le.Buyer2_SSN;
		self.Buyer2_DateOfBirth    		:= le.Buyer2_DateOfBirth;
		self.Buyer2_StreetAddress  		:= le.Buyer2_StreetAddress;
		self.Buyer2_City            	:= le.Buyer2_City;
		self.Buyer2_St            		 := le.Buyer2_St;
		self.Buyer2_Zip            		:= le.Buyer2_Zip;
		
		self.Buyer3_First_Name    		:= le.Buyer3_First_Name;
		self.Buyer3_Middle_Name   			:= le.Buyer3_Middle_Name;
		self.Buyer3_Last_Name     		:= le.Buyer3_Last_Name;
		self.Buyer3_SSN								:= le.Buyer3_SSN;
		self.Buyer3_DateOfBirth    		:= le.Buyer3_DateOfBirth;
		self.Buyer3_StreetAddress  		:= le.Buyer3_StreetAddress;
		self.Buyer3_City            	:= le.Buyer3_City;
		self.Buyer3_St            		 := le.Buyer3_St;
		self.Buyer3_Zip            		:= le.Buyer3_Zip;
		
		self.seller1_First_Name    		:= le.seller1_First_Name;
		self.seller1_Middle_Name   			:= le.seller1_Middle_Name;
		self.seller1_Last_Name     		:= le.seller1_Last_Name;
		self.seller1_SSN								:= le.seller1_SSN;
		self.seller1_DateOfBirth    		:= le.seller1_DateOfBirth;
		self.seller1_StreetAddress  		:= le.seller1_StreetAddress;
		self.seller1_City            	:= le.seller1_City;
		self.seller1_St            		 := le.seller1_St;
		self.seller1_Zip            		:= le.seller1_Zip;
		
		self.seller2_First_Name    		:= le.seller2_First_Name;
		self.seller2_Middle_Name   			:= le.seller2_Middle_Name;
		self.seller2_Last_Name     		:= le.seller2_Last_Name;
		self.seller2_SSN								:= le.seller2_SSN;
		self.seller2_DateOfBirth    		:= le.seller2_DateOfBirth;
		self.seller2_StreetAddress  		:= le.seller2_StreetAddress;
		self.seller2_City            	:= le.seller2_City;
		self.seller2_St            		 := le.seller2_St;
		self.seller2_Zip            		:= le.seller2_Zip;
		
		self.seller3_First_Name    		:= le.seller3_First_Name;
		self.seller3_Middle_Name   			:= le.seller3_Middle_Name;
		self.seller3_Last_Name     		:= le.seller3_Last_Name;
		self.seller3_SSN								:= le.seller3_SSN;
		self.seller3_DateOfBirth    		:= le.seller3_DateOfBirth;
		self.seller3_StreetAddress  		:= le.seller3_StreetAddress;
		self.seller3_City            	:= le.seller3_City;
		self.seller3_St            		 := le.seller3_St;
		self.seller3_Zip            		:= le.seller3_Zip; 
		
		self.Professional1_First_Name    			:= le.Professional1_First_Name;
		self.Professional1_Middle_Name   			:= le.Professional1_Middle_Name;
		self.Professional1_Last_Name     			:= le.Professional1_Last_Name;
		self.Professional1_SSN								:= le.Professional1_SSN;
		self.Professional1_DateOfBirth    		:= le.Professional1_DateOfBirth;
		self.Professional1_StreetAddress  		:= le.Professional1_StreetAddress;
		self.Professional1_City            		:= le.Professional1_City;
		self.Professional1_St            		 	:= le.Professional1_St;
		self.Professional1_Zip            		:= le.Professional1_Zip;
		
		self.Professional2_First_Name    			:= le.Professional2_First_Name;
		self.Professional2_Middle_Name   			:= le.Professional2_Middle_Name;
		self.Professional2_Last_Name     			:= le.Professional2_Last_Name;
		self.Professional2_SSN								:= le.Professional2_SSN;
		self.Professional2_DateOfBirth    		:= le.Professional2_DateOfBirth;
		self.Professional2_StreetAddress  		:= le.Professional2_StreetAddress;
		self.Professional2_City            		:= le.Professional2_City;
		self.Professional2_St            		 	:= le.Professional2_St;
		self.Professional2_Zip            		:= le.Professional2_Zip;
		
		
		self.Professional3_First_Name    			:= le.Professional3_First_Name;
		self.Professional3_Middle_Name   			:= le.Professional3_Middle_Name;
		self.Professional3_Last_Name     			:= le.Professional3_Last_Name;
		self.Professional3_SSN								:= le.Professional3_SSN;
		self.Professional3_DateOfBirth    		:= le.Professional3_DateOfBirth;
		self.Professional3_StreetAddress  		:= le.Professional3_StreetAddress;
		self.Professional3_City            		:= le.Professional3_City;
		self.Professional3_St            		 	:= le.Professional3_St;
		self.Professional3_Zip            		:= le.Professional3_Zip;
		
		
		self                        	:= [];
		));
	SELF.batch_in := r2;
	SELF.gateways := []; 
END;

MCInput := project(ds_inRecs, finalin(left, counter));

	
MC_out_layout := record
	sna.layouts.mortgage_collusion_output_flat;
	string200 errorCode;
END;
	
	MC_out_layout myfail(MCInput le) := Transform
  SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := [];
end;


MCResults := SOAPCALL(	MCInput, 																	// Record Set
												RoxieIP, 																		// URL
												'SNA.MortgageCollusion_Batch_Service', 								// Service
												{MCInput}, 															// Input Structure
												DATASET(MC_out_layout),
												PARALLEL(threads),
										    onfail(myfail(left))
											);	
											

OUTPUT(MCResults,named('MCResults'));

OUTPUT(MCResults,,'~mwalklin::out::_' + thorlib.wuid(), CSV(QUOTE('"'),HEADING(single)), OVERWRITE);
		
	