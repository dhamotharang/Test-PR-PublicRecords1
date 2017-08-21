import _control;

export spray_AreaCode_Change (string filedate) := function

sprayupdate     := FileServices.SprayFixed(_Control.IPAddress.edata12, '/thor_back5/local_data/areacode_change/areacode_change.d00' ,58, 'thor400_92', 
							  '~thor_data400::in::'+ filedate +'::areacode_change' , , , ,true,true,false);
							  
sfShuffle := sequential(
	fileservices.startsuperfiletransaction(),
	fileservices.clearsuperfile('~thor_data400::base::areacode_change_grandfather'),
	fileservices.SwapSuperFile('~thor_data400::base::areacode_change_father','~thor_data400::base::areacode_change_grandfather'),
	fileservices.SwapSuperFile('~thor_data400::base::areacode_change','~thor_data400::base::areacode_change_father'),
	fileservices.addsuperfile('~thor_data400::base::areacode_change','~thor_data400::in::'+ filedate +'::areacode_change'),
    fileservices.finishsuperfiletransaction()
	);
return							  
sequential(sprayupdate,sfshuffle);
						
end;
