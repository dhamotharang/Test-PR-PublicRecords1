import Versioncontrol;
export Files(STRING pVersion = '') := module
 //////////////////////////////////////////////////////////////////
 // -- Vendor Files
 //////////////////////////////////////////////////////////////////
 export Vendor := module
   EXPORT ISDA := module	    
	  shared INTEGER _ISDA := Source_Codes.ISDA;
		export Class_Description := Redefine_Input(_ISDA).Class_Description; 
		export Title_Company_Number := Redefine_Input(_ISDA).Title_Company_Number;
		export Corporate_Address := Redefine_Input(_ISDA).Corporate_Address;
		export Mailing_Address := Redefine_Input(_ISDA).Mailing_Address;
		export Phone_Numbers := Redefine_Input(_ISDA).Phone_Numbers;
		export Telex_Numbers := Redefine_Input(_ISDA).Telex_Numbers;
		export TWX_Numbers := Redefine_Input(_ISDA).TWX_Numbers;
		export Cable_Numbers := Redefine_Input(_ISDA).Cable_Numbers;
		export Fax_Numbers := Redefine_Input(_ISDA).Fax_Numbers;
		export Other_Numbers := Redefine_Input(_ISDA).Other_Numbers;
		export Email_URL := Redefine_Input(_ISDA).Email_URL;
		export Number_Of_Employees := Redefine_Input(_ISDA).Number_Of_Employees;
		export Advertising_Budget := Redefine_Input(_ISDA).Advertising_Budget;
		export Media_Type := Redefine_Input(_ISDA).Media_Type;
	    export Executives := Redefine_Input(_ISDA).Executives;
		export SIC_Codes := Redefine_Input(_ISDA).SIC_Codes;
		export Approximate_Sales := Redefine_Input(_ISDA).Approximate_Sales;
		export Advertising_Appropriations := Redefine_Input(_ISDA).Advertising_Appropriations;
		export Sub_Company_Headings := Redefine_Input(_ISDA).Sub_Company_Headings;
		export Business_Description := Redefine_Input(_ISDA).Business_Description;
		export Advertising_Distribution := Redefine_Input(_ISDA).Advertising_Distribution;
		export Tradenames := Redefine_Input(_ISDA).Tradenames;
		export Agency_Title := Redefine_Input(_ISDA).Agency_Title;
		export Agency_Product_Data := Redefine_Input(_ISDA).Agency_Product_Data;
		export Agency_Corporate_Address := Redefine_Input(_ISDA).Agency_Corporate_Address;
		export Agency_Mailing_Address := Redefine_Input(_ISDA).Agency_Mailing_Address;
		export Agency_Phone_Numbers := Redefine_Input(_ISDA).Agency_Phone_Numbers;
		export Agency_Executives := Redefine_Input(_ISDA).Agency_Executives;
	END; //ISDA

    export ISDAA := module
	  shared INTEGER _ISDAA := Source_Codes.ISDAA;  
		export Class_Description := Redefine_Input(_ISDAA).Class_Description;
	  export  Title := Redefine_Input(_ISDAA).Title;
	  export Corporate_Address := Redefine_Input(_ISDAA).Corporate_Address;
	  export Mailing_Address := Redefine_Input(_ISDAA).Mailing_Address;
	  export Phone_Numbers := Redefine_Input(_ISDAA).Phone_Numbers;
	  export Telex_Numbers := Redefine_Input(_ISDAA).Telex_Numbers;
	  export TWX_Numbers := Redefine_Input(_ISDAA).TWX_Numbers;
    end;
	  
	export IAD := module
	  shared INTEGER _IAD := Source_Codes.IAD;
	  export Class_Description := Redefine_Input(_IAD).Class_Description;
	  export  Title := Redefine_Input(_IAD).Title;
	  export  Title_Company_Number := Redefine_Input(_IAD).Title_Company_Number;
	  export Corporate_Address := Redefine_Input(_IAD).Corporate_Address;
	  export Mailing_Address := Redefine_Input(_IAD).Mailing_Address;
	  export Phone_Numbers := Redefine_Input(_IAD).Phone_Numbers;
	  export Telex_Numbers := Redefine_Input(_IAD).Telex_Numbers;
	  export Fax_Numbers := Redefine_Input(_IAD).Fax_Numbers;
	  export Other_Numbers := Redefine_Input(_IAD).Other_Numbers;
	  export Email_URL := Redefine_Input(_IAD).Email_URL;
	  export Number_Of_Employees := Redefine_Input(_IAD).Number_Of_Employees;
	  export Advertising_Budget := Redefine_Input(_IAD).Advertising_Budget;
	  export Annual_Billing := Redefine_Input(_IAD).Annual_Billing;
	  export Gross_Billing_By_Media := Redefine_Input(_IAD).Gross_Billing_By_Media;
	  export Media_Type := Redefine_Input(_IAD).Media_Type;
	  export Executives := Redefine_Input(_IAD).Executives;
	  export Approximate_Sales := Redefine_Input(_IAD).Approximate_Sales;
	  export Advertising_Appropriations := Redefine_Input(_IAD).Advertising_Appropriations;
	  export Sub_Company_Headings := Redefine_Input(_IAD).Sub_Company_Headings;
	  export Business_Description := Redefine_Input(_IAD).Business_Description;
	  export Tradenames := Redefine_Input(_IAD).Tradenames;
	  export Agency_Title := Redefine_Input(_IAD).Agency_Title;
	  export Agency_Product_Data := Redefine_Input(_IAD).Agency_Product_Data;
	  export Agency_Corporate_Address := Redefine_Input(_IAD).Agency_Corporate_Address;
	  export Agency_Mailing_Address := Redefine_Input(_IAD).Agency_Mailing_Address;
	  export Agency_Phone_Numbers := Redefine_Input(_IAD).Agency_Phone_Numbers;
	  export Agency_Executives := Redefine_Input(_IAD).Agency_Executives;
	end;
 	
	export IAG := module
	  shared INTEGER _IAG := Source_Codes.IAG;
	  export Title  := Redefine_Input(_IAG).Title;
      export Title_Company_Number  := Redefine_Input(_IAG).Title_Company_Number;
      export Corporate_Address  := Redefine_Input(_IAG).Corporate_Address;
      export Mailing_Address  := Redefine_Input(_IAG).Mailing_Address;
      export Phone_Numbers  := Redefine_Input(_IAG).Phone_Numbers;
      export Telex_Numbers  := Redefine_Input(_IAG).Telex_Numbers;
      export Fax_Numbers  := Redefine_Input(_IAG).Fax_Numbers;
      export Other_Numbers  := Redefine_Input(_IAG).Other_Numbers;
      export Email_URL  := Redefine_Input(_IAG).Email_URL;
      export Number_Of_Employees  := Redefine_Input(_IAG).Number_Of_Employees;
      export Agency_Specialization  := Redefine_Input(_IAG).Agency_Specialization;
      export Advertising_Budget  := Redefine_Input(_IAG).Advertising_Budget;
      export Annual_Billing  := Redefine_Input(_IAG).Annual_Billing;
      export Gross_Billing_By_Media  := Redefine_Input(_IAG).Gross_Billing_By_Media;
      export Media_Type  := Redefine_Input(_IAG).Media_Type;
      export Executives  := Redefine_Input(_IAG).Executives;
      export Sub_Executives_By_Media  := Redefine_Input(_IAG).Sub_Executives_By_Media;
      export Accounts  := Redefine_Input(_IAG).Accounts;
      export Products  := Redefine_Input(_IAG).Products;
 	end; 
 end; //Vendor
 
  //////////////////////////////////////////////////////////////////
  // -- Input File Versions
  //////////////////////////////////////////////////////////////////
	export Input :=
	module
	  versioncontrol.macInputFileVersions(Filenames(pversion).Input.ISDA, layouts.Vendor.Generic_in, ISDA);
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.ISDAA, layouts.Vendor.Generic_in, ISDAA);
	  versioncontrol.macInputFileVersions(Filenames(pversion).Input.IAD, layouts.Vendor.Generic_in, IAD);
	  versioncontrol.macInputFileVersions(Filenames(pversion).Input.IAG, layouts.Vendor.Generic_in, IAG);
	end;
	
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base :=
	module
	  versioncontrol.macBuildFileVersions(Filenames(pversion).Base.Combined, layouts.Base.Layout_Combined,Combined);
	end;
	
	
end; 
