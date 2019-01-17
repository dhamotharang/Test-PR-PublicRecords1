export MAC_GLB_DPPA_Clean_RNA(infile,outfile,modAccess) := Macro
// this should get called if the header records have already been through the normal
// header.MAC_GlbClean_Header
// this macro will apply GLB and DPPA restrictions that are special for Relative, Neighbors
// Associates, roomates, Household members, Residents, imposters; when  there is a subject to be
// also returned.

import mdr, doxie;
#uniquename(filterIncoming);
#uniquename(filtered);

infile %filterIncoming%(infile le):= transform,	skip((modAccess.isRnaRestrictedGlb() 
   and ~modAccess.isHeaderPreGLB((unsigned3)le.dt_nonglb_last_seen, (unsigned3)le.dt_first_seen, le.src))
	 or 
	 (modAccess.isRnaRestrictedDppa() and mdr.SourceTools.SourceIsDPPA(le.src))
	 )
	self := le;
end;

%filtered% := project (infile,%filterIncoming%(Left));
#uniquename(fixedDates)
Doxie.mac_headerDates(%filtered%, %fixedDates%, modAccess, header.constants.checkRNA);
outfile := %fixedDates%;
endMacro;
