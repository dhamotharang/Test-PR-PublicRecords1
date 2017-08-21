import Phonesplus,Gong,Risk_Indicators;

export mac_evaluateCellFile(infile,incellphone,outfile) := macro

#uniquename(t_recs)
#uniquename(p_infile)
#uniquename(dist_infile)
#uniquename(ctTESTED)
#uniquename(ctAfterDedup)
#uniquename(infile_layout)
#uniquename(sourcefile)


%infile_layout% := record
infile;
string %sourcefile%;
end;

%ctTESTED% := count(infile);///////////////Report ENTRY/////////////////////

%infile_layout% %t_recs%(infile L ) := transform
self.incellphone := CellPhone.CleanPhones(L.incellphone);
self.%sourcefile% := '';
self := L; 
end;						

%p_infile% := project(infile,%t_recs%(left));
%dist_infile% := distribute(dedup(%p_infile%,incellphone,all),hash(incellphone))(incellphone!='');


%ctAfterDedup%:= count(%dist_infile%); ///////////////Report ENTRY/////////

/* ********************************************************************* */
//Level 1 to PhonesPlus

#uniquename(pp)
#uniquename(dist_pp)
#uniquename(t_pp)
#uniquename(j_pp)
#uniquename(j_ppt)
#uniquename(j_ppbl)
#uniquename(j_pptbl)
#uniquename(ctAfterPPlusCheck)
#uniquename(ctAfterPPlusCheckbl)
#uniquename(tblCntSrcPlus)
#uniquename(counted)

%pp% := Phonesplus.file_phonesplus_base;
%dist_pp% 	:= distribute(dedup(%pp%,cellphone,all),hash(cellphone));

%dist_infile% %t_pp%(%dist_infile% L ,%dist_pp% R) := transform
self.%sourcefile% := R.sourcefile;
self 		:= L;
end;

%j_pp%	    := join(%dist_infile%,%dist_pp% (confidencescore>=11), //above line
					left.incellphone = right.CellPhone,
					%t_pp%(left,right),left only,local); 
%j_ppt%	    := join(%dist_infile%,%dist_pp% (confidencescore>=11), //above line
					left.incellphone = right.CellPhone,
					%t_pp%(left,right), local); 
					
%j_ppbl%	    := join(%j_pp%,%dist_pp% (confidencescore<11), //below line
					left.incellphone = right.CellPhone,
					%t_pp%(left,right),left only,local); 
%j_pptbl%	    := join(%j_pp%,%dist_pp% (confidencescore<11), //below line
					left.incellphone = right.CellPhone,
					%t_pp%(left,right), local);

%ctAfterPPlusCheck% := count(%j_pp%); ///////////////Report ENTRY//////////
%ctAfterPPlusCheckbl% := count(%j_ppbl%); ///////////////Report ENTRY//////////
/* ********************************************************************* */
//Level 1.2 :) to Infutor CID

#uniquename(ifcid)
#uniquename(dist_ifcid)
#uniquename(t_ifcid)
#uniquename(j_ifcid)
#uniquename(j_ifcidt)
#uniquename(ctAfterIFCIDCheck)
// #uniquename(tblCntSrcPlus)

%ifcid% := infutorcid.File_InfutorCID_Base;
%dist_ifcid% 	:= distribute(dedup(%ifcid%,phone,all),hash(phone));

%j_pp% %t_ifcid%(%j_ppbl% L ,%dist_ifcid% R) := transform
self.%sourcefile% := '';
self 		:= L;
end;

%j_ifcid%	    := join(%j_ppbl%,%dist_ifcid%,
					left.incellphone = right.Phone,
					%t_ifcid%(left,right),left only,local); 
// %j_ifcidt%	    := join(%j_pp%,%dist_ifcid%,
					// left.incellphone = right.Phone,
					// %t_ifcid%(left,right), local); 

%ctAfterIFCIDCheck% := count(%j_ifcid%); ///////////////Report ENTRY//////////
/* ********************************************************************* */
//Level 2 to Gong & Gong History

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

%j_ifcid% %t_gh%(%j_ifcid% L ,%dist_gh% R) := transform
self.%sourcefile% := R.bell_id;
self 		:= L;
end;

%j_gh%		:= join(%j_ifcid%,%dist_gh%,
				left.incellphone = right.phone10,
				%t_gh%(left,right),left only,local); 

%j_ght%		:= join(%j_ifcid%,%dist_gh%,
				left.incellphone = right.phone10,
				%t_gh%(left,right),local); 
				
%ctAfterEDACheck% := count(%j_gh%); ///////////////Report ENTRY////////////
/* ********************************************************************* */
//Level 3 to Headers

#uniquename(hd)
#uniquename(f_hd)
#uniquename(dist_hd)
#uniquename(t_hd)
#uniquename(j_hd)
#uniquename(dist_jhd)
#uniquename(j_hdt)
#uniquename(ctAfterHDRCheck)

%hd% := Header.File_Headers;
%f_hd% := %hd% (phone != '' and length(stringlib.stringfilter(phone,'0123456789')) = 10 and 
				phone[7..10] != '0000'and phone[7..10] != '9999');
%dist_hd% := distribute(dedup(%f_hd%,phone,all),hash(phone));

%j_gh% %t_hd%(%j_gh% L ,%dist_hd% R) := transform
self.%sourcefile% := R.src;
self := L;
end;

%j_hd%	:= join(%j_gh%,%dist_hd%,
		   left.incellphone = right.phone,
		   %t_hd%(left,right),left only,local); 

%j_hdt%	:= join(%j_gh%,%dist_hd%,
		   left.incellphone = right.phone,
		   %t_hd%(left,right),local); 

%dist_jhd% := distribute(%j_hd%,hash(incellphone[1..3],incellphone[4..6],incellphone[7]));

%ctAfterHDRCheck% := count(%dist_jhd%); ///////////////Report ENTRY/////////	   
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

%j_hd% %t_tpm%(%dist_jhd% L, %dist_tpm% R) := transform
self.%sourcefile% := R.ocn;
self := L;
end;


%j_tpm%	:= join(%dist_jhd%,%dist_tpm%,
		   left.incellphone[1..3] = right.npa and 
		   left.incellphone[4..6] = right.nxx and
		   left.incellphone[7]    = right.tb,
		   %t_tpm%(left,right),local); 
		   
%ctPASSED% := count(%j_tpm%);///////////////Report ENTRY////////////////////
//-----------------------------------------------------------------------------------
%j_hd% %t_tpmINVALID%(%dist_jhd% L, %dist_tpm% R) := transform
self := L;
end;
%j_tpmINVALID%	:= join(%dist_jhd%,%dist_tpm%,
		   left.incellphone[1..3] = right.npa and 
		   left.incellphone[4..6] = right.nxx and
		   left.incellphone[7]    = right.tb,
		   %t_tpmINVALID%(left,right),left only, local); 

#uniquename(has_email)
#uniquename(has_lname)
#uniquename(has_fname)
#uniquename(has_company)
#uniquename(has_Address1)
#uniquename(has_Address2)
#uniquename(has_city)
#uniquename(has_state)
#uniquename(has_zip)
#uniquename(has_homephone)
#uniquename(has_gender)
#uniquename(has_dob)
#uniquename(has_cellphone)


%layout_popstats% :=  record

%has_email% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.email,'0')<>'',100,0));
%has_lname% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.lname,'0')<>'',100,0));
%has_fname% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.fname,'0')<>'',100,0));
%has_Address1%	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.Address1,'0')<>'',100,0));
%has_Address2%	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.Address2,'0')<>'',100,0));
%has_city% 		:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.p_city_name,'0')<>'',100,0));
%has_state% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.st,'0')<>'',100,0));
%has_zip% 		:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.zip,'0')<>'',100,0));
%has_homephone% := AVE(group,IF(stringlib.stringfilterout(%j_tpm%.phone,'0')<>'',100,0));
%has_gender% 	:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.gender,'0"')<>'',100,0));
%has_dob% 		:= AVE(group,IF(stringlib.stringfilterout(%j_tpm%.dob,'0"')<>'',100,0));
%has_cellphone% := AVE(group,IF(stringlib.stringfilterout(%j_tpm%.phone,'0"')<>'',100,0));

end;

%popstats% := table(%j_tpm%,%layout_popstats%,few);
%errCtAlphaNumZips% := count(%j_tpm%(regexfind('[a-zA-Z]',zip,0) != ''));
/* ********************************************************************* */	
#uniquename(layout_statSTATE)
#uniquename(statSTATE)
#uniquename(outstatSTATE)

%layout_statSTATE% := record
%j_tpm%.st;
total := count(group);
end;

%statSTATE% := sort(table(%j_tpm%,%layout_statSTATE%,st,few),st); ///////////////Report ENTRY////////////////////

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


outfile := 
parallel(
 output(dataset([{'ctTESTED:              			',%ctTESTED%},
				  {'ctAfterDedup:          			',%ctAfterDedup%},
				  {'ctAfterPPlusCheck(Above):		',%ctAfterPPlusCheck%},
				  {'ctAfterPPlusCheck(Below):   	',%ctAfterPPlusCheckbl%},
				  {'ctAfterIFCIDCheck:     			',%ctAfterIFCIDCheck%},
				  {'ctAfterEDACheck:       			',%ctAfterEDACheck%},
				  {'ctAfterHDRCheck:       			',%ctAfterHDRCheck%},
				  {'ctAfterNPANXXCheck/ctPASSED: 	',%ctPASSED%},
				  {'ctFlaggedCell:         			',%ctFlaggedCell%},
				  {'errCtAlphaNumZips:     			',%errCtAlphaNumZips%}], %layout_out%),named('SampleEvalReport')),

 output(%popstats%,all,named('FieldPopulations')),
 output(table(distribute(%j_ppt%, hash(%sourcefile%)), {%sourcefile%, counted := count(group)}, %sourcefile%), named('Phones_Plus_Sources Above Line')),
 output(table(distribute(%j_pptbl%, hash(%sourcefile%)), {%sourcefile%, counted := count(group)}, %sourcefile%), named('Phones_Plus_Sources Below Line')),
 output(table(distribute(%j_ght%, hash(%sourcefile%)), {%sourcefile%, counted := count(group)}, %sourcefile%), named('Gong_History_Sources')),
 output(table(distribute(%j_hdt%, hash(%sourcefile%)), {%sourcefile%, counted := count(group)}, %sourcefile%), named('Headers_Sources')),
 output(table(distribute(%j_tpm%, hash(%sourcefile%)), {%sourcefile%, counted := count(group)}, %sourcefile%), named('Telcordia_Sources')),
 output(enth(sort(%j_tpm%,st),300),all,named('ct300SamplePassed')),
 
 output(%j_tpm%(regexfind('[a-zA-Z]',zip,0) != ''),named('ct100SampleAlphaNumZips')),
 output(enth(%j_tpmINVALID%,100),named('ct100SampleInvalidNPANXX')),
 output(%statSTATE%,all,named('RecordCountsPerState')));

endmacro;