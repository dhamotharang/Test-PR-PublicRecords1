IMPORT iesp, doxie, Accident_Services;

out_rec := iesp.accident.t_AccidentReportRecord;

EXPORT out_rec Accident_records (
  DATASET(doxie.layout_references) dids,
  input.accidents in_params = MODULE(input.accidents) END,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

	accRpts := RECORD
		UNSIGNED seq;
		DATASET(out_Rec) accRptRec {MAXCOUNT(iesp.Constants.ACCIDENTS_MAX_COUNT_SEARCH_RESPONSE_RECORDS)}; 
	END;
	
	accRpts accRptsByNbr(Accident_Services.Layouts.search L, UNSIGNED cnt) := TRANSFORM
		accNbrMod := MODULE(PROJECT(in_params,Accident_Services.IParam.searchRecords))
			EXPORT STRING40 Accident_Number := L.accident_nbr;
		END;
		SELF.seq := cnt;
		SELF.AccRptRec := Accident_Services.Report_Records.accidentNmbr(accNbrMod);
	END;

	tmpMod := MODULE(PROJECT(in_params,Accident_Services.IParam.searchRecords))
		EXPORT STRING14 did := (STRING)dids[1].did;
	END;

	accNbrs := Accident_Services.Search_IDs(tmpMod);

	rptRecs := PROJECT(accNbrs,accRptsByNbr(LEFT,COUNTER));

	nrmRecs := NORMALIZE(rptRecs,LEFT.accRptRec,TRANSFORM(out_rec,SELF:=RIGHT));

  RETURN nrmRecs;
END;
