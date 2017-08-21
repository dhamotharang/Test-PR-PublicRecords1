/*
	Vendor Source:
	
		Overview: Collection of "source codes" and their associated vendor information used for a lookup service.

							Base file currently contains vendor information for:
								*	Professional license vendors
								*	Bankruptcy court information
								*	Liens court information
								*	Person header vendor source information
								* Riskview and FFD report from Orbit
								* Base superfile name is 'thor_data400::base::vendor_src_info' (logical file is 'thor_data400::base::vendor_src_info_<version>')
							
							One index is being created - by source code 
								* Key superfile name is 'thor_data400::key::vendor_src_info::vendor_source_qa' 
										(logical file is 'thor_data400::key::vendor_src_info::<version>::vendor_source')

							Notes on input files:
								* Raw input files are expected to be comma delimited and without any headers 
								* Filenaming convention:
															Court*BK*.csv, Court*SLJ*.csv, Riskview*.csv, OldVendorSrc*.csv
										(there are files with other names in the /hds_180/vendor_source/20130813, /hds_180/vendor_source/20131001, and /hds_180/vendor_source/21031003
											directories - these are from the first runs of the base file, didn't have the same 'in' file layout - files left in directorires for now, just for 
											historical purposes - files with this naming convention WILL NOT be called by the automated	spray function).
------->>>>		Note about orbit report:
								*	RBecker Reports > Riskview Report
								*	export - csv
									* The build is set to work with these columns, which is the current layout as of 20140123
												* column A:	item_id2
												* column B:	item_name2
												* column C:	item_description2
												* column D:	status_name2
												* column E:	item_sourceCodes2
												* column F:	textbox330
												* column G:	source_name2
												* column H:	source_address3
												* column I:	source_address22
												* column J:	source_city2
												*	column K: source_state2
												* column L:	source_zip2
												* column M:	source_phone2
												* column N:	source_website2
												* column O:	source_sourceCodes2                   +++
												* column P:	fcra1																	+++
												* column Q:	fcra_comments1												+++
												* column R:	marketing_restrictions2
												* column S:	marketing_restrictions_comments2			+++
												* column T:	contact_cat_name											+++
												* column U:	contact_name													+++
												* column V:	contact_phone													+++
												* column W:	contact_email													+++
																	+++ these fields are ignored for processing the base file

							Steps to build/update the base file and key:
								* FTP raw input files to edata12:/hds_180/vendor_source
								*	Run "Misc.BWR_VendorSrc_BuildAll(<version or filedate>);"
*/