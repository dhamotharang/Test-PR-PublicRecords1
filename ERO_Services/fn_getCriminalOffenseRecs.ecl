import AutoStandardI, BatchShare, Corrections, CriminalRecords_Services,  
       doxie, doxie_files, FCRA, iesp, SexOffender, SexOffender_Services, Suppress, ut;

export fn_getCriminalOffenseRecs( dataset(Layouts.LookupId) ids = dataset([],Layouts.LookupId) ) :=
	function
		/*
			Requirement 4.1-11:
			re: INPUT - FBI / STATE ID #s
			FBI# and State ID # will be provided on input when available.  

			For each possible subject ("Best"), conduct a criminal search.  Records returned for a subject 
			that have an FBI# will be compared to the input FBI#.  If the criminal record FBI# does 
			not match the input FBI#, then that criminal record will be eliminated as a possible 
			record to be returned for a subject.  NOTE:  This requirement could potentially be done 
			in conjunction with requirement 4.1-27.  

			If a criminal record has the same FBI# as the input FBI# or the is blank then that record 
			will not be eliminated.

			Input State ID # will not be used in processing at this time.

			NOTE: In reviewing what was provided by the data team only 8% of records have a DLE 
			number (State Id) and only about 3% have FBI numbers in our files. Limited pop counts for 
			this but may still be useful. 

			Requirement 4.1-27:
			Search Criminal data by the best subject being returned to ERO to return the five most 
			current offenses (not cases) based on Adjudication Date for Sex Offender outputs and 
			Offense Date (followed by Sentence Date as a secondary comparison) for Criminal Records.  
			Records where the gender does not match the input gender will be eliminated prior to 
			returning the 5 most current offenses.   NOTE:  Only values of Male and Female will be used 
			for comparison.  If no gender is available (i.e., blank, Unknown, etc), then that record 
			will not be eliminated from the list of criminal records. 

			The found subject being returned will be consistent with the output criminal records. 

			The following criteria will be met: 
			  o   Sex Offender returns will be considered a priority for returns
			  o   Felony, misdemeanor, and citations are listed for offense levels; use these to determine 
			priority of the criminal records returned (after Sex Offender). 
			  o   If gender found on Criminal Record does not match input, disregard record; should not be 
			an issue based on LexId matching but will be additional clarification.
		*/
				
		
		df := doxie_files.File_Offenders;
		offenders_key := doxie_files.Key_Offenders(false);   //these are in prod by now 5/1/13
		
		fn_format_int_date(iesp.share.t_date dt) := 
			function
				return dt.year*10000 + dt.month*100 + dt.day;
			end;
			
		// Configuration module for use in obtaining Offenders, Crim Records and Sex Offenders.
		in_mod := module(project(AutoStandardI.GlobalModule(),CriminalRecords_Services.IParam.report,opt))
			export string14 did                      := '';
			export string32 ApplicationType          := ''; 
			export boolean IncludeSexualOffenses     := true;
			export boolean IncludeAllCriminalRecords := true;
			export string6 ssnmask                   := 'NONE';
		end;
		
		ids_slim := project(ids, doxie.layout_references_acctno);
		
		// The following join was pillaged from CriminalRecords_Services.Raw.getOffenderKeys.byDID and modified.

		offender_key_recs_w_dups := 
			join(
				ids_slim, offenders_key,
				keyed(left.did = right.sdid),
				transform( {Layouts.LookupId.acctno, Layouts.LookupId.did, CriminalRecords_Services.layouts.l_search}, 
					self.acctno       := left.acctno, 
					self.did          := left.did,
					self.offender_key := right.offender_key,
					self.isDeepDive   := false
				),
				keep(ut.limits.OFFENDERS_PER_DID) // We are interested in KEEPing records, as opposed to limit-skipping them, because they're Criminal records.
			);

		// The following code was swiped from CriminalRecords_Services.ReportService_Records.val
		// and modified for the case when FRCA is always false.
		//
		blank_flagfile := fcra.compliance.blank_flagfile;
	

		// Get Offender records...
		offender_key_recs := dedup(sort(offender_key_recs_w_dups,record),record);
		offender_keys := project( offender_key_recs, CriminalRecords_Services.layouts.l_search );
		offender_recs := CriminalRecords_Services.Raw.getOffenderraw(offender_keys, false, blank_flagfile);

		// ...and join them back to acctno, did, etc.
		ds_offenders := 
			join(
				offender_key_recs, offender_recs,
				left.offender_key = right.offender_key,
				inner,
				keep(ut.limits.OFFENDERS_MAX)
			);
				
		// Perform Offender suppression and masking.
		Suppress.MAC_Suppress(offender_recs,pull_1,in_mod.ApplicationType,Suppress.Constants.LinkTypes.DID,did);
		Suppress.MAC_Suppress(pull_1,pull_2,in_mod.ApplicationType,Suppress.Constants.LinkTypes.SSN,ssn);
		Suppress.MAC_Suppress(pull_2,pull_3,in_mod.ApplicationType,,,Suppress.Constants.DocTypes.OffenderKey,offender_key);
		
		doxie.MAC_PruneOldSSNs(pull_3, out_f_p1, ssn, did);
		doxie.MAC_PruneOldSSNs(out_f_p1, out_f_p2, ssn_appended, did);
		
		ssn_mask_mod   := project( in_mod, AutoStandardI.InterfaceTranslator.ssn_mask_val.params );
		ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(ssn_mask_mod);
		
		suppress.MAC_Mask(out_f_p2, out_intm, ssn, blank, true, false);
		suppress.MAC_Mask(out_intm, out_mskd, ssn_appended, blank, true, false);
		
		// Get Criminal Records...
		added_in_mod := project(in_mod, CriminalRecords_Services.Functions.params);
		criminal_records_rpt := CriminalRecords_Services.Functions.fnCrimReportVal(out_mskd, added_in_mod, false, blank_flagfile);
    
		// ...and join them back to acctno, did, etc.
		layout_criminal_records_rpt := record
			Layouts.LookupId.acctno;
			Layouts.LookupId.did;
			iesp.criminal.t_CrimReportRecord;
			string10 dle_num;   //for future use
	    string9 fbi_num;
		end;
		//restore fbi_num and dle_num
		layout_criminal_records_rpt fillFBI(criminal_records_rpt l, out_mskd r) := transform
		   self.dle_num := r.dle_num;
			 self.fbi_num := r.fbi_num;
			 self.acctno := '';
			 self.did := 0;
			 self := l;
		end;
		
		criminal_records_rpt_fbi := 
			join(
				criminal_records_rpt, out_mskd, 
				left.offenderid = right.offender_key, 
				fillFBI(left,right), 
				left outer,	
				limit(0), 
				keep(1)
			); 

		ds_criminal_records := 
			join(
				offender_key_recs, criminal_records_rpt_fbi,
				left.offender_key = right.offenderid,
				transform( layout_criminal_records_rpt,
				  self.acctno := left.acctno,
					self.did := left.did,
					self := right,
				),
				inner,
				keep(ut.limits.OFFENDERS_MAX)
			);
			
		// Get Sex Offenders...

		// (First find the seisint_primary_key and associate with acctno/did.)
		layout_sexoffender_key := record
			Layouts.LookupId.acctno;
			Layouts.LookupId.did;
			SexOffender_Services.layouts.search;
		end;
		
		sexoffender_key_recs := 
			join(
				ids_slim, SexOffender.Key_SexOffender_DID(false),
				keyed(left.did = right.did),
				transform( layout_sexoffender_key, 
					self := left,
					self := right
				),
				keep(SexOffender_Services.Constants.MAX_RECS_PERDID)
			); 

		in_mod_sex_offenders := project( in_mod, SexOffender_Services.IParam.report );
		sex_offender_rpt := SexOffender_Services.Raw.REPORT_VIEW.by_did(project(ids_slim,doxie.layout_references),in_mod_sex_offenders);
		
		// ...and join sex offender records back to acctno, did, etc.
		layout_sexoffender_rpt := record
			Layouts.LookupId.acctno;
			Layouts.LookupId.did;
			iesp.sexualoffender.t_SexOffReportRecord;
		end;
		
		ds_sex_offenders := 
			join(
				sexoffender_key_recs, sex_offender_rpt,
				left.seisint_primary_key = right.primarykey,
				transform( layout_sexoffender_rpt,
					self := right,
					self := left
				),
				inner,
				keep(ut.limits.OFFENDERS_MAX)
			);
		
		// Now, convert ds_offenders, ds_criminal_records and ds_sex_offenders to ERO layout:
		//   o  Construct the Offender section of the Crim Records layout
		//   o  Find all AKAs using ds_offenders and ds_sex_offenders and include them in the Offender section
		//   o  Obtain all Criminal Records from ds_offenders
		//   o  Obtain all Sex Offender Records from ds_sex_offenders
		//   o  Union, sort, and grab the top five records from Criminal Records + Sex Offender records
		//   o  Exception! If the Sex Offender records have no date, throw them to the top of the stack.
		
		/* ***********************************************************************************
		//
		//             Construct the Offender section of the Crim Records layout.
		//
		// ********************************************************************************* */
		
		// The Offender dataset will provide the basis for the person's:
		//  o  personal information
		//  o  physical characteristics
		
		layout_offender_slim := record
			BatchShare.Layouts.ShareAcct;
			BatchShare.Layouts.ShareDID;
			Corrections.layout_offender.lname;
			Corrections.layout_offender.fname;
			Corrections.layout_offender.mname;
			string akas := '';
			Corrections.layout_offender.ssn_appended;
			Corrections.layout_offender.dob;
			Corrections.layout_offender.height;
			Corrections.layout_offender.weight;
			Corrections.layout_offender.sex;
			Corrections.layout_offender.race_desc;
			Corrections.layout_offender.eye_color_desc;
			Corrections.layout_offender.hair_color_desc;
		end;
			
		ds_offenders_slim :=
			project(
				ds_offenders, 
				transform( layout_offender_slim,
					self.did := (unsigned6)left.did,
					self     := left,
					self     := []
				)
			);
			
		ds_sexoffenders_slim :=
			project(
				ds_sex_offenders,
				transform( layout_offender_slim,
					self.did             := (unsigned6)left.did,
					self.lname           := left.name.last,
					self.fname           := left.name.first,
					self.mname           := left.name.middle,
					self.akas            := '';
					self.ssn_appended    := left.ssn,
					self.dob             := (string)left.dob.year + intformat(left.dob.month,2,1) + intformat(left.dob.day,2,1),
					self.height          := left.physicalcharacteristics.height,
					self.weight          := left.physicalcharacteristics.weight,
					self.sex             := left.physicalcharacteristics.sex[1],
					self.race_desc       := left.physicalcharacteristics.race,
					self.eye_color_desc  := left.physicalcharacteristics.eyecolor,
					self.hair_color_desc := left.physicalcharacteristics.haircolor,
					self                 := left,
					self                 := []
				)
			);		
		
		ds_offenders_all_slim := ds_offenders_slim + ds_sexoffenders_slim;
		
		// Remove all gender mismatches. Preserve records, though, where gender is blank.
		ds_offenders_slim_correct_gender := 
			join(
				ids, ds_offenders_all_slim,
				left.acctno = right.acctno and 
				not( (left.input_gender[1] = 'M' and right.sex[1] = 'F') or (left.input_gender[1] = 'F' and right.sex[1] = 'M') ),
				transform(right),
				inner,
				keep(ut.limits.OFFENDERS_MAX)
			);
		
		ds_offenders_slim_grouped := group(sort(ds_offenders_slim_correct_gender,acctno),acctno);
		
		ds_offenders_slim_rolled :=
			rollup(
				ds_offenders_slim_grouped,
				left.acctno = right.acctno,
				transform( layout_offender_slim,
					self.acctno       := if( trim(left.acctno) != '', left.acctno, right.acctno ),
					self.did          := if( left.did != 0, left.did, right.did ),
					self.lname        := if( trim(left.lname) != '', left.lname, right.lname );
					self.fname        := if( trim(left.fname) != '', left.fname, right.fname );
					self.mname        := if( trim(left.mname) != '', left.mname[1], right.mname[1] );
					self.akas         := '';
					self.ssn_appended := if( trim(left.ssn_appended) != '', left.ssn_appended, right.ssn_appended );
					self.dob          := if( trim(left.dob) != '', left.dob, right.dob );
					self.height       := if( trim(left.height) != '', left.height, right.height );
					self.weight       := if( trim(left.weight) != '', left.weight, right.weight );
					self.sex          := if( trim(left.sex) != '', left.sex[1], right.sex[1] );
					self.race_desc    := if( trim(left.race_desc) != '' and StringLib.StringFind(left.race_desc,'UNMATCHED',1) = 0, left.race_desc, right.race_desc );
					self.eye_color_desc := if( trim(left.eye_color_desc) != '' and StringLib.StringFind(left.eye_color_desc,'UNMATCHED',1) = 0, left.eye_color_desc, right.eye_color_desc );
					self.hair_color_desc  := if( trim(left.hair_color_desc) != '' and StringLib.StringFind(left.hair_color_desc,'UNMATCHED',1) = 0, left.hair_color_desc, right.hair_color_desc );
				)
			);

		/* ***********************************************************************************
		//
		//             Find all AKAs using ds_offenders and ds_sex_offenders 
		//             and include them in the Offender section.
		//
		// ********************************************************************************* */

		// Grab existing AKAs from both Criminal Records and Sex Offenders; then union, sort, 
		// rollup, and dedup.
		layout_acctno_t_names := record
			BatchShare.Layouts.ShareAcct;
			dataset(iesp.share.t_name) akas;
		end;
		
		layout_acctno_akas := record
			BatchShare.Layouts.ShareAcct;
			string100 akas_as_string;
		end;
		
		ds_criminal_record_akas :=
			project( ds_criminal_records, layout_acctno_t_names );
						
		ds_sex_offenders_akas := 
			project( ds_sex_offenders, layout_acctno_t_names );
			
		ds_all_akas_sorted := 
			sort( (ds_criminal_record_akas + ds_sex_offenders_akas), acctno );
		
		ds_akas_rolled := 
			rollup(
				ds_all_akas_sorted,
				left.acctno = right.acctno,
				transform( layout_acctno_t_names,
					self.acctno := if(left.acctno != '', left.acctno, right.acctno),
					self.akas := left.akas + right.akas
				)
			);
		
		ds_akas_deduped := 
			project(
				ds_akas_rolled,
				transform( layout_acctno_t_names,
					self.acctno := left.acctno,
					self.akas   := dedup(sort(left.akas,record),record)
				)
			);

		// Remove AKAs that already exist as the Offender's name.
		ds_akas_actual :=
			join(
				ds_offenders_slim_rolled, ds_akas_deduped,
				left.acctno = right.acctno,
				transform( layout_acctno_t_names,
					self.akas := right.akas( not(last = left.lname and first = left.fname and middle = left.mname) ),
					self.acctno := left.acctno
				),
				inner,
				keep(ut.limits.OFFENDERS_MAX)
			);
		
		// Construct AKA as a "full" name.
		ds_akas_formatted := 
			project(
				ds_akas_actual,
				transform( layout_acctno_t_names,
					self.acctno := left.acctno,
					self.akas := 
						project(
							left.akas,
							transform( iesp.share.t_name,
								self.full :=
										if( trim(left.last) != '', trim(left.last), '') +
										if( trim(left.last) != '' and trim(left.first) != '', ', ' + trim(left.first), '') +
										if( trim(left.last) != '' and trim(left.middle) != '', ' ' + trim(left.middle), ''),
								self := left,
								self := []
							)
						)
				)
			);
		
		// Concatenate all AKAs as a single, semi-colon delimited string.
		ds_akas_as_string :=
			project( 
				ds_akas_formatted,
				transform( layout_acctno_akas,
					self.acctno := left.acctno,
					self.akas_as_string := 
							rollup( 
								left.akas, 
								true, 
								transform( iesp.share.t_name, 
									self.full := trim(left.full) + '~ ' + trim(right.full),
									self      := []
								) 
							)[1].full
				)
			);	
		
		// Add AKAs to the other Offender data.
		ds_offenders_with_akas_slim :=
			join(
				ds_offenders_slim_rolled, ds_akas_as_string,
				left.acctno = right.acctno,
				transform(layout_offender_slim,
					self.akas := right.akas_as_string,
					self := left
				),
				inner,
				keep(ut.limits.OFFENDERS_MAX)
			);
		
		// Project Offenders into final record layout. Offender data is done.
		ds_final_with_offenders := 
			project(
				ds_offenders_with_akas_slim,
				transform( ERO_Services.Layouts.CriminalOffenses_out,
					self.acctno             := left.acctno,
					self.did                := left.did,
					self.Off_Crim_Name      := Functions.fn_format_name( trim(left.lname), trim(left.fname), trim(left.mname) ),
					self.Off_Crim_AKAs      := left.akas,
					self.Off_Crim_SSN       := left.ssn_appended,
					self.Off_Crim_DOB       := Functions.fn_format_date(left.dob),
					self.Off_Crim_Height    := left.height, 
					self.Off_Crim_Weight    := left.weight,
					self.Off_Crim_Gender    := left.sex,
					self.Off_Crim_Race      := left.race_desc,
					self.Off_Crim_Eye_color := left.eye_color_desc,
					self.Off_Crim_Hair      := left.hair_color_desc,
					self                    := []
				)
			);
		
		/* ***********************************************************************************
		//
		//                   Obtain all Criminal Records from ds_offenders.
		//
		// ********************************************************************************* */

		// The Criminal Records contain a base record onto which are attached several child 
		// datasets. The child dataset we're most interested in is the one named "Offenses",
		// since it contains the majority of the data needed to fulfill the data requirements.
		// Some of the other data are contained in the base record and in the child dataset
		// named "Court". Each Criminal Record is based on a single criminal case, so we could
		// call each record plus child datasets a "Criminal Case Record". 
		//
		// However, per the requirement (and after some clarification) the customer wants the
		// five most recent *Offenses* returned, not Criminal Cases. This complicates things.
		// So, what I'm doing below is Normalizing the entire Criminal Case record into a transform
		// where the result is a base record consisting of only 'acctno' plus an inflated version 
		// of the Offenses child dataset. 
		
		// Inflate the Offenses child dataset to hold all the needed information to fulfill the  
		// Offenses data requriements for ERO.
		layout_CrimReportOffense_plus := record
			string20 acctno;
			boolean isSexOffense;
			string OffenderId;
			string FBINumber;
			string DOCNumber;
			string25 StateOfOrigin;
			string60 Status;
			unsigned sortby_date;
			string sortby_date_type;
			iesp.criminal.t_CrimReportOffense;
		end;
		
		fn_get_most_recent_prison_admitted_date(dataset(iesp.criminal.t_CrimReportPrison) sentences) :=
			function
				// Find the most recent date (as integer yyyymmdd).
				dt := max( sentences, fn_format_int_date( admitteddate ) );
				return row( { dt DIV 10000, (dt DIV 100) % 100, dt % 100 }, iesp.share.t_date );
			end;

		layout_CrimReportOffense_plus xfm_inflate_offenses(layout_criminal_records_rpt le, iesp.criminal.t_CrimReportOffense ri) :=
			transform
				self.acctno            := le.acctno;
				self.isSexOffense      := false;
				self.OffenderId        := le.offenderid;
				self.FBINumber         := le.fbi_num;
				self.DOCNumber         := le.DOCNumber;
				self.StateOfOrigin     := le.stateoforigin;
				self.Status            := le.status;
				self.casenumber        := le.casenumber;
				self.sortby_date       := 0;
				self.sortby_date_type  := '';
				self.incarcerationdate := 
					if( // if there's no incarceration date, use the most recent prison admitted date
						fn_format_int_date( ri.incarcerationdate ) != 0, 
						ri.incarcerationdate,
						fn_get_most_recent_prison_admitted_date( le.prisonsentences )
					);
				self := ri;
			end;

		ds_crim_offenses_dups :=
			normalize(
				ds_criminal_records,
				left.offenses,
				xfm_inflate_offenses(left,right)
			);
		ds_crim_offenses := dedup(sort(ds_crim_offenses_dups,record),record);	
		// Date fields aren't populated really well in Criminal Records. The requirements state
		// that we must return the most recent criminal records (determined by offense date) and
		// sex offender records (determined by adjudication date)--five in total. We'll use a 
		// map to establish order of precedence, sine the offense date (for criminal records) is
		// not always populated.

		fn_determine_sortby_date(layout_CrimReportOffense_plus offense) :=
			function			
					offense_date            := fn_format_int_date( offense.offensedate );
					arrest_date             := fn_format_int_date( offense.arrest.date ); 
					arrest_disposition_date := fn_format_int_date( offense.arrest.dispositiondate );
					court_disposition_date  := fn_format_int_date( offense.court.dispositiondate );
					sentence_date           := fn_format_int_date( offense.sentencedate ); 
					incarceration_date      := fn_format_int_date( offense.incarcerationdate ); 
					
					sortby_date := 
						map(
							offense_date != 0            => offense_date,
							arrest_date != 0             => arrest_date,
							arrest_disposition_date != 0 => arrest_disposition_date,
							court_disposition_date != 0  => court_disposition_date,
							sentence_date != 0           => sentence_date,
							incarceration_date != 0      => incarceration_date,
							/* default................. */  0
						);
						
					return sortby_date;
			end;
		
		// It's pretty important that we know what sort of date type was chosen for the sortby_date,
		// too. Yeah, lots of same code as above. We'll do a little maintenance later.
		fn_determine_sortby_date_type(layout_CrimReportOffense_plus offense) :=
			function			
					offense_date            := fn_format_int_date( offense.offensedate );
					arrest_date             := fn_format_int_date( offense.arrest.date ); 
					arrest_disposition_date := fn_format_int_date( offense.arrest.dispositiondate );
					court_disposition_date  := fn_format_int_date( offense.court.dispositiondate );
					sentence_date           := fn_format_int_date( offense.sentencedate ); 
					incarceration_date      := fn_format_int_date( offense.incarcerationdate ); 
					
					sortby_date_type := 
						map(
							offense_date != 0            => 'offense',
							arrest_date != 0             => 'arrest',
							arrest_disposition_date != 0 => 'arrest_disposition',
							court_disposition_date != 0  => 'court_disposition',
							sentence_date != 0           => 'sentence',
							incarceration_date != 0      => 'incarceration',
							/* default................. */  ''
						);
						
					return sortby_date_type;
			end;

		// Add a sortby_date and its type to the criminal Offenses.
		ds_crim_offenses_with_sortby_date :=
			project(
				ds_crim_offenses,
				transform( layout_CrimReportOffense_plus,
					self.sortby_date      := fn_determine_sortby_date(left),
					self.sortby_date_type := fn_determine_sortby_date_type(left),
					self                  := left
				)
			); 
			
		// The sentence for a particular Case can be expressed in up to 2 fields: in both, in one
		// or the other, or in neither.
		fn_get_sentence_desc(layout_CrimReportOffense_plus offense) :=
			function
				return map( 
									trim(offense.sentence) != '' and trim(offense.SentenceLengthDescription) != '' =>
												trim(offense.sentence) + '--' + trim(offense.SentenceLengthDescription),
									trim(offense.sentence) != '' => 
												trim(offense.sentence),
									trim(offense.SentenceLengthDescription) != '' => 
												trim(offense.SentenceLengthDescription),
									/* default...... */ ''
								);
			end;
					
		// Project Criminal Records into the following layout, which is very close to 
		// the final layout for each Offense:
		layout_offenses_slim := record
			string20 acctno;
			string500 Off;                       // from Criminal Records (Offense or Court Offense) or Sex Offender
			string10 Off_Date;                   // from Criminal Records
			string150 Off_Sentence;              // from Criminal Records
			string10 Off_Sentence_Date;          // from Criminal Records
			string10 Off_Incarceration_Date;     // from Criminal Records
			string40 Off_Court_Name;             // from Criminal Records (Court Description) or Sex Offender
			string35 Off_Court_Case_Number;      // from Criminal Records or Sex Offender
			string80 Off_Jurisdiction_State;     // from Criminal Records (Convicted County) or Sex Offender 
			string360 Off_Adjudication;          // Sex Offender "sentencedescription"
			string10 Off_Adjudication_Date;      // Sex Offender "convictiondate"
			string30 Off_FBI_Number;             // from Sex Offender "FBINumber"
			string30 Off_DOC_Number;             // from Criminal Records or Sex Offender "DOCNumber"
			string30 Off_Sex_Off_Registry_Id;    // from Sex Offender "SORNumber"
			string10 Off_Arrest_Date;            // from Criminal Records
			string35 Off_Arrest_Level_Degree;    // from Criminal Records
			string9  Off_Court_Fine;             // from Criminal Records
			string30 Off_Court_Plea;             // from Criminal Records
			string80 Off_Court_Disposition;      // from Criminal Records
			string10 Off_Court_Disposition_Date; // from Criminal Records
			string20 Off_Suspended_Time;         // from Criminal Records
			string60 Off_Party_Status;           // Jail/Probation/Parole related to offense/subject
			boolean  isSexOffense;               // For sorting.
			unsigned sortby_date;                // For sorting.
			string sortby_date_type;             // For assigning a date to 'offensedate' or not.
		end;
		
		layout_offenses_slim xfm_make_slim_offenses(layout_CrimReportOffense_plus le) :=
			transform
					self.acctno                     := le.acctno;
					self.Off                        := if( trim(le.court.offense) != '', le.court.offense, le.arrest.offense );
					self.Off_Date                   := if( le.sortby_date_type in ['offense','arrest'], Functions.fn_format_date( (string)le.sortby_date ), '' ); 
					self.Off_Sentence               := fn_get_sentence_desc(le);              
					self.Off_Sentence_Date          := Functions.fn_format_date( (string)fn_format_int_date(le.sentencedate) );         
					self.Off_Incarceration_Date     := Functions.fn_format_date( (string)fn_format_int_date(le.incarcerationdate) );
					self.Off_Court_Name             := le.court.description;              
					self.Off_Court_Case_Number      := le.casenumber;
					self.Off_Jurisdiction_State     := le.stateoforigin;
					self.Off_Adjudication           := ''; // from sex offender          
					self.Off_Adjudication_Date      := ''; // from sex offender     
					self.Off_FBI_Number             := le.fbinumber; // from crimsex offender
					self.Off_DOC_Number             := le.docnumber;              
					self.Off_Sex_Off_Registry_Id    := ''; // from sex offender   
					self.Off_Arrest_Date            := Functions.fn_format_date( (string)fn_format_int_date(le.arrest.date) );           
					self.Off_Arrest_Level_Degree    := map(le.arrest.level <> '' => le.arrest.level,
					                                      StringLib.StringFind(le.CaseTypeDescription,'FELONY',1) >0 => 'FELONY',
					                                      StringLib.StringFind(le.CaseTypeDescription,'MISDEMEANOR',1)>0 => 'MISDEMEANOR',
																								 '');   
					self.Off_Court_Fine             := le.court.fine;            
					self.Off_Court_Plea             := le.court.plea;            
					self.Off_Court_Disposition      := le.court.disposition;     
					self.Off_Court_Disposition_Date := Functions.fn_format_date( (string)fn_format_int_date(le.court.dispositiondate) );
					self.Off_Suspended_Time         := ''; // available in Corrections.layout_CourtOffenses; not used in iesp.criminal.t_CrimReportCourtSentence
					self.Off_Party_Status           := le.status;			
					self.isSexOffense               := false;
					self.sortby_date                := le.sortby_date;
					self.sortby_date_type           := le.sortby_date_type;
			end;

		ds_results_crim_recs := 
				project( ds_crim_offenses_with_sortby_date, xfm_make_slim_offenses(left) );
			
		/* ***********************************************************************************
		//
		//                   Obtain all Sex Offenses from ds_sex_offenders.
		//
		// ********************************************************************************* */

		// As above, the Sex Offense contain a base record onto which are attached several child 
		// datasets. We're interested in "Convictions". Here also, some of the other data are 
		// contained in the base record. Each Sex Offense record is based on a single criminal 
		// case, but we must return the five most recent *Offenses*, not Cases. 
		//
		// I'm doing the same type of operation below to Normalize a Sex Offense Cases. 
		
		// Inflate the Convictions child dataset to hold all the needed information to fulfill the  
		// Offenses data requriements for ERO.
		layout_SexOffense_plus := record
			string20 acctno;
			boolean isSexOffense;
			string OffenderId;
			string FBINumber;
			string DOCNumber;
			string SORNumber;
			string25 StateOfOrigin;
			string60 OffenderStatus;
			unsigned sortby_date;
			string sortby_date_type;
			iesp.sexualoffender.t_SexOffReportConviction;
		end;

		layout_SexOffense_plus xfm_inflate_sexoffenses(layout_sexoffender_rpt le, iesp.sexualoffender.t_SexOffReportConviction ri) :=
			transform
				// A few local attributes to help with sortby_date.
					offense_date    := fn_format_int_date( ri.offensedate );
					conviction_date := fn_format_int_date( ri.convictiondate );
				self.acctno           := le.acctno;
				self.isSexOffense     := true;
				self.OffenderId       := le.IdNumbers.OffenderId;
				self.DOCNumber        := le.IdNumbers.DOCNumber;
				self.SORNumber        := le.IdNumbers.SORNumber;
				self.FBINumber        := le.IdNumbers.FBINumber;
				self.StateOfOrigin    := le.StateOfOrigin;
				self.OffenderStatus   := le.OffenderStatus;
				self.sortby_date      := if( offense_date != 0, offense_date, conviction_date );
				self.sortby_date_type := 
						map(
							offense_date != 0    => 'offense',
							conviction_date != 0 => 'conviction',
							''
						);
				self := ri;
			end;

		ds_sex_offenses :=
			normalize(
				ds_sex_offenders,
				left.convictions,
				xfm_inflate_sexoffenses(left,right)
			);
			
		// Project Sex Offenses into the following layout, which is very close to 
		// the final layout for each Offense:
		layout_offenses_slim xfm_make_slim_sexoffenses(layout_SexOffense_plus le) :=
			transform
					self.acctno                     := le.acctno;
					self.Off                        := le.offensedescription;
					self.Off_Date                   := Functions.fn_format_date( (string)fn_format_int_date(le.offensedate) ); 
					self.Off_Sentence               := le.sentencedescription;              
					self.Off_Sentence_Date          := '';         
					self.Off_Incarceration_Date     := '';
					self.Off_Court_Name             := le.courtname;              
					self.Off_Court_Case_Number      := le.courtcasenumber;
					self.Off_Jurisdiction_State     := le.convictionjurisdiction;
					self.Off_Adjudication           := le.sentencedescription;          
					self.Off_Adjudication_Date      := Functions.fn_format_date( (string)fn_format_int_date(le.convictiondate) );
					self.Off_FBI_Number             := le.fbinumber;
					self.Off_DOC_Number             := le.docnumber;              
					self.Off_Sex_Off_Registry_Id    := le.sornumber;   
					self.Off_Arrest_Date            := '';           
					self.Off_Arrest_Level_Degree    := '';   
					self.Off_Court_Fine             := '';            
					self.Off_Court_Plea             := '';            
					self.Off_Court_Disposition      := '';     
					self.Off_Court_Disposition_Date := '';
					self.Off_Suspended_Time         := ''; // available in Corrections.layout_CourtOffenses; not used in iesp.criminal.t_CrimReportCourtSentence
					self.Off_Party_Status           := le.offenderstatus;			
					self.isSexOffense               := true;
					self.sortby_date                := le.sortby_date;
					self.sortby_date_type           := le.sortby_date_type;
			end;
			
		ds_results_SO_recs := project( ds_sex_offenses,	xfm_make_slim_sexoffenses(left)	);

		/* ***********************************************************************************
		//
		//                       Union, sort, and grab the top five records 
		//                      from Criminal Records + Sex Offender records
		//
		// ********************************************************************************* */
		
		ds_all_crim_recs_fbi := ds_results_crim_recs + ds_results_SO_recs;
		//only use records where the FBI numbers match or 1 is blank
		ds_all_crim_recs := join(ds_all_crim_recs_fbi, ids, 
		    left.acctno = right.acctno and 
				ut.nneq(left.off_fbi_number,right.input_fbi_num),
				transform(left),
				inner,
				limit(0), 
				keep(1));   //lookup the input fbi_num for an Acctno
		
	       ds_crim_offenses_top5 :=
				      topn( group( sort( ds_all_crim_recs, acctno, -(unsigned)isSexOffense, -(unsigned)(Off_Arrest_Level_Degree[1] = 'F'), 
				                                             -(unsigned)(Off_Arrest_Level_Degree[1] = 'M'),-sortby_date), 
  				    		  acctno ), 
 					        5, acctno );
		// Group-Denormalize into the final output layout and return.
		ERO_Services.Layouts.CriminalOffenses_out xfm_to_final_layout(ERO_Services.Layouts.CriminalOffenses_out le, dataset(layout_offenses_slim) offenses) :=
			transform
					self.Off_1                        := offenses[1].Off,
					self.Off_Date_1                   := offenses[1].Off_Date, 
					self.Off_Sentence_1               := offenses[1].Off_Sentence,              
					self.Off_Sentence_Date_1          := offenses[1].Off_Sentence_Date,         
					self.Off_Incarceration_Date_1     := offenses[1].Off_Incarceration_Date,
					self.Off_Court_Name_1             := offenses[1].Off_Court_Name,              
					self.Off_Court_Case_Number_1      := offenses[1].Off_Court_Case_Number,
					self.Off_Jurisdiction_State_1     := offenses[1].Off_Jurisdiction_State,
					self.Off_Adjudication_1           := offenses[1].Off_Adjudication,          
					self.Off_Adjudication_Date_1      := offenses[1].Off_Adjudication_Date,     
					self.Off_FBI_Number_1             := offenses[1].Off_FBI_Number,
					self.Off_DOC_Number_1             := offenses[1].Off_DOC_Number,              
					self.Off_Sex_Off_Registry_Id_1    := offenses[1].Off_Sex_Off_Registry_Id,   
					self.Off_Arrest_Date_1            := offenses[1].Off_Arrest_Date,           
					self.Off_Arrest_Level_Degree_1    := offenses[1].Off_Arrest_Level_Degree,   
					self.Off_Court_Fine_1             := offenses[1].Off_Court_Fine,            
					self.Off_Court_Plea_1             := offenses[1].Off_Court_Plea,            
					self.Off_Court_Disposition_1      := offenses[1].Off_Court_Disposition,     
					self.Off_Court_Disposition_Date_1 := offenses[1].Off_Court_Disposition_Date,
					self.Off_Suspended_Time_1         := '', // available in Corrections.layout_CourtOffenses, but not utilized in iesp.criminal.t_CrimReportCourtSentence
					self.Off_Party_Status_1           := offenses[1].Off_Party_Status,

					self.Off_2                        := offenses[2].Off,
					self.Off_Date_2                   := offenses[2].Off_Date, 
					self.Off_Sentence_2               := offenses[2].Off_Sentence,              
					self.Off_Sentence_Date_2          := offenses[2].Off_Sentence_Date,         
					self.Off_Incarceration_Date_2     := offenses[2].Off_Incarceration_Date,
					self.Off_Court_Name_2             := offenses[2].Off_Court_Name,              
					self.Off_Court_Case_Number_2      := offenses[2].Off_Court_Case_Number,
					self.Off_Jurisdiction_State_2     := offenses[2].Off_Jurisdiction_State,
					self.Off_Adjudication_2           := offenses[2].Off_Adjudication,          
					self.Off_Adjudication_Date_2      := offenses[2].Off_Adjudication_Date,     
					self.Off_FBI_Number_2             := offenses[2].Off_FBI_Number,
					self.Off_DOC_Number_2             := offenses[2].Off_DOC_Number,              
					self.Off_Sex_Off_Registry_Id_2    := offenses[2].Off_Sex_Off_Registry_Id,   
					self.Off_Arrest_Date_2            := offenses[2].Off_Arrest_Date,           
					self.Off_Arrest_Level_Degree_2    := offenses[2].Off_Arrest_Level_Degree,   
					self.Off_Court_Fine_2             := offenses[2].Off_Court_Fine,            
					self.Off_Court_Plea_2             := offenses[2].Off_Court_Plea,            
					self.Off_Court_Disposition_2      := offenses[2].Off_Court_Disposition,     
					self.Off_Court_Disposition_Date_2 := offenses[2].Off_Court_Disposition_Date,
					self.Off_Suspended_Time_2         := '', // available in Corrections.layout_CourtOffenses, but not utilized in iesp.criminal.t_CrimReportCourtSentence
					self.Off_Party_Status_2           := offenses[2].Off_Party_Status,

					self.Off_3                        := offenses[3].Off,
					self.Off_Date_3                   := offenses[3].Off_Date, 
					self.Off_Sentence_3               := offenses[3].Off_Sentence,              
					self.Off_Sentence_Date_3          := offenses[3].Off_Sentence_Date,         
					self.Off_Incarceration_Date_3     := offenses[3].Off_Incarceration_Date,
					self.Off_Court_Name_3             := offenses[3].Off_Court_Name,              
					self.Off_Court_Case_Number_3      := offenses[3].Off_Court_Case_Number,
					self.Off_Jurisdiction_State_3     := offenses[3].Off_Jurisdiction_State,
					self.Off_Adjudication_3           := offenses[3].Off_Adjudication,          
					self.Off_Adjudication_Date_3      := offenses[3].Off_Adjudication_Date,     
					self.Off_FBI_Number_3             := offenses[3].Off_FBI_Number,
					self.Off_DOC_Number_3             := offenses[3].Off_DOC_Number,              
					self.Off_Sex_Off_Registry_Id_3    := offenses[3].Off_Sex_Off_Registry_Id,   
					self.Off_Arrest_Date_3            := offenses[3].Off_Arrest_Date,           
					self.Off_Arrest_Level_Degree_3    := offenses[3].Off_Arrest_Level_Degree,   
					self.Off_Court_Fine_3             := offenses[3].Off_Court_Fine,            
					self.Off_Court_Plea_3             := offenses[3].Off_Court_Plea,            
					self.Off_Court_Disposition_3      := offenses[3].Off_Court_Disposition,     
					self.Off_Court_Disposition_Date_3 := offenses[3].Off_Court_Disposition_Date,
					self.Off_Suspended_Time_3         := '', // available in Corrections.layout_CourtOffenses, but not utilized in iesp.criminal.t_CrimReportCourtSentence
					self.Off_Party_Status_3           := offenses[3].Off_Party_Status,

					self.Off_4                        := offenses[4].Off,
					self.Off_Date_4                   := offenses[4].Off_Date, 
					self.Off_Sentence_4               := offenses[4].Off_Sentence,              
					self.Off_Sentence_Date_4          := offenses[4].Off_Sentence_Date,         
					self.Off_Incarceration_Date_4     := offenses[4].Off_Incarceration_Date,
					self.Off_Court_Name_4             := offenses[4].Off_Court_Name,              
					self.Off_Court_Case_Number_4      := offenses[4].Off_Court_Case_Number,
					self.Off_Jurisdiction_State_4     := offenses[4].Off_Jurisdiction_State,
					self.Off_Adjudication_4           := offenses[4].Off_Adjudication,          
					self.Off_Adjudication_Date_4      := offenses[4].Off_Adjudication_Date,     
					self.Off_FBI_Number_4             := offenses[4].Off_FBI_Number,
					self.Off_DOC_Number_4             := offenses[4].Off_DOC_Number,              
					self.Off_Sex_Off_Registry_Id_4    := offenses[4].Off_Sex_Off_Registry_Id,   
					self.Off_Arrest_Date_4            := offenses[4].Off_Arrest_Date,           
					self.Off_Arrest_Level_Degree_4    := offenses[4].Off_Arrest_Level_Degree,   
					self.Off_Court_Fine_4             := offenses[4].Off_Court_Fine,            
					self.Off_Court_Plea_4             := offenses[4].Off_Court_Plea,            
					self.Off_Court_Disposition_4      := offenses[4].Off_Court_Disposition,     
					self.Off_Court_Disposition_Date_4 := offenses[4].Off_Court_Disposition_Date,
					self.Off_Suspended_Time_4         := '', // available in Corrections.layout_CourtOffenses, but not utilized in iesp.criminal.t_CrimReportCourtSentence
					self.Off_Party_Status_4           := offenses[4].Off_Party_Status,

					self.Off_5                        := offenses[5].Off,
					self.Off_Date_5                   := offenses[5].Off_Date, 
					self.Off_Sentence_5               := offenses[5].Off_Sentence,              
					self.Off_Sentence_Date_5          := offenses[5].Off_Sentence_Date,         
					self.Off_Incarceration_Date_5     := offenses[5].Off_Incarceration_Date,
					self.Off_Court_Name_5             := offenses[5].Off_Court_Name,              
					self.Off_Court_Case_Number_5      := offenses[5].Off_Court_Case_Number,
					self.Off_Jurisdiction_State_5     := offenses[5].Off_Jurisdiction_State,
					self.Off_Adjudication_5           := offenses[5].Off_Adjudication,          
					self.Off_Adjudication_Date_5      := offenses[5].Off_Adjudication_Date,     
					self.Off_FBI_Number_5             := offenses[5].Off_FBI_Number,
					self.Off_DOC_Number_5             := offenses[5].Off_DOC_Number,              
					self.Off_Sex_Off_Registry_Id_5    := offenses[5].Off_Sex_Off_Registry_Id,   
					self.Off_Arrest_Date_5            := offenses[5].Off_Arrest_Date,           
					self.Off_Arrest_Level_Degree_5    := offenses[5].Off_Arrest_Level_Degree,   
					self.Off_Court_Fine_5             := offenses[5].Off_Court_Fine,            
					self.Off_Court_Plea_5             := offenses[5].Off_Court_Plea,            
					self.Off_Court_Disposition_5      := offenses[5].Off_Court_Disposition,     
					self.Off_Court_Disposition_Date_5 := offenses[5].Off_Court_Disposition_Date,
					self.Off_Suspended_Time_5         := '', // available in Corrections.layout_CourtOffenses, but not utilized in iesp.criminal.t_CrimReportCourtSentence
					self.Off_Party_Status_5           := offenses[5].Off_Party_Status,
					
					self := le,
					self := []
			end;
		
		results := 
			denormalize(
				ds_final_with_offenders, 
				ds_crim_offenses_top5,
				left.acctno = right.acctno,
				group,
				xfm_to_final_layout(left, rows(right))
			);
		

		  //output(ds_sex_offenders,named('sexoff'));
		 
		 // OUTPUT( out_mskd , NAMED('out_mskd') );
		 // OUTPUT( offender_recs , NAMED('offender_recs') );
		 // OUTPUT( criminal_records_rpt , NAMED('criminal_records_rpt') );
		 // OUTPUT( criminal_records_rpt.offenses[1].court , NAMED('criminal_records_rptcourt') );
		 // OUTPUT( criminal_records_rpt_fbi , NAMED('criminal_records_rpt_fbi') );
		 // OUTPUT( ds_criminal_records , NAMED('ds_criminal_records') );
		 // OUTPUT( ds_results_crim_recs , NAMED('ds_results_crim_recs') );
		 // OUTPUT( ds_criminal_record_akas  , NAMED('ds_criminal_record_akas') );
		 // OUTPUT( ds_results_crim_recs  , NAMED('ds_results_crim_recs') );
		 // OUTPUT( ds_crim_offenses , NAMED('ds_crim_offenses') );
		 // OUTPUT( ds_crim_offenses_with_sortby_date , NAMED('ds_crim_offenses_with_sortby_date') );
		  
		 // OUTPUT( ds_crim_offenses_dups  , NAMED('ds_crim_offenses_dups') );
		 // OUTPUT( ds_crim_offenses_top5 , NAMED('ds_crim_offenses_top5') );
		
		return results;
		
	end;
