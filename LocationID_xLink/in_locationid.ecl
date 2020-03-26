import LocationId_Ingest;
export in_locationid := project(LocationId_Ingest.files_locationid.DS_Base, 
                                transform(Layout_LocationId,
						                           self.sec_range := if(trim(left.sec_range)='','NOVALUE',left.sec_range),
						                           self.err_stat  := left.err_stat[1];
						                           self := left,
						                           self := []));
