function prepare_init()
    % create init file
    nc = netcdf('data/init.nc', 'c');
    nc{'theta1'} = ncdouble();
    nc{'theta2'} = ncdouble();
    nc{'theta3'} = ncdouble();
    nc{'theta1'}(:) = 0.0187;
    nc{'theta2'}(:) = 0.2610;
    nc{'theta3'}(:) = 0.0224;
    ncclose(nc);
    
    % same for all data sets
    copyfile('data/init.nc', 'data/init_set.nc');
    copyfile('data/init.nc', 'data/init_ffr.nc');
end
