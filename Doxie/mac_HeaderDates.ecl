export mac_HeaderDates(infile, outfile, modAccess, checkRNA = false, batch = false) := macro
#uniquename(tra_mac_HeaderDates)
infile %tra_mac_HeaderDates%(infile le) := transform
	Ldls := if(
  						doxie.compliance.SrcNeverRestricted (le.src) or
		#if(batch)
			doxie.compliance.glb_ok (le.glb_purpose, checkRNA),
    #else
      modAccess.isValidGLB (checkRNA),
		#end
		le.dt_last_seen, le.dt_nonglb_last_seen); //or ~(le.src in mdr.sourceTools.set_GLB) above 90984
	Ldfs := le.dt_first_seen;  
  
	self.dt_first_seen := if(Ldfs > 0, Ldfs, Ldls);
	self.dt_last_seen := if(Ldls > 0, Ldls, Ldfs);

	self := le;
end;

outfile := project(infile, %tra_mac_HeaderDates%(left));

endmacro;

