	IMPORT lib_fileservices,tools,_control,lib_stringlib,Versioncontrol, HMS_Medicaid_Common,HMS_Medicaid_NY;
	Medicaid_State := 'NY';
	EXPORT Create_AllSheets_File( String pVersion, Boolean pUseProd) := MODULE
		EXPORT DoTheBuild (string pversion, boolean pUseProd) := FUNCTION
		Result := HMS_Medicaid_NY.fSpray(pversion, pUseProd);
		AllSheets := Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet1',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')))
								+ Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet2',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')))
								+ Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet3',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')))
								+ Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet4',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')))
								+ Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet5',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')))
								+ Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet6',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')))
								+ Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet7',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')))
								+ Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet8',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')))
								+ Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet9',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')))
								+ Dataset(HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'Sheet10',
									HMS_Medicaid_Common.Layouts.Medicaid_NY,  csv( separator('\t'),heading(12), terminator(['\n', '\r\n']), quote('')));
							output(AllSheets,,HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
									HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + pversion + '::' + 'ALLSHEETS', Compressed, OVERWRITE, THOR);
				return ('All ok');
			END; // Function
		EXPORT Built :=  DoTheBuild (pversion, pUseProd);
									
END;