/*2018-03-02T22:00:03Z (Santos, Ricardo Dos (RIS-BCT))
RR-12118
*/
import doxie, AutoStandardI, STD, ut;

EXPORT DID_Batch_Service_Records(dataset(DidVille.Layout_Did_InBatch) in_recs) := FUNCTION

  //creating mod_access in place, since other values are also initiated here;
  // this function is being used directly from the service layer.
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

	string120 append_l := '' 		: stored('Appends');
	string120 verify_l := '' 		: stored('Verify');
	string120 fuzzy_l := '' 			: stored('Fuzzies');
	boolean   lookups := false 		: stored('Lookups');
	boolean   livingSits := false 	: stored('LivingSits');
	boolean   dedup_results_l := true 	: stored('Deduped');
	string3   thresh_val := '' 		: stored('AppendThreshold');
	boolean   GLB := false 			: stored('GLBData');
	boolean   patriotproc := false 	: stored('PatriotProcess');
	unsigned1 soap_xadl_version_value := 0 : stored('xADLVersion');			
	boolean usePreLab := false : stored('usePreLab');

	// Bug: 53541=> for this service, we are using the nonblank key to ensure the largest 
	// majority of first and last names are populated during record retreival
	UseNonBlankKey := TRUE;

	dedup_results := dedup_results_l;// IN ['on','1'];
	appends := STD.Str.ToUpperCase(append_l);
	verify := STD.Str.ToUpperCase(verify_l);
	thresh_num := (unsigned2)thresh_val;
	fuzzy := STD.Str.ToUpperCase(fuzzy_l);

	DidVille.Layout_Did_OutBatch into(DidVille.Layout_Did_InBatch i) := transform
		self.ssn := stringlib.stringfilter(i.ssn,'0123456789');
		self := i;
		end;

	recs := project(in_recs,into(left));

	res1 := didville.did_service_common_function(recs, appends, verify, fuzzy, dedup_results, 
																							thresh_num, GLB, patriotproc, lookups, 
																							livingSits, false, false, mod_access.glb, 
																							mod_access.show_minors,,UseNonBlankKey, mod_access.application_type, soap_xadl_version_value,
																							IndustryClass_val := mod_access.industry_class);


	Mapkey := DidVille.key_lab_did_mapping;

	string isLabData1 := STD.Str.ToUpperCase(thorlib.getenv('isLabData',''));

	dummyDIDs := [1791860725];

	recs_out := If(usePreLab ,
						Join(res1 , Mapkey, 
						(isLabData1='TRUE' or Left.did in dummyDIDs) 
						and Keyed(Left.did = right.postLAB_LexID)  ,
								Transform(DidVille.Layout_Did_OutBatch,
									Self.DID := if(right.preLAB_ADL > 0, 
																	right.preLAB_ADL, left.DID),
									Self := left	),
							left outer, keep(1)),
						res1);
						
	return recs_out;
END;