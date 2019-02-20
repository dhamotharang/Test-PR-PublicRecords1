import ut, autostandardi, batchservices, DeathV2_Services,Ingenix_NatlProf,
Suppress, doxie_files, doxie, BankruptcyV3, LiensV2, dea, Codes, CNLD_Practitioner, CNLD_Facilities;

string26 alphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

string nameFromComponentsLFM(string fname,string mname,string lname,string name_suffix) :=
  IF(lname<>'',trim(lname)+', ','')+IF(fname<>'',trim(fname)+' ','')+IF(mname<>'',trim(mname)+' ','')+trim(name_suffix);

SearchPoint_Services.Layouts.practitioner.batchService.layout_in file_inSearchPointBatchMaster(BOOLEAN forceSeq = FALSE) := function 
 
	rec := SearchPoint_Services.Layouts.practitioner.batchService.layout_in;
	raw1 := DATASET([], rec) : STORED('batch_in', FEW);
	raw0 := raw1 : GLOBAL;
	
	rec tra(rec l) := TRANSFORM
		SELF.max_results := if( (UNSIGNED8) l.max_results > 0, l.max_results, '500');
		SELF := l;
	end;
	raw := PROJECT(raw0, tra(LEFT));
	
	ut.MAC_Sequence_Records(raw, seq, raw_seq)
		dea_file := IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);				
	return dea_file;
	
end;	

	SearchPoint_Services.Layouts.Practitioner.batchService.layout_out_batch
	          practitioner_make_flat(SearchPoint_services.Layouts.Practitioner.batchService.layout_out le,
								                        DATASET(SearchPoint_services.Layouts.Practitioner.batchService.layout_out) allRows) :=
       TRANSFORM
				self.acctno                       :=  le.acctno;
			  self.IMS_DEA                   		:= allrows[1].dea_number;
			  self.gennum                       := if (allrows[1].gennum <> '', allrows[1].gennum, if(allrows[1].did<>0,(string) allrows[1].did,''));
			  self.Practitioner_Name            := allrows[1].Practitioner_Name;
			  self.Area_of_Practice             := allrows[1].Area_of_Practice;
				self.Practitioner_sched           := allrows[1].Practitioner_sched;
				self.Practitioner_zip3            := allrows[1].Practitioner_zip3;
				self.Practitioner_DEA_Active_Flg  := allrows[1].Practitioner_DEA_Active_Flg;
				self.Practitioner_DEA_Expired_Flg := allrows[1].Practitioner_DEA_Expired_Flg;
				self.Practitioner_Discipline_Flg  := allrows[1].Practitioner_Discipline_Flg;
				self.Practitioner_Discipline_St_Flg :=  allrows[1].Practitioner_Discipline_St_Flg;
				self.Practitioner_St_Lic_Active_Flg :=  allrows[1].Practitioner_St_Lic_Active_Flg;
				self.Practitioner_St_Expired_Flg    :=  allrows[1].Practitioner_St_Expired_Flg;
				self.Practitioner_BLJ_Flg           :=  allrows[1].Practitioner_BLJ_Flg;
				self.Practitioner_Crim_Hist_Flg     :=  allrows[1].Practitioner_Crim_Hist_Flg;
				self.Practitioner_Dead_Flg          :=  allrows[1].Practitioner_Dead_Flg;
				self.MatchType                      :=  allrows[1].MatchType;
				self.Practitioner_Zip5              :=  allrows[1].Practitioner_Zip5;										
end;				

EXPORT Practitioner_Batch_Service_Records(BOOLEAN useCannedRecs = FALSE) := FUNCTION		
		
		UNSIGNED4 tmp_max_results_per_acct := 100 : STORED('max_results_per_acct');
		
		UNSIGNED4 max_results_per_acct :=  IF ( tmp_max_results_per_acct > 1000, 1000, 
				                                    tmp_max_results_per_acct);
    unsigned4 joinLimit := 5000;
		gm := AutoStandardI.GlobalModule();
		deathparams := DeathV2_Services.IParam.GetDeathRestrictions(gm);
    glb_ok := deathparams.isValidGlb();
		                                 
		appType := deathparams.application_type;
		
		sample_SearchPoint_set := BatchServices._Sample_inBatchMaster('SEARCHPOINT_PRACTITIONER');
		
	  test_SearchPoint_recs := PROJECT(sample_SearchPoint_set, TRANSFORM(
		                           SearchPoint_Services.Layouts.practitioner.batchservice.layout_in,
		                            SELF.dea_number := (string10) LEFT.filing_number;																
		                            SELF := LEFT;
															));

		// Grab the input XML and throw into a dataset.	
		ds_batch_in_Searchpoint := project(IF (NOT useCannedRecs, 		                 
													       file_inSearchPointBatchMaster(forceSeq := FALSE),
													       test_SearchPoint_recs),
																 transform(SearchPoint_Services.Layouts.practitioner.batchservice.layout_in,
												             self.acctno := left.acctno;									
												             self.dea_number := StringLib.StringToUpperCase(left.dea_number);
															  ));
																
    ds_batch_in_valid := project(ds_batch_in_Searchpoint,
		                       transform(SearchPoint_Services.Layouts.practitioner.batchservice.layout_out_matchcodes,
													   len := length(left.dea_number);
														 tmplen :=  stringlib.StringFilterout(left.dea_number[3..len],'1234567890');																														
													   self.isDeaValid := StringLib.StringFind(alphabet, left.dea_number[1], 1) > 0
															                        and (tmplen = '') // meaning all numbers in the 3..end positions
															                        and (len >= 9); 
                             self := left;																											
                             self := [];                              																																								   
												 ));
													 
    ds_batch_valid := ds_batch_in_valid(isDeaValid);
		
		// mark as invalid this set of input data.
		ds_batch_NOTvalid := project(ds_batch_in_valid(~isDeaValid),
		                       transform(SearchPoint_Services.Layouts.Practitioner.batchservice.layout_out,
													   self.acctno := left.acctno;
														 self.matchtype := SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[3]; 
														          // INV - invalid;
                             self.gennum := '';																			
														 self := left));
    // match type is set in the transform above and in several different transforms below.
    // they are as follows
    // INV - invalid DEA Number
    // PR - matched CMC or matched DEA or CNLD
    // FAC - not used for a match against facilities data
          // taken care of by the other batch service SearchPoint_Services.Outlet_Batch_Service
    // N/A - not matched the default

    // separately there are stated rules for a valid DEA Number and based on 
    // the internet: rules a valid dea number is as follows:

    // "A DEA controlled substance registration can begin with one or two alphas.
    // The first letter of a company name, or a person's last name, is the second
    // character of the DEA number. For example, if the registrant is 
    // named "Third Street Pharmacy", then it will be assign a number such as
    // "FT0123456." However, if the company's name begins with a number, 
    // for example "3rd Street Pharmacy", then we insert the number "9" in the second position,
    // that is "F90123456."
	
    string8 CurDate := stringlib.getDateYYYYMMDD();	

    // get from a single DEA key join everything we need, including name and city information for further DID search
    rec_dids_by_name_city_combos := record
            string30 FirstName;
            string30 MiddleName;
            string30 LastName;
            string25 City;
            string2 State;
            string6 Zip;
            unsigned6 did;
        end;
    rec_layout_out_matchcodes_wide := record
          SearchPoint_Services.Layouts.practitioner.batchservice.layout_out_matchcodes - did,
          rec_dids_by_name_city_combos
        end;
    ds_dea_direct := join(
        ds_batch_valid,
        dea.Key_dea_reg_num,
        keyed(left.dea_number = right.dea_registration_number),
        transform(rec_layout_out_matchcodes_wide,
            isFAC := right.is_company_flag; 
            parseName := nameFromComponentsLFM(right.fname, right.mname, right.lname, right.name_suffix);
            self.acctno := left.acctno;
            self.dea_number := left.dea_number;
            self.did := (unsigned6) right.did;
            self.deaMatch := true;
            self.matchType := if (isFAC,
                SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[2],
                SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[1]);
            self.Practitioner_Name := if (isFAC and right.cname != '',
                right.cname,
                if (parseName != '', parseName, right.cname));
            // these were already combined into 4 different possible entities delimited by a space so
            // value in drug_schedules can be any combination of these in order slots 1, 2, 3, 4
            // 1st slot = 2 or 22N
            // 2nd slot = 3 or 33N
            // 3rd slot = 4
            // 4th slot = 5 so we can get away with below logic.
            // it's a 4 digit string of either 0 or 1
            self.Practitioner_sched :=
                if (stringlib.stringfind(right.drug_schedules, '2',1) > 0, '1', '0') +
                if (stringlib.stringfind(right.drug_schedules, '3',1) > 0, '1', '0') +
                if (stringlib.stringfind(right.drug_schedules, '4',1) > 0, '1', '0') +
                if (stringlib.stringfind(right.drug_schedules, '5',1) > 0, '1', '0');
            self.Practitioner_zip3 := right.zip_code[1..3];
            self.Practitioner_zip5 := right.zip_code;
            self.Practitioner_DEA_Active_flg := if ((integer) right.expiration_date > (integer) CurDate, 1, 0);
            self.Practitioner_DEA_Expired_flg := if ((integer) right.expiration_date < (integer) CurDate, 1, 0);
            self.practitioner_Discipline_flg := 0; // right.sanction_case <> ''; // possibly sanctions
            self.practitioner_Discipline_st_flg := 0; // right.sanction_state <> ''; // sanction related
            self.Practitioner_St_Lic_Active_Flg := 0; // right.st_lic_stat = 'A';
            self.Practitioner_St_Expired_Flg  := 0; // right.st_lic_stat = 'I';
            self.Area_of_practice := right.Business_activity_code; // Codes.DEA_REGISTRATION.BUSINESS_ACTIVITY_CODE(right.Business_activity_code); // use activity code and activity sub code
            self.address_date := right.expiration_date;
            self.FirstName := right.fname;
            self.MiddleName := right.mname;
            self.LastName := right.lname;
            self.City := right.p_city_name;
            self.State := right.st;
            self.Zip := right.zip;
            self := [];
       ),
       limit(joinLimit, skip),
       keep(joinlimit));

	   ds_most_recent_dea_per_acct := dedup(sort(ds_dea_direct, dea_number, -address_date, did = 0, did),dea_number);

    // eliminate records that are not necessary to project onto the get header dids function
    isContainingName(string FirstName, string MiddleName, string LastName) :=
            FirstName != '' or MiddleName != '' or LastName != '';
    isContainingLocation(string City, string State, string Zip) :=
            (City != '' and State != '') or Zip != '';
    ds_name_city_combos_needing_dids := ds_most_recent_dea_per_acct(did = 0
        and isContainingName(FirstName, MiddleName, LastName)
        and isContainingLocation(City, State, Zip));

    // eliminate further records by deduping and minimize the record layout
    ds_name_city_combos_needing_dids_ded := dedup(
        sort(
            project(ds_name_city_combos_needing_dids, rec_dids_by_name_city_combos),
            record),
        record);

    // assign additional dids from header library
    // based on looser search criteria than that of external linking
    ds_name_city_combos_with_possibly_found_dids := project(
        ds_name_city_combos_needing_dids_ded,
        transform(rec_dids_by_name_city_combos,
            mod := module(SearchPoint_Services.Functions.searchParams)
                export string30 FirstName := left.FirstName;
                export string30 MiddleName := left.MiddleName;
                export string30 LastName := left.LastName;
                export string25 City := left.City;
                export string2 State := left.State;
                export string6 Zip := left.Zip;
            end;
            self.did := SearchPoint_Services.Functions.getHdrDidByNameAddr(mod);
            self := left;
        ));

    // attach the dids to the records to which they apply
    ds_dea_possibly_appended_dids := join(
        ds_most_recent_dea_per_acct,
        ds_name_city_combos_with_possibly_found_dids,
        left.FirstName = right.FirstName
                and left.MiddleName = right.MiddleName
                and left.LastName = right.LastName
                and left.City = right.City
                and left.State = right.State
                and left.Zip = right.Zip,
        transform(SearchPoint_Services.Layouts.practitioner.batchservice.layout_out_matchcodes,
            self.did := right.did;
            self := left),left outer);

    // remove the records that are still did-less and eliminate fields that were added temporarily
    ds_dea_direct_with_dids := project(ds_dea_direct(did != 0),
            SearchPoint_Services.Layouts.practitioner.batchservice.layout_out_matchcodes);

    // consider all DEA records tied to practitioner to determine Active/Expired
    rec_batch_did := record
            string30 acctno;
            string10 dea_number;
            unsigned6 did;
        end;
    ds_dea_appended_dids := ds_dea_possibly_appended_dids(did != 0);
    ds_batch_did := dedup(sort(project(ds_dea_direct_with_dids + ds_dea_appended_dids,rec_batch_did),
													acctno, dea_number, did),
										acctno, dea_number, did);

    // consider all DEA records tied to practitioner to determine Active/Expired
		dea_direct_did := join(ds_batch_did, dea.Key_dea_did,
					keyed(left.did = right.my_did),
					transform(SearchPoint_Services.Layouts.practitioner.batchservice.layout_out_matchcodes,
						isFAC:=right.is_company_flag;// or right.Business_activity_code!='C';
						parseName:=nameFromComponentsLFM(right.fname,right.mname,right.lname,right.name_suffix);
						self.acctno := left.acctno;
						self.dea_number := left.dea_number;
						self.did := (unsigned6) left.did;
						self.deaMatch := true;
						self.matchType := if(isFAC,SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[2],SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[1]);
						self.Practitioner_Name := if(isFAC and right.cname!='',right.cname,if(parseName!='',parseName,right.cname));
						self.Practitioner_sched :=  if (stringlib.stringfind(right.drug_schedules, '2',1) > 0, '1', '0') +
									if (stringlib.stringfind(right.drug_schedules, '3',1) > 0, '1', '0') +
									if (stringlib.stringfind(right.drug_schedules, '4',1) > 0, '1', '0') +
									if (stringlib.stringfind(right.drug_schedules, '5',1) > 0, '1', '0');
						self.Practitioner_zip3  := right.zip_code[1..3];
						self.Practitioner_zip5  := right.zip_code;
						self.Practitioner_DEA_Active_flg  := if ((integer) right.expiration_date  > (integer) CurDate, 1, 0);
						self.Practitioner_DEA_Expired_flg := if ((integer) right.expiration_date <  (integer) CurDate, 1, 0);
						self.practitioner_Discipline_flg  := 0; //right.sanction_case <> ''; // possibly sanctions
						self.practitioner_Discipline_st_flg := 0; //right.sanction_state <> ''; // sanction related.
						self.Practitioner_St_Lic_Active_Flg := 0; // right.st_lic_stat='A';
						self.Practitioner_St_Expired_Flg  := 0; //right.st_lic_stat='I';
						self.Area_of_practice := right.Business_activity_code; //Codes.DEA_REGISTRATION.BUSINESS_ACTIVITY_CODE(right.Business_activity_code); // use activity code and activity sub code
						self.address_date := right.expiration_date;
						self := [];
						), limit(joinLimit,skip), keep(joinlimit));

    // keep latest expiration_date record with a not empty name
		dea_direct_rollup := rollup(sort(ds_dea_possibly_appended_dids+dea_direct_did,acctno,dea_number,-address_date,did=0,did),
			left.acctno = right.acctno and left.dea_number = right.dea_number,
			transform(SearchPoint_Services.Layouts.practitioner.batchservice.layout_out_matchcodes,useLeft:=left.practitioner_name!='';
				self.did := if(left.did!=0,left.did,right.did);
				self.matchtype := if(useLeft,left.matchtype,right.matchtype);
				self.practitioner_name  := if(useLeft,left.practitioner_name,right.practitioner_name);
				self.Practitioner_sched := if(useLeft,left.Practitioner_sched,right.Practitioner_sched);
				self.Area_of_practice   := if(useLeft,left.Area_of_practice,right.Area_of_practice);
				self.Practitioner_zip3  := if(useLeft,left.Practitioner_zip3,right.Practitioner_zip3);
				self.Practitioner_zip5  := if(useLeft,left.Practitioner_zip5,right.Practitioner_zip5);
				self:=left));

		// pickup Gennum for FAC matchtypes as customer will use the result from the batch to pull detail XML report by Gennum

 		dea_direct_slim := join(dea_direct_rollup,CNLD_Facilities.key_dea,
   			keyed(left.dea_number=right.deanbr),
   			transform(SearchPoint_Services.Layouts.practitioner.batchservice.layout_out_matchcodes,
   			self.gennum:=right.gennum,self:=left),
   			left outer,keep(1));
   	  dea_ingenix := join(ds_batch_valid, Ingenix_NatlProf.key_DEA_DEANumber,
   				             keyed(left.dea_number = right.l_DEANumber),
   											 transform({string10 dea_Number; string30 acctno; unsigned6 providerId;
   											            boolean ingenixMatch; boolean cnlpracticeMatch; string2 MatchType;},
                            self.acctno := left.acctno;
   												 self.dea_number := left.dea_number;
   											   self.providerid := (unsigned6) right.providerid;
   												 self.matchType := SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[1];
   												                       //  matched ingenix. no 'FAC' match code
   												                        //since no business dea Numbers in this service.
   												 self.ingenixMatch := true;
   												 self.cnlPracticeMatch := false;
   											), limit(joinLimit,skip),keep(joinlimit));
   												
       dea_ingenixProv := join(dea_ingenix, doxie_files.key_provider_id,
   		                     keyed(left.providerid = right.l_providerid) and
   												   (unsigned)right.did <> 0,
   												 transform(SearchPoint_Services.Layouts.practitioner.batchservice.layout_out_matchcodes,
   													 self.acctno := left.acctno;
   													 self.dea_number := left.dea_number;
   													 self.practitioner_Name := nameFromComponentsLFM(right.Firstname,right.middlename,right.Lastname,right.Suffix);
   													 self.ingenixMatch := true;
   													 self.cnlPracticeMatch := false;
   													 self.did := (unsigned6) right.did;													
   													 self.providerid := left.providerid;
   													 self.MatchType := left.MatchType;
   													 self := [];																												 
   												 ), 
   												 limit(joinLimit,skip),keep(joinlimit)
   											 );
   											 
   		// added dedup all into this dataset to slim the input before join takes place.			
       dea_ingenixProv_slim := dedup(dea_ingenixProv,all);
   		 
   		// rollup specialities by most recent and most reported
   		speciality := record
   			Ingenix_NatlProf.key_speciality_providerid.l_providerid;
   			Ingenix_NatlProf.key_speciality_providerid.processdate;
   			Ingenix_NatlProf.key_speciality_providerid.specialityname;
   			unsigned cnt;
   		end;
   
   		specialities := Join(dea_ingenixProv_slim,Ingenix_NatlProf.key_speciality_providerid,
   			keyed((unsigned)left.providerid=right.l_providerid),
   			transform(speciality,self:=right,self.cnt:=1),
   			limit(joinLimit,skip),keep(joinlimit));
   
   		specialityRolled := rollup(sort(specialities,l_providerid,-processdate,specialityname),
   			left.l_providerid=right.l_providerid and
   			left.processdate=right.processdate and
   			left.specialityname=right.specialityname,
   			transform(speciality,self.cnt:=left.cnt+1,self:=left));
   
   		topSpeciality := dedup(sort(specialityRolled,l_providerid,-processdate,-cnt),l_providerid);
   
       dea_ingenixProvSpecialty := Join(dea_ingenixProv_slim, topSpeciality,											
   		                              left.providerid = right.l_providerid,
   																  transform(recordof(left),
   																    self.Area_of_practice := right.specialityname,
   																    self := left,
   																    self := []),
   																 left outer,keep(1)
   																 );																
   																											                         
   		dea_cnldGenNum := join(ds_batch_in_searchPoint, CNLD_Practitioner.key_Dea,  
   														keyed(left.dea_number = right.deanbr),																										
   													  transform({string10 gennum; string10 dea_Number; string30 acctno;},
   													  self.gennum :=  right.gennum;
   														self.dea_Number := left.dea_number;
   														self.acctno := left.acctno;                            
   													 ),limit(joinLimit,skip),keep(joinlimit));
   													 
   													 // now join to the payload key in
   													 // order to get other additional fields.
       												  
        dea_cnldRaw := join(dea_cnldGenNum , CNLD_Practitioner.key_PractitionerID,
   							           keyed(left.gennum = right.gennum),
   												 transform(SearchPoint_services.Layouts.practitioner.batchservice.layout_out_matchcodes,
   												 self.acctno := left.acctno;
   												 self.did := right.did;
   												 self.dea_number := left.dea_number;
   												 self.Practitioner_Name := nameFromComponentsLFM(right.Firstname,right.middlename,right.Lastname,right.Suffix);																					
                            // the deanbr_sch[1] value is ignored.
   												 // see above comment about practitioner_sched field for more info.
   												 self.practitioner_sched := if (right.deanbr_sch[2]='T' OR
   												                                right.deanbr_sch[3]='T', '1', '0') +
   												                            if (right.deanbr_sch[4]='T' OR
   																										    right.deanbr_sch[5]='T', '1', '0') +
   																										if (right.deanbr_sch[6]='T', '1', '0') +
   																										if (right.deanbr_sch[7]='T', '1', '0');																																																																                                
   												                          											 
   												 self.practitioner_Zip3 := right.address_zip[1..3];
   												 self.practitioner_zip5 := right.address_zip;
   												 self.Practitioner_DEA_Active_flg := if (((integer) right.deanbr_exp >  (integer) CurDate), 1, 0);
   												 self.Practitioner_DEA_Expired_flg := if (((integer) right.deanbr_exp <  (integer) CurDate), 1, 0);
   												 self.practitioner_Discipline_flg := if (right.sanction_case <> '', 1, 0); // possibly sanctions
   												 self.practitioner_Discipline_st_flg := if (right.sanction_state <> '', 1, 0); // sanction related.
   												 self.Practitioner_St_Lic_Active_Flg := if (right.st_lic_stat='A', 1, 0);
   												 self.Practitioner_St_Expired_Flg := if (right.st_lic_stat='I', 1, 0);
   
   												 // match type same as ingenix
   												 self.matchType := SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[1];
   												 self.gennum := right.gennum;
                            self.address_date := right.Address_date;
   												 self := [];
   												  ),limit(joinLimit,skip),keep(joinlimit));				    									
   	  // sort the recs with non-zero did within a dea_number to the top.
   		//
   		dea_cnldRaw_slim := dedup(sort(dea_cnldRaw, acctno, dea_number, -address_date, record), acctno, dea_number);
   		
       // added deup all on next line to slim the input
   		ds_dea_reg_num_recs_slim := dedup(sort(dea_direct_slim + dea_ingenixProvSpecialty  + dea_cnldRaw_slim,
   																					 acctno, dea_number, did, -address_date, practitioner_sched, gennum), 
   		                                       acctno, dea_number, did, address_date, practitioner_sched, gennum);
       ds_dea_reg_num_Recs_slimwDid := ds_dea_reg_num_recs_slim(did <> 0);																					 
   		
   		// now do keyed projects to populate the flags for bk/judgement/liens, crim , death
   		
   		ds_dea_Bank := project(ds_dea_reg_num_recs_slimWDid,  // DO we want to do 
   		                                                  // FCRA here or not??? the  default is false.		                    											  
   									   transform(SearchPoint_Services.Layouts.practitioner.batchservice.layout_out_matchcodes,
   										   ds_bankruptcy	:=	BankruptcyV3.key_bankruptcyv3_did()(keyed(did=left.did));
   											 Suppress.MAC_Suppress(ds_bankruptcy,ds_bank_suppress,appType,,,Suppress.Constants.DocTypes.BK_TMSID,tmsid);
   											 self.BankruptcyFlag := count(project(ds_bank_suppress,
   												                                transform(left))) > 0;                       																											
   											 self := left;
   											 self := [];
   									 ));
   												 
       ds_dea_liens := project(ds_dea_bank,		                    											
   											 transform( recordof(left),
   											   ds_liens	:=	LiensV2.key_liens_DID(keyed(did = left.did));
   											   Suppress.MAC_Suppress(ds_liens,ds_liens_suppress,appType,,,Suppress.Constants.DocTypes.LIENS_TMSID,tmsid);
   												 self.liensFlag := count(project(ds_liens_suppress,
   												                     transform(left))) > 0;
   												 self := left;
   												 self := [];
   										));
   												 			 												 
       ds_dea_dead := project(ds_dea_liens,                   											
   										 transform(recordof(left),		
   										     deadRecs := doxie.Key_Death_MasterV2_ssa_Did(keyed(l_did = left.did)
   											                and not DeathV2_Services.functions.Restricted(src, glb_flag, glb_ok, deathparams));   																			        
   											   self.deadFlag := count(deadRecs) > 0;  //true if death record found
   												 self := left;
   												 self := [];
   									 ));			
   												 
       ds_dea_crim := project(ds_dea_dead, 		                    								 
   										 transform( recordof(left),		 
   											 self.CrimFlag := count(project(doxie_files.Key_Offenders()(keyed(sdid = left.did)),
   												                  transform(left))) > 0;												 
   												 self := left;
   												 self := [];
   										));	
   												 
       before_rolled := ds_dea_crim + ds_dea_reg_num_recs_slim(did=0);			
   		
   		// get rid of some duplicate rows and in collapsing still populate the zip3/zip5's from same person did/dea_number/acctno recs
   		// so that final results will be more full.
   		// also grab the area of practice and populate that from the left/right sides.
   		//
       ds_final_rolled := rollup(sort(before_rolled, acctno, -dea_number, -did, -address_date),
   													 left.acctno = right.acctno and
   													 left.dea_number = right.dea_number,													
   														 transform(recordof(left),
   														   self.practitioner_name := if (length(left.practitioner_name) > length(right.practitioner_name),
   															                                left.practitioner_name, right.practitioner_name);
   															 self.practitioner_sched := if (left.practitioner_sched = '',
   																		                      right.practitioner_sched, left.practitioner_sched);
                                  self.practitioner_Zip3 := if (left.practitioner_Zip3 = '', right.practitioner_Zip3, left.practitioner_Zip3);																															
                                  self.practitioner_Zip5 := if (left.practitioner_Zip5 = '', right.practitioner_zip5, left.practitioner_zip5);															 
   															 self.Area_of_practice := if (length(trim(left.Area_of_practice)) = 1 and right.Area_of_Practice <> ''
   																														 , right.Area_of_Practice, left.Area_of_Practice);
                                  self.gennum := if (left.gennum = '', right.gennum, left.gennum);	
   															 self.practitioner_dea_active_flg := if (left.practitioner_dea_active_flg <> 0, left.practitioner_dea_active_flg,
   															                                         right.practitioner_dea_active_flg);
   															 self.practitioner_dea_expired_flg := if (left.practitioner_dea_active_flg <> 0, left.practitioner_dea_expired_flg,
   															                                          if(left.practitioner_dea_expired_flg <> 0,left.practitioner_dea_expired_flg,right.practitioner_dea_expired_flg));
   															 self.practitioner_discipline_flg := if (left.practitioner_discipline_flg <> 0, left.practitioner_discipline_flg,
   															                                          right.practitioner_discipline_flg);
   															 self.practitioner_discipline_st_flg := if (left.practitioner_discipline_st_flg <> 0, left.practitioner_discipline_st_flg,
   															                                          right.practitioner_discipline_st_flg);
   															 self.practitioner_st_lic_active_flg := if (left.practitioner_st_lic_active_flg <> 0, left.practitioner_st_lic_active_flg,
   															                                          right.practitioner_st_lic_active_flg);
   															 self.practitioner_st_expired_flg := if (left.practitioner_st_lic_active_flg <> 0, left.practitioner_st_expired_flg,
   															                                          if(left.practitioner_st_expired_flg <> 0,left.practitioner_st_expired_flg,right.practitioner_st_expired_flg));
   															 self.practitioner_blj_flg := if (left.practitioner_blj_flg <> 0, left.practitioner_blj_flg,
   															                                          right.practitioner_blj_flg);
   															 self.practitioner_crim_hist_flg := if (left.practitioner_crim_hist_flg <> 0, left.practitioner_crim_hist_flg,
   															                                          right.practitioner_crim_hist_flg);
   															 self.practitioner_dead_flg := if (left.practitioner_dead_flg <> 0, left.practitioner_dead_flg,
   															                                          right.practitioner_dead_flg);
   															 self := left,
   															 self := right
   													));
       
   												 
       //													
   		// set the flags and also set up the area of practice from codes.key_codes_v3 if it hasn't been setup above.
   		// 
   		tmpds_final := project(ds_final_rolled, 
   		                 transform(SearchPoint_Services.Layouts.Practitioner.batchservice.layout_out,		                           
   		                   self.Practitioner_BLJ_Flg       := if (left.BankruptcyFlag  OR left.liensFlag, 1, 0);
   									     self.Practitioner_Crim_Hist_Flg := if (left.CrimFlag, 1, 0);
   						           self.Practitioner_Dead_Flg      := if (left.deadFlag, 1, 0);
   									     self.Area_of_practice := if (length(trim(left.Area_of_practice,left,right)) = 1, 
   											                              project(Codes.Key_Codes_V3(file_name='DEA_REGISTRATION' and
   																									                    code = left.area_of_Practice), transform(
   																																			 {string330 long_desc;},
   																																			 self.long_desc := left.long_desc))[1].long_desc,									                            
   																								 left.Area_of_practice); // use activity code and activity sub code
                          self := left
   										));
       // add back in any acct no's from orginal input that do not match any dea_number
   		// with a left only join setting only matchType and acctno as fields
   	  ds_final_withNoMatch := join(ds_batch_in_searchPoint, 		                                
   															tmpds_final, 
   		                            left.acctno = right.acctno,
   																transform(SearchPoint_Services.Layouts.Practitioner.batchservice.layout_out,
   																self.matchType := SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[4];
   																self := left;
   																self := []
   																       ), 
   														 left only);
       
   		ds_final := sort(tmpds_final + ds_final_withNoMatch + ds_batch_NOTvalid, 
   		             //   main DS    +  valid inputs with no match + invalid inputs
   		              acctno, dea_number, record);
       
   		// call macro to to did suppression.
       Suppress.MAC_Suppress(ds_final,ds_final_pulled,appType,Suppress.Constants.LinkTypes.DID,did);  
   		
   		// group the final recs by acctno
   		ds_results_grouped := group(sort(ds_final_pulled, acctno, - gennum, -practitioner_zip5, -did, record), acctno);
   			
       ds_results_grouped_TOPX := TOPN(ds_results_grouped, max_results_per_acct, acctno);			
       // At this point, 'flatten' the resultant records into the specified output layout													
   		ds_results_rolled_flat := ROLLUP(ds_results_grouped_TOPX, GROUP, practitioner_make_flat(LEFT, ROWS(LEFT)));
   
       // reset matchtype by 1st char of gennum
       // set dea expired flag using active
       ds_has_gennum := project(ds_results_rolled_flat(gennum!=''),transform(SearchPoint_Services.Layouts.Practitioner.batchService.layout_out_batch,
         self.matchtype:=map(
           left.gennum[1]='P' => SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[1],
           left.gennum[1]='F' => SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[2],
           left.matchtype);
         self.Practitioner_DEA_Expired_Flg:=if(left.Practitioner_DEA_Active_Flg=0,1,0),
         self:=left));
   
       // clear any records with no gennum
       ds_no_gennum := project(ds_results_rolled_flat(gennum=''),transform(SearchPoint_Services.Layouts.Practitioner.batchService.layout_out_batch,
         self.acctno:=left.acctno,
         self.ims_dea:=left.ims_dea,
         self.matchtype:=SearchPoint_Services.Layouts.practitioner.batchservice.MATCHTYPES[4],
         self:=[]));
   
       // final processing
       ds_final_results := sort(ds_has_gennum+ds_no_gennum,acctno);
   
       // output(ds_batch_in_valid, named('ds_batch_in_valid'));
       // output(ds_batch_valid, named('ds_batch_valid'));
       // output(ds_batch_NOTvalid, named('ds_batch_NOTvalid'));
       // output(ds_dea_direct, named('ds_dea_direct'));
       // output(ds_dea_direct_without_dids, named('ds_dea_direct_without_dids'));
       // output(ds_dea_direct_without_dids_ident_from_first_rec, named('ds_dea_direct_without_dids_ident_from_first_rec'));
       // output(ds_name_city_combos_needing_dids_ded, named('ds_name_city_combos_needing_dids_ded'));
       // output(ds_name_city_combos_with_possibly_found_dids, named('ds_name_city_combos_with_possibly_found_dids'));
       // output(ds_name_city_combos_with_found_dids, named('ds_name_city_combos_with_found_dids'));
       // output(ds_dea_possibly_appended_dids, named('ds_dea_possibly_appended_dids'));
       // output(ds_dea_appended_dids, named('ds_dea_appended_dids'));
       // output(ds_dea_direct_with_dids, named('ds_dea_direct_with_dids'));
       // output(ds_batch_did, named('ds_batch_did'));
       // output(dea_direct_did, named('dea_direct_did'));
       // output(dea_direct_rollup, named('dea_direct_rollup'));
       // output(dea_direct_slim, named('dea_direct_slim'));
       // output(dea_ingenix, named('dea_ingenix'));
       // output(dea_ingenixProv, named('dea_ingenixProv'));
       // output(dea_ingenixProv_slim, named('dea_ingenixProv_slim'));
       // output(specialities, named('specialities'));
       // output(specialityRolled, named('specialityRolled'));
       // output(topSpeciality, named('topSpeciality'));
       // output(dea_ingenixProvSpecialty, named('dea_ingenixProvSpecialty'));
       // output(dea_cnldGenNum, named('dea_cnldGenNum'));
       // output(dea_cnldRaw, named('dea_cnldRaw'));
       // output(dea_cnldRaw_slim, named('dea_cnldRaw_slim'));
       // output(ds_dea_reg_num_recs_slim, named('ds_dea_reg_num_recs_slim'));
       // output(ds_dea_reg_num_Recs_slimwDid, named('ds_dea_reg_num_Recs_slimwDid'));
       // output(ds_dea_Bank, named('ds_dea_Bank'));
       // output(ds_dea_liens, named('ds_dea_liens'));
       // output(ds_dea_dead, named('ds_dea_dead'));
       // output(ds_dea_crim, named('ds_dea_crim'));
       // output(before_rolled, named('before_rolled'));
       // output(ds_final_rolled, named('ds_final_rolled'));
       // output(ds_final, named('ds_final'));
       // output(ds_has_gennum, named('ds_has_gennum'));
       // output(ds_no_gennum, named('ds_no_gennum'));
       // output(ds_final_results, named('ds_final_results'));    
   
       return(ds_final_results);			
	
end;
