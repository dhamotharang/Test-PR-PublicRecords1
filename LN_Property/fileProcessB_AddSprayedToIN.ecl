import lib_fileservices;

export fileProcessB_AddSprayedToIN(string pGroup,
                                   string pSource,
																	 string pDestination
													        ) := function

assessor := pGroup + pDestination;
sprayed  := pGroup + pSource;

// Add sprayed superfiles to IN superfiles
addToSuper  := fileservices.AddSuperFile(assessor, sprayed);

sequential(fileservices.startsuperfiletransaction(),
           addToSuper, 
					 fileservices.finishsuperfiletransaction()
					 );

return 'AddSprayToIN';
end;													
