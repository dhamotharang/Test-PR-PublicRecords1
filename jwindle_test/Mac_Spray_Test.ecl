import doxie,lssi;


export Mac_Spray_Test(sourceIP,sourcefile,destfile, filedate, group_name='\'thor_200\'',email_target='\' \'') := macro
#option('KEEP_THOR_SPILLS', 1);
#workunit('name', 'jw hates this thing today');
#stored('did_add_force','thor');

#uniquename(max_rec_size)	
%max_rec_size%:=800;

#uniquename(spray_it)
%spray_it% := FileServices.SprayVariable(sourceIP,sourcefile,%max_rec_size%,,,,group_name,destfile,-1,,,true,true);	


#uniquename(get_priority1)
%get_priority1% := output('spraying...') : success(%spray_it%);



sequential(%get_priority1%,
			output('Done...')
			);

endmacro;