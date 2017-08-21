import BIPV2_Files;

EXPORT seg_active_proxid := module
	export results := BIPV2_Files.files_segmentation.DS_SEG_BASE(inactive = '');
end;