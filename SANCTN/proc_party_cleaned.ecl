IMPORT SANCTN, Address;
//added attribute for Bug # 39235
export proc_party_cleaned(dataset(layout_SANCTN_party_clean) j_party_toclean ) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Build Party Parent/Child Datset
/////////////////////////////////////////////////////////////////////////////////

//party := distribute(SANCTN.clean_party,hash(batch_number,incident_number));  (getting a wierd "way error")
//incident := distribute(SANCTN.clean_incident,hash(batch_number,incident_number));

SANCTN.layout_SANCTN_party_clean clean_SANCTN_party(j_party_toclean input) := TRANSFORM
   // Set the local values
is_company      := SANCTN.fIsCompany(stringlib.StringToUpperCase(trim(input.party_name)));
   //Bug #39235  added party_firm data
   CmpName      := SANCTN.fIsCompany(stringlib.StringToUpperCase(trim(input.PARTY_FIRM)));
   
   tempPName    := if(is_company or length(trim(input.party_name)) < 5 
                     ,''
				              ,Address.CleanPersonLFM73(input.party_name));
	 CleanPName  := if( tempPName[71..73] != '000',tempPName[71..73],'');
   tempPFirm    := if(CmpName or ((INTEGER)tempPName[71..73] < 80) 
                     ,''
				              ,Address.CleanPersonLFM73(input.PARTY_FIRM));
	CleanPFirm   := if ( tempPFirm[71..73] != '000',tempPFirm[71..73],'');
  
  self.title 			:= map(input.party_position <> '' and input.party_name <> '' => tempPName[1..5],
	                         input.party_position = '' and NOT(is_company) or NOT((INTEGER)tempPName[71..73] < 80) AND input.party_name <> '' and regexfind(',',input.party_name) = true => tempPName[1..5],tempPFirm[1..5]);
  self.fname 			:= map(input.party_position <> '' and input.party_name <> '' => tempPName[6..25],
	                    input.party_position = '' and NOT(is_company) or NOT((INTEGER)tempPName[71..73] < 80) AND input.party_name <> ''and regexfind(',',input.party_name) = true => tempPName[6..25],tempPFirm[6..25]);
  self.mname 			:= map(input.party_position <> '' and input.party_name <> '' => tempPName[26..45],
	                      input.party_position = '' and NOT(is_company) or NOT((INTEGER)tempPName[71..73] < 80) AND input.party_name <> '' and regexfind(',',input.party_name) = true => tempPName[26..45],tempPFirm[26..45]);
  self.lname 			:= map( input.party_position <> ''  and input.party_name <> '' => tempPName[46..65],
	                       input.party_position = '' and NOT(is_company) or NOT((INTEGER)tempPName[71..73] < 80) AND input.party_name <> '' and regexfind(',',input.party_name) = true => tempPName[46..65],tempPFirm[46..65]);
   self.name_suffix 	:= map( input.party_position <> '' and input.party_name <> '' => tempPName[66..70],
	                        input.party_position = '' and NOT(is_company) or NOT((INTEGER)tempPName[71..73] < 80) AND input.party_name <> '' and regexfind(',',input.party_name) = true => tempPName[66..70],tempPFirm[66..70]);
   self.name_score 		:= map( input.party_position <> '' and input.party_name <> '' => CleanPName,
	                     input.party_position = '' and NOT(is_company) and NOT((INTEGER)tempPName[71..73] > 80) AND input.party_name <> '' and regexfind(',',input.party_name) = true => CleanPName,CleanPFirm); 
   self.cname        := map( length(trim(input.party_name)) > 3  and length(trim(input.party_name)) < 5 and input.party_name <> '' and is_company => stringlib.StringToUpperCase(trim(input.party_name)),
	                          input.party_position = '' and is_company and input.party_name <> '' => stringlib.StringToUpperCase(trim(input.party_name)),
														input.party_position = '' and NOT(is_company) and regexfind(',',input.party_name) = true and trim(input.party_firm) = ' ' => '',
														input.party_position = '' and NOT(is_company) and regexfind(',',input.party_name) = false and input.party_name <> '' => stringlib.StringToUpperCase(trim(input.party_name)),
	                         input.party_position <> '' and is_company or (INTEGER)tempPName[71..73] < 80 and input.party_name <> ''  => stringlib.StringToUpperCase(trim(input.party_name)),
													  CmpName and input.party_firm <> ''  => stringlib.StringToUpperCase(trim(input.party_firm)),
														NOT(CmpName) and input.party_firm <> '' and input.party_name = '' => stringlib.StringToUpperCase(trim(input.party_firm)),''); 
   self := input;



end;
	 
   
 pty_clean := project(j_party_toclean,clean_SANCTN_party(LEFT));
 
 pty_clean_final := pty_clean(regexfind('[0-9]',incident_number) = true and trim(party_name) <> '0'  );
   
//party_cleaned := distribute(pty_clean,hash(batch_number,incident_number,party_number));

//pty_clean_file := output(pty_clean,,SANCTN.cluster + 'out::sanctn::party_cleaned',overwrite);

return pty_clean_final;
end;