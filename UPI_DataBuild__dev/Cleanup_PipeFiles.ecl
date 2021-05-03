import versioncontrol, _control, ut, tools, UPI_DataBuild__dev;

EXPORT Cleanup_PipeFiles (string gcid, string pBatch_JobID) := FUNCTION

		cleanupPipeFiles				:= sequential(
																					FileServices.DeleteLogicalFile('~ushc::crk::' + trim(gcid, all) + '_' + trim(pBatch_jobID, all) + '_metrics'),
																					FileServices.DeleteLogicalFile('~ushc::crk::' + trim(gcid, all) + '_' + trim(pBatch_jobID, all) + '_out_tobatch'),
																					FileServices.DeleteLogicalFile('~ushc::crk::' + trim(gcid, all) + '_' + trim(pBatch_jobID, all) + '_linkhistory'),
																					FileServices.DeleteLogicalFile('~ushc::crk::' + trim(gcid, all) + '_' + trim(pBatch_jobID, all) + '_aggregate'));
		
		RETURN cleanupPipeFiles;
END;