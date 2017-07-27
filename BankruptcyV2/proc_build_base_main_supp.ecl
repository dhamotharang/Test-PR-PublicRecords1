export proc_build_base_main_supp(dataset(recordof(BankruptcyV2.file_bankruptcy_main_v3)) infile) := function

////////////////////////////////////////////////////////////////////////////
//PATCH MAIN BASEFILE: 
//_20100301 adding method_dismiss (Other field additions to come)
//_20100312 adding case_status field
////////////////////////////////////////////////////////////////////////////

origFile := Bankruptcyv2.File_In_Defendants
					  + dataset('~thor_data400::in::bankruptcyv3::defendants_full',BankruptcyV2.Layout_In_Defendants,csv(quote('\"')));
					  
origFile2 := dedup(sort(distribute(Bankruptcyv2.File_In_Case
					  + dataset('~thor_data400::in::bankruptcyv3::case_full',BankruptcyV2.Layout_In_Case,csv(quote('\"'))),hash(c3code,casenumber))
					  ,c3code,casenumber,dateadded,local),c3code,casenumber,right,local);
					  
courtcodelookup := Bankruptcyv2.File_Lookup_CourtCode;
/////////////////////////////////////////////////////////////////////////
//Supplemental Table Layout (add new fields here)
layout_tbl_supp := record
string50   	TMSID ;
string1     methodDismiss := '';
string1     caseStatus := '';
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

end;

cmbdTbl_supp := dedup(join(tbl_supp,tbl_supp2,
							left.tmsid = right.tmsid,
							getCmbdTbl(left,right),
							full outer,
							hash),record);
	
//Add method dismiss field and populate
BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp patchBase(infile L, cmbdTbl_supp R) := transform
self.method_dismiss := if(l.tmsid=r.tmsid,R.methodDismiss,'');
self.case_status    := if(l.tmsid=r.tmsid,R.caseStatus,'');
self := L;
end;

outfile:= join(infile, cmbdTbl_supp,
		left.tmsid = right.tmsid,
		patchBase(left,right),left outer,lookup);
		

							
return outfile;		
end;