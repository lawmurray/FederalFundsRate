function prepare_init()
    % create init file
    nc = netcdf('data/init.nc', 'c');
    nc{'theta1'} = ncdouble();
    nc{'theta2'} = ncdouble();
    nc{'theta3'} = ncdouble();
    nc{'theta1'}(:) = 0.011969;
    nc{'theta2'}(:) = 0.26028;
    nc{'theta3'}(:) = 0.016356;
    ncclose(nc);
end
