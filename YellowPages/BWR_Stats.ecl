#workunit('name', 'Yellow Pages Stats ' + yellowpages.YellowPages_Build_Date);

State_stats		:= Query_YellowPages_State_Stats	: success(output('yellow pages State Stats finished.'));
Field_stats		:= Query_YP_Field_Stats 			: success(output('yellow pages Field Stats finished.'));

sequential(

			 State_stats
			,Field_stats
);