IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared, ut,_Validate;
EXPORT Build_Input_DisposableEmailDomains(
	 string pversion
	,dataset(Layouts.Input.DisposableEmailDomains) DisposableEmailDomains_Sprayed =  files().Input.DisposableEmailDomains.sprayed
	,dataset(Layouts.Input.DisposableEmailDomains) ByPassed_DisposableEmailDomains_Sprayed = files().Input.ByPassed_DisposableEmailDomains.sprayed	
) :=
module

	inDisposableEmailDomainsUpdate :=	  if( nothor(STD.File.GetSuperFileSubCount(Filenames().Sprayed.DisposableEmailDomains)) > 0, 
		Files(pversion).Sprayed.DisposableEmailDomains, 
		dataset([],{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.DisposableEmailDomains})
		) ;

	Functions.CleanFields(inDisposableEmailDomainsUpdate ,inDisposableEmailDomainsUpdateUpper); 

	Layouts.Input.DisposableEmailDomains tr(inDisposableEmailDomainsUpdateUpper l, integer cnt) := transform

		filename := ut.CleanSpacesAndUpper(l.fn);
		
		self.FileName := filename;		

		FileDate := StringLib.StringFindReplace(filename, '.dat','')[34..41];
		self.domain:= ut.CleanSpacesAndUpper((STRING200)l.domain);
		self.dispsblemail:= ut.CleanSpacesAndUpper((STRING1)l.dispsblemail);
		self.Process_Date := (unsigned)pversion;
		self.FileDate := (unsigned)FileDate;
		self.FileTime := '';
		self:=l;
		self:=[];
	end;

	shared f1:= project(inDisposableEmailDomainsUpdateUpper,tr(left, counter));

	max_uid := max(DisposableEmailDomains_Sprayed, DisposableEmailDomains_Sprayed.source_rec_id) + 1;

	MAC_Sequence_Records( f1, source_rec_id, f1_source_rec_id, max_uid);

	shared d_source_rec_id := distribute(f1_source_rec_id);
	
	shared f1_errors:=d_source_rec_id
		(
			domain = '' or dispsblemail = ''
		);

		shared fn_dedup(inputs):=FUNCTIONMACRO
			in_dst := inputs;
			in_srt := sort(in_dst, domain,filename);
			{inputs} RollupUpdate({inputs} l, {inputs} r) := 
			transform
					SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous Unique_Id 
					self := l;
			end;

			in_ddp := rollup( in_srt
					,RollupUpdate(left, right)
					,domain,filename
					,local
			);
			return in_ddp;
	ENDMACRO;	
	//Exclude Errors
	shared f1_bypass_dedup:= fn_dedup(ByPassed_DisposableEmailDomains_Sprayed + PROJECT(f1_errors,FraudGovPlatform.Layouts.Input.DisposableEmailDomains));
	
	tools.mac_WriteFile(
		Filenames().Input.ByPassed_DisposableEmailDomains.New(pversion),
		f1_bypass_dedup,
		Build_Bypass_DisposableEmailDomains,
		pCompress := true,
		pHeading := false,
		pOverwrite := true);

	//Move only Valid Records
	shared Valid_Recs :=	join (	
		d_source_rec_id,
		f1_bypass_dedup,
		LEFT.source_rec_id = RIGHT.source_rec_id,
		TRANSFORM(Layouts.Input.DisposableEmailDomains,SELF := LEFT),
		LEFT ONLY,
		LOOKUP);	
	
	input_file_1 := fn_dedup(DisposableEmailDomains_Sprayed  + project(Valid_Recs,Layouts.Input.DisposableEmailDomains)); 


	tools.mac_WriteFile(
		Filenames(pversion).Input.DisposableEmailDomains.New(pversion),
		input_file_1,
		Build_DisposableEmailDomains,
		pCompress := true,
		pHeading := false,
		pOverwrite := true);

// Return
	export build_prepped := 
		sequential(
			 Build_DisposableEmailDomains
			,Build_Bypass_DisposableEmailDomains 
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_DisposableEmailDomains atribute')
	);

end;


