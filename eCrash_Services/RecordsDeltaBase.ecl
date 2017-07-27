/*2015-06-24T16:52:16Z (Sai Nagula)
Open State search and Drivers exchange report grouping.
*/
IMPORT FLAccidents_Ecrash, ut, doxie;

EXPORT RecordsDeltaBase(IParam.searchrecords in_mod)  := MODULE

		EXPORT DeltaService := DeltaBaseSoapCall(in_mod);
		EXPORT deltaSQL := RawDeltaBaseSQL(in_mod);
		EXPORT eCrashRecordStructure := Layouts.eCrashRecordStructure;
		EXPORT boolean hasOneNameParm 	:= in_mod.firstname<>'' OR in_mod.lastname<>'';

		
		//======================================================================================
		// Either a lookup by RPT_NUMBER or else a name lookup if possible		
		EXPORT readFirstByReport() := FUNCTION
				string SQLString := deltaSQL.byReportNumberSQL();
				out := DeltaService.LookupIncidentPersons(SQLString);
				RETURN out;
		END;
		
		EXPORT readFirstByAuto() := FUNCTION
				string SQLString := deltaSQL.byAutoRecsSQL();
				out := DeltaService.LookupIncidentPersons(SQLString);
				RETURN out;
		END;
		
		//======================================================================================

		EXPORT readPartialReportNumBatch(STRING8 dateMin, STRING8 dateMax) := FUNCTION			
			string SQLString := deltaSQL.byPartialReportNumberSQL(dateMin, dateMax);
			out := DeltaService.LookupIncidentPersons(SQLString);
			RETURN out;
		END;

		//======================================================================================

		EXPORT readDOLBatch(STRING8 dateMin, STRING8 dateMax) := FUNCTION
			string SQLString1 := deltaSQL.byDOLExactSQL();
			string SQLString2 := deltaSQL.byDOLFuzzySQL(dateMin,dateMax);

			dol_exact_recs := DeltaService.LookupIncidentPersons(SQLString1);
			dol_fuzzy_recs := DeltaService.LookupIncidentPersons(SQLString2);
			
			RETURN IF(EXISTS(dol_exact_recs), dol_exact_recs, dol_fuzzy_recs);
		END;

		//======================================================================================
		
		EXPORT readByLocation() := FUNCTION 
			string SQLString := deltaSQL.byLocationSQL();
			out := DeltaService.LookupIncidentPersons(SQLString);
			RETURN out;
		END;
		
	  EXPORT readByFirstName() := FUNCTION 
			string SQLString := deltaSQL.byFirstNameAndState();
			out := DeltaService.LookupIncidentPersons(SQLString);
			RETURN out;
		END;
		
		EXPORT getAssociatedReports(Layouts.recs_with_penalty rec) := FUNCTION 
			string SQLString := deltaSQL.associatedReportsByReportLinkID(rec);
			temp := DeltaService.LookupIncidentPersons(SQLString);
			out := project(temp,TRANSFORM(Layouts.recs_with_penalty, SELF.isDelta:=true, SELF:=LEFT));
			RETURN out;
		END;

    EXPORT getSubscriptionReports(string incidentIdList) := FUNCTION 
			string SQLString := deltaSQL.GetSubscriptionSQL(incidentIdList);
			temp := DeltaService.LookupIncidentPersons(SQLString);
			out := project(temp,TRANSFORM(Layouts.recs_with_penalty, SELF.isDelta:=true, SELF:=LEFT));
			RETURN out;
		END;

		EXPORT getSubscriptionIncidentIds(INTEGER limitValue) := FUNCTION 
			string SQLString := deltaSQL.GetSubscriptionIncidentIdSQL(limitValue);
			out := DeltaService.GetAgencySubscriptionIncidentIds(SQLString);
			RETURN out;
		END;

END;