import corp2, corp2_raw_hi, tools;

filedate								:= '20160811';
puseprod 								:= tools._constants.isdataland;

state_origin			 			:= 'HI';
state_fips	 				 		:= '15';
state_desc	 			 			:= 'HAWAII';

CompanyMaster 					:= sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.CompanyMaster.Logical,hash(filenumber,filesuffix)),filenumber,filesuffix,local) : independent;
CompanyOfficer 					:= sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.CompanyOfficer.Logical,hash(filenumber,filesuffix)),filenumber,filesuffix,local) : independent;
CompanyStock 						:= sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.CompanyStock.Logical,hash(filenumber,filesuffix)),filenumber,filesuffix,local) : independent;
CompanyTransaction 			:= sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.CompanyTransaction.Logical,hash(filenumber,filesuffix)),filenumber,filesuffix,local) : independent;
TTSMaster 							:= sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.TTSMaster.Logical,hash(filenumber,filesuffix)),filenumber,filesuffix,local) : independent;
TTSMaster_ZZ						:= TTSMaster(corp2.t2u(filesuffix)='ZZ'); 	//"ZZ" - represents Tradename, Trademark & Servicemark records
TTSMaster_NonZZ					:= TTSMaster(corp2.t2u(filesuffix)<>'ZZ');	//"ZZ" - represents Tradename, Trademark & Servicemark records
TTSTransaction 					:= sort(distribute(Corp2_Raw_HI.Files(fileDate,puseprod).Input.TTSTransaction.Logical,hash(filenumber,filesuffix)),filenumber,filesuffix,local) : independent;
TitleLookupTable				:= Corp2_Raw_HI.Files(fileDate,puseprod).Input.TitleLookupTable;

output(CompanyMaster,named('CompanyMaster'));
output(CompanyOfficer,named('CompanyOfficer'));
output(CompanyStock,named('CompanyStock'));
output(CompanyTransaction,named('CompanyTransaction'));
output(TTSMaster,named('TTSMaster'));
output(TTSMaster_ZZ,named('TTSMaster_ZZ'));
output(TTSMaster_NonZZ,named('TTSMaster_NonZZ'));
output(TTSTransaction,named('TTSTransaction'));
output(TitleLookupTable,named('TitleLookupTable'));