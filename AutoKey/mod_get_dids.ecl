/*2008-02-06T19:51:58Z (Chad Morton)
bug 29110
*/
import doxie;
export mod_get_dids(
	STRING t, 
	set of STRING1 get_skip_set=[], 
	boolean workHard = true, 
	boolean nofail=true,
	boolean useAllLookups = false,
  IFetch visitor = MODULE (IFetch) END)  := 
MODULE

//***** BOOLEANS TO DIRECT THE ACTION
shared boolean skip_all := 'C' in get_skip_set;
shared boolean skip_ssn := 'S' in get_skip_set;
shared boolean skip_phn := 'P' in get_skip_set;
shared boolean skip_zip := 'Z' in get_skip_set;
shared boolean  add_zpl := '-' in get_skip_set;

//***** RETURN LAYOUT
export layout := autokey.layout_fetch;

//***** LIL FUNCTIONS
shared afailure(dataset(layout) l) := l[1].error_code;
shared results(dataset(layout) l) := l(error_code = 0);
 
//***** FETCHES
shared ssn := 
	project(
		if(not skip_all and not skip_ssn,
			 visitor.Fetch_ssn(t, workHard, nofail, useAllLookups)), layout);
	
shared phone :=	
	project(
		if(not skip_all and not skip_phn,
			 visitor.Fetch_Phone(t,nofail,useAllLookups)), layout);
		 
shared Address :=
	project(
		if(not skip_all,	 
			 visitor.Fetch_Address(t, workHard,nofail)), layout);
		 
shared zip :=
	project(
		if(not skip_all and not skip_zip,	 		 
			visitor.Fetch_Zip(t, workHard, nofail)), layout);

shared name :=
	project(
		if(not skip_all,	 
			visitor.Fetch_Name(t, workHard,nofail)), layout);
	
shared StFLName :=
	project(
		if(not skip_all,	 
			visitor.Fetch_StFLName(t, workHard,nofail)), layout);
	
shared StCityFLName :=
	project(
		if(not skip_all,	 
			visitor.Fetch_StCityFLName(t, workHard,nofail)), layout);

shared zipPRLname :=
	project(
		if(not skip_all and add_zpl,	 		 
			visitor.Fetch_ZipPRLName(t, workHard, nofail)), layout);

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
	
shared all_ds := 
	ssn + phone + address + zip + name + StFLName + StCityFLName + zipPRLname +
	custom1 + custom2 + custom3 + custom4 + custom5;

//***** EXPORT THESE FOR CONTROL OVER FAILURE AT THE LEVEL ABOVE
export the_failure := afailure(all_ds);
export had_failure := the_failure > 0;
export all_results := results(all_ds);
export has_results := exists(all_results);
export did_fail 	 := had_failure and not has_results;
	
export result := dedup(all_results,did,all);

		
END;