IMPORT NPPES, ut, iesp;

EXPORT NPI_ReportService_Records(IParams.searchParams aInputData) := FUNCTION
		npi_key := NPPES.Key_NPPES_npi;
		
		// get id's from autokeys for name, address, and ssn etc.
		nppes_fakeid := Healthcare_Provider_Services.AutoKey_Ids(aInputData).nppes;		
		nppes_payload := Healthcare_Provider_Services.Functions.getPayloadByNPPESIDS(nppes_fakeid);
		nppes_byak := project(nppes_payload, recordof(Healthcare_Provider_Services.layouts.NPPES_Layouts.temp_layout));
		
		//get id's by NPI number
		npi_rec := dataset([{aInputData.NPI}], layouts.NPPES_Layouts.layout_npiid);
		nppes_ids_bynpi := Functions.getNPPESByNPI(npi_rec);
														
		nppes_recs := if(exists(npi_rec(npi_id <> '')), nppes_ids_bynpi, nppes_byak);
		
		penalt_recs := Functions.apply_penalty_nppes(nppes_recs, aInputData);
		final_penalt_recs := penalt_recs(record_penalty < aInputData.penalty_threshold);		
		final_recs := dedup(sort(final_penalt_recs, npi, record_penalty,-process_date), npi);
		
		//Project to final output
		out_rec := iesp.npireport.t_NPIReportResponse;
		
		nppes_final := choosen(project(final_recs, Healthcare_Provider_Services.NPI_Transforms.formatRecords(left)),iesp.constants.HPR.Max_Cnt_Search);
		emptyBase		:= dataset([],iesp.npireport.t_NPIReport);

		boolean checkInputMatched := Functions.MatchingInputVerified(nppes_recs, aInputData);
		boolean hasSomething2Report := exists(final_recs);
		boolean foundMoreThanOneRec := count(final_recs) > 1 and aInputData.isReport = true;//if it is a report and more than 1 record problem.....
		boolean noHit := count(final_recs) = 0;
		
		out_rec format() := transform
			string q_id := '' : stored ('_QueryId');
			string t_id := '' : stored ('_TransactionId');
			integer msg_code := map(foundMoreThanOneRec => 203,
															~checkInputMatched => 204,
															0);
			string msg := map(foundMoreThanOneRec => ut.MapMessageCodes(ut.constants_MessageCodes.SUBJECT_NOT_UNIQUE),
												~checkInputMatched => 'Input data does not match',
												'');
			goodheader := ROW ({0, '', q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
			badheader := ROW ({msg_code, msg, q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
			self._Header  := if(hasSomething2Report and checkInputMatched and not foundMoreThanOneRec or noHit,goodheader,badheader);
			self.RecordCount 	:= if(hasSomething2Report and not foundMoreThanOneRec,count(final_recs),0);
			self.NPIReports := if(hasSomething2Report and not foundMoreThanOneRec,nppes_final,emptyBase);
			self := [];
		end;
		
		final_nppes_rec := dataset([format()]);
		
		// output(nppes_fakeid, named('nppes_fakeid'));
		// output(nppes_payload, named('nppes_payload'));
		// output(nppes_byak, named('nppes_byak'));
		// output(nppes_recs, named('nppes_recs'));
		// output(penalt_recs, named('penalt_recs'));
		// output(final_penalt_recs, named('final_penalt_recs'));
		// output(final_recs, named('final_recs'));
		// output(foundMoreThanOneRec,named('foundMoreThanOneRec'));
		
	RETURN final_nppes_rec;
END;
