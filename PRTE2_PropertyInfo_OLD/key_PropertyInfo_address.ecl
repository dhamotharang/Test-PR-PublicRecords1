IMPORT PRTE_CSV;

// This was originally all in NEW_process_build_propertyinfo, so search history there to see older changes

EXPORT key_PropertyInfo_address(STRING Filedate)  := FUNCTION

		All_Expanded := Get_Payload.All_Expanded;

		rKeyPropertyInfo__address := RECORD
					PRTE_CSV.PropertyInformation.rthor_data400__key__propertyinfo__address;
		END;

		rKeyPropertyInfo__address  Reformat_Address (All_Expanded L) := TRANSFORM
					SELF := L;
					SELF := [];
		END;

		dKeyPropInfo__property__address	:= PROJECT(All_Expanded, Reformat_Address (Left));

		STRING keyFileName := Files.BuildKeyADDRName(Filedate);
		
		RETURN index(dKeyPropInfo__property__address,
										{prim_name,prim_range,zip,predir,postdir,addr_suffix,sec_range},
										{dKeyPropInfo__property__address},
										keyFileName);

END;