IMPORT PhoneFinder_Services, MemberPoint, iesp, Std;
/* 	
   	Function transforms record of PhoneFinder_Services.Layouts.PhoneFinder.BatchOut into recordset of MemberPoint.Layouts.PhoneFinderOutPhone
		Due PhoneFinder_Services.Layouts.PhoneFinder.BatchOut layout is dynamically created based on iesp.Constants.Phone_Finder.MaxOtherPhones
		constant and the result includes columns of form:
		OtherPhone1_PhoneNumber, OtherPhone1[...], OtherPhone2_PhoneNumber, OtherPhone2[...]..., OtherPhone[iesp.Constants.Phone_Finder.MaxOtherPhones]_PhoneNumber
		function iterates over these columns creating a recordset of form:
		1 PhoneNumber
		2 PhoneNumber
			.
			.
			.
		iesp.Constants.Phone_Finder.MaxOtherPhones PhoneNumber
   	
		The main idea not to use normalization is to avoid static declaratinos that results in error if MaxOtherPhones constant is modified
*/
	EXPORT MemberPoint.Layouts.PhoneFinderOutPhone deserializeOtherPhones(PhoneFinder_Services.Layouts.PhoneFinder.BatchOut inRow):=FUNCTION
		LOADXML('<xml/>');
		#DECLARE(storeRec);
		#DECLARE(loopCounter);

		#SET(storeRec, '');
		#SET(loopCounter, 1);
		#LOOP
			#IF(%loopCounter% > iesp.Constants.Phone_Finder.MaxOtherPhones)
				#BREAK;
			#ELSE
				#APPEND(storeRec, 'DATASET([{\'' + %'loopCounter'% + '\',');
				#APPEND(storeRec, 'inRow.did,');
				#APPEND(storeRec, 'inRow.OtherPhone' + %'loopCounter'% + '_PhoneNumber,');
				#APPEND(storeRec, 'inRow.OtherPhone' + %'loopCounter'% + '_PhoneType,');
				#APPEND(storeRec, 'inRow.OtherPhone' + %'loopCounter'% + '_ListingName,');
				#APPEND(storeRec, 'inRow.OtherPhone' + %'loopCounter'% + '_DateFirstSeen,');
				#APPEND(storeRec, 'inRow.OtherPhone' + %'loopCounter'% + '_DateLastSeen,');
				#APPEND(storeRec, 'inRow.OtherPhone' + %'loopCounter'% + '_Carrier,');
				#APPEND(storeRec, 'inRow.OtherPhone' + %'loopCounter'% + '_CarrierCity,');
				#APPEND(storeRec, 'inRow.OtherPhone' + %'loopCounter'% + '_CarrierState,');
				#APPEND(storeRec, 'inRow.OtherPhone' + %'loopCounter'% + '_PhoneStatus,');
				#APPEND(storeRec, '\'\'');
				#APPEND(storeRec, '}], MemberPoint.Layouts.PhoneFinderOutPhone)+');
				#SET(loopCounter, %loopCounter% + 1);
			#END
		#END
		#SET(storeRec, Std.Str.RemoveSuffix(%'storeRec'%, '+'));
		RETURN #EXPAND(%'storeRec'%);
	END;