/*
  Set the proxid, and the regex for the good records.
  seems to only work if your cluster should be broken into two.  if it is horribly overlinked and should be broken up into multiple clusters
  you need to use
    BIPV2_BlockLink._BWR_Reset_Overlinked_Clusters
*/

theproxid  := 73855628 ;
goodregex := '(Lydia)';

#workunit('name'  ,'Proxid Blocklink ' + (string)theproxid + ' ' + goodregex );


ds_blocklink_cands := BIPV2_Blocklink.ManualOverlinksproxid.candidates(theproxid);

ds_blocklink_cands_set_good_flag := project(ds_blocklink_cands  ,transform(recordof(left)
  ,self.good := if(regexfind(goodregex ,left.cnp_name,nocase) ,true ,false)
  ,self      := left

));

output(ds_blocklink_cands_set_good_flag ,all);
output(ds_blocklink_cands_set_good_flag(regexfind(goodregex  ,cnp_name ,nocase)) ,all);


// -- Make sure your datasets above have the good field set properly first.  Once you have that set properly, 
// -- then uncomment out this line to add them to the blocklink file
// BIPV2_Blocklink.ManualOverlinksproxid.addCandidates(ds_blocklink_cands_set_good_flag);

