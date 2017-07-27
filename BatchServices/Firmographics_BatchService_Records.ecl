import Business_Header,  corp2, DCA, Batchservices, EBR, autostandardi, MDR, doxie_cbrs, Business_Header_SS, ut, STD;

export Firmographics_BatchService_Records(boolean useCannedRecs, 
          AutoStandardI.DataRestrictionI.params in_mod) := module

	shared BatchServices.Firmographics_BatchService_Layouts.layout_batch_out 
	          xfm_firmographics_make_flat(BatchServices.Firmographics_BatchService_Layouts.rec_results_raw le,
								                        DATASET(BatchServices.Firmographics_BatchService_Layouts.rec_results_raw) allRows) := 
		TRANSFORM
	
			SELF.acctno                        := le.acctno;
					
      self.CompanyName_1                 := allRows[1].CompanyName;			
			self.phone_1						           := allRows[1].phone;
			self.fax_1                         := allRows[1].fax;
			self.YearStarted_1                 := allRows[1].YearStarted;
			self.YearsInbusiness_1             := allRows[1].YearsInBusiness;
			self.parentCompanyName_1           := allRows[1].parentCompanyName;
			self.url_1                         := allRows[1].url;
			self.fein_1                        := allRows[1].fein;
			self.tickerSymbol_1                := allRows[1].tickerSymbol;
			self.sales_1                       := (unsigned6) allRows[1].sales; 
			self.netWorth_1                    := allRows[1].netWorth;		
			self.NumEmployees_1                := allRows[1].NumEmployees;
			
      self.CompanyName_2                 := allRows[2].CompanyName;			
			self.phone_2 						           := allRows[2].phone;
			self.fax_2                         := allRows[2].fax;
			self.YearStarted_2                 := allRows[2].YearStarted;
			self.YearsInbusiness_2             := allRows[2].YearsInBusiness;
			self.parentCompanyName_2           := allRows[2].parentCompanyName;
			self.url_2                         := allRows[2].url;
			self.fein_2                        := allRows[2].fein;
			self.tickerSymbol_2                := allRows[2].tickerSymbol;
			self.sales_2                       := (unsigned6) allRows[2].sales; // may need formatting
			self.netWorth_2                    := allRows[2].netWorth;			
			self.NumEmployees_2                := allRows[2].NumEmployees;
			
      self.CompanyName_3                 := allRows[3].CompanyName;			
			self.phone_3 						           := allRows[3].phone;
			self.fax_3                         := allRows[3].fax;
			self.YearStarted_3                 := allRows[3].YearStarted;
			self.YearsInbusiness_3             := allRows[3].YearsInBusiness;
			self.parentCompanyName_3           := allRows[3].parentCompanyName;
			self.url_3                         := allRows[3].url;
			self.fein_3                        := allRows[3].fein;
			self.tickerSymbol_3                := allRows[3].tickerSymbol;
			self.sales_3                       := (unsigned6) allRows[3].sales; // may need formatting
			self.netWorth_3                    := allRows[3].netWorth;			
			self.NumEmployees_3                := allRows[3].NumEmployees;
			
			self.CompanyName_4                 := allRows[4].CompanyName;
			self.phone_4 						           := allRows[4].phone;
			self.fax_4                         := allRows[4].fax;
			self.YearStarted_4                 := allRows[4].YearStarted;
			self.YearsInbusiness_4             := allRows[4].YearsInBusiness;
			self.parentCompanyName_4           := allRows[4].parentCompanyName;
			self.url_4                         := allRows[4].url;
			self.fein_4                        := allRows[4].fein;
			self.tickerSymbol_4                := allRows[4].tickerSymbol;
			self.sales_4                       := (unsigned6) allRows[4].sales; // may need formatting
			self.netWorth_4                    := allRows[4].netWorth;			
			self.NumEmployees_4                := allRows[4].NumEmployees;
			
      self.CompanyName_5                 := allRows[5].CompanyName;			
			self.phone_5 						           := allRows[5].phone;
			self.fax_5                         := allRows[5].fax;
			self.YearStarted_5                 := allRows[5].YearStarted;
			self.YearsInbusiness_5             := allRows[5].YearsInBusiness;
			self.parentCompanyName_5           := allRows[5].parentCompanyName;
			self.url_5                         := allRows[5].url;
			self.fein_5                        := allRows[5].fein;
			self.tickerSymbol_5                := allRows[5].tickerSymbol;
			self.sales_5                       := (unsigned6) allRows[5].sales; // may need formatting
			self.netWorth_5                    := allRows[5].netWorth;			
			self.NumEmployees_5                := allRows[5].NumEmployees;
			
      self.CompanyName_6                 := allRows[6].CompanyName;			
			self.phone_6 						           := allRows[6].phone;
			self.fax_6                         := allRows[6].fax;
			self.YearStarted_6                 := allRows[6].YearStarted;
			self.YearsInbusiness_6             := allRows[6].YearsInBusiness;
			self.parentCompanyName_6           := allRows[6].parentCompanyName;
			self.url_6                         := allRows[6].url;
			self.fein_6                        := allRows[6].fein;
			self.tickerSymbol_6                := allRows[6].tickerSymbol;
			self.sales_6                       := (unsigned6) allRows[6].sales; // may need formatting
			self.netWorth_6                    := allRows[6].netWorth;			
			self.NumEmployees_6                := allRows[6].NumEmployees;
		
	end; // transform
 // Local layouts.

	export Results := function
       
    UNSIGNED4 tmp_max_results_per_acct := 100 : STORED('max_results_per_acct');
		
		UNSIGNED4 max_results_per_acct :=  IF ( tmp_max_results_per_acct > 1000, 1000, 
				                                           tmp_max_results_per_acct
				                                           ); 
    // this line is here for future reference in case suppression is needed.
		// apptype is used as an input param into the standard supression macro which may be used in the future
		// as a standard call in all batch services.  It is currently not used.
		appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));			 			 
		
    	/* ***** System flags and values ***** */
		BOOLEAN forceSeqNumber  := TRUE;
		
		/* ***** Constants ***** */
		INTEGER FOR_PARENT      := 1;  // : for retrieving parent records				

    // 1. Accept input records.		
		ds_batch_in := IF( NOT useCannedRecs, 
		                   BatchServices.file_inBatchMaster(forceSeqNumber), 
		                   BatchServices._Sample_inBatchMaster('FIRMOGRAPHICS') 
                      );
											
    // to ensure no duplicate acctno's and slim to proper layout
		ds_batch_in_slim := project(dedup(sort(ds_batch_in, acctno, record), acctno),
		                            BatchServices.Firmographics_BatchService_Layouts.layout_batch_in);
		
		inBatch_rec := rECORD
				String20  acctno;
				Business_Header_SS.Layout_BDID_InBatch;			
		END;

		inBatch_rec xfm_clean_input(ds_batch_in_slim in_data, unsigned c) := TRANSFORM
			SELF.company_name := STD.Str.ToUpperCase(in_data.comp_name);
			SELF.prim_range := STD.Str.ToUpperCase(in_data.prim_range);
			SELF.predir := STD.Str.ToUpperCase(in_data.predir);
			SELF.prim_name := STD.Str.ToUpperCase(in_data.prim_name);
			SELF.addr_suffix := STD.Str.ToUpperCase(in_data.addr_suffix);
			SELF.postdir := STD.Str.ToUpperCase(in_data.postdir);
			SELF.unit_desig := STD.Str.ToUpperCase(in_data.unit_desig);
			SELF.sec_range := STD.Str.ToUpperCase(in_data.sec_range);
			SELF.p_city_name := STD.Str.ToUpperCase(in_data.p_city_name);
			SELF.st := STD.Str.ToUpperCase(in_data.st);
			SELF.phone10 := (string10)choose(c,in_data.homephone,in_data.workphone);
			SELF.z5 := if(in_data.z5 != '',in_data.z5,ziplib.CityToZip5(self.st,self.p_city_name));
			SELF := in_data;
		END;
    
		// normalized here so as to add the work phone to home phone.
		cleaned_in := NORMALIZE(ds_batch_in_slim(bdid = 0),2,xfm_clean_input(LEFT,COUNTER));														 

		Business_Header_SS.MAC_BDID_Append(cleaned_in,cleaned_outBdid,1)		
		
		bdid_append_results := dedup(sort(cleaned_outBdid,seq,-score,bdid),seq);
				
		BatchServices.Firmographics_BatchService_Layouts.layout_batch_in
		    xfm_best_res(recordof(cleaned_in) l,recordof(bdid_append_results) r) := TRANSFORM
				// SELF.process_date := r.dt_last_seen;
				SELF.comp_name := r.best_companyname;
				// SELF.street       := r.best_addr1;
				// SELF.city         := r.best_city;
				// SELF.state        := r.best_state;
				// SELF.zip          := r.best_zip;
				// SELF.phone        := r.best_phone;
				SELF.bdid         := r.bdid;
				SELF.acctno       := l.acctno;
				SELF := [];
		END;

		bdid_append_results_acctno := JOIN(cleaned_in,bdid_append_results
														,LEFT.seq = RIGHT.seq
														,xfm_best_res(LEFT,RIGHT));
		
		// 2. join against various keys and get data.    
				
		temp_layout := record
					BatchServices.Firmographics_BatchService_Layouts.rec_results_raw;
					unsigned6 bdid;					
		end;
		
		ds_batch_in_BDID := dedup(sort(bdid_append_results_acctno + ds_batch_in_slim(bdid != 0),acctno,record),acctno);
		         
		
		FirmPhoneFeinRecs := Join(ds_batch_in_BDID, Business_Header.Key_BH_Best, 
		  keyed (left.bdid = right.bdid) and
			not BatchServices.Firmographics_BatchService_Functions(in_mod).isRestricted(right.source),								             			
		  transform(temp_layout,
				self.acctno := left.acctno;
				self.bdid := left.bdid;
				self.fein := right.fein;
			  self.phone := right.phone;
				self.CompanyName := if (left.comp_name = '', right.company_name, left.comp_name);
				self.fax := '';
				self := [];
			), left outer, keep (1), limit (0));
								 
		Corp2Recs := join(FirmPhoneFeinRecs,  Corp2.Key_Corp_BdidPL,
			keyed(left.bdid = right.bdid) and
			right.record_type = 'C',			
			transform({recordof(temp_layout); string1 record_type;},                  										 
				self.acctno := left.acctno;									
				self.bdid := left.bdid;
				self.yearStarted := (unsigned4) right.corp_inc_date;	
				self.record_type := right.record_type;
				self.CompanyName := if (left.companyName = '', right.corp_legal_name, left.companyName);
				self := left,
				self := []), left outer, limit(5000));
									
    corp2RecsWBdidSorted := sort(corp2Recs(yearStarted != 0 and record_type ='C'), acctno, bdid, yearStarted);
		
		// do a left only join using corp2Recs against  corp2RecsWBdidSorted
		// in order to keep recs from Corpt2Recs set that have a null yearStarted
		// from being filtered out
		
		tempcorp2RecsFinal := join(corp2Recs, corp2RecsWBdidSorted,
			left.acctno = right.acctno and
			left.bdid = right.bdid,
		  transform({recordof(temp_layout);string1 record_type;},			
        self := left,											   
			   ), 
		  left only);			
		//
		// sort and project to the predefined layout
		// since record_type no longer needed.
    corp2RecsFinal := project(sort(corp2RecsWBdidSorted + tempCorp2RecsFinal, acctno, bdid, record), temp_layout);
    
		temp_layout corp2RolledXform(temp_layout l, temp_layout r) := transform
		  self := l;
		  self := r;
		end;

    corp2RecsFinalRolled := rollup(sort(Corp2RecsFinal, acctno, bdid, yearStarted, record),
		  left.acctno = right.acctno and
		  left.bdid = right.bdid,
			corp2rolledXform(left, right));		
			
		string8 CurDate := stringlib.getDateYYYYMMDD();	
    //																		
    // now set yearsInBusiness.
		//		
    yearStartedRecsRolled2 := project(corp2RecsFinalRolled, 
		  transform(recordof(left),
				tempYearStarted := left.yearStarted;
		    self.yearsInBusiness := if (tempYearStarted <> 0, 
																   (if ((unsigned4) CurDate[1..4] - (unsigned4) tempYearStarted[1..4] > 0,
																        (unsigned4) CurDate[1..4] - (unsigned4) tempYearStarted[1..4], 
																		0))
																,0);
			  self := left;
		));
		
    bdid_only := project(yearStartedRecsrolled2, doxie_cbrs.layout_references);
		
		integer RETR_PARENT := 1; // For retrieving parent records in doxie_cbrs.get_DCA_Records
   
	   //  Get parent company information.
  // NOTE: In DCA, the root-sub expression is a compound value: 
	// the root (nine digits), followed by a dash, followed by the sub(sidiary) value
	// (four digits). e.g. 123456789-1234. 
	// The root denotes the top-level company at the head of a conglomerate or set of 
	// subsidiaries. e.g. lexisnexis RiskSolution's root is Reed-Elsevier. 
	// The sub is simply a surrogate identifier denoting a particular subsidiary in the 
	// root's tree. 
	// Therefore in the code below you'll see the expression:
  //     LEFT.parent_number[1..9]  = RIGHT.root AND
  //     LEFT.parent_number[11..14] = RIGHT.sub
  // Where [1..9] refers to the root portion of the parent_number and [11..14] refers 
	// to the sub portion of the parent_number. We omit [10] of course, which is a dash.

  // part1 of get Parent company. First for the deduped bdids, get the level, root, sub & parent_number info
	// from the DCA bdid key file.
	
	  rec_temp_dca := RECORD
		  string2  Level;
		  string9  Root;
		  string4  Sub;
		  string15 Parent_Number;
		  unsigned6 bdid;
		  qstring120 parentCompanyName;
	  END;
	
	  ds_bdids_dca_added := JOIN(bdid_only,DCA.Key_DCA_BDID,
			                         keyed(LEFT.bdid = RIGHT.bdid),
			                       TRANSFORM(rec_temp_dca,
				                       SELF.level         := RIGHT.level,
												       SELF.root          := RIGHT.root,
												       SELF.sub           := RIGHT.sub,
												       SELF.parent_number := RIGHT.parent_number,
															 self.ParentCompanyName := '';
				                       SELF := LEFT),
			                       KEEP(1),LIMIT (ut.limits.MAX_DCA_PER_BDID), LEFT OUTER);

    // part2 of get parent company. Next get parent company info for each bdid with a non-blank DCA root value.
    ds_parents := doxie_cbrs.get_DCA_records(project(ds_bdids_dca_added(root != ''),doxie_cbrs.layout_references), RETR_PARENT);

    // part3 Next attach the parent company info to the bdids with DCA data.
	  ds_bdids_with_parent := JOIN(ds_bdids_dca_added, ds_parents,
		                             LEFT.parent_number[1..9]  = RIGHT.root AND
																 // NOTE: position 10 = '-'; so it is skipped
		                             LEFT.parent_number[11..14] = RIGHT.sub,
															 TRANSFORM(rec_temp_dca,
															   // Get parent company fields from right file
		                             SELF.parentCompanyName := STD.Str.ToUpperCase(RIGHT.Name);		                           
																 // Keep rest of data from left file
			                           SELF                     := LEFT),
															 LEFT OUTER, LIMIT(5000,SKIP));

    yearStartedRecsRolled2withParentCompanyName := join(yearStartedRecsRolled2,ds_bdids_with_parent, 													 
		                                                     left.bdid = right.bdid,
																												 transform(recordof(left),
																												 self.parentCompanyName := right.parentCompanyName;
																												 self := left), left outer, limit(5000));
		
    DCARecs := join(yearStartedRecsRolled2withParentCompanyName, DCA.Key_DCA_BDID,
			left.bdid = right.bdid,// AND		 
		  transform(temp_layout,											           														
				self.parentCompanyName := if (left.parentCompanyName = '', right.Parent_Name, left.parentCompanyName);
			  self.url          := right.url;
				self.CompanyName  := if (left.companyName = '', right.name, left.companyName);
				self.tickerSymbol := right.Ticker_Symbol;
				self.sales        := (unsigned6) right.sales;
				self.networth     := right.net_worth_;
				self.numEmployees := right.EMP_NUM;
				self.fax          := right.fax;
			  self := left
			   // keeps acctno, bdid, phone, yearStarted, YearsInBusiness, fein which are already set.				
			), left outer,limit(5000));
															   		 
	  temp_layout dcRolled(temp_layout l, temp_layout r) := transform
		   self.parentcompanyName := if (l.parentcompanyName = '', r.parentCompanyname,l.parentCompanyName);
			 self := l;
		end;
		   //
	   // Rollup with sort is done so as to keep recs with fein, url, tickerSymbol, sales, networth information
		 // and parent company information and collaspe if possible into rollup recs that don't have this info.
    DCARecsRolled := rollup(sort(DCARecs,acctno, bdid,phone, fein, -sales, 
		                  -networth, if (parentcompanyName <> '', 0, 1), length(url), -numEmployees, record),
		   left.acctno = right.acctno and
		   left.bdid = right.bdid and
			 left.phone = right.phone and
			 left.fein = right.fein,
			 dcRolled(left, right));
															   															
    EBRRecs := join(DCARecsRolled, EBR.Key_5600_Demographic_Data_BDID,
       keyed(left.bdid = right.bdid) and
		   right.record_type = 'C' and // to get only current recs
			 not BatchServices.Firmographics_BatchService_Functions(in_mod).isRestricted(MDR.sourceTools.src_EBR),
			 transform(recordof(BatchServices.Firmographics_BatchService_Layouts.rec_results_raw),														         
         self.acctno := left.acctno;
				 self.yearsInBusiness := (unsigned2)( if (right.yrs_in_bus_actual ='', left.yearsInBusiness, (unsigned2) right.yrs_in_bus_actual));
				 mappedChar := map(right.sales_actual[7]= '{' => '0',
						right.sales_actual[7]= 'A' => '1',
					right.sales_actual[7]= 'B' => '2',
					right.sales_actual[7]= 'C' => '3',
					right.sales_actual[7]= 'D' => '4',
					right.sales_actual[7]= 'E' => '5',
					right.sales_actual[7]= 'F' => '6',
					right.sales_actual[7]= 'G' => '7',
					right.sales_actual[7]= 'H' => '8',
	        right.sales_actual[7]= 'I' => '9',																							
					right.sales_actual[7]= 'J' => '0',
					// right.sales_actual[7]= 'K' => '-1',
					// right.sales_actual[7]= 'L'
					// right.sales_actual[7]= 'M'
					// right.sales_actual[7]= 'N'
					// right.sales_actual[7]= 'O'
					// right.sales_actual[7]= 'P'
					// right.sales_actual[7]= 'Q'
					// right.sales_actual[7]= 'R'
					//^--- convert position 7 which is an EBCDIC signed value
          //              "{" & A thru I to +0 thru +9 AND "}" & J thru R to -0 thru -9 
					// cept nothing negative in the file.
					'');
															
					tempsalesEBR := (((unsigned)(right.sales_actual[1..6] + mappedChar)) * 1000); 
					     //per specs of EBR data it is in hundreds of thousands.
					self.sales := (unsigned) if (tempSalesEBR = 0, left.sales, tempSalesEBR);
					self := left
					), 
				left outer,limit(5000));															           														
		      												
		// 3.  Sort and group by acctno
		ds_results_grouped := group(sort(EBRRecs, acctno), acctno);
			
    ds_results_grouped_TOPX := TOPN(ds_results_grouped, max_results_per_acct, acctno);			
    // 4. At this point, 'flatten' the resultant records into the specified output layout using ostensibly															
		ds_results_rolled_flat := ROLLUP(ds_results_grouped_TOPX, GROUP, xfm_firmographics_make_flat(LEFT, ROWS(LEFT)));		

    // output(bdid_append_results, named('bdid_append_results'));
    // output(FirmPhoneFeinRecs, named('FirmPhoneFeinRecs'));
		// output(Corp2Recs, named('Corp2Recs'));
		// output(corp2RecsWBdidSorted, named('corp2RecsWBdidSorted'));
		// output(tempcorp2RecsFinal, named('tempcorp2RecsFinal'));
		// output(corp2RecsFinal, named('corp2RecsFinal'));
		// output(yearStartedRecsRolled2, named('yearStartedRecsRolled2'));
		 // output(ds_bdids_with_parent, named('ds_bdids_with_parent'));
		 // output(yearStartedRecsRolled2withParentCompanyName, named('yearStartedRecsRolled2withParentCompanyName'));
		 // output(DCARecs, named('DCARecs'));
		 
		// output(DCARecsRolled, named('DCARecsRolled'));
		// output(EBRRecs, named('EBRRecs'));
		
    return(ds_results_rolled_flat);
		end; // function

end;