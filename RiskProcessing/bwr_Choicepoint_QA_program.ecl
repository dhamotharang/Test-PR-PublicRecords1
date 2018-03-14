#workunit('name','Choicepoint QA Summary Rpt');
#option ('hthorMemoryLimit', 1000)

/////////////////////////Read in File/////////////////////////////////////////////

prii_layout := RECORD
	STRING Account;
	STRING first;
	STRING middle;
	STRING last;
	STRING addr;
	STRING City;
	STRING State;
	STRING Zip;
	STRING hphone;
	STRING Socs;
	STRING dob;
	STRING wphone;
	STRING income;  
	string drlc;
	string drlcstate;
	string BALANCE; 
	string CHARGEOFFD;  
	string FormerName;
	string EMAIL;  
	string COMPANY;
	STRING historydateyyyymm;
END;

f1 := DATASET('~jpyon::in::test_cp_f_s_in3',prii_layout,csv(quote('"')));
//f := choosen(DATASET('~jpyon::in::esurance_1573_f_s_in',prii_layout,csv(quote('"'))),20);

// f1 := DATASET('~tfuerstenberg::in::cp_1659_a_in',prii_layout,csv(quote('"')));
// f2 := DATASET('~tfuerstenberg::in::cp_1659_b_in',prii_layout,csv(quote('"')));
// f3 := DATASET('~tfuerstenberg::in::cp_1659_c_in',prii_layout,csv(quote('"')));
// f4 := DATASET('~tfuerstenberg::in::cp_1659_d_in',prii_layout,csv(quote('"')));
// f5 := DATASET('~tfuerstenberg::in::cp_1659_e_in',prii_layout,csv(quote('"')));

// all_f := f1 + f2 + f3 + f4 + f5;
f := f1;

output(f,named('input_file'));

/////////////////////////Create Freq Tables//////////////////////////////////////////
t := table(f, {socs, freq := count(group)}, socs, few);
s := sort(t, -freq);
output(s,named('ssn_freq')); 
/////////////////////////////////////////////////////////////////////////////////////
t1 := table(f, {historydateyyyymm, freq := count(group)}, historydateyyyymm, few);
s1:= sort(t1, -freq);
output(s1,named('historydate_freq')); 
/////////////////////////////////////////////////////////////////////////////////////
t2 := table(f, {hphone, freq := count(group)}, hphone, few);
s2:= sort(t2, -freq);
output(s2,named('hphone_freq')); 


////////////////////////create Summary flags/////////////////////////////////////////
cnt_summary := table(f, {	
  	total_record := count(group),
	
	total_unique_acct := count(DEDUP(SORT(f(Account <>''), Account),Account,all)),
	
	Acct_num_length_le_30 := count(group, length(trim(account))<=30),
	
	firstname_flag := count(group,StringLib.StringToupperCase(first) ='' or 
	                            StringLib.StringToupperCase(first) ='JR' or 
					            StringLib.StringToupperCase(first) ='SR' or 
					            StringLib.StringToupperCase(first) ='III'
								),
					   
	middlename_flag := count(group,middle =''),
	
	lastname_flag := count(group, StringLib.StringToupperCase(last) ='' or 
	                            StringLib.StringToupperCase(last) ='JR' or 
					            StringLib.StringToupperCase(last) ='SR' or 
					            StringLib.StringToupperCase(last) ='III'
								),
	
	addr_flag := count(group,addr =''),

	city_flag := count(group,city =''),
	
	state_flag := count(group,State ='' or 
	                    length(state)<2 or
				        length(state)>2
						),
	
	zip_flag := count(group,                         zip ='' or 
	                                            zip ='00000' or 
							                    zip ='99999' or 
	                                        zip ='000000000' or 
				    	                    zip ='999999999' or 
							                    zip ='0    ' or
							                   length(zip)<5 or 
							                   length(zip)>9 or
					   stringlib.stringfind(zip, '/', 1) > 0 or
					   stringlib.stringfind(zip, '*', 1) > 0 or
					   stringlib.stringfind(zip, '&', 1) > 0 or
					   stringlib.stringfind(zip, '^', 1) > 0 or
					   stringlib.stringfind(zip, '$', 1) > 0 or
					   stringlib.stringfind(zip, '#', 1) > 0 or
					   stringlib.stringfind(zip, '@', 1) > 0 or
					   stringlib.stringfind(zip, '!', 1) > 0 or 
					   stringlib.stringfind(zip, '~', 1) > 0 or
					   stringlib.stringfind(zip, ',', 1) > 0 or
					   stringlib.stringfind(zip, '.', 1) > 0 or
					   stringlib.stringfind(zip, '?', 1) > 0 or
					   stringlib.stringfind(zip, '[', 1) > 0 or
					   stringlib.stringfind(zip, ']', 1) > 0 or
					   stringlib.stringfind(zip, '<', 1) > 0 or
					   stringlib.stringfind(zip, '>', 1) > 0 or
					   stringlib.stringfind(zip, '+', 1) > 0 or
					   stringlib.stringfind(zip, '-', 1) > 0
					   ),
	
	hphone_flag := count(group,                      HPhone ='' or 
	                                        hphone='0000000000' or
					                        hphone='0         ' or
					                          length(hphone)<10 or 
						                      length(hphone)>10 or
					   stringlib.stringfind(hphone, '/', 1) > 0 or
					   stringlib.stringfind(hphone, '*', 1) > 0 or
					   stringlib.stringfind(hphone, '&', 1) > 0 or
					   stringlib.stringfind(hphone, '^', 1) > 0 or
					   stringlib.stringfind(hphone, '$', 1) > 0 or
					   stringlib.stringfind(hphone, '#', 1) > 0 or
					   stringlib.stringfind(hphone, '@', 1) > 0 or
					   stringlib.stringfind(hphone, '!', 1) > 0 or 
					   stringlib.stringfind(hphone, '~', 1) > 0 or
					   stringlib.stringfind(hphone, ',', 1) > 0 or
					   stringlib.stringfind(hphone, '.', 1) > 0 or
					   stringlib.stringfind(hphone, '?', 1) > 0 or
					   stringlib.stringfind(hphone, '[', 1) > 0 or
					   stringlib.stringfind(hphone, ']', 1) > 0 or
					   stringlib.stringfind(hphone, '<', 1) > 0 or
					   stringlib.stringfind(hphone, '>', 1) > 0 or
					   stringlib.stringfind(hphone, '+', 1) > 0 or
					   stringlib.stringfind(hphone, '-', 1) > 0
					   ),
						  
	ssn_flag := count(group,                         Socs ='' or 
	                                         socs='000000000' or 
					                         socs='0        ' or 
					                           length(socs)<9 or
   					                           length(socs)>9 or
					   stringlib.stringfind(socs, '/', 1) > 0 or
					   stringlib.stringfind(socs, '*', 1) > 0 or
					   stringlib.stringfind(socs, '&', 1) > 0 or
					   stringlib.stringfind(socs, '^', 1) > 0 or
					   stringlib.stringfind(socs, '$', 1) > 0 or
					   stringlib.stringfind(socs, '#', 1) > 0 or
					   stringlib.stringfind(socs, '@', 1) > 0 or
					   stringlib.stringfind(socs, '!', 1) > 0 or 
					   stringlib.stringfind(socs, '~', 1) > 0 or
					   stringlib.stringfind(socs, ',', 1) > 0 or
					   stringlib.stringfind(socs, '.', 1) > 0 or
					   stringlib.stringfind(socs, '?', 1) > 0 or
					   stringlib.stringfind(socs, '[', 1) > 0 or
					   stringlib.stringfind(socs, ']', 1) > 0 or
					   stringlib.stringfind(socs, '<', 1) > 0 or
					   stringlib.stringfind(socs, '>', 1) > 0 or
					   stringlib.stringfind(socs, '+', 1) > 0 or
					   stringlib.stringfind(socs, '-', 1) > 0 
					   ),
	
							 
	dob_flag := count(group, dob=' ' or
	         (integer)dob <=19000101 or  
             (integer)dob >=20111231
			 ),						 
							 
							 	  
	wphone_flag := count(group,                      wPhone ='' or 
	                                        wphone='0000000000' or 
					                        wphone='0         ' or
					                          length(wphone)<10 or
						                      length(wphone)>10 or
					   stringlib.stringfind(wphone, '/', 1) > 0 or
					   stringlib.stringfind(wphone, '*', 1) > 0 or
					   stringlib.stringfind(wphone, '&', 1) > 0 or
					   stringlib.stringfind(wphone, '^', 1) > 0 or
					   stringlib.stringfind(wphone, '$', 1) > 0 or
					   stringlib.stringfind(wphone, '#', 1) > 0 or
					   stringlib.stringfind(wphone, '@', 1) > 0 or
					   stringlib.stringfind(wphone, '!', 1) > 0 or 
					   stringlib.stringfind(wphone, '~', 1) > 0 or
					   stringlib.stringfind(wphone, ',', 1) > 0 or
					   stringlib.stringfind(wphone, '.', 1) > 0 or
					   stringlib.stringfind(wphone, '?', 1) > 0 or
					   stringlib.stringfind(wphone, '[', 1) > 0 or
					   stringlib.stringfind(wphone, ']', 1) > 0 or
					   stringlib.stringfind(wphone, '<', 1) > 0 or
					   stringlib.stringfind(wphone, '>', 1) > 0 or
					   stringlib.stringfind(wphone, '+', 1) > 0 or
					   stringlib.stringfind(wphone, '-', 1) > 0
					   ),
						 
	income_flag := count(group,income =''),
	
	drlc_flag := count(group,drlc =''),
	
    drlcstate_flag := count(group, drlcstate ='' or
	                         length(drlcstate)<2 or
							 length(drlcstate)>2
							 ),
								   
    BALANCE_flag := count(group,BALANCE =''),
	
    CHARGEOFFD_flag := count(group,CHARGEOFFD =''),
	
    FormerName_flag := count(group,FormerName =''),
	
	EMAIL_flag := count(group,EMAIL =''),
	
	COMPANY_flag := count(group,COMPANY =''),

 history_flag :=count(group,        historydateyyyymm=' '	
	// history_flag :=count(group,        historydateyyyymm=' ' or 
	                      // (integer)historydateyyyymm <199301 or 
	                     // ((integer)historydateyyyymm >201112 and (integer)historydateyyyymm <>999999) 
						 )}, few);
						   
////////////////////////Summary table/////////////////////////////////////////						   
output(cnt_summary,named('cnt_summary'));