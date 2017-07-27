/*--SOAP--
<message name="Phone_Type_Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
/*--INFO-- This service returns phone type.*/

/*
<message name="Phone_Type_Batch_Service" wuTimeout="300000">
*/

import progressive_phone, cellphone;

export Phone_Type_Batch_Service := macro
		
layout_batch_in := record
	string20 acctno,
	string10 phoneno,
	string10 phoneno_1,
	string10 phoneno_2,
	string10 phoneno_3,
	string10 phoneno_4,
	string10 phoneno_5,
	string10 phoneno_6,
	string10 phoneno_7,
	string10 phoneno_8,
	string10 phoneno_9,
	string10 phoneno_10,
	string10 phoneno_11,
	string10 phoneno_12,
	string10 phoneno_13,
	string10 phoneno_14,
	string10 phoneno_15,
	string10 phoneno_16,
	string10 phoneno_17,
	string10 phoneno_18,
	string10 phoneno_19,
end; 		
		
f_batch_in := dataset([], layout_batch_in) : stored('batch_in',few);

layout_phone_type_in := record
   string20 acctno,
	 unsigned seq,
	 string10 subj_phone10,
	 string1 switch_type := '',
end;

layout_phone_type_in norm_phones(f_batch_in l, unsigned c) := transform
	self.acctno := l.acctno;
	self.seq := c;
	self.subj_phone10 := map(c=1 => l.phoneno,
	                         c=2 => l.phoneno_1,
													 c=3 => l.phoneno_2,
													 c=4 => l.phoneno_3,
													 c=5 => l.phoneno_4,
													 c=6 => l.phoneno_5,
													 c=7 => l.phoneno_6,
													 c=8 => l.phoneno_7,
													 c=9 => l.phoneno_8,
													 c=10 => l.phoneno_9,
													 c=11 => l.phoneno_10,
													 c=12 => l.phoneno_11,
													 c=13 => l.phoneno_12,
													 c=14 => l.phoneno_13,
													 c=15 => l.phoneno_14,
													 c=16 => l.phoneno_15,
													 c=17 => l.phoneno_16,
													 c=18 => l.phoneno_17,
													 c=19 => l.phoneno_18,
													 c=20 => l.phoneno_19,
													 '');
	self.switch_type := '';
end;

f_batch_ready := normalize(f_batch_in, 20, norm_phones(left, counter));

progressive_phone.mac_get_switchtype(f_batch_ready, f_batch_out_raw,true)

f_batch_out_srt := sort(f_batch_out_raw, acctno, seq);

layout_batch_out := record
	string20 acctno,
	string10 phoneno,
	string1 switch_type,
	string10 phoneno_1,
	string1 switch_type_1,
	string10 phoneno_2,
	string1 switch_type_2,
	string10 phoneno_3,
	string1 switch_type_3,
	string10 phoneno_4,
	string1 switch_type_4,
	string10 phoneno_5,
	string1 switch_type_5,
	string10 phoneno_6,
	string1 switch_type_6,
	string10 phoneno_7,
	string1 switch_type_7,
	string10 phoneno_8,
	string1 switch_type_8,
	string10 phoneno_9,
	string1 switch_type_9,
	string10 phoneno_10,
	string1 switch_type_10,
	string10 phoneno_11,
	string1 switch_type_11,
	string10 phoneno_12,
	string1 switch_type_12,
	string10 phoneno_13,
	string1 switch_type_13,
	string10 phoneno_14,
	string1 switch_type_14,
	string10 phoneno_15,
	string1 switch_type_15,
	string10 phoneno_16,
	string1 switch_type_16,
	string10 phoneno_17,
	string1 switch_type_17,
	string10 phoneno_18,
	string1 switch_type_18,
	string10 phoneno_19,
	string1 switch_type_19,
end; 	

f_batch_out_init := project(f_batch_in, transform(layout_batch_out, 
                                                  self.acctno := left.acctno,
																									self := []));
																									
layout_batch_out denorm_phones(f_batch_out_init l, f_batch_out_srt r, unsigned c) := transform
		self.acctno := l.acctno;
		self.phoneno := if(c=1, r.subj_phone10, l.phoneno);
	  self.switch_type := if(c=1, r.switch_type, l.switch_type);
	  self.phoneno_1 := if(c=2, r.subj_phone10, l.phoneno_1);
	  self.switch_type_1 := if(c=2, r.switch_type, l.switch_type_1);
		self.phoneno_2 := if(c=3, r.subj_phone10, l.phoneno_2);
	  self.switch_type_2 := if(c=3, r.switch_type, l.switch_type_2);
		self.phoneno_3 := if(c=4, r.subj_phone10, l.phoneno_3);
	  self.switch_type_3 := if(c=4, r.switch_type, l.switch_type_3);
		self.phoneno_4 := if(c=5, r.subj_phone10, l.phoneno_4);
	  self.switch_type_4 := if(c=5, r.switch_type, l.switch_type_4);
		self.phoneno_5 := if(c=6, r.subj_phone10, l.phoneno_5);
	  self.switch_type_5 := if(c=6, r.switch_type, l.switch_type_5);
		self.phoneno_6 := if(c=7, r.subj_phone10, l.phoneno_6);
	  self.switch_type_6 := if(c=7, r.switch_type, l.switch_type_6);
		self.phoneno_7 := if(c=8, r.subj_phone10, l.phoneno_7);
	  self.switch_type_7 := if(c=8, r.switch_type, l.switch_type_7);
		self.phoneno_8 := if(c=9, r.subj_phone10, l.phoneno_8);
	  self.switch_type_8 := if(c=9, r.switch_type, l.switch_type_8);
		self.phoneno_9 := if(c=10, r.subj_phone10, l.phoneno_9);
	  self.switch_type_9 := if(c=10, r.switch_type, l.switch_type_9);
		self.phoneno_10 := if(c=11, r.subj_phone10, l.phoneno_10);
	  self.switch_type_10 := if(c=11, r.switch_type, l.switch_type_10);
		self.phoneno_11 := if(c=12, r.subj_phone10, l.phoneno_11);
	  self.switch_type_11 := if(c=12, r.switch_type, l.switch_type_11);
		self.phoneno_12 := if(c=13, r.subj_phone10, l.phoneno_12);
	  self.switch_type_12 := if(c=13, r.switch_type, l.switch_type_12);
		self.phoneno_13 := if(c=14, r.subj_phone10, l.phoneno_13);
	  self.switch_type_13 := if(c=14, r.switch_type, l.switch_type_13);
		self.phoneno_14 := if(c=15, r.subj_phone10, l.phoneno_14);
	  self.switch_type_14 := if(c=15, r.switch_type, l.switch_type_14);
		self.phoneno_15 := if(c=16, r.subj_phone10, l.phoneno_15);
	  self.switch_type_15 := if(c=16, r.switch_type, l.switch_type_15);
		self.phoneno_16 := if(c=17, r.subj_phone10, l.phoneno_16);
	  self.switch_type_16 := if(c=17, r.switch_type, l.switch_type_16);
		self.phoneno_17 := if(c=18, r.subj_phone10, l.phoneno_17);
	  self.switch_type_17 := if(c=18, r.switch_type, l.switch_type_17);
		self.phoneno_18 := if(c=19, r.subj_phone10, l.phoneno_18);
	  self.switch_type_18 := if(c=19, r.switch_type, l.switch_type_18);
		self.phoneno_19 := if(c=20, r.subj_phone10, l.phoneno_19);
	  self.switch_type_19 := if(c=20, r.switch_type, l.switch_type_19);
end;

f_batch_out := denormalize(f_batch_out_init, f_batch_out_srt, 
                           left.acctno=right.acctno,
                           denorm_phones(left, right, counter));

output(f_batch_out, named('Results'));	

endmacro;