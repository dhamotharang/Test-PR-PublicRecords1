export fn_patch_vendor(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function

recordof(int0) t_patch_vendor(recordof(int0) le) := transform
 
 self.source_file := stringlib.stringtouppercase(le.source_file);
 self.vendor := if(le.vendor[1..3] in ['CIV','OFR'],le.vendor,
                if(le.vendor='INGHM',le.vendor,
				le.state_origin
				));
 self        := le;				
				
end;

p_patch_vendor := project(int0,t_patch_vendor(left));

return p_patch_vendor;

end;