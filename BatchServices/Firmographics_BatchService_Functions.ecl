import MDR, autostandardI;
export Firmographics_BatchService_Functions(AutoStandardI.DataRestrictionI.params in_mod) := module

	export DRM := AutoStandardI.DataRestrictionI.val(in_mod);
	export DPPA := AutoStandardI.PermissionI_Tools.val(in_mod).DPPA;

  // keeping lines in here which are used for property restrictions in case they are needed
	// in the future.
	export boolean isRestricted(
		string2 source		
		) := function	
		return map(			
			MDR.sourceTools.SourceIsDunn_Bradstreet(source)                                 => true,
			//DRM.FARES      and MDR.sourceTools.SourceIsProperty(source)        and source_docid_1 in ['R']     => true,
			DRM.EBR        and MDR.sourceTools.SourceIsEBR(source)                          => true,
			//DRM.Fidelity   and MDR.sourceTools.SourceIsProperty(source)        and source_docid_1 in ['O','D'] => true,
			//not ln_branded and MDR.sourceTools.SourceIsProperty(source)        and source_docid_1 in ['D']     => true,
			MDR.sourceTools.SourceIsDPPA(source)
			          and not DPPA.state_ok(MDR.SourceTools.DPPAOriginState(source),DPPA.stored_value,,source) => true,
			/* otherwise                                                                                    => */ false
			);
	
	end;
end;	