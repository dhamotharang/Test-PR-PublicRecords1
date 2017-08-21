export mac_patch_county(infile, state_field, outfile) := macro

#uniquename(patch_county)
#uniquename(input_state)
recordof(infile) %patch_county%(infile le) := transform

 string2  %input_state%      := le.state_field;
 string30 v_orig_county      := le.county_name;
 
 string30 v_county1     := stringlib.stringtouppercase(v_orig_county);
 string30 v_county2     := if(%input_state%='AK' and stringlib.stringfind(stringlib.stringtouppercase(v_county1),'FAIRBANKS',1)!=0,'FAIRBANKS NORTH STAR',
                           if(stringlib.stringfind(v_county1,'BOROUGH',1)!=0,v_county1[1..stringlib.stringfind(v_county1,'BOROUGH',1)-1],
 						   stringlib.stringfindreplace(v_county1,'\'','')));
 						   
 self.county_name       := v_county2;
 self                   := le;
end;

outfile := project(infile,%patch_county%(left));

endmacro;