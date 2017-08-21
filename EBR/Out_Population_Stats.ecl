import Business_Header, strata;
export Out_Population_Stats(string filedate) :=
module


	export Business_Headers(pversion, pOut) :=
	macro
	//left pversion in there for when we change to using versions for these files--for flexibility
		strata.createAsBusinessHeaderStats(
			fEBR_As_Business_Header(File_0010_Header_Base),
			'Experian Business Reports', 
		   'Data', 
		   filedate, 
		   'lbentley@seisint.com', 
		   pOut
		  );

	endmacro;

	Business_Headers(qa, BH);
	export bh_out := bh;

			
	export Business_Contact(pversion, pOut) :=
	macro
	//left pversion in there for when we change to using versions for these files--for flexibility
			
		export pOut := Business_Header.fAsBusinessContactStats(
			fEBR_As_Business_Contact(File_0010_Header_Base, File_5610_Demographic_Data_Base)
			,'EB'
			,filedate
		);
	endmacro;

	Business_Contact(qa, BC);

	export All :=
	parallel(
		 BH_out
		,EBR.Strata_Grid_Stats(filedate)
//		,BC
	);



end;



