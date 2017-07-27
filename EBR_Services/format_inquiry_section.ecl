import ebr;

export format_inquiry_section(DATASET(ebr.Layout_6000_Inquiries_Base) inds) :=
FUNCTION
		Layout_6000_Inquiries_Base_Rolled.parent inq_roll2(Layout_6000_Inquiries_Base_Rolled.parent le, Layout_6000_Inquiries_Base_Rolled.parent ri) :=
		TRANSFORM
			SELF.Counts := CHOOSEN(le.Counts&ri.Counts,constants.maxcounts.Inquiry_counts);
			SELF := le;
		END;						

		Layout_6000_Inquiries_Base_Rolled.top_level inq_roll_project(Layout_6000_Inquiries_Base_Rolled.top_level le) :=
		TRANSFORM
			SELF.Inquiries := ROLLUP(le.inquiries, LEFT.Bus_Desc=RIGHT.Bus_Desc, inq_roll2(LEFT,RIGHT));
			SELF.INQ_YYMM_MIN := INTFORMAT(MIN(SELF.inquiries,MIN(counts,(unsigned)Inq_yymm)),4,1);
			SELF.INQ_YYMM_MAX := INTFORMAT(MAX(SELF.inquiries,MAX(counts,(unsigned)Inq_yymm)),4,1);
		END;

		Layout_6000_Inquiries_Base_Rolled.top_level inq_roll(Layout_6000_Inquiries_Base_Rolled.top_level le, Layout_6000_Inquiries_Base_Rolled.top_level ri) :=
		TRANSFORM
			SELF.Inquiries := CHOOSEN(le.inquiries&ri.inquiries,constants.maxcounts.Inquiry_history);
			SELF := le;
		END;

		Layout_6000_Inquiries_Base_Rolled.child inq_count_format(ebr.Layout_6000_Inquiries_Base le) :=
		TRANSFORM
			SELF.INQ_YYMM := le.inq_yy+le.inq_mm;
			SELF.INQ_COUNT := le.inq_count;
		END;
		
		Layout_6000_Inquiries_Base_Rolled.parent inq_inquiries_format(ebr.Layout_6000_Inquiries_Base le) :=
		TRANSFORM
			SELF.Counts := PROJECT(le, inq_count_format(LEFT));
			SELF := le;
		END;

		Layout_6000_Inquiries_Base_Rolled.top_level inq_toplevel_format(ebr.Layout_6000_Inquiries_Base le) :=
		TRANSFORM
			inq := PROJECT(le, inq_inquiries_format(LEFT));
			SELF.Inquiries := inq;
			SELF := [];
		END;
		inquiry_recs_rolled := ROLLUP(PROJECT(inds, inq_toplevel_format(LEFT)), true, inq_roll(LEFT,RIGHT));
		inquiry_recs_rolled2 := PROJECT(inquiry_recs_rolled, inq_roll_project(LEFT));
		
		RETURN inquiry_recs_rolled2;
END;