import Drivers, DriversV2, lib_stringlib, ut;

export Mapping_DL_MN_As_ConvPoints := module

  //***************** Conviction Mapping ****************************************************
  Layout_CP_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;

  Layout_CP_Common normMNToCommon(Drivers.File_MN_Raw l, integer c) := transform
    self.process_date       := l.process_date;
    self.dt_first_seen      := self.process_date;
    self.dt_last_seen       := self.process_date;
    self.src_state          := 'MN';
    self.DLCP_KEY           := trim(l.key_driver_license,left, right);
    self.VIOLATION_DATE     := ut.unDoJulian((integer)StringLib.stringFilter(                             
                               choose(c, trim(l.conviction_code_data_1[4..],left,right),
									     trim(l.conviction_code_data_2[4..],left,right),
									     trim(l.conviction_code_data_3[4..],left,right),
									     trim(l.conviction_code_data_4[4..],left,right),
									     trim(l.conviction_code_data_5[4..],left,right),
									     trim(l.conviction_code_data_6[4..],left,right),
									     trim(l.conviction_code_data_7[4..],left,right),
									     trim(l.conviction_code_data_8[4..],left,right),
									     trim(l.conviction_code_data_9[4..],left,right),
									     trim(l.conviction_code_data_10[4..],left,right),
									     trim(l.conviction_code_data_11[4..],left,right),
									     trim(l.conviction_code_data_12[4..],left,right),
									     trim(l.conviction_code_data_13[4..],left,right),
									     trim(l.conviction_code_data_14[4..],left,right),
									     trim(l.conviction_code_data_15[4..],left,right),
									     trim(l.conviction_code_data_16[4..],left,right),
									     trim(l.conviction_code_data_17[4..],left,right),
									     trim(l.conviction_code_data_18[4..],left,right),
									     trim(l.conviction_code_data_19[4..],left,right),
									     trim(l.conviction_code_data_20[4..],left,right),
									     trim(l.conviction_code_data_21[4..],left,right),
									     trim(l.conviction_code_data_22[4..],left,right),
									     trim(l.conviction_code_data_23[4..],left,right),
									     trim(l.conviction_code_data_24[4..],left,right),
									     trim(l.conviction_code_data_25[4..],left,right),
									     trim(l.conviction_code_data_26[4..],left,right),
									     trim(l.conviction_code_data_27[4..],left,right),
									     trim(l.conviction_code_data_28[4..],left,right),
									     trim(l.conviction_code_data_29[4..],left,right),
									     trim(l.conviction_code_data_30[4..],left,right),
									     trim(l.conviction_code_data_31[4..],left,right),
									     trim(l.conviction_code_data_32[4..],left,right),
									     trim(l.conviction_code_data_33[4..],left,right),
									     trim(l.conviction_code_data_34[4..],left,right),
									     trim(l.conviction_code_data_35[4..],left,right),
									     trim(l.conviction_code_data_36[4..],left,right),
									     trim(l.conviction_code_data_37[4..],left,right),
									     trim(l.conviction_code_data_38[4..],left,right),
									     trim(l.conviction_code_data_39[4..],left,right),
									     trim(l.conviction_code_data_40[4..],left,right),
									     trim(l.conviction_code_data_41[4..],left,right),
									     trim(l.conviction_code_data_42[4..],left,right),
									     trim(l.conviction_code_data_43[4..],left,right),
									     trim(l.conviction_code_data_44[4..],left,right),
									     trim(l.conviction_code_data_45[4..],left,right),
									     trim(l.conviction_code_data_46[4..],left,right),
									     trim(l.conviction_code_data_47[4..],left,right),
									     trim(l.conviction_code_data_48[4..],left,right),
									     trim(l.conviction_code_data_49[4..],left,right),
									     trim(l.conviction_code_data_50[4..],left,right)
                                     ), '0123456789'));
								   
    self.ST_OFFENSE_CONV_CD := StringLib.StringToUpperCase(
                               choose(c, trim(l.conviction_code_data_1[1..3],left,right),
                                         trim(l.conviction_code_data_2[1..3],left,right),
		                                 trim(l.conviction_code_data_3[1..3],left,right),
								         trim(l.conviction_code_data_4[1..3],left,right),
								         trim(l.conviction_code_data_5[1..3],left,right),
								         trim(l.conviction_code_data_6[1..3],left,right),
								         trim(l.conviction_code_data_7[1..3],left,right),
								         trim(l.conviction_code_data_8[1..3],left,right),
								         trim(l.conviction_code_data_9[1..3],left,right),
								         trim(l.conviction_code_data_10[1..3],left,right),
								         trim(l.conviction_code_data_11[1..3],left,right),
								         trim(l.conviction_code_data_12[1..3],left,right),
								         trim(l.conviction_code_data_13[1..3],left,right),
								         trim(l.conviction_code_data_14[1..3],left,right),
								         trim(l.conviction_code_data_15[1..3],left,right),
								         trim(l.conviction_code_data_16[1..3],left,right),
								         trim(l.conviction_code_data_17[1..3],left,right),
								         trim(l.conviction_code_data_18[1..3],left,right),
								         trim(l.conviction_code_data_19[1..3],left,right),
								         trim(l.conviction_code_data_20[1..3],left,right),
							             trim(l.conviction_code_data_21[1..3],left,right),
								         trim(l.conviction_code_data_22[1..3],left,right),
								         trim(l.conviction_code_data_23[1..3],left,right),
								         trim(l.conviction_code_data_24[1..3],left,right),
								         trim(l.conviction_code_data_25[1..3],left,right),
									     trim(l.conviction_code_data_26[1..3],left,right),
									     trim(l.conviction_code_data_27[1..3],left,right),
									     trim(l.conviction_code_data_28[1..3],left,right),
									     trim(l.conviction_code_data_29[1..3],left,right),
									     trim(l.conviction_code_data_30[1..3],left,right),
									     trim(l.conviction_code_data_31[1..3],left,right),
									     trim(l.conviction_code_data_32[1..3],left,right),
									     trim(l.conviction_code_data_33[1..3],left,right),
									     trim(l.conviction_code_data_34[1..3],left,right),
									     trim(l.conviction_code_data_35[1..3],left,right),
									     trim(l.conviction_code_data_36[1..3],left,right),
									     trim(l.conviction_code_data_37[1..3],left,right),
									     trim(l.conviction_code_data_38[1..3],left,right),
									     trim(l.conviction_code_data_39[1..3],left,right),
									     trim(l.conviction_code_data_40[1..3],left,right),
									     trim(l.conviction_code_data_41[1..3],left,right),
									     trim(l.conviction_code_data_42[1..3],left,right),
									     trim(l.conviction_code_data_43[1..3],left,right),
									     trim(l.conviction_code_data_44[1..3],left,right),
									     trim(l.conviction_code_data_45[1..3],left,right),
									     trim(l.conviction_code_data_46[1..3],left,right),
									     trim(l.conviction_code_data_47[1..3],left,right),
									     trim(l.conviction_code_data_48[1..3],left,right),
			  						     trim(l.conviction_code_data_49[1..3],left,right),
		  							     trim(l.conviction_code_data_50[1..3],left,right)
                                     ));
     self.ST_OFFENSE_CONV_DESC := DriversV2.Tables_CP_MN.Conviction(self.ST_OFFENSE_CONV_CD);
     self := [];
  end;

  norm_file := normalize(Drivers.File_MN_Raw, 50, normMNToCommon(left, counter))(trim(violation_date,left,right) <> '' and trim(ST_OFFENSE_CONV_CD,left,right) <> '');


  export MN_As_ConvictionS := norm_file;

end;