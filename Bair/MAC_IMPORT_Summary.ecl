EXPORT MAC_IMPORT_Summary(infile, file_type, filename, dtImport, outrec) := MACRO

	import ut;
	
#if('EventMO' = file_type or 'EventPersons' = file_type or 'EventVehicles' = file_type or 'CFS' = file_type or 'Crash' = file_type or 'Offenders' = file_type or 'LPR' = file_type or 'EventDeletes' = file_type or 'CFSDeletes' = file_type)
	
	#uniquename(providerRec)
		%providerRec% := record
			unsigned4 providerID;
			STRING ori;
			STRING data_provider_name;
			STRING reportEmail := '';
			STRING filename := '';
			STRING dtImport := '';
		end;
	
	#uniquename(infile_dist)
		%infile_dist% := distribute(infile, hash(
			#if('EventMO' = file_type or 'EventPersons' = file_type or 'EventVehicles' = file_type or 'EventDeletes' = file_type)			
				ir_number,
			#end
			#if('CFS' = file_type or 'CFSDeletes' = file_type)			
				event_number,
			#end
			#if('Offenders' = file_type)
				agency_offender_id,
			#end
			#if('Crash' = file_type)
				case_number,
			#end
			#if('LPR' = file_type)
				EventNumber,
			#end
			#if('SHO' = file_type)
				shot_id,
			#end
			ori
			));
		
	#uniquename(infile_sort)
		%infile_sort% := sort(%infile_dist%,
		#if('EventMO' = file_type or 'EventPersons' = file_type or 'EventVehicles' = file_type or 'EventDeletes' = file_type)
			ir_number,
		#end
		#if('CFS' = file_type or 'CFSDeletes' = file_type)			
			event_number,
		#end
		#if('Offenders' = file_type)
			agency_offender_id,
		#end
		#if('Crash' = file_type)
			case_number,
		#end
		#if('LPR' = file_type)
				EventNumber,
		#end
		#if('SHO' = file_type)
			shot_id,
		#end
		ori,
		local
		);
	
	#uniquename(infile_dedup)
		%infile_dedup% := dedup(%infile_sort%,
		#if('EventMO' = file_type or 'EventPersons' = file_type or 'EventVehicles' = file_type or 'EventDeletes' = file_type)
			ir_number,
		#end
		#if('CFS' = file_type or 'CFSDeletes' = file_type)			
			event_number,
		#end
		#if('Offenders' = file_type)
			agency_offender_id,
		#end
		#if('Crash' = file_type)
			case_number,
		#end
		#if('LPR' = file_type)
				EventNumber,
		#end
		#if('SHO' = file_type)
			shot_id,
		#end
		ori,
		local
		);

	#uniquename(crimeTable)
		%crimeTable% 		:= dedup(sort(table(bair.files().AgencyCrimeLookup_Base.built,{dataproviderid, crime}, few, merge), dataproviderid, crime, local), dataproviderid, crime, local);
	#uniquename(cfscrimeTable)
		%cfscrimeTable% := dedup(sort(table(bair.files().AgencyCfsLookup_Base.built, {dataproviderid, agencyType}, few, merge), dataproviderid, agencyType, local), dataproviderid, agencyType, local);
	#uniquename(DataProvidertable)
		%DataProvidertable% 		:= bair.files().DataProvider_Base.built;
	#uniquename(DataProviderImptable)
		%DataProviderImptable% 	:= bair.files().DataProviderImp_Base.built;
	#uniquename(moTable)
		%moTable% 			:= bair.files().mo_base.built;
	#uniquename(personsTable)
		%personsTable% 	:= bair.files().persons_base.built;
	#uniquename(vehicleTable)
		%vehicleTable% 	:= bair.files().vehicle_base.built;
	#uniquename(cfsTable)
		%cfsTable% 			:= bair.files().cfs_base.built;
	#uniquename(offenderTable)
		%offenderTable% := bair.files().offenders_base.built;
	#uniquename(crashTable)
		%crashTable% 		:= bair.files().crash_base.built;
	#uniquename(lprTable)
		%lprTable% 			:= bair.files().lpr_base.built;
		
	#uniquename(unique_ori)
	%unique_ori% := dedup(table(distribute(infile, hash(ori)), {infile.ori}, few, merge), ori, all);
	
	#uniquename(dp)	
		%dp% := join(%unique_ori%
							,%DataProvidertable%
							,left.ori = right.data_provider_id
							,transform(%providerRec%,
									self.ori := right.data_provider_ori;
									self.providerID := left.ori;
									self.data_provider_name := right.data_provider_name;
									self.filename := filename;
									self.dtImport := dtImport;
									self.reportEmail := [];)
							,left outer);
							
	#uniquename(providerHDRTable)	
		%providerHDRTable% := join(%dp%
							,%DataProviderImptable%
							,left.providerID = right.dataProviderID
							,transform(%providerRec%, self.reportEmail := left.reportEmail; self := left;)
							,left outer);
	
	#uniquename(tb_inc_total) //approved + quarantined
		%tb_inc_total% 		:= table(%infile_dedup%, {%infile_dedup%.ori, imp_inc_total := count(group)}, ori, few, merge);
						
	#uniquename(tb_inc_approved)
		%tb_inc_approved% := table(%infile_dedup%(quarantined = '0'), {%infile_dedup%.ori, imp_inc_approved := count(group)},  ori, few, merge);
	
	#uniquename(tb_file_total)
		%tb_file_total%		:= table(%infile_sort%, {%infile_sort%.ori, imp_file_total := count(group)},  ori, few, merge);
			
	#uniquename(tb_inc_geocoded)
		%tb_inc_geocoded% :=		
			#if('EventMO' = file_type or 'CFS' = file_type)
				table(%infile_dedup%(quarantined = '0' and geocoded = '1'), {%infile_dedup%.ori, imp_inc_geocoded := count(group)},  ori, few, merge);
			#end
			#if('EventPersons' = file_type or 'EventVehicles' = file_type or 'SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
				table(%infile_dedup%(quarantined = '0'), {%infile_dedup%.ori, imp_inc_geocoded := 0},  ori, few, merge);
			#end
			
	#uniquename(tb_file_first_date)
		%tb_file_first_date% := 
			#if('CFS' = file_type)
				table(%infile_sort%(quarantined = '0'), {%infile_sort%.ori, imp_file_first_date := Bair.DateToMonDDYYYY(min(group, ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(date_time_received,'.>$!%*@=?&\''),left,right))))}, ori, few, merge);
			#end
			#if('EventMO' = file_type)
				table(%infile_sort%(quarantined = '0'), {%infile_sort%.ori, imp_file_first_date := Bair.DateToMonDDYYYY(min(group, ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(first_date_time,'.>$!%*@=?&\''),left,right))))}, ori, few, merge);
			#end
			#if('EventPersons' = file_type or 'EventVehicles' = file_type or 'SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
				table(%infile_sort%(quarantined = '0'), { %infile_sort%.ori, imp_file_first_date := ''},  ori, few, merge);
			#end
		
	#uniquename(tb_file_last_date)
		%tb_file_last_date% :=
			#if('CFS' = file_type)
				table(%infile_sort%(quarantined = '0'), { %infile_sort%.ori, imp_file_last_date := Bair.DateToMonDDYYYY(max(group, ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(date_time_received,'.>$!%*@=?&\''),left,right))))}, ori, few, merge);
			#end
			#if('EventMO' = file_type)
				table(%infile_sort%(quarantined = '0'), { %infile_sort%.ori, imp_file_last_date := Bair.DateToMonDDYYYY(max(group, ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(first_date_time,'.>$!%*@=?&\''),left,right))))}, ori, few, merge);
			#end
			#if('EventPersons' = file_type or 'EventVehicles' = file_type or 'SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
				table(%infile_sort%(quarantined = '0'), { %infile_sort%.ori, imp_file_last_date := ''},  ori, few, merge);
			#end
			
#if('EventMO' = file_type or 'EventPersons' = file_type or 'EventVehicles' = file_type or 'CFS' = file_type)
	#uniquename(tb_full)	
		%tb_full%  := #if('CFS' = file_type)
										%cfsTable%;
									#else
										join(#if('EventMO' = file_type) %moTable% #end #if('EventPersons' = file_type) %personsTable% #end #if('EventVehicles' = file_type) %vehicleTable% #end, %providerHDRTable%, left.ori = right.providerID, transform({#if('EventMO' = file_type) %moTable%.ori #end #if('EventPersons' = file_type) %personsTable%.ori #end #if('EventVehicles' = file_type) %vehicleTable%.ori #end}, self.ori := left.ori), lookup)
									#end;
	#uniquename(tb_allTime_ImportTotal)
		%tb_allTime_ImportTotal% := table(%tb_full%, {%tb_full%.ori, allTime_ImportTotal := count(group)}, ori, few, merge);
		
	#uniquename(tb_crimes)
		%tb_crimes%	:= dedup(table(%infile_sort%, {%infile_sort%.ori, #if('CFS' = file_type) %infile_sort%.initial_type #end #if('EventMO' = file_type) %infile_sort%.crime #end}, few, merge), all);	

	#uniquename(tb_unclassified_crimes)
		%tb_unclassified_crimes% := #if('EventPersons' = file_type or 'EventVehicles' = file_type) dataset([], {%tb_crimes%.ori, string crime});
													#else
														join(%tb_crimes%, #if('CFS' = file_type) %cfscrimeTable% #end #if('EventMO' = file_type) %crimeTable% #end, left.ori = right.dataproviderid and #if('CFS' = file_type) ut.CleanSpacesAndUpper(left.initial_type) = ut.CleanSpacesAndUpper(right.agencyType) #end #if('EventMO' = file_type) ut.CleanSpacesAndUpper(left.crime) = ut.CleanSpacesAndUpper(right.crime) #end, transform({%tb_crimes%.ori, string crime}, self.ori := left.ori; self.crime := #if('EventMO' = file_type) left.crime #else left.initial_type #end;), LEFT ONLY);	
													#end;	
#end

	// #uniquename(tb_inc_deletes)
		// %tb_inc_deletes% 			:= table(%infile_dedup%, {%infile_dedup%.ori, imp_inc_deletes := count(group)}, ori);
	
// #if('EventDeletes' = file_type)	
	// #uniquename(infile_with_persons)
		// %infile_with_persons% := join(%personsTable%, %infile_dedup%, %infile_dedup%.ori = %personsTable%.ori and %infile_dedup%.ir_number = %personsTable%.ir_number, transform({%personsTable%.ori, %personsTable%.ir_number}, self := left), left outer);
	// #uniquename(tb_persons_deletes)
		// %tb_persons_deletes%	:= table(%infile_with_persons%, {%infile_with_persons%.ori, imp_persons_deletes := count(group)}, ori);
	
	// #uniquename(infile_with_vehicle)
		// %infile_with_vehicle% := join(%vehicleTable%, %infile_dedup%, %infile_dedup%.ori = %vehicleTable%.ori and %infile_dedup%.ir_number = %personsTable%.ir_number, transform({%vehicleTable%.ori, %vehicleTable%.ir_number}, self := left), left outer);
	// #uniquename(tb_vehicle_deletes)
		// %tb_vehicle_deletes%	:= table(%infile_with_vehicle%, {%infile_with_vehicle%.ori, imp_vehicle_deletes := count(group)}, ori);
// #end
		
	#uniquename(stats)
		%stats% := 	#if('EventPersons' = file_type or 'EventVehicles' = file_type)
										join(%tb_file_total%, %tb_allTime_ImportTotal%, left.ori = right.ori, full outer);
										// #elseif('EventDeletes' = file_type)
											// join(join(%tb_inc_deletes%, %tb_persons_deletes%, left.ori = right.ori, full outer), %tb_vehicle_deletes%, left.ori = right.ori, full outer)
											// join(join(%tb_inc_deletes%, %tb_persons_deletes%, left.ori = right.ori, full outer), %tb_vehicle_deletes%, left.ori = right.ori, full outer)
											#elseif('CFSDeletes' = file_type)
												%tb_inc_deletes%
													#elseif('SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
														join(join(
															 %tb_inc_total%, %tb_inc_approved%, left.ori = right.ori, full outer)
															,%tb_file_total%, left.ori = right.ori, full outer)
															// ,%tb_allTime_ImportTotal%, left.data_provider_id = right.data_provider_id, full outer);
														#else
															join(join(join(join(join(join(
															 %tb_inc_total%, %tb_inc_approved%, left.ori = right.ori, full outer)
															,%tb_file_total%, left.ori = right.ori, full outer)
															,%tb_inc_geocoded%, left.ori = right.ori, full outer)
															,%tb_file_first_date%, left.ori = right.ori, full outer)
															,%tb_file_last_date%, left.ori = right.ori, full outer)
															,%tb_allTime_ImportTotal%, left.ori = right.ori, full outer);
								#end;
	
	#uniquename(stats_with_DataProvider)
		%stats_with_DataProvider% := 						
					join(%stats%, %DataProvidertable%, left.ori = right.data_provider_id
							,transform({%stats%, %DataProvidertable%.data_provider_ori, %DataProvidertable%.data_provider_name,%DataProvidertable%.records_uploaded, %DataProvidertable%.records_approved, %DataProvidertable%.flagged_records, %DataProvidertable%.geocode_google, %DataProvidertable%.geocode_provider, %DataProvidertable%.first_date, %DataProvidertable%.last_date},
								self.first_date := Bair.DateToMonDDYYYY(ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(right.first_date,'.>$!%*@=?&\''),left,right)));
								self.last_date 	:= Bair.DateToMonDDYYYY(ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(right.last_date,'.>$!%*@=?&\''),left,right)));
								self := left;
								self := right;)
					,LEFT OUTER);					
	
	#uniquename(MakeSummaryDS)
		Bair.RaidsReport_Layout.summaryRec %MakeSummaryDS%(%stats_with_DataProvider% L, INTEGER ctr) := transform
		
		#if('CFS' = file_type or 'EventMO' = file_type or 'Offenders' = file_type or 'SHO' = file_type or 'LPR' = file_type or 'Crash' = file_type)
			#uniquename(importIncidentTotal)
				%importIncidentTotal% 					:= L.imp_inc_total;
			#uniquename(importIncidentApproved)
				%importIncidentApproved% 				:= L.imp_inc_approved;
			#uniquename(importIncidentApprovedPct)
				%importIncidentApprovedPct% 		:= REALFORMAT(%importIncidentApproved%*100/%importIncidentTotal%, 6, 2);
			#uniquename(importIncidentQuarantined)
				%importIncidentQuarantined% 		:=  %importIncidentTotal% - %importIncidentApproved%;
			#uniquename(importIncidentQuarantinedPct)
				%importIncidentQuarantinedPct% 	:= REALFORMAT(100 - (real8)%importIncidentApprovedPct%, 6, 2);
			#uniquename(noImportIncident)
				%noImportIncident% 							:= 0;
				
			#uniquename(allTimeimportIncidentTotal)
				%allTimeimportIncidentTotal% 					:= L.records_uploaded;	
			#uniquename(allTimeimportIncidentApproved)
				%allTimeimportIncidentApproved% 			:= L.records_approved;
			#uniquename(allTimeimportIncidentApprovedPct)
				%allTimeimportIncidentApprovedPct% 		:= REALFORMAT(%allTimeimportIncidentApproved%*100/%allTimeimportIncidentTotal%, 6, 2);
			#uniquename(allTimeimportIncidentQuarantined)
				%allTimeimportIncidentQuarantined% 		:=  L.flagged_records;
			#uniquename(allTimeimportIncidentQuarantinedPct)
				%allTimeimportIncidentQuarantinedPct% := REALFORMAT(%allTimeimportIncidentQuarantined%*100/%allTimeimportIncidentTotal%, 6, 2);
			#uniquename(allTimenoImportIncident)
				%allTimenoImportIncident% 						:= 0;			
		#end
		
		#if('CFS' = file_type or 'EventMO' = file_type or 'SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
			ds := dataset([
			{L.ori, 'Approved ' + #if('EventMO' = file_type) 'Incidents' #else 'Records' #end, %importIncidentApproved%, %importIncidentApprovedPct%, %allTimeimportIncidentApproved%,  %allTimeimportIncidentApprovedPct%},
			{L.ori, 'Quarantined ' + #if('EventMO' = file_type) 'Incidents' #else 'Records' #end, %importIncidentQuarantined%, %importIncidentQuarantinedPct%, %allTimeimportIncidentQuarantined%, %allTimeimportIncidentQuarantinedPct%},
			{L.ori, '\'Do Not Import\' ' + #if('EventMO' = file_type) 'Incidents' #else 'Records' #end, '0', '', '0', ''}
			], Bair.RaidsReport_Layout.summaryRec);
		#end
		
		#if('EventPersons' = file_type or 'EventVehicles' = file_type or 'EventDeletes' = file_type)
			ds := dataset([
			{L.ori, 'Approved Incidents', 0, 0, 0, 0},
			{L.ori, 'Quarantined Incidents', 0, 0, 0, 0},
			{L.ori, '\'Do Not Import\' Incidents', 0, 0, 0, 0}
			], Bair.RaidsReport_Layout.summaryRec);
		#end

			self := row({ds[ctr].providerID, ds[ctr].description, ds[ctr].importCount, ds[ctr].importPct, ds[ctr].allTimeCount, ds[ctr].allTimePct}, Bair.RaidsReport_Layout.summaryRec);		
	end;
	
	#uniquename(summary_blk)
		%summary_blk% := NORMALIZE(%stats_with_DataProvider%, 3, 	%MakeSummaryDS%(LEFT,COUNTER));
	
	#uniquename(MakeFileCountDS)
	Bair.RaidsReport_Layout.filesCountRec %MakeFileCountDS%(%stats_with_DataProvider% L, INTEGER ctr) := transform
	
		#uniquename(importFileTotal)
			%importFileTotal% 						:= #if('EventDeletes' = file_type or 'CFSDeletes' = file_type) 0 #else L.imp_file_total #end;	
		#uniquename(allTimeimportFileTotal)
			%allTimeimportFileTotal% 			:=  #if('EventPersons' = file_type or 'EventVehicles' = file_type or 'EventMO' = file_type) L.allTime_ImportTotal #else 0 #end; //calculate from actual full file
		#uniquename(importIncidentTotal)
			%importIncidentTotal% 				:= #if('EventPersons' = file_type or 'EventVehicles' = file_type or 'EventDeletes' = file_type or 'CFSDeletes' = file_type) 0 #else L.imp_inc_total #end;
		#uniquename(allTimeimportIncidentTotal)
			%allTimeimportIncidentTotal% 	:= #if('EventPersons' = file_type or 'EventVehicles' = file_type or 'EventDeletes' = file_type or 'CFSDeletes' = file_type) 0 #else L.records_uploaded #end;

		#if('EventMO' = file_type or 'EventPersons' = file_type or 'EventVehicles' = file_type or 'EventDeletes' = file_type)
			ds := dataset([
			#if('EventMO' = file_type)
				{L.ori, 'Incidents', %importIncidentTotal%, %allTimeimportIncidentTotal%},
			#end
			{L.ori, #if('EventMO' = file_type) 'MO' #elseif('EventVehicles' = file_type) 'VEHICLE' #elseif('EventPersons' = file_type) 'PERSONS' #elseif('EventDeletes' = file_type) '' #end, %importFileTotal%, %allTimeimportFileTotal%}
			], Bair.RaidsReport_Layout.filesCountRec);
		#end

		#if('CFS' = file_type or 'CFSDeletes' = file_type)
			ds := dataset([
			{L.ori, 'CFS Records', %importFileTotal%, %allTimeimportIncidentTotal%},
			{0,'',0,0}
			], Bair.RaidsReport_Layout.filesCountRec);
		#end
		
		#if('SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
			ds := dataset([
			{L.ori, 'Incident Records', %importFileTotal%, %allTimeimportIncidentTotal%},
			{0,'',0,0}
			], Bair.RaidsReport_Layout.filesCountRec);
		#end
		
		self := row({ds[ctr].providerID, ds[ctr].fileName, ds[ctr].importCount, ds[ctr].allTimeCount}, Bair.RaidsReport_Layout.filesCountRec);
	end;
	
	#uniquename(filecount_blk)
		%filecount_blk% := NORMALIZE(%stats_with_DataProvider%, 2, %MakeFileCountDS%(left, COUNTER))(providerID <> 0);			
	
	#uniquename(MakeCoordinatesDS)
	Bair.RaidsReport_Layout.coordinatesRec %MakeCoordinatesDS%(%stats_with_DataProvider% L, INTEGER ctr) := transform
	
		#if('CFS' = file_type or 'EventMO' = file_type)
			#uniquename(importAgencyCount)
				%importAgencyCount% 	:= L.imp_inc_approved - L.imp_inc_geocoded;
			#uniquename(importBairCount)
				%importBairCount% 		:= L.imp_inc_geocoded;	
			#uniquename(importAgencyPct)
				%importAgencyPct% 		:= REALFORMAT(%importAgencyCount%*100/L.imp_inc_approved, 6, 2);
			#uniquename(importBairPct)
				%importBairPct% 			:= REALFORMAT(100 - (real8)%importAgencyPct%, 6, 2);
			#uniquename(allTimeBairCount)
				%allTimeBairCount% 		:= L.geocode_google;
			#uniquename(allTimeAgencyCount)
				%allTimeAgencyCount% 	:= L.geocode_provider;
			#uniquename(allTimeBairPct)
				%allTimeBairPct% 			:= REALFORMAT(%allTimeBairCount%*100/L.records_approved, 6, 2);
			#uniquename(allTimeAgencyPct)
				%allTimeAgencyPct% 		:= REALFORMAT(100 - (real8)%allTimeBairPct%, 6, 2);
				
			ds := dataset([
			{L.ori, 'Provided by Agency', %importAgencyCount%, %importAgencyPct%, %allTimeAgencyCount%,  %allTimeAgencyPct%},
			{L.ori, 'Geocoded by BAIR', %importBairCount%, %importBairPct%, %allTimeBairCount%,  %allTimeBairPct%}
			], Bair.RaidsReport_Layout.coordinatesRec);
		#end
		
		#if('EventPersons' = file_type or 'EventVehicles' = file_type or 'EventDeletes' = file_type or 'CFSDeletes' = file_type or 'SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
			ds := dataset([
			{L.ori, 'Provided by Agency', 0, 0, 0, 0},
			{L.ori, 'Geocoded by BAIR', 0, 0, 0, 0}
			], Bair.RaidsReport_Layout.coordinatesRec);
		#end
		
		self := row({ds[ctr].providerID, ds[ctr].description, ds[ctr].importCount, ds[ctr].importPct, ds[ctr].allTimeCount, ds[ctr].allTimePct}, Bair.RaidsReport_Layout.coordinatesRec);
	end;
	
	#uniquename(coordinates_blk)
		%coordinates_blk% := NORMALIZE(%stats_with_DataProvider%, 2, %MakeCoordinatesDS%(left, COUNTER))(providerID <> 0);
	
	#uniquename(MakeDateRangeDS)
	Bair.RaidsReport_Layout.dateRangeRec %MakeDateRangeDS%(%stats_with_DataProvider% L, INTEGER ctr) := transform
	
		#if('CFS' = file_type or 'EventMO' = file_type)
			#uniquename(importStartDt)
				%importStartDt% 				:= L.imp_file_first_date;
			#uniquename(importEndDt)
				%importEndDt% 					:= L.imp_file_last_date;
			#uniquename(importStartDtAlltime)
				%importStartDtAlltime% 	:= L.first_date;
			#uniquename(importEndDtAlltime)
				%importEndDtAlltime% 		:= L.last_date;
		
			ds := dataset([
			{L.ori, 'Start Date', %importStartDt%, %importStartDtAlltime%},
			{L.ori, 'End Date', %importEndDt%, %importEndDtAlltime%}
			], Bair.RaidsReport_Layout.dateRangeRec);
		#end
		
		#if('EventPersons' = file_type or 'EventVehicles' = file_type or 'EventDeletes' = file_type or 'CFSDeletes' = file_type or 'SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
			ds := dataset([
			{L.ori, 'Start Date', '', ''},
			{L.ori, 'End Date', '', ''}
			], Bair.RaidsReport_Layout.dateRangeRec);
		#end

		self := row({ds[ctr].providerID, ds[ctr].description, ds[ctr].importDate, ds[ctr].allTimeDate}, Bair.RaidsReport_Layout.dateRangeRec);
	end;
	
	#uniquename(daterange_blk)
		%daterange_blk% := NORMALIZE(%stats_with_DataProvider%, 2, %MakeDateRangeDS%(left, COUNTER))(providerID <> 0);
	
	#uniquename(MakeQuarantinedDS)
	Bair.RaidsReport_Layout.quarantinedRec %MakeQuarantinedDS%(%infile_dedup% L, Bair.QuarantineReasonsDS R) := transform
	
		self.providerID := L.ori;
    self.incidentID := #if('EventMO' = file_type or 'EventPersons' = file_type or 'EventVehicles' = file_type)
												L.ir_number
											#end
											#if('CFS' = file_type)
												L.event_number
											#end
											#if('Offenders' = file_type)
												L.agency_offender_id
											#end
											#if('Crash' = file_type)
												L.case_number
											#end
											#if('EventDeletes' = file_type or 'CFSDeletes' = file_type)
												''
											#end;
    self.Reason			:= #if('EventDeletes' = file_type or 'CFSDeletes' = file_type) '' #else R.reason #end;
    self.Notes			:= #if('EventMO' = file_type)
												case(R.code
														,1 => ''
														,3 => L.Address_of_Crime
														,4 => L.First_Date_Time
														,5 => L.First_Date_Time + ' and ' + L.Last_Date_Time
														,6 => L.Last_Date_Time
														,7 => L.Last_Date_Time
														,10 => ''
														,11 => L.Last_Date_Time
														,12 => L.Address_of_Crime
														,13 => L.X_Coordinate + ' and ' + L.Y_Coordinate
														,15 => L.First_Date_Time + ' and ' + L.Last_Date_Time
														,'');
											 #elseif('CFS' = file_type)
													case(R.code
														,1 => L.address
														,2 => L.initial_type
														,3 => L.date_time_enroute
														,4 => L.date_time_received
														,5 => L.date_time_arrived
														,6 => L.date_time_received
														,7 => L.date_time_cleared
														,8 => ''
														,9 => L.address
														,10 => L.unit + ' and ' + L.officer_name
														,11 => L.date_time_received
														,12 => L.X_Coordinate + ' and ' + L.Y_Coordinate
														,13 => L.date_time_received + ' and ' + L.date_time_arrived
														,14 => L.date_time_received + ' and ' + L.date_time_enroute
														,15 => L.date_time_dispatched
														,16 => L.date_time_received
														,17 => L.date_time_received + ' and ' + L.date_time_cleared
														,'');
											 #elseif('Offenders' = file_type)
													case(R.code
														,1 => ''
														,2 => L.address
														,'');
											 #elseif('Crash' = file_type)
													case(R.code
														,1 => ''
														,2 => L.address
														,3 => L.x + ' and ' + L.y
														,4 => L.report_date
														,'');
											 #elseif('LPR' = file_type)
													case(R.code
														,1 => ''
														,2 => L.X_Coordinate + ' and ' + L.Y_Coordinate
														,3 => L.CaptureDateTime
														,'');
											 #else
												'';
											 #end
	end;
	
	#uniquename(quarantined_blk)
		%quarantined_blk% := #if('EventDeletes' = file_type or 'CFSDeletes' = file_type)
														dataset([], Bair.RaidsReport_Layout.quarantinedRec);
												 #else
														join(%infile_dedup%(quarantined = '1'), Bair.QuarantineReasonsDS(record_type = #if('EventMO' = file_type or 'EventPersons' = file_type or 'EventVehicles' = file_type) 1 #end #if('CFS' = file_type) 2 #end #if('Crash' = file_type) 3 #end #if('Offenders' = file_type) 7 #end), left.quarantine_code = right.code, %MakeQuarantinedDS%(left, right))(providerID <> 0);
												 #end;
		
	#uniquename(MakeDeletedDS)
	Bair.RaidsReport_Layout.deletedRec %MakeDeletedDS%(%stats_with_DataProvider% L, INTEGER ctr) := transform
		#uniquename(recordCount)
			%recordCount% 	:= #if('EventDeletes' = file_type or 'CFSDeletes' = file_type) L.imp_inc_deletes #else 0 #end;
		#uniquename(personsCount)
			%personsCount% 	:= #if('EventDeletes' = file_type) L.imp_persons_deletes #else 0 #end;
		#uniquename(vehicleCount)
			%vehicleCount% 	:= #if('EventDeletes' = file_type) L.imp_vehicle_deletes #else 0 #end;
		
		#if('EventDeletes' = file_type or 'EventMO' = file_type or 'EventPersons' = file_type or 'EventVehicles' = file_type)
			ds := dataset([
			{L.ori,  'MO', %recordCount%},
			{L.ori,  'PERSONS', %personsCount%},
			{L.ori,  'VEHICLE', %vehicleCount%}
			], Bair.RaidsReport_Layout.deletedRec);
		#end
		
		#if('CFSDeletes' = file_type or 'CFS' = file_type)
			ds := dataset([
			{L.ori,  'CFS Records', %recordCount%},
			{0, '', 0},
			{0, '', 0}
			], Bair.RaidsReport_Layout.deletedRec);
		#end
		
		#if('SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
			ds := dataset([
			{L.ori,  'Incident Records', %recordCount%},
			{0, '', 0},
			{0, '', 0}
			], Bair.RaidsReport_Layout.deletedRec);
		#end

		self := row({ds[ctr].providerID, ds[ctr].fileName, ds[ctr].recordCount}, Bair.RaidsReport_Layout.deletedRec);
	end;
	
	#uniquename(deleted_blk)
		%deleted_blk% := NORMALIZE(%stats_with_DataProvider%, 3, %MakeDeletedDS%(left, COUNTER))(providerID <> 0);
	
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
	
	#uniquename(SummaryMove)
	Bair.RaidsReport_Layout.RaidsReportRec %SummaryMove%(Bair.RaidsReport_Layout.RaidsReportRec L, Bair.RaidsReport_Layout.summaryRec R):=TRANSFORM
		SELF.summaryTable 		:= L.summaryTable + R;
		SELF := L;
	END;
	
	#uniquename(DeNormedWithSummaryRecs)
		%DeNormedWithSummaryRecs% := DENORMALIZE(%ParentOnly%, %summary_blk%,
                            LEFT.providerID = RIGHT.providerID,
                            %SummaryMove%(LEFT,RIGHT));
	
	#uniquename(FileCountMove)
	Bair.RaidsReport_Layout.RaidsReportRec %FileCountMove%(Bair.RaidsReport_Layout.RaidsReportRec L, Bair.RaidsReport_Layout.filesCountRec R):=TRANSFORM
		SELF.filesCountTable := L.filesCountTable + R;
		SELF := L;
	END;
	
	#uniquename(DeNormedWithFilesRecs)
		%DeNormedWithFilesRecs% := DENORMALIZE(%DeNormedWithSummaryRecs%, %filecount_blk%,
															LEFT.providerID = RIGHT.providerID,
															%FileCountMove%(LEFT,RIGHT));
	
	#uniquename(CoordinatesMove)
	Bair.RaidsReport_Layout.RaidsReportRec %CoordinatesMove%(Bair.RaidsReport_Layout.RaidsReportRec L, Bair.RaidsReport_Layout.coordinatesRec R):=TRANSFORM
		SELF.coordinatesTable  := L.coordinatesTable  + R;
		SELF := L;
	END;
	
	#uniquename(DeNormedWithCoordinateRecs)
		%DeNormedWithCoordinateRecs% := DENORMALIZE(%DeNormedWithFilesRecs%, %coordinates_blk%,
															LEFT.providerID = RIGHT.providerID,
															%CoordinatesMove%(LEFT,RIGHT));														
	
	#uniquename(DateRangeMove)
	Bair.RaidsReport_Layout.RaidsReportRec %DateRangeMove%(Bair.RaidsReport_Layout.RaidsReportRec L, Bair.RaidsReport_Layout.dateRangeRec R):=TRANSFORM
		SELF.dateRangeTable := L.dateRangeTable + R;
		SELF := L;
	END;
	
	#uniquename(DeNormedWithDateRangeRecs)
		%DeNormedWithDateRangeRecs% := DENORMALIZE(%DeNormedWithCoordinateRecs%, %daterange_blk% ,
															LEFT.providerID = RIGHT.providerID,
															%DateRangeMove%(LEFT,RIGHT));
	
	#uniquename(QuarantinedMove)
	Bair.RaidsReport_Layout.RaidsReportRec %QuarantinedMove%(Bair.RaidsReport_Layout.RaidsReportRec L, Bair.RaidsReport_Layout.quarantinedRec R):=TRANSFORM
		SELF.quarantinedTable  := L.quarantinedTable  + R;
		SELF := L;
	END;
	
	#uniquename(DeNormedWithQuarantinedRecs)
		%DeNormedWithQuarantinedRecs% := DENORMALIZE(%DeNormedWithDateRangeRecs%, %quarantined_blk% ,
															LEFT.providerID = RIGHT.providerID,
															%QuarantinedMove%(LEFT,RIGHT));
	
	#uniquename(DeletedMove)
	Bair.RaidsReport_Layout.RaidsReportRec %DeletedMove%(Bair.RaidsReport_Layout.RaidsReportRec L, Bair.RaidsReport_Layout.deletedRec R):=TRANSFORM
		SELF.deletedTable  := L.deletedTable  + R;
		SELF := L;
	END;
	
	#uniquename(DeNormedWithDeletedRecs)
		%DeNormedWithDeletedRecs% := DENORMALIZE(%DeNormedWithQuarantinedRecs%, %deleted_blk%,
															LEFT.providerID = RIGHT.providerID,
															%DeletedMove%(LEFT,RIGHT));
	
	#uniquename(UnclassifiedMove)
	Bair.RaidsReport_Layout.RaidsReportRec %UnclassifiedMove%(Bair.RaidsReport_Layout.RaidsReportRec L, Bair.RaidsReport_Layout.unclassifiedCrimeRec R):=TRANSFORM
		SELF.unclassifiedCrimeTable  := L.unclassifiedCrimeTable  + R;
		SELF := L;
	END;
	
	#uniquename(unclassified_blk)
		%unclassified_blk% := #if('EventDeletes' = file_type or 'CFSDeletes' = file_type or 'SHO' = file_type or 'LPR' = file_type or 'Offenders' = file_type or 'Crash' = file_type)
															DATASET([], Bair.RaidsReport_Layout.unclassifiedCrimeRec);
													#else
															project(%tb_unclassified_crimes%, transform(Bair.RaidsReport_Layout.unclassifiedCrimeRec, self.providerId := left.ori; self.description := left.crime;));
													#end
	
	#uniquename(DeNormedWithUnclassifiedRecs)
		%DeNormedWithUnclassifiedRecs% := DENORMALIZE(%DeNormedWithDeletedRecs%, %unclassified_blk%,
															LEFT.providerID = RIGHT.providerID,
															%UnclassifiedMove%(LEFT,RIGHT));
															
	outrec := sort(%DeNormedWithUnclassifiedRecs%, providerID);
#else
	outrec := 'Incorrect file_type; Valid types [EventMO, EventPersons, EventVehicles, CFS, Offenders, Crash, LPR, SHO]';
#end
ENDMACRO;