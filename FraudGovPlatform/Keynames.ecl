import tools;

export Keynames(


	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module
	export lTemplate(string tag)	:=	_Dataset(pUseOtherEnvironment).KeyTemplate + tag;
	export llogicalautoTmplt		  :=  _Dataset(pUseOtherEnvironment).autokeytemplate;

	export Main := module
		export AmountPaid								:= tools.mod_FilenamesBuild(lTemplate('AmountPaid'),pversion);
		export BankAccount							:= tools.mod_FilenamesBuild(lTemplate('BankAccount'),pversion);
		export BankName									:= tools.mod_FilenamesBuild(lTemplate('BankName'),pversion);		
		export BankRoutingNumber				:= tools.mod_FilenamesBuild(lTemplate('BankRoutingNumber'),pversion);
		export CityState								:= tools.mod_FilenamesBuild(lTemplate('CityState'),pversion);
		export CustomerID								:= tools.mod_FilenamesBuild(lTemplate('CustomerID'),pversion);
		export DeviceID									:= tools.mod_FilenamesBuild(lTemplate('DeviceID'),pversion);
		export DID											:= tools.mod_FilenamesBuild(lTemplate('DID'),pversion);
		export DriversLicense						:= tools.mod_FilenamesBuild(lTemplate('DriversLicense'),pversion);
		export Email										:= tools.mod_FilenamesBuild(lTemplate('Email'),pversion);
		export Host											:= tools.mod_FilenamesBuild(lTemplate('Host'),pversion);
		export HouseholdID							:= tools.mod_FilenamesBuild(lTemplate('HouseholdID'),pversion);
		export ID												:= tools.mod_FilenamesBuild(lTemplate('ID'),pversion);
		export IPRange									:= tools.mod_FilenamesBuild(lTemplate('IPRange'),pversion);
		export ISP											:= tools.mod_FilenamesBuild(lTemplate('ISP'),pversion);
		export MACAddress								:= tools.mod_FilenamesBuild(lTemplate('MACAddress'),pversion);
		export MbsFdnIndType						:= tools.mod_FilenamesBuild(lTemplate('MbsFdnIndType'),pversion);
		export MbsFDNMasterID						:= tools.mod_FilenamesBuild(lTemplate('Gcid_2_MbsFDNMasterID'),pversion);
		export MbsFDNMasterIDExcl				:= tools.mod_FilenamesBuild(lTemplate('MbsFDNMasterIDExclusion'),pversion);
		export MbsFDNMasterIDIndTypIncl	:= tools.mod_FilenamesBuild(lTemplate('MbsFdnMasterIDIndTypeInclusion'),pversion);
		export MbsIndTypeExclusion			:= tools.mod_FilenamesBuild(lTemplate('MbsIndTypeExclusion'),pversion);
		export MbsProductInclude				:= tools.mod_FilenamesBuild(lTemplate('MbsProductInclude'),pversion);
		export ReportedDate							:= tools.mod_FilenamesBuild(lTemplate('ReportedDate'),pversion);
		export SerialNumber							:= tools.mod_FilenamesBuild(lTemplate('SerialNumber'),pversion);
  	export User											:= tools.mod_FilenamesBuild(lTemplate('User'),pversion);
		export Zip											:= tools.mod_FilenamesBuild(lTemplate('Zip'),pversion);
		export EntityProfile						:= tools.mod_FilenamesBuild(lTemplate('kel::EntityProfile'),pversion);
		export ConfigAttributes					:= tools.mod_FilenamesBuild(lTemplate('kel::ConfigAttributes'),pversion);
		export ConfigRules							:= tools.mod_FilenamesBuild(lTemplate('kel::ConfigRules'),pversion);
		export DisposableEmailDomains		:= tools.mod_FilenamesBuild(lTemplate('kel::DisposableEmailDomains'),pversion);
		
		export dAll_filenames :=
				AmountPaid.dAll_filenames +
				BankAccount.dAll_filenames +
				BankName.dAll_filenames +
				BankRoutingNumber.dAll_filenames +
				CityState.dAll_filenames +
				CustomerID.dAll_filenames +
				DeviceID.dAll_filenames + 
				DID.dAll_filenames +
				DriversLicense.dAll_filenames +
				Email.dAll_filenames +
				Host.dAll_filenames + 
				HouseholdID.dAll_filenames +
				ID.dAll_filenames +
				IPRange.dAll_filenames +
				ISP.dAll_filenames +
				MACAddress.dAll_filenames + 
				MbsFdnIndType.dAll_filenames +
				MbsFDNMasterID.dAll_filenames +
				MbsFDNMasterIDExcl.dAll_filenames +
				MbsFDNMasterIDIndTypIncl.dAll_filenames +
				MbsIndTypeExclusion.dAll_filenames +
				MbsProductInclude.dAll_filenames +
				ReportedDate.dAll_filenames +
				SerialNumber.dAll_filenames +
				User.dAll_filenames + 
				Zip.dAll_filenames +
				EntityProfile.dAll_filenames +
				ConfigAttributes.dAll_filenames +
				ConfigRules.dAll_filenames +
				DisposableEmailDomains.dAll_filenames ;
		end;
			
	export autokeyroot	 		:= tools.mod_FilenamesBuild(llogicalautoTmplt																							,pversion	,llogicalautoTmplt																							);

  export Address				  := tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'Address'														  ,pversion	,llogicalautoTmplt				+ 'Address'													  );
	export CityStName       := tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'CityStName'													,pversion	,llogicalautoTmplt				+ 'CityStName'												);
	export name				      := tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'name'														    ,pversion	,llogicalautoTmplt				+ 'name'													    );
	export Phone2           := tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'Phone2'														  ,pversion	,llogicalautoTmplt				+ 'Phone2'													  );
	export ssn2             := tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'ssn2'														    ,pversion	,llogicalautoTmplt				+ 'ssn2'													    );
	export stname				    := tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'stname'														  ,pversion	,llogicalautoTmplt				+ 'stname'													  );
	export zip				      := tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'zip'														      ,pversion	,llogicalautoTmplt				+ 'zip'													      );
	export payload 					:= tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'payload'															,pversion	,llogicalautoTmplt				+ 'payload'														);
  export addressb2 				:= tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'addressb2'														,pversion	,llogicalautoTmplt				+ 'addressb2'													);
	export citystnameb2 		:= tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'citystnameb2'												,pversion	,llogicalautoTmplt				+ 'citystnameb2'											);
	export nameb2 					:= tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'nameb2'															,pversion	,llogicalautoTmplt				+ 'nameb2'														);
	export namewords2 			:= tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'namewords2'													,pversion	,llogicalautoTmplt				+ 'namewords2'												);
	export PhoneB2 					:= tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'PhoneB2'															,pversion	,llogicalautoTmplt				+ 'PhoneB2'														);
	export FEIN2 					  := tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'FEIN2'															  ,pversion	,llogicalautoTmplt				+ 'FEIN2'														  );
	export stnameb2 				:= tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'stnameb2'														,pversion	,llogicalautoTmplt				+ 'stnameb2'													);
	export zipb2 						:= tools.mod_FilenamesBuild(llogicalautoTmplt			+ 'zipb2'																,pversion	,llogicalautoTmplt				+ 'zipb2'															);
	
export dAll_filenames :=
		    Main.dAll_filenames 
			+ addressb2.dAll_filenames
			+ citystnameb2.dAll_filenames
			+ nameb2.dAll_filenames
			+ namewords2.dAll_filenames
			+ payload.dAll_filenames
			+ stnameb2.dAll_filenames
			+ zipb2.dAll_filenames 
			+ Address.dAll_filenames
			+ CityStName.dAll_filenames
			+ Name.dAll_filenames
			+ Phone2.dAll_filenames
			+ Ssn2.dAll_filenames
			+ Stname.dAll_filenames
			+ Zip.dAll_filenames
			+ PhoneB2.dAll_filenames
			+ FEIN2.dAll_filenames;
end;