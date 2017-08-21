import SANCTN_Mari,_Control, lib_stringlib;

export proc_midex_Sprayxml(string fileName, string fileDate) := Function

		inpath		:= '/thor_back5/sanctn/non_public/data/';
		outpath		:= 'in::SANCTN::NP::';
		maxRecordSize	:=	8000;
		superfile	:= SANCTN_Mari.cluster_name +'in::SANCTN::NP::' + filename;
		// groupname	:=	'thor5_241_10a';
		groupname := 'thor400_30';
//		cluster_name := '~thor_data400::';
		
		srcFileName := inpath + filedate + '/'+ fileName + '.xml';
		spFileName := SANCTN_Mari.cluster_name + outpath + filedate + '::'+ fileName;

		clear_super	:=
					IF(FileServices.SuperFileExists(superfile), 
					FileServices.ClearSuperFile(superfile),
					FileServices.CreateSuperFile(superfile));
					
		SprayFileXml := FUNCTION
			RETURN 	FileServices.SprayXml(
												_Control.IPAddress.edata12
												,srcFileName
												,maxRecordSize
												,'RECORD'
												,
												,groupname
												,spFileName
												,-1
												,
												,
												,true
												,true
												,false
												);
		END;

		spray_xml	:=	SEQUENTIAL(SprayFileXml);
		super_xml	:=	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),			
		FileServices.AddSuperFile(superfile, spFileName),
		FileServices.FinishSuperFileTransaction()
	);
	
		return SEQUENTIAL(clear_super, spray_xml, super_xml);
		// return spray_xml;

End;