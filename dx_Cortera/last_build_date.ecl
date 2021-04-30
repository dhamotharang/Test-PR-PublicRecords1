IMPORT dx_cortera;
EXPORT last_build_date := TOPN(dx_cortera.Key_Build_Version, 1, -last_build_version)[1].last_build_version;
