import SexOffender,doxie_build, ut, hygenics_soff;


 File_Offenses_2 :=
 dataset('~thor_data400::base::sex_offender_Offenses'+
    doxie_build.buildstate,Sexoffender.layout_Common_Offense_new, flat);
                                   

ds := File_offenses_2;

hygenics_soff.Layout_common_Offense slimTrans(ds l):= transform
	self := l;
end;

 File_Offenses := project(ds, slimTrans(left));

//output(File_Offenses);


export File_In_SexOffender_Offense := File_Offenses;