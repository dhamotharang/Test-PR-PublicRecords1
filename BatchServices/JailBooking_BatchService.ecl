
/*--SOAP--
<message name="JailBooking_BatchService">
	<part name="GLBPurpose"          type="xsd:byte" 	default="1"/>
	<part name="DPPAPurpose"         type="xsd:byte" 	default="1"/>
		
	<part name="Max_Results"           type="xsd:unsignedInt"/>
	<part name="Max_Results_Per_Acct" type="xsd:unsignedInt"/>

	<part name="Run_Deep_Dive"        type="xsd:boolean"/>
	<part name="PenaltThreshold"    type="xsd:unsignedInt"/>
  <part name="Nicknames" type="xsd:boolean"/>
  <part name="Phonetics" type="xsd:boolean"/>
  <part name="IncludeNameVariations" type="xsd:boolean"/>
  <part name="ScoreThreshold" 		type="xsd:unsignedInt"/>
  <part name="StrictMatch" 		type="xsd:boolean"/>
  <part name="SearchGoodSSNOnly" 		type="xsd:boolean"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

/* NOTES
	TODO: implement 'MaxResults' properly.
*/
 /*--HELP-- 
 <pre>
 &lt;batch_in&gt;
  &lt;Row&gt;
    &lt;acctno&gt;&lt;/acctno&gt;
    &lt;name_last&gt;&lt;/name_last&gt;
    &lt;name_first&gt;&lt;/name_first&gt;
    &lt;name_middle&gt;&lt;/name_middle&gt;
    &lt;SSN&gt;&lt;/SSN&gt;
    &lt;DOB&gt;&lt;/DOB&gt;
    &lt;FBI_Number&gt;&lt;/FBI_Number&gt;
    &lt;Alien_Number&gt;&lt;/Alien_Number&gt;
    &lt;DL&gt;&lt;/DL&gt;
    &lt;State_ID_Number&gt;&lt;/State_ID_Number&gt;
    &lt;ScoreThreshold&gt;&lt;/ScoreThreshold&gt;
    &lt;StrictMatch&gt;&lt;/StrictMatch&gt;
    &lt;SearchGoodSSNOnly&gt;&lt;/SearchGoodSSNOnly&gt;
  &lt;/Row&gt;
 &lt;/batch_in&gt;
 </pre>
*/
IMPORT Appriss,AutoStandardI, Autokey_batch,AutokeyB2_batch, BatchServices, JailBooking_Services;

#warning('Service no longer used as of 09/26/2012.')
EXPORT JailBooking_BatchService(useCannedRecs = 'false') := 
	MACRO
	
	  INTEGER max_results             := BatchServices.Constants.JailBooking.MAX_RESULTS : STORED('Max_Results');
		INTEGER max_results_per_acct    := BatchServices.Constants.JailBooking.MAX_RESULTS_PER_ACCT : STORED('Max_Results_Per_Acct');

		BOOLEAN name_variations         := false  : STORED('IncludeNameVariations');
		#stored('allowFuzzyDOBMatch', FALSE);  //this service only allows for LastFirst when DOB matching is used so disable fuzzy dob matching.
		#stored('useOnlyBestDID', TRUE);  //
		
		
		ds_xml_in      := DATASET([], BatchServices.Layouts.JailBooking.layout_inJailBookingBatch) : STORED('batch_in', FEW);

		ds_xml_in  UpperName(ds_xml_in l) := transform
		  self.name_last :=  StringLib.StringToUpperCase(l.name_Last);
		  self.name_First :=  StringLib.StringToUpperCase(l.name_First);
		  self.name_Middle :=  StringLib.StringToUpperCase(l.name_Middle);
			self.fbi_number := StringLib.StringToUpperCase(l.fbi_number);
			self := l;
		end;
		//upperCase all the incoming Name fields
		ds_xml_upper := PROJECT(ds_xml_in, UpperName(LEFT));

		// if name_variations are requested generate multiple input rows with various name variations. 
		// NOTE: this is a specialized request for this process in order to closely match an existing custom thor job.
    ds_xml_cleaned := IF (name_variations, BatchServices.JailBooking_Functions.fn_generate_names(ds_xml_upper), ds_xml_upper);
		
		//use dummy input requests if asked useCannedRecs = true.
		BatchServices.Layouts.JailBooking.layout_inJailBookingBatch fillCanned(Autokey_batch.Layouts.rec_inBatchMaster l) := transform
		   self := l;
			 self.fbi_number := 'SampleFbiNumber';
			 self.alien_number := 'SampleAlienNumber';
			 self.state_id_number := 'SampleStateID';
			 self.Min_Booking_Date := '';
			 self.Max_Booking_Date := '';
		end;
		ds_canned := project(BatchServices._Sample_inBatchMaster('JailBooking'), fillCanned(LEFT));
		ds_canned_cleaned := IF (name_variations, BatchServices.JailBooking_Functions.fn_generate_names(ds_canned), ds_canned);
		
		ds_batch_in    := IF( NOT useCannedRecs, 
		                      ds_xml_upper , 
		                      ds_canned 
                         );		
    
		ds_batch_in_w_names := IF (NOT useCannedRecs,
		                           ds_xml_cleaned,
															 ds_canned_cleaned
		                          );
		p := BatchServices.JailBooking_BatchService_Records(ds_batch_in_w_names);
    BatchServices.layouts.JailBooking.out_normalized  combineIt(p.ds_all_ids L, p.results R) := transform
		   self:= l;
			 self:= r;
		end;
		// will not have input records with no booking ids found...could be empty.
		ds_recs := JOIN(p.ds_all_ids, p.results,
		                     LEFT.ACCTNO = RIGHT.ACCTNO AND
		                     LEFT.booking_sid = RIGHT.booking_sid,
												 combineIt(LEFT, RIGHT),
		                     INNER);
    // put back all acctno found in input recs.
     BatchServices.layouts.JailBooking.out_normalized  AtLeast1perAcct(ds_batch_in L, ds_recs R) := transform
		   self.acctno := l.acctno;
		   self:= r;		  
			self:= l;
		 end;
		ds_recs_acctno := JOIN(ds_batch_in, ds_recs, LEFT.ACCTNO = RIGHT.ACCTNO, AtLeast1perAcct(LEFT, RIGHT), LEFT OUTER);
		
		ds_recs_grouped := GROUP(SORT(ds_recs_acctno, acctno, -booking_date), acctno);

		ds_top_recs := TOPN(ds_recs_grouped, max_results_per_acct, acctno, -booking_date);
		
		//now that we have the correct booking records get the charges.
		booking_ids := project(ungroup(ds_top_recs),JailBooking_Services.Layouts.bookingId);
		ds_charges := JailBooking_Services.Raw.getCharges(booking_ids);
				
		//// merge charges
		BatchServices.layouts.JailBooking.out_normalized loadCharges(ds_top_recs L, dataset(JailBooking_Services.Layouts.bookingCharges) R) := TRANSFORM
		  SELF.charges := SORT(choosen(R, BatchServices.Constants.JailBooking.MAX_CHARGES_OUT), -R.charge_dt, R.charge_seq);
			SELF := L;
		END;
		
		ds_bookNCharges := DENORMALIZE(ds_top_recs, ds_charges, 
																	 LEFT.booking_sid = RIGHT.booking_sid and 
																	 LEFT.agencykey = RIGHT.agencykey, 
																	 group, 
																	 loadCharges(LEFT, ROWS(RIGHT)));

	// flatten the records for output.
		BatchServices.layouts.JailBooking.out_flat flatten(ds_bookNCharges l) := transform
  	  self.charge1_booking_sid := L.charges[1].booking_sid;
			self.charge1_site_id := L.charges[1].site_id;
      self.charge1_agency := L.charges[1].agency ;
			self.charge1_charge_seq := L.charges[1].charge_seq;
			self.charge1_agencykey := L.charges[1].agencykey;
			self.charge1_charge_cnt := L.charges[1].charge_cnt;
			self.charge1_charge := L.charges[1].charge;
			self.charge1_description := L.charges[1].description;
			self.charge1_charge_dt := L.charges[1].charge_dt;
			self.charge1_court_dt := L.charges[1].court_dt;
			self.charge1_key_severity := L.charges[1].key_severity;
			self.charge1_bond_amt := L.charges[1].bond_amt;
			self.charge1_disposition_dt := L.charges[1].disposition_dt;
			self.charge1_disposition_text := L.charges[1].disposition_text;
			self.charge1_ncic_offense_class_txt := L.charges[1].ncic_offense_class_txt;
			self.charge1_ncic_offense_cd := L.charges[1].ncic_offense_cd;
			self.charge1_bond_type_txt := L.charges[1].bond_type_txt;
			self.charge2_booking_sid := L.charges[2].booking_sid;
			self.charge2_site_id :=L.charges[2].site_id;
      self.charge2_agency := L.charges[2].agency ;
			self.charge2_charge_seq := L.charges[2].charge_seq;
			self.charge2_agencykey := L.charges[2].agencykey;
			self.charge2_charge_cnt := L.charges[2].charge_cnt;
			self.charge2_charge := L.charges[2].charge;
			self.charge2_description := L.charges[2].description;
			self.charge2_charge_dt := L.charges[2].charge_dt;
			self.charge2_court_dt := L.charges[2].court_dt;
			self.charge2_key_severity := L.charges[2].key_severity;
			self.charge2_bond_amt := L.charges[2].bond_amt;
			self.charge2_disposition_dt := L.charges[2].disposition_dt;
			self.charge2_disposition_text := L.charges[2].disposition_text;
			self.charge2_ncic_offense_class_txt := L.charges[2].ncic_offense_class_txt;
			self.charge2_ncic_offense_cd := L.charges[2].ncic_offense_cd;
			self.charge2_bond_type_txt := L.charges[2].bond_type_txt;
			self.charge3_booking_sid := L.charges[3].booking_sid;
			self.charge3_site_id :=L.charges[3].site_id;
      self.charge3_agency := L.charges[3].agency ;
			self.charge3_charge_seq := L.charges[3].charge_seq;
			self.charge3_agencykey := L.charges[3].agencykey;
			self.charge3_charge_cnt := L.charges[3].charge_cnt;
			self.charge3_charge := L.charges[3].charge;
			self.charge3_description := L.charges[3].description;
			self.charge3_charge_dt := L.charges[3].charge_dt;
			self.charge3_court_dt := L.charges[3].court_dt;
			self.charge3_key_severity := L.charges[3].key_severity;
			self.charge3_bond_amt := L.charges[3].bond_amt;
			self.charge3_disposition_dt := L.charges[3].disposition_dt;
			self.charge3_disposition_text := L.charges[3].disposition_text;
			self.charge3_ncic_offense_class_txt := L.charges[3].ncic_offense_class_txt;
			self.charge3_ncic_offense_cd := L.charges[3].ncic_offense_cd;
			self.charge3_bond_type_txt := L.charges[3].bond_type_txt;
			self.charge4_booking_sid := L.charges[4].booking_sid;
			self.charge4_site_id :=L.charges[4].site_id;
      self.charge4_agency := L.charges[4].agency ;
			self.charge4_charge_seq := L.charges[4].charge_seq;
			self.charge4_agencykey := L.charges[4].agencykey;
			self.charge4_charge_cnt := L.charges[4].charge_cnt;
			self.charge4_charge := L.charges[4].charge;
			self.charge4_description := L.charges[4].description;
			self.charge4_charge_dt := L.charges[4].charge_dt;
			self.charge4_court_dt := L.charges[4].court_dt;
			self.charge4_key_severity := L.charges[4].key_severity;
			self.charge4_bond_amt := L.charges[4].bond_amt;
			self.charge4_disposition_dt := L.charges[4].disposition_dt;
			self.charge4_disposition_text := L.charges[4].disposition_text;
			self.charge4_ncic_offense_class_txt := L.charges[4].ncic_offense_class_txt;
			self.charge4_ncic_offense_cd := L.charges[4].ncic_offense_cd;
			self.charge4_bond_type_txt := L.charges[4].bond_type_txt;
			self.charge5_booking_sid := L.charges[5].booking_sid;
			self.charge5_site_id :=L.charges[5].site_id;
      self.charge5_agency := L.charges[5].agency ;
			self.charge5_charge_seq := L.charges[5].charge_seq;
			self.charge5_agencykey := L.charges[5].agencykey;
			self.charge5_charge_cnt := L.charges[5].charge_cnt;
			self.charge5_charge := L.charges[5].charge;
			self.charge5_description := L.charges[5].description;
			self.charge5_charge_dt := L.charges[5].charge_dt;
			self.charge5_court_dt := L.charges[5].court_dt;
			self.charge5_key_severity := L.charges[5].key_severity;
			self.charge5_bond_amt := L.charges[5].bond_amt;
			self.charge5_disposition_dt := L.charges[5].disposition_dt;
			self.charge5_disposition_text := L.charges[5].disposition_text;
			self.charge5_ncic_offense_class_txt := L.charges[5].ncic_offense_class_txt;
			self.charge5_ncic_offense_cd := L.charges[5].ncic_offense_cd;
			self.charge5_bond_type_txt := L.charges[5].bond_type_txt;
			self := l;
		end;

		// OUTPUT(ds_xml_cleaned,NAMED('ds_xml_cleaned'));
		// OUTPUT(P.ds_fids,NAMED('ds_fids'));
		// OUTPUT(P.ds_ids_by_autokey,NAMED('ds_ids_by_autokey'));
		// OUTPUT(P.ds_all_ids,NAMED('ds_all_ids'));
		// output(p.deep, named('out1')); 
		// output(p.ds_ak_plus_hdr, named('out2')); 
		// OUTPUT(ds_recs,NAMED('ds_recs'));
		// OUTPUT(ds_recs_acctno,NAMED('ds_recs_acctno'));
		
		// OUTPUT(P.results,NAMED('p_results'));
		// output(ds_top_recs,named('ds_top_recs'));
		// output(p.base_recs,named('base_recs'));
		// output(p.tmp_ds_input,named('tmp_ds_input'));
		// output(p.ds_pre_penalty,named('new_pre_penalty'));	
		// output(p.ds_pen,named('penthreshold'));
	   ds_flat_recs := PROJECT(ds_bookNCharges, flatten(LEFT));
		
// Start of too many match ************************************************************************		
    TOO_MANY_MATCHES := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;		
		ds_too_many_results := DEDUP(SORT(p.ds_fids(search_status = TOO_MANY_MATCHES), acctno), acctno);
		// Format for output those acctnos having too_many_matches.
		BatchServices.layouts.JailBooking.out_flat xfm_recs_having_too_many_results(AutokeyB2_batch.Layouts.rec_output_IDs_batch l) := 
			TRANSFORM
				SELF.acctno     := l.acctno;
				SELF.error_code := l.search_status;
				SELF            := [];
			END;
		ds_too_many  := PROJECT(ds_too_many_results, xfm_recs_having_too_many_results(LEFT));
		ds_all := ds_too_many + ds_flat_recs(acctNo not in set(ds_too_many,acctNo));
// End of too many match ****************************************************************************		

		ds_results := SORT(ds_all,acctno, -booking_date);
    OUTPUT(ds_results, NAMED('Results'));			
					
	ENDMACRO;	
 //JailBooking_BatchService();