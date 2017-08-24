import _control, versioncontrol,ut;

export Build_Base(
	 string														pversion
	,boolean													pUseProd			= false
	,boolean 													pDelta 				= false				
) :=
module
   
 base:=if(pDelta,Update_Base(pversion,pUseProd,true),Update_Base(pversion,pUseProd,false));

ut.MAC_SF_BuildProcess(base,'~thor400_data::base::composite_public_safety_data'+if(pDelta,'_delta','_full'), out_composite,2,,true,pVersion:=pversion);

export All := sequential(
					out_composite
				,Bair_composite.Sequence_Flag.fn_SetSequenceFlag(pversion,pDelta))

;																													

end;
