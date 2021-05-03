/*
  Set the seleid, lgid3(which can be different), and the regex for the good records
  seems to only work if your cluster should be broken into two.  if it is horribly overlinked and should be broken up into multiple clusters
  need to use
    BIPV2_BlockLink._BWR_Reset_Overlinked_Clusters
*/

theseleid := 73855628 ;
thelgid3  := 73855628 ;
goodregex := '(Lydia)';

#workunit('name'  ,'LGID3 Blocklink ' + (string)theseleid + ' ' + goodregex );


ds_blocklink_cands := BIPV2_Blocklink.ManualOverlinksLGID3.candidates(theseleid  ,thelgid3);

ds_blocklink_cands_set_good_flag := project(ds_blocklink_cands  ,transform(recordof(left)
  ,self.good := if(regexfind(goodregex ,left.company_name,nocase) ,true ,false)
  ,self      := left

));

output(ds_blocklink_cands_set_good_flag ,all);
output(ds_blocklink_cands_set_good_flag(regexfind(goodregex  ,company_name ,nocase)) ,all);


// -- Make sure your datasets above have the good field set properly first.  Once you have that set properly, 
// -- then uncomment out this line to add them to the blocklink file
// BIPV2_Blocklink.ManualOverlinksLGID3.addCandidates(ds_blocklink_cands_set_good_flag ,theseleid);

