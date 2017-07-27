/*2008-02-07T15:06:24Z (George  LHeureux)
Bug 29110.  Correcting.
*/
import doxie,autokeyb2;
export mod_get_bdids(
	STRING t, 
	set of STRING1 get_skip_set=[],
	boolean isBareAddr, 
	boolean workHard = true,
	boolean nofail=true,
	boolean useAllLookups = false,
  IFetch visitor = MODULE (IFetch) END)  := 
MODULE
//NB: by default visitor = autokeyB below.

//***** BOOLEANS TO DIRECT THE ACTION
shared boolean skip_all  := 'B' in get_skip_set;
shared boolean skip_fein := 'F' in get_skip_set;
shared boolean skip_phn  := 'Q' in get_skip_set;
shared boolean skip_zip  := 'Z' in get_skip_set;
shared boolean skip_addr := isBareAddr;

//***** RETURN LAYOUT
export layout := autokeyb2.layout_fetch;

//***** LIL FUNCTIONS
shared afailure(dataset(layout) l) := l(error_code > 0)[1].error_code;
shared results(dataset(layout) l) := l(error_code = 0);
 
//***** FETCHES 
shared fein := 
	project(
		if(not skip_all and not skip_fein,
			 visitor.Fetch_FEIN(t, workHard,nofail,useAllLookups)), layout);
	
shared phone :=	
	project(
		if(not skip_all and not skip_phn,
			 visitor.Fetch_Phone(t,nofail,useAllLookups)), layout);
		 
shared Address :=
	project(
		if(not skip_all and not skip_addr,	 
			 visitor.Fetch_Address(t, workHard,nofail,useAllLookups)), layout);
		 
shared zip :=
	project(
		if(not skip_all and not skip_addr and not skip_zip,	 		 
			visitor.Fetch_Zip(t, workHard,nofail,useAllLookups,get_skip_set)), layout);

shared name :=
	project(
		if(not skip_all,
			visitor.Fetch_Name(t, workHard,nofail,useAllLookups)), layout);
	
shared StName :=
	project(
		if(not skip_all and not skip_addr,
			visitor.Fetch_StName(t, workHard,nofail,useAllLookups)), layout);
	
shared StCityFLName :=
	project(
		if(not skip_all and not skip_addr,	 
			visitor.Fetch_StCityFLName(t, workHard,nofail,useAllLookups,get_skip_set)), layout);

shared NameWords :=
	project(
		if(not skip_all,
			visitor.Fetch_NameWords(t, workHard,nofail,useAllLookups)), layout);

shared custom1 :=
	visitor.Fetch_Custom1(t, workHard, nofail);

shared custom2 :=
	visitor.Fetch_Custom2(t, workHard, nofail);
	
shared custom3 :=
	visitor.Fetch_Custom3(t, workHard, nofail);
	
shared custom4 :=
	visitor.Fetch_Custom4(t, workHard, nofail);
	
shared custom5 :=
	visitor.Fetch_Custom5(t, workHard, nofail);

// NameWords fetch should never contribute to an error
shared base_ds := fein + phone + address + zip + name + StName + StCityFLName +
	custom1 + custom2 + custom3 + custom4 + custom5;
	
shared all_ds := base_ds + NameWords;	
	
//***** EXPORT THESE FOR CONTROL OVER FAILURE AT THE LEVEL ABOVE
export the_failure := afailure(base_ds);
export had_failure := the_failure > 0;
export all_results := results(all_ds);
export has_results := exists(all_results);
export did_fail 	 := had_failure and not has_results;
	

export result := dedup(all_results,bdid, all)(bdid > 0);

		
END;