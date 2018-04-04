Export mac_append_score(infile, outf, daily_file_fraud_count,//daily file in fraud function count below here will append score
isdaily = 'true') := macro 

import risk_indicators, INQL_v2, models, riskwise;

virtual_fraud_func_set := INQL_v2.score_constants.virtual_fraud_db_function_set;

orig_inquiries_fraud := 
#if(isdaily)
infile(trim(function_description) in virtual_fraud_func_set);
#else
infile(trim(search_info.function_description) in virtual_fraud_func_set);
#end

orig_inquiries_nofraud := 
#if(isdaily)
infile(trim(function_description) not in virtual_fraud_func_set);
#else
infile(trim(search_info.function_description) not in virtual_fraud_func_set);
#end

#uniquename(fp_batch_in)
%fp_batch_in% := record
	Models.FraudAdvisor_Batch_Service_Layouts.BatchInput;
	/*STRING5 Grade := '';
	string16 Channel := '';
	string8 Income := '';
	string16 OwnOrRent := '';
	string16 LocationIdentifier := '';
	string16 OtherApplicationIdentifier := '';
	string16 OtherApplicationIdentifier2 := '';
	string16 OtherApplicationIdentifier3 := '';
	string8 DateofApplication := '';
	string8 TimeofApplication := '';
	string50 email := '';*/
end;

// hang on to the batch input fields and the inquiries in the same dataset for joining back to pipe results by acctno
layout_exclusions
	:=
record
	string5 name_suffix;
	string10 prim_range;
	string28 prim_name;
	string2 predir;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string2 st;
	string work_phone;
	string ssn;
	string dob;
	string dl_state;
end
;
#uniquename(temp_layout)
%temp_layout% := record
	%fp_batch_in%;
	#if(isdaily)
	INQL_v2.Layouts.Common_layout - layout_exclusions;
	#else
	INQL_v2.Layouts.Common_ThorAdditions;
	#end

end;
	
%temp_layout% make_batch_in(orig_inquiries_fraud le, integer c) := transform
	self.AcctNo := (string)c;
	#if(isdaily)
	self.SSN := le.SSN;
	self.Name_First := le.Fname ;
	self.Name_Middle := le.Mname ;
	self.Name_Last := le.LName ;
	self.DOB := le.dob ;
	self.street_addr := le.orig_Addr1 ;
	self.p_City_name := le.orig_CITY1 ;
	self.St := le.orig_STATE1 ;
	self.Z5 := le.orig_ZIP1 ;
	self.Home_Phone := le.personal_Phone ;
	self.HistoryDateYYYYMM := (unsigned)le.datetime[1..6];
	#else
	self.SSN := le.person_q.SSN;
	self.Name_First := le.person_q.Fname ;
	self.Name_Middle := le.person_q.Mname ;
	self.Name_Last := le.person_q.LName ;
	self.DOB := le.person_q.dob ;
	self.street_addr := le.person_q.Address ;
	self.p_City_name := le.person_q.CITY ;
	self.St := le.person_q.STATE ;
	self.Z5 := le.person_q.ZIP ;
	self.Home_Phone := le.person_q.personal_Phone ;
	self.HistoryDateYYYYMM := (unsigned)le.search_info.datetime[1..6];
	#end
	self := le;
  self := [];
end;

infile_batch := project(orig_inquiries_fraud, make_batch_in(left, counter));

infile_batch_dist := distribute(infile_batch, hash(Name_First, name_last, ssn, street_addr));

infile_batch_sort := sort(infile_batch_dist, name_first, name_middle, name_last, ssn, street_addr, DOB, p_city_name, st, z5, 
home_phone, HistoryDateYYYYMM, local);

infile_batch_group := group(infile_batch_sort, name_first, name_middle, name_last, ssn, street_addr, DOB, p_city_name, st, z5, 
home_phone, HistoryDateYYYYMM, local);

   %temp_layout% iter_id(%temp_layout% le, %temp_layout% ri) := transform
		
		self.AcctNo := if ((unsigned)le.AcctNo = 0, ri.AcctNo, le.AcctNo);
		self := ri;
	end;

//here join back after hitting batch service
	
infile_iter := iterate(infile_batch_group, iter_id(left, right));

fdInput := project(infile_iter, transform(%fp_batch_in%, self := left));
infile_id_dedup := group(dedup(fdInput, AcctNo));
roxie_IP := std.str.splitwords(RiskWise.shortcuts.prod_batch_analytics_roxie,'//')[2]:INDEPENDENT;

insize := sizeof(%fp_batch_in%);
outsize := sizeof(models.Layout_FD_Batch_Out);		
options := '<ModelName>fp3710_0</ModelName><DPPAPurpose>1</DPPAPurpose><GLBPurpose>1</GLBPurpose><DataRestrictionMask>0000000000000</DataRestrictionMask>';

// -b:  send batch packets of 100 records at a time
// -t:  number of threads to use.  

threads := '2';
pipe_results := PIPE(DISTRIBUTE(choosen(infile_id_dedup, daily_file_fraud_count),RANDOM() % 50), 'roxiepipe -iw '+ insize +' -t '+threads+' -ow '
									+ outsize	+' -b 100 -mr 2 -q "'
									+ '<Models.FraudAdvisor_Batch_Service format=\'raw\'>'
									+ options +'<batch_in id=\'id\' format=\'raw\'></batch_in>'
									+ '</Models.FraudAdvisor_Batch_Service>" -h ' 
									+ roxie_ip + ' -r Results', 
									models.Layout_FD_Batch_Out);
							
// append a 3 digit score to the end of the layout of the inquiry keys
inquiries_with_score_appended := project(join(distribute(infile_iter,hash(acctno)),distribute(pipe_results,hash(acctno)),
 left.acctno=right.acctno,transform(
 #if(isdaily)
 INQL_v2.Layouts.Common_layout,
 #else
 	INQL_v2.Layouts.Common_ThorAdditions,
#end

		self.fraudpoint_score := right.score1;
		self := left), left outer, local),recordof(orig_inquiries_fraud));
#uniquename(append_score)

orig_with_score_appended := orig_inquiries_nofraud + inquiries_with_score_appended;

outf := orig_with_score_appended;

endmacro;


