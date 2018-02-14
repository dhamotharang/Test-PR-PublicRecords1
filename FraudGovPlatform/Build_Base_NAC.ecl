Import ut,tools,inquiry_acclogs,FraudShared,Address; 

EXPORT Build_Base_NAC (
   string pversion
	,dataset(Layouts.Input.NAC) inNACUpdate = Files().Input.NAC.Sprayed
) := 
module 

	Functions.CleanFields(inNACUpdate ,inNACUpdateUpper);
	shared _inNACUpdateUpper := inNACUpdateUpper;
	Mbs_ds := FraudShared.Files().Input.MBS.sprayed(status = 1);
	
	Layouts.Base.IdentityData	tIDDTPrep(_inNACUpdateUpper	l,integer	cnt)	:=
	transform
				
						self.process_date                   	:= (unsigned) l.ProcessDate, 
						self.dt_first_seen								:= (unsigned) l.ProcessDate; 
						self.dt_last_seen									:= (unsigned) l.ProcessDate;
						self.dt_vendor_last_reported				:= (unsigned) l.ProcessDate; 
						self.dt_vendor_first_reported				:= (unsigned) l.ProcessDate; 
						self.Unique_Id										:= 0; 
					  self.source_rec_id								:= 0;																	
						// add  address and name prep 
					  self.current											:= 'C' ; 
						cleanperson73										:= Address.cleanperson73(l.SearchFullName);
						self.Client_ID										:= '196969851';
						self.Customer_State								:= 'FL';
						self.Customer_Program							:= 'N';  // NAC SNAP
						self.Customer_Agency_Vertical_Type		:= 'S';
						self.Customer_County							:= '001';
 						self.cleaned_name.title						:= ut.CleanSpacesAndUpper(cleanperson73[1..5]); 
						self.cleaned_name.fname						:= ut.CleanSpacesAndUpper(cleanperson73[6..25]);
						self.cleaned_name.mname						:= ut.CleanSpacesAndUpper(cleanperson73[26..45]); 
						self.cleaned_name.lname						:= ut.CleanSpacesAndUpper(cleanperson73[46..65]);
						self.cleaned_name.name_suffix				:= ut.CleanSpacesAndUpper(cleanperson73[66..70]); 
						self.cleaned_name.name_score				:= ut.CleanSpacesAndUpper(cleanperson73[71..73]);
						self.Case_ID											:= l.SearchCaseId;
						//self.Client_ID										:= l.SearchClientId
						self.Full_Name										:= l.SearchFullName;
						self.Last_Name										:= l.SearchLastName;
						self.First_name									:= l.SearchFirstName;
						self.Middle_Name									:= l.SearchMiddleName;
						self.Suffix											:= l.SearchSuffix;
						self.SSN												:= l.SearchSSN;
						self.dob												:= l.SearchDOB;
						self.Physical_Address_1						:= l.SearchAddress1StreetAddress1;
						self.Physical_Address_2						:= l.SearchAddress1StreetAddress2;
						self.City												:= l.SearchAddress1City;
						self.State											:= l.SearchAddress1State;
						self.Zip												:= l.SearchAddress1Zip;
						self.Mailing_Address_1							:= l.SearchAddress2StreetAddress1;
						self.Mailing_Address_2							:= l.SearchAddress2StreetAddress2;
						self.Mailing_City									:= l.SearchAddress2City;
						self.Mailing_State								:= l.SearchAddress2State;
						self.Mailing_Zip									:= l.SearchAddress2Zip;						
						self														:= l; 
						self														:= []; 
   end; 
		
	export NACIDDTUpdate	:=	project(dedup(_inNACUpdateUpper(ActivityType in ['1','2']) ,all),tIDDTPrep(left,counter));  		


	Layouts.Base.KnownFraud	tKNFDPrep(_inNACUpdateUpper	l,integer	cnt)	:=
	transform
				
						self.process_date                   	:= (unsigned) l.ProcessDate, 
						self.dt_first_seen								:= (unsigned) l.ProcessDate; 
						self.dt_last_seen									:= (unsigned) l.ProcessDate;
						self.dt_vendor_last_reported				:= (unsigned) l.ProcessDate; 
						self.dt_vendor_first_reported				:= (unsigned) l.ProcessDate; 
						self.Unique_Id										:= 0; 
					  self.source_rec_id								:= 0;																	
						// add  address and name prep 
					  self.current											:= 'C' ; 
						cleanperson73										:= Address.cleanperson73(l.ClientFirstName + ' ' + l.ClientMiddleName + ' ' + l.ClientLastName);
						self.client_id										:= '196969851';
						self.Customer_State								:= 'FL';
						self.Customer_Program							:= 'N';  // NAC SNAP
						self.customer_agency_vertical_type		:= 'S';
						self.Customer_County							:= '001';
 						self.cleaned_name.title						:= ut.CleanSpacesAndUpper(cleanperson73[1..5]); 
						self.cleaned_name.fname						:= ut.CleanSpacesAndUpper(cleanperson73[6..25]);
						self.cleaned_name.mname						:= ut.CleanSpacesAndUpper(cleanperson73[26..45]); 
						self.cleaned_name.lname						:= ut.CleanSpacesAndUpper(cleanperson73[46..65]);
						self.cleaned_name.name_suffix				:= ut.CleanSpacesAndUpper(cleanperson73[66..70]); 
						self.cleaned_name.name_score				:= ut.CleanSpacesAndUpper(cleanperson73[71..73]);
						self.Case_ID											:= (unsigned8)l.CaseID;
						self.last_name										:= l.ClientLastName;
						self.first_name									:= l.ClientFirstName;
						self.middle_name									:= l.ClientMiddleName;
						self.ssn												:= l.ClientSSN;
						self.dob												:= l.ClientDOB;
						self.phone_number									:= l.ClientPhone;
						// self.Ethnicity										:= l.ClientEthnicity;
						// self.Race												:= l.ClientRace;						
						self.email_address								:= l.ClientEmail;
						self														:= l; 
						self														:= []; 
   end; 
	
	export NACKNFDUpdate	:=	project(dedup(_inNACUpdateUpper(ActivityType ='4') ,all),tKNFDPrep(left,counter));
	
end;
