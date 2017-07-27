IMPORT doxie, ut, IdentityManagement_Services, InsuranceHeader_PostProcess, AutoStandardI, InsuranceHeader_BestOfBest;

EXPORT InsuranceDLRecords(IdentityManagement_Services.IParam._report in_params, DATASET (doxie.layout_references) dids) := FUNCTION
	dppa_ok := AutoStandardI.PermissionI_Tools.val(in_params).DPPA.ok(in_params.dppaPurpose);
	dl_ok	:= AutoStandardI.DataPermissionI.val(in_params).use_InsuranceDLData;
	
	InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Layout_Input Insurance_Input(doxie.layout_references L,INTEGER C) := TRANSFORM
		SELF.Seq := C;
		SELF.DID := L.DID;
		SELF := L;
		SELF := [];
	END;

	ds_InReq_InsuranceDL := IF(dppa_ok and dl_ok, PROJECT(dids(did<>0),Insurance_Input(left,counter)));
	ds_InReq_Formatted := GROUP(SORT(ds_InReq_InsuranceDL,Seq),Seq); 
	
	
  dppa := in_params.dppaPurpose;
	DataPermission := AutoStandardI.DataPermissionI.val(in_params).permission_mask;
	Insurance_DL_Did := InsuranceHeader_BestOfBest.search_Insurance_DL_by_DID(ds_InReq_Formatted,dppa,false,DataPermission);
	
	Insurance_DL_Recs := PROJECT(UNGROUP(Insurance_DL_Did), InsuranceHeader_PostProcess.layouts.DL);

	Insurance_DL_Final := Insurance_DL_Recs(ut.PermissionTools.dppa.state_ok(dl_state,in_params.dppaPurpose,,src));

	//=====For Debug Purposes========================================
	// output(dids, named('dids'));
	// output(ds_InReq_InsuranceDL, named('ds_InReq_InsuranceDL'));
	// output(ds_InReq_Formatted, named('ds_InReq_Formatted'));
	// output(dppa, named('dppa'));
	// output(DataPermission, named('DataPermission'));
	// output(Insurance_DL_Did, named('Insurance_DL_Did'));
	// output(Insurance_DL_Recs, named('Insurance_DL_Recs'));
	// output(Insurance_DL_Final, named('Insurance_DL_Final'));
	//===============================================================
	
	Return Insurance_DL_Final;
	
END;
