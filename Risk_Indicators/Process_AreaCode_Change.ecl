Import Risk_Indicators, Data_Services, STD, ut;

EXPORT Process_AreaCode_Change(string filedate) := FUNCTION

File_AreaCode_base := Risk_Indicators.File_AreaCode_Change(old_npa <> '');
file_AreaCode_split	:= Risk_Indicators.File_AreaCode_split_in;

//Join to get old and new NPA records information
srtAreaCodeOld := sort(file_AreaCode_split(DisconnectDate <> ''),NXX,AreaExchngName);
srtAreaCodeNew := sort(file_AreaCode_split(DisconnectDate = ''),NXX,AreaExchngName);

Risk_Indicators.Layout_AreaCode_Change ApndNewAreaCode(Risk_Indicators.Layout_AreaCode_split_in L, Risk_Indicators.Layout_AreaCode_split_in R) := TRANSFORM
	self.old_NPA							:= L.NPA;
	self.old_NXX							:= L.NXX;
	self.old_date_extablished	:= L.Date_established;
	self.permissive_end				:= L.DisconnectDate;
	self.old_name							:= L.AreaExchngName;
	self.old_lf								:= L.lf;
	self.new_NPA							:= R.NPA;
	self.new_NXX							:= R.NXX;
	self.permissive_start			:= R.Date_established;
	self.new_disconnect_date	:= R.DisconnectDate;
	self.new_name							:= R.AreaExchngName;
	self.new_lf								:= R.lf;
END;

jAreaCode	:= sort(join(srtAreaCodeOld,srtAreaCodeNew,
									trim(left.NXX,left,right) = trim(right.NXX,left,right) AND
									trim(left.AreaExchngName,left,right) = trim(right.AreaExchngName,left,right),
									ApndNewAreaCode(left,right)),old_NPA,old_NXX,old_name,-old_date_extablished,-permissive_end);
									
//Rollup to update with any changes
srtPrevBase := sort(File_AreaCode_base,old_NPA,old_NXX,old_name,-old_date_extablished,-permissive_end);
AppendNew := jAreaCode + srtPrevBase;
dedNewBase := dedup(AppendNew,all, EXCEPT old_lf,new_lf);

Risk_Indicators.Layout_AreaCode_Change RollitUp(Risk_Indicators.Layout_AreaCode_Change L, Risk_Indicators.Layout_AreaCode_Change R) := TRANSFORM
	self := L;
END;

rAreaCode_change := ROLLUP(dedNewBase, RollitUp(LEFT,RIGHT),
															left.old_npa = right.old_npa AND
															left.old_nxx = right.old_nxx AND
															left.old_name = right.old_name);
															
AreaCode_change_out := output(rAreaCode_change,,'~thor_data400::in::'+ filedate +'::areacode_change',overwrite);

sfShuffle := sequential(
												fileservices.startsuperfiletransaction(),
												fileservices.clearsuperfile('~thor_data400::base::areacode_change_grandfather'),
												fileservices.SwapSuperFile('~thor_data400::base::areacode_change_father','~thor_data400::base::areacode_change_grandfather'),
												fileservices.SwapSuperFile('~thor_data400::base::areacode_change','~thor_data400::base::areacode_change_father'),
												fileservices.addsuperfile('~thor_data400::base::areacode_change','~thor_data400::in::'+ filedate +'::areacode_change'),
												fileservices.finishsuperfiletransaction()
												);
												
RETURN sequential(AreaCode_change_out, sfShuffle);

END;