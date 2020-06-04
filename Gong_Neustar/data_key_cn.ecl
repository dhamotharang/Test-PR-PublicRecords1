IMPORT $, dx_Gong;

f_base := $.File_History_Full_Prepped_for_Keys(current_record_flag<>'', listing_type_bus !='' or listing_type_gov != '');

cn_layout := RECORD
	f_base.listed_name;
	f_base.caption_text;
	STRING 		cn_all := '';
	STRING100 	cn := '';
	STRING2 	st := '';
	STRING25 	p_city_name;
	STRING25 	v_city_name;
	STRING5 	z5 := '';
	STRING10 	phone10;
END;

f_cn := project(f_base, transform(cn_layout, 
							      self.cn_all := if(left.listing_type_bus !='' or left.listing_type_gov != '',
											        keyLib.GongDacName(Left.listed_name+' '+Left.caption_text),''),
								  self := left))(cn_all<>'');
								
cn_layout normCN(cn_layout l,integer c) :=TRANSFORM
	self.cn := l.cn_all[((c-1)*10)+1..c*10];
	self := l;
END;

f_cn_norm := normalize(f_cn,length(left.cn_all)/10,normCN(left,counter));
f_cn_norm_dep := dedup(sort(f_cn_norm, record), record);

ds_file := f_cn_norm_dep(metaphonelib.DMetaPhone1(cn) <> '');

EXPORT data_key_cn := PROJECT(ds_file, TRANSFORM(dx_Gong.layouts.i_cn,
                                                 SELF.dph_cn := metaphonelib.DMetaPhone1(LEFT.cn),
                                                 SELF := LEFT));
