import autokey,doxie,autokeyb2;

export get_IDs(
	STRING t, 
	string typestr='', 
	set of STRING1 get_skip_set=[], 
	boolean PworkHard = true,
	boolean nofail =true,
	boolean useAllLookups = false,
  Autokey.IFetch visitor = MODULE (Autokey.IFetch) END,
  AutokeyB.IFetch visitorb = MODULE (AutokeyB.IFetch) END) := FUNCTION


SworkHard := if(PworkHard, '1', '0');
workHard := thorlib.getenv('WorkHard',SworkHard)='1';  

doxie.MAC_Header_Field_Declare()

//***** SOME BOOLEANS TO DIRECT BEHAVIOR
isCompanyNameSearch := comp_name_value <> '';
isAddrSearch := pname_value <> '';
isBareAddr := isAddrSearch and not isCompanyNameSearch and 'C' not in get_skip_set;


//***** MODULE CALLS FOR PERSON SEARCH AND BUSINESS SEARCH
agd := autokey.mod_get_dids(t, get_skip_set, workhard,nofail,useAllLookups, visitor);
agb := autokeyb.mod_get_bdids(t,get_skip_set, isBareAddr, workhard,nofail,useAllLookups, visitorb);


//***** TRANSFORM RESULTS INTO OUTPUT LAYOUT
idsrec := {unsigned6 ID, boolean isDID := false, boolean isBDID := false,boolean IsFake};
 
idsrec makeids(boolean lisDID, boolean lisBDID, unsigned6 lID) := transform
	self.isDID  := lisDID;
	self.isBDID := lisBDID;
	self.ID := lID;
	self.IsFake := IsFakeID(lID,typestr);
end;
 
newdids  := project(agd.result, makeids(true, false, left.did)); 
newbdids := project(agb.result, makeids(false, true, left.bdid)); 
 
ids := newdids+newbdids;


//***** ONLY FAIL IF SOME FETCH FAILED AND NO OTHER FETCH FOUND RESULTS
did_fail := (agd.did_fail or agb.did_fail) and not exists(ids);
the_failure := if(agd.did_fail, agd.the_failure, agb.the_failure);

return if(did_fail,
					fail(idsrec, the_failure, doxie.ErrorCodes(the_failure)),
					ids);

END;