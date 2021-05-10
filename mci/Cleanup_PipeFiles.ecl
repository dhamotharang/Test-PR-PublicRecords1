import versioncontrol, _control, ut, tools, MCI;

EXPORT Cleanup_PipeFiles (string gcid, string pBatch_JobID) := FUNCTION

		cleanupPipeFiles				:= sequential(
																					FileServices.DeleteLogicalFile('~usgv::mci::' + trim(gcid, all) + '_' + trim(pBatch_jobID, all) + '_metrics'),
																					FileServices.DeleteLogicalFile('~usgv::mci::' + trim(gcid, all) + '_' + trim(pBatch_jobID, all) + '_out_tobatch'),
																					FileServices.DeleteLogicalFile('~usgv::mci::' + trim(gcid, all) + '_' + trim(pBatch_jobID, all) + '_linkhistory'),
																					FileServices.DeleteLogicalFile('~usgv::mci::' + trim(gcid, all) + '_' + trim(pBatch_jobID, all) + '_aggregate'));
		
		RETURN cleanupPipeFiles;
END;