import std,ut;

// You can pre-set your logs variables by using the following code, customizing it, and inserting it at the begining of your BWR: 
// #stored ('buildname', 'my_build_name'   ); 
// #stored ('version'  , 'my_build_version'); 
// #stored ('emailList', 'my_emailList'    ); 

string  build_name := workunit :stored('buildname');
string  version    := workunit :stored('version'  );
string  emailList  := ''       :stored('emailList');

EXPORT LogBuild := module
EXPORT multi( dataset(recordof({string check_point})) check_points, boolean skipEmail = false ) := FUNCTION
			layout_log := record
					string date_time;
					string build_name;
					string version;
					string check_point;
					string wuid;
			end;

			log_file 			:= '~thor_data400::log::'+build_name+'_b';
			new_log_entry := project(check_points, TRANSFORM(layout_log,
				
					self.date_time:= (STRING8)Std.Date.Today() + ' ' + Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
					self.build_name:=build_name;
					self.version:=version;
					self.check_point:=LEFT.check_point;
					self.wuid:=workunit
			));
			
			previous_log  := if(nothor(global(fileservices.fileexists(log_file),FEW)),dataset(log_file,layout_log,thor),dataset([],layout_log));
			last_check_point := check_points[count(check_points)].check_point;
			addNewLog := sequential(
															if(emailList <>'' AND NOT skipEmail, fileservices.sendEmail(emailList,
																			build_name+' v'+version+': '+last_check_point,'See: '+workunit+ ' / '+log_file)),
															output(choosen(previous_log + new_log_entry,1000,1)), // back up for log file
															output(previous_log + new_log_entry,,log_file+'_temp',cluster('thor400_44'),overwrite),
															// *** NB NB NB *** THIS CODE ASSUMES THE LOGICAL LOG FILE IS ** NOT ** IN A SUPERFILE !!!
															if(fileservices.fileexists(log_file),fileservices.deleteLogicalFile(log_file)), 
															fileservices.renameLogicalFile(log_file+'_temp',log_file)
														 );
			return addNewLog;

END;
EXPORT single( string check_point, boolean skipEmail = false ) := FUNCTION
	RETURN multi(dataset([{check_point}],{string check_point}), skipEmail);
END;
END;