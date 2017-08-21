import Data_Services, doxie;

f_base := File_History_Full_Prepped_for_Keys(current_record_flag<>'', listing_type_bus !='' or listing_type_gov != '');

cn_layout := record
f_base.listed_name;
f_base.caption_text;
string cn_all := '';
string100 cn := '';
string2 st := '';
string25 p_city_name;
string25 v_city_name;
string5 z5 := '';
string10 phone10;
end;

f_cn := project(f_base, transform(cn_layout, 
							                    self.cn_all		:= if(left.listing_type_bus !='' or left.listing_type_gov != '',
											                                keyLib.GongDacName(Left.listed_name+' '+Left.caption_text),''),
								                  self := left))(cn_all<>'');
								
cn_layout normCN(cn_layout l,integer c) :=TRANSFORM
	self.cn := l.cn_all[((c-1)*10)+1..c*10];
	self := l;
END;

f_cn_norm := normalize(f_cn,length(left.cn_all)/10,normCN(left,counter));
f_cn_norm_dep := dedup(sort(f_cn_norm, record), record);

export key_cn := index(f_cn_norm_dep(metaphonelib.DMetaPhone1(cn) <> ''), 
                       {string6 dph_cn := metaphonelib.DMetaPhone1(cn), cn, st, p_city_name, v_city_name, z5},{listed_name, phone10},
                       Data_Services.Data_location.Prefix('Gong_History')+'thor_data400::key::gong_cn_'+doxie.Version_SuperKey);