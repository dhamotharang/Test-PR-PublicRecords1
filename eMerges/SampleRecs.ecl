import eMerges;

export SampleRecs(string version) := function

ccw := eMerges.file_ccw_out;
ccw_fath := dataset('~thor_data400::base::emerges_ccw_father', emerges.layout_ccw_out,flat);
ccw_father := sort(distribute(ccw_fath, hash(persistent_record_id)),persistent_record_id, LOCAL);

hunt := eMerges.file_hunters_out; 
hunt_fath := dataset('~thor_data400::base::emerges_hunt_father', emerges.layout_hunters_out,flat);
hunt_father := sort(distribute(hunt_fath, hash(persistent_record_id)),persistent_record_id, LOCAL);

//Join on persistent record id's
emerges.layout_hunters_out hunt_sample(hunt l, hunt_father r) := TRANSFORM
SELF := l;
END;

emerges.layout_ccw_out ccw_sample(ccw l, ccw_father r) := TRANSFORM
SELF := l;
END;

//New Hunting Records Samples
HuntSampleRec := join(hunt, hunt_father,
							left.persistent_record_id = right.persistent_record_id
							,hunt_sample(LEFT,RIGHT)
							,LEFT ONLY
							);

//New CCW Records Samples
CcwSampleRec := join(ccw, ccw_father,
							left.persistent_record_id = right.persistent_record_id
							,ccw_sample(LEFT,RIGHT)
							,LEFT ONLY
							);						
								
                                
sampleout:=  sequential(
                         output(choosen(HuntSampleRec, 1000), named('HuntingFishingSampleRecords'))
							//					,output(choosen(CcwSampleRec, 1000), named('CCWSampleRecords'))
                      );

return sampleout;

end;
                                