/*
//do tonight -- try to kick off iteration that doesnt have contact fields in it.  see how much faster it is
//remove contact fields from spc
//do cnp name stuff
//corpkey stuff -- check
//high priority
//two step specs
added hint(parallel_match to MJ in matches
changed h0 dedup in match_candidates to except rcid instead of whole record
hack on BIPV2_Files.tools_dotid.SetSOS
remove abbr from cnp name
make cnp name force(+13) instead of just force(+)
remove all conditional forces on cnp name
add force(+-2) to company_csz concept
patch iteration1's bad city, bad zip records
patch cnp_number field to split records with populated to blank cnp number
change SPC for cnp_number field to default force from force(--) to prevent future blank to populated matches on that field.
hack default force for cnp_number and prim_range(make sure they equal each other)
*/
import BIPV2,BIPV2_Build,BIPV2_ProxID,tools;
iteration := '@iteration@';
pversion  := '@version@';
lih       := if((unsigned)iteration = 1   ,BIPV2_ProxID.In_DOT_Base    ,BIPV2_ProxID.files().base.built );
#workunit('name','BIPV2 Proxid ' + pversion + ' iter ' + iteration);
#workunit('priority','high');
BIPV2_Build.proc_proxid(iteration,lih,pversion).runIter;
