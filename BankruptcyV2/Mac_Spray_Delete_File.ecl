import bankruptcyv2, ut;

export Mac_spray_Delete_File(Deletesfile = '\'\'',filedate,group_name = '') := macro


#uniquename(spray_Deletes)

#uniquename(sourceIP)

//%sourceIP% := _control.IPAddress.edata12;
  %sourceIP% := _control.IPAddress.bctlpedata10;

						
#if (Deletesfile <> '')
%spray_Deletes% :=	sequential(
											fileservices.removesuperfile('~thor_data400::in::bankruptcy::deletes',
												'~thor_data400::in::bankruptcy::'+filedate+'::deletes'),
												if(fileservices.superfileexists('~thor_data400::in::bankruptcyv3::Deletes_full'),
													fileservices.removesuperfile('~thor_data400::in::bankruptcy::deletes_full',
												'~thor_data400::in::bankruptcy::'+filedate+'::deletes')),
											
											FileServices.SprayVariable(%sourceIP%,Deletesfile,,,,,group_name,
										'~thor_data400::in::bankruptcy::'+filedate+'::deletes',-1,,,true,true),
										fileservices.clearsuperfile('~thor_data400::in::bankruptcy::Deletes'),
										fileservices.addsuperfile('~thor_data400::in::bankruptcy::Deletes','~thor_data400::in::bankruptcy::'+filedate+'::Deletes'),
										if(~fileservices.superfileexists('~thor_data400::in::bankruptcyv3::Deletes_full'),
											fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::Deletes_full')),
																				fileservices.addsuperfile('~thor_data400::in::bankruptcy::Deletes_full','~thor_data400::in::bankruptcy::'+filedate+'::Deletes')	
										);
#else
	%spray_Deletes% := output('No Deletes');
#end

	if(fileservices.superfileexists('~thor_data400::in::bankruptcy::Deletes'),
				%spray_deletes%,
				sequential(fileservices.createsuperfile('~thor_data400::in::bankruptcy::Deletes'),
				%spray_Deletes%)
				);
endmacro;	

	