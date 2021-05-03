import	_control,Address,AID,ut,std;

export	Spray_Prep_Fedex(string	pVersion)	:= function
	string					vCorrectionsCSVSeparator				:=	',';
	string					vCorrectionsCSVQuote						:=	'"';
	string					vCorrectionsCSVTerminator				:=	'\n';
	set	of	string	sCorrectionsCSVTerminator				:=	['\r\n','\n'];
	string					vMainTempLogicalFileName				:=	FedEx.constants.cluster	+	'temp::fedex::nohit::'	+	pVersion;
	string					vMainLogicalFileName						:=	FedEx.constants.cluster	+	'in::fedex::nohit::'		+	pVersion;
	string					vMainSuperFileName							:=	'~thor_200::in::fedex::nohit';
	string					vCorrectionsTempLogicalFileName	:=	FedEx.constants.cluster	+	'temp::fedex::nohit::corrections::'	+	pVersion;
	string					vCorrectionsLogicalFileName			:=	FedEx.constants.cluster	+	'in::fedex::nohit::corrections::'		+	pVersion;
	string					vCorrectionsSuperFileName				:=	'~thor_200::in::fedex::nohit::corrections';
	
//Spray append and correction files
sprayMainFile					:=	fileservices.sprayxml(	_control.IPAddress.bctlpedata10,
																										'/data/hds_4/FedEx/in/addresses.xml',
																										8192,
																									//'record',,_control.TargetGroup.Thor400_20,
																										'record',,'thor400_44',
																										vMainTempLogicalFileName,
																										,,,true,true,true
																									);
	
	
	
	
	// Fedex new batch update file
	dFedExMainIn				:=	dataset(	vMainTempLogicalFileName,
																		FedEx.Layout_FedEx.Main,
																		xml('addressupdate/records/record')
																	);
	
	// Calculate the max value for the record id
	integer	vMaxFedExRecordID	:=	max(FedEx.file_fedex_base,(integer)record_id[4..])	:	global;
	
	// Combine the corrections and append records
	dFedExCombinedIn	:=	dFedExMainIn;
	
	// Prep the sprayed file - add file date, cleaned name and record id	
	FedEx.Layout_FedEx.Prepped	tFedExPrep(FedEx.Layout_FedEx.Main	pInput,integer	cnt)	:=
	transform
				
		self.record_type						:=	ut.CleanSpacesAndUpper(pInput.record_type);
		
		self.file_date							:=	if(	self.record_type	!=	'',
																				pInput.file_date,
																				pVersion
																			);
		self.record_id							:=	if(	self.record_type in ['U','D'],
																				pInput.record_id,
																				'FDX'	+	intformat(vMaxFedExRecordID	+	cnt,12,1)
																			);
		
		self.name.first_name				:=	pInput.first_name;
		self.name.middle_initial		:=	pInput.middle_initial;
		self.name.last_name					:=	pInput.last_name;
		self.name.full_name					:=	pInput.full_name;
		self.name.company_name			:=	pInput.company_name;
		self.address.address_line1	:=	pInput.address_line1;
		self.address.address_line2	:=	pInput.address_line2;
		self.address.city						:=	pInput.city;
		self.address.state					:=	pInput.state;
		self.address.zip						:=	pInput.zip;
		self.address.country				:=	pInput.country;
		self.phone.phone						:=	pInput.phone;
		self.Append_CleanName				:=	'';
		self.Append_PrepAddr1				:=	'';
		self.Append_PrepAddr2				:=	'';
		self.Append_RawAID					:=	0;
	end;
	
	dFedExPrepped	:=	project(dFedExCombinedIn,tFedExPrep(left,counter));

	// Split out the corrections and the append records from the combined file

	dFedExMain				:=	dFedExPrepped(record_type	=		'');
	//dFedExCorrections	:=	dFedExPrepped(record_type	!=	'');
	
	// Output main and corrections prepped files
	outPreppedFedExMain					:=	output(	dFedExMain,,
																					vMainLogicalFileName,
																					xml(heading('<addressupdate>\n<records>\n','</records>\n</addressupdate>\n'),'record'),
																					overwrite,
																					__compressed__
																				);
	

	// Superfile transactions
	addsupermain:=STD.File.PromoteSuperFileList(['~thor_200::in::fedex::nohit','~thor_200::in::fedex::nohit_father','~thor_200::in::fedex::nohit_grandfather'],vMainLogicalFileName,true);
	checkzerobytefile := if(	EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata10,'/data/hds_4/FedEx/in/','corrections.csv')),
	   output('corrections files not deleted because it has data'),
		 sequential(
		 fileservices.startsuperfiletransaction(),
		 fileservices.removesuperfile(vCorrectionsSuperFileName,vCorrectionsLogicalFileName),
		 fileservices.finishsuperfiletransaction(),
	   fileservices.deletelogicalfile(vCorrectionsLogicalFileName)));
		 
	
	return	sequential(sprayMainFile,outPreppedFedExMain,addsupermain,checkzerobytefile);	
		
end;