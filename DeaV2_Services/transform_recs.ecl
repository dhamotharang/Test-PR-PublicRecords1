import doxie,doxie_raw,DEA,Suppress,codes;

export transform_recs(DATASET(Dea.layout_DEA_Out) raw 
											= DATASET([],Dea.layout_DEA_Out)
											)	:= FUNCTION
											
	sorted_recs := SORT(raw,dea_registration_number);
	grouped_recs := GROUP(sorted_recs,dea_registration_number);

	Assorted_Layouts.Layout_Output_Child xfm_output_child(Dea.layout_DEA_Out l) := TRANSFORM
		SELF.Address :=  TRIM(l.Address2,LEFT,RIGHT)
										+' '+TRIM(l.Address3,LEFT,RIGHT)
										+' '+TRIM(l.Address4,LEFT,RIGHT)
										+' '+TRIM(l.Address5,LEFT,RIGHT);
		SELF.Bussiness_Type := codes.DEA_REGISTRATION.BUSINESS_ACTIVITY_CODE(l.Business_Activity_code);
		SELF.Name := trim(l.address1,LEFT,RIGHT);
		SELF := l;
		SELF := [];
	END;
  
	Assorted_Layouts.Layout_Output xfm_output(Dea.layout_DEA_Out l ,DATASET(Dea.layout_DEA_Out) r) := TRANSFORM
		//String str  := l.address1 + If( l.is_Company_Flag,'Doing Business As :');//+If( l.is_Company_Flag,l.cname); 
		SELF.dea_registration_number:= l.dea_registration_number;
		SELF := l;
		SELF.Children := choosen(DEDUP(SORT(PROJECT(r,xfm_Output_child(LEFT)),
																	fname,lname,mname,name_suffix
																	,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4
																	,-expiration_date,drug_schedules,bussiness_type
																	),
														fname,lname,mname,name_suffix
														,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4
														,drug_schedules,bussiness_type
														),15);
		//SELF.Children := choosen(DEDUP(PROJECT(r,xfm_Output_child(LEFT)),ALL),15);
		// SELF.Children := [];
		SELF := [];
	END;

  DEA_recs := rollup( grouped_recs,group, xfm_output(LEFT,rows(left)));
	
	return (DEA_recs);
END;