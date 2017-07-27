export mac_SF_Move(bname, move_type, seq_name, num_gens = '3', include_built = 'false', is_key = 'false', preview = 'false') := macro

/* move_type may be
		'R' for Rollback
			1) Contents of Base released.
			2) Contents of Father moved into Base.
			3) Contents of GFather moved into Father
		
		'P' for base -> prod
			1) old prod moved to _delete
			2) base copied into prod
			2) attempt to delete contents of _delete
		
	preview only shows what action would be taken
	
	
*/


#uniquename(released)
#uniquename(tobase)
#uniquename(tofather)
%released% := FileServices.GetSuperFileSubName(bname,1);
%tobase% := FileServices.GetSuperFileSubName(bname + '_father',1);
#if (num_gens = 3)
%tofather% := FileServices.GetSuperFileSubName(bname + '_Grandfather',1);
#end

//just force these variables to evaluate for correct reporting
//force_eval := output(asstring(13) + %released% + asstring(13) + %tobase%  + asstring(13) + %tofather%);

seq_name := sequential(
#if (move_type = 'R')
	#if(preview = false)
		//force_eval,
		FileServices.StartSuperFileTransaction(),
		  #if(is_key = false)	//keys do not really have a base
				FileServices.ClearSuperFile(bname),
				FileServices.AddSuperFile(bname, bname + '_father',,true),
			#end
			#if(include_built)
				FileServices.ClearSuperFile(bname + '_built'),
				FileServices.AddSuperFile(bname + '_built', bname + '_father',,true),
			#end
			FileServices.ClearSuperFile(bname + '_father'),
			#if(num_gens = 3)
				FileServices.AddSuperFile(bname + '_father', bname + '_Grandfather',, true),
				FileServices.ClearSuperFile(bname + '_Grandfather'),
			#end		
		FileServices.FinishSuperFileTransaction(),
	#end
#else 
	#if (move_type = 'P')
		#if (preview = false)
			FileServices.StartSuperFileTransaction(),
		
			fileservices.addsuperfile(bname + '_delete',bname + '_Prod',0,true),
			fileservices.clearsuperfile(bname + '_prod'),
			fileservices.addsuperfile(bname + '_prod',bname,0,true),
			
			FileServices.FinishSuperFileTransaction(),
			fileservices.RemoveOwnedSubFiles(bname + '_delete',true),
			fileservices.ClearSuperFile(bname + '_delete'),	
			//fileservices.clearsuperfile(bname + '_delete',true),
		#end
	#end
#end
		//reporting or previewing
		
		/* this does not work for some reason
		output(%released% + ' released from ' + bname),
		output(%tobase% + ' moved into ' + bname),
		#if(include_built)
			output(%tobase% + ' moved into ' + bname + '_built'),
		#end
		output(%tofather% + ' moved into ' + bname + '_father')
		*/
	output('reporting and preview under construction')
);
	
endmacro;