import ut;

////////////////////////////////////////////////////////////////////////////
//PATCH MAIN BASEFILE: 
//_20100301 adding method_dismiss (Other field additions to come)
//_20100312 adding case_status field
////////////////////////////////////////////////////////////////////////////

origFile := Bankruptcyv2.File_In_Defendants
					  + dataset(ut.foreign_prod + '~thor_data400::in::bankruptcyv3::defendants_full',BankruptcyV2.Layout_In_Defendants,csv(quote('\"')));
					  
origFile2 := dedup(sort(distribute(Bankruptcyv2.File_In_Case
					  + dataset(ut.foreign_prod + '~thor_data400::in::bankruptcyv3::case_full',BankruptcyV2.Layout_In_Case,csv(quote('\"'))),hash(c3code,casenumber))
					  ,c3code,casenumber,dateadded,local),c3code,casenumber,right,local);
					  
courtcodelookup := Bankruptcyv2.File_Lookup_CourtCode;
/////////////////////////////////////////////////////////////////////////
layout_tbl_supp := record
//Supplemental Table Layout (add new fields here)
string50   	TMSID ;
string1     methodDismiss := ''; 				//file def
string1     caseStatus := ''; 					//file case
string250   debtor1AttorneyEmail := ''; //file def
string250		TrusteeEmail := ''; 				//file case
string8 		PlanConfDate := ''; 				//file case
string8  		ConfHearDate := ''; 				//file case
string 	    debtor1Screen:= ''; 				//file def
string 			datePOC := ''; 							//file case
string 			date341 := ''; 							//file case
string 			time341 := ''; 							//file case
string 			location341 := ''; 					//file case	
end;
/////////////////////////////////////////////////////////////////////////
//Create TMSID for Orig Defendent file
layout_tbl_supp getTMSID(origFile L,courtcodelookup R) := transform 	
		string l_courtcode := r.moxie_code;
		string l_caseNumber := if(trim(regexreplace('[0.,/}{\'"*|-]+',l.caseNumber,'')) = '','',
									l.caseNumber);
		string l_temp_caseNumber := if(regexfind(':',l_caseNumber),
								stringlib.stringfilter(trim(l_caseNumber)[2..8],'0123456789'),
		      							if(trim(l_caseNumber)[length(l_caseNumber)..length(l_caseNumber)] = '-',
										stringlib.stringfilter(trim(l_caseNumber)[2..8],'0123456789'),
										stringlib.stringfilter(trim(l_caseNumber),'0123456789')));
		string caseNumber   	:=  l_temp_caseNumber;
		
		self.tmsid := 'BK' + trim(l_courtcode) + trim(l.caseNumber);
		self := L;
end;

tbl_supp := dedup(join(origFile,courtcodelookup,
							left.C3Code = right.C3Courtid,
							getTMSID(left,right),
							left outer,
							lookup),record);
/////////////////////////////////////////////////////////////////////////
//Create TMSID for Orig Case file
layout_tbl_supp getTMSID2(origFile2 L,courtcodelookup R) := transform 	
		string l_courtcode := r.moxie_code;
		string l_caseNumber := if(trim(regexreplace('[0.,/}{\'"*|-]+',l.caseNumber,'')) = '','',
									l.caseNumber);
		string l_temp_caseNumber := if(regexfind(':',l_caseNumber),
								stringlib.stringfilter(trim(l_caseNumber)[2..8],'0123456789'),
		      							if(trim(l_caseNumber)[length(l_caseNumber)..length(l_caseNumber)] = '-',
										stringlib.stringfilter(trim(l_caseNumber)[2..8],'0123456789'),
										stringlib.stringfilter(trim(l_caseNumber),'0123456789')));
		string caseNumber   	:=  l_temp_caseNumber;
		
		self.tmsid := 'BK' + trim(l_courtcode) + trim(l.caseNumber);
		self := L;
end;

tbl_supp2 := dedup(join(origFile2,courtcodelookup,
							left.C3Code = right.C3Courtid,
							getTMSID2(left,right),
							left outer,
							lookup),record);

/////////////////////////////////////////////////////////////////////////
//Combine Defendent and Case Supplemental fields into one table							
layout_tbl_supp getCmbdTbl(tbl_supp L,tbl_supp2 R) := transform 
self.tmsid := if (l.tmsid = r.tmsid,l.tmsid,r.tmsid);
self.methoddismiss := map(l.tmsid = r.tmsid and l.methoddismiss !='' => l.methoddismiss, r.methoddismiss);
self.casestatus := map(l.tmsid = r.tmsid and l.casestatus !='' => l.casestatus, r.casestatus);
self.debtor1AttorneyEmail := map(l.tmsid = r.tmsid and l.debtor1AttorneyEmail !='' => l.debtor1AttorneyEmail, r.debtor1AttorneyEmail);
self.TrusteeEmail := map(l.tmsid = r.tmsid and l.TrusteeEmail !='' => l.TrusteeEmail, r.TrusteeEmail);
self.PlanConfDate := map(l.tmsid = r.tmsid and l.PlanConfDate !='' => l.PlanConfDate, r.PlanConfDate);
self.ConfHearDate := map(l.tmsid = r.tmsid and l.ConfHearDate !='' => l.ConfHearDate, r.ConfHearDate);
self.debtor1Screen:= map(l.tmsid = r.tmsid and l.debtor1Screen !='' => l.debtor1Screen, r.debtor1Screen);
self.datePOC:= stringlib.stringfilter(map(l.tmsid = r.tmsid and l.datePOC!='' => l.datePOC, r.datePOC),'0123456789')[1..8];
self.date341 := stringlib.stringfilter(map(l.tmsid = r.tmsid and l.date341 !='' => l.date341, r.date341),'0123456789')[1..8];
self.time341 := map(l.tmsid = r.tmsid and l.time341  !='' => l.time341 , r.time341 );
self.location341 := map(l.tmsid = r.tmsid and l.location341 !='' => l.location341, r.location341);
end;

cmbdTbl_supp := dedup(join(tbl_supp,tbl_supp2,
							left.tmsid = right.tmsid,
							getCmbdTbl(left,right),
							full outer,
							hash),record);

export proc_build_v3_supplemental := dedup(sort(distribute(cmbdTbl_supp,hash(tmsid)),tmsid,debtor1Screen,local),tmsid,local,right);