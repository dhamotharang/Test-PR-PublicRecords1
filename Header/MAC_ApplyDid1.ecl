export MAC_ApplyDid1(infile1,did_field,infile2,outfile) := macro

//****** FIRST, I WANT TO ELIMINATE ANY RULES THAT WOULD MAP TO DIDS THAT HAVE DISAPPEARED
//			 I'LL DO THIS BY MAKING SURE NEW_RID MATCHES A DID IN THE HEADER FILE
//infile1 is the header
//infile2 is the did rules
#uniquename(hdids)
#uniquename(rules_dist)
#uniquename(rules)
%hdids% := dedup(sort(distribute(project(infile1, {infile1.did_field}), hash((unsigned6)did_field)), did_field, local), did_field, local);
%rules_dist% := distribute(infile2, hash((unsigned6)new_rid));
%rules% := join(%rules_dist%, %hdids%, 
								left.new_rid = right.did_field,
								transform({infile2}, self := left),
								local);

// debug only
// count(infile2);
// count(%rules%);

ut.MAC_Patch_Id(infile1,did_field,%rules%,old_rid,new_rid,outfile)

endmacro;