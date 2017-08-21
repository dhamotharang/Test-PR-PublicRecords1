import ut, VersionControl, Business_Header_BDL2;

export Proc_build_business_header_BDL2_base_file(

	 string										pversion
	,dataset(Layout_BDL2		)	pBH_BDL			= BH_BDL2	()	

) := 
module

		BuildBase := 
		sequential(
			 Business_Header_BDL2.Proc_Iterate        ('1',pBH_BDL,pversion).DoAll3		
			,Business_Header.promote(pversion,'^.*?base::business_header.*?BDL2$').new2built
		);
			
		export all := 
		sequential(
				BuildBase				
		);
    
end;