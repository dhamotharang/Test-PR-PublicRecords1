export Proc_Certegy_Build_All(string filedate) := function

DoBuild := Certegy.Build_all(filedate);

SampleRecs := choosen(sort(Certegy.Files.certegy_base(       did!=0
								                                         and orig_ssn!='000000000'
																												 and date_vendor_first_reported=filedate
																										 ), record
													), 1000
										  );

retval := sequential(Certegy.SpryInput(filedate)
                             ,DoBuild
                             ,output(SampleRecs, named('SampleRecords'))
                             ) : success(Certegy.Send_Email(filedate).Build_Success) 
														   , failure(Certegy.Send_Email(filedate).Build_Failure);
                                                                             
return retval;
end;