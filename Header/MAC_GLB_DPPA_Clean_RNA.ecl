export MAC_GLB_DPPA_Clean_RNA(infile,outfile) := Macro
// this should get called if the header records have already been through the normal
// header.MAC_GlbClean_Header
// this macro will apply GLB and DPPA restrictions that are special for Relative, Neighbors
// Associates, roomates, Household members, Residents, imposters; when  there is a subject to be
// also returned.

import mdr, ut, doxie;
#uniquename(filterIncoming);
#uniquename(filtered);

infile %filterIncoming%(infile le):= transform,	skip((ut.PermissionTools.glb.restrictRNA(GLB_Purpose) 
   and ~ut.PermissionTools.glb.HeaderIsPreGLB((unsigned3)le.dt_nonglb_last_seen, (unsigned3)le.dt_first_seen, le.src))
	 or 
	 (ut.PermissionTools.dppa.restrictRNA(dppa_Purpose) and mdr.SourceTools.SourceIsDPPA(le.src))
	 )
	self := le;
end;

%filtered% := project (infile,%filterIncoming%(Left));
#uniquename(fixedDates)
Doxie.mac_headerDates(%filtered%,%fixedDates%,,header.constants.checkRNA);
outfile := %fixedDates%;
endMacro;
