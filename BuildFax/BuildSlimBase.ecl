IMPORT RoxieKeyBuild;
EXPORT BuildSlimBase (string build_date) := FUNCTION
slimContractor 				:= PROJECT (Files.DS_BASE_CONTRACTOR, Layout.CONTRACTOR_SLIM);
slimCorrection 				:= PROJECT (Files.DS_BASE_CORRECTION, Layout.CORRECTION_SLIM);
slimPermit		 				:= PROJECT (Files.DS_BASE_PERMIT, Layout.PERMIT_SLIM);
slimIspection 				:= PROJECT (Files.DS_BASE_INSPECTION, Layout.INSPECTION_SLIM);
slimProperty 					:= PROJECT (Files.DS_BASE_PROPERTY, Layout.PROPERTY_SLIM);
slimPermitContractor 	:= PROJECT (Files.DS_BASE_PERMITCONTRACTOR, Layout.PERMITCONTRACTOR_SLIM);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(slimContractor, FILES.SLIM_BASE_PREFIX_NAME, Constants().contractor, build_date, contractSlimBase, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(slimCorrection, FILES.SLIM_BASE_PREFIX_NAME, Constants().correction, build_date, correctionSlimBase, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(slimPermit, FILES.SLIM_BASE_PREFIX_NAME, Constants().permit, build_date, permitSlimBase, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(slimIspection, FILES.SLIM_BASE_PREFIX_NAME, Constants().inspection, build_date, inspectionSlimBase, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(slimProperty, FILES.SLIM_BASE_PREFIX_NAME, Constants().property, build_date, propertySlimBase, 3, false, true);
RoxieKeyBuild.Mac_SF_BuildProcess_V2(slimPermitContractor, FILES.SLIM_BASE_PREFIX_NAME, Constants().permitcontractor, build_date, permitContractorSlimBase, 3, false, true);

RETURN SEQUENTIAL(contractSlimBase, correctionSlimBase, inspectionSlimBase, permitSlimBase, propertySlimBase, permitContractorSlimBase);
END;