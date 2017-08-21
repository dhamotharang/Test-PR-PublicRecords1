ds    := ln_property.File_Deed(recording_date<>'');
ds_fc := property.File_Foreclosure(document_desc<>'' or deed_desc<>'',recording_date<>'');

rec := record
 string2  st;
 string5  fips;
 string40 county;
 string3  not_relevant;
end;

fips_lookup := dataset('~thor_data400::in::fips_code_lookup',rec,flat);

fares_doc_type := [
'F','L','N','R'
];
//Removed U b/c of possible overlap with fares_foreclosure

fares_foreclosure_ := [
'O','P','Y'
];

ln_doc_type := [
'DL','DS','FC','PA','SD','TD'
];
//Removed AG from consideration

fares := ds(vendor_source_flag[1..3]='FAR');
ln_   := ds(vendor_source_flag in ['DAYTN','OKCTY']);

fares_filter1 := fares((trim(document_type_code) in fares_doc_type) or trim(document_type_code)='U' and fares_foreclosure not in ['O','P','Y']);
fares_filter2 := fares(fares_foreclosure in fares_foreclosure_ and trim(document_type_code)!='U');

ln_filter1    := ln_(trim(document_type_code) in ln_doc_type);
ln_filter2    := ln_(trim(recorder_map_reference) in ['LP','LIS PENDENS']);

concat := fares_filter1
        + fares_filter2
		+ ln_filter1
		+ ln_filter2
		;

//output(choosen(concat,5000));

slim_rec := record
 string5  vendor;
 string2  st;
 string30 county;
 string5  fips;
 string8  recording_date;
 string40 record_type;
 string11 file_type;
end;

slim_rec t_slim_ds(concat l) := transform

 string a := trim(l.document_type_code);
 
 string8 v_rec_dt := if(l.recording_date between '19500000' and ut.GetDate,l.recording_date,'');
 
 self.vendor         := if(l.vendor_source_flag[1..3]='FAR','FARES','LEXIS');
 self.st             := if(self.vendor='LEXIS',l.state,'');
 self.county         := if(self.vendor='LEXIS',l.county_name,'');
 self.fips           := l.fips_code;
 self.recording_date := v_rec_dt;
 self.record_type    := map(a='F' => 'FINAL JUDGEMENT',
                            a='L' => 'LIS PENDENS',
							a='N' => 'NOTICE OF DEFAULT',
							a='R' => 'RELEASE OF LIS PENDENS',
							a='U' => 'FORECLOSURE',
							l.fares_foreclosure='Y' => 'FORECLOSURE',
							l.fares_foreclosure='O' => 'REPOSSESSION',
							l.fares_foreclosure='P' => 'LENDER DISPOSITION',
							a='DL' => 'DEED IN LIEU OF FORECLOSURE',
							a='DS' => 'DISTRESS SALE',
							a='FC' => 'FORECLOSURE',
							a='PA' => 'SOLD FOR TAXES',
							a='SD' => 'SHERIFF\'S DEED',
							a='TD' and self.vendor='LEXIS' => 'TRUSTEE\'S DEED',
							l.recorder_map_reference='LP' => 'LIS PENDENS',
							l.recorder_map_reference='LIS PENDENS' => 'LIS PENDENS',
							''
						   );
 self.file_type      := 'DEED';						   
end;

p_slim := project(concat,t_slim_ds(left)) : persist('~thor_dell400_2::persist::deed_foreclosures');	

p_slim_lexis := p_slim(vendor='LEXIS');
p_slim_fares := p_slim(vendor='FARES');

slim_rec t_get_st_co(p_slim_fares l, fips_lookup r) := transform
 self.st     := r.st;
 self.county := r.county;
 self        := l;
end;

p_slim_fares_lookup := join(p_slim_fares,fips_lookup,
                            left.fips=right.fips,
							t_get_st_co(left,right),
							left outer, lookup
						   );

p_slim_concat := p_slim_lexis+p_slim_fares_lookup;

slim_rec t_slim_ds_fc(ds_fc l) := transform

 string v_deed_desc     := stringlib.stringtouppercase(l.deed_desc);
 string v_document_desc := stringlib.stringtouppercase(l.document_desc);
 
 string pick_1 := if(v_document_desc<>'',v_document_desc,v_deed_desc);
 
 string8 v_rec_dt := if(l.recording_date between '19500000' and ut.GetDate,l.recording_date,'');

 self.vendor         := 'FARES';
 self.st             := '';
 self.county         := '';
 self.fips           := l.state+l.county;
 self.recording_date := v_rec_dt;
 //Handle mis-spellings
 self.record_type    := map(pick_1='COMMISSIONER\'S DEDED'        => 'COMMISSIONER\'S DEED',
                            pick_1='DEED IN LIEW OF FORCLOSURE'   => 'DEED IN LIEU OF FORECLOSURE',
							pick_1='FINAL JUDGMENT'               => 'FINAL JUDGEMENT',
							pick_1='NOTICE OF DEFAULTS'           => 'NOTICE OF DEFAULT',
							pick_1='TRUSTEE\'S DEED (FORCLOSURE)' => 'TRUSTEE\'S DEED (FORECLOSURE)',
							pick_1
						   );
 self.file_type      := 'FORECLOSURE';
end;

p_slim_fc := project(ds_fc,t_slim_ds_fc(left)) : persist('~thor_dell400_2::persist::true_foreclosures');

slim_rec t_get_st_co_fc(p_slim_fc l, fips_lookup r) := transform
 self.st     := r.st;
 self.county := r.county;
 self        := l;
end;

p_slim_fc_lookup := join(p_slim_fc,fips_lookup,
                         left.fips=right.fips,
						 t_get_st_co_fc(left,right),
						 left outer,lookup
						);

bring_together := (p_slim_concat+p_slim_fc_lookup)(st<>'');

stat_rec := record
 bring_together.record_type;
 //string8 earliest_recording_dt := min(group,bring_together.recording_date);
 //string8 latest_recording_dt   := max(group,bring_together.recording_date); 
 deed_count        := count(group,trim(bring_together.file_type)='DEED');
 foreclosure_count := count(group,trim(bring_together.file_type)='FORECLOSURE');
 total_count                   := count(group);
end;

out_stats := sort(table(bring_together,stat_rec,record_type,few),record_type)(total_count>=100);
output(out_stats,all);

bring_together_d := bring_together(trim(file_type)='DEED');
bring_together_f := bring_together(trim(file_type)='FORECLOSURE');

stat_rec2 := record
 bring_together_d.fips;
 bring_together_d.st;
 bring_together_d.county;
 bring_together_d.record_type;
 bring_together_d.file_type;
 string8 earliest_recording_dt := min(group,bring_together_d.recording_date);
 string8 latest_recording_dt   := max(group,bring_together_d.recording_date);
 total_count                   := count(group);
end;

out_stats2      := sort(table(bring_together_d,stat_rec2,fips,st,county,record_type,file_type),fips,st,county,file_type,record_type);

stat_rec2 t_drop_low_freqs(out_stats l, out_stats2 r) := transform
 self := r;
end;

out_stats2_join := join(out_stats,out_stats2,
                        left.record_type=right.record_type,
						t_drop_low_freqs(left,right)
					   );


output(sort(out_stats2_join,fips,st,county,record_type,file_type),all);


stat_rec2a := record
 bring_together_f.fips;
 bring_together_f.st;
 bring_together_f.county;
 bring_together_f.record_type;
 bring_together_f.file_type;
 string8 earliest_recording_dt := min(group,bring_together_f.recording_date);
 string8 latest_recording_dt   := max(group,bring_together_f.recording_date);
 total_count                   := count(group);
end;

out_stats2a      := sort(table(bring_together_f,stat_rec2a,fips,st,county,record_type,file_type),fips,st,county,file_type,record_type);

stat_rec2a t_drop_low_freqs_2a(out_stats l, out_stats2a r) := transform
 self := r;
end;

out_stats2a_join := join(out_stats,out_stats2a,
                        left.record_type=right.record_type,
						t_drop_low_freqs_2a(left,right)
					   );


output(sort(out_stats2a_join,fips,st,county,record_type,file_type),all);




stat_rec3 := record
 bring_together.st;
 bring_together.record_type;
 deed_count        := count(group,trim(bring_together.file_type)='DEED');
 foreclosure_count := count(group,trim(bring_together.file_type)='FORECLOSURE');
 total_count       := count(group);
end;

out_stats3 := sort(table(bring_together,stat_rec3,st,record_type),st,record_type);

stat_rec3 t_drop_low_freqs2(out_stats l, out_stats3 r) := transform
 self := r;
end;

out_stats3_join := join(out_stats,out_stats3,
                        left.record_type=right.record_type,
						t_drop_low_freqs2(left,right)
					   );


output(sort(out_stats3_join,st,record_type),all);

/*
FARES_1080 DOCUMENT_TYPE FAR_F D N RELEASE OF MORTGAGE/DEED OF TRUST 
FARES_1080 DOCUMENT_TYPE FAR_F F N FINAL JUDGEMENT 
FARES_1080 DOCUMENT_TYPE FAR_F G N GRANT DEED 
FARES_1080 DOCUMENT_TYPE FAR_F L N LIS PENDENS 
FARES_1080 DOCUMENT_TYPE FAR_F N N NOTICE OF DEFAULT 
FARES_1080 DOCUMENT_TYPE FAR_F Q N QUIT CLAIM 
FARES_1080 DOCUMENT_TYPE FAR_F R N RELEASE OF LIS PENDENS 
FARES_1080 DOCUMENT_TYPE FAR_F S N LOAN ASSIGNMENT 
FARES_1080 DOCUMENT_TYPE FAR_F T N DEED OF TRUST 
FARES_1080 DOCUMENT_TYPE FAR_F U N FORECLOSURE 
FARES_1080 DOCUMENT_TYPE FAR_F X N MULTI CNTY/ST OR OPEN END MORTGAGE 
FARES_1080 DOCUMENT_TYPE FAR_F Z N NOMINAL 
*/