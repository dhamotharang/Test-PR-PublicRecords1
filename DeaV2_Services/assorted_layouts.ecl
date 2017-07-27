import DEA, ut;
	
export assorted_layouts := MODULE

		Export int_Ids := RECORD
			unsigned6 inDID;
			unsigned6 inBDID;
		END;
		
		Export layout_Index := RECORD
			DEA.layout_DEA_Out;
			string10 cprim_range;
			string28 cprim_name;
			string8  csec_range;
			string25 cv_city_name;
			string2  cst;
			string5  czip;
			unsigned1 zero := 0;
			int_Ids;
	 END;
	 
	 Export layout_DeaKey := RECORD
			DEA.layout_DEA_In.Dea_Registration_Number;
	 END;
	 
	 export layout_search_IDs := record(layout_DeaKey)
			boolean isDeepDive := false;
	 end;
	 
	Export layout_KeyFormat := RECORD
			layout_Index;
			boolean IsDeepDive := false;
	ENd;

	Export Layout_Output_Child := RECORD
	 //add Clean Address and Clean Name Fields.
	  String40 Name ;
		String160 Address := '' ;
		String20 Bussiness_Type;
		String12 Drug_Schedules;
		String8 Expiration_Date;
		String9 Best_SSN;
		String40 Cname;
		DEA.layout_DEA_In.fname;
		DEA.layout_DEA_In.mname;
		DEA.layout_DEA_In.lname;
		DEA.layout_DEA_In.name_suffix;
		DEA.layout_DEA_In.title;
		DEA.layout_DEA_In.prim_range;
		DEA.layout_DEA_In.predir;
		DEA.layout_DEA_In.prim_name;
		DEA.layout_DEA_In.addr_suffix;
		DEA.layout_DEA_In.postdir;
		DEA.layout_DEA_In.unit_desig;
		DEA.layout_DEA_In.sec_range;
		DEA.layout_DEA_In.p_city_name;
		DEA.layout_DEA_In.v_city_name;
		DEA.layout_DEA_In.st;
		DEA.layout_DEA_In.zip;
		DEA.layout_DEA_In.zip4;
		DEA.layout_DEA_Out.Did;
		DEA.layout_DEA_Out.BDid;
		boolean hasCriminalConviction := false;
		boolean isSexualOffender := false;		
	END;
	
	Export Layout_Output := RECORD

		String9 Dea_Registration_Number;
		unsigned2 penalt;
		Boolean IsDeepDive := false;
		dataset(Layout_Output_Child) Children {maxcount(ut.limits.DEA_MAX)};
  END;
	
END;	


  