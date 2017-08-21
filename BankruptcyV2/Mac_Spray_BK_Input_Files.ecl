import bankruptcyv2, ut;

export Mac_spray_BK_input_files(Casefile,Defendantsfile,filedate,group_name = '') := macro

#uniquename(spray_Case)
#uniquename(spray_Defendants)
#uniquename(super_Case)
#uniquename(super_Defendants)
#uniquename(super_Case_full)
#uniquename(super_Defendants_full)
#uniquename(sourceIP)

%sourceIP% := _control.IPAddress.bctlpedata10;

%spray_Case% := FileServices.SprayVariable(%sourceIP%,Casefile,,,,,group_name,
						'~thor_data400::in::bankruptcyv3::'+filedate+'::Case::sprayed',-1,,,true,true);
%spray_Defendants% := FileServices.SprayVariable(%sourceIP%,Defendantsfile,,,,,group_name,
						'~thor_data400::in::bankruptcyv3::'+filedate+'::Defendants::sprayed',-1,,,true,true);

//////////////////////// Add filename to each record
//Case
#uniquename(casevirtuallayout)
#uniquename(caseds)
#uniquename(proj_case_recs)
#uniquename(proj_case_out)

%casevirtuallayout% := record
	BankruptcyV2.layout_in_case - filename;
end;

%caseds% := dataset('~thor_data400::in::bankruptcyv3::'+filedate+'::Case::sprayed',%casevirtuallayout%,csv(quote('\"')));

BankruptcyV2.Layout_In_Case %proj_case_recs%(%caseds% l) := transform
	self.filename := 'thor_data400::in::bankruptcyv3::'+filedate+'::Case';
	self := l;
end;						

%proj_case_out% := output(project(%caseds%,%proj_case_recs%(left)),,'~thor_data400::in::bankruptcyv3::'+filedate+'::Case',csv(quote('\"')),overwrite);


//Defendant
#uniquename(defvirtuallayout)
#uniquename(defds)
#uniquename(proj_def_recs)
#uniquename(proj_def_out)

%defvirtuallayout% := record
	BankruptcyV2.layout_in_defendants - filename;
end;

%defds% := dataset('~thor_data400::in::bankruptcyv3::'+filedate+'::defendants::sprayed',%defvirtuallayout%,csv(quote('\"')));

BankruptcyV2.Layout_In_defendants %proj_def_recs%(%defds% l) := transform
	self.filename := 'thor_data400::in::bankruptcyv3::'+filedate+'::defendants';
	self := l;
end;						

%proj_def_out% := output(project(%defds%,%proj_def_recs%(left)),,'~thor_data400::in::bankruptcyv3::'+filedate+'::defendants',csv(quote('\"')),overwrite);

//////////////////////// Add filename to each record - End //////////////////////

//FileServices.SprayFixed(%sourceIP%,Casefile, %recordlengthCase%,group_name,'~thor_data400::in::bankruptcyv3::'+filedate+'::Case' ,-1,,,true,true);
// %spray_Defendants% := FileServices.SprayFixed(%sourceIP%,Defendantsfile,%recordlengthDefendants%,group_name,'~thor_data400::in::bankruptcyv3::'+filedate+'::Defendants' ,-1,,,true,true);

%super_Case% := sequential(FileServices.StartSuperFileTransaction(),
                            fileservices.clearsuperfile('~thor_data400::in::bankruptcyv3::Case'),
							fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::Case','~thor_data400::in::bankruptcyv3::'+filedate+'::Case'),
							FileServices.FinishSuperFileTransaction());

%super_Defendants% := sequential(FileServices.StartSuperFileTransaction(),
                            fileservices.clearsuperfile('~thor_data400::in::bankruptcyv3::Defendants'),
							fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::Defendants','~thor_data400::in::bankruptcyv3::'+filedate+'::Defendants'),
							FileServices.FinishSuperFileTransaction());

// created to rerun full file incase. 

%super_Case_full%   := if(fileservices.superfileexists('~thor_data400::in::bankruptcyv3::Case_full'),
							fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::Case_full','~thor_data400::in::bankruptcyv3::'+filedate+'::Case'),
							sequential(fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::Case_full'),
									fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::Case_full','~thor_data400::in::bankruptcyv3::'+filedate+'::Case')));
%super_Defendants_full% :=	if(fileservices.superfileexists('~thor_data400::in::bankruptcyv3::Defendants_full'),
							fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::Defendants_full','~thor_data400::in::bankruptcyv3::'+filedate+'::Defendants'),
							sequential(fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::Defendants_full'),
									fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::Defendants_full','~thor_data400::in::bankruptcyv3::'+filedate+'::Defendants')));

sequential(
				parallel(
//	Case
					if(fileservices.superfileexists('~thor_data400::in::bankruptcyv3::Case'),
						sequential(
						fileservices.removesuperfile('~thor_data400::in::bankruptcyv3::Case',
						'~thor_data400::in::bankruptcyv3::'+filedate+'::Case'),
						fileservices.removesuperfile('~thor_data400::in::bankruptcyv3::Case_full',
						'~thor_data400::in::bankruptcyv3::'+filedate+'::Case'),
						%spray_Case%,
						%proj_case_out%
						),
						sequential(fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::Case'),
						if (not fileservices.superfileexists('~thor_data400::in::bankruptcyv3::Case_full'),
							fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::Case_full')),
						%spray_Case%,
						%proj_case_out%)
					),
//	Defendant
					if(fileservices.superfileexists('~thor_data400::in::bankruptcyv3::Defendants'),
						sequential(fileservices.removesuperfile('~thor_data400::in::bankruptcyv3::Defendants',
						'~thor_data400::in::bankruptcyv3::'+filedate+'::Defendants'),
						fileservices.removesuperfile('~thor_data400::in::bankruptcyv3::Defendants_full',
						'~thor_data400::in::bankruptcyv3::'+filedate+'::Defendants'),
						%spray_Defendants%,
						%proj_def_out%),
						sequential(fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::Defendants'),
						if (not fileservices.superfileexists('~thor_data400::in::bankruptcyv3::Defendants_full'),
							fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::Defendants_full')),
						%spray_Defendants%,
						%proj_def_out%)
					)
				),
				parallel(
					%super_Case%,%super_Defendants%,
					%super_Case_full%,%super_Defendants_full%
				),
				parallel(
					bankruptcyv2.daily_count_stats_for_banko('fcra',true),
					bankruptcyv2.daily_count_stats_for_banko('nonfcra',true)
				),
				notify('Yogurt:BANKRUPTCY SPRAY COMPLETE','*'),
				fileservices.deletelogicalfile('~thor_data400::in::bankruptcyv3::'+filedate+'::Case::sprayed'),
				fileservices.deletelogicalfile('~thor_data400::in::bankruptcyv3::'+filedate+'::Defendants::sprayed'),
				BankruptcyV2.Proc_BK_Preprocess(filedate),
				BankruptcyV2.proc_build_base(filedate),
				BankruptcyV3.proc_build_withdrawnstatus(filedate).All	// Create WithdrawnStatus File
				);
				// Deleting the ::sprayed file and consolidating full super in
				// Proc_Misc_Tasks
endmacro;	

	