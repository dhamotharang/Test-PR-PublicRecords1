import Phonesplus,Gong, lib_thorlib, Risk_Indicators;

export mac_evaluateCellFileBusiness(infile,incellphone,outfile) := macro

/* ********************************************************************* */
// Prep Incoming File
#uniquename(t_recs)
#uniquename(p_infile)
#uniquename(dist_infile)
#uniquename(ctTESTED)
#uniquename(ctAfterDedup)
#uniquename(infile_layout)
#uniquename(sourcefile)
#uniquename(file)


%infile_layout% := record
infile;
string %sourcefile%;
string %file%;
end;

%ctTESTED% := count(infile);///////////////Report ENTRY/////////////////////

%infile_layout% %t_recs%(infile L ) := transform
self.incellphone := CellPhone.CleanPhones(L.incellphone);
self.%sourcefile% := '';
self.%file% := '';
self := L; 
end;						

%p_infile% := project(infile,%t_recs%(left));
%dist_infile% := distribute(dedup(%p_infile%(incellphone!=''),incellphone,all),hash(incellphone));


%ctAfterDedup%:= count(%dist_infile%); ///////////////Report ENTRY/////////
/* ********************************************************************* */
//Level 1 to Gong & Gong History

#uniquename(gh)
#uniquename(f_gh)
#uniquename(dist_gh)
#uniquename(t_gh)
#uniquename(j_gh)
#uniquename(ctAfterEDACheck) 
#uniquename(j_ght)


%gh%        := Gong.File_History;
%f_gh%	    := %gh%(phone10 != '' and length(stringlib.stringfilter(phone10,'0123456789')) = 10 and 
				phone10[7..10] != '0000' and phone10[7..10] != '9999' and publish_code != 'N');
%dist_gh%   := distribute(dedup(%f_gh%,phone10,all),hash(phone10)); 

%dist_infile% %t_gh%(%dist_infile% L ,%dist_gh% R) := transform
self.%sourcefile% :=R.bell_id;
self.%file% :=  'EDA';
self 		:= L;
end;

%j_gh%		:= join(%dist_infile%,%dist_gh%,
				left.incellphone = right.phone10,
				%t_gh%(left,right),left only,local); 

%j_ght%		:= join(%dist_infile%,%dist_gh%,
				left.incellphone = right.phone10,
				%t_gh%(left,right),local); 
				
%ctAfterEDACheck% := count(%j_gh%); ///////////////Report ENTRY////////////
/* ********************************************************************* */
//Level 2 to Business Header

#uniquename(bh)
#uniquename(f_bh)
#uniquename(dist_bh)
#uniquename(t_bh)
#uniquename(j_bh)
#uniquename(dist_jbh)
#uniquename(j_bht)
#uniquename(ctAfterBHCheck)

%bh% := business_header.File_Business_Header;
%f_bh% := %bh% ((string)phone != '' and length(stringlib.stringfilter((string)phone,'0123456789')) = 10 and 
				(string)phone[7..10] != '0000'and (string)phone[7..10] != '9999');
%dist_bh% := distribute(dedup(%f_bh%,phone,all),hash(phone));

%j_gh% %t_bh%(%j_gh% L ,%dist_bh% R) := transform
self.%sourcefile% := R.source;
self.%file% :=  'BH';
self := L;
end;

%j_bh%	:= join(%j_gh%,%dist_bh%,
		   left.incellphone = (string)right.phone,
		   %t_bh%(left,right),left only,local); 

%j_bht%	:= join(%j_gh%,%dist_bh%,
		   left.incellphone = (string)right.phone,
		   %t_bh%(left,right),local); 

%dist_jbh% := distribute(%j_bh%,hash(incellphone[1..3],incellphone[4..6],incellphone[7]));

%ctAfterBHCheck% := count(%dist_jbh%); ///////////////Report ENTRY/////////	   
/* ********************************************************************* */
//Level 3 to People At Work

#uniquename(pw)
#uniquename(f_pw)
#uniquename(dist_pw)
#uniquename(t_pw)
#uniquename(j_pw)
#uniquename(dist_jpw)
#uniquename(j_pwt)
#uniquename(ctAfterPAWCheck)

%pw% := paw.File_Base;
%f_pw% := %pw% (company_phone != '' and length(stringlib.stringfilter(company_phone,'0123456789')) = 10 and 
				company_phone[7..10] != '0000'and company_phone[7..10] != '9999');
%dist_pw% := distribute(dedup(%f_pw%,company_phone,all),hash(company_phone));

%j_gh% %t_pw%(%j_gh% L ,%dist_pw% R) := transform
self.%sourcefile% := R.source;
self.%file% :=  'PAW';
self := L;
end;

%j_pw%	:= join(%j_gh%,%dist_pw%,
		   left.incellphone = right.company_phone,
		   %t_pw%(left,right),left only,local); 

%j_pwt%	:= join(%j_gh%,%dist_pw%,
		   left.incellphone = right.company_phone,
		   %t_pw%(left,right),local); 

%dist_jpw% := distribute(%j_pw%,hash(incellphone[1..3],incellphone[4..6],incellphone[7]));

%ctAfterPAWCheck% := count(%dist_jpw%); ///////////////Report ENTRY/////////	   
/* ********************************************************************* */	
//Level 4 to Telcordia TPM

#uniquename(tpm)
#uniquename(dist_tpm)
#uniquename(t_tpm)
#uniquename(j_tpm)
#uniquename(t_tpmINVALID)
#uniquename(j_tpmINVALID)
#uniquename(layout_popstats)
#uniquename(popstats)
#uniquename(ctPASSED)
#uniquename(outSamplePASSED)
#uniquename(errCtAlphaNumZips)
#uniquename(outSampleAlphaNumZips)


%tpm% := Risk_Indicators.File_Telcordia_tpm;
%dist_tpm% := distribute(dedup(%tpm%,npa,nxx,tb,all),hash(npa,nxx,tb));

%dist_jpw% %t_tpm%(%dist_jpw% L, %dist_tpm% R) := transform
self.%sourcefile% := R.ocn;
self := L;
end;


%j_tpm%	:= join(%dist_jpw%,%dist_tpm%,
		   left.incellphone[1..3] = right.npa and 
		   left.incellphone[4..6] = right.nxx and
		   left.incellphone[7]    = right.tb,
		   %t_tpm%(left,right),local); 
		   
%ctPASSED% := count(%j_tpm%);///////////////Report ENTRY////////////////////
%j_pw% %t_tpmINVALID%(%dist_jpw% L, %dist_tpm% R) := transform
self := L;
end;

%j_tpmINVALID%	:= join(%dist_jpw%,%dist_tpm%,
		   left.incellphone[1..3] = right.npa and 
		   left.incellphone[4..6] = right.nxx and
		   left.incellphone[7]    = right.tb,
		   %t_tpmINVALID%(left,right),left only, local); 

/* ********************************************************************* */	
//Level 5 to Telcordia TDS

#uniquename(tds)
#uniquename(dist_tds)
#uniquename(layout_tdsTypes)
#uniquename(t_tds)
#uniquename(j_tds)

%tds% := Risk_Indicators.File_Telcordia_tds; 
%dist_tds% := distribute(dedup(%tds%,npa,nxx,tb,all),hash(npa,nxx,tb));

%layout_tdsTypes% := record
string cell_npa;
string cell_nxx;
string cell_tb;
string tds_COCType;
string tds_SCC;
end;


%layout_tdsTypes% %t_tds%(%j_tpm% L ,%dist_tds% R) := transform
self.cell_npa := L.incellphone[1..3];
self.cell_nxx := L.incellphone[4..6];
self.cell_tb  := L.incellphone[7];
self.tds_COCType := R.COCType;
self.tds_SCC := R.SCC;
end;

%j_tds%	:= join(%j_tpm%,%dist_tds%,
					left.incellphone[1..3] = right.npa and 
					left.incellphone[4..6] = right.nxx and
					left.incellphone[7] = right.tb,
					%t_tds%(left,right), local); 

#uniquename(ctFlaggedCell)
%ctFlaggedCell% := count(%j_tds%(regexfind('C|R|S',tds_SCC,0) != ''));

#uniquename(out)
#uniquename(layout_out)
%layout_out% := record
string   fieldName;
unsigned fieldVal;
end;

//-----------------------------------------------------------------------------------
//Level 6 Phone Types Yellowpages
#uniquename(phoneType1)
#uniquename(d1out)
#uniquename(ctPhoneTypes)

YellowPages.NPA_PhoneType(%j_tpm%,incellphone,%phoneType1%,%d1out%);

%ctPhoneTypes% := table(%d1out%, {%phoneType1%, count_ := count(group)}, %phoneType1%);

//-----------------------------------------------------------------------------------

// NOW PERFORMED AFTER MACRO MANUALLY
// #uniquename(has_email)
// #uniquename(has_lname)
// #uniquename(has_fname)
// #uniquename(has_company)
// #uniquename(has_Address1)
// #uniquename(has_Address2)
// #uniquename(has_city)
// #uniquename(has_state)
// #uniquename(has_zip)
// #uniquename(has_homephone)
// #uniquename(has_gender)
// #uniquename(has_dob)
// #uniquename(has_cellphone)


// %layout_popstats% :=  record

// %has_email% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.email,'0')<>'',100,0));
// %has_lname% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.lname,'0')<>'',100,0));
// %has_fname% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.fname,'0')<>'',100,0));
// %has_Address1%	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.Address1,'0')<>'',100,0));
// %has_Address2%	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.Address2,'0')<>'',100,0));
// %has_city% 		:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.city,'0')<>'',100,0));
// %has_state% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.state,'0')<>'',100,0));
// %has_zip% 		:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.zip,'0')<>'',100,0));
// %has_homephone% := AVE(group,IF(stringlib.stringfilterout(%j_tpm%.phone,'0')<>'',100,0));
// %has_gender% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.gender,'0"')<>'',100,0));
// %has_dob% 		:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.dob,'0"')<>'',100,0));
// %has_cellphone% := AVE(group,IF(stringlib.stringfilterout(%j_tpm%.cellphone,'0"')<>'',100,0));

// end;

// %popstats% := table(%j_tpm%,%layout_popstats%,few);
// %errCtAlphaNumZips% := count(%j_tpm%(regexfind('[a-zA-Z]',zip,0) != ''));
/* ********************************************************************* */	
// #uniquename(layout_statSTATE)
// #uniquename(statSTATE)
// #uniquename(outstatSTATE)

// %layout_statSTATE% := record
// %j_tpm%.state;
// total := count(group);
// end;

// %statSTATE% := sort(table(%j_tpm%,%layout_statSTATE%,state,few),state); ///////////////Report ENTRY////////////////////

/* ********************************************************************* */		   

#if (count(%ctPASSED%) > 1000000)
outfile := 
parallel(
 output(dataset([ {'Total Records:',%ctTESTED%},
				  {'Count After Removed Duplicates:',%ctAfterDedup%},
				  {'Count After EDA Removals:',%ctAfterEDACheck%},
				  {'Count After Business Header Removals:',%ctAfterBHCheck%},
				  {'Count After People At Work Removals:',%ctAfterPAWCheck%},
				  {'Count After NPA/NXX/TB Check (Passed):',%ctPASSED%},
				  {'Passed Records Flagged Cell:',%ctFlaggedCell%}
				  // ,{'errCtAlphaNumZips:     			',%errCtAlphaNumZips%}
				  ], %layout_out%),named('Sample_Evaluation_Report')),

 // output(%popstats%,all,named('FieldPopulations')),
 output(table(distribute(%j_ght%+%j_bht%+%j_pwt%+%j_tpm%, hash(%sourcefile%)), {%sourcefile%, counted := count(group)}, %sourcefile%), named('Sources_Codes')),
 output(%j_tpm%,,'out::phone_eval::Passed_'+thorlib.wuid(), expire(7)),
 output(enth(sort(%j_tpm%,incellphone[1..3]),300),,'out::phone_eval::Small_Sample_Passed_Extract_'+thorlib.wuid(), expire(7)),
 output(enth(sort(%j_tpm%,incellphone[1..3]),1000000),,'out::phone_eval::Large_Sample_Passed_Extract_'+thorlib.wuid(), expire(7)),
 // output(%j_tpm%(regexfind('[a-zA-Z]',zip,0) != ''),named('ct100SampleAlphaNumZips')),
 output(enth(%j_tpmINVALID%,100),,'out::phone_eval::Sample_Invalid_'+thorlib.wuid(), expire(7)),
 output(%ctPhoneTypes%,named('Phone_Types'))
 // ,output(%statSTATE%,all,named('RecordCountsPerState'))
 );

#else
outfile := 
parallel(
 output(dataset([ {'Total Records:',%ctTESTED%},
				  {'Count After Removed Duplicates:',%ctAfterDedup%},
				  {'Count After EDA Removals:',%ctAfterEDACheck%},
				  {'Count After Business Header Removals:',%ctAfterBHCheck%},
				  {'Count After People At Work Removals:',%ctAfterPAWCheck%},
				  {'Count After NPA/NXX/TB Check (Passed):',%ctPASSED%},
				  {'Passed Records Flagged Cell:',%ctFlaggedCell%}
				  // ,{'errCtAlphaNumZips:     			',%errCtAlphaNumZips%}
				  ], %layout_out%),named('Sample_Evaluation_Report')),

 // output(%popstats%,all,named('FieldPopulations')),
 output(table(distribute(%j_ght%+%j_bht%+%j_pwt%+%j_tpm%, hash(%sourcefile%)), {%file%,%sourcefile%, counted := count(group)}, %sourcefile%), named('Sources_Codes'), all),
 output(%j_tpm%,,'out::phone_eval::Passed_'+thorlib.wuid(), expire(7)),
 output(enth(sort(%j_tpm%,incellphone[1..3]),300),,'out::phone_eval::Small_Sample_Passed_Extract_'+thorlib.wuid(), expire(7)),
 // output(%j_tpm%(regexfind('[a-zA-Z]',zip,0) != ''),named('ct100SampleAlphaNumZips')),
 output(enth(%j_tpmINVALID%,100),,'out::phone_eval::Sample_Invalid_'+thorlib.wuid(), expire(7)),
 output(%ctPhoneTypes%,named('Phone_Types'))
 // ,output(%statSTATE%,all,named('RecordCountsPerState'))
 );
 
 #end
endmacro;