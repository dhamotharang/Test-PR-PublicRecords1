/*2017-12-04T15:19:34Z (ananth)
C:\Users\VenkatAN\AppData\Roaming\HPCC Systems\eclide\ananth\boca_dev\dops\SuppressRecords\2017-12-04T15_19_34Z.ecl
*/
import RoxieKeyBuild,Data_Services;
EXPORT SuppressRecords := module

	export GetRecordsFromFile(inlayout
															,datasetname = ''	
															,useLocal = 'true'
															,dRecords) := macro
		#uniquename(rSuppressLayout)
		%rSuppressLayout% := record
			inlayout;
			string filedate;
			string whenupdated;
			string flag;
		end;
		dRecords := dataset(dops.SuppressConstants(datasetname,useLocal).SuperName,%rSuppressLayout%,thor,opt);
		
	endmacro;
	
	export GetRecords(
											inlayout
											,datasetname = ''	
											,useLocal = 'true'
											,isFCRA = 'false'
											,isUnsuppress = 'false'
											,dGetRecords
											) := macro
		
		#uniquename(dGetrecordsfromfile)
		dops.SuppressRecords.GetRecordsFromFile(inlayout, datasetname, useLocal ,%dGetrecordsfromfile%);
		dGetRecords := if( ~isUnsuppress 
												,if (isFCRA
															,%dGetrecordsfromfile%(flag = 'A' and whenupdated < dops.SuppressConstants(datasetname,useLocal).thresholddate)
															,%dGetrecordsfromfile%(flag = 'A')
														)
												,%dGetrecordsfromfile%(flag = 'D')
											);
	endmacro;

	export Add(datasetname	
							,indataset
							,infiledate
							,useLocal = 'true'
							
							) := macro
		#uniquename(rSuppressLayout)					
		%rSuppressLayout% := record
			indataset;
			string filedate;
			string whenupdated;
			string flag;
		end;					
		#uniquename(dSuppressedRecords);
		dops.SuppressRecords.GetRecords(%rSuppressLayout% - [filedate, whenupdated, flag],datasetname,useLocal,,,%dSuppressedRecords%);
		
		#uniquename(xConvertToSuppressLayout)
		%rSuppressLayout% %xConvertToSuppressLayout%(indataset l) := transform
			self.filedate := infiledate;
			self.whenupdated := regexreplace('-', WORKUNIT,'')[2..];
			self.flag := 'A';
			self := l;
		end;
		
		#uniquename(dConvertToSuppressLayout)
		%dConvertToSuppressLayout% := project(indataset,%xConvertToSuppressLayout%(left));
		
		#uniquename(dAddSuppressIDs)
		%dAddSuppressIDs% := dedup(
															sort(
																group(sort(%dSuppressedRecords% + %dConvertToSuppressLayout%
																				,record,except filedate, whenupdated, flag)
																,record, except filedate, whenupdated, flag)
															,-filedate)
														,record, except filedate, whenupdated, flag);
															
		
		#uniquename(mCreateFile)
		RoxieKeyBuild.MAC_SF_BuildProcess_V2(%dAddSuppressIDs%
																					,dops.SuppressConstants(datasetname,useLocal).Files().Prefix
																					,dops.SuppressConstants(datasetname,useLocal).Files().Suffix
																					,infiledate
																					,%mCreateFile%
																					,,,true);
		
		if(dops.SuppressConstants(datasetname,useLocal).isValidDataset
									,%mCreateFile%
									,fail(datasetname + ' not found in dops.SuppressConstants(datasetname,useLocal).ValidDatasets')
								);
								
		
		
	endmacro;
	
	
	export Delete(datasetname
							,indataset
							,infiledate
							,useLocal = 'true') := macro
		
		#uniquename(rSuppressLayout)					
		%rSuppressLayout% := record
			indataset;
			string filedate;
			string whenupdated;
			string flag;
		end;					
		
		#uniquename(dSuppressedRecords)
		dops.SuppressRecords.GetRecords(%rSuppressLayout% - [filedate, whenupdated, flag],datasetname,useLocal,,,%dSuppressedRecords%);
				
		#uniquename(xFlagAsDeletes)
		%rSuppressLayout% %xFlagAsDeletes%(indataset l) := transform
			self.flag := 'D';
			self.whenupdated := regexreplace('-', WORKUNIT,'')[2..];
			self.filedate := infiledate;
			self := l;
		end;
		#uniquename(dFlagAsDeletes)
		%dFlagAsDeletes% := project(indataset,%xFlagAsDeletes%(left));
		
		#uniquename(dDeleteSuppressIDs)
		%dDeleteSuppressIDs% := dedup(
															sort(
																group(sort(%dFlagAsDeletes% + %dSuppressedRecords%
																				,record,except filedate, whenupdated, flag)
																,record, except filedate, whenupdated, flag)
															,-filedate)
														,record, except filedate, whenupdated, flag);
		
		#uniquename(mCreateFile)
		RoxieKeyBuild.MAC_SF_BuildProcess_V2(%dDeleteSuppressIDs%
																					,dops.SuppressConstants(datasetname,useLocal).Files().Prefix
																					,dops.SuppressConstants(datasetname,useLocal).Files().Suffix
																					,filedate
																					,%mCreateFile%
																					,,,true);
		
		if(dops.SuppressConstants(datasetname,useLocal).isValidDataset
									,%mCreateFile%
									,fail(datasetname + ' not found in dops.SuppressConstants(datasetname,useLocal).ValidDatasets')
								);
		
	endmacro;
	
	
	
end;