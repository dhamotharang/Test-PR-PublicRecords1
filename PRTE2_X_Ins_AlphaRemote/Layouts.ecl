/* ***********************************************************************************************************
PRTE2_X_Ins_AlphaRemote.Layouts

*********************************************************************************************************** */


EXPORT Layouts := MODULE

	EXPORT VIN_Simple_Layout := RECORD
			STRING17 VIN;
			STRING   Year;
			STRING   Make;
			STRING   Model;
	END;

   // only the first 5 fields
	EXPORT Quick_Telematics2 := RECORD
			UNSIGNED8 LexID;
			STRING firstName;
			STRING middleName:='';
			STRING lastName;
			STRING dob;
			STRING	VIN;
			STRING	MAKE;
			STRING	MODEL;
			STRING	YEAR;
   END;
   EXPORT Quick_Tele2Fix := RECORD
         Quick_Telematics2;
			STRING	Fix_VIN;
			STRING	Fix_MAKE;
			STRING	Fix_MODEL;
			STRING	Fix_YEAR;
         STRING   vina_veh_type;         
   END;
END;