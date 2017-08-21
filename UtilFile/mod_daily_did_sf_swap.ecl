export mod_daily_did_sf_swap() :=
module

swap1 := sequential(fileservices.startsuperfiletransaction(),
                    fileservices.removesuperfile('~thor_data400::in::utility::daily_did','~thor_data400::in::utility::daily_did_subsuper'),
					fileservices.finishsuperfiletransaction()
				   );

swap2 := sequential(fileservices.startsuperfiletransaction(),
                    fileservices.swapsuperfile('~thor_data400::in::utility::daily_did','~thor_data400::in::utility::daily_did_subsuper'),
					fileservices.finishsuperfiletransaction()
				   );

swap3 := sequential(fileservices.startsuperfiletransaction(),
                    fileservices.addsuperfile('~thor_data400::in::utility::daily_did','~thor_data400::in::utility::daily_did_subsuper'),
                    fileservices.finishsuperfiletransaction()
				   );
				   

export swap_sfs := sequential(swap1,swap2,swap3);

export clear_sub_sf := fileservices.clearsuperfile('~thor_data400::in::utility::daily_did_subsuper');

end;