xml_layout := record
string payload;
end;
 
f := dataset ('~thor_data400::in::bbbdata2_xml',xml_layout,CSV(HEADING(0)));

layout_attr_name := record
string50 attr_name;
end;

count(f(stringlib.stringfind(payload, 'attr name="', 1) > 0));

layout_attr_name GetPhoneType(f l) := transform
self.attr_name := l.payload[(stringlib.stringfind(l.payload, '"', 1) + 1)..(stringlib.stringfind(l.payload, '"', 2) - 1)];
end;
							 

attr_names := project(f(stringlib.stringfind(payload, 'attr name="', 1) > 0), GetPhoneType(left));
							 
layout_stat := record
attr_names.attr_name;
cnt := count(group);
end;

attr_names_stat := table(attr_names, layout_stat, attr_name, few);

output(attr_names_stat, all);


