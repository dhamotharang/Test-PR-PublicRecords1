//============================================================================
// Attribute: CompAddress_Raw.  Used by view source service.
// Function to get the source of header records by did.
// Return value: dataset of layout Doxie_Raw.Layout_crs_raw.
//============================================================================
import Doxie, Doxie_raw, UtilFile, ut, address;

export CompAddress_Raw(
    dataset(Doxie_raw.Layout_input) input,
    doxie.IDataAccess mod_access
) := FUNCTION

myHeader := Doxie_Raw.Header_Raw(
    project(input(section = 'addresses'), 
      transform(Doxie.layout_references, self.did:=(unsigned6)left.id)),
      mod_access);

//Filter by address here. Simulate the Doxie.mac_address_rollup.
addressFiltered := join(myHeader, input, 
    left.did = (unsigned6)right.id and 
    ((right.prim_range = '' and right.prim_name = '') OR  //if no address, show all.
   (left.prim_range=right.prim_range and
     (left.prim_name=right.prim_name or
    right.zip4='' and 
    ( ut.StringSimilar(left.prim_name,right.prim_name)<3 or
    length(trim(left.prim_range))>2 )
   )and 
    ut.nneq(left.predir, right.predir) and
    address.Sec_Range_Eq(left.sec_range,right.sec_range) < 10)), 
   transform(left));

ridsAll := project(addressFiltered, TRANSFORM(Doxie.Layout_ref_rid, SELF := LEFT));
rids := dedup(sort(ridsAll, rid), rid);

srcRec := Doxie_Raw.ViewSourceRid(rids, mod_access);

// get daily utility records 
utDailyRecs := project(Doxie_Raw.Util_Daily_Raw(    
                        project(input(section = 'addresses'), 
                                transform(Doxie.layout_references_hh, 
                                          self.did:=(unsigned6)left.id, self.includedByHHID := false)),            
                        mod_access.date_threshold,
                        mod_access.dppa, 
                        mod_access.glb,
                        mod_access.industry_class), 
                      transform(recordof(srcRec), 
                                self.did := (unsigned8)left.did, 
                                self.rid := 0;
                                self.src := 'UT';
                                self.util_child := project(left, transform(UtilFile.Layout_Utility_In, self := left));                  
                                self := [])) ;

glb_ok := mod_access.isValidGLB();

res := srcRec + if(glb_ok, utDailyRecs);

return res;
END;
