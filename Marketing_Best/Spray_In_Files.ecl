IMPORT _Control;

SHARED spray_fixed(STRING8 filedate, STRING2 state) := FUNCTION

		superfile							:=  '~thor_data400::in::marketing_best_equifax';
		sourceFileName   			:=	'/data_build_5_2/epsilon/'+filedate+'/M0000948_'+state+'.txt';	
		destFileName   				:=	'~thor_data400::in::marketing_best_equifax_'+state+'_'+filedate;	
		SHARED RecordSize			:=	503;
		SHARED sourceIP		 		:=	_Control.IPAddress.edata10;
		SHARED group_name			:=	'thor40_241';

		spray_file						:= FileServices.SprayFixed(sourceIP,
																						         sourceFileName, 
																						         RecordSize,
																										 group_name, 
																										 destFileName,
																										 -1,
																										 ,
																										 ,
																										 TRUE,
																										 FALSE);
																				
		//Create a superfile in specified directory if it does not already exists. Clear it if it already exists.
		create_super :=	IF(NOT FileServices.SuperFileExists(superfile), FileServices.CreateSuperFile(superfile));
				
		add_to_super := SEQUENTIAL(				 
												FileServices.StartSuperFileTransaction();
												FileServices.AddSuperFile(superfile, destFileName);
												FileServices.FinishSuperFileTransaction();
												);
		RETURN SEQUENTIAL(spray_file, create_super, add_to_super);

END;

EXPORT Spray_In_Files(STRING8 filedate) := FUNCTION

	// where incoming sources are sprayed
	superfile			:= '~thor_data400::in::marketing_best_equifax';

	//clear the super file - thor_data400::in::marketing_best_equifax
	clear_super := SEQUENTIAL(				 
										FileServices.StartSuperFileTransaction();
										FileServices.ClearSuperFile(superfile);
										FileServices.FinishSuperFileTransaction();
										);

	spray_all		:= PARALLEL(
	               spray_fixed(filedate,'AK');
								 spray_fixed(filedate,'AL');
								 spray_fixed(filedate,'AR');
								 spray_fixed(filedate,'AZ');
 								 spray_fixed(filedate,'CA');
   							 spray_fixed(filedate,'CO');
   							 spray_fixed(filedate,'CT');
   							 spray_fixed(filedate,'DC');
   							 spray_fixed(filedate,'DE');
   							 spray_fixed(filedate,'FL');
   							 spray_fixed(filedate,'GA');
   							 spray_fixed(filedate,'HI');
   							 spray_fixed(filedate,'IA');
   							 spray_fixed(filedate,'ID');
   							 spray_fixed(filedate,'IL');
   							 spray_fixed(filedate,'IN');
   							 spray_fixed(filedate,'KS');
   							 spray_fixed(filedate,'KY');
   							 spray_fixed(filedate,'LA');
   							 spray_fixed(filedate,'MA');
   							 spray_fixed(filedate,'MD');
   							 spray_fixed(filedate,'ME');
   							 spray_fixed(filedate,'MI');
   							 spray_fixed(filedate,'MN');
   							 spray_fixed(filedate,'MO');
   							 spray_fixed(filedate,'MS');
   							 spray_fixed(filedate,'MT');
   							 spray_fixed(filedate,'NC');
   							 spray_fixed(filedate,'ND');
   							 spray_fixed(filedate,'NE');
   							 spray_fixed(filedate,'NH');
   							 spray_fixed(filedate,'NJ');
   							 spray_fixed(filedate,'NM');
   							 spray_fixed(filedate,'NV');
   							 spray_fixed(filedate,'NY');
   							 spray_fixed(filedate,'OH');
   							 spray_fixed(filedate,'OK');
   							 spray_fixed(filedate,'OR');
   							 spray_fixed(filedate,'PA');
   							 spray_fixed(filedate,'RI');
   							 spray_fixed(filedate,'SC');
   							 spray_fixed(filedate,'SD');
   							 spray_fixed(filedate,'TN');
   							 spray_fixed(filedate,'TX');
   							 spray_fixed(filedate,'UT');
   							 spray_fixed(filedate,'VA');
   							 spray_fixed(filedate,'VT');
   							 spray_fixed(filedate,'WA');
   							 spray_fixed(filedate,'WI');
   							 spray_fixed(filedate,'WV');
   						   spray_fixed(filedate,'WY');

								 );
	
	RETURN SEQUENTIAL(clear_super, spray_all);
	
END;