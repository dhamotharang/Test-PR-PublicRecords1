import ln_propertyv2,ut;

ixi_fid := distribute(ixi.get_fid(ln_fares_id[2]='A'),hash(ln_fares_id));
ln_tax  := distribute(ln_propertyv2.File_Assessment(vendor_source_flag in variables.vendor),hash(ln_fares_id));

r1 := record
 ixi_fid.aid;
 ln_tax.ln_fares_id;
 ln_tax.current_record;
 ln_tax.assessed_land_value;
 ln_tax.assessed_improvement_value;
 ln_tax.assessed_total_value;
 ln_tax.assessed_value_year;
 ln_tax.market_land_value;
 ln_tax.market_improvement_value;
 ln_tax.market_total_value;
 ln_tax.market_value_year;
 ln_tax.tax_amount;
 ln_tax.tax_year;
end;

r1 t1(ln_tax le, ixi_fid ri) := transform
 self := le;
 self := ri;
end;

j1 := join(ln_tax,ixi_fid,left.ln_fares_id=right.ln_fares_id,t1(left,right),local,keep(1)) : persist('persist::ixi_get_tax'+variables.pst_suffix);

//unlike deeds, which can have multiple records spanning current ownership, for tax there should be a single current record

f1 := distribute(j1,hash(aid));

r3 := record
 boolean aid_has_avm;
 f1;
end;

r3 t4(f1 le, ixi.get_avm ri) := transform
 self.aid_has_avm := le.aid=ri.aid;
 self             := le;
end;

j3 := join(f1,ixi.get_avm,left.aid=right.aid,t4(left,right),left outer,keep(1),local);

f3 := j3(assessed_total_value<>'' and (aid_has_avm=true or assessed_value_year<>''));

r2 := record
 f3.aid;
 max_yr := max(group,max(f3.assessed_value_year));
end;

ta1 := table(f3,r2,aid,local);

r1 t2(f1 le, ta1 ri) := transform
 self := le;
end;

j2 := join(f1,ta1,left.aid=right.aid and left.assessed_value_year=right.max_yr,t2(left,right),local);

//when there's more than 1 record with the max_tax_yr, sort/dedup on assd and mkt yr's
//also assume latest fid is most current (in the event of corrections)
//OKC states that, in the event of quarterly tax billings, they are rolled up into a single record

j2_sort1 := sort(j2,aid);
j2_grpd  := group(j2_sort1,aid);
j2_sort2 := sort(j2_grpd,-ln_fares_id);
j2_dupd  := dedup(j2_sort2,aid,all);
j2_ungrp := ungroup(j2_dupd);

export get_tax := j2_ungrp : persist('persist::ixi_get_tax_current'+variables.pst_suffix);