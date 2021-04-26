/*2015-06-24T16:52:16Z (Sai Nagula)
Open State search and Drivers exchange report grouping.
*/
IMPORT dx_eCrash, ut, doxie;

EXPORT RecordsDeltaBase(IParam.searchrecords in_mod)  := MODULE

		EXPORT DeltaService := DeltaBaseSoapCall(in_mod);
		EXPORT deltaSQL := RawDeltaBaseSQL(in_mod);
		EXPORT eCrashRecordStructure := Layouts.eCrashRecordStructure;
		EXPORT boolean hasOneNameParm 	:= in_mod.firstname<>'' OR in_mod.lastname<>'';

		//======================================================================================
		// Either a lookup by RPT_NUMBER or else a name lookup if possible		
		EXPORT readFirstByReport() := FUNCTION
				SQLString_DS := deltaSQL.byReportNumberSQL();
				out := DeltaService.LookupIncidentPersons_Alias(SQLString_DS);
				Return out;				
		END;
		
		EXPORT readFirstByAuto() := FUNCTION
			  SQLString_DS := deltaSQL.byAutoRecsSQL();
				out := DeltaService.LookupIncidentPersons_Alias(SQLString_DS);
				Return out; 				
		END;
		
		//======================================================================================

		EXPORT readPartialReportNumBatch(STRING8 dateMin, STRING8 dateMax) := FUNCTION			
		  /*		
			string SQLString := deltaSQL.byPartialReportNumberSQL(dateMin, dateMax);
			out := DeltaService.LookupIncidentPersons(SQLString);
			RETURN out;
			*/
			SQLString_DS := deltaSQL.byPartialReportNumberSQL(dateMin, dateMax);
			out := DeltaService.LookupIncidentPersons_Alias(SQLString_DS);				
			Return out; 				
		END;
		
		//======================================================================================

		EXPORT readDOLBatch(STRING8 dateMin, STRING8 dateMax) := FUNCTION
	
			SQLString1_ds := deltaSQL.byDOLExactSQL();
			SQLString2_ds := deltaSQL.byDOLFuzzySQL(dateMin,dateMax);
			
			dol_exact_recs := DeltaService.LookupIncidentPersons_Alias(SQLString1_ds);
			dol_fuzzy_recs := DeltaService.LookupIncidentPersons_Alias(SQLString2_ds);
						
			RETURN IF(EXISTS(dol_exact_recs), dol_exact_recs, dol_fuzzy_recs);			
		END;

		//======================================================================================
		
		EXPORT readByLocation() := FUNCTION 
	
			SQLString_DS := deltaSQL.byLocationSQL();
			out := DeltaService.LookupIncidentPersons_Alias(SQLString_DS);				
   		Return out;    	
		END;
		
	  EXPORT readByFirstName() := FUNCTION 
					
			SQLString_DS := deltaSQL.byFirstNameAndState();
			out := DeltaService.LookupIncidentPersons_Alias(SQLString_DS);
			Return out; 			
		END;
		
		EXPORT getAssociatedReports(Layouts.recs_with_penalty rec) := FUNCTION 		  
			SQLString := deltaSQL.associatedReportsByReportLinkID(rec);
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