

//
// phase 2 get current dfacts
//
df_m_layout := record
string m_make_id;
string make_code;
string make_description;
end;
df_mi := dataset('~thor_200::in::dfacts_mv_make_20061130',df_m_layout,csv);
df_m := df_mi(m_make_id<>'makeid');

df_mm_layout := record
string mm_make_id;
string model_description;
end;
df_mmi := dataset('~thor_200::in::dfacts_mv_make_model_20061130',df_mm_layout,csv);
df_mm := df_mmi(mm_make_id<>'makeid');

//
// and compare to vehicle
//
mm_layout := record
string5 	make_code;
string75	model_description;
unsigned integer4 		b_total;
end;
mm:=dataset('~thor_200::temp::vehicle_make_model_for_dfacts_compare',mm_layout,flat);
m_layout := record
string5 		make_code;
string75		make_description;
unsigned integer4 		b_total;
end;
m := dataset('~thor_200::temp::vehicle_make_for_dfacts_compare', m_layout,flat);

df_m_layout keep_df_m_layout (df_m l, m r) := transform
self :=l;
end;
m_layout keep_m_layout(df_m l, m r) := transform
self := r;
end;
both_m 		:= join(df_m, m, left.make_code=right.make_code, keep_df_m_layout(left,right), inner);
df_m_only 	:= join(df_m, m, left.make_code=right.make_code, keep_df_m_layout(left,right), left only);
mv_m_only 		:= join(df_m, m, left.make_code=right.make_code, keep_m_layout(left,right), right only);
//

output(df_m_only, named('Make_in_dFacts_only'));
output(sort(mv_m_only,-b_total), named('Make_in_vehicle_reg_only'));

//
// join df_m and df_mm
// 
df_m_mm_joined_layout := record
df_m_layout;
df_mm_layout;
end;
df_m_mm_joined_layout  df_join_trans(df_m l, df_mm r) := transform
self := l;
self := r;
end;
df_m_mm := join(df_m, df_mm, left.m_make_id = right.mm_make_id, df_join_trans(left,right));

//
// and compare to mm
//
df_m_mm_joined_layout keep_df_m_mm_joined_layout(df_m_mm l, mm r) := transform
self := l;
end;
mm_layout keep_mm_layout(df_m_mm l, mm r) := transform
self := r;
end;
both_mm 	:= join(df_m_mm, mm, left.make_code=right.make_code and left.model_description=right.model_description,keep_df_m_mm_joined_layout(left,right),inner);
df_m_mm_only:= join(df_m_mm, mm, left.make_code=right.make_code and left.model_description=right.model_description,keep_df_m_mm_joined_layout(left,right),left only);
mv_m_mm_only:= join(df_m_mm, mm, left.make_code=right.make_code and left.model_description=right.model_description,keep_mm_layout(left,right),right only);
//
mv_m_mm_only_app_layout := record
string m_make_id;
string m_make_code;
string m_make_description;
mv_m_mm_only;
end;
mv_m_mm_only_app_layout append_makeid(mv_m_mm_only l, df_m r) := transform
self:= l;
self.m_make_id:= r.m_make_id;
self.m_make_code:= r.make_code;
self.m_make_description := r.make_description;
end;
mv_m_mm_only_app:=
			join(mv_m_mm_only, df_m, left.make_code=right.make_code,append_makeid(left,right),left outer);
		
//
output(choosen(df_m_mm_only,2500), named('Make_Model_in_dFacts_only'));
output(choosen(sort(mv_m_mm_only_app(model_description<>''),-b_total),2500), named('Make_Model_in_vehicle_reg_only'));


