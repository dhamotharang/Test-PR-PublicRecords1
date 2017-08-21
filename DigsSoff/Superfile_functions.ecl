/*
**********************************************************************************
Created by    Comments
Vani 					This attribute has common functions used by spray attributes 
							
***********************************************************************************
*/	
export SuperFile_Functions := MODULE 

//check if the file exists in superfile
  EXPORT Fun_createsuperfile(STRING superfile) := IF(FileServices.SuperFileExists(superfile),output('SuperFile Exists: '+ superfile ),
                                                                 FileServices.CreateSuperFile(superfile)
											                              );
																		
//check if the file exists in superfile
  EXPORT Fun_Clearsuperfile(STRING superfile)  := IF(FileServices.GetSuperFileSubCount(superfile) <> 0, 
                                                      FileServices.ClearSuperFile(superfile), //FileServices.RemoveSuperFile(superfile,OPFileName), 
														                          output('Superfile is empty')
													                          );		
 
  EXPORT Fun_AddToSuperfile(String FileName, String SuperFile) := IF(fileservices.FileExists (FileName), 
	                                                                       fileservices.addsuperfile(superfile,FileName), 
                                                                         output('Could not add'+ FileName+' to '+ superfile)
											                                              );
// Delete Logical files with the same name
	EXPORT DoCleanup(String FileName,String SuperFileName) := IF( fileservices.FileExists (FileName), 
	                                                                   sequential( Fun_Clearsuperfile(SuperFileName) ,
																												                         FileServices.DeleteLogicalFile(FileName)
																												                       )																		 
                                                              );																																
 END;																															