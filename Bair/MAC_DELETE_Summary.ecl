EXPORT MAC_DELETE_Summary(infile, file_type, filename, dtImport, outrec) := MACRO

	import ut;

#if('EventDeletes' = file_type or 'CFSDeletes' = file_type or 'CrashDeletes' = file_type or 'CrashDeletes' = file_type)
	
	#uniquename(providerRec)
	%providerRec% := record
		unsigned4 providerID;
		STRING ori;
		STRING data_provider_name;
		STRING reportEmail := '';
		STRING filename := '';
		STRING dtImport := '';
	end;
	
	#uniquename(DataProvidertable)
	%DataProvidertable% 		:= bair.files().DataProvider_Base.built;
	
	#uniquename(DataProviderImptable)
	%DataProviderImptable% 	:= bair.files().DataProviderImp_Base.built;
	
	#uniquename(unique_ori)
	%unique_ori% := dedup(table(infile, {infile.field2}), field2, all);
	
	#uniquename(providerHDRTable)	
		%providerHDRTable% := join(join(%unique_ori%
							,%DataProvidertable%
							,left.field2 = (string)right.data_provider_id
							,transform(%providerRec%,
									self.ori := right.data_provider_ori;
									self.providerID := (UNSIGNED4)left.field2;
									self.data_provider_name := right.data_provider_name;
									self.filename := filename;
									self.dtImport := dtImport;
									self.reportEmail := [];)
							,left outer)
					,%DataProviderImptable%
					,left.providerID = right.dataProviderID
					,transform(%providerRec%, self.reportEmail := left.reportEmail; self := left;)
					,left outer);
	
	#uniquename(tb_inc_deletes)
	%tb_inc_deletes% 			:= table(infile, {infile.field2, imp_inc_deletes := count(group)}, field2);
	
	#uniquename(MakeDeletedDS)
	Bair.RaidsReport_Layout.deletedRec %MakeDeletedDS%(%tb_inc_deletes% L, INTEGER ctr) := transform
		#uniquename(recordCount)
			%recordCount% 	:= L.imp_inc_deletes;
			
		#if('EventDeletes' = file_type)
			ds := dataset([
			{L.field2,  'MO', %recordCount%},
			{L.field2,  'PERSONS', %recordCount%},
			{L.field2,  'VEHICLE', %recordCount%}
			], Bair.RaidsReport_Layout.deletedRec);
		#end
		
		#if('CFSDeletes' = file_type)
			ds := dataset([
			{L.field2,  'CFS Records', %recordCount%},
			{0, '', 0},
			{0, '', 0}
			], Bair.RaidsReport_Layout.deletedRec);
		#end
		
		#if('CrashDeletes' = file_type or 'OffendersDeletes' = file_type)
			ds := dataset([
			{L.field2,  'Incident Records', %recordCount%},
			{0, '', 0},
			{0, '', 0}
			], Bair.RaidsReport_Layout.deletedRec);
		#end

		self := row({ds[ctr].providerID, ds[ctr].fileName, ds[ctr].recordCount}, Bair.RaidsReport_Layout.deletedRec);
	end;
	
	#uniquename(deleted_blk)
	%deleted_blk% := NORMALIZE(%tb_inc_deletes%, 3, %MakeDeletedDS%(left, COUNTER))(providerID <> 0);
		
	#uniquename(ParentMove)
	Bair.RaidsReport_Layout.RaidsReportRec %ParentMove%(%providerRec% L) := TRANSFORM
		SELF.filesCountTable 	:= [];
		SELF.summaryTable 		:= [];
		SELF.dateRangeTable 	:= [];
		SELF.coordinatesTable := []; 
		SELF.quarantinedTable := []; 
		SELF.deletedTable 		:= []; 
		SELF.unclassifiedCrimeTable := []; 	
		SELF := L;
	END;
	
	#uniquename(ParentOnly)
		%ParentOnly% := PROJECT(%providerHDRTable%, %ParentMove%(LEFT));
		
	#uniquename(DeletedMove)
	Bair.RaidsReport_Layout.RaidsReportRec %DeletedMove%(Bair.RaidsReport_Layout.RaidsReportRec L, Bair.RaidsReport_Layout.deletedRec R):=TRANSFORM
		SELF.deletedTable  := L.deletedTable  + R;
		SELF := L;
	END;
	
	#uniquename(DeNormedWithDeletedRecs)
	%DeNormedWithDeletedRecs% := DENORMALIZE(%ParentOnly%, %deleted_blk%,
														LEFT.providerID = RIGHT.providerID,
														%DeletedMove%(LEFT,RIGHT));	
	
	outrec := %DeNormedWithDeletedRecs%;
#else
	outrec := 'Incorrect file_types: Valid types [EventDeletes, CFSDeletes, CrashDeletes, CrashDeletes]';
#end

endmacro;