IMPORT AutoStandardI, doxie, ut, doxie_raw, PhonesFeedback_Services, PhonesFeedback, dx_Gong, Suppress;

export fn_phone_records_wide(
	dataset(doxie.Layout_Comp_Addresses) ca,
	boolean secRangeStrict = false,
  boolean returnRestricted = false)
 :=
FUNCTION

doxie.MAC_Selection_Declare() // need it only for n_phones and IncludePhonesFeedback
global_mod := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());

doxie_raw.mac_entrp_clean(ca,dt_last_seen,ca_entrp);
ca_in := IF(ut.IndustryClass.is_entrp,ca_entrp,ca);

var_string := dedup(ca_in,prim_range,prim_name,zip,sec_range,predir,all);

outf := doxie.layout_AppendGongByAddr_input;

outf fixComp(var_string L) := transform
  self.listing_name := '';
	self.timezone := '';
  self.phone := '';
  self := l;
end;

a := project(var_string,fixComp(left));
dd := doxie.fn_AppendGongByAddr(a,secRangeStrict)(returnRestricted OR not(publish_code = 'N' or omit_phone = 'Y'));

score_rec := record
	dd;
	unsigned1	score;
	unsigned1 lname_score;
	unsigned8 rawaid := 0;
	string1 	tnt := '';
end;

score_rec get_score(dd L, var_string R) := transform

  name_match := ut.NameMatch(l.fname,l.mname,l.lname,R.fname,R.mname,R.lname);
	self.score :=
		map(
			L.sec_range = R.sec_range and name_match < 3 => 1,
			L.sec_range = R.sec_range                    => 2,
			name_match < 3                               => 3,
			l.phone = r.phone                            => 4,
			5);
	self.lname_score := ut.StringSimilar(l.lname,R.lname);
	self.rawaid := R.rawaid;
	self.tnt := R.tnt;
	self := L;
end;

dd_score := join(dd, var_string, left.prim_range = right.prim_range and
				    left.prim_name = right.prim_name and
				    left.zip = right.zip and
				    left.predir = right.predir,
				    get_score(LEFT,RIGHT), left outer);

str_unlisted := dx_Gong.Constants.STR_UNLISTED;
//NB: in case of unpub phones sorting must be done by something different than phone, otherwise random 'UNPUB' will be taken.
dd1 := dedup (sort(dd_score,prim_range,prim_name, zip, if (phone=str_unlisted, listing_name, phone),score,lname_score, record),
              prim_range,prim_name,zip, if (phone=str_unlisted, listing_name, phone));
//keep upto 'n_phones' different phones
dd2_tmp := dedup (SORT (dd1, prim_range,prim_name,zip,score,lname_score,record), prim_range, prim_name, zip, keep(n_phones));


// output(ca, named('ca'));
// output(dd, named('dd'));
// output(dd_score, named('dd_score'));

fb_rec_layout:=record
dd2_tmp,
DATASET(PhonesFeedback_Services.Layouts.feedback_report) Feedback {MAXCOUNT(1)};
end;

fb_rec_layout Add_FeedBack_ds(dd2_tmp le):=transform
self.feedback:=[];
self:=le;
end;
dd2_tmp_fb:=project(dd2_tmp,Add_FeedBack_ds(LEFT));

PhonesFeedback_Services.Mac_Append_Feedback(dd2_tmp_fb
																						,DID
																						,Phone
																						,dd2_feedback
                                       ,mod_access
																						);

dd3:=dd2_feedback;
dd3 Add_Feedback_data (dd3 le):=TRANSFORM

self.feedback:=if(le.isSubject=true,le.feedback,DATASET ([], PhonesFeedback_Services.Layouts.feedback_report));//le.feedback;//
self:=le;
END;
dd3_a:=project(dd3,Add_Feedback_data(LEFT));
dd2:=if(IncludePhonesFeedback,dd3_a,dd2_tmp_fb);
return dd2;

END;
