import LocationID_xLink;
import AID;

export CleanAndAppend(inDs, 
                      line1_field,
                      line2_field,
                      rawaid_field,
                      outDs) := macro

          
   #uniquename(InputRec)
   %InputRec% := record
      unsigned6 ref_clean;
      string line1;
      string line2;
      unsigned8 RawAID;
   end;

   #uniquename(resolveInputA)
   %resolveInputA% := project(inDs,
                              transform(%InputRec%,
                              self.ref_clean   := ((counter - 1) * thorlib.nodes()) + thorlib.node(),
                              self.line1       := left.line1_field,
                              self.line2       := left.line2_field,
                              self.RawAID      := left.rawaid_field), local);

   #uniquename(lFlags)
   unsigned4   %lFlags% := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

   #uniquename(dedupLines)
   %dedupLines%  := dedup(%resolveInputA%, line1, line2, all, hash);
   
   #uniquename(cleanInput)  
   AID.MacAppendFromRaw_2Line(%dedupLines%, line1, line2, RawAID, %cleanInput%, %lFlags%);    
		    
   #uniquename(appendOutput)
   LocationID_xLink.Append(%cleanInput%
                           ,aidwork_acecache.prim_range
                           ,aidwork_acecache.predir
                           ,aidwork_acecache.prim_name
                           ,aidwork_acecache.addr_suffix
                           ,aidwork_acecache.postdir
                           ,aidwork_acecache.sec_range
                           ,aidwork_acecache.v_city_name
                           ,aidwork_acecache.st
                           ,aidwork_acecache.zip5
                           ,%appendOutput%);

   #uniquename(FlatRec)
   %FlatRec% := record
      %resolveOutput%.results.locid;
      %resolveOutput%.results.weight;
      %resolveOutput%.results.reference;
      %resolveOutput%.resolved;
   end;

   #uniquename(flattenDs)
   %flattenDs% := normalize(%resolveOutput%, left.results, 
                            transform(%FlatRec%,
                                      self := left,
                                      self := right));

   #uniquename(resolvedDs)
   %resolvedDs% := dedup(%flattenDs%(resolved), reference);
   
   #uniquename(OutputRecA)
   %OutputRecA% := record
      %FlatRec%.LocId;
      %cleanInput%.line1;
      %cleanInput%.line2;
      typeof(%cleanInput%.aidwork_rawaid) rawaid;
      typeof(%cleanInput%.aidwork_acecache.aid) cleanaid;
      %cleanInput%.aidwork_acecache.prim_range;
      %cleanInput%.aidwork_acecache.predir;
      %cleanInput%.aidwork_acecache.prim_name;
      %cleanInput%.aidwork_acecache.addr_suffix;
      %cleanInput%.aidwork_acecache.postdir;
      %cleanInput%.aidwork_acecache.unit_desig;
      %cleanInput%.aidwork_acecache.sec_range;
      %cleanInput%.aidwork_acecache.v_city_name;
      %cleanInput%.aidwork_acecache.st;
      %cleanInput%.aidwork_acecache.zip5;
      %cleanInput%.aidwork_acecache.zip4;
      %cleanInput%.aidwork_acecache.cart;
      %cleanInput%.aidwork_acecache.cr_sort_sz;
      %cleanInput%.aidwork_acecache.lot;
      %cleanInput%.aidwork_acecache.lot_order;
      %cleanInput%.aidwork_acecache.dbpc;
      %cleanInput%.aidwork_acecache.chk_digit;
      %cleanInput%.aidwork_acecache.rec_type;
      %cleanInput%.aidwork_acecache.county;
      %cleanInput%.aidwork_acecache.geo_lat;
      %cleanInput%.aidwork_acecache.geo_long;
      %cleanInput%.aidwork_acecache.msa;
      %cleanInput%.aidwork_acecache.geo_blk;
      %cleanInput%.aidwork_acecache.geo_match;
      %cleanInput%.aidwork_acecache.err_stat;
   end;
   
   #uniquename(createOutput)
   %createOutput% := join(%cleanInput%, %appendOutput%,
                          left.ref_clean = right.ref_clean,
                          transform(%OutputRecA%, self.locid := right.locid, self.rawaid := left.aidwork_rawaid, self.cleanaid := left.aidwork_acecache.aid, self := left.aidwork_acecache, self.line1 := left.line1, self.line2 := left.line2, self := right), left outer, hash);

   #uniquename(OutputRec)
   %OutputRec% := record
      inDs;
      %OutputRecA%;
   end;
   
   #uniquename(addBackData)
   %addBackData%  := join(inDs, %createOutput%,
                          left.line1_field = right.line1 and
                          left.line2_field = right.line2,
                          transform(%OutputRec%, self := left,  self := right), left outer, hash);
	
   output(%resolvedDs%);
   outDs          := %addBackData%;

endmacro;