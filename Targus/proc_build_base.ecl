import address, MDR, did_add, didville,ut,header_slimsort,mdr,header, idl_header, PromoteSupers, Scrubs, Scrubs_Targus, _Control, lib_date, tools, std;
export proc_build_base(string versionDate, string emailList='') := function
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Pull Input Data Sample
	dRawFile				:=	Targus.File_Consumer_in;
	dRawFile_Dedup	:=	DEDUP(SORT(DISTRIBUTE(dRawFile),RECORD,LOCAL),RECORD,LOCAL);

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Clean Address using Address Cache
	temp_layout := record
		string temp_address1;
		string temp_address2;
		targus.layout_consumer_In;
	end; 

	temp_layout t_temp(dRawFile_Dedup L) := transform
		self.temp_address1 		:= regexreplace('[  ]+'
									,L.house_number+' '+
									 L.pre_direction+' '+
									 L.street_name+' '+
									 L.street_type+' '+
									 L.post_direction+' '+
									 L.apt_type+' '+
									 L.apt_number,' ');
		self.temp_address2 		:= address.Addr2FromComponents(L.postal_city_name
									,L.state
									,L.z5);
		self 					:= L;
	end;

	p_temp := project(dRawFile_Dedup, t_temp(left)); 

	Address.MAC_Address_Clean(p_temp,temp_address1,temp_address2,true,appndAddr);	

	newfile := appndAddr;					
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	rCleanInput	:=	record
		targus.layout_consumer_In;
		qstring73		CleanName1;
		qstring73		CleanName2;
		qstring182	CleanAddress;	
	end;
		
	string fNameIfValid(string pFirst, string pMiddle, string pLast, string pSuffix)	:=	
		if(pFirst + pMiddle <>'' and pLast + pSuffix <> ''
				,Address.CleanPersonFML73(pFirst + ' ' + pMiddle + ' ' + pLast + ' ' + pSuffix)
				,'');
	 
	rCleanInput	tCleanNames(newfile pInput)	:=	transform
		self.CleanName1	  :=	fNameIfValid(pInput.first_name,pInput.middle_name,pInput.last_name,pInput.last_name_suffix);
		self.CleanName2	  :=	fNameIfValid(pInput.secondary_first_name,pInput.secondary_middle_name,pInput.last_name,pInput.secondary_name_suffix);
		self.CleanAddress :=	(qstring182)pInput.Clean;
		self							:=	pInput;
	end;

	dConsumerInCleaned	:=	PROJECT(newfile, tCleanNames(left));

	rNormalizedName	:=	record
		targus.layout_consumer_In;
		qstring73		CleanName;
		qstring182	CleanAddress;
		string1			rec_type;
		unsigned1		did_score:=0;
	end;

	rNormalizedName tNormalizeName(dConsumerInCleaned pInput, unsigned1 pCounter)	:=	transform
		self.CleanName	:=	choose(pCounter, 	pInput.CleanName1, pInput.CleanName2);
		self.rec_type		:=	choose(pCounter, 	'1', 						'2');
		self						:=	pInput;
	end;

	dNormalize				:=	normalize(dConsumerInCleaned,2,tNormalizeName(left,counter));

	targus.Layout_Consumer_Out_Unfiltered project_Consumer_in(dNormalize pLeft) := TRANSFORM
		DateVendorLastReported				:=	versionDate[1..6];
		self.dt_first_seen						:=	(unsigned3)pLeft.Pubdate;
		self.dt_last_seen							:=	(unsigned3)(pLeft.validation_date[1..6]);
		self.dt_vendor_last_reported	:=	(unsigned3)DateVendorLastReported;
		self.dt_vendor_first_reported	:=	(unsigned3)DateVendorLastReported;
		self.prim_range								:=	pLeft.CleanAddress[1..10];
		self.predir										:=	pLeft.CleanAddress[11..12];
		self.prim_name								:=	pLeft.CleanAddress[13..40];
		self.suffix										:=	pLeft.CleanAddress[41..44];			
		self.postdir									:=	pLeft.CleanAddress[45..46];
		self.unit_desig								:=	pLeft.CleanAddress[47..56];
		self.sec_range								:=	pLeft.CleanAddress[57..64];
		self.city_name								:=	pLeft.CleanAddress[90..114];
		self.st												:=	pLeft.CleanAddress[115..116];
		self.zip											:=	pLeft.CleanAddress[117..121];
		self.zip4											:=	pLeft.CleanAddress[122..125];
		self.county										:=	pLeft.CleanAddress[143..145];
		self.cbsa											:=	pLeft.CleanAddress[167..170] + '0';
		self.geo_blk									:=	pLeft.CleanAddress[171..177];
		self.title										:=	pLeft.CleanName[1..5];
		self.fname										:=	pLeft.CleanName[6..25];
		self.minit										:=	pLeft.CleanName[26..45];
		self.lname										:=	pLeft.CleanName[46..65];
		self.name_suffix							:=	pLeft.CleanName[66..70];
		self													:=	pLeft;  
		self													:=	[]; // For Scrubs Bits
	END;
	 
	dNormalizeProj	:=	project(dNormalize(CleanName<>''), project_Consumer_in(Left));
	// dNormalizeProj	:=	PROJECT(dNormalize, project_Consumer_in(LEFT));
	dNormalizeDist	:=	DISTRIBUTE(dNormalizeProj);
	dNormalizeSort	:=	SORT(dNormalizeDist, RECORD, LOCAL);
	dNormalizeDedup	:=	DEDUP(dNormalizeSort,LOCAL):persist('~persist::dTargusNormalizeDedup');
	
	
//------------Apply Name Flipping Macro--------------------
	ut.mac_flipnames(dNormalizeDedup,fname,minit,lname,names_flipped);
//---------------------------------------------------------

//********************************Apply Scrubs before building the base file***************************
	recordsToScrub						:=	PROJECT(names_flipped,
																	TRANSFORM(Scrubs_Targus.Layout_Targus,
																		SELF:=LEFT));											//	Remove Scrub Bits
	scrubsTargus							:=	Scrubs.ScrubsPlus_PassFile(recordsToScrub,'Targus','Scrubs_Targus','Scrubs_Targus','',versionDate,emailList);
	// Scrubs_Targus.Scrubs;									//	Scrubs Module for Targus Layout
//Apply Scrubs
	// dTargusScrubbedRecords		:=	scrubsTargus.FromNone(recordsToScrub);		//	Generate the Targus error flags
	// dTargusExpandedRecords		:=	scrubsTargus.FromExpanded(dTargusScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
//Generate Some Debug Results
	// ErrorSummary							:=	OUTPUT(dTargusExpandedRecords.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
	// EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dTargusExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
	// SomeErrorValues						:=	OUTPUT(CHOOSEN(dTargusExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values
//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
	// orbitStats								:=	dTargusExpandedRecords.OrbitStats():persist('~persist::targus_scrubs_rpt');	//	Get our stats
//Submits stats to Orbit
	// submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Targus','ScrubsAlerts',orbitStats,versionDate,'Targus').SubmitStats;
//Output Scrubs report with examples in WU
	// dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Targus','ScrubsAlerts',orbitStats,versionDate,'Targus').CompareToProfile_with_examples;
//Send Alerts and Scrubs reports via email 
	// scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
	// scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
  // mailfile									:=	FileServices.SendEmailAttachData(	_Control.MyInfo.EmailAddressNotify
																																	// ,'Scrubs Targus Report Test' //subject
																																	// ,'Scrubs Targus Report Test WU: '+WORKUNIT //body
																																	// ,(data)scrubsAttachment
																																	// ,'text/csv'
																																	// ,'TargusScrubsReport.csv'
																																	// ,
																																	// ,
																																	// ,_Control.MyInfo.EmailAddressNotify);	
// ****************************************************************************************************

	dTargusPostScrubbedRecords	:=	PROJECT(names_flipped,TRANSFORM(RECORDOF(names_flipped),SELF:=LEFT)):persist('~persist::dTargusScrubbed');

	//build consumer hhid
	didville.MAC_HHID_Append_By_Address(dTargusPostScrubbedRecords
										,dNormalizehhid
										,hhid
										,lname
										,prim_range
										,prim_name
										,sec_range
										,st
										,zip)

	//build consumer did

		//add src 
	src_rec := record
		header_slimsort.Layout_Source;
		targus.Layout_Consumer_Out_Unfiltered;
	end;

	DID_Add.Mac_Set_Source_Code(dNormalizehhid, src_rec, 'WP', dNormalizehhid_src)
	
	matchset := ['A','P','Z'];
	did_add.MAC_Match_Flex(dNormalizehhid_src
						   ,matchset
						   ,''
						   ,validate_date
						   ,fname
						   ,minit
						   ,lname
						   ,name_suffix
						   ,prim_range
						   ,prim_name
						   ,sec_range
						   ,zip
						   ,st
						   ,phone_number
						   ,did
						   ,src_rec
						   ,true
						   ,did_score
						   ,75
						   ,consumer_out_src,true,src)

		//	We don't use the File Attribute because it filters out the active=FALSE records
		//	which we want during the build.
	  dOldBaseFile	:=	project(Targus.File_Consumer_Base_Unfiltered, transform(targus.Layout_Consumer_Out_Unfiltered, self.active := false, self.dt_vendor_first_reported := if(left.dt_vendor_first_reported = 200602, 201412, left.dt_vendor_first_reported),self := left));
		newInput := project(consumer_out_src, transform(targus.Layout_Consumer_Out_Unfiltered, self.active := true,  self := left));
	  new_base_s := sort(distribute(dOldBaseFile + newInput, hash(phone_number)), phone_number, record_id, rec_type, first_name, last_name, active, dt_vendor_first_reported, local);
	
	
	targus.Layout_Consumer_Out_Unfiltered	tKeepFirstReportedDate(new_base_s pLeft, new_base_s pRight)	:=	TRANSFORM
		SELF.dt_first_seen							:=	lib_date.EarliestDate(pLeft.dt_first_seen, pRight.dt_first_seen);  
		SELF.dt_last_seen								:=	lib_date.LatestDate(pRight.dt_last_seen,	pLeft.dt_last_seen);
	  SELF.dt_vendor_first_reported		:=	lib_date.EarliestDate(pLeft.dt_vendor_first_reported, pRight.dt_vendor_first_reported);
		SELF.dt_vendor_last_reported		:=	lib_date.LatestDate(pRight.dt_vendor_last_reported,	pLeft.dt_vendor_last_reported);
    SELF.active := if(pRight.active = true, pRight.active, pLeft.active);		
		self := pRight;
		
	END;
	
	dNewBase_Dedup	:=	rollup(new_base_s, tKeepFirstReportedDate(left, right),
											ut.CleanSpacesAndUpper(left.phone_number) = ut.CleanSpacesAndUpper(right.phone_number) and
											ut.CleanSpacesAndUpper(left.record_id) = ut.CleanSpacesAndUpper(right.record_id) and
											ut.CleanSpacesAndUpper(left.rec_type) = ut.CleanSpacesAndUpper(right.rec_type) and
											ut.CleanSpacesAndUpper(left.first_name) = ut.CleanSpacesAndUpper(right.first_name) and
											ut.CleanSpacesAndUpper(left.last_name) = ut.CleanSpacesAndUpper(right.last_name),
									LOCAL
								);

// JIRA DF-16221 - Changes to first/last seen, first/last vendor reported dates to fit Scoring needs
// Dates going to be aggregated to a higher level of granularity: phone, name, address

	//aggregate data at phone, name, address level
dt_tb_ly := record
		dNewBase_Dedup.phone_number;
		dNewBase_Dedup.first_name;
		dNewBase_Dedup.last_name;
		dNewBase_Dedup.house_number;
		dNewBase_Dedup.pre_direction;
		dNewBase_Dedup.street_name;
		dNewBase_Dedup.street_type;
		dNewBase_Dedup.post_direction;
		dNewBase_Dedup.apt_number;
		dNewBase_Dedup.box_number;
		dNewBase_Dedup.state;
		dNewBase_Dedup.z5;
		dNewBase_Dedup.active;
		dNewBase_Dedup.dt_vendor_first_reported;
		dNewBase_Dedup.dt_first_seen; 
		dNewBase_Dedup.dt_last_seen;
		dNewBase_Dedup.dt_vendor_last_reported;
end;

 	dDatesFile	:=	project(dNewBase_Dedup, transform(dt_tb_ly, self := left));
	dDatesFile_s := sort(distribute(dDatesFile, hash(phone_number)),  ut.CleanSpacesAndUpper(phone_number),
																																	ut.CleanSpacesAndUpper(first_name),
																																	ut.CleanSpacesAndUpper(last_name),
																																	ut.CleanSpacesAndUpper(house_number),
																																	ut.CleanSpacesAndUpper(pre_direction),
																																	ut.CleanSpacesAndUpper(street_name),
																																	ut.CleanSpacesAndUpper(street_type),
																																	ut.CleanSpacesAndUpper(post_direction),
																																	ut.CleanSpacesAndUpper(apt_number),
																																	ut.CleanSpacesAndUpper(box_number),
																																	ut.CleanSpacesAndUpper(state),
																																	ut.CleanSpacesAndUpper(z5),
																																	active,
																																	dt_vendor_first_reported,
																																	dt_first_seen, 
																																	dt_last_seen,
																																	dt_vendor_last_reported,
																																	local);

//Rollup dates at phone, name and address levels	
dt_tb_ly	tRollforDate(	dDatesFile_s  pLeft, 	dDatesFile_s  pRight)	:=	TRANSFORM
		self.dt_vendor_first_reported		:=	lib_date.EarliestDate(pLeft.dt_vendor_first_reported, pRight.dt_vendor_first_reported);
		SELF.dt_first_seen							:=	lib_date.EarliestDate(pLeft.dt_first_seen, pRight.dt_first_seen);  
		SELF.dt_last_seen								:=	lib_date.LatestDate(pRight.dt_last_seen,	pLeft.dt_last_seen);
		SELF.dt_vendor_last_reported		:=	lib_date.LatestDate(pRight.dt_vendor_last_reported,	pLeft.dt_vendor_last_reported);
		self := pRight;
		END;
		
	
	dDatesFile_r := rollup(dDatesFile_s , tRollforDate(left, right),
										ut.CleanSpacesAndUpper(LEFT.phone_number)	=	ut.CleanSpacesAndUpper(RIGHT.phone_number)	AND
										ut.CleanSpacesAndUpper(LEFT.first_name)	=	ut.CleanSpacesAndUpper(RIGHT.first_name)	AND
										ut.CleanSpacesAndUpper(LEFT.last_name)	=	ut.CleanSpacesAndUpper(RIGHT.last_name)	AND
										ut.CleanSpacesAndUpper(LEFT.house_number)	=	ut.CleanSpacesAndUpper(RIGHT.house_number)	AND
										ut.CleanSpacesAndUpper(LEFT.pre_direction)	=	ut.CleanSpacesAndUpper(RIGHT.pre_direction)	AND
										ut.CleanSpacesAndUpper(LEFT.street_name)	=	ut.CleanSpacesAndUpper(RIGHT.street_name)	AND
										ut.CleanSpacesAndUpper(LEFT.street_type)	=	ut.CleanSpacesAndUpper(RIGHT.street_type)	AND
										ut.CleanSpacesAndUpper(LEFT.post_direction)	=	ut.CleanSpacesAndUpper(RIGHT.post_direction)	AND
										ut.CleanSpacesAndUpper(LEFT.apt_number)	=	ut.CleanSpacesAndUpper(RIGHT.apt_number)		AND
										ut.CleanSpacesAndUpper(LEFT.box_number)	=	ut.CleanSpacesAndUpper(RIGHT.box_number)	AND
										ut.CleanSpacesAndUpper(LEFT.state)	=	ut.CleanSpacesAndUpper(RIGHT.state)	AND
										ut.CleanSpacesAndUpper(LEFT.z5)	=	ut.CleanSpacesAndUpper(RIGHT.z5), local);	
										
	//Append new dates to base file						
	targus.Layout_Consumer_Out_Unfiltered tAssignDates (dNewBase_Dedup pLeft, 	dDatesFile_r pRight) := transform
			self.dt_vendor_first_reported		:=	pRight.dt_vendor_first_reported;
		  SELF.dt_first_seen							:=	pRight.dt_first_seen;  
		  SELF.dt_last_seen								:=	pRight.dt_last_seen;
		  SELF.dt_vendor_last_reported		:=	pRight.dt_vendor_last_reported;
		  self := pLeft;
	end;
	
dNewBase_final := join(distribute(dNewBase_Dedup, hash(phone_number)), 	dDatesFile_r ,
	                  ut.CleanSpacesAndUpper(LEFT.phone_number)	=	ut.CleanSpacesAndUpper(RIGHT.phone_number)	AND
										ut.CleanSpacesAndUpper(LEFT.first_name)	=	ut.CleanSpacesAndUpper(RIGHT.first_name)	AND
										ut.CleanSpacesAndUpper(LEFT.last_name)	=	ut.CleanSpacesAndUpper(RIGHT.last_name)	AND
										ut.CleanSpacesAndUpper(LEFT.house_number)	=	ut.CleanSpacesAndUpper(RIGHT.house_number)	AND
										ut.CleanSpacesAndUpper(LEFT.pre_direction)	=	ut.CleanSpacesAndUpper(RIGHT.pre_direction)	AND
										ut.CleanSpacesAndUpper(LEFT.street_name)	=	ut.CleanSpacesAndUpper(RIGHT.street_name)	AND
										ut.CleanSpacesAndUpper(LEFT.street_type)	=	ut.CleanSpacesAndUpper(RIGHT.street_type)	AND
										ut.CleanSpacesAndUpper(LEFT.post_direction)	=	ut.CleanSpacesAndUpper(RIGHT.post_direction)	AND
										ut.CleanSpacesAndUpper(LEFT.apt_number)	=	ut.CleanSpacesAndUpper(RIGHT.apt_number)		AND
										ut.CleanSpacesAndUpper(LEFT.box_number)	=	ut.CleanSpacesAndUpper(RIGHT.box_number)	AND
										ut.CleanSpacesAndUpper(LEFT.state)	=	ut.CleanSpacesAndUpper(RIGHT.state)	AND
										ut.CleanSpacesAndUpper(LEFT.z5)	=	ut.CleanSpacesAndUpper(RIGHT.z5),
										tAssignDates(left, right),
										keep(1),
										left outer,										
										local);
	
	
	dNewBase_Dedup_ := dNewBase_Dedup;
	dFilteredBase		:=	PROJECT(dNewBase_final(Active=TRUE),TRANSFORM(Targus.Layout_Consumer_out,                                                                  
																																		SELF.global_sid := 0;  //Added for CCPA-6 - Targus has a single source and sid retrieval function not yet available
																																		SELF.record_sid := 0;
	                                                                  SELF            := LEFT)
														 );
	
	addGSFiltered		:= MDR.macGetGlobalSid(dFilteredBase,'Targus','','global_sid'); //Add Global_SID
	
	PromoteSupers.MAC_SF_BuildProcess(dNewBase_Dedup_,'~thor_data400::base::consumer_targus_unfiltered',buildBase,3,,TRUE); // Compressed
  PromoteSupers.MAC_SF_BuildProcess(addGSFiltered,'~thor_data400::base::consumer_targus',buildFilteredBase,3,,TRUE);

	RETURN SEQUENTIAL (
		// OUTPUT(dScrubsWithExamples, ALL, NAMED('TargusScrubsReportWithExamples')),
		// Send Alerts if Scrubs exceeds threholds
		// IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No Targus Scrubs Alerts')),	
		// output Scrubs Report
		// ErrorSummary,
		// EyeballSomeErrors,
		// SomeErrorValues,
		scrubsTargus,
		buildBase,
		buildFilteredBase
	);
	
END;