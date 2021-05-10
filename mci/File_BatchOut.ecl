EXPORT File_BatchOut(string Batch_JobID, string gcid) := dataset('~usgv::mci::out_tobatch::'+Batch_JobID+'::'+gcid,
						MCI.Layouts_V2.from_batch, csv(heading(1),separator('|'),terminator('\n'),quote('\"'))):INDEPENDENT;
