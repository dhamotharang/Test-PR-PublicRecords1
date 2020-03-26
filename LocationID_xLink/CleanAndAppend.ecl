import LocationID_xLink;
import AID;
import Address;

export CleanAndAppend(inDs, 
                      line1_field,
                      line2_field,
                      rawaid_field,
                      outDs) := macro

          
   #uniquename(InputRec)
   %InputRec% := record
      unsigned6 ref_clean;
      inDs;
   end;

   #uniquename(resolveInputA)
   %resolveInputA% := project(inDs,
                              transform(%InputRec%,
                              self.ref_clean         := ((counter - 1) * thorlib.nodes()) + thorlib.node(),
                              self.line1_field       := Address.fn_addr_clean_prep(left.line1_field, 'first'),
                              self.line2_field       := Address.fn_addr_clean_prep(left.line2_field, 'last'),
                              self                   := left), local);

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
                          Address.fn_addr_clean_prep(left.line1_field, 'first') = right.line1 and
                          Address.fn_addr_clean_prep(left.line2_field, 'last')  = right.line2,
                          transform(%OutputRec%, self.locid := right.locid, self.rawaid := right.rawaid, self := left,  self := right), left outer, hash);
	

  	outDs          := %addBackData%;

endmacro;