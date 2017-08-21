import gong_v2;

export file_gong_current_thisweek := dataset('~thor_data400::base::monitoring::gong_current_thisweek',
                                             monitoring_gong.layout_gong_slim,thor,opt);