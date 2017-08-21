export fConvertOld2New :=
module

	export fConvertInput2New(dataset(Layouts_Old.Input.Sprayed) pInputDataset) :=
	function

		Layouts.Input.Sprayed t2NewLayout(Layouts_Old.Input.Sprayed l) :=
		transform
			self.rawfields.Job_Title																	:= l.rawfields.Title;
			self.rawfields.Job_Title_Hierarchy_Level									:= '';
			self.rawfields.Company_Division_Name											:= '';
			self.rawfields.Email_Address															:= l.rawfields.Email;
			self.rawfields.Source_Count																:= '';
			self.rawfields.Last_Updated_Date													:= '';
			self.rawfields.Zoom_Company_ID														:= '';
			self.rawfields.Acquiring_Company_ID												:= '';
			self.rawfields.Parent_Company_ID													:= '';
			self.rawfields.Company_Name																:= l.rawfields.CompanyName;
			self.rawfields.Company_Domain_Name												:= l.rawfields.CompanyURL;
			self.rawfields.Company_Phone															:= '';
			self.rawfields.Industry_Label															:= '';
			self.rawfields.Industry_Hierarchical_Category							:= '';
			self.rawfields.Secondary_Industry_Label										:= '';
			self.rawfields.Secondary_Industry_Hierarchical_Category		:= '';
			self.ExecutiveURL																					:= l.rawfields.ExecutiveURL;

			self := l;
		end;
		
		newlayout := project(pInputDataset, t2NewLayout(left));
		
		return newlayout;

	end;

	export fConvertBase2New(dataset(Layouts_Old.Base) pInputDataset) :=
	function

		Layouts.Base t2NewLayout(Layouts_Old.Base l) :=
		transform
			self.rawfields.Job_Title																	:= l.rawfields.Title;
			self.rawfields.Job_Title_Hierarchy_Level									:= '';
			self.rawfields.Company_Division_Name											:= '';
			self.rawfields.Email_Address															:= l.rawfields.Email;
			self.rawfields.Source_Count																:= '';
			self.rawfields.Last_Updated_Date													:= '';
			self.rawfields.Zoom_Company_ID														:= '';
			self.rawfields.Acquiring_Company_ID												:= '';
			self.rawfields.Parent_Company_ID													:= '';
			self.rawfields.Company_Name																:= l.rawfields.CompanyName;
			self.rawfields.Company_Domain_Name												:= l.rawfields.CompanyURL;
			self.rawfields.Company_Phone															:= '';
			self.rawfields.Industry_Label															:= '';
			self.rawfields.Industry_Hierarchical_Category							:= '';
			self.rawfields.Secondary_Industry_Label										:= '';
			self.rawfields.Secondary_Industry_Hierarchical_Category		:= '';
			self.ExecutiveURL																					:= l.rawfields.ExecutiveURL;

			self := l;
		end;
		
		newlayout := project(pInputDataset, t2NewLayout(left));
		
		return newlayout;

	end;

end;