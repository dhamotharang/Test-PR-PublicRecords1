IMPORT DEA,iesp,doxie_files;
export Layouts := MODULE;
	export Layout_DEA_out :=record (DEA.layout_DEA_Out)

	end;

	export DEANumberPlus := record
		   string15 Dea_Registration_Number;
		   unsigned6 did;
		   unsigned6 bdid;
		   boolean isDeepDive := false;
	end;	
	export rawrec := record

		   Layout_DEA_out;
		   boolean isDeepDive := false;
		   unsigned2 penalt := 0;
	end;	
	
		Export int_Ids := RECORD
			unsigned6 inDID;
			unsigned6 inBDID;
		END;
		
		Export layout_Index := RECORD
			layout_DEA_Out;
			string10 cprim_range;
			string28 cprim_name;
			string8  csec_range;
			string25 cv_city_name;
			string2  cst;
			string5  czip;
			unsigned1 zero := 0;
			int_Ids;
	 END;

END;
