export Normalize_Input :=
module

	export Names(

		dataset(Layouts.Input.Sprayed) pRawFileInput	= files().input.sprayed

	) :=
	function

		Layouts.NormNames	tNormInput(Layouts.Input.Sprayed l,unsigned cnt) :=
		transform
			
			self.Did													:= 0;
			self.did_score										:= 0;
			
			self.Quoteback										:= l.Group_Current.Quoteback	;	// unique id to join back to input file
			self.subject_num									:= cnt;
			self.Subject											:= case(cnt
																						,1 => l.Subject1
																						,2 => l.Subject2
																						,3 => l.Subject3
																						,4 => l.Subject4
																						,			l.Subject5
																					);
			self.clean_subject_name						:= [];
			self.Clean_Subject_address				:= [];

			self.clean_dates									:= [];

		end;

		dNormedInput := normalize(pRawFileInput,5,tNormInput(left,counter));
		
		dFilter := dNormedInput(Subject.Last_Name != '');

		return dFilter;

	end;
	
	export Vehicles(

		dataset(Layouts.Input.Sprayed) pRawFileInput	= files().input.sprayed

	) :=
	function

		Layouts.NormVehicles	tNormInput(Layouts.Input.Sprayed l,unsigned cnt) :=
		transform
			
			self.Quoteback										:= l.Group_Current.Quoteback	;	// unique id to join back to input file
			self.vehicle_num									:= cnt;
			self.Vehicle											:= case(cnt
																						,1 => l.Vehicle1
																						,2 => l.Vehicle2
																						,3 => l.Vehicle3
																						,			l.Vehicle4
																					);        

		end;

		dNormedInput := normalize(pRawFileInput,4,tNormInput(left,counter));
		
		dFilter := dNormedInput;

		return dFilter;

	end;

end;