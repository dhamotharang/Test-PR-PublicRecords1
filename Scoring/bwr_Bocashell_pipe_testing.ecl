import ut, Business_Risk, fair_isaac, Risk_Indicators;
layout_erin:= record
string	account_nu	;
string	ownagency	;
string	portfolio_id	;
string	remaining_balance	;
string	acc_int_fees	;
string	date_opened	;
string	claim_date	;
string	last_pay_date	;
string	last_activity_date	;
string	i_rate	;
string	merchant	;
string	dateoos	;
string	bnkaccttype	;
string	lname	;
string	fname	;
string	address1	;
string	city	;
string	state	;
string	zipcode	;
string	debtor_ssn	;
string	home_phone	;
string	work_phone	;
string	fcradate	;
string	county	;
string	terrname	;
end;

file_in :=  dataset('~thor_data50::in::BocaShell::Eltman_Erin::20060322', layout_erin, CSV(heading(1)));
output(file_in, named('file_in'));


Layout_for_clean_address := record
	layout_erin; 	
	string182	clean_P_address;
end;

Layout_for_clean_address address_clean(file_in L) := transform
  self.clean_P_address  := address.cleanaddress182(L.address1+' '+' ', L.city + ',' + L.state+ ' ' + trim(L.zipcode));
  self 					:= L;
end;	

file_clean := project(file_in, address_clean(LEFT));
output(file_clean, named('file_clean'));

Risk_Indicators.Layout_Batch_In into_in(file_clean L, unsigned2 cnt) := transform

	self.seq			:= cnt;
	Self.AcctNo			:= L.account_nu;
	Self.SSN			:= L.debtor_ssn;
    self.name_first  	:= L.fNAME;
    self.name_middle  	:= '';
    self.name_last  	:= L.lNAME;
    self.name_suffix  	:= '';
    self.dob  			:= ''; //L.IND_DOB;
	
	self.Prim_Range		:= L.clean_P_address[1..10];
	self.Predir  		:= L.clean_P_address[11..12];
	self.Prim_Name  	:= L.clean_P_address[13..40];
	self.Suffix  		:= L.clean_P_address[41..44];
	self.Postdir		:= L.clean_P_address[45..46];
	self.Unit_Desig  	:= L.clean_P_address[47..56];
	self.Sec_Range		:= L.clean_P_address[57..64];
	Self.p_City_name  	:= L.clean_P_address[65..89];
	Self.St				:= L.clean_P_address[115..116];
	Self.Z5	  			:= L.clean_P_address[117..121];
	
	self.Age  			:= ''; //(string2)ut.GetAgeI((integer) L.IND_DOB);
    self.dl_number  	:= '';
    self.dl_state  		:= '';
	
	Self.Home_Phone		:= l.home_phone;
	Self.Work_Phone		:= l.work_phone;
	
end;

file_out := project(file_clean, into_in(LEFT, counter));
output(file_out, named('bocashell_input'));

//count(file_out);

outf := Risk_Indicators.Boca_Shell_Pipe(file_out, 1, 1,, false);

ox :=
RECORD
	STRING AccountNumber;
	risk_indicators.Layout_Boca_Shell_Edina;
	STRING errorcode := '';
END;

ox getold(file_out le, outf ri) :=
TRANSFORM
	SELF.AccountNumber := le.acctno;
	SELF := ri;
	self.errorcode := '';
END;

j_f := JOIN(file_out,outf,LEFT.seq=right.seq,getold(LEFT,RIGHT));
	
	
output(outf, named('boca_shell_edina'));
output(j_f,,'~thor_data50::out::BocaShell::Eltman_Erin::20060322', overwrite);
