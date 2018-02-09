import _control;
//export foreign_prod := '~foreign::' + _control.IPAddress.prod_thor_dali + '::';       // Use to reference files 
                                                                                         //while testing using a BWR scripts (on THOR)
																																												                                             // that is your code is compiled at run time
																																									                                               //AND for deployments on the 1 ways.  */  

export foreign_prod := '~';     //  point to ~ for your files during your compile/deployments to Dev 194.   
                                //  Now your compiled query had the foreign_prod setting of '~' 


//*** ~ look for your data on the same cluster you are running on.   
//***   when you run on DEV194 you will find a local copy of the keys
//***   when you run on DEV one ways OR on THOR/DATALAND you will NOT find a local copy if the keys you will want to point to '~foreign::'.