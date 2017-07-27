/*--SOAP--
<message name="DoNotMailCallBatchService">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
/*--INFO-- This service returns if a given address or phone number of should be suppressed.*/

import clickdata, dma, execathomev2;

export DoNotMailCallBatchService := macro

f_in := dataset([],ClickData.Layout_DoNotMailCall_In) : stored('batch_in',few);

execathomev2.layout_eah_person_best get_seq_cname(f_in l, unsigned8 cnt) := transform
	cleaned_name := if(l.name_last<>'', '', address.CleanPerson73(l.unparsedfullname));
	self.person_best_fname := if(l.name_last<>'', l.name_first, cleaned_name[6..25]);
	self.person_best_mname := if(l.name_last<>'', l.name_middle, cleaned_name[26..45]);
	self.person_best_lname := if(l.name_last<>'', l.name_last, cleaned_name[46..65]);
	self.person_best_name_suffix := if(l.name_last<>'', l.name_suffix, cleaned_name[66..70]);
	self.person_prim_range := l.prim_range;
     self.person_predir := l.predir;
     self.person_prim_name := l.prim_name;
     self.person_suffix := l.suffix;
     self.person_postdir := l.postdir;
     self.person_unit_desig := l.unit_desig;
     self.person_sec_range := l.sec_range;
	self.person_best_city := l.p_city_name;
	self.person_best_state := l.st;
	self.person_best_zip := l.z5;
	self.person_best_phone := l.phoneno;
	self.seq := cnt;
	self := l;
	self := [];
end;

f_in_seq := project(f_in, get_seq_cname(left, counter));
f_in_grp := group(sort(f_in_seq, seq), seq);

f_out := execathomev2.suppress_address_phone(f_in_grp);

f_out_slim := project(f_out, transform(clickdata.Layout_DoNotMailCall_Out,
                                       self.AddressSuppressed := if(left.do_not_mail_flag='Y','Y','N'),
							    self.PhoneSuppressed := if(left.do_not_call_flag='Y','Y','N'),
							    self := left));

output(f_out_slim, named('Results'));

endmacro;