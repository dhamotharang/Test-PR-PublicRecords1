IMPORT AutoKey, doxie, Gateway, Gong, Header, MDR, MemberPoint, Phones, phonesplus_batch, Phonesplus_v2, Risk_Indicators, ut;

	EXPORT PhoneLookup := MODULE
	
		//Phone lookup (from phonesplus_batch)
		SHARED getPhonesPlus(DATASET(MemberPoint.Layouts.BatchInter) batchIn, MemberPoint.IParam.BatchParams options) := FUNCTION
			ppRecs := PROJECT(batchIn, TRANSFORM(phonesplus_batch.layout_phonesplus_reverse_batch_in,
																							SELF.phoneno:= LEFT.primary_phone_number,
																							SELF:= LEFT));			

      ppOptions:= PROJECT(options, phonesplus_batch.options.IOptions, OPT);  
			
			ppResult:= phonesplus_batch.phonesplus_reverse_batch_records(ppRecs, ppOptions);
			lookupResult:= ppResult.Results;
			RETURN lookupResult;
		END;

		//get best data from posible guardians to have access to DBO and SSN
		SHARED getBestGuardians(DATASET(phonesplus_batch.layout_phonesplus_reverse_string_out) phonesPlusDS, 
														MemberPoint.IParam.BatchParams options) := FUNCTION
			derivedGuardians:= PROJECT(phonesPlusDS, TRANSFORM(MemberPoint.Layouts.BatchInter,
																												SELF.LN_search_name_type	:= MemberPoint.Constants.LNSearchNameType.None,
																												SELF.did									:= (UNSIGNED6)LEFT.did,
																												SELF.primary_phone_number	:= LEFT.phone,
																												SELF.name_first						:= LEFT.fname,
																												SELF.name_middle					:= LEFT.mname,
																												SELF.name_last						:= LEFT.lname,
																												SELF.prim_range						:= LEFT.prim_range,
																												SELF.predir 							:= LEFT.predir,
																												SELF.prim_name 						:= LEFT.prim_name,
																												SELF.postdir 							:= LEFT.postdir,
																												SELF.unit_desig 					:= LEFT.unit_desig,
																												SELF.sec_range 						:= LEFT.sec_range,
																												SELF.p_city_name 					:= LEFT.city_name,
																												SELF.st 									:= LEFT.st,
																												SELF.z5 									:= LEFT.zip,
																												SELF.zip4 								:= LEFT.zip4,
																												SELF											:= LEFT,
																												SELF											:= []));
			bestDerived:= MemberPoint.getBest(derivedGuardians, options);
			RETURN bestDerived;
		END;

		//Derive guardians for minors using phones plus as reverse phone lookup
		EXPORT deriveGuardiansFromPhonesPlus(DATASET(MemberPoint.Layouts.BatchInter) minorsDS, MemberPoint.IParam.BatchParams options):= FUNCTION
			//Reverse phone lookup
			phonesPlus:= getPhonesPlus(minorsDS, options);
			//Get best data to handle dob
			bestGuardians:= getBestGuardians(phonesPlus, options);
			MemberPoint.Layouts.BatchInter assignGuardian(MemberPoint.Layouts.BatchInter minor, RECORDOF(bestGuardians) guardian):= TRANSFORM
																										gDOB											:= IF(guardian.dob='', guardian.best_dob, guardian.dob);
																										gSSN											:= IF(guardian.ssn='', guardian.best_ssn, guardian.ssn);
																										age												:= ut.Age((UNSIGNED4)gDOB);
																										isGuardian 								:= age >= MemberPoint.Constants.AdultAgeStart; 
																										SELF.LN_search_name_type	:= IF(isGuardian,MemberPoint.Constants.LNSearchNameType.Derived,MemberPoint.Constants.LNSearchNameType.Minor);
																										SELF.Guardian_name_first	:= IF(isGuardian,guardian.fname,'');
																										SELF.Guardian_name_last		:= IF(isGuardian,guardian.lname,'');
																										SELF.Guardian_DOB					:= IF(isGuardian,gDOB,'');
																										SELF.Guardian_SSN 				:= IF(isGuardian,gSSN,'');
																										SELF 											:= minor;
			END;
			derived:= JOIN(minorsDS, bestGuardians,
										(INTEGER)LEFT.acctno = RIGHT.seq AND 
										LEFT.name_last = RIGHT.lname AND 
										RIGHT.lname <> ''	AND
										RIGHT.score  >= options.UniqueIdScoreThreshold,
										assignGuardian(LEFT,RIGHT),
										LEFT OUTER,
										KEEP(1));
			RETURN derived;
		END;
	
	END;