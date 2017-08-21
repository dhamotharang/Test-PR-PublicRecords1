IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, 
		Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT Standardize_HMS_Spec_to_Taxonomy_File (string filedate, boolean pUseProd = false):= MODULE
	baseFile	:= HMS_SureScripts.Files(filedate,pUseProd).HMS_Spec_to_Taxonomy_Input;
	
	EXPORT Base	:= FUNCTION																																														
		HMS_SureScripts.layouts.HMS_Spec_to_Taxonomy tMapping(HMS_SureScripts.layouts.HMS_Spec_to_Taxonomy_Input L) := TRANSFORM		
			SELF.Date_Imported			:= (unsigned)filedate;
			SELF.Spec_Code := TRIM(Stringlib.StringToUpperCase(stringlib.stringcleanspaces(L.Spec_Code)), LEFT, RIGHT);
			SELF.Taxonomy := TRIM(Stringlib.StringToUpperCase(stringlib.stringcleanspaces(L.Taxonomy)), LEFT, RIGHT);
			SELF  :=  L;
			SELF  :=  [];
		END; // Transform
		RETURN PROJECT(baseFile, tMapping(LEFT));			
	END; // Function
	/*
	std_input	:= First_base(baseFile,HMS_SureScripts.layouts.HMS_Spec_to_Taxonomy_Input);

	new_base_d := distribute(std_input, hash(Spec_Code, Taxonomy));  // Need more than these?, Why not just SPI?

	new_base_s := sort(new_base_d
		,Spec_Code
		, Taxonomy										
		,local);
																	 						
	Layouts.base t_rollup (new_base_s  le, new_base_s ri) := transform
		 self.Date_Imported            := ut.EarliestDate (le.Date_Imported, ri.Date_Imported);
		 self := if(le.Date_Imported > ri.Date_Imported,le,ri);
	end;
	base_f := rollup(new_base_s,
									left.Spec_Code = right.Spec_Code
									,t_rollup(left, right)
									,local);

	EXPORT Base	:= FUNCTION
																																																
		HMS_SureScripts.layouts.HMS_Spec_to_Taxonomy tMapping(HMS_SureScripts.layouts.HMS_Spec_to_Taxonomy_Input L) := TRANSFORM
		
			SELF.Date_Imported			:= (unsigned)filedate;
			SELF.Spec_Code := TRIM(Stringlib.StringToUpperCase(stringlib.stringcleanspaces(L.Spec_Code)), LEFT, RIGHT);
			SELF.Taxonomy := TRIM(Stringlib.StringToUpperCase(stringlib.stringcleanspaces(L.Taxonomy)), LEFT, RIGHT);
			SELF  :=  L;
			SELF  :=  [];
		END; // Transform
		
		RETURN PROJECT(baseFile, tMapping(LEFT));
				
	END; // Function
*/	
END;