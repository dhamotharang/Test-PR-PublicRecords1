import gong_v2;

export file_gong_current_lastweek := dataset('~thor_data400::base::monitoring::gong_current_lastweek',
                                             monitoring_gong.layout_gong_slim,thor,opt);