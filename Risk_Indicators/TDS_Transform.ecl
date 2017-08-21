import ut; 
export TDS_Transform(string filedate) := function
orig:=DATASET('~thor_data400::raw::tdsdata::'+filedate,Risk_Indicators.Layout_Telcordia_tds_input.Ab_Initio,CSV (separator('\t'),terminator('\n'),quote('')) );
mod := PROJECT ( orig, TRANSFORM ( Risk_Indicators.Layout_Telcordia_tds_input.TDS_Layout,
																	 self.nxx 						:= LEFT.nxx ;
																	 self.npa 						:= LEFT.npa;
																	 self.tb							:= LEFT.tb;
																	 self.state 					:= LEFT.state;
																	 self.timezone 				:= LEFT.timezone ;
																	 self.COCType					:= LEFT.COCType;
																	 self.SSC							:= LEFT.SCC;
																	 self.Wireless_ind		:= LEFT.Wireless_ind;
															
															));
															orig;
															mod;
return output(mod,,'~thor_data400::in::tdsdata_'+filedate);

end; 
