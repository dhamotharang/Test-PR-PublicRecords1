import doxie, ut, dx_Gong;

export Append_Gong_Biz(dataset(doxie.Layout_Append_Gong_Biz.Layout_In) phones) :=
FUNCTION
  temp_norm_rec := record
    doxie.Layout_Append_Gong_Biz.Layout_In - [company_names];
    string120 company_name;
  end;

  temp_norm := normalize(phones,count(left.company_names),transform(temp_norm_rec,
    self.company_name := left.company_names[counter].company_name,
    self := left));

  temp_gong_phones0 := join(temp_norm, dx_Gong.key_phone(),
    keyed(left.phone[4..10] = right.ph7) and
    keyed(left.phone[1..3] = right.ph3) and
    wild(right.st) and
    keyed(right.business_flag) and
    right.publish_code = 'P' and
    ut.CompanySimilar100(left.company_name,right.listed_name) < 10,
    transform(left),limit(100000,skip),keep(1));

  temp_gong_phones := temp_gong_phones0(not ut.IndustryClass.is_knowx);

  temp_dedup := dedup(sort(temp_gong_phones,__seq,phone),__seq,phone);

  temp_final := join(phones,temp_dedup,
    left.__seq = right.__seq and left.phone = right.phone,
    transform(doxie.Layout_Append_Gong_Biz.Layout_Out,
    self.verified := right.phone != '',
    self := left),
    left outer);

  temp_reduced := dedup(sort(temp_final,__seq,phone,if(verified,0,1)),__seq,phone);

  return temp_reduced;
end;
