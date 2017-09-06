IMPORT ut,data_services;

export STRING version := ut.getDateOffset  (-1,(string8) Std.Date.Today());
