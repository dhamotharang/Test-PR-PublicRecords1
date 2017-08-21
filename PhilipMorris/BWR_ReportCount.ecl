


import PhilipMorris;
#workunit('name','Philip Morris Report')

SetValidBureauDataValues := ['EQ','EN','LT','TU','TN','TS'];

SetValidDMVValues := ['1X','2X','FD','ID','3X','4X','KD','5X','6X',
					            'PD','7X','AD','CD','ND','8X','9X','OD','XX','SD','TD','WD',
					            'BX','YD'];

SetValidMVRValues := [ '!E','#E','$E','&E','@E','AE','AV',
					   'BE','EE','EV','FV','GE','HE','IE','IV','JE','KE','KV',
					   'LE','LV','ME','MV','NE','NV','OE','OV','PE','QE',
					   'RE','SE','TE','TV','UE','VE','WE','WV','XE','YV','ZE'];

SetValidCertegyValues := ['CY'];

SetValidUtilValues := ['UT','ZT'];

SetValidStudentValues := ['SL'];

SetValidHuntValues := ['E1'];

SetValidFishValues := ['E2'];


BureauDataReportCount 		:= output(PhilipMorris.fn_BureauDataReportCount(SetValidBureauDataValues), named('State_BureauData_Count'));
DMVReportCount 						:= output(PhilipMorris.fn_ReportCount(SetValidDMVValues), named('State_DMV_Count'));
MVRReportCount 						:= output(PhilipMorris.fn_ReportCount(SetValidMVRValues), named('State_MVR_Count'));
CertegyoutputReportCount 	:= output(PhilipMorris.fn_BureauDataReportCount(SetValidCertegyValues), named('State_SupDL_Count'));
UtilReportCount 					:= output(PhilipMorris.fn_BureauDataReportCount(SetValidUtilValues), named('State_Utilities_Count'));
VotersReportCount					:= output(PhilipMorris.fn_VotersReportCount(), named('State_VotersReg_Count'));
StudentReportCount				:= output(PhilipMorris.fn_BureauDataReportCount(SetValidStudentValues), named('State_Student_Count'));
HuntReportCount						:= output(PhilipMorris.fn_BureauDataReportCount(SetValidHuntValues), named('State_Hunt_Count'));
FishReportCount						:= output(PhilipMorris.fn_BureauDataReportCount(SetValidFishValues), named('State_Fish_Count'));


SEQUENTIAL( 
							BureauDataReportCount,
						  DMVReportCount,
			        MVRReportCount,
							CertegyoutputReportCount,
						  UtilReportCount,
							VotersReportCount,
							StudentReportCount,
							HuntReportCount,
							FishReportCount
					);
