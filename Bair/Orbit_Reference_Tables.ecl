EXPORT Orbit_Reference_Tables := MODULE

rcOrbitMember := RECORD
	STRING  MemberId;	
  STRING  ContributorID;
  STRING  AgencyName;
	STRING  BuildPrefix;
END;

EXPORT rfOrbitMember := DATASET([ 
{'0001','B0001','Bair','bair'} 
],rcOrbitMember);

rcOrbitDataSet := RECORD
  STRING  FileNameRoot;
  STRING  FileSourceID;
	STRING  MemberId;	
END;

EXPORT rfOrbitDataset := DATASET([ 
																	{'cfs.dbo.agencycfstypelookup','1','0001'},
																	{'cfs.dbo.cfs_2','1','0001'},
																	{'cfs.dbo.cfs_officers_2','1','0001'},
																	{'crash.dbo.crash','1','0001'},
																	{'crash.dbo.person','1','0001'},
																	{'crash.dbo.vehicle','1','0001'},
																	{'event.dbo.agencycrimetypelookup','1','0001'},
																	{'event.dbo.data_provider','1','0001'},
																	{'event.dbo.data_provider_import','1','0001'},
																	{'event.dbo.data_provider_location','1','0001'},
																	{'event.dbo.mo','1','0001'},
																	{'event.dbo.mo_udf','1','0001'},
																	{'event.dbo.persons','1','0001'},
																	{'event.dbo.persons_udf','1','0001'},
																	{'event.dbo.vehicle','1','0001'},
																	{'event.import.group_access','1','0001'},
																	{'gunop.dbo.shot_incident','1','0001'},
																	{'intel.dbo.entity','1','0001'},
																	{'intel.dbo.entity_notes','1','0001'},
																	{'intel.dbo.entity_photo','1','0001'},
																	{'intel.dbo.incident','1','0001'},
																	{'intel.dbo.incident_notes','1','0001'},
																	{'intel.dbo.reporting_officer','1','0001'},
																	{'intel.dbo.vehicle_notes','1','0001'},
																	{'lpr.dbo.licenseplateevent','1','0001'},
																	{'offenders.dbo.classification','1','0001'},
																	{'offenders.dbo.offender','1','0001'},
																	{'offenders.dbo.offender_classification','1','0001'},
																	{'offenders.dbo.offender_picture','1','0001'},
																	{'offenders.dbo.person','1','0001'},
																	{'lpr.dbo.nightlyLPRDeletes','1','0001'},
																	{'agency_removed.dbo.agency_deletes','1','0001'}
																],rcOrbitDataset);
						

rcBuildStatus := RECORD
  STRING  paramStatus;
  STRING  statusType;
END;

EXPORT rfBuildStatus := DATASET([ 
																	 {'New','Status'},
																	 {'BuildInProgress','Status'},
																	 {'Quarantine','Status'},
																	 {'Built','Status'},
																	 {'Spraying','SubStatus'},									 
																	 {'Sprayed','SubStatus'},									 									 
																	 {'CreatingKeys','SubStatus'},									 									 
																	 {'KeysCreated','SubStatus'},									 									 									 
																	 {'Deploying','SubStatus'},									 									 									 
																	 {'Deployed','SubStatus'},									 									 									 
																	 {'CreatingKeys','SubStatus'},									 									 									 
																	 {'Failed QA','Status'}									 
									              ],rcBuildStatus);


rcReceiveStatus := RECORD
  STRING  paramStatus;
  STRING  statusType;
END;

EXPORT rfReceiveStatus := DATASET([ 
																	 {'Received','Status'},
																	 {'Loaded','Status'},
																	 {'Reformatted','Status'},
																	 {'Failed','Status'},
																	 {'Sprayed','Status'},
																	 {'Built','Status'},									 
																	 {'KeysCreated','Status'},									 									 
																	 {'CreatingKeys','SubStatus'},									 									 
																	 {'Spraying','SubStatus'}									 									 									 
																	],rcReceiveStatus);

END;