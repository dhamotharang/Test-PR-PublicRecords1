
/*--SOAP--
<message name="JailBooking_BatchServiceV2">
	<part name="GLBPurpose"          	type="xsd:byte" 	default="1"/>
	<part name="DPPAPurpose"        	type="xsd:byte" 	default="1"/>
	
	<part name="Max_Results"          type="xsd:unsignedInt"/>
	<part name="Max_Results_Per_Acct" type="xsd:unsignedInt"/>

	<part name="Run_Deep_Dive"        type="xsd:boolean"/>
	<part name="PenaltThreshold"  	  type="xsd:unsignedInt"/>
  <part name="Nicknames" 						type="xsd:boolean"/>
  <part name="Phonetics"						type="xsd:boolean"/>
  <part name="IncludeNameVariations" type="xsd:boolean"/>
  <part name="ScoreThreshold" 			type="xsd:unsignedInt"/>
  <part name="StrictMatch" 		 			type="xsd:boolean"/>
  <part name="SearchGoodSSNOnly" 		type="xsd:boolean"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

/* NOTES
	
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
    &lt;prim_range&gt;&lt;/prim_range&gt;
    &lt;predir&gt;&lt;/predir&gt;   
    &lt;prim_name&gt;&lt;/prim_name&gt; 
    &lt;addr_suffix&gt;&lt;/addr_suffix&gt; 
    &lt;postdir&gt;&lt;/postdir&gt; 
    &lt;unit_desig&gt;&lt;/unit_desig&gt; 
    &lt;sec_range&gt;&lt;/sec_range&gt; 
    &lt;p_city_name&gt;&lt;/p_city_name&gt;
    &lt;st&gt;&lt;/st&gt; 
    &lt;z5&gt;&lt;/z5&gt; 
    &lt;FBI_Number&gt;&lt;/FBI_Number&gt;
    &lt;Alien_Number&gt;&lt;/Alien_Number&gt;
    &lt;DL&gt;&lt;/DL&gt;
    &lt;State_ID_Number&gt;&lt;/State_ID_Number&gt;
    &lt;Min_Booking_Date&gt;&lt;/Min_Booking_Date&gt;
    &lt;Max_Booking_Date&gt;&lt;/Max_Booking_Date&gt;
    &lt;ScoreThreshold&gt;&lt;/ScoreThreshold&gt;
    &lt;StrictMatch&gt;&lt;/StrictMatch&gt;
    &lt;SearchGoodSSNOnly&gt;&lt;/SearchGoodSSNOnly&gt;
  &lt;/Row&gt;
 &lt;/batch_in&gt;
 </pre>
*/
IMPORT Appriss,AutoStandardI, Autokey_batch,AutokeyB2_batch, BatchServices, JailBooking_Services;

#warning('Service no longer used as of 09/26/2012.')
EXPORT JailBooking_BatchServiceV2(useCannedRecs = 'false') := 
	MACRO
		INTEGER max_results             := BatchServices.Constants.JailBooking.MAX_RESULTS : STORED('Max_Results');
		INTEGER max_results_per_acct    := BatchServices.Constants.JailBooking.MAX_RESULTS_PER_ACCT : STORED('Max_Results_Per_Acct');
		BOOLEAN name_variations         := false  : STORED('IncludeNameVariations');
		#stored('allowFuzzyDOBMatch', FALSE);  //this service only allows for LastFirst when DOB matching is used so disable fuzzy dob matching.
		#stored('useOnlyBestDID', TRUE);  //
		
		ds_xml_in      := DATASET([], BatchServices.Layouts.JailBooking.layout_inJailBookingBatch) : STORED('batch_in', FEW);

		ds_xml_upper := BatchServices.JailBooking_Functions.fn_upper_input(ds_xml_in);

		// if name_variations are requested generate multiple input rows with various name variations. 
    ds_xml_cleaned := IF (name_variations, BatchServices.JailBooking_Functions.fn_generate_names(ds_xml_upper), ds_xml_upper);
		
		//use dummy input requests if asked useCannedRecs = true.
		BatchServices.Layouts.JailBooking.layout_inJailBookingBatch fillCanned(Autokey_batch.Layouts.rec_inBatchMaster l) := transform
		   self := l;
			 self.fbi_number := 'SampleFbiNumber';
			 self.state_id_number := 'SampleStateID';
			 self.alien_number := 'SampleAlienNumber';
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
		p := BatchServices.JailBooking_BatchService_RecordsV2(ds_batch_in_w_names);
		
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
		
		ds_recs_grouped := GROUP(SORT(ds_recs_acctno, acctno, isDeepDive, record_penalty, -booking_date), acctno);

		ds_top_recs := TOPN(ds_recs_grouped, max_results_per_acct, acctno, isDeepDive, record_penalty, -booking_date);
		
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
	
    ds_flat_recs := BatchServices.JailBooking_Functions.fn_flatten(ds_bookNCharges);
		
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

		ds_results := SORT(ds_all,acctno, isDeepDive, record_penalty, -booking_date);
		limited_results := choosen(ds_results, max_results);
  	OUTPUT(limited_results, NAMED('Results'));			
		
	ENDMACRO;	
// JailBooking_BatchServiceV2();