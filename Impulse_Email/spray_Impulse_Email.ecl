IMPORT lib_fileservices,_control, Impulse_Email;

// spray_cluster	:=	'thor400_88';
// spray_cluster	:=	'thor200_144';

EXPORT spray_Impulse_Email(string file_date_in, string version_date_in, string spray_cluster) := FUNCTION
	
	sprayImpulseEmail :=
		IF(fileservices.fileexists(Impulse_Email.cluster + 'in::impulse_email::'+ file_date_in +'::temp'),
			OUTPUT('Impulse Email file sprayed in previous run'),
			FileServices.SprayVariable(_control.IPAddress.edata12, '/hds_2/impulse_email/data/'+ file_date_in +'/ImpulseEmail.csv',8192, '\\,', '\n'
			, ,spray_cluster, Impulse_Email.cluster + 'in::impulse_email::'+ file_date_in +'::temp', , , , TRUE))
		;
				
	Impulse_Email_in_temp	:=	dataset(Impulse_Email.cluster + 'in::impulse_email::'+ file_date_in +'::temp', layouts.layout_Impulse_Email, CSV(terminator('\n'),separator(','),quote(''), MAXLENGTH(8192)));
		
	layouts.layout_Impulse_Email_Dates_append	lTransformAddDtVendorFirstReported(layouts.layout_Impulse_Email pInput)
		:=
			TRANSFORM
				self.version_date								:=	version_date_in;
				self.file_date									:=	file_date_in;
				self.DateVendorFirstReported		:=	(unsigned4)self.file_date;
				self.DateVendorLastReported			:=	(unsigned4)self.file_date;
				self.RawAID											:=	0;
				self														:=	pInput;
			END
	;
	
	addProcDte	:=
		IF(fileservices.fileexists(Impulse_Email.cluster + 'in::impulse_email::'+ file_date_in +'::full'),
			OUTPUT('Impulse Email file transformed in previous run'),
			OUTPUT(PROJECT(Impulse_Email_in_temp, lTransformAddDtVendorFirstReported(left)), , Impulse_Email.cluster + 'in::impulse_email::' + file_date_in + '::full', CLUSTER(spray_cluster), COMPRESSED)
			)
	;
	
	delTemp	:=
		IF(fileservices.fileexists(Impulse_Email.cluster + 'in::impulse_email::'+ file_date_in +'::temp'),
			FileServices.DeleteLogicalFile(Impulse_Email.cluster + 'in::impulse_email::'+ file_date_in +'::temp'),
			OUTPUT('Impulse Email Temp file deleted in previous run')
			)
	;

	NewFile						:=	Impulse_Email.cluster + 'in::impulse_email::'+ file_date_in +'::full';
	inFile						:=	Impulse_Email.cluster + 'in::impulse_email::using::impulse_email';
	fatherInFile			:=	Impulse_Email.cluster + 'in::impulse_email::using::impulse_email_father';
	GrandfatherInFile	:=	Impulse_Email.cluster + 'in::impulse_email::using::impulse_email_grandfather';
	DeleteInFile			:=	Impulse_Email.cluster + 'in::impulse_email::using::impulse_email_delete';
		
	addToSuper := sequential(
									
							 FileServices.StartSuperFileTransaction(),
							 FileServices.AddSuperFile(DeleteInFile, GrandfatherInFile, , TRUE),
							 FileServices.ClearSuperFile(GrandfatherInFile),
							 FileServices.AddSuperFile(GrandfatherInFile, fatherInFile, , TRUE),
							 FileServices.ClearSuperFile(fatherInFile),
							 FileServices.AddSuperFile(fatherInFile, inFile, , TRUE),
							 FileServices.ClearSuperFile(inFile),
							 FileServices.AddSuperFile(inFile, NewFile),
							 FileServices.FinishSuperFileTransaction(),
							 IF(FileServices.GetSuperFileSubCount(DeleteInFile) > 0,
							     FileServices.ClearSuperFile(DeleteInFile, TRUE)
							   )
							 
							);
							  
	
	return sequential(sprayImpulseEmail
									, addProcDte
									, addToSuper
									, delTemp
									);
END;