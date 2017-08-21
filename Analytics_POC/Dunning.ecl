export Dunning := module

export Dayton_rec := record
 string vc_id;
 string Date;
 string Dunning_Stat_cd;
end;

export Dayton_Dunning := dataset('~thor::poc::dayton_dunning',dayton_rec,csv(separator(','),heading(1)));

Alpharetta_rec := record
 string Company_Name;
 string Company_Status;
 string dun_session_id;
 string company_id;
 string session_open;
 string date_opened;
 string date_closed;
 string amount_overdue;
 string invoice_date;
 string payment_due_date;
 string payment_overdue_date;
 string billing_terms;
 string payment_method;
 string date_added;
 string user_added;
 string date_changed;
 string user_changed;
 string company_status1;
 string dun_tran_date;
 string gc_id;
 string product_id;
 string invoice_id;
 string mbs_session;
 string dun_schedule_id;
 string orig_amount;
end;

raw_data := dataset('~thor::poc::alpharetta_dunning',alpharetta_rec,csv(separator('\t'),heading(1),quote('""')));

export Alpharetta_Dunning := project(raw_data,transform(Alpharetta_rec,
																								self.Company_Name:=left.Company_Name[stringlib.stringfind(left.Company_Name,'"',1)+1..],
																								self.orig_amount := stringlib.stringfilterout(left.orig_amount,'"""');
																								self := left));

end;