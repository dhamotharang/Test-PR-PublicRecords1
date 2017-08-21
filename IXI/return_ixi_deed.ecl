import ut;

curr_deed_pst := ixi.get_deed_current;

r1 := record
 boolean aid_has_sales_price_in_other_rec:=false;
 curr_deed_pst;
end;

r1 t1(curr_deed_pst le) := transform
 self := le;
end;

p1 := project(curr_deed_pst,t1(left));

second_mortgages  := p1;
primary_mortgages := p1(sales_price<>'');

r1 t2(second_mortgages le, primary_mortgages ri) := transform
 self.aid_has_sales_price_in_other_rec := le.aid=ri.aid and le.ln_fares_id<>ri.ln_fares_id;
 self                                  := le;
end;

//distribute should be preserved in ixi.get_deed_current
j1 := dedup(join(second_mortgages,primary_mortgages,left.aid=right.aid and left.ln_fares_id<>right.ln_fares_id,t2(left,right),local),record,all,local);

concat1 := primary_mortgages+j1;

deed_recs := concat1(tax_or_deed in ['D','M']);
assr_recs := concat1(tax_or_deed='T');

recordof(assr_recs) t3(assr_recs le, deed_recs ri) := transform
 self := le;
end;

//only keep the assessment records with a non-matching record in the deed file
j2 := join(assr_recs,deed_recs,left.aid=right.aid and left.sales_price=right.sales_price and left.date_[1..6]=right.date_[1..6],t3(left,right),left only,local);

concat2 := deed_recs+j2;

r2 := record
 boolean aid_has_avm;
 concat2;
end;

r2 t4(concat2 le, ixi.get_avm ri) := transform
 self.aid_has_avm := le.aid=ri.aid;
 self             := le;
end;

j3 := dedup(join(concat2,ixi.get_avm,left.aid=right.aid,t4(left,right),left outer,keep(1),local),record, except did,all,local);

f1 := j3((sales_price<>''     and aid_has_avm=true) or (sales_price<>''      and first_loan<>'' and date_<>''));
f2 := j3(is_2nd_mortgage=true and aid_has_avm=true);
//although the other record may have a sales price
f3 := j3(aid_has_sales_price_in_other_rec=true);

r2 t5(f3 le, f1 ri) := transform
 self := le;
end;

j4 := join(f3,f1,left.aid=right.aid,t5(left,right),local);

concat3 := f1+f2+j4;

ixi.layouts.l_deed t6(concat3 le) := transform
 self.aid             := le.aid;
 self.sales_price     := (integer)le.sales_price;
 self.first_loan_amt  := (integer)le.first_loan;
 self.second_loan_amt := (integer)le.second_loan;
 self.loan_type       := le.loan_type_desc;
 self.date_type       := le.date_type;
 self.date_           := (integer)le.date_;
 self.is_2nd_mortgage := le.is_2nd_mortgage;
end;

p2      := project(concat3,t6(left));
p2_dupd := dedup(p2,record,all);

ut.mac_sf_buildprocess(p2_dupd,'~thor_data400::base::ixi_deed',ixi_deed,2,,true);

export return_ixi_deed := ixi_deed;