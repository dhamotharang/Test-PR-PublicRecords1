IMPORT HMS_SureScripts,ut;
EXPORT Update_HMS_SPEC_To_Taxonomy_Base(string filedate, boolean pUseProd = false) := MODULE

	EXPORT _Base	:= FUNCTION
		std_input	:= HMS_SureScripts.Standardize_HMS_Spec_to_Taxonomy_File(filedate,pUseProd).base;
		new_base_d := distribute(std_input, hash(Spec_Code, Taxonomy));  // Need more than these?, Why not just SPI?

		new_base_s := sort(new_base_d
			,Spec_Code
			, Taxonomy										
			,local);
																	 						
		HMS_SureScripts.layouts.HMS_Spec_to_Taxonomy t_rollup (new_base_s  le, new_base_s ri) := transform
			 self.Date_Imported            := ut.EarliestDate (le.Date_Imported, ri.Date_Imported);
			 self := if(le.Date_Imported > ri.Date_Imported,le,ri);
		end;
		base_f := rollup(new_base_s,
										left.Spec_Code = right.Spec_Code
										,t_rollup(left, right)
										,local);		
		RETURN base_f;			
	END; // Function	
END;