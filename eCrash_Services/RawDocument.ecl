import FLAccidents_Ecrash, Risk_Indicators, lib_stringlib, ut, doxie;
EXPORT RawDocument(IParam.searchrecords in_mod) := MODULE

EXPORT GetReportDocuments(string RequestReportId, string DocumentType='') := FUNCTION

		DeltaBaseService := eCrash_Services.DeltaBaseSoapCall(in_mod);
		DeltaBaseSql := RawDeltaBaseSQL(in_mod);	
		SuperReportIdToReportId := CHOOSEN(FLAccidents_Ecrash.Key_eCrashV2_ReportId(KEYED(report_id = RequestReportId)), 1);
		SuperReportId := if(exists(SuperReportIdToReportId),SuperReportIdToReportId[1].Super_report_id,'');
		//SuperReportId := (string11)SuperReportIdToReportId.Super_report_id;
		//All of the records in ReportHashKeysFromKey have the same accident_nbr, report_code, jurisdiction_state, jurisdiction, accident_date, orig_accnbr
		//The only reason we are joining with supplemental key is to get the documents from deltabase based on key fields if we did not find the documents using report_id
		ReportHashKeysFromKey := 
			JOIN(
				SuperReportIdToReportId,
				FLAccidents_Ecrash.Key_eCrashv2_Supplemental,
				KEYED(LEFT.super_report_id = RIGHT.super_report_id),
				TRANSFORM(RIGHT),
				LIMIT(constants.MAX_REPORT_NUMBER, FAIL(203, doxie.ErrorCodes(203)))
			);
		
		DeltaBaseDateAddedRaw := FLAccidents_Ecrash.Key_eCrashV2_DeltaDate(delta_text = 'DELTADATE');
		DeltaBaseDateAdded := ut.date_math(DeltaBaseDateAddedRaw[1].date_added[1..8], -1);
		DeltaBaseDateAddedSql := DeltaBaseSql.dateFormatted(DeltaBaseDateAdded);

		DeltabaseReportSelectSql := DeltaBaseSql.GetImageRetrievalSqlByReportId(TRIM(RequestReportId), DeltaBaseDateAddedSql);
		EmptyReportDeltabaseRow := DATASET([],eCrash_Services.Layouts.eCrashRecordStructure);

		ReportDeltabaseRow := IF(
			SuperReportId = '', 
			DeltaBaseService.GetReportData(DeltabaseReportSelectSql),
			EmptyReportDeltabaseRow
		);
		
		PayloadRowByDeltabaseRaw := FLAccidents_Ecrash.key_EcrashV2_accnbrv1(
			KEYED(
				l_accnbr = ReportDeltabaseRow[1].l_accnbr AND
				//report_code IN ReportCodeDeltabase AND    //WE NEED to comment this out because if for example we found
					// TF in the deltabase then we don't want to miss EA in the payload because we will be looking for supplements in the deltabase by this payload record
				jurisdiction_state = ReportDeltabaseRow[1].jurisdiction_state AND
				jurisdiction = ReportDeltabaseRow[1].jurisdiction
			) AND 
			WILD(report_code) AND
			accident_date = ReportDeltabaseRow[1].accident_date AND 
			orig_accnbr = ReportDeltabaseRow[1].orig_accnbr	AND
			report_type_id = ReportDeltabaseRow[1].report_type_id
		);	
		
		//OUTPUT(PayloadRowByDeltabaseRaw,named('PayloadRowByDeltabaseRaw'));
		
		PayloadSuperIdByDelta := if(exists(PayloadRowByDeltabaseRaw),PayloadRowByDeltabaseRaw[1].super_report_id,'');

		FinalSuperReportId := if (SuperReportId = '', PayloadSuperIdByDelta, SuperReportId);
		
   // OUTPUT(FinalSuperReportId,named('FinalSuperReportId'));

		ReportIdSet := if (LENGTH(TRIM(FinalSuperReportId)) > 0,[FinalSuperReportId, RequestReportId],[RequestReportId]);      
		ReportIdString := eCrash_Services.fn_CombineWords(ReportIdSet, ',');
  deltabaseDocReportIdSql := DeltaBaseSql.GetDocumentsByReportIdSQL(ReportIdString,DeltaBaseDateAddedSql, DocumentType);
  EmptyDocumentData := DATASET([],eCrash_Services.Layouts.DocumentData);
		
  DeltaDocumentDataById :=  if (TRIM(ReportIdString, LEFT, RIGHT) = '', EmptyDocumentData, DeltaBaseService.GetDocumentData(deltabaseDocReportIdSql));
		
		DeltabaseSuperReport := project(ReportDeltabaseRow,TRANSFORM(recordof(FLAccidents_Ecrash.Key_eCrashv2_Supplemental), SELF.accident_nbr:=LEFT.l_accnbr, self.addl_report_number:=LEFT.formattedStateReportNumber, SELF:=LEFT,SELF:=[]));	//project(ReportDeltabaseRow,TRANSFORM(FLAccidents_Ecrash.Key_eCrashv2_Supplemental, SELF:=LEFT));
		
	  //OUTPUT(DeltabaseSuperReport, named('DeltabaseSuperReport_temp'));
	 deltabaseDocBySupplementalSql := if (EXISTS(ReportHashKeysFromKey),DeltaBaseSql.GetDocumentsSQL(ReportHashKeysFromKey[1],DeltaBaseDateAddedSql, DocumentType),DeltaBaseSql.GetDocumentsSQL(DeltabaseSuperReport[1],DeltaBaseDateAddedSql, DocumentType));
		DeltaDocumentDataBySupKey := DeltaBaseService.GetDocumentData(deltabaseDocBySupplementalSql);
		
		//OUTPUT(DeltaDocumentDataBySupKey,named('DeltaDocumentDataBySupKey_temp'));
		DeltabaseDocuments := DeltaDocumentDataById + DeltaDocumentDataBySupKey;
		
		//OUTPUT(DeltabaseDocuments,named('DeltabaseDocuments'));
		
		DocumentKey := FLAccidents_Ecrash.Key_ecrashV2_PhotoId;
		PayloadDocumentsTemp := CHOOSEN(
		 DocumentKey(keyed(Super_report_id=FinalSuperReportId) 
			           and keyed(Document_id <> '') 
									     and keyed(DocumentType = '' or report_type = DocumentType)
									     ),
			constants.MAX_REPORT_NUMBER
		);
		
		Layouts.DocumentData transformPayload(FLAccidents_Ecrash.Key_ecrashV2_PhotoId l) := TRANSFORM
			self.documentId := l.document_id;
			self.hashKey := l.document_hash_key;
			self.dateAdded := l.date_created;
			self.reportTypeId := l.Report_type;
			self.pageCount := l.Page_Count;
			self.extension := l.extension;
			self := [];
		END;
		
		PayloadDocuments := project(PayloadDocumentsTemp,transformPayload(left));
		
		//OUTPUT(PayloadDocuments,named('PayloadDocuments'));
		
		MergedDocuments := DeltabaseDocuments + PayloadDocuments;
		
		DupedDocuments := dedup(sort(MergedDocuments,documentId,-dateAdded,-isDelta),documentId);
		
		//We are filtering isDeleted in the end because a document could be deleted and it might not have made to hpcc yet.
		FilteredDupedDocuments := DupedDocuments(isDeleted = false);
		
		RETURN FilteredDupedDocuments;
	END;

END;