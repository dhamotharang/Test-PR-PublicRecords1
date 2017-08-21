import LN_propertyV2_fast, ut;

layout_bus_preferred := record

string orig_name;

string clean_name;

string preferred_name;

end;

preferred_name := dataset('~thor_data400::in::epic::preferred_biz_name', layout_bus_preferred, csv(heading(1), separator(','),quote('"')), opt);

//clean and dedup

preferred_name_clean := project(preferred_name, transform(layout_bus_preferred, self.clean_name := if(left.clean_name = '', trim(left.orig_name, left,right), trim(left.clean_name,left,right)),
self.preferred_name := StringLib.StringToUpperCase(trim(left.preferred_name, left,right)),self := left));

export File_Bus_Preferred := dedup(sort(preferred_name_clean(clean_name <> preferred_name and preferred_name <> ''), 
                       clean_name, preferred_name),clean_name, preferred_name)(clean_name = 'BANK OF NEW YORK' and preferred_name = 'BNY MELLON');
