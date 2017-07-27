export Mac_Set_Header_Source(infile,in_layout,out_layout,source_code,outfile,seed=1) := macro
#uniquename(setUID)
#uniquename(outfile0)
out_layout %setUID%(in_layout L) := transform
 self.uid := 0 ; 
 self.src := source_code;
 self := l;
end;
%outfile0% := project(infile,%setUID%(left));

#uniquename(tra)
out_layout %tra%(%outfile0% l,%outfile0% r) := transform
  self.uid := if(l.uid=0, thorlib.node() + seed, l.uid + thorlib.nodes() );
  self := r;
  end;

//****** Push infile through transform above
outfile := iterate(%outfile0%,%tra%(left,right),local);
endmacro;