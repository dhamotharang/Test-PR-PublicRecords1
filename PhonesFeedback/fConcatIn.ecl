import lib_fileservices,ut;

EXPORT fConcatIn(string filedate,string ftype) := function

infileraw := '~thor_data400::in::phonesFeedback_fcra::sprayed::'+ftype;
infinalname := '~thor_data400::in::phonesfeedback_fcra::'+filedate+'::'+ftype;

newrec := record
PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in;
string128 logicalfilename{virtual (logicalfilename)};
end;

dnewfile := dataset(infileraw,newrec,thor);


dprevfile := if ( ftype = 'customer' ,PhonesFeedback.File_PhonesFeedback_in_fcra_customer, PhonesFeedback.File_PhonesFeedback_in_fcra_online) ;

 outappn := if ( FileServices.GetSuperfilesubcount(infileraw) <> 0, Sequential( output( project( dnewfile + dprevfile,transform( PhonesFeedback.Layouts_PhonesFeedback.Layout_virtual ,self := left)) ,,infinalname+'::appn',overwrite,compressed),
                                  FileServices.StartSuperFiletransaction(),
																	FileServices.ClearSuperFile(PhonesFeedback.Cluster+'in::phonesfeedback_fcra::'+ftype),
																	FileServices.AddSuperfile(PhonesFeedback.Cluster+'in::phonesfeedback_fcra::'+ftype,infinalname+'::appn'),
																	FileServices.FinishSuperFiletransaction()
																	
																	) ,Output( 'RawSuperfile for typename '+ftype+' is empty') ) ;
																	
																	
return outappn;


end;
