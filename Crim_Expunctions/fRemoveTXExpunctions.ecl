import Crim_Common, Crim, ut, Address;

export fRemoveTXExpunctions(dataset(Crim_Common.Layout_In_Court_Offender) offnd) := function 

offns := CRIM.Map_TX_Offenses;
nondis:= CRIM.File_TX_Statewide.nondisclosures;
expgd := CRIM.File_TX_Statewide.expunged;
okc_expgd := CRIM.File_TX_Statewide.okc_expunged;

////////////////////////////////////////////////////////////////////
//Clean ExpungeFile
////////////////////////////////////////////////////////////////////
cleanLayout := record
string id;
string source;
string lastname;
string firstname;
string middlename;
string DOB;
string offense;
string filedate;
string arrestdate;
string DLNumber;
string DPS_NBR;
string NAM_TXT;
string DOB_DTE;
string AGY_TXT;
string TRN_NBR;
string TRS_COD;
string DOA_DTE;
string DOO_DTE;
string AON_COD;
string AON_LIT;
string AOL_TXT;
string CAU_NBR;
string CDD_DTE;
string CPR_COD;
string	caseno;
string8 clean_dob;
string8 offense_date;
string5 title;
string20 fname;
string20 mname;
string20 lname;
string5 name_suffix;
string3 cleaning_score;
offns.offender_key;
string20 offnd_fname;
string20 offnd_mname;
string20 offnd_lname;
string8 offnd_dob;
offns.court_case_number;
offns.court_off_desc_1;
offns.off_date;
end;

////////////////////////////////////////////////////////////////////
//Temp OKC_ExpungeFile
////////////////////////////////////////////////////////////////////
okc_expunged_output := 
record
string Source;
string record_id;
string date_added;
string first_name;
string last_name;
string middle_name;
string address_line_1;
string address_line_2;
string city;
string state;
string zip;
string date_of_birth;
string social_security_number;
string offense_state;
string offense_county;
string case_number;
string offense_description;
string offense_date;
string attachment_link;
end;

cleanLayout trecs(expgd L) := transform

///////////////////format dob
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');

//////////////////clean name	
CleanName			:= Address.CleanPersonLFM73(L.lastname + ' ' + L.firstname + ' ' + L.middlename);
self.caseno			:= stringlib.stringfilterout(L.id,'"');
self.clean_dob		:= getReasonableRange(fSlashedMDYtoCYMD(L.DOB));
self.filedate		:= getReasonableRange(fSlashedMDYtoCYMD(L.filedate));
self.arrestdate		:= getReasonableRange(fSlashedMDYtoCYMD(L.arrestdate));	
self.offense_date	:= '';	//no offense date provided				  
self.title 			:= CleanName[1..5];
self.fname 			:= CleanName[6..25];
self.mname 			:= CleanName[26..45];
self.lname 			:= CleanName[46..65];
self.name_suffix 	:= CleanName[66..70];
self.cleaning_score := CleanName[71..73];
self := L;
self := [];
end;

pExpgd := project(expgd,trecs(left));


////////////////////////////////////////////////////////////////////
//Clean NonDisclosure File
///////////////////////////////////////////////////////////////////

cleanLayout trecs2( nondis L) := transform

///////////////////format dob
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');

//////////////////clean name	
CleanName			:= Address.CleanPersonLFM73(regexreplace(',',L.NAM_TXT,', '));
self.caseno			:= L.cau_nbr;
self.clean_dob		:= getReasonableRange(fSlashedMDYtoCYMD(L.DOB_DTE));
self.offense_date	:= stringlib.stringfilterout(L.DOO_DTE,'/');					  
self.title 			:= CleanName[1..5];
self.fname 			:= CleanName[6..25];
self.mname 			:= CleanName[26..45];
self.lname 			:= CleanName[46..65];
self.name_suffix 	:= CleanName[66..70];
self.cleaning_score := CleanName[71..73];
self := L;
self := [];
end;

pNondis := project(nondis,trecs2(left));

///////////////////////////////////////////////////////////////////
//Normalize OKC Expunctions
///////////////////////////////////////////////////////////////////

okc_expunged_output NormIt(CRIM.Layout_TX_Statewide.okc_expunged L, INTEGER C) := TRANSFORM
SELF := L;
SELF.case_number := CHOOSE(C, L.case_number_1, L.case_number_2, L.case_number_3);
SELF.offense_description := CHOOSE(C, L.offense_description_1, L.offense_description_2, L.offense_description_3);
SELF.offense_date := CHOOSE(C, L.offense_date_1, L.offense_date_2, L.offense_date_3);
END;

NormOffense := NORMALIZE(okc_expgd,3,NormIt(LEFT,COUNTER));

fNormOffense := NormOffense(case_number <> '');

////////////////////////////////////////////////////////////////////
//Clean OKC_expunge file
///////////////////////////////////////////////////////////////////
cleanLayout okc_trecs(fNormOffense L) := transform

///////////////////format dob
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string8     getReasonableRange(string newDateIn) 
:=    map((newDateIn[1..2] between '19' and '20') and 
			(newDateIn < ut.GetDate) => newDateIn,'');

//////////////////clean name	
CleanName			:= Address.CleanPersonLFM73(L.last_name + ' ' + L.first_name + ' ' + L.middle_name);
self.caseno			:= stringlib.stringfilterout(L.case_number,'"');
self.clean_dob		:= getReasonableRange(fSlashedMDYtoCYMD(L.date_of_birth));
self.filedate		:= getReasonableRange(fSlashedMDYtoCYMD(L.date_added));
self.arrestdate		:= '';	
self.offense_date	:= getReasonableRange(fSlashedMDYtoCYMD(L.offense_date));				  
self.title 			:= CleanName[1..5];
self.fname 			:= CleanName[6..25];
self.mname 			:= CleanName[26..45];
self.lname 			:= CleanName[46..65];
self.name_suffix 	:= CleanName[66..70];
self.cleaning_score := CleanName[71..73];
self := L;
self := [];
end;

pOKC_Expgd := project(fNormOffense,okc_trecs(left));

///////////////////////////////////////////////////////////////////
//Remove Expunctions - Scenario 1 = match on caseno,lname,fname.dob
///////////////////////////////////////////////////////////////////
allExp := pExpgd + pNondis + pOKC_Expgd;
	
cleanLayout trecs3(offns L, allExp R) := transform

self := L;
self := R;
end;

jrecs := join(offns(court_case_number<>''), allExp, // get expunged offense record with matching caseno
				left.court_case_number = right.cau_nbr,
				trecs3(left,right),lookup): persist('~thor_data400::persist::TX_expunged_caseno');
//////////////////////////////////////////////////////////////////////////
//Remove Expunctions - Scenario 2 = match on lname,fname,dob,offense_date
//////////////////////////////////////////////////////////////////////////	
cleanLayout trecs4(offns L, allExp R) := transform
self := L;
self := R;

end;

jrecs1 := join(offns(court_case_number<>''), allExp, // get expunged offense record with matching offense date
				left.off_date = right.offense_date,
				trecs4(left,right),lookup): persist('~thor_data400::persist::TX_expunged_offdt');
//------------------------------------------------------				
cmbndRecs := jrecs+jrecs1;

cmbndRecs trecs5(offnd L, cmbndRecs R) := transform
self := R;
self := L;
end;

jrecs2 := join(distribute(offnd(lname+fname<>''),hash(offender_key)), distribute(cmbndRecs,hash(offender_key)),  // get corresponding offender record from offenses above that match on the proper name and dob criteria
				left.offender_key = right.offender_key and
				left.lname = right.lname and 
				left.fname = right.fname and
				left.dob   = right.clean_dob,
				trecs5(left,right),local): persist('~thor_data400::persist::TX_expunged_' + Crim_Common.Version_Development);


offnd trecs6(offnd L, jrecs2 R) := transform
self := L;
end;


jrecs3 := join(distribute(offnd,hash(offender_key)), distribute(jrecs2,hash(offender_key)),  // get offender records that have not been expunged
				left.offender_key = right.offender_key,
				trecs6(left,right),left only,local);


return	
jrecs3;					
end;

		



