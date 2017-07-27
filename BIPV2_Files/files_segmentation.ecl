import BIPV2_PostProcess;
EXPORT files_segmentation := module

	EXPORT DS_PROXSEG_BASE   				:= BIPV2_PostProcess.Files().ProxidSegs.qa;
	EXPORT DS_PROXSEG_FATHER   			:= BIPV2_PostProcess.Files().ProxidSegs.father;
	EXPORT DS_PROXSEG_GRANDFATHER		:= BIPV2_PostProcess.Files().ProxidSegs.grandfather;

	EXPORT DS_SELESEG_BASE   				:= BIPV2_PostProcess.Files().SELEidSegs.qa;
	EXPORT DS_SELESEG_FATHER   			:= BIPV2_PostProcess.Files().SELEidSegs.father;
	EXPORT DS_SELESEG_GRANDFATHER		:= BIPV2_PostProcess.Files().SELEidSegs.grandfather;

	EXPORT DS_ORGSEG_BASE   				:= BIPV2_PostProcess.Files().ORGidSegs.qa;
	EXPORT DS_ORGSEG_FATHER   			:= BIPV2_PostProcess.Files().ORGidSegs.father;
	EXPORT DS_ORGSEG_GRANDFATHER		:= BIPV2_PostProcess.Files().ORGidSegs.grandfather;
  	

end;