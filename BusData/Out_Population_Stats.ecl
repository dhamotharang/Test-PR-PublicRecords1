import Business_Header, Busdata;

export Out_Population_Stats :=
module

	export Business_Headers :=
	module
		//left pversion in there for when we change to using versions for these files--for flexibility
	
		export Accurint_Tradeshow(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
			 fAccurint_Tradeshow_As_Business_Header()
			,'AT'
			,versions.Accurint_Tradeshow
		);

		endmacro;
		
		export Credit_Unions(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
			 fCredit_Unions_As_Business_Header(File_Credit_Unions_base)
			,'CU'
			,versions.Credit_Unions
		);

		endmacro;
		
		export SKA(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
			 fSKA_As_Business_Header(File_SKA_Verified_base, File_SKA_Nixie_base)
			,'SK'
			,versions.SKA
		);

		endmacro;
		
		Accurint_Tradeshow(qa, AT);
		Credit_Unions(qa, CU);
		SKA(qa, SK);
		
		export All :=
			parallel(
				 AT
				,CU
				,SK
			);

		
	end;

	export Business_Contact :=
	module
		//left pversion in there for when we change to using versions for these files for flexibility
	
		export Accurint_Tradeshow(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
			 fAccurint_Tradeshow_As_Business_Contact()
			,'AT'
			,versions.Accurint_Tradeshow
		);

		endmacro;
		
		export Credit_Unions(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
			 fCredit_Unions_As_Business_Contact(File_Credit_Unions_base)
			,'CU'
			,versions.Credit_Unions
		);

		endmacro;
		
		export SKA(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
			 fSKA_As_Business_Contact(File_SKA_Verified_base, File_SKA_Nixie_base)
			,'SK'
			,versions.SKA
		);

		endmacro;
		
		Accurint_Tradeshow(qa, AT);
		Credit_Unions(qa, CU);
		SKA(qa, SK);
		
		export All :=
			parallel(
				 AT
				,CU
				,SK
			);

		
	end;


	export All :=
		parallel(
			 Business_Headers.all
			,Business_Contact.all
		);




end;

