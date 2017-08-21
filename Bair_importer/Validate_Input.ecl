IMPORT ut,std,_Validate, address, bair,PromoteSupers;
EXPORT Validate_Input := module

		EXPORT CalculateOffset(real offset_max, real offset_min) := FUNCTION
			
					Offset_ := (RANDOM() * (offset_max - offset_min)) + offset_min;
					result	:= If (RANDOM() <= 0.5, Offset_  * (-1.0), Offset_);
					return result;
		 
		END;

		EXPORT QuarantineMo(UNSIGNED4 pORI, string pFirstDate, string pLastDate, unsigned pFirstTime, unsigned pLastTime, string pAddress,real8 X_Coordinate, real8 Y_Coordinate,real8 pBoundingboxsouthwestlat, real8 pBoundingboxsouthwestlong, real8 pBoundingboxnortheastlat, real8 pBoundingboxnortheastlong, unsigned pAccuracy, boolean pCode) := FUNCTION

			
			first_date 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(pFirstDate,'.>$!%*@=?&\''),left,right)); 
			last_date 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(pLastDate,	'.>$!%*@=?&\''),left,right)); 

			#stored('_Validate_Year_Range_Low'	,1900);
			#stored('_Validate_Year_Range_High'	,2099);	
			
			Unsigned4 lTestFlags := _Validate.Date.Rules.Optional | _Validate.Date.Rules.YearValid 	| _Validate.Date.Rules.MonthValid 	| _Validate.Date.Rules.DayValid;		
				
			code := map(
											//Quarantine Dates
											first_date = '' 																											=> '1', 	//-- MO	First Date time and time missing
											_Validate.Date.fIsValid(first_date, lTestFlags,false,false)=false 		=> '4', 	//-- MO	Invalid date string or MO First Date Time before 1900
											pLastDate != '' and first_date > last_date  													=> '15',	//-- MO First Date after Last Date
											pLastDate != '' and first_date = last_date 
													and pLastTime != 0 and pFirstTime > pLastTime 										=> '5',		//-- MO	First Date Time after Last Date Time
											pLastDate != '' and last_date > (string8)std.date.today() 														=> '6',		//-- MO	Future Last Date
											pLastDate != '' and last_date = (string8)std.date.today() 
													and pLastTime != 0  and pLastTime > (unsigned)ut.getTime()[1..4]	=> '7',		//-- MO Future Last Date Time
											pLastDate != '' 
											  and _Validate.Date.fIsValid(last_date,lTestFlags,false,false)=false => '11',	//-- MO Last Date Time before 1900
											first_date = (string8)std.date.today() and pFirstTime > (unsigned)ut.getTime()[1..4]	=> '17',	//-- MO Future First Date Time
											//Quarantine Addresses
											X_Coordinate = 0 and Y_Coordinate = 0  and pAddress = ''							=> '10',	//-- MO Missing address
											(X_Coordinate = 0 or Y_Coordinate = 0) and pAddress != ''							=> '12',	//-- MO Unknown address
											pAccuracy > 0 and pAccuracy < 6																				=> '3',   //-- MO	Low Accuracy*
											X_Coordinate != 0 and Y_Coordinate != 0 and 
											 ((pBoundingBoxSouthWestLat > Y_Coordinate) or
											 (pBoundingBoxNorthEastLat < Y_Coordinate) or
											 (pBoundingBoxSouthWestLong > X_Coordinate) or
											 (pBoundingBoxNorthEastLong < X_Coordinate))													=> '13', 	//-- MO Out of bounds*				
											// MO	Unknown geocoding error*
											// MO Excessive intersection offset distance*
											// MO Invalid time string		
											// MO First Date time did not match date and time
											'0');	
											
				result := IF(pCode,code,if(code='0','0','1'));
				RETURN result;
		END;

		EXPORT QuarantineCFS(UNSIGNED4 pORI, string pDateTimeReceived,string pInitialType,string pDateTimeDispatched, string pDateTimeEnroute, string pDateTimeArrived, string pDateTimeCleared, string pUnit, string pOfficerName, string pAddress, real8 X_Coordinate, real8 Y_Coordinate, real8 pBoundingboxsouthwestlat, real8 pBoundingboxsouthwestlong, real8 pBoundingboxnortheastlat, real8 pBoundingboxnortheastlong, unsigned pAccuracy, UNSIGNED4 officer_ori, string officer_event_number,  boolean pCode) := FUNCTION
	
			#stored('_Validate_Year_Range_Low'	,1900);
			#stored('_Validate_Year_Range_High'	,2099);

			vDateTimeArrived 		:= (unsigned)trim(stringlib.stringfilterout(pDateTimeArrived,'-/:T'),left,right);		
			vDateTimeArrivedF 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(pDateTimeArrived,'.>$!%*@=?&\''),left,right));
			vDateTimeDispatched := (unsigned)trim(stringlib.stringfilterout(pDateTimeDispatched,'-/:T'),left,right);		
			vDateTimeDispatchedF:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(pDateTimeDispatched,'.>$!%*@=?&\''),left,right)); 			
			vDateTimeReceived 	:= (unsigned)trim(stringlib.stringfilterout(pDateTimeReceived,'-/:T'),left,right);			
			vDateTimeReceivedF 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(pDateTimeReceived,'.>$!%*@=?&\''),left,right)); 						
			vDateTimeEnroute 		:= (unsigned)trim(stringlib.stringfilterout(pDateTimeEnroute,'-/:T'),left,right);			
			vDateTimeEnrouteF		:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(pDateTimeEnroute,'.>$!%*@=?&\''),left,right)); 
			vDateTimeCleared 		:= (unsigned)trim(stringlib.stringfilterout(pDateTimeCleared,'-/:T'),left,right);			
			vDateTimeClearedF		:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(pDateTimeCleared,'.>$!%*@=?&\''),left,right)); 
			
			
			Unsigned4 lTestFlags := _Validate.Date.Rules.Optional | _Validate.Date.Rules.YearValid 	| _Validate.Date.Rules.MonthValid 	| _Validate.Date.Rules.DayValid;
			
			code := map(		
											(X_Coordinate = 0.0 or Y_Coordinate = 0.0) and pAddress != ''							=> '1',	  // CFS Unknown addresss
											pAccuracy > 0 and pAccuracy < 6																						=> '9',   // CFS Low Accuracy
											pInitialType = '' 																												=> '2', 	// CFS Initial Type missing
											officer_ori != 0 and officer_event_number != '' and
											vDateTimeDispatchedF >= vDateTimeReceivedF and
												vDateTimeDispatched < vDateTimeReceived																	=> '4', 	// CFS Officer DateTimeDispatched before CFS DateTimeReceived
											officer_ori != 0 and officer_event_number != '' and		
											vDateTimeArrivedF > (string8)std.date.today()																						=> '5', 	// CFS Future Officer DateTimeArrived
											vDateTimeReceivedF = ''																										=> '6',		// CFS DateTimeReceived missing	
											_Validate.Date.fIsValid(vDateTimeReceivedF, lTestFlags,false,false)=false	=> '16', 	// CFS DateTimeReceived before 1900 											
											officer_ori != 0 and officer_event_number != '' and
											vDateTimeClearedF > (string8)std.date.today()																						=> '7', 	// CFS Future Officer DateTimeCleared
											(X_Coordinate = 0.0 or Y_Coordinate = 0.0) and pAddress = ''							=> '8',		// CFS Missing address
											officer_ori != 0 and officer_event_number != '' and
											pUnit = '' and pOfficerName = ''																					=> '10',	// CFS Both Unit and Officer Name are missing from OFFICER record							
											vDateTimeReceivedF > (string8)std.date.today()																						=> '11',	// CFS Future DateTimeReceived					
											officer_ori != 0 and officer_event_number != '' and
											vDateTimeArrivedF >= vDateTimeReceivedF and 
												vDateTimeArrived < vDateTimeReceived																		=> '13',	// CFS Officer DateTimeArrived before CFS DateTimeReceived
											officer_ori != 0 and officer_event_number != '' and
											vDateTimeEnrouteF >= vDateTimeReceivedF and
												vDateTimeEnroute < vDateTimeReceived																		=> '14',	// CFS Officer DateTimeEnroute before CFS DateTimeReceived
											officer_ori != 0 and officer_event_number != '' and
											vDateTimeDispatchedF > (string8)std.date.today()																					=> '15',	// CFS Future Officer DateTimeDispatched
											officer_ori != 0 and officer_event_number != '' and
											vDateTimeClearedF >= vDateTimeReceivedF and 
												vDateTimeCleared < vDateTimeReceived																		=> '17',	// CFS Officer DateTimeCleared before CFS DateTimeReceived
											officer_ori != 0 and officer_event_number != '' and
											vDateTimeEnrouteF > (string8)std.date.today()																						=> '3', 	// CFS Future Officer DateTimeEnroute	
											(X_Coordinate != 0 and Y_Coordinate != 0)    
											and
											(
												pBoundingBoxSouthWestLat > Y_Coordinate  or
												pBoundingBoxNorthEastLat < Y_Coordinate  or
												pBoundingBoxSouthWestLong > X_Coordinate or
												pBoundingBoxNorthEastLong < X_Coordinate
											)																																					=> '12', 	// CFS Out of bounds*				
											'0');	

				result := IF(pCode,code,if(code='0','0','1'));
				
				RETURN result;
		END;

		EXPORT QuarantineOffenders(UNSIGNED4 pORI,string pAddress, real8 X_Coordinate, real8 Y_Coordinate, boolean pCode) := function
		
			code := map(	 X_Coordinate = 0.0 and Y_Coordinate = 0.0  and pAddress = '' 	=> '1', 	// Offenders Missing addresss
										(X_Coordinate = 0.0 or Y_Coordinate = 0.0) and pAddress != ''	  => '2',	  // Offenders Unknown address	
										'0');	
										
			result := IF(pCode,code,if(code='0','0','1'));
			
			RETURN result;
			
		END;
		
		EXPORT QuarantineLPR(UNSIGNED4 pORI,string pCaptureDateTime,real8 X_Coordinate, real8 Y_Coordinate, real8 pBoundingboxsouthwestlat, real8 pBoundingboxsouthwestlong, real8 pBoundingboxnortheastlat, real8 pBoundingboxnortheastlong, boolean pCode ) := function

			vCaptureDateTimeF	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(pCaptureDateTime,'.>$!%*@=?&\''),left,right)); 
			vCaptureDateTime 	:= (unsigned)trim(stringlib.stringfilterout(pCaptureDateTime,'-/:T'),left,right);

			code := map(	
										X_Coordinate = 0.0 or Y_Coordinate = 0.0								=> '1',		// Missing X/Y Coordinates
										(X_Coordinate != 0.0 or Y_Coordinate != 0.0) and 
										(pBoundingBoxSouthWestLat > y_coordinate) 	or
											(pBoundingBoxNorthEastLat < y_coordinate) or
											(pBoundingBoxSouthWestLong > x_coordinate) or
											(pBoundingBoxNorthEastLong < x_coordinate)						=> '2', 	// LPR Out of bounds										
										vCaptureDateTimeF > (string8)std.date.today() 													=> '3',   // Future CaptureDateTime	
										'0');	
										
			result := IF(pCode,code,if(code='0','0','1'));
			
			RETURN result;
			
		END;		
		
		EXPORT QuarantineCrash(UNSIGNED4 pORI,string pAddress, string pReportDate,real8 X_Coordinate, real8 Y_Coordinate, real8 pBoundingboxsouthwestlat, real8 pBoundingboxsouthwestlong, real8 pBoundingboxnortheastlat, real8 pBoundingboxnortheastlong, boolean pCode ) := function

			
			vReportDate 	:= (unsigned)trim(stringlib.stringfilterout(pReportDate,'-/:T'),left,right);
			vReportDateF 	:= ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(pReportDate,'.>$!%*@=?&\''),left,right)); 

			code := map(
										X_Coordinate = 0.0 and  Y_Coordinate = 0.0 and pAddress = '' 							=> '1', // Missing Address
										//X_Coordinate = 0.0 or Y_Coordinate = 0.0   and pAddress != ''							=> '2', // Unknown address	
										X_Coordinate != 0.0 and Y_Coordinate != 0.0 and 
										  ((pBoundingBoxSouthWestLat  > y_coordinate) or
											(pBoundingBoxNorthEastLat  < y_coordinate) or
											(pBoundingBoxSouthWestLong > x_coordinate) or
											(pBoundingBoxNorthEastLong < x_coordinate))														=> '3', // Out of bounds
										vReportDateF > (string8)std.date.today() 																							=> '4', // Future report date
										'0');
										
			result := IF(pCode,code,if(code='0','0','1'));
			
			RETURN result;
			
		END;	
		
		
		EXPORT findNearestIntersection(unsigned4 dp_id, real8 x, real8 y) := function

				ic := bair.files().intersection_coordinates_input(dataProviderID = dp_id);             
				tb := table(ic, {X_Coordinate, Y_Coordinate});
				dd := dedup(sort(tb, X_Coordinate, Y_Coordinate), X_Coordinate, Y_Coordinate);
				
				offset_layout := record
												real8 deltaX;
												real8 deltaY;
												real8 shortestDist;
				end;
				
				offset_layout calcOffset(dd L) := transform
												self.deltaX := L.X_Coordinate - x;
												self.deltaY := L.Y_Coordinate - y;
												self.shortestDist := SQRT((self.deltaX * self.deltaX) + (self.deltaY * self.deltaY));
				end;
				
				dd_p := project(dd, calcOffset(left));
				
				return table(dd_p(shortestDist = min(dd_p, shortestDist)), {deltaX, deltaY});
										
		end;

			EXPORT eval_recordIDRAIDS(integer last_recordID_RAIDS) := FUNCTION
					eval := sequential(					
														fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
														,'*** ALERT **** RecordID_RAIDS is less than '+ bair_importer._Constants.min_recordID_RAIDS
														,Bair_importer.email_msg(workunit,last_recordID_RAIDS).RecordID_RAIDS_MSG),
											FAIL('RecordID_RAIDS is less than ' + bair_importer._Constants.min_recordID_RAIDS)
									);
									
					eval_recordID_RAIDS := if(last_recordID_RAIDS < bair_importer._Constants.min_recordID_RAIDS, eval);
					RETURN eval_recordID_RAIDS;
			END;
			
			EXPORT fn_GetMORecordID(boolean eval = false) := FUNCTION
				res := dataset(bair_importer._constants.recordid_raids_built,bair_importer.layouts.recordid_raids, THOR);
				if(eval,eval_recordIDRAIDS(res[1].mo_recordid_raids));
				return res[1].mo_recordid_raids;		
			END;

			EXPORT fn_GetPersonRecordID(boolean eval = false) := FUNCTION
				res := dataset(bair_importer._constants.recordid_raids_built,bair_importer.layouts.recordid_raids, THOR);
				if(eval,eval_recordIDRAIDS(res[1].person_recordid_raids));
				return res[1].person_recordid_raids;		
			END;
			
			
			EXPORT fn_SetRecordID_RAIDS(unsigned5 moLastSequence, unsigned5 personLastSequence, string pVersion, boolean pUseProd = false) := FUNCTION
			
				dNew := dataset([{moLastSequence,personLastSequence}],bair_importer.layouts.recordid_raids);

				PromoteSupers.MAC_SF_BuildProcess(dNew,Bair_importer.Filenames().lBaseRecordIdRaidsTemplate, doIt ,2,,true,pVersion);
				err:='ERROR - bair_importer.Validate_Input.fn_SetRecordID_RAIDS returned bad recordID_RAIDS';
				return if(moLastSequence>50000000000 and personLastSequence>50000000000
										,doIt
										,sequential(
										fileservices.sendemail('jose.bello@lexisnexis.com','import error',workunit+'\n\n'+err+'\n\n'+failmessage)
										,fail(err)
										)

									);
			END;
			

END;