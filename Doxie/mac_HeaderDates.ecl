export mac_HeaderDates(infile, outfile, batch = false, checkRNA = false) := macro
#uniquename(tra_mac_HeaderDates)
infile %tra_mac_HeaderDates%(infile le) := transform
	Ldls := if(
  						ut.PermissionTools.glb.SrcNeverRestricted(le.src) or
							ut.glb_ok(
		#if(batch)
			le.
		#end
		glb_purpose,checkRNA), le.dt_last_seen, le.dt_nonglb_last_seen); //or ~(le.src in mdr.sourceTools.set_GLB) above 90984
	Ldfs := le.dt_first_seen;  
  
	self.dt_first_seen := if(Ldfs > 0, Ldfs, Ldls);
	self.dt_last_seen := if(Ldls > 0, Ldls, Ldfs);

	self := le;
end;

outfile := project(infile, %tra_mac_HeaderDates%(left));

endmacro;

