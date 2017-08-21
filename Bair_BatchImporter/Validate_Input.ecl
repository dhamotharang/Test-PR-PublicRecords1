IMPORT ut,std,_Validate, address, bair,PromoteSupers;
EXPORT Validate_Input := module

		EXPORT CalculateOffset(real offset_max, real offset_min) := FUNCTION
			
					Offset_ := (RANDOM() * (offset_max - offset_min)) + offset_min;
					result	:= If (RANDOM() <= 0.5, Offset_  * (-1.0), Offset_);
					return result;
		 
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
														,'*** ALERT **** RecordID_RAIDS is less than '+ _Constants.min_recordID_RAIDS
														,email_msg(workunit,last_recordID_RAIDS).RecordID_RAIDS_MSG),
											FAIL('RecordID_RAIDS is less than ' + _Constants.min_recordID_RAIDS)
									);
									
					eval_recordID_RAIDS := if(last_recordID_RAIDS < _Constants.min_recordID_RAIDS, eval);
					RETURN eval_recordID_RAIDS;
			END;
			
			EXPORT fn_GetMORecordID(boolean eval = false) := FUNCTION
				res := dataset(_constants.recordid_raids_built,layouts.recordid_raids, THOR);
				if(eval,eval_recordIDRAIDS(res[1].mo_recordid_raids));
				return res[1].mo_recordid_raids;		
			END;

			EXPORT fn_GetPersonRecordID(boolean eval = false) := FUNCTION
				res := dataset(_constants.recordid_raids_built,layouts.recordid_raids, THOR);
				if(eval,eval_recordIDRAIDS(res[1].person_recordid_raids));
				return res[1].person_recordid_raids;		
			END;
			
			
			EXPORT fn_SetRecordID_RAIDS(unsigned5 moLastSequence, unsigned5 personLastSequence, string pVersion, boolean pUseProd = false) := FUNCTION
			
				dNew := dataset([{moLastSequence,personLastSequence}],layouts.recordid_raids);

				PromoteSupers.MAC_SF_BuildProcess(dNew,Filenames().lBaseRecordIdRaidsTemplate, doIt ,2,,true,pVersion);
				err:='ERROR - Validate_Input.fn_SetRecordID_RAIDS returned bad recordID_RAIDS';
				return if(moLastSequence>50000000000 and personLastSequence>50000000000
										,doIt
										,sequential(
										fileservices.sendemail('jose.bello@lexisnexis.com','import error',workunit+'\n\n'+err+'\n\n'+failmessage)
										,fail(err)
										)

									);
			END;
			

END;