export Ready_Output (

	 dataset(Layouts.Temporary.UniqueId	) pSubjectFile	
	,dataset(Layouts.NormVehicles				)	pVehiclesfile
	,dataset(Layouts.Input.Sprayed			) pRawFileInput	= files().input.sprayed
	,string																pPersistname	= persistnames().ReadyOutput

) :=
function
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	// -- rollup subject file
	//////////////////////////////////////////////////////////////////////////////////////////////////
	blanksubject := dataset([],layouts.input.Subject);

	dprojsubject := project(pSubjectFile, transform(
			 Layouts.Temporary.DeNormNames
			,self.Quoteback	:= left.Quoteback;
			 self.Subject1	:= if(left.subject_num = 1, left.Subject);
			 self.Subject2	:= if(left.subject_num = 2, left.Subject);
			 self.Subject3	:= if(left.subject_num = 3, left.Subject);
			 self.Subject4	:= if(left.subject_num = 4, left.Subject);
			 self.Subject5	:= if(left.subject_num = 5, left.Subject);
		)
	);

	drollupsubject := rollup(sort(dprojsubject, Quoteback)
			,transform(
			 Layouts.Temporary.DeNormNames
			,self.Quoteback	:= left.Quoteback;
			 self.Subject1	:= if(left.Subject1.Last_Name != '', left.Subject1, right.Subject1);
			 self.Subject2	:= if(left.Subject2.Last_Name != '', left.Subject2, right.Subject2);
			 self.Subject3	:= if(left.Subject3.Last_Name != '', left.Subject3, right.Subject3);
			 self.Subject4	:= if(left.Subject4.Last_Name != '', left.Subject4, right.Subject4);
			 self.Subject5	:= if(left.Subject5.Last_Name != '', left.Subject5, right.Subject5);
	                                                                                   
		)
		,Quoteback
	) : persist(persistnames().ReadyOutput + '.drollupsubject');
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	// -- rollup Vehicles file
	//////////////////////////////////////////////////////////////////////////////////////////////////
	blankVehicle := dataset([],layouts.input.Vehicles);

	dprojVehicles := project(pVehiclesfile, transform(
			 Layouts.Temporary.DeNormVehicles
			,self.Quoteback	:= left.Quoteback;
			 self.Vehicle1	:= if(left.vehicle_num = 1, left.Vehicle);
			 self.Vehicle2	:= if(left.vehicle_num = 2, left.Vehicle);
			 self.Vehicle3	:= if(left.vehicle_num = 3, left.Vehicle);
			 self.Vehicle4	:= if(left.vehicle_num = 4, left.Vehicle);
		)
	);

	drollupVehicles := rollup(sort(dprojVehicles,Quoteback)
		,transform(
			 Layouts.Temporary.DeNormVehicles
			,self.Quoteback	:= left.Quoteback;
			 self.Vehicle1	:= if(left.Vehicle1.VIN_Num != '', left.Vehicle1, right.Vehicle1);
			 self.Vehicle2	:= if(left.Vehicle2.VIN_Num != '', left.Vehicle2, right.Vehicle2);
			 self.Vehicle3	:= if(left.Vehicle3.VIN_Num != '', left.Vehicle3, right.Vehicle3);
			 self.Vehicle4	:= if(left.Vehicle4.VIN_Num != '', left.Vehicle4, right.Vehicle4);
	                                                                                   
		)
		,Quoteback
	): persist(persistnames().ReadyOutput + '.drollupVehicles');

	//////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Join both together
	//////////////////////////////////////////////////////////////////////////////////////////////////
	djoinem := sort(join(
		 drollupsubject
		,drollupVehicles
		,left.Quoteback = right.Quoteback
		,transform(
			 Layouts.Temporary.DeNormAll
			,self := left;
			 self := right;
		)
		,left outer
	),Quoteback): persist(persistnames().ReadyOutput + '.djoinem');
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Join to Raw file
	//////////////////////////////////////////////////////////////////////////////////////////////////
	djoinback := sort(join(
		 pRawFileInput
		,djoinem
		,left.Group_Current.Quoteback = right.Quoteback
		,transform(
			 Layouts.Input.Sprayed
			,self.Group_Current := left.Group_Current	;
			 self.Group_Prior 	:= left.Group_Prior		;
			 self								:= right;
		)
		,left outer
	),Group_Current.Quoteback) 
	: persist(pPersistname);
	
	
	return djoinback;
	
end;
