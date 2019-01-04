#workunit('name', 'Infutor Email Base Build');
#OPTION('multiplePersistInstances', FALSE);

IMPORT	Infutor_NARE
				, ut
				, AID
				, DID_Add
				, address
				, lib_StringLib
				,	NID
				, STD
				,	Scrubs
				, Scrubs_Infutor_NARE_Base
				, Orbit3SOA
				, SALT30
				,	PromoteSupers;

EXPORT proc_build_base(STRING version) := FUNCTION

 prep_layout := Infutor_NARE.layouts.prepped;
 dsInputPrep := DATASET('~thor_data400::in::email::infutor_email_clean',prep_layout,thor);
 dsBase := Infutor_NARE.file_base;

 //For clean address lookup only
 cln_addr_base := dataset('~thor_data400::base::email::infutor_email_clnaddr',Infutor_NARE.layouts.slim_address,thor);
 
  //clean fields to remove unprintable characters
 ut.CleanFields(dsInputPrep, dsInputPrepClean);
 
 //Clean fields
 Infutor_NARE.layouts.Cleaned tFormatInfutorFields(prep_layout pInput) := TRANSFORM
			tmpLastName			:= Infutor_NARE.fn_clean_name.fStripNickName(pInput.LastName);
			tmpFirstName		:= Infutor_NARE.fn_clean_name.fStripNickName(pInput.FirstName);
			SELF.LastName		:= IF(trim(pInput.LastName) = '','',tmpLastName);
			SELF.FirstName	:= IF(trim(pInput.FirstName) = '','',tmpFirstName);
			SELF.MiddleName := IF(trim(pInput.MiddleName) = '','',pInput.MiddleName);
			SELF.Suffix			:= IF(trim(pInput.Suffix) = '','',pInput.Suffix);
			SELF.ZipCode		:= IF(pInput.ZipCode = '00000','',pInput.ZipCode);
			SELF.ZipPlus4		:= IF(pInput.ZipPlus4 = '0000','',pInput.ZipPlus4);
			SELF.Phone			:= pInput.clean_phone1;
			SELF.Phone2			:= pInput.clean_phone2;
			SELF.Email			:= stringlib.stringcleanspaces(StringLib.StringFindReplace(pInput.append_cln_email,'NOTSUPPLIED!',''));
			SELF.DateFirstSeen := stringlib.stringcleanspaces(REGEXREPLACE('[^0-9]',pInput.DateFirstSeen,''));
			SELF.DateLastSeen  := stringlib.stringcleanspaces(REGEXREPLACE('[^0-9]',pInput.DateLastSeen,''));
			SELF.FileDate 		 := stringlib.stringcleanspaces(REGEXREPLACE('[^0-9]',pInput.FileDate,''));
			SELF.Age				:= stringlib.stringcleanspaces(REGEXREPLACE('[^0-9]',pInput.Age,''));
			SELF							:=	pInput;
			SELF							:=	[];
	END;
	
	cln_raw_input := project(dsInputPrepClean,tFormatInfutorFields(left));
											
		//Remove records with blank names prior to processing
	f_blank := cln_raw_input(trim(firstname,all) != '' AND trim(lastname,all) != '') : persist('~thor_data400::persist::email::infutor_pre_nid');
	
	//Clean input name	
	NID.Mac_CleanParsedNames(f_blank, FileClnName, 
													firstname:=FirstName, lastname:=LastName, middlename := MiddleName, namesuffix := Suffix
													,includeInRepository:=true, normalizeDualNames:=false, useV2 := true);
	
//Project to base layout, prep for Clean Address, add date fields 
	month_pattern := '(^JAN |FEB |MAR |APR |MAY |JUN |JUL |AUG |SEP |SEPT |OCT |NOV |DEC |MON |TUE |WED |THU |FRI )';

	Infutor_NARE.layouts.Base_new tProjectAIDClean_prep(FileClnName pInput) := TRANSFORM
			self.clean_title				:=	pInput.cln_title;
			self.clean_fname				:=	pInput.cln_fname;
			self.clean_mname				:=	pInput.cln_mname;
			self.clean_lname				:=	pInput.cln_lname;
			self.clean_name_suffix	:=	pInput.cln_suffix;
			tempStreetName					:= Infutor_NARE.fn_clean_name.strippunctMiscAddr(REGEXREPLACE('^(.*)PO BOX',pInput.StreetName,'PO BOX'));
			tempPreDir							:= REGEXREPLACE('[^a-zA-Z]',pInput.StreetPreDir,' ');
			tempStrSuffix						:= REGEXREPLACE('[^a-zA-Z]',pInput.StreetSuffix,' ');
			tempPostDir							:= REGEXREPLACE('[^a-zA-Z]',pInput.StreetPostDir,' ');
			tempAptNum							:= REGEXREPLACE('[^a-zA-Z0-9_]',pInput.AptNum,' ');
			tempAptType							:= IF(StringLib.stringfind(pInput.AptType,'#',1)>0,pInput.AptType,REGEXREPLACE('[^a-zA-Z]',pInput.AptType,''));
			tempCity								:= REGEXREPLACE('[^a-zA-Z]',pInput.city,' ');
			clnFullAddr	:= StringLib.StringCleanSpaces(IF(pInput.StreetNum <> '',trim(REGEXREPLACE('^0+',pInput.StreetNum,''),left,right)+' ','')+
																								 IF(pInput.StreetPreDir <> '',trim(tempPreDir,left,right)+' ','')+
																								 IF(pInput.StreetName <> '',trim(tempStreetName,left,right)+' ','')+
																								 IF(pInput.StreetSuffix <> '',trim(tempStrSuffix,left,right)+' ','')+
																								 IF(pInput.StreetPostDir <> '',trim(tempPostDir,left,right)+' ','')+
																								 IF(pInput.AptType <> '',trim(tempAptType,left,right)+' ','')+
																								 IF(pInput.AptNum <> '',trim(tempAptNum,left,right),''));
				ClnAddrLine2	:= StringLib.StringCleanSpaces(trim(tempCity,left,right)
																										+	IF(trim(tempCity) <> '',', ','')
																										+ trim(pInput.state,left,right)
																										+	' ' + trim(pInput.zipcode,left,right) 
																										+trim(pInput.ZipPlus4,left,right));
			tempPrep_Address_Situs		:= IF(REGEXFIND(month_pattern,clnFullAddr),'',
																			StringLib.StringCleanSpaces(StringLib.StringFindReplace(clnFullAddr,'NULL',' ')));
			self.Append_Prep_Address_Situs			:=	Address.fn_addr_clean_prep(tempPrep_Address_Situs, 'first');
			self.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(ClnAddrLine2, 'last');
			self.DID              						:=	0;
			self.RawAID												:=	0;
			self.Process_Date 								:=	thorlib.wuid()[2..9];
			self.date_first_seen							:=  pInput.DateFirstSeen;
			self.date_last_seen								:=  pInput.DateLastSeen;
			self.Date_Vendor_First_Reported 	:=	version[1..8];
			self.Date_Vendor_Last_Reported 		:=	version[1..8];
			self.current_rec_flag	:= 'C';
			self							:=	pInput;
			self							:=	[];
	END;
	
	d_clnbase	:= project(FileClnName, tProjectAIDClean_prep(left));

//Remove records with blank(non-cleaned) names prior to processing
	filter_blank := d_clnbase(trim(clean_fname,all) != '' and trim(clean_lname,all) != '');
	
//Append Record ID
	Infutor_NARE.layouts.Base_new appendRecID(filter_blank pInput) := TRANSFORM
		self.persistent_record_id := HASH64(TRIM(pInput.FirstName)
																				+TRIM(pInput.MiddleName)[1]
																				+TRIM(pInput.LastName)
																				+TRIM(pInput.DOB)
																				+TRIM(pInput.city)
																				+TRIM(pInput.state)
																				+TRIM(pInput.ZipCode)
																				+TRIM(pInput.Phone)
																				+TRIM(pInput.email));
		self :=	pInput;
	END;
	
	f_recordID := project(filter_blank,appendRecID(left))  : persist('~thor_data400::persist::email::infutor_pre_clnAddr');
	
	//Only run records with address through the cleaner
		WithAddress := f_recordID(trim(Append_Prep_Address_Situs,left,right) <> '' OR trim(Append_Prep_Address_Last_Situs,left,right) <> '');
		NoAddress := f_recordID(trim(Append_Prep_Address_Situs,left,right) = '' AND trim(Append_Prep_Address_Last_Situs,left,right) = '');

	//Check against previously cleaned addresses prior to running through address cleaner
		dist_dsClnAddr := sort(distribute(cln_addr_base,Hash64(Append_Prep_Address_Situs,Append_Prep_Address_Last_Situs)),Append_Prep_Address_Situs,Append_Prep_Address_Last_Situs,local);
		dist_PreClean	 := sort(distribute(WithAddress,Hash64(Append_Prep_Address_Situs,Append_Prep_Address_Last_Situs)),Append_Prep_Address_Situs,Append_Prep_Address_Last_Situs,email,skew(1),local);

		Infutor_NARE.layouts.Base_new XformAddrJoin(dist_PreClean L,dist_dsClnAddr R) := TRANSFORM
				SELF.clean_prim_range  	:=  R.clean_prim_range;
				SELF.clean_predir  			:=  R.clean_predir;
				SELF.clean_prim_name  	:=  R.clean_prim_name;
				SELF.clean_addr_suffix  :=  R.clean_addr_suffix;
				SELF.clean_postdir  		:=  R.clean_postdir;
				SELF.clean_unit_desig  	:=  R.clean_unit_desig;
				SELF.clean_sec_range  	:=  R.clean_sec_range;
				SELF.clean_p_city_name  :=  R.clean_p_city_name;
				SELF.clean_v_city_name  :=  R.clean_v_city_name;
				SELF.clean_st  					:=  R.clean_st;
				SELF.clean_zip  				:=  R.clean_zip;
				SELF.clean_zip4  				:=  R.clean_zip4;
				SELF.clean_cart  				:=  R.clean_cart;
				SELF.clean_cr_sort_sz  	:=  R.clean_cr_sort_sz;
				SELF.clean_lot  				:=  R.clean_lot;
				SELF.clean_lot_order  	:=  R.clean_lot_order;
				SELF.clean_dbpc  				:=  R.clean_dbpc;
				SELF.clean_chk_digit  	:=  R.clean_chk_digit;
				SELF.clean_rec_type  		:=  R.clean_rec_type;
				SELF.clean_county  			:=  R.clean_county;
				SELF.clean_geo_lat  		:=  R.clean_geo_lat;
				SELF.clean_geo_long  		:=  R.clean_geo_long;
				SELF.clean_msa  				:=  R.clean_msa;
				SELF.clean_geo_blk  		:=  R.clean_geo_blk;
				SELF.clean_geo_match  	:=  R.clean_geo_match;
				SELF.clean_err_stat  		:=  R.clean_err_stat;		
				SELF  									:= L;		
	END;	
	
	j_PreCleanAddr := join(dist_PreClean, dist_dsClnAddr,
												LEFT.Append_Prep_Address_Situs = RIGHT.Append_Prep_Address_Situs AND
												LEFT.Append_Prep_Address_Last_Situs = RIGHT.Append_Prep_Address_Last_Situs,
												XformAddrJoin(left,right),left outer,lookup,nosort,local);

//Only clean records that haven't previously been cleaned
	PrevCleanAddr := j_PreCleanAddr(TRIM(clean_err_stat) <> '');
	NewAddr	:= j_PreCleanAddr(TRIM(clean_err_stat) = '');
	
	Infutor_NARE.layouts.Base_new tProjectAddrClean(NewAddr pInput) := TRANSFORM
		cl_addr			:= Address.CleanAddress182(pInput.Append_Prep_Address_Situs, pInput.Append_Prep_Address_Last_Situs);
		SELF.clean_prim_range  	:=  cl_addr[1..10];
		SELF.clean_predir  			:=  cl_addr[11..12];
		SELF.clean_prim_name  	:=  cl_addr[13..40];
		SELF.clean_addr_suffix  :=  cl_addr[41..44];
		SELF.clean_postdir  		:=  cl_addr[45..46];
		SELF.clean_unit_desig  	:=  cl_addr[47..56];
		SELF.clean_sec_range  	:=  cl_addr[57..64];
		SELF.clean_p_city_name  :=  cl_addr[65..89];
		SELF.clean_v_city_name  :=  cl_addr[90..114];
		tempCleanSt							:=  cl_addr[115..116];
		SELF.clean_st  					:=  If(trim(tempCleanSt) = '' and trim(pInput.state) IN valid_states,trim(pInput.state),tempCleanSt);
		SELF.clean_zip  				:=  cl_addr[117..121];
		SELF.clean_zip4  				:=  cl_addr[122..125];
		SELF.clean_cart  				:=  cl_addr[126..129];
		SELF.clean_cr_sort_sz  	:=  cl_addr[130];
		SELF.clean_lot  				:=  cl_addr[131..134];
		SELF.clean_lot_order  	:=  cl_addr[135];
		SELF.clean_dbpc  				:=  cl_addr[136..137];
		SELF.clean_chk_digit  	:=  cl_addr[138];
		SELF.clean_rec_type  		:=  cl_addr[139..140];
		SELF.clean_county  			:=  cl_addr[141..145];
		SELF.clean_geo_lat  		:=  cl_addr[146..155];
		SELF.clean_geo_long  		:=  cl_addr[156..166];
		SELF.clean_msa  				:=  cl_addr[167..170];
		SELF.clean_geo_blk  		:=  cl_addr[171..177];
		SELF.clean_geo_match  	:=  cl_addr[178];
		SELF.clean_err_stat  		:=  cl_addr[179..182];		
    SELF  									:= pInput;		
	END;	
	
	CleanNewAddr := PROJECT(NewAddr, tProjectAddrClean(LEFT));
	
//Combine and sort Previously cleaned records and new records prior to dedup
	CombineClnRecs := PrevCleanAddr + CleanNewAddr;
	srt_All := sort(distribute(CombineClnRecs,hash64(email,clean_fname,clean_mname,clean_lname)),email,clean_fname,clean_mname,clean_lname,local);
	dedupClnRecs := dedup(srt_All, except clean_geo_lat, clean_geo_long);

//Combine ClnAddr records with NoAddr records for DID 
	CombineAll := dedupClnRecs + NoAddress : persist('~thor_data400::persist::email::infutor_email_PreDID');
		
//Flip names before DID process
	ut.mac_flipnames(CombineAll,clean_fname,clean_mname,clean_lname,rsCleanFlipNames);

	matchset :=['A','P','Z'];

	did_Add.MAC_Match_Flex(rsCleanFlipNames, matchset,
													foo, foo, clean_fname, clean_mname, clean_lname, clean_name_suffix, 
													clean_prim_range, clean_prim_name, clean_sec_range, clean_zip, clean_st, Phone,
													DID,   			
													Infutor_NARE.layouts.Base_new, 
													true, DID_score,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													rsClean_DID);
	
	f_NewUpdate:= rsClean_DID : persist('~thor_data400::persist::email::infutor_pre_rollup');
	
	//slim clean address records for new lookup file output
	d_NewAddress := project(dedupClnRecs(trim(clean_prim_range+clean_prim_name+clean_sec_range+clean_st) <> '')
														,transform(Infutor_NARE.layouts.slim_address, SELF := LEFT));
	
	//Append address from current build to previous address file
	CombineAddress := cln_addr_base + d_NewAddress;
	
	//Dedup to ensure only unique address records exist in clean address lookup file
	srt_address := sort(CombineAddress,Append_Prep_Address_Situs,Append_Prep_Address_last_Situs);
	dedup_NewAddress := dedup(srt_address,clean_prim_range,clean_prim_name,clean_sec_range,clean_st,clean_Zip);
	
	PromoteSupers.mac_sf_buildprocess(dedup_NewAddress,Infutor_NARE.thor_cluster+'base::email::infutor_email_clnAddr',buildnewaddrfile,2,,true);
	
	//Rollup process	
	BOOLEAN basefileexists	:=	nothor(fileservices.GetSuperFileSubCount('~thor_data400::base::email::infutor_email_base')) > 0;
	
	//Remove current record flag for existing base file - only current records from build will have flag set
	ResetBaseRecFlag := IF(basefileexists,project(dsbase,transform(Infutor_NARE.layouts.Base_new,SELF.current_rec_flag := ''; SELF:=LEFT)));
	NewBaseIn	:=	IF(basefileexists, f_NewUpdate + ResetBaseRecFlag, f_NewUpdate);
	
	BaseDist	:=	SORT(DISTRIBUTE(NewBaseIn, HASH(clean_fname,clean_mname[1],clean_lname))
									,clean_fname,clean_mname[1],clean_lname,clean_prim_range,clean_prim_name,clean_sec_range,clean_st,clean_Zip
									,email,-Date_Vendor_Last_Reported,LOCAL);
															
	Infutor_NARE.layouts.Base_new  rollupXform(Infutor_NARE.layouts.Base_new L, Infutor_NARE.layouts.Base_new R) := transform
		self.Process_Date    := if(L.Process_Date > R.Process_Date, L.Process_Date, R.Process_Date);
		self.date_first_seen := if(L.date_first_seen > R.date_first_seen, R.date_first_seen, L.date_first_seen);
		self.date_last_seen  := if(L.date_last_seen  < R.date_last_seen,  R.date_last_seen, L.date_last_seen);
		self.Date_Vendor_First_Reported := if(L.Date_Vendor_First_Reported > R.Date_Vendor_First_Reported, R.Date_Vendor_First_Reported, L.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(L.Date_Vendor_Last_Reported  < R.Date_Vendor_Last_Reported,  R.Date_Vendor_Last_Reported, L.Date_Vendor_Last_Reported);
		self.IDNum						:= IF(L.IDNum = '',R.IDNum,L.IDNum);
		self.DOB							:= IF(L.dob = '',R.dob,L.dob);
		self.clean_title				:=	IF(L.clean_title = '',R.clean_title,L.clean_title);
		self.clean_fname				:=	IF(L.clean_fname = '',R.clean_fname,L.clean_fname);
		self.clean_mname				:=	IF(L.clean_mname = '',R.clean_mname,L.clean_mname);
		self.clean_lname				:=	IF(L.clean_lname = '',R.clean_lname,L.clean_lname);
		self.clean_name_suffix	:=	IF(L.clean_name_suffix = '',R.clean_name_suffix,L.clean_name_suffix);
		self.current_rec_flag				:= IF(L.current_rec_flag = 'C','C','');
		self := L; 
	end;
															
	//Roll it up
	BaseRollup := rollup(BaseDist,rollupXform(LEFT,RIGHT),
																		LEFT.clean_fname = RIGHT.clean_fname
																		AND LEFT.clean_mname[1] = RIGHT.clean_mname[1]
																		AND LEFT.clean_lname = RIGHT.clean_lname
																		AND LEFT.clean_prim_range = RIGHT.clean_prim_range
																		AND LEFT.clean_prim_name = RIGHT.clean_prim_name
																		AND LEFT.clean_sec_range = RIGHT.clean_sec_range
																		AND LEFT.clean_st = RIGHT.clean_st
																		AND LEFT.clean_Zip = RIGHT.clean_Zip
																		AND LEFT.email = RIGHT.email, LOCAL);

//Run SCRUBS to validate data prior to final output
	F := BaseRollup;
	P := project(F, Infutor_NARE.layouts.base_new);
	S :=Scrubs_Infutor_NARE_Base.Scrubs; // My scrubs module
	N := S.FromNone(P); // Generate the error flags

	U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
	Orbit_st := U.OrbitStats() : persist('~persist::NARE_orbit_stats');

//Submits Profile's stats to Orbit
	submit_stats :=	Scrubs.OrbitProfileStats('Scrubs_Infutor_NARE_Base',, Orbit_st, version).SubmitStats;

//Output Scrubs report with examples in WU
	Scrubs_report := Scrubs.OrbitProfileStats('Scrubs_Infutor_NARE_Base',, Orbit_st, version).CompareToProfile_with_examples;
	
//Send Alerts and Scrubs reports via email 
	Scrubs_alert := Scrubs_report(RejectWarning = 'Y');
	attachment := Scrubs.fn_email_attachment(Scrubs_alert);
  mailfile := FileServices.SendEmailAttachData('shannon.skumanich@lexisnexis.com'
																						,'Scrubs Infutor NARE Base Report' //subject
																						,'Scrubs Infutor NARE Base Report '+ WORKUNIT //body
																						,(data)attachment
																						,'text/csv'
																						,'ScrubsReportInf.csv'
																						,
																						,
																						,'shannon.skumanich@lexisnexis.com');	
  //append bitmap to base
	dbuildbase := project(N.BitmapInfile, transform(Infutor_NARE.layouts.Scrubs, self := left));
	
	//Final base file output including scrubbits appended to end of base file
	PromoteSupers.MAC_SF_BuildProcess(dbuildbase,'~thor_data400::base::email::infutor_email_base',NAREBaseFile,3,,true);
	
	RETURN sequential(buildnewaddrfile
										,submit_stats
										,output(Scrubs_report, all, named('ScrubsReportExamples'))
									//Send Alerts if Scrubs exceeds threholds
										,if(count(Scrubs_alert) > 1, mailfile, output('No_Scrubs_Alerts'))
										,NAREBaseFile);

END;